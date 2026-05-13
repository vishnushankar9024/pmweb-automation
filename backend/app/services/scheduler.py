"""Daily batch scheduler — processes queued fix-later tickets at 7 PM IST.

Uses APScheduler to run a daily job that picks up all fix-later tickets
with status 'queued' and processes them through the MLOps pipeline.
"""

from __future__ import annotations

import logging

from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.cron import CronTrigger

logger = logging.getLogger(__name__)

_scheduler: BackgroundScheduler | None = None


def _run_batch_fixes() -> None:
    """Callback executed by APScheduler at 7 PM IST daily."""
    logger.info("Batch scheduler triggered — processing queued fix-later tickets")
    try:
        from app.services.mlops_engine import get_mlops_engine
        engine = get_mlops_engine()
        results = engine.process_queued_fixes()
        logger.info("Batch processing complete: %d tickets processed", len(results))
        for r in results:
            logger.info("  fix_id=%s status=%s", r.get("fix_id"), r.get("status"))
    except Exception:
        logger.exception("Batch scheduler failed")


def start_scheduler() -> BackgroundScheduler:
    """Start the APScheduler background scheduler.

    Runs daily at 7 PM IST (13:30 UTC — IST is UTC+5:30).
    """
    global _scheduler
    if _scheduler is not None:
        return _scheduler

    _scheduler = BackgroundScheduler()

    _scheduler.add_job(
        _run_batch_fixes,
        trigger=CronTrigger(hour=13, minute=30),
        id="daily_batch_fixes",
        name="Process queued fix-later tickets (7 PM IST)",
        replace_existing=True,
    )

    _scheduler.start()
    logger.info("Batch scheduler started — next run at 7 PM IST (13:30 UTC)")
    return _scheduler


def stop_scheduler() -> None:
    """Shut down the scheduler gracefully."""
    global _scheduler
    if _scheduler:
        _scheduler.shutdown(wait=False)
        _scheduler = None
        logger.info("Batch scheduler stopped")
