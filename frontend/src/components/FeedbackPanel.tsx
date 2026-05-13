import { useState } from "react";
import { DeployProgressBar } from "./DeployProgressBar";

const API = import.meta.env.VITE_API_URL || "";

export function FeedbackPanel({
  sessionId,
  prompt,
  actualResult,
  onClose,
  onSubmitted,
}: {
  sessionId: string;
  prompt: string;
  actualResult: string;
  onClose: () => void;
  onSubmitted: () => void;
}) {
  const [expected, setExpected] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [busy, setBusy] = useState(false);
  const [ticketId, setTicketId] = useState<string | null>(null);
  const [fixMode, setFixMode] = useState<"now" | "later" | null>(null);
  const [prUrl, setPrUrl] = useState<string | null>(null);

  const submit = async (mode: "now" | "later") => {
    if (!expected.trim()) return;
    setBusy(true);
    setFixMode(mode);

    const form = new FormData();
    form.append("session_id", sessionId);
    form.append("prompt", prompt);
    form.append("actual_result", actualResult);
    form.append("expected_result", expected);
    if (file) form.append("file", file);

    try {
      const r = await fetch(API + "/api/feedback", { method: "POST", body: form });
      const data = await r.json();
      const tid = data.ticket_id;

      if (tid) {
        setTicketId(tid);
        const f2 = new FormData();
        f2.append("feedback_id", tid);
        await fetch(API + `/api/feedback/fix-${mode}`, { method: "POST", body: f2 });
      }
    } catch {
      /* handled by progress bar */
    } finally {
      setBusy(false);
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
      <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 8 }}>
        <b style={{ fontSize: 13, color: "#92400e" }}>What should have happened?</b>
        <button
          onClick={onClose}
          style={{ background: "none", border: "none", cursor: "pointer", color: "#92400e" }}
        >
          ✕
        </button>
      </div>

      {!ticketId && (
        <>
          <textarea
            value={expected}
            onChange={(e) => setExpected(e.target.value)}
            placeholder="Describe expected result..."
            style={{
              width: "100%",
              minHeight: 50,
              padding: 6,
              borderRadius: 6,
              border: "1px solid #fde68a",
              fontSize: 12,
              resize: "vertical",
            }}
          />
          <div style={{ marginTop: 8, display: "flex", gap: 8, flexWrap: "wrap" }}>
            <label
              style={{
                padding: "4px 10px",
                borderRadius: 6,
                border: "1px solid #fde68a",
                fontSize: 11,
                cursor: "pointer",
              }}
            >
              {file ? file.name : "📎 Attach"}
              <input
                type="file"
                onChange={(e) => setFile(e.target.files?.[0] || null)}
                style={{ display: "none" }}
              />
            </label>
            <button
              onClick={() => submit("now")}
              disabled={busy || !expected.trim()}
              style={{
                padding: "4px 12px",
                borderRadius: 6,
                border: "none",
                background: "#dc2626",
                color: "#fff",
                fontSize: 12,
                cursor: "pointer",
                opacity: busy || !expected.trim() ? 0.5 : 1,
              }}
            >
              🚀 Fix Now
            </button>
            <button
              onClick={() => submit("later")}
              disabled={busy || !expected.trim()}
              style={{
                padding: "4px 12px",
                borderRadius: 6,
                border: "1px solid #f59e0b",
                background: "#fff",
                color: "#f59e0b",
                fontSize: 12,
                cursor: "pointer",
                opacity: busy || !expected.trim() ? 0.5 : 1,
              }}
            >
              📋 Fix Later
            </button>
          </div>
        </>
      )}

      {ticketId && (
        <DeployProgressBar
          feedbackId={ticketId}
          onComplete={(url) => {
            if (url) setPrUrl(url);
            setTimeout(() => onSubmitted(), 3000);
          }}
        />
      )}

      {prUrl && (
        <div style={{ marginTop: 8, fontSize: 11, color: "#16a34a" }}>
          ✅ Fix submitted!{" "}
          <a href={prUrl} target="_blank" rel="noopener noreferrer" style={{ color: "#2563eb" }}>
            View on GitHub →
          </a>
        </div>
      )}
    </div>
  );
}
