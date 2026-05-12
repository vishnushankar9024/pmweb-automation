<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="Website._default" EnableSessionState="True" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWEB</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <%--<link href="CSS/ControlsCSS/Combobox.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />--%>
        <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
        <link href="CSS/ControlsCSS/Window.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
    </telerik:RadCodeBlock>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .divMsgContainer {
            position: relative;
            display: none;
        }

        a.saml {
        }
        /*tr.rwTitleRow, td.rwCorner, tr.rwFooterRow {
            display: none;
        }*/
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
                let el = wnd.get_popupElement();
                //wnd.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close);
                wnd.set_modal(true);
                wnd.setSize(480, 365);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                wnd.set_visibleStatusbar(false);
                wnd.set_visibleTitlebar(false);
                wnd.set_destroyOnClose(false);
                wnd.center();

                $(el).find("tr.rwTitleRow, td.rwCorner, tr.rwFooterRow").remove();
                $(el).find(".rwWindowContent").css("border-radius", "20px");
                $(el).find(".rwWindowContent").css("box-shadow", "0px 0px 1rem rgba(0, 0, 0, 0.3)");
                //$(el).find(".rwWindowContent").css("overflow", "hidden");
                $(el).find('iframe').css("border-radius", "20px");

                return false;
            }

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


                }
                else if (URL.includes('ForgotPasswordPopup.aspx')) {
                    wnd.setSize(408, 420);
                    wnd.Center();
                }
                else if (browserWidth > 600) {
                    wnd.setSize(600, 400);
                    wnd.Center();
                }

                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }

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


            function firstTimeOpenPopUp(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                wnd.set_behaviors('none');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else if (browserWidth > 600) {
                    wnd.setSize(500, 400);
                    wnd.Center();
                }
            }

            function OpenChangePasswordPopup(URL) {
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
                wnd.set_behaviors('none');
                wnd.set_modal(false);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else if (browserWidth > 600) {
                    wnd.setSize(388, 650);
                    wnd.Center();
                }
            }

            function manyTimesOpenPopUp(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                wnd.set_behaviors('none');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else if (browserWidth > 600) {
                    wnd.setSize(490, 280);
                    wnd.Center();
                }
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
                    return OpenPOPUpAngular('ForgotPasswordPopup.aspx?username=' + strUsername, 378, 260, false);
                return false;
            }

            function OpenFirstTimeMFA() {
                setTimeout(function () { return firstTimeOpenPopUp('TwoFactorAuthPopUp.aspx', 480, 260, false); }, 500);
            }

            function openManyTimesMFA() {
                setTimeout(function () { return manyTimesOpenPopUp('TwoFactorAuthPopUp.aspx', 480, 260, false); }, 500);
            }

            function getParameterByName(name) {
                var url = window.location.href;
                name = name.replace(/[\[\]]/g, '\\$&');
                var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                    results = regex.exec(url);
                if (!results) return '';
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, ' '));
            }

            function btnLogin_Clicked() {
                var strUsername = '';
                var strPwnd = '';
                var intDbId = 0;
                if ($find('cboDatabases')) {
                    strDatabase = $find('cboDatabases').get_text();
                }
                if ($find('cboUsers')) {
                    strUsername = $find('cboUsers').get_text();
                } else {
                    if ($find('txtUser')) { strUsername = $find('txtUser').get_value(); }
                }
                if ($find('txtPassword')) {
                    strPwnd = $find('txtPassword').get_value();
                }

                if (strUsername == '') {
                    spanValidatorsUser();

                }

                if (strPwnd == '') {
                    spanValidatorsPwnd();
                }

                if (strDatabase == '') {
                    spanValidatorsDatabase();
                }

                if (strUsername === '' || strPwnd === '' || strDatabase === '')
                    return false;

                var redirect = false;
                intDbId = $find('cboDatabases').get_value();
                if (intDbId > 0) {
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/RedirectToSAML",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ strUserName: strUsername, intDbId: intDbId }),
                        dataType: "json",
                        async: false,
                        success: function (response) {
                            if (response.d.length > 0) {
                                var linkto = encodeURIComponent(getParameterByName('linkto'));
                                if (linkto.length > 0) {
                                    window.location.href = response.d + '?linkto=' + linkto;
                                } else {
                                    window.location.href = response.d;
                                }
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
                //  setCookie('PMWebUser', sender.get_text(), 60);
                RedirectToSAML(sender.get_text());
            }

            function txtUserBlurred(sender) {
                //setCookie('PMWebUser', sender.get_value(), 60);
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
                        data: JSON.stringify({ strUserName: argUserName, intDbId: intDbId }),
                        dataType: "json",
                        async: false,
                        success: function (response) {
                            if (response.d.length > 0) {
                                var linkto = encodeURIComponent(getParameterByName('linkto'));
                                if (linkto.length > 0) {
                                    window.location.href = response.d + '?linkto=' + linkto;
                                } else {
                                    window.location.href = response.d;
                                }
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
                        data: JSON.stringify({ isChecked: document.getElementById('chkSavePassword').checked }),
                        dataType: "json",
                        async: false,
                        success: function (response) {

                        }
                    });


                }

            }

            function getElementId(event) {
                var elementid = event.target.id;
                var spans = document.getElementsByClassName('LogInSpan');
                for (let i = 0; i <= spans.length - 1; i++) {
                    if (spans[i].classList.contains('EmptyCredentials')) {
                        spans[i].classList.remove('highlight');
                        spans[i].classList.add('EmptyCredentials');
                        break;
                    }
                    if (!spans[i].classList.contains('EmptyCredentials')) {
                        switch (elementid) {
                            case "cboDatabases_Input":
                                spans[0].classList.add('highlight')
                                break;
                            case "cboUsers_Input":
                            case "txtUser":
                                spans[1].classList.add('highlight')
                                break;
                            case "txtPassword":
                                spans[2].classList.add('highlight')
                                break;

                        }
                    }
                }
            }

            function spanValidatorsDatabase() {
                var spans = document.getElementsByClassName('LogInSpan');
                spans[0].textContent = 'Database (Required)';
                spans[0].classList.remove('highlight');
                spans[0].classList.add('EmptyCredentials');
                $('[id="cboDatabases"')[0].classList.add('pwnd-error');

            }

            function spanValidatorsUser() {
                var spans = document.getElementsByClassName('LogInSpan');
                spans[1].textContent = 'User (Required)';
                spans[1].classList.remove('highlight');
                spans[1].classList.add('EmptyCredentials');

                if ($find('txtUser')) {
                    $('[id="txtUser_wrapper"')[0].classList.add('pwnd-error');
                }
                else {
                    $('[id="cboUsers"')[0].classList.add('pwnd-error');
                }
            }

            function spanValidatorsPwnd() {
                var spans = document.getElementsByClassName('LogInSpan');
                spans[2].textContent = 'Password (Required)';
                spans[2].classList.remove('highlight');
                spans[2].classList.add('EmptyCredentials');
                $('[id="Password"')[0].classList.add('pwnd-error');
            }

            //function showErrCredentials() {
            //    const divErrElement = document.getElementById('errCredentials');
            //    divErrElement.style.visibility = "visible";
            //}

            function closeDDL(sender, eventArgs) {
                //if (sender.get_dropDownVisible()) {
                //    sender.hideDropDown();
                //}
            }

            function onComboxOpen(sender, eventArgs) {
                //if (sender.get_dropDownVisible()) {
                //    eventArgs.set_cancel(true);
                //}
            }

            document.addEventListener('DOMContentLoaded', function (event) {
                <%--var elements = document.getElementsByClassName('AngularControlDDLArrow');

                elements[0].addEventListener('click', function (event) {
                    if (event.target.closest('.rcbInputCell')) {
                        return;
                    }
                    var comboBoxDb = $find('<%= cboDatabases.ClientID  %>');
                    if (!comboBoxDb.get_dropDownVisible()) {
                        comboBoxDb.showDropDown();
                    } else {
                        comboBoxDb.hideDropDown();
                    }

                });

                elements[1].addEventListener('click', function (event) {
                    if (event.target.closest('.rcbInputCell')) {
                        return;
                    }
                    var comboBoxUsers = $find('<%= cboUsers.ClientID  %>');

                    if (!comboBoxUsers.get_dropDownVisible()) {
                        comboBoxUsers.showDropDown();
                    } else {
                        comboBoxUsers.hideDropDown();
                    }

                });--%>

                let arrowButtons = document.querySelectorAll(".form-ddl-input .rcbArrowCell");
                arrowButtons.forEach(arrow => {
                    arrow.addEventListener("click", e => {
                        let comboElement = arrow.closest(".RadComboBox");
                        if (!comboElement) {
                            return;
                        }
                        let combo = $find(comboElement.id);
                        if (combo) {
                            e.preventDefault();
                            e.stopPropagation();
                            combo.toggleDropDown();
                        }
                    })
                });
                let labels = document.querySelectorAll(".form-ddl-input label");
                labels.forEach(label => {
                    label.addEventListener("click", e => {
                        let comboElement = label.closest(".RadComboBox");
                        if (!comboElement) {
                            return;
                        }
                        let combo = $find(comboElement.id);
                        if (combo) {
                            e.preventDefault();
                            e.stopPropagation();
                            combo.toggleDropDown();
                        }
                    })
                })

            });

        </script>
        <script language="javascript" type="text/javascript">

            function PasswordChangeNotAllowed() {
                alert("Your password has expired. Please contact your PMWeb administrator for assistance.")
                return false;
            }

            function OpenChangePassword() {
                setTimeout(function () { return OpenChangePasswordPopup('ChangePasswordPopup.aspx', 480, 260, false); }, 500);
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
                $('#copyrightLabel').html('© 2007-' + year + ' PMWEB, Inc.');


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

            function selectedItem(sender, args) {
                var elmnt = $('[id=cboUsers_DropDown]')[0];

                elmnt.firstChild.firstChild.childNodes.forEach(element => {
                    if (element.classList.contains('rcbSelected')) {
                        element.classList.remove('rcbSelected');
                        element.classList.add('rcbItem');
                    }
                });

                sender.get_selectedItem()._removeClassFromElement('rcbHovered');
                sender.get_selectedItem().set_cssClass('rcbSelected');
            }

            function selectedItemDb(sender, args) {
                var elmnt = $('[id=cboDatabases_DropDown]')[0];

                elmnt.firstChild.firstChild.childNodes.forEach(element => {
                    if (element.classList.contains('rcbSelected')) {
                        element.classList.remove('rcbSelected');
                        element.classList.add('rcbItem');
                    }
                });
                sender.get_selectedItem()._removeClassFromElement('rcbHovered');
                sender.get_selectedItem().set_cssClass('rcbSelected');
            }

            function userDDLLoad() {
                elmnt.firstChild.firstChild.childNodes.forEach(element => {
                    if (element.classList.contains('rcbHovered')) {
                        element.classList.remove('rcbHovered');
                        element.classList.add('rcbSelected');
                    }
                });
            }

            function showErrCredentials() {
                const divErrElement = document.getElementById('errCredentials');
                divErrElement.style.visibility = "visible";
            }

        </script>
    </telerik:RadCodeBlock>
</head>


<body>
    <form id="form1" runat="server" style="background-color:lightgray">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />

        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>

        <div class="main-container">
            <div class="sidebar">

                <div class="header-section">
                    <asp:Image ID="imgLogo" runat="server" class="logo" ImageUrl="CSS/Images/LoginLogo.png" AlternateText="PMWeb Logo" />
                    <h1 class="title">Welcome to PMWEB 2025</h1>
                    <p class="subtitle">Log in to your account to get started</p>
                    <div id="errCredentials" style="visibility: hidden; margin-block: 1px; transform: translateY(5px);">
                        <p class="errorMsg" style="font-size: 1rem ; line-height:19px">There was a problem</p>
                        <p class="errorMsg" style="font-size: 0.75rem ; line-height:15px">Please try again</p>
                    </div>
                </div>
                <div class="form-section">
                    <div>
                        <%--<label for="cboDatabases_Input" class="input-label">Database</label>--%>
                        <telerik:RadComboBox ID="cboDatabases" runat="server" AutoPostBack="true" CausesValidation="false"
                            CloseDropDownOnBlur="true" Height="232px" TabIndex="1" CssClass="form-ddl-input"
                            DropDownCssClass="form-ddl" ExpandAnimation-Type="None"
                            ExpandAnimation-Duration="0000" CollapseAnimation-Type="None" CollapseAnimation-Duration="0000"
                            Label="Database" LabelCssClass="input-label">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("DatabaseName") %>'></asp:Label>
                                <i class="selected-icon">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" viewBox="20 -237.5 356.2 257.5" stroke="#3654e9" stroke-width="40">
                                        <path d="m 40 -98.7 l 98.7 98.7 l 217.5 -217.5" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </i>
                                <%-- <svg xmlns="http://www.w3.org/2000/svg" width="14" viewBox="19.5858 33.3358 25.08 18.16" fill="#3654e9">
                                        <path d="m 20 44 a 1 1 0 0 1 2 -2 l 6 6 l 14.25 -14.25 a 1 1 0 0 1 2 2 l -15.25 15.25 q -1 1 -2 0 z"  stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>--%>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </div>


                    <div>
                        <telerik:RadComboBox ID="cboUsers" runat="server" Filter="Contains" MarkFirstMatch="true"
                            CloseDropDownOnBlur="true" AllowCustomText="true" Visible="false" CssClass="form-ddl-input"
                            Height="232px" Style="border-radius: 5px;" TabIndex="2" OnClientFocus="closeDDL" OnClientDropDownOpening="onComboxOpen"
                            DropDownCssClass="form-ddl" OnClientSelectedIndexChanged="selectedItem" ExpandAnimation-Type="None"
                            ExpandAnimation-Duration="0000" CollapseAnimation-Type="None" CollapseAnimation-Duration="0000"
                            Label="User" LabelCssClass="input-label">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                                <i class="selected-icon">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" viewBox="20 -237.5 356.2 257.5" stroke="#3654e9" stroke-width="40">
                                        <path d="m 40 -98.7 l 98.7 98.7 l 217.5 -217.5" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </i>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                        <div>
                           <asp:Label ID="lblUser" runat="server" Text="User" CssClass="input-label" Visible="false"></asp:Label>
                            <telerik:RadTextBox ID="txtUser" runat="server" CausesValidation="True" CssClass="form-text-input"  Width="85%" Visible="false"
                                       Style="height: 40px;" TabIndex="2">
                              </telerik:RadTextBox>
                        </div>
                        
                    </div>

                    <div>
                        <label for="txtPassword" class="input-label">Password</label>
                        <div>
                            <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True"
                                TextMode="Password" AutoCompleteType="None" autocomplete="Off" TabIndex="3" CssClass="form-text-input password">
                            </telerik:RadTextBox>
                            <asp:Label runat="server" ID="lblPassword" Style="display: none;"></asp:Label>
                        </div>
                        <div id="CapsLockDiv" class="Validator" style="display: none">Caps Lock is on</div>

                    </div>
                    <uc1:Message ID="Message1" runat="server" />

                    <div class="options">
                        <%--<div class="checkbox-input">
                            <input id="chkSavePassword" runat="server" type="checkbox" onclick="clearFields(this)" />
                            <label for="chkSavePassword" class="checkbox-label">Remember Me</label>
                        </div>--%>
                        <div>
                            <label class="checkbox-container">
                                <input id="chkSavePassword" runat="server" type="checkbox" onclick="clearFields(this)" />
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path d="m 5 13 l 4 4 l 10 -10" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                                </svg>
                                <span class="checkbox-label">Remember Me</span>
                            </label>
                        </div>
                        <div>
                            <asp:LinkButton class="link" Text="Forgot password" meta:resourceKey="lbtForgotPassword" runat="server" OnClientClick="return OpenForgotPasswordPopup();"></asp:LinkButton>
                            <asp:Label ID="lblForgotPassowrd" meta:resourceKey="lblForgotPassowrd" runat="server" Text="Your password has been sent to your email inbox." Visible="false" Style="color: #FFF; font-size: 11px;"></asp:Label>
                        </div>
                    </div>

                    <div class="loginBtnFont">
                        <asp:Button ID="btnLogin" Text="Log in" runat="server" OnClientClick="return btnLogin_Clicked()" class="login-button" />
                        <asp:Button ID="btnFLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="FLogin" class="login-button" />
                        <asp:Button ID="btnLoginAfterPassChange" CausesValidation="false" CssClass="Hide" runat="server" Text="PLogin" class="login-button" />
                        <asp:Button ID="btnRemindLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="PRemindLogin" class="login-button" />
                    </div>

                    <div class="vendors">
                        <asp:Repeater ID="rptLinks" runat="server">
                            <ItemTemplate>
                                <li>
                                    <asp:HyperLink ID="hplLink2" runat="server"></asp:HyperLink>
                                    <asp:HyperLink ID="hplLink1" runat="server"></asp:HyperLink>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                        <%-- <asp:LinkButton runat="server" ID="btnHelp" OnClientClick="return OpenPOPUp('AboutPMWeb.aspx')" Style="color: white !important; margin-top: 50px; display: none">
                    <div class="HeaderMenuHelp">&nbsp;</div><span><asp:Literal  runat="server" meta:Resourcekey="btnAbout" /></span>
    </asp:LinkButton>--%>
                    </div>
                </div>


                <div class="footer">
                    <p id="copyrightLabel"></p>
                    <div class="footer-links">
                        <a href="javascript:void(0);" onclick="return OpenPOPUp('AboutPMWeb.aspx')">
                            <asp:Literal runat="server" meta:Resourcekey="btnAbout">  </asp:Literal>
                        </a>
                        <a href="https://www.pmweb.com/eula" target="_blank">License Agreement</a>
                       <%-- <a href="https://help.pmweb.com/pmwebeula.html" target="_blank">Privacy Policy</a>--%>
                    </div>
                </div>
            </div>
            <div style="flex: 1">
             <%--   <video class="mirrored" width="1024" autoplay loop muted playsinline
                    onerror="this.style.display='none'; document.getElementById('imgLogin').style.display='block';">
                    <source src="Images/login/login.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>--%>
                <img src="CSS/Images/LoginBackgroundImg.png" style=" width: 100%;" class="imgLogin" id="imgLogin" runat="server" alt="Login Background Image" />
            </div>
        </div>
    </form>
</body>
</html>
