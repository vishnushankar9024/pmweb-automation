# PMWeb Automation Agent

AI-powered conversational agent for automating PMWeb configuration — security settings, workflows, and custom forms.

## Architecture

```
backend/          Python FastAPI backend with OpenAI function calling
  app/
    agent/        Agent core (LLM orchestrator, tools, prompts)
    models/       Pydantic domain models (security, workflow, form)
    services/     PMWeb client (mock mode / API integration)
    api/          REST endpoints (chat, health)
  tests/          pytest test suite

frontend/         React + TypeScript chat UI (Vite)
  src/
    components/   ChatWindow, MessageBubble, ActionCard
    services/     API client
```

## Quick Start

### Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```

Open http://localhost:5173 to use the chat interface.

### Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `OPENAI_API_KEY` | No* | OpenAI API key for AI-powered configuration |
| `OPENAI_MODEL` | No | Model to use (default: `gpt-4o`) |
| `PMWEB_BASE_URL` | No | PMWeb instance URL (for live integration) |

*Without an API key, the agent runs in fallback mode with guided responses.

## Testing

```bash
cd backend
python3 -m pytest tests/ -v    # Run all tests
ruff check .                   # Lint
```

## What the Agent Can Do

1. **Security Settings** — Create groups, users, permissions, password policies
2. **Workflows** — Design approval chains with submit/review/approve/finish steps
3. **Custom Forms** — Build forms with custom fields, permissions, workflow integration
