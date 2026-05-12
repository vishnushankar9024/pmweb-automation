import { useEffect, useState } from "react";

const API_BASE = import.meta.env.VITE_API_URL || "";

interface Props {
  sessionId: string;
  prompt: string;
  actualResult: string;
  onClose: () => void;
  onSubmitted: () => void;
}

interface ProgressData {
  step: number;
  step_label: string;
  progress_pct: number;
  status: string;
  pr_url?: string;
  done: boolean;
  steps: { step: number; label: string; done: boolean }[];
}

export function FeedbackPanel({
  sessionId, prompt, actualResult, onClose, onSubmitted,
}: Props) {
  const [expected, setExpected] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [feedbackId, setFeedbackId] = useState<string | null>(null);
  const [fixing, setFixing] = useState(false);
  const [progress, setProgress] = useState<ProgressData | null>(null);

  useEffect(() => {
    if (!feedbackId || !fixing) return;
    const interval = setInterval(async () => {
      try {
        const r = await fetch(`${API_BASE}/api/feedback/progress/${feedbackId}`);
        const data = await r.json();
        setProgress(data);
        if (data.done) {
          clearInterval(interval);
          setFixing(false);
        }
      } catch { /* ignore */ }
    }, 5000);
    return () => clearInterval(interval);
  }, [feedbackId, fixing]);

  const submitFeedback = async (): Promise<string | null> => {
    const form = new FormData();
    form.append("session_id", sessionId);
    form.append("prompt", prompt);
    form.append("actual_result", actualResult);
    form.append("expected_result", expected);
    if (file) form.append("file", file);
    const r = await fetch(`${API_BASE}/api/feedback`, { method: "POST", body: form });
    const data = await r.json();
    return data.ticket_id || null;
  };

  const handleFixNow = async () => {
    if (!expected.trim()) return;
    setSubmitting(true);
    try {
      const ticketId = await submitFeedback();
      if (!ticketId) return;
      setFeedbackId(ticketId);
      const form = new FormData();
      form.append("feedback_id", ticketId);
      await fetch(`${API_BASE}/api/feedback/fix-now`, { method: "POST", body: form });
      setFixing(true);
      setProgress({ step: 1, step_label: "Diagnosing...", progress_pct: 20, status: "fixing", done: false, steps: [
        { step: 1, label: "Diagnosing the issue", done: true },
        { step: 2, label: "Agent on duty is fixing", done: false },
        { step: 3, label: "Deploying to server", done: false },
        { step: 4, label: "Verifying the fix", done: false },
      ]});
    } catch { alert("Failed to submit"); }
    finally { setSubmitting(false); }
  };

  const handleFixLater = async () => {
    if (!expected.trim()) return;
    setSubmitting(true);
    try {
      const ticketId = await submitFeedback();
      if (!ticketId) return;
      const form = new FormData();
      form.append("feedback_id", ticketId);
      await fetch(`${API_BASE}/api/feedback/fix-later`, { method: "POST", body: form });
      onSubmitted();
    } catch { alert("Failed"); }
    finally { setSubmitting(false); }
  };

  if (fixing && progress) {
    return (
      <div style={{ background: "#f8fafc", border: "1px solid #e2e8f0", borderRadius: 8, padding: 16, marginTop: 8 }}>
        <div style={{ fontWeight: 600, fontSize: 13, marginBottom: 12, color: "#1e293b" }}>
          🔧 Fix in progress
        </div>
        {/* Progress bar */}
        <div style={{ background: "#e2e8f0", borderRadius: 4, height: 6, marginBottom: 12, overflow: "hidden" }}>
          <div style={{
            width: `${progress.progress_pct}%`,
            height: "100%",
            background: progress.done ? "#16a34a" : "#2563eb",
            borderRadius: 4,
            transition: "width 0.5s ease",
          }} />
        </div>
        {/* Steps */}
        {progress.steps.map((s) => (
          <div key={s.step} style={{ fontSize: 12, color: s.done ? "#16a34a" : "#94a3b8", marginBottom: 4, display: "flex", gap: 6 }}>
            <span>{s.done ? "✅" : "⏳"}</span>
            <span>{s.label}</span>
          </div>
        ))}
        <div style={{ fontSize: 12, color: "#475569", marginTop: 8, fontWeight: 500 }}>
          {progress.step_label}
        </div>
        {progress.pr_url && (
          <a href={progress.pr_url} target="_blank" style={{ fontSize: 11, color: "#2563eb", marginTop: 4, display: "block" }}>
            View PR →
          </a>
        )}
        {progress.done && (
          <button onClick={onSubmitted} style={{ marginTop: 8, padding: "6px 14px", borderRadius: 6, border: "none", background: "#16a34a", color: "#fff", fontSize: 12, cursor: "pointer" }}>
            Done
          </button>
        )}
      </div>
    );
  }

  return (
    <div style={{ background: "#fffbeb", border: "1px solid #fde68a", borderRadius: 8, padding: 12, marginTop: 8 }}>
      <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 8 }}>
        <span style={{ fontWeight: 600, fontSize: 13, color: "#92400e" }}>What should have happened?</span>
        <button onClick={onClose} style={{ background: "none", border: "none", cursor: "pointer", color: "#92400e", fontSize: 16 }}>x</button>
      </div>
      <textarea
        value={expected}
        onChange={(e) => setExpected(e.target.value)}
        placeholder="Describe the expected result..."
        style={{ width: "100%", minHeight: 60, padding: 8, borderRadius: 6, border: "1px solid #fde68a", fontSize: 12, resize: "vertical" }}
      />
      <div style={{ marginTop: 8, display: "flex", gap: 8, alignItems: "center", flexWrap: "wrap" }}>
        <label style={{ padding: "4px 10px", borderRadius: 6, border: "1px solid #fde68a", fontSize: 11, cursor: "pointer", background: "#fff" }}>
          {file ? file.name : "📎 Attach file"}
          <input type="file" onChange={(e) => setFile(e.target.files?.[0] || null)} style={{ display: "none" }} />
        </label>
        <button
          onClick={handleFixNow}
          disabled={submitting || !expected.trim()}
          style={{ padding: "6px 14px", borderRadius: 6, border: "none", background: "#dc2626", color: "#fff", fontSize: 12, fontWeight: 600, cursor: "pointer" }}
        >
          {submitting ? "..." : "🚀 Fix Now"}
        </button>
        <button
          onClick={handleFixLater}
          disabled={submitting || !expected.trim()}
          style={{ padding: "6px 14px", borderRadius: 6, border: "1px solid #f59e0b", background: "#fff", color: "#f59e0b", fontSize: 12, fontWeight: 600, cursor: "pointer" }}
        >
          📋 Fix Later
        </button>
      </div>
    </div>
  );
}
