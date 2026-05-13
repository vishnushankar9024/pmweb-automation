from app.agent.browser_agent import HybridAgent


def test_create_security_group_action_card_uses_structured_result():
    agent = HybridAgent()
    steps = [
        {
            "action": "create_security_group",
            "group_name": "CONTRACTORS",
            "description": "External contractors",
            "options": ["Can Send Notifications"],
        }
    ]
    results = [
        {
            "step": 1,
            "action": "create_security_group",
            "result": {
                "status": "created",
                "group_name": "CONTRACTORS",
                "description": "External contractors",
                "options_enabled": ["Can Send Notifications"],
                "message": "Security group 'CONTRACTORS' created in PMWeb",
            },
        }
    ]

    cards = agent._format_executed_actions(steps, results)

    assert cards == [
        {
            "tool": "create_security_group",
            "args": {
                "group_name": "CONTRACTORS",
                "description": "External contractors",
                "options": ["Can Send Notifications"],
            },
            "result": results[0]["result"],
        }
    ]


def test_granular_security_group_steps_get_action_card():
    agent = HybridAgent()
    steps = [
        {"action": "navigate", "url": "/Security.aspx"},
        {"action": "switch_to_iframe", "id": "ctl00_CPH1_ngFrame"},
        {"action": "click_tab", "text": "Groups"},
        {"action": "click_button", "text": "New Group"},
        {"action": "fill_textbox", "index": 0, "value": "QA_TEAM"},
        {"action": "fill_textbox", "index": 1, "value": "Quality team"},
        {"action": "check_option", "label": "Can Send Notifications"},
        {
            "action": "click_module_permission",
            "module": "Assets",
            "permission": "Full Control",
        },
        {"action": "click_save"},
    ]
    results = [
        {"step": index + 1, "action": step["action"], "result": "ok"}
        for index, step in enumerate(steps)
    ]

    cards = agent._format_executed_actions(steps, results)

    assert cards[0]["tool"] == "create_security_group"
    assert cards[0]["args"] == {
        "group_name": "QA_TEAM",
        "description": "Quality team",
        "options": ["Can Send Notifications"],
        "module_permissions": [
            {"module": "Assets", "permission": "Full Control"}
        ],
    }
    assert cards[0]["result"]["status"] == "created"


def test_granular_security_group_card_reports_step_failure():
    agent = HybridAgent()
    steps = [
        {"action": "click_button", "text": "New Group"},
        {"action": "fill_textbox", "index": 0, "value": "QA_TEAM"},
    ]
    results = [
        {
            "step": 1,
            "action": "click_button",
            "result": "not found: New Group",
        }
    ]

    cards = agent._format_executed_actions(steps, results)

    assert cards[0]["result"]["status"] == "error"
    assert cards[0]["result"]["message"] == "not found: New Group"
