<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SnapshotPopup_Print.aspx.vb" Inherits="Website.SnapshotPopup_Print"  meta:resourcekey="Page"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body onload="window.print()">
    <form id="form1" runat="server">
    <asp:Image ID="imgSnapshot" runat="server" />
    </form>
</body>
</html>
