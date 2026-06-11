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

### How the Agent Works

1. User chats in the frontend UI at `localhost:5173`
2. User clicks "Connect to PMWeb" — this opens a **visible** Chrome browser that logs into PMWeb
3. When the user requests a configuration (e.g. "create a security group"), the agent:
   - Calls GPT-4o which decides which tool to invoke
   - The tool handler navigates the real PMWeb UI via Selenium
   - Opens the Security page, clicks "New Group", fills in the form, and saves
4. The result is shown back to the user in the chat as a green action card

### Important Technical Notes

- **Selenium required**: PMWeb uses Telerik/Kendo Angular controls. Playwright headless does NOT work with these controls (keyboard events don't register). Selenium with Chrome works.
- **Browser must be visible**: Set `PMWEB_HEADLESS=false` (the default). The Security page loads an Angular app inside an iframe (`id=ctl00_CPH1_ngFrame` at `/app/security`). All interactions must `switch_to.frame()` first.
- **PMWeb session conflict**: If admin is already logged in elsewhere, an alert appears: "This user is already logged into this database." The automation accepts it automatically.
- **`~/.local/bin` on PATH**: Required for `uvicorn`, `pytest`, `ruff`.
- **Credentials**: Stored in `backend/.env` (git-ignored): `PMWEB_BASE_URL`, `PMWEB_USERNAME`, `PMWEB_PASSWORD`, `OPENAI_API_KEY`.
- **Admin display name**: Shows as "Bassam Samman" on the Demo database.
