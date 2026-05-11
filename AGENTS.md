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

- The backend runs without `OPENAI_API_KEY` in fallback mode (topic-based guided responses). Set the key in `backend/.env` for full LLM agent functionality.
- The frontend dev server calls the backend directly at `http://localhost:8000`. Backend CORS is configured for `localhost:5173`.
- `~/.local/bin` must be on `PATH` for `uvicorn`, `pytest`, and `ruff` to work.
- PMWeb browser automation uses Selenium with Chrome (`--headless=new`). The Telerik ASP.NET controls in PMWeb do NOT work with Playwright headless — Selenium is required.
- PMWeb credentials are configured via env vars: `PMWEB_BASE_URL`, `PMWEB_USERNAME`, `PMWEB_PASSWORD` (stored in `backend/.env`, git-ignored).
- After connecting to PMWeb, the admin user's display name is "Bassam Samman" on the Demo database.
- If login fails with "already logged in" alert, the automation accepts it automatically.
