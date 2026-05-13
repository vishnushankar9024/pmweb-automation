import { useState } from "react";
import { Sidebar } from "./components/Sidebar";
import { ChatWindow } from "./components/ChatWindow";

function App() {
  const [sid, setSid] = useState<string | null>(null);
  return (
    <div style={{ display: "flex", height: "100vh" }}>
      <Sidebar activeSessionId={sid} onSelectSession={setSid} onNewChat={() => setSid(null)} />
      <ChatWindow sessionId={sid} onSessionCreated={setSid} />
    </div>
  );
}
export default App;
