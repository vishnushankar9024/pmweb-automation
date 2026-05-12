<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Attachment_Dashboard.aspx.cs" Inherits="PMWebHelper.WebForms.Attachment_Dashboard" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
    <rsweb:ReportViewer ID="rptViewer1" runat="server" Width="100%"  Height="100%" AsyncRendering="false" SizeToReportContent="true" ShowParameterPrompts="false"></rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
