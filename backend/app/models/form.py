from __future__ import annotations

from enum import Enum

from pydantic import BaseModel, Field


class FieldDataType(str, Enum):
    TEXT = "Text"
    NUMBER = "Number"
    CURRENCY = "Currency"
    DATE = "Date"
    DROPDOWN = "Dropdown"
    CHECKBOX = "Checkbox"
    TEXTAREA = "Text Area"
    ATTACHMENT = "Attachment"


class CustomField(BaseModel):
    label: str = Field(..., description="Required. Field label.")
    data_type: FieldDataType = FieldDataType.TEXT
    is_required: bool = False
    default_value: str = ""
    width_px: int = Field(200, ge=50, le=1000)
    dropdown_options: list[str] | None = None


class FormPermission(BaseModel):
    group_name: str
    can_view: bool = True
    can_edit: bool = False


class FormModule(str, Enum):
    TOOLS = "Tools"
    FORMS = "Forms"
    COSTS = "Costs"
    PLANS = "Plans"
    ASSETS = "Assets"


class ClassicForm(BaseModel):
    """A PMWeb Classic Form Builder form."""

    form_id: str = Field(
        ..., description="Required. Alphanumeric form ID."
    )
    form_name: str = Field(..., description="Required. Form display name.")
    module: FormModule = Field(
        FormModule.TOOLS,
        description="Module menu where the form resides",
    )
    use_with: str = Field(
        "Both",
        description="Initiatives, Projects, or Both",
    )
    custom_fields: list[CustomField] = Field(default_factory=list)
    permissions: list[FormPermission] = Field(default_factory=list)
    enable_workflow: bool = False
