"""Regression tests for the LLM intent parser and deterministic flows."""

from app.agent.browser_agent import INTENT_PROMPT, HybridAgent, _build_registry_context
from app.agent.pmweb_flows import PMWebFlows
from app.agent.pmweb_navigator import PMWebNavigator
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
        self.called_read_kendo_grid = 0
        self.called_read_security_groups = 0

    def navigate(self, _url_fragment: str) -> str:
        return "navigated"

    def switch_to_iframe(self, _iframe_id: str) -> str:
        return "switched"

    def read_kendo_grid(self, max_rows: int = 30) -> list[dict[str, str]]:
        self.called_read_kendo_grid += 1
        return self._rows[:max_rows]

    def read_security_groups(self, max_rows: int = 200) -> list[dict[str, str]]:
        self.called_read_security_groups += 1
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


def test_run_task_sync_security_group_list_uses_deterministic_fast_path():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
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

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = (  # type: ignore[method-assign]
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("LLM parser should not run"))
    )

    result = agent.run_task_sync("List all security groups")

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
        "3. PMWEB Admin — Admin users",
    ]


def test_run_task_with_context_security_group_list_ignores_attached_create_text():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 3,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": 2,
                            "data": [
                                {"Group ID": "Default Group", "Description": "System defaults"},
                                {"Group ID": "Guest Users", "Description": "Guest profile"},
                            ],
                        },
                    }
                ]

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = (  # type: ignore[method-assign]
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("LLM parser should not run"))
    )

    result = agent.run_task_with_context(
        "List all security groups",
        file_context="This attached note says create a new record later.",
    )

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_security_group_list_detection_ignores_add_substring_inside_words():
    assert HybridAgent._is_security_group_list_task(
        "List all security groups with additional details"
    )

def test_run_task_sync_security_group_list_retries_when_payload_is_sampled():
    class FakeFlows:
        def __init__(self) -> None:
            self.calls = 0

        def read_records(self, _rt, _record_type_name):
            self.calls += 1
            if self.calls == 1:
                class Result:
                    steps = [
                        {
                            "step": 3,
                            "action": "read_grid",
                            "result": {
                                "record_type": "Security Groups",
                                "rows": 4,
                                "sample_rows": [
                                    {"Group ID": "Default Group", "Description": "System defaults"},
                                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                                ],
                            },
                        }
                    ]

                return Result()

            class Result:
                steps = [
                    {
                        "step": 4,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": 4,
                            "data": [
                                {"Group ID": "Default Group", "Description": "System defaults"},
                                {"Group ID": "Guest Users", "Description": "Guest profile"},
                                {"Group ID": "PMWEB Admin", "Description": "Admin users"},
                                {"Group ID": "Power Users", "Description": "Power user access"},
                            ],
                        },
                    }
                ]

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    fake_flows = FakeFlows()
    agent._flows = fake_flows  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = (  # type: ignore[method-assign]
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("LLM parser should not run"))
    )

    result = agent.run_task_sync("List all security groups")

    assert fake_flows.calls == 2
    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
        "3. PMWEB Admin — Admin users",
        "4. Power Users — Power user access",
    ]

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
    assert nav.called_read_security_groups == 1
    assert nav.called_read_kendo_grid == 0


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

    lines = reply.splitlines()
    assert lines == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
        "3. PMWEB Admin — Admin users",
    ]


def test_build_reply_lists_security_groups_even_when_step_action_varies():
    agent = HybridAgent()
    parsed = {"intent": "create", "record_type": ""}
    results = [
        {
            "step": 5,
            "action": "inspect_grid",
            "result": {
                "rows": 2,
                "data": [
                    {"col_0": "Default Group", "col_1": "System defaults"},
                    {"col_0": "Guest Users", "col_1": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_lists_security_groups_from_stringified_payload():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    results = [
        {
            "step": 7,
            "action": "read_grid",
            "result": (
                "{'rows': 2, 'data': ["
                "{'Group ID': 'Default Group', 'Description': 'System defaults'}, "
                "{'Group ID': 'Guest Users', 'Description': 'Guest profile'}]}"
            ),
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_lists_security_groups_from_list_rows_payload():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    results = [
        {
            "step": 4,
            "action": "inspect_grid",
            "output": (
                "[['Default Group', 'System defaults'], "
                "['Guest Users', 'Guest profile']]"
            ),
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_reads_groups_from_alternate_result_key():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    results = [
        {
            "step": 4,
            "action": "inspect_grid",
            "result": {
                "groups": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_reads_groups_from_stringified_output_payload():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": ""}
    results = [
        {
            "step": 6,
            "action": "read_grid",
            "output": (
                '{"payload":{"items":[{"col_0":"Default Group","col_1":"System defaults"},'
                '{"col_0":"Guest Users","col_1":"Guest profile"}]}}'
            ),
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_reads_groups_from_rows_key_payload():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    results = [
        {
            "step": 9,
            "action": "read_grid",
            "result": {
                "count": 2,
                "rows": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_reads_groups_from_python_literal_result_payload():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": ""}
    results = [
        {
            "step": 7,
            "action": "read_grid",
            "result": (
                "{'data':[{'col_1':'Default Group','col_2':'System defaults'},"
                "{'col_1':'Guest Users','col_2':'Guest profile'}]}"
            ),
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_reads_groups_from_sample_strings_payload():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": ""}
    results = [
        {
            "step": 10,
            "action": "inspect_grid",
            "result": {
                "rows": 2,
                "sample": ["Default Group", "Guest Users"],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group",
        "2. Guest Users",
    ]


def test_build_reply_prefers_security_group_rows_even_when_intent_is_create():
    agent = HybridAgent()
    parsed = {"intent": "create", "record_type": ""}
    results = [
        {
            "step": 8,
            "action": "inspect_grid",
            "record_type": "Security Groups",
            "result": {
                "data": [
                    {"col_1": "Default Group", "col_2": "System defaults"},
                    {"col_1": "Guest Users", "col_2": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("Please continue", parsed, results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_retries_security_group_read_when_payload_has_no_rows():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 4,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": 2,
                            "data": [
                                {"Group ID": "Default Group", "Description": "System defaults"},
                                {"Group ID": "Guest Users", "Description": "Guest profile"},
                            ],
                        },
                    }
                ]

            return Result()

    agent = HybridAgent()
    agent._flows = FakeFlows()  # type: ignore[assignment]
    parsed = {"intent": "read", "record_type": "Security Groups"}
    malformed_results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": "found 28 rows",
            "output": "rows: 28, sample: Default Group, Guest Users",
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, malformed_results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_retries_when_security_group_payload_is_sampled():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 5,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": 4,
                            "data": [
                                {"Group ID": "Default Group", "Description": "System defaults"},
                                {"Group ID": "Guest Users", "Description": "Guest profile"},
                                {"Group ID": "PMWEB Admin", "Description": "Admin users"},
                                {"Group ID": "Power Users", "Description": "Power user access"},
                            ],
                        },
                    }
                ]

            return Result()

    agent = HybridAgent()
    agent._flows = FakeFlows()  # type: ignore[assignment]
    parsed = {"intent": "read", "record_type": "Security Groups"}
    sampled_results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 4,
                "sample_rows": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, sampled_results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
        "3. PMWEB Admin — Admin users",
        "4. Power Users — Power user access",
    ]


def test_build_reply_uses_direct_read_when_retry_payload_remains_sampled():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 5,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": 4,
                            "sample_rows": [
                                {"Group ID": "Default Group", "Description": "System defaults"},
                                {"Group ID": "Guest Users", "Description": "Guest profile"},
                            ],
                        },
                    }
                ]

            return Result()

    class FakeNav:
        def read_security_groups(self, max_rows=1000):
            return [
                {"Group ID": "Default Group", "Description": "System defaults"},
                {"Group ID": "Guest Users", "Description": "Guest profile"},
                {"Group ID": "PMWEB Admin", "Description": "Admin users"},
                {"Group ID": "Power Users", "Description": "Power user access"},
            ][:max_rows]

    agent = HybridAgent()
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._nav = FakeNav()  # type: ignore[assignment]
    parsed = {"intent": "read", "record_type": "Security Groups"}
    sampled_results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 4,
                "sample_rows": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, sampled_results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
        "3. PMWEB Admin — Admin users",
        "4. Power Users — Power user access",
    ]


def test_build_reply_uses_direct_security_group_fallback_when_flow_retry_unavailable():
    class FakeNav:
        def read_security_groups(self, max_rows=1000):
            return [
                {"Group ID": "Default Group", "Description": "System defaults"},
                {"Group ID": "Guest Users", "Description": "Guest profile"},
            ][:max_rows]

    agent = HybridAgent()
    agent._nav = FakeNav()  # type: ignore[assignment]
    malformed_results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": "found 28 rows",
            "output": "rows: 28, sample: Default Group, Guest Users",
        }
    ]

    reply = agent._build_reply(
        "List all security groups",
        {"intent": "read", "record_type": "Security Groups"},
        malformed_results,
    )

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_build_reply_handles_shifted_security_group_columns_without_wrapper():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    results = [
        {
            "step": 8,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 2,
                "data": [
                    {"col_0": "", "col_1": "", "col_2": "Default Group", "col_3": "System defaults"},
                    {"col_0": "", "col_1": "", "col_2": "Guest Users", "col_3": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, results)

    assert not reply.lower().startswith("security groups (")
    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_read_security_groups_handles_shifted_columns_and_dedupes():
    nav = PMWebNavigator.__new__(PMWebNavigator)
    nav.read_kendo_grid = lambda max_rows=200: [  # type: ignore[method-assign]
        {"col_0": "", "col_1": "", "col_2": "Default Group", "col_3": "System defaults"},
        {"col_0": "", "col_1": "", "col_2": "Guest Users", "col_3": "Guest profile"},
        {"col_0": "", "col_1": "", "col_2": "Guest Users", "col_3": "Guest profile"},
    ]

    rows = nav.read_security_groups()

    assert rows == [
        {"Group ID": "Default Group", "Description": "System defaults"},
        {"Group ID": "Guest Users", "Description": "Guest profile"},
    ]
