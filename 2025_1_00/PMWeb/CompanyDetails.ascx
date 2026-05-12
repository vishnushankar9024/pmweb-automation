<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CompanyDetails.ascx.vb"
    Inherits="Website.CompanyDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<table width="100%" border="0">
    <tr>
        <td valign="top" style="width: 400px; padding-top: 7px">
            <asp:Panel ID="pnlCompanyDetails" runat="server">
                <table width="390px" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table width="150px" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 100px">
                                        <asp:Label ID="lblOccupant" meta:Resourcekey="lblOccupant" runat="server" Text="Occupant"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="chkOccupant" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblApprovedBidder" runat="server" Text="Approved Bidder" meta:Resourcekey="lblApprovedBidder">
                                        </asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkApprovedBidder" runat="server" Checked="true" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblPrimary" runat="server" Text="Primary (From Addresses Tab)" meta:Resourcekey="lblPrimary"></asp:Label>
                                </legend>
                                <table>
                                    <tr>
                                        <td style="width: 100px">
                                            <asp:Label ID="lblPrimaryAddress" meta:resourcekey="lblPrimaryAddress" runat="server" Text="Address"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPrimaryAddress" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:TextBox ID="txtAddress" runat="server" Width="250px" TextMode="MultiLine" Height="51px"
                                                Rows="3"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPhone" meta:resourcekey="lblPhone" runat="server" Text="Phone"></asp:Label>
                                        </td>
                                        <td>
                                            <table style="width: 250px;" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <telerik:RadMaskedTextBox ID="txtPhone" runat="server" DisplayMask="###-###-####"
                                                            Mask="###-###-####" TextWithLiterals="--" Width="125px">
                                                        </telerik:RadMaskedTextBox>
                                                    </td>
                                                    <td align="center">
                                                        <asp:Label ID="lblExt" meta:resourcekey="lblExt" runat="server" Text="Ext" Width="50px"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <telerik:RadMaskedTextBox ID="txtExt" Width="67px" Height="15px" runat="server" DisplayMask="#####-####"
                                                            Mask="#####-####">
                                                        </telerik:RadMaskedTextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblFax" meta:resourcekey="lblFax" runat="server" Text="Fax"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="txtFax" runat="server" DisplayMask="###-###-####" Mask="###-###-####"
                                                TabIndex="2" TextWithLiterals="--" Width="125px" Height="15px">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblEmail" meta:resourcekey="lblEmail" runat="server" Text="Email"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmail" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblWebsite" meta:resourcekey="lblWebsite" runat="server" Text="Website"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtWebsite" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label runat="server" ID="lblTags" meta:resourcekey="lblTags" Text="Tags"></asp:Label></legend>
                                <table>
                                    <tr>
                                        <td style="width: 100px">
                                            <asp:LinkButton runat="server" ID="btnlatitude" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnlatitude" Text="Latitude"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtlatitude" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:LinkButton runat="server" ID="btnLongitude" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnLongitude" Text="Longitude"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLongitude" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:LinkButton runat="server" ID="btnElevation" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnElevation" Text="Elevation"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtElevation" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleCompanyAddressesPicker();" meta:resourcekey="btnGoogleAddress" Text="Google Address"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="250px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
        <td valign="top">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <uc7:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
