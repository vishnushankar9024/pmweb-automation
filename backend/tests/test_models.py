"""Tests for PMWeb domain models."""


from app.models.form import FieldType, FormDefinition, FormField, FormPermission
from app.models.security import (
    AccessLevel,
    ModuleAccess,
    PasswordPolicy,
    SecurityGroup,
    UserAccess,
    UserAccount,
)
from app.models.workflow import (
    StepType,
    WorkflowDefinition,
    WorkflowStep,
)


class TestSecurityModels:
    def test_security_group_creation(self):
        group = SecurityGroup(group_id="PM_TEAM", description="Project Managers")
        assert group.group_id == "PM_TEAM"
        assert group.is_active is True

    def test_user_account_creation(self):
        user = UserAccount(
            username="jdoe",
            email="jdoe@example.com",
            first_name="John",
            last_name="Doe",
            groups=["PM_TEAM"],
        )
        assert user.username == "jdoe"
        assert "PM_TEAM" in user.groups

    def test_password_policy_defaults(self):
        policy = PasswordPolicy()
        assert policy.min_length == 8
        assert policy.require_uppercase is True
        assert policy.expiry_days == 90

    def test_password_policy_custom(self):
        policy = PasswordPolicy(min_length=12, require_special_chars=True, expiry_days=60)
        assert policy.min_length == 12
        assert policy.require_special_chars is True
        assert policy.expiry_days == 60

    def test_user_access(self):
        access = UserAccess(
            username="jdoe",
            project_access=["Project Alpha"],
            module_access=[
                ModuleAccess(module_name="Cost Management", access_level=AccessLevel.EDIT),
                ModuleAccess(module_name="Documents", access_level=AccessLevel.VIEW_ONLY),
            ],
        )
        assert len(access.module_access) == 2
        assert access.module_access[0].access_level == AccessLevel.EDIT


class TestWorkflowModels:
    def test_valid_workflow(self):
        wf = WorkflowDefinition(
            workflow_name="Change Order Approval",
            record_type="Change Order",
            steps=[
                WorkflowStep(step_name="Submit", step_type=StepType.SUBMIT, order=1),
                WorkflowStep(
                    step_name="PM Review",
                    step_type=StepType.APPROVAL,
                    order=2,
                    assigned_roles=["PM_TEAM"],
                    review_days=5,
                ),
                WorkflowStep(step_name="Complete", step_type=StepType.FINISH, order=3),
            ],
        )
        assert wf.validate_structure() == []

    def test_workflow_missing_submit(self):
        wf = WorkflowDefinition(
            workflow_name="Bad Workflow",
            record_type="RFI",
            steps=[
                WorkflowStep(step_name="Review", step_type=StepType.APPROVAL, order=1),
                WorkflowStep(step_name="Done", step_type=StepType.FINISH, order=2),
            ],
        )
        issues = wf.validate_structure()
        assert any("Submit" in i for i in issues)

    def test_workflow_missing_finish(self):
        wf = WorkflowDefinition(
            workflow_name="Bad Workflow",
            record_type="RFI",
            steps=[
                WorkflowStep(step_name="Submit", step_type=StepType.SUBMIT, order=1),
                WorkflowStep(step_name="Review", step_type=StepType.APPROVAL, order=2),
            ],
        )
        issues = wf.validate_structure()
        assert any("Finish" in i for i in issues)

    def test_empty_workflow(self):
        wf = WorkflowDefinition(workflow_name="Empty", record_type="RFI")
        issues = wf.validate_structure()
        assert len(issues) == 1


class TestFormModels:
    def test_form_creation(self):
        form = FormDefinition(
            form_name="Safety Inspection",
            description="Daily safety checklist",
            fields=[
                FormField(
                    field_name="inspector",
                    label="Inspector Name",
                    field_type=FieldType.TEXT,
                    is_required=True,
                    display_order=1,
                ),
                FormField(
                    field_name="date",
                    label="Inspection Date",
                    field_type=FieldType.DATE,
                    is_required=True,
                    display_order=2,
                ),
                FormField(
                    field_name="status",
                    label="Status",
                    field_type=FieldType.DROPDOWN,
                    dropdown_options=["Pass", "Fail", "N/A"],
                    display_order=3,
                ),
            ],
        )
        assert form.form_name == "Safety Inspection"
        assert len(form.fields) == 3
        assert form.fields[2].dropdown_options == ["Pass", "Fail", "N/A"]

    def test_form_permissions(self):
        perm = FormPermission(group_id="PM_TEAM", can_view=True, can_edit=True)
        assert perm.can_view is True
        assert perm.can_delete is False
