"""Regression tests for auto-fix issue creation."""

import pytest

from app.services.mlops_engine import MLOpsEngine


class FakeCollection:
    def __init__(self) -> None:
        self.docs = []

    def insert_one(self, doc):
        self.docs.append(doc)

    def update_one(self, filter_doc, update):
        doc = next(
            item for item in self.docs if item.get("fix_id") == filter_doc["fix_id"]
        )
        for key, value in update.get("$set", {}).items():
            target = doc
            parts = key.split(".")
            for part in parts[:-1]:
                target = target[int(part)] if part.isdigit() else target[part]
            target[parts[-1]] = value

    def find_one(self, *args, **kwargs):
        return None

    def count_documents(self, *args, **kwargs):
        return 0

    def find(self, *args, **kwargs):
        return []


class FakeDB:
    def __init__(self) -> None:
        self.fixes = FakeCollection()

    def __getitem__(self, name):
        assert name == "fixes"
        return self.fixes


class FakeFeedbackStore:
    def __init__(self, ticket):
        self.ticket = ticket

    def get_ticket(self, feedback_id):
        return self.ticket


def make_engine(ticket):
    return MLOpsEngine(
        db=FakeDB(),
        learning_store=object(),
        feedback_store=FakeFeedbackStore(ticket),
    )


@pytest.mark.parametrize(
    ("prompt", "expected", "actual", "missing"),
    [
        ("", "expected", "actual", "prompt"),
        ("prompt", "", "actual", "expected"),
        ("prompt", "expected", "", "actual"),
    ],
)
def test_create_github_issue_rejects_blank_required_context(
    prompt,
    expected,
    actual,
    missing,
):
    engine = make_engine({})

    with pytest.raises(ValueError) as exc_info:
        engine._create_github_issue("feedback-id", prompt, expected, actual, "")

    assert f"missing required context: {missing}" in str(exc_info.value)


def test_process_fix_now_fails_before_issue_creation_for_blank_ticket():
    engine = make_engine(
        {
            "id": "feedback-id",
            "session_id": "",
            "prompt": " ",
            "actual_result": "",
            "expected_result": "It should work",
        }
    )

    result = engine.process_fix_now("feedback-id")

    assert result["status"] == "failed"
    assert "missing required context: prompt, actual" in result["error"]
    assert engine._fixes.docs[0]["status"] == "failed"
