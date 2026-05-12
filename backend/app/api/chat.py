import asyncio
from concurrent.futures import ThreadPoolExecutor

from fastapi import APIRouter, HTTPException

from app.agent.browser_agent import HybridAgent
from app.models.chat import ChatRequest, ChatResponse
from app.services.session_store import SessionStore

router = APIRouter(prefix="/api", tags=["chat"])

agent = HybridAgent()
executor = ThreadPoolExecutor(max_workers=1)
store = SessionStore()


@router.post("/chat", response_model=ChatResponse)
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
            session_id,
            "assistant",
            result["reply"],
            result.get("actions", []),
        )

        return ChatResponse(
            reply=result["reply"],
            conversation_id=session_id,
            executed_actions=result.get("actions", []),
        )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc


@router.get("/sessions")
async def list_sessions():
    return store.list_sessions()


@router.get("/sessions/{session_id}")
async def get_session(session_id: str):
    session = store.get_session(session_id)
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
    return session


@router.delete("/sessions/{session_id}")
async def delete_session(session_id: str):
    store.delete_session(session_id)
    return {"status": "deleted"}
