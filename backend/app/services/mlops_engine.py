"""MLOps Engine — full feedback-to-fix cycle for PMWeb Agent.

Flow: Diagnose → Create GitHub PR → Cursor fixes → Auto-deploy → Verify

Replicates smart-gatekeeper pattern:
1. Create fix-now/{feedback_id} branch
2. Add diagnosis file to .fix-now/ folder
3. Create PR with full context targeting main branch
4. Add fix-now label → Cursor Automation picks it up
5. Cursor fixes code, pushes to branch
6. Cloud Build / VM auto-deploys
7. Verify by re-running the prompt
"""

from __future__ import annotations

import base64
import json
import logging
import os
from datetime import datetime, timezone
from typing import Any

import requests as http_requests

logger = logging.getLogger(__name__)

GITHUB_REPO = "vishnushankar9024/pmweb-automation"
GITHUB_API = f"https://api.github.com/repos/{GITHUB_REPO}"
BASE_BRANCH = "cursor/pmweb-agent-6eca"


class MLOpsEngine:
    """Full Fix Now / Fix Later pipeline."""

    def __init__(self, db) -> None:
        self.db = db
        self.feedback_col = db["feedback_tickets"]
        self.diagnosis_col = db["diagnoses"]

    def process_fix_now(self, feedback_id: str) -> dict[str, Any]:
        """Immediate fix: diagnose → create PR → Cursor fixes."""
        from bson import ObjectId

        try:
            fb = self.feedback_col.find_one(
                {"_id": ObjectId(feedback_id)}
            )
        except Exception:
            return {"error": f"Invalid feedback_id: {feedback_id}"}

        if not fb:
            return {"error": "Feedback not found"}

        prompt = fb.get("prompt", "")
        actual = fb.get("actual_result", "")
        expected = fb.get("expected_result", "")

        # Step 1: Diagnose
        diagnosis = self._diagnose(prompt, actual, expected)

        # Step 2: Create GitHub PR
        pr_result = self._create_github_pr(diagnosis, fb)

        # Step 3: Update feedback record
        self.feedback_col.update_one(
            {"_id": fb["_id"]},
            {
                "$set": {
                    "status": "fixing",
                    "fix_mode": "now",
                    "diagnosis": diagnosis,
                    "github_pr": pr_result,
                    "fixed_at": datetime.now(timezone.utc),
                }
            },
        )

        self.diagnosis_col.insert_one(
            {
                "feedback_id": feedback_id,
                "prompt": prompt,
                "expected": expected,
                "diagnosis": diagnosis,
                "github_pr": pr_result,
                "created_at": datetime.now(timezone.utc),
            }
        )

        return {
            "feedback_id": feedback_id,
            "status": "fixing",
            "github_pr": pr_result,
            "diagnosis_summary": diagnosis.get("summary", ""),
            "message": (
                f"PR #{pr_result.get('number', '?')} created. "
                "Agent on duty will fix and auto-deploy."
            ),
        }

    def process_fix_later(self, feedback_id: str) -> dict[str, Any]:
        """Queue for batch processing at 7 PM IST."""
        from bson import ObjectId

        self.feedback_col.update_one(
            {"_id": ObjectId(feedback_id)},
            {
                "$set": {
                    "status": "queued",
                    "fix_mode": "later",
                }
            },
        )
        return {
            "feedback_id": feedback_id,
            "status": "queued",
            "message": "Queued for batch fix at 7:00 PM IST.",
        }

    def process_batch(self) -> dict[str, Any]:
        """Process all queued tickets (called by scheduler)."""
        queued = list(
            self.feedback_col.find({"status": "queued"}).limit(20)
        )
        if not queued:
            return {"processed": 0, "message": "No tickets queued"}

        results = []
        for fb in queued:
            fid = str(fb["_id"])
            r = self.process_fix_now(fid)
            results.append(r)

        return {"processed": len(results), "results": results}

    def get_fix_status(self, feedback_id: str) -> dict[str, Any]:
        """Get current status of a fix for progress bar."""
        from bson import ObjectId

        try:
            fb = self.feedback_col.find_one(
                {"_id": ObjectId(feedback_id)}
            )
        except Exception:
            return {"error": "Invalid feedback_id"}

        if not fb:
            return {"error": "Feedback not found"}

        status = fb.get("status", "pending")
        pr = fb.get("github_pr", {})
        pr_number = pr.get("number")
        pr_url = pr.get("url", "")

        # Check PR status from GitHub
        pr_merged = False
        cursor_fixed = False
        if pr_number:
            token = os.environ.get("GITHUB_TOKEN", "")
            if token:
                try:
                    headers = {
                        "Authorization": f"token {token}",
                        "Accept": "application/vnd.github.v3+json",
                    }
                    resp = http_requests.get(
                        f"{GITHUB_API}/pulls/{pr_number}",
                        headers=headers,
                        timeout=5,
                    )
                    if resp.status_code == 200:
                        pr_data = resp.json()
                        pr_merged = pr_data.get("merged", False)

                    # Check if Cursor pushed commits
                    commits_resp = http_requests.get(
                        f"{GITHUB_API}/pulls/{pr_number}/commits",
                        headers=headers,
                        timeout=5,
                    )
                    if commits_resp.status_code == 200:
                        commits = commits_resp.json()
                        for c in commits:
                            author = (
                                c.get("author", {}) or {}
                            ).get("login", "")
                            msg = c.get("commit", {}).get(
                                "message", ""
                            )
                            if (
                                "cursor" in author.lower()
                                or "fix" in msg.lower()
                            ):
                                cursor_fixed = True
                except Exception:
                    pass

        # Determine progress step
        if status == "pending":
            step, pct, label = 0, 0, "Waiting..."
        elif status == "fixing":
            if cursor_fixed:
                step, pct, label = (
                    3,
                    60,
                    "Agent on duty has fixed the code",
                )
            elif pr_number:
                step, pct, label = (
                    2,
                    40,
                    "Agent on duty is fixing...",
                )
            else:
                step, pct, label = 1, 20, "Diagnosing issue..."
        elif status == "deploying":
            step, pct, label = 4, 80, "Deploying to server..."
        elif status == "resolved":
            step, pct, label = 5, 100, "Fixed and verified!"
        elif status == "queued":
            step, pct, label = (
                0,
                0,
                "Queued for 7:00 PM IST batch",
            )
        else:
            step, pct, label = 0, 0, status

        return {
            "feedback_id": feedback_id,
            "step": step,
            "step_label": label,
            "progress_pct": pct,
            "status": status,
            "pr_url": pr_url,
            "pr_merged": pr_merged,
            "cursor_fixed": cursor_fixed,
            "done": status in ("resolved", "failed"),
            "steps": [
                {
                    "step": 1,
                    "label": "Diagnosing the issue",
                    "done": step >= 1,
                },
                {
                    "step": 2,
                    "label": "Agent on duty is fixing",
                    "done": step >= 3,
                },
                {
                    "step": 3,
                    "label": "Deploying to server",
                    "done": step >= 4,
                },
                {
                    "step": 4,
                    "label": "Verifying the fix",
                    "done": step >= 5,
                },
            ],
        }

    def get_queued_count(self) -> int:
        return self.feedback_col.count_documents({"status": "queued"})

    def _diagnose(
        self, prompt: str, actual: str, expected: str
    ) -> dict[str, Any]:
        """Analyze what went wrong."""
        issues = []
        if not actual:
            issues.append("Agent returned empty result")
        if actual == expected:
            issues.append("Results appear identical")

        return {
            "prompt": prompt,
            "actual_result": actual[:500],
            "expected_result": expected[:500],
            "issues": issues,
            "summary": (
                f"User expected: '{expected[:100]}' "
                f"but got: '{actual[:100]}'"
            ),
        }

    def _create_github_pr(
        self, diagnosis: dict, feedback: dict
    ) -> dict[str, Any]:
        """Create a GitHub PR with fix-now label."""
        token = os.environ.get("GITHUB_TOKEN", "")
        if not token:
            return {"error": "GITHUB_TOKEN not set"}

        headers = {
            "Authorization": f"token {token}",
            "Accept": "application/vnd.github.v3+json",
        }

        feedback_id = str(feedback.get("_id", ""))
        prompt = feedback.get("prompt", "")
        expected = feedback.get("expected_result", "")
        actual = feedback.get("actual_result", "")
        ts = datetime.now(timezone.utc).strftime("%Y%m%d%H%M%S")

        try:
            # Get base branch SHA
            ref_resp = http_requests.get(
                f"{GITHUB_API}/git/ref/heads/{BASE_BRANCH}",
                headers=headers,
                timeout=10,
            )
            if ref_resp.status_code != 200:
                return {
                    "error": f"Branch {BASE_BRANCH} not found"
                }
            base_sha = ref_resp.json()["object"]["sha"]

            # Create fix branch
            branch_name = f"fix-now/{feedback_id[:8]}-{ts}"
            http_requests.post(
                f"{GITHUB_API}/git/refs",
                headers=headers,
                json={
                    "ref": f"refs/heads/{branch_name}",
                    "sha": base_sha,
                },
                timeout=10,
            )

            # Add diagnosis file
            diag_content = json.dumps(
                {
                    "feedback_id": feedback_id,
                    "prompt": prompt,
                    "expected": expected,
                    "actual": actual,
                    "diagnosis": diagnosis,
                    "timestamp": ts,
                },
                indent=2,
            )

            http_requests.put(
                f"{GITHUB_API}/contents/"
                f".fix-now/{feedback_id}.json",
                headers=headers,
                json={
                    "message": f"fix-now: {prompt[:60]}",
                    "content": base64.b64encode(
                        diag_content.encode()
                    ).decode(),
                    "branch": branch_name,
                },
                timeout=10,
            )

            # Create PR
            title = (
                f"Fix: \"{prompt[:70]}\" → wrong result"
            )
            body = f"""## Fix Now — Agent gave wrong result

### User Prompt
```
{prompt}
```

### Expected Result
```
{expected}
```

### Actual Result
```
{actual[:500]}
```

### Diagnosis
{diagnosis.get('summary', '')}

### Relevant Code Files
- `backend/app/agent/browser_agent.py` — planner prompt + action handlers
- `backend/app/services/pmweb_browser.py` — Selenium PMWeb interactions

### Instructions for Agent on Duty
Fix the PMWeb automation agent so that when the user says:
"{prompt}"
The result matches: "{expected}"

The issue is likely in the PLANNER_PROMPT (wrong action plan generated)
or in the _execute_step handlers (action not working correctly).
"""

            pr_resp = http_requests.post(
                f"{GITHUB_API}/pulls",
                headers=headers,
                json={
                    "title": title,
                    "body": body,
                    "head": branch_name,
                    "base": BASE_BRANCH,
                },
                timeout=15,
            )

            if pr_resp.status_code not in (200, 201):
                return {
                    "error": f"PR creation failed: "
                    f"{pr_resp.text[:200]}"
                }

            pr_data = pr_resp.json()
            pr_number = pr_data["number"]

            # Add fix-now label
            http_requests.post(
                f"{GITHUB_API}/issues/{pr_number}/labels",
                headers=headers,
                json={"labels": ["fix-now"]},
                timeout=10,
            )

            return {
                "number": pr_number,
                "url": pr_data.get("html_url"),
                "branch": branch_name,
                "title": title,
                "status": "created",
            }

        except Exception as e:
            logger.exception("Failed to create GitHub PR")
            return {"error": str(e), "status": "failed"}
