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
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
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
                $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc. All rights reserved.');
                $('body').click(function (e) {
                    //debugger;
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
                .RadComboBox .rcbArrowCellRight, .RadComboBox .rcbHovered .rcbArrowCellRight, .RadComboBox .rcbFocused .rcbArrowCellRight {
                    background-position: -307px -176px !important;
                }

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
                                        <div style="display: inline" runat="server" id="iconWithTxt">
                                            <div class="outerIcon">
                                                <div class="divIcon" style="background-position: -1848px;"></div>
                                            </div>
                                        </div>
                                        <div style="display: inline">
                                            <telerik:RadTextBox ID="txtUser" runat="server" CausesValidation="True" Width="85%"
                                                Style="height: 40px;" EmptyMessage="User">
                                                <ClientEvents OnBlur="txtUserBlurred" OnLoad="txtUserBlurred" />
                                            </telerik:RadTextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 0px">
                                        <asp:RequiredFieldValidator runat="server" ID="rfvtxtUsers" ControlToValidate="txtUser" ValidationGroup="Login"
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
                                            <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True" ClientEvents-OnBlur="OnBlur" ClientEvents-OnFocus="OnFocus"
                                                TextMode="Password" AutoCompleteType="None" autocomplete="Off">
                                            </telerik:RadTextBox>
                                            <asp:Label ID="lblPassword" meta:resourceKey="lblPassword" runat="server" Text="Password"></asp:Label>
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
                                        <uc2:Message ID="Message1" runat="server" />
                                        <div id="CapsLockDiv" class="Validator" style="visibility: hidden">Caps Lock is on</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="Login_btn">
                                            <asp:Button ID="btnLogin" Text="Login" runat="server" class="btnLogin"  ValidationGroup="Login" />
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
                                        <asp:LinkButton ID="lbtForgotPassword" Style="text-decoration: underline; cursor: hand; color: #FFF !important; text-decoration: none; font-size: 16px" Text="Forgot Your Password?" meta:resourceKey="lbtForgotPassword"  ValidationGroup="Login" runat="server"></asp:LinkButton>
										<br />
										<span style="color: #FFF !important; text-decoration: none; font-size: 13px">Please contact AMAALA’s PMWeb Support to retrieve the username</span><br /><br />
										<a href="https://cmcs.pmweb.com/7_0_00/pmwebext/vendorapplication/GetManual" target="_blank" style="text-decoration: underline; cursor: hand; color: #FFF !important; text-decoration: none; font-size: 13px">Download Manual</a>
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
                                            <input id="chkRememberMe" runat="server" type="checkbox" />
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

                            <asp:LinkButton runat="server" ID="btnHelp" OnClientClick="return OpenPOPUp('AboutPMWeb.aspx')" Style="color: white !important; margin-top: 50px; display: block;">
                                <table>
                                    <tr>
                                        <td>
                                            <div class="HeaderMenuHelp">&nbsp;</div>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblAboutPMWeb" Text="About PMWeb" meta:resourceKey="lblAboutPMWeb"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:LinkButton>
                        </div>
                        <br />

                        <div id="licenseAgreement">
                            <asp:Label runat="server" ID="lblLicenseAgreement" meta:resourceKey="lblLicenseAgreement" Text="Use of PMWeb is subject to the terms of the license agreement."></asp:Label>

                            <br />
                            <a href="https://help.pmweb.com/pmwebeula.html" target="_blank" style="color: white !important">www.pmweb.com/EULA</a>
                        </div>
                        <div id="copyright">
                            <label id="copyrightLabel"></label>
                        </div>
                    </div>
                </td>
                <td style="width: 100%; height: 360px;" align="left" valign="top" class="tdImgLogin">

                    <table cellpadding="0" cellspacing="0" style="vertical-align: top; width: 100%; height: 100%; margin-top: 24px;" id="tblMainTable">
                        <tr valign="top">
                            <td valign="top" class="tdaccount" style="float: left">
                                <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; color: #333333; width: 400px; table-layout: fixed">
                                    <tr>
                                        <td>
                                            <table style="width: 400px;">
                                                <tr style="display:none">
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
                                                            <asp:Label ID="lblCompanyName" meta:resourceKey="lblCompanyName" runat="server" Text="Company Name*" title="Please enter the registered Company Name"></asp:Label></td>
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
                                                            <asp:Label ID="lblFederalTaxId" meta:resourceKey="lblFederalTaxId" runat="server" Text="Federal Tax ID*" title="Trade License:  Enter the company registration number. Companies registered in KSA, please enter the KSA license number."></asp:Label></td>
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
                                                            <asp:Label ID="lblContactName" meta:resourceKey="lblContactName" runat="server" Text="Contact Name*" title="Enter the Contact Name for any official communication from AMAALA"></asp:Label></td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtContactName" CssClass="VendorInput" runat="server" Text=""></asp:TextBox>

                                                            <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName" CssClass="txtValidatorColor" ErrorMessage="<br/>Enter Contact Name"
                                                                Display="Dynamic" ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfvContactName">
                                                            </asp:RequiredFieldValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblContactEmail" meta:resourceKey="lblContactEmail" runat="server" Text="Contact Email*" title="Enter the Contact Email Id for any official Communication from AMAALA"></asp:Label></td>
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
                                                            <asp:Label ID="lblContactPhone" meta:resourceKey="lblContactPhone" runat="server" Text="Contact Phone*" title="“+(CountryCode)(Phone Number)"></asp:Label></td>
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
                                                            <asp:Label ID="lblSignUpPassword" meta:resourceKey="lblSignUpPassword" runat="server" Text="Password*" title="Minimum 8 Character with atleast 1 uppercase letter & 1 number"></asp:Label></td>
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
                </td>
            </tr>
        </table>

        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
