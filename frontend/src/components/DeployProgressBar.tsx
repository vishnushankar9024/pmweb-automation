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
        { name: "Triggering deploy", status: "pending" as const },
        { name: "Deploying to VM", status: "pending" as const },
      ];

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
      <div style={{ fontSize: 12, fontWeight: 600, color: "#334155", marginBottom: 10 }}>
        {progress.status === "completed"
          ? "Fix deployed to VM"
          : progress.status === "ai_fixing"
          ? "Cursor AI agent is fixing the code..."
          : progress.status === "failed"
          ? "Fix failed"
          : progress.status === "queued"
          ? "Queued for batch (7 PM IST)"
          : progress.status === "creating_issue"
          ? "Creating GitHub issue..."
          : "Processing fix..."}
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: 0 }}>
        {steps.map((step, i) => (
          <div key={i} style={{ display: "flex", alignItems: "center", flex: 1 }}>
            <div style={{ display: "flex", flexDirection: "column", alignItems: "center", minWidth: 50 }}>
              <div
                style={{
                  width: 28,
                  height: 28,
                  borderRadius: "50%",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 14,
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
                  fontSize: 9,
                  color: STEP_COLORS[step.status] || "#94a3b8",
                  marginTop: 4,
                  textAlign: "center",
                  maxWidth: 70,
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
                  marginBottom: 18,
                  transition: "background 0.3s ease",
                }}
              />
            )}
          </div>
        ))}
      </div>

      {progress.pr_url && (
        <div style={{ marginTop: 10, fontSize: 11 }}>
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
