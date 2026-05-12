"""PMWeb browser connection management endpoints."""

from fastapi import APIRouter, HTTPException

from app.config import settings
from app.services.pmweb_browser import PMWebBrowser

router = APIRouter(prefix="/api/pmweb", tags=["pmweb"])

_browser: PMWebBrowser | None = None


def get_browser() -> PMWebBrowser:
    global _browser
    if _browser is None:
        if not settings.pmweb_base_url:
            raise HTTPException(
                status_code=400,
                detail="PMWEB_BASE_URL not configured",
            )
        _browser = PMWebBrowser(
            base_url=settings.pmweb_base_url,
            username=settings.pmweb_username,
            password=settings.pmweb_password,
            headless=settings.pmweb_headless,
        )
    return _browser


def get_browser_if_connected() -> PMWebBrowser | None:
    """Return the browser instance only if connected, else None."""
    if _browser and _browser._logged_in:
        return _browser
    return None


@router.post("/connect")
async def connect_pmweb() -> dict:
    """Connect to PMWeb and login (opens a visible browser)."""
    browser = get_browser()
    result = browser.login()
    if result["status"] != "success":
        raise HTTPException(status_code=401, detail=result.get("message"))
    return {"status": "connected", "url": result["url"]}


@router.get("/status")
async def pmweb_status() -> dict:
    """Get current PMWeb connection status."""
    return {
        "configured": bool(settings.pmweb_base_url),
        "base_url": settings.pmweb_base_url or None,
        "connected": _browser is not None and _browser._logged_in,
    }


@router.post("/disconnect")
async def disconnect() -> dict:
    """Close the browser connection."""
    global _browser
    if _browser:
        _browser.close()
        _browser = None
    return {"status": "disconnected"}


@router.get("/screenshot")
async def screenshot():
    """Return a live screenshot of the PMWeb browser as JPEG."""
    import base64

    if not _browser or not _browser._logged_in:
        return {"image": None}
    try:
        png_bytes = _browser.driver.get_screenshot_as_png()
        b64 = base64.b64encode(png_bytes).decode("ascii")
        return {"image": f"data:image/png;base64,{b64}"}
    except Exception:
        return {"image": None}
