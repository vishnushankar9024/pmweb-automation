import { useEffect, useState } from "react";
import type { SessionSummary } from "../services/api";
import { listSessions, deleteSession } from "../services/api";

interface Props {
  activeSessionId: string | null;
  onSelectSession: (id: string) => void;
  onNewChat: () => void;
}

export function Sidebar({
  activeSessionId,
  onSelectSession,
  onNewChat,
}: Props) {
  const [sessions, setSessions] = useState<SessionSummary[]>([]);

  const load = () => {
    listSessions().then(setSessions).catch(() => {});
  };

  useEffect(() => {
    load();
  }, [activeSessionId]);

  const handleDelete = async (
    e: React.MouseEvent,
    id: string
  ) => {
    e.stopPropagation();
    await deleteSession(id);
    load();
    if (id === activeSessionId) onNewChat();
  };

  const formatDate = (iso: string) => {
    const d = new Date(iso);
    const now = new Date();
    const diff = now.getTime() - d.getTime();
    if (diff < 60000) return "Just now";
    if (diff < 3600000) return `${Math.floor(diff / 60000)}m ago`;
    if (diff < 86400000) return `${Math.floor(diff / 3600000)}h ago`;
    return d.toLocaleDateString();
  };

  return (
    <div
      style={{
        width: 260,
        background: "#1a1a2e",
        color: "#e2e8f0",
        display: "flex",
        flexDirection: "column",
        height: "100vh",
        flexShrink: 0,
      }}
    >
      {/* New Chat Button */}
      <div style={{ padding: 12 }}>
        <button
          onClick={onNewChat}
          style={{
            width: "100%",
            padding: "10px 16px",
            borderRadius: 8,
            border: "1px solid #334155",
            background: "transparent",
            color: "#e2e8f0",
            fontSize: 13,
            cursor: "pointer",
            display: "flex",
            alignItems: "center",
            gap: 8,
          }}
        >
          + New Chat
        </button>
      </div>

      {/* Session List */}
      <div
        style={{
          flex: 1,
          overflowY: "auto",
          padding: "0 8px",
        }}
      >
        {sessions.map((s) => (
          <div
            key={s.id}
            onClick={() => onSelectSession(s.id)}
            style={{
              padding: "10px 12px",
              borderRadius: 8,
              cursor: "pointer",
              background:
                s.id === activeSessionId
                  ? "#334155"
                  : "transparent",
              marginBottom: 2,
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
              transition: "background 0.15s",
            }}
            onMouseOver={(e) => {
              if (s.id !== activeSessionId)
                e.currentTarget.style.background = "#1e293b";
            }}
            onMouseOut={(e) => {
              if (s.id !== activeSessionId)
                e.currentTarget.style.background = "transparent";
            }}
          >
            <div style={{ overflow: "hidden", flex: 1 }}>
              <div
                style={{
                  fontSize: 13,
                  whiteSpace: "nowrap",
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                }}
              >
                {s.title}
              </div>
              <div
                style={{
                  fontSize: 10,
                  color: "#64748b",
                  marginTop: 2,
                }}
              >
                {formatDate(s.updated_at)}
              </div>
            </div>
            <button
              onClick={(e) => handleDelete(e, s.id)}
              style={{
                background: "none",
                border: "none",
                color: "#64748b",
                cursor: "pointer",
                fontSize: 14,
                padding: "2px 6px",
                borderRadius: 4,
                flexShrink: 0,
              }}
              title="Delete"
            >
              x
            </button>
          </div>
        ))}
      </div>

      {/* Footer */}
      <div
        style={{
          padding: "12px 16px",
          borderTop: "1px solid #334155",
          fontSize: 11,
          color: "#64748b",
        }}
      >
        PMWeb Automation Agent
      </div>
    </div>
  );
}
