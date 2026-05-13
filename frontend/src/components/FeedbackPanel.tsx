import { useState } from "react";
const API = import.meta.env.VITE_API_URL || "";
export function FeedbackPanel({ sessionId, prompt, actualResult, onClose, onSubmitted }: { sessionId: string; prompt: string; actualResult: string; onClose: () => void; onSubmitted: () => void; }) {
  const [expected, setExpected] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [busy, setBusy] = useState(false);
  const submit = async (mode: string) => {
    if (!expected.trim()) return;
    setBusy(true);
    const form = new FormData();
    form.append("session_id", sessionId); form.append("prompt", prompt);
    form.append("actual_result", actualResult); form.append("expected_result", expected);
    if (file) form.append("file", file);
    const r = await fetch(API + "/api/feedback", { method: "POST", body: form });
    const data = await r.json();
    if (mode === "now" && data.ticket_id) { const f2 = new FormData(); f2.append("feedback_id", data.ticket_id); await fetch(API + "/api/feedback/fix-now", { method: "POST", body: f2 }); }
    if (mode === "later" && data.ticket_id) { const f2 = new FormData(); f2.append("feedback_id", data.ticket_id); await fetch(API + "/api/feedback/fix-later", { method: "POST", body: f2 }); }
    setBusy(false); onSubmitted();
  };
  return (
    <div style={{ background: "#fffbeb", border: "1px solid #fde68a", borderRadius: 8, padding: 12, marginTop: 8 }}>
      <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 8 }}>
        <b style={{ fontSize: 13, color: "#92400e" }}>What should have happened?</b>
        <button onClick={onClose} style={{ background: "none", border: "none", cursor: "pointer", color: "#92400e" }}>x</button>
      </div>
      <textarea value={expected} onChange={e => setExpected(e.target.value)} placeholder="Describe expected result..." style={{ width: "100%", minHeight: 50, padding: 6, borderRadius: 6, border: "1px solid #fde68a", fontSize: 12 }} />
      <div style={{ marginTop: 8, display: "flex", gap: 8, flexWrap: "wrap" }}>
        <label style={{ padding: "4px 10px", borderRadius: 6, border: "1px solid #fde68a", fontSize: 11, cursor: "pointer" }}>{file ? file.name : "📎 Attach"}<input type="file" onChange={e => setFile(e.target.files?.[0]||null)} style={{ display: "none" }} /></label>
        <button onClick={() => submit("now")} disabled={busy||!expected.trim()} style={{ padding: "4px 12px", borderRadius: 6, border: "none", background: "#dc2626", color: "#fff", fontSize: 12, cursor: "pointer" }}>🚀 Fix Now</button>
        <button onClick={() => submit("later")} disabled={busy||!expected.trim()} style={{ padding: "4px 12px", borderRadius: 6, border: "1px solid #f59e0b", background: "#fff", color: "#f59e0b", fontSize: 12, cursor: "pointer" }}>📋 Fix Later</button>
      </div>
    </div>
  );
}
