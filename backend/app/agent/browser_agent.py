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
    """Raised when the planner asks Selenium to perform an unsafe write."""

PLANNER_PROMPT = """\
You are a PMWeb automation planner. Given a user request, output a JSON \
array of steps the browser should execute on PMWeb.

## PMWeb Navigation
- Home: /Home.aspx
- Security: /Security.aspx (iframe id="ctl00_CPH1_ngFrame")
  - Tabs: Groups, Users, User Access, Conditional Security, etc.
  - Groups: "New Group" button, kendo-textbox for Group/Description
  - Users: "New Line" button, grid row with cells
  - Save: span.k-button-text "Save" → click parent
- Adaptive Forms: /AdaptiveFormBuilder.aspx?id=0&ModuleId=8&PageId=371
  - iframe with SurveyJS Creator
  - Save: hidden input[value="SaveTemplate"]
- Workflows/BPM: /Workflow.aspx (NO iframe, direct ASP.NET)
  - Tabs: Roles, Business Processes (BPM), Defaults, APM Rules
  - BPM ID: ctl00_CPH1_ucBusinessProcesses_txtTemplateId
  - Template Name: ctl00_CPH1_ucBusinessProcesses_txtTemplateName

## Available Actions

### Navigation
- {"action": "navigate", "url": "/Security.aspx"}
- {"action": "switch_to_iframe", "id": "ctl00_CPH1_ngFrame"}
- {"action": "switch_to_main"}
- {"action": "click_sidebar", "module": "Tools"}
- {"action": "click_menu_item", "text": "Adaptive Forms"}
- {"action": "ask_user", "message": "Question to ask before changing PMWeb"}
- {"action": "wait", "seconds": 3}

### Security — Groups (inside iframe)
- {"action": "click_tab", "text": "Groups"}
- {"action": "click_button", "text": "New Group"}
- {"action": "fill_textbox", "index": 0, "value": "GROUP_NAME"}
- {"action": "fill_textbox", "index": 1, "value": "Description"}
- {"action": "check_option", "label": "Can Send Notifications"}
- {"action": "click_module_permission", "module": "Assets", \
"permission": "Full Control"}
- {"action": "click_save"}
- {"action": "read_groups"}

### Security — Users (inside iframe)
- {"action": "click_tab", "text": "Users"}
- {"action": "click_new_line"}
- {"action": "fill_cell", "cell_index": 3, "value": "user_id"}
- {"action": "fill_cell", "cell_index": 5, "value": "FirstName"}
- {"action": "fill_cell", "cell_index": 6, "value": "LastName"}
- {"action": "fill_cell_dropdown", "cell_index": 8, "value": "Full"}
- {"action": "fill_cell_dropdown", "cell_index": 9, "value": "Named"}
- {"action": "fill_cell_dropdown", "cell_index": 10, "value": "Admin"}
- {"action": "fill_cell", "cell_index": 11, "value": "password"}
- {"action": "fill_cell", "cell_index": 17, "value": "email@co.com"}
- {"action": "read_users"}

### Workflows/BPM (NO iframe)
- {"action": "navigate", "url": "/Workflow.aspx"}
- {"action": "click_bpm_tab"}
- {"action": "create_new_bpm", "bpm_id": "100", "name": "Name"}
- {"action": "save_bpm"}

### Adaptive Forms (iframe)
- {"action": "open_adaptive_form_builder"}
- {"action": "set_form_title", "title": "My Form"}
- {"action": "add_form_field", "label": "Field Name"}
- {"action": "save_adaptive_form"}

### General
- {"action": "read_page_text"}
- {"action": "fill_by_id", "element_id": "id", "value": "text"}
- {"action": "click_by_id", "element_id": "id"}
- {"action": "click_by_text", "text": "Button Text"}

## Rules
- Always navigate first, then switch_to_iframe if needed
- For Security: navigate → switch_to_iframe → act → click_save
- Do not create or save a Security Group unless the user provided an \
explicit group name and enough description/role/permission details to fill \
required fields
- If a create request is missing required fields, return one ask_user step \
with a concise question. Do not navigate, click, fill, or save in that case
- For a bare request like "create a security group", ask for the group name, \
description, and whether the group should be based on a team/role or uploaded \
details
- Never click "New Group" as a placeholder or default response. The executor \
will reject that action unless the request includes the required group details
- For Adaptive Forms: open_adaptive_form_builder → set_form_title \
→ add fields → save_adaptive_form
- For BPM: navigate to /Workflow.aspx → click_bpm_tab → create → save
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
                WebDriverWait(self.driver, 5).until(
                    EC.alert_is_present()
                ).accept()
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

    def run_task_with_context(
        self, task: str, file_context: str = ""
    ) -> dict[str, Any]:
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

        # Few-shot from past successes
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

        # Step 1: Plan
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

        # Step 2: Execute
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

        # Learn
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

        # Step 3: Summarize
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

        elif action == "ask_user":
            return step["message"]

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
            if self._is_new_group_click(step) and not self._allow_security_group_creation:
                raise UnsafePlanError(SECURITY_GROUP_CLARIFICATION)
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

        elif action == "click_module_permission":
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

        elif action == "read_page_text":
            return self.driver.find_element(By.TAG_NAME, "body").text[:3000]

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
            add_btns = self.driver.find_elements(By.XPATH, "//span[contains(text(),'Add Field')]")
            visible = [b for b in add_btns if b.is_displayed()]
            if visible:
                visible[-1].click()
                time.sleep(2)
            for fl in reversed(self.driver.find_elements(By.CSS_SELECTOR, "span.sv-string-editor")):
                if fl.text.startswith("field") and fl.is_displayed():
                    fl.click()
                    time.sleep(0.3)
                    ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
                    ActionChains(self.driver).send_keys(step["label"]).perform()
                    self.driver.find_element(By.TAG_NAME, "body").click()
                    time.sleep(0.5)
                    return f"added field: {step['label']}"
            return "could not add field"

        elif action == "save_adaptive_form":
            import re
            btn = self.driver.find_element(By.CSS_SELECTOR, "input[value='SaveTemplate']")
            self.driver.execute_script("arguments[0].click()", btn)
            time.sleep(8)
            self.driver.switch_to.default_content()
            url = self.driver.current_url
            m = re.search(r"[Ii]d=(\d+)", url)
            fid = int(m.group(1)) if m else None
            return f"saved as ID={fid}"

        elif action == "click_bpm_tab":
            self.driver.find_element(By.XPATH, "//span[contains(text(),'Business Processes')]").click()
            time.sleep(3)
            return "clicked BPM tab"

        elif action == "create_new_bpm":
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateId").clear()
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateId").send_keys(step["bpm_id"])
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateName").clear()
            self.driver.find_element(By.ID, "ctl00_CPH1_ucBusinessProcesses_txtTemplateName").send_keys(step["name"])
            time.sleep(0.3)
            return f"BPM ID={step['bpm_id']}, name={step['name']}"

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

        elif action == "click_by_text":
            if self._is_new_group_click(step) and not self._allow_security_group_creation:
                raise UnsafePlanError(SECURITY_GROUP_CLARIFICATION)
            els = self.driver.find_elements(By.XPATH, f"//*[contains(text(),'{step['text']}')]")
            for el in els:
                if el.is_displayed():
                    el.click()
                    time.sleep(1)
                    return f"clicked: {step['text']}"
            return f"not found: {step['text']}"

        elif action == "fill_by_id":
            el = self.driver.find_element(By.ID, step["element_id"])
            el.clear()
            el.send_keys(step["value"])
            time.sleep(0.3)
            return f"filled #{step['element_id']}"

        elif action == "click_by_id":
            self.driver.find_element(By.ID, step["element_id"]).click()
            time.sleep(1)
            return f"clicked #{step['element_id']}"

        elif action == "wait":
            time.sleep(step.get("seconds", 3))
            return "waited"

        return f"unknown action: {action}"

    def _clarification_for_missing_required_fields(self, task: str) -> str | None:
        if self._security_group_request_missing_details(task):
            return SECURITY_GROUP_CLARIFICATION
        return None

    def _clarification_from_plan(self, steps: Any, task: str = "") -> str | None:
        if not isinstance(steps, list):
            return None
        for step in steps:
            if isinstance(step, dict) and step.get("action") == "ask_user":
                message = step.get("message")
                if isinstance(message, str) and message.strip():
                    return message.strip()
        if (
            self._plan_creates_security_group(steps)
            and not self._security_group_request_has_required_details(task)
        ):
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
        return (
            self._has_security_group_name(content)
            and self._has_security_group_context(content)
        )

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
            (
                r"\b(?:team|role|department)\s*(?:is|:|=|-)\s*"
                r"(?P<value>[a-z0-9][\w -]{1,80})"
            ),
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

    def _plan_creates_security_group(self, steps: list[Any]) -> bool:
        for step in steps:
            if not isinstance(step, dict):
                continue
            action = step.get("action")
            text = str(step.get("text", "")).lower()
            if action in {"click_button", "click_by_text"} and "new group" in text:
                return True
        return False

    def _is_new_group_click(self, step: dict[str, Any]) -> bool:
        return str(step.get("text", "")).strip().lower() == "new group"

    def _find_edit_row(self):
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr"):
            inputs = row.find_elements(By.CSS_SELECTOR, "input:not([type='hidden']), kendo-dropdownlist")
            if sum(1 for i in inputs if i.is_displayed()) > 5:
                return row
        return None

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
