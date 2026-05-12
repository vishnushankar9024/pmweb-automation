"""Tests for the browser-backed PMWeb agent."""

import pytest

from app.agent.browser_agent import HybridAgent


def test_greeting_returns_whats_up_without_login(monkeypatch: pytest.MonkeyPatch):
    agent = HybridAgent()

    def fail_login():
        raise AssertionError("greeting should not open PMWeb")

    monkeypatch.setattr(agent, "login", fail_login)

    result = agent.run_task_sync("hi")

    assert result["reply"].startswith("whats up")
    assert result["actions"] == []


def test_direct_reply_step_returns_message():
    agent = HybridAgent()

    result = agent._execute_step(
        {"action": "direct_reply", "message": "whats up! How can I help with PMWeb?"}
    )

    assert result == {"message": "whats up! How can I help with PMWeb?"}
