import logging
import os

from fastapi import FastAPI, WebSocket
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from app.api.chat import router as chat_router
from app.api.health import router as health_router
from app.api.pmweb import router as pmweb_router
from app.config import settings

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)

app = FastAPI(
    title=settings.app_name,
    description=(
        "AI agent for automating PMWeb security, workflows, and forms"
    ),
    version="0.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(health_router)
app.include_router(chat_router)
app.include_router(pmweb_router)


@app.websocket("/ws/vnc")
async def vnc_proxy(websocket: WebSocket):
    """Proxy VNC WebSocket to local websockify for live browser view."""
    import asyncio

    import websockets

    await websocket.accept()
    try:
        async with websockets.connect(
            "ws://localhost:6081/websockify"
        ) as vnc:

            async def to_vnc():
                try:
                    while True:
                        data = await websocket.receive_bytes()
                        await vnc.send(data)
                except Exception:
                    pass

            async def to_client():
                try:
                    async for msg in vnc:
                        if isinstance(msg, bytes):
                            await websocket.send_bytes(msg)
                        else:
                            await websocket.send_text(msg)
                except Exception:
                    pass

            await asyncio.gather(to_vnc(), to_client())
    except Exception:
        pass


# Serve noVNC static files
novnc_path = "/opt/noVNC"
if os.path.isdir(novnc_path):
    app.mount(
        "/novnc",
        StaticFiles(directory=novnc_path, html=True),
        name="novnc",
    )

# Serve frontend
static_dir = os.path.join(os.path.dirname(__file__), "..", "static")
frontend_dist = os.path.join(
    os.path.dirname(__file__), "..", "..", "frontend", "dist"
)
serve_dir = static_dir if os.path.isdir(static_dir) else frontend_dist
if os.path.isdir(serve_dir):
    app.mount(
        "/",
        StaticFiles(directory=serve_dir, html=True),
        name="frontend",
    )
