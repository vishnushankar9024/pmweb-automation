"""Regression tests for the GPT/Selenium browser agent."""

from app.agent.browser_agent import PLANNER_PROMPT, HybridAgent


def test_bare_security_group_create_request_asks_for_details(monkeypatch):
    agent = HybridAgent()

    def fail_login():
        raise AssertionError("bare requests should not open PMWeb")

    monkeypatch.setattr(agent, "login", fail_login)

    result = agent.run_task_sync("create a security group")

    assert result["actions"] == []
    assert "what should the security group be called" in result["reply"].lower()
    assert "description" in result["reply"].lower()


def test_execute_ask_user_returns_message():
    agent = HybridAgent()

    result = agent._execute_step(
        {
            "action": "ask_user",
            "message": "Please provide the group name and description.",
        }
    )

    assert result == "Please provide the group name and description."


def test_planner_prompt_documents_security_group_clarification():
    assert '"action": "ask_user"' in PLANNER_PROMPT
    assert "Do not create or save a Security Group unless" in PLANNER_PROMPT
