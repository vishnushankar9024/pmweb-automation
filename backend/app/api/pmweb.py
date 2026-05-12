import asyncio

from fastapi import APIRouter, HTTPException

from app.api.chat import agent, executor

router = APIRouter(prefix="/api/pmweb", tags=["pmweb"])


@router.post("/connect")
async def connect():
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(executor, agent.login)
    if result["status"] != "success":
        raise HTTPException(status_code=401, detail=result.get("message"))
    return {"status": "connected"}


@router.get("/status")
async def status():
    return {"configured": True, "connected": agent._logged_in}


@router.post("/disconnect")
async def disconnect():
    agent.close()
    return {"status": "disconnected"}
