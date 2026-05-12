"""Learning system — stores successful patterns for few-shot retrieval."""

from __future__ import annotations

from datetime import datetime, timezone
from typing import Any

from pymongo import MongoClient

MONGO_URI = (
    "mongodb+srv://pmwebxadmin:sa_admin2025"
    "@cluster0.oddu5r6.mongodb.net/"
)
DB_NAME = "pmweb-automation"


class LearningStore:
    def __init__(self, mongo_uri: str = MONGO_URI) -> None:
        self._client = MongoClient(mongo_uri)
        self._db = self._client[DB_NAME]
        self._procedures = self._db["learned_procedures"]
        self._improvements = self._db["agent_improvements"]

    def store_success(
        self,
        prompt: str,
        plan: list[dict],
        results: list[dict],
    ) -> None:
        """Store a successful interaction for future reference."""
        doc = {
            "prompt": prompt,
            "plan": plan,
            "results": results,
            "success": True,
            "created_at": datetime.now(timezone.utc),
        }
        self._procedures.insert_one(doc)

    def store_failure(
        self,
        prompt: str,
        plan: list[dict],
        results: list[dict],
        feedback: str = "",
    ) -> None:
        """Store a failed interaction for learning."""
        doc = {
            "prompt": prompt,
            "plan": plan,
            "results": results,
            "success": False,
            "feedback": feedback,
            "created_at": datetime.now(timezone.utc),
        }
        self._procedures.insert_one(doc)

    def find_similar(self, prompt: str, limit: int = 3) -> list[dict]:
        """Find similar past successful interactions.

        Uses simple keyword matching. Can be upgraded to
        embeddings/vector search later.
        """
        words = prompt.lower().split()
        keywords = [
            w
            for w in words
            if len(w) > 3 and w not in ("create", "make", "build",
                                         "the", "with", "and", "for")
        ]

        if not keywords:
            return []

        query = {
            "success": True,
            "$or": [
                {"prompt": {"$regex": kw, "$options": "i"}}
                for kw in keywords[:5]
            ],
        }

        results = (
            self._procedures.find(query, {"_id": 0, "prompt": 1, "plan": 1})
            .sort("created_at", -1)
            .limit(limit)
        )
        return list(results)

    def get_stats(self) -> dict[str, Any]:
        total = self._procedures.count_documents({})
        successes = self._procedures.count_documents({"success": True})
        failures = self._procedures.count_documents({"success": False})
        return {
            "total_interactions": total,
            "successes": successes,
            "failures": failures,
            "success_rate": (
                round(successes / total * 100, 1) if total > 0 else 0
            ),
        }

    def store_improvement(
        self,
        ticket_id: str,
        description: str,
        changes: str,
    ) -> None:
        doc = {
            "ticket_id": ticket_id,
            "description": description,
            "changes": changes,
            "created_at": datetime.now(timezone.utc),
        }
        self._improvements.insert_one(doc)
