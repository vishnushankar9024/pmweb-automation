export interface ChatMessage {
  role: "user" | "assistant";
  content: string;
  actions?: ExecutedAction[];
}

export interface ExecutedAction {
  tool: string;
  args: Record<string, unknown>;
  result: {
    status: string;
    [key: string]: unknown;
  };
}

export interface ChatResponse {
  reply: string;
  conversation_id: string;
  pending_actions: unknown[];
  executed_actions: ExecutedAction[];
}
