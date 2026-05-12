export interface ChatMessage {
  role: "user" | "assistant";
  content: string;
  actions?: ExecutedAction[];
}

export interface ExecutedAction {
  step: number;
  action: string;
  result?: string | Record<string, unknown>;
  error?: string;
}

export interface ChatResponse {
  reply: string;
  conversation_id: string;
  pending_actions: unknown[];
  executed_actions: ExecutedAction[];
}
