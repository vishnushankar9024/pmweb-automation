"""Tests for the HybridAgent planner/executor guardrails."""

from app.agent.browser_agent import HybridAgent, PLANNER_PROMPT


def test_generic_security_group_request_asks_for_required_fields():
    agent = HybridAgent()

    result = agent.run_task_sync("create a security group")

    assert "group name" in result["reply"].lower()
    assert "description" in result["reply"].lower()
    assert result["actions"] == [
        {
            "step": 1,
            "action": "ask_user",
            "result": result["reply"],
        }
    ]


def test_security_group_request_with_required_fields_can_be_planned():
    agent = HybridAgent()

    clarification = agent._clarify_missing_required_inputs(
        "create a security group named PM_TEAM with description Project Managers"
    )

    assert clarification is None


def test_planner_prompt_documents_ask_user_action():
    assert '{"action": "ask_user"' in PLANNER_PROMPT
    assert "Do NOT invent" in PLANNER_PROMPT


def test_execute_step_ask_user_returns_message():
    agent = HybridAgent()

    result = agent._execute_step(
        {"action": "ask_user", "message": "Which group name should I use?"}
    )

    assert result == "Which group name should I use?"
