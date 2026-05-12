"""Persistent session store — keeps conversation state across restarts.

Uses a simple JSON-file backend so sessions survive server restarts without
requiring a database.  In production, swap :class:`FileSessionStore` for a
Redis/Postgres implementation behind the same :class:`SessionStore` protocol.
"""

from __future__ import annotations

import json
import logging
import os
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Protocol

logger = logging.getLogger(__name__)

DEFAULT_DATA_DIR = os.environ.get("SESSION_DATA_DIR", "/tmp/pmweb_sessions")
MAX_SESSIONS = 200
SESSION_TTL_SECONDS = 60 * 60 * 24 * 7  # 7 days


@dataclass
class Session:
    """In-memory representation of a conversation session."""

    session_id: str
    messages: list[dict[str, Any]] = field(default_factory=list)
    metadata: dict[str, Any] = field(default_factory=dict)
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)

    def to_dict(self) -> dict[str, Any]:
        return {
            "session_id": self.session_id,
            "messages": self.messages,
            "metadata": self.metadata,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }

    @classmethod
    def from_dict(cls, data: dict[str, Any]) -> "Session":
        return cls(
            session_id=data["session_id"],
            messages=data.get("messages", []),
            metadata=data.get("metadata", {}),
            created_at=data.get("created_at", time.time()),
            updated_at=data.get("updated_at", time.time()),
        )


class SessionStore(Protocol):
    """Protocol that any session backend must implement."""

    def get(self, session_id: str) -> Session | None: ...

    def save(self, session: Session) -> None: ...

    def delete(self, session_id: str) -> bool: ...

    def list_sessions(self) -> list[str]: ...


class FileSessionStore:
    """JSON-file-backed session store for development / small deployments."""

    def __init__(self, data_dir: str = DEFAULT_DATA_DIR) -> None:
        self._dir = Path(data_dir)
        self._dir.mkdir(parents=True, exist_ok=True)

    def _path(self, session_id: str) -> Path:
        safe = session_id.replace("/", "_").replace("..", "_")
        return self._dir / f"{safe}.json"

    def get(self, session_id: str) -> Session | None:
        path = self._path(session_id)
        if not path.exists():
            return None
        try:
            data = json.loads(path.read_text())
            session = Session.from_dict(data)
            if time.time() - session.updated_at > SESSION_TTL_SECONDS:
                path.unlink(missing_ok=True)
                return None
            return session
        except (json.JSONDecodeError, KeyError):
            logger.warning("Corrupt session file: %s", path)
            path.unlink(missing_ok=True)
            return None

    def save(self, session: Session) -> None:
        session.updated_at = time.time()
        self._enforce_limit()
        path = self._path(session.session_id)
        path.write_text(json.dumps(session.to_dict(), default=str))

    def delete(self, session_id: str) -> bool:
        path = self._path(session_id)
        if path.exists():
            path.unlink()
            return True
        return False

    def list_sessions(self) -> list[str]:
        return [p.stem for p in self._dir.glob("*.json")]

    def _enforce_limit(self) -> None:
        """Evict the oldest sessions when we exceed MAX_SESSIONS."""
        files = sorted(self._dir.glob("*.json"), key=lambda p: p.stat().st_mtime)
        while len(files) > MAX_SESSIONS:
            oldest = files.pop(0)
            oldest.unlink(missing_ok=True)
            logger.info("Evicted old session: %s", oldest.stem)


# Module-level singleton
_store: FileSessionStore | None = None


def get_session_store() -> FileSessionStore:
    """Return the global session store instance."""
    global _store
    if _store is None:
        _store = FileSessionStore()
    return _store
