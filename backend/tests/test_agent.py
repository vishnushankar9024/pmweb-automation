"""Tests for PMWeb client service."""

from app.agent.browser_agent import CLARIFICATION_MESSAGE, HybridAgent
from app.services.pmweb_client import PMWebClient


class _FakeChoice:
    def __init__(self, content):
        self.message = type("Message", (), {"content": content})()


class _FakeResponse:
    def __init__(self, content):
        self.choices = [_FakeChoice(content)]


class _FakeClient:
    def __init__(self, content):
        self.content = content
        self.chat = self
        self.completions = self

    def create(self, **_kwargs):
        return _FakeResponse(self.content)


class TestHybridAgent:
    def test_greeting_returns_clarification_without_login(self, monkeypatch):
        agent = HybridAgent()

        def fail_login():
            raise AssertionError("greetings should not log in to PMWeb")

        monkeypatch.setattr(agent, "login", fail_login)
        result = agent.run_task_sync("hi")

        assert result["reply"] == CLARIFICATION_MESSAGE
        assert result["actions"] == [
            {"step": 1, "action": "ask_user", "result": CLARIFICATION_MESSAGE}
        ]

    def test_planner_clarification_skips_login(self, monkeypatch):
        message = "What security group name and permissions should I use?"
        agent = HybridAgent()
        agent._client = _FakeClient(
            f'[{{"action": "ask_user", "message": "{message}"}}]'
        )

        def fail_login():
            raise AssertionError("clarification-only plans should not log in to PMWeb")

        monkeypatch.setattr(agent, "login", fail_login)
        result = agent.run_task_sync("create a security group")

        assert result["reply"] == message
        assert result["actions"] == [{"step": 1, "action": "ask_user", "result": message}]

    def test_execute_ask_user_step(self):
        agent = HybridAgent()
        assert (
            agent._execute_step({"action": "ask_user", "message": "Need more details"})
            == "Need more details"
        )


class TestPMWebClient:
    def setup_method(self):
        self.client = PMWebClient()

    def test_create_security_group(self):
        result = self.client.create_security_group(
            group_name="CONTRACTORS",
            description="External contractors",
        )
        assert result["status"] == "created"

    def test_create_security_group_with_options(self):
        result = self.client.create_security_group(
            group_name="ADMINS",
            description="Administrators",
            options=["Can Copy Project", "Can Send Notifications"],
        )
        assert result["status"] == "created"

    def test_create_user(self):
        result = self.client.create_user(
            user_id="asmith",
            first_name="Alice",
            last_name="Smith",
            email="asmith@example.com",
            group_name="Admin",
        )
        assert result["status"] == "created"

    def test_create_user_guest(self):
        result = self.client.create_user(
            user_id="guest1",
            first_name="Guest",
            group_name="Contractors",
            license_type="Guest",
            named_license="Concurrent",
        )
        assert result["status"] == "created"

    def test_create_workflow_valid(self):
        result = self.client.create_workflow(
            bpm_id="INV_APPROVAL",
            associate_with=["Invoice"],
            steps=[
                {"step_name": "Submit", "step_type": "submit", "order": 1},
                {
                    "step_name": "Manager Approval",
                    "step_type": "step",
                    "order": 2,
                    "assigned_roles": ["PM_TEAM"],
                },
                {"step_name": "Complete", "step_type": "finish", "order": 3},
            ],
        )
        assert result["status"] == "created"

    def test_create_workflow_invalid(self):
        result = self.client.create_workflow(
            bpm_id="BAD",
            steps=[
                {"step_name": "Review", "step_type": "step", "order": 1},
            ],
        )
        assert result["status"] == "validation_error"

    def test_create_form(self):
        result = self.client.create_form(
            form_id="DAILY_RPT",
            form_name="Daily Report",
            custom_fields=[
                {"label": "Weather", "data_type": "Dropdown"},
                {"label": "Workers", "data_type": "Number"},
            ],
        )
        assert result["status"] == "created"

    def test_get_summary(self):
        self.client.create_security_group(
            group_name="TEAM_A", description="Team A"
        )
        summary = self.client.get_summary()
        assert summary["groups"] == 1

    def test_execute_unknown_action(self):
        result = self.client.execute_action("nonexistent", {})
        assert result["status"] == "error"
