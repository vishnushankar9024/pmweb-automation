import type { ChatResponse } from "../types";

const API_BASE = import.meta.env.VITE_API_URL || "";

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

export async function getPmwebStatus(): Promise<{
  configured: boolean;
  base_url: string | null;
  connected: boolean;
}> {
  const res = await fetch(`${API_BASE}/api/pmweb/status`);
  return res.json();
}

export async function connectPmweb(): Promise<{
  status: string;
  url?: string;
}> {
  const res = await fetch(`${API_BASE}/api/pmweb/connect`, { method: "POST" });
  if (!res.ok) {
    const err = await res.json();
    throw new Error(err.detail || "Connection failed");
  }
  return res.json();
}

// ── Session management ──────────────────────────────────────────────

export async function getSessionList(): Promise<string[]> {
  const res = await fetch(`${API_BASE}/api/sessions`);
  if (!res.ok) return [];
  return res.json();
}

export async function deleteSession(sessionId: string): Promise<void> {
  await fetch(`${API_BASE}/api/sessions/${sessionId}`, { method: "DELETE" });
}

// ── Feedback ────────────────────────────────────────────────────────

export interface FeedbackPayload {
  session_id: string;
  message_index: number;
  rating: number;
  comment: string;
  action_name: string;
}

export async function submitFeedback(payload: FeedbackPayload): Promise<{ feedback_id: string }> {
  const res = await fetch(`${API_BASE}/api/feedback`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload),
  });
  if (!res.ok) {
    throw new Error(`Feedback submit failed: ${res.status}`);
  }
  return res.json();
}

export async function getFeedbackSummary(): Promise<{
  total: number;
  positive: number;
  negative: number;
  neutral: number;
  satisfaction_rate: number | null;
}> {
  const res = await fetch(`${API_BASE}/api/feedback/summary`);
  return res.json();
}

// ── MLOps / Performance ─────────────────────────────────────────────

export async function getPerformanceReport(): Promise<Record<string, unknown>> {
  const res = await fetch(`${API_BASE}/api/mlops/report`);
  return res.json();
}

export async function getSession(sessionId: string) {
  const res = await fetch(`${API_BASE}/api/sessions/${sessionId}`);
  if (!res.ok) throw new Error(`Session not found: ${res.status}`);
  return res.json();
}

export async function listSessions() { const r = await fetch((import.meta.env.VITE_API_URL || "") + "/api/sessions"); return r.json(); }

