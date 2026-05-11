from __future__ import annotations

from enum import Enum

from pydantic import BaseModel, Field


class AccessLevel(str, Enum):
    NO_ACCESS = "no_access"
    VIEW_ONLY = "view_only"
    ADD = "add"
    EDIT = "edit"
    DELETE = "delete"
    FULL = "full"


class SecurityGroup(BaseModel):
    group_id: str = Field(..., description="Unique group identifier")
    description: str = Field("", description="Group description")
    is_active: bool = True


class UserAccount(BaseModel):
    username: str
    email: str
    first_name: str = ""
    last_name: str = ""
    groups: list[str] = Field(default_factory=list, description="Group IDs this user belongs to")
    is_active: bool = True


class ModuleAccess(BaseModel):
    module_name: str
    access_level: AccessLevel = AccessLevel.NO_ACCESS


class UserAccess(BaseModel):
    username: str
    project_access: list[str] = Field(
        default_factory=list, description="Projects the user can access"
    )
    module_access: list[ModuleAccess] = Field(default_factory=list)


class PasswordPolicy(BaseModel):
    min_length: int = Field(8, ge=4, le=128)
    require_uppercase: bool = True
    require_lowercase: bool = True
    require_numbers: bool = True
    require_special_chars: bool = False
    expiry_days: int = Field(90, ge=0, description="0 means no expiry")
    max_failed_attempts: int = Field(5, ge=1)


class SecurityConfig(BaseModel):
    """Complete security configuration for a PMWeb setup."""

    groups: list[SecurityGroup] = Field(default_factory=list)
    users: list[UserAccount] = Field(default_factory=list)
    user_access: list[UserAccess] = Field(default_factory=list)
    password_policy: PasswordPolicy = Field(default_factory=PasswordPolicy)
