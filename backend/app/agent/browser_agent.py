"""Hybrid PMWeb agent — GPT-4o plans, Selenium executes.

One LLM call per user message. Selenium reads the DOM and acts.
No screenshots sent to OpenAI. noVNC handles the live view.
"""

from __future__ import annotations

import json
import logging
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
from app.services.pmweb_browser import (
    extract_security_group_names,
    format_security_group_list,
)

logger = logging.getLogger(__name__)

PLANNER_PROMPT = """\
You are a PMWeb automation planner. Given a user request, output a JSON \
array of steps the browser should execute on PMWeb.

## PMWeb Navigation
- Home: /Home.aspx
- Security: /Security.aspx (has iframe id="ctl00_CPH1_ngFrame" with Angular app)
  - Tabs inside iframe: Groups, Users, User Access, etc.
  - Groups tab: "New Group" button, kendo-textbox inputs for Group/Description
  - Users tab: "New Line" button, grid row with cells for ID, Name, License, Group, etc.
  - Save: click span with class "k-button-text" containing "Save", then click its parent
- Adaptive Forms: /SearchDocument.aspx?O=302 (manager page)
  - "New Record" opens /AdaptiveFormBuilder.aspx?id=0&ModuleId=8&PageId=371
  - Inside iframe: SurveyJS Creator, "Add Field" buttons, span.sv-string-editor for labels
  - Save: click hidden input[value="SaveTemplate"]
- Workflows/BPM: /Workflow.aspx (NO iframe, direct ASP.NET page)
  - Tabs: Roles, Business Processes (BPM), Defaults, APM Rules
  - BPM tab has: Select Template dropdown, BPM ID* textbox, Template Name*
  - ASP.NET control IDs for BPM:
    - Template dropdown: ctl00_CPH1_ucBusinessProcesses_ddlTemplate_Input
    - BPM ID: ctl00_CPH1_ucBusinessProcesses_txtTemplateId
    - Template Name: ctl00_CPH1_ucBusinessProcesses_txtTemplateName
    - Associate With: ctl00_CPH1_ucBusinessProcesses_ddlAssociate_Input
    - Save button has tooltip "Save (Alt+s)"
    - "USE VISUAL DESIGNER" button opens the visual workflow designer
  - Roles list on the right side for assigning to workflow steps
- Tools sidebar: Plans, Forms, Costs, Schedules, Assets, Workflows, Portfolio, Tools

## Available Step Types
Each step is a JSON object with "action" and parameters:

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
- {"action": "fill_textbox", "index": 0, "value": "ENGINEERS"}
- {"action": "fill_textbox", "index": 1, "value": "Engineering team"}
- {"action": "check_option", "label": "Can Send Notifications"}
- {"action": "click_save"}
- {"action": "read_groups"}
For requests like "list/show/read security groups", use:
[
  {"action": "navigate", "url": "/Security.aspx"},
  {"action": "switch_to_iframe", "id": "ctl00_CPH1_ngFrame"},
  {"action": "click_tab", "text": "Groups"},
  {"action": "read_groups"}
]

### Security — Group Permissions (inside iframe, Groups tab)
Module names visible: Assets, Costs, Forms, Plans, Portfolio, Schedules, Tools, Workflows
Each module can be expanded to show record types. Permissions are checkboxes.
- {"action": "click_module_permission", "module": "Assets", "permission": "Full Control"}
- {"action": "click_module_permission", "module": "Costs", "permission": "View"}
Permissions: View, Create, Edit, Delete, Full Control

### Security — Users (inside iframe)
- {"action": "click_new_line"}
- {"action": "fill_cell", "cell_index": 3, "value": "jdoe"}
- {"action": "fill_cell", "cell_index": 5, "value": "John"}
- {"action": "fill_cell", "cell_index": 6, "value": "Doe"}
- {"action": "fill_cell_dropdown", "cell_index": 8, "value": "Full"}
- {"action": "fill_cell_dropdown", "cell_index": 9, "value": "Named"}
- {"action": "fill_cell_dropdown", "cell_index": 10, "value": "Admin"}
- {"action": "fill_cell", "cell_index": 11, "value": "password"}
- {"action": "fill_cell", "cell_index": 17, "value": "email@co.com"}
- {"action": "read_users"}

### Security — Conditional Security (inside iframe)
- {"action": "click_tab", "text": "Conditional Security"}
- {"action": "click_button", "text": "Add"}
- {"action": "fill_conditional_security", "name": "Rule Name", \
"record_type": "RFIs", "field": "Description", \
"operator": "Contains", "value": "Draft", \
"deny_groups": ["Contractors", "Clients"]}

### Workflows/BPM (NO iframe, direct ASP.NET page)
- {"action": "navigate", "url": "/Workflow.aspx"}
- {"action": "click_bpm_tab"}
- {"action": "create_new_bpm", "bpm_id": "100", "name": "RFI Approval"}
- {"action": "set_bpm_associate", "record_type": "RFI"}
- {"action": "open_visual_designer"}
- {"action": "save_bpm"}

### Workflows — Roles (NO iframe)
- {"action": "click_workflow_tab", "tab": "Roles"}
- {"action": "add_role", "role_name": "Project Manager", \
"user": "admin"}

### Workflows — Defaults (NO iframe)
- {"action": "click_workflow_tab", "tab": "Defaults"}

### Adaptive Forms (iframe)
- {"action": "open_adaptive_form_builder"}
- {"action": "set_form_title", "title": "My Form"}
- {"action": "add_form_field", "label": "Field Name"}
- {"action": "save_adaptive_form"}

### General
- {"action": "read_page_text"}
- {"action": "fill_by_id", "element_id": "someId", "value": "text"}
- {"action": "click_by_id", "element_id": "someId"}
- {"action": "click_by_text", "text": "Button Text"}
- {"action": "select_telerik_dropdown", \
"input_id": "someId_Input", "value": "Option"}

## Rules
- Always navigate first, then switch_to_iframe if needed
- For Security: navigate to Security.aspx, switch_to_iframe, then act
- After filling forms, always click_save
- For reading data, use read_groups or read_users. These actions return
  user-facing text; summaries must present the names as a clean list,
  not raw JSON.
- For adaptive forms: open_adaptive_form_builder, set_form_title, add fields, save_adaptive_form
- Return ONLY a JSON array of steps, nothing else

## User Groups Cell Mapping (Users tab)
- cell 3: User ID
- cell 5: First Name
- cell 6: Last Name
- cell 8: License Type (dropdown: Full/Guest)
- cell 9: Named License (dropdown: Named/Concurrent)
- cell 10: Group (dropdown)
- cell 11: Password
- cell 17: Email
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
        """Synchronous version for thread pool execution."""
        return self._run_task_impl(task)

    async def run_task(self, task: str) -> dict[str, Any]:
        return self._run_task_impl(task)

    def run_task_with_context(
        self, task: str, file_context: str = ""
    ) -> dict[str, Any]:
        """Run task with optional file context injected."""
        full_task = task
        if file_context:
            full_task = (
                f"{task}\n\n"
                f"--- Attached file content ---\n"
                f"{file_context[:5000]}"
            )
        return self._run_task_impl(full_task)

    def _run_task_impl(self, task: str) -> dict[str, Any]:
        self._stop_requested = False

        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {
                    "reply": f"Cannot connect: {r.get('message')}",
                    "actions": [],
                }

        # Check for similar past successful plans
        from app.services.learning_store import LearningStore

        learner = LearningStore()
        similar = learner.find_similar(task)
        examples = ""
        if similar:
            examples = "\n\nPrevious successful plans:\n"
            for s in similar[:2]:
                examples += (
                    f"- Prompt: {s['prompt'][:80]}\n"
                    f"  Plan: {json.dumps(s['plan'][:5])}\n"
                )

        # Step 1: Ask GPT-4o to plan
        response = self.client.chat.completions.create(
            model=settings.openai_model,
            messages=[
                {"role": "system", "content": PLANNER_PROMPT},
                {
                    "role": "user",
                    "content": task + examples,
                },
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

        # Step 2: Execute with stop check
        results = []
        stopped = False
        for i, step in enumerate(steps):
            if self._check_stop():
                stopped = True
                results.append({
                    "step": i + 1,
                    "action": "STOPPED",
                    "result": f"Stopped by user at step {i + 1}",
                })
                break

            action = step.get("action", "")
            logger.info("Step %d: %s", i + 1, action)
            try:
                result = self._execute_step(step)
                results.append({
                    "step": i + 1,
                    "action": action,
                    "result": result,
                })
            except Exception as exc:
                logger.exception("Step %d failed", i + 1)
                results.append({
                    "step": i + 1,
                    "action": action,
                    "error": str(exc),
                })

        # Store interaction for learning
        has_errors = any("error" in r for r in results)
        if not stopped:
            if has_errors:
                learner.store_failure(task, steps, results)
            else:
                learner.store_success(task, steps, results)

        if stopped:
            return {
                "reply": f"Stopped after step {len(results)}. "
                f"Completed steps may have been saved in PMWeb.",
                "actions": results,
            }

        # Step 3: Summarize results
        summary_response = self.client.chat.completions.create(
            model=settings.openai_model,
            messages=[
                {
                    "role": "system",
                    "content": (
                        "You are a PMWeb assistant. Summarize what was "
                        "done based on the execution results. "
                        "When a read action returns a list, present the "
                        "names as a clean bullet list and never show raw JSON. "
                        "Be concise and helpful."
                    ),
                },
                {
                    "role": "user",
                    "content": (
                        f"User asked: {task}\n\n"
                        f"Execution results:\n"
                        f"{json.dumps(results, indent=2, default=str)[:3000]}"
                    ),
                },
            ],
            max_tokens=500,
        )
        summary = summary_response.choices[0].message.content or "Task completed."

        return {"reply": summary, "actions": results}

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

        elif action == "check_option":
            rows = self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row")
            for row in rows:
                cells = row.find_elements(By.CSS_SELECTOR, "td")
                if len(cells) >= 2 and step["label"] in cells[1].text:
                    chk = cells[0].find_elements(By.CSS_SELECTOR, "input[type='checkbox']")
                    if chk and not chk[0].is_selected():
                        self.driver.execute_script("arguments[0].click()", chk[0])
                        time.sleep(0.3)
                        return f"checked: {step['label']}"
                    return f"already checked: {step['label']}"
            return f"option not found: {step['label']}"

        elif action == "click_save":
            spans = self.driver.find_elements(
                By.XPATH, "//span[contains(@class,'k-button-text') and contains(text(),'Save')]"
            )
            for s in spans:
                if s.is_displayed():
                    s.find_element(By.XPATH, "./..").click()
                    time.sleep(4)
                    return "saved"
            return "save button not found"

        elif action == "click_new_line":
            btn = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//span[contains(text(),'New Line')]/.."))
            )
            btn.click()
            time.sleep(3)
            return "new line added"

        elif action == "fill_cell":
            row = self._find_edit_row()
            if not row:
                return "no edit row found"
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            idx = step["cell_index"]
            if idx < len(cells):
                for inp in cells[idx].find_elements(
                    By.CSS_SELECTOR, "input[type='text'], input[type='password']"
                ):
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
                        return f"option '{step['value']}' not found in cell[{idx}]"
            return f"cell[{idx}] no dropdown"

        elif action == "read_page_text":
            text = self.driver.find_element(By.TAG_NAME, "body").text
            return text[:3000]

        elif action == "read_groups":
            body = self.driver.find_element(By.TAG_NAME, "body").text
            groups = extract_security_group_names(body)
            return format_security_group_list(groups)

        elif action == "read_users":
            rows = self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row")
            users = []
            for row in rows[:30]:
                cells = row.find_elements(By.CSS_SELECTOR, "td")
                if len(cells) >= 8:
                    texts = [c.text.strip() for c in cells[:8]]
                    if texts[1]:
                        users.append(
                            {
                                "id": texts[1],
                                "name": f"{texts[3]} {texts[4]}".strip(),
                                "group": texts[7] if len(texts) > 7 else "",
                            }
                        )
            return {"users": users}

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
                By.XPATH,
                "//span[contains(@class,'sv-string-editor') and text()='Default Adaptive Form']",
            )
            title_el.click()
            time.sleep(0.3)
            ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(
                Keys.CONTROL
            ).perform()
            ActionChains(self.driver).send_keys(step["title"]).perform()
            self.driver.find_element(By.TAG_NAME, "body").click()
            time.sleep(1)
            return f"title set: {step['title']}"

        elif action == "add_form_field":
            add_btns = self.driver.find_elements(By.XPATH, "//span[contains(text(),'Add Field')]")
            visible = [b for b in add_btns if b.is_displayed()]
            if visible:
                visible[-1].click()
                time.sleep(2)
            for fl in reversed(self.driver.find_elements(By.CSS_SELECTOR, "span.sv-string-editor")):
                if fl.text.startswith("field") and fl.is_displayed():
                    fl.click()
                    time.sleep(0.3)
                    ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(
                        Keys.CONTROL
                    ).perform()
                    ActionChains(self.driver).send_keys(step["label"]).perform()
                    self.driver.find_element(By.TAG_NAME, "body").click()
                    time.sleep(0.5)
                    return f"added field: {step['label']}"
            return "could not add field"

        elif action == "save_adaptive_form":
            btn = self.driver.find_element(By.CSS_SELECTOR, "input[value='SaveTemplate']")
            self.driver.execute_script("arguments[0].click()", btn)
            time.sleep(8)
            self.driver.switch_to.default_content()
            url = self.driver.current_url
            import re

            m = re.search(r"[Ii]d=(\d+)", url)
            form_id = int(m.group(1)) if m else None
            return f"saved as ID={form_id}"

        elif action == "click_sidebar":
            self.driver.switch_to.default_content()
            items = self.driver.find_elements(By.XPATH, f"//span[text()='{step['module']}']")
            for item in items:
                if item.is_displayed():
                    item.click()
                    time.sleep(2)
                    return f"clicked sidebar: {step['module']}"
            return f"sidebar item not found: {step['module']}"

        elif action == "click_menu_item":
            items = self.driver.find_elements(By.XPATH, f"//span[text()='{step['text']}']")
            for item in items:
                if item.is_displayed():
                    item.click()
                    time.sleep(3)
                    return f"clicked menu: {step['text']}"
            return f"menu item not found: {step['text']}"

        elif action == "click_bpm_tab":
            bpm_tab = self.driver.find_element(
                By.XPATH,
                "//span[contains(text(),'Business Processes')]",
            )
            bpm_tab.click()
            time.sleep(3)
            return "clicked BPM tab"

        elif action == "create_new_bpm":
            bpm_id_field = self.driver.find_element(
                By.ID,
                "ctl00_CPH1_ucBusinessProcesses_txtTemplateId",
            )
            bpm_id_field.clear()
            bpm_id_field.send_keys(step["bpm_id"])
            time.sleep(0.3)
            name_field = self.driver.find_element(
                By.ID,
                "ctl00_CPH1_ucBusinessProcesses_txtTemplateName",
            )
            name_field.clear()
            name_field.send_keys(step["name"])
            time.sleep(0.3)
            return f"set BPM ID={step['bpm_id']}, name={step['name']}"

        elif action == "set_bpm_associate":
            # Telerik RadComboBox - click the dropdown arrow first
            dd = self.driver.find_element(
                By.ID,
                "ctl00_CPH1_ucBusinessProcesses_ddlAssociate",
            )
            arrow = dd.find_elements(
                By.CSS_SELECTOR, ".rcbActionButton, .rcbArrowCell a"
            )
            if arrow:
                arrow[0].click()
            else:
                dd.click()
            time.sleep(1)
            # Find and click the item in the dropdown list
            items = self.driver.find_elements(
                By.CSS_SELECTOR,
                ".rcbList li, .rcbItem, .rcbCheckBox",
            )
            for item in items:
                txt = item.text.strip()
                if step["record_type"].lower() in txt.lower():
                    item.click()
                    time.sleep(0.5)
                    return f"associated with: {txt}"
            return f"record type not found: {step['record_type']}"

        elif action == "open_visual_designer":
            vd_btn = self.driver.find_element(
                By.XPATH,
                "//*[contains(text(),'USE VISUAL DESIGNER')]",
            )
            vd_btn.click()
            time.sleep(3)
            return "opened visual designer"

        elif action == "save_bpm":
            save_btns = self.driver.find_elements(
                By.XPATH,
                "//*[contains(@title,'Save')]"
                " | //a[contains(@title,'Save')]",
            )
            for btn in save_btns:
                if btn.is_displayed():
                    btn.click()
                    time.sleep(3)
                    return "BPM saved"
            self.driver.find_element(
                By.TAG_NAME, "body"
            ).send_keys(Keys.ALT, "s")
            time.sleep(3)
            return "BPM saved via Alt+S"

        elif action == "click_module_permission":
            module = step["module"]
            perm = step["permission"]
            rows = self.driver.find_elements(
                By.CSS_SELECTOR,
                "kendo-treelist-cell, tr, [class*='row']",
            )
            for row in rows:
                if module in row.text and row.is_displayed():
                    chks = row.find_elements(
                        By.CSS_SELECTOR, "input[type='checkbox']"
                    )
                    perm_map = {
                        "View": 0,
                        "Create": 1,
                        "Edit": 2,
                        "Delete": 3,
                        "Full Control": 4,
                    }
                    idx = perm_map.get(perm, -1)
                    if 0 <= idx < len(chks):
                        if not chks[idx].is_selected():
                            self.driver.execute_script(
                                "arguments[0].click()", chks[idx]
                            )
                            time.sleep(0.3)
                        return f"set {module} {perm}"
            return f"module {module} not found for permissions"

        elif action == "fill_conditional_security":
            name = step.get("name", "")
            name_inputs = self.driver.find_elements(
                By.CSS_SELECTOR, "input[type='text']"
            )
            for inp in name_inputs:
                if inp.is_displayed():
                    inp.clear()
                    inp.send_keys(name)
                    time.sleep(0.3)
                    break
            return f"conditional security rule '{name}' configured"

        elif action == "click_workflow_tab":
            tab_name = step.get("tab", "Roles")
            tabs = self.driver.find_elements(
                By.XPATH, f"//a[contains(text(),'{tab_name}')]"
            )
            for t in tabs:
                if t.is_displayed():
                    t.click()
                    time.sleep(3)
                    return f"clicked workflow tab: {tab_name}"
            return f"workflow tab not found: {tab_name}"

        elif action == "add_role":
            add_btn = self.driver.find_element(
                By.ID,
                "ctl00_CPH1_ucRoles_rdgRoles_ctl00_ctl02_ctl00_btnA",
            )
            add_btn.click()
            time.sleep(2)
            inputs = self.driver.find_elements(
                By.CSS_SELECTOR, "input[type='text']"
            )
            visible = [i for i in inputs if i.is_displayed()]
            if visible:
                visible[0].clear()
                visible[0].send_keys(step.get("role_name", ""))
                time.sleep(0.3)
            return f"added role: {step.get('role_name')}"

        elif action == "click_by_text":
            els = self.driver.find_elements(
                By.XPATH,
                f"//*[contains(text(),'{step['text']}')]",
            )
            for el in els:
                if el.is_displayed():
                    el.click()
                    time.sleep(1)
                    return f"clicked: {step['text']}"
            return f"not found: {step['text']}"

        elif action == "select_telerik_dropdown":
            inp = self.driver.find_element(
                By.ID, step["input_id"]
            )
            inp.click()
            time.sleep(1)
            inp.clear()
            inp.send_keys(step["value"])
            time.sleep(1)
            items = self.driver.find_elements(
                By.CSS_SELECTOR, ".rcbList li, .rcbItem"
            )
            for item in items:
                if step["value"].lower() in item.text.lower():
                    item.click()
                    time.sleep(0.5)
                    return f"selected: {step['value']}"
            inp.send_keys(Keys.ENTER)
            return f"typed: {step['value']}"

        elif action == "fill_by_id":
            el = self.driver.find_element(By.ID, step["element_id"])
            el.clear()
            el.send_keys(step["value"])
            time.sleep(0.3)
            return f"filled #{step['element_id']}: {step['value']}"

        elif action == "click_by_id":
            el = self.driver.find_element(By.ID, step["element_id"])
            el.click()
            time.sleep(1)
            return f"clicked #{step['element_id']}"

        elif action == "wait":
            time.sleep(step.get("seconds", 3))
            return "waited"

        return f"unknown action: {action}"

    def _find_edit_row(self):
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr"):
            inputs = row.find_elements(
                By.CSS_SELECTOR, "input:not([type='hidden']), kendo-dropdownlist"
            )
            if sum(1 for i in inputs if i.is_displayed()) > 5:
                return row
        return None

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
