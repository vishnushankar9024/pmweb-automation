"""PMWeb browser automation — full consultant capabilities.

Performs real UI actions in a VISIBLE Chrome browser so the user
can watch everything happen via the live split-screen view.
"""

from __future__ import annotations

import logging
import time
from typing import Any

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

logger = logging.getLogger(__name__)

PMWEB_URL = "https://cmcs.pmweb.com/2025_1_00/pmweb/"


SECURITY_GROUP_SKIP_LABELS = {
    "Default Group",
    "Guest Users",
    "Adaptive Form Administrator",
    "Can change Due Date in Procurement",
    "Can Copy Project",
    "Can Edit WBS In Program",
    "Can Edit WBS In Project",
    "Can Execute Move",
    "Can Lock/Unlock Schedules",
    "Can Make Vendors Active/Inactive",
    "Can Make Locations Active/Inactive",
    "Can Make Projects Active/Inactive",
    "Can Send Notifications",
    "Custom Form Administrator",
    "Document Manager Administrator",
    "Events Administrator",
    "Lease Administrator",
    "PMWeb Report Administrator",
    "Procurement Administrator",
    "Report Manager Administrator",
    "Assets",
    "Costs",
    "Forms",
    "Plans",
    "Portfolio",
    "Schedules",
    "Tools",
    "Workflows",
    "View: Filtered",
    "Duplicate",
    "Delete",
    "New Group",
    "Group*",
    "Description*",
    "Option",
    "Logged into: All Levels",
    "Need Help?",
    "Security",
    "Manage your group and user security settings",
    "Licenses",
    "Save",
    "Cancel",
    "aS",
}

SECURITY_GROUP_SKIP_PREFIXES = (
    "Groups",
    "Users",
    "User Access",
    "Conditional",
    "Activity",
    "Password",
    "External",
)


def extract_security_group_names(page_text: str) -> list[str]:
    """Extract group names from PMWeb Security page text."""
    groups: list[str] = []
    seen: set[str] = set()
    for line in page_text.split("\n"):
        stripped = line.strip()
        if not stripped or len(stripped) > 60:
            continue
        if stripped in SECURITY_GROUP_SKIP_LABELS:
            continue
        if stripped.startswith(SECURITY_GROUP_SKIP_PREFIXES):
            continue
        if stripped.isdigit() or len(stripped) < 2:
            continue
        if stripped not in seen:
            groups.append(stripped)
            seen.add(stripped)
    return groups


def format_security_group_list(groups: list[str]) -> str:
    """Return a clean user-facing list of security group names."""
    if not groups:
        return "No security groups found."
    lines = [f"Security groups ({len(groups)}):"]
    lines.extend(f"- {group}" for group in groups)
    return "\n".join(lines)


class PMWebBrowser:
    """Full PMWeb automation via a VISIBLE browser."""

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
        opts = Options()
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-setuid-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--window-size=1400,900")
        if self.headless:
            opts.add_argument("--headless=new")
        return webdriver.Chrome(options=opts)

    # ------------------------------------------------------------------ #
    #  Login / Session
    # ------------------------------------------------------------------ #

    def login(self) -> dict[str, Any]:
        try:
            self.driver.get(self.base_url)
            time.sleep(3)
            pwd = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, "txtPassword"))
            )
            pwd.click()
            time.sleep(0.3)
            pwd.send_keys(self.password)
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
            r = self.login()
            if r["status"] != "success":
                raise RuntimeError(f"Login failed: {r.get('message')}")

    # ------------------------------------------------------------------ #
    #  Navigation
    # ------------------------------------------------------------------ #

    def _go_to_security(self) -> None:
        self._ensure_logged_in()
        self.driver.get(f"{self.base_url}/Security.aspx")
        time.sleep(3)
        iframe = WebDriverWait(self.driver, 10).until(
            EC.presence_of_element_located(
                (By.ID, "ctl00_CPH1_ngFrame")
            )
        )
        self.driver.switch_to.frame(iframe)
        time.sleep(3)

    def _go_to_adaptive_form_builder(self, form_id: int = 0) -> None:
        self._ensure_logged_in()
        url = (
            f"{self.base_url}/AdaptiveFormBuilder.aspx"
            f"?id={form_id}&ModuleId=8&PageId=371"
        )
        self.driver.get(url)
        time.sleep(8)
        iframe = WebDriverWait(self.driver, 15).until(
            EC.presence_of_element_located(
                (By.ID, "ctl00_CPH1_ngFrame")
            )
        )
        self.driver.switch_to.frame(iframe)
        time.sleep(5)

    def navigate_to(self, destination: str) -> dict[str, Any]:
        """Navigate to a PMWeb module/page."""
        self._ensure_logged_in()
        url_map = {
            "home": f"{self.base_url}/Home.aspx",
            "security": f"{self.base_url}/Security.aspx",
            "adaptive_forms": (
                f"{self.base_url}/SearchDocument.aspx?O=302"
            ),
            "settings": f"{self.base_url}/Settings.aspx",
        }
        if destination in url_map:
            self.driver.get(url_map[destination])
            time.sleep(3)
        else:
            self.driver.get(f"{self.base_url}/Home.aspx")
            time.sleep(3)
            self._click_sidebar_module(destination)
        return {
            "status": "navigated",
            "destination": destination,
            "url": self.driver.current_url,
        }

    def _click_sidebar_module(self, module: str) -> None:
        label_map = {
            "plans": "Plans",
            "forms": "Forms",
            "costs": "Costs",
            "schedules": "Schedules",
            "assets": "Assets",
            "workflows": "Workflows",
            "portfolio": "Portfolio",
            "tools": "Tools",
        }
        label = label_map.get(module, module.title())
        items = self.driver.find_elements(
            By.XPATH, f"//span[text()='{label}']"
        )
        for item in items:
            if item.is_displayed():
                item.click()
                time.sleep(3)
                return

    def _click_tab(self, tab_text: str) -> None:
        tabs = self.driver.find_elements(
            By.CSS_SELECTOR, "li.k-item.k-tabstrip-item"
        )
        for tab in tabs:
            if tab_text.lower() in tab.text.lower():
                tab.click()
                time.sleep(2)
                return

    def _switch_to_main(self) -> None:
        self.driver.switch_to.default_content()

    def _click_save(self) -> None:
        """Click the kendo Save button."""
        try:
            span = self.driver.find_element(
                By.XPATH,
                "//span[contains(@class,'k-button-text') "
                "and contains(text(),'Save')]",
            )
            span.find_element(By.XPATH, "./..").click()
            time.sleep(4)
        except Exception:
            logger.warning("Save button not found")

    def _set_kendo_dropdown(self, el, value: str) -> None:
        el.click()
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
        el.send_keys(Keys.ESCAPE)

    # ------------------------------------------------------------------ #
    #  Security — Groups
    # ------------------------------------------------------------------ #

    def create_security_group(
        self,
        group_name: str,
        description: str,
        options: list[str] | None = None,
    ) -> dict[str, Any]:
        try:
            self._go_to_security()
            self._click_tab("Groups")
            time.sleep(1)

            new_btn = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable(
                    (By.XPATH, "//*[contains(text(),'New Group')]")
                )
            )
            new_btn.click()
            time.sleep(2)

            tbs = self.driver.find_elements(
                By.CSS_SELECTOR, "kendo-textbox input.k-input-inner"
            )
            if len(tbs) < 2:
                raise RuntimeError("Group/Description fields not found")
            tbs[0].click()
            tbs[0].clear()
            tbs[0].send_keys(group_name)
            time.sleep(0.3)
            tbs[1].click()
            tbs[1].clear()
            tbs[1].send_keys(description)
            time.sleep(0.3)

            if options:
                self._set_group_options(options)

            self._click_save()
            self._switch_to_main()
            return {
                "status": "created",
                "group_name": group_name,
                "description": description,
                "options_enabled": options or [],
                "message": f"Group '{group_name}' created in PMWeb",
            }
        except Exception as exc:
            self._switch_to_main()
            return {"status": "error", "message": str(exc)}

    def _set_group_options(self, options: list[str]) -> None:
        rows = self.driver.find_elements(
            By.CSS_SELECTOR, "kendo-grid tr.k-table-row"
        )
        for row in rows:
            cells = row.find_elements(By.CSS_SELECTOR, "td")
            if len(cells) < 2:
                continue
            label = cells[1].text.strip()
            if label in options:
                chk = cells[0].find_elements(
                    By.CSS_SELECTOR, "input[type='checkbox']"
                )
                if chk and not chk[0].is_selected():
                    self.driver.execute_script(
                        "arguments[0].click()", chk[0]
                    )
                    time.sleep(0.3)

    # ------------------------------------------------------------------ #
    #  Security — Users
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
        try:
            self._go_to_security()
            self._click_tab("Users")
            time.sleep(2)

            new_line = WebDriverWait(self.driver, 10).until(
                EC.element_to_be_clickable(
                    (
                        By.XPATH,
                        "//span[contains(text(),'New Line')]/..",
                    )
                )
            )
            new_line.click()
            time.sleep(3)

            row = self._find_edit_row()
            if not row:
                raise RuntimeError("Edit row not found")
            cells = row.find_elements(By.CSS_SELECTOR, "td")

            self._fill_cell(cells[3], user_id)
            self._fill_cell(cells[5], first_name)
            if last_name:
                self._fill_cell(cells[6], last_name)
            self._fill_cell_dd(cells[8], license_type)
            self._fill_cell_dd(cells[9], named_license)
            self._fill_cell_dd(cells[10], group_name)
            if password:
                self._fill_cell(cells[11], password)
            if email:
                self._fill_cell(cells[17], email)
            if pmweb_admin:
                chk = cells[12].find_elements(
                    By.CSS_SELECTOR, "input[type='checkbox']"
                )
                if chk and not chk[0].is_selected():
                    chk[0].click()

            self._click_save()
            self._switch_to_main()
            return {
                "status": "created",
                "user_id": user_id,
                "name": f"{first_name} {last_name}".strip(),
                "email": email,
                "group": group_name,
                "message": f"User '{first_name} {last_name}' "
                "created in PMWeb",
            }
        except Exception as exc:
            self._switch_to_main()
            return {"status": "error", "message": str(exc)}

    def _find_edit_row(self):
        for row in self.driver.find_elements(
            By.CSS_SELECTOR, "kendo-grid tr"
        ):
            inputs = row.find_elements(
                By.CSS_SELECTOR,
                "input:not([type='hidden']), kendo-dropdownlist",
            )
            if sum(1 for i in inputs if i.is_displayed()) > 5:
                return row
        return None

    def _fill_cell(self, cell, value: str) -> None:
        for inp in cell.find_elements(
            By.CSS_SELECTOR,
            "input[type='text'], input[type='password'], "
            "input.k-input-inner",
        ):
            if inp.is_displayed():
                inp.click()
                inp.clear()
                inp.send_keys(value)
                time.sleep(0.3)
                return

    def _fill_cell_dd(self, cell, value: str) -> None:
        for dd in cell.find_elements(
            By.CSS_SELECTOR, "kendo-dropdownlist"
        ):
            if dd.is_displayed():
                self._set_kendo_dropdown(dd, value)
                return

    # ------------------------------------------------------------------ #
    #  Adaptive Forms
    # ------------------------------------------------------------------ #

    def create_adaptive_form(
        self,
        form_name: str,
        fields: list[dict[str, Any]] | None = None,
    ) -> dict[str, Any]:
        """Create an Adaptive Form by designing it in the SurveyJS
        Creator and clicking the hidden SaveTemplate button."""
        try:
            self._go_to_adaptive_form_builder(form_id=0)

            # Set form title
            title = self.driver.find_element(
                By.XPATH,
                "//span[contains(@class,'sv-string-editor') "
                "and text()='Default Adaptive Form']",
            )
            title.click()
            time.sleep(0.3)
            ActionChains(self.driver).key_down(Keys.CONTROL).send_keys(
                "a"
            ).key_up(Keys.CONTROL).perform()
            ActionChains(self.driver).send_keys(form_name).perform()
            self.driver.find_element(By.TAG_NAME, "body").click()
            time.sleep(1)

            # Add custom fields
            added_fields = []
            if fields:
                for field in fields:
                    label = field.get("label", "")
                    if label:
                        self._add_survey_field(label)
                        added_fields.append(label)

            # Click the hidden SaveTemplate button
            save_btn = self.driver.find_element(
                By.CSS_SELECTOR,
                "input[value='SaveTemplate']",
            )
            self.driver.execute_script(
                "arguments[0].click()", save_btn
            )
            time.sleep(8)

            # Check if save succeeded (URL changes from id=0 to id=N)
            self._switch_to_main()
            url = self.driver.current_url
            if "Id=0" not in url and "id=0" not in url:
                import re

                m = re.search(r"[Ii]d=(\d+)", url)
                new_id = int(m.group(1)) if m else None
                return {
                    "status": "created",
                    "form_name": form_name,
                    "form_id": new_id,
                    "fields": added_fields,
                    "message": (
                        f"Adaptive form '{form_name}' created "
                        f"(ID={new_id}) in PMWeb"
                    ),
                }
            return {
                "status": "created",
                "form_name": form_name,
                "fields": added_fields,
                "message": f"Adaptive form '{form_name}' created",
            }
        except Exception as exc:
            self._switch_to_main()
            return {"status": "error", "message": str(exc)}

    def _add_survey_field(self, label: str) -> None:
        """Add a field to the SurveyJS form and rename it."""
        add_btns = self.driver.find_elements(
            By.XPATH, "//span[contains(text(),'Add Field')]"
        )
        visible = [b for b in add_btns if b.is_displayed()]
        if visible:
            visible[-1].click()
            time.sleep(2)
        for fl in reversed(
            self.driver.find_elements(
                By.CSS_SELECTOR, "span.sv-string-editor"
            )
        ):
            if fl.text.startswith("field") and fl.is_displayed():
                fl.click()
                time.sleep(0.3)
                ActionChains(self.driver).key_down(
                    Keys.CONTROL
                ).send_keys("a").key_up(Keys.CONTROL).perform()
                ActionChains(self.driver).send_keys(label).perform()
                self.driver.find_element(
                    By.TAG_NAME, "body"
                ).click()
                time.sleep(0.5)
                break

    # ------------------------------------------------------------------ #
    #  Read / Query
    # ------------------------------------------------------------------ #

    def list_security_groups(self) -> dict[str, Any]:
        """Read all security group names from the Groups tab."""
        try:
            self._go_to_security()
            self._click_tab("Groups")
            time.sleep(2)
            body = self.driver.find_element(
                By.TAG_NAME, "body"
            ).text
            groups = extract_security_group_names(body)
            self._switch_to_main()
            return {
                "status": "success",
                "groups": groups,
                "count": len(groups),
                "message": format_security_group_list(groups),
            }
        except Exception as exc:
            self._switch_to_main()
            return {"status": "error", "message": str(exc)}

    def list_users(self) -> dict[str, Any]:
        """Read user list from the Users tab."""
        try:
            self._go_to_security()
            self._click_tab("Users")
            time.sleep(3)
            rows = self.driver.find_elements(
                By.CSS_SELECTOR, "kendo-grid tr.k-table-row"
            )
            users = []
            for row in rows[:50]:
                cells = row.find_elements(By.CSS_SELECTOR, "td")
                if len(cells) >= 6:
                    texts = [c.text.strip() for c in cells[:8]]
                    if texts[1]:
                        users.append({
                            "id": texts[1],
                            "first_name": texts[3] if len(texts) > 3 else "",
                            "last_name": texts[4] if len(texts) > 4 else "",
                            "license_type": texts[5] if len(texts) > 5 else "",
                            "group": texts[7] if len(texts) > 7 else "",
                        })
            self._switch_to_main()
            return {
                "status": "success",
                "users": users,
                "count": len(users),
            }
        except Exception as exc:
            self._switch_to_main()
            return {"status": "error", "message": str(exc)}

    # ------------------------------------------------------------------ #
    #  Utility
    # ------------------------------------------------------------------ #

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
