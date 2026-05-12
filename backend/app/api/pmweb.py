"""PMWeb browser connection management."""

from fastapi import APIRouter, HTTPException

from app.api.chat import agent

router = APIRouter(prefix="/api/pmweb", tags=["pmweb"])


@router.post("/connect")
async def connect_pmweb() -> dict:
    result = agent.login()
    if result["status"] != "success":
        raise HTTPException(status_code=401, detail=result.get("message"))
    return {"status": "connected"}


@router.get("/status")
async def pmweb_status() -> dict:
    return {
        "configured": True,
        "connected": agent._logged_in,
    }


@router.post("/disconnect")
async def disconnect() -> dict:
    agent.close()
    return {"status": "disconnected"}
