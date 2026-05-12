import { useEffect, useState } from "react";
import { getSessionList, deleteSession } from "../services/api";

interface SidebarProps {
  currentSessionId?: string;
  onSelectSession: (id: string) => void;
  onNewSession: () => void;
}

interface SessionInfo {
  session_id: string;
  updated_at: number;
}

export function Sidebar({
  currentSessionId,
  onSelectSession,
  onNewSession,
}: SidebarProps) {
  const [sessions, setSessions] = useState<SessionInfo[]>([]);
  const [collapsed, setCollapsed] = useState(false);

  const refresh = () => {
    getSessionList()
      .then((list) => {
        const sorted = list
          .map((id: string) => ({ session_id: id, updated_at: 0 }))
          .reverse();
        setSessions(sorted);
      })
      .catch(() => {});
  };

  useEffect(() => {
    refresh();
  }, [currentSessionId]);

  const handleDelete = async (id: string, e: React.MouseEvent) => {
    e.stopPropagation();
    try {
      await deleteSession(id);
      refresh();
      if (id === currentSessionId) onNewSession();
    } catch {
      /* ignore */
    }
  };

  if (collapsed) {
    return (
      <div
        style={{
          width: 48,
          background: "#1e293b",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          paddingTop: 12,
          borderRight: "1px solid #334155",
        }}
      >
        <button
          onClick={() => setCollapsed(false)}
          style={{
            background: "none",
            border: "none",
            color: "#94a3b8",
            fontSize: 20,
            cursor: "pointer",
            padding: 4,
          }}
          title="Expand sidebar"
        >
          ☰
        </button>
      </div>
    );
  }

  return (
    <div
      style={{
        width: 240,
        background: "#1e293b",
        color: "#e2e8f0",
        display: "flex",
        flexDirection: "column",
        borderRight: "1px solid #334155",
        flexShrink: 0,
      }}
    >
      {/* Header */}
      <div
        style={{
          padding: "14px 14px 10px",
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          borderBottom: "1px solid #334155",
        }}
      >
        <span style={{ fontSize: 13, fontWeight: 600 }}>Sessions</span>
        <div style={{ display: "flex", gap: 6 }}>
          <button
            onClick={onNewSession}
            style={{
              background: "#2563eb",
              border: "none",
              color: "#fff",
              borderRadius: 6,
              padding: "4px 10px",
              fontSize: 12,
              cursor: "pointer",
              fontWeight: 500,
            }}
          >
            + New
          </button>
          <button
            onClick={() => setCollapsed(true)}
            style={{
              background: "none",
              border: "none",
              color: "#94a3b8",
              fontSize: 16,
              cursor: "pointer",
              padding: "2px 4px",
            }}
            title="Collapse sidebar"
          >
            ✕
          </button>
        </div>
      </div>

      {/* Session list */}
      <div style={{ flex: 1, overflowY: "auto", padding: "8px 6px" }}>
        {sessions.length === 0 && (
          <p
            style={{
              fontSize: 12,
              color: "#64748b",
              textAlign: "center",
              padding: "16px 8px",
            }}
          >
            No saved sessions
          </p>
        )}
        {sessions.map((s) => (
          <div
            key={s.session_id}
            onClick={() => onSelectSession(s.session_id)}
            style={{
              padding: "8px 10px",
              borderRadius: 6,
              marginBottom: 2,
              cursor: "pointer",
              fontSize: 12,
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
              background:
                s.session_id === currentSessionId
                  ? "#334155"
                  : "transparent",
              color:
                s.session_id === currentSessionId
                  ? "#fff"
                  : "#94a3b8",
              transition: "background 0.15s",
            }}
            onMouseOver={(e) => {
              if (s.session_id !== currentSessionId)
                e.currentTarget.style.background = "#2d3a4d";
            }}
            onMouseOut={(e) => {
              if (s.session_id !== currentSessionId)
                e.currentTarget.style.background = "transparent";
            }}
          >
            <span
              style={{
                overflow: "hidden",
                textOverflow: "ellipsis",
                whiteSpace: "nowrap",
                maxWidth: 170,
              }}
            >
              {s.session_id.slice(0, 8)}…
            </span>
            <button
              onClick={(e) => handleDelete(s.session_id, e)}
              style={{
                background: "none",
                border: "none",
                color: "#64748b",
                cursor: "pointer",
                fontSize: 14,
                padding: "0 2px",
                lineHeight: 1,
              }}
              title="Delete session"
            >
              ×
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
