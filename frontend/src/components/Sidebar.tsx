import { useEffect, useState } from "react";
const API = import.meta.env.VITE_API_URL || "";
export function Sidebar({ activeSessionId, onSelectSession, onNewChat }: { activeSessionId: string | null; onSelectSession: (id: string) => void; onNewChat: () => void; }) {
  const [sessions, setSessions] = useState<any[]>([]);
  const load = () => { fetch(API + "/api/sessions").then(r => r.json()).then(setSessions).catch(() => {}); };
  useEffect(load, [activeSessionId]);
  return (
    <div style={{ width: 260, background: "#1a1a2e", color: "#e2e8f0", display: "flex", flexDirection: "column", height: "100vh", flexShrink: 0 }}>
      <div style={{ padding: 12 }}><button onClick={onNewChat} style={{ width: "100%", padding: "10px 16px", borderRadius: 8, border: "1px solid #334155", background: "transparent", color: "#e2e8f0", fontSize: 13, cursor: "pointer" }}>+ New Chat</button></div>
      <div style={{ flex: 1, overflowY: "auto", padding: "0 8px" }}>
        {sessions.map((s: any) => (
          <div key={s.id} onClick={() => onSelectSession(s.id)} style={{ padding: "10px 12px", borderRadius: 8, cursor: "pointer", background: s.id === activeSessionId ? "#334155" : "transparent", marginBottom: 2, display: "flex", justifyContent: "space-between" }}>
            <div style={{ overflow: "hidden", flex: 1 }}><div style={{ fontSize: 13, whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{s.title}</div></div>
            <button onClick={(e) => { e.stopPropagation(); fetch(API + "/api/sessions/" + s.id, {method:"DELETE"}).then(load); if (s.id === activeSessionId) onNewChat(); }} style={{ background: "none", border: "none", color: "#64748b", cursor: "pointer", fontSize: 14 }}>x</button>
          </div>
        ))}
      </div>
      <div style={{ padding: "12px 16px", borderTop: "1px solid #334155", fontSize: 11, color: "#64748b" }}>PMWeb Agent</div>
    </div>
  );
}
