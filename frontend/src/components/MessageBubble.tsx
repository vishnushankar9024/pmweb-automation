import { useState } from "react";
import type { ChatMessage } from "../types";
import { ActionCard } from "./ActionCard";
import { FeedbackPanel } from "./FeedbackPanel";

interface Props {
  message: ChatMessage;
  sessionId?: string;
  lastUserMessage?: string;
}

export function MessageBubble({ message, sessionId, lastUserMessage }: Props) {
  const isUser = message.role === "user";
  const [showFeedback, setShowFeedback] = useState(false);
  const [feedbackDone, setFeedbackDone] = useState(false);

  return (
    <div style={{ display: "flex", justifyContent: isUser ? "flex-end" : "flex-start", marginBottom: 16 }}>
      <div style={{ maxWidth: "80%" }}>
        <div style={{
          padding: "10px 14px", borderRadius: 12,
          background: isUser ? "#2563eb" : "#f1f5f9",
          color: isUser ? "#fff" : "#1e293b",
          fontSize: 13, lineHeight: 1.6, whiteSpace: "pre-wrap", wordBreak: "break-word",
        }}>
          {message.content}
        </div>

        {message.actions && message.actions.length > 0 && (
          <div style={{ marginTop: 4 }}>
            {message.actions.map((a, i) => <ActionCard key={i} action={a} />)}
          </div>
        )}

        {!isUser && message.content && !feedbackDone && (
          <div style={{ display: "flex", gap: 6, marginTop: 6 }}>
            <button onClick={() => setFeedbackDone(true)}
              style={{ background: "none", border: "1px solid #e2e8f0", borderRadius: 6, padding: "3px 8px", fontSize: 11, cursor: "pointer", color: "#64748b" }}>
              👍
            </button>
            <button onClick={() => setShowFeedback(!showFeedback)}
              style={{ background: showFeedback ? "#fef3c7" : "none", border: "1px solid #e2e8f0", borderRadius: 6, padding: "3px 8px", fontSize: 11, cursor: "pointer", color: "#64748b" }}>
              🔧 Fix This
            </button>
          </div>
        )}

        {feedbackDone && !showFeedback && (
          <div style={{ fontSize: 10, color: "#16a34a", marginTop: 4 }}>✅ Thanks!</div>
        )}

        {showFeedback && sessionId && (
          <FeedbackPanel
            sessionId={sessionId} prompt={lastUserMessage || ""} actualResult={message.content}
            onClose={() => setShowFeedback(false)}
            onSubmitted={() => { setShowFeedback(false); setFeedbackDone(true); }}
          />
        )}
      </div>
    </div>
  );
}
