# AGENTS.md

## Cursor Cloud specific instructions

### Services

| Service | Command | Port |
|---------|---------|------|
| Backend (FastAPI) | `cd backend && uvicorn app.main:app --reload --port 8000` | 8000 |
| Frontend (Vite) | `cd frontend && npm run dev -- --host 0.0.0.0 --port 5173` | 5173 |

### Key Commands

- **Lint**: `cd backend && ruff check .`
- **Tests**: `cd backend && python3 -m pytest tests/ -v`
- **TypeScript check**: `cd frontend && npx tsc --noEmit`

### Notes

- The backend runs without `OPENAI_API_KEY` in fallback mode (returns guided topic-based responses instead of LLM-generated answers). Set the key as an env var or in `backend/.env` for full agent functionality.
- The frontend dev server proxies nothing — it calls the backend directly at `http://localhost:8000`. The backend has CORS configured for `localhost:5173`.
- The `pip` user-install path (`~/.local/bin`) must be on `PATH` for `uvicorn`, `pytest`, and `ruff` commands to work.
- PMWeb client currently runs in mock mode (in-memory). All "created" resources live only for the session.
