<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExternalUsers.aspx.vb" Inherits="Website.ExternalUsers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Application_PMWebLogo.ascx" TagName="PMWebLogo" TagPrefix="uc1" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>

    <style type="text/css">
        .divMsgContainer {
            position: relative;
        }
    </style>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var IsIpad = "False";
        function ShowHideCompanyNameBackground(ExistCompanyName) {
            if (ExistCompanyName == "1") {
                $('#divCompanyName').css({ 'display': 'block' });
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
            if (sender.isEmpty()) {
                $get('lblPassword').style.display = 'inline';
            }
        }
        function txtUserBlurred(sender) {
            return
        }
        $(window).on('load', function () {
            if (window.getComputedStyle(document.getElementById('txtPassword')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtPassword').value == '' && $("#txtPassword").is(':focus') == false) {
                $get('lblPassword').style.display = 'inline';
            }
            if (window.getComputedStyle(document.getElementById('txtUser')).backgroundColor == 'rgb(255, 255, 255)' && document.getElementById('txtUser').value == '' && $("#txtPassword").is(':focus') == false) {
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
            }, 800);


        })
        function showLanguages() {
            var language = $('.language');
            language[0].className = language[0].className.replace(' Hide', '')
            return false;
        }
        $(document).ready(function () {
            var today = new Date();
            var year = today.getFullYear();
            $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc.');
            $('body').click(function (e) {
                var q = e.target;
                var targetid = e.target.id
                if (targetid.indexOf('imgSelectedlanguage') >= 0 || targetid.indexOf('rptLanguages') >= 0)
                    return;
                var language = $('.language');
                if (language[0].className.indexOf('Hide') >= 0)
                    return;
                language[0].className = language[0].className + ' Hide';
            })
        })
        function GenerateNewCaptchaImg() {
            $("[id$='CaptchaLinkButton']")[0].click();
            return false;

        }
        function OpenPOPUp(URL) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            let el = wnd.get_popupElement();
            //wnd.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close);
            wnd.set_modal(true);
            wnd.setSize(480, 345);
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
                wnd.setSize(378, 400);
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
        //function OpenForgotPasswordPopup() {
        //    var intDbId = 0;
        //    let qs = new URLSearchParams(window.location.search);
        //    intDbId = qs.get("db");
        //    var strUsername = '';
        //    if ($find('txtUser'))
        //    {
        //        strUsername = $find('txtUser').get_value();
        //    }   
        //    if (strUsername.toLowerCase() == 'admin') {
        //        strUsername = '';
        //        alert('This procedure cannot be used to reset the Admin password!')
        //        return false;
        //    }
        //    if (intDbId != 0)
        //        return OpenPOPUpAngular('ForgotPasswordPopup.aspx?username=' + strUsername, 378, 260, false);
        //    return false;
        //}
        function getElementId(event) {
            var elementid = event.target.id;
            var spans = document.getElementsByClassName('LogInSpan');
            console.log(spans)
            console.log(elementid);
            for (let i = 0; i <= spans.length - 1; i++) {
                if (!spans[i].classList.contains('highlight')) {
                    switch (elementid) {
                        case "cboUsers_Input":
                        case "txtUser":
                            spans[0].classList.add('highlight');
                            break;
                        case "txtPassword":
                            spans[1].classList.add('highlight');
                            break;
                    }
                }
            }
        }

        function btnLogin_Clicked() {
            var strUsername = '';
            var strPwnd = '';

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

            if (strUsername === '' || strPwnd === '')
                return false;
        }

        function spanValidatorsUser() {
            var spans = document.getElementsByClassName('LogInSpan');
            spans[0].textContent = 'User (Required)';
            spans[0].classList.add('EmptyCredentials');

            if ($('#txtUser').length > 0) {
                $('[id="txtUser"').css({ 'border-color': 'red' })
            } else {
                $('[id="cboUsers_Input"').css({ 'border-color': 'red' })

            }
        }

        function spanValidatorsPwnd() {
            var spans = document.getElementsByClassName('LogInSpan');
            spans[1].textContent = 'Password (Required)';
            spans[1].classList.add('EmptyCredentials');
            $('[id="txtPassword"').css({ 'border-color': 'red' })

        }
        function showErrCredentials() {
            const divErrElement = document.getElementById('errCredentials');
            divErrElement.style.visibility = "visible";
        }

    </script>

    <style type="text/css">
        .rcRefreshImage {
            display: none !important;
        }

        .RadCaptcha a {
            top: 0px;
            position: relative;
        }

        .RadCaptcha span {
            position: relative;
            bottom: -90px;
        }

        .Validator br {
            display: none;
        }

        .RadComboBoxDropDown .rcbScroll.rcbWidth {
            width: 100% !important;
        }

        .RadComboBoxDropDown .rcbArrowCell {
            background-image: url(../Images/radFormSprite.png) !important;
            width: 24px !important;
            height: 24px !important;
        }

        /*.RadComboBox .rcbArrowCellRight {
            background-position: 5px;
        }*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
            <%-- <link href="CSS/MainCss.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />--%>
            <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
            <link href="CSS/ControlsCSS/Window.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
            <link href="CSS/ControlsCSS/Combobox.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
            <style type="text/css">
                /*.RadComboBox .rcbArrowCellRight, .RadComboBox .rcbHovered .rcbArrowCellRight, .RadComboBox .rcbFocused .rcbArrowCellRight {
                    background-position: 5px;
                }*/

                .VendorInput {
                    width: 100%;
                    height: 24px;
                    line-height: 24px;
                    color: #000000;
                    background: #FFFFFF;
                    border: 1px solid #666;
                    border-radius: 0px;
                    box-sizing: border-box;
                }

                .languageFlags {
                    text-align: right;
                    vertical-align: middle;
                }

                .labelWidth {
                    width: 160px;
                    height: 24px;
                    line-height: 24px;
                    background: #FFFFFF;
                    color: #666666 !important;
                    min-width: 160px;
                    vertical-align: top;
                }

                .controlWidth {
                    width: 100% !important;
                    max-width: 240px;
                }

                .colTable > tbody > tr > td {
                    padding: 0 0 5px 0;
                }

                .btn {
                    border: 1px solid #666666;
                    text-align: center;
                    text-transform: uppercase;
                    color: #666666;
                    line-height: 1.8;
                    border-radius: 2px;
                    background-color: #FFFFFF;
                    vertical-align: central;
                    height: 32px;
                    text-decoration: none;
                    width: 100%;
                    display: table-cell;
                    cursor: pointer;
                    border-radius: 5px;
                    padding: 1px 1px 1px 1px !important;
                    margin-right: 0px;
                }

                .txtValidatorColor {
                    color: rgb(255,36,0);
                }

                .tdaccount {
                    padding-left: 20px;
                }

                @media screen and (max-width: 880px) {
                    .tdImgLogin {
                        display: table-cell;
                    }

                    #SideBar {
                        width: 400px;
                    }

                    .tdaccount {
                        padding-left: 8px;
                    }
                }

                @media screen and (max-width: 835px) {
                    #tblMainTable {
                        margin-bottom: 10px;
                    }

                    .tdImgLogin {
                        display: table-cell;
                        width: 100% !important;
                        float: left;
                    }

                    #SideBar {
                        width: 100% !important;
                    }

                    .tdaccount {
                        padding-left: 8px;
                    }

                    .tdSidebar {
                        width: 100% !important;
                        float: left;
                    }
                }

                #Vendorlogin {
                    margin-top: 27px;
                    background-color: #ffffff;
                    height: 432px;
                    width: 320px;
                    border-radius: 20px;
                    margin-left: 25px;
                }

                #VendorlicenseAgreement {
                    margin-left: 5px;
                    text-align: left;
                    text-decoration: none;
                    color: white;
                    font-size: 9px;
                    display: block;
                    font-family: 'Roboto', sans-serif;
                    position: relative;
                    top: 115px;
                }

                #Vendorcopyright {
                    bottom: 5px;
                    text-align: left;
                    margin-left: 5px;
                    text-decoration: none;
                    color: white;
                    font-size: 9px;
                    display: block;
                    margin-top: 5px;
                    font-family: 'Roboto', sans-serif;
                    position: relative;
                    top: 124px;
                }

                td.rcbArrowCell.rcbArrowCellRight {
                    width: 24px;
                    height: 24px;
                }
            </style>
        </telerik:RadCodeBlock>
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnApply">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnApply" />
                        <telerik:AjaxUpdatedControl ControlID="cptValidation" />
                        <telerik:AjaxUpdatedControl ControlID="lblUsernameExist" />
                        <telerik:AjaxUpdatedControl ControlID="lblNewPasswordNotConfirmed" />
                        <telerik:AjaxUpdatedControl ControlID="lblCountryRequired" />
                        <telerik:AjaxUpdatedControl ControlID="lblCaptchaError" />
                        <telerik:AjaxUpdatedControl ControlID="txtCaptcha" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <div class="main-container">
            <div class="sidebar">

                <div class="header-section">
                    <asp:Image ID="imgLogo" runat="server" class="logo" ImageUrl="CSS/Images/LoginLogo.png" AlternateText="PMWeb Logo" />
                    <h1 class="title">Welcome to PMWEB 9</h1>
                    <p class="subtitle">Log in to your account to get started</p>
                    <div id="errCredentials" style="visibility: hidden; margin-block: 1px; transform: translateY(5px);">
                        <p class="errorMsg" style="font-size: 1rem">There was a problem</p>
                        <p class="errorMsg" style="font-size: 0.75rem">Please try again</p>
                    </div>
                </div>
                <div class="form-section">
                    <div>
                        <label for="txtUser" class="input-label">User</label>
                        <telerik:RadTextBox ID="txtUser" runat="server" CausesValidation="True" Width="85%"
                            Style="height: 40px;" TabIndex="1" onclick="getElementId(event)" CssClass="form-text-input">
                           <%-- <ClientEvents OnBlur="txtUserBlurred" OnLoad="txtUserBlurred" />--%>
                        </telerik:RadTextBox>
                    </div>

                    <div>
                        <label for="txtPassword" class="input-label">Password</label>
                        <div>
                            <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True"
                                TextMode="Password" AutoCompleteType="None" autocomplete="Off" TabIndex="2" CssClass="form-text-input password"
                                onclick="getElementId(event)">
                            </telerik:RadTextBox>
                            <asp:Label runat="server" ID="lblPassword" Style="display: none;"></asp:Label>
                        </div>
                        <div id="CapsLockDiv" class="Validator" style="display: none">Caps Lock is on</div>

                    </div>
                    <uc2:Message ID="Message1" runat="server" />

                    <div class="options">
                        <%--<div class="checkbox-input">
                    <input id="chkSavePassword" runat="server" type="checkbox" onclick="clearFields(this)" />
                    <label for="chkSavePassword" class="checkbox-label">Remember Me</label>
                </div>--%>
                        <div>
                            <label class="checkbox-container">
                                <input id="chkRememberMe" runat="server" type="checkbox" onclick="clearFields(this)" />
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                    <path d="m 5 13 l 4 4 l 10 -10" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                                </svg>
                                <span class="checkbox-label">Remember Me</span>
                            </label>
                        </div>
                        <div style="display:none;">
                            <asp:LinkButton Id="lbtForgotPassword" CssClass="link" Text="Forgot password" meta:resourceKey="lbtForgotPassword" runat="server" OnClientClick="return OpenForgotPasswordPopup();"></asp:LinkButton>
                            <asp:Label ID="lblForgotPassowrd" meta:resourceKey="lblForgotPassowrd" runat="server" Text="Your password has been sent to your email inbox." Visible="false" Style="color: #FFF; font-size: 11px;"></asp:Label>
                        </div>
                    </div>

                    <div class="loginBtnFont">
                        <asp:Button ID="btnLogin" Text="Log in" runat="server" OnClientClick="return btnLogin_Clicked()" class="login-button" />
                        <asp:Button ID="btnFLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="FLogin" class="login-button" />
                        <asp:Button ID="btnLoginAfterPassChange" CausesValidation="false" CssClass="Hide" runat="server" Text="PLogin" class="login-button" />
                        <asp:Button ID="btnRemindLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="PRemindLogin" class="login-button" />
                    </div>


                </div>

                <div class="footer">
                    <p id="copyrightLabel"></p>
                    <div class="footer-links">
                        <a href="javascript:void(0);" onclick="return OpenPOPUp('AboutPMWeb.aspx')">
                            <asp:Literal runat="server" meta:Resourcekey="lblAboutPMWeb" Text="About PMWeb1"></asp:Literal>
                        </a>
                        <a href="https://help.pmweb.com/pmwebeula.html" target="_blank">Terms Of Use</a>
                        <a href="https://help.pmweb.com/pmwebeula.html" target="_blank">Privacy Policy</a>
                    </div>
                </div>
            </div>
            <div style="flex: 1; background-color:white;">


                <table cellpadding="0" cellspacing="0" style="vertical-align: top; width: 100%; margin-top: 24px;" id="tblMainTable">
                    <tr valign="top">
                        <td valign="top" class="tdaccount" style="float: left">
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; color: #333333; width: 400px; table-layout: fixed">
                                <tr>
                                    <td>
                                        <table style="width: 400px;">
                                            <tr>
                                                <td class="labelWidth" style="width: 90% !important">
                                                    <asp:Label ID="lblLanguage" runat="server" OnClientClick="return showLanguages();"></asp:Label>
                                                </td>
                                                <td style="text-align: right; width: 50px;">
                                                    <asp:ImageButton ID="imgSelectedlanguage" Width="40px"
                                                        OnClientClick="return showLanguages();" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="languageFlags" style="position: relative;" colspan="2">
                                                    <div class="language Hide" style="width: 160px; position: absolute; background-color: white; border: 1px solid gray; right: 0; top: 0; z-index: 999;">
                                                        <asp:Repeater ID="rptLanguages" runat="server" Visible="true">
                                                            <ItemTemplate>
                                                                <table style="width: 100%; border-collapse: separate; border-spacing: 2px;">
                                                                    <tr>
                                                                        <td>
                                                                            <div style="float: left">
                                                                                <asp:Label ID="lblLanguageDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'></asp:Label>
                                                                            </div>
                                                                            <div style="float: right">
                                                                                <asp:ImageButton ID="ImageButton2" Style="padding: -15px" Width="40px" OnClientClick="return CheckDirt2();"
                                                                                    ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description") %>' runat="server"
                                                                                    CausesValidation="false" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath") %>'
                                                                                    AlternateText='<%# DataBinder.Eval(Container.DataItem, "Description") %>' CommandName="LanguageClicked"
                                                                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Code") %>' />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <%-- <asp:ImageButton ID="ImageButton1" Style="padding: -15px" Height="13px" Width="30px" OnClientClick="return CheckDirt2();"
                                                                            ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description") %>' runat="server"
                                                                            CausesValidation="false" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath") %>'
                                                                            AlternateText='<%# DataBinder.Eval(Container.DataItem, "Description") %>' CommandName="LanguageClicked"
                                                                            CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Code") %>' />--%>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 10px;"></td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; color: #333333; table-layout: fixed">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAccount" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblWelcome" meta:resourceKey="lblWelcome" runat="server" Text=""></asp:Label></td>
                                </tr>
                                <tr>
                                    <td style="height: 25px;"></td>
                                </tr>
                            </table>
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; color: #333333; width: 400px; table-layout: fixed">
                                <tr>
                                    <td style="line-height: 25px;">
                                        <asp:Panel ID="pnlExternalUserSignUp" DefaultButton="btnApply" runat="server" Style="color: #333333;">
                                            <table cellpadding="0" cellspacing="0" class="colTable" border="0" style="vertical-align: top; width: 400px;">
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Label runat="server" ID="lblallfieldrequired" meta:resourceKey="lblallfieldrequired" Text="All fields are required."></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblCompanyName" meta:resourceKey="lblCompanyName" runat="server" Text="Company Name*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtCompanyName" CssClass="VendorInput" runat="server" Text="">
                                                        </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Company Name"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvCompanyName">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblFederalTaxId" meta:resourceKey="lblFederalTaxId" runat="server" Text="Federal Tax ID*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtFederalTaxId" CssClass="VendorInput" runat="server" Text="">
                                                        </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvFederalTaxId" runat="server" ControlToValidate="txtFederalTaxId" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Federal Tax ID"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvFederalTaxId">
                                                        </asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblCountry" meta:resourceKey="lblCountry" runat="server" Text="Country*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlCountries" Width="100%" runat="server" Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                            MarkFirstMatch="true" CausesValidation="False" Height="300px" ShowMoreResultsBox="false" EnableVirtualScrolling="True">
                                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="rfvCountries" runat="server" ControlToValidate="ddlCountries" CssClass="txtValidatorColor" ErrorMessage="<br/>Select country"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvCountries">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:Label ID="lblCountryRequired" meta:resourcekey="lblCountryRequired" runat="server" CssClass="txtValidatorColor" Text="Select country" Visible="false" Style="color: #C60000;"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblContactName" meta:resourceKey="lblContactName" runat="server" Text="Contact Name*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtContactName" CssClass="VendorInput" runat="server" Text=""></asp:TextBox>

                                                        <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Contact Name"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvContactName">
                                                        </asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblContactEmail" meta:resourceKey="lblContactEmail" runat="server" Text="Contact Email*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtContactEmail" CssClass="VendorInput" runat="server" Text=""></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvContactEmail" runat="server" ControlToValidate="txtContactEmail" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Contact Email"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvContactEmail">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="revContactEmail" meta:resourceKey="revContactEmail" CssClass="txtValidatorColor" ControlToValidate="txtContactEmail"
                                                            ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                            runat="server" ErrorMessage="example@domain.com" ValidationGroup="Apply" Display="Dynamic">
                                                        </asp:RegularExpressionValidator>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblContactPhone" meta:resourceKey="lblContactPhone" runat="server" Text="Contact Phone*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtContactPhone" CssClass="VendorInput" runat="server" Text=""></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvContactPhone" runat="server" ControlToValidate="txtContactPhone" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Contact Phone"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvContactPhone">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">

                                                        <asp:Label ID="lblUsername" meta:resourceKey="lblUsername" runat="server" Text="Username*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtUsername" CssClass="VendorInput" runat="server" Text="">
                                                        </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Username"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvUsername">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:Label ID="lblUsernameExist" meta:resourcekey="lblUsernameExist" CssClass="txtValidatorColor" runat="server" Text="Username already exists" Visible="false" Style="color: #C60000;"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblSignUpPassword" meta:resourceKey="lblSignUpPassword" runat="server" Text="Password*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtSignUpPassword" CssClass="VendorInput" runat="server" Text="" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvSignUpPassword" runat="server" ControlToValidate="txtSignUpPassword" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Password"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvSignUpPassword">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblReEnterPassword" meta:resourceKey="lblReEnterPassword" runat="server" Text="Re-enter Password*"></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtReEnterPassword" CssClass="VendorInput" runat="server" Text="" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvReEnterPassword" runat="server" ControlToValidate="txtReEnterPassword" CssClass="txtValidatorColor" ErrorMessage="<br/>Re-enter Password"
                                                            Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvReEnterPassword">
                                                        </asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Label ID="lblNewPasswordNotConfirmed" runat="server" meta:resourcekey="lblNewPasswordNotConfirmed" Style="color: #C60000;" Text="The passwords you entered don't match." Visible="false"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Button runat="server" CssClass="btn" Width="150px" ID="btngenerateCaptcha" Text="Generate New Image" OnClientClick="return GenerateNewCaptchaImg();" />

                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadCaptcha ID="cptValidation" runat="server" CaptchaLinkButtonText="Generate New Image" EnableRefreshImage="true"
                                                            ErrorMessage="The Code you entered is not valid." Display="None">
                                                            <CaptchaImage RenderImageOnly="true" />
                                                        </telerik:RadCaptcha>
                                                        <asp:Label ID="lblCaptchaError" runat="server" CssClass="txtValidatorColor" meta:resourcekey="lblCaptchaError"></asp:Label>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="labelWidth" style="padding: 0">
                                                        <asp:Label runat="server" ID="lblTypeCaptcha" meta:resourceKey="lblTypeImageText" Text="Type the text from the image above."></asp:Label></td>
                                                    <td class="controlWidth" style="padding: 0">
                                                        <asp:TextBox runat="server" CssClass="VendorInput" ID="txtCaptcha"></asp:TextBox></td>

                                                </tr>
                                                <tr>
                                                    <td class="labelWidth" style="padding: 0"></td>
                                                    <td class="controlWidth" style="padding: 0; padding-top: 5px;">

                                                        <asp:Button ID="btnCancel" CssClass="btn" Width="70px" meta:resourceKey="btnCancel" Text="Cancel" runat="server" Style="float: right;"></asp:Button>
                                                        <asp:Button ID="btnApply" CssClass="btn" Width="70px" meta:resourceKey="btnApply" ValidationGroup="Apply" runat="server" Text="Apply" Style="float: right; margin-right: 20px;" />


                                                    </td>

                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>


                            </table>
                        </td>
                    </tr>
                </table>

            </div>
        </div>

        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
