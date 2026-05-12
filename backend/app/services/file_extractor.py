"""File extraction — converts uploaded files to text for the agent."""

from __future__ import annotations

import base64
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
        return _extract_csv(content)

    elif ext in (".json",):
        return content.decode("utf-8", errors="replace")

    elif ext in (".xlsx", ".xls"):
        return _extract_excel(content)

    elif ext == ".pdf":
        return _extract_pdf(content)

    elif ext in (".docx",):
        return _extract_docx(content)

    elif ext in (".png", ".jpg", ".jpeg", ".gif", ".webp", ".bmp"):
        return _extract_image(content, ext)

    elif ext in (".mp4", ".mov", ".avi", ".webm"):
        return _extract_video(content, filename)

    else:
        try:
            return content.decode("utf-8", errors="replace")
        except Exception:
            return f"[Binary file: {filename}, {len(content)} bytes]"


def _extract_csv(content: bytes) -> str:
    text = content.decode("utf-8", errors="replace")
    reader = csv.reader(io.StringIO(text))
    rows = list(reader)
    if not rows:
        return ""
    return json.dumps(rows[:100], indent=2)


def _extract_excel(content: bytes) -> str:
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
    except ImportError:
        return "[Excel extraction requires openpyxl]"
    except Exception as e:
        return f"[Excel extraction failed: {e}]"


def _extract_pdf(content: bytes) -> str:
    try:
        import PyPDF2

        reader = PyPDF2.PdfReader(io.BytesIO(content))
        pages = []
        for page in reader.pages[:50]:
            text = page.extract_text()
            if text:
                pages.append(text)
        return "\n\n".join(pages)
    except ImportError:
        return "[PDF extraction requires PyPDF2]"
    except Exception as e:
        return f"[PDF extraction failed: {e}]"


def _extract_docx(content: bytes) -> str:
    try:
        import docx

        doc = docx.Document(io.BytesIO(content))
        paragraphs = [p.text for p in doc.paragraphs if p.text.strip()]
        return "\n".join(paragraphs)
    except ImportError:
        return "[DOCX extraction requires python-docx]"
    except Exception as e:
        return f"[DOCX extraction failed: {e}]"


def _extract_image(content: bytes, ext: str) -> str:
    b64 = base64.b64encode(content).decode("ascii")
    mime = {
        ".png": "image/png",
        ".jpg": "image/jpeg",
        ".jpeg": "image/jpeg",
        ".gif": "image/gif",
        ".webp": "image/webp",
        ".bmp": "image/bmp",
    }.get(ext, "image/png")
    return f"[IMAGE:{mime};base64,{b64[:100]}... ({len(content)} bytes)]"


def _extract_video(content: bytes, filename: str) -> str:
    return (
        f"[VIDEO: {filename}, {len(content)} bytes. "
        f"Video frame analysis available via GPT-4o vision.]"
    )


def describe_image_with_vision(
    image_b64: str, mime: str, prompt: str = "Describe this image"
) -> str:
    """Use GPT-4o vision to describe an image."""
    try:
        from openai import OpenAI

        from app.config import settings

        client = OpenAI(api_key=settings.openai_api_key)
        resp = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": prompt},
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:{mime};base64,{image_b64}",
                            },
                        },
                    ],
                }
            ],
            max_tokens=500,
        )
        return resp.choices[0].message.content or ""
    except Exception as e:
        return f"[Vision analysis failed: {e}]"
