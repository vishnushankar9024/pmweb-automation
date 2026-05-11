"""Tests for PMWeb domain models."""

from app.models.form import ClassicForm, CustomField, FieldDataType, FormPermission
from app.models.security import (
    GroupOption,
    LicenseType,
    NamedLicense,
    PasswordPolicy,
    SecurityGroup,
    UserAccount,
)
from app.models.workflow import BusinessProcess, StepType, WorkflowStep


class TestSecurityModels:
    def test_security_group_creation(self):
        group = SecurityGroup(
            group_name="PM_TEAM", description="Project Managers"
        )
        assert group.group_name == "PM_TEAM"
        assert group.options == []

    def test_security_group_with_options(self):
        group = SecurityGroup(
            group_name="ADMINS",
            description="Administrators",
            options=[
                GroupOption.CAN_COPY_PROJECT,
                GroupOption.CAN_SEND_NOTIFICATIONS,
                GroupOption.CUSTOM_FORM_ADMIN,
            ],
        )
        assert len(group.options) == 3

    def test_user_account_creation(self):
        user = UserAccount(
            user_id="jdoe",
            first_name="John",
            last_name="Doe",
            email="jdoe@example.com",
            group_name="PM_TEAM",
        )
        assert user.user_id == "jdoe"
        assert user.license_type == LicenseType.FULL
        assert user.named_license == NamedLicense.NAMED
        assert user.group_name == "PM_TEAM"

    def test_user_guest_license(self):
        user = UserAccount(
            user_id="contractor1",
            first_name="Bob",
            group_name="Contractors",
            license_type=LicenseType.GUEST,
            named_license=NamedLicense.CONCURRENT,
        )
        assert user.license_type == LicenseType.GUEST
        assert user.named_license == NamedLicense.CONCURRENT

    def test_password_policy_defaults(self):
        policy = PasswordPolicy()
        assert policy.min_length == 8
        assert policy.require_uppercase is True
        assert policy.expiry_days == 90


class TestWorkflowModels:
    def test_valid_bpm(self):
        bpm = BusinessProcess(
            bpm_id="CO_APPROVAL",
            associate_with=["Change Order"],
            steps=[
                WorkflowStep(
                    step_name="Submit", step_type=StepType.SUBMIT, order=1
                ),
                WorkflowStep(
                    step_name="PM Review",
                    step_type=StepType.STEP,
                    order=2,
                    assigned_roles=["Project Manager"],
                    review_days=5,
                ),
                WorkflowStep(
                    step_name="Complete",
                    step_type=StepType.FINISH,
                    order=3,
                ),
            ],
        )
        assert bpm.validate_structure() == []

    def test_bpm_missing_submit(self):
        bpm = BusinessProcess(
            bpm_id="BAD",
            steps=[
                WorkflowStep(
                    step_name="Review", step_type=StepType.STEP, order=1
                ),
                WorkflowStep(
                    step_name="Done", step_type=StepType.FINISH, order=2
                ),
            ],
        )
        issues = bpm.validate_structure()
        assert any("Submit" in i for i in issues)

    def test_bpm_missing_finish(self):
        bpm = BusinessProcess(
            bpm_id="BAD",
            steps=[
                WorkflowStep(
                    step_name="Submit", step_type=StepType.SUBMIT, order=1
                ),
                WorkflowStep(
                    step_name="Review", step_type=StepType.STEP, order=2
                ),
            ],
        )
        issues = bpm.validate_structure()
        assert any("Finish" in i for i in issues)

    def test_empty_bpm(self):
        bpm = BusinessProcess(bpm_id="EMPTY")
        assert len(bpm.validate_structure()) == 1


class TestFormModels:
    def test_classic_form(self):
        form = ClassicForm(
            form_id="SAFETY_INSPECT",
            form_name="Safety Inspection",
            custom_fields=[
                CustomField(
                    label="Inspector Name",
                    data_type=FieldDataType.TEXT,
                    is_required=True,
                ),
                CustomField(
                    label="Inspection Date",
                    data_type=FieldDataType.DATE,
                    is_required=True,
                ),
                CustomField(
                    label="Status",
                    data_type=FieldDataType.DROPDOWN,
                    dropdown_options=["Pass", "Fail", "N/A"],
                ),
            ],
        )
        assert form.form_id == "SAFETY_INSPECT"
        assert len(form.custom_fields) == 3
        assert form.custom_fields[2].dropdown_options == ["Pass", "Fail", "N/A"]

    def test_form_permissions(self):
        perm = FormPermission(group_name="PM_TEAM", can_view=True, can_edit=True)
        assert perm.can_view is True
