"""MLOps performance reporting endpoints."""

from fastapi import APIRouter

from app.services.mlops_engine import get_mlops_engine

router = APIRouter(prefix="/api/mlops", tags=["mlops"])


@router.get("/report")
async def performance_report() -> dict:
    engine = get_mlops_engine()
    report = engine.generate_report()
    return {
        "generated_at": report.generated_at,
        "total_actions": report.total_actions,
        "overall_success_rate": report.overall_success_rate,
        "avg_latency_seconds": report.avg_latency_seconds,
        "user_satisfaction_rate": report.user_satisfaction_rate,
        "action_breakdown": report.action_breakdown,
        "recommendations": report.recommendations,
    }
