from __future__ import annotations

from enum import Enum

from pydantic import BaseModel, Field


class GroupOption(str, Enum):
    DEFAULT_GROUP = "Default Group"
    GUEST_USERS = "Guest Users"
    ADAPTIVE_FORM_ADMIN = "Adaptive Form Administrator"
    CAN_CHANGE_DUE_DATE = "Can change Due Date in Procurement"
    CAN_COPY_PROJECT = "Can Copy Project"
    CAN_EDIT_WBS_PROGRAM = "Can Edit WBS In Program"
    CAN_EDIT_WBS_PROJECT = "Can Edit WBS In Project"
    CAN_EXECUTE_MOVE = "Can Execute Move"
    CAN_LOCK_SCHEDULES = "Can Lock/Unlock Schedules"
    CAN_MAKE_VENDORS_ACTIVE = "Can Make Vendors Active/Inactive"
    CAN_MAKE_LOCATIONS_ACTIVE = "Can Make Locations Active/Inactive"
    CAN_MAKE_PROJECTS_ACTIVE = "Can Make Projects Active/Inactive"
    CAN_SEND_NOTIFICATIONS = "Can Send Notifications"
    CUSTOM_FORM_ADMIN = "Custom Form Administrator"
    DOC_MANAGER_ADMIN = "Document Manager Administrator"
    EVENTS_ADMIN = "Events Administrator"
    LEASE_ADMIN = "Lease Administrator"
    PMWEB_REPORT_ADMIN = "PMWeb Report Administrator"
    PROCUREMENT_ADMIN = "Procurement Administrator"
    REPORT_MANAGER_ADMIN = "Report Manager Administrator"


class ModulePermission(str, Enum):
    VIEW = "View"
    CREATE = "Create"
    EDIT = "Edit"
    DELETE = "Delete"
    FULL_CONTROL = "Full Control"


class ModuleAccess(BaseModel):
    module_name: str = Field(
        ...,
        description="PMWeb module: Assets, Costs, Forms, Plans, "
        "Portfolio, Schedules, Tools, Workflows",
    )
    permissions: list[ModulePermission] = Field(default_factory=list)


class SecurityGroup(BaseModel):
    group_name: str = Field(..., description="Required. Group name.")
    description: str = Field(..., description="Required. Group description.")
    options: list[GroupOption] = Field(
        default_factory=list,
        description="Group option checkboxes to enable",
    )
    module_access: list[ModuleAccess] = Field(
        default_factory=list,
        description="Module-level permissions to set",
    )


class LicenseType(str, Enum):
    FULL = "Full"
    GUEST = "Guest"


class NamedLicense(str, Enum):
    NAMED = "Named"
    CONCURRENT = "Concurrent"


class UserAccount(BaseModel):
    user_id: str = Field(..., description="Required. Alphanumeric user ID.")
    first_name: str = Field(..., description="Required. User first name.")
    last_name: str = Field("", description="User last name.")
    email: str = Field("", description="User email address.")
    license_type: LicenseType = Field(
        LicenseType.FULL, description="Full or Guest"
    )
    named_license: NamedLicense = Field(
        NamedLicense.NAMED, description="Named or Concurrent"
    )
    group_name: str = Field(
        ..., description="Required. Security group to assign."
    )
    password: str = Field("Welcome1!", description="Initial password.")
    pmweb_admin: bool = Field(
        False, description="Allow editing Security permissions"
    )
    inactive: bool = False


class PasswordPolicy(BaseModel):
    min_length: int = Field(8, ge=4, le=128)
    require_uppercase: bool = True
    require_lowercase: bool = True
    require_numbers: bool = True
    require_special_chars: bool = False
    expiry_days: int = Field(90, ge=0)
    max_failed_attempts: int = Field(5, ge=1)
