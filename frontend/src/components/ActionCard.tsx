import type { ExecutedAction } from "../types";

export function ActionCard({ action }: { action: ExecutedAction }) {
  const hasError = !!action.error;
  const resultText =
    typeof action.result === "string"
      ? action.result
      : action.result
      ? JSON.stringify(action.result, null, 2)
      : "";

  return (
    <div
      style={{
        background: hasError ? "#fef2f2" : "#f0fdf4",
        border: `1px solid ${hasError ? "#fecaca" : "#bbf7d0"}`,
        borderRadius: 8,
        padding: "8px 12px",
        marginTop: 6,
        fontSize: 12,
      }}
    >
      <div style={{ fontWeight: 600, marginBottom: 2 }}>
        <span style={{ color: "#64748b" }}>Step {action.step}:</span>{" "}
        {action.action}
        <span
          style={{
            marginLeft: 8,
            fontSize: 10,
            color: hasError ? "#dc2626" : "#16a34a",
            textTransform: "uppercase",
          }}
        >
          {hasError ? "ERROR" : "OK"}
        </span>
      </div>
      {(resultText || action.error) && (
        <div
          style={{
            fontSize: 11,
            color: hasError ? "#dc2626" : "#475569",
            marginTop: 2,
            wordBreak: "break-word",
          }}
        >
          {hasError ? action.error : resultText}
        </div>
      )}
    </div>
  );
}
