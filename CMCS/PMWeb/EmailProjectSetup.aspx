<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="EmailProjectSetup.aspx.vb" Inherits="Website.EmailProjectSetup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EmailProjectSetupDetails.ascx" TagName="EmailProjectSetupDetails"
    TagPrefix="uc1" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="RamTemplates" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgSetupIncoming">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSetupIncoming" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <script type="text/javascript">

        function CheckDomainAddress(sender, args) {
            var DomainAddress = args.Value;
            var DomainAddress_array = DomainAddress.split(";");
            var reg = /^\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            for (var i = 0; i < DomainAddress_array.length; i++) {
                if (reg.test(DomainAddress_array[i]) == false) {
                    args.IsValid = false;
                    return;
                }
            }
            args.IsValid = true;
            return;
        }

    </script>

    <style type="text/css">
        body {
            overflow-x: hidden;
        }

        .RadioCss input {
            margin-top: -9px;
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .EmailSetupTabs {
                padding-top: 5px !important;
            }

            .marginBottomOnMobile {
                margin-bottom: 36px !important;
            }

            .documentMultiPages {
                margin-bottom: 0;
             /*   margin-top: 120px !important;*/
            }
          /*  .documentSubToolbar{
                top:77px !important;
            }*/
        }

        @media screen and (max-width: 1323px) and (min-width: 844px) {
            .EmailSetupTabs .rtsLevel.rtsLevel1 {
                width: calc(100vw - 205px) !important;
            }

            .rail .rtsLevel.rtsLevel1 {
                width: calc(100vw - 96px) !important;
            }
        }
        /*.documentMultiPages {
                margin-top: 30px;
            }*/
    </style>

    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <telerik:RadTabStrip runat="server" ID="tbsDocument" Orientation="HorizontalTop" CssClass="EmailSetupTabs" AutoPostBack="true"
                    SelectedIndex="0" MultiPageID="RMP" ShowBaseLine="True" Skin="Default" Width="100%">
                    <Tabs>
                        <telerik:RadTab Text="INCOMING" PageViewID="RP1" Selected="true" Value="INCOMMING" meta:resourcekey="tbsINCOMING" />
                        <telerik:RadTab IsSeparator="true" runat="server" Value="isseparator"></telerik:RadTab>
                        <telerik:RadTab Text="OUTGOING" PageViewID="RP2" Value="OUTGOING" meta:resourcekey="tbsOUTGOING" />
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
    </table>

    <table class="ToolBar " style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CausesValidation="true"
                            ToolTip="<%$ Resources:PMWeb, RadToolBarButton_Save %>" CommandName="Save" ValidationGroup="Save"
                            AccessKey="s">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>"
                            CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Estimating.htm#EmailSetup">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>

    <telerik:RadMultiPage runat="server" ID="RMP" SelectedIndex="0" Width="100%" CssClass="documentMultiPages" >
        <telerik:RadPageView runat="server" ID="RP1">
            <div class="PMMainPage">
                <div class="row R1Col">
                    <div class="col-4 col-4-left">
                        <fieldset>
                            <legend class="legend">
                                <asp:Label runat="server" ID="lblIncoming" meta:resourcekey="lblDefaults" Text="DEFAULTS"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblIncomingAddressDomain" ID="lblIncomingAddressDomain"
                                            Text="Address Domain('@acme.com')"> </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtIncomingAddressDomain"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvIncomingAddressDomain" meta:resourcekey="rfvIncomingAddressDomain" CssClass="Validator"
                                            runat="server" ControlToValidate="txtIncomingAddressDomain" Display="Dynamic" ValidationGroup="Save" ErrorMessage="Required">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator runat="server" ID="cvIncomingAddressDomain" ErrorMessage="Invalid Domain Address"
                                            ControlToValidate="txtIncomingAddressDomain" CssClass="Validator" ClientValidationFunction="CheckDomainAddress"
                                            meta:resourcekey="cvIncomingAddressDomain" Display="Dynamic" ValidationGroup="Save">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblIncomingMailServer" ID="lblIncomingMailServer"
                                            Text="Mail Server (POP3)*"> </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtIncomingMailServerPOP3"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvIncomingMailServerPOP3" meta:resourcekey="rfvIncomingMailServerPOP3" CssClass="Validator"
                                            runat="server" ControlToValidate="txtIncomingMailServerPOP3" Display="Dynamic" ValidationGroup="Save" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblIncomingPortPOP3" ID="lblIncomingPortPOP3"
                                            Text="Port (POP3)"> </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtIncomingPortPOP3" CssClass="PositiveInteger"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvIncomingPortPOP3" meta:resourcekey="rfvIncomingPortPOP3" CssClass="Validator" Display="Dynamic"
                                            runat="server" ControlToValidate="txtIncomingPortPOP3" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblIncomingNote" ID="lblIncomingNote"
                                            Text="Note: Project ID is the Default Address Name('______@acme.com')"> </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblIncomingUserName" ID="lblIncomingUserName"
                                            Text="User Name*"> </asp:Label>
                                    </td>

                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtIncomingUserName"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvIncomingUserName" meta:resourcekey="rfvIncomingUserName" CssClass="Validator"
                                            runat="server" ControlToValidate="txtIncomingUserName" Display="Dynamic" ErrorMessage="Required" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="cvIncomingUserName" runat="server" ErrorMessage="Invalid Email" CssClass="Validator"
                                            meta:resourcekey="cvIncomingUserName" ValidationGroup="Save" Display="Dynamic" ControlToValidate="txtIncomingUserName" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                        </asp:RegularExpressionValidator>
                                    </td>


                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
                <uc1:EmailProjectSetupDetails ID="EmailProjectSetupDetails1" runat="server" />
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView runat="server" ID="RP2" Width="100%">
            <div class="PMMainPage">
                <div class="row documentMultiPages marginBottomOnMobile">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" Text="Mail Server(SMTP)*" meta:resourcekey="lblMailServerSMTP"
                                        ID="lblMailServerSMTP"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" Text="" ReadOnly="true" ID="txtMailServerSMTP" disabled="disabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMailServerSMTP" meta:resourcekey="rfvMailServerSMTP" CssClass="Validator" Display="Dynamic"
                                        runat="server" ControlToValidate="txtMailServerSMTP" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" meta:resourcekey="lblPortSMTP" Text="Port(SMTP)*" ID="lblPortSMTP"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" Text="" ID="txtPortSMTP" ReadOnly="true" disabled="disabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPortSMTP" meta:resourcekey="rfvPortSMTP" runat="server" CssClass="Validator" Display="Dynamic"
                                        ControlToValidate="txtPortSMTP" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" meta:resourcekey="lblFromName" Text="From Name*" ID="lblFromName"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" Text="" ID="txtFromName" ReadOnly="true" disabled="disabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFormName" meta:resourcekey="rfvFormName" runat="server" CssClass="Validator"
                                        ControlToValidate="txtFromName" ErrorMessage="Required" Display="Dynamic"></asp:RequiredFieldValidator>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label meta:resourcekey="lblEmailAddress" runat="server" Text="E-mail Address*"
                                        ID="lblEmailAddress"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" Text="" ID="txtEmailAddress" ReadOnly="true" disabled="disabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmailAddress" meta:resourcekey="rfvEmailAddress" CssClass="Validator"
                                        runat="server" ControlToValidate="txtEmailAddress" ErrorMessage="Required" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmailAddress" runat="server" ErrorMessage="Not valid Email" CssClass="Validator"
                                        meta:resourcekey="revEmailAddress" ControlToValidate="txtEmailAddress" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblRequireAuthentication" meta:resourcekey="chkRequireAuthentication" runat="server"
                                        Text="Require Authentication"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox runat="server" Enabled="false" Text=""
                                        ID="chkRequireAuthentication" Width="100%" />


                                </td>
                            </tr>
                        </table>
                        <table class="colTable" runat="server" id="tblRequireAuthentication" style="text-transform: uppercase; color: #666666;">
                            <tr>
                                <td class="labelWidth"></td>

                                <td class="controlWidth">
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:RadioButton runat="server" GroupName="Credentials" Enabled="false" CssClass="RadioCss"
                                                    ID="rdbUseIncumingCredentials" Checked="true" Text="" Width="100%" />
                                            </td>
                                            <td style="padding-left: 24px;">
                                                <asp:Label ID="lblUseIncumingCredentials" meta:resourcekey="rdbIncumingCredentials" runat="server"
                                                    Text="Use Incoming Credentials"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth"></td>
                                <td class="controlWidth">
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td>
                                                <asp:RadioButton runat="server" GroupName="Credentials" Enabled="false" ID="rdbUseOutgoingCredentials"
                                                    Checked="true" Text="" Width="100%" CssClass="RadioCss" />
                                            </td>
                                            <td style="padding-left: 24px;">
                                                <asp:Label ID="lblUseOutgoingCredentials" meta:resourcekey="rdbOutgoingCredentials" runat="server"
                                                    Text="Use Outgoing Credentials"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                        </table>
                        <table class="colTable" runat="server" id="tblUseOutgoingCredentials">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" meta:resourcekey="lblUserName" Text="User Name" ID="lblUserName"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" Text="" ID="txtUserName" ReadOnly="true" disabled="disabled" Width="100%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvUserName" ValidationGroup="Save" meta:resourcekey="rfvUserName"
                                        runat="server" ControlToValidate="txtUserName" ErrorMessage="Required" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>

                                <td class="labelWidth">
                                    <asp:Label runat="server" meta:resourcekey="lblPassword" Text="Password" ID="lblPassword"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" ID="txtPassword" ReadOnly="true" disabled="disabled" Text="" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
