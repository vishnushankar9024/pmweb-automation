import logging
import os

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from app.api.chat import router as chat_router
from app.api.health import router as health_router
from app.api.mlops import router as mlops_router
from app.api.pmweb import router as pmweb_router
from app.config import settings

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")

app = FastAPI(title=settings.app_name, version="0.1.0")
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_credentials=True, allow_methods=["*"], allow_headers=["*"])
app.include_router(health_router)
app.include_router(chat_router)
app.include_router(pmweb_router)
app.include_router(mlops_router)


@app.on_event("startup")
async def startup_event():
    from app.services.scheduler import start_scheduler
    start_scheduler()


@app.on_event("shutdown")
async def shutdown_event():
    from app.services.scheduler import stop_scheduler
    stop_scheduler()


static_dir = os.path.join(os.path.dirname(__file__), "..", "static")
frontend_dist = os.path.join(os.path.dirname(__file__), "..", "..", "frontend", "dist")
serve_dir = static_dir if os.path.isdir(static_dir) else frontend_dist
if os.path.isdir(serve_dir):
    app.mount("/", StaticFiles(directory=serve_dir, html=True), name="frontend")
