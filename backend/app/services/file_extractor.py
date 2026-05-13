"""File extraction — converts uploaded files to text for the agent.

Supports video files via ffmpeg frame extraction + GPT-4o vision analysis,
images via GPT-4o vision, and common document/spreadsheet formats.
"""

from __future__ import annotations

import base64
import csv
import io
import json
import logging
import os
import subprocess
import tempfile
from pathlib import Path

logger = logging.getLogger(__name__)

MAX_VIDEO_FRAMES = 5
FRAME_INTERVAL_SECONDS = 3


def _analyze_image_with_vision(image_bytes: bytes, filename: str, mime_type: str = "image/png") -> str:
    """Send a single image to GPT-4o vision and return a text description."""
    api_key = os.getenv("OPENAI_API_KEY", "")
    if not api_key:
        from app.config import settings
        api_key = settings.openai_api_key
    if not api_key:
        return f"[IMAGE: {filename} — no OpenAI key for vision analysis]"

    try:
        from openai import OpenAI
        client = OpenAI(api_key=api_key)
        b64 = base64.b64encode(image_bytes).decode("utf-8")
        resp = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": f"Describe this image from '{filename}' in detail. Focus on any UI elements, text content, error messages, or data visible."},
                        {"type": "image_url", "image_url": {"url": f"data:{mime_type};base64,{b64}", "detail": "low"}},
                    ],
                }
            ],
            max_tokens=500,
        )
        return resp.choices[0].message.content or f"[IMAGE: {filename}]"
    except Exception as e:
        logger.warning("Vision analysis failed for %s: %s", filename, e)
        return f"[IMAGE: {filename}, vision error: {e}]"


def _extract_video_frames(video_bytes: bytes, filename: str) -> str:
    """Extract key frames from video using ffmpeg, analyze each with GPT-4o vision."""
    with tempfile.TemporaryDirectory() as tmpdir:
        video_path = os.path.join(tmpdir, filename)
        with open(video_path, "wb") as f:
            f.write(video_bytes)

        frames_dir = os.path.join(tmpdir, "frames")
        os.makedirs(frames_dir)

        try:
            probe = subprocess.run(
                ["ffprobe", "-v", "quiet", "-show_entries", "format=duration", "-of", "csv=p=0", video_path],
                capture_output=True, text=True, timeout=30,
            )
            duration = float(probe.stdout.strip()) if probe.stdout.strip() else 15.0
        except Exception:
            duration = 15.0

        interval = max(1, int(duration / MAX_VIDEO_FRAMES))

        try:
            subprocess.run(
                [
                    "ffmpeg", "-i", video_path,
                    "-vf", f"fps=1/{interval}",
                    "-frames:v", str(MAX_VIDEO_FRAMES),
                    "-q:v", "3",
                    os.path.join(frames_dir, "frame_%03d.jpg"),
                ],
                capture_output=True, timeout=60,
            )
        except FileNotFoundError:
            return f"[VIDEO: {filename} — ffmpeg not installed, cannot extract frames]"
        except subprocess.TimeoutExpired:
            return f"[VIDEO: {filename} — ffmpeg timed out]"

        frame_files = sorted(Path(frames_dir).glob("frame_*.jpg"))
        if not frame_files:
            return f"[VIDEO: {filename} — no frames extracted]"

        descriptions = [f"Video: {filename} ({duration:.1f}s, {len(frame_files)} frames extracted)"]
        for i, fp in enumerate(frame_files):
            frame_bytes = fp.read_bytes()
            timestamp = i * interval
            desc = _analyze_image_with_vision(frame_bytes, f"{filename} @{timestamp}s")
            descriptions.append(f"\n[Frame {i + 1} at {timestamp}s]\n{desc}")

        return "\n".join(descriptions)


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
        mime_map = {".png": "image/png", ".jpg": "image/jpeg", ".jpeg": "image/jpeg", ".gif": "image/gif", ".webp": "image/webp"}
        return _analyze_image_with_vision(content, filename, mime_map.get(ext, "image/png"))
    elif ext in (".mp4", ".mov", ".avi", ".webm"):
        return _extract_video_frames(content, filename)
    else:
        try:
            return content.decode("utf-8", errors="replace")
        except Exception:
            return f"[Binary file: {filename}, {len(content)} bytes]"
