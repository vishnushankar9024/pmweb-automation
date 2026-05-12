<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="Website._default" EnableSessionState="True" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <link href="CSS/ControlsCSS/Combobox.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
        <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
        <link href="CSS/ControlsCSS/Window.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
    </telerik:RadCodeBlock>
 
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .divMsgContainer {
            position: relative;
        }

        a.saml {
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var IsIpad = "False";

            function ConfirmDelete() { return confirm('Are you sure you want to change your password?'); }
            var CookieName = '<%= FormsAuthentication.FormsCookieName%>';
            function OpenPOPUp(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                wnd.set_behaviors('none');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else if(browserWidth>600)
                {
                    wnd.setSize(600, 400);
                    wnd.Center();
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function OpenForgotPasswordPopup() {
                var intDbId = 0;
                intDbId = $find('cboDatabases').get_value();
                var strUsername = '';
                if ($find('cboUsers')) {
                    strUsername = $find('cboUsers').get_text();
                } else {
                    if ($find('txtUser')) { strUsername = $find('txtUser').get_value(); }
                }
                if (strUsername.toLowerCase() == 'admin') {
                    strUsername = '';
                    alert('This procedure cannot be used to reset the Admin password!')
                    return false;
                }
                if (intDbId != 0)
                    return OpenPOPUp('ForgotPasswordPopup.aspx?username=' + strUsername, 480, 260, false);
                return false;
            }

            function btnLogin_Clicked() {
                var strUsername = '';
                var intDbId = 0;
                if ($find('cboUsers')) {
                    strUsername = $find('cboUsers').get_text();
                } else {
                    if ($find('txtUser')) { strUsername = $find('txtUser').get_value(); }
                }

                if (strUsername == '')
                    return false
                var redirect = false;
                intDbId = $find('cboDatabases').get_value();
                if (intDbId > 0) {
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/RedirectToSAML",
                        contentType: "application/json; charset=utf-8",
                        data: "{'strUserName':'" + strUsername + "','intDbId':'" + intDbId + "'}",
                        dataType: "json",
                        async: false,
                        success: function (response) {
                            if (response.d.length > 0) {
                                window.location.href = response.d;
                                redirect = true;
                            } else {
                                redirect = false;
                            }
                        }
                    });
                }
                if (redirect == true) return false;
            }


            function OnClientTextChange(sender, eventArgs) {
                setCookie('PMWebUser', sender.get_text(), 60);
                RedirectToSAML(sender.get_text());
            }

            function txtUserBlurred(sender) {
                setCookie('PMWebUser', sender.get_value(), 60);
                RedirectToSAML(sender.get_value());
            }

            function RedirectToSAML(argUserName) {
                var intDbId = 0;
                intDbId = $find('cboDatabases').get_value();
                if (intDbId > 0) {
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/RedirectToSAML",
                        contentType: "application/json; charset=utf-8",
                        data: "{'strUserName':'" + argUserName + "','intDbId':'" + intDbId + "'}",
                        dataType: "json",
                        async: false,
                        success: function (response) {
                            if (response.d.length > 0) {
                                document.location.href = response.d;
                                return false;
                            } else {
                                return true;
                            }
                        }
                    });
                }
            }

            function PasswordExpired() {
                radalert(Msg_PasswordExpired, 450, 200, Msg_TitlePasswordExpired);
                return false;
            }

            function clearFields(s) {
                if (s.checked == false) {

                    $.ajax({
                        type: "POST",
                        url: "default.aspx/ClearCookie",
                        contentType: "application/json; charset=utf-8",
                        data: "{'isChecked':'" + document.getElementById('chkSavePassword').checked + "'}",
                        dataType: "json",
                        async: false,
                        success: function (response) {
                      
                        }
                    });


                }
              
            }
   



        </script>
        <script language="javascript" type="text/javascript">

            function PasswordChangeNotAllowed() {
                alert("Your password has expired. Please contact your PMWeb administrator for assistance.")
                return false;
            }

            function OpenChangePassword() {
                var left = (screen.width - 400) / 2;
                var top = (screen.height - 380) / 2;
                var win = window.open('ChangePasswordPopup.aspx', '',
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=400,height=380,top=' + top + ',left=' + left);
                return false;
            }

            function ShowHideCompanyNameBackground(ExistCompanyName) {
                if (ExistCompanyName == "1") {
                    $('#divCompanyName').css({ 'display': 'block' });
                }
            }

            function getCookie(c_name) {
                var i, x, y, ARRcookies = document.cookie.split(";");
                for (i = 0; i < ARRcookies.length; i++) {
                    x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
                    y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
                    x = x.replace(/^\s+|\s+$/g, "");
                    if (x == c_name) {
                        return unescape(y);
                    }
                }
            }
            $(document).ready(function (n) {
                var today = new Date();
                var year = today.getFullYear();
                $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc. All rights reserved.');


                $(document).keypress(function (e) {
                    kc = e.keyCode ? e.keyCode : e.which;
                    sk = e.shiftKey ? e.shiftKey : ((kc == 16) ? true : false);
                    if (((kc >= 65 && kc <= 90) && !sk) || ((kc >= 97 && kc <= 122) && sk)) {
                        document.getElementById('CapsLockDiv').style.visibility = 'visible';
                    } else {
                        document.getElementById('CapsLockDiv').style.visibility = 'hidden';
                    }
                });

                setCookie('ScreenWidth', document.documentElement.clientWidth, null);
                setCookie('ScreenHeight', document.documentElement.clientHeight, null);

                $(window).resize(function () {
                    RTime = new Date();
                    if (RTimeout == false) {
                        RTimeout = true;
                        setTimeout(WindowResizeEnd, RDelta);
                    }
                });
            });


            var RTime;
            var RTimeout = false;
            var RDelta = 100;

            function WindowResizeEnd() {
                if (new Date() - RTime < RDelta) {
                    setTimeout(WindowResizeEnd, RDelta);
                } else {
                    RTimeout = false;
                    setCookie('ScreenWidth', document.documentElement.clientWidth, null);
                    setCookie('ScreenHeight', document.documentElement.clientHeight, null);
                }
            }

            function OnFocus() {
                $get('lblPassword').style.display = 'none';
            }

            function onLabelFocus() {
                $get('lblPassword').style.display = 'none';
                $find('<%= txtPassword.ClientID %>').focus();
            }
            function OnBlur(sender, args) {
                if (sender.isEmpty()) 
                    $get('lblPassword').style.display = 'inline';
                else
                     $get('lblPassword').style.display = 'none';
            }

            function onLoad() {
                if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                    $get('lblPassword').style.display = 'inline';
                }
                else {

                    $get('lblPassword').style.display = 'none';
                }
            }
            $(window).load(function () {
                if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                    $get('lblPassword').style.display = 'inline';
                }
                else {

                    $get('lblPassword').style.display = 'none';
                }

                setTimeout(function () {
                    if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                        $get('lblPassword').style.display = 'inline';
                    }
                    else {

                        $get('lblPassword').style.display = 'none';
                    }
                }, 200);

                setTimeout(function () {
                    if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                        $get('lblPassword').style.display = 'inline';
                    }
                    else {

                        $get('lblPassword').style.display = 'none';
                    }
                }, 400);
                setTimeout(function () {
                    if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                        $get('lblPassword').style.display = 'inline';
                    }
                    else {

                        $get('lblPassword').style.display = 'none';
                    }
                }, 600);
                setTimeout(function () {
                    if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                        $get('lblPassword').style.display = 'inline';
                    }
                    else {

                        $get('lblPassword').style.display = 'none';
                    }
                }, 800);

                setTimeout(function () {
                    if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                        $get('lblPassword').style.display = 'inline';
                    }
                    else {

                        $get('lblPassword').style.display = 'none';
                    }
                }, 1200);

                setTimeout(function () {
                    if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                        $get('lblPassword').style.display = 'inline';
                    }
                    else {

                        $get('lblPassword').style.display = 'none';
                    }
                }, 1500);

            })

        </script>
    </telerik:RadCodeBlock>
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
                    <div id="SideBar">
                        <div id="img_pmweb" style="text-align: center">
                            <asp:Image ID="imgLogo" Style="margin-top: 40px" runat="server" ImageUrl="CSS/Images/PMWeb-Logo-WHite.png" Height="68px" Width="220px" />
                        </div>

                        <div id="login">
                            <table class="tblLogin" style="width: 100%;">
                                <tr>
                                    <td>
                                        <div style="display: inline">
                                            <div class="outerIconComboBox">
                                                <div class="divIcon" style="background-position: -2496px;"></div>
                                            </div>
                                        </div>
                                        <div style="display: inline">
                                            <telerik:RadComboBox ID="cboDatabases" runat="server" CssClass="ddlLogin" meta:Resourcekey="cboDatabases" EmptyMessage="Database" AutoPostBack="true" CausesValidation="false"
                                                CloseDropDownOnBlur="true" Height="150px" Width="84%" Style="margin-bottom: 12px;">
                                            </telerik:RadComboBox>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="height: 0px">
                                        <asp:RequiredFieldValidator runat="server" ID="rfvDatabases" ControlToValidate="cboDatabases"
                                            CssClass="Validator" ForeColor="" Display="Dynamic" meta:Resourcekey="rfvDatabases"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="display: inline" id="iconWithCbo" runat="server" visible="false">
                                            <div class="outerIconComboBox" style="top: 13px">
                                                <div class="divIcon" style="background-position: -1848px;"></div>
                                            </div>
                                        </div>
                                        <div style="display: inline" runat="server" id="iconWithTxt" visible="false">
                                            <div class="outerIcon">
                                                <div class="divIcon" style="background-position: -1848px;"></div>
                                            </div>
                                        </div>
                                        <div style="display: inline">
                                            <telerik:RadComboBox ID="cboUsers" runat="server" Filter="Contains" MarkFirstMatch="true" EmptyMessage="User" meta:Resourcekey="cboUsers"
                                                Width="84%" CloseDropDownOnBlur="true" AllowCustomText="true" OnClientSelectedIndexChanged="OnClientTextChange" CssClass="ddlLogin" Visible="false"
                                                Height="300px" Style="margin-bottom: 8px;">
                                            </telerik:RadComboBox>
                                            <telerik:RadTextBox ID="txtUser" runat="server" CausesValidation="True" Width="85%" Visible="false"
                                                Style="height: 40px;" EmptyMessage="User">
                                                <ClientEvents OnBlur="txtUserBlurred" OnLoad="txtUserBlurred" />
                                            </telerik:RadTextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 0px">
                                        <asp:RequiredFieldValidator runat="server" ID="rfvUsers" ControlToValidate="cboUsers"
                                            CssClass="Validator" ForeColor="" Display="Dynamic" meta:Resourcekey="rfvUsers"></asp:RequiredFieldValidator>
                                         <asp:RequiredFieldValidator runat="server" ID="rfvtxtUsers" ControlToValidate="txtUser"
                                            CssClass="Validator" ForeColor="" Display="Dynamic" meta:Resourcekey="rfvUsers"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="display: inline">
                                            <div class="outerIcon">
                                                <div class="divIcon" style="background-position: -1320px;"></div>
                                            </div>
                                        </div>
                                        <div style="display: inline; position: relative" id="Password">
                                            <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True" ClientEvents-OnBlur="OnBlur" ClientEvents-OnFocus="OnFocus" ClientEvents-OnLoad="onLoad"
                                                TextMode="Password" AutoCompleteType="None" autocomplete="Off">
                                            </telerik:RadTextBox>
                                            <asp:Label runat="server" ID="lblPassword" style="display:none;">Password</asp:Label>
                                        </div>


                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 0px">
                                        <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="txtPassword" Enabled="false"
                                            CssClass="Validator" ForeColor="" Display="Dynamic" meta:Resourcekey="rfvPassword"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <td style="width: 100%;">
                                        <uc1:Message ID="Message1" runat="server" />
                                        <div id="CapsLockDiv" class="Validator" style="visibility: hidden">Caps Lock is on</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="Login_btn">
                                            <asp:Button ID="btnLogin" Text="Login" runat="server" OnClientClick="return btnLogin_Clicked()" class="btnLogin" />
                                            <asp:Button ID="btnFLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="FLogin" class="btnLogin" />
                                            <asp:Button ID="btnLoginAfterPassChange" CausesValidation="false" CssClass="Hide" runat="server" Text="PLogin" class="btnLogin" />
                                            <asp:Button ID="btnRemindLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="PRemindLogin" class="btnLogin" />
                                        </div>
                                    </td>
                                </tr>

                            </table>
                            <table border="0" cellspacing="0" cellpadding="0" style="margin-top: 40px; width: 100%; text-align: center">

                                <tr>

                                    <td style="width: 100%;">
                                        <asp:LinkButton ID="lbtForgotPassword" Style="text-decoration: underline; cursor: hand; color: #FFF !important; text-decoration: none; font-size: 16px" Text="Forgot Your Password?" meta:resourceKey="lbtForgotPassword" runat="server" OnClientClick="return OpenForgotPasswordPopup();"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblForgotPassowrd" meta:resourceKey="lblForgotPassowrd" runat="server" Text="Your password has been sent to your email inbox." Visible="false" Style="color: #FFF; font-size: 11px;"></asp:Label></td>

                                </tr>

                                <tr>
                                    <td style="height: 50px;">
                                        <%--<asp:CheckBox ID="chkSavePassword" TextAlign="Left" ForeColor="White" runat="server" Text="Remember Me" CssClass="mobile-switch-login" />--%>
                                        <asp:Label runat="server" Text="Remember Me" Font-Size="16px" ForeColor="White" Style="vertical-align: bottom; margin-right: 8px"></asp:Label>
                                        <label class="switch">
                                            <input id="chkSavePassword" runat="server" type="checkbox" onclick="clearFields(this)" />
                                            <span class="slider round"></span>
                                        </label>
                                    </td>
                                </tr>





                                <tr>
                                    <td></td>
                                </tr>
                            </table>


                        </div>

                      


                        <div id="out_links">
                            <asp:Repeater ID="rptLinks" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <asp:HyperLink ID="hplLink1" runat="server" Style="color: white !important;text-decoration:none;"></asp:HyperLink>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:LinkButton runat="server"  ID="btnHelp" OnClientClick="return OpenPOPUp('AboutPMWeb.aspx')" style="color:white !important;margin-top:50px;display:block;">
<table><tr><td><div class="HeaderMenuHelp">&nbsp;</div></td><td><span><asp:Literal  runat="server" meta:Resourcekey="btnAbout" /></span></td></tr></table></asp:LinkButton>
                        </div>
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
                    <img src="Images/login/LoginSystemDefault.png" class="imgLogin" id="imgLogin" runat="server" />
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
