<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" Inherits="PMWebHelper.WebForms.Dashboard.ReportViewer" EnableEventValidation="false" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#rptViewer1_ToggleParam").closest('td').css({ "background-color": "#FFFFFF" });
            console.log($("#rptViewer1_ToggleParam").parent('td'));
        });
    </script>
    <style>
        #rptViewer1_fixedTable{
            /*width:100% !important;*/
             width:<%=((Convert.ToDouble(Request.QueryString["width"].ToString()) - 350) + "px !important")%>
        }
        #rptViewer1_ctl04 {
            width:<%=((Convert.ToDouble(Request.QueryString["width"].ToString()) - 350) + "px !important")%>
        }
        #rptViewer1_ToggleParam {
            width:<%=((Convert.ToDouble(Request.QueryString["width"].ToString()) - 350) + "px !important")%>;
            background-color: rgb(236, 233, 216);
        }
        td < #rptViewer1_ToggleParam {
             background-color: #FFFFFF !important;
        }
        #rptViewer1_ctl05 {
            width:<%=((Convert.ToDouble(Request.QueryString["width"].ToString()) - 350) + "px !important")%>
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false">
        </asp:ScriptManager>
        <div style="width:100%; min-height:300px;">
            <rsweb:ReportViewer ID="rptViewer1" runat="server" Width="100%" Height="100%" AsyncRendering="false" KeepSessionAlive="true" PromptAreaCollapsed="true" ZoomMode="PageWidth" SizeToReportContent="True"  ShowParameterPrompts="true" ShowToolBar="true"></rsweb:ReportViewer>
        </div>
    </form>
</body>
</html>
