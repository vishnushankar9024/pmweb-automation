from __future__ import annotations

from enum import Enum
from typing import Any

from pydantic import BaseModel, Field


class MessageRole(str, Enum):
    USER = "user"
    ASSISTANT = "assistant"
    SYSTEM = "system"


class ChatMessage(BaseModel):
    role: MessageRole
    content: str


class ActionType(str, Enum):
    CREATE_SECURITY_GROUP = "create_security_group"
    CREATE_USER = "create_user"
    SET_USER_ACCESS = "set_user_access"
    SET_PASSWORD_POLICY = "set_password_policy"
    CREATE_WORKFLOW = "create_workflow"
    ADD_WORKFLOW_STEP = "add_workflow_step"
    ASSIGN_WORKFLOW = "assign_workflow"
    CREATE_FORM = "create_form"
    ADD_FORM_FIELD = "add_form_field"
    SET_FORM_PERMISSIONS = "set_form_permissions"


class PendingAction(BaseModel):
    """An action the agent proposes before executing."""

    action_type: ActionType
    description: str
    parameters: dict[str, Any] = Field(default_factory=dict)


class ChatRequest(BaseModel):
    message: str
    conversation_id: str | None = None


class ChatResponse(BaseModel):
    reply: str
    conversation_id: str
    pending_actions: list[PendingAction] = Field(default_factory=list)
    executed_actions: list[dict[str, Any]] = Field(default_factory=list)
