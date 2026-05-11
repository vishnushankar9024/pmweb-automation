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


@router.post("/connect")
async def connect_pmweb() -> dict:
    """Connect to PMWeb and login."""
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


@router.post("/navigate/{section}")
async def navigate(section: str) -> dict:
    """Navigate to a PMWeb section."""
    browser = get_browser()
    if section == "security":
        return browser.navigate_to_security()
    elif section == "forms":
        return browser.navigate_to_forms()
    elif section == "workflows":
        return browser.navigate_to_workflows()
    elif section == "tools":
        return browser.navigate_to_tools()
    else:
        raise HTTPException(status_code=400, detail=f"Unknown section: {section}")


@router.get("/page-info")
async def page_info() -> dict:
    """Get current page info."""
    browser = get_browser()
    return browser.get_page_info()


@router.post("/disconnect")
async def disconnect() -> dict:
    """Close the browser connection."""
    global _browser
    if _browser:
        _browser.close()
        _browser = None
    return {"status": "disconnected"}
