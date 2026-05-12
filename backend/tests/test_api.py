"""Tests for API endpoints."""

from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


class TestHealthEndpoint:
    def test_health_check(self):
        response = client.get("/health")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "healthy"
        assert "PMWeb" in data["service"]

    def test_health_shows_openai_status(self):
        response = client.get("/health")
        data = response.json()
        assert "openai_configured" in data


class TestChatEndpoint:
    def test_chat_returns_response(self):
        response = client.post(
            "/api/chat",
            json={"message": "Hello, I need help with PMWeb"},
        )
        assert response.status_code == 200
        data = response.json()
        assert "reply" in data
        assert "conversation_id" in data
        assert len(data["reply"]) > 0

    def test_chat_security_topic(self):
        response = client.post(
            "/api/chat",
            json={"message": "I need to set up security groups"},
        )
        data = response.json()
        assert len(data["reply"]) > 0

    def test_chat_workflow_topic(self):
        response = client.post(
            "/api/chat",
            json={"message": "Help me create an approval workflow"},
        )
        data = response.json()
        assert len(data["reply"]) > 0

    def test_chat_conversation_continuity(self):
        r1 = client.post("/api/chat", json={"message": "Hello"})
        cid = r1.json()["conversation_id"]
        r2 = client.post(
            "/api/chat",
            json={"message": "Tell me about workflows", "conversation_id": cid},
        )
        assert r2.json()["conversation_id"] == cid
