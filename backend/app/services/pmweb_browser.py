"""PMWeb browser automation — performs real UI actions visible to the user.

Uses Selenium in VISIBLE mode so the user can watch the agent
navigate PMWeb and fill in forms in real-time.
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

    def login(self) -> dict[str, Any]:
        """Log into PMWeb visibly."""
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
            err_texts = [e.text for e in errors if e.text]
            return {
                "status": "error",
                "message": "; ".join(err_texts) or "Login failed",
            }
        except Exception as exc:
            logger.exception("Login failed")
            return {"status": "error", "message": str(exc)}

    def _ensure_logged_in(self) -> None:
        if not self._logged_in:
            result = self.login()
            if result["status"] != "success":
                raise RuntimeError(f"Login failed: {result.get('message')}")

    def _go_to_security(self) -> None:
        """Navigate to Security page and switch to the Angular iframe."""
        self._ensure_logged_in()
        self.driver.get(f"{self.base_url}/Security.aspx")
        time.sleep(3)
        iframe = WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located((By.ID, "ctl00_CPH1_ngFrame"))
        )
        self.driver.switch_to.frame(iframe)
        time.sleep(2)

    def _switch_to_main(self) -> None:
        """Switch back to the main content from iframe."""
        self.driver.switch_to.default_content()

    def _click_tab(self, tab_text: str) -> None:
        """Click a tab by its text label inside the security iframe."""
        tabs = self.driver.find_elements(
            By.CSS_SELECTOR, "li.k-item.k-tabstrip-item"
        )
        for tab in tabs:
            if tab_text.lower() in tab.text.lower():
                tab.click()
                time.sleep(2)
                return
        raise RuntimeError(f"Tab '{tab_text}' not found")

    def create_security_group(
        self, group_name: str, description: str
    ) -> dict[str, Any]:
        """Create a new security group in PMWeb by filling the real UI."""
        try:
            self._go_to_security()
            time.sleep(1)

            # Make sure Groups tab is active (it's default)
            self._click_tab("Groups")
            time.sleep(1)

            # Click "New Group" button
            new_group_btn = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable(
                    (By.XPATH, "//*[contains(text(),'New Group')]")
                )
            )
            new_group_btn.click()
            time.sleep(2)

            # Find the Group name field (first text input after the toolbar)
            # The Group* and Description* fields are Kendo TextBox inputs
            inputs = self.driver.find_elements(
                By.CSS_SELECTOR, "kendo-textbox input, input.k-input-inner"
            )
            logger.info("Found %d input fields", len(inputs))

            # Group field is typically the first, Description the second
            if len(inputs) >= 2:
                group_input = inputs[0]
                desc_input = inputs[1]
            else:
                raise RuntimeError("Could not find Group/Description fields")

            # Fill Group name
            group_input.click()
            group_input.clear()
            group_input.send_keys(group_name)
            time.sleep(0.5)

            # Fill Description
            desc_input.click()
            desc_input.clear()
            desc_input.send_keys(description)
            time.sleep(0.5)

            # Save — look for Save button or use Ctrl+S
            save_btns = self.driver.find_elements(
                By.XPATH,
                "//*[contains(text(),'Save')]"
                "| //button[contains(@class,'save')]"
                "| //*[@title='Save']",
            )
            if save_btns:
                save_btns[0].click()
            else:
                # Try Ctrl+S
                group_input.send_keys(Keys.CONTROL, "s")
            time.sleep(3)

            self._switch_to_main()
            return {
                "status": "created",
                "group_name": group_name,
                "description": description,
                "message": f"Security group '{group_name}' created in PMWeb",
            }
        except Exception as exc:
            self._switch_to_main()
            logger.exception("Failed to create security group")
            return {"status": "error", "message": str(exc)}

    def create_user(
        self,
        user_id: str,
        first_name: str,
        last_name: str,
        email: str,
        group_name: str,
        password: str = "Welcome1!",
    ) -> dict[str, Any]:
        """Create a new user in PMWeb by filling the Define Users form."""
        try:
            self._go_to_security()
            time.sleep(1)

            # Click Users tab
            self._click_tab("Users")
            time.sleep(2)

            # Click New/Add user button
            new_user_btns = self.driver.find_elements(
                By.XPATH,
                "//*[contains(text(),'New')]"
                "| //*[contains(text(),'Add')]"
                "| //button[contains(@title,'New')]"
                "| //button[contains(@title,'Add')]",
            )
            for btn in new_user_btns:
                if "new" in btn.text.lower() or "add" in btn.text.lower():
                    btn.click()
                    break
            time.sleep(2)

            # Fill in user fields — find by label association or order
            inputs = self.driver.find_elements(
                By.CSS_SELECTOR, "kendo-textbox input, input.k-input-inner"
            )
            logger.info("Found %d user inputs", len(inputs))

            # The user form fields are in order based on PMWeb docs:
            # ID, First Name, Last Name, Password, Email
            # We'll fill them by finding labels
            self._fill_field_by_label("ID", user_id)
            self._fill_field_by_label("First Name", first_name)
            self._fill_field_by_label("Last Name", last_name)
            self._fill_field_by_label("Email", email)
            self._fill_field_by_label("Password", password)

            # Select group from dropdown
            self._select_dropdown("Group", group_name)

            # Save
            save_btns = self.driver.find_elements(
                By.XPATH,
                "//*[contains(text(),'Save')]"
                "| //button[contains(@class,'save')]",
            )
            if save_btns:
                save_btns[0].click()
            time.sleep(3)

            self._switch_to_main()
            return {
                "status": "created",
                "user_id": user_id,
                "name": f"{first_name} {last_name}",
                "email": email,
                "group": group_name,
                "message": (
                    f"User '{first_name} {last_name}' created in PMWeb"
                ),
            }
        except Exception as exc:
            self._switch_to_main()
            logger.exception("Failed to create user")
            return {"status": "error", "message": str(exc)}

    def _fill_field_by_label(self, label: str, value: str) -> None:
        """Find a field by its label text and fill it."""
        try:
            label_el = self.driver.find_element(
                By.XPATH,
                f"//*[contains(text(),'{label}')]"
                f"/ancestor::*[1]//input"
                f" | //*[contains(text(),'{label}')]"
                f"/following::input[1]",
            )
            label_el.click()
            label_el.clear()
            label_el.send_keys(value)
            time.sleep(0.3)
        except Exception:
            logger.warning("Could not find field for label '%s'", label)

    def _select_dropdown(self, label: str, value: str) -> None:
        """Select a value from a Kendo dropdown by label."""
        try:
            dropdown = self.driver.find_element(
                By.XPATH,
                f"//*[contains(text(),'{label}')]"
                f"/following::kendo-dropdownlist[1]"
                f" | //*[contains(text(),'{label}')]"
                f"/following::select[1]",
            )
            dropdown.click()
            time.sleep(1)
            option = WebDriverWait(self.driver, 5).until(
                EC.element_to_be_clickable(
                    (By.XPATH, f"//li[contains(text(),'{value}')]")
                )
            )
            option.click()
            time.sleep(0.5)
        except Exception:
            logger.warning(
                "Could not select '%s' in dropdown '%s'", value, label
            )

    def get_page_info(self) -> dict[str, Any]:
        """Get current page state."""
        return {
            "url": self.driver.current_url,
            "title": self.driver.title,
        }

    def take_screenshot(self, path: str = "/tmp/pmweb_screenshot.png") -> str:
        """Take a screenshot."""
        self.driver.save_screenshot(path)
        return path

    def close(self) -> None:
        """Close the browser."""
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
