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
  const [issueUrl, setIssueUrl] = useState<string | null>(null);

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
      if (!tid) return;

      setTicketId(tid);

      const f2 = new FormData();
      f2.append("feedback_id", tid);
      const fixRes = await fetch(API + `/api/feedback/fix-${mode}`, { method: "POST", body: f2 });
      const fixData = await fixRes.json();
      if (fixData.pr_url) setIssueUrl(fixData.pr_url);
    } catch {
      /* progress bar handles display */
    } finally {
      setBusy(false);
    }
  };

  const isSubmitted = !!ticketId;

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
        <b style={{ fontSize: 13, color: "#92400e" }}>
          {isSubmitted ? (fixMode === "later" ? "Queued for Fix Later" : "Fix in Progress") : "What should have happened?"}
        </b>
        <button
          onClick={() => { if (isSubmitted) onSubmitted(); else onClose(); }}
          style={{ background: "none", border: "none", cursor: "pointer", color: "#92400e" }}
        >
          ✕
        </button>
      </div>

      {!isSubmitted && (
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
              {busy && fixMode === "now" ? "Submitting..." : "🚀 Fix Now"}
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
              {busy && fixMode === "later" ? "Queuing..." : "📋 Fix Later"}
            </button>
          </div>
        </>
      )}

      {isSubmitted && (
        <>
          <DeployProgressBar feedbackId={ticketId} />

          <div style={{ fontSize: 12, color: "#334155", marginTop: 10 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 6, marginBottom: 6 }}>
              <span style={{ fontSize: 14 }}>🤖</span>
              <span>
                {fixMode === "later"
                  ? "Queued — will be processed at 7 PM IST."
                  : "Cursor AI agent will fix the code, open a PR, and auto-deploy."}
              </span>
            </div>
            {issueUrl && (
              <a href={issueUrl} target="_blank" rel="noopener noreferrer" style={{ color: "#2563eb", fontSize: 11 }}>
                Track on GitHub →
              </a>
            )}
            <div style={{ marginTop: 8 }}>
              <button
                onClick={onSubmitted}
                style={{
                  padding: "4px 12px",
                  borderRadius: 6,
                  border: "1px solid #e2e8f0",
                  background: "#fff",
                  fontSize: 11,
                  cursor: "pointer",
                  color: "#64748b",
                }}
              >
                Dismiss
              </button>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
