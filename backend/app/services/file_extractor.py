"""File extraction — converts uploaded files to text for the agent.

Supports: PDF, Excel, Word, PowerPoint, ODF, CSV, JSON, images (GPT-4o vision),
video (ffmpeg + GPT-4o vision), drawings (DWG/DXF via GPT-4o vision on renders),
and plain text formats.
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
import zipfile
from pathlib import Path
from xml.etree import ElementTree

logger = logging.getLogger(__name__)

MAX_VIDEO_FRAMES = 5


def _get_openai_key() -> str:
    key = os.getenv("OPENAI_API_KEY", "")
    if not key:
        from app.config import settings
        key = settings.openai_api_key
    return key


def _analyze_image_with_vision(image_bytes: bytes, filename: str, mime_type: str = "image/png") -> str:
    api_key = _get_openai_key()
    if not api_key:
        return f"[IMAGE: {filename} — no OpenAI key for vision analysis]"
    try:
        from openai import OpenAI
        client = OpenAI(api_key=api_key)
        b64 = base64.b64encode(image_bytes).decode("utf-8")
        resp = client.chat.completions.create(
            model="gpt-4o",
            messages=[{
                "role": "user",
                "content": [
                    {"type": "text", "text": (
                        f"Extract ALL text, data, labels, field names, column headers, and values "
                        f"from this image '{filename}'. Output as structured data. "
                        f"If it's a form, list every field name and its value. "
                        f"If it's a table, output as rows. If it's a drawing/diagram, "
                        f"describe the layout, labels, dimensions, and annotations."
                    )},
                    {"type": "image_url", "image_url": {"url": f"data:{mime_type};base64,{b64}", "detail": "high"}},
                ],
            }],
            max_tokens=1000,
        )
        return resp.choices[0].message.content or f"[IMAGE: {filename}]"
    except Exception as e:
        logger.warning("Vision analysis failed for %s: %s", filename, e)
        return f"[IMAGE: {filename}, vision error: {e}]"


def _extract_video_frames(video_bytes: bytes, filename: str) -> str:
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
                ["ffmpeg", "-i", video_path, "-vf", f"fps=1/{interval}",
                 "-frames:v", str(MAX_VIDEO_FRAMES), "-q:v", "3",
                 os.path.join(frames_dir, "frame_%03d.jpg")],
                capture_output=True, timeout=60,
            )
        except FileNotFoundError:
            return f"[VIDEO: {filename} — ffmpeg not installed]"
        except subprocess.TimeoutExpired:
            return f"[VIDEO: {filename} — ffmpeg timed out]"
        frame_files = sorted(Path(frames_dir).glob("frame_*.jpg"))
        if not frame_files:
            return f"[VIDEO: {filename} — no frames extracted]"
        descriptions = [f"Video: {filename} ({duration:.1f}s, {len(frame_files)} frames)"]
        for i, fp in enumerate(frame_files):
            desc = _analyze_image_with_vision(fp.read_bytes(), f"{filename} @{i * interval}s")
            descriptions.append(f"\n[Frame {i + 1} at {i * interval}s]\n{desc}")
        return "\n".join(descriptions)


def _extract_pptx(content: bytes, filename: str) -> str:
    try:
        from pptx import Presentation
        prs = Presentation(io.BytesIO(content))
        slides = []
        for i, slide in enumerate(prs.slides[:30]):
            texts = []
            for shape in slide.shapes:
                if shape.has_text_frame:
                    for para in shape.text_frame.paragraphs:
                        t = para.text.strip()
                        if t:
                            texts.append(t)
                if shape.has_table:
                    table = shape.table
                    for row in table.rows:
                        row_texts = [cell.text.strip() for cell in row.cells]
                        texts.append(" | ".join(row_texts))
            if texts:
                slides.append(f"--- Slide {i + 1} ---\n" + "\n".join(texts))
        return "\n\n".join(slides) if slides else f"[PPTX: {filename} — no text found]"
    except ImportError:
        return f"[PPTX: {filename} — python-pptx not installed]"
    except Exception as e:
        return f"[PPTX extraction failed: {e}]"


def _extract_odf(content: bytes, filename: str) -> str:
    """Extract text from ODF files (.odt, .ods, .odp) via XML inside the ZIP."""
    try:
        with zipfile.ZipFile(io.BytesIO(content)) as zf:
            if "content.xml" not in zf.namelist():
                return f"[ODF: {filename} — no content.xml found]"
            xml_content = zf.read("content.xml")
            tree = ElementTree.fromstring(xml_content)
            texts = []
            for elem in tree.iter():
                if elem.text and elem.text.strip():
                    texts.append(elem.text.strip())
                if elem.tail and elem.tail.strip():
                    texts.append(elem.tail.strip())
            return "\n".join(texts[:500]) if texts else f"[ODF: {filename} — no text]"
    except Exception as e:
        return f"[ODF extraction failed: {e}]"


def _extract_drawing(content: bytes, filename: str) -> str:
    """Extract data from CAD drawings (DWG/DXF) using ezdxf or vision fallback."""
    ext = Path(filename).suffix.lower()
    if ext == ".dxf":
        try:
            import ezdxf
            doc = ezdxf.read(io.BytesIO(content))
            msp = doc.modelspace()
            entities = []
            for entity in list(msp)[:200]:
                etype = entity.dxftype()
                if etype == "TEXT":
                    entities.append(f"TEXT: '{entity.dxf.text}' at ({entity.dxf.insert.x:.1f}, {entity.dxf.insert.y:.1f})")
                elif etype == "MTEXT":
                    entities.append(f"MTEXT: '{entity.text}' at ({entity.dxf.insert.x:.1f}, {entity.dxf.insert.y:.1f})")
                elif etype == "LINE":
                    entities.append(f"LINE: ({entity.dxf.start.x:.1f},{entity.dxf.start.y:.1f}) → ({entity.dxf.end.x:.1f},{entity.dxf.end.y:.1f})")
                elif etype == "CIRCLE":
                    entities.append(f"CIRCLE: center=({entity.dxf.center.x:.1f},{entity.dxf.center.y:.1f}), r={entity.dxf.radius:.1f}")
                elif etype == "INSERT":
                    entities.append(f"BLOCK: '{entity.dxf.name}' at ({entity.dxf.insert.x:.1f},{entity.dxf.insert.y:.1f})")
                elif etype == "DIMENSION":
                    entities.append(f"DIMENSION: {entity.dxf.text or 'auto'}")
            layers = [layer.dxf.name for layer in doc.layers]
            header = f"DXF Drawing: {filename}\nLayers: {', '.join(layers[:20])}\n{len(entities)} entities\n"
            return header + "\n".join(entities[:100])
        except ImportError:
            pass
        except Exception as e:
            return f"[DXF parse failed: {e}]"

    return _analyze_image_with_vision(content, filename, "application/octet-stream")


def extract_text(filename: str, content: bytes) -> str:
    """Extract text from any file format."""
    ext = Path(filename).suffix.lower()

    if ext in (".txt", ".md", ".log", ".xml", ".html", ".htm"):
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
            parts = []
            for para in doc.paragraphs:
                if para.text.strip():
                    parts.append(para.text)
            for table in doc.tables:
                for row in table.rows:
                    row_text = " | ".join(cell.text.strip() for cell in row.cells)
                    if row_text.strip():
                        parts.append(row_text)
            return "\n".join(parts)
        except Exception as e:
            return f"[DOCX extraction failed: {e}]"

    elif ext in (".doc",):
        return _analyze_image_with_vision(content, filename, "application/msword")

    elif ext in (".pptx",):
        return _extract_pptx(content, filename)

    elif ext in (".ppt",):
        return _analyze_image_with_vision(content, filename, "application/vnd.ms-powerpoint")

    elif ext in (".odt", ".ods", ".odp"):
        return _extract_odf(content, filename)

    elif ext in (".dwg", ".dxf"):
        return _extract_drawing(content, filename)

    elif ext in (".png", ".jpg", ".jpeg", ".gif", ".webp", ".bmp", ".tiff", ".tif", ".svg"):
        mime_map = {
            ".png": "image/png", ".jpg": "image/jpeg", ".jpeg": "image/jpeg",
            ".gif": "image/gif", ".webp": "image/webp", ".bmp": "image/bmp",
            ".tiff": "image/tiff", ".tif": "image/tiff", ".svg": "image/svg+xml",
        }
        return _analyze_image_with_vision(content, filename, mime_map.get(ext, "image/png"))

    elif ext in (".mp4", ".mov", ".avi", ".webm", ".mkv"):
        return _extract_video_frames(content, filename)

    else:
        try:
            return content.decode("utf-8", errors="replace")
        except Exception:
            return f"[Binary file: {filename}, {len(content)} bytes]"
