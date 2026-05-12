<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FloorDetails.ascx.vb" Inherits="Website.FloorDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>

<table style="width: 100%">
    <tr>
        <td style="width: 350px">
            <table>
                <tr>
                    <td>
                        <fieldset style="margin-top: 11px">
                            <legend>
                                <asp:Label ID="lblAddress" meta:resourcekey="lblAddress" runat="server" Text="Address"></asp:Label>
                            </legend>
                            <table width="350px" border="0">
                                <tr>
                                    <td class="NoWrap" width="100px">
                                        <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1" Text="Address 1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap">
                                        <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2" Text="Address 2"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Width="250px" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap">
                                        <asp:Label runat="server" ID="lblCity" meta:resourcekey="lblCity" Text="City"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Width="250px" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server" ID="lblState" meta:resourcekey="lblState" Text="State"></asp:Label>
                                    </td>
                                    <td width="100px">
                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="125px" Skin="Default" DropDownWidth="120px"
                                            Style="font-size: 11px" Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                    <td style="text-align: center; width: 60px">
                                        <asp:Label runat="server" ID="LblZip" meta:resourcekey="lblZip" Text="ZIP"></asp:Label>
                                    </td>
                                    <td width="50px">
                                        <asp:TextBox ID="txtZip" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap">
                                        <asp:Label runat="server" ID="lblCountry" meta:resourcekey="lblCountry" Text="Country"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadComboBox ID="ddlCountries" runat="server" Skin="Default" AllowCustomText="true"
                                            Style="font-size: 11px" Height="400px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap">
                                        <asp:Label runat="server" ID="LblPhone" meta:resourcekey="LblPhone" Text="Phone"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Width="250px" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap">
                                        <asp:Label runat="server" ID="LblFax" meta:resourcekey="LblFax" Text="Fax"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Width="250px" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="padding-left: 10px">
                                    <asp:Label ID="lblComponentType" runat="server" Text="Component Type11" meta:resourcekey="lblComponentType"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="ddlComponentType" runat="server" Width="194px" Skin="Default" Style="font-size: 11px" AllowCustomText="true">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 10px">
                                    <asp:Label ID="lblServiceInterval" runat="server" meta:resourcekey="lblServiceInterval" Text="Service Interval11"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtServiceInterval" MaxLength="15" runat="server" CssClass="PositiveDouble" Width="190px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblTags" meta:resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                            </legend>
                            <table width="100%" border="0">
                                <tr>
                                    <td class="NoWrap">
                                        <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleFloorAddressesPicker();" meta:resourcekey="btnGoogleAddress" Text="Google Address"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                                    </td>
                                    <td>
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtBarcode" runat="Server" Width="120px" Style="vertical-align: middle; height: 16px;" MaxLength="255"></asp:TextBox>
                                            <img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" style="vertical-align: middle; cursor: pointer" alt=""
                                                onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','FLOOR','<%= PM.Asset.FloorInfo.Id %>')" />
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                        </div>

                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top" style="vertical-align: top" class="NoWrap">
            <uc2:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </td>
    </tr>
</table>


