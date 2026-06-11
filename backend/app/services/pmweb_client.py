"""PMWeb client — routes actions to the real PMWeb browser when connected."""

from __future__ import annotations

import logging
from typing import Any

from app.models.workflow import BusinessProcess

logger = logging.getLogger(__name__)


class PMWebClient:
    """Routes PMWeb actions to the real browser or stores in memory."""

    def __init__(self) -> None:
        self._groups: dict[str, dict] = {}
        self._users: dict[str, dict] = {}
        self._workflows: dict[str, dict] = {}
        self._forms: dict[str, dict] = {}

    def _get_browser(self):
        try:
            from app.api.pmweb import get_browser_if_connected
        except ImportError:
            return None

        return get_browser_if_connected()

    def create_security_group(self, **kwargs: Any) -> dict[str, Any]:
        browser = self._get_browser()
        if browser:
            return browser.create_security_group(
                group_name=kwargs["group_name"],
                description=kwargs["description"],
                options=kwargs.get("options"),
            )
        self._groups[kwargs["group_name"]] = kwargs
        return {"status": "created", "group": kwargs}

    def create_user(self, **kwargs: Any) -> dict[str, Any]:
        browser = self._get_browser()
        if browser:
            return browser.create_user(
                user_id=kwargs["user_id"],
                first_name=kwargs["first_name"],
                last_name=kwargs.get("last_name", ""),
                email=kwargs.get("email", ""),
                license_type=kwargs.get("license_type", "Full"),
                named_license=kwargs.get("named_license", "Named"),
                group_name=kwargs.get("group_name", "Admin"),
                password=kwargs.get("password", "Welcome1!"),
                pmweb_admin=kwargs.get("pmweb_admin", False),
            )
        self._users[kwargs["user_id"]] = kwargs
        return {"status": "created", "user": kwargs}

    def create_workflow(self, **kwargs: Any) -> dict[str, Any]:
        steps_data = kwargs.pop("steps", [])
        bpm = BusinessProcess(steps=steps_data, **kwargs)
        issues = bpm.validate_structure()
        if issues:
            return {"status": "validation_error", "issues": issues}
        self._workflows[bpm.bpm_id] = bpm.model_dump()
        return {"status": "created", "workflow": bpm.model_dump()}

    def create_form(self, **kwargs: Any) -> dict[str, Any]:
        self._forms[kwargs.get("form_id", "")] = kwargs
        return {"status": "created", "form": kwargs}

    def get_summary(self) -> dict[str, Any]:
        return {
            "groups": len(self._groups),
            "users": len(self._users),
            "workflows": len(self._workflows),
            "forms": len(self._forms),
        }

    def execute_action(
        self, action_name: str, params: dict[str, Any]
    ) -> dict[str, Any]:
        handler = getattr(self, action_name, None)
        if handler is None:
            return {"status": "error", "message": f"Unknown: {action_name}"}
        try:
            return handler(**params)
        except Exception as exc:
            logger.exception("Error executing %s", action_name)
            return {"status": "error", "message": str(exc)}
