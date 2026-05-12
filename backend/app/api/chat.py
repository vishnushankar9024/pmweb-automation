import asyncio
from concurrent.futures import ThreadPoolExecutor

from fastapi import APIRouter, HTTPException

from app.agent.browser_agent import HybridAgent
from app.models.chat import ChatRequest, ChatResponse

router = APIRouter(prefix="/api", tags=["chat"])

agent = HybridAgent()
executor = ThreadPoolExecutor(max_workers=1)


@router.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest) -> ChatResponse:
    try:
        loop = asyncio.get_event_loop()
        result = await loop.run_in_executor(
            executor, agent.run_task_sync, request.message
        )
        return ChatResponse(
            reply=result["reply"],
            conversation_id=request.conversation_id or "default",
            executed_actions=result.get("actions", []),
        )
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc)) from exc
