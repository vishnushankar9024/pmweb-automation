"""PMWeb Automation Agent — 4-layer architecture.

Layer 1: pmweb_registry.py  — pure data (record types, fields, selectors)
Layer 2: pmweb_navigator.py — atomic DOM actions (click, fill, read)
Layer 3: pmweb_flows.py     — deterministic multi-step operation flows
Layer 4: browser_agent.py   — LLM intent parser, delegates to flows

This file is Layer 4. The LLM's ONLY job is to parse user intent into
structured JSON. All DOM interaction is deterministic.
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

from app.agent.pmweb_flows import PMWebFlows
from app.agent.pmweb_navigator import PMWebNavigator
from app.agent.pmweb_registry import RECORD_TYPES, get_record_type, get_required_fields
from app.config import settings

logger = logging.getLogger(__name__)


def _build_registry_context() -> tuple[str, str]:
    """Return prompt snippets derived from the deterministic PMWeb registry."""
    record_types = sorted({rt.name for rt in RECORD_TYPES.values()})
    record_types_ctx = "\n".join(f"- {name}" for name in record_types)

    required_lines = []
    for name in record_types:
        required = get_required_fields(name)
        if required:
            required_lines.append(f"- {name}: {', '.join(required)}")
    return record_types_ctx, "\n".join(required_lines)


INTENT_PROMPT = """\
You are a PMWeb automation assistant. Parse the user's request into JSON.

ALWAYS return a valid JSON object. Never refuse. Never say you can't understand.

## Available PMWeb Record Types
{record_types}

## Required Fields
{required_fields}

## JSON Format
{{
  "intent": "create | read | list | update | ask_user",
  "record_type": "<type name>",
  "fields": {{}},
  "message": "<question if ask_user>"
}}

## Intent Rules
- "build/create/make/add/set up" → intent="create"
- "show/list/read/get/find/what is/what are" → intent="read"
- If user gives enough details to create → intent="create" with fields filled
- If user says "generic/default/sample" → intent="create", generate reasonable values
- If essential info is missing AND user did NOT say generic → intent="ask_user"
- For "safety inspection form" → record_type="Inspections", intent depends on context
- For "build a form" → record_type="Adaptive Forms"
- For forms with specific fields → add form_fields array: [{{"label":"Name","field_type":"text"}}]
- For Security Groups, use fields["Group ID"] and fields["Description"]. Do not use "Group Name".
- NEVER return empty JSON or refuse. Always pick the best matching record type.
"""


class HybridAgent:
    """Layer 4: LLM intent parser → delegates to deterministic flows."""

    def __init__(self) -> None:
        self._driver: webdriver.Chrome | None = None
        self._logged_in = False
        self._client: OpenAI | None = None
        self._stop_requested = False
        self._nav: PMWebNavigator | None = None
        self._flows: PMWebFlows | None = None

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

    @property
    def flows(self) -> PMWebFlows:
        if self._flows is None:
            self._flows = PMWebFlows(self.nav)
        return self._flows

    # ── Login ────────────────────────────────────────────────────────

    def login(self) -> dict[str, Any]:
        try:
            self.driver.get(settings.pmweb_base_url)
            time.sleep(5)
            try:
                user_input = WebDriverWait(self.driver, 10).until(
                    EC.presence_of_element_located((By.ID, "cboUsers_Input"))
                )
                user_input.click()
                user_input.clear()
                user_input.send_keys(settings.pmweb_username)
                time.sleep(1)
                for opt in self.driver.find_elements(By.CSS_SELECTOR, "li.rcbItem, li.k-item"):
                    if settings.pmweb_username.lower() in opt.text.lower():
                        opt.click()
                        time.sleep(0.5)
                        break
            except Exception:
                try:
                    user_field = self.driver.find_element(By.ID, "txtUserName")
                    user_field.click()
                    user_field.clear()
                    user_field.send_keys(settings.pmweb_username)
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

    # ── Public API ───────────────────────────────────────────────────

    def run_task_sync(self, task: str, history: list[dict[str, str]] | None = None) -> dict[str, Any]:
        return self._run_task_impl(task, history=history)

    def run_task_with_context(
        self, task: str, file_context: str = "", history: list[dict[str, str]] | None = None,
    ) -> dict[str, Any]:
        full = task
        if file_context:
            full = f"{task}\n\n--- Attached file ---\n{file_context[:5000]}"
        return self._run_task_impl(full, history=history)

    # ── Core pipeline ────────────────────────────────────────────────

    def _run_task_impl(self, task: str, history: list[dict[str, str]] | None = None) -> dict[str, Any]:
        self._stop_requested = False
        if not task.strip():
            return {
                "reply": "Please describe what you want me to do in PMWeb.",
                "actions": [],
            }

        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {"reply": f"Cannot connect to PMWeb: {r.get('message')}", "actions": []}

        parsed = self._parse_intent(task, history)

        intent = parsed.get("intent", "ask_user")
        if intent == "ask_user":
            return {"reply": parsed.get("message", "Could you provide more details?"), "actions": []}

        if intent == "create":
            rt_name = parsed.get("record_type", "")
            fields = parsed.get("fields", {})
            filled = {k: v for k, v in fields.items() if v}
            req = get_required_fields(rt_name)
            if req and not filled:
                return {
                    "reply": (
                        f"I'll create a {rt_name} record. First I need: {', '.join(req)}. "
                        f"Please provide these details, or say 'generic' for defaults."
                    ),
                    "actions": [],
                }

        flow_result = self._dispatch_to_flow(parsed)

        self._store_learning(task, parsed, flow_result.steps)

        reply = self._build_reply(task, parsed, flow_result.steps)
        return {"reply": reply, "actions": flow_result.steps}

    # ── LLM intent parsing (Layer 4's only LLM use) ──────────────────

    def _parse_intent(self, task: str, history: list[dict[str, str]] | None = None) -> dict[str, Any]:
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

        try:
            response = self.client.chat.completions.create(
                model=settings.openai_model,
                messages=messages,
                temperature=0,
                max_tokens=1000,
            )
            raw = response.choices[0].message.content or "{}"
            start = raw.index("{")
            end = raw.rindex("}") + 1
            parsed = json.loads(raw[start:end])
            if parsed.get("intent") and parsed.get("record_type"):
                return parsed
        except Exception:
            logger.exception("Intent parsing failed for: %s", task[:100])

        return self._fallback_parse(task)

    def _fallback_parse(self, task: str) -> dict[str, Any]:
        """Rule-based fallback when LLM parsing fails."""
        t = task.lower()

        keyword_map = {
            "security group": "Security Groups",
            "adaptive form": "Adaptive Forms",
            "form builder": "Adaptive Forms",
            "build a form": "Adaptive Forms",
            "build a safety": "Adaptive Forms",
            "build a inspection": "Adaptive Forms",
            "safety inspection form": "Adaptive Forms",
            "inspection form": "Adaptive Forms",
            "custom form": "Adaptive Forms",
            "user": "Users",
            "inspection": "Inspections",
            "safety": "Safety Forms",
            "rfi": "RFIs",
            "punch list": "Punch Lists",
            "daily report": "Daily Reports",
            "meeting minute": "Meeting Minutes",
            "action item": "Action Items",
            "correspondence": "Correspondence",
            "transmittal": "Transmittals",
            "drawing": "Drawing Lists",
            "submittal": "Online Submittals",
            "budget": "Budgets",
            "commitment": "Commitments",
            "contract": "Prime Contracts",
            "invoice": "Progress Invoices",
            "work order": "Work Orders",
            "schedule": "Schedules",
            "project": "Projects",
            "program": "Programs",
            "company": "Companies",
            "estimate": "Estimates",
            "bid": "Bid Packages",
            "form": "Adaptive Forms",
            "workflow": "Business Processes",
            "equipment": "Equipment",
            "lease": "Leases",
            "location": "Locations",
            "initiative": "Initiatives",
            "funding": "Funding Records",
            "change event": "Change Events",
            "change order": "Commitment COs",
            "change request": "Online Change Requests",
            "risk": "Risk Analysis",
            "timesheet": "Timesheets",
            "forecast": "Forecasts",
            "document": "Document Manager",
        }

        record_type = ""
        for keyword, rt_name in keyword_map.items():
            if keyword in t:
                record_type = rt_name
                break

        create_words = ["create", "build", "make", "add", "set up", "new"]
        read_words = ["show", "list", "read", "get", "find", "what", "last", "current", "view"]

        intent = "ask_user"
        if any(w in t for w in create_words):
            intent = "create"
        elif any(w in t for w in read_words):
            intent = "read"

        if not record_type:
            return {
                "intent": "ask_user",
                "record_type": "",
                "fields": {},
                "message": (
                    "I can help with that. Which PMWeb record type are you looking for? "
                    "For example: Security Groups, Inspections, Work Orders, RFIs, Budgets, or Schedules."
                ),
            }

        if intent == "create":
            req = get_required_fields(record_type)
            if req:
                return {
                    "intent": "ask_user",
                    "record_type": record_type,
                    "fields": {},
                    "message": f"To create a {record_type} record, I need: {', '.join(req)}. Please provide these details, or say 'generic' for defaults.",
                }

        return {"intent": intent, "record_type": record_type, "fields": {}}

    # ── Flow dispatch ────────────────────────────────────────────────

    def _dispatch_to_flow(self, parsed: dict[str, Any]) -> Any:
        """Route parsed intent to the correct deterministic flow."""
        from app.agent.pmweb_flows import FlowResult

        intent = parsed.get("intent", "")
        record_type_name = parsed.get("record_type", "")
        fields = parsed.get("fields", {})
        options = parsed.get("options", [])
        permissions = parsed.get("permissions", {})
        detail_lines = parsed.get("detail_lines", [])
        form_fields = parsed.get("form_fields", [])
        workflow = parsed.get("workflow", {})

        rt = get_record_type(record_type_name)

        # Read / list
        if intent in ("read", "list"):
            return self.flows.read_records(rt, record_type_name)

        # Specific record type flows
        rt_lower = record_type_name.lower()

        if rt_lower == "security groups" and rt:
            return self.flows.create_security_group(rt, fields, options, permissions)

        if rt_lower == "users" and rt:
            return self.flows.create_user(rt, fields)

        if rt_lower in ("adaptive form builder", "adaptive forms") and form_fields:
            title = fields.get("title", fields.get("Title", "New Form"))
            return self.flows.create_adaptive_form(title, form_fields)

        if workflow and workflow.get("bpm_id"):
            return self.flows.create_bpm_workflow(
                bpm_id=workflow["bpm_id"],
                name=workflow.get("name", ""),
                statuses=workflow.get("statuses"),
                roles=workflow.get("roles"),
            )

        if rt_lower == "business processes" and fields:
            bpm_id = fields.get("BPM ID", fields.get("bpm_id", fields.get("id", "")))
            bpm_name = fields.get("Template Name", fields.get("name", fields.get("Name", "")))
            if bpm_id:
                return self.flows.create_bpm_workflow(bpm_id=bpm_id, name=bpm_name)

        # Bulk creation
        if detail_lines and len(detail_lines) > 1 and rt:
            return self.flows.create_bulk_records(rt, detail_lines)

        # Generic record creation
        if rt and intent in ("create", "update"):
            return self.flows.create_record(rt, fields, detail_lines or None)

        # Fallback
        result = FlowResult()
        result.add_error("dispatch", f"no flow for intent={intent}, record_type={record_type_name}")
        return result

    # ── Summarizer ───────────────────────────────────────────────────

    def _build_reply(self, task: str, parsed: dict[str, Any], results: list[dict[str, Any]]) -> str:
        intent = str(parsed.get("intent", "")).strip().lower()
        normalized_task = task.lower()
        if intent in ("read", "list") or "security group" in normalized_task:
            read_reply = self._format_read_reply(parsed, results, task=task)
            if read_reply:
                return read_reply
        return self._summarize(task, results)

    @staticmethod
    def _value_from_row(row: dict[str, Any], *aliases: str) -> str:
        normalized = {
            str(key).lower().replace(" ", "").replace("_", ""): str(value).strip()
            for key, value in row.items()
            if value is not None
        }
        for alias in aliases:
            value = normalized.get(alias.lower().replace(" ", "").replace("_", ""))
            if value:
                return value
        return ""

    @staticmethod
    def _coerce_json_dict(value: Any) -> dict[str, Any] | None:
        if isinstance(value, dict):
            return value
        if isinstance(value, str):
            try:
                decoded = json.loads(value)
            except Exception:
                return None
            if isinstance(decoded, dict):
                return decoded
        return None

    def _extract_grid_result(self, results: list[dict[str, Any]]) -> dict[str, Any] | None:
        grid_result: dict[str, Any] | None = None
        for step in results:
            parsed_result = self._coerce_json_dict(step.get("result"))
            if (
                step.get("action") == "read_grid"
                and parsed_result
                and isinstance(parsed_result.get("data"), list)
            ):
                return parsed_result
            if parsed_result and isinstance(parsed_result.get("data"), list):
                grid_result = parsed_result
                continue

            parsed_output = self._coerce_json_dict(step.get("output"))
            if parsed_output and isinstance(parsed_output.get("data"), list):
                grid_result = parsed_output
        return grid_result

    def _format_read_reply(
        self, parsed: dict[str, Any], results: list[dict[str, Any]], task: str = "",
    ) -> str | None:
        grid_result = self._extract_grid_result(results)

        if grid_result is None:
            return None

        data = grid_result.get("data")
        if not isinstance(data, list):
            return None

        record_type = str(parsed.get("record_type", grid_result.get("record_type", "records"))).strip()
        if not record_type or record_type.lower() == "records":
            if "security group" in task.lower():
                record_type = "Security Groups"
        if not data:
            return f"No {record_type.lower()} were found."

        if record_type.lower() == "security groups" or "security group" in task.lower():
            lines: list[str] = []
            for index, row in enumerate(data, start=1):
                if not isinstance(row, dict):
                    continue
                group_id = self._value_from_row(
                    row,
                    "Group ID",
                    "Group",
                    "Group Name",
                    "ID",
                    "Name",
                    "col_0",
                )
                description = self._value_from_row(
                    row,
                    "Description",
                    "Group Description",
                    "col_1",
                )
                if group_id and description and group_id.lower() != description.lower():
                    lines.append(f"{index}. {group_id} — {description}")
                elif group_id:
                    lines.append(f"{index}. {group_id}")
                elif description:
                    lines.append(f"{index}. {description}")

            if lines:
                # Return the direct answer content (group entries) without
                # procedural narration/wrappers for "list all security groups".
                return "\n".join(lines)

        rows: list[str] = []
        for index, row in enumerate(data, start=1):
            if isinstance(row, dict):
                columns = [f"{key}: {value}" for key, value in row.items() if str(value).strip()]
                if columns:
                    rows.append(f"{index}. " + " | ".join(columns))
            elif row:
                rows.append(f"{index}. {row}")

        if rows:
            return f"{record_type} ({len(rows)} rows):\n" + "\n".join(rows)
        return None

    def _summarize(self, task: str, results: list[dict[str, Any]]) -> str:
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

    # ── Learning ─────────────────────────────────────────────────────

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
            self._flows = None
