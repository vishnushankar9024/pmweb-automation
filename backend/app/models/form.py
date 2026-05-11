from __future__ import annotations

from enum import Enum

from pydantic import BaseModel, Field


class FieldType(str, Enum):
    TEXT = "text"
    NUMBER = "number"
    CURRENCY = "currency"
    DATE = "date"
    DROPDOWN = "dropdown"
    CHECKBOX = "checkbox"
    TEXTAREA = "textarea"
    ATTACHMENT = "attachment"
    CALCULATED = "calculated"


class FormField(BaseModel):
    field_name: str
    label: str
    field_type: FieldType = FieldType.TEXT
    is_required: bool = False
    default_value: str | None = None
    width_px: int = Field(200, ge=50, le=1000)
    display_order: int = Field(1, ge=1)
    dropdown_options: list[str] | None = Field(
        None, description="Only for dropdown fields"
    )
    calculation_formula: str | None = Field(
        None, description="Only for calculated fields"
    )


class FormPermission(BaseModel):
    group_id: str
    can_view: bool = True
    can_add: bool = False
    can_edit: bool = False
    can_delete: bool = False


class FormDefinition(BaseModel):
    form_name: str
    description: str = ""
    category: str = Field("Custom", description="Form category in PMWeb")
    fields: list[FormField] = Field(default_factory=list)
    permissions: list[FormPermission] = Field(default_factory=list)
    enable_attachments: bool = True
    enable_notes: bool = True
    enable_workflow: bool = False
    workflow_name: str | None = None
