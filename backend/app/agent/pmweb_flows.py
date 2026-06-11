"""Deterministic PMWeb operation flows.

Each flow is a complete multi-step sequence for a specific PMWeb operation.
Flows use the navigator for atomic DOM actions and the registry for
field/record definitions. No LLM involvement.

Architecture layer 3 of 4:
  1. Registry (data) → 2. Navigator (DOM) → 3. Flows (sequences) → 4. Agent (LLM intent)
"""

from __future__ import annotations

import logging
from typing import Any

from app.agent.pmweb_navigator import PMWebNavigator
from app.agent.pmweb_registry import RecordType

logger = logging.getLogger(__name__)


class FlowResult:
    """Accumulates step results from a flow execution."""

    def __init__(self) -> None:
        self.steps: list[dict[str, Any]] = []
        self._step = 0

    def add(self, action: str, result: str) -> None:
        self._step += 1
        self.steps.append({"step": self._step, "action": action, "result": result})

    def add_error(self, action: str, error: str) -> None:
        self._step += 1
        self.steps.append({"step": self._step, "action": action, "error": error})

    @property
    def has_errors(self) -> bool:
        return any("error" in s for s in self.steps)


class PMWebFlows:
    """Deterministic multi-step flows for every PMWeb operation."""

    def __init__(self, nav: PMWebNavigator) -> None:
        self.nav = nav

    @staticmethod
    def _field_value(fields: dict[str, str], *aliases: str) -> str:
        """Return a field value using case/space/underscore-insensitive aliases."""
        normalized = {
            str(key).lower().replace(" ", "").replace("_", ""): value
            for key, value in fields.items()
        }
        for alias in aliases:
            value = normalized.get(alias.lower().replace(" ", "").replace("_", ""))
            if value:
                return str(value)
        return ""

    # ── Navigation flows ─────────────────────────────────────────────

    def navigate_to_record(self, rt: RecordType, result: FlowResult) -> None:
        """Navigate to a record type's page, handling iframe if needed."""
        if rt.url_fragment:
            result.add("navigate", self.nav.navigate(rt.url_fragment))
        else:
            result.add("navigate", self.nav.navigate_to_record_type(rt.module, rt.menu_item))

        if rt.uses_iframe:
            result.add("switch_to_iframe", self.nav.switch_to_iframe(rt.iframe_id))

    # ── Read flows ───────────────────────────────────────────────────

    def read_records(self, rt: RecordType | None, record_type_name: str) -> FlowResult:
        """Navigate to a record type and read its grid data."""
        result = FlowResult()

        if rt:
            self.navigate_to_record(rt, result)
        else:
            result.add("navigate", self.nav.navigate("/Home.aspx"))

        # Use a high cap so list/read answers can include complete datasets.
        row_cap = 1000
        if "security group" in record_type_name.lower() and hasattr(self.nav, "read_security_groups"):
            data = self.nav.read_security_groups(max_rows=row_cap)
        else:
            data = self.nav.read_kendo_grid(max_rows=row_cap)
        result.add("read_grid", f"found {len(data)} rows")
        payload = {
            "record_type": record_type_name,
            "rows": len(data),
            "data": data,
        }
        # Keep payload available under both keys for compatibility with
        # older result-consumers that read `output` instead of `result`.
        result.steps[-1]["result"] = payload
        result.steps[-1]["output"] = payload
        return result

    # ── Security Group flow ──────────────────────────────────────────

    def create_security_group(
        self,
        rt: RecordType,
        fields: dict[str, str],
        options: list[str],
        permissions: dict[str, str],
    ) -> FlowResult:
        """Full deterministic flow: navigate → iframe → Groups tab → New Group → fill → options → permissions → save."""
        result = FlowResult()

        self.navigate_to_record(rt, result)

        result.add("click_tab_groups", self.nav.click_tab("Groups"))
        result.add("click_new_group", self.nav.click_toolbar_button("New Group"))

        group_id = self._field_value(
            fields,
            "Group ID",
            "GroupID",
            "group_id",
            "groupid",
            # Backwards compatibility with prompts/results produced before PMWeb
            # Security Groups were modeled with the correct Group ID field.
            "Group Name",
            "group_name",
            "name",
        )
        if group_id:
            result.add("fill_group_id", self.nav.fill_kendo_textbox(0, group_id))

        desc = self._field_value(fields, "Description", "description")
        if desc:
            result.add("fill_description", self.nav.fill_kendo_textbox(1, desc))

        for opt in options:
            result.add(f"check_{opt}", self.nav.toggle_checkbox(opt, check=True))

        for module, perm in permissions.items():
            result.add(f"permission_{module}", self.nav.set_module_permission(module, perm))

        result.add("save", self.nav.click_save())
        return result

    # ── User flow ────────────────────────────────────────────────────

    CELL_MAP = {
        "User ID": 3, "user_id": 3,
        "First Name": 5, "first_name": 5,
        "Last Name": 6, "last_name": 6,
        "Password": 11, "password": 11,
        "Email": 17, "email": 17,
    }
    DROPDOWN_MAP = {
        "License Type": 8, "license_type": 8,
        "Named License": 9, "named_license": 9,
        "Group": 10, "group": 10,
    }

    def create_user(self, rt: RecordType, fields: dict[str, str]) -> FlowResult:
        """Full deterministic flow: navigate → iframe → Users tab → New Line → fill cells → save."""
        result = FlowResult()

        self.navigate_to_record(rt, result)

        result.add("click_tab_users", self.nav.click_tab("Users"))
        result.add("new_line", self.nav.click_new_line())

        for field_name, value in fields.items():
            if not value:
                continue
            if field_name in self.CELL_MAP:
                result.add(f"fill_{field_name}", self.nav.fill_grid_cell(self.CELL_MAP[field_name], str(value)))
            elif field_name in self.DROPDOWN_MAP:
                result.add(f"select_{field_name}", self.nav.select_grid_cell_dropdown(self.DROPDOWN_MAP[field_name], str(value)))

        result.add("save", self.nav.click_save())
        return result

    # ── User Access flow ─────────────────────────────────────────────

    def assign_user_to_group(self, rt: RecordType, user: str, group: str) -> FlowResult:
        """Navigate → iframe → User Access tab → assign user to group."""
        result = FlowResult()
        self.navigate_to_record(rt, result)
        result.add("click_tab_user_access", self.nav.click_tab("User Access"))

        for row in self.nav.driver.find_elements("css selector", "kendo-grid tr.k-table-row"):
            if user.lower() in row.text.lower():
                dds = row.find_elements("css selector", "kendo-dropdownlist")
                for dd in dds:
                    if dd.is_displayed():
                        dd.click()
                        import time
                        time.sleep(1)
                        from selenium.webdriver.common.by import By
                        from selenium.webdriver.support import expected_conditions as EC
                        from selenium.webdriver.support.ui import WebDriverWait
                        for item in WebDriverWait(self.nav.driver, 5).until(
                            EC.presence_of_all_elements_located((By.CSS_SELECTOR, "kendo-popup li"))
                        ):
                            if group.lower() in item.text.lower():
                                item.click()
                                time.sleep(0.5)
                                result.add("assign_user", f"assigned {user} to {group}")
                                result.add("save", self.nav.click_save())
                                return result
                        from selenium.webdriver.common.keys import Keys
                        dd.send_keys(Keys.ESCAPE)
                        result.add_error("assign_user", f"group '{group}' not in dropdown")
                        return result
        result.add_error("assign_user", f"user '{user}' not found")
        return result

    # ── Generic record creation flow ─────────────────────────────────

    def create_record(
        self,
        rt: RecordType,
        fields: dict[str, str],
        detail_lines: list[dict[str, str]] | None = None,
    ) -> FlowResult:
        """Generic flow: navigate → new record → fill header fields → add detail lines → save."""
        result = FlowResult()

        self.navigate_to_record(rt, result)
        result.add("new_record", self.nav.click_new_record())

        for field_name, value in fields.items():
            if value:
                result.add(f"fill_{field_name}", self.nav.fill_field_by_label(field_name, str(value)))

        if detail_lines:
            for line in detail_lines:
                result.add("new_line", self.nav.click_new_line())
                for col, val in line.items():
                    if val:
                        result.add(f"fill_{col}", self.nav.fill_field_by_label(col, str(val)))

        result.add("save", self.nav.click_save())
        return result

    # ── Adaptive Form flow ───────────────────────────────────────────

    def create_adaptive_form(
        self,
        title: str,
        form_fields: list[dict[str, Any]],
    ) -> FlowResult:
        """Full flow: open builder → set title → add fields with types/choices → save."""
        result = FlowResult()

        result.add("open_builder", self.nav.open_form_builder())
        result.add("set_title", self.nav.set_form_title(title))

        for ff in form_fields:
            label = ff.get("label", "Field")
            field_type = ff.get("field_type", ff.get("type", "text"))
            choices = ff.get("choices", [])
            result.add(f"add_field_{label}", self.nav.add_form_field(label, field_type, choices))

        result.add("save", self.nav.save_form())
        return result

    # ── Workflow/BPM flow ────────────────────────────────────────────

    def create_bpm_workflow(
        self,
        bpm_id: str,
        name: str,
        statuses: list[dict[str, str]] | None = None,
        roles: list[str] | None = None,
    ) -> FlowResult:
        """Full flow: navigate → BPM tab → create → add statuses → save."""
        result = FlowResult()

        result.add("navigate", self.nav.navigate("/Workflow.aspx"))
        result.add("click_bpm_tab", self.nav.click_tab("Business Processes"))

        result.add("fill_bpm_id", self.nav.fill_field_by_id(
            "ctl00_CPH1_ucBusinessProcesses_txtTemplateId", bpm_id))
        result.add("fill_bpm_name", self.nav.fill_field_by_id(
            "ctl00_CPH1_ucBusinessProcesses_txtTemplateName", name))

        if statuses:
            for status in statuses:
                status_name = status.get("name", status.get("status_name", ""))
                if status_name:
                    result.add("add_status", self.nav.click_toolbar_button("New"))
                    result.add(f"fill_status_{status_name}",
                               self.nav.fill_field_by_label("Status", status_name))

        result.add("save", self.nav.click_save())
        return result

    # ── Document Management flow ─────────────────────────────────────

    def create_doc_folder(self, folder_name: str, parent: str = "Root") -> FlowResult:
        """Navigate → Document Manager → create folder under parent."""
        result = FlowResult()
        result.add("navigate", self.nav.navigate("/DocumentManager.aspx"))

        from selenium.webdriver.common.action_chains import ActionChains
        from selenium.webdriver.common.keys import Keys

        tree_items = self.nav.driver.find_elements("css selector", ".k-treeview-item, [class*='tree'] li")
        for item in tree_items:
            if parent.lower() in item.text.lower() and item.is_displayed():
                ActionChains(self.nav.driver).context_click(item).perform()
                import time
                time.sleep(1)
                break

        menu_items = self.nav.driver.find_elements("css selector", ".k-context-menu li, [class*='menu'] li")
        for mi in menu_items:
            if "new" in mi.text.lower() or "add" in mi.text.lower():
                mi.click()
                import time
                time.sleep(2)
                break

        inputs = self.nav.driver.find_elements("css selector", "input[type='text']")
        for inp in inputs:
            if inp.is_displayed() and not inp.get_attribute("value"):
                inp.click()
                inp.send_keys(folder_name)
                inp.send_keys(Keys.ENTER)
                import time
                time.sleep(1)
                result.add("create_folder", f"created folder: {folder_name} under {parent}")
                return result

        result.add_error("create_folder", f"could not create folder: {folder_name}")
        return result

    # ── Bulk creation flow ───────────────────────────────────────────

    def create_bulk_records(
        self,
        rt: RecordType,
        records: list[dict[str, str]],
    ) -> FlowResult:
        """Create multiple records of the same type from a list of field dicts."""
        result = FlowResult()
        for i, fields in enumerate(records):
            result.add(f"record_{i + 1}_start", f"creating record {i + 1} of {len(records)}")
            sub = self.create_record(rt, fields)
            result.steps.extend(sub.steps)
        return result
