import { useState } from "react";
import { Sidebar } from "./components/Sidebar";
import { ChatWindow } from "./components/ChatWindow";

function App() {
  const [activeSessionId, setActiveSessionId] = useState<string | null>(
    null
  );

  return (
    <div style={{ display: "flex", height: "100vh" }}>
      <Sidebar
        activeSessionId={activeSessionId}
        onSelectSession={(id) => setActiveSessionId(id)}
        onNewChat={() => setActiveSessionId(null)}
      />
      <ChatWindow
        sessionId={activeSessionId}
        onSessionCreated={(id) => setActiveSessionId(id)}
      />
    </div>
  );
}

export default App;
