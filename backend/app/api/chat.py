import asyncio
from concurrent.futures import ThreadPoolExecutor

from fastapi import APIRouter, File, Form, HTTPException, UploadFile

from app.agent.browser_agent import HybridAgent
from app.models.chat import ChatRequest, ChatResponse
from app.services.feedback_store import FeedbackStore
from app.services.file_extractor import extract_text
from app.services.learning_store import LearningStore
from app.services.mlops_engine import get_mlops_engine
from app.services.session_store import SessionStore

router = APIRouter(prefix="/api", tags=["chat"])

agent = HybridAgent()
executor = ThreadPoolExecutor(max_workers=1)
store = SessionStore()
feedback_store = FeedbackStore()
learning_store = LearningStore()


def _get_history(session_id: str) -> list[dict[str, str]]:
    """Load recent conversation messages for LLM context."""
    session = store.get_session(session_id)
    if not session:
        return []
    msgs = session.get("messages", [])
    history = []
    for m in msgs[-10:]:
        role = m.get("role", "user")
        content = m.get("content", "")
        if role in ("user", "assistant") and content:
            history.append({"role": role, "content": content})
    return history


def _get_session_safely(session_id: str) -> dict | None:
    try:
        return store.get_session(session_id)
    except Exception:
        return None


def _latest_message_content(session: dict | None, role: str) -> str:
    if not session:
        return ""
    for message in reversed(session.get("messages", [])):
        if message.get("role") == role:
            content = message.get("content", "")
            if isinstance(content, str) and content.strip():
                return content.strip()
    return ""


@router.post("/chat")
async def chat(request: ChatRequest) -> ChatResponse:
    sid = request.conversation_id
    if not sid:
        s = store.create_session(title=request.message[:50])
        sid = s["id"]
    store.add_message(sid, "user", request.message)
    history = _get_history(sid)
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(executor, agent.run_task_sync, request.message, history)
    store.add_message(sid, "assistant", result["reply"], result.get("actions", []))
    return ChatResponse(reply=result["reply"], conversation_id=sid, executed_actions=result.get("actions", []))


@router.post("/chat-with-file")
async def chat_with_file(message: str = Form(...), conversation_id: str = Form(None), file: UploadFile = File(None)):
    sid = conversation_id
    file_context = ""
    if file:
        content = await file.read()
        file_context = extract_text(file.filename or "", content)
    if not sid:
        s = store.create_session(title=message[:50])
        sid = s["id"]
    store.add_message(sid, "user", f"{message}\n[Attached: {file.filename}]" if file else message)
    history = _get_history(sid)
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(executor, agent.run_task_with_context, message, file_context, history)
    store.add_message(sid, "assistant", result["reply"], result.get("actions", []))
    return {"reply": result["reply"], "conversation_id": sid, "executed_actions": result.get("actions", [])}


@router.post("/stop")
async def stop():
    agent.request_stop()
    return {"status": "stop_requested"}


@router.post("/feedback")
async def submit_feedback(session_id: str = Form(...), prompt: str = Form(...), actual_result: str = Form(...), expected_result: str = Form(...), file: UploadFile = File(None)):
    session_id = session_id.strip()
    prompt = prompt.strip()
    actual_result = actual_result.strip()
    expected_result = expected_result.strip()

    if not session_id:
        raise HTTPException(status_code=400, detail="session_id is required")
    if not expected_result:
        raise HTTPException(status_code=400, detail="expected_result is required")

    session = None
    if not prompt or not actual_result:
        session = _get_session_safely(session_id)
        if not prompt:
            prompt = _latest_message_content(session, "user")
        if not actual_result:
            actual_result = _latest_message_content(session, "assistant")

    if not prompt:
        raise HTTPException(status_code=400, detail="prompt is required")
    if not actual_result:
        raise HTTPException(status_code=400, detail="actual_result is required")

    file_ids = []
    if file:
        content = await file.read()
        extracted = extract_text(file.filename or "", content)
        fid = feedback_store.store_file(file.filename or "", content, file.content_type or "", extracted[:2000])
        file_ids.append(fid)
    ticket = feedback_store.create_ticket(session_id, prompt, actual_result, expected_result, file_ids)
    learning_store.store_failure(prompt, [], [], expected_result)
    return {"ticket_id": ticket["id"], "status": "submitted"}


@router.post("/feedback/fix-now")
async def fix_now(feedback_id: str = Form(...)):
    engine = get_mlops_engine()
    return engine.process_fix_now(feedback_id)


@router.post("/feedback/fix-later")
async def fix_later(feedback_id: str = Form(...)):
    engine = get_mlops_engine()
    return engine.process_fix_later(feedback_id)


@router.get("/feedback/progress/{feedback_id}")
async def fix_progress(feedback_id: str):
    engine = get_mlops_engine()
    return engine.get_fix_status(feedback_id)


@router.get("/feedback/queued-count")
async def queued_count():
    engine = get_mlops_engine()
    return {"count": engine.get_queued_count()}


@router.get("/feedback/history")
async def fix_history():
    engine = get_mlops_engine()
    return engine.get_fix_history()


@router.get("/sessions")
async def list_sessions():
    return store.list_sessions()


@router.get("/sessions/{session_id}")
async def get_session(session_id: str):
    s = store.get_session(session_id)
    if not s:
        raise HTTPException(status_code=404)
    return s


@router.delete("/sessions/{session_id}")
async def delete_session(session_id: str):
    store.delete_session(session_id)
    return {"status": "deleted"}


@router.get("/learning/stats")
async def learning_stats():
    return learning_store.get_stats()
