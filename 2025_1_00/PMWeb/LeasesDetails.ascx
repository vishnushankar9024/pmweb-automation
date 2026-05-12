<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LeasesDetails.ascx.vb" Inherits="Website.LeasesDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAssets">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblLinkedAreaInfo" />
            </UpdatedControls>

        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="fldSubLeases">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldSubLeases" />
            </UpdatedControls>

        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<table border="0">
    <tr>
        <td valign="top" width="350px">
            <table>
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
                            <table width="100%" border="0">
                                <tr>
                                    <td class="NoWrap">
                                        <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleLeaseAddressesPicker();" meta:resourcekey="btnGoogleAddress" Text="Google Address"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="250px"></asp:TextBox>
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
                                                onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','LEASE','<%= PM.Asset.LeaseInfo.Id %>')" />
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
        <td valign="top" width="880px">
            <fieldset runat="server" id="fldsetLinkedAssets">
                <legend style="text-align: left">
                    <asp:Label runat="server" ID="lblAssets" meta:resourcekey="lblAssets" Text="Linked Assets"></asp:Label>
                </legend>
                <telerik:RadGrid
                    ID="rdgAssets" runat="server"
                    HeaderStyle-Font-Size="8" Width="860px"
                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" TabIndex="11"
                    AllowMultiRowSelection="true" AllowPaging="true" PageSize="250">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Primary" HeaderStyle-Width="70px" SortExpression="IsPrimary">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkPrimary" OnCheckedChanged="chkPrimary_OnChekedChanged" AutoPostBack="true" runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Suite" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-Width="140px" SortExpression="Suite">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Property" HeaderStyle-Width="140px" SortExpression="Property">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Property") = String.Empty, "&nbsp;", Container.DataItem("Property"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Building" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Building" HeaderStyle-Width="140px" SortExpression="Building">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Floor" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Floor" SortExpression="Floor">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Space" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="115px" UniqueName="Space" SortExpression="Space">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hliSpace" runat="server" CssClass="NoWrap,Link"
                                        Text='<%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%>'
                                        NavigateUrl='<%# "~/Spaces.aspx?Id=" & CStr(iif(Container.DataItem("SpaceId") is system.DBnull.value,"0",Container.DataItem("SpaceId")))%>'></asp:HyperLink>
                                    &nbsp;
                      
                                    <%--  <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span> --%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Equipment" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Equipment" HeaderStyle-Width="140px" SortExpression="Equipment">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="linkAsset" CssClass="GridCmdlinkAsset"
                                    OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=2',1035, 710,true);">
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
            <fieldset id="fldSubLeases" runat="server" style="height: 100%; margin-top: 20px; text-align: center">
                <legend style="text-align: left">
                    <asp:Label runat="server" ID="lblSubLeases" meta:resourcekey="lblSubLeases" Text="Sub-Leases"></asp:Label>
                </legend>
                <telerik:RadGrid
                    ID="rdgSubLeases" runat="server"
                    HeaderStyle-Font-Size="8" Width="860px"
                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" TabIndex="11"
                    AllowMultiRowSelection="true" AllowPaging="true" PageSize="250">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="ID" HeaderStyle-Width="100px" SortExpression="ID">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hliSpace" runat="server" CssClass="NoWrap,Link"
                                        Text='<%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%>'
                                        NavigateUrl='<%# "~/Leases.aspx?Id=" & CStr(iif(Container.DataItem("Id") is system.DBnull.value,"0",Container.DataItem("Id")))%>'></asp:HyperLink>


                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="140px" SortExpression="Description">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="LeaseType" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="LeaseType" HeaderStyle-Width="100px" SortExpression="LeaseType">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("LeaseType") = String.Empty, "&nbsp;", Container.DataItem("LeaseType"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Tenant" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Tenant" HeaderStyle-Width="160px" SortExpression="Tenant">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Tenant") = String.Empty, "&nbsp;", Container.DataItem("Tenant"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="LeaseStart" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="120px" UniqueName="LeaseStart" SortExpression="LeaseStart">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("LeaseStart") Is DBNull.Value, "&nbsp;", Container.DataItem("LeaseStart"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="LeaseEnd" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="120px" UniqueName="LeaseEnd" SortExpression="LeaseEnd">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("LeaseEnd") Is DBNull.Value, "&nbsp;", Container.DataItem("LeaseEnd"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Active" UniqueName="Active" HeaderStyle-Width="60px" ItemStyle-Wrap="false" SortExpression="Active"
                                ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Active"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                        alt="" />
                                </ItemTemplate>

                            </telerik:GridTemplateColumn>
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
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
