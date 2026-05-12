<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TestWebFormLocalization.aspx.vb" Inherits="Website.TestWebFormLocalization" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
    <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI.Gantt" tagprefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>Report Viewer</title>
    </head>
    
<body>
    <form id="form1" runat="server">
   
     <asp:ScriptManager ID="PMScriptManager" runat="server" 
        EnableScriptGlobalization="True" EnableTheming="True">
    </asp:ScriptManager>
   <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
    </telerik:RadAjaxManager>
   
       


    </form>
</body>
</html>
