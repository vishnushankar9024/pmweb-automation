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

const STEP_TIMES = ["~5s", "~10s", "~3 min", "~5 min"];

function getProgressPercent(steps: ProgressStep[]): number {
  const completed = steps.filter((s) => s.status === "completed").length;
  const inProgress = steps.filter((s) => s.status === "in_progress").length;
  const total = steps.length || 4;
  return Math.round(((completed + inProgress * 0.5) / total) * 100);
}

function getEta(steps: ProgressStep[]): string {
  const currentIdx = steps.findIndex((s) => s.status === "in_progress");
  if (currentIdx === -1) {
    const allDone = steps.every((s) => s.status === "completed");
    return allDone ? "Done!" : "Waiting...";
  }
  const remaining = steps.slice(currentIdx).filter((s) => s.status !== "completed");
  if (remaining.length <= 1) return "Almost done...";
  if (currentIdx <= 1) return "~4 min remaining";
  return "~2 min remaining";
}

export function DeployProgressBar({
  feedbackId,
  onComplete,
}: {
  feedbackId: string;
  onComplete?: (prUrl?: string) => void;
}) {
  const [progress, setProgress] = useState<ProgressData | null>(null);
  const [polling, setPolling] = useState(true);

  useEffect(() => {
    if (!feedbackId || !polling) return;

    const poll = async () => {
      try {
        const res = await fetch(`${API}/api/feedback/progress/${feedbackId}`);
        if (res.ok) {
          const data: ProgressData = await res.json();
          setProgress(data);
          if (data.status === "completed" || data.status === "ai_fixing" || data.status === "failed" || data.status === "not_found") {
            setPolling(false);
            onComplete?.(data.pr_url ?? undefined);
          }
        }
      } catch {
        /* retry next interval */
      }
    };

    poll();
    const interval = setInterval(poll, 1500);
    return () => clearInterval(interval);
  }, [feedbackId, polling, onComplete]);

  if (!progress || progress.status === "not_found") return null;

  const steps = progress.steps?.length
    ? progress.steps
    : [
        { name: "Analyzing", status: "pending" as const },
        { name: "Creating issue", status: "pending" as const },
        { name: "AI fixing code", status: "pending" as const },
        { name: "Auto-deploy", status: "pending" as const },
      ];

  const percent = getProgressPercent(steps);
  const eta = getEta(steps);

  const statusText =
    progress.status === "completed"
      ? "Fix deployed to VM"
      : progress.status === "ai_fixing"
      ? "Cursor AI agent is fixing the code..."
      : progress.status === "failed"
      ? "Fix failed"
      : progress.status === "queued"
      ? "Queued for batch (7 PM IST)"
      : progress.status === "creating_issue"
      ? "Creating GitHub issue..."
      : "Processing fix...";

  return (
    <div
      style={{
        background: "#f8fafc",
        border: "1px solid #e2e8f0",
        borderRadius: 10,
        padding: 14,
        marginTop: 10,
      }}
    >
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 8 }}>
        <div style={{ fontSize: 12, fontWeight: 600, color: "#334155" }}>
          {statusText}
        </div>
        <div style={{ fontSize: 11, color: "#64748b", fontWeight: 500 }}>
          {percent}%
        </div>
      </div>

      {/* Overall progress bar */}
      <div style={{ height: 6, background: "#e2e8f0", borderRadius: 3, marginBottom: 10, overflow: "hidden" }}>
        <div
          style={{
            height: "100%",
            width: `${percent}%`,
            background: progress.status === "failed" ? "#dc2626" : "linear-gradient(90deg, #2563eb, #16a34a)",
            borderRadius: 3,
            transition: "width 0.5s ease",
          }}
        />
      </div>

      {/* Step indicators */}
      <div style={{ display: "flex", alignItems: "center", gap: 0 }}>
        {steps.map((step, i) => (
          <div key={i} style={{ display: "flex", alignItems: "center", flex: 1 }}>
            <div style={{ display: "flex", flexDirection: "column", alignItems: "center", minWidth: 50 }}>
              <div
                style={{
                  width: 26,
                  height: 26,
                  borderRadius: "50%",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 13,
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
                  maxWidth: 65,
                  lineHeight: 1.2,
                  fontWeight: step.status === "in_progress" ? 600 : 400,
                }}
              >
                {step.name}
              </div>
              <div style={{ fontSize: 7, color: "#94a3b8", marginTop: 1 }}>
                {step.status === "in_progress" ? STEP_TIMES[i] || "" : ""}
              </div>
            </div>
            {i < steps.length - 1 && (
              <div
                style={{
                  flex: 1,
                  height: 2,
                  background: step.status === "completed" ? "#16a34a" : "#e2e8f0",
                  marginBottom: 22,
                  transition: "background 0.3s ease",
                }}
              />
            )}
          </div>
        ))}
      </div>

      {/* ETA */}
      <div style={{ textAlign: "center", fontSize: 10, color: "#94a3b8", marginTop: 6 }}>
        {eta}
      </div>

      {progress.pr_url && (
        <div style={{ marginTop: 8, fontSize: 11, textAlign: "center" }}>
          <a
            href={progress.pr_url}
            target="_blank"
            rel="noopener noreferrer"
            style={{ color: "#2563eb", textDecoration: "underline" }}
          >
            View on GitHub →
          </a>
        </div>
      )}

      <style>{`@keyframes pulse-step { 0%, 100% { transform: scale(1); opacity: 1; } 50% { transform: scale(1.15); opacity: 0.8; } }`}</style>
    </div>
  );
}
