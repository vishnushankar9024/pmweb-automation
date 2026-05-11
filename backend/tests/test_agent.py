"""Tests for agent and PMWeb client."""


from app.services.pmweb_client import PMWebClient


class TestPMWebClient:
    def setup_method(self):
        self.client = PMWebClient()

    def test_create_security_group(self):
        result = self.client.create_security_group(
            group_id="CONTRACTORS", description="External contractors"
        )
        assert result["status"] == "created"
        assert result["group"]["group_id"] == "CONTRACTORS"

    def test_create_user(self):
        result = self.client.create_user(
            username="asmith",
            email="asmith@example.com",
            first_name="Alice",
            last_name="Smith",
            groups=["PM_TEAM"],
        )
        assert result["status"] == "created"
        assert result["user"]["username"] == "asmith"

    def test_set_password_policy(self):
        result = self.client.set_password_policy(min_length=12, require_special_chars=True)
        assert result["status"] == "updated"
        assert result["policy"]["min_length"] == 12

    def test_set_user_access(self):
        result = self.client.set_user_access(
            username="asmith",
            project_access=["Project Alpha", "Project Beta"],
        )
        assert result["status"] == "updated"
        assert len(result["access"]["project_access"]) == 2

    def test_create_workflow_valid(self):
        result = self.client.create_workflow(
            workflow_name="Invoice Approval",
            record_type="Invoice",
            steps=[
                {"step_name": "Submit", "step_type": "submit", "order": 1},
                {
                    "step_name": "Manager Approval",
                    "step_type": "approval",
                    "order": 2,
                    "assigned_roles": ["PM_TEAM"],
                },
                {"step_name": "Complete", "step_type": "finish", "order": 3},
            ],
        )
        assert result["status"] == "created"
        assert result["workflow"]["workflow_name"] == "Invoice Approval"

    def test_create_workflow_invalid(self):
        result = self.client.create_workflow(
            workflow_name="Bad Workflow",
            record_type="RFI",
            steps=[
                {"step_name": "Review", "step_type": "approval", "order": 1},
            ],
        )
        assert result["status"] == "validation_error"
        assert len(result["issues"]) > 0

    def test_create_form(self):
        result = self.client.create_form(
            form_name="Daily Report",
            description="Daily site report",
            fields=[
                {
                    "field_name": "weather",
                    "label": "Weather Conditions",
                    "field_type": "dropdown",
                    "dropdown_options": ["Sunny", "Cloudy", "Rainy"],
                    "display_order": 1,
                },
                {
                    "field_name": "workers_count",
                    "label": "Number of Workers",
                    "field_type": "number",
                    "is_required": True,
                    "display_order": 2,
                },
            ],
        )
        assert result["status"] == "created"
        assert result["form"]["form_name"] == "Daily Report"

    def test_get_summary(self):
        self.client.create_security_group(group_id="TEAM_A", description="Team A")
        self.client.create_user(
            username="bob", email="bob@example.com", first_name="Bob", last_name="B"
        )
        summary = self.client.get_summary()
        assert summary["groups"] == 1
        assert summary["users"] == 1

    def test_execute_unknown_action(self):
        result = self.client.execute_action("nonexistent", {})
        assert result["status"] == "error"
