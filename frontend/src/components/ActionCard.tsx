const ACTION_ICONS: Record<string, string> = {
  navigate: "🌐",
  switch_to_iframe: "🖼️",
  switch_to_main: "🖼️",
  click_tab: "📑",
  click_button: "👆",
  fill_textbox: "✏️",
  check_option: "☑️",
  click_module_permission: "🔑",
  click_save: "💾",
  click_new_line: "➕",
  fill_cell: "✏️",
  fill_cell_dropdown: "📋",
  read_page_text: "📖",
  read_groups: "🔒",
  read_users: "👥",
  open_adaptive_form_builder: "📝",
  set_form_title: "📝",
  add_form_field: "📝",
  save_adaptive_form: "💾",
  click_bpm_tab: "🔄",
  create_new_bpm: "🔄",
  save_bpm: "💾",
  wait: "⏳",
  STOPPED: "🛑",
};

export function ActionCard({ action }: { action: Record<string, unknown> }) {
  const actionName = (action.action as string) || (action.tool as string) || "unknown";
  const step = action.step as number | undefined;
  const result = action.result as string | Record<string, unknown> | undefined;
  const error = action.error as string | undefined;
  const args = action.args as Record<string, unknown> | undefined;

  const hasError = !!error;
  const icon = ACTION_ICONS[actionName] || "⚡";

  const resultText = error
    ? error
    : typeof result === "string"
    ? result
    : result
    ? JSON.stringify(result, null, 2)
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
      <div style={{ fontWeight: 600, marginBottom: 2, display: "flex", alignItems: "center", gap: 6 }}>
        <span>{icon}</span>
        <span>
          {step ? `Step ${step}: ` : ""}
          {actionName.replace(/_/g, " ")}
        </span>
        <span
          style={{
            fontSize: 10,
            color: hasError ? "#dc2626" : "#16a34a",
            textTransform: "uppercase",
            marginLeft: "auto",
          }}
        >
          {hasError ? "ERROR" : "OK"}
        </span>
      </div>
      {resultText && (
        <pre
          style={{
            margin: 0,
            fontSize: 10,
            color: hasError ? "#991b1b" : "#475569",
            whiteSpace: "pre-wrap",
            wordBreak: "break-word",
          }}
        >
          {resultText}
        </pre>
      )}
      {args && (
        <pre
          style={{
            margin: "2px 0 0",
            fontSize: 10,
            color: "#94a3b8",
            whiteSpace: "pre-wrap",
            wordBreak: "break-word",
          }}
        >
          {JSON.stringify(args, null, 2)}
        </pre>
      )}
    </div>
  );
}
