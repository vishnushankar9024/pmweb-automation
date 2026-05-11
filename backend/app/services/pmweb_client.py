"""PMWeb client — routes actions to the real PMWeb browser when connected.

When the browser is connected, actions are performed VISUALLY in PMWeb.
When disconnected, actions are stored in memory (mock/preview mode).
"""

from __future__ import annotations

import logging
from typing import Any

from app.models.form import FormDefinition
from app.models.security import PasswordPolicy, SecurityGroup, UserAccess, UserAccount
from app.models.workflow import WorkflowDefinition

logger = logging.getLogger(__name__)


class PMWebClient:
    """Routes PMWeb actions to the real browser or stores in memory."""

    def __init__(self) -> None:
        self._groups: dict[str, SecurityGroup] = {}
        self._users: dict[str, UserAccount] = {}
        self._user_access: dict[str, UserAccess] = {}
        self._password_policy: PasswordPolicy = PasswordPolicy()
        self._workflows: dict[str, WorkflowDefinition] = {}
        self._forms: dict[str, FormDefinition] = {}

    def _get_browser(self):
        """Get the connected browser instance if available."""
        from app.api.pmweb import get_browser_if_connected

        return get_browser_if_connected()

    def create_security_group(self, **kwargs: Any) -> dict[str, Any]:
        group = SecurityGroup(**kwargs)
        browser = self._get_browser()

        if browser:
            result = browser.create_security_group(
                group_name=group.group_id,
                description=group.description,
            )
            if result["status"] == "created":
                self._groups[group.group_id] = group
            return result

        self._groups[group.group_id] = group
        logger.info("Created security group (mock): %s", group.group_id)
        return {"status": "created", "group": group.model_dump()}

    def create_user(self, **kwargs: Any) -> dict[str, Any]:
        user = UserAccount(**kwargs)
        browser = self._get_browser()

        if browser:
            result = browser.create_user(
                user_id=user.username,
                first_name=user.first_name,
                last_name=user.last_name,
                email=user.email,
                group_name=user.groups[0] if user.groups else "Admin",
            )
            if result["status"] == "created":
                self._users[user.username] = user
            return result

        self._users[user.username] = user
        logger.info("Created user (mock): %s", user.username)
        return {"status": "created", "user": user.model_dump()}

    def set_password_policy(self, **kwargs: Any) -> dict[str, Any]:
        self._password_policy = PasswordPolicy(**kwargs)
        logger.info("Updated password policy")
        return {"status": "updated", "policy": self._password_policy.model_dump()}

    def set_user_access(self, **kwargs: Any) -> dict[str, Any]:
        access = UserAccess(**kwargs)
        self._user_access[access.username] = access
        logger.info("Set access for user: %s", access.username)
        return {"status": "updated", "access": access.model_dump()}

    def create_workflow(self, **kwargs: Any) -> dict[str, Any]:
        steps_data = kwargs.pop("steps", [])
        wf = WorkflowDefinition(steps=steps_data, **kwargs)

        issues = wf.validate_structure()
        if issues:
            return {"status": "validation_error", "issues": issues}

        self._workflows[wf.workflow_name] = wf
        logger.info("Created workflow: %s", wf.workflow_name)
        return {"status": "created", "workflow": wf.model_dump()}

    def create_form(self, **kwargs: Any) -> dict[str, Any]:
        form = FormDefinition(**kwargs)
        self._forms[form.form_name] = form
        logger.info("Created form: %s", form.form_name)
        return {"status": "created", "form": form.model_dump()}

    def get_summary(self) -> dict[str, Any]:
        return {
            "groups": len(self._groups),
            "users": len(self._users),
            "workflows": len(self._workflows),
            "forms": len(self._forms),
            "items": {
                "groups": list(self._groups.keys()),
                "users": list(self._users.keys()),
                "workflows": list(self._workflows.keys()),
                "forms": list(self._forms.keys()),
            },
        }

    def execute_action(
        self, action_name: str, params: dict[str, Any]
    ) -> dict[str, Any]:
        handler = getattr(self, action_name, None)
        if handler is None:
            return {"status": "error", "message": f"Unknown action: {action_name}"}
        try:
            return handler(**params)
        except Exception as exc:
            logger.exception("Error executing %s", action_name)
            return {"status": "error", "message": str(exc)}
