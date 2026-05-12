<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Website._Default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PMWeb Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jquery.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>
    <link href="CSS/ComboBox.PM.css" rel="stylesheet" />
    <link href="CSS/Login.css" rel="stylesheet" type="text/css" />


    <%-- <script type="text/javascript">
        function OnClientTextChange(sender, eventArgs) {
            setCookie('PMWebUser', sender.get_text(), 60);
            RedirectToSAML(sender.get_text());
        }
        function txtUserBlurred(sender) {
            setCookie('PMWebUser', sender.get_value(), 60);
            RedirectToSAML(sender.get_value());
        }
        function setCookie(c_name, value, expiredays) {
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + expiredays);
            document.cookie = c_name + "=" + escape(value) +
            ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());
        }

    </script>--%>

    <script type="text/javascript">

        $(document).ready(function (n) {
            var today = new Date();
            var year = today.getFullYear();
            $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc. All rights reserved.');

            $(document).keypress(function (e) {
                kc = e.keyCode ? e.keyCode : e.which;
                sk = e.shiftKey ? e.shiftKey : ((kc == 16) ? true : false);
                if (((kc >= 65 && kc <= 90) && !sk) || ((kc >= 97 && kc <= 122) && sk)) {
                    document.getElementById('trCapsLockDiv').style.display = 'block';
                } else {
                    document.getElementById('trCapsLockDiv').style.display = 'none';
                }
            });
        });

        function OnFocus() {
            $get('lblPassword').style.display = 'none';
        }

        function onLabelFocus() {
            $get('lblPassword').style.display = 'none';
            $find('<%= txtPassword.ClientID %>').focus();
        }
        function OnBlur(sender, args) {
            if (sender.isEmpty()) {
                $get('lblPassword').style.display = 'inline';
            }
        }
        $(window).load(function () {
            if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)') {
                $get('lblPassword').style.display = 'inline';
            }
            else {

                $get('lblPassword').style.display = 'none';
            }

            setTimeout(function () {
                if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)') {
                    $get('lblPassword').style.display = 'inline';
                }
                else {

                    $get('lblPassword').style.display = 'none';
                }
            }, 800);


        })

        function OpenForgotPasswordPopup() {
            debugger;
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
        function isMobileScreen() {
            var browserWidth = $telerik.$(window).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }

        function OpenPOPUp(URL) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            wnd.set_behaviors('none');
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else if (browserWidth > 600) {
                wnd.setSize(600, 400);
                wnd.Center();
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
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
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <table style="width: 100%; height: 100%;">
            <tr>
                <td rowspan="2" class="tdSidebar" valign="top">
                    <div id="SideBar">
                        <div id="img_pmweb" style="text-align: center">
                            <asp:Image ID="imgLogo" Style="margin-top: 40px" runat="server" ImageUrl="Images/PMWeb-Logo-WHite.png" Height="68px" Width="220px" />
                        </div>

                        <h1 id="h1_User_Login">PMWEB ADMIN</h1>

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
                                        <div style="position: relative; top: -5px; left: 0px;">
                                            <div style="display: inline">
                                                <div class="outerIconComboBox">
                                                    <div class="divIcon" style="background-position: -1848px;"></div>
                                                </div>
                                            </div>
                                            <div style="display: inline">
                                                <telerik:RadComboBox ID="cboUsers" runat="server" Filter="Contains" MarkFirstMatch="true" EmptyMessage="User" meta:Resourcekey="cboUsers"
                                                    Width="85%" CloseDropDownOnBlur="true " AllowCustomText="true" OnClientSelectedIndexChanged="OnClientTextChange" CssClass="ddlLogin" Visible="false"
                                                    Height="300px" Style="margin-bottom: 8px;">
                                                </telerik:RadComboBox>
                                                <telerik:RadTextBox ID="txtUser" runat="server" CausesValidation="True" EmptyMessage="User">
                                                    <%--<ClientEvents OnBlur="txtUserBlurred" OnLoad="txtUserBlurred" />--%>
                                                </telerik:RadTextBox>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="width: 100%; text-align: left" class="MarginLeft">
                                            <asp:RequiredFieldValidator runat="server" ID="rfvUsers" ControlToValidate="txtUser" Style="display: inline; position: relative; bottom: 5px;"
                                                CssClass="Validator" ForeColor="" Display="Dynamic" meta:Resourcekey="rfvUsers"></asp:RequiredFieldValidator>
                                        </div>
                                    </td>
                                </tr>
                                <%--      <tr>
                                    <td>
                                        <asp:Label ID="lblPassword" meta:resourcekey="lblPassword" Text="Password" runat="server"
                                            CssClass="login_field"></asp:Label>
                                    </td>
                                    <td style="padding-left: 7px;">
                                        <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True" Width="185px"
                                            Skin="Outlook" TextMode="Password">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <div style="position: relative; left: 0px; top: -5px;">
                                            <div style="display: inline">
                                                <div class="outerIcon">
                                                    <div class="divIcon" style="background-position: -1320px;"></div>
                                                </div>
                                            </div>
                                            <div style="display: inline; position: relative" id="Password">
                                                <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True" ClientEvents-OnBlur="OnBlur" ClientEvents-OnFocus="OnFocus"
                                                    TextMode="Password" AutoCompleteType="None" autocomplete="Off">
                                                </telerik:RadTextBox>
                                                <asp:Label runat="server" ID="lblPassword" onclick="onLabelFocus()">Password</asp:Label>
                                            </div>
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
                                    <td>
                                        <uc1:Message ID="Message1" runat="server" />
                                    </td>
                                </tr>
                                <tr id="trCapsLockDiv" style="display:none;">
                                    <td style="width: 100%;">
                                        <div id="CapsLockDiv" class="Validator" style="padding-left:14px;">Caps Lock is on</div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <div id="Login_btn">
                                            <asp:Button ID="btnLogin" Text="Login" runat="server" class="btnLogin" />
                                            <asp:Button ID="btnFLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="FLogin" class="btnLogin" />
                                            <asp:Button ID="btnLoginAfterPassChange" CausesValidation="false" CssClass="Hide" runat="server" Text="PLogin" class="btnLogin" />
                                            <asp:Button ID="btnRemindLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="PRemindLogin" class="btnLogin" />
                                        </div>
                                    </td>
                                </tr>
                              <%--  <tr>
                                    <td colspan="2" style="text-align: center; padding-top: 40px;">
                                        <asp:LinkButton ID="lbtForgotPassword" Style="text-decoration: underline; cursor: pointer; color: #FFF !important; text-decoration: none; font-size: 16px; display: inline-block;" Text="Forgot Your Password?" meta:resourceKey="lbtForgotPassword" runat="server" OnClientClick="return OpenForgotPasswordPopup();"></asp:LinkButton>
                                    </td>
                                </tr>--%>

                            </table>
                             <table border="0" cellspacing="0" cellpadding="0" style="margin-top: 40px; width: 100%; text-align: center">

                   <%--             <tr>

                                    <td style="width: 100%;">
                                        <asp:LinkButton ID="lbtForgotPassword" Style="text-decoration: underline; cursor: hand; color: #FFF !important; text-decoration: none; font-size: 16px" Text="Forgot Your Password?" meta:resourceKey="lbtForgotPassword" runat="server" OnClientClick="return OpenForgotPasswordPopup();"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblForgotPassowrd" meta:resourceKey="lblForgotPassowrd" runat="server" Text="Your password has been sent to your email inbox." Visible="false" Style="color: #FFF; font-size: 11px;"></asp:Label></td>

                                </tr>--%>

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
                            <%--     <div id="Login_btn">
                                <asp:Button ID="btnLogin" Text="Login" runat="server" />
                            </div>--%>
                        </div>
                        <div style="padding-left: 10px;">
                            <div id="out_links" style="padding-top: 60px">
                                <asp:Repeater ID="rptLinks" runat="server">
                                    <ItemTemplate>
                                        <li>
                                            <asp:HyperLink ID="hplLink1" runat="server" Style="color: white !important;"></asp:HyperLink>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div style="margin-top: 15px"><a href="https://pmweb.com/technical-support/" target="_blank" style="color: white !important">Technical Support</a></div>
                                <div><a href="http://pmweb.com" target="_blank" style="color: white !important">PMWeb.com</a></div>
                            </div>
                            <div id="ClientBox" class="divClientBox" style="padding-top: 85px">
                                <div>
                                    PMWeb Admin Version:
                                <asp:Label runat="server" CssClass="bold" ID="lblVersionNumber" />
                                </div>
                                <div>
                                    Database Version:
                                <asp:Label ID="lblDBVersion" runat="server" CssClass="bold" />
                                </div>

                            </div>
                            <div id="licenseAgreement" style="padding-top: 50px; margin-left: 10px;">
                                <a style="color: white !important">Use of PMWeb is subject to the terms of the license
                            agreement. </a>

                                <a href="https://help.pmweb.com/pmwebeula.html" target="_blank" style="color: white !important">www.pmweb.com/EULA</a>
                            </div>
                            <div id="copyright" style="padding-left: 5px;">
                                <label id="copyrightLabel"></label>
                            </div>
                        </div>

                        <br />


                        <%--                        <div id="info">
                          <%--  <div id="info_img" style="display: block;">
                                <img src="Images/login/login_bck.jpg" />
                            </div>--%>
                        <%--   <div id="info_data">

                                <h2>PMWEB ADMIN </h2>

                            </div>--%>
                        <%-- </div>--%>
                    </div>
                </td>
                <td style="width: 100%; height: 360px; background-color: #7396AA" align="left" valign="top" class="tdImgLogin"></td>
            </tr>
        </table>


    </form>
</body>
</html>
