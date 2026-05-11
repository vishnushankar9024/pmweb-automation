"""PMWeb client — abstracts interaction with PMWeb.

Currently runs in **mock mode** (all actions are simulated locally).
When a real PMWeb instance is available, swap the implementation to use
the PMWeb REST API or browser automation via Playwright.
"""

from __future__ import annotations

import logging
from typing import Any

from app.models.form import FormDefinition
from app.models.security import PasswordPolicy, SecurityGroup, UserAccess, UserAccount
from app.models.workflow import WorkflowDefinition

logger = logging.getLogger(__name__)


class PMWebClient:
    """Simulated PMWeb client that stores configuration in memory."""

    def __init__(self) -> None:
        self._groups: dict[str, SecurityGroup] = {}
        self._users: dict[str, UserAccount] = {}
        self._user_access: dict[str, UserAccess] = {}
        self._password_policy: PasswordPolicy = PasswordPolicy()
        self._workflows: dict[str, WorkflowDefinition] = {}
        self._forms: dict[str, FormDefinition] = {}

    def create_security_group(self, **kwargs: Any) -> dict[str, Any]:
        group = SecurityGroup(**kwargs)
        self._groups[group.group_id] = group
        logger.info("Created security group: %s", group.group_id)
        return {"status": "created", "group": group.model_dump()}

    def create_user(self, **kwargs: Any) -> dict[str, Any]:
        user = UserAccount(**kwargs)
        self._users[user.username] = user
        logger.info("Created user: %s", user.username)
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

    def execute_action(self, action_name: str, params: dict[str, Any]) -> dict[str, Any]:
        handler = getattr(self, action_name, None)
        if handler is None:
            return {"status": "error", "message": f"Unknown action: {action_name}"}
        try:
            return handler(**params)
        except Exception as exc:
            logger.exception("Error executing %s", action_name)
            return {"status": "error", "message": str(exc)}
