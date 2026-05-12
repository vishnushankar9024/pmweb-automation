from fastapi import APIRouter, HTTPException

from app.agent.browser_agent import HybridAgent
from app.models.chat import ChatRequest, ChatResponse

router = APIRouter(prefix="/api", tags=["chat"])

agent = HybridAgent()


@router.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest) -> ChatResponse:
    try:
        result = await agent.run_task(request.message)
        return ChatResponse(
            reply=result["reply"],
            conversation_id=request.conversation_id or "default",
            executed_actions=result.get("actions", []),
        )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc
