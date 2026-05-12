"""PMWeb browser connection management."""

import asyncio

from fastapi import APIRouter, HTTPException

from app.api.chat import agent, executor

router = APIRouter(prefix="/api/pmweb", tags=["pmweb"])


def get_browser_if_connected():
    """Compatibility hook for legacy PMWebClient fallback behavior."""
    return None


@router.post("/connect")
async def connect_pmweb() -> dict:
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(executor, agent.login)
    if result["status"] != "success":
        raise HTTPException(
            status_code=401, detail=result.get("message")
        )
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
