<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PMWebConsumer.Dashboard" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb User Information</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>User Information</h2>
        <div>
            <strong>Username:</strong> <asp:Label ID="lblUsername" runat="server" Text="Loading..."></asp:Label><br />
            <strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" Text="Loading..."></asp:Label><br />
            <strong>Group:</strong> <asp:Label ID="lblGroup" runat="server" Text="Loading..."></asp:Label><br />
        </div>
    </form>
</body>
</html>
