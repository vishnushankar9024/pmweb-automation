import { useState } from "react";

const API_BASE = import.meta.env.VITE_API_URL || "";

interface Props {
  sessionId: string;
  prompt: string;
  actualResult: string;
  onClose: () => void;
  onSubmitted: () => void;
}

export function FeedbackPanel({
  sessionId,
  prompt,
  actualResult,
  onClose,
  onSubmitted,
}: Props) {
  const [expected, setExpected] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const handleSubmit = async () => {
    if (!expected.trim()) return;
    setSubmitting(true);
    try {
      const form = new FormData();
      form.append("session_id", sessionId);
      form.append("prompt", prompt);
      form.append("actual_result", actualResult);
      form.append("expected_result", expected);
      if (file) form.append("file", file);

      await fetch(`${API_BASE}/api/feedback`, {
        method: "POST",
        body: form,
      });
      onSubmitted();
    } catch {
      alert("Failed to submit feedback");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div
      style={{
        background: "#fffbeb",
        border: "1px solid #fde68a",
        borderRadius: 8,
        padding: 12,
        marginTop: 8,
      }}
    >
      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          marginBottom: 8,
        }}
      >
        <span style={{ fontWeight: 600, fontSize: 13, color: "#92400e" }}>
          What should have happened?
        </span>
        <button
          onClick={onClose}
          style={{
            background: "none",
            border: "none",
            cursor: "pointer",
            color: "#92400e",
            fontSize: 16,
          }}
        >
          x
        </button>
      </div>
      <textarea
        value={expected}
        onChange={(e) => setExpected(e.target.value)}
        placeholder="Describe the expected result..."
        style={{
          width: "100%",
          minHeight: 60,
          padding: 8,
          borderRadius: 6,
          border: "1px solid #fde68a",
          fontSize: 12,
          resize: "vertical",
        }}
      />
      <div
        style={{
          marginTop: 8,
          display: "flex",
          gap: 8,
          alignItems: "center",
        }}
      >
        <label
          style={{
            padding: "4px 10px",
            borderRadius: 6,
            border: "1px solid #fde68a",
            fontSize: 11,
            cursor: "pointer",
            background: "#fff",
          }}
        >
          {file ? file.name : "Attach file"}
          <input
            type="file"
            onChange={(e) => setFile(e.target.files?.[0] || null)}
            style={{ display: "none" }}
          />
        </label>
        <button
          onClick={handleSubmit}
          disabled={submitting || !expected.trim()}
          style={{
            padding: "4px 14px",
            borderRadius: 6,
            border: "none",
            background: submitting ? "#d97706" : "#f59e0b",
            color: "#fff",
            fontSize: 12,
            fontWeight: 600,
            cursor: "pointer",
          }}
        >
          {submitting ? "Submitting..." : "Submit Fix Request"}
        </button>
      </div>
    </div>
  );
}
