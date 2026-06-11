"""Regression tests for the LLM intent parser and deterministic flows."""

from app.agent.browser_agent import INTENT_PROMPT, HybridAgent, _build_registry_context
from app.agent.pmweb_flows import PMWebFlows
from app.agent.pmweb_registry import get_record_type, get_required_fields


class FakeSecurityNav:
    def __init__(self) -> None:
        self.textboxes: list[tuple[int, str]] = []
        self.actions: list[tuple[str, str]] = []

    def navigate(self, url_fragment: str) -> str:
        self.actions.append(("navigate", url_fragment))
        return f"navigated to {url_fragment}"

    def switch_to_iframe(self, iframe_id: str) -> str:
        self.actions.append(("switch_to_iframe", iframe_id))
        return f"switched to iframe {iframe_id}"

    def click_tab(self, tab_text: str) -> str:
        self.actions.append(("click_tab", tab_text))
        return f"clicked tab: {tab_text}"

    def click_toolbar_button(self, button_text: str) -> str:
        self.actions.append(("click_toolbar_button", button_text))
        return f"clicked toolbar: {button_text}"

    def fill_kendo_textbox(self, index: int, value: str) -> str:
        self.textboxes.append((index, value))
        return f"filled textbox[{index}]: {value}"

    def toggle_checkbox(self, label: str, check: bool = True) -> str:
        self.actions.append(("toggle_checkbox", label))
        return f"checked: {label}" if check else f"unchecked: {label}"

    def set_module_permission(self, module: str, permission: str) -> str:
        self.actions.append(("set_module_permission", f"{module}:{permission}"))
        return f"set {module} -> {permission}"

    def click_save(self) -> str:
        self.actions.append(("click_save", ""))
        return "saved"


class FakeReadNav:
    def __init__(self, rows: list[dict[str, str]]) -> None:
        self._rows = rows

    def navigate(self, _url_fragment: str) -> str:
        return "navigated"

    def switch_to_iframe(self, _iframe_id: str) -> str:
        return "switched"

    def read_kendo_grid(self, max_rows: int = 30) -> list[dict[str, str]]:
        return self._rows[:max_rows]


def test_security_group_registry_requires_group_id():
    assert get_required_fields("Security Groups") == ["Group ID", "Description"]


def test_intent_prompt_documents_security_group_group_id():
    assert 'fields["Group ID"]' in INTENT_PROMPT
    assert "Do not use \"Group Name\"" in INTENT_PROMPT


def test_registry_context_includes_group_id_requirement():
    _, required_fields = _build_registry_context()

    assert "Security Groups: Group ID, Description" in required_fields


def test_security_group_flow_fills_group_id_before_description():
    nav = FakeSecurityNav()
    flow = PMWebFlows(nav)  # type: ignore[arg-type]
    rt = get_record_type("Security Groups")

    result = flow.create_security_group(
        rt,
        {"Group ID": "CONTRACTORS", "Description": "Security group for contractors"},
        [],
        {},
    )

    assert not result.has_errors
    assert nav.textboxes == [
        (0, "CONTRACTORS"),
        (1, "Security group for contractors"),
    ]
    assert [step["action"] for step in result.steps] == [
        "navigate",
        "switch_to_iframe",
        "click_tab_groups",
        "click_new_group",
        "fill_group_id",
        "fill_description",
        "save",
    ]


def test_security_group_flow_accepts_legacy_group_name_alias():
    nav = FakeSecurityNav()
    flow = PMWebFlows(nav)  # type: ignore[arg-type]
    rt = get_record_type("Security Groups")

    flow.create_security_group(
        rt,
        {"Group Name": "Contractors", "Description": "Security group for contractors"},
        [],
        {},
    )

    assert nav.textboxes[0] == (0, "Contractors")


def test_agent_dispatch_routes_security_group_fields_to_flow():
    captured = {}

    class FakeFlows:
        def create_security_group(self, rt, fields, options, permissions):
            captured["record_type"] = rt.name
            captured["fields"] = fields
            captured["options"] = options
            captured["permissions"] = permissions

            class Result:
                steps = []

            return Result()

    agent = HybridAgent()
    agent._flows = FakeFlows()  # type: ignore[assignment]

    agent._dispatch_to_flow(
        {
            "intent": "create",
            "record_type": "Security Groups",
            "fields": {
                "Group ID": "CONTRACTORS",
                "Description": "Security group for contractors",
            },
            "options": [],
            "permissions": {},
        }
    )

    assert captured == {
        "record_type": "Security Groups",
        "fields": {
            "Group ID": "CONTRACTORS",
            "Description": "Security group for contractors",
        },
        "options": [],
        "permissions": {},
    }


def test_blank_task_asks_for_details_without_login():
    agent = HybridAgent()

    def fail_login():
        raise AssertionError("blank tasks should not log in to PMWeb")

    agent.login = fail_login

    result = agent.run_task_sync("   ")

    assert result == {
        "reply": "Please describe what you want me to do in PMWeb.",
        "actions": [],
    }


def test_read_records_keeps_all_rows_for_listing():
    rows = [{"Group ID": f"Group {i}", "Description": f"Desc {i}"} for i in range(1, 13)]
    nav = FakeReadNav(rows)
    flow = PMWebFlows(nav)  # type: ignore[arg-type]
    rt = get_record_type("Security Groups")

    result = flow.read_records(rt, "Security Groups")

    read_step = next(step for step in result.steps if step["action"] == "read_grid")
    assert read_step["result"]["rows"] == 12
    assert len(read_step["result"]["data"]) == 12
    assert read_step["result"]["data"][-1]["Group ID"] == "Group 12"


def test_build_reply_lists_all_security_groups():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 3,
                "data": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                    {"Group ID": "PMWEB Admin", "Description": "Admin users"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert "Security groups (3):" in reply
    assert "1. Default Group — System defaults" in reply
    assert "2. Guest Users — Guest profile" in reply
    assert "3. PMWEB Admin — Admin users" in reply
