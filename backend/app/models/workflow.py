from __future__ import annotations

from enum import Enum

from pydantic import BaseModel, Field


class StepType(str, Enum):
    SUBMIT = "submit"
    STEP = "step"
    BRANCH = "branch"
    FINISH = "finish"


class WorkflowStep(BaseModel):
    step_name: str
    step_type: StepType
    order: int = Field(..., ge=1)
    assigned_roles: list[str] = Field(default_factory=list)
    review_days: int = Field(3, ge=1)
    all_must_approve: bool = False
    require_comments: bool = False
    allow_delegation: bool = True
    instructions: str = ""


class BusinessProcess(BaseModel):
    """A PMWeb Business Process (BPM) — the real name for workflows."""

    bpm_id: str = Field(
        ..., description="Required. Alphanumeric BPM ID."
    )
    description: str = ""
    associate_with: list[str] = Field(
        default_factory=list,
        description="Record types this BPM applies to (e.g. RFI, "
        "Change Order, Invoice)",
    )
    recalculate_due_dates: bool = False
    steps: list[WorkflowStep] = Field(default_factory=list)

    def validate_structure(self) -> list[str]:
        """Return validation issues, empty if valid."""
        issues: list[str] = []
        if not self.steps:
            issues.append("BPM must have at least one step")
            return issues
        sorted_steps = sorted(self.steps, key=lambda s: s.order)
        if sorted_steps[0].step_type != StepType.SUBMIT:
            issues.append("First step must be Submit")
        if sorted_steps[-1].step_type != StepType.FINISH:
            issues.append("Last step must be Finish")
        for step in sorted_steps[1:-1]:
            if step.step_type in (StepType.SUBMIT, StepType.FINISH):
                issues.append(
                    f"Step '{step.step_name}' cannot be "
                    f"{step.step_type.value} in the middle"
                )
        return issues
