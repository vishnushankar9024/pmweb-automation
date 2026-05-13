"""Regression tests for the GPT/Selenium browser agent."""

import pytest

from app.agent.browser_agent import PLANNER_PROMPT, HybridAgent, UnsafePlanError


@pytest.mark.parametrize(
    "task",
    [
        "create a security group",
        "Can you create a security group?",
        "please set up new security groups",
        "create a security group for me",
        "create a security group for the procurement team",
        "create a security group named Safety Team",
        "create a security group with group name and description",
        "create a security group called Safety Team with description",
        "create a security group\n\n--- Attached file ---\nPlease create a security group",
    ],
)
def test_bare_security_group_create_request_asks_for_details(monkeypatch, task):
    agent = HybridAgent()

    def fail_login():
        raise AssertionError("bare requests should not open PMWeb")

    monkeypatch.setattr(agent, "login", fail_login)

    result = agent.run_task_sync(task)

    assert result["actions"] == []
    assert "what should the security group be called" in result["reply"].lower()
    assert "description" in result["reply"].lower()


@pytest.mark.parametrize(
    "task",
    [
        "create a security group named Safety Team with description Safety access",
        "create a security group called Safety Team for the procurement team",
        "create a security group\n\n--- Attached file ---\nName: Safety Team\nDescription: Safety access",
    ],
)
def test_security_group_create_request_with_details_can_be_planned(monkeypatch, task):
    agent = HybridAgent()

    def fake_login():
        return {"status": "error", "message": "planner reached"}

    class FakeCompletions:
        def create(self, **kwargs):
            class Choice:
                class Message:
                    content = "[]"

                message = Message()

            class Response:
                choices = [Choice()]

            return Response()

    class FakeChat:
        completions = FakeCompletions()

    class FakeClient:
        chat = FakeChat()

    monkeypatch.setattr(agent, "_client", FakeClient())
    monkeypatch.setattr(agent, "login", fake_login)

    result = agent.run_task_sync(task)

    assert result["reply"] == "Cannot connect: planner reached"


def test_execute_ask_user_returns_message():
    agent = HybridAgent()

    result = agent._execute_step(
        {
            "action": "ask_user",
            "message": "Please provide the group name and description.",
        }
    )

    assert result == "Please provide the group name and description."


@pytest.mark.parametrize("action", ["click_button", "click_by_text"])
def test_execute_blocks_unsafe_new_group_click(action):
    agent = HybridAgent()

    with pytest.raises(UnsafePlanError) as exc_info:
        agent._execute_step({"action": action, "text": "New Group"})

    assert "what should the security group be called" in str(exc_info.value).lower()


def test_planner_prompt_documents_security_group_clarification():
    assert '"action": "ask_user"' in PLANNER_PROMPT
    assert "Do not create or save a Security Group unless" in PLANNER_PROMPT
    assert 'Never click "New Group"' in PLANNER_PROMPT


def test_planned_security_group_creation_is_blocked_without_details():
    agent = HybridAgent()
    plan = [
        {"action": "navigate", "url": "/Security.aspx"},
        {"action": "switch_to_iframe", "id": "ctl00_CPH1_ngFrame"},
        {"action": "click_tab", "text": "Groups"},
        {"action": "click_button", "text": "New Group"},
        {"action": "click_save"},
    ]

    message = agent._clarification_from_plan(plan, "Can you create a security group?")

    assert message is not None
    assert "what should the security group be called" in message.lower()


def test_hallucinated_security_group_creation_is_blocked_for_unrelated_prompt():
    agent = HybridAgent()
    plan = [
        {"action": "navigate", "url": "/Security.aspx"},
        {"action": "switch_to_iframe", "id": "ctl00_CPH1_ngFrame"},
        {"action": "click_tab", "text": "Groups"},
        {"action": "click_button", "text": "New Group"},
        {"action": "click_save"},
    ]

    message = agent._clarification_from_plan(plan, "hi")

    assert message is not None
    assert "what should the security group be called" in message.lower()
