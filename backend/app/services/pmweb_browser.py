"""PMWeb browser automation — performs real UI actions visible to the user.

Uses Selenium to drive a VISIBLE Chrome browser that opens PMWeb,
navigates to the correct page, fills in Kendo UI forms, and saves.
"""

from __future__ import annotations

import logging
import time
from typing import Any

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

logger = logging.getLogger(__name__)

PMWEB_URL = "https://cmcs.pmweb.com/2025_1_00/pmweb/"


class PMWebBrowser:
    """Automates PMWeb via a VISIBLE browser the user can watch."""

    def __init__(
        self,
        base_url: str = PMWEB_URL,
        username: str = "admin",
        password: str = "pmweb2",
        headless: bool = False,
    ) -> None:
        self.base_url = base_url.rstrip("/")
        self.username = username
        self.password = password
        self.headless = headless
        self._driver: webdriver.Chrome | None = None
        self._logged_in = False

    @property
    def driver(self) -> webdriver.Chrome:
        if self._driver is None:
            self._driver = self._create_driver()
        return self._driver

    def _create_driver(self) -> webdriver.Chrome:
        options = Options()
        options.add_argument("--no-sandbox")
        options.add_argument("--disable-setuid-sandbox")
        options.add_argument("--disable-dev-shm-usage")
        options.add_argument("--window-size=1400,900")
        if self.headless:
            options.add_argument("--headless=new")
        return webdriver.Chrome(options=options)

    # ------------------------------------------------------------------ #
    #  Login
    # ------------------------------------------------------------------ #

    def login(self) -> dict[str, Any]:
        try:
            logger.info("Opening PMWeb login page...")
            self.driver.get(self.base_url)
            time.sleep(3)

            pwd_field = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, "txtPassword"))
            )
            pwd_field.click()
            time.sleep(0.3)
            pwd_field.send_keys(self.password)
            time.sleep(0.5)

            self.driver.find_element(By.ID, "btnLogin").click()
            time.sleep(3)

            try:
                alert = WebDriverWait(self.driver, 5).until(
                    EC.alert_is_present()
                )
                alert.accept()
                time.sleep(5)
            except Exception:
                time.sleep(5)

            if "Home" in self.driver.current_url:
                self._logged_in = True
                return {"status": "success", "url": self.driver.current_url}

            errors = self.driver.find_elements(By.CSS_SELECTOR, ".errorMsg")
            return {
                "status": "error",
                "message": "; ".join(e.text for e in errors if e.text)
                or "Login failed",
            }
        except Exception as exc:
            logger.exception("Login failed")
            return {"status": "error", "message": str(exc)}

    def _ensure_logged_in(self) -> None:
        if not self._logged_in:
            result = self.login()
            if result["status"] != "success":
                raise RuntimeError(f"Login failed: {result.get('message')}")

    # ------------------------------------------------------------------ #
    #  Navigation helpers
    # ------------------------------------------------------------------ #

    def _go_to_security(self) -> None:
        self._ensure_logged_in()
        self.driver.get(f"{self.base_url}/Security.aspx")
        time.sleep(3)
        iframe = WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located((By.ID, "ctl00_CPH1_ngFrame"))
        )
        self.driver.switch_to.frame(iframe)
        time.sleep(3)

    def _click_tab(self, tab_text: str) -> None:
        tabs = self.driver.find_elements(
            By.CSS_SELECTOR, "li.k-item.k-tabstrip-item"
        )
        for tab in tabs:
            if tab_text.lower() in tab.text.lower():
                tab.click()
                time.sleep(2)
                return
        raise RuntimeError(f"Tab '{tab_text}' not found")

    def _switch_to_main(self) -> None:
        self.driver.switch_to.default_content()

    def _click_save(self) -> None:
        """Click the Save button (kendo-button containing 'Save' span)."""
        try:
            save_span = self.driver.find_element(
                By.XPATH,
                "//span[contains(@class,'k-button-text') "
                "and contains(text(),'Save')]",
            )
            save_btn = save_span.find_element(By.XPATH, "./..")
            save_btn.click()
            time.sleep(4)
        except Exception:
            logger.warning("Save button not found, trying alternative")
            try:
                self.driver.find_element(
                    By.CSS_SELECTOR, "kendo-button.k-button-solid-primary"
                ).click()
                time.sleep(4)
            except Exception:
                logger.error("Could not find Save button")

    def _set_kendo_dropdown(self, dropdown_el, value: str) -> None:
        """Select a value from a Kendo DropDownList."""
        dropdown_el.click()
        time.sleep(1)
        items = WebDriverWait(self.driver, 5).until(
            EC.presence_of_all_elements_located(
                (By.CSS_SELECTOR, "kendo-popup li, .k-list-item")
            )
        )
        for item in items:
            if item.text.strip().lower() == value.lower():
                item.click()
                time.sleep(0.5)
                return
        dropdown_el.send_keys(Keys.ESCAPE)
        logger.warning("Dropdown option '%s' not found", value)

    # ------------------------------------------------------------------ #
    #  Security — Create Group
    # ------------------------------------------------------------------ #

    def create_security_group(
        self,
        group_name: str,
        description: str,
        options: list[str] | None = None,
    ) -> dict[str, Any]:
        """Create a security group by filling the real PMWeb UI."""
        try:
            self._go_to_security()
            self._click_tab("Groups")
            time.sleep(1)

            # Click "New Group"
            new_btn = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable(
                    (By.XPATH, "//*[contains(text(),'New Group')]")
                )
            )
            new_btn.click()
            time.sleep(2)

            # Fill Group name (first kendo-textbox)
            textboxes = self.driver.find_elements(
                By.CSS_SELECTOR, "kendo-textbox input.k-input-inner"
            )
            if len(textboxes) < 2:
                raise RuntimeError("Cannot find Group/Description fields")

            textboxes[0].click()
            textboxes[0].clear()
            textboxes[0].send_keys(group_name)
            time.sleep(0.3)

            # Fill Description (second kendo-textbox)
            textboxes[1].click()
            textboxes[1].clear()
            textboxes[1].send_keys(description)
            time.sleep(0.3)

            # Enable requested option checkboxes
            if options:
                self._set_group_options(options)

            # Save
            self._click_save()

            self._switch_to_main()
            return {
                "status": "created",
                "group_name": group_name,
                "description": description,
                "options_enabled": options or [],
                "message": (
                    f"Security group '{group_name}' created in PMWeb"
                ),
            }
        except Exception as exc:
            self._switch_to_main()
            logger.exception("Failed to create security group")
            return {"status": "error", "message": str(exc)}

    def _set_group_options(self, options: list[str]) -> None:
        """Enable specific option checkboxes in the Groups options grid."""
        rows = self.driver.find_elements(
            By.CSS_SELECTOR, "kendo-grid tr.k-table-row"
        )
        for row in rows:
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            if len(cells) < 2:
                continue
            label = cells[1].text.strip() if len(cells) > 1 else ""
            if label in options:
                checkbox = cells[0].find_elements(
                    By.CSS_SELECTOR, "input[type='checkbox']"
                )
                if checkbox and not checkbox[0].is_selected():
                    checkbox[0].click()
                    time.sleep(0.3)
                    logger.info("Enabled option: %s", label)

    # ------------------------------------------------------------------ #
    #  Security — Create User
    # ------------------------------------------------------------------ #

    def create_user(
        self,
        user_id: str,
        first_name: str,
        last_name: str = "",
        email: str = "",
        license_type: str = "Full",
        named_license: str = "Named",
        group_name: str = "Admin",
        password: str = "Welcome1!",
        pmweb_admin: bool = False,
    ) -> dict[str, Any]:
        """Create a user by filling the real PMWeb Define Users grid."""
        try:
            self._go_to_security()
            self._click_tab("Users")
            time.sleep(2)

            # Click "New Line"
            new_line = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable(
                    (By.XPATH, "//*[contains(text(),'New Line')]")
                )
            )
            new_line.click()
            time.sleep(3)

            # Find the editable row (the one with many visible inputs)
            edit_row = self._find_edit_row()
            if not edit_row:
                raise RuntimeError("New user edit row not found")

            cells = edit_row.find_elements(By.CSS_SELECTOR, "td")

            # cell[3] = ID, cell[5] = First Name, cell[6] = Last Name
            # cell[8] = License Type dropdown, cell[9] = Named License dropdown
            # cell[10] = Group dropdown, cell[11] = Password
            self._fill_cell_input(cells[3], user_id)
            self._fill_cell_input(cells[5], first_name)
            if last_name:
                self._fill_cell_input(cells[6], last_name)

            # License Type dropdown (cell[8])
            lt_dd = cells[8].find_elements(
                By.CSS_SELECTOR, "kendo-dropdownlist"
            )
            if lt_dd:
                self._set_kendo_dropdown(lt_dd[0], license_type)

            # Named License dropdown (cell[9])
            nl_dd = cells[9].find_elements(
                By.CSS_SELECTOR, "kendo-dropdownlist"
            )
            if nl_dd:
                self._set_kendo_dropdown(nl_dd[0], named_license)

            # Group Name dropdown (cell[10])
            grp_dd = cells[10].find_elements(
                By.CSS_SELECTOR, "kendo-dropdownlist"
            )
            if grp_dd:
                self._set_kendo_dropdown(grp_dd[0], group_name)

            # Password (cell[11])
            if password:
                self._fill_cell_input(cells[11], password)

            # PMWEB Admin checkbox (cell[12])
            if pmweb_admin:
                chk = cells[12].find_elements(
                    By.CSS_SELECTOR, "input[type='checkbox']"
                )
                if chk and not chk[0].is_selected():
                    chk[0].click()
                    time.sleep(0.3)

            # Email — find the email field (around cell[17])
            if email:
                self._fill_email_field(cells, email)

            # Save
            self._click_save()

            self._switch_to_main()
            return {
                "status": "created",
                "user_id": user_id,
                "name": f"{first_name} {last_name}".strip(),
                "email": email,
                "group": group_name,
                "license_type": license_type,
                "named_license": named_license,
                "message": (
                    f"User '{first_name} {last_name}' created in PMWeb"
                ),
            }
        except Exception as exc:
            self._switch_to_main()
            logger.exception("Failed to create user")
            return {"status": "error", "message": str(exc)}

    def _find_edit_row(self):
        """Find the grid row that is in edit mode (has many visible inputs)."""
        rows = self.driver.find_elements(By.CSS_SELECTOR, "kendo-grid tr")
        for row in rows:
            inputs = row.find_elements(
                By.CSS_SELECTOR,
                "input:not([type='hidden']), kendo-dropdownlist",
            )
            visible = [i for i in inputs if i.is_displayed()]
            if len(visible) > 5:
                return row
        return None

    def _fill_cell_input(self, cell, value: str) -> None:
        """Fill a text/password input inside a grid cell."""
        inputs = cell.find_elements(
            By.CSS_SELECTOR,
            "input[type='text'], input[type='password'], "
            "input.k-input-inner",
        )
        visible = [i for i in inputs if i.is_displayed()]
        if visible:
            visible[0].click()
            visible[0].clear()
            visible[0].send_keys(value)
            time.sleep(0.3)

    def _fill_email_field(self, cells: list, email: str) -> None:
        """Find and fill the email field in the user row.

        Email is a text input that comes after the password and checkboxes,
        typically around cell index 17 or wherever we find an unfilled
        text input past the checkbox region.
        """
        for cell in cells[14:]:
            inputs = cell.find_elements(
                By.CSS_SELECTOR, "input[type='text']"
            )
            visible = [i for i in inputs if i.is_displayed()]
            if visible and not visible[0].get_attribute("value"):
                visible[0].click()
                visible[0].clear()
                visible[0].send_keys(email)
                time.sleep(0.3)
                return

    # ------------------------------------------------------------------ #
    #  Utility
    # ------------------------------------------------------------------ #

    def get_page_info(self) -> dict[str, Any]:
        return {
            "url": self.driver.current_url,
            "title": self.driver.title,
        }

    def take_screenshot(self, path: str = "/tmp/pmweb_screenshot.png") -> str:
        self.driver.save_screenshot(path)
        return path

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
