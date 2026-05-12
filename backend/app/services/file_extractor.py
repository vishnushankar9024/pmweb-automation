"""File extraction — converts uploaded files to text for the agent."""

from __future__ import annotations

import csv
import io
import json
import logging
from pathlib import Path

logger = logging.getLogger(__name__)


def extract_text(filename: str, content: bytes) -> str:
    """Extract text from any file format."""
    ext = Path(filename).suffix.lower()

    if ext in (".txt", ".md", ".log"):
        return content.decode("utf-8", errors="replace")
    elif ext == ".csv":
        text = content.decode("utf-8", errors="replace")
        reader = csv.reader(io.StringIO(text))
        return json.dumps(list(reader)[:100], indent=2)
    elif ext in (".json",):
        return content.decode("utf-8", errors="replace")
    elif ext in (".xlsx", ".xls"):
        try:
            import openpyxl
            wb = openpyxl.load_workbook(io.BytesIO(content), read_only=True)
            result = []
            for sheet in wb.sheetnames:
                ws = wb[sheet]
                rows = []
                for row in ws.iter_rows(max_row=100, values_only=True):
                    rows.append([str(c) if c is not None else "" for c in row])
                result.append({"sheet": sheet, "rows": rows})
            return json.dumps(result, indent=2)
        except Exception as e:
            return f"[Excel extraction failed: {e}]"
    elif ext == ".pdf":
        try:
            import PyPDF2
            reader = PyPDF2.PdfReader(io.BytesIO(content))
            pages = [p.extract_text() for p in reader.pages[:50] if p.extract_text()]
            return "\n\n".join(pages)
        except Exception as e:
            return f"[PDF extraction failed: {e}]"
    elif ext in (".docx",):
        try:
            import docx
            doc = docx.Document(io.BytesIO(content))
            return "\n".join(p.text for p in doc.paragraphs if p.text.strip())
        except Exception as e:
            return f"[DOCX extraction failed: {e}]"
    elif ext in (".png", ".jpg", ".jpeg", ".gif", ".webp"):
        return f"[IMAGE: {filename}, {len(content)} bytes]"
    elif ext in (".mp4", ".mov", ".avi", ".webm"):
        return f"[VIDEO: {filename}, {len(content)} bytes]"
    else:
        try:
            return content.decode("utf-8", errors="replace")
        except Exception:
            return f"[Binary file: {filename}, {len(content)} bytes]"
