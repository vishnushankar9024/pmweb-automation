"""Deterministic PMWeb Selenium navigator.

All DOM interaction logic is here — no LLM involved. Uses the registry
for field definitions and navigation paths. Every action is a pure
function: given a WebDriver and parameters, perform exactly one thing.
"""

from __future__ import annotations

import logging
import re
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

    @staticmethod
    def _normalize_key(text: str) -> str:
        return text.lower().replace(" ", "").replace("_", "").replace("-", "")

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
        cell = cells[cell_index]
        dd_selectors = [
            "kendo-dropdownlist",
            "select",
            "[class*='dropdown']",
            "input[class*='combo']",
            "span[class*='k-dropdown']",
            "span[class*='k-widget']",
        ]
        for sel in dd_selectors:
            for dd in cell.find_elements(By.CSS_SELECTOR, sel):
                if dd.is_displayed():
                    dd.click()
                    time.sleep(1)
                    popup_selectors = [
                        "kendo-popup li", "ul.k-list li", "div.k-popup li",
                        "div.k-animation-container li", "li.k-item",
                    ]
                    for ps in popup_selectors:
                        items = self.driver.find_elements(By.CSS_SELECTOR, ps)
                        for item in items:
                            if item.is_displayed() and value.lower() in item.text.strip().lower():
                                item.click()
                                time.sleep(0.5)
                                return f"selected {value} in cell[{cell_index}]"
                    try:
                        dd.send_keys(Keys.ESCAPE)
                    except Exception:
                        pass
                    time.sleep(0.3)
        inp = cell.find_elements(By.CSS_SELECTOR, "input")
        for i in inp:
            if i.is_displayed():
                i.click()
                i.clear()
                i.send_keys(value)
                time.sleep(0.5)
                for ps in ["ul.k-list li", "li.k-item", "div.k-popup li", "div.k-animation-container li"]:
                    items = self.driver.find_elements(By.CSS_SELECTOR, ps)
                    for item in items:
                        if item.is_displayed() and value.lower() in item.text.strip().lower():
                            item.click()
                            time.sleep(0.5)
                            return f"selected {value} in cell[{cell_index}] (via type)"
                i.send_keys(Keys.TAB)
                time.sleep(0.3)
                return f"typed {value} in cell[{cell_index}] (no popup match)"
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

    @staticmethod
    def _row_signature(row: dict[str, str]) -> tuple[tuple[str, str], ...]:
        return tuple(sorted((str(key), str(value)) for key, value in row.items()))

    @staticmethod
    def _ordered_row_values(row: dict[str, str]) -> list[str]:
        indexed_columns: list[tuple[int, str]] = []
        fallback_columns: list[str] = []

        for key, value in row.items():
            text_value = str(value).strip() if value is not None else ""
            if not text_value:
                continue
            normalized_key = str(key).strip().lower().replace("-", "_").replace(" ", "")
            if normalized_key.startswith("col_"):
                try:
                    indexed_columns.append((int(normalized_key.split("_", 1)[1]), text_value))
                    continue
                except Exception:
                    pass
            fallback_columns.append(text_value)

        ordered_values = [value for _, value in sorted(indexed_columns, key=lambda item: item[0])]
        ordered_values.extend(fallback_columns)
        return ordered_values

    def _kendo_grid_headers(self) -> list[str]:
        selectors = [
            "kendo-grid thead th",
            ".k-grid-header th",
            "table thead th",
        ]
        for selector in selectors:
            headers = [
                th.text.strip()
                for th in self.driver.find_elements(By.CSS_SELECTOR, selector)
                if th.text.strip()
            ]
            if headers:
                return headers
        return []

    def _kendo_grid_rows(self, headers: list[str], max_rows: int) -> list[dict[str, str]]:
        row_selectors = [
            "kendo-grid .k-grid-content tr.k-table-row",
            ".k-grid-content tr.k-table-row",
            "tr.k-table-row",
            "table tbody tr",
        ]
        row_elements = []
        for selector in row_selectors:
            row_elements = self.driver.find_elements(By.CSS_SELECTOR, selector)
            if row_elements:
                break

        rows: list[dict[str, str]] = []
        for row in row_elements[:max_rows]:
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            values = [cell.text.strip() for cell in cells]
            if values and any(values):
                row_dict = {}
                for i, val in enumerate(values):
                    key = headers[i] if i < len(headers) else f"col_{i}"
                    row_dict[key] = val
                rows.append(row_dict)
        return rows

    def _pager_control_is_disabled(self, control: Any) -> bool:
        classes = (control.get_attribute("class") or "").lower()
        aria_disabled = (control.get_attribute("aria-disabled") or "").lower()
        disabled = control.get_attribute("disabled")
        if any(flag in classes for flag in ("k-disabled", "k-state-disabled")):
            return True
        if aria_disabled == "true" or disabled is not None:
            return True
        try:
            parent_disabled = self.driver.execute_script(
                (
                    "const el = arguments[0];"
                    "if (!el || !el.closest) return false;"
                    "const disabledParent = el.closest('[aria-disabled=\"true\"], .k-disabled, .k-state-disabled');"
                    "return Boolean(disabledParent);"
                ),
                control,
            )
            return bool(parent_disabled)
        except Exception:
            return False

    def _click_pager_control(self, control: Any) -> bool:
        candidates: list[Any] = [control]
        try:
            clickable_ancestor = self.driver.execute_script(
                (
                    "const el = arguments[0];"
                    "if (!el || !el.closest) return null;"
                    "return el.closest('button, a, span[role=\"button\"], span.k-pager-nav');"
                ),
                control,
            )
            if clickable_ancestor is not None:
                candidates.insert(0, clickable_ancestor)
        except Exception:
            pass

        seen_ids: set[int] = set()
        for candidate in candidates:
            if candidate is None:
                continue
            marker = id(candidate)
            if marker in seen_ids:
                continue
            seen_ids.add(marker)
            try:
                candidate.click()
            except Exception:
                try:
                    self.driver.execute_script("arguments[0].click()", candidate)
                except Exception:
                    continue
            time.sleep(1.2)
            return True
        return False

    def _active_kendo_page_number(self) -> int | None:
        selectors = [
            ".k-pager-numbers .k-selected",
            ".k-pager-numbers .k-state-selected",
            ".k-pager-numbers .k-current-page",
            ".k-pager-numbers li.k-selected",
            ".k-pager-numbers button.k-selected",
            ".k-pager-numbers a.k-selected",
        ]
        for selector in selectors:
            for element in self.driver.find_elements(By.CSS_SELECTOR, selector):
                text = element.text.strip()
                if text.isdigit():
                    return int(text)
        return None

    def _first_visible_grid_row_signature(self) -> str:
        row_selectors = [
            "kendo-grid .k-grid-content tr.k-table-row",
            ".k-grid-content tr.k-table-row",
            "tr.k-table-row",
            "table tbody tr",
        ]
        for selector in row_selectors:
            for row in self.driver.find_elements(By.CSS_SELECTOR, selector):
                try:
                    if not row.is_displayed():
                        continue
                except Exception:
                    continue
                cells = row.find_elements(By.CSS_SELECTOR, "td")
                values = [cell.text.strip() for cell in cells if cell.text.strip()]
                if values:
                    return " | ".join(values[:3])
        return ""

    def _pager_state_signature(self) -> tuple[int | None, str, str]:
        pager_info: list[str] = []
        for selector in (
            ".k-pager-info",
            ".k-grid-pager .k-pager-info",
            "kendo-pager-info",
        ):
            for element in self.driver.find_elements(By.CSS_SELECTOR, selector):
                text = element.text.strip()
                if text:
                    pager_info.append(text)
        return (
            self._active_kendo_page_number(),
            " | ".join(pager_info),
            self._first_visible_grid_row_signature(),
        )

    def _wait_for_pager_state_change(
        self,
        previous_signature: tuple[int | None, str, str],
        timeout_s: float = 3.0,
    ) -> bool:
        deadline = time.time() + timeout_s
        while time.time() < deadline:
            current_signature = self._pager_state_signature()
            if current_signature != previous_signature:
                return True
            time.sleep(0.2)
        return False

    def _go_to_next_kendo_page_via_numeric_button(self, current_page: int | None) -> bool:
        if current_page is None:
            return False

        next_page = current_page + 1
        next_page_text = str(next_page)
        numeric_selectors = [
            ".k-pager-numbers button",
            ".k-pager-numbers a",
            ".k-pager-numbers li",
            "kendo-pager-numeric-buttons button",
            "kendo-pager-numeric-buttons a",
        ]
        for selector in numeric_selectors:
            for button in self.driver.find_elements(By.CSS_SELECTOR, selector):
                if not button.is_displayed():
                    continue
                if button.text.strip() != next_page_text:
                    continue
                if self._pager_control_is_disabled(button):
                    continue
                if self._click_pager_control(button):
                    return True
        return False

    def _go_to_next_kendo_page(self) -> bool:
        current_page = self._active_kendo_page_number()
        initial_signature = self._pager_state_signature()
        next_button_selectors = [
            "button[aria-label='Go to the next page']",
            "a[aria-label='Go to the next page']",
            "span[aria-label='Go to the next page']",
            "button[aria-label*='next page' i]",
            "a[aria-label*='next page' i]",
            "span[aria-label*='next page' i]",
            "button[title='Go to the next page']",
            "a[title='Go to the next page']",
            "span[title='Go to the next page']",
            ".k-pager-nav[aria-label*='next page']",
            "button.k-pager-nav.k-pager-next",
            "a.k-pager-nav.k-pager-next",
            "span.k-pager-nav.k-pager-next",
            ".k-pager-nav.k-pager-next .k-icon",
            ".k-pager-nav.k-pager-next .k-svg-icon",
            ".k-pager-nav.k-pager-next",
            ".k-pager-next",
            "[aria-label='Next page']",
            "[title='Next page']",
            "[title='Next']",
        ]
        for selector in next_button_selectors:
            for button in self.driver.find_elements(By.CSS_SELECTOR, selector):
                if not button.is_displayed():
                    continue
                if self._pager_control_is_disabled(button):
                    continue
                if self._click_pager_control(button):
                    if self._wait_for_pager_state_change(initial_signature):
                        return True
        if self._go_to_next_kendo_page_via_numeric_button(current_page):
            if self._wait_for_pager_state_change(initial_signature):
                return True
        xpath_fallbacks = [
            "//button[contains(translate(@aria-label,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next')]",
            "//a[contains(translate(@aria-label,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next')]",
            "//span[contains(translate(@aria-label,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next')]",
            "//button[contains(translate(@title,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next')]",
            "//a[contains(translate(@title,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next')]",
            "//span[contains(translate(@title,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next')]",
            "//*[contains(concat(' ', normalize-space(@class), ' '), ' k-pager-next ')]",
            "//button[.//*[contains(@class,'arrow-end-right') or contains(@class,'caret-alt-right') or contains(@class,'chevron-right')]]",
            "//a[.//*[contains(@class,'arrow-end-right') or contains(@class,'caret-alt-right') or contains(@class,'chevron-right')]]",
            "//span[.//*[contains(@class,'arrow-end-right') or contains(@class,'caret-alt-right') or contains(@class,'chevron-right')]]",
            "//*[contains(@class,'k-pager-next')]//*[contains(@class,'k-icon') or contains(@class,'k-svg-icon')]",
            "//button[normalize-space(text())='>']",
            "//a[normalize-space(text())='>']",
            "//span[normalize-space(text())='>']",
        ]
        for xpath in xpath_fallbacks:
            for button in self.driver.find_elements(By.XPATH, xpath):
                if not button.is_displayed():
                    continue
                if self._pager_control_is_disabled(button):
                    continue
                if self._click_pager_control(button):
                    if self._wait_for_pager_state_change(initial_signature):
                        return True
        return False

    def _go_to_first_kendo_page(self) -> bool:
        """Try to reset pager state to the first page before reading rows."""
        selectors = [
            "button[aria-label='Go to the first page']",
            "a[aria-label='Go to the first page']",
            "span[aria-label='Go to the first page']",
            "button[title='Go to the first page']",
            "a[title='Go to the first page']",
            ".k-pager-first",
            ".k-pager-nav.k-pager-first",
            "[aria-label='First page']",
            "[title='First page']",
        ]
        for selector in selectors:
            for button in self.driver.find_elements(By.CSS_SELECTOR, selector):
                if not button.is_displayed():
                    continue
                classes = (button.get_attribute("class") or "").lower()
                aria_disabled = (button.get_attribute("aria-disabled") or "").lower()
                disabled = button.get_attribute("disabled")
                if any(flag in classes for flag in ("k-disabled", "k-state-disabled")) or aria_disabled == "true" or disabled is not None:
                    continue
                try:
                    button.click()
                except Exception:
                    self.driver.execute_script("arguments[0].click()", button)
                time.sleep(1.0)
                return True

        for button in self.driver.find_elements(By.CSS_SELECTOR, ".k-pager-numbers .k-link"):
            if not button.is_displayed():
                continue
            if button.text.strip() != "1":
                continue
            classes = (button.get_attribute("class") or "").lower()
            if "k-selected" in classes or "k-state-selected" in classes:
                return False
            try:
                button.click()
            except Exception:
                self.driver.execute_script("arguments[0].click()", button)
            time.sleep(1.0)
            return True

        return False

    def _find_scrollable_grid_container(self) -> Any:
        selectors = [
            "kendo-grid .k-grid-content",
            ".k-grid-content",
            "[class*='k-grid-content']",
            "kendo-grid [role='presentation']",
        ]
        for selector in selectors:
            for container in self.driver.find_elements(By.CSS_SELECTOR, selector):
                try:
                    if not container.is_displayed():
                        continue
                    metrics = self.driver.execute_script(
                        "return {h: arguments[0].scrollHeight || 0, c: arguments[0].clientHeight || 0};",
                        container,
                    )
                    if metrics and float(metrics.get("h", 0)) > float(metrics.get("c", 0)) + 2:
                        return container
                except Exception:
                    continue
        return None

    def get_kendo_total_rows(self) -> int | None:
        """Return total rows reported by the Kendo pager, when present."""
        info_selectors = [
            ".k-pager-info",
            ".k-grid-pager .k-pager-info",
            "kendo-pager-info",
            "[class*='pager'] [class*='info']",
        ]
        texts: list[str] = []
        for selector in info_selectors:
            for element in self.driver.find_elements(By.CSS_SELECTOR, selector):
                text = element.text.strip()
                if text:
                    texts.append(text)

        # Some PMWeb pages put the count in aria-label/title text.
        aria_selectors = [
            ".k-grid-pager",
            "kendo-pager",
            "[class*='pager']",
        ]
        for selector in aria_selectors:
            for element in self.driver.find_elements(By.CSS_SELECTOR, selector):
                for attr in ("aria-label", "title"):
                    value = (element.get_attribute(attr) or "").strip()
                    if value:
                        texts.append(value)

        for text in texts:
            match = re.search(r"\bof\s+(\d+)\b", text, re.IGNORECASE)
            if match:
                return int(match.group(1))
            all_digits = re.findall(r"\d+", text)
            if len(all_digits) == 1:
                return int(all_digits[0])
            if len(all_digits) >= 2:
                # Common formats: "1 - 20 of 28 items", "Page 1 / 3 (56)".
                return int(all_digits[-1])
        return None

    def _collect_rows_from_virtual_scroll(
        self,
        headers: list[str],
        max_rows: int,
        seed_rows: list[dict[str, str]] | None = None,
    ) -> list[dict[str, str]]:
        """Capture additional rows when Kendo grids virtualize instead of paging."""
        rows = list(seed_rows or [])
        seen_signatures = {self._row_signature(row) for row in rows}
        container = self._find_scrollable_grid_container()
        if container is None:
            return rows

        stagnant_iterations = 0
        while len(rows) < max_rows and stagnant_iterations < 4:
            remaining = max_rows - len(rows)
            visible_rows = self._kendo_grid_rows(headers, remaining)
            added_row = False
            for row in visible_rows:
                signature = self._row_signature(row)
                if signature in seen_signatures:
                    continue
                seen_signatures.add(signature)
                rows.append(row)
                added_row = True
                if len(rows) >= max_rows:
                    break

            try:
                metrics = self.driver.execute_script(
                    (
                        "return {"
                        "top: Number(arguments[0].scrollTop || 0),"
                        "maxTop: Math.max(Number(arguments[0].scrollHeight || 0)"
                        " - Number(arguments[0].clientHeight || 0), 0),"
                        "step: Math.max(Number(arguments[0].clientHeight || 0) - 24, 120)"
                        "};"
                    ),
                    container,
                )
            except Exception:
                break

            if not metrics:
                break

            scroll_top = float(metrics.get("top", 0))
            max_scroll_top = float(metrics.get("maxTop", 0))
            if scroll_top >= max_scroll_top - 1:
                break

            next_scroll_top = min(max_scroll_top, scroll_top + float(metrics.get("step", 120)))
            if next_scroll_top <= scroll_top:
                break

            self.driver.execute_script("arguments[0].scrollTop = arguments[1];", container, next_scroll_top)
            time.sleep(0.8)
            if added_row:
                stagnant_iterations = 0
            else:
                stagnant_iterations += 1

        return rows

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
        """Read a kendo grid with headers, traversing pager pages when present."""
        headers = self._kendo_grid_headers()
        # Best effort: start from page 1 so previous user navigation state
        # cannot truncate list/read responses.
        self._go_to_first_kendo_page()
        rows: list[dict[str, str]] = []
        seen_page_signatures: set[tuple[tuple[str, str], ...]] = set()
        stale_page_reads = 0
        max_stale_page_reads = 2

        while len(rows) < max_rows:
            remaining = max_rows - len(rows)
            page_rows = self._kendo_grid_rows(headers, remaining)
            if not page_rows:
                break

            page_signature = tuple(self._row_signature(row) for row in page_rows)
            if page_signature in seen_page_signatures:
                stale_page_reads += 1
                if stale_page_reads > max_stale_page_reads:
                    break
                if not self._go_to_next_kendo_page():
                    break
                continue
            stale_page_reads = 0
            seen_page_signatures.add(page_signature)

            rows.extend(page_rows[:remaining])
            if len(rows) >= max_rows:
                break
            if not self._go_to_next_kendo_page():
                break

        if len(rows) < max_rows:
            rows = self._collect_rows_from_virtual_scroll(headers, max_rows, seed_rows=rows)
        return rows

    def read_security_groups(self, max_rows: int = 1000) -> list[dict[str, str]]:
        """Read Security Groups as normalized Group ID/Description rows."""
        rows = self.read_kendo_grid(max_rows=max_rows)
        normalized_rows: list[dict[str, str]] = []
        seen: set[tuple[str, str]] = set()
        for row in rows:
            normalized = {
                self._normalize_key(str(key)): str(value).strip()
                for key, value in row.items()
                if value is not None
            }

            group_id = (
                normalized.get("groupid")
                or normalized.get("group")
                or normalized.get("groupname")
                or normalized.get("id")
                or normalized.get("name")
                or normalized.get("col0")
                or normalized.get("col1")
                or normalized.get("col2")
                or normalized.get("col3")
                or ""
            )
            description = (
                normalized.get("description")
                or normalized.get("groupdescription")
                or normalized.get("col4")
                or normalized.get("col3")
                or normalized.get("col2")
                or normalized.get("col1")
                or ""
            )

            ordered_values = self._ordered_row_values(row)
            if not group_id and ordered_values:
                group_id = ordered_values[0]
            if not description:
                for candidate in ordered_values[1:]:
                    if candidate.lower() != group_id.lower():
                        description = candidate
                        break

            if group_id or description:
                signature = (group_id.lower(), description.lower())
                if signature in seen:
                    continue
                seen.add(signature)
                normalized_rows.append({
                    "Group ID": group_id,
                    "Description": description,
                })
        return normalized_rows

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
        for selector in ["kendo-grid tr", "table tr", "tr.k-grid-edit-row", "tr"]:
            for row in self.driver.find_elements(By.CSS_SELECTOR, selector):
                inputs = row.find_elements(
                    By.CSS_SELECTOR,
                    "input:not([type='hidden']), kendo-dropdownlist, select, "
                    "[class*='dropdown'], [class*='combo']"
                )
                visible = sum(1 for i in inputs if i.is_displayed())
                if visible > 3:
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
