"""Chat session storage in MongoDB."""

from __future__ import annotations

from datetime import datetime, timezone
from typing import Any

from pymongo import MongoClient

MONGO_URI = "mongodb+srv://pmwebxadmin:sa_admin2025@cluster0.oddu5r6.mongodb.net/"
DB_NAME = "pmweb-automation"


class SessionStore:
    def __init__(self, mongo_uri: str = MONGO_URI) -> None:
        self._client = MongoClient(mongo_uri)
        self._db = self._client[DB_NAME]
        self._sessions = self._db["chat_sessions"]

    def create_session(self, title: str = "New Chat") -> dict[str, Any]:
        doc = {
            "title": title,
            "messages": [],
            "created_at": datetime.now(timezone.utc),
            "updated_at": datetime.now(timezone.utc),
        }
        result = self._sessions.insert_one(doc)
        doc["_id"] = str(result.inserted_id)
        return self._serialize(doc)

    def list_sessions(self) -> list[dict[str, Any]]:
        sessions = self._sessions.find({}, {"messages": 0}).sort("updated_at", -1).limit(50)
        return [self._serialize(s) for s in sessions]

    def get_session(self, session_id: str) -> dict[str, Any] | None:
        from bson import ObjectId
        doc = self._sessions.find_one({"_id": ObjectId(session_id)})
        return self._serialize(doc) if doc else None

    def add_message(self, session_id: str, role: str, content: str, actions: list | None = None) -> None:
        from bson import ObjectId
        msg = {"role": role, "content": content, "actions": actions or [], "timestamp": datetime.now(timezone.utc)}
        self._sessions.update_one(
            {"_id": ObjectId(session_id)},
            {"$push": {"messages": msg}, "$set": {"updated_at": datetime.now(timezone.utc)}},
        )

    def delete_session(self, session_id: str) -> None:
        from bson import ObjectId
        self._sessions.delete_one({"_id": ObjectId(session_id)})

    def _serialize(self, doc: dict) -> dict[str, Any]:
        doc["id"] = str(doc.pop("_id"))
        for k in ("created_at", "updated_at"):
            if k in doc and doc[k]:
                doc[k] = doc[k].isoformat()
        for msg in doc.get("messages", []):
            if "timestamp" in msg:
                msg["timestamp"] = msg["timestamp"].isoformat()
        return doc
