from fastapi import APIRouter, HTTPException

from app.agent.core import PMWebAgent
from app.models.chat import ChatRequest, ChatResponse

router = APIRouter(prefix="/api", tags=["chat"])

agent = PMWebAgent()


@router.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest) -> ChatResponse:
    try:
        result = await agent.chat(
            message=request.message,
            conversation_id=request.conversation_id,
        )
        return ChatResponse(**result)
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc


@router.get("/conversations/{conversation_id}/summary")
async def get_summary(conversation_id: str) -> dict:
    if conversation_id not in agent._conversations:
        raise HTTPException(status_code=404, detail="Conversation not found")
    state = agent._conversations[conversation_id]
    return state.pmweb.get_summary()
