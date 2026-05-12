<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ImportResultsPopup.aspx.vb" Inherits="Website.ImportResultsPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
       <style type="text/css">
            .ButtonOK {
                /*background-image: url('Button/btn.gif') !important;*/
                /*background-position: -2px 130px !important;*/
                border: 1px solid #666666;
                text-align: center;
                text-transform: uppercase;
                color: #666666;
                border-radius: 5px;
                background-color: #FFFFFF;
                vertical-align: central;
                height: 24px;
                text-decoration: none;
                width: 100%;
                display: table-cell;
                padding: 4px;
            }
        </style>
</head>
<body>

    <telerik:RadCodeBlock runat="server" ID="script1">
        <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
        <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>

        <script type="text/javascript">
            var interval;
            window.onload = function () {
                var ldp = $find("<%= ldpLoading.ClientID %>")
                ldp.show('form1');
                $("[id$='lblInProgress']").removeClass('Hide')
                $(window.parent.document).find("input[id$='btnhdnImport']").click()
                interval = window.setInterval(function () {
                    CheckImportState();
                }, 1500)

            };

            function CheckImportState() {
                var ImportState = $(window.parent.document).find("input[id$='hdnImportState']").val();
                if (ImportState == 'Success') {
                    clearInterval(interval);
                    var ldp = $find("<%= ldpLoading.ClientID %>");
                    ldp.hide('form1');
                    $("[id$='lblInProgress']").addClass('Hide')
                    $("#divResults").removeClass('Hide');
                    var success  = '<%= GetLocalResourceObject("ImportSucceeded")%>'
                    $("[id$='lblResult']").html(success);
                    var wnd = GetRadWindow();
                    wnd.set_title(success);
                }
                else if (ImportState == 'Failed') {

                    $("[id$='lblInProgress']").addClass('Hide')
                    clearInterval(interval);
                    var ldp = $find("<%= ldpLoading.ClientID %>");
                    ldp.hide('form1');
                    $("#divResults").removeClass('Hide');
                    var fail = '<%= GetLocalResourceObject("ImportFailed")%>'
                    $("[id$='lblResult']").html(fail);
                    var wnd = GetRadWindow();
                    wnd.set_title(fail);
                }
        }

        function CloseResultsPopup() {
            var ImportState = $(window.parent.document).find("input[id$='hdnImportState']").val();
            if (ImportState == 'Success') {
                var btnRefresh = $(window.parent.parent.document).find("a[id*=RDG1][id$=btnRefresh]")[0]
                if (btnRefresh)
                    btnRefresh.click();
                else
                    window.parent.parent.location = window.parent.parent.location
                window.parent.GetRadWindow().close();
                CloseRadWnd();

            }
            else {
                CloseRadWnd();
            }
        }

        </script>
     
    </telerik:RadCodeBlock>
    <form id="form1" runat="server" style="height: 100vh;">
        <telerik:RadAjaxLoadingPanel ID="ldpLoading"  runat="server" Skin="Default" BackgroundTransparency="0" Transparency="0"></telerik:RadAjaxLoadingPanel>
        <asp:Label runat="server" ID="lblInProgress" Class="Hide" meta:resourcekey="lblInprogress" Style=" font-size: 16px;color: #999999;font-family: 'Work Sans';bottom: 20%;position: absolute;left: calc(50% - 60px);"></asp:Label>
            
        <div id="divResults" class="Hide" style="text-align:center">
            <asp:Label runat="server" ID="lblResult"  Style=" font-size: 16px;color: #999999;font-family: 'Work Sans';top: 50%;position: absolute;left: calc(50% - 100px);width: 200px;"></asp:Label>
            <asp:Button runat="server" ID="btnOk" CssClass="ButtonOK" OnClientClick="CloseResultsPopup();return false;" meta:resourcekey="btnOK" style="position:fixed;width:100px;bottom:24px;right:24px"/>
        </div>
    </form> 
</body>
</html>
