export interface ChatMessage {
  role: "user" | "assistant";
  content: string;
  actions?: Record<string, unknown>[];
}

export interface ChatResponse {
  reply: string;
  conversation_id: string;
  pending_actions: unknown[];
  executed_actions: Record<string, unknown>[];
}
