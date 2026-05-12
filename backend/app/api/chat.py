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
    sid = request.conversation_id
    if not sid:
        s = store.create_session(title=request.message[:50])
        sid = s["id"]
    store.add_message(sid, "user", request.message)
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(executor, agent.run_task_sync, request.message)
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
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(executor, agent.run_task_with_context, message, file_context)
    store.add_message(sid, "assistant", result["reply"], result.get("actions", []))
    return {"reply": result["reply"], "conversation_id": sid, "executed_actions": result.get("actions", [])}


@router.post("/stop")
async def stop():
    agent.request_stop()
    return {"status": "stop_requested"}


@router.post("/feedback")
async def submit_feedback(session_id: str = Form(...), prompt: str = Form(...), actual_result: str = Form(...), expected_result: str = Form(...), file: UploadFile = File(None)):
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
    from pymongo import MongoClient

    from app.services.mlops_engine import MLOpsEngine
    client = MongoClient("mongodb+srv://pmwebxadmin:sa_admin2025@cluster0.oddu5r6.mongodb.net/")
    return MLOpsEngine(client["pmweb-automation"]).process_fix_now(feedback_id)


@router.post("/feedback/fix-later")
async def fix_later(feedback_id: str = Form(...)):
    from pymongo import MongoClient

    from app.services.mlops_engine import MLOpsEngine
    client = MongoClient("mongodb+srv://pmwebxadmin:sa_admin2025@cluster0.oddu5r6.mongodb.net/")
    return MLOpsEngine(client["pmweb-automation"]).process_fix_later(feedback_id)


@router.get("/feedback/progress/{feedback_id}")
async def fix_progress(feedback_id: str):
    from pymongo import MongoClient

    from app.services.mlops_engine import MLOpsEngine
    client = MongoClient("mongodb+srv://pmwebxadmin:sa_admin2025@cluster0.oddu5r6.mongodb.net/")
    return MLOpsEngine(client["pmweb-automation"]).get_fix_status(feedback_id)


@router.get("/feedback/queued-count")
async def queued_count():
    from pymongo import MongoClient

    from app.services.mlops_engine import MLOpsEngine
    client = MongoClient("mongodb+srv://pmwebxadmin:sa_admin2025@cluster0.oddu5r6.mongodb.net/")
    return {"count": MLOpsEngine(client["pmweb-automation"]).get_queued_count()}


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
