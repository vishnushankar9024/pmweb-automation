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
from app.agent.pmweb_registry import get_record_type, get_required_fields, list_record_types
from app.config import settings

logger = logging.getLogger(__name__)

INTENT_PROMPT = """\
You are a PMWeb automation assistant. Parse the user's request and output \
a JSON object describing what they want to do.

## Available PMWeb Record Types
{record_types}

## Output Format
Return ONLY a JSON object:
{{
  "intent": "create" | "read" | "update" | "delete" | "list" | "ask_user",
  "record_type": "<exact name from list above>",
  "fields": {{"<field_name>": "<value>", ...}},
  "detail_lines": [{{"<column>": "<value>", ...}}, ...],
  "options": ["<option to check>", ...],
  "permissions": {{"<module>": "<View|Create|Edit|Delete|Full Control>", ...}},
  "form_fields": [{{"label": "Name", "field_type": "text", "choices": []}}, ...],
  "workflow": {{"bpm_id": "", "name": "", "statuses": [{{"name": ""}}], "roles": []}},
  "message": "<only for ask_user — question to ask>"
}}

## Rules
1. Ask for required fields if missing. Set intent="ask_user".
2. Required fields: {required_fields}
3. "generic"/"default"/"sample" → generate reasonable values, intent="create".
4. File attached ("--- Attached file ---") → extract values, use directly.
5. "list"/"show"/"read"/"get" → intent="read".
6. Bulk operations → detail_lines array.
7. For adaptive forms → populate form_fields array.
8. For workflows → populate workflow object.
9. Return ONLY JSON, no markdown.
"""


def _build_registry_context() -> tuple[str, str]:
    rt_lines, req_lines = [], []
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
        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {"reply": f"Cannot connect to PMWeb: {r.get('message')}", "actions": []}

        parsed = self._parse_intent(task, history)
        if parsed is None:
            return {"reply": "I couldn't understand that request. Could you rephrase?", "actions": []}

        intent = parsed.get("intent", "ask_user")
        if intent == "ask_user":
            return {"reply": parsed.get("message", "Could you provide more details?"), "actions": []}

        flow_result = self._dispatch_to_flow(parsed)

        self._store_learning(task, parsed, flow_result.steps)

        summary = self._summarize(task, flow_result.steps)
        return {"reply": summary, "actions": flow_result.steps}

    # ── LLM intent parsing (Layer 4's only LLM use) ──────────────────

    def _parse_intent(self, task: str, history: list[dict[str, str]] | None = None) -> dict[str, Any] | None:
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
            return json.loads(raw[start:end])
        except (ValueError, json.JSONDecodeError):
            logger.warning("Failed to parse LLM output: %s", raw[:200])
            return None

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

    def _summarize(self, task: str, results: list) -> str:
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
