"""OpenAI function-calling tool definitions for PMWeb operations."""

from __future__ import annotations

TOOLS: list[dict] = [
    {
        "type": "function",
        "function": {
            "name": "create_security_group",
            "description": (
                "Create a new security group in PMWeb. Opens Security "
                "page visibly, fills in name/description, enables "
                "option checkboxes, and saves."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "group_name": {
                        "type": "string",
                        "description": "Required. Group name.",
                    },
                    "description": {
                        "type": "string",
                        "description": "Required. Group description.",
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
                        "description": "Option checkboxes to enable",
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
                "Create a new user in PMWeb. Opens Security → Users "
                "tab visibly, adds a new line, fills all fields, "
                "and saves."
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
                    "last_name": {"type": "string"},
                    "email": {"type": "string"},
                    "license_type": {
                        "type": "string",
                        "enum": ["Full", "Guest"],
                        "description": "Default: Full",
                    },
                    "named_license": {
                        "type": "string",
                        "enum": ["Named", "Concurrent"],
                        "description": "Default: Named",
                    },
                    "group_name": {
                        "type": "string",
                        "description": "Required. Existing group name.",
                    },
                    "password": {"type": "string"},
                    "pmweb_admin": {"type": "boolean"},
                },
                "required": ["user_id", "first_name", "group_name"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "create_adaptive_form",
            "description": (
                "Create a new Adaptive Form in PMWeb. Opens the "
                "Adaptive Form Builder visibly, sets the title, "
                "adds custom fields, and saves. The form appears "
                "under Tools → Adaptive Forms."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "form_name": {
                        "type": "string",
                        "description": "Required. Form title/name.",
                    },
                    "fields": {
                        "type": "array",
                        "description": "Custom fields to add.",
                        "items": {
                            "type": "object",
                            "properties": {
                                "label": {
                                    "type": "string",
                                    "description": "Field label",
                                },
                                "type": {
                                    "type": "string",
                                    "enum": [
                                        "text",
                                        "number",
                                        "date",
                                        "dropdown",
                                        "checkbox",
                                        "comment",
                                        "rating",
                                        "boolean",
                                    ],
                                    "description": (
                                        "Field type. Default: text"
                                    ),
                                },
                                "required": {
                                    "type": "boolean",
                                    "description": "Is field required",
                                },
                                "choices": {
                                    "type": "array",
                                    "items": {"type": "string"},
                                    "description": (
                                        "Options for dropdown fields"
                                    ),
                                },
                            },
                            "required": ["label"],
                        },
                    },
                },
                "required": ["form_name"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "navigate_pmweb",
            "description": (
                "Navigate to a specific PMWeb page or module. "
                "Opens the page visibly so the user can see it."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "destination": {
                        "type": "string",
                        "enum": [
                            "home",
                            "security",
                            "adaptive_forms",
                            "workflows",
                            "settings",
                            "plans",
                            "forms",
                            "costs",
                            "schedules",
                            "assets",
                            "portfolio",
                            "tools",
                        ],
                        "description": "Where to navigate",
                    },
                },
                "required": ["destination"],
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
                        "description": "Record types to associate",
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
]
