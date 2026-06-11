from selenium.webdriver.common.by import By

from app.agent.pmweb_navigator import PMWebNavigator


class _FakeElement:
    def __init__(
        self,
        attrs: dict[str, str | None] | None = None,
        displayed: bool = True,
        text: str = "",
    ) -> None:
        self._attrs = attrs or {}
        self._displayed = displayed
        self.text = text
        self.clicks = 0

    def is_displayed(self) -> bool:
        return self._displayed

    def get_attribute(self, name: str) -> str | None:
        return self._attrs.get(name)

    def click(self) -> None:
        self.clicks += 1


class _FakeDriver:
    def __init__(
        self,
        css_matches: dict[str, list[_FakeElement]] | None = None,
        xpath_matches: dict[str, list[_FakeElement]] | None = None,
        parent_disabled: bool = False,
        clickable_ancestor: _FakeElement | None = None,
    ) -> None:
        self._css_matches = css_matches or {}
        self._xpath_matches = xpath_matches or {}
        self._parent_disabled = parent_disabled
        self._clickable_ancestor = clickable_ancestor

    def find_elements(self, by: str, selector: str) -> list[_FakeElement]:
        if by == By.CSS_SELECTOR:
            return self._css_matches.get(selector, [])
        if by == By.XPATH:
            return self._xpath_matches.get(selector, [])
        return []

    def execute_script(self, script: str, element: _FakeElement):  # noqa: ANN001
        if "disabledParent" in script:
            return self._parent_disabled
        if "closest('button, a, span[role=\"button\"], span.k-pager-nav')" in script:
            return self._clickable_ancestor
        if script.strip() == "arguments[0].click()":
            element.click()
            return None
        return None


def _build_nav(driver: _FakeDriver) -> PMWebNavigator:
    nav = PMWebNavigator.__new__(PMWebNavigator)
    nav.driver = driver  # type: ignore[assignment]
    return nav


def test_go_to_next_kendo_page_clicks_span_next_control():
    next_control = _FakeElement({"class": "k-pager-nav k-pager-next"})
    driver = _FakeDriver(
        css_matches={"span.k-pager-nav.k-pager-next": [next_control]},
    )
    nav = _build_nav(driver)
    nav._wait_for_pager_state_change = lambda _signature, timeout_s=3.0: True  # type: ignore[method-assign]

    moved = nav._go_to_next_kendo_page()

    assert moved is True
    assert next_control.clicks == 1


def test_go_to_next_kendo_page_skips_controls_disabled_by_parent():
    next_control = _FakeElement({"class": "k-pager-nav k-pager-next"})
    driver = _FakeDriver(
        css_matches={"span.k-pager-nav.k-pager-next": [next_control]},
        parent_disabled=True,
    )
    nav = _build_nav(driver)

    moved = nav._go_to_next_kendo_page()

    assert moved is False
    assert next_control.clicks == 0


def test_go_to_next_kendo_page_uses_numeric_button_when_next_control_missing():
    active_page = _FakeElement(text="1")
    next_page = _FakeElement(text="2")
    driver = _FakeDriver(
        css_matches={
            ".k-pager-numbers .k-selected": [active_page],
            ".k-pager-numbers button": [next_page],
        },
    )
    nav = _build_nav(driver)
    nav._wait_for_pager_state_change = lambda _signature, timeout_s=3.0: True  # type: ignore[method-assign]

    moved = nav._go_to_next_kendo_page()

    assert moved is True
    assert next_page.clicks == 1
