from __future__ import annotations

from enum import Enum

from pydantic import BaseModel, Field


class StepType(str, Enum):
    SUBMIT = "submit"
    APPROVAL = "approval"
    REVIEW = "review"
    BRANCH = "branch"
    FINISH = "finish"


class NotificationMethod(str, Enum):
    EMAIL = "email"
    IN_APP = "in_app"
    BOTH = "both"


class WorkflowStep(BaseModel):
    step_name: str
    step_type: StepType
    order: int = Field(..., ge=1)
    assigned_roles: list[str] = Field(default_factory=list)
    review_days: int = Field(3, ge=1, description="Days allowed for review")
    all_must_approve: bool = False
    allow_edit: bool = False
    require_comments: bool = False
    allow_delegation: bool = True
    notification_method: NotificationMethod = NotificationMethod.EMAIL
    cc_roles: list[str] = Field(default_factory=list)
    instructions: str = ""
    return_to_step: str | None = None


class WorkflowDefinition(BaseModel):
    workflow_name: str
    description: str = ""
    record_type: str = Field(..., description="PMWeb record type this workflow applies to")
    is_active: bool = True
    steps: list[WorkflowStep] = Field(default_factory=list)

    def validate_structure(self) -> list[str]:
        """Return a list of validation issues, empty if valid."""
        issues: list[str] = []
        if not self.steps:
            issues.append("Workflow must have at least one step")
            return issues

        sorted_steps = sorted(self.steps, key=lambda s: s.order)

        if sorted_steps[0].step_type != StepType.SUBMIT:
            issues.append("First step must be a Submit step")
        if sorted_steps[-1].step_type != StepType.FINISH:
            issues.append("Last step must be a Finish step")

        for step in sorted_steps[1:-1]:
            if step.step_type in (StepType.SUBMIT, StepType.FINISH):
                issues.append(
                    f"Step '{step.step_name}' cannot be {step.step_type.value} "
                    "in the middle of a workflow"
                )

        return issues
