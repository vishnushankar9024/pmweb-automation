<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ErrorPage2.aspx.vb" Inherits="Website.ErrorPage2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head runat="server">
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>

    <title>The system could not process your request.</title>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">

        <link href="CSS/Login.css" rel="stylesheet" type="text/css" />
        <link href="CSS/ControlsCSS/Window.css" rel="stylesheet" />

    </telerik:RadCodeBlock>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        $(document).ready(function (n) {
            var today = new Date();
            var year = today.getFullYear();
            $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc. All rights reserved.');
        });

        function OpenPOPUpAngular(URL) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            $(".rwBodyLeft").remove();
            $(".rwBodyRight").remove();
            $(".rwFooterRow").remove();
            $(".rwTitleRow").remove();
            $(".rwWindowContent").css("width", "100%");
            $(".rwWindowContent").css("border-radius", "20px");
            $('iframe').css("border-radius", "20px");
            $('.TelerikModalOverlay').css('opacity', '0');
            wnd.set_behaviors('true');
            wnd.GetTitlebar().parentElement.hidden = true;
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else if (URL === 'AboutPMWeb.aspx') {
                wnd.setSize(300, 344);
                wnd.center();

                var popupElement = $(wnd.get_popupElement());
                popupElement.css({
                    opacity: 0,
                });

                popupElement.animate({
                    opacity: 1
                }, 500, function () {
                });
                return false;
            }
        }
    </script>
    <style type="text/css">
        #SideBar1{
		float:left;
		width: 400px;
        min-height: 100vh;
		-moz-border-radius: 5px;  
        -webkit-border-radius: 5px;
         padding-bottom:0px;
         margin-left:10px;
         padding-left:10px;
}

        #licenseAgreement{
            margin-left: 0px !important;
        }
        #copyright {
            margin-left: 0px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="LoginForm">
                <telerik:RadScriptManager ID="ScriptManager1" runat="server" />

        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>


        <table style="width: 100%; height: 100%; max-width: 100vw">
            <tr>
                <td rowspan="2" class="tdSidebar" valign="top">
                    <div id="SideBar1">
                        <div id="img_pmweb" style="text-align: center">
                            <asp:Image ID="imgLogo" Style="margin-top: 40px" runat="server" ImageUrl="CSS/Images/LoginLogo.png" Height="68px" Width="220px" />
                        </div>

                        <div  style="color: white !important;margin-right: 24px;margin-top: 150px;font-size: 12px;">
                            PMWeb was not able to process your request at <br />
                             this time, please try again later. For immediate <br />
                             assistance, please contact your PMWeb <br />
                             administrator.
                        </div>
                            <asp:LinkButton runat="server"  ID="btnHelp" OnClientClick="return OpenPOPUpAngular('AboutPMWeb.aspx')" style="color:white !important;margin-top:150px;display:block;text-decoration:none">
<table><tr><td><div class="HeaderMenuHelp">&nbsp;</div></td><td><span><asp:Literal  runat="server" meta:Resourcekey="btnAbout" /></span></td></tr></table></asp:LinkButton>
                        
                        <br />
                          
                        <div id="licenseAgreement">
                            Use of PMWeb is subject to the terms of the license
                            agreement. &nbsp;
                            <br />
                            <a href="https://help.pmweb.com/pmwebeula.html" target="_blank" style="color: white !important">www.pmweb.com/EULA</a>
                        </div>
                        <div id="copyright">
                            <label id="copyrightLabel"></label>
                        </div>
                    </div>
                </td>
                <td style="width: 100%; height: 360px;" align="left" valign="top" class="tdImgLogin">
                    <img src="CSS/Images/LoginBackgroundImg.png" class="imgLogin" id="imgLogin" runat="server" />
                </td>

            </tr>
        </table>

    </form>
</body>
</html>

