<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrintPreview.aspx.vb" Inherits="Website.PrintPreview" Title="Print Preview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
</head>
<style type="text/css">
    body:nth-of-type(1) img[src*="Blank.gif"] {
        display: none;
    }

    table#rvSqlReport2_fixedTable {
        width: 100%;
    }

    [id^="rvSqlReport2_ctl09"] {
        padding-left: 15px;
        box-sizing: border-box;
        padding-top: 15px;
    }

    input[type="submit"] {
        width: 100px !important;
    }
    a.rfdSkinnedButton{
        text-decoration:none !important;
    }
</style>

<script language="javascript" type="text/javascript">
    function pageLoad() {
        calcualteReportHeight();
        $("[id^='rvSqlReport2_ToggleParam_img']").on("click", function (event) {
            void (0);
            calcualteReportHeight();
        });
    }
    function calcualteReportHeight() {
        if ($("[id^='ParametersRowrvSqlReport2']")) {
            height = $("[id^='ParametersRowrvSqlReport2']").height() + 45;
            if ($("[id^='ParametersRowrvSqlReport2']").css("display") == "none")
                height = 45;
            $("[id='rvSqlReport2_ctl09']").css({ height: "calc(99vh - " + height + "px)" });
            $("[id$='ReportArea']").css({ display: "none" });
        }
    }
</script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="2400">
        </asp:ScriptManager>
        <div>
            <rsweb:ReportViewer ID="rvSqlReport2" runat="server" ShowBackButton="true"
                DocumentMapWidth="200" SizeToReportContent="true" Width="100%" Height="100%" AsyncRendering="false" ShowZoomControl="true"
                ShowFindControls="false" ShowDocumentMapButton="true" ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt" ShowPromptAreaButton="true"
                PromptAreaCollapsed="true" KeepSessionAlive="true">
            </rsweb:ReportViewer>
        </div>
    </form>
</body>
</html>
