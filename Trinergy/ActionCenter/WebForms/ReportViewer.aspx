<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" Inherits="PMWebHelper.WebForms.ReportViewer" %>

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
        <%--<rsweb:ReportViewer ID="rptViewer1" runat="server" ProcessingMode="Remote" Width="100%"  Height="100%">
            <serverreport reportpath="/PMWeb/Custom Reports/Construction Phase Documents-Summary Sheet" reportserverurl="http://pmweb.hamad.qa/reportserver" />
        </rsweb:ReportViewer>--%>
        <rsweb:ReportViewer ID="rptViewer1" runat="server" Width="100%"  Height="100%"></rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
