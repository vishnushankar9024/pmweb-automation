"""MLOps engine — monitors agent performance metrics and surfaces
recommendations for prompt tuning, tool selection, and error reduction.

Pulls data from :mod:`learning_store` and :mod:`feedback_store` to
generate periodic reports and improvement suggestions.
"""

from __future__ import annotations

import logging
import time
from dataclasses import dataclass, field
from typing import Any

from app.services.feedback_store import FeedbackStore, get_feedback_store
from app.services.learning_store import LearningStore, get_learning_store

logger = logging.getLogger(__name__)


@dataclass
class PerformanceReport:
    """Snapshot of agent performance metrics."""

    generated_at: float = field(default_factory=time.time)
    total_actions: int = 0
    overall_success_rate: float = 0.0
    avg_latency_seconds: float = 0.0
    user_satisfaction_rate: float | None = None
    action_breakdown: list[dict[str, Any]] = field(default_factory=list)
    recommendations: list[str] = field(default_factory=list)


class MLOpsEngine:
    """Analyses agent telemetry and generates improvement recommendations."""

    SUCCESS_THRESHOLD = 0.85
    LATENCY_THRESHOLD = 15.0  # seconds
    MIN_SAMPLES = 5

    def __init__(
        self,
        learning_store: LearningStore | None = None,
        feedback_store: FeedbackStore | None = None,
    ) -> None:
        self._learning = learning_store or get_learning_store()
        self._feedback = feedback_store or get_feedback_store()

    def generate_report(self) -> PerformanceReport:
        """Build a full performance report with recommendations."""
        patterns = self._learning.analyze()
        feedback_summary = self._feedback.summary()

        total = sum(p.total_count for p in patterns)
        successes = sum(p.success_count for p in patterns)
        rate = round(successes / total, 2) if total else 0.0
        avg_latency = (
            round(sum(p.avg_elapsed * p.total_count for p in patterns) / total, 2)
            if total
            else 0.0
        )

        breakdown = [
            {
                "action": p.action_name,
                "total": p.total_count,
                "success_rate": p.success_rate,
                "avg_elapsed": p.avg_elapsed,
                "common_errors": p.common_errors,
            }
            for p in patterns
        ]

        recommendations = self._derive_recommendations(patterns, feedback_summary)

        return PerformanceReport(
            total_actions=total,
            overall_success_rate=rate,
            avg_latency_seconds=avg_latency,
            user_satisfaction_rate=feedback_summary.get("satisfaction_rate"),
            action_breakdown=breakdown,
            recommendations=recommendations,
        )

    def _derive_recommendations(
        self,
        patterns: list,
        feedback_summary: dict[str, Any],
    ) -> list[str]:
        """Produce actionable suggestions based on data."""
        recs: list[str] = []

        for p in patterns:
            if p.total_count < self.MIN_SAMPLES:
                continue
            if p.success_rate < self.SUCCESS_THRESHOLD:
                recs.append(
                    f"Action '{p.action_name}' has a {p.success_rate*100:.0f}% "
                    f"success rate ({p.failure_count} failures). "
                    f"Review common errors: {', '.join(p.common_errors[:2]) or 'N/A'}."
                )
            if p.avg_elapsed > self.LATENCY_THRESHOLD:
                recs.append(
                    f"Action '{p.action_name}' averages {p.avg_elapsed:.1f}s — "
                    f"consider adding explicit waits or reducing page loads."
                )

        sat = feedback_summary.get("satisfaction_rate")
        if sat is not None and sat < 0.7:
            recs.append(
                f"User satisfaction is {sat*100:.0f}%. Review negative "
                f"feedback comments for common complaints."
            )

        if not recs:
            recs.append("All metrics are within acceptable ranges. No changes needed.")

        return recs

    def get_prompt_supplement(self) -> str:
        """Return learned-pattern text to append to the system prompt."""
        return self._learning.get_prompt_hints()


_engine: MLOpsEngine | None = None


def get_mlops_engine() -> MLOpsEngine:
    """Return the global MLOps engine singleton."""
    global _engine
    if _engine is None:
        _engine = MLOpsEngine()
    return _engine
