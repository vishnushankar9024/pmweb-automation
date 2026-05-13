"""Hybrid PMWeb agent — GPT-4o plans, Selenium executes.

One LLM call per user message. Selenium reads the DOM and acts.
No screenshots sent to OpenAI. noVNC handles the live view.
"""

from __future__ import annotations

import json
import logging
import re
import time
from typing import Any

from openai import OpenAI
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from app.config import settings

logger = logging.getLogger(__name__)

SECURITY_GROUP_CLARIFICATION = (
    "What should the security group be called, what description should I use, "
    "and should it be based on a specific team/role or details from a file you can upload?"
)

GENERIC_SECURITY_GROUP_DETAIL_WORDS = {
    "access",
    "and",
    "based",
    "description",
    "described",
    "detail",
    "details",
    "field",
    "fields",
    "for",
    "group",
    "name",
    "or",
    "permission",
    "permissions",
    "role",
    "security",
    "team",
    "with",
}


class UnsafePlanError(RuntimeError):
    """Raised when a planned browser write is unsafe to execute."""


PLANNER_PROMPT = """\
You are a PMWeb automation planner. Given a user request, output a JSON \
array of steps the browser should execute on PMWeb.

## IMPORTANT — Clarification Rule
If the user's request is missing required information (e.g. group name, \
user details, workflow name, form fields), output a single step:
[{"action": "ask_user", "question": "What name/details would you like?"}]
Do NOT guess or use placeholder values like GROUP_NAME or Description. \
Always ask the user for the specific values they want.

## Security Group Safety Rule
Do not create or save a Security Group unless the user provided an explicit \
group name and enough description/role/permission details to fill required \
fields. For a bare request like "create a security group", output only:
[{"action": "ask_user", "question": "What should the security group be \
called, what description should I use, and should it be based on a specific \
team/role or details from a file you can upload?"}]
Never click "New Group", fill group fields, toggle options, set permissions, \
or save as a placeholder/default response.

## PMWeb Navigation
- Home: /Home.aspx
- Security: /Security.aspx (iframe id="ctl00_CPH1_ngFrame")
  - Tabs: Groups, Users, User Access, Conditional Security
  - Groups: "New Group" button, kendo-textbox for Group/Description
  - Users: "New Line" button, grid row with cells
  - Save: span.k-button-text "Save" → click parent
- Adaptive Forms: /AdaptiveFormBuilder.aspx?id=0&ModuleId=8&PageId=371
  - iframe with SurveyJS Creator
  - Save: hidden input[value="SaveTemplate"]
- Workflows/BPM: /Workflow.aspx (NO iframe, direct ASP.NET)
  - Tabs: Roles, Business Processes (BPM), Defaults, APM Rules
  - BPM: ctl00_CPH1_ucBusinessProcesses_txtTemplateId / txtTemplateName
  - Roles: ctl00_CPH1_ucRoles_ prefix
  - APM Rules: ctl00_CPH1_ucAPMRules_ prefix
- Document Management: /DocumentManager.aspx (NO iframe)
  - Tree view of folders, right-click for security

## Available Actions

### Clarification
- {"action": "ask_user", "question": "What group name would you like?"}

### Navigation
- {"action": "navigate", "url": "/Security.aspx"}
- {"action": "switch_to_iframe", "id": "ctl00_CPH1_ngFrame"}
- {"action": "switch_to_main"}
- {"action": "click_sidebar", "module": "Tools"}
- {"action": "click_menu_item", "text": "Adaptive Forms"}
- {"action": "wait", "seconds": 3}

### Security — Groups (inside iframe)
- {"action": "click_tab", "text": "Groups"}
- {"action": "click_button", "text": "New Group"}
- {"action": "fill_textbox", "index": 0, "value": "Contractors"}
- {"action": "fill_textbox", "index": 1, "value": "External contractors"}
- {"action": "check_option", "label": "Can Send Notifications"}
- {"action": "uncheck_option", "label": "Can Copy Project"}
- {"action": "click_module_permission", "module": "Assets", \
"permission": "Full Control"}
- {"action": "click_save"}
- {"action": "read_groups"}

### Security — Users (inside iframe)
- {"action": "click_tab", "text": "Users"}
- {"action": "click_new_line"}
- {"action": "fill_cell", "cell_index": 3, "value": "jsmith"}
- {"action": "fill_cell", "cell_index": 5, "value": "John"}
- {"action": "fill_cell", "cell_index": 6, "value": "Smith"}
- {"action": "fill_cell_dropdown", "cell_index": 8, "value": "Full"}
- {"action": "fill_cell_dropdown", "cell_index": 9, "value": "Named"}
- {"action": "fill_cell_dropdown", "cell_index": 10, "value": "Admin"}
- {"action": "fill_cell", "cell_index": 11, "value": "P@ssw0rd"}
- {"action": "fill_cell", "cell_index": 17, "value": "jsmith@co.com"}
- {"action": "read_users"}

### Security — User Access (inside iframe)
- {"action": "click_tab", "text": "User Access"}
- {"action": "assign_user_to_group", "user": "jsmith", "group": "Admin"}

### Security — Conditional Security (inside iframe)
- {"action": "click_tab", "text": "Conditional Security"}
- {"action": "read_conditional_security"}

### Workflows/BPM (NO iframe — direct ASP.NET)
- {"action": "navigate", "url": "/Workflow.aspx"}
- {"action": "click_workflow_tab", "tab": "Roles"}
- {"action": "click_workflow_tab", "tab": "Business Processes"}
- {"action": "click_workflow_tab", "tab": "Defaults"}
- {"action": "click_workflow_tab", "tab": "APM Rules"}

#### Roles
- {"action": "add_workflow_role", "role_name": "Project Manager"}
- {"action": "read_workflow_roles"}

#### BPM
- {"action": "create_new_bpm", "bpm_id": "100", "name": "RFI Approval"}
- {"action": "add_bpm_status", "status_name": "Draft", "sequence": 1}
- {"action": "add_bpm_status", "status_name": "Submitted", "sequence": 2}
- {"action": "add_bpm_status", "status_name": "Approved", "sequence": 3}
- {"action": "assign_bpm_role", "status": "Submitted", \
"role": "Project Manager", "action_type": "Approve"}
- {"action": "read_bpm_statuses"}
- {"action": "save_bpm"}

#### APM Rules
- {"action": "create_apm_rule", "rule_name": "RFI Auto-Route", \
"module": "RFI", "level": "Project", \
"template": "RFI Approval"}
- {"action": "read_apm_rules"}
- {"action": "save_apm_rules"}

### Adaptive Forms (iframe)
- {"action": "open_adaptive_form_builder"}
- {"action": "set_form_title", "title": "Safety Inspection"}
- {"action": "add_form_field", "label": "Inspector Name", \
"field_type": "text"}
- {"action": "add_form_field", "label": "Inspection Date", \
"field_type": "date"}
- {"action": "add_form_field", "label": "Status", "field_type": \
"dropdown", "choices": ["Pass", "Fail", "Pending"]}
- {"action": "add_form_field", "label": "Upload Photos", \
"field_type": "file"}
- {"action": "add_form_field", "label": "Compliant?", \
"field_type": "boolean"}
- {"action": "add_form_field", "label": "Rating", \
"field_type": "rating"}
- {"action": "reorder_form_field", "label": "Status", "position": 2}
- {"action": "save_adaptive_form"}

### Document Management (NO iframe)
- {"action": "navigate", "url": "/DocumentManager.aspx"}
- {"action": "create_doc_folder", "folder_name": "RFI Documents", \
"parent": "Root"}
- {"action": "set_folder_security", "folder": "RFI Documents", \
"group": "Contractors", "permission": "Read"}
- {"action": "read_doc_folders"}

### Data Read / Extract
- {"action": "read_page_text"}
- {"action": "read_grid_data", "max_rows": 20}
- {"action": "read_workflow_config"}
- {"action": "read_group_permissions", "group_name": "Admin"}

### General
- {"action": "fill_by_id", "element_id": "id", "value": "text"}
- {"action": "click_by_id", "element_id": "id"}
- {"action": "click_by_text", "text": "Button Text"}
- {"action": "click_by_css", "selector": "button.my-class"}
- {"action": "select_dropdown_by_id", "element_id": "id", \
"value": "Option"}

## Rules
- If the user doesn't specify names/values, use ask_user to ask
- Always navigate first, then switch_to_iframe if needed
- For Security: navigate → switch_to_iframe → act → click_save
- For Adaptive Forms: open_adaptive_form_builder → set_form_title \
→ add fields → save_adaptive_form
- For BPM: navigate /Workflow.aspx → click_workflow_tab BPM → create \
→ add statuses → assign roles → save_bpm
- For APM Rules: navigate /Workflow.aspx → click_workflow_tab APM \
→ create rules → save_apm_rules
- For Documents: navigate /DocumentManager.aspx → create/set security
- Return ONLY a JSON array of steps
"""


class HybridAgent:
    """One GPT-4o call to plan, Selenium to execute."""

    def __init__(self) -> None:
        self._driver: webdriver.Chrome | None = None
        self._logged_in = False
        self._client: OpenAI | None = None
        self._stop_requested = False
        self._allow_security_group_creation = False

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

    def login(self) -> dict[str, Any]:
        try:
            self.driver.get(settings.pmweb_base_url)
            time.sleep(3)
            pwd = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, "txtPassword"))
            )
            pwd.click()
            time.sleep(0.3)
            pwd.send_keys(settings.pmweb_password)
            time.sleep(0.5)
            self.driver.find_element(By.ID, "btnLogin").click()
            time.sleep(3)
            try:
                WebDriverWait(self.driver, 5).until(EC.alert_is_present()).accept()
                time.sleep(5)
            except Exception:
                time.sleep(5)
            if "Home" in self.driver.current_url:
                self._logged_in = True
                return {"status": "success"}
            return {"status": "error", "message": "Login failed"}
        except Exception as exc:
            return {"status": "error", "message": str(exc)}

    def run_task_sync(self, task: str) -> dict[str, Any]:
        return self._run_task_impl(task)

    def run_task_with_context(self, task: str, file_context: str = "") -> dict[str, Any]:
        full = task
        if file_context:
            full = f"{task}\n\n--- Attached file ---\n{file_context[:5000]}"
        return self._run_task_impl(full)

    def _run_task_impl(self, task: str) -> dict[str, Any]:
        self._stop_requested = False
        self._allow_security_group_creation = False

        clarification = self._clarification_for_missing_required_fields(task)
        if clarification:
            return {"reply": clarification, "actions": []}

        examples = ""
        try:
            from app.services.learning_store import LearningStore
            similar = LearningStore().find_similar(task)
            if similar:
                examples = "\n\nPast successful plans:\n"
                for s in similar[:2]:
                    examples += f"- {s['prompt'][:60]}: {json.dumps(s['plan'][:3])}\n"
        except Exception:
            pass

        response = self.client.chat.completions.create(
            model=settings.openai_model,
            messages=[
                {"role": "system", "content": PLANNER_PROMPT},
                {"role": "user", "content": task + examples},
            ],
            temperature=0,
            max_tokens=2000,
        )
        plan_text = response.choices[0].message.content or "[]"
        try:
            start = plan_text.index("[")
            end = plan_text.rindex("]") + 1
            steps = json.loads(plan_text[start:end])
        except (ValueError, json.JSONDecodeError):
            return {"reply": plan_text, "actions": []}

        clarification = self._clarification_from_plan(steps, task)
        if clarification:
            return {"reply": clarification, "actions": []}

        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {"reply": f"Cannot connect: {r.get('message')}", "actions": []}

        results = []
        self._allow_security_group_creation = self._security_group_request_has_required_details(task)
        for i, step in enumerate(steps):
            if self._check_stop():
                results.append({"step": i + 1, "action": "STOPPED", "result": "Stopped by user"})
                break
            action = step.get("action", "")
            logger.info("Step %d: %s", i + 1, action)
            try:
                result = self._execute_step(step)
                results.append({"step": i + 1, "action": action, "result": result})
            except UnsafePlanError as exc:
                logger.warning("Step %d blocked as unsafe: %s", i + 1, exc)
                results.append({"step": i + 1, "action": action, "error": str(exc)})
                break
            except Exception as exc:
                logger.exception("Step %d failed", i + 1)
                results.append({"step": i + 1, "action": action, "error": str(exc)})

        try:
            from app.services.learning_store import LearningStore
            ls = LearningStore()
            has_err = any("error" in r for r in results)
            if has_err:
                ls.store_failure(task, steps, results)
            else:
                ls.store_success(task, steps, results)
        except Exception:
            pass

        summary_response = self.client.chat.completions.create(
            model=settings.openai_model,
            messages=[
                {"role": "system", "content": "Summarize what was done on PMWeb. Be concise."},
                {"role": "user", "content": f"Task: {task}\nResults:\n{json.dumps(results, indent=2, default=str)[:3000]}"},
            ],
            max_tokens=500,
        )
        summary = summary_response.choices[0].message.content or "Done."
        return {"reply": summary, "actions": results}

    # ── Step executor ────────────────────────────────────────────────

    def _execute_step(self, step: dict) -> Any:
        action = step["action"]
        base = settings.pmweb_base_url.rstrip("/")

        # ── Navigation ───────────────────────────────────────────────

        if action == "navigate":
            url = step["url"]
            if url.startswith("/"):
                url = base + url
            self.driver.get(url)
            time.sleep(3)
            return "navigated"

        elif action == "switch_to_iframe":
            iframe = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, step["id"]))
            )
            self.driver.switch_to.frame(iframe)
            time.sleep(3)
            return "switched to iframe"

        elif action == "switch_to_main":
            self.driver.switch_to.default_content()
            return "switched to main"

        elif action == "wait":
            time.sleep(step.get("seconds", 3))
            return "waited"

        elif action == "ask_user":
            return step.get("question") or step.get("message", "Need more info")

        # ── Tab / button clicks ──────────────────────────────────────

        elif action == "click_tab":
            for tab in self.driver.find_elements(By.CSS_SELECTOR, "li.k-item.k-tabstrip-item"):
                if step["text"].lower() in tab.text.lower():
                    tab.click()
                    time.sleep(2)
                    return f"clicked tab: {step['text']}"
            return f"tab not found: {step['text']}"

        elif action == "click_button":
            self._raise_if_unsafe_security_group_step(step)
            btn = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, f"//*[contains(text(),'{step['text']}')]"))
            )
            btn.click()
            time.sleep(2)
            return f"clicked: {step['text']}"

        elif action == "click_save":
            spans = self.driver.find_elements(
                By.XPATH, "//span[contains(@class,'k-button-text') and contains(text(),'Save')]"
            )
            for s in spans:
                if s.is_displayed():
                    s.find_element(By.XPATH, "./..").click()
                    time.sleep(4)
                    return "saved"
            saves = self.driver.find_elements(By.XPATH, "//*[contains(@title,'Save')]")
            for btn in saves:
                if btn.is_displayed():
                    btn.click()
                    time.sleep(3)
                    return "saved via title"
            return "save button not found"

        elif action == "click_new_line":
            btn = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//span[contains(text(),'New Line')]/.."))
            )
            btn.click()
            time.sleep(3)
            return "new line added"

        # ── Form filling ─────────────────────────────────────────────

        elif action == "fill_textbox":
            self._raise_if_unsafe_security_group_step(step)
            tbs = self.driver.find_elements(By.CSS_SELECTOR, "kendo-textbox input.k-input-inner")
            idx = step.get("index", 0)
            if idx < len(tbs):
                tbs[idx].click()
                tbs[idx].clear()
                tbs[idx].send_keys(step["value"])
                time.sleep(0.3)
                return f"filled textbox[{idx}]: {step['value']}"
            return f"textbox[{idx}] not found"

        elif action == "fill_cell":
            row = self._find_edit_row()
            if not row:
                return "no edit row found"
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            idx = step["cell_index"]
            if idx < len(cells):
                for inp in cells[idx].find_elements(By.CSS_SELECTOR, "input[type='text'], input[type='password']"):
                    if inp.is_displayed():
                        inp.click()
                        inp.clear()
                        inp.send_keys(step["value"])
                        time.sleep(0.3)
                        return f"filled cell[{idx}]: {step['value']}"
            return f"cell[{idx}] not fillable"

        elif action == "fill_cell_dropdown":
            row = self._find_edit_row()
            if not row:
                return "no edit row found"
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            idx = step["cell_index"]
            if idx < len(cells):
                dds = cells[idx].find_elements(By.CSS_SELECTOR, "kendo-dropdownlist")
                for dd in dds:
                    if dd.is_displayed():
                        dd.click()
                        time.sleep(1)
                        items = WebDriverWait(self.driver, 5).until(
                            EC.presence_of_all_elements_located((By.CSS_SELECTOR, "kendo-popup li"))
                        )
                        for item in items:
                            if item.text.strip().lower() == step["value"].lower():
                                item.click()
                                time.sleep(0.5)
                                return f"selected {step['value']} in cell[{idx}]"
                        dd.send_keys(Keys.ESCAPE)
                        return f"option '{step['value']}' not in cell[{idx}]"
            return f"cell[{idx}] no dropdown"

        elif action == "fill_by_id":
            el = self.driver.find_element(By.ID, step["element_id"])
            el.clear()
            el.send_keys(step["value"])
            time.sleep(0.3)
            return f"filled #{step['element_id']}"

        elif action == "select_dropdown_by_id":
            from selenium.webdriver.support.ui import Select
            el = self.driver.find_element(By.ID, step["element_id"])
            Select(el).select_by_visible_text(step["value"])
            time.sleep(0.5)
            return f"selected '{step['value']}' in #{step['element_id']}"

        elif action == "click_by_id":
            self.driver.find_element(By.ID, step["element_id"]).click()
            time.sleep(1)
            return f"clicked #{step['element_id']}"

        elif action == "click_by_text":
            self._raise_if_unsafe_security_group_step(step)
            els = self.driver.find_elements(By.XPATH, f"//*[contains(text(),'{step['text']}')]")
            for el in els:
                if el.is_displayed():
                    el.click()
                    time.sleep(1)
                    return f"clicked: {step['text']}"
            return f"not found: {step['text']}"

        elif action == "click_by_css":
            el = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable((By.CSS_SELECTOR, step["selector"]))
            )
            el.click()
            time.sleep(1)
            return f"clicked: {step['selector']}"

        elif action == "click_sidebar":
            items = self.driver.find_elements(By.XPATH, f"//span[text()='{step['module']}']")
            for item in items:
                if item.is_displayed():
                    item.click()
                    time.sleep(2)
                    return f"clicked sidebar: {step['module']}"
            return f"not found: {step['module']}"

        elif action == "click_menu_item":
            items = self.driver.find_elements(By.XPATH, f"//span[text()='{step['text']}']")
            for item in items:
                if item.is_displayed():
                    item.click()
                    time.sleep(3)
                    return f"clicked: {step['text']}"
            return f"not found: {step['text']}"

        # ── Security — Options / Permissions ─────────────────────────

        elif action == "check_option":
            self._raise_if_unsafe_security_group_step(step)
            return self._toggle_option(step["label"], check=True)

        elif action == "uncheck_option":
            self._raise_if_unsafe_security_group_step(step)
            return self._toggle_option(step["label"], check=False)

        elif action == "click_module_permission":
            self._raise_if_unsafe_security_group_step(step)
            module = step["module"]
            perm = step["permission"]
            rows = self.driver.find_elements(By.CSS_SELECTOR, "tr, [class*='row']")
            perm_map = {"View": 0, "Create": 1, "Edit": 2, "Delete": 3, "Full Control": 4}
            for row in rows:
                if module in row.text and row.is_displayed():
                    chks = row.find_elements(By.CSS_SELECTOR, "input[type='checkbox']")
                    idx = perm_map.get(perm, -1)
                    if 0 <= idx < len(chks):
                        if not chks[idx].is_selected():
                            self.driver.execute_script("arguments[0].click()", chks[idx])
                            time.sleep(0.3)
                        return f"set {module} {perm}"
            return f"module {module} not found"

        elif action == "assign_user_to_group":
            user = step["user"]
            group = step["group"]
            rows = self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row")
            for row in rows:
                if user.lower() in row.text.lower():
                    dds = row.find_elements(By.CSS_SELECTOR, "kendo-dropdownlist")
                    for dd in dds:
                        if dd.is_displayed():
                            dd.click()
                            time.sleep(1)
                            items = WebDriverWait(self.driver, 5).until(
                                EC.presence_of_all_elements_located((By.CSS_SELECTOR, "kendo-popup li"))
                            )
                            for item in items:
                                if group.lower() in item.text.lower():
                                    item.click()
                                    time.sleep(0.5)
                                    return f"assigned {user} to {group}"
                            dd.send_keys(Keys.ESCAPE)
                            return f"group '{group}' not in dropdown"
            return f"user '{user}' not found"

        # ── Security — Read ──────────────────────────────────────────

        elif action == "read_groups":
            body = self.driver.find_element(By.TAG_NAME, "body").text
            skip = {"Default Group", "Guest Users", "Adaptive Form Administrator",
                    "Can change Due Date in Procurement", "Can Copy Project",
                    "Can Edit WBS In Program", "Can Edit WBS In Project",
                    "Can Execute Move", "Can Lock/Unlock Schedules",
                    "Can Make Vendors Active/Inactive", "Can Make Locations Active/Inactive",
                    "Can Make Projects Active/Inactive", "Can Send Notifications",
                    "Custom Form Administrator", "Document Manager Administrator",
                    "Events Administrator", "Lease Administrator",
                    "PMWeb Report Administrator", "Procurement Administrator",
                    "Report Manager Administrator", "Assets", "Costs", "Forms",
                    "Plans", "Portfolio", "Schedules", "Tools", "Workflows",
                    "View: Filtered", "Duplicate", "Delete", "New Group",
                    "Group*", "Description*", "Option", "Logged into: All Levels",
                    "Need Help?", "Security", "Manage your group and user security settings",
                    "Licenses", "Save", "Cancel", "aS"}
            groups = []
            for line in body.split("\n"):
                s = line.strip()
                if not s or len(s) > 50 or s in skip or s.isdigit():
                    continue
                if any(s.startswith(p) for p in ["Groups", "Users", "User Access", "Conditional", "Activity", "Password", "External"]):
                    continue
                if len(s) >= 2:
                    groups.append(s)
            return {"groups": groups}

        elif action == "read_users":
            rows = self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row")
            users = []
            for row in rows[:30]:
                cells = row.find_elements(By.CSS_SELECTOR, "td")
                if len(cells) >= 8:
                    texts = [c.text.strip() for c in cells[:8]]
                    if texts[1]:
                        users.append({"id": texts[1], "name": f"{texts[3]} {texts[4]}".strip()})
            return {"users": users}

        elif action == "read_conditional_security":
            return self._read_grid_text()

        elif action == "read_group_permissions":
            group_name = step.get("group_name", "")
            body = self.driver.find_element(By.TAG_NAME, "body").text
            return {"group": group_name, "page_text": body[:3000]}

        elif action == "read_page_text":
            return self.driver.find_element(By.TAG_NAME, "body").text[:3000]

        elif action == "read_grid_data":
            return self._read_grid_text(max_rows=step.get("max_rows", 20))

        # ── Workflow — Tabs ──────────────────────────────────────────

        elif action == "click_workflow_tab":
            tab = step.get("tab", "")
            tab_map = {
                "Roles": "Roles",
                "Business Processes": "Business Processes",
                "BPM": "Business Processes",
                "Defaults": "Defaults",
                "APM Rules": "APM Rules",
                "APM": "APM Rules",
            }
            target = tab_map.get(tab, tab)
            els = self.driver.find_elements(By.XPATH, f"//span[contains(text(),'{target}')]")
            for el in els:
                if el.is_displayed():
                    el.click()
                    time.sleep(3)
                    return f"clicked workflow tab: {target}"
            return f"workflow tab not found: {target}"

        elif action == "click_bpm_tab":
            return self._execute_step({"action": "click_workflow_tab", "tab": "Business Processes"})

        # ── Workflow — Roles ─────────────────────────────────────────

        elif action == "add_workflow_role":
            role_name = step["role_name"]
            add_btns = self.driver.find_elements(By.XPATH, "//*[contains(@title,'Add') or contains(text(),'Add')]")
            for btn in add_btns:
                if btn.is_displayed() and ("role" in btn.text.lower() or "add" in btn.get_attribute("title").lower()):
                    btn.click()
                    time.sleep(2)
                    break
            inputs = self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']")
            for inp in reversed(inputs):
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(role_name)
                    time.sleep(0.3)
                    return f"added role: {role_name}"
            return f"could not add role: {role_name}"

        elif action == "read_workflow_roles":
            return self._read_grid_text()

        # ── Workflow — BPM ───────────────────────────────────────────

        elif action == "create_new_bpm":
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateId").clear()
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateId").send_keys(step["bpm_id"])
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateName").clear()
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateName").send_keys(step["name"])
            time.sleep(0.3)
            return f"BPM ID={step['bpm_id']}, name={step['name']}"

        elif action == "add_bpm_status":
            status_name = step["status_name"]
            seq = step.get("sequence", "")
            add_btns = self.driver.find_elements(By.XPATH, "//*[contains(@title,'Add') or contains(text(),'New')]")
            for btn in add_btns:
                if btn.is_displayed():
                    btn.click()
                    time.sleep(2)
                    break
            inputs = self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']")
            filled = False
            for inp in reversed(inputs):
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(status_name)
                    filled = True
                    break
            time.sleep(0.3)
            return f"added BPM status: {status_name} (seq {seq})" if filled else f"could not add status: {status_name}"

        elif action == "assign_bpm_role":
            status = step.get("status", "")
            role = step.get("role", "")
            rows = self.driver.find_elements(By.CSS_SELECTOR, "tr")
            for row in rows:
                if status.lower() in row.text.lower() and row.is_displayed():
                    dds = row.find_elements(By.CSS_SELECTOR, "select, kendo-dropdownlist")
                    for dd in dds:
                        if dd.is_displayed():
                            dd.click()
                            time.sleep(1)
                            items = self.driver.find_elements(By.CSS_SELECTOR, "kendo-popup li, option")
                            for item in items:
                                if role.lower() in item.text.lower():
                                    item.click()
                                    time.sleep(0.5)
                                    return f"assigned role '{role}' to status '{status}'"
                            return f"role '{role}' not found for status '{status}'"
            return f"status '{status}' not found"

        elif action == "read_bpm_statuses":
            return self._read_grid_text()

        elif action == "save_bpm":
            saves = self.driver.find_elements(By.XPATH, "//*[contains(@title,'Save')]")
            for btn in saves:
                if btn.is_displayed():
                    btn.click()
                    time.sleep(3)
                    return "BPM saved"
            self.driver.find_element(By.TAG_NAME, "body").send_keys(Keys.ALT, "s")
            time.sleep(3)
            return "BPM saved via Alt+S"

        # ── Workflow — APM Rules ─────────────────────────────────────

        elif action == "create_apm_rule":
            rule_name = step.get("rule_name", "")
            module = step.get("module", "")
            level = step.get("level", "Project")
            template = step.get("template", "")
            add_btns = self.driver.find_elements(By.XPATH, "//*[contains(@title,'Add') or contains(text(),'New') or contains(text(),'Add')]")
            for btn in add_btns:
                if btn.is_displayed():
                    btn.click()
                    time.sleep(2)
                    break
            inputs = self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']")
            for inp in inputs:
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(rule_name)
                    break
            self._try_select_dropdown_by_text(module)
            self._try_select_dropdown_by_text(level)
            self._try_select_dropdown_by_text(template)
            time.sleep(0.5)
            return f"APM rule: {rule_name} ({module}/{level}/{template})"

        elif action == "read_apm_rules":
            return self._read_grid_text()

        elif action == "save_apm_rules":
            return self._execute_step({"action": "save_bpm"})

        # ── Adaptive Forms ───────────────────────────────────────────

        elif action == "open_adaptive_form_builder":
            self.driver.switch_to.default_content()
            self.driver.get(f"{base}/AdaptiveFormBuilder.aspx?id=0&ModuleId=8&PageId=371")
            time.sleep(8)
            iframe = WebDriverWait(self.driver, 15).until(
                EC.presence_of_element_located((By.ID, "ctl00_CPH1_ngFrame"))
            )
            self.driver.switch_to.frame(iframe)
            time.sleep(5)
            return "form builder opened"

        elif action == "set_form_title":
            title_el = self.driver.find_element(
                By.XPATH, "//span[contains(@class,'sv-string-editor') and text()='Default Adaptive Form']"
            )
            title_el.click()
            time.sleep(0.3)
            ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
            ActionChains(self.driver).send_keys(step["title"]).perform()
            self.driver.find_element(By.TAG_NAME, "body").click()
            time.sleep(1)
            return f"title set: {step['title']}"

        elif action == "add_form_field":
            label = step.get("label", "Field")
            field_type = step.get("field_type", "text")
            choices = step.get("choices", [])

            type_map = {
                "text": "Single-Line Input",
                "textarea": "Long Text",
                "date": "Single-Line Input",
                "number": "Single-Line Input",
                "dropdown": "Dropdown",
                "checkbox": "Checkboxes",
                "radio": "Radio Button Group",
                "boolean": "Yes/No (Boolean)",
                "file": "File Upload",
                "rating": "Rating",
                "comment": "Long Text",
                "signature": "Signature",
            }

            toolbox_name = type_map.get(field_type, "Single-Line Input")
            toolbox_items = self.driver.find_elements(By.CSS_SELECTOR, ".svc-toolbox__item")
            added = False
            for item in toolbox_items:
                if toolbox_name.lower() in item.text.lower() and item.is_displayed():
                    item.click()
                    time.sleep(2)
                    added = True
                    break

            if not added:
                add_btns = self.driver.find_elements(By.XPATH, "//span[contains(text(),'Add Field')]")
                visible = [b for b in add_btns if b.is_displayed()]
                if visible:
                    visible[-1].click()
                    time.sleep(2)
                    added = True

            if added:
                for fl in reversed(self.driver.find_elements(By.CSS_SELECTOR, "span.sv-string-editor")):
                    if fl.is_displayed() and (fl.text.startswith("field") or fl.text.startswith("question")):
                        fl.click()
                        time.sleep(0.3)
                        ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
                        ActionChains(self.driver).send_keys(label).perform()
                        self.driver.find_element(By.TAG_NAME, "body").click()
                        time.sleep(0.5)
                        break

            if choices and field_type in ("dropdown", "checkbox", "radio"):
                choice_editors = self.driver.find_elements(By.CSS_SELECTOR, "span.sv-string-editor")
                choice_slots = [e for e in choice_editors if e.is_displayed() and e.text.startswith("Item")]
                for i, choice in enumerate(choices):
                    if i < len(choice_slots):
                        choice_slots[i].click()
                        time.sleep(0.2)
                        ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
                        ActionChains(self.driver).send_keys(choice).perform()
                        self.driver.find_element(By.TAG_NAME, "body").click()
                        time.sleep(0.3)

            return f"added field: {label} (type={field_type})"

        elif action == "reorder_form_field":
            label = step.get("label", "")
            position = step.get("position", 0)
            return f"reorder not supported in SurveyJS via automation — {label} at position {position}"

        elif action == "save_adaptive_form":
            btn = self.driver.find_element(By.CSS_SELECTOR, "input[value='SaveTemplate']")
            self.driver.execute_script("arguments[0].click()", btn)
            time.sleep(8)
            self.driver.switch_to.default_content()
            url = self.driver.current_url
            m = re.search(r"[Ii]d=(\d+)", url)
            fid = int(m.group(1)) if m else None
            return f"saved as ID={fid}"

        # ── Document Management ──────────────────────────────────────

        elif action == "create_doc_folder":
            folder_name = step.get("folder_name", "")
            parent = step.get("parent", "Root")
            tree_items = self.driver.find_elements(By.CSS_SELECTOR, ".k-treeview-item, [class*='tree'] li")
            for item in tree_items:
                if parent.lower() in item.text.lower() and item.is_displayed():
                    ActionChains(self.driver).context_click(item).perform()
                    time.sleep(1)
                    break
            menu_items = self.driver.find_elements(By.CSS_SELECTOR, ".k-context-menu li, [class*='menu'] li")
            for mi in menu_items:
                if "new" in mi.text.lower() or "add" in mi.text.lower():
                    mi.click()
                    time.sleep(2)
                    break
            inputs = self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']")
            for inp in inputs:
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(folder_name)
                    inp.send_keys(Keys.ENTER)
                    time.sleep(1)
                    return f"created folder: {folder_name} under {parent}"
            return f"could not create folder: {folder_name}"

        elif action == "set_folder_security":
            folder = step.get("folder", "")
            group = step.get("group", "")
            perm = step.get("permission", "Read")
            tree_items = self.driver.find_elements(By.CSS_SELECTOR, ".k-treeview-item, [class*='tree'] li")
            for item in tree_items:
                if folder.lower() in item.text.lower() and item.is_displayed():
                    ActionChains(self.driver).context_click(item).perform()
                    time.sleep(1)
                    break
            menu_items = self.driver.find_elements(By.CSS_SELECTOR, ".k-context-menu li, [class*='menu'] li")
            for mi in menu_items:
                if "security" in mi.text.lower() or "permission" in mi.text.lower():
                    mi.click()
                    time.sleep(2)
                    break
            body_text = self.driver.find_element(By.TAG_NAME, "body").text
            return f"folder security dialog opened for '{folder}' — set {group}={perm} (page: {body_text[:500]})"

        elif action == "read_doc_folders":
            tree_items = self.driver.find_elements(By.CSS_SELECTOR, ".k-treeview-item, [class*='tree'] li")
            folders = [item.text.strip().split("\n")[0] for item in tree_items if item.is_displayed()]
            return {"folders": folders[:50]}

        # ── Data extraction ──────────────────────────────────────────

        elif action == "read_workflow_config":
            body = self.driver.find_element(By.TAG_NAME, "body").text
            return {"workflow_config": body[:3000]}

        # ── Unknown ──────────────────────────────────────────────────

        return f"unknown action: {action}"

    # ── Helpers ──────────────────────────────────────────────────────

    def _clarification_for_missing_required_fields(self, task: str) -> str | None:
        if self._security_group_request_missing_details(task):
            return SECURITY_GROUP_CLARIFICATION
        return None

    def _clarification_from_plan(self, steps: Any, task: str = "") -> str | None:
        if not isinstance(steps, list):
            return None
        for step in steps:
            if not isinstance(step, dict) or step.get("action") != "ask_user":
                continue
            message = step.get("question") or step.get("message")
            if isinstance(message, str) and message.strip():
                return message.strip()
        if self._plan_writes_security_group(steps) and not self._security_group_request_has_required_details(task):
            return SECURITY_GROUP_CLARIFICATION
        return None

    def _security_group_request_missing_details(self, task: str) -> bool:
        text = re.sub(r"\s+", " ", task).strip().lower()
        if not self._is_security_group_create_request(text):
            return False
        return not self._security_group_request_has_required_details(task)

    def _security_group_request_has_required_details(self, task: str) -> bool:
        text = re.sub(r"\s+", " ", task).strip().lower()
        if not self._is_security_group_create_request(text):
            return False
        if self._attached_file_has_security_group_details(text):
            return True
        return self._has_security_group_name(text) and self._has_security_group_context(text)

    def _is_security_group_create_request(self, text: str) -> bool:
        return bool(
            re.search(r"\b(create|add|make|setup|set up)\b", text)
            and re.search(r"\bsecurity\s+groups?\b", text)
        )

    def _attached_file_has_security_group_details(self, text: str) -> bool:
        attached = re.search(r"---\s*attached file\s*---\s*(?P<content>.+)", text)
        if not attached:
            return False
        content = attached.group("content")
        return self._has_security_group_name(content) and self._has_security_group_context(content)

    def _has_security_group_name(self, text: str) -> bool:
        patterns = [
            r"\b(?:named|called)\s+(?P<value>[a-z0-9][\w -]{1,80})",
            r"\b(?:group\s+)?name\s*(?:is|:|=|-)\s*(?P<value>[a-z0-9][\w -]{1,80})",
        ]
        return self._has_concrete_value_after(patterns, text)

    def _has_security_group_context(self, text: str) -> bool:
        if re.search(r"\b(view|edit|delete|full control)\b", text):
            return True
        patterns = [
            r"\bdescription\s*(?:is|:|=|-)?\s*(?P<value>[a-z0-9][\w -]{1,80})",
            r"\bdescribed as\s+(?P<value>[a-z0-9][\w -]{1,80})",
            r"\bfor\s+(?!me\b)(?!my\b)(?P<value>[a-z0-9][\w -]{1,80})",
            r"\bbased on\s+(?P<value>[a-z0-9][\w -]{1,80})",
            r"\b(?:team|role|department)\s*(?:is|:|=|-)\s*(?P<value>[a-z0-9][\w -]{1,80})",
        ]
        return self._has_concrete_value_after(patterns, text)

    def _has_concrete_value_after(self, patterns: list[str], text: str) -> bool:
        for pattern in patterns:
            for match in re.finditer(pattern, text):
                value = match.group("value")
                words = re.findall(r"[a-z0-9][a-z0-9_-]*", value.lower())
                if any(word not in GENERIC_SECURITY_GROUP_DETAIL_WORDS for word in words[:4]):
                    return True
        return False

    def _plan_writes_security_group(self, steps: list[Any]) -> bool:
        on_security_page = False
        on_groups_tab = False
        for step in steps:
            if not isinstance(step, dict):
                continue
            action = step.get("action")
            text = str(step.get("text", "")).strip().lower()
            url = str(step.get("url", "")).strip().lower()
            if action == "navigate":
                on_security_page = "security.aspx" in url
                on_groups_tab = False
            elif action == "click_tab":
                on_groups_tab = text == "groups"
            if action in {"click_button", "click_by_text"} and text == "new group":
                return True
            if action in {"fill_textbox", "check_option", "uncheck_option", "click_module_permission"} and (
                on_security_page or on_groups_tab
            ):
                return True
            if action == "click_save" and (on_security_page or on_groups_tab):
                return True
        return False

    def _raise_if_unsafe_security_group_step(self, step: dict[str, Any]) -> None:
        if self._allow_security_group_creation:
            return
        if self._step_writes_security_group(step):
            raise UnsafePlanError(SECURITY_GROUP_CLARIFICATION)

    def _step_writes_security_group(self, step: dict[str, Any]) -> bool:
        action = step.get("action")
        text = str(step.get("text", "")).strip().lower()
        return (
            (action in {"click_button", "click_by_text"} and text == "new group")
            or action in {"fill_textbox", "check_option", "uncheck_option", "click_module_permission"}
        )

    def _find_edit_row(self):
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr"):
            inputs = row.find_elements(By.CSS_SELECTOR, "input:not([type='hidden']), kendo-dropdownlist")
            if sum(1 for i in inputs if i.is_displayed()) > 5:
                return row
        return None

    def _toggle_option(self, label: str, check: bool) -> str:
        rows = self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row")
        for row in rows:
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            if len(cells) >= 2 and label in cells[1].text:
                chk = cells[0].find_elements(By.CSS_SELECTOR, "input[type='checkbox']")
                if chk:
                    is_checked = chk[0].is_selected()
                    if check and not is_checked:
                        self.driver.execute_script("arguments[0].click()", chk[0])
                        time.sleep(0.3)
                        return f"checked: {label}"
                    elif not check and is_checked:
                        self.driver.execute_script("arguments[0].click()", chk[0])
                        time.sleep(0.3)
                        return f"unchecked: {label}"
                    return f"already {'checked' if check else 'unchecked'}: {label}"
        return f"option not found: {label}"

    def _read_grid_text(self, max_rows: int = 20) -> dict[str, Any]:
        rows = self.driver.find_elements(By.CSS_SELECTOR, "tr")
        data = []
        for row in rows[:max_rows]:
            cells = row.find_elements(By.CSS_SELECTOR, "td, th")
            texts = [c.text.strip() for c in cells if c.text.strip()]
            if texts:
                data.append(texts)
        return {"rows": data}

    def _try_select_dropdown_by_text(self, text: str) -> bool:
        if not text:
            return False
        dds = self.driver.find_elements(By.CSS_SELECTOR, "select, kendo-dropdownlist")
        for dd in dds:
            if dd.is_displayed():
                try:
                    dd.click()
                    time.sleep(0.5)
                    items = self.driver.find_elements(By.CSS_SELECTOR, "kendo-popup li, option")
                    for item in items:
                        if text.lower() in item.text.lower():
                            item.click()
                            time.sleep(0.3)
                            return True
                except Exception:
                    pass
        return False

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
