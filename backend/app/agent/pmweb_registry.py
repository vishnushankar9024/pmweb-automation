"""PMWeb deterministic command registry.

Every PMWeb module, record type, navigation path, UI element, and field
is defined here as pure data. No LLM guessing — all selectors and flows
come from the PMWeb 2025.1 User Guide.

Architecture:
  - MODULES: top-level sidebar modules (Plans, Forms, Costs, etc.)
  - RECORD_TYPES: each record type with its module, nav path, required
    fields, optional fields, detail table columns, and toolbar actions
  - NAV: deterministic navigation sequences
  - SHORTCUTS: keyboard shortcuts from the docs
  - TOOLBAR: standard toolbar button selectors
"""

from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class FieldDef:
    """A single field on a PMWeb record."""

    name: str
    field_type: str = "text"
    required: bool = False
    read_only: bool = False
    selector_id: str = ""
    selector_css: str = ""
    options: list[str] = field(default_factory=list)


@dataclass
class RecordType:
    """A PMWeb record type with its full field and navigation spec."""

    name: str
    module: str
    menu_item: str
    url_fragment: str = ""
    uses_iframe: bool = False
    iframe_id: str = ""
    header_fields: list[FieldDef] = field(default_factory=list)
    detail_columns: list[str] = field(default_factory=list)
    toolbar_actions: list[str] = field(default_factory=list)
    has_workflow: bool = True
    has_create_next: bool = False
    notes: str = ""


SHORTCUTS = {
    "home": "Ctrl+Alt+H",
    "search": "Ctrl+Alt+S",
    "recent": "Ctrl+Alt+R",
    "exit": "Ctrl+Alt+X",
    "help": "Ctrl+Alt+O",
    "profile": "Ctrl+Alt+P",
    "university": "Ctrl+Alt+U",
    "reminder": "Ctrl+Alt+E",
}

MODULES = {
    "Plans": {
        "sections": {
            "Portfolio Planning": ["Initiatives", "Portfolio Planning Worksheets", "Estimates"],
            "Procurement": ["Pre-Bid", "Bid Packages", "Online Bidding"],
            "Setup": ["Items", "Formulas", "Assemblies", "NDA"],
        },
    },
    "Forms": {
        "sections": {
            "Forms": [
                "Safety Forms", "RFIs", "Online Submittals", "Submittal Items",
                "Submittal Sets", "Meeting Minutes", "Drawing Lists", "Drawing Sets",
                "Daily Reports", "Inspections", "Punch Lists", "Transmittals",
                "Action Items", "Correspondence",
            ],
        },
    },
    "Costs": {
        "sections": {
            "Budgets": [
                "Cost Codes", "Budgets", "Cost Ledgers", "Forecasts",
                "Cost Worksheets", "Define Worksheets", "Budget Requests", "Journal Entries",
            ],
            "Funding": ["Funding Records", "Funding Requests", "Funding Authorizations"],
            "Contracts": ["Prime Contracts", "Master Commitments", "Commitments"],
            "Change Management": [
                "Online Change Requests", "Change Events", "Contract COs", "Commitment COs",
            ],
            "Invoices": ["Production", "Requisitions", "Miscellaneous Invoices", "Progress Invoices"],
            "Payments": ["A/R and A/P Payments", "A/R and A/P Payment Batches"],
        },
    },
    "Assets": {"sections": {}},
    "Schedules": {"sections": {}},
    "Portfolio": {"sections": {}},
    "Tools": {
        "sections": {
            "Security": ["Security Groups", "Users", "User Access", "Conditional Security"],
            "Workflows": ["Roles", "Business Processes", "Defaults", "APM Rules"],
            "Adaptive Forms": ["Adaptive Form Builder"],
            "Document Management": ["Document Manager"],
        },
    },
    "Workflows": {"sections": {}},
}

STANDARD_TOOLBAR = {
    "new_record": {
        "desc": "Create a new empty record",
        "selector": "button[title*='New'], button:has(> span:contains('New'))",
    },
    "save": {
        "desc": "Save unsaved changes",
        "selectors": [
            "button[title*='Save']",
            "span.k-button-text:contains('Save')",
            "button:has(> span:contains('Save'))",
        ],
    },
    "cancel": {
        "desc": "Undo unsaved changes",
        "selector": "button[title*='Cancel'], button:has(> span:contains('Cancel'))",
    },
    "submit": {
        "desc": "Submit record into workflow",
        "selector": "button[title*='Submit'], button:has(> span:contains('Submit'))",
    },
    "more": {
        "desc": "Open More dropdown",
        "selector": "button[title*='More'], button:has(> span:contains('More'))",
    },
    "print": {
        "desc": "Open print/report options",
        "selector": "button[title*='Print'], button:has(> span:contains('Print'))",
    },
    "new_line": {
        "desc": "Add new line to table",
        "selectors": [
            "button:has(> span:contains('New Line'))",
            "span:contains('New Line')",
        ],
    },
    "add_items": {
        "desc": "Open Add Items dialog",
        "selector": "button:has(> span:contains('Add Items')), button:has(> span:contains('Add Item'))",
    },
    "export_excel": {
        "desc": "Export table to Excel",
        "selector": "button[title*='Export'], button:has(> span:contains('Export'))",
    },
    "paste_excel": {
        "desc": "Paste from Excel clipboard",
        "selector": "button[title*='Paste'], button:has(> span:contains('Paste'))",
    },
    "delete": {
        "desc": "Delete selected lines",
        "selector": "button[title*='Delete'], button:has(> span:contains('Delete'))",
    },
}

STANDARD_TABLE_CONTROLS = {
    "group_by": "Group By field for table grouping",
    "layout": "Layout selector for saved grid layouts",
    "maximize": "Maximize/minimize table view",
    "column_settings": "Click More button in column header for filter/sort/show-hide",
    "sort": "Click column header to sort (asc → desc → none)",
    "resize": "Drag column header right edge to resize",
    "reorder": "Drag column header to reorder",
}

RECORD_TYPES: dict[str, RecordType] = {}


def _register(rt: RecordType) -> None:
    RECORD_TYPES[rt.name.lower()] = rt


# ── FORMS module ─────────────────────────────────────────────────────

_register(RecordType(
    name="Safety Forms",
    module="Forms",
    menu_item="Safety Forms",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"),
        FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Submitted By"), FieldDef("Company"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Reference"),
        FieldDef("Incident Date", field_type="date"), FieldDef("Incident Time", field_type="time"),
        FieldDef("Report Date", field_type="date"), FieldDef("Report Time", field_type="time"),
        FieldDef("Conditions", field_type="dropdown"),
        FieldDef("Temperature"), FieldDef("Temperature Scale", field_type="dropdown"),
        FieldDef("Precipitation Amount"), FieldDef("Precipitation UOM", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"), FieldDef("User Assigned"),
        FieldDef("User Due Date", field_type="date"),
    ],
    detail_columns=[
        "Work in Progress at Time", "Describe Incident",
        "People Involved", "Causes", "Witnesses",
    ],
    toolbar_actions=["new_record", "save", "cancel", "submit", "more", "print"],
))

_register(RecordType(
    name="RFIs",
    module="Forms",
    menu_item="RFIs",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("RFI #", required=True),
        FieldDef("Description"),
        FieldDef("Phase"), FieldDef("WBS"), FieldDef("Reference"),
        FieldDef("From"), FieldDef("To"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Trade"),
        FieldDef("CSI Code"), FieldDef("Task"),
        FieldDef("RFI Date", field_type="date"),
        FieldDef("Date Required", field_type="date"),
        FieldDef("Date Answered", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Priority", field_type="dropdown"),
        FieldDef("Affects Scope of Work", field_type="checkbox"),
        FieldDef("Affects Cost", field_type="checkbox"),
        FieldDef("Affects Schedule", field_type="checkbox"),
    ],
    detail_columns=["Question", "Proposed Solution", "Answer"],
))

_register(RecordType(
    name="Meeting Minutes",
    module="Forms",
    menu_item="Meeting Minutes",
    has_create_next=True,
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Meeting #", read_only=True),
        FieldDef("Description"),
        FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Location"),
        FieldDef("Meeting Date", field_type="date"),
        FieldDef("Started", field_type="time"), FieldDef("Ended", field_type="time"),
        FieldDef("Reference"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Next Meeting Location"), FieldDef("Next Meeting Date", field_type="date"),
    ],
    detail_columns=[
        "Item #", "Seq #", "Attachments", "Description", "Assigned To",
        "Category", "Subject", "Due", "Completed", "Status", "Task", "Notes", "Done",
    ],
))

_register(RecordType(
    name="Daily Reports",
    module="Forms",
    menu_item="Daily Reports",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Report Date", field_type="date"),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Submitted By"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Post to Non-commitment Costs", field_type="checkbox"),
        FieldDef("Conditions", field_type="dropdown"),
        FieldDef("Temperature"), FieldDef("Temperature Scale", field_type="dropdown"),
    ],
    detail_columns=[
        "Attachments", "Location", "Location Level", "Company",
        "Classification", "Quantity", "UOM", "Cost Code", "Description", "Notes",
    ],
    notes="Has Incidents section and Timesheet tab",
))

_register(RecordType(
    name="Inspections",
    module="Forms",
    menu_item="Inspections",
    header_fields=[
        FieldDef("Project"),
        FieldDef("Inspection ID", required=True),
        FieldDef("Description"),
        FieldDef("Type", required=True, field_type="dropdown"),
        FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Inspection Date", field_type="date"),
        FieldDef("Inspected By"),
        FieldDef("Inspection Point Color", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    notes="Type determines detail fields. Has Image Tab with clickable inspection points.",
))

_register(RecordType(
    name="Punch Lists",
    module="Forms",
    menu_item="Punch Lists",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Punch List #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Date", field_type="date"), FieldDef("Reference"),
        FieldDef("CSI Code"), FieldDef("From"), FieldDef("To"),
        FieldDef("Priority", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Description", "Location", "Trade",
        "Assigned To", "Issued Date", "Due Date", "Days Overdue",
        "Completed", "Cost", "Closed", "Notes",
    ],
))

_register(RecordType(
    name="Action Items",
    module="Forms",
    menu_item="Action Items",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Action Item #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Date", field_type="date", read_only=True),
        FieldDef("Priority", field_type="dropdown"), FieldDef("CSI Code"),
        FieldDef("User"), FieldDef("Reference"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=["Line #", "Attachments", "Description", "Assigned To", "Notes", "Done", "Due", "Completed"],
))

_register(RecordType(
    name="Correspondence",
    module="Forms",
    menu_item="Correspondence",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Correspondence #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Date", field_type="date"), FieldDef("Priority", field_type="dropdown"),
        FieldDef("CSI Code"), FieldDef("Reference"),
        FieldDef("From"), FieldDef("To"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=["Body (rich text)"],
))

_register(RecordType(
    name="Transmittals",
    module="Forms",
    menu_item="Transmittals",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Transmittal #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Date", field_type="date"), FieldDef("Category", field_type="dropdown"),
        FieldDef("From"), FieldDef("To"), FieldDef("Address"),
        FieldDef("Quantity"), FieldDef("Due Date", field_type="date"),
        FieldDef("Reference"), FieldDef("Shipped Date", field_type="date"),
        FieldDef("Via"), FieldDef("Tracking #"),
        FieldDef("Comment"), FieldDef("Remarks", field_type="multiselect"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Link", "Set #", "Description",
        "Status", "Revision", "Date", "Type", "Quantity",
    ],
))

# ── PLANS module ─────────────────────────────────────────────────────

_register(RecordType(
    name="Initiatives",
    module="Plans",
    menu_item="Initiatives",
    header_fields=[
        FieldDef("Initiative ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Program"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Abbreviation"), FieldDef("Status", field_type="dropdown"),
        FieldDef("Location"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("PBS"), FieldDef("Funding Year"),
        FieldDef("Priority", field_type="dropdown"),
        FieldDef("Start", field_type="date"), FieldDef("Finish", field_type="date"),
        FieldDef("Sponsor"), FieldDef("Funding Source"),
        FieldDef("Project Manager"), FieldDef("Scope", field_type="textarea"),
    ],
    detail_columns=[
        "Line #", "Assembly", "Attachments", "Item", "Resource", "Description",
        "Currency", "UOM", "Quantity", "Unit Cost", "Ext. Cost", "Total Cost",
        "Cost Type", "Cost Code", "Funding Source", "Company", "Period", "Year", "Task", "Notes",
    ],
))

_register(RecordType(
    name="Estimates",
    module="Plans",
    menu_item="Estimates",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Description"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Estimate Unit of Measure"), FieldDef("Estimate Units"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Assembly", "Attachments", "Item", "BIM ID", "Resource",
        "Description", "Currency", "UOM", "Quantity", "Unit Cost", "Ext. Cost",
        "Total Cost", "Cost Type", "Cost Code", "Funding Source", "Company",
        "Period", "Year", "Task", "Notes",
    ],
))

_register(RecordType(
    name="Bid Packages",
    module="Plans",
    menu_item="Bid Packages",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("Project", required=True),
        FieldDef("Procurement #", required=True),
        FieldDef("Description"), FieldDef("Bid Category", field_type="dropdown"),
        FieldDef("Bidding Company"), FieldDef("Bidding Contact"),
        FieldDef("Commitment Type", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Bids Due", field_type="date"),
    ],
    detail_columns=[
        "Award", "Company", "Invitation Status", "Best Bid", "NDA",
        "Bid Revision", "Bid Status", "Bid Total", "Leveled Total",
    ],
    notes="Has Bid Items, Bid RFIs, Clauses, and Manage Bids tabs",
))

# ── COSTS module ─────────────────────────────────────────────────────

_register(RecordType(
    name="Budgets",
    module="Costs",
    menu_item="Budgets",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Description"), FieldDef("WBS"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Cashflow", "Attachments", "Cost Code", "Group 1",
        "Description", "Currency", "UOM", "Quantity", "Unit Price",
        "Owner Budget", "Unit Cost", "Adjustments", "Project Budget",
        "Cost Type", "Funding", "Company", "Task", "Period", "Notes",
    ],
    notes="One Approved Budget per project; each cost code unique within a Budget",
))

_register(RecordType(
    name="Commitments",
    module="Costs",
    menu_item="Commitments",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Company"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown", options=["Purchase Order", "Subcontract"]),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("WBS"), FieldDef("Expiration Date", field_type="date"),
        FieldDef("Days"), FieldDef("Status", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
        FieldDef("Paid in Full", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Item", "Description", "UOM", "Quantity",
        "Unit Cost", "Currency", "Ext. Cost", "Adjustments", "Total Cost",
        "Cost Type", "Cost Code", "Period", "Phase", "WBS", "Location",
        "Funding", "Notes", "Task",
    ],
    has_create_next=False,
    notes="Generate from Bid Packages. Has Change Order and Progress Invoices tabs.",
))

_register(RecordType(
    name="Prime Contracts",
    module="Costs",
    menu_item="Prime Contracts",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Company"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("WBS"), FieldDef("Effective Date", field_type="date"),
        FieldDef("Days"), FieldDef("Status", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Item", "Description", "Currency",
        "Cost Code", "UOM", "Quantity", "Unit Cost", "Total Cost", "Total Price",
        "Task", "Period", "Notes", "Req. Code",
    ],
    notes="Has Change Orders, Requisitions, and Payments tabs",
))

_register(RecordType(
    name="Progress Invoices",
    module="Costs",
    menu_item="Progress Invoices",
    has_create_next=True,
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Commitment", required=True),
        FieldDef("Company", read_only=True),
        FieldDef("Invoice #", read_only=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Cost Period"), FieldDef("WBS"),
        FieldDef("Invoice Date", field_type="date"),
        FieldDef("Billing Terms"), FieldDef("Invoice Due", field_type="date"),
        FieldDef("Invoice Type", field_type="dropdown", options=["Final", "Progress"]),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Paid in Full", field_type="checkbox"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Cost Code", "Description", "Currency", "UOM",
        "Scheduled Quantity", "Current Quantity", "Prior Quantity", "Unit Cost",
        "Total Quantity", "Scheduled Value", "% Complete", "Current Invoice",
        "Total Invoiced", "Balance to Invoice",
    ],
))

_register(RecordType(
    name="Journal Entries",
    module="Costs",
    menu_item="Journal Entries",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("WBS"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Net Amount", read_only=True),
    ],
    detail_columns=[
        "Line #", "Attachments", "Project", "Cost Code", "Description",
        "Currency", "Total Amount", "Worksheet Column", "Period", "Req. Code", "Notes",
    ],
    notes="Worksheet column directly selectable per line. Can affect multiple projects.",
))

# ── TOOLS / SECURITY ─────────────────────────────────────────────────

_register(RecordType(
    name="Security Groups",
    module="Tools",
    menu_item="Security",
    url_fragment="/Security.aspx",
    uses_iframe=True,
    iframe_id="ctl00_CPH1_ngFrame",
    header_fields=[
        FieldDef("Group ID", required=True, selector_css="kendo-textbox input.k-input-inner:nth-of-type(1)"),
        FieldDef("Description", required=True, selector_css="kendo-textbox input.k-input-inner:nth-of-type(2)"),
    ],
    toolbar_actions=["new_group", "save", "cancel"],
    notes="Inside iframe. Tabs: Groups, Users, User Access, Conditional Security. "
          "The first textbox is Group ID, followed by Description. "
          "Options grid (checkboxes), Module permissions grid (View/Create/Edit/Delete/Full Control).",
))

_register(RecordType(
    name="Users",
    module="Tools",
    menu_item="Security",
    url_fragment="/Security.aspx",
    uses_iframe=True,
    iframe_id="ctl00_CPH1_ngFrame",
    header_fields=[
        FieldDef("User ID", required=True),
        FieldDef("First Name"), FieldDef("Last Name"),
        FieldDef("License Type", field_type="dropdown", options=["Full", "View"]),
        FieldDef("Named License", field_type="dropdown", options=["Named", "Concurrent"]),
        FieldDef("Group", field_type="dropdown"),
        FieldDef("Password"), FieldDef("Email"),
    ],
    toolbar_actions=["new_line", "save", "cancel"],
    notes="Grid-based editing inside Security iframe, Users tab.",
))


def get_record_type(name: str) -> RecordType | None:
    """Look up a record type by name (case-insensitive)."""
    return RECORD_TYPES.get(name.lower())


def get_required_fields(record_name: str) -> list[str]:
    """Return list of required field names for a record type."""
    rt = get_record_type(record_name)
    if not rt:
        return []
    return [f.name for f in rt.header_fields if f.required]


def get_all_fields(record_name: str) -> list[FieldDef]:
    """Return all field definitions for a record type."""
    rt = get_record_type(record_name)
    return rt.header_fields if rt else []


def list_record_types() -> list[str]:
    """Return all registered record type names."""
    return [rt.name for rt in RECORD_TYPES.values()]


def list_modules() -> list[str]:
    """Return all module names."""
    return list(MODULES.keys())


def get_module_record_types(module: str) -> list[str]:
    """Return record type names for a module."""
    mod = MODULES.get(module, {})
    types = []
    for section_types in mod.get("sections", {}).values():
        types.extend(section_types)
    return types
