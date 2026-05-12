<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Asset_SuitesDetails.ascx.vb" Inherits="Website.Asset_SuitesDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLinkedAssets">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLinkedAssets" LoadingPanelID="ldpPM" />
            </UpdatedControls>
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="txtLinkedGross" />
            </UpdatedControls>
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="txtLinkedUsable" />
            </UpdatedControls>
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="txtLinkedRentable" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<table border="0">
    <tr>
        <td valign="top" width="350px">
            <table runat="server" id="tblAddressInfo">
                <tr>
                    <td>
                        <fieldset runat="server" id="fldsetAddress">
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
                        <fieldset runat="server" id="fldsetTags">
                            <legend>
                                <asp:Label ID="lblTags" meta:resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                            </legend>
                            <table>
                                <tr>
                                    <td class="NoWrap">
                                        <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="OpenGoogleSuiteAddressesPicker();" meta:resourcekey="lblGoogleAddress" Text="Google Address11"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode11"></asp:Label>
                                    </td>
                                    <td>
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtBarcode" runat="Server" Width="120px" Style="vertical-align: middle; height: 16px;" MaxLength="255"></asp:TextBox>
                                            <img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" style="vertical-align: middle; cursor: pointer" alt=""
                                                onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','ASSET_SUITES','<%= PM.Asset.SuiteInfo.Id %>')" />
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                        </div>

                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top" width="800px">
            <fieldset runat="server" id="fldsetLinkedAssets">
                <legend>
                    <asp:Label ID="LblLinkedAssets" meta:resourcekey="LblLinkedAssets" runat="server" Text="Linked Assets"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgLinkedAssets" runat="server"
                    HeaderStyle-Font-Size="8" Width="99%"
                    AutoGenerateColumns="False" AllowSorting="True" ShowStatusBar="true" TabIndex="11"
                    AllowMultiRowSelection="true" AllowPaging="true" PageSize="250">
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                        <Columns>
                            <telerik:GridTemplateColumn SortExpression="IsPrimary" HeaderText="Primary" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Primary" HeaderStyle-Width="70px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkPrimary" OnCheckedChanged="chkPrimary_OnChekedChanged" AutoPostBack="true" runat="server" class="switch-mobile" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Property" ItemStyle-Wrap="false"
                                HeaderStyle-Width="130px" Groupable="false" SortExpression="Property">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblLocation" Text='<%#IIf(Container.DataItem("Property").ToString = String.Empty, "&nbsp;", Container.DataItem("Property").ToString)%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Building" UniqueName="Building" ItemStyle-Wrap="false"
                                HeaderStyle-Width="120px" Groupable="false" SortExpression="Building">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblBuilding" Text='<%#IIf(Container.DataItem("Building").ToString = String.Empty, "&nbsp;", Container.DataItem("Building").ToString)%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Floor" UniqueName="Floor" ItemStyle-Wrap="false"
                                HeaderStyle-Width="105px" Groupable="false" SortExpression="Floor">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblFloor" Text='<%#IIf(Container.DataItem("Floor").ToString = String.Empty, "&nbsp;", Container.DataItem("Floor").ToString)%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Space" UniqueName="Space" ItemStyle-Wrap="false"
                                HeaderStyle-Width="105px" Groupable="false" SortExpression="Space">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblSpace" Text='<%#IIf(Container.DataItem("Space").ToString = String.Empty, "&nbsp;", Container.DataItem("Space").ToString)%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Equipment" UniqueName="Equipment" ItemStyle-Wrap="false"
                                HeaderStyle-Width="120px" Groupable="false" SortExpression="Equipment">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblEquipment" Text='<%#IIf(Container.DataItem("Equipment").ToString = String.Empty, "&nbsp;", Container.DataItem("Equipment").ToString)%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdlinkAsset" CommandName="linkAsset" OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=3',1035, 710,true);">
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdUnlinkAsset"
                                    runat="server" SecurityButtonType="ItemMode_Delete" CommandName="UnlinkAsset">
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblDeleteAssets" Text="Delete Assets"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>


                                <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                    <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings Resizing-AllowColumnResize="true">
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                    </ClientSettings>

                </telerik:RadGrid>
            </fieldset>
        </td>
    </tr>
</table>
