<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PasswordSetup.ascx.vb" Inherits="Website.PasswordSetup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxyPass" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="PasswordToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblPass" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<style type="text/css">
    .passwordsetup label{display:table-cell;}
    .PMMainPage .passwordsetup .RadioCss td{padding-bottom:10px !important;}
    .ToolBar {
           top: 153px !important;
        }
    @media screen and (max-width: 843px) and (min-width: 320px) {
        .ToolBar {
            top: 0px !important;
        }
        .documentSinglePage {
            margin-top: 0px !important;
        }
        .PMMainPage{
            padding-top: 150px;
        }
    }

    .RadioCss > tbody > tr > td {
        padding-bottom: 8px !important;
    }

</style>
<table style="width: 100%;" cellpadding="0" cellspacing="0" >
    <tr class="ToolBar SecurityHomePageToolbar">
        <td class="ToolbarTd">
            <telerik:RadToolBar ID="PasswordToolBar" runat="server" Skin="Default" AutoPostBack="True">
                <Items>
                    <telerik:RadToolBarButton Value="Save" ImageUrl="Images/ToolBar/Save.png"
                        CommandName="Save" CausesValidation="False" AccessKey="s" CssClass="">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
</table>

<div class="PMMainPage">
    <div class="row row-8-4  passwordsetup">
        <div class="col-8" style="padding-left: 0">
            <table runat="server" id="tblPass" cellpadding="0" cellspacing="0" class="colTable">
                <tr>
                    <td>
                        <table class="TableNoSpacingNoBorder">
                            <tr>
                                <td>
                                    <label class="switch">
                                        <input id="chkForcePasswordChangeOnFirstLogIn" runat="server" type="checkbox" />
                                        <span class="slider round"></span>
                                    </label>
                                </td>
                                <td style="padding-left:8px">
                                    <asp:Label ID="lblChk" runat="server" Text="Require users to change password on first log-in" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 15px">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" meta:resourcekey="lblComplexity" Text="Password Complexity" ID="lblComplexity"></asp:Label>
                            </legend>
                            <asp:RadioButtonList ID="rblComplexity" AutoPostBack="False" CssClass="RadioCss RadioPadding"
                                runat="server" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                <asp:ListItem Selected="True" Text="Off" Value="Off" meta:resourcekey="rblComplexity_Off"></asp:ListItem>
                                <asp:ListItem meta:resourcekey="rblComplexity_Low" Text="Low: minimum 6 characters and minimum 1 number" Value="Low">
                                </asp:ListItem>
                                <asp:ListItem meta:resourcekey="rblComplexity_Medium" Text="Medium: minimum 8 characters and 1 Uppercase letter and minimum 1 number" Value="Medium"></asp:ListItem>
                                  <asp:ListItem meta:resourcekey="rblComplexity_High" Text="" Value="High">
                                <%--<asp:ListItem meta:resourcekey="rblComplexity_High" Text="High: Minimum 8 characters, minimum 1 uppercase, 1 number and 1 special character" Value="High">--%>
                                </asp:ListItem>
                            </asp:RadioButtonList>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 15px">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" meta:resourcekey="lblExpiration" Text="Password Expiration" ID="lblExpiration"></asp:Label>
                            </legend>

                            <asp:RadioButtonList ID="rblExpiration" AutoPostBack="true" CssClass="RadioCss RadioPadding"
                                runat="server" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                <asp:ListItem Selected="True" Text="Off" Value="Off" meta:resourcekey="rblComplexity_Off"></asp:ListItem>
                                <asp:ListItem meta:resourcekey="rblComplexity_defaultnumberOfDays" Text="Default number of days" Value="defautNumberOfDays">
                                </asp:ListItem>
                            </asp:RadioButtonList>
                            <div style="padding-left: 10px;">
                                <telerik:RadNumericTextBox ID="rnDays" Visible="false" ShowSpinButtons="true"
                                    IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                    Label="" runat="server" Width="70px"
                                    MinValue="1">
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>
                            </div>
                            <div style="padding-left: 5px;">
                                <asp:CheckBox runat="server" ID="chkForceChange" meta:resourcekey="chkAllowEditExpPass" Text="Allow user to edit expired password(default)" />
                            </div>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 15px">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" meta:resourcekey="lblPasswordhistory" Text="Password History" ID="lblPasswordhistory"></asp:Label></legend>
                            <asp:RadioButtonList ID="rblPasswordHistory" AutoPostBack="true" CssClass="RadioCss RadioPadding"
                                runat="server" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                <asp:ListItem Selected="True" Text="Off" Value="Off" meta:resourcekey="rblComplexity_Off"></asp:ListItem>
                                <asp:ListItem meta:resourcekey="rblPasswordHistory_Low" Text="Low: 1 password. Remember only 1 password and do not allow it to be reused" Value="Low">
                                </asp:ListItem>
                                <asp:ListItem meta:resourcekey="rblPasswordHistory_Medium" Text="Medium: 3 passwords. Remember 3 passwords and do not allow them to be reused" Value="Medium"></asp:ListItem>
                                <asp:ListItem meta:resourcekey="rblPasswordHistory_High" Text="Hight: 5 passwords. Remember 5 passwords and do not allow them to be reused." Value="High">
                                </asp:ListItem>
                            </asp:RadioButtonList>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
