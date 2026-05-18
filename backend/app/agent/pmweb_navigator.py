"""Deterministic PMWeb Selenium navigator.

All DOM interaction logic is here — no LLM involved. Uses the registry
for field definitions and navigation paths. Every action is a pure
function: given a WebDriver and parameters, perform exactly one thing.
"""

from __future__ import annotations

import logging
import time
from typing import Any

from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.remote.webdriver import WebDriver
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

logger = logging.getLogger(__name__)


class PMWebNavigator:
    """Deterministic Selenium executor for PMWeb 2025.1."""

    def __init__(self, driver: WebDriver, base_url: str) -> None:
        self.driver = driver
        self.base = base_url.rstrip("/")
        self._in_iframe = False

    # ── Navigation ───────────────────────────────────────────────────

    def navigate(self, url_fragment: str) -> str:
        url = url_fragment if url_fragment.startswith("http") else self.base + url_fragment
        self.driver.get(url)
        self._in_iframe = False
        time.sleep(3)
        return f"navigated to {url_fragment}"

    def go_home(self) -> str:
        return self.navigate("/Home.aspx")

    def switch_to_iframe(self, iframe_id: str) -> str:
        self.driver.switch_to.default_content()
        iframe = WebDriverWait(self.driver, 15).until(
            EC.presence_of_element_located((By.ID, iframe_id))
        )
        self.driver.switch_to.frame(iframe)
        self._in_iframe = True
        time.sleep(3)
        return f"switched to iframe {iframe_id}"

    def switch_to_main(self) -> str:
        self.driver.switch_to.default_content()
        self._in_iframe = False
        return "switched to main frame"

    def click_module(self, module_name: str) -> str:
        """Click a module in the Control Panel sidebar."""
        for el in self.driver.find_elements(By.XPATH, f"//span[contains(text(),'{module_name}')]"):
            if el.is_displayed():
                el.click()
                time.sleep(2)
                return f"clicked module: {module_name}"
        return f"module not found: {module_name}"

    def click_menu_item(self, item_name: str) -> str:
        """Click a menu item in the flyout after clicking a module."""
        for el in self.driver.find_elements(By.XPATH, f"//*[contains(text(),'{item_name}')]"):
            if el.is_displayed():
                el.click()
                time.sleep(3)
                return f"clicked menu item: {item_name}"
        return f"menu item not found: {item_name}"

    def navigate_to_record_type(self, module: str, menu_item: str, url_fragment: str = "") -> str:
        """Full navigation: sidebar module → menu item, or direct URL."""
        if url_fragment:
            self.navigate(url_fragment)
            return f"navigated to {url_fragment}"
        self.click_module(module)
        time.sleep(1)
        return self.click_menu_item(menu_item)

    # ── Breadcrumb navigation (PMWeb 2025.1) ─────────────────────────

    def select_breadcrumb_module(self, module_name: str) -> str:
        """Click breadcrumb segment 1 and select a module."""
        breadcrumbs = self.driver.find_elements(By.CSS_SELECTOR, "[class*='breadcrumb'] span, nav span")
        if breadcrumbs:
            breadcrumbs[0].click()
            time.sleep(1)
        for item in self.driver.find_elements(By.XPATH, f"//*[contains(text(),'{module_name}')]"):
            if item.is_displayed():
                item.click()
                time.sleep(2)
                return f"selected breadcrumb module: {module_name}"
        return f"breadcrumb module not found: {module_name}"

    def select_breadcrumb_record_type(self, record_type: str) -> str:
        """Click breadcrumb segment 2 and select a record type."""
        for item in self.driver.find_elements(By.XPATH, f"//*[contains(text(),'{record_type}')]"):
            if item.is_displayed():
                item.click()
                time.sleep(2)
                return f"selected record type: {record_type}"
        return f"record type not found: {record_type}"

    # ── Toolbar actions (deterministic) ──────────────────────────────

    def click_toolbar_button(self, button_text: str) -> str:
        """Click a toolbar button by its visible text."""
        xpaths = [
            f"//span[contains(@class,'k-button-text') and contains(text(),'{button_text}')]/..",
            f"//button[contains(@title,'{button_text}')]",
            f"//*[contains(text(),'{button_text}')]",
        ]
        for xpath in xpaths:
            for el in self.driver.find_elements(By.XPATH, xpath):
                if el.is_displayed():
                    try:
                        el.click()
                        time.sleep(2)
                        return f"clicked toolbar: {button_text}"
                    except Exception:
                        self.driver.execute_script("arguments[0].click()", el)
                        time.sleep(2)
                        return f"clicked toolbar (js): {button_text}"
        return f"toolbar button not found: {button_text}"

    def click_save(self) -> str:
        """Deterministic save — tries multiple known selectors."""
        selectors = [
            (By.XPATH, "//span[contains(@class,'k-button-text') and contains(text(),'Save')]/.."),
            (By.XPATH, "//button[contains(@title,'Save')]"),
            (By.CSS_SELECTOR, "button[title*='Save']"),
        ]
        for by, sel in selectors:
            for el in self.driver.find_elements(by, sel):
                if el.is_displayed():
                    try:
                        el.click()
                    except Exception:
                        self.driver.execute_script("arguments[0].click()", el)
                    time.sleep(4)
                    return "saved"
        self.driver.find_element(By.TAG_NAME, "body").send_keys(Keys.ALT, "s")
        time.sleep(3)
        return "saved via Alt+S"

    def click_new_record(self) -> str:
        return self.click_toolbar_button("New")

    def click_new_line(self) -> str:
        return self.click_toolbar_button("New Line")

    def click_submit(self) -> str:
        return self.click_toolbar_button("Submit")

    def click_cancel(self) -> str:
        return self.click_toolbar_button("Cancel")

    def click_create_next(self) -> str:
        return self.click_toolbar_button("Create Next")

    # ── Tab clicking ─────────────────────────────────────────────────

    def click_tab(self, tab_text: str) -> str:
        """Click a tab (kendo tabstrip or any tab-like element)."""
        for tab in self.driver.find_elements(By.CSS_SELECTOR, "li.k-item.k-tabstrip-item, [role='tab'], li[class*='tab']"):
            if tab_text.lower() in tab.text.lower() and tab.is_displayed():
                tab.click()
                time.sleep(2)
                return f"clicked tab: {tab_text}"
        for el in self.driver.find_elements(By.XPATH, f"//span[contains(text(),'{tab_text}')]"):
            if el.is_displayed():
                el.click()
                time.sleep(2)
                return f"clicked tab (text): {tab_text}"
        return f"tab not found: {tab_text}"

    # ── Field filling (deterministic) ────────────────────────────────

    def fill_field_by_label(self, label: str, value: str) -> str:
        """Find a field by its label text and fill it."""
        label_els = self.driver.find_elements(By.XPATH, f"//label[contains(text(),'{label}')]")
        for lbl in label_els:
            if not lbl.is_displayed():
                continue
            for_id = lbl.get_attribute("for")
            if for_id:
                try:
                    inp = self.driver.find_element(By.ID, for_id)
                    inp.clear()
                    inp.send_keys(value)
                    time.sleep(0.3)
                    return f"filled {label}: {value}"
                except Exception:
                    pass
            parent = lbl.find_element(By.XPATH, "./..")
            inputs = parent.find_elements(By.CSS_SELECTOR, "input, textarea, select")
            for inp in inputs:
                if inp.is_displayed():
                    inp.clear()
                    inp.send_keys(value)
                    time.sleep(0.3)
                    return f"filled {label}: {value}"
        return f"field not found: {label}"

    def fill_field_by_id(self, element_id: str, value: str) -> str:
        el = self.driver.find_element(By.ID, element_id)
        el.clear()
        el.send_keys(value)
        time.sleep(0.3)
        return f"filled #{element_id}: {value}"

    def fill_field_by_css(self, selector: str, value: str) -> str:
        el = WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, selector))
        )
        el.click()
        el.clear()
        el.send_keys(value)
        time.sleep(0.3)
        return f"filled {selector}: {value}"

    def fill_kendo_textbox(self, index: int, value: str) -> str:
        """Fill a kendo-textbox by its position index."""
        tbs = self.driver.find_elements(By.CSS_SELECTOR, "kendo-textbox input.k-input-inner")
        if index < len(tbs):
            tbs[index].click()
            tbs[index].clear()
            tbs[index].send_keys(value)
            time.sleep(0.3)
            return f"filled textbox[{index}]: {value}"
        return f"textbox[{index}] not found (found {len(tbs)})"

    def select_dropdown_by_text(self, visible_text: str) -> str:
        """Click any visible dropdown and select an option by text."""
        dds = self.driver.find_elements(By.CSS_SELECTOR, "kendo-dropdownlist, select")
        for dd in dds:
            if dd.is_displayed():
                dd.click()
                time.sleep(1)
                items = self.driver.find_elements(By.CSS_SELECTOR, "kendo-popup li, option")
                for item in items:
                    if visible_text.lower() in item.text.lower():
                        item.click()
                        time.sleep(0.5)
                        return f"selected: {visible_text}"
                try:
                    dd.send_keys(Keys.ESCAPE)
                except Exception:
                    pass
        return f"dropdown option not found: {visible_text}"

    def select_dropdown_by_id(self, element_id: str, value: str) -> str:
        from selenium.webdriver.support.ui import Select
        el = self.driver.find_element(By.ID, element_id)
        Select(el).select_by_visible_text(value)
        time.sleep(0.5)
        return f"selected '{value}' in #{element_id}"

    # ── Grid / table operations ──────────────────────────────────────

    def fill_grid_cell(self, cell_index: int, value: str) -> str:
        """Fill a cell in the active edit row of a kendo grid."""
        row = self._find_edit_row()
        if not row:
            return "no edit row found"
        cells = row.find_elements(By.CSS_SELECTOR, "td")
        if cell_index >= len(cells):
            return f"cell[{cell_index}] out of range (row has {len(cells)} cells)"
        for inp in cells[cell_index].find_elements(By.CSS_SELECTOR, "input[type='text'], input[type='password'], textarea"):
            if inp.is_displayed():
                inp.click()
                inp.clear()
                inp.send_keys(value)
                time.sleep(0.3)
                return f"filled cell[{cell_index}]: {value}"
        return f"cell[{cell_index}] not editable"

    def select_grid_cell_dropdown(self, cell_index: int, value: str) -> str:
        """Select a dropdown value in a grid cell."""
        row = self._find_edit_row()
        if not row:
            return "no edit row found"
        cells = row.find_elements(By.CSS_SELECTOR, "td")
        if cell_index >= len(cells):
            return f"cell[{cell_index}] out of range"
        for dd in cells[cell_index].find_elements(By.CSS_SELECTOR, "kendo-dropdownlist"):
            if dd.is_displayed():
                dd.click()
                time.sleep(1)
                for item in WebDriverWait(self.driver, 5).until(
                    EC.presence_of_all_elements_located((By.CSS_SELECTOR, "kendo-popup li"))
                ):
                    if item.text.strip().lower() == value.lower():
                        item.click()
                        time.sleep(0.5)
                        return f"selected {value} in cell[{cell_index}]"
                dd.send_keys(Keys.ESCAPE)
                return f"option '{value}' not found in cell[{cell_index}]"
        return f"no dropdown in cell[{cell_index}]"

    def toggle_checkbox(self, label: str, check: bool = True) -> str:
        """Toggle a checkbox in a kendo grid options row."""
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row, tr"):
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            if len(cells) >= 2 and label.lower() in cells[1].text.lower():
                chks = cells[0].find_elements(By.CSS_SELECTOR, "input[type='checkbox']")
                if chks:
                    is_checked = chks[0].is_selected()
                    if check != is_checked:
                        self.driver.execute_script("arguments[0].click()", chks[0])
                        time.sleep(0.3)
                    action = "checked" if check else "unchecked"
                    return f"{action}: {label}"
        return f"option not found: {label}"

    def set_module_permission(self, module: str, permission: str) -> str:
        """Set a module permission checkbox (View/Create/Edit/Delete/Full Control)."""
        perm_map = {"View": 0, "Create": 1, "Edit": 2, "Delete": 3, "Full Control": 4}
        idx = perm_map.get(permission, -1)
        if idx < 0:
            return f"unknown permission: {permission}"
        for row in self.driver.find_elements(By.CSS_SELECTOR, "tr, [class*='row']"):
            if module in row.text and row.is_displayed():
                chks = row.find_elements(By.CSS_SELECTOR, "input[type='checkbox']")
                if idx < len(chks):
                    if not chks[idx].is_selected():
                        self.driver.execute_script("arguments[0].click()", chks[idx])
                        time.sleep(0.3)
                    return f"set {module} → {permission}"
        return f"module row not found: {module}"

    # ── Data reading (deterministic) ─────────────────────────────────

    def read_page_text(self, max_chars: int = 3000) -> str:
        return self.driver.find_element(By.TAG_NAME, "body").text[:max_chars]

    def read_grid(self, max_rows: int = 30) -> list[list[str]]:
        """Read a grid/table and return rows as lists of cell text."""
        data = []
        for row in self.driver.find_elements(By.CSS_SELECTOR, "tr")[:max_rows]:
            cells = row.find_elements(By.CSS_SELECTOR, "td, th")
            texts = [c.text.strip() for c in cells if c.text.strip()]
            if texts:
                data.append(texts)
        return data

    def read_kendo_grid(self, max_rows: int = 30) -> list[dict[str, str]]:
        """Read a kendo grid with headers."""
        headers = []
        for th in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid th, th"):
            t = th.text.strip()
            if t:
                headers.append(t)
        rows = []
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr.k-table-row, tr")[:max_rows]:
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            values = [c.text.strip() for c in cells]
            if values and any(v for v in values):
                row_dict = {}
                for i, val in enumerate(values):
                    key = headers[i] if i < len(headers) else f"col_{i}"
                    row_dict[key] = val
                rows.append(row_dict)
        return rows

    # ── SurveyJS Adaptive Forms ──────────────────────────────────────

    def open_form_builder(self) -> str:
        self.switch_to_main()
        self.navigate("/AdaptiveFormBuilder.aspx?id=0&ModuleId=8&PageId=371")
        time.sleep(5)
        self.switch_to_iframe("ctl00_CPH1_ngFrame")
        time.sleep(3)
        return "form builder opened"

    def set_form_title(self, title: str) -> str:
        try:
            el = self.driver.find_element(
                By.XPATH, "//span[contains(@class,'sv-string-editor') and text()='Default Adaptive Form']"
            )
            el.click()
            time.sleep(0.3)
            ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
            ActionChains(self.driver).send_keys(title).perform()
            self.driver.find_element(By.TAG_NAME, "body").click()
            time.sleep(1)
            return f"form title set: {title}"
        except Exception as e:
            return f"could not set title: {e}"

    def add_form_field(self, label: str, field_type: str = "text", choices: list[str] | None = None) -> str:
        type_map = {
            "text": "Single-Line Input", "textarea": "Long Text", "date": "Single-Line Input",
            "number": "Single-Line Input", "dropdown": "Dropdown", "checkbox": "Checkboxes",
            "radio": "Radio Button Group", "boolean": "Yes/No (Boolean)", "file": "File Upload",
            "rating": "Rating", "signature": "Signature",
        }
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
            slots = [e for e in self.driver.find_elements(By.CSS_SELECTOR, "span.sv-string-editor")
                     if e.is_displayed() and e.text.startswith("Item")]
            for i, choice in enumerate(choices):
                if i < len(slots):
                    slots[i].click()
                    time.sleep(0.2)
                    ActionChains(self.driver).key_down(Keys.CONTROL).send_keys("a").key_up(Keys.CONTROL).perform()
                    ActionChains(self.driver).send_keys(choice).perform()
                    self.driver.find_element(By.TAG_NAME, "body").click()
                    time.sleep(0.3)
        return f"added field: {label} (type={field_type})"

    def save_form(self) -> str:
        import re
        btn = self.driver.find_element(By.CSS_SELECTOR, "input[value='SaveTemplate']")
        self.driver.execute_script("arguments[0].click()", btn)
        time.sleep(8)
        self.switch_to_main()
        url = self.driver.current_url
        m = re.search(r"[Ii]d=(\d+)", url)
        fid = int(m.group(1)) if m else None
        return f"form saved as ID={fid}"

    # ── Helpers ──────────────────────────────────────────────────────

    def _find_edit_row(self) -> Any:
        for row in self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr"):
            inputs = row.find_elements(By.CSS_SELECTOR, "input:not([type='hidden']), kendo-dropdownlist")
            if sum(1 for i in inputs if i.is_displayed()) > 3:
                return row
        return None

    def wait(self, seconds: float = 3) -> str:
        time.sleep(seconds)
        return f"waited {seconds}s"

    def click_element(self, by: str, selector: str) -> str:
        by_map = {"id": By.ID, "css": By.CSS_SELECTOR, "xpath": By.XPATH, "text": By.XPATH}
        sel_by = by_map.get(by, By.CSS_SELECTOR)
        if by == "text":
            selector = f"//*[contains(text(),'{selector}')]"
        el = WebDriverWait(self.driver, 10).until(
            EC.element_to_be_clickable((sel_by, selector))
        )
        el.click()
        time.sleep(1)
        return f"clicked [{by}] {selector}"
