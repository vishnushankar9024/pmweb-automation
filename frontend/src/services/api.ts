import type { ChatResponse, ExecutedAction } from "../types";

const API_BASE = import.meta.env.VITE_API_URL || "";

export async function sendChatMessage(
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
  if (!res.ok) throw new Error(`API error: ${res.status}`);
  return res.json();
}

export interface SessionSummary {
  id: string;
  title: string;
  created_at: string;
  updated_at: string;
}

export interface SessionDetail extends SessionSummary {
  messages: {
    role: string;
    content: string;
    actions: ExecutedAction[];
    timestamp: string;
  }[];
}

export async function listSessions(): Promise<SessionSummary[]> {
  const res = await fetch(`${API_BASE}/api/sessions`);
  return res.json();
}

export async function getSession(id: string): Promise<SessionDetail> {
  const res = await fetch(`${API_BASE}/api/sessions/${id}`);
  return res.json();
}

export async function deleteSession(id: string): Promise<void> {
  await fetch(`${API_BASE}/api/sessions/${id}`, { method: "DELETE" });
}

export async function getPmwebStatus(): Promise<{
  configured: boolean;
  connected: boolean;
}> {
  const res = await fetch(`${API_BASE}/api/pmweb/status`);
  return res.json();
}

export async function connectPmweb(): Promise<{ status: string }> {
  const res = await fetch(`${API_BASE}/api/pmweb/connect`, {
    method: "POST",
  });
  if (!res.ok) {
    const err = await res.json();
    throw new Error(err.detail || "Connection failed");
  }
  return res.json();
}
