"""PMWeb browser automation using Selenium.

Handles login, navigation, and configuration actions in the real PMWeb application.
"""

from __future__ import annotations

import logging
import time
from typing import Any

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

logger = logging.getLogger(__name__)


class PMWebBrowser:
    """Automates interaction with the PMWeb web application via Selenium."""

    def __init__(
        self,
        base_url: str,
        username: str,
        password: str,
        headless: bool = True,
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
        options.add_argument("--window-size=1280,900")
        if self.headless:
            options.add_argument("--headless=new")
        return webdriver.Chrome(options=options)

    def login(self) -> dict[str, Any]:
        """Log into PMWeb and return status."""
        try:
            logger.info("Navigating to PMWeb login: %s", self.base_url)
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
                logger.info("Session conflict alert, accepting...")
                alert.accept()
                time.sleep(5)
            except Exception:
                time.sleep(5)

            if "Home" in self.driver.current_url:
                self._logged_in = True
                logger.info("Login successful")
                return {"status": "success", "url": self.driver.current_url}

            errors = self.driver.find_elements(By.CSS_SELECTOR, ".errorMsg")
            err_texts = [e.text for e in errors if e.text]
            return {"status": "error", "message": "; ".join(err_texts)}

        except Exception as exc:
            logger.exception("Login failed")
            return {"status": "error", "message": str(exc)}

    def _ensure_logged_in(self) -> None:
        if not self._logged_in:
            result = self.login()
            if result["status"] != "success":
                raise RuntimeError(f"Login failed: {result.get('message')}")

    def navigate_to_security(self) -> dict[str, Any]:
        """Navigate to the Security page."""
        self._ensure_logged_in()
        self.driver.get(f"{self.base_url}/Security.aspx")
        time.sleep(3)
        return {
            "status": "navigated",
            "url": self.driver.current_url,
            "title": self.driver.title,
        }

    def navigate_to_forms(self) -> dict[str, Any]:
        """Navigate to the Forms module."""
        self._ensure_logged_in()
        self.driver.get(f"{self.base_url}/Home.aspx")
        time.sleep(2)
        try:
            self.driver.execute_script(
                "__doPostBack('ctl00$rptModules$ctl01$btnModule','')"
            )
            time.sleep(3)
        except Exception:
            pass
        return {
            "status": "navigated",
            "url": self.driver.current_url,
            "title": self.driver.title,
        }

    def navigate_to_workflows(self) -> dict[str, Any]:
        """Navigate to the Workflows module."""
        self._ensure_logged_in()
        self.driver.get(f"{self.base_url}/Home.aspx")
        time.sleep(2)
        try:
            self.driver.execute_script(
                "__doPostBack('ctl00$rptModules$ctl05$btnModule','')"
            )
            time.sleep(3)
        except Exception:
            pass
        return {
            "status": "navigated",
            "url": self.driver.current_url,
            "title": self.driver.title,
        }

    def navigate_to_tools(self) -> dict[str, Any]:
        """Navigate to the Tools section."""
        self._ensure_logged_in()
        try:
            tools = self.driver.find_element(
                By.XPATH, "//span[contains(text(),'Tools')]"
            )
            tools.click()
            time.sleep(2)
            return {"status": "navigated", "section": "tools"}
        except Exception as exc:
            return {"status": "error", "message": str(exc)}

    def get_page_info(self) -> dict[str, Any]:
        """Get current page state for the agent."""
        return {
            "url": self.driver.current_url,
            "title": self.driver.title,
            "text": self.driver.find_element(
                By.TAG_NAME, "body"
            ).text[:2000],
        }

    def execute_js(self, script: str) -> Any:
        """Execute arbitrary JavaScript in the PMWeb page."""
        self._ensure_logged_in()
        return self.driver.execute_script(script)

    def find_and_click(self, selector: str) -> dict[str, Any]:
        """Find an element and click it."""
        self._ensure_logged_in()
        try:
            el = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable((By.CSS_SELECTOR, selector))
            )
            el.click()
            time.sleep(1)
            return {"status": "clicked", "selector": selector}
        except Exception as exc:
            return {"status": "error", "message": str(exc)}

    def fill_field(self, selector: str, value: str) -> dict[str, Any]:
        """Fill a form field with a value."""
        self._ensure_logged_in()
        try:
            el = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, selector))
            )
            el.clear()
            el.send_keys(value)
            time.sleep(0.3)
            return {"status": "filled", "selector": selector, "value": value}
        except Exception as exc:
            return {"status": "error", "message": str(exc)}

    def take_screenshot(self, path: str = "/tmp/pmweb_screenshot.png") -> str:
        """Take a screenshot and return the path."""
        self.driver.save_screenshot(path)
        return path

    def close(self) -> None:
        """Close the browser."""
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
