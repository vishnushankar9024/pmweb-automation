import { useEffect, useRef, useState } from "react";

const API_BASE = import.meta.env.VITE_API_URL || "http://localhost:8000";

export function PMWebViewer({ isLoading }: { isLoading: boolean }) {
  const [imageSrc, setImageSrc] = useState<string | null>(null);
  const intervalRef = useRef<number | null>(null);

  useEffect(() => {
    const fetchScreenshot = async () => {
      try {
        const res = await fetch(`${API_BASE}/api/pmweb/screenshot`);
        const data = await res.json();
        if (data.image) {
          setImageSrc(data.image);
        }
      } catch {
        // ignore fetch errors
      }
    };

    fetchScreenshot();

    const rate = isLoading ? 1000 : 3000;
    intervalRef.current = window.setInterval(fetchScreenshot, rate);

    return () => {
      if (intervalRef.current) {
        window.clearInterval(intervalRef.current);
      }
    };
  }, [isLoading]);

  return (
    <div
      style={{
        flex: 1,
        display: "flex",
        flexDirection: "column",
        background: "#1e293b",
        overflow: "hidden",
      }}
    >
      {/* Viewer header */}
      <div
        style={{
          padding: "10px 16px",
          borderBottom: "1px solid #334155",
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <span style={{ color: "#e2e8f0", fontSize: 13, fontWeight: 500 }}>
          PMWeb Live View
        </span>
        {isLoading && (
          <span
            style={{
              color: "#fbbf24",
              fontSize: 11,
              display: "flex",
              alignItems: "center",
              gap: 6,
            }}
          >
            <span
              style={{
                width: 6,
                height: 6,
                borderRadius: "50%",
                background: "#fbbf24",
                animation: "pulse 1s ease-in-out infinite",
              }}
            />
            Agent is working...
          </span>
        )}
        {!isLoading && imageSrc && (
          <span style={{ color: "#4ade80", fontSize: 11 }}>
            ● Live
          </span>
        )}
      </div>

      {/* Screenshot display */}
      <div
        style={{
          flex: 1,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          padding: 8,
          overflow: "hidden",
        }}
      >
        {imageSrc ? (
          <img
            src={imageSrc}
            alt="PMWeb Live"
            style={{
              maxWidth: "100%",
              maxHeight: "100%",
              objectFit: "contain",
              borderRadius: 6,
              boxShadow: "0 4px 20px rgba(0,0,0,0.4)",
            }}
          />
        ) : (
          <div style={{ color: "#64748b", fontSize: 13 }}>
            Connecting to PMWeb...
          </div>
        )}
      </div>

      <style>{`
        @keyframes pulse {
          0%, 100% { opacity: 1; }
          50% { opacity: 0.3; }
        }
      `}</style>
    </div>
  );
}
