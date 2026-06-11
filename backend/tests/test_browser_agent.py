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
    def __init__(self, rows: list[dict[str, str]], total_rows: int | None = None) -> None:
        self._rows = rows
        self._total_rows = total_rows
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

    def get_kendo_total_rows(self) -> int | None:
        return self._total_rows


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
    assert result["actions"] == []


def test_run_task_sync_security_group_list_prefers_complete_flow_rows_over_partial_direct_read():
    expected_rows = [
        {"Group ID": f"Group {idx}", "Description": f"Description {idx}"}
        for idx in range(1, 29)
    ]

    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 3,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": 28,
                            "total_rows": 28,
                            "data": expected_rows,
                        },
                    }
                ]

            return Result()

    class FakeNav:
        def __init__(self):
            self.read_calls = 0

        def read_security_groups(self, max_rows=1000):
            self.read_calls += 1
            return expected_rows[:20][:max_rows]

        def get_kendo_total_rows(self):
            return 28

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    fake_nav = FakeNav()
    agent._nav = fake_nav  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = (  # type: ignore[method-assign]
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("LLM parser should not run"))
    )

    result = agent.run_task_sync("List all security groups")

    assert fake_nav.read_calls == 0
    reply_lines = result["reply"].splitlines()
    assert len(reply_lines) == 28
    assert reply_lines[0] == "1. Group 1 — Description 1"
    assert reply_lines[-1] == "28. Group 28 — Description 28"
    assert result["actions"] == []


def test_run_task_sync_security_group_list_prefers_direct_read_when_flow_has_no_totals():
    flow_rows = [
        {"Group ID": "Default Group", "Description": "System defaults"},
        {"Group ID": "Guest Users", "Description": "Guest profile"},
    ]
    direct_rows = [
        {"Group ID": "Default Group", "Description": "System defaults"},
        {"Group ID": "Guest Users", "Description": "Guest profile"},
        {"Group ID": "PMWEB Admin", "Description": "Admin users"},
        {"Group ID": "Power Users", "Description": "Power user access"},
    ]

    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 3,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "data": flow_rows,
                        },
                    }
                ]

            return Result()

    class FakeNav:
        def __init__(self):
            self.read_calls = 0

        def read_security_groups(self, max_rows=1000):
            self.read_calls += 1
            return direct_rows[:max_rows]

        def get_kendo_total_rows(self):
            return None

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    fake_nav = FakeNav()
    agent._nav = fake_nav  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = (  # type: ignore[method-assign]
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("LLM parser should not run"))
    )

    result = agent.run_task_sync("List all security groups")

    assert fake_nav.read_calls >= 1
    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
        "3. PMWEB Admin — Admin users",
        "4. Power Users — Power user access",
    ]
    assert result["actions"] == []


def test_run_task_sync_hides_actions_for_security_group_read_intent_without_list_phrase():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {"step": 1, "action": "navigate", "result": "navigated"},
                    {"step": 2, "action": "switch_to_iframe", "result": "switched"},
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
                    },
                ]

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "read",
        "record_type": "Security Groups",
        "fields": {},
    }

    result = agent.run_task_sync("Show me all of them")

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]
    assert result["actions"] == []


def test_run_task_sync_keeps_actions_for_security_group_create_intent():
    class FakeFlows:
        def create_security_group(self, _rt, _fields, _options, _permissions):
            class Result:
                steps = [
                    {"step": 1, "action": "navigate", "result": "navigated"},
                    {"step": 2, "action": "click_new_group", "result": "clicked"},
                    {"step": 3, "action": "save", "result": "saved"},
                ]

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "create",
        "record_type": "Security Groups",
        "fields": {"Group ID": "NEW_GROUP", "Description": "Created by test"},
        "options": [],
        "permissions": {},
    }
    agent._build_reply = lambda *_args, **_kwargs: "Created security group."  # type: ignore[method-assign]

    result = agent.run_task_sync("Create security group NEW_GROUP")

    assert result["reply"] == "Created security group."
    assert result["actions"] == [
        {"step": 1, "action": "navigate", "result": "navigated"},
        {"step": 2, "action": "click_new_group", "result": "clicked"},
        {"step": 3, "action": "save", "result": "saved"},
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
    assert result["actions"] == []


def test_run_task_sync_security_group_read_hides_actions_when_fast_path_is_skipped():
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
    agent._is_security_group_list_task = lambda _task: False  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "read",
        "record_type": "Security Groups",
        "fields": {},
    }

    result = agent.run_task_sync("List all security groups")

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]
    assert result["actions"] == []


def test_answer_only_security_group_reply_strips_non_row_lines():
    reply = (
        "Security groups (28):\n"
        "1. Default Group — System defaults\n"
        "2. Guest Users — Guest profile\n"
        "Done."
    )

    assert HybridAgent._answer_only_security_group_reply(reply) == (
        "1. Default Group — System defaults\n"
        "2. Guest Users — Guest profile"
    )


def test_security_group_list_detection_ignores_add_substring_inside_words():
    assert HybridAgent._is_security_group_list_task(
        "List all security groups with additional details"
    )


def test_security_group_list_detection_accepts_hyphenated_variant():
    assert HybridAgent._is_security_group_list_task("List all security-groups")


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


def test_run_task_sync_security_group_list_retries_when_only_sample_rows_are_present():
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


def test_run_task_sync_replaces_procedural_security_summary_with_group_rows():
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
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "read",
        "record_type": "Security Groups",
        "fields": {},
    }
    agent._build_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "On PMWeb, the task of listing all security groups was completed. "
        "The process involved navigating to the Security page and reading the grid."
    )

    result = agent.run_task_sync("Please provide security groups report")

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_run_task_sync_replaces_procedural_security_summary_variant_with_group_rows():
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
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "read",
        "record_type": "Security Groups",
        "fields": {},
    }
    agent._build_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "On PMWeb, a task was performed to list all security groups. "
        "The process involved navigating to the Security page, switched to the iframe, "
        "and found 28 rows including Default Group and Guest Users."
    )

    result = agent.run_task_sync("Please list all security groups")

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_run_task_sync_replaces_feedback_style_procedural_summary_with_group_rows():
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
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    # Force parser path to ensure narrative replacement runs even when the list
    # fast-path is bypassed.
    agent._is_security_group_list_task = lambda _task: False  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "read",
        "record_type": "Security Groups",
        "fields": {},
    }
    agent._build_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "On PMWeb, the task of listing all security groups was completed. "
        "The process involved navigating to the Security page, switching to an appropriate iframe, "
        "and then reading the security groups grid. A total of 28 rows were identified, "
        "with a sample of groups including Default Group and Guest Users, among others."
    )

    result = agent.run_task_sync("List all security groups")

    assert result["reply"].splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]
    assert result["actions"] == []


def test_run_task_sync_security_group_read_rejects_non_numbered_prose_reply():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [{"step": 4, "action": "read_grid", "result": {}}]

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._is_security_group_list_task = lambda _task: False  # type: ignore[method-assign]
    agent._parse_intent = lambda *_args, **_kwargs: {  # type: ignore[method-assign]
        "intent": "read",
        "record_type": "Security Groups",
        "fields": {},
    }
    agent._build_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "Security groups include Default Group and Guest Users."
    )
    agent._deterministic_security_group_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "Security groups include Default Group and Guest Users."
    )

    result = agent.run_task_sync("List all security groups")

    assert result["reply"] == "I couldn't extract the security group rows from PMWeb. Please try again."
    assert result["actions"] == []


def test_run_task_sync_security_group_fast_path_rejects_non_numbered_reply():
    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = []

            return Result()

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._format_read_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "Default Group, Guest Users"
    )
    agent._resolve_security_group_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "Default Group, Guest Users"
    )
    agent._direct_security_group_read_reply = lambda *_args, **_kwargs: None  # type: ignore[method-assign]

    result = agent.run_task_sync("List all security groups")

    assert result["reply"] == "I couldn't extract the security group rows from PMWeb. Please try again."
    assert result["actions"] == []


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


def test_read_records_captures_pager_total_rows_when_available():
    rows = [{"Group ID": f"Group {i}", "Description": f"Desc {i}"} for i in range(1, 6)]
    nav = FakeReadNav(rows, total_rows=28)
    flow = PMWebFlows(nav)  # type: ignore[arg-type]
    rt = get_record_type("Security Groups")

    result = flow.read_records(rt, "Security Groups")

    read_step = next(step for step in result.steps if step["action"] == "read_grid")
    assert read_step["result"]["rows"] == 5
    assert read_step["result"]["row_count"] == 5
    assert read_step["result"]["total_rows"] == 28


def test_dispatch_read_normalizes_security_group_record_type_variants():
    captured: dict[str, object] = {}

    class FakeFlows:
        def read_records(self, rt, record_type_name):
            captured["record_type_name"] = record_type_name
            captured["rt_name"] = rt.name if rt else None

            class Result:
                steps = []

            return Result()

    agent = HybridAgent()
    agent._flows = FakeFlows()  # type: ignore[assignment]

    agent._dispatch_to_flow(
        {
            "intent": "read",
            "record_type": "Security-Group",
            "fields": {},
        }
    )

    assert captured == {
        "record_type_name": "Security Groups",
        "rt_name": "Security Groups",
    }


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


def test_build_reply_lists_security_groups_for_hyphenated_task_phrase():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security-Group"}
    results = [
        {
            "step": 5,
            "action": "read_grid",
            "result": {
                "rows": 2,
                "data": [
                    {"col_0": "Default Group", "col_1": "System defaults"},
                    {"col_0": "Guest Users", "col_1": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security-groups", parsed, results)

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


def test_build_reply_returns_error_when_only_partial_security_group_rows_exist():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    sampled_results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 2,
                "total_rows": 28,
                "data": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("Please provide security groups report", parsed, sampled_results)

    assert reply == "I couldn't extract the security group rows from PMWeb. Please try again."


def test_build_reply_prefers_full_non_sample_rows_when_payload_has_sample_data():
    agent = HybridAgent()
    parsed = {"intent": "read", "record_type": "Security Groups"}
    mixed_results = [
        {
            "step": 4,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 2,
                "total_rows": 2,
                "data": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                ],
                "sample_rows": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                ],
                "groups": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._build_reply("List all security groups", parsed, mixed_results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_reported_row_count_uses_largest_available_counter():
    assert HybridAgent._reported_row_count({"rows": 5, "total_rows": 28, "row_count": "5"}) == 28


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


def test_run_task_sync_security_group_list_uses_reported_total_for_direct_read_cap():
    reported_total = 1001

    class FakeFlows:
        def read_records(self, _rt, _record_type_name):
            class Result:
                steps = [
                    {
                        "step": 3,
                        "action": "read_grid",
                        "result": {
                            "record_type": "Security Groups",
                            "rows": reported_total,
                            "sample_rows": [
                                {"Group ID": "Default Group", "Description": "System defaults"},
                            ],
                        },
                    }
                ]

            return Result()

    class FakeNav:
        def __init__(self):
            self.caps: list[int] = []

        def read_security_groups(self, max_rows=1000):
            self.caps.append(max_rows)
            return [
                {"Group ID": f"Group {idx}", "Description": f"Description {idx}"}
                for idx in range(1, max_rows + 1)
            ]

    agent = HybridAgent()
    agent._logged_in = True
    agent._flows = FakeFlows()  # type: ignore[assignment]
    fake_nav = FakeNav()
    agent._nav = fake_nav  # type: ignore[assignment]
    agent._store_learning = lambda *_args, **_kwargs: None  # type: ignore[method-assign]
    agent._parse_intent = (  # type: ignore[method-assign]
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("LLM parser should not run"))
    )

    result = agent.run_task_sync("List all security groups")

    assert fake_nav.caps
    assert all(cap == reported_total for cap in fake_nav.caps)
    assert result["reply"].splitlines()[0] == "1. Group 1 — Description 1"
    assert result["reply"].splitlines()[-1] == "1001. Group 1001 — Description 1001"
    assert result["actions"] == []


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


def test_summarize_returns_deterministic_security_group_rows_instead_of_narration():
    agent = HybridAgent()
    results = [
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

    reply = agent._summarize("List all security groups", results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_resolve_security_group_reply_replaces_narrative_reply_with_rows():
    class FakeNav:
        def read_security_groups(self, max_rows=1000):
            return [
                {"Group ID": "Default Group", "Description": "System defaults"},
                {"Group ID": "Guest Users", "Description": "Guest profile"},
            ][:max_rows]

    agent = HybridAgent()
    agent._nav = FakeNav()  # type: ignore[assignment]
    results = [
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

    reply = agent._resolve_security_group_reply(
        "List all security groups",
        results,
        "On PMWeb, the task of listing all security groups was completed.",
    )

    assert reply is not None
    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_resolve_security_group_reply_rejects_prose_without_numbered_rows():
    agent = HybridAgent()
    reply = agent._resolve_security_group_reply(
        "List all security groups",
        [],
        "Security groups include Default Group, Guest Users, and PMWEB Admin.",
    )

    assert reply is None


def test_resolve_security_group_reply_strips_procedural_wrapper_when_rows_present():
    agent = HybridAgent()
    results = [
        {
            "step": 3,
            "action": "read_grid",
            "result": {
                "record_type": "Security Groups",
                "rows": 2,
                "row_count": 2,
                "total_rows": 2,
                "data": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]
    wrapped_reply = (
        "On PMWeb, the task of listing all security groups was completed.\n"
        "The process involved navigating to Security and switching to an iframe.\n"
        "1. Default Group — System defaults\n"
        "2. Guest Users — Guest profile"
    )

    reply = agent._resolve_security_group_reply(
        "List all security groups",
        results,
        wrapped_reply,
    )

    assert reply == "1. Default Group — System defaults\n2. Guest Users — Guest profile"


def test_summarize_uses_deterministic_rows_when_results_indicate_security_groups():
    agent = HybridAgent()
    results = [
        {
            "step": 3,
            "action": "read_grid",
            "record_type": "Security Groups",
            "result": {
                "data": [
                    {"Group ID": "Default Group", "Description": "System defaults"},
                    {"Group ID": "Guest Users", "Description": "Guest profile"},
                ],
            },
        }
    ]

    reply = agent._summarize("What did you do?", results)

    assert reply.splitlines() == [
        "1. Default Group — System defaults",
        "2. Guest Users — Guest profile",
    ]


def test_summarize_rejects_security_group_prose_fallback():
    agent = HybridAgent()
    agent._deterministic_security_group_reply = lambda *_args, **_kwargs: (  # type: ignore[method-assign]
        "Security groups include Default Group and Guest Users."
    )

    reply = agent._summarize("List all security groups", [])

    assert reply == "I couldn't extract the security group rows from PMWeb. Please try again."


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
