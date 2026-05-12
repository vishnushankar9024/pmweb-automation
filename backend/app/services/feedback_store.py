"""Feedback system — stores fix requests and learns from outcomes."""

from __future__ import annotations

import base64
from datetime import datetime, timezone
from typing import Any

from pymongo import MongoClient

MONGO_URI = (
    "mongodb+srv://pmwebxadmin:sa_admin2025"
    "@cluster0.oddu5r6.mongodb.net/"
)
DB_NAME = "pmweb-automation"


class FeedbackStore:
    def __init__(self, mongo_uri: str = MONGO_URI) -> None:
        self._client = MongoClient(mongo_uri)
        self._db = self._client[DB_NAME]
        self._tickets = self._db["feedback_tickets"]
        self._files = self._db["uploaded_files"]

    def create_ticket(
        self,
        session_id: str,
        prompt: str,
        actual_result: str,
        expected_result: str,
        file_ids: list[str] | None = None,
    ) -> dict[str, Any]:
        doc = {
            "session_id": session_id,
            "prompt": prompt,
            "actual_result": actual_result,
            "expected_result": expected_result,
            "file_ids": file_ids or [],
            "status": "pending",
            "created_at": datetime.now(timezone.utc),
            "resolved_at": None,
            "fix_attempts": 0,
        }
        result = self._tickets.insert_one(doc)
        doc["_id"] = str(result.inserted_id)
        return self._serialize(doc)

    def list_tickets(
        self, status: str | None = None
    ) -> list[dict[str, Any]]:
        query = {"status": status} if status else {}
        tickets = (
            self._tickets.find(query)
            .sort("created_at", -1)
            .limit(50)
        )
        return [self._serialize(t) for t in tickets]

    def get_ticket(self, ticket_id: str) -> dict[str, Any] | None:
        from bson import ObjectId

        doc = self._tickets.find_one({"_id": ObjectId(ticket_id)})
        return self._serialize(doc) if doc else None

    def resolve_ticket(self, ticket_id: str) -> None:
        from bson import ObjectId

        self._tickets.update_one(
            {"_id": ObjectId(ticket_id)},
            {
                "$set": {
                    "status": "resolved",
                    "resolved_at": datetime.now(timezone.utc),
                }
            },
        )

    def increment_attempt(self, ticket_id: str) -> None:
        from bson import ObjectId

        self._tickets.update_one(
            {"_id": ObjectId(ticket_id)},
            {"$inc": {"fix_attempts": 1}},
        )

    def store_file(
        self,
        filename: str,
        content: bytes,
        content_type: str,
        extracted_text: str,
    ) -> str:
        doc = {
            "filename": filename,
            "content_type": content_type,
            "size": len(content),
            "content_b64": base64.b64encode(content).decode("ascii"),
            "extracted_text": extracted_text,
            "uploaded_at": datetime.now(timezone.utc),
        }
        result = self._files.insert_one(doc)
        return str(result.inserted_id)

    def get_file(self, file_id: str) -> dict[str, Any] | None:
        from bson import ObjectId

        doc = self._files.find_one({"_id": ObjectId(file_id)})
        if doc:
            doc["id"] = str(doc.pop("_id"))
            return doc
        return None

    def _serialize(self, doc: dict) -> dict[str, Any]:
        doc["id"] = str(doc.pop("_id"))
        for key in ("created_at", "resolved_at"):
            if key in doc and doc[key]:
                doc[key] = doc[key].isoformat()
        return doc
