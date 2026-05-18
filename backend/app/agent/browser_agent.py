"""Hybrid PMWeb agent — GPT-4o parses intent, deterministic engine executes.

Architecture:
  1. LLM receives user message + conversation history + registry of
     available record types and their required fields
  2. LLM outputs structured JSON: {intent, record_type, fields, actions}
  3. Deterministic navigator executes using exact selectors from the
     PMWeb 2025.1 User Guide — zero LLM involvement in DOM interaction
"""

from __future__ import annotations

import json
import logging
import time
from typing import Any

from openai import OpenAI
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from app.agent.pmweb_navigator import PMWebNavigator
from app.agent.pmweb_registry import (
    get_record_type,
    get_required_fields,
    list_record_types,
)
from app.config import settings

logger = logging.getLogger(__name__)

INTENT_PROMPT = """\
You are a PMWeb automation assistant. Parse the user's request and output \
a JSON object describing what they want to do.

## Available PMWeb Record Types
{record_types}

## Output Format
Return ONLY a JSON object with these fields:
{{
  "intent": "create" | "read" | "update" | "delete" | "list" | "ask_user",
  "record_type": "<exact record type name from the list above>",
  "fields": {{
    "<field_name>": "<value>",
    ...
  }},
  "detail_lines": [
    {{"<column>": "<value>", ...}},
    ...
  ],
  "options": ["<option to check>", ...],
  "permissions": {{"<module>": "<View|Create|Edit|Delete|Full Control>", ...}},
  "message": "<only for ask_user intent — the question to ask>"
}}

## Rules
1. ALWAYS ask for required fields if they are missing from the user's \
message. Set intent="ask_user" and list what's needed in "message".
2. Required fields per record type:
{required_fields}
3. If the user says "generic", "default", or "sample", generate \
reasonable values and set intent="create".
4. If a file is attached (text after "--- Attached file ---"), extract \
field values from it and use them directly.
5. If the user asks to "list", "show", "read", or "get", set \
intent="read".
6. For bulk operations (multiple records), return detail_lines array.
7. Return ONLY the JSON object, no markdown, no explanation.
"""


def _build_registry_context() -> tuple[str, str]:
    """Build the record type list and required fields for the LLM prompt."""
    rt_lines = []
    req_lines = []
    for name in list_record_types():
        rt = get_record_type(name)
        if rt:
            fields = [f.name for f in rt.header_fields]
            rt_lines.append(f"- {name} (module: {rt.module}) — fields: {', '.join(fields)}")
            req = get_required_fields(name)
            if req:
                req_lines.append(f"- {name}: {', '.join(req)}")
    return "\n".join(rt_lines), "\n".join(req_lines)


class HybridAgent:
    """GPT-4o parses intent, deterministic navigator executes."""

    def __init__(self) -> None:
        self._driver: webdriver.Chrome | None = None
        self._logged_in = False
        self._client: OpenAI | None = None
        self._stop_requested = False
        self._nav: PMWebNavigator | None = None

    def request_stop(self) -> None:
        self._stop_requested = True

    def _check_stop(self) -> bool:
        if self._stop_requested:
            self._stop_requested = False
            return True
        return False

    @property
    def client(self) -> OpenAI:
        if self._client is None:
            self._client = OpenAI(api_key=settings.openai_api_key)
        return self._client

    @property
    def driver(self) -> webdriver.Chrome:
        if self._driver is None:
            opts = Options()
            opts.add_argument("--no-sandbox")
            opts.add_argument("--disable-setuid-sandbox")
            opts.add_argument("--disable-dev-shm-usage")
            opts.add_argument("--window-size=1400,900")
            if settings.pmweb_headless:
                opts.add_argument("--headless=new")
            self._driver = webdriver.Chrome(options=opts)
        return self._driver

    @property
    def nav(self) -> PMWebNavigator:
        if self._nav is None:
            self._nav = PMWebNavigator(self.driver, settings.pmweb_base_url)
        return self._nav

    def login(self) -> dict[str, Any]:
        try:
            self.driver.get(settings.pmweb_base_url)
            time.sleep(5)
            try:
                user_field = WebDriverWait(self.driver, 10).until(
                    EC.presence_of_element_located((By.ID, "txtUserName"))
                )
                user_field.click()
                user_field.clear()
                user_field.send_keys(settings.pmweb_username)
                time.sleep(0.3)
            except Exception:
                try:
                    user_dd = self.driver.find_element(By.ID, "ddlUsers")
                    from selenium.webdriver.support.ui import Select
                    Select(user_dd).select_by_visible_text(settings.pmweb_username)
                    time.sleep(0.3)
                except Exception:
                    logger.warning("No username field found")
            pwd = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, "txtPassword"))
            )
            pwd.click()
            time.sleep(0.3)
            pwd.send_keys(settings.pmweb_password)
            time.sleep(0.5)
            self.driver.find_element(By.ID, "btnLogin").click()
            time.sleep(5)
            try:
                WebDriverWait(self.driver, 5).until(EC.alert_is_present()).accept()
                time.sleep(5)
            except Exception:
                time.sleep(3)
            if "Home" in self.driver.current_url or "Default" in self.driver.current_url:
                self._logged_in = True
                logger.info("Logged in as %s", settings.pmweb_username)
                return {"status": "success"}
            return {"status": "error", "message": "Login may have failed"}
        except Exception as exc:
            return {"status": "error", "message": str(exc)}

    def run_task_sync(self, task: str, history: list[dict[str, str]] | None = None) -> dict[str, Any]:
        return self._run_task_impl(task, history=history)

    def run_task_with_context(
        self, task: str, file_context: str = "", history: list[dict[str, str]] | None = None,
    ) -> dict[str, Any]:
        full = task
        if file_context:
            full = f"{task}\n\n--- Attached file ---\n{file_context[:5000]}"
        return self._run_task_impl(full, history=history)

    def _run_task_impl(self, task: str, history: list[dict[str, str]] | None = None) -> dict[str, Any]:
        self._stop_requested = False
        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {"reply": f"Cannot connect to PMWeb: {r.get('message')}", "actions": []}

        record_types_ctx, required_fields_ctx = _build_registry_context()
        system_prompt = INTENT_PROMPT.format(
            record_types=record_types_ctx,
            required_fields=required_fields_ctx,
        )

        messages: list[dict[str, str]] = [{"role": "system", "content": system_prompt}]
        if history:
            for msg in history[-10:]:
                messages.append({"role": msg.get("role", "user"), "content": msg.get("content", "")[:500]})
        messages.append({"role": "user", "content": task})

        response = self.client.chat.completions.create(
            model=settings.openai_model,
            messages=messages,
            temperature=0,
            max_tokens=2000,
        )
        raw = response.choices[0].message.content or "{}"

        try:
            start = raw.index("{")
            end = raw.rindex("}") + 1
            parsed = json.loads(raw[start:end])
        except (ValueError, json.JSONDecodeError):
            return {"reply": raw, "actions": []}

        intent = parsed.get("intent", "ask_user")

        if intent == "ask_user":
            return {"reply": parsed.get("message", "Could you provide more details?"), "actions": []}

        return self._execute_intent(parsed, task)

    # ── Deterministic execution ──────────────────────────────────────

    def _execute_intent(self, parsed: dict[str, Any], task: str) -> dict[str, Any]:
        """Execute a parsed intent using the deterministic navigator."""
        intent = parsed.get("intent", "")
        record_type_name = parsed.get("record_type", "")
        fields = parsed.get("fields", {})
        options = parsed.get("options", [])
        permissions = parsed.get("permissions", {})
        detail_lines = parsed.get("detail_lines", [])

        rt = get_record_type(record_type_name)
        results: list[dict[str, Any]] = []

        if intent == "read" or intent == "list":
            return self._execute_read(record_type_name, rt, results)

        if intent in ("create", "update"):
            return self._execute_create(record_type_name, rt, fields, options, permissions, detail_lines, results, task)

        return {"reply": f"Unknown intent: {intent}", "actions": results}

    def _execute_read(self, record_type_name: str, rt: Any, results: list) -> dict[str, Any]:
        """Navigate to the record type and read data."""
        step = 1
        if rt:
            if rt.url_fragment:
                r = self.nav.navigate(rt.url_fragment)
                results.append({"step": step, "action": "navigate", "result": r})
                step += 1
            if rt.uses_iframe:
                r = self.nav.switch_to_iframe(rt.iframe_id)
                results.append({"step": step, "action": "switch_to_iframe", "result": r})
                step += 1
        else:
            r = self.nav.navigate("/Home.aspx")
            results.append({"step": step, "action": "navigate", "result": r})
            step += 1

        data = self.nav.read_kendo_grid()
        results.append({"step": step, "action": "read_grid", "result": {"rows": len(data), "data": data[:10]}})

        summary = self._summarize(f"Read data for {record_type_name}", results)
        return {"reply": summary, "actions": results}

    def _execute_create(
        self, record_type_name: str, rt: Any,
        fields: dict, options: list, permissions: dict,
        detail_lines: list, results: list, task: str,
    ) -> dict[str, Any]:
        """Navigate, fill fields, set options/permissions, save."""
        step = 1

        # Navigate
        if rt and rt.url_fragment:
            r = self.nav.navigate(rt.url_fragment)
            results.append({"step": step, "action": "navigate", "result": r})
            step += 1
        elif rt:
            r = self.nav.navigate_to_record_type(rt.module, rt.menu_item)
            results.append({"step": step, "action": "navigate", "result": r})
            step += 1

        # Switch to iframe if needed
        if rt and rt.uses_iframe:
            r = self.nav.switch_to_iframe(rt.iframe_id)
            results.append({"step": step, "action": "switch_to_iframe", "result": r})
            step += 1

        # Handle Security-specific flows
        if record_type_name.lower() == "security groups":
            return self._create_security_group(fields, options, permissions, results, step, task)
        elif record_type_name.lower() == "users":
            return self._create_user(fields, results, step, task)

        # Generic record creation via breadcrumb/toolbar
        r = self.nav.click_new_record()
        results.append({"step": step, "action": "new_record", "result": r})
        step += 1

        # Fill header fields
        for field_name, value in fields.items():
            if value:
                r = self.nav.fill_field_by_label(field_name, str(value))
                results.append({"step": step, "action": f"fill_{field_name}", "result": r})
                step += 1

        # Add detail lines
        for line in detail_lines:
            r = self.nav.click_new_line()
            results.append({"step": step, "action": "new_line", "result": r})
            step += 1
            for col, val in line.items():
                if val:
                    r = self.nav.fill_field_by_label(col, str(val))
                    results.append({"step": step, "action": f"fill_{col}", "result": r})
                    step += 1

        # Save
        r = self.nav.click_save()
        results.append({"step": step, "action": "save", "result": r})

        summary = self._summarize(task, results)
        return {"reply": summary, "actions": results}

    # ── Security Group creation (deterministic) ──────────────────────

    def _create_security_group(
        self, fields: dict, options: list, permissions: dict,
        results: list, step: int, task: str,
    ) -> dict[str, Any]:
        # Click Groups tab
        r = self.nav.click_tab("Groups")
        results.append({"step": step, "action": "click_tab", "result": r})
        step += 1

        # Click New Group
        r = self.nav.click_toolbar_button("New Group")
        results.append({"step": step, "action": "click_new_group", "result": r})
        step += 1

        # Fill group name (textbox 0)
        name = fields.get("Group Name", fields.get("group_name", fields.get("name", "")))
        if name:
            r = self.nav.fill_kendo_textbox(0, name)
            results.append({"step": step, "action": "fill_group_name", "result": r})
            step += 1

        # Fill description (textbox 1)
        desc = fields.get("Description", fields.get("description", ""))
        if desc:
            r = self.nav.fill_kendo_textbox(1, desc)
            results.append({"step": step, "action": "fill_description", "result": r})
            step += 1

        # Set options
        for opt in options:
            r = self.nav.toggle_checkbox(opt, check=True)
            results.append({"step": step, "action": f"check_{opt}", "result": r})
            step += 1

        # Set module permissions
        for module, perm in permissions.items():
            r = self.nav.set_module_permission(module, perm)
            results.append({"step": step, "action": f"permission_{module}", "result": r})
            step += 1

        # Save
        r = self.nav.click_save()
        results.append({"step": step, "action": "save", "result": r})

        summary = self._summarize(task, results)
        return {"reply": summary, "actions": results}

    # ── User creation (deterministic) ────────────────────────────────

    def _create_user(
        self, fields: dict, results: list, step: int, task: str,
    ) -> dict[str, Any]:
        r = self.nav.click_tab("Users")
        results.append({"step": step, "action": "click_tab", "result": r})
        step += 1

        r = self.nav.click_new_line()
        results.append({"step": step, "action": "new_line", "result": r})
        step += 1

        cell_map = {
            "User ID": 3, "user_id": 3,
            "First Name": 5, "first_name": 5,
            "Last Name": 6, "last_name": 6,
            "Password": 11, "password": 11,
            "Email": 17, "email": 17,
        }
        dropdown_map = {
            "License Type": 8, "license_type": 8,
            "Named License": 9, "named_license": 9,
            "Group": 10, "group": 10,
        }

        for field_name, value in fields.items():
            if not value:
                continue
            if field_name in cell_map:
                r = self.nav.fill_grid_cell(cell_map[field_name], str(value))
                results.append({"step": step, "action": f"fill_{field_name}", "result": r})
                step += 1
            elif field_name in dropdown_map:
                r = self.nav.select_grid_cell_dropdown(dropdown_map[field_name], str(value))
                results.append({"step": step, "action": f"select_{field_name}", "result": r})
                step += 1

        r = self.nav.click_save()
        results.append({"step": step, "action": "save", "result": r})

        summary = self._summarize(task, results)
        return {"reply": summary, "actions": results}

    # ── Summarizer ───────────────────────────────────────────────────

    def _summarize(self, task: str, results: list) -> str:
        """Use LLM to summarize what was done."""
        try:
            resp = self.client.chat.completions.create(
                model=settings.openai_model,
                messages=[
                    {"role": "system", "content": "Summarize what was done on PMWeb. Be concise and friendly."},
                    {"role": "user", "content": f"Task: {task}\nResults:\n{json.dumps(results, indent=2, default=str)[:3000]}"},
                ],
                max_tokens=500,
            )
            return resp.choices[0].message.content or "Done."
        except Exception:
            has_errors = any("error" in r for r in results)
            return "Completed with some errors." if has_errors else "Done."

    # ── Learning hooks ───────────────────────────────────────────────

    def _store_learning(self, task: str, parsed: dict, results: list) -> None:
        try:
            from app.services.learning_store import LearningStore
            ls = LearningStore()
            has_err = any("error" in r for r in results)
            if has_err:
                ls.store_failure(task, [parsed], results)
            else:
                ls.store_success(task, [parsed], results)
        except Exception:
            pass

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
            self._nav = None
