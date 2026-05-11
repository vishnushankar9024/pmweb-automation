import type { ChatResponse } from "../types";

const API_BASE = import.meta.env.VITE_API_URL || "http://localhost:8000";

export async function sendMessage(
  message: string,
  conversationId?: string
): Promise<ChatResponse> {
  const res = await fetch(`${API_BASE}/api/chat`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      message,
      conversation_id: conversationId,
    }),
  });
  if (!res.ok) {
    throw new Error(`API error: ${res.status}`);
  }
  return res.json();
}

export async function checkHealth(): Promise<{
  status: string;
  service: string;
  openai_configured: boolean;
}> {
  const res = await fetch(`${API_BASE}/health`);
  return res.json();
}
