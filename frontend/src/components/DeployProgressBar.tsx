import { useEffect, useState } from "react";

const API = import.meta.env.VITE_API_URL || "";

interface ProgressStep {
  name: string;
  status: "pending" | "in_progress" | "completed" | "failed";
}

interface ProgressData {
  fix_id?: string;
  status: string;
  step: number;
  steps: ProgressStep[];
  pr_url?: string;
  mode?: string;
}

const STEP_ICONS: Record<string, string> = {
  pending: "○",
  in_progress: "◉",
  completed: "✓",
  failed: "✗",
};

const STEP_COLORS: Record<string, string> = {
  pending: "#94a3b8",
  in_progress: "#2563eb",
  completed: "#16a34a",
  failed: "#dc2626",
};

function getProgressPercent(steps: ProgressStep[]): number {
  const completed = steps.filter((s) => s.status === "completed").length;
  const inProgress = steps.filter((s) => s.status === "in_progress").length;
  const total = steps.length || 4;
  return Math.round(((completed + inProgress * 0.5) / total) * 100);
}

function getStatusText(status: string): string {
  switch (status) {
    case "completed": return "Fix deployed to VM";
    case "ai_fixing": return "Cursor AI agent is fixing the code...";
    case "failed": return "Fix failed";
    case "queued": return "Queued for batch (7 PM IST)";
    case "creating_issue": return "Creating GitHub issue...";
    case "analyzing": return "Analyzing feedback...";
    default: return "Processing...";
  }
}

export function DeployProgressBar({ feedbackId }: { feedbackId: string }) {
  const [progress, setProgress] = useState<ProgressData | null>(null);
  const [polling, setPolling] = useState(true);
  const [elapsed, setElapsed] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => setElapsed((e) => e + 1), 1000);
    return () => clearInterval(timer);
  }, []);

  useEffect(() => {
    if (!feedbackId || !polling) return;

    const poll = async () => {
      try {
        const res = await fetch(`${API}/api/feedback/progress/${feedbackId}`);
        if (res.ok) {
          const data: ProgressData = await res.json();
          setProgress(data);
          if (data.status === "completed" || data.status === "ai_fixing" || data.status === "failed") {
            setPolling(false);
          }
        }
      } catch {
        /* retry */
      }
    };

    poll();
    const interval = setInterval(poll, 2000);
    return () => clearInterval(interval);
  }, [feedbackId, polling]);

  const steps = progress?.steps?.length
    ? progress.steps
    : [
        { name: "Analyzing", status: (elapsed < 1 ? "in_progress" : "completed") as ProgressStep["status"] },
        { name: "Creating issue", status: (elapsed < 1 ? "pending" : elapsed < 3 ? "in_progress" : "completed") as ProgressStep["status"] },
        { name: "AI fixing code", status: (elapsed < 3 ? "pending" : "in_progress") as ProgressStep["status"] },
        { name: "Auto-deploy", status: "pending" as const },
      ];

  const percent = progress ? getProgressPercent(steps) : Math.min(elapsed * 8, 60);
  const statusText = progress ? getStatusText(progress.status) : (elapsed < 3 ? "Creating GitHub issue..." : "Cursor AI agent is fixing the code...");

  return (
    <div
      style={{
        background: "#f8fafc",
        border: "1px solid #e2e8f0",
        borderRadius: 10,
        padding: 14,
        marginTop: 8,
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 8 }}>
        <div style={{ fontSize: 12, fontWeight: 600, color: "#334155" }}>
          {statusText}
        </div>
        <div style={{ fontSize: 11, color: "#64748b", fontWeight: 500 }}>
          {percent}% · {elapsed}s
        </div>
      </div>

      {/* Progress bar */}
      <div style={{ height: 6, background: "#e2e8f0", borderRadius: 3, marginBottom: 10, overflow: "hidden" }}>
        <div
          style={{
            height: "100%",
            width: `${percent}%`,
            background: progress?.status === "failed" ? "#dc2626" : "linear-gradient(90deg, #2563eb, #16a34a)",
            borderRadius: 3,
            transition: "width 0.8s ease",
          }}
        />
      </div>

      {/* Steps */}
      <div style={{ display: "flex", alignItems: "flex-start", gap: 0 }}>
        {steps.map((step, i) => (
          <div key={i} style={{ display: "flex", alignItems: "center", flex: 1 }}>
            <div style={{ display: "flex", flexDirection: "column", alignItems: "center", minWidth: 50 }}>
              <div
                style={{
                  width: 24,
                  height: 24,
                  borderRadius: "50%",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 12,
                  fontWeight: 700,
                  color: "#fff",
                  background: STEP_COLORS[step.status] || "#94a3b8",
                  transition: "all 0.3s ease",
                  animation: step.status === "in_progress" ? "pulse-step 1.2s ease-in-out infinite" : "none",
                }}
              >
                {STEP_ICONS[step.status] || (i + 1)}
              </div>
              <div
                style={{
                  fontSize: 8,
                  color: STEP_COLORS[step.status] || "#94a3b8",
                  marginTop: 3,
                  textAlign: "center",
                  maxWidth: 60,
                  lineHeight: 1.2,
                  fontWeight: step.status === "in_progress" ? 600 : 400,
                }}
              >
                {step.name}
              </div>
            </div>
            {i < steps.length - 1 && (
              <div
                style={{
                  flex: 1,
                  height: 2,
                  background: step.status === "completed" ? "#16a34a" : "#e2e8f0",
                  marginBottom: 16,
                  transition: "background 0.3s ease",
                }}
              />
            )}
          </div>
        ))}
      </div>

      {progress?.pr_url && (
        <div style={{ marginTop: 8, fontSize: 11, textAlign: "center" }}>
          <a href={progress.pr_url} target="_blank" rel="noopener noreferrer" style={{ color: "#2563eb" }}>
            View on GitHub →
          </a>
        </div>
      )}

      <style>{`@keyframes pulse-step { 0%, 100% { transform: scale(1); opacity: 1; } 50% { transform: scale(1.15); opacity: 0.8; } }`}</style>
    </div>
  );
}
