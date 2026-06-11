"""High-level browser agent — orchestrates PMWeb browser actions with
retry logic, screenshot capture on failure, and progress reporting.

Wraps :class:`PMWebBrowser` to provide a resilient execution layer that the
agent core can call without worrying about transient Selenium failures.
"""

from __future__ import annotations

import base64
import logging
import time
from dataclasses import dataclass, field
from typing import Any, Callable

from app.services.pmweb_browser import PMWebBrowser

logger = logging.getLogger(__name__)

DEFAULT_MAX_RETRIES = 2
DEFAULT_RETRY_DELAY = 3.0


@dataclass
class ActionResult:
    """Structured result of a browser action."""

    action: str
    status: str
    detail: dict[str, Any] = field(default_factory=dict)
    screenshot_b64: str | None = None
    elapsed_seconds: float = 0.0
    retries: int = 0


class BrowserAgent:
    """Resilient wrapper around :class:`PMWebBrowser`.

    * Automatically retries transient Selenium errors.
    * Captures a screenshot on failure for diagnostics.
    * Emits structured :class:`ActionResult` objects.
    * Tracks cumulative action history for the session.
    """

    def __init__(
        self,
        browser: PMWebBrowser,
        max_retries: int = DEFAULT_MAX_RETRIES,
        retry_delay: float = DEFAULT_RETRY_DELAY,
    ) -> None:
        self.browser = browser
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        self.history: list[ActionResult] = []

    @property
    def is_connected(self) -> bool:
        return self.browser._logged_in

    def ensure_connected(self) -> ActionResult:
        """Login if not already connected."""
        if self.is_connected:
            return ActionResult(action="login", status="already_connected")
        result = self._run_with_retry("login", self.browser.login)
        return result

    def _capture_screenshot(self) -> str | None:
        """Return base64-encoded PNG of the current browser state."""
        try:
            if self.browser._driver is None:
                return None
            png = self.browser.driver.get_screenshot_as_png()
            return base64.b64encode(png).decode("ascii")
        except Exception:
            return None

    def _run_with_retry(
        self,
        action_name: str,
        fn: Callable[..., dict[str, Any]],
        *args: Any,
        **kwargs: Any,
    ) -> ActionResult:
        """Execute *fn* with up to *max_retries* on failure."""
        last_error: str = ""
        for attempt in range(1 + self.max_retries):
            start = time.monotonic()
            try:
                raw = fn(*args, **kwargs)
                elapsed = time.monotonic() - start
                status = raw.get("status", "unknown")
                result = ActionResult(
                    action=action_name,
                    status=status,
                    detail=raw,
                    elapsed_seconds=round(elapsed, 2),
                    retries=attempt,
                )
                if status == "error" and attempt < self.max_retries:
                    last_error = raw.get("message", "")
                    logger.warning(
                        "%s attempt %d failed: %s — retrying",
                        action_name,
                        attempt + 1,
                        last_error,
                    )
                    time.sleep(self.retry_delay)
                    continue
                self.history.append(result)
                return result
            except Exception as exc:
                last_error = str(exc)
                logger.exception(
                    "%s attempt %d raised exception", action_name, attempt + 1
                )
                if attempt < self.max_retries:
                    time.sleep(self.retry_delay)

        screenshot = self._capture_screenshot()
        result = ActionResult(
            action=action_name,
            status="error",
            detail={"message": last_error},
            screenshot_b64=screenshot,
            retries=self.max_retries,
        )
        self.history.append(result)
        return result

    def create_security_group(
        self,
        group_name: str,
        description: str,
        options: list[str] | None = None,
    ) -> ActionResult:
        self.ensure_connected()
        return self._run_with_retry(
            "create_security_group",
            self.browser.create_security_group,
            group_name=group_name,
            description=description,
            options=options,
        )

    def create_user(self, **kwargs: Any) -> ActionResult:
        self.ensure_connected()
        return self._run_with_retry(
            "create_user",
            self.browser.create_user,
            **kwargs,
        )

    def get_summary(self) -> dict[str, Any]:
        """Return a summary of all actions executed during this session."""
        total = len(self.history)
        ok = sum(1 for r in self.history if r.status not in ("error",))
        return {
            "total_actions": total,
            "successful": ok,
            "failed": total - ok,
            "actions": [
                {
                    "action": r.action,
                    "status": r.status,
                    "elapsed": r.elapsed_seconds,
                    "retries": r.retries,
                }
                for r in self.history
            ],
        }
