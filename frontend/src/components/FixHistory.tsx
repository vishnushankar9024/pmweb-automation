import { useEffect, useState } from "react";

const API = import.meta.env.VITE_API_URL || "";

interface FixEntry {
  fix_id: string;
  feedback_id: string;
  mode: "now" | "later";
  status: string;
  steps: { name: string; status: string }[];
  pr_url?: string;
  created_at: string;
}

const STATUS_BADGES: Record<string, { bg: string; color: string; label: string }> = {
  completed: { bg: "#dcfce7", color: "#166534", label: "Deployed" },
  ai_fixing: { bg: "#dbeafe", color: "#1e40af", label: "AI Fixing" },
  queued: { bg: "#fef3c7", color: "#92400e", label: "Queued" },
  creating_issue: { bg: "#e0e7ff", color: "#3730a3", label: "Creating Issue" },
  analyzing: { bg: "#f1f5f9", color: "#475569", label: "Analyzing" },
  failed: { bg: "#fee2e2", color: "#991b1b", label: "Failed" },
};

export function FixHistory({ onClose }: { onClose: () => void }) {
  const [history, setHistory] = useState<FixEntry[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API}/api/feedback/history`)
      .then((r) => r.json())
      .then((data) => {
        setHistory(data);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  return (
    <div
      style={{
        position: "fixed",
        top: 0,
        right: 0,
        width: 360,
        height: "100vh",
        background: "#fff",
        borderLeft: "1px solid #e2e8f0",
        boxShadow: "-4px 0 12px rgba(0,0,0,0.08)",
        zIndex: 100,
        display: "flex",
        flexDirection: "column",
      }}
    >
      <div style={{ padding: "14px 16px", borderBottom: "1px solid #e2e8f0", display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <h3 style={{ margin: 0, fontSize: 14, color: "#1e293b" }}>Fix History</h3>
        <button onClick={onClose} style={{ background: "none", border: "none", cursor: "pointer", fontSize: 16, color: "#64748b" }}>✕</button>
      </div>

      <div style={{ flex: 1, overflowY: "auto", padding: 12 }}>
        {loading && <div style={{ textAlign: "center", color: "#94a3b8", fontSize: 12, padding: 20 }}>Loading...</div>}

        {!loading && history.length === 0 && (
          <div style={{ textAlign: "center", color: "#94a3b8", fontSize: 12, padding: 20 }}>No fix requests yet</div>
        )}

        {history.map((entry) => {
          const badge = STATUS_BADGES[entry.status] || { bg: "#f1f5f9", color: "#475569", label: entry.status };
          const date = new Date(entry.created_at);
          const timeStr = date.toLocaleString(undefined, { month: "short", day: "numeric", hour: "2-digit", minute: "2-digit" });

          return (
            <div
              key={entry.fix_id}
              style={{
                border: "1px solid #e2e8f0",
                borderRadius: 8,
                padding: 10,
                marginBottom: 8,
                fontSize: 11,
              }}
            >
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 6 }}>
                <span
                  style={{
                    padding: "2px 8px",
                    borderRadius: 10,
                    background: badge.bg,
                    color: badge.color,
                    fontSize: 10,
                    fontWeight: 600,
                  }}
                >
                  {badge.label}
                </span>
                <span style={{ color: "#94a3b8", fontSize: 10 }}>{timeStr}</span>
              </div>

              <div style={{ display: "flex", gap: 4, marginBottom: 6 }}>
                {entry.steps.map((step, i) => (
                  <div
                    key={i}
                    title={step.name}
                    style={{
                      flex: 1,
                      height: 4,
                      borderRadius: 2,
                      background:
                        step.status === "completed" ? "#16a34a" :
                        step.status === "in_progress" ? "#2563eb" :
                        step.status === "failed" ? "#dc2626" : "#e2e8f0",
                    }}
                  />
                ))}
              </div>

              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <span style={{ color: "#64748b" }}>
                  {entry.mode === "now" ? "🚀 Fix Now" : "📋 Fix Later"}
                </span>
                {entry.pr_url && (
                  <a href={entry.pr_url} target="_blank" rel="noopener noreferrer" style={{ color: "#2563eb", fontSize: 10 }}>
                    GitHub →
                  </a>
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
