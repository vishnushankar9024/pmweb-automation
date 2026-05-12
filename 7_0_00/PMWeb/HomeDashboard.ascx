<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="HomeDashboard.ascx.vb" Inherits="Website.HomeDashboard" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Panel ID="pnlSqlReport" runat="server">
    <style type="text/css">
        body:nth-of-type(1) img[src*="Blank.gif"]{display:none;}
        #ParametersGridctl00_CPH1_HomeDashboard1_rvSqlReport_ctl04 td > div > div > input[type="text"] {
            width:222px;
        }


        #ParametersGridctl00_CPH1_HomeDashboard1_rvSqlReport_ctl04 td > div > input[type="text"] {
            width:240px;
        }

        #ParametersGridctl00_CPH1_HomeDashboard1_rvSqlReport_ctl04 td > div > a{
            width:240px !important;
        }

       #ParametersGridctl00_CPH1_HomeDashboard1_rvSqlReport_ctl04 td > div > select{
            width:240px !important;
        }

        .rfdSelectBoxDropDown {
            overflow-x: auto !important;
        }
        .rfdSelectBoxDropDown li {
            overflow: unset !important;
        }
        </style>
<asp:Button ID="btnBack" runat="server" CssClass="Hide"></asp:Button>
<a name="SqlReport"></a>

<rsweb:ReportViewer ID="rvSqlReport" runat="server" ShowParameterPrompts="true" ShowBackButton="true" ShowDocumentMapButton="true"
         DocumentMapWidth="200" Width="100%"  height="800px" ShowZoomControl="true" ShowFindControls="true"  AsyncRendering="False"
            ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt" PromptAreaCollapsed="true" KeepSessionAlive="true">
</rsweb:ReportViewer>
</asp:Panel>
<asp:HiddenField ID="hfEnableBackButton" runat="server" Value="0"/>
<asp:Panel ID="pnlError" runat="server">
   <table width="100%" cellpadding="2" border="0" style="padding:5px"> 
    <tr>
        <td><asp:Label ID="lblError" runat="server"  Text="<%$Resources:PMWeb, ReportErrorMsg %>" CssClass="Validator"></asp:Label></td>
    </tr>
   </table></asp:Panel>
   <asp:Button ID="btnRefereshReportViewer" runat="server" CssClass="Hide"></asp:Button>