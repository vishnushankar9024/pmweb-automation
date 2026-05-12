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
      const controller = new AbortController();
      const timeout = setTimeout(() => controller.abort(), 300000);
      const res = await fetch(
        `${import.meta.env.VITE_API_URL || ""}/api/chat`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            message: msg,
            conversation_id: conversationId,
          }),
          signal: controller.signal,
        }
      );
      clearTimeout(timeout);
      if (!res.ok) throw new Error(`API ${res.status}`);
      const data = await res.json();
      setConversationId(data.conversation_id);
      setMessages((prev) => [
        ...prev,
        {
          role: "assistant" as const,
          content: data.reply,
          actions: data.executed_actions,
        },
      ]);
    } catch (err) {
      const msg2 =
        err instanceof DOMException && err.name === "AbortError"
          ? "Request timed out (5 min). The agent may still be working — check the live browser view."
          : "Sorry, an error occurred. The agent may still be working in PMWeb.";
      setMessages((prev) => [
        ...prev,
        { role: "assistant" as const, content: msg2 },
      ]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      style={{
        display: "flex",
        height: "100vh",
        fontFamily:
          '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
      }}
    >
      {/* Left: Chat Panel */}
      <div
        style={{
          width: "100%",
          maxWidth: 800,
          margin: "0 auto",
          display: "flex",
          flexDirection: "column",
          transition: "width 0.3s ease",
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
          }}
        >
          <div>
            <h1 style={{ margin: 0, fontSize: 18, color: "#1e293b" }}>
              PMWeb Automation Agent
            </h1>
            <p style={{ margin: "2px 0 0", fontSize: 12, color: "#64748b" }}>
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
            padding: 16,
            background: "#fafbfc",
          }}
        >
          {messages.length === 0 && (
            <div style={{ textAlign: "center", paddingTop: 40 }}>
              <h2
                style={{ color: "#475569", fontSize: 16, marginBottom: 6 }}
              >
                Welcome! How can I help you today?
              </h2>
              <p
                style={{ color: "#94a3b8", fontSize: 13, marginBottom: 20 }}
              >
                Describe what you need — I'll configure PMWeb for you
              </p>
              <div
                style={{
                  display: "flex",
                  flexWrap: "wrap",
                  gap: 6,
                  justifyContent: "center",
                }}
              >
                {SUGGESTIONS.map((s) => (
                  <button
                    key={s}
                    onClick={() => handleSend(s)}
                    style={{
                      padding: "6px 14px",
                      borderRadius: 20,
                      border: "1px solid #cbd5e1",
                      background: "#fff",
                      cursor: "pointer",
                      fontSize: 12,
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
            <div
              style={{
                display: "flex",
                gap: 4,
                padding: "8px 0",
                alignItems: "center",
              }}
            >
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
              <span
                style={{ marginLeft: 8, fontSize: 12, color: "#94a3b8" }}
              >
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
              padding: "8px 14px",
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
              padding: "8px 20px",
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
