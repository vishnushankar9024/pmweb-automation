"""MLOps engine — monitors agent performance metrics, manages fix-now/fix-later
pipeline with MongoDB persistence, and surfaces improvement recommendations.
"""

from __future__ import annotations

import logging
import os
import time
import uuid
from dataclasses import dataclass, field
from datetime import datetime, timezone
from typing import Any

from pymongo import MongoClient

from app.services.feedback_store import FeedbackStore, get_feedback_store
from app.services.learning_store import LearningStore, get_learning_store

logger = logging.getLogger(__name__)

DB_NAME = os.getenv("MONGO_DB", "pmweb-automation")


def _get_mongo_uri() -> str:
    uri = os.getenv("MONGO_URI", "")
    if not uri:
        from app.services.session_store import MONGO_URI as _SESSION_URI
        uri = _SESSION_URI
    return uri

GITHUB_TOKEN = os.getenv("GITHUB_TOKEN", "")
GITHUB_REPO = os.getenv("GITHUB_REPO", "vishnushankar9024/pmweb-automation")
DEPLOY_BRANCH = os.getenv("DEPLOY_BRANCH", "cursor/clean-agent-6eca")


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
    """Analyses agent telemetry, manages fix pipeline, generates recommendations."""

    SUCCESS_THRESHOLD = 0.85
    LATENCY_THRESHOLD = 15.0
    MIN_SAMPLES = 5

    def __init__(
        self,
        db: Any = None,
        learning_store: LearningStore | None = None,
        feedback_store: FeedbackStore | None = None,
    ) -> None:
        self._learning = learning_store or get_learning_store()
        self._feedback = feedback_store or get_feedback_store()
        if db is not None:
            self._db = db
        else:
            client = MongoClient(_get_mongo_uri())
            self._db = client[DB_NAME]
        self._fixes = self._db["fixes"]

    def process_fix_now(self, feedback_id: str) -> dict[str, Any]:
        """Create GitHub issue → Cursor Automation fixes code → auto-deploy."""
        fix_id = str(uuid.uuid4())
        fix_doc = {
            "fix_id": fix_id,
            "feedback_id": feedback_id,
            "mode": "now",
            "status": "analyzing",
            "step": 1,
            "steps": [
                {"name": "Analyzing", "status": "in_progress"},
                {"name": "Creating issue", "status": "pending"},
                {"name": "AI fixing code", "status": "pending"},
                {"name": "Auto-deploy", "status": "pending"},
            ],
            "pr_url": None,
            "created_at": datetime.now(timezone.utc),
            "updated_at": datetime.now(timezone.utc),
        }
        self._fixes.insert_one(fix_doc)

        try:
            ticket = self._feedback.get_ticket(feedback_id)
            prompt = ticket.get("prompt", "") if ticket else ""
            expected = ticket.get("expected_result", "") if ticket else ""

            self._update_fix_step(fix_id, 0, "completed")
            self._update_fix_step(fix_id, 1, "in_progress")
            self._update_fix_status(fix_id, "creating_issue", 2)

            issue_url = self._create_github_issue(feedback_id, prompt, expected)

            self._update_fix_step(fix_id, 1, "completed")
            self._update_fix_step(fix_id, 2, "in_progress")
            self._update_fix_status(fix_id, "ai_fixing", 3)

            self._fixes.update_one(
                {"fix_id": fix_id},
                {"$set": {"pr_url": issue_url}},
            )

            return {
                "fix_id": fix_id,
                "status": "ai_fixing",
                "pr_url": issue_url,
            }
        except Exception as exc:
            logger.exception("Fix-now failed for %s", feedback_id)
            self._update_fix_status(fix_id, "failed", 0)
            return {"fix_id": fix_id, "status": "failed", "error": str(exc)}

    def process_fix_later(self, feedback_id: str) -> dict[str, Any]:
        """Queue a fix for the daily 7 PM IST batch run."""
        fix_id = str(uuid.uuid4())
        fix_doc = {
            "fix_id": fix_id,
            "feedback_id": feedback_id,
            "mode": "later",
            "status": "queued",
            "step": 0,
            "steps": [
                {"name": "Queued (7 PM IST)", "status": "pending"},
                {"name": "Creating issue", "status": "pending"},
                {"name": "AI fixing code", "status": "pending"},
                {"name": "Auto-deploy", "status": "pending"},
            ],
            "pr_url": None,
            "created_at": datetime.now(timezone.utc),
            "updated_at": datetime.now(timezone.utc),
        }
        self._fixes.insert_one(fix_doc)
        return {"fix_id": fix_id, "status": "queued"}

    def get_fix_status(self, feedback_id: str) -> dict[str, Any]:
        """Return the current status and step progress for a fix."""
        doc = self._fixes.find_one(
            {"feedback_id": feedback_id},
            sort=[("created_at", -1)],
        )
        if not doc:
            return {"status": "not_found", "step": 0, "steps": []}
        return {
            "fix_id": doc.get("fix_id"),
            "status": doc.get("status", "unknown"),
            "step": doc.get("step", 0),
            "steps": doc.get("steps", []),
            "pr_url": doc.get("pr_url"),
            "mode": doc.get("mode"),
        }

    def get_queued_count(self) -> int:
        """Count fixes waiting in the batch queue."""
        return self._fixes.count_documents({"status": "queued", "mode": "later"})

    def get_fix_history(self, limit: int = 20) -> list[dict[str, Any]]:
        """Return recent fix requests with their status."""
        docs = self._fixes.find({}, sort=[("created_at", -1)], limit=limit)
        history = []
        for doc in docs:
            history.append({
                "fix_id": doc.get("fix_id"),
                "feedback_id": doc.get("feedback_id"),
                "mode": doc.get("mode"),
                "status": doc.get("status"),
                "steps": doc.get("steps", []),
                "pr_url": doc.get("pr_url"),
                "created_at": doc.get("created_at", "").isoformat() if hasattr(doc.get("created_at", ""), "isoformat") else str(doc.get("created_at", "")),
            })
        return history

    def process_queued_fixes(self) -> list[dict[str, Any]]:
        """Process all queued fix-later tickets (called by scheduler).

        Creates GitHub issues for each — Cursor Automation picks them up,
        fixes the code, opens PRs, and the push triggers auto-deploy.
        """
        queued = list(self._fixes.find({"status": "queued", "mode": "later"}))
        if not queued:
            return []

        results = []
        for doc in queued:
            fix_id = doc["fix_id"]
            feedback_id = doc["feedback_id"]
            try:
                self._update_fix_step(fix_id, 0, "completed")
                self._update_fix_step(fix_id, 1, "in_progress")
                self._update_fix_status(fix_id, "creating_issue", 2)

                ticket = self._feedback.get_ticket(feedback_id)
                prompt = ticket.get("prompt", "") if ticket else ""
                expected = ticket.get("expected_result", "") if ticket else ""

                issue_url = self._create_github_issue(feedback_id, prompt, expected)

                self._update_fix_step(fix_id, 1, "completed")
                self._update_fix_step(fix_id, 2, "in_progress")
                self._update_fix_status(fix_id, "ai_fixing", 3)

                self._fixes.update_one(
                    {"fix_id": fix_id},
                    {"$set": {"pr_url": issue_url}},
                )
                results.append({"fix_id": fix_id, "status": "ai_fixing", "pr_url": issue_url})
            except Exception as exc:
                logger.exception("Batch fix failed for %s", fix_id)
                self._update_fix_status(fix_id, "failed", 0)
                results.append({"fix_id": fix_id, "status": "failed", "error": str(exc)})

        return results

    def _update_fix_status(self, fix_id: str, status: str, step: int) -> None:
        self._fixes.update_one(
            {"fix_id": fix_id},
            {"$set": {"status": status, "step": step, "updated_at": datetime.now(timezone.utc)}},
        )

    def _update_fix_step(self, fix_id: str, step_index: int, step_status: str) -> None:
        self._fixes.update_one(
            {"fix_id": fix_id},
            {"$set": {f"steps.{step_index}.status": step_status, "updated_at": datetime.now(timezone.utc)}},
        )

    def _create_github_issue(self, feedback_id: str, prompt: str, expected: str) -> str:
        """Create a GitHub issue with rich context for Cursor Automation to fix."""
        try:
            import httpx

            ticket = self._feedback.get_ticket(feedback_id)
            actual = ticket.get("actual_result", "") if ticket else ""
            session_id = ticket.get("session_id", "") if ticket else ""

            title = f"[Auto-Fix] {prompt[:80]}" if prompt else f"[Auto-Fix] Feedback {feedback_id[:8]}"
            body = (
                f"## Auto-Fix Request\n\n"
                f"A user reported that the PMWeb Automation Agent did not work as expected.\n\n"
                f"### What the user asked\n"
                f"```\n{prompt}\n```\n\n"
                f"### What actually happened\n"
                f"```\n{actual}\n```\n\n"
                f"### What should have happened\n"
                f"```\n{expected}\n```\n\n"
                f"### Instructions for the fixing agent\n\n"
                f"1. Read the HybridAgent in `backend/app/agent/browser_agent.py` — "
                f"this is the GPT-4o planner + Selenium executor that automates PMWeb.\n"
                f"2. Read the planner prompt (`PLANNER_PROMPT`) and the `_execute_step()` method.\n"
                f"3. Identify why the user's request failed — missing action, wrong selector, "
                f"incorrect navigation flow, etc.\n"
                f"4. Fix the code so the request would succeed next time.\n"
                f"5. If new Selenium actions are needed, add them to both `PLANNER_PROMPT` "
                f"(so GPT-4o knows about them) and `_execute_step()` (so they execute).\n"
                f"6. Run `cd backend && ruff check app/` to ensure no lint errors.\n"
                f"7. Open a PR with the fix on branch `cursor/clean-agent-6eca`.\n\n"
                f"### Key files\n"
                f"- `backend/app/agent/browser_agent.py` — HybridAgent (planner + executor)\n"
                f"- `backend/app/api/chat.py` — API endpoints\n"
                f"- `backend/app/services/learning_store.py` — learning from past runs\n\n"
                f"### Metadata\n"
                f"- **Feedback ID:** `{feedback_id}`\n"
                f"- **Session ID:** `{session_id}`\n\n"
                f"---\n*Created automatically by PMWeb Automation Agent — Fix Now*"
            )

            resp = httpx.post(
                f"https://api.github.com/repos/{GITHUB_REPO}/issues",
                headers={
                    "Authorization": f"token {GITHUB_TOKEN}",
                    "Accept": "application/vnd.github.v3+json",
                },
                json={"title": title, "body": body, "labels": ["auto-fix"]},
                timeout=30,
            )
            if resp.status_code in (200, 201):
                return resp.json().get("html_url", "")
            logger.warning("GitHub API returned %d: %s", resp.status_code, resp.text[:200])
            return f"https://github.com/{GITHUB_REPO}/issues (creation returned {resp.status_code})"
        except Exception as exc:
            logger.exception("GitHub issue creation failed")
            return f"Issue creation error: {exc}"

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
