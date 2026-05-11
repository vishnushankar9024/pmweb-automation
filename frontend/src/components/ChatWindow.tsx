import { useEffect, useRef, useState } from "react";
import { sendMessage, getPmwebStatus, connectPmweb } from "../services/api";
import type { ChatMessage } from "../types";
import { MessageBubble } from "./MessageBubble";

const SUGGESTIONS = [
  "Create security groups for a construction project",
  "Design an approval workflow for change orders",
  "Build a safety inspection form",
  "Set up user accounts with different access levels",
];

export function ChatWindow() {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [input, setInput] = useState("");
  const [loading, setLoading] = useState(false);
  const [conversationId, setConversationId] = useState<string>();
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

  const handleConnect = async () => {
    setPmwebConnecting(true);
    try {
      await connectPmweb();
      setPmwebConnected(true);
    } catch {
      alert("Failed to connect to PMWeb. Check credentials.");
    } finally {
      setPmwebConnecting(false);
    }
  };

  const handleSend = async (text?: string) => {
    const msg = text || input.trim();
    if (!msg || loading) return;

    const userMsg: ChatMessage = { role: "user", content: msg };
    setMessages((prev) => [...prev, userMsg]);
    setInput("");
    setLoading(true);

    try {
      const res = await sendMessage(msg, conversationId);
      setConversationId(res.conversation_id);
      const assistantMsg: ChatMessage = {
        role: "assistant",
        content: res.reply,
        actions: res.executed_actions,
      };
      setMessages((prev) => [...prev, assistantMsg]);
    } catch {
      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          content: "Sorry, I encountered an error. Please check that the backend is running.",
        },
      ]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        height: "100vh",
        maxWidth: 800,
        margin: "0 auto",
        fontFamily:
          '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
      }}
    >
      {/* Header */}
      <div
        style={{
          padding: "16px 24px",
          borderBottom: "1px solid #e2e8f0",
          background: "#fff",
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <div>
          <h1 style={{ margin: 0, fontSize: 20, color: "#1e293b" }}>
            PMWeb Automation Agent
          </h1>
          <p style={{ margin: "4px 0 0", fontSize: 13, color: "#64748b" }}>
            Configure security, workflows, and forms through conversation
          </p>
        </div>
        <button
          onClick={handleConnect}
          disabled={pmwebConnected || pmwebConnecting}
          style={{
            padding: "8px 16px",
            borderRadius: 8,
            border: pmwebConnected ? "1px solid #bbf7d0" : "1px solid #cbd5e1",
            background: pmwebConnected ? "#f0fdf4" : "#fff",
            color: pmwebConnected ? "#16a34a" : "#475569",
            fontSize: 13,
            fontWeight: 500,
            cursor: pmwebConnected ? "default" : "pointer",
          }}
        >
          {pmwebConnected
            ? "● PMWeb Connected"
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
          padding: 24,
          background: "#fafbfc",
        }}
      >
        {messages.length === 0 && (
          <div style={{ textAlign: "center", paddingTop: 60 }}>
            <h2 style={{ color: "#475569", fontSize: 18, marginBottom: 8 }}>
              Welcome! How can I help you today?
            </h2>
            <p style={{ color: "#94a3b8", fontSize: 14, marginBottom: 24 }}>
              Describe what you need and I'll configure PMWeb for you
            </p>
            <div
              style={{
                display: "flex",
                flexWrap: "wrap",
                gap: 8,
                justifyContent: "center",
              }}
            >
              {SUGGESTIONS.map((s) => (
                <button
                  key={s}
                  onClick={() => handleSend(s)}
                  style={{
                    padding: "8px 16px",
                    borderRadius: 20,
                    border: "1px solid #cbd5e1",
                    background: "#fff",
                    cursor: "pointer",
                    fontSize: 13,
                    color: "#475569",
                    transition: "all 0.15s",
                  }}
                  onMouseOver={(e) => {
                    e.currentTarget.style.borderColor = "#2563eb";
                    e.currentTarget.style.color = "#2563eb";
                  }}
                  onMouseOut={(e) => {
                    e.currentTarget.style.borderColor = "#cbd5e1";
                    e.currentTarget.style.color = "#475569";
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
          <div style={{ display: "flex", gap: 4, padding: "8px 0" }}>
            {[0, 1, 2].map((i) => (
              <div
                key={i}
                style={{
                  width: 8,
                  height: 8,
                  borderRadius: "50%",
                  background: "#94a3b8",
                  animation: `bounce 1.4s ease-in-out ${i * 0.16}s infinite both`,
                }}
              />
            ))}
          </div>
        )}
        <div ref={bottomRef} />
      </div>

      {/* Input */}
      <div
        style={{
          padding: "16px 24px",
          borderTop: "1px solid #e2e8f0",
          background: "#fff",
          display: "flex",
          gap: 12,
        }}
      >
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleSend()}
          placeholder="Describe what you want to configure in PMWeb..."
          disabled={loading}
          style={{
            flex: 1,
            padding: "10px 16px",
            borderRadius: 8,
            border: "1px solid #cbd5e1",
            fontSize: 14,
            outline: "none",
          }}
        />
        <button
          onClick={() => handleSend()}
          disabled={loading || !input.trim()}
          style={{
            padding: "10px 24px",
            borderRadius: 8,
            border: "none",
            background: loading || !input.trim() ? "#94a3b8" : "#2563eb",
            color: "#fff",
            fontSize: 14,
            fontWeight: 600,
            cursor: loading || !input.trim() ? "default" : "pointer",
          }}
        >
          Send
        </button>
      </div>

      <style>{`
        @keyframes bounce {
          0%, 80%, 100% { transform: scale(0); }
          40% { transform: scale(1); }
        }
      `}</style>
    </div>
  );
}
