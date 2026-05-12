"""Learning store — tracks which agent actions succeed or fail so that
the system prompt and tool selection can be improved over time.

Records action outcomes (success/failure, parameters, user feedback) and
derives actionable patterns: e.g. "create_user fails 30% of the time when
group_name has spaces" or "users prefer 3-step workflows over 5-step ones."
"""

from __future__ import annotations

import json
import logging
import time
from collections import Counter, defaultdict
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Any

logger = logging.getLogger(__name__)

DEFAULT_LEARNING_DIR = "/tmp/pmweb_learning"


@dataclass
class ActionRecord:
    """One logged action outcome."""

    action_name: str
    params: dict[str, Any] = field(default_factory=dict)
    status: str = ""
    error_message: str = ""
    elapsed_seconds: float = 0.0
    feedback_rating: int = 0  # -1/0/+1
    timestamp: float = field(default_factory=time.time)

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)


@dataclass
class ActionPattern:
    """A derived pattern from historical action records."""

    action_name: str
    total_count: int
    success_count: int
    failure_count: int
    success_rate: float
    avg_elapsed: float
    common_errors: list[str] = field(default_factory=list)


class LearningStore:
    """Persists action records and derives improvement patterns."""

    def __init__(self, data_dir: str = DEFAULT_LEARNING_DIR) -> None:
        self._dir = Path(data_dir)
        self._dir.mkdir(parents=True, exist_ok=True)
        self._file = self._dir / "actions.jsonl"

    def record(self, entry: ActionRecord) -> None:
        """Append an action record."""
        with self._file.open("a") as f:
            f.write(json.dumps(entry.to_dict(), default=str) + "\n")

    def get_all(self) -> list[ActionRecord]:
        """Load all recorded actions."""
        if not self._file.exists():
            return []
        records: list[ActionRecord] = []
        for line in self._file.read_text().splitlines():
            if not line.strip():
                continue
            try:
                d = json.loads(line)
                records.append(
                    ActionRecord(
                        action_name=d.get("action_name", ""),
                        params=d.get("params", {}),
                        status=d.get("status", ""),
                        error_message=d.get("error_message", ""),
                        elapsed_seconds=d.get("elapsed_seconds", 0.0),
                        feedback_rating=d.get("feedback_rating", 0),
                        timestamp=d.get("timestamp", 0),
                    )
                )
            except (json.JSONDecodeError, KeyError):
                continue
        return records

    def analyze(self) -> list[ActionPattern]:
        """Derive per-action patterns from the full history."""
        records = self.get_all()
        grouped: dict[str, list[ActionRecord]] = defaultdict(list)
        for r in records:
            grouped[r.action_name].append(r)

        patterns: list[ActionPattern] = []
        for name, recs in grouped.items():
            total = len(recs)
            successes = sum(1 for r in recs if r.status not in ("error", "validation_error"))
            failures = total - successes
            avg_el = sum(r.elapsed_seconds for r in recs) / total if total else 0
            errors = Counter(r.error_message for r in recs if r.error_message)
            patterns.append(
                ActionPattern(
                    action_name=name,
                    total_count=total,
                    success_count=successes,
                    failure_count=failures,
                    success_rate=round(successes / total, 2) if total else 0,
                    avg_elapsed=round(avg_el, 2),
                    common_errors=[e for e, _ in errors.most_common(3)],
                )
            )
        return patterns

    def get_prompt_hints(self) -> str:
        """Generate a supplementary prompt section based on learned patterns.

        This string can be appended to the system prompt so the LLM avoids
        historically problematic parameters.
        """
        patterns = self.analyze()
        if not patterns:
            return ""

        lines = ["\n## Learned patterns from past actions\n"]
        for p in patterns:
            if p.failure_count == 0:
                continue
            lines.append(
                f"- **{p.action_name}**: {p.success_rate*100:.0f}% success "
                f"({p.total_count} uses). "
                f"Common errors: {', '.join(p.common_errors) or 'none'}"
            )
        return "\n".join(lines) if len(lines) > 1 else ""


_store: LearningStore | None = None


def get_learning_store() -> LearningStore:
    """Return the global learning store singleton."""
    global _store
    if _store is None:
        _store = LearningStore()
    return _store
