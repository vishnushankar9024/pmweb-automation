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

PLANNER_PROMPT = """\
You are a PMWeb automation planner. Given a user request, output a JSON \
array of steps the browser should execute on PMWeb.

## CRITICAL — Always Ask First Rule
Before executing ANY create/write action, you MUST ask the user for the \
required input fields UNLESS:
1. The user already provided all required values in their message
2. The user explicitly says "generic" or "default" or "sample"
3. The user attached a file — use the extracted file data as input

For every PMWeb record type, here are the required fields to ask about:

### Security Groups: group name, description, permissions, options
### Users: user ID, first name, last name, email, password, license, group
### Workflows/BPM: template ID, name, statuses, role assignments
### APM Rules: rule name, module, level (project/programme/system), template
### Adaptive Forms: form title, field names, field types, dropdown choices
### Document Folders: folder name, parent folder, group permissions

If ANY required field is missing, output:
[{"action": "ask_user", "question": "I need a few details to create this. \
Please provide: <list missing fields>. You can also upload a file \
(Excel, PDF, Word, drawing, etc.) with the details."}]

## File-Based Input
When the user attaches a file, the extracted text will appear after \
"--- Attached file ---" in the message. Parse the file data to extract \
field values (names, descriptions, lists, table rows, etc.) and use them \
directly — do NOT ask again for information that's already in the file.

For bulk operations from files (e.g. Excel with multiple rows), create \
multiple records by repeating the create+save steps for each row.

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
- {"action": "ask_user", "question": "I need details: ..."}

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

### Workflows/BPM (NO iframe)
- {"action": "navigate", "url": "/Workflow.aspx"}
- {"action": "click_workflow_tab", "tab": "Roles"}
- {"action": "click_workflow_tab", "tab": "Business Processes"}
- {"action": "click_workflow_tab", "tab": "Defaults"}
- {"action": "click_workflow_tab", "tab": "APM Rules"}
- {"action": "add_workflow_role", "role_name": "Project Manager"}
- {"action": "read_workflow_roles"}
- {"action": "create_new_bpm", "bpm_id": "100", "name": "RFI Approval"}
- {"action": "add_bpm_status", "status_name": "Draft", "sequence": 1}
- {"action": "assign_bpm_role", "status": "Submitted", \
"role": "Project Manager", "action_type": "Approve"}
- {"action": "read_bpm_statuses"}
- {"action": "save_bpm"}
- {"action": "create_apm_rule", "rule_name": "RFI Auto-Route", \
"module": "RFI", "level": "Project", "template": "RFI Approval"}
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
- ALWAYS ask for missing required fields before creating anything
- If file data is attached, parse it and use the values directly
- For bulk file imports: repeat create+save for each row/entry
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
        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {"reply": f"Cannot connect: {r.get('message')}", "actions": []}

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

        if len(steps) == 1 and steps[0].get("action") == "ask_user":
            return {"reply": steps[0].get("question", "Could you provide more details?"), "actions": []}

        results = []
        for i, step in enumerate(steps):
            if self._check_stop():
                results.append({"step": i + 1, "action": "STOPPED", "result": "Stopped by user"})
                break
            action = step.get("action", "")
            logger.info("Step %d: %s", i + 1, action)
            try:
                result = self._execute_step(step)
                results.append({"step": i + 1, "action": action, "result": result})
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
            return step.get("question", "Need more info")

        elif action == "click_tab":
            for tab in self.driver.find_elements(By.CSS_SELECTOR, "li.k-item.k-tabstrip-item"):
                if step["text"].lower() in tab.text.lower():
                    tab.click()
                    time.sleep(2)
                    return f"clicked tab: {step['text']}"
            return f"tab not found: {step['text']}"

        elif action == "click_button":
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

        elif action == "fill_textbox":
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

        elif action == "check_option":
            return self._toggle_option(step["label"], check=True)

        elif action == "uncheck_option":
            return self._toggle_option(step["label"], check=False)

        elif action == "click_module_permission":
            module, perm = step["module"], step["permission"]
            perm_map = {"View": 0, "Create": 1, "Edit": 2, "Delete": 3, "Full Control": 4}
            for row in self.driver.find_elements(By.CSS_SELECTOR, "tr, [class*='row']"):
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
            user, group = step["user"], step["group"]
            for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row"):
                if user.lower() in row.text.lower():
                    for dd in row.find_elements(By.CSS_SELECTOR, "kendo-dropdownlist"):
                        if dd.is_displayed():
                            dd.click()
                            time.sleep(1)
                            for item in WebDriverWait(self.driver, 5).until(
                                EC.presence_of_all_elements_located((By.CSS_SELECTOR, "kendo-popup li"))
                            ):
                                if group.lower() in item.text.lower():
                                    item.click()
                                    time.sleep(0.5)
                                    return f"assigned {user} to {group}"
                            dd.send_keys(Keys.ESCAPE)
            return f"user '{user}' or group '{group}' not found"

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
            users = []
            for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row")[:30]:
                cells = row.find_elements(By.CSS_SELECTOR, "td")
                if len(cells) >= 8:
                    texts = [c.text.strip() for c in cells[:8]]
                    if texts[1]:
                        users.append({"id": texts[1], "name": f"{texts[3]} {texts[4]}".strip()})
            return {"users": users}

        elif action in ("read_conditional_security", "read_grid_data"):
            return self._read_grid_text(max_rows=step.get("max_rows", 20))

        elif action == "read_group_permissions":
            return {"group": step.get("group_name", ""), "page_text": self.driver.find_element(By.TAG_NAME, "body").text[:3000]}

        elif action == "read_page_text":
            return self.driver.find_element(By.TAG_NAME, "body").text[:3000]

        elif action == "click_workflow_tab":
            tab_map = {
                "Roles": "Roles", "Business Processes": "Business Processes",
                "BPM": "Business Processes", "Defaults": "Defaults",
                "APM Rules": "APM Rules", "APM": "APM Rules",
            }
            target = tab_map.get(step.get("tab", ""), step.get("tab", ""))
            for el in self.driver.find_elements(By.XPATH, f"//span[contains(text(),'{target}')]"):
                if el.is_displayed():
                    el.click()
                    time.sleep(3)
                    return f"clicked workflow tab: {target}"
            return f"workflow tab not found: {target}"

        elif action == "click_bpm_tab":
            return self._execute_step({"action": "click_workflow_tab", "tab": "Business Processes"})

        elif action == "add_workflow_role":
            for btn in self.driver.find_elements(By.XPATH, "//*[contains(@title,'Add') or contains(text(),'Add')]"):
                if btn.is_displayed():
                    btn.click()
                    time.sleep(2)
                    break
            for inp in reversed(self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']")):
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(step["role_name"])
                    time.sleep(0.3)
                    return f"added role: {step['role_name']}"
            return f"could not add role: {step['role_name']}"

        elif action == "read_workflow_roles":
            return self._read_grid_text()

        elif action == "create_new_bpm":
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateId").clear()
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateId").send_keys(step["bpm_id"])
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateName").clear()
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateName").send_keys(step["name"])
            time.sleep(0.3)
            return f"BPM ID={step['bpm_id']}, name={step['name']}"

        elif action == "add_bpm_status":
            for btn in self.driver.find_elements(By.XPATH, "//*[contains(@title,'Add') or contains(text(),'New')]"):
                if btn.is_displayed():
                    btn.click()
                    time.sleep(2)
                    break
            for inp in reversed(self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']")):
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(step["status_name"])
                    return f"added status: {step['status_name']} (seq {step.get('sequence', '')})"
            return f"could not add status: {step['status_name']}"

        elif action == "assign_bpm_role":
            status, role = step.get("status", ""), step.get("role", "")
            for row in self.driver.find_elements(By.CSS_SELECTOR, "tr"):
                if status.lower() in row.text.lower() and row.is_displayed():
                    for dd in row.find_elements(By.CSS_SELECTOR, "select, kendo-dropdownlist"):
                        if dd.is_displayed():
                            dd.click()
                            time.sleep(1)
                            for item in self.driver.find_elements(By.CSS_SELECTOR, "kendo-popup li, option"):
                                if role.lower() in item.text.lower():
                                    item.click()
                                    time.sleep(0.5)
                                    return f"assigned '{role}' to '{status}'"
            return f"status '{status}' or role '{role}' not found"

        elif action == "read_bpm_statuses":
            return self._read_grid_text()

        elif action == "save_bpm":
            for btn in self.driver.find_elements(By.XPATH, "//*[contains(@title,'Save')]"):
                if btn.is_displayed():
                    btn.click()
                    time.sleep(3)
                    return "BPM saved"
            self.driver.find_element(By.TAG_NAME, "body").send_keys(Keys.ALT, "s")
            time.sleep(3)
            return "BPM saved via Alt+S"

        elif action == "create_apm_rule":
            for btn in self.driver.find_elements(By.XPATH, "//*[contains(@title,'Add') or contains(text(),'New') or contains(text(),'Add')]"):
                if btn.is_displayed():
                    btn.click()
                    time.sleep(2)
                    break
            for inp in self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']"):
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(step.get("rule_name", ""))
                    break
            self._try_select_dropdown_by_text(step.get("module", ""))
            self._try_select_dropdown_by_text(step.get("level", ""))
            self._try_select_dropdown_by_text(step.get("template", ""))
            time.sleep(0.5)
            return f"APM rule: {step.get('rule_name', '')} ({step.get('module', '')}/{step.get('level', '')}/{step.get('template', '')})"

        elif action == "read_apm_rules":
            return self._read_grid_text()

        elif action == "save_apm_rules":
            return self._execute_step({"action": "save_bpm"})

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
            type_map = {"text": "Single-Line Input", "textarea": "Long Text", "date": "Single-Line Input",
                        "number": "Single-Line Input", "dropdown": "Dropdown", "checkbox": "Checkboxes",
                        "radio": "Radio Button Group", "boolean": "Yes/No (Boolean)", "file": "File Upload",
                        "rating": "Rating", "comment": "Long Text", "signature": "Signature"}
            toolbox_name = type_map.get(field_type, "Single-Line Input")
            added = False
            for item in self.driver.find_elements(By.CSS_SELECTOR, ".svc-toolbox__item"):
                if toolbox_name.lower() in item.text.lower() and item.is_displayed():
                    item.click()
                    time.sleep(2)
                    added = True
                    break
            if not added:
                for b in self.driver.find_elements(By.XPATH, "//span[contains(text(),'Add Field')]"):
                    if b.is_displayed():
                        b.click()
                        time.sleep(2)
                        added = True
                        break
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
                slots = [e for e in self.driver.find_elements(By.CSS_SELECTOR, "span.sv-string-editor") if e.is_displayed() and e.text.startswith("Item")]
                for i, choice in enumerate(choices):
                    if i < len(slots):
                        slots[i].click()
                        time.sleep(0.2)
                        ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
                        ActionChains(self.driver).send_keys(choice).perform()
                        self.driver.find_element(By.TAG_NAME, "body").click()
                        time.sleep(0.3)
            return f"added field: {label} (type={field_type})"

        elif action == "save_adaptive_form":
            btn = self.driver.find_element(By.CSS_SELECTOR, "input[value='SaveTemplate']")
            self.driver.execute_script("arguments[0].click()", btn)
            time.sleep(8)
            self.driver.switch_to.default_content()
            url = self.driver.current_url
            m = re.search(r"[Ii]d=(\d+)", url)
            fid = int(m.group(1)) if m else None
            return f"saved as ID={fid}"

        elif action == "create_doc_folder":
            folder_name, parent = step.get("folder_name", ""), step.get("parent", "Root")
            for item in self.driver.find_elements(By.CSS_SELECTOR, ".k-treeview-item, [class*='tree'] li"):
                if parent.lower() in item.text.lower() and item.is_displayed():
                    ActionChains(self.driver).context_click(item).perform()
                    time.sleep(1)
                    break
            for mi in self.driver.find_elements(By.CSS_SELECTOR, ".k-context-menu li, [class*='menu'] li"):
                if "new" in mi.text.lower() or "add" in mi.text.lower():
                    mi.click()
                    time.sleep(2)
                    break
            for inp in self.driver.find_elements(By.CSS_SELECTOR, "input[type='text']"):
                if inp.is_displayed() and not inp.get_attribute("value"):
                    inp.click()
                    inp.send_keys(folder_name)
                    inp.send_keys(Keys.ENTER)
                    time.sleep(1)
                    return f"created folder: {folder_name} under {parent}"
            return f"could not create folder: {folder_name}"

        elif action == "set_folder_security":
            folder, group, perm = step.get("folder", ""), step.get("group", ""), step.get("permission", "Read")
            for item in self.driver.find_elements(By.CSS_SELECTOR, ".k-treeview-item, [class*='tree'] li"):
                if folder.lower() in item.text.lower() and item.is_displayed():
                    ActionChains(self.driver).context_click(item).perform()
                    time.sleep(1)
                    break
            for mi in self.driver.find_elements(By.CSS_SELECTOR, ".k-context-menu li, [class*='menu'] li"):
                if "security" in mi.text.lower() or "permission" in mi.text.lower():
                    mi.click()
                    time.sleep(2)
                    break
            return f"folder security for '{folder}': {group}={perm}"

        elif action == "read_doc_folders":
            folders = [item.text.strip().split("\n")[0] for item in self.driver.find_elements(By.CSS_SELECTOR, ".k-treeview-item, [class*='tree'] li") if item.is_displayed()]
            return {"folders": folders[:50]}

        elif action == "read_workflow_config":
            return {"workflow_config": self.driver.find_element(By.TAG_NAME, "body").text[:3000]}

        return f"unknown action: {action}"

    # ── Helpers ──────────────────────────────────────────────────────

    def _find_edit_row(self):
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr"):
            inputs = row.find_elements(By.CSS_SELECTOR, "input:not([type='hidden']), kendo-dropdownlist")
            if sum(1 for i in inputs if i.is_displayed()) > 5:
                return row
        return None

    def _toggle_option(self, label: str, check: bool) -> str:
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row"):
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
        data = []
        for row in self.driver.find_elements(By.CSS_SELECTOR, "tr")[:max_rows]:
            texts = [c.text.strip() for c in row.find_elements(By.CSS_SELECTOR, "td, th") if c.text.strip()]
            if texts:
                data.append(texts)
        return {"rows": data}

    def _try_select_dropdown_by_text(self, text: str) -> bool:
        if not text:
            return False
        for dd in self.driver.find_elements(By.CSS_SELECTOR, "select, kendo-dropdownlist"):
            if dd.is_displayed():
                try:
                    dd.click()
                    time.sleep(0.5)
                    for item in self.driver.find_elements(By.CSS_SELECTOR, "kendo-popup li, option"):
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
