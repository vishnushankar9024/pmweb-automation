<%@ Page Language="vb" meta:resourcekey="Page" Title ="Report Viewer" AutoEventWireup="false" CodeBehind="ReportPrintingPreview.aspx.vb" Inherits="Website.ReportPrintingPreview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Report Viewer</title> 
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <style type="text/css">
        body:nth-of-type(1) img[src*="Blank.gif"]{display:none;}
        #ParametersGridrvSqlReport2_ctl04 td > div > div > input[type="text"] {
            width:222px;
        }


        #ParametersGridrvSqlReport2_ctl04 td > div > input[type="text"] {
            width:240px;
        }

        #ParametersGridrvSqlReport2_ctl04 td > div > a{
            width:240px !important;
        }

        #ParametersGridrvSqlReport2_ctl04 td > div > select{
            width:240px !important;
        }


        .rfdSelectBoxDropDown {
            overflow-x: auto !important;
        }
        .rfdSelectBoxDropDown li {
            overflow: unset !important;
        }
        .Validator
        {
            font-family: Arial, Helvetica, sans-serif !important;
            font-size: 8pt !important;
            text-decoration: none !important;
            color: #C60000 !important;
        }
        body
        {
            background-image: none !important;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000 !important;
        }
         input[type="submit"]{
            width:100px !important
        }
         a.rfdSkinnedButton{
             text-decoration:none;
         }
             [id^="rvSqlReport2_ctl09"]{
               padding-left: 10px;
               box-sizing: border-box;
               padding-top:15px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function DisplayMessage(innerText) {
            alert(innerText);
            // radalert(innerText, null, null, 'Warning Message');
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            var oWindow = GetRadWindow();
            oWindow.Close();
        }
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
        /* $(document).ready(function() {
        $("td[id$=ReportCell] > div:first").css("width", "800px");
        });*/
    </script>

</head>
<body style="background-color: White" onload="javascript:document.getElementById('dimmer').style.display='none';">

    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="dimmer" class="dimmer"> </div>
    <div>
        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <table style="width: 100%; height: 300px" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center">
                        <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
      
        <rsweb:ReportViewer ID="rvSqlReport2" runat="server" ShowParameterPrompts="true" ShowBackButton="true" ShowDocumentMapButton="true"
         DocumentMapWidth="200" Width="100%"   ShowZoomControl="true" ShowFindControls="true"  AsyncRendering="False"
            ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt"  KeepSessionAlive="true">
            
        </rsweb:ReportViewer>
    </div>
    
    </form>
    
</body>
</html>
