import asyncio
from concurrent.futures import ThreadPoolExecutor

from fastapi import APIRouter, File, Form, HTTPException, UploadFile

from app.agent.browser_agent import HybridAgent
from app.models.chat import ChatRequest, ChatResponse
from app.services.feedback_store import FeedbackStore
from app.services.file_extractor import extract_text
from app.services.learning_store import LearningStore
from app.services.session_store import SessionStore

router = APIRouter(prefix="/api", tags=["chat"])

agent = HybridAgent()
executor = ThreadPoolExecutor(max_workers=1)
store = SessionStore()
feedback_store = FeedbackStore()
learning_store = LearningStore()


@router.post("/chat")
async def chat(request: ChatRequest) -> ChatResponse:
    try:
        session_id = request.conversation_id
        if not session_id:
            session = store.create_session(
                title=request.message[:50]
            )
            session_id = session["id"]

        store.add_message(session_id, "user", request.message)

        loop = asyncio.get_event_loop()
        result = await loop.run_in_executor(
            executor, agent.run_task_sync, request.message
        )

        store.add_message(
            session_id, "assistant",
            result["reply"], result.get("actions", []),
        )

        return ChatResponse(
            reply=result["reply"],
            conversation_id=session_id,
            executed_actions=result.get("actions", []),
        )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc


@router.post("/chat-with-file")
async def chat_with_file(
    message: str = Form(...),
    conversation_id: str = Form(None),
    file: UploadFile = File(None),
):
    """Chat with an optional file attachment as context."""
    try:
        file_context = ""
        file_id = None

        if file:
            content = await file.read()
            file_context = extract_text(file.filename or "", content)
            file_id = feedback_store.store_file(
                filename=file.filename or "unknown",
                content=content,
                content_type=file.content_type or "",
                extracted_text=file_context[:2000],
            )

        session_id = conversation_id
        if not session_id:
            session = store.create_session(title=message[:50])
            session_id = session["id"]

        user_msg = message
        if file:
            user_msg += f"\n[Attached: {file.filename}]"
        store.add_message(session_id, "user", user_msg)

        loop = asyncio.get_event_loop()
        result = await loop.run_in_executor(
            executor,
            agent.run_task_with_context,
            message,
            file_context,
        )

        store.add_message(
            session_id, "assistant",
            result["reply"], result.get("actions", []),
        )

        return {
            "reply": result["reply"],
            "conversation_id": session_id,
            "executed_actions": result.get("actions", []),
            "file_id": file_id,
        }
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc


@router.post("/stop")
async def stop_execution():
    """Stop the currently running agent task."""
    agent.request_stop()
    return {"status": "stop_requested"}


@router.post("/feedback")
async def submit_feedback(
    session_id: str = Form(...),
    prompt: str = Form(...),
    actual_result: str = Form(...),
    expected_result: str = Form(...),
    file: UploadFile = File(None),
):
    """Submit feedback when user is unhappy with result."""
    try:
        file_ids = []
        if file:
            content = await file.read()
            extracted = extract_text(file.filename or "", content)
            fid = feedback_store.store_file(
                filename=file.filename or "unknown",
                content=content,
                content_type=file.content_type or "",
                extracted_text=extracted[:2000],
            )
            file_ids.append(fid)

        ticket = feedback_store.create_ticket(
            session_id=session_id,
            prompt=prompt,
            actual_result=actual_result,
            expected_result=expected_result,
            file_ids=file_ids,
        )

        learning_store.store_failure(
            prompt=prompt,
            plan=[],
            results=[],
            feedback=expected_result,
        )

        return {"ticket_id": ticket["id"], "status": "submitted"}
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc


@router.get("/feedback/tickets")
async def list_feedback_tickets(status: str = None):
    return feedback_store.list_tickets(status)


@router.get("/sessions")
async def list_sessions():
    return store.list_sessions()


@router.get("/sessions/{session_id}")
async def get_session(session_id: str):
    session = store.get_session(session_id)
    if not session:
        raise HTTPException(status_code=404)
    return session


@router.delete("/sessions/{session_id}")
async def delete_session(session_id: str):
    store.delete_session(session_id)
    return {"status": "deleted"}


@router.get("/learning/stats")
async def learning_stats():
    return learning_store.get_stats()
