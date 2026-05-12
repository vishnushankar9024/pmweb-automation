"""Tests for PMWeb agent and client services."""

from selenium.webdriver.common.by import By

from app.agent.browser_agent import HybridAgent
from app.services.pmweb_browser import (
    extract_security_group_names,
    format_security_group_list,
)
from app.services.pmweb_client import PMWebClient


SECURITY_GROUP_PAGE_TEXT = """
Security
Manage your group and user security settings
Groups
New Group
Group*
Description*
Default Group
Can Copy Project
Admin
Project Managers
Project Managers
123
Save
"""


class FakeBody:
    text = SECURITY_GROUP_PAGE_TEXT


class FakeDriver:
    def find_element(self, by, value):
        assert by == By.TAG_NAME
        assert value == "body"
        return FakeBody()


class TestSecurityGroupFormatting:
    def test_extract_security_group_names_filters_ui_labels(self):
        groups = extract_security_group_names(SECURITY_GROUP_PAGE_TEXT)

        assert groups == ["Admin", "Project Managers"]

    def test_format_security_group_list_uses_bullets(self):
        formatted = format_security_group_list(["Admin", "Project Managers"])

        assert formatted == "Security groups (2):\n- Admin\n- Project Managers"

    def test_read_groups_action_returns_clean_text_not_json(self):
        agent = HybridAgent()
        agent._driver = FakeDriver()

        result = agent._execute_step({"action": "read_groups"})

        assert result == "Security groups (2):\n- Admin\n- Project Managers"
        assert '"groups"' not in result
        assert not result.strip().startswith("{")


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
        result = self.client.create_adaptive_form(
            form_name="Daily Report",
            fields=[
                {"label": "Weather", "type": "dropdown"},
                {"label": "Workers", "type": "number"},
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
