"""OpenAI function-calling tool definitions for PMWeb actions."""

from __future__ import annotations

TOOLS: list[dict] = [
    {
        "type": "function",
        "function": {
            "name": "create_security_group",
            "description": "Create a new security group in PMWeb for organizing user permissions",
            "parameters": {
                "type": "object",
                "properties": {
                    "group_id": {
                        "type": "string",
                        "description": (
                            "Unique identifier for the group "
                            "(e.g. 'PM_TEAM', 'CONTRACTORS')"
                        ),
                    },
                    "description": {
                        "type": "string",
                        "description": "Human-readable description of the group's purpose",
                    },
                },
                "required": ["group_id", "description"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_user",
            "description": "Create a new user account in PMWeb",
            "parameters": {
                "type": "object",
                "properties": {
                    "username": {"type": "string"},
                    "email": {"type": "string", "description": "User email address"},
                    "first_name": {"type": "string"},
                    "last_name": {"type": "string"},
                    "groups": {
                        "type": "array",
                        "items": {"type": "string"},
                        "description": "Security group IDs to assign",
                    },
                },
                "required": ["username", "email", "first_name", "last_name"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "set_password_policy",
            "description": "Configure the password policy for PMWeb",
            "parameters": {
                "type": "object",
                "properties": {
                    "min_length": {"type": "integer", "description": "Minimum password length"},
                    "require_uppercase": {"type": "boolean"},
                    "require_lowercase": {"type": "boolean"},
                    "require_numbers": {"type": "boolean"},
                    "require_special_chars": {"type": "boolean"},
                    "expiry_days": {
                        "type": "integer",
                        "description": "Password expiry in days (0 = no expiry)",
                    },
                    "max_failed_attempts": {"type": "integer"},
                },
                "required": ["min_length"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_workflow",
            "description": "Create a new visual workflow in PMWeb with approval/review steps",
            "parameters": {
                "type": "object",
                "properties": {
                    "workflow_name": {"type": "string"},
                    "description": {"type": "string"},
                    "record_type": {
                        "type": "string",
                        "description": "PMWeb record type (e.g. 'Change Order', 'RFI', 'Invoice')",
                    },
                    "steps": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "step_name": {"type": "string"},
                                "step_type": {
                                    "type": "string",
                                    "enum": ["submit", "approval", "review", "branch", "finish"],
                                },
                                "order": {"type": "integer"},
                                "assigned_roles": {
                                    "type": "array",
                                    "items": {"type": "string"},
                                },
                                "review_days": {"type": "integer"},
                                "all_must_approve": {"type": "boolean"},
                                "require_comments": {"type": "boolean"},
                                "instructions": {"type": "string"},
                            },
                            "required": ["step_name", "step_type", "order"],
                        },
                    },
                },
                "required": ["workflow_name", "record_type", "steps"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_form",
            "description": "Create a custom form in PMWeb with fields and permissions",
            "parameters": {
                "type": "object",
                "properties": {
                    "form_name": {"type": "string"},
                    "description": {"type": "string"},
                    "category": {"type": "string", "description": "Form category"},
                    "fields": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "field_name": {"type": "string"},
                                "label": {"type": "string"},
                                "field_type": {
                                    "type": "string",
                                    "enum": [
                                        "text", "number", "currency", "date",
                                        "dropdown", "checkbox", "textarea",
                                        "attachment", "calculated",
                                    ],
                                },
                                "is_required": {"type": "boolean"},
                                "default_value": {"type": "string"},
                                "dropdown_options": {
                                    "type": "array",
                                    "items": {"type": "string"},
                                },
                            },
                            "required": ["field_name", "label", "field_type"],
                        },
                    },
                    "enable_workflow": {"type": "boolean"},
                    "workflow_name": {"type": "string"},
                    "permissions": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "group_id": {"type": "string"},
                                "can_view": {"type": "boolean"},
                                "can_add": {"type": "boolean"},
                                "can_edit": {"type": "boolean"},
                                "can_delete": {"type": "boolean"},
                            },
                            "required": ["group_id"],
                        },
                    },
                },
                "required": ["form_name", "fields"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "set_user_access",
            "description": "Configure module and project access for a user",
            "parameters": {
                "type": "object",
                "properties": {
                    "username": {"type": "string"},
                    "project_access": {
                        "type": "array",
                        "items": {"type": "string"},
                        "description": "Project names/IDs user can access",
                    },
                    "module_access": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "module_name": {"type": "string"},
                                "access_level": {
                                    "type": "string",
                                    "enum": [
                                        "no_access", "view_only", "add",
                                        "edit", "delete", "full",
                                    ],
                                },
                            },
                            "required": ["module_name", "access_level"],
                        },
                    },
                },
                "required": ["username"],
            },
        },
    },
]
