import { useEffect, useRef, useState } from "react";
import { getPmwebStatus, connectPmweb, getSession } from "../services/api";
import type { ChatMessage } from "../types";
import { MessageBubble } from "./MessageBubble";

interface Props {
  sessionId: string | null;
  onSessionCreated: (id: string) => void;
}

export function ChatWindow({ sessionId, onSessionCreated }: Props) {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [input, setInput] = useState("");
  const [loading, setLoading] = useState(false);
  const [pmwebConnected, setPmwebConnected] = useState(false);
  const [pmwebConnecting, setPmwebConnecting] = useState(false);
  const bottomRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  useEffect(() => {
    getPmwebStatus()
      .then((s) => setPmwebConnected(s.connected))
      .catch(() => {});
  }, []);

  useEffect(() => {
    if (sessionId) {
      getSession(sessionId)
        .then((s) => {
          setMessages(
            s.messages.map((m) => ({
              role: m.role as "user" | "assistant",
              content: m.content,
              actions: m.actions,
            }))
          );
        })
        .catch(() => setMessages([]));
    } else {
      setMessages([]);
    }
  }, [sessionId]);

  const handleConnect = async () => {
    setPmwebConnecting(true);
    try {
      await connectPmweb();
      setPmwebConnected(true);
    } catch {
      alert("Failed to connect to PMWeb.");
    } finally {
      setPmwebConnecting(false);
    }
  };

  const handleSend = async (text?: string) => {
    const msg = text || input.trim();
    if (!msg || loading) return;

    setMessages((prev) => [...prev, { role: "user", content: msg }]);
    setInput("");
    setLoading(true);

    try {
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 300000);
      const res = await fetch(
        `${import.meta.env.VITE_API_URL || ""}/api/chat`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            message: msg,
            conversation_id: sessionId,
          }),
          signal: controller.signal,
        }
      );
      clearTimeout(timeout);
      if (!res.ok) throw new Error(`API ${res.status}`);
      const data = await res.json();

      if (!sessionId && data.conversation_id) {
        onSessionCreated(data.conversation_id);
      }

      setMessages((prev) => [
        ...prev,
        {
          role: "assistant" as const,
          content: data.reply,
          actions: data.executed_actions,
        },
      ]);
    } catch {
      setMessages((prev) => [
        ...prev,
        {
          role: "assistant" as const,
          content:
            "Request timed out or failed. The agent may still be working — check the live browser view.",
        },
      ]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      style={{
        flex: 1,
        display: "flex",
        flexDirection: "column",
        height: "100vh",
      }}
    >
      {/* Header */}
      <div
        style={{
          padding: "12px 20px",
          borderBottom: "1px solid #e2e8f0",
          background: "#fff",
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          flexShrink: 0,
        }}
      >
        <div>
          <h1 style={{ margin: 0, fontSize: 16, color: "#1e293b" }}>
            PMWeb Automation Agent
          </h1>
          <p style={{ margin: 0, fontSize: 11, color: "#94a3b8" }}>
            Chat to configure PMWeb — watch it happen live
          </p>
        </div>
        <button
          onClick={handleConnect}
          disabled={pmwebConnected || pmwebConnecting}
          style={{
            padding: "6px 14px",
            borderRadius: 8,
            border: pmwebConnected
              ? "1px solid #bbf7d0"
              : "1px solid #cbd5e1",
            background: pmwebConnected ? "#f0fdf4" : "#fff",
            color: pmwebConnected ? "#16a34a" : "#475569",
            fontSize: 12,
            fontWeight: 500,
            cursor: pmwebConnected ? "default" : "pointer",
          }}
        >
          {pmwebConnected
            ? "● Connected"
            : pmwebConnecting
            ? "Connecting..."
            : "Connect to PMWeb"}
        </button>
      </div>

      {/* Messages */}
      <div
        style={{
          flex: 1,
          overflowY: "auto",
          padding: 20,
          background: "#fafbfc",
        }}
      >
        {messages.length === 0 && (
          <div style={{ textAlign: "center", paddingTop: 60 }}>
            <h2 style={{ color: "#475569", fontSize: 18, marginBottom: 6 }}>
              How can I help you with PMWeb?
            </h2>
            <p style={{ color: "#94a3b8", fontSize: 13, marginBottom: 20 }}>
              I can create security groups, users, workflows, and forms
            </p>
            <div
              style={{
                display: "flex",
                flexWrap: "wrap",
                gap: 6,
                justifyContent: "center",
              }}
            >
              {[
                "Create a security group for contractors",
                "Build a safety inspection form",
                "List all security groups",
                "Create a workflow for RFI approval",
              ].map((s) => (
                <button
                  key={s}
                  onClick={() => handleSend(s)}
                  style={{
                    padding: "8px 14px",
                    borderRadius: 20,
                    border: "1px solid #cbd5e1",
                    background: "#fff",
                    cursor: "pointer",
                    fontSize: 12,
                    color: "#475569",
                  }}
                >
                  {s}
                </button>
              ))}
            </div>
          </div>
        )}

        {messages.map((msg, i) => (
          <MessageBubble key={i} message={msg} />
        ))}

        {loading && (
          <div
            style={{
              display: "flex",
              gap: 4,
              padding: "12px 0",
              alignItems: "center",
            }}
          >
            <div className="dot-pulse" />
            <span style={{ marginLeft: 12, fontSize: 12, color: "#94a3b8" }}>
              Working in PMWeb...
            </span>
          </div>
        )}
        <div ref={bottomRef} />
      </div>

      {/* Input */}
      <div
        style={{
          padding: "12px 20px",
          borderTop: "1px solid #e2e8f0",
          background: "#fff",
          display: "flex",
          gap: 10,
          flexShrink: 0,
        }}
      >
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleSend()}
          placeholder="Describe what you want to configure..."
          disabled={loading}
          style={{
            flex: 1,
            padding: "10px 14px",
            borderRadius: 8,
            border: "1px solid #cbd5e1",
            fontSize: 13,
            outline: "none",
          }}
        />
        <button
          onClick={() => handleSend()}
          disabled={loading || !input.trim()}
          style={{
            padding: "10px 20px",
            borderRadius: 8,
            border: "none",
            background:
              loading || !input.trim() ? "#94a3b8" : "#2563eb",
            color: "#fff",
            fontSize: 13,
            fontWeight: 600,
            cursor:
              loading || !input.trim() ? "default" : "pointer",
          }}
        >
          Send
        </button>
      </div>

      <style>{`
        .dot-pulse {
          width: 8px; height: 8px; border-radius: 50%;
          background: #94a3b8;
          animation: pulse 1.2s ease-in-out infinite;
        }
        @keyframes pulse {
          0%, 100% { opacity: 0.3; }
          50% { opacity: 1; }
        }
      `}</style>
    </div>
  );
}
