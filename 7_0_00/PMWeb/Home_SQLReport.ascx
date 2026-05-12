<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_SQLReport.ascx.vb" Inherits="Website.Home_SQLReport" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Panel ID="pnlSqlReport" runat="server">
    <style type="text/css">
        body:nth-of-type(1) img[src*="Blank.gif"]{display:none;}
        </style>
<a name="SqlReport"></a>

<rsweb:ReportViewer ID="rvSqlReport" runat="server" ShowParameterPrompts="true" ShowBackButton="true" ShowDocumentMapButton="true"
         DocumentMapWidth="200" Width="100%"  height="800px" ShowZoomControl="true" ShowFindControls="true"  AsyncRendering="False"
            ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt"  KeepSessionAlive="true">
</rsweb:ReportViewer>
</asp:Panel>
<asp:Panel ID="pnlError" runat="server">
   <table width="100%" cellpadding="2" border="0" style="padding:5px"> 
    <tr>
        <td><asp:Label ID="lblError" runat="server"  Text="<%$Resources:PMWeb, ReportErrorMsg %>" CssClass="Validator"></asp:Label></td>
    </tr>
   </table>
</asp:Panel>