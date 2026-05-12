"""PMWeb client — routes actions to the real browser when connected."""

from __future__ import annotations

import logging
from typing import Any

logger = logging.getLogger(__name__)


class PMWebClient:
    """Routes PMWeb actions to the real browser or stores locally."""

    def __init__(self) -> None:
        self._store: dict[str, list] = {
            "groups": [],
            "users": [],
            "workflows": [],
            "forms": [],
        }

    def _get_browser(self):
        from app.api.pmweb import get_browser_if_connected

        return get_browser_if_connected()

    def create_security_group(self, **kw: Any) -> dict[str, Any]:
        browser = self._get_browser()
        if browser:
            return browser.create_security_group(
                group_name=kw["group_name"],
                description=kw["description"],
                options=kw.get("options"),
            )
        self._store["groups"].append(kw)
        return {"status": "created", "group": kw}

    def create_user(self, **kw: Any) -> dict[str, Any]:
        browser = self._get_browser()
        if browser:
            return browser.create_user(
                user_id=kw["user_id"],
                first_name=kw["first_name"],
                last_name=kw.get("last_name", ""),
                email=kw.get("email", ""),
                license_type=kw.get("license_type", "Full"),
                named_license=kw.get("named_license", "Named"),
                group_name=kw.get("group_name", "Admin"),
                password=kw.get("password", "Welcome1!"),
                pmweb_admin=kw.get("pmweb_admin", False),
            )
        self._store["users"].append(kw)
        return {"status": "created", "user": kw}

    def create_adaptive_form(self, **kw: Any) -> dict[str, Any]:
        browser = self._get_browser()
        if browser:
            return browser.create_adaptive_form(
                form_name=kw["form_name"],
                fields=kw.get("fields"),
            )
        self._store["forms"].append(kw)
        return {"status": "created", "form": kw}

    def navigate_pmweb(self, **kw: Any) -> dict[str, Any]:
        browser = self._get_browser()
        if browser:
            return browser.navigate_to(kw["destination"])
        return {
            "status": "not_connected",
            "message": "Connect to PMWeb first",
        }

    def create_workflow(self, **kw: Any) -> dict[str, Any]:
        steps = kw.pop("steps", [])
        from app.models.workflow import BusinessProcess

        bpm = BusinessProcess(steps=steps, **kw)
        issues = bpm.validate_structure()
        if issues:
            return {"status": "validation_error", "issues": issues}
        self._store["workflows"].append(bpm.model_dump())
        return {"status": "created", "workflow": bpm.model_dump()}

    def get_summary(self) -> dict[str, Any]:
        return {k: len(v) for k, v in self._store.items()}

    def execute_action(
        self, action_name: str, params: dict[str, Any]
    ) -> dict[str, Any]:
        handler = getattr(self, action_name, None)
        if handler is None:
            return {
                "status": "error",
                "message": f"Unknown: {action_name}",
            }
        try:
            return handler(**params)
        except Exception as exc:
            logger.exception("Error executing %s", action_name)
            return {"status": "error", "message": str(exc)}
