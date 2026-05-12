import { useState } from "react";
import { ChatWindow } from "./components/ChatWindow";
import { Sidebar } from "./components/Sidebar";

function App() {
  const [sessionId, setSessionId] = useState<string | undefined>();
  const [sessionKey, setSessionKey] = useState(0);

  const handleNewSession = () => {
    setSessionId(undefined);
    setSessionKey((k) => k + 1);
  };

  return (
    <div style={{ display: "flex", height: "100vh" }}>
      <Sidebar
        currentSessionId={sessionId}
        onSelectSession={(id) => {
          setSessionId(id);
          setSessionKey((k) => k + 1);
        }}
        onNewSession={handleNewSession}
      />
      <ChatWindow
        key={sessionKey}
        initialSessionId={sessionId}
        onSessionChange={setSessionId}
      />
    </div>
  );
}

export default App;
