import type { ExecutedAction } from "../types";

const TOOL_LABELS: Record<string, string> = {
  create_security_group: "Security Group Created",
  create_user: "User Created",
  set_user_access: "User Access Updated",
  set_password_policy: "Password Policy Updated",
  create_workflow: "Workflow Created",
  create_form: "Form Created",
};

const TOOL_ICONS: Record<string, string> = {
  create_security_group: "🔒",
  create_user: "👤",
  set_user_access: "🔑",
  set_password_policy: "🛡️",
  create_workflow: "🔄",
  create_form: "📋",
};

export function ActionCard({ action }: { action: ExecutedAction }) {
  const label = TOOL_LABELS[action.tool] || action.tool;
  const icon = TOOL_ICONS[action.tool] || "⚡";
  const isSuccess = action.result.status === "created" || action.result.status === "updated";

  return (
    <div
      style={{
        background: isSuccess ? "#f0fdf4" : "#fef2f2",
        border: `1px solid ${isSuccess ? "#bbf7d0" : "#fecaca"}`,
        borderRadius: 8,
        padding: "10px 14px",
        marginTop: 8,
        fontSize: 13,
      }}
    >
      <div style={{ fontWeight: 600, marginBottom: 4 }}>
        {icon} {label}
        <span
          style={{
            marginLeft: 8,
            fontSize: 11,
            color: isSuccess ? "#16a34a" : "#dc2626",
            textTransform: "uppercase",
          }}
        >
          {action.result.status}
        </span>
      </div>
      <pre
        style={{
          margin: 0,
          fontSize: 11,
          color: "#475569",
          whiteSpace: "pre-wrap",
          wordBreak: "break-word",
        }}
      >
        {JSON.stringify(action.args, null, 2)}
      </pre>
    </div>
  );
}
