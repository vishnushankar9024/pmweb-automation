"""Feedback collection endpoints."""

from fastapi import APIRouter
from pydantic import BaseModel

from app.services.feedback_store import FeedbackEntry, get_feedback_store

router = APIRouter(prefix="/api", tags=["feedback"])


class FeedbackRequest(BaseModel):
    session_id: str = ""
    message_index: int = -1
    rating: int = 0
    comment: str = ""
    action_name: str = ""


@router.post("/feedback")
async def submit_feedback(req: FeedbackRequest) -> dict:
    store = get_feedback_store()
    entry = FeedbackEntry(
        session_id=req.session_id,
        message_index=req.message_index,
        rating=req.rating,
        comment=req.comment,
        action_name=req.action_name,
    )
    fid = store.add(entry)
    return {"feedback_id": fid}


@router.get("/feedback/summary")
async def feedback_summary() -> dict:
    store = get_feedback_store()
    return store.summary()
