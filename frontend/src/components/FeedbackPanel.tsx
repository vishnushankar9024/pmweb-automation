import { useState } from "react";
import { submitFeedback } from "../services/api";

interface FeedbackPanelProps {
  sessionId?: string;
  messageIndex: number;
  actionName?: string;
}

export function FeedbackPanel({
  sessionId,
  messageIndex,
  actionName,
}: FeedbackPanelProps) {
  const [rating, setRating] = useState<number | null>(null);
  const [comment, setComment] = useState("");
  const [submitted, setSubmitted] = useState(false);
  const [showComment, setShowComment] = useState(false);

  const handleSubmit = async (value: number) => {
    setRating(value);
    try {
      await submitFeedback({
        session_id: sessionId || "",
        message_index: messageIndex,
        rating: value,
        comment,
        action_name: actionName || "",
      });
      setSubmitted(true);
    } catch {
      /* ignore */
    }
  };

  if (submitted) {
    return (
      <div
        style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 4,
          fontSize: 11,
          color: "#64748b",
          marginTop: 4,
        }}
      >
        <span>{rating === 1 ? "👍" : "👎"}</span>
        <span>Thanks for your feedback!</span>
      </div>
    );
  }

  return (
    <div style={{ marginTop: 6 }}>
      <div
        style={{
          display: "inline-flex",
          gap: 4,
          alignItems: "center",
        }}
      >
        <button
          onClick={() => handleSubmit(1)}
          style={{
            background: "none",
            border: "1px solid #e2e8f0",
            borderRadius: 4,
            padding: "2px 6px",
            cursor: "pointer",
            fontSize: 14,
            lineHeight: 1,
          }}
          title="Helpful"
        >
          👍
        </button>
        <button
          onClick={() => {
            setShowComment(true);
            setRating(-1);
          }}
          style={{
            background: "none",
            border: "1px solid #e2e8f0",
            borderRadius: 4,
            padding: "2px 6px",
            cursor: "pointer",
            fontSize: 14,
            lineHeight: 1,
          }}
          title="Not helpful"
        >
          👎
        </button>
      </div>

      {showComment && (
        <div style={{ marginTop: 6, display: "flex", gap: 4 }}>
          <input
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            placeholder="What went wrong?"
            style={{
              flex: 1,
              padding: "4px 8px",
              borderRadius: 4,
              border: "1px solid #cbd5e1",
              fontSize: 11,
              outline: "none",
            }}
            onKeyDown={(e) => {
              if (e.key === "Enter") handleSubmit(-1);
            }}
          />
          <button
            onClick={() => handleSubmit(-1)}
            style={{
              padding: "4px 10px",
              borderRadius: 4,
              border: "none",
              background: "#2563eb",
              color: "#fff",
              fontSize: 11,
              cursor: "pointer",
            }}
          >
            Send
          </button>
        </div>
      )}
    </div>
  );
}
