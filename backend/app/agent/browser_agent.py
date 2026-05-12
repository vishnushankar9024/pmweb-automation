"""Vision-based browser agent — sees the screen and acts like a human.

Takes screenshots, sends them to GPT-4o vision to understand the page,
then executes browser actions (click, type, scroll, navigate) based on
what it sees. Repeats until the task is complete.
"""

from __future__ import annotations

import base64
import json
import logging
import time
from typing import Any

from openai import OpenAI
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from app.config import settings

logger = logging.getLogger(__name__)

BROWSER_TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "click",
            "description": "Click at specific coordinates on the page",
            "parameters": {
                "type": "object",
                "properties": {
                    "x": {"type": "integer", "description": "X coordinate"},
                    "y": {"type": "integer", "description": "Y coordinate"},
                },
                "required": ["x", "y"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "type_text",
            "description": "Type text at the current cursor position",
            "parameters": {
                "type": "object",
                "properties": {
                    "text": {"type": "string", "description": "Text to type"},
                    "clear_first": {
                        "type": "boolean",
                        "description": "Clear field before typing",
                    },
                },
                "required": ["text"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "press_key",
            "description": "Press a keyboard key (Enter, Tab, Escape, etc.)",
            "parameters": {
                "type": "object",
                "properties": {
                    "key": {
                        "type": "string",
                        "description": "Key name: Enter, Tab, Escape, "
                        "Backspace, Delete, ArrowDown, ArrowUp",
                    },
                },
                "required": ["key"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "scroll",
            "description": "Scroll the page up or down",
            "parameters": {
                "type": "object",
                "properties": {
                    "direction": {
                        "type": "string",
                        "enum": ["up", "down"],
                    },
                    "amount": {
                        "type": "integer",
                        "description": "Pixels to scroll (default 300)",
                    },
                },
                "required": ["direction"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "navigate",
            "description": "Navigate to a URL",
            "parameters": {
                "type": "object",
                "properties": {
                    "url": {"type": "string", "description": "URL to open"},
                },
                "required": ["url"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "wait",
            "description": "Wait for the page to load",
            "parameters": {
                "type": "object",
                "properties": {
                    "seconds": {
                        "type": "integer",
                        "description": "Seconds to wait (default 3)",
                    },
                },
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "done",
            "description": "Task is complete. Call this when finished.",
            "parameters": {
                "type": "object",
                "properties": {
                    "summary": {
                        "type": "string",
                        "description": "Summary of what was accomplished",
                    },
                },
                "required": ["summary"],
            },
        },
    },
]

SYSTEM_PROMPT = """\
You are a PMWeb Automation Agent that controls a web browser to perform \
tasks on PMWeb — a construction project management platform.

You can see the current state of the browser via screenshots. Based on \
what you see, decide what action to take next.

## PMWeb Application Info
- URL: {base_url}
- The app uses Kendo UI / Angular components
- Security is under Tools > left sidebar click "Tools" then Security
- Adaptive Forms are under Tools > Adaptive Forms
- Workflows are under Workflows module in left sidebar
- After login, you land on the Home page with Visual Workflow Inbox

## Available Actions
- click(x, y): Click at coordinates on the screen
- type_text(text, clear_first): Type text (optionally clear field first)
- press_key(key): Press Enter, Tab, Escape, Backspace, ArrowDown, etc.
- scroll(direction, amount): Scroll up or down
- navigate(url): Go to a URL
- wait(seconds): Wait for page to load
- done(summary): Call when the task is complete

## Rules
- Look at the screenshot carefully before each action
- Click on the exact coordinates of buttons, fields, menu items
- After clicking a menu/dropdown, wait for it to open before clicking items
- After filling a form, look for and click the Save button
- If a dialog/alert appears, handle it (click OK, Accept, etc.)
- Call done() when the task is finished
- If something looks wrong, try a different approach
- Be precise with coordinates — look at where elements are in the image
"""


class BrowserAgent:
    """Vision-based browser agent for PMWeb."""

    def __init__(self) -> None:
        self._driver: webdriver.Chrome | None = None
        self._logged_in = False
        self._client: OpenAI | None = None

    @property
    def client(self) -> OpenAI:
        if self._client is None:
            self._client = OpenAI(api_key=settings.openai_api_key)
        return self._client

    @property
    def driver(self) -> webdriver.Chrome:
        if self._driver is None:
            opts = Options()
            opts.add_argument("--no-sandbox")
            opts.add_argument("--disable-setuid-sandbox")
            opts.add_argument("--disable-dev-shm-usage")
            opts.add_argument("--window-size=1400,900")
            if settings.pmweb_headless:
                opts.add_argument("--headless=new")
            self._driver = webdriver.Chrome(options=opts)
        return self._driver

    def login(self) -> dict[str, Any]:
        try:
            self.driver.get(settings.pmweb_base_url)
            time.sleep(3)
            pwd = WebDriverWait(self.driver, 10).until(
                EC.presence_of_element_located((By.ID, "txtPassword"))
            )
            pwd.click()
            time.sleep(0.3)
            pwd.send_keys(settings.pmweb_password)
            time.sleep(0.5)
            self.driver.find_element(By.ID, "btnLogin").click()
            time.sleep(3)
            try:
                alert = WebDriverWait(self.driver, 5).until(
                    EC.alert_is_present()
                )
                alert.accept()
                time.sleep(5)
            except Exception:
                time.sleep(5)
            if "Home" in self.driver.current_url:
                self._logged_in = True
                return {"status": "success"}
            return {"status": "error", "message": "Login failed"}
        except Exception as exc:
            return {"status": "error", "message": str(exc)}

    def take_screenshot_b64(self) -> str:
        png = self.driver.get_screenshot_as_png()
        return base64.b64encode(png).decode("ascii")

    def execute_action(self, action: str, params: dict) -> str:
        """Execute a browser action and return result."""
        try:
            if action == "click":
                self.driver.execute_script(
                    "document.elementFromPoint(arguments[0], arguments[1])"
                    ".click()",
                    params["x"],
                    params["y"],
                )
                time.sleep(1)
                return f"Clicked at ({params['x']}, {params['y']})"

            elif action == "type_text":
                if params.get("clear_first"):
                    ActionChains(self.driver).key_down(
                        Keys.CONTROL
                    ).send_keys("a").key_up(Keys.CONTROL).perform()
                    time.sleep(0.2)
                ActionChains(self.driver).send_keys(
                    params["text"]
                ).perform()
                time.sleep(0.5)
                return f"Typed: {params['text']}"

            elif action == "press_key":
                key_map = {
                    "Enter": Keys.ENTER,
                    "Tab": Keys.TAB,
                    "Escape": Keys.ESCAPE,
                    "Backspace": Keys.BACKSPACE,
                    "Delete": Keys.DELETE,
                    "ArrowDown": Keys.ARROW_DOWN,
                    "ArrowUp": Keys.ARROW_UP,
                    "ArrowLeft": Keys.ARROW_LEFT,
                    "ArrowRight": Keys.ARROW_RIGHT,
                }
                key = key_map.get(params["key"], params["key"])
                ActionChains(self.driver).send_keys(key).perform()
                time.sleep(0.5)
                return f"Pressed: {params['key']}"

            elif action == "scroll":
                amount = params.get("amount", 300)
                if params["direction"] == "down":
                    self.driver.execute_script(
                        f"window.scrollBy(0, {amount})"
                    )
                else:
                    self.driver.execute_script(
                        f"window.scrollBy(0, -{amount})"
                    )
                time.sleep(0.5)
                return f"Scrolled {params['direction']} {amount}px"

            elif action == "navigate":
                self.driver.get(params["url"])
                time.sleep(3)
                return f"Navigated to {params['url']}"

            elif action == "wait":
                secs = params.get("seconds", 3)
                time.sleep(secs)
                return f"Waited {secs}s"

            elif action == "done":
                return f"DONE: {params['summary']}"

            return f"Unknown action: {action}"
        except Exception as exc:
            return f"Error: {exc}"

    async def run_task(self, task: str) -> dict[str, Any]:
        """Run a task by looking at the screen and acting step by step."""
        if not self._logged_in:
            r = self.login()
            if r["status"] != "success":
                return {
                    "reply": f"Cannot connect to PMWeb: {r.get('message')}",
                    "actions": [],
                }

        messages = [
            {
                "role": "system",
                "content": SYSTEM_PROMPT.format(
                    base_url=settings.pmweb_base_url
                ),
            },
            {"role": "user", "content": f"Task: {task}"},
        ]

        actions_log = []
        max_steps = 20

        for step in range(max_steps):
            screenshot = self.take_screenshot_b64()

            messages.append({
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": (
                            f"Step {step + 1}: Here is the current screen. "
                            "What action should I take next?"
                            if step > 0
                            else "Here is the current PMWeb screen. "
                            "Begin the task."
                        ),
                    },
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/png;base64,{screenshot}",
                            "detail": "high",
                        },
                    },
                ],
            })

            response = self.client.chat.completions.create(
                model=settings.openai_model,
                messages=messages,
                tools=BROWSER_TOOLS,
                tool_choice="required",
                max_tokens=1000,
            )

            choice = response.choices[0]

            if not choice.message.tool_calls:
                break

            tc = choice.message.tool_calls[0]
            fn = tc.function.name
            args = json.loads(tc.function.arguments)

            logger.info("Step %d: %s(%s)", step + 1, fn, args)
            actions_log.append({"step": step + 1, "action": fn, "args": args})

            if fn == "done":
                return {
                    "reply": args.get("summary", "Task completed"),
                    "actions": actions_log,
                }

            result = self.execute_action(fn, args)
            logger.info("  Result: %s", result)

            messages.append(choice.message.model_dump())
            messages.append({
                "role": "tool",
                "tool_call_id": tc.id,
                "content": result,
            })

        return {
            "reply": "Task completed (reached step limit)",
            "actions": actions_log,
        }

    def close(self) -> None:
        if self._driver:
            self._driver.quit()
            self._driver = None
            self._logged_in = False
