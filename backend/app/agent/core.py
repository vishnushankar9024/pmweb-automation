"""Core agent orchestrator — manages conversation and tool execution."""

from __future__ import annotations

import json
import logging
import uuid
from typing import Any

from openai import OpenAI
from openai.types.chat import ChatCompletionMessageToolCall

from app.agent.prompts import SYSTEM_PROMPT
from app.agent.tools import TOOLS
from app.config import settings
from app.services.pmweb_client import PMWebClient

logger = logging.getLogger(__name__)


class ConversationState:
    def __init__(self) -> None:
        self.messages: list[dict[str, Any]] = [
            {"role": "system", "content": SYSTEM_PROMPT}
        ]
        self.pmweb = PMWebClient()

    def add_user_message(self, content: str) -> None:
        self.messages.append({"role": "user", "content": content})

    def add_assistant_message(self, content: str) -> None:
        self.messages.append({"role": "assistant", "content": content})


class PMWebAgent:
    """Conversational agent that uses OpenAI function calling to configure PMWeb."""

    def __init__(self) -> None:
        self._conversations: dict[str, ConversationState] = {}
        self._client: OpenAI | None = None

    @property
    def client(self) -> OpenAI:
        if self._client is None:
            self._client = OpenAI(api_key=settings.openai_api_key)
        return self._client

    def _get_or_create_conversation(
        self, conversation_id: str | None
    ) -> tuple[str, ConversationState]:
        if conversation_id and conversation_id in self._conversations:
            return conversation_id, self._conversations[conversation_id]
        cid = conversation_id or str(uuid.uuid4())
        state = ConversationState()
        self._conversations[cid] = state
        return cid, state

    def _execute_tool_calls(
        self, tool_calls: list[ChatCompletionMessageToolCall], state: ConversationState
    ) -> list[dict[str, Any]]:
        results: list[dict[str, Any]] = []
        for tc in tool_calls:
            fn_name = tc.function.name
            fn_args = json.loads(tc.function.arguments)
            logger.info("Executing tool: %s(%s)", fn_name, fn_args)

            result = state.pmweb.execute_action(fn_name, fn_args)
            results.append({"tool": fn_name, "args": fn_args, "result": result})

            state.messages.append(
                {"role": "tool", "tool_call_id": tc.id, "content": json.dumps(result)}
            )
        return results

    async def chat(self, message: str, conversation_id: str | None = None) -> dict[str, Any]:
        cid, state = self._get_or_create_conversation(conversation_id)
        state.add_user_message(message)

        if not settings.openai_api_key:
            return self._fallback_response(message, cid, state)

        executed_actions: list[dict[str, Any]] = []

        response = self.client.chat.completions.create(
            model=settings.openai_model,
            messages=state.messages,
            tools=TOOLS,
            tool_choice="auto",
        )

        choice = response.choices[0]

        while choice.finish_reason == "tool_calls" and choice.message.tool_calls:
            state.messages.append(choice.message.model_dump())
            results = self._execute_tool_calls(choice.message.tool_calls, state)
            executed_actions.extend(results)

            response = self.client.chat.completions.create(
                model=settings.openai_model,
                messages=state.messages,
                tools=TOOLS,
                tool_choice="auto",
            )
            choice = response.choices[0]

        reply = choice.message.content or ""
        state.add_assistant_message(reply)

        return {
            "reply": reply,
            "conversation_id": cid,
            "executed_actions": executed_actions,
            "pending_actions": [],
        }

    def _fallback_response(
        self, message: str, cid: str, state: ConversationState
    ) -> dict[str, Any]:
        """Provide a helpful response when no OpenAI API key is configured."""
        msg_lower = message.lower()

        sec_kws = ("security", "group", "user", "permission", "password", "access")
        wf_kws = ("workflow", "approval", "routing", "review")
        form_kws = ("form", "field", "custom", "inspection", "checklist")

        if any(kw in msg_lower for kw in sec_kws):
            reply = (
                "I can help you set up PMWeb security! "
                "Here's what I can configure:\n\n"
                "- **Security Groups**: Create groups like "
                "'Project Managers', 'Contractors'\n"
                "- **User Accounts**: Create users and assign them to groups\n"
                "- **Access Control**: Set project and module permissions\n"
                "- **Password Policy**: Configure length, complexity, expiry\n\n"
                "👉 *Set the `OPENAI_API_KEY` env var for full "
                "AI-powered configuration.* Tell me what to set up."
            )
        elif any(kw in msg_lower for kw in wf_kws):
            reply = (
                "I can help you design PMWeb workflows! "
                "Here's what I can do:\n\n"
                "- **Visual Workflows**: Design approval chains "
                "(Submit → Review → Approve → Finish)\n"
                "- **Step Configuration**: Reviewers, deadlines, rules\n"
                "- **Notifications**: Email/in-app alerts at each step\n\n"
                "👉 *Set the `OPENAI_API_KEY` env var for full "
                "AI-powered workflow design.*"
            )
        elif any(kw in msg_lower for kw in form_kws):
            reply = (
                "I can help you build PMWeb custom forms! "
                "Here's what I can create:\n\n"
                "- **Custom Forms**: Safety inspections, "
                "quality checklists, field reports\n"
                "- **Field Types**: Text, number, currency, date, "
                "dropdown, checkbox, calculated\n"
                "- **Permissions**: View, add, edit, delete per group\n"
                "- **Workflow Integration**: Link forms to workflows\n\n"
                "👉 *Set the `OPENAI_API_KEY` env var for full "
                "AI-powered form creation.*"
            )
        else:
            reply = (
                "Welcome to the **PMWeb Automation Agent**! "
                "I can help you configure:\n\n"
                "1. **Security Settings** — Groups, users, permissions\n"
                "2. **Workflows** — Approval chains, review steps\n"
                "3. **Custom Forms** — Inspections, checklists, "
                "field reports\n\n"
                "Describe your requirements in plain language.\n\n"
                "👉 *Set the `OPENAI_API_KEY` env var for full "
                "AI-powered configuration.*"
            )

        state.add_assistant_message(reply)
        return {
            "reply": reply,
            "conversation_id": cid,
            "executed_actions": [],
            "pending_actions": [],
        }
