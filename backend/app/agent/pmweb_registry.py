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
    "manager_page": "Ctrl+Alt+M",
}

STANDARD_RECORD_TABS = [
    "Main", "Adjustments", "Specifications", "Checklists", "Scoring",
    "Ratings", "Notes", "Attachments", "Clauses", "Workflow",
    "Collaborate", "Notifications", "Components", "Payments",
]

HEADER_TOOLBAR_SECTIONS = {
    "navigation": ["Manager Page", "Recent Records", "Tree Page", "Record Selector"],
    "save_add_delete": ["Save Record", "Add Record", "Delete Record"],
    "output": ["Notifications", "Print"],
    "other": ["Submit", "Assign", "Generate"],
}

DETAILS_TOOLBAR_BUTTONS = [
    "Edit Line", "Add Line", "Add Items", "Add Assembly",
    "Add Resources", "Delete Line", "Refresh", "Use Units", "Preview Conversion",
]

DIALOG_TOOLBAR_BUTTONS = ["Cancel", "Delete", "OK", "Save & Exit", "Save"]

WORKFLOW_ACTIONS = ["Submit", "Approve", "Final Approve", "Reject", "Return", "Withdraw", "Delegate", "Comment"]

ADMIN_UTILITY_TABS = [
    "General Settings", "Integrations", "Interface", "Login",
    "Language Manager", "License", "SQL Command", "Email Settings", "SSRS",
]

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
    "Assets": {
        "sections": {
            "Assets": ["Locations", "Buildings", "Floors", "Spaces", "Equipment", "Inventory Locations"],
            "Maintenance": ["Work Orders", "Dispatch Board", "Map View", "Maintenance Contracts"],
            "Leasing": ["Suites", "Leases", "Lease Administrator", "Tenant Invoices"],
            "Space Management": ["Assets Search", "Move Plans", "Reservation Requests", "Shared Assets"],
            "Setup": ["Configure Dispatch Boards", "Lease Charges", "Location Programs"],
        },
    },
    "Schedules": {
        "sections": {
            "Schedules": ["Schedules", "PPM", "Resources Availability"],
            "Setup": ["Link Setup", "Project Codes", "Calendars"],
        },
    },
    "Portfolio": {
        "sections": {
            "Records": [
                "Programs", "Projects", "Work Requests", "Companies",
                "Labor Resources", "Equipment Resources", "Email Home", "PMWeb Calendar",
            ],
            "Reports": ["Search", "Portfolio View", "BI Reporting Center", "PMWeb Reporting Center", "Issues", "Document Log", "Audit Trail"],
            "Administer": [
                "Settings", "Security", "Items", "Currency", "Close-Open Periods",
                "PMWeb Word", "Email Setup", "Message Templates", "Generating",
                "Calendar Setup", "Event Center", "Define Reminders", "Define Report Schedules",
            ],
            "Define": [
                "WBS", "PBS", "Distribution Lists", "Selection Lists", "Periods",
                "Specifications", "User Defined Fields", "Checklists", "Adjustments",
                "Adjustment Groups", "Scoring", "Clauses", "Pay Types",
                "Classification Matrix", "CPI", "Inspection Types", "Profile",
            ],
        },
    },
    "Tools": {
        "sections": {
            "Activity Boards": ["Activity Boards"],
            "Timesheets": ["Timesheets"],
            "Risk Analysis": ["Risk Analysis"],
            "Form Builders": ["Adaptive Forms", "Classic Form Builder"],
            "Vendor Prequal": ["Vendor Prequal Designer", "Vendor Prequal Records"],
            "Stage Gates": ["Stage Gates", "Stage Gates Setup"],
            "Document Manager": ["Document Manager"],
            "Integrations": ["Integration Manager", "Document Integrator", "LDAP Integration", "Bluebeam Markups"],
            "Resource Management": ["Requirements", "Org Chart"],
            "BIM": ["Model Manager", "COBie Manager"],
        },
    },
    "Workflows": {
        "sections": {
            "Workflows": ["Inbox", "Business Processes", "Role Manager", "Email Templates", "Workflow Calendars"],
        },
    },
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


# ── PLANS — remaining record types ───────────────────────────────

_register(RecordType(
    name="Portfolio Planning Worksheets",
    module="Plans",
    menu_item="Portfolio Planning Worksheets",
    header_fields=[
        FieldDef("Plan Year", required=True),
        FieldDef("Program", required=True),
        FieldDef("Portfolio Name"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=[
        "Line #", "Fund", "Initiatives", "Initiative ID", "Funding Year",
        "Funding Source", "Project Manager", "Currency", "Type", "Total",
        "Start", "Finish", "Priority", "Score", "Rating", "Sponsor", "Notes",
    ],
    notes="Has Copy Record, Generate Project Records. Year columns in From/To range.",
))

_register(RecordType(
    name="Pre-Bid",
    module="Plans",
    menu_item="Pre-Bid",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Pre-bid #", required=True),
        FieldDef("Description"),
        FieldDef("Bid Category", field_type="dropdown"),
        FieldDef("Bidding Company"), FieldDef("Bidding Contact"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Bids Due Date", field_type="date"),
        FieldDef("Bids Due Time", field_type="time"),
        FieldDef("Commitment Type", field_type="dropdown"),
    ],
    detail_columns=["Bid Category", "Company", "Notes", "Inactive"],
    notes="Has Bid Items tab. Generate procurement records from here.",
))

_register(RecordType(
    name="Online Bidding",
    module="Plans",
    menu_item="Online Bidding",
    header_fields=[
        FieldDef("Program", read_only=True),
        FieldDef("Project", read_only=True),
        FieldDef("Bid #", read_only=True),
        FieldDef("Procurement #", read_only=True),
        FieldDef("Description"),
        FieldDef("Bid Category", read_only=True),
        FieldDef("Currency", read_only=True),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Bids Due", field_type="date", read_only=True),
        FieldDef("Company", read_only=True),
    ],
    detail_columns=[
        "Line #", "Project", "Item", "Description", "Currency", "Scope of Work",
        "Manufacturer", "Mfr #", "UOM", "Est. Quantity", "Bid Quantity",
        "Unit Price", "Total Amount", "Leveled Total", "Days", "Notes",
    ],
    notes="Auto-created from Bid Packages. Has Bid RFIs and Submission tabs. Submit Bid button.",
))

_register(RecordType(
    name="Formulas",
    module="Plans",
    menu_item="Formulas",
    header_fields=[
        FieldDef("Formula ID", read_only=True),
        FieldDef("Description"),
        FieldDef("Type", field_type="dropdown"),
    ],
    detail_columns=["Line #", "Attachments", "Description", "UOM", "Variable", "Calculation / Quantity", "Notes"],
    notes="Variables in brackets. Supports math operators, trig, log functions, logical symbols.",
))

_register(RecordType(
    name="Assemblies",
    module="Plans",
    menu_item="Assemblies",
    header_fields=[
        FieldDef("Assembly ID", read_only=True),
        FieldDef("Description"),
        FieldDef("Assembly Group", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("UOM"), FieldDef("Formula", field_type="dropdown"),
    ],
    detail_columns=["Item", "Description", "Default Cost", "UOM", "Quantity", "Notes"],
    notes="Drag and drop items. Test Assembly button. Quantity can be fixed or variable from formula.",
))

_register(RecordType(
    name="NDA",
    module="Plans",
    menu_item="NDA",
    header_fields=[
        FieldDef("NDA ID", required=True),
        FieldDef("Description"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Default", field_type="checkbox"),
    ],
    detail_columns=[],
    notes="RTF editor for NDA full text. Only one can be default.",
))

# ── FORMS — remaining record types ──────────────────────────────

_register(RecordType(
    name="Online Submittals",
    module="Forms",
    menu_item="Online Submittals",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Submittal #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Linked Set"), FieldDef("CSI Code"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Date", field_type="date"),
        FieldDef("Submitted", field_type="date"), FieldDef("Due", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=["Sub #", "CSI Code", "Attachments", "Item", "Description", "Manufacturer", "Mfr. Number", "Supplier", "Rev.", "Status", "Task", "Notes"],
))

_register(RecordType(
    name="Submittal Items",
    module="Forms",
    menu_item="Submittal Items",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("Company"), FieldDef("CSI Code"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Submittal Status", field_type="dropdown"),
        FieldDef("Start Date", field_type="date"), FieldDef("Finish Date", field_type="date"),
        FieldDef("Lead Time"), FieldDef("Due Date", field_type="date"),
        FieldDef("Supplier"), FieldDef("Task"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Manufacturer"), FieldDef("Mfr. Number"),
    ],
))

_register(RecordType(
    name="Submittal Sets",
    module="Forms",
    menu_item="Submittal Sets",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Set #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("CSI Code"), FieldDef("Reference"),
        FieldDef("Date", field_type="date"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("From"), FieldDef("To"), FieldDef("Assigned To"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Total Lines", read_only=True),
        FieldDef("Closed Lines", read_only=True),
        FieldDef("% Closed", read_only=True),
    ],
    detail_columns=[
            "CSI Code", "Sub #", "Attachments", "Submittal Item ID", "Item",
            "Phase", "Company", "Description", "Category", "Manufacturer",
            "Mfr. Number", "Supplier", "Revision", "Status"
        ],
    notes="Link Submittal Items button. Revise & Resubmit auto-creates next revision.",
))

_register(RecordType(
    name="Drawing Lists",
    module="Forms",
    menu_item="Drawing Lists",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Drawing #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("CSI Code"), FieldDef("CSI Division"),
        FieldDef("Date", field_type="date"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("From"), FieldDef("Reference"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Revision", "Sheet", "Date",
            "Item", "Description", "CSI Division", "CSI Code", "Category",
            "Status", "% complete", "Notes", "Set #", "Task",
            "Location", "Cost Impact"
        ],
    notes="Can be imported from Manager Page.",
))

_register(RecordType(
    name="Drawing Sets",
    module="Forms",
    menu_item="Drawing Sets",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Set #", required=True),
        FieldDef("Description"), FieldDef("Phase"), FieldDef("WBS"),
        FieldDef("CSI Code"), FieldDef("CSI Division"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("From"), FieldDef("Status", field_type="dropdown"), FieldDef("Reference"),
    ],
    detail_columns=[
            "List #", "Line #", "Attachments", "Sheet", "Revision",
            "Item", "Date", "Description", "CSI Division", "CSI Code",
            "Category", "Task", "Location", "Status", "% complete",
            "Notes"
        ],
    notes="Link Drawings button. Adding a new line also creates a Drawing Lists record.",
))

# ── COSTS — remaining record types ──────────────────────────────

_register(RecordType(
    name="Cost Codes",
    module="Costs",
    menu_item="Cost Codes",
    header_fields=[
        FieldDef("Project", required=True),
    ],
    detail_columns=["Inactive", "Cost Code", "Description", "Notes", "Account"],
    notes="Levels section defines structure (up to 10 segments). Copy From Project button. Cost Level Values Dialog.",
))

_register(RecordType(
    name="Cost Ledgers",
    module="Costs",
    menu_item="Cost Ledgers",
    header_fields=[],
    detail_columns=[
        "System ID", "Attachments", "Cost Code", "Description", "UOM", "Currency",
        "Quantity", "Unit Cost", "Total Amount", "Worksheet Column", "Status",
        "Period", "Notes", "Document", "Document Type", "Date",
    ],
    notes="Auto-posted from all transaction types. Has History Tab. Add/Edit/Void for direct entries only.",
))

_register(RecordType(
    name="Forecasts",
    module="Costs",
    menu_item="Forecasts",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Record #"), FieldDef("Description"),
        FieldDef("To This Period", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Status", field_type="dropdown"), FieldDef("WBS"),
        FieldDef("Snapshot Mode", field_type="checkbox"),
        FieldDef("Use Units", field_type="checkbox"),
        FieldDef("Post", field_type="checkbox"),
    ],
    detail_columns=[
        "Cost Code", "Description", "Currency", "Total Budget", "Actual Cost",
        "Balance to Complete", "UOM", "Quantity to Complete", "Unit Cost",
        "Forecast to Complete", "Forecast at Completion", "Forecast Variance",
        "% Complete", "Earned Value", "CPI", "SPI",
    ],
    notes="Update Tasks, Forecast from Earned Value, Link Production buttons. Cashflow and EV graph sections.",
))

_register(RecordType(
    name="Cost Worksheets",
    module="Costs",
    menu_item="Cost Worksheets",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Worksheet", field_type="dropdown"),
        FieldDef("Periods From", field_type="dropdown"),
        FieldDef("Periods To", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Project Default", field_type="checkbox"),
    ],
    detail_columns=[],
    notes="User-defined spreadsheet. Edit mode unlocks cells. Cost Worksheet Entry Dialog. Drill-down on numbers.",
))

_register(RecordType(
    name="Define Worksheets",
    module="Costs",
    menu_item="Define Worksheets",
    header_fields=[
        FieldDef("Worksheet Name", required=True),
        FieldDef("Project", required=True),
        FieldDef("System Default", field_type="checkbox"),
    ],
    detail_columns=["Column #", "System Field", "Column Name", "Calculation", "Symbol", "Alias", "Column Size", "Visible", "Tooltip", "Notes"],
    notes="Drag to reorder. Worksheet Calculation Dialog for formulas.",
))

_register(RecordType(
    name="Budget Requests",
    module="Costs",
    menu_item="Budget Requests",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("WBS"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Post As", field_type="dropdown", options=["Original Budget", "Revised Budget"]),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Project", "Cost Code", "Description", "Currency",
        "UOM", "Quantity", "Unit Price", "Owner Budget", "Unit Cost", "Adjustments",
        "Project Budget", "Cost Type", "Funding", "Company", "Task", "Period", "Notes",
    ],
    notes="Unlimited per project. Cost code can repeat. Post As determines worksheet column.",
))

_register(RecordType(
    name="Funding Records",
    module="Costs",
    menu_item="Funding Records",
    header_fields=[
        FieldDef("Funding By", field_type="dropdown", options=["Portfolio", "Program", "Project"]),
        FieldDef("Source"), FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("Year"),
        FieldDef("Code"), FieldDef("WBS"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=["Line #", "Attachments", "Program", "Project", "Year", "Funding Source", "Currency", "Funding Code", "Funded", "WBS", "Period", "Notes", "Closed"],
))

_register(RecordType(
    name="Funding Requests",
    module="Costs",
    menu_item="Funding Requests",
    header_fields=[
        FieldDef("Funding By", field_type="dropdown", options=["Portfolio", "Program", "Project"]),
        FieldDef("Source"), FieldDef("Record #", required=True),
        FieldDef("Description"),
        FieldDef("Post As", field_type="dropdown", options=["Original Funding", "Revised Funding"]),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=["Line #", "Attachments", "Program", "Project", "Year", "Funding Source", "Currency", "Funding Code", "Funded", "WBS", "Period", "Notes", "Closed"],
))

_register(RecordType(
    name="Funding Authorizations",
    module="Costs",
    menu_item="Funding Authorizations",
    header_fields=[
        FieldDef("Project"),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("WBS"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Funding #", "Year", "Project",
            "Currency", "Funding Source", "Funding Code", "Authorization Code", "Amount",
            "WBS", "Period", "Notes"
        ],
    notes="Add Funding Codes button opens Funding Selector dialog.",
))

_register(RecordType(
    name="Master Commitments",
    module="Costs",
    menu_item="Master Commitments",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Company"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown", options=["Subcontract", "Purchase Order"]),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("WBS"), FieldDef("Effective Date", field_type="date"),
        FieldDef("Days"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=["Record #", "Project", "Description", "Effective Date", "Status", "Date", "Currency", "Original Value", "Approved Changes", "Revised Value"],
    notes="Add Commitment, Link Commitments, Remove Link buttons. All detail fields read-only.",
))

_register(RecordType(
    name="Online Change Requests",
    module="Costs",
    menu_item="Online Change Requests",
    header_fields=[
        FieldDef("Company"),
        FieldDef("Project", required=True),
        FieldDef("Commitment", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("WBS"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Post As", field_type="dropdown", options=["Original Scope", "Revised Scope"]),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Requested Date", field_type="date"), FieldDef("Needed By", field_type="date"),
        FieldDef("Cause", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Description", "Item", "Currency",
            "UOM", "Quantity", "Unit Cost", "Ext. Cost", "Commitment Line",
            "Cost Code", "Cost Type", "Days", "Notes"
        ],
    notes="Generate → Change Event or Change Order. Posts to Potential Exposure worksheet column.",
))

_register(RecordType(
    name="Change Events",
    module="Costs",
    menu_item="Change Events",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Company"), FieldDef("Cause", field_type="dropdown"),
        FieldDef("WBS"), FieldDef("Requested By"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("Effective Date", field_type="date"),
        FieldDef("Change #"),
        FieldDef("Use Units Budget", field_type="checkbox"),
        FieldDef("Use Units Cost", field_type="checkbox"),
    ],
    detail_columns=[],
    notes="Has Budget section (budget/revenue impact) and Cost section (cost impact). Add Linked button in Cost section.",
))

_register(RecordType(
    name="Contract COs",
    module="Costs",
    menu_item="Contract COs",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Contract", required=True),
        FieldDef("Company", read_only=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"),
        FieldDef("Change Order Date", field_type="date"),
        FieldDef("Reference"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("WBS"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Days +/-"),
        FieldDef("Effective Date", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Item", "Description", "Currency",
            "UOM", "Quantity", "Unit Price", "Owner Budget", "Adjustments",
            "Total Price", "Cost Type", "Cost Code", "Contract Line", "Period",
            "Notes", "Req. Code", "CE #"
        ],
    notes="Amends Prime Contracts (revenue). Link to Change Events.",
))

_register(RecordType(
    name="Commitment COs",
    module="Costs",
    menu_item="Commitment COs",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Commitment", required=True),
        FieldDef("Company", read_only=True),
        FieldDef("Commitment Type", read_only=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Post As", field_type="dropdown", options=["Original Scope", "Revised Scope"]),
        FieldDef("WBS"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Cause", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Change Order Date", field_type="date"),
        FieldDef("Effective Date", field_type="date"),
        FieldDef("Days"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Commitment Line", "Description", "Item",
            "Currency", "UOM", "Quantity", "Unit Cost Requested", "Amount Requested",
            "Unit Cost Approved", "Adjustments", "Amount Approved", "Cost Type", "Cost Code",
            "Funding", "Notes", "CE #"
        ],
    notes="Amends Commitments (costs). Link to Change Events.",
))

_register(RecordType(
    name="Production",
    module="Costs",
    menu_item="Production",
    has_create_next=True,
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"),
        FieldDef("Production #", read_only=True),
        FieldDef("Contract"), FieldDef("Commitment"),
        FieldDef("Currency", field_type="dropdown"), FieldDef("Company"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("From Date", field_type="date"), FieldDef("To Date", field_type="date"),
        FieldDef("Period"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"), FieldDef("WBS"),
        FieldDef("Post to Cost Ledger", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Date", "Cost Code", "Description",
            "Currency", "UOM", "Scheduled Quantity", "Current Quantity", "Rate",
            "Total", "Total Quantity", "Contract", "Commitment", "Notes",
            "Done"
        ],
    notes="Sequential series. Create Next rolls forward. Links to contracts/commitments.",
))

_register(RecordType(
    name="Requisitions",
    module="Costs",
    menu_item="Requisitions",
    has_create_next=True,
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Contract", required=True),
        FieldDef("Company", read_only=True),
        FieldDef("Invoice #", read_only=True),
        FieldDef("Record #", required=True),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Reference"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Cost Period"), FieldDef("WBS"),
        FieldDef("Invoice Date", field_type="date"),
        FieldDef("Billing Terms"), FieldDef("Invoice Due", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Paid in Full", field_type="checkbox"),
        FieldDef("Use Units", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Description", "Currency", "Cost Code",
            "UOM", "Scheduled Quantity", "Prior Quantity", "Current Quantity", "Total Quantity",
            "Unit Price", "Scheduled Value", "% Complete", "Current Invoice", "Total Invoiced",
            "Balance to Invoice", "Req. Code", "Notes"
        ],
    notes="Revenue invoices against Prime Contracts. Add Actual Costs button. Sequential series.",
))

_register(RecordType(
    name="Miscellaneous Invoices",
    module="Costs",
    menu_item="Miscellaneous Invoices",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Company"), FieldDef("Invoice #"),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Period"), FieldDef("Date", field_type="date"),
        FieldDef("Billing Terms"), FieldDef("Invoice Due", field_type="date"),
        FieldDef("WBS"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Reference"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Post to Non-commitment Costs", field_type="checkbox"),
        FieldDef("Paid in Full", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Item", "Description", "Currency",
            "Cost Code", "UOM", "Quantity", "Unit Cost", "Ext. Cost",
            "Adjustments", "Total Cost", "Cost Type", "Funding", "Notes",
            "Req. Code"
        ],
    notes="Costs not through Commitments.",
))

_register(RecordType(
    name="A/R and A/P Payments",
    module="Costs",
    menu_item="A/R and A/P Payments",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("Project", required=True),
        FieldDef("Contract"), FieldDef("Requisition"),
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Company"), FieldDef("WBS"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Reference"),
        FieldDef("Payment Amount"),
        FieldDef("Cost Code"), FieldDef("Period"),
        FieldDef("Invoice #"), FieldDef("Payment Method", field_type="dropdown"),
        FieldDef("Payment #"), FieldDef("Payment Date", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Applied in Full", field_type="checkbox"),
    ],
    detail_columns=[],
    notes="5 application levels: Portfolio→Program→Project→Contract→Invoice. Pay Invoice and Auto Apply buttons.",
))

_register(RecordType(
    name="A/R and A/P Payment Batches",
    module="Costs",
    menu_item="A/R and A/P Payment Batches",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("Project", required=True),
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Company"),
        FieldDef("WBS"), FieldDef("Currency", field_type="dropdown"),
        FieldDef("Period"),
        FieldDef("Payment Method", field_type="dropdown"),
        FieldDef("Payment #"), FieldDef("Payment Date", field_type="date"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Reference"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Applied in Full", field_type="checkbox"),
    ],
    detail_columns=[
            "Line #", "Attachments", "Program", "Project", "Contract",
            "Requisition", "ID", "Company", "Invoice #", "Payment Method",
            "Payment #", "Payment Date", "Description", "Currency", "Open Balance",
            "Payment Amount", "Cost Code", "Period", "Status", "Notes",
            "Applied in Full"
        ],
    notes="Link payments. Pay Invoices button applies to multiple invoices.",
))

_register(RecordType(
    name="Cost Ledger Converted",
    module="Costs",
    menu_item="Cost Ledger Converted",
    header_fields=[],
    detail_columns=["ID", "Exchange Rate", "Converted Amount"],
    notes="All fields read-only. Auto-created when cost ledger entries are saved. Click ID to navigate to original.",
))


# ── SCHEDULES module ─────────────────────────────────────────────

_register(RecordType(
    name="Schedules",
    module="Schedules",
    menu_item="Schedules",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Description"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"), FieldDef("Reference"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Calendar", field_type="dropdown"),
        FieldDef("Set as Project Schedule", field_type="checkbox"),
        FieldDef("Link % Complete to Actual Costs", field_type="checkbox"),
        FieldDef("Link % Complete to Remaining Duration", field_type="checkbox"),
        FieldDef("Schedule Tasks", field_type="dropdown", options=["Manually", "Auto", "Ask"]),
        FieldDef("Status Date", field_type="date"),
    ],
    detail_columns=[
        "ID", "Project", "Schedule", "Code", "Task", "Start",
        "Finish", "%C", "TF", "Duration", "Summary",
        "Rem. Duration", "WBS", "Phase", "Location",
        "Baseline Start", "Baseline Finish", "Original Duration",
        "Completed", "Actual Start", "Actual Finish",
        "Revenue", "Cost", "Curve", "Resources", "Cost Code",
        "Status", "Type",
    ],
    toolbar_actions=[
        "new_record", "save", "cancel", "submit",
        "copy_from_schedule", "link_schedule", "update_percent_from_timesheets",
        "save_as_baseline", "lock_schedule", "display_task_tabs",
    ],
    notes="Interactive Gantt chart with Critical Path Management. Task bars draggable. "
          "Dependency connectors: FS/FF/SS/SF with lag. Constraints: Early/Late Start/Finish. "
          "Gantt toolbar: Calculate Dependencies, Save/Delete/Refresh Task, Excel export, Undo/Redo, "
          "Add Task, Expand/Collapse, Show/Hide Columns, Zoom, Assign Resources. "
          "Task Details tabs: Details, Dependencies, Resources, Checklists, Project Codes, Notes. "
          "Link to MS Project or Primavera P6. Save as Baseline copies Start/Finish to Baseline fields.",
))

_register(RecordType(
    name="PPM",
    module="Schedules",
    menu_item="PPM",
    header_fields=[],
    detail_columns=[],
    notes="Multi-Project View. Read-only. Shows all project schedules in one screen. "
          "Click Project Name hyperlink to navigate to editable Schedules page.",
))

_register(RecordType(
    name="Resources Availability",
    module="Schedules",
    menu_item="Resources Availability",
    header_fields=[
        FieldDef("Resources", field_type="dropdown"),
        FieldDef("From Date", field_type="date"),
        FieldDef("To Date", field_type="date"),
    ],
    detail_columns=[],
    notes="Read-only view of tasks assigned to selected resources in date range. "
          "Only resources with Scheduling checkbox checked appear.",
))

_register(RecordType(
    name="Link Setup",
    module="Schedules",
    menu_item="Link Setup",
    header_fields=[
        FieldDef("Primavera", field_type="checkbox"),
    ],
    detail_columns=[
        "Default", "Web Service URL", "Use Network Credential",
        "Web Service User", "Web Service Password", "Domain",
        "Server Name", "Database", "Login", "Password", "Inactive",
    ],
    notes="Configure Primavera P6 database connections for external schedule linking.",
))

_register(RecordType(
    name="Project Codes",
    module="Schedules",
    menu_item="Project Codes",
    header_fields=[
        FieldDef("Project", field_type="dropdown"),
    ],
    detail_columns=[
        "Unique Name", "Header Text", "Width", "Order",
        "Visible By Default", "On/Off", "BG-Color", "Font Color",
    ],
    notes="Up to 10 user-defined dropdown lists per project for schedule task metadata. "
          "Values Button opens Project Code Items dialog. Copy Project Codes from other projects.",
))

_register(RecordType(
    name="Calendars",
    module="Schedules",
    menu_item="Calendars",
    header_fields=[
        FieldDef("Description"),
    ],
    detail_columns=["Date", "Type", "Description"],
    notes="Regular Days Off checkboxes (Mon-Sun). Days Off table: Exception (day off→working) "
          "or Off (working→day off). Interactive calendar control. Apply Regular Days Off button.",
))


# ── WORKFLOWS module ─────────────────────────────────────────────

_register(RecordType(
    name="Inbox",
    module="Workflows",
    menu_item="Inbox",
    header_fields=[],
    detail_columns=["Document ID", "Record Type", "Module", "Status", "Step", "Role", "Due Date"],
    notes="Read-only view of all records in workflow where logged-in user is current approver. "
          "Click Document ID hyperlink to navigate to record.",
))

_register(RecordType(
    name="Business Processes",
    module="Workflows",
    menu_item="Business Processes",
    header_fields=[
        FieldDef("BPM ID", required=True),
        FieldDef("Template Name"),
        FieldDef("Recalculate", field_type="checkbox"),
        FieldDef("Single", field_type="checkbox"),
        FieldDef("Associate With", field_type="multiselect"),
    ],
    detail_columns=[
        "#", "Type", "Description", "Level", "Action",
        "Return To", "Delegate", "DocuSign",
    ],
    toolbar_actions=["save", "use_visual_designer"],
    notes="Central workflow config. 5 tabs: Select Level, Roles, BPM, Record Types, APM Rules. "
          "Levels: System → Program → Project (inherited downward). "
          "Visual Workflow Designer: drag Submit/Step/Branch/Finish elements. "
          "Define Steps: evaluation order top-to-bottom, drag to reorder. "
          "Actions: Next Step, Final Approve, Branch, Reject, Return. "
          "BPM Managers can edit approved/rejected/withdrawn records. "
          "Overdue Alerts: configurable days, roles, email/onscreen. "
          "Roles Tab: Lock checkbox, Level, Role name, User assignment (drag-and-drop). "
          "Options: Allow Users (multi-role), Allow Roles (duplicate in BPM). "
          "Document Manager: CC, Notify On All, Can permissions. "
          "Record Types Tab: assign template per record type per level. "
          "Template options: Use System Default, Use Program Default, Do Not Use Workflow, or custom BPM.",
))

_register(RecordType(
    name="Role Manager",
    module="Workflows",
    menu_item="Role Manager",
    header_fields=[],
    detail_columns=["Level", "Role", "User", "Locked"],
    notes="Cross-level view: define/assign workflow roles at System, Program, and Project simultaneously. "
          "Drag users from Users tree onto roles. Add/Edit/Delete Role buttons. "
          "Locked checkbox: role can only be assigned at the level where it was defined.",
))

_register(RecordType(
    name="Email Templates",
    module="Workflows",
    menu_item="Email Templates",
    header_fields=[
        FieldDef("Record Type", field_type="dropdown"),
        FieldDef("Notification", field_type="dropdown"),
        FieldDef("From Email", required=True),
        FieldDef("Subject", required=True),
    ],
    detail_columns=[],
    notes="Per record type + workflow action. Rich text editor with field tokens. "
          "Special tokens: Approve/Final Approve/Reject action buttons in email. "
          "Requires 'Display Email Buttons' in Define Role Step + Admin Utility setting. "
          "Default Template: master for all types. Update Unlocked Templates copies design down. "
          "Lock checkbox prevents overwrite. Attach to Email section for files/reports.",
))

_register(RecordType(
    name="Workflow Calendars",
    module="Workflows",
    menu_item="Workflow Calendars",
    header_fields=[
        FieldDef("Description"),
    ],
    detail_columns=["Date", "Type", "Description"],
    notes="Same structure as Schedules Calendars. Days off excluded from workflow due date calculations. "
          "Associate with project via Workflow Calendar field in Projects record.",
))


# ── ASSETS module ────────────────────────────────────────────────

_register(RecordType(
    name="Locations",
    module="Assets",
    menu_item="Locations",
    header_fields=[
        FieldDef("Program"),
        FieldDef("Location ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Location Type", field_type="dropdown"),
        FieldDef("Operating Project"),
        FieldDef("Component Type", field_type="dropdown"),
        FieldDef("Service Interval"),
        FieldDef("In Service Date", field_type="date"),
        FieldDef("Condition", field_type="dropdown"),
        FieldDef("Condition Date", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Target Budget"), FieldDef("Target Revenue"),
        FieldDef("Target Occupancy"),
        FieldDef("Barcode"),
    ],
    notes="Top-level real estate asset. Tabs: Details, Buildings, Floors, Spaces, Projects, Work Orders, Equipment. "
          "Asset Explorer tree navigation. Personnel and Leasing sections.",
))

_register(RecordType(
    name="Buildings",
    module="Assets",
    menu_item="Buildings",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Building ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Component Type", field_type="dropdown"),
        FieldDef("Service Interval"),
        FieldDef("In Service Date", field_type="date"),
        FieldDef("Condition", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Barcode"),
    ],
    notes="Child of Location. Tabs: Floors, Spaces, Work Orders, Equipment.",
))

_register(RecordType(
    name="Floors",
    module="Assets",
    menu_item="Floors",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Building", required=True),
        FieldDef("Floor ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Component Type", field_type="dropdown"),
        FieldDef("Service Interval"),
        FieldDef("In Service Date", field_type="date"),
        FieldDef("Condition", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Barcode"),
    ],
    notes="Child of Building. Floor Plan button opens PMWeb Viewer. Tabs: Spaces, Work Orders, Equipment.",
))

_register(RecordType(
    name="Spaces",
    module="Assets",
    menu_item="Spaces",
    header_fields=[
        FieldDef("Building", required=True),
        FieldDef("Floor", required=True),
        FieldDef("Space ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Sub Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Condition", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Barcode"),
    ],
    notes="Lowest real estate level. Occupants Tab (Company/Department/Contact with move dates). "
          "Leases, Work Orders, Equipment tabs. Space Planning section.",
))

_register(RecordType(
    name="Equipment",
    module="Assets",
    menu_item="Equipment",
    header_fields=[
        FieldDef("Equipment ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Current Location", required=True),
        FieldDef("Equipment Type", field_type="dropdown"),
        FieldDef("Ownership", field_type="dropdown"),
        FieldDef("Function Status", field_type="dropdown"),
        FieldDef("Condition", field_type="dropdown"),
        FieldDef("Condition Date", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("In Service Date", field_type="date"),
        FieldDef("Vendor"), FieldDef("Manufacturer"),
        FieldDef("Manufacturer #"), FieldDef("Serial #"), FieldDef("Lot #"),
        FieldDef("Item"), FieldDef("Price"),
        FieldDef("Warranty Expires", field_type="date"),
        FieldDef("Track Use by"),
        FieldDef("Or By Days", field_type="checkbox"),
        FieldDef("Service Interval"),
        FieldDef("Barcode"),
    ],
    notes="Tabs: Moves (location history), Components (predictive maintenance), Log (usage readings), "
          "Work Orders, Cost Worksheet (depreciation + TCO). Drag in Asset Explorer to move. "
          "Equipment Move Dialog for formal moves.",
))

_register(RecordType(
    name="Inventory Locations",
    module="Assets",
    menu_item="Inventory Locations",
    header_fields=[
        FieldDef("Location ID", required=True),
        FieldDef("Name"),
        FieldDef("Linked To", required=True),
        FieldDef("Location Type", field_type="dropdown"),
        FieldDef("Capacity"), FieldDef("Capacity UOM"),
    ],
    detail_columns=[
        "Stock #", "Sub-Location", "Item", "Description",
        "Condition", "UOM", "Stocked", "Used", "Unusable",
        "Moved", "On Hand", "Unit Cost", "Ext. Cost",
        "Manufacturer", "Mfr. Number", "Serial #", "Lot #",
    ],
    notes="Sub-locations section. Stock Move Dialog for moving/using/marking unusable. "
          "Pull inventory to Work Orders via Material Costs Tab.",
))

_register(RecordType(
    name="Work Orders",
    module="Assets",
    menu_item="Work Orders",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Project"),
        FieldDef("Record #", required=True),
        FieldDef("Description"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("WBS"), FieldDef("Progress", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Scope", field_type="textarea"),
        FieldDef("Priority", field_type="dropdown"),
        FieldDef("Reported", field_type="date"),
        FieldDef("Estimated Start", field_type="date"),
        FieldDef("Finish", field_type="date"),
        FieldDef("Contact Name"), FieldDef("Email"),
        FieldDef("Maintenance Contract"),
    ],
    notes="Tabs: Preventive (recurring via frequency config), Estimate, Resources (labor/equipment), "
          "Serviced (condition assessment → Update Assets), Material Costs (pick from inventory), "
          "Cost Totals. On Demand, Preventive, or Predictive types. Dispatch Board integration.",
))

_register(RecordType(
    name="Dispatch Board",
    module="Assets",
    menu_item="Dispatch Board",
    header_fields=[],
    notes="Visual scheduler. Drag work orders onto resource columns. Appointments update Work Orders Resources Tab. "
          "Board Selector, Time Navigator, Unassigned Column, Show 24 Hours toggle.",
))

_register(RecordType(
    name="Map View",
    module="Assets",
    menu_item="Map View",
    header_fields=[],
    notes="Interactive map of work orders with dispatch appointments. Click points for resource/date details.",
))

_register(RecordType(
    name="Maintenance Contracts",
    module="Assets",
    menu_item="Maintenance Contracts",
    header_fields=[
        FieldDef("ID", required=True),
        FieldDef("Description"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Bill to", required=True),
        FieldDef("Contact"),
        FieldDef("Overview", field_type="textarea"),
        FieldDef("Start", field_type="date"), FieldDef("End", field_type="date"),
        FieldDef("Value"), FieldDef("Billing"),
    ],
    notes="Linked Work Orders section. Add button creates linked work order.",
))

_register(RecordType(
    name="Suites",
    module="Assets",
    menu_item="Suites",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Building"), FieldDef("Floor"),
        FieldDef("ID", required=True),
        FieldDef("Name"), FieldDef("Suite Type", field_type="dropdown"),
        FieldDef("Sub-Type", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Barcode"),
    ],
    notes="Combine assets for leasing. Linked Gross/Usable/Rentable from assets. "
          "Snapshot section with rent calculations. Leases Tab.",
))

_register(RecordType(
    name="Leases",
    module="Assets",
    menu_item="Leases",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Lease ID", required=True),
        FieldDef("Description"),
        FieldDef("Lease Type", field_type="dropdown"),
        FieldDef("Post As", field_type="dropdown", options=["Cost", "Revenue"]),
        FieldDef("Landlord"), FieldDef("Tenant"), FieldDef("Agent"),
        FieldDef("Status", field_type="dropdown"),
    ],
    notes="Tabs: Abstract (lease terms, dates, payments), Charges (basic + advanced with "
          "Escalations/Recoveries/Overages), Ledger (all transactions). Parent/Sub-lease support.",
))

_register(RecordType(
    name="Lease Administrator",
    module="Assets",
    menu_item="Lease Administrator",
    header_fields=[
        FieldDef("Program", required=True),
        FieldDef("Location", required=True),
        FieldDef("Batch ID", required=True),
        FieldDef("Description"),
        FieldDef("Type", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Batch Date", field_type="date"),
        FieldDef("Invoice Date", field_type="date"),
        FieldDef("Posted Date", field_type="date"),
        FieldDef("Deactivate Expiring Charges", field_type="checkbox"),
    ],
    notes="Post button processes batch. Tabs: Scheduled Charges, Recoveries, Overages, Escalations. "
          "Creates Tenant Invoices, flags recovered costs, advances posting dates.",
))

_register(RecordType(
    name="Tenant Invoices",
    module="Assets",
    menu_item="Tenant Invoices",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Lease", required=True),
        FieldDef("Invoice #", required=True),
        FieldDef("Description"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Invoice Date", field_type="date"),
        FieldDef("Billing Terms"), FieldDef("Due Date", field_type="date"),
        FieldDef("Cost Period"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Paid in Full", field_type="checkbox"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Description", "Item", "UOM",
        "Quantity", "Unit Cost", "Ext. Cost", "Adjustments",
        "Unit Price", "Total Price", "Cost Code", "Charge Type", "Notes",
    ],
    notes="Created manually or by Lease Administrator batch. Posts to Cost Ledgers if Cost Code set.",
))

_register(RecordType(
    name="Move Plans",
    module="Assets",
    menu_item="Move Plans",
    header_fields=[
        FieldDef("Move Plan ID"),
        FieldDef("Description"),
        FieldDef("Location"), FieldDef("Building"), FieldDef("Floor"),
        FieldDef("Status", field_type="dropdown"),
    ],
    notes="Plan and execute moves of companies/departments/contacts/equipment between spaces. "
          "Execute Moves button. Drag from Occupants/Companies onto Destination.",
))

_register(RecordType(
    name="Reservation Requests",
    module="Assets",
    menu_item="Reservation Requests",
    header_fields=[
        FieldDef("Code", required=True),
        FieldDef("Description"), FieldDef("Location"),
        FieldDef("Building"), FieldDef("Floor"), FieldDef("Subject"),
        FieldDef("Space"), FieldDef("Equipment"),
        FieldDef("Start Date", required=True, field_type="date"),
        FieldDef("Finish Date", required=True, field_type="date"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Notes", field_type="textarea"),
    ],
    notes="Works with Shared Assets scheduler. Drag onto scheduler to assign to spaces/equipment.",
))

_register(RecordType(
    name="Shared Assets",
    module="Assets",
    menu_item="Shared Assets",
    header_fields=[],
    notes="Visual scheduler for shared spaces and equipment. Drag Reservation Requests onto asset columns. "
          "Filter by location/building/floor. Week/Timeline views.",
))

_register(RecordType(
    name="Configure Dispatch Boards",
    module="Assets",
    menu_item="Configure Dispatch Boards",
    header_fields=[
        FieldDef("Description"),
        FieldDef("Default Board", field_type="checkbox"),
        FieldDef("Default Start Time"),
        FieldDef("Default Hours"),
    ],
    notes="Select labor and equipment resources to display as columns in the Dispatch Board.",
))

_register(RecordType(
    name="Lease Charges",
    module="Assets",
    menu_item="Lease Charges",
    header_fields=[],
    detail_columns=[
        "Charge ID", "Type", "Description", "Post Every",
        "Est.", "UOM", "Quantity", "Unit Cost", "Amount",
        "Annualized", "Cost Code", "Notes", "Inactive",
    ],
    notes="Predefined charges for drag-and-drop into Leases Charges Tab.",
))

_register(RecordType(
    name="Location Programs",
    module="Assets",
    menu_item="Location Programs",
    header_fields=[
        FieldDef("Program ID", required=True),
        FieldDef("Name"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Target Budget"), FieldDef("Target Revenue"),
        FieldDef("Director"), FieldDef("Manager"),
        FieldDef("Program Manager"),
    ],
    notes="Grouping record for Locations. Location Defaults and Personnel auto-copied to new Locations.",
))


# ── PORTFOLIO module ──────────────────────────────────────────────

_register(RecordType(
    name="Programs",
    module="Portfolio",
    menu_item="Programs",
    header_fields=[
        FieldDef("Program #", required=True),
        FieldDef("Name", required=True),
        FieldDef("Description"), FieldDef("Notes", field_type="textarea"),
        FieldDef("Director"), FieldDef("Manager"),
        FieldDef("Program Manager"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Program Status", field_type="dropdown"),
        FieldDef("Estimated Duration"), FieldDef("Estimated Cost"),
    ],
    notes="Top-level container. Projects Tab shows linked projects. Project Defaults section copied to new projects.",
))

_register(RecordType(
    name="Projects",
    module="Portfolio",
    menu_item="Projects",
    header_fields=[
        FieldDef("Program"),
        FieldDef("Project ID", required=True),
        FieldDef("Name"),
        FieldDef("Location"), FieldDef("Project Status", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
        FieldDef("Currency", field_type="dropdown"),
        FieldDef("Target Budget"), FieldDef("Target Revenue"),
        FieldDef("Target Duration"), FieldDef("Target Start", field_type="date"),
        FieldDef("Target Finish", field_type="date"),
        FieldDef("Percent Complete"),
        FieldDef("Scope", field_type="textarea"),
        FieldDef("Workflow Calendar", field_type="dropdown"),
    ],
    notes="Primary operational record. Tabs: Locations, Phases, WBS, Users, Companies, Contacts. "
          "Copy Project dialog. Link Schedule. Personnel section.",
))

_register(RecordType(
    name="Work Requests",
    module="Portfolio",
    menu_item="Work Requests",
    header_fields=[
        FieldDef("Contact Name", required=True),
        FieldDef("Record #", required=True),
        FieldDef("Location"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Description"),
        FieldDef("WBS"), FieldDef("Scope", field_type="textarea"),
        FieldDef("Status", field_type="dropdown"),
    ],
    notes="Generate into Work Orders, Initiatives, or Projects.",
))

_register(RecordType(
    name="Companies",
    module="Portfolio",
    menu_item="Companies",
    header_fields=[
        FieldDef("Company ID", required=True),
        FieldDef("Name", required=True),
        FieldDef("Type", field_type="dropdown"), FieldDef("Abbreviation"),
        FieldDef("Reference"), FieldDef("Account #"),
        FieldDef("Country"), FieldDef("Billing Terms"),
        FieldDef("Occupant", field_type="checkbox"),
        FieldDef("Approved Bidder", field_type="checkbox"),
    ],
    notes="Tabs: Addresses, Departments, Contacts, Insurance, Resources. Purchase History tab.",
))

_register(RecordType(
    name="Labor Resources",
    module="Portfolio",
    menu_item="Labor Resources",
    header_fields=[
        FieldDef("ID", required=True),
        FieldDef("Company"), FieldDef("Contact"),
        FieldDef("Last Name"), FieldDef("First Name"), FieldDef("Description"),
        FieldDef("Resource Group"), FieldDef("Default Cost Code"),
        FieldDef("Default Hours Per Day"),
        FieldDef("Target Utilization %"),
        FieldDef("Scheduling", field_type="checkbox"),
    ],
    notes="Used in Estimates, Timesheets, Schedules, Work Orders.",
))

_register(RecordType(
    name="Equipment Resources",
    module="Portfolio",
    menu_item="Equipment Resources",
    header_fields=[
        FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("Equipment Type"),
        FieldDef("Condition", field_type="dropdown"),
        FieldDef("Manager"), FieldDef("Default Cost Code"),
        FieldDef("Target Utilization %"),
    ],
    notes="Used in Estimates, Timesheets, Schedules, Work Orders. Link to Asset Management Equipment.",
))

_register(RecordType(
    name="Items",
    module="Portfolio",
    menu_item="Items",
    header_fields=[
        FieldDef("Item ID", read_only=True),
        FieldDef("Description"),
        FieldDef("Item Group", field_type="dropdown"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("Manufacturer"), FieldDef("Mfr. Number"), FieldDef("BIM ID"),
        FieldDef("UOM"), FieldDef("Currency", field_type="dropdown"), FieldDef("Cost"),
    ],
    notes="Catalogue of items. Drag-and-drop into Estimates, Commitments, etc. Items Tree View for folder structure.",
))

# ── TOOLS module ─────────────────────────────────────────────────

_register(RecordType(
    name="Activity Boards",
    module="Tools",
    menu_item="Activity Boards",
    header_fields=[],
    notes="Kanban-style boards. Card View and List View. Columns represent stages. "
          "Tasks: drag-and-drop, assign users, due dates, subtasks, links to PMWeb records, "
          "attachments, comments, likes, flags. Board Settings for membership and notifications.",
))

_register(RecordType(
    name="Timesheets",
    module="Tools",
    menu_item="Timesheets",
    header_fields=[
        FieldDef("Timesheet #", required=True),
        FieldDef("From", required=True, field_type="date"),
        FieldDef("To", required=True, field_type="date"),
        FieldDef("Resource"), FieldDef("Program", required=True),
        FieldDef("Project"), FieldDef("Status", field_type="dropdown"),
        FieldDef("Period"), FieldDef("Funding Code"),
        FieldDef("Post to Non-commitment Costs", field_type="checkbox"),
    ],
    detail_columns=[
        "Resource", "Project", "Attachments", "Cost Code",
        "Description", "Task", "Day columns", "Total",
        "% Complete", "Classification", "Pay Type", "Period", "Notes",
    ],
    notes="7-day max range. Generate Next increments sequence and advances dates by one week. "
          "Posts to Cost Ledgers when Approved.",
))

_register(RecordType(
    name="Risk Analysis",
    module="Tools",
    menu_item="Risk Analysis",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Analysis #", required=True),
        FieldDef("Description"), FieldDef("Phase"),
        FieldDef("Analysis Date", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
    ],
    detail_columns=[
        "Line #", "Attachments", "Risk", "Type", "Responsible",
        "Probability", "Impact", "Risk Impact", "Risk Delay",
        "Cost", "Risk Cost", "UOM", "Task", "Notes", "Action", "Rating", "Use",
    ],
    notes="Unlimited risks per project with contingency sub-table. Generate from Online Change Requests. "
          "Generate Change Events.",
))

_register(RecordType(
    name="Adaptive Forms",
    module="Tools",
    menu_item="Adaptive Forms",
    header_fields=[],
    notes="Modern form designer. Designer/Preview/JSON Editor/Translation sub-tabs. "
          "Assign Permissions tab. Drag-and-drop layout. Integrated with Visual Workflow.",
))

_register(RecordType(
    name="Classic Form Builder",
    module="Tools",
    menu_item="Classic Form Builder",
    header_fields=[
        FieldDef("ID", required=True),
        FieldDef("Form Name", required=True),
        FieldDef("Module", field_type="dropdown"),
        FieldDef("Use With", field_type="dropdown", options=["Initiatives only", "Projects only", "Both"]),
        FieldDef("Use Advanced Design", field_type="checkbox"),
    ],
    notes="System Fields, Custom Fields, Custom Tables sections. Designer Tab (drag-and-drop layout). "
          "Permissions Tab. Design Table dialog for custom tables.",
))

_register(RecordType(
    name="Vendor Prequal Designer",
    module="Tools",
    menu_item="Vendor Prequal",
    header_fields=[],
    notes="Design vendor application forms. Sections Table, Custom Fields, Custom Tables, Links. "
          "Published to PMWeb site for external applicants.",
))

_register(RecordType(
    name="Vendor Prequal Records",
    module="Tools",
    menu_item="Vendor Prequal",
    header_fields=[
        FieldDef("Prequalification ID", required=True),
        FieldDef("Company Name"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Year"), FieldDef("Country"),
        FieldDef("Prequalification Starts", field_type="date"),
        FieldDef("Prequalification Ends", field_type="date"),
        FieldDef("Status", field_type="dropdown"),
    ],
    notes="Create Company button when Approved. Tabs mirror Companies record. Applications tab.",
))

_register(RecordType(
    name="Stage Gates",
    module="Tools",
    menu_item="Stage Gates",
    header_fields=[
        FieldDef("Project", required=True),
        FieldDef("Stage"), FieldDef("Gate Keeper"),
        FieldDef("Duration"), FieldDef("UOM"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Task"),
        FieldDef("Lead Time"), FieldDef("Due", field_type="date"),
        FieldDef("Done", field_type="checkbox"),
    ],
    detail_columns=[
        "Link Records", "Done", "Line #", "Attachments",
        "Record Type", "Record #", "Description", "Status",
        "Responsible", "WBS", "Start Date", "Due Date", "Done Date",
    ],
    notes="Stages tree. Activities linked to PMWeb records. Real-time status from linked records.",
))

_register(RecordType(
    name="Stage Gates Setup",
    module="Tools",
    menu_item="Stage Gates Setup",
    header_fields=[],
    notes="Reusable Stage Gate templates for project lifecycle.",
))

_register(RecordType(
    name="Document Manager",
    module="Tools",
    menu_item="Document Manager",
    header_fields=[],
    notes="Full document management. Folder tree: Locations/Projects/Shared. Versioning, check in/out, "
          "custom attributes, subscriptions. Card/List view. Drag-and-drop upload. PMWeb Viewer for "
          "PDFs, images, CAD. Advanced Search. Edit Folder Dialog for permissions.",
))

_register(RecordType(
    name="Integration Manager",
    module="Tools",
    menu_item="Integration Manager",
    header_fields=[
        FieldDef("Profile ID", required=True),
        FieldDef("Description"),
    ],
    notes="Flat-file data exchange (Excel/CSV/XML). Out section for export, In section for import. "
          "Schedule Tab for automatic runs. Projects Tab for scope.",
))

_register(RecordType(
    name="Requirements",
    module="Tools",
    menu_item="Requirements",
    header_fields=[
        FieldDef("Requirement ID", required=True),
        FieldDef("Based On", field_type="dropdown", options=["System", "Projects", "Locations"]),
        FieldDef("Program"), FieldDef("Project"),
        FieldDef("Description"), FieldDef("Resource Type"),
        FieldDef("Classification"), FieldDef("Priority", field_type="dropdown"),
        FieldDef("Start", required=True, field_type="date"),
        FieldDef("Finish", required=True, field_type="date"),
        FieldDef("Cost Code"),
    ],
    detail_columns=[
        "Resource", "Resource Type", "Start", "Finish",
        "Hours Per Day", "Assigned Hours", "% Effort",
        "Classification", "Pay Type", "Rate", "Total", "Cost Code",
    ],
    notes="Staffing requirements linked to records. Assignments post to Cost Ledger if cost code set.",
))

_register(RecordType(
    name="Org Chart",
    module="Tools",
    menu_item="Org Chart",
    header_fields=[
        FieldDef("Org Chart ID", required=True),
        FieldDef("Based On", field_type="dropdown", options=["Projects", "Locations", "System"]),
        FieldDef("Program"), FieldDef("Project"),
        FieldDef("Description"), FieldDef("Status", field_type="dropdown"),
    ],
    notes="Interactive org chart builder. Drag resources from flyout onto groups. Export as image.",
))

_register(RecordType(
    name="Model Manager",
    module="Tools",
    menu_item="Model Manager",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Project", required=True),
        FieldDef("Building"), FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("BIM Application"),
        FieldDef("BIM Model"), FieldDef("Owner"),
        FieldDef("Type", field_type="dropdown"), FieldDef("Category", field_type="dropdown"),
        FieldDef("LOD"), FieldDef("Status", field_type="dropdown"),
    ],
    notes="PMWeb 3D Viewer for .dwfx models. Snapshots, annotations. Revit Add-in integration.",
))

_register(RecordType(
    name="COBie Manager",
    module="Tools",
    menu_item="COBie Manager",
    header_fields=[
        FieldDef("Location", required=True),
        FieldDef("Project", required=True),
        FieldDef("Building"), FieldDef("ID", required=True),
        FieldDef("Description"), FieldDef("BIM Application"),
        FieldDef("Owner"), FieldDef("Type", field_type="dropdown"),
        FieldDef("Category", field_type="dropdown"),
        FieldDef("Status", field_type="dropdown"),
    ],
    notes="COBie data tabs: Space, Zone, Type, Component, System. Revit Add-in integration.",
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
