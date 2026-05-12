import { useState } from "react";

const API_BASE = import.meta.env.VITE_API_URL || "";

export function PMWebViewer({ isLoading }: { isLoading: boolean }) {
  const [checked, setChecked] = useState(false);
  const [connected, setConnected] = useState(false);

  const vncUrl = `${window.location.origin}/novnc/vnc.html?autoconnect=true&resize=scale&view_only=true&path=ws/vnc`;

  if (!checked) {
    setChecked(true);
    fetch(`${API_BASE}/api/pmweb/status`)
      .then((r) => r.json())
      .then((d) => { if (d.connected) setConnected(true); })
      .catch(() => {});
  }

  return (
    <div style={{ flex: 1, display: "flex", flexDirection: "column", background: "#1e293b", overflow: "hidden" }}>
      <div style={{ padding: "10px 16px", borderBottom: "1px solid #334155", display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <span style={{ color: "#e2e8f0", fontSize: 13, fontWeight: 500 }}>PMWeb Live View</span>
        {isLoading ? (
          <span style={{ color: "#fbbf24", fontSize: 11, display: "flex", alignItems: "center", gap: 6 }}>
            <span style={{ width: 6, height: 6, borderRadius: "50%", background: "#fbbf24", animation: "pulse 1s ease-in-out infinite" }} />
            Agent is working...
          </span>
        ) : connected ? (
          <span style={{ color: "#4ade80", fontSize: 11 }}>● Live</span>
        ) : null}
      </div>
      <div style={{ flex: 1, overflow: "hidden" }}>
        {connected ? (
          <iframe src={vncUrl} title="PMWeb Live" style={{ width: "100%", height: "100%", border: "none" }} />
        ) : (
          <div style={{ display: "flex", alignItems: "center", justifyContent: "center", height: "100%", color: "#64748b", fontSize: 13 }}>
            Connect to PMWeb to see live browser
          </div>
        )}
      </div>
      <style>{`@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.3; } }`}</style>
    </div>
  );
}
