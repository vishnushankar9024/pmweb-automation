"""Session management endpoints."""

from fastapi import APIRouter

from app.services.session_store import get_session_store

router = APIRouter(prefix="/api", tags=["sessions"])


@router.get("/sessions")
async def list_sessions() -> list[str]:
    store = get_session_store()
    return store.list_sessions()


@router.delete("/sessions/{session_id}")
async def delete_session(session_id: str) -> dict:
    store = get_session_store()
    deleted = store.delete(session_id)
    return {"deleted": deleted}
