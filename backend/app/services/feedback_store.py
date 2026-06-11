"""Feedback store — collects and persists user feedback on agent actions.

Captures thumbs-up/down ratings and optional text comments tied to
specific conversation turns.  The data feeds into :mod:`learning_store`
so the agent can improve over time.
"""

from __future__ import annotations

import json
import logging
import time
import uuid
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Any

logger = logging.getLogger(__name__)

DEFAULT_FEEDBACK_DIR = "/tmp/pmweb_feedback"


@dataclass
class FeedbackEntry:
    """A single piece of user feedback."""

    feedback_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    session_id: str = ""
    message_index: int = -1
    rating: int = 0  # -1 = negative, 0 = neutral, +1 = positive
    comment: str = ""
    action_name: str = ""
    action_args: dict[str, Any] = field(default_factory=dict)
    created_at: float = field(default_factory=time.time)

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)


class FeedbackStore:
    """File-backed feedback store.

    Each piece of feedback is appended to a JSONL (newline-delimited JSON)
    file for easy processing.
    """

    def __init__(self, data_dir: str = DEFAULT_FEEDBACK_DIR) -> None:
        self._dir = Path(data_dir)
        self._dir.mkdir(parents=True, exist_ok=True)
        self._file = self._dir / "feedback.jsonl"

    def add(self, entry: FeedbackEntry) -> str:
        """Persist a feedback entry and return its ID."""
        with self._file.open("a") as f:
            f.write(json.dumps(entry.to_dict(), default=str) + "\n")
        logger.info(
            "Feedback recorded: %s rating=%d session=%s",
            entry.feedback_id,
            entry.rating,
            entry.session_id,
        )
        return entry.feedback_id

    def get_all(self) -> list[FeedbackEntry]:
        """Read all feedback entries."""
        if not self._file.exists():
            return []
        entries: list[FeedbackEntry] = []
        for line in self._file.read_text().splitlines():
            if not line.strip():
                continue
            try:
                data = json.loads(line)
                entries.append(
                    FeedbackEntry(
                        feedback_id=data.get("feedback_id", ""),
                        session_id=data.get("session_id", ""),
                        message_index=data.get("message_index", -1),
                        rating=data.get("rating", 0),
                        comment=data.get("comment", ""),
                        action_name=data.get("action_name", ""),
                        action_args=data.get("action_args", {}),
                        created_at=data.get("created_at", 0),
                    )
                )
            except (json.JSONDecodeError, KeyError):
                continue
        return entries

    def get_by_session(self, session_id: str) -> list[FeedbackEntry]:
        """Return feedback entries for a specific session."""
        return [e for e in self.get_all() if e.session_id == session_id]

    def store_file(self, filename: str, content: bytes, content_type: str, extracted_text: str) -> str:
        """Persist an uploaded evidence file and return its ID."""
        file_id = str(uuid.uuid4())
        files_dir = self._dir / "files"
        files_dir.mkdir(exist_ok=True)
        (files_dir / f"{file_id}_{filename}").write_bytes(content)
        meta = {
            "file_id": file_id,
            "filename": filename,
            "content_type": content_type,
            "extracted_text": extracted_text,
            "created_at": time.time(),
        }
        with (self._dir / "file_meta.jsonl").open("a") as f:
            f.write(json.dumps(meta, default=str) + "\n")
        return file_id

    def create_ticket(
        self,
        session_id: str,
        prompt: str,
        actual_result: str,
        expected_result: str,
        file_ids: list[str] | None = None,
    ) -> dict[str, Any]:
        """Create a feedback ticket and return it with an ID."""
        ticket_id = str(uuid.uuid4())
        ticket = {
            "id": ticket_id,
            "session_id": session_id,
            "prompt": prompt,
            "actual_result": actual_result,
            "expected_result": expected_result,
            "file_ids": file_ids or [],
            "status": "open",
            "created_at": time.time(),
        }
        with (self._dir / "tickets.jsonl").open("a") as f:
            f.write(json.dumps(ticket, default=str) + "\n")
        logger.info("Feedback ticket created: %s", ticket_id)
        return ticket

    def get_ticket(self, ticket_id: str) -> dict[str, Any] | None:
        """Retrieve a ticket by ID."""
        tickets_file = self._dir / "tickets.jsonl"
        if not tickets_file.exists():
            return None
        for line in tickets_file.read_text().splitlines():
            if not line.strip():
                continue
            try:
                t = json.loads(line)
                if t.get("id") == ticket_id:
                    return t
            except json.JSONDecodeError:
                continue
        return None

    def summary(self) -> dict[str, Any]:
        """Aggregate feedback statistics."""
        entries = self.get_all()
        positive = sum(1 for e in entries if e.rating > 0)
        negative = sum(1 for e in entries if e.rating < 0)
        neutral = sum(1 for e in entries if e.rating == 0)
        return {
            "total": len(entries),
            "positive": positive,
            "negative": negative,
            "neutral": neutral,
            "satisfaction_rate": (
                round(positive / (positive + negative), 2)
                if (positive + negative) > 0
                else None
            ),
        }


_store: FeedbackStore | None = None


def get_feedback_store() -> FeedbackStore:
    """Return the global feedback store singleton."""
    global _store
    if _store is None:
        _store = FeedbackStore()
    return _store
