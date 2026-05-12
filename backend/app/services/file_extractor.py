"""File extractor — parses uploaded documents (CSV, Excel, JSON) into
structured PMWeb configuration payloads.

Users can upload a spreadsheet of security groups or users and this module
converts each row into the parameters expected by the agent's tool functions.
"""

from __future__ import annotations

import csv
import io
import json
import logging
from dataclasses import dataclass, field
from typing import Any

logger = logging.getLogger(__name__)

SUPPORTED_FORMATS = {"csv", "json", "tsv"}


@dataclass
class ExtractionResult:
    """Result of parsing an uploaded file."""

    format: str
    row_count: int
    records: list[dict[str, Any]] = field(default_factory=list)
    errors: list[str] = field(default_factory=list)
    suggested_action: str = ""


class FileExtractor:
    """Extracts structured records from uploaded files."""

    FIELD_ALIASES: dict[str, str] = {
        "id": "user_id",
        "userid": "user_id",
        "user id": "user_id",
        "firstname": "first_name",
        "first name": "first_name",
        "lastname": "last_name",
        "last name": "last_name",
        "group": "group_name",
        "group name": "group_name",
        "groupname": "group_name",
        "license": "license_type",
        "license type": "license_type",
        "licensetype": "license_type",
        "named": "named_license",
        "named license": "named_license",
        "admin": "pmweb_admin",
        "pmweb admin": "pmweb_admin",
        "description": "description",
        "name": "group_name",
        "bpm id": "bpm_id",
        "bpmid": "bpm_id",
        "form id": "form_id",
        "formid": "form_id",
        "form name": "form_name",
        "formname": "form_name",
    }

    def extract_csv(self, content: str | bytes) -> ExtractionResult:
        """Parse CSV content into records."""
        if isinstance(content, bytes):
            content = content.decode("utf-8-sig")

        reader = csv.DictReader(io.StringIO(content))
        records: list[dict[str, Any]] = []
        errors: list[str] = []

        for i, row in enumerate(reader, start=2):
            normalized = self._normalize_row(row)
            if not normalized:
                errors.append(f"Row {i}: empty after normalization")
                continue
            records.append(normalized)

        action = self._guess_action(records)
        return ExtractionResult(
            format="csv",
            row_count=len(records),
            records=records,
            errors=errors,
            suggested_action=action,
        )

    def extract_json(self, content: str | bytes) -> ExtractionResult:
        """Parse JSON content (array of objects) into records."""
        if isinstance(content, bytes):
            content = content.decode("utf-8-sig")

        try:
            data = json.loads(content)
        except json.JSONDecodeError as exc:
            return ExtractionResult(
                format="json", row_count=0, errors=[f"Invalid JSON: {exc}"]
            )

        if isinstance(data, dict):
            data = [data]
        if not isinstance(data, list):
            return ExtractionResult(
                format="json", row_count=0, errors=["Expected a JSON array"]
            )

        records = [self._normalize_row(item) for item in data if isinstance(item, dict)]
        action = self._guess_action(records)
        return ExtractionResult(
            format="json",
            row_count=len(records),
            records=records,
            suggested_action=action,
        )

    def extract(self, filename: str, content: str | bytes) -> ExtractionResult:
        """Auto-detect format from filename and extract."""
        lower = filename.lower()
        if lower.endswith(".csv") or lower.endswith(".tsv"):
            return self.extract_csv(content)
        if lower.endswith(".json"):
            return self.extract_json(content)
        return ExtractionResult(
            format="unknown",
            row_count=0,
            errors=[f"Unsupported file format: {filename}"],
        )

    def _normalize_row(self, row: dict[str, Any]) -> dict[str, Any]:
        """Map aliased/variant column names to canonical field names."""
        out: dict[str, Any] = {}
        for key, value in row.items():
            canonical = self.FIELD_ALIASES.get(key.strip().lower(), key.strip().lower())
            if isinstance(value, str):
                value = value.strip()
            if value in (None, ""):
                continue
            if canonical == "pmweb_admin":
                value = (
                    value.lower() in ("true", "yes", "1")
                    if isinstance(value, str)
                    else bool(value)
                )
            out[canonical] = value
        return out

    def _guess_action(self, records: list[dict[str, Any]]) -> str:
        """Heuristically determine which tool action the records map to."""
        if not records:
            return ""
        sample = records[0]
        keys = set(sample.keys())
        if "user_id" in keys or "first_name" in keys:
            return "create_user"
        if "bpm_id" in keys:
            return "create_workflow"
        if "form_id" in keys or "form_name" in keys:
            return "create_form"
        if "group_name" in keys and "description" in keys:
            return "create_security_group"
        return ""
