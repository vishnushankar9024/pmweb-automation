import { useEffect, useRef, useState } from "react";
import { getPmwebStatus, connectPmweb, getSession } from "../services/api";
import type { ChatMessage } from "../types";
import { MessageBubble } from "./MessageBubble";

const API_BASE = import.meta.env.VITE_API_URL || "";

interface Props {
  sessionId: string | null;
  onSessionCreated: (id: string) => void;
}

export function ChatWindow({ sessionId, onSessionCreated }: Props) {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [input, setInput] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [loading, setLoading] = useState(false);
  const [pmwebConnected, setPmwebConnected] = useState(false);
  const [pmwebConnecting, setPmwebConnecting] = useState(false);
  const bottomRef = useRef<HTMLDivElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

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

  const handleStop = async () => {
    await fetch(`${API_BASE}/api/stop`, { method: "POST" });
  };

  const handleSend = async (text?: string) => {
    const msg = text || input.trim();
    if (!msg || loading) return;

    const userMsg = file ? `${msg}\n[Attached: ${file.name}]` : msg;
    setMessages((prev) => [
      ...prev,
      { role: "user", content: userMsg },
    ]);
    setInput("");
    setLoading(true);

    try {
      const controller = new AbortController();
      const timeout = setTimeout(
        () => controller.abort(),
        300000
      );

      let res: Response;

      if (file) {
        const form = new FormData();
        form.append("message", msg);
        if (sessionId) form.append("conversation_id", sessionId);
        form.append("file", file);
        res = await fetch(`${API_BASE}/api/chat-with-file`, {
          method: "POST",
          body: form,
          signal: controller.signal,
        });
      } else {
        res = await fetch(`${API_BASE}/api/chat`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            message: msg,
            conversation_id: sessionId,
          }),
          signal: controller.signal,
        });
      }

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
            "Request failed or timed out. The agent may still be working.",
        },
      ]);
    } finally {
      setLoading(false);
      setFile(null);
    }
  };

  const lastUserMsg =
    [...messages].reverse().find((m) => m.role === "user")?.content || "";

  return (
    <div
      style={{
        flex: 1,
        display: "flex",
        flexDirection: "column",
        height: "100vh",
        fontFamily:
          '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
      }}
    >
      {/* Header */}
      <div
        style={{
          padding: "10px 20px",
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
            Chat to configure PMWeb
          </p>
        </div>
        <div style={{ display: "flex", gap: 8 }}>
          <a
            href={`${window.location.protocol}//${window.location.hostname}:6081/vnc.html?autoconnect=true&resize=scale&view_only=true`}
            target="_blank"
            style={{
              padding: "6px 12px",
              borderRadius: 8,
              border: "1px solid #cbd5e1",
              fontSize: 11,
              color: "#475569",
              textDecoration: "none",
            }}
          >
            Live View
          </a>
          <button
            onClick={handleConnect}
            disabled={pmwebConnected || pmwebConnecting}
            style={{
              padding: "6px 12px",
              borderRadius: 8,
              border: pmwebConnected
                ? "1px solid #bbf7d0"
                : "1px solid #cbd5e1",
              background: pmwebConnected ? "#f0fdf4" : "#fff",
              color: pmwebConnected ? "#16a34a" : "#475569",
              fontSize: 11,
              cursor: pmwebConnected ? "default" : "pointer",
            }}
          >
            {pmwebConnected
              ? "● Connected"
              : pmwebConnecting
              ? "Connecting..."
              : "Connect"}
          </button>
        </div>
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
            <h2
              style={{
                color: "#475569",
                fontSize: 18,
                marginBottom: 6,
              }}
            >
              How can I help you with PMWeb?
            </h2>
            <p
              style={{
                color: "#94a3b8",
                fontSize: 13,
                marginBottom: 20,
              }}
            >
              Create security groups, users, workflows, forms, and more
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
          <MessageBubble
            key={i}
            message={msg}
            sessionId={sessionId || undefined}
            lastUserMessage={lastUserMsg}
          />
        ))}

        {loading && (
          <div
            style={{
              display: "flex",
              gap: 8,
              padding: "12px 0",
              alignItems: "center",
            }}
          >
            <div
              style={{
                width: 8,
                height: 8,
                borderRadius: "50%",
                background: "#94a3b8",
                animation: "pulse 1.2s ease-in-out infinite",
              }}
            />
            <span
              style={{ fontSize: 12, color: "#94a3b8" }}
            >
              Working in PMWeb...
            </span>
          </div>
        )}
        <div ref={bottomRef} />
      </div>

      {/* File preview */}
      {file && (
        <div
          style={{
            padding: "6px 20px",
            background: "#f1f5f9",
            fontSize: 11,
            color: "#475569",
            display: "flex",
            alignItems: "center",
            gap: 8,
          }}
        >
          📎 {file.name} ({(file.size / 1024).toFixed(1)} KB)
          <button
            onClick={() => setFile(null)}
            style={{
              background: "none",
              border: "none",
              cursor: "pointer",
              color: "#dc2626",
              fontSize: 12,
            }}
          >
            x
          </button>
        </div>
      )}

      {/* Input */}
      <div
        style={{
          padding: "10px 20px",
          borderTop: "1px solid #e2e8f0",
          background: "#fff",
          display: "flex",
          gap: 8,
          alignItems: "center",
          flexShrink: 0,
        }}
      >
        <button
          onClick={() => fileInputRef.current?.click()}
          style={{
            background: "none",
            border: "1px solid #cbd5e1",
            borderRadius: 8,
            padding: "8px",
            cursor: "pointer",
            fontSize: 14,
          }}
          title="Attach file"
        >
          📎
        </button>
        <input
          ref={fileInputRef}
          type="file"
          onChange={(e) => setFile(e.target.files?.[0] || null)}
          style={{ display: "none" }}
        />
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
        {loading ? (
          <button
            onClick={handleStop}
            style={{
              padding: "10px 16px",
              borderRadius: 8,
              border: "none",
              background: "#dc2626",
              color: "#fff",
              fontSize: 13,
              fontWeight: 600,
              cursor: "pointer",
            }}
          >
            Stop
          </button>
        ) : (
          <button
            onClick={() => handleSend()}
            disabled={!input.trim() && !file}
            style={{
              padding: "10px 20px",
              borderRadius: 8,
              border: "none",
              background:
                !input.trim() && !file ? "#94a3b8" : "#2563eb",
              color: "#fff",
              fontSize: 13,
              fontWeight: 600,
              cursor:
                !input.trim() && !file ? "default" : "pointer",
            }}
          >
            Send
          </button>
        )}
      </div>

      <style>{`
        @keyframes pulse {
          0%, 100% { opacity: 0.3; }
          50% { opacity: 1; }
        }
      `}</style>
    </div>
  );
}
