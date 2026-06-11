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
import re
import time
from ast import literal_eval
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

        # Keep this high-frequency read path deterministic so users always get
        # the full list content instead of a procedural summary.
        if self._is_security_group_list_task(task):
            parsed = {"intent": "read", "record_type": "Security Groups", "fields": {}}
            flow_result = self._dispatch_to_flow(parsed)
            self._store_learning(task, parsed, flow_result.steps)
            grid_result = self._extract_grid_result(flow_result.steps)
            expected_rows = self._reported_row_count(grid_result) if grid_result else None
            if (
                expected_rows is None
                and self._nav is not None
                and hasattr(self._nav, "get_kendo_total_rows")
            ):
                try:
                    nav_total = self._nav.get_kendo_total_rows()
                    if isinstance(nav_total, int) and nav_total > 0:
                        expected_rows = nav_total
                except Exception:
                    logger.debug("Could not read pager total rows from navigator", exc_info=True)

            direct_read_cap = min(max(expected_rows or 1000, 1000), 5000)
            # Prefer the flow payload first (it already reflects deterministic
            # retries), then use direct-read fallback when needed.
            reply = self._format_read_reply(parsed, flow_result.steps, task=task)
            reply = self._strip_procedural_security_narration(reply)
            # When flow payloads omit row-count metadata, we still compare
            # against a direct navigator read and keep the richer concrete list.
            if (
                expected_rows is None
                or not reply
                or self._security_group_reply_is_partial(flow_result.steps, reply)
                or self._looks_like_procedural_security_summary(reply)
            ):
                direct_reply = self._direct_security_group_read_reply(max_rows=direct_read_cap)
                if direct_reply:
                    direct_reply = self._strip_procedural_security_narration(direct_reply)
                    if (
                        not reply
                        or self._rendered_row_count(direct_reply) >= self._rendered_row_count(reply)
                    ):
                        reply = direct_reply
            if (
                not reply
                or not self._reply_contains_numbered_rows(reply)
                or self._security_group_reply_is_partial(flow_result.steps, reply)
                or self._looks_like_procedural_security_summary(reply)
            ):
                reply = self._resolve_security_group_reply(task, flow_result.steps, reply)
            if reply and self._looks_like_procedural_security_summary(reply):
                reply = self._resolve_security_group_reply(task, flow_result.steps, reply)
            if not reply:
                reply = self._resolve_security_group_reply(task, flow_result.steps, reply)
            reply = self._answer_only_security_group_reply(reply)
            if reply and not self._reply_contains_numbered_rows(reply):
                resolved_reply = self._resolve_security_group_reply(task, flow_result.steps, reply)
                resolved_reply = self._answer_only_security_group_reply(resolved_reply)
                if resolved_reply and self._reply_contains_numbered_rows(resolved_reply):
                    reply = resolved_reply
                else:
                    reply = None
            reply = self._strip_security_group_step_numbers(reply)
            return {
                "reply": reply or "I couldn't extract the security group rows from PMWeb. Please try again.",
                # Hide internal execution steps for the list/read UX so the chat
                # only shows the answer content, not procedural action cards.
                "actions": [],
            }

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
        reply = self._strip_procedural_security_narration(reply)
        if (
            "security group" in self._primary_task_text(task).lower()
            and reply
            and self._looks_like_procedural_security_summary(reply)
        ):
            forced_reply = self._resolve_security_group_reply(task, flow_result.steps, reply)
            if forced_reply:
                reply = forced_reply
            else:
                reply = "I couldn't extract the security group rows from PMWeb. Please try again."
        if self._is_security_group_read_intent(task, parsed, flow_result.steps):
            deterministic_reply = self._deterministic_security_group_reply(task, flow_result.steps)
            if deterministic_reply and self._reply_contains_numbered_rows(deterministic_reply):
                reply = deterministic_reply
            elif (
                not reply
                or not self._reply_contains_numbered_rows(reply)
                or self._looks_like_procedural_security_summary(reply)
                or self._security_group_reply_is_partial(flow_result.steps, reply)
            ):
                reply = "I couldn't extract the security group rows from PMWeb. Please try again."
            reply = self._answer_only_security_group_reply(reply)
            if not reply or not self._reply_contains_numbered_rows(reply):
                reply = "I couldn't extract the security group rows from PMWeb. Please try again."
            reply = self._strip_security_group_step_numbers(reply)
        if self._should_hide_actions(task, parsed, flow_result.steps):
            return {"reply": reply, "actions": []}
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

    @staticmethod
    def _primary_task_text(task: str) -> str:
        """Return the user-facing task text without appended attachment context."""
        marker = "\n\n--- Attached file ---"
        if marker in task:
            return task.split(marker, 1)[0].strip()
        return task.strip()

    @staticmethod
    def _mentions_security_groups(text: str) -> bool:
        return bool(re.search(r"\bsecurity[\s_-]*groups?\b", text.lower()))

    @staticmethod
    def _is_security_group_list_task(task: str) -> bool:
        lowered = HybridAgent._primary_task_text(task).lower()
        if not HybridAgent._mentions_security_groups(lowered):
            return False

        read_signals = (
            "list",
            "show",
            "read",
            "get",
            "find",
            "display",
            "provide",
            "report",
            "show me",
            "give me",
            "all",
            "what are",
            "what's",
        )
        create_signals = ("create", "build", "make", "add", "set up", "new security group")
        return HybridAgent._contains_phrase(lowered, read_signals) and not HybridAgent._contains_phrase(
            lowered, create_signals
        )

    def _is_security_group_read_intent(
        self,
        task: str,
        parsed: dict[str, Any],
        results: list[dict[str, Any]],
    ) -> bool:
        intent = str(parsed.get("intent", "")).strip().lower()
        if self._is_security_group_list_task(task):
            return True
        if intent not in ("read", "list"):
            return False
        parsed_record_type = str(parsed.get("record_type", "")).strip()
        if self._mentions_security_groups(parsed_record_type):
            return True
        return self._looks_like_security_group_list(task, parsed, results)

    @staticmethod
    def _contains_phrase(text: str, phrases: tuple[str, ...]) -> bool:
        """Return True when any phrase appears as a whole word/phrase."""
        for phrase in phrases:
            stripped = phrase.strip().lower()
            if not stripped:
                continue
            pattern = r"\b" + re.escape(stripped).replace(r"\ ", r"\s+") + r"\b"
            if re.search(pattern, text):
                return True
        return False

    @staticmethod
    def _looks_like_procedural_security_summary(reply: str) -> bool:
        """Detect narrative summaries that should be replaced with concrete group rows."""
        has_signal = HybridAgent._contains_procedural_security_narration(reply)
        has_numbered_rows = bool(re.search(r"^\s*\d+\.\s+", reply, re.MULTILINE))
        return has_signal and not has_numbered_rows

    @staticmethod
    def _contains_procedural_security_narration(reply: str) -> bool:
        lowered = reply.lower()
        procedural_signals = (
            "task of listing",
            "task was performed",
            "was completed",
            "process involved",
            "navigating to",
            "navigated to",
            "switching to",
            "switched to",
            "iframe",
            "reading the",
            "found ",
            "a total of",
            "total of",
            "result was a list of",
            "including",
            "rows were identified",
            "sample of groups",
            "among others",
        )
        regex_signals = (
            r"\btotal of\s+\d+\s+rows?\b",
            r"\bsample of\s+(?:security\s+)?groups?\b",
        )
        return any(signal in lowered for signal in procedural_signals) or any(
            re.search(pattern, lowered) for pattern in regex_signals
        )

    @staticmethod
    def _strip_procedural_security_narration(reply: str | None) -> str | None:
        """When narration wraps numbered rows, keep only concrete row lines."""
        if not reply:
            return reply
        if not HybridAgent._contains_procedural_security_narration(reply):
            return reply
        numbered_rows = [
            line.strip()
            for line in reply.splitlines()
            if re.match(r"^\s*\d+\.\s+\S", line)
        ]
        if not numbered_rows:
            return reply
        return "\n".join(numbered_rows)

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
            normalized_record_type_name = record_type_name
            if self._mentions_security_groups(record_type_name):
                normalized_record_type_name = "Security Groups"
                rt = get_record_type(normalized_record_type_name)
            return self.flows.read_records(rt, normalized_record_type_name)

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
        looks_like_security_groups = self._looks_like_security_group_list(task, parsed, results)
        if intent in ("read", "list") or looks_like_security_groups:
            read_reply = self._format_read_reply(parsed, results, task=task)
            if read_reply:
                if looks_like_security_groups and self._security_group_reply_is_partial(results, read_reply):
                    complete_reply = self._resolve_security_group_reply(task, results, read_reply)
                    if complete_reply:
                        return complete_reply
                    # Enforce complete security-group answers: when we cannot
                    # recover from a sampled/partial payload, do not return a
                    # truncated list.
                    read_reply = None
                else:
                    return read_reply
            record_type = str(parsed.get("record_type", "")).strip().lower()
            security_group_read = looks_like_security_groups or record_type == "security groups"
            if security_group_read:
                complete_reply = self._resolve_security_group_reply(task, results, None)
                if complete_reply:
                    return complete_reply
                return "I couldn't extract the security group rows from PMWeb. Please try again."
        return self._summarize(task, results)

    def _deterministic_security_group_reply(self, task: str, results: list[dict[str, Any]]) -> str | None:
        """Return a direct security-group listing when deterministic row data exists."""
        parsed = {"intent": "read", "record_type": "Security Groups"}
        read_reply = self._format_read_reply(parsed, results, task=task)
        if (
            read_reply
            and self._reply_contains_numbered_rows(read_reply)
            and not self._security_group_reply_is_partial(results, read_reply)
        ):
            return read_reply
        return self._resolve_security_group_reply(task, results, read_reply)

    @staticmethod
    def _reply_contains_numbered_rows(reply: str | None) -> bool:
        if not reply:
            return False
        return bool(re.search(r"^\s*\d+\.\s+\S", reply, flags=re.MULTILINE))

    @staticmethod
    def _rendered_row_count(reply: str | None) -> int:
        if not reply:
            return 0
        return sum(
            1 for line in reply.splitlines() if re.match(r"^\s*\d+\.\s+\S", line)
        )

    @staticmethod
    def _answer_only_security_group_reply(reply: str | None) -> str | None:
        """Keep only numbered rows for security-group list/read responses."""
        if not reply:
            return reply
        numbered_lines = [
            line.strip()
            for line in reply.splitlines()
            if re.match(r"^\s*\d+\.\s+\S", line)
        ]
        if numbered_lines:
            return "\n".join(numbered_lines)
        if HybridAgent._contains_procedural_security_narration(reply):
            return None
        return reply

    @staticmethod
    def _strip_security_group_step_numbers(reply: str | None) -> str | None:
        """Strip numeric list prefixes so UI shows answer text, not steps."""
        if not reply:
            return reply

        cleaned_lines: list[str] = []
        for line in reply.splitlines():
            stripped = line.strip()
            if not stripped:
                continue
            cleaned_lines.append(re.sub(r"^\d+\.\s+", "", stripped))

        return "\n".join(cleaned_lines) if cleaned_lines else None

    @staticmethod
    def _reply_is_partial_for_rows(reply: str | None, expected_rows: int | None) -> bool:
        if not reply or expected_rows is None or expected_rows <= 0:
            return False
        rendered_rows = HybridAgent._rendered_row_count(reply)
        return rendered_rows != expected_rows

    def _resolve_security_group_reply(
        self,
        task: str,
        results: list[dict[str, Any]],
        initial_reply: str | None,
    ) -> str | None:
        """Prefer a complete security-group reply over sampled rows."""
        if initial_reply and self._looks_like_procedural_security_summary(initial_reply):
            initial_reply = None
        initial_reply = self._strip_procedural_security_narration(initial_reply)
        grid_result = self._extract_grid_result(results)
        expected_rows = self._reported_row_count(grid_result) if grid_result else None
        if (
            expected_rows is None
            and self._nav is not None
            and hasattr(self._nav, "get_kendo_total_rows")
        ):
            try:
                nav_total = self._nav.get_kendo_total_rows()
                if isinstance(nav_total, int) and nav_total > 0:
                    expected_rows = nav_total
            except Exception:
                logger.debug("Could not read pager total rows from navigator", exc_info=True)
        sampled_payload = bool(grid_result and self._grid_payload_is_sampled(grid_result))

        best_reply = initial_reply
        best_rows = self._rendered_row_count(initial_reply)
        if initial_reply and not self._reply_contains_numbered_rows(initial_reply):
            best_rows = 0
        if (
            initial_reply
            and self._reply_contains_numbered_rows(initial_reply)
            and not self._reply_is_partial_for_rows(initial_reply, expected_rows)
            and not sampled_payload
        ):
            return initial_reply

        retry_reply = self._retry_security_group_read_reply(task)
        if retry_reply:
            retry_reply = self._strip_procedural_security_narration(retry_reply)
            retry_rows = self._rendered_row_count(retry_reply)
            if retry_rows > best_rows:
                best_reply = retry_reply
                best_rows = retry_rows
            if not self._reply_is_partial_for_rows(retry_reply, expected_rows):
                return retry_reply

        direct_cap = min(max(expected_rows or 1000, 1000), 5000)
        direct_reply = self._direct_security_group_read_reply(max_rows=direct_cap)
        if direct_reply:
            direct_reply = self._strip_procedural_security_narration(direct_reply)
            direct_rows = self._rendered_row_count(direct_reply)
            if direct_rows > best_rows:
                best_reply = direct_reply
            if not self._reply_is_partial_for_rows(direct_reply, expected_rows):
                return direct_reply

        if self._reply_is_partial_for_rows(best_reply, expected_rows):
            return None
        if sampled_payload and best_reply and self._reply_contains_numbered_rows(best_reply):
            return None
        # Never allow prose-only security-group responses to pass through.
        if best_reply and not self._reply_contains_numbered_rows(best_reply):
            return None
        return self._strip_procedural_security_narration(best_reply)

    def _retry_security_group_read_reply(self, task: str) -> str | None:
        """Best-effort deterministic re-read when initial read payload is malformed."""
        if self._flows is None:
            return None
        try:
            security_rt = get_record_type("Security Groups")
            if security_rt is None:
                return None
            retry_result = self._flows.read_records(security_rt, "Security Groups")
            retry_parsed = {"intent": "read", "record_type": "Security Groups"}
            return self._format_read_reply(retry_parsed, retry_result.steps, task=task)
        except Exception:
            logger.exception("Security-group read retry failed")
            return None

    def _direct_security_group_read_reply(self, max_rows: int = 1000) -> str | None:
        """Final fallback: read rows directly from navigator and format."""
        if self._nav is None:
            return None
        try:
            rows = self._nav.read_security_groups(max_rows=max_rows)
        except Exception:
            logger.exception("Direct security-group read fallback failed")
            return None

        if not isinstance(rows, list) or not rows:
            return None

        lines: list[str] = []
        for index, row in enumerate(rows, start=1):
            group_id, description = self._security_group_values(row)
            if group_id and description and group_id.lower() != description.lower():
                lines.append(f"{index}. {group_id} — {description}")
            elif group_id:
                lines.append(f"{index}. {group_id}")
            elif description:
                lines.append(f"{index}. {description}")
        return "\n".join(lines) if lines else None

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
    def _ordered_row_values(row: dict[str, Any]) -> list[str]:
        """Return non-empty row values in deterministic left-to-right order."""
        indexed_columns: list[tuple[int, str]] = []
        fallback_columns: list[str] = []

        for key, value in row.items():
            text_value = str(value).strip() if value is not None else ""
            if not text_value:
                continue
            key_text = str(key).strip().lower()
            match = re.fullmatch(r"col[_\s-]?(\d+)", key_text)
            if match:
                indexed_columns.append((int(match.group(1)), text_value))
            else:
                fallback_columns.append(text_value)

        ordered_values = [value for _, value in sorted(indexed_columns, key=lambda item: item[0])]
        ordered_values.extend(fallback_columns)
        return ordered_values

    def _security_group_values(self, row: Any) -> tuple[str, str]:
        """Extract security group id/description across varied payload shapes."""
        if isinstance(row, dict):
            group_id = self._value_from_row(
                row,
                "Group ID",
                "Group",
                "Group Name",
                "ID",
                "Name",
                "col_0",
                "col_1",
                "col_2",
                "col_3",
            )
            description = self._value_from_row(
                row,
                "Description",
                "Group Description",
                "col_4",
                "col_3",
                "col_2",
                "col_1",
            )
            ordered_values = self._ordered_row_values(row)
            if not group_id and ordered_values:
                group_id = ordered_values[0]
            if not description:
                for candidate in ordered_values[1:]:
                    if candidate.lower() != group_id.lower():
                        description = candidate
                        break
            return group_id, description

        if isinstance(row, (list, tuple)):
            values = [str(item).strip() for item in row if str(item).strip()]
            if not values:
                return "", ""
            if len(values) == 1:
                return values[0], ""
            return values[0], values[1]

        if isinstance(row, str):
            return row.strip(), ""

        return "", ""

    @staticmethod
    def _coerce_json_value(value: Any) -> dict[str, Any] | list[Any] | None:
        if isinstance(value, dict):
            return value
        if isinstance(value, list):
            return value
        if isinstance(value, str):
            try:
                decoded = json.loads(value)
            except Exception:
                try:
                    decoded = literal_eval(value)
                except Exception:
                    return None
            if isinstance(decoded, (dict, list)):
                return decoded
        return None

    def _extract_rows(self, payload: Any) -> list[Any] | None:
        if isinstance(payload, list):
            return payload

        payload_value = self._coerce_json_value(payload)
        if not isinstance(payload_value, dict):
            return None

        candidates: list[tuple[int, int, list[Any]]] = []
        list_keys = (
            "groups",
            "group_rows",
            "data",
            "rows_data",
            "items",
            "records",
            "rows",
            "sample_rows",
            "sample",
        )
        for key in list_keys:
            value = payload_value.get(key)
            if not isinstance(value, list):
                continue
            normalized_key = key.lower()
            is_sample = "sample" in normalized_key
            quality = 0 if is_sample else 1
            candidates.append((quality, len(value), value))

        # Evaluate nested payload objects as candidates too so we can choose the
        # most complete non-sampled rows set instead of the first key hit.
        for key in ("result", "output", "payload", "response", "details"):
            nested_rows = self._extract_rows(payload_value.get(key))
            if nested_rows is not None:
                candidates.append((1, len(nested_rows), nested_rows))

        for value in payload_value.values():
            nested_rows = self._extract_rows(value)
            if nested_rows is not None:
                candidates.append((1, len(nested_rows), nested_rows))

        if not candidates:
            return None

        candidates.sort(key=lambda candidate: (candidate[0], candidate[1]), reverse=True)
        return candidates[0][2]

    def _extract_grid_result(self, results: list[dict[str, Any]]) -> dict[str, Any] | None:
        grid_result: dict[str, Any] | None = None
        for step in results:
            parsed_result = self._coerce_json_value(step.get("result"))
            result_rows = self._extract_rows(parsed_result)
            if result_rows is not None:
                enriched = dict(parsed_result) if isinstance(parsed_result, dict) else {}
                enriched["data"] = result_rows
                if step.get("record_type") and not enriched.get("record_type"):
                    enriched["record_type"] = step["record_type"]
                if step.get("action") == "read_grid":
                    return enriched
                grid_result = enriched
                continue

            parsed_output = self._coerce_json_value(step.get("output"))
            output_rows = self._extract_rows(parsed_output)
            if output_rows is not None:
                enriched = dict(parsed_output) if isinstance(parsed_output, dict) else {}
                enriched["data"] = output_rows
                if step.get("record_type") and not enriched.get("record_type"):
                    enriched["record_type"] = step["record_type"]
                if step.get("action") == "read_grid":
                    return enriched
                grid_result = enriched
                continue

            if isinstance(step.get("data"), list):
                grid_result = {"data": step.get("data")}
        return grid_result

    def _looks_like_security_group_list(self, task: str, parsed: dict[str, Any], results: list[dict[str, Any]]) -> bool:
        task_text = self._primary_task_text(task).lower()
        if self._mentions_security_groups(task_text):
            return True
        record_type = str(parsed.get("record_type", "")).strip().lower()
        if self._mentions_security_groups(record_type):
            return True
        grid_result = self._extract_grid_result(results)
        if not grid_result:
            return False
        grid_record_type = str(grid_result.get("record_type", "")).strip().lower()
        if grid_record_type == "security groups":
            return True
        data = grid_result.get("data")
        if not isinstance(data, list):
            return False
        for row in data:
            group_id, description = self._security_group_values(row)
            if group_id or description:
                return True
        return False

    def _should_hide_actions(self, task: str, parsed: dict[str, Any], results: list[dict[str, Any]]) -> bool:
        """Hide internal execution actions for security-group list/read responses."""
        intent = str(parsed.get("intent", "")).strip().lower()
        if intent not in ("read", "list"):
            return False
        return self._is_security_group_list_task(task) or self._looks_like_security_group_list(task, parsed, results)

    @staticmethod
    def _reported_row_count(grid_result: dict[str, Any]) -> int | None:
        candidates: list[int] = []
        for key in ("rows", "row_count", "total_rows", "total", "count"):
            value = grid_result.get(key)
            if isinstance(value, int) and value >= 0:
                candidates.append(value)
            if isinstance(value, str):
                candidate = value.strip()
                if candidate.isdigit():
                    candidates.append(int(candidate))
        return max(candidates) if candidates else None

    @staticmethod
    def _grid_payload_is_sampled(grid_result: dict[str, Any]) -> bool:
        """Detect payloads that only include sampled rows (not full dataset)."""
        data = grid_result.get("data")
        if not isinstance(data, list):
            return False

        reported_rows = HybridAgent._reported_row_count(grid_result)

        sample_rows = grid_result.get("sample_rows")
        if isinstance(sample_rows, list) and sample_rows and len(data) == len(sample_rows):
            if reported_rows is None or reported_rows > len(data):
                return True

        sample = grid_result.get("sample")
        if isinstance(sample, list) and sample and len(data) == len(sample):
            if reported_rows is None or reported_rows > len(data):
                return True

        return False

    def _security_group_reply_is_partial(self, results: list[dict[str, Any]], reply: str) -> bool:
        grid_result = self._extract_grid_result(results)
        if not grid_result:
            return False
        if self._grid_payload_is_sampled(grid_result):
            return True
        reported_rows = self._reported_row_count(grid_result)
        return self._reply_is_partial_for_rows(reply, reported_rows)

    def _format_read_reply(
        self, parsed: dict[str, Any], results: list[dict[str, Any]], task: str = "",
    ) -> str | None:
        grid_result = self._extract_grid_result(results)

        if grid_result is None:
            return None

        data = grid_result.get("data")
        if not isinstance(data, list):
            return None

        parsed_record_type = str(parsed.get("record_type", "")).strip()
        record_type = parsed_record_type or str(grid_result.get("record_type", "records")).strip()
        task_text = self._primary_task_text(task).lower()
        if not record_type or record_type.lower() == "records":
            if self._mentions_security_groups(task_text):
                record_type = "Security Groups"
        if not data:
            return f"No {record_type.lower()} were found."

        if self._mentions_security_groups(record_type) or self._mentions_security_groups(task_text):
            lines: list[str] = []
            for index, row in enumerate(data, start=1):
                group_id, description = self._security_group_values(row)
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
        # Never narrate procedural steps for security-group list/read requests.
        if self._is_security_group_list_task(task) or self._looks_like_security_group_list(task, {}, results):
            deterministic_reply = self._deterministic_security_group_reply(task, results)
            deterministic_reply = self._answer_only_security_group_reply(deterministic_reply)
            if deterministic_reply and self._reply_contains_numbered_rows(deterministic_reply):
                return deterministic_reply
            return "I couldn't extract the security group rows from PMWeb. Please try again."

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
