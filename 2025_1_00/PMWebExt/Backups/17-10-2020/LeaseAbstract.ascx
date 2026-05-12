<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeaseAbstract.ascx.vb" Inherits="Website.LeaseAbstract" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAssets">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
            </UpdatedControls>

        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMMainPage JustifyContent">
    <div class="row">
        <div class="col-4 col-4-left">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblLessor" meta:resourcekey="lblLessor" runat="server" Text="Lessor"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtLessor" MaxLength="250" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblLessee" meta:resourcekey="lblLessee" runat="server" Text="Lessee"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtLessee" MaxLength="250" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblAddress" meta:resourcekey="lblAddress" runat="server" Text="Address"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtAddress" MaxLength="1000" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtDescription" MaxLength="255" TextMode="MultiLine"  runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSuite" meta:resourcekey="lblSuite" runat="server" Text="Suite"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtSuite" MaxLength="1000" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblComment" meta:resourcekey="lblComment" runat="server" Text="Comment"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtComment" MaxLength="1000" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4 col-4-middle">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblFirstPaymentDate" meta:resourcekey="lblFirstPaymentDate" runat="server" Text="First Payment Date"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <span runat="server" id="rmd_dtpFirstPayement" style="display: block">
                            <telerik:RadDatePicker ID="dtpFirstPayement" runat="server" MinDate="1901-01-01"
                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                <DateInput ID="DateInput3" Skin="Default" runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblLastPaymentDate" meta:resourcekey="lblLastPaymentDate" runat="server" Text="Last Payment Date"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <span runat="server" id="rmd_dtpLastPayment" style="display: block">
                            <telerik:RadDatePicker ID="dtpLastPayment" runat="server" MinDate="1901-01-01"
                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                <DateInput ID="DateInput4" Skin="Default" runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSignedDate" meta:resourcekey="lblSignedDate" runat="server" Text="Signed Date"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <span runat="server" id="rmd_dtpSignedDate" style="display: block">
                            <telerik:RadDatePicker ID="dtpSignedDate" runat="server" MinDate="1901-01-01"
                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                <DateInput ID="DateInput5" Skin="Default" runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblMoveInDate" meta:resourcekey="lblMoveInDate" runat="server" Text="Move-in Date"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <span runat="server" id="rmd_dtpMoveInDate" style="display: block">
                            <telerik:RadDatePicker ID="dtpMoveInDate" runat="server" MinDate="1901-01-01"
                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                <DateInput ID="DateInput1" Skin="Default" runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblMoveOutDate" meta:resourcekey="lblMoveOutDate" runat="server" Text="Move-out Date"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <span runat="server" id="rmd_dtpMoveOutDate" style="display: block">
                            <telerik:RadDatePicker ID="dtpMoveOutDate" runat="server" MinDate="1901-01-01"
                                MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                <DateInput ID="DateInput2" Skin="Default" runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblRentalTerm" meta:resourcekey="lblRentalTerm" runat="server" Text="Rental Term"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlRentalTerm" runat="server" AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblRenewalTerm" meta:resourcekey="lblRenewalTerm" runat="server" Text="Renewal Term"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlRenewalTerm" runat="server" AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblBillingTerm" meta:resourcekey="lblBillingTerm" runat="server" Text="Billing Terms"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlBillingTerms" runat="server" AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4 col-4-right">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblFirstPayement" meta:resourcekey="lblFirstPayement" runat="server" Text="First Payment"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtFirstPayement" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblLastPayment" meta:resourcekey="lblLastPayment" runat="server" Text="Last Payment"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtLastPayment" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblLateFee" meta:resourcekey="lblLateFee" runat="server" Text="Late Fee"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtLateFee" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblDepositRequired" meta:resourcekey="lblDepositRequired" runat="server" Text="Deposit Required"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtDepositRequired" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblDeposit" meta:resourcekey="lblDeposit" runat="server" Text="Deposit Held"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtDeposit" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lbldepositRate" meta:resourcekey="lbldepositRate" runat="server" Text="Deposit Interest Rate"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtdepositeRate" CssClass="Percent" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblAbatement" meta:resourcekey="lblAbatement" runat="server" Text="Abatement"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtAbatement" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblRenewalRent" meta:resourcekey="lblRenewalRent" runat="server" Text="Renewal Rent"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtRenewalRent" CssClass="Currency" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>


