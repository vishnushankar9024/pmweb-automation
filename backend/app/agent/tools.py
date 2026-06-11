"""OpenAI function-calling tool definitions for real PMWeb actions."""

from __future__ import annotations

TOOLS: list[dict] = [
    {
        "type": "function",
        "function": {
            "name": "create_security_group",
            "description": (
                "Create a new security group in PMWeb. Opens the Security "
                "page, clicks New Group, fills in name/description, "
                "enables option checkboxes, and saves."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "group_name": {
                        "type": "string",
                        "description": "Required. Name for the group.",
                    },
                    "description": {
                        "type": "string",
                        "description": "Required. Description of the group.",
                    },
                    "options": {
                        "type": "array",
                        "items": {
                            "type": "string",
                            "enum": [
                                "Default Group",
                                "Guest Users",
                                "Adaptive Form Administrator",
                                "Can change Due Date in Procurement",
                                "Can Copy Project",
                                "Can Edit WBS In Program",
                                "Can Edit WBS In Project",
                                "Can Execute Move",
                                "Can Lock/Unlock Schedules",
                                "Can Make Vendors Active/Inactive",
                                "Can Make Locations Active/Inactive",
                                "Can Make Projects Active/Inactive",
                                "Can Send Notifications",
                                "Custom Form Administrator",
                                "Document Manager Administrator",
                                "Events Administrator",
                                "Lease Administrator",
                                "PMWeb Report Administrator",
                                "Procurement Administrator",
                                "Report Manager Administrator",
                            ],
                        },
                        "description": (
                            "Option checkboxes to enable for this group"
                        ),
                    },
                },
                "required": ["group_name", "description"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_user",
            "description": (
                "Create a new user in PMWeb. Opens the Security page, "
                "clicks the Users tab, adds a new line, fills in all "
                "fields, and saves."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "user_id": {
                        "type": "string",
                        "description": "Required. Alphanumeric user ID.",
                    },
                    "first_name": {
                        "type": "string",
                        "description": "Required. First name.",
                    },
                    "last_name": {
                        "type": "string",
                        "description": "Last name.",
                    },
                    "email": {
                        "type": "string",
                        "description": "Email address.",
                    },
                    "license_type": {
                        "type": "string",
                        "enum": ["Full", "Guest"],
                        "description": "License type. Default: Full.",
                    },
                    "named_license": {
                        "type": "string",
                        "enum": ["Named", "Concurrent"],
                        "description": "Named or Concurrent. Default: Named.",
                    },
                    "group_name": {
                        "type": "string",
                        "description": (
                            "Required. Security group name "
                            "(must match an existing group)."
                        ),
                    },
                    "password": {
                        "type": "string",
                        "description": "Initial password.",
                    },
                    "pmweb_admin": {
                        "type": "boolean",
                        "description": "Allow editing Security permissions.",
                    },
                },
                "required": ["user_id", "first_name", "group_name"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_workflow",
            "description": (
                "Create a Business Process (BPM) workflow in PMWeb. "
                "Workflows must start with Submit and end with Finish."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "bpm_id": {
                        "type": "string",
                        "description": "Required. BPM identifier.",
                    },
                    "description": {"type": "string"},
                    "associate_with": {
                        "type": "array",
                        "items": {"type": "string"},
                        "description": (
                            "Record types: RFI, Change Order, Invoice, etc."
                        ),
                    },
                    "steps": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "step_name": {"type": "string"},
                                "step_type": {
                                    "type": "string",
                                    "enum": [
                                        "submit",
                                        "step",
                                        "branch",
                                        "finish",
                                    ],
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
                            "required": [
                                "step_name",
                                "step_type",
                                "order",
                            ],
                        },
                    },
                },
                "required": ["bpm_id", "steps"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_form",
            "description": (
                "Create a custom form using Classic Form Builder in PMWeb."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "form_id": {
                        "type": "string",
                        "description": "Required. Alphanumeric form ID.",
                    },
                    "form_name": {
                        "type": "string",
                        "description": "Required. Form display name.",
                    },
                    "module": {
                        "type": "string",
                        "enum": [
                            "Tools",
                            "Forms",
                            "Costs",
                            "Plans",
                            "Assets",
                        ],
                        "description": "Module menu. Default: Tools.",
                    },
                    "custom_fields": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "label": {"type": "string"},
                                "data_type": {
                                    "type": "string",
                                    "enum": [
                                        "Text",
                                        "Number",
                                        "Currency",
                                        "Date",
                                        "Dropdown",
                                        "Checkbox",
                                        "Text Area",
                                    ],
                                },
                                "is_required": {"type": "boolean"},
                                "default_value": {"type": "string"},
                            },
                            "required": ["label", "data_type"],
                        },
                    },
                    "permissions": {
                        "type": "array",
                        "items": {
                            "type": "object",
                            "properties": {
                                "group_name": {"type": "string"},
                                "can_view": {"type": "boolean"},
                                "can_edit": {"type": "boolean"},
                            },
                            "required": ["group_name"],
                        },
                    },
                },
                "required": ["form_id", "form_name"],
            },
        },
    },
]
