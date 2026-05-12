<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TreeListComponents.ascx.vb" Inherits="Website.TreeListComponents" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <style>
        a, a:visited, a:active {
            /* text-decoration: none; */
            font-size: 11px;
            cursor: pointer;
            color: #666666;
        }
    </style>

</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdtComponents">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtComponents" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="tdCommandBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtComponents" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnGenerateWorkOrder">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdtComponents" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnGenerateWorkOrder" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table cellpadding="0" cellspacing="0" style="width: 100%">
    <tr class="tblCommandRow">
        <td class="rgCommandCell" style="padding-left: 5px">
            <asp:LinkButton ID="lbtAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False"
                SecurityButtonType="ItemMode_Add"
                meta:resourcekey="btnAddItemsResource" OnClientClick="return OpenPopupToRefreshTreeList('EstimateItemsSelect.aspx?SourceId=Components&IsComponent=1', 910, 580);">
                <span class="Icon"></span>
                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
        </td>
        <td>
            <asp:LinkButton ID="lbtPickInventory" runat="server" CommandName="PickInventory" CssClass="GridCmdPickInventory" OnClientClick="return OpenPopupToRefreshTreeList('PickInventory.aspx?Id=1',900, 600);"
                SecurityButtonType="ItemMode_Add">
                <span class="Icon"></span>
                <asp:Label ID="lblPickInventory" meta:resourceKey="lblPickInventory" runat="server" Text="Pick Inventory"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
        </td>
        <td>
            <asp:LinkButton ID="lbtlinkAsset" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="linkAsset" CssClass="GridCmdlinkAsset"
                OnClientClick="return OpenPopupToRefreshTreeList('SelectAsset.aspx?Id=5',1035, 710);">
                <span class="Icon"></span>
                <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)" meta:resourceKey="lblAddAsset"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
        </td>
        <td>
            <asp:LinkButton ID="lbtRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                SecurityButtonType="ItemMode" meta:resourcekey="btnRefreshResource">
                <span class="Icon"></span>
                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
        </td>
        <td>
            <asp:LinkButton ID="btnCreateWorkOrder" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CommandName="CreateWorkOrder" CssClass="GridCmdCreateWorkOrder"
                OnClientClick="return OpenGenerateWorkOrderPopup('GenerateWorkOrderPopup.aspx',450, 250);">
                <span class="Icon"></span>
                <asp:Label runat="server" ID="lblCreateWorkOrder" Text="Create Work Order"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
        </td>
        <td>
            <asp:LinkButton ID="lbtGridView" runat="server" CausesValidation="False" CommandName="GridView" CssClass="GridCmdGridView" OnClientClick="return ClickSwitchComponentsButton()"
                SecurityButtonType="ItemMode_Add" meta:resourcekey="btnTreeListView">
                <span class="Icon"></span>
                <asp:Label ID="lblGridView" runat="server" CssClass="Text" Text="Grid View" meta:resourcekey="lblGridView"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
        </td>
    </tr>
</table>
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadTreeList ID="rdtComponents" runat="server" AllowMultiItemEdit="True" AllowPaging="true" PageSize="250" CssClass="StepsTreeStyle"
                AllowRecursiveDelete="True" AutoGenerateColumns="False" AllowSorting="true" EnableEmbeddedScripts="false"
                AllowMultiItemSelection="True" AllowLoadOnDemand="true" ParentDataKeyNames="GuidId" AlternatingItemStyle-BackColor="#FFFFFF"
                ShowTreeLines="False" EditMode="InPlace" DataKeyNames="GuidId"
                ClientDataKeyNames="Id">
                <ClientSettings AllowItemsDragDrop="False">
                    <Selecting AllowItemSelection="True"></Selecting>
                    <Scrolling AllowScroll="true" UseStaticHeaders="True" />
                </ClientSettings>
                <Columns>
                    <telerik:TreeListTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Width="100px" SortExpression="LineNumber"
                        meta:resourcekey="LineNumber">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLineNumber" Text='<%#Container.DataItem("LineNumber").ToString%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="ID" UniqueName="RecordNumber" HeaderStyle-Width="50px" SortExpression="RecordNumber"
                        meta:resourcekey="RecordNumber">
                        <ItemTemplate>
                            <%#Container.DataItem("RecordNumber")%>&nbsp;
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Asset ID" UniqueName="AssetId" HeaderStyle-Width="70px" SortExpression="AssetId"
                        meta:resourcekey="AssetId">
                        <ItemTemplate>
                            <asp:HyperLink ID="hliAsset" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("EquipmentPostBackUrl").ToString%>'>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Component Type" UniqueName="ComponentType" HeaderStyle-Width="70px" SortExpression="ComponentType"
                        meta:resourcekey="ComponentType">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("ComponentType") = String.Empty, "&nbsp;", Container.DataItem("ComponentType"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-Width="120px" SortExpression="Description"
                        meta:resourcekey="Description">
                        <ItemTemplate>
                            <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Condition" UniqueName="Condition" SortExpression="Condition" HeaderStyle-Width="120px"
                        meta:resourcekey="Condition">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("Condition").ToString = String.Empty, "&nbsp;", Container.DataItem("Condition"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Condition Date" UniqueName="ConditionDate" HeaderStyle-Width="120px"
                        meta:resourcekey="ConditionDate" SortExpression="ConditionDate">
                        <ItemTemplate>
                            <span>
                                <%#FormatDate(Container.DataItem("ConditionDate"))%>&nbsp;</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Last WO" UniqueName="LastWOId" HeaderStyle-Width="190px" SortExpression="LastWOId"
                        meta:resourcekey="LastWOId">
                        <ItemTemplate>
                            <asp:HyperLink ID="hliLastWo" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                Text='<%#Eval("LastWOId").ToString%>' NavigateUrl='<%#Eval("LastWoPostbackUrl").ToString%>'></asp:HyperLink>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Life Remaining" UniqueName="LifeRemaining" HeaderStyle-Width="80px" SortExpression="LifeRemaining"
                        meta:resourcekey="LifeRemaining">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLifeRemaining" Text='<%#FormatNumber(Container.DataItem("LifeRemaining"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="% Remaining" UniqueName="RemainingPercentage" HeaderStyle-Width="100px" SortExpression="RemainingPercentage"
                        meta:resourcekey="RemainingPercentage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblRemainingPercentage" Text='<%#FormatPercent(Container.DataItem("RemainingPercentage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Service Interval Usage" UniqueName="ServiceIntervalUsage" HeaderStyle-Width="100px" SortExpression="ServiceIntervalUsage"
                        meta:resourcekey="ServiceIntervalUsage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblServiceIntervalUsage" Text='<%#FormatNumber(Container.DataItem("ServiceIntervalUsage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Installed Usage" UniqueName="InstalledUsage" HeaderStyle-Width="150px" SortExpression="InstalledUsage"
                        meta:resourcekey="InstalledUsage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblInstalledUsage" Text='<%#FormatNumber(Container.DataItem("InstalledUsage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Last Service Usage" UniqueName="LastServiceUsage" HeaderStyle-Width="100px" SortExpression="LastServiceUsage"
                        meta:resourcekey="LastServiceUsage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLastServiceUsage" Text='<%#FormatNumber(Container.DataItem("LastServiceUsage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Service Due Usage" UniqueName="ServiceDueUsage" HeaderStyle-Width="120px" SortExpression="ServiceDueUsage"
                        meta:resourcekey="ServiceDueUsage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblServiceDueUsage" Text='<%#FormatNumber(Container.DataItem("ServiceDueUsage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Life to Date Usage" UniqueName="LifeToDateUsage" HeaderStyle-Width="120px" SortExpression="LifeToDateUsage"
                        meta:resourcekey="LifeToDateUsage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLifeToDateUsage" Text='<%#FormatNumber(Container.DataItem("LifeToDateUsage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Service by Days" UniqueName="ServiceByDays" HeaderStyle-Width="100px" SortExpression="ServiceByDays"
                        meta:resourcekey="ServiceByDays">
                        <ItemTemplate>
                            <img src='Images/Global/<%# CStr(IIf(Container.DataItem("ServiceByDays"), "checked.png", "unchecked.png")) %>' />
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Service Interval Days" UniqueName="ServiceIntervalDays" HeaderStyle-Width="100px" SortExpression="ServiceIntervalDays"
                        meta:resourcekey="ServiceIntervalDays">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblServiceIntervalDays" Text='<%#FormatNumber(Container.DataItem("ServiceIntervalDays"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Installed Date" UniqueName="InstalledDate" HeaderStyle-Width="120px" SortExpression="InstalledDate"
                        meta:resourcekey="InstalledDate">
                        <ItemTemplate>
                            <span>
                                <%#FormatDate(Container.DataItem("InstalledDate"))%>&nbsp;
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Last Service Date" UniqueName="LastServiceDate" HeaderStyle-Width="120px" SortExpression="LastServiceDate"
                        meta:resourcekey="LastServiceDate">
                        <ItemTemplate>
                            <span>
                                <%#FormatDate(Container.DataItem("LastServiceDate"))%>&nbsp;
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Service Due Date" UniqueName="ServiceDueDate" HeaderStyle-Width="120px" SortExpression="ServiceDueDate"
                        meta:resourcekey="ServiceDueDate">
                        <ItemTemplate>
                            <span>
                                <%#FormatDate(Container.DataItem("ServiceDueDate"))%>&nbsp;
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Life to Date Days" UniqueName="LifeToDateDays" HeaderStyle-Width="120px" SortExpression="LifeToDateDays"
                        meta:resourcekey="LifeToDateDays">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLifeToDateDays1" Text='<%#FormatNumber(Container.DataItem("LifeToDateDays"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Removed Usage" UniqueName="RemovedUsage" HeaderStyle-Width="100px" SortExpression="RemovedUsage"
                        meta:resourcekey="RemovedUsage">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblRemovedUsage" Text='<%#FormatNumber(Container.DataItem("RemovedUsage"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Removed Date" UniqueName="RemovedDate" HeaderStyle-Width="120px" SortExpression="RemovedDate"
                        meta:resourcekey="RemovedDate">
                        <ItemTemplate>
                            <span>
                                <%#FormatDate(Container.DataItem("RemovedDate"))%>&nbsp;
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Manufacturer" UniqueName="Manufacturer" HeaderStyle-Width="120px" SortExpression="Manufacturer"
                        meta:resourcekey="Manufacturer">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Mfr. #" UniqueName="ManufacturerNumber" HeaderStyle-Width="100px" SortExpression="ManufacturerNumber"
                        meta:resourcekey="ManufacturerNumber">
                        <ItemTemplate>
                            <%#Container.DataItem("ManufacturerNumber")%>&nbsp;
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Quantity UOM" UniqueName="QuantityUOM" HeaderStyle-Width="90px" SortExpression="QuantityUOM"
                        meta:resourcekey="QuantityUOM">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("QuantityUOM") = String.Empty, "&nbsp;", Container.DataItem("QuantityUOM"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Quantity" UniqueName="Quantity" HeaderStyle-Width="100px" SortExpression="Quantity"
                        meta:resourcekey="Quantity">
                        <ItemTemplate>
                            <span>
                                <%#FormatNumber(Container.DataItem("Quantity"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" HeaderStyle-Width="100px" SortExpression="UnitCost"
                        meta:resourcekey="UnitCost">
                        <ItemTemplate>
                            <span>
                                <%#FormatCurrency(Container.DataItem("UnitCost"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" HeaderStyle-Width="100px" SortExpression="TotalCost"
                        meta:resourcekey="TotalCost">
                        <ItemTemplate>
                            <span>
                                <%#FormatCurrency(Container.DataItem("TotalCost"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Begin" UniqueName="Begin" HeaderStyle-Width="100px" SortExpression="Begin"
                        meta:resourcekey="Begin">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblBegin" Text='<%#FormatNumber(Container.DataItem("Begin"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="End" UniqueName="End" HeaderStyle-Width="100px" SortExpression="End"
                        meta:resourcekey="End">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblEnd" Text='<%#FormatNumber(Container.DataItem("End"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Length" UniqueName="Length" HeaderStyle-Width="100px" SortExpression="Length"
                        meta:resourcekey="Length">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLength" Text='<%#FormatNumber(Container.DataItem("Length"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Direction" UniqueName="Direction" HeaderStyle-Width="90px" SortExpression="Direction"
                        meta:resourcekey="Direction">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("Direction") = String.Empty, "&nbsp;", Container.DataItem("Direction"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Lateral Offset" UniqueName="LateralOffset" HeaderStyle-Width="100px" SortExpression="LateralOffset"
                        meta:resourcekey="LateralOffset">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLateralOffset" Text='<%#FormatNumber(Container.DataItem("LateralOffset"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="LO UOM" UniqueName="LateralOffsetUOM" HeaderStyle-Width="90px" SortExpression="LateralOffsetUOM"
                        meta:resourcekey="LateralOffsetUOM">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("LateralOffsetUOM") = String.Empty, "&nbsp;", Container.DataItem("LateralOffsetUOM"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Vertical Offset" UniqueName="VerticalOffset" HeaderStyle-Width="100px" SortExpression="VerticalOffset"
                        meta:resourcekey="VerticalOffset">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblVerticalOffset" Text='<%#FormatNumber(Container.DataItem("VerticalOffset"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="VO UOM" UniqueName="VerticalOffsetUOM" HeaderStyle-Width="90px" SortExpression="VerticalOffsetUOM"
                        meta:resourcekey="VerticalOffsetUOM">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("VerticalOffsetUOM") = String.Empty, "&nbsp;", Container.DataItem("VerticalOffsetUOM"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Radial Offset" UniqueName="RadialOffset" HeaderStyle-Width="100px" SortExpression="RadialOffset"
                        meta:resourcekey="RadialOffset">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblRadialOffset" Text='<%#FormatNumber(Container.DataItem("RadialOffset"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Latitude" UniqueName="Latitude" HeaderStyle-Width="100px" SortExpression="Latitude"
                        meta:resourcekey="Latitude">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLatitude" Text='<%#IIf(FormatLongtitude(Container.DataItem("Latitude"), False) = String.Empty, "&nbsp;", FormatLongtitude(Container.DataItem("Latitude"), false))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Longitude" UniqueName="Longitude" HeaderStyle-Width="100px" SortExpression="Longitude"
                        meta:resourcekey="Longitude">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblLongitude" Text='<%#IIf(FormatLongtitude(Container.DataItem("Longitude"), False) = String.Empty, "&nbsp;", FormatLongtitude(Container.DataItem("Longitude"), false))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Elevation" UniqueName="Elevation" HeaderStyle-Width="100px" SortExpression="Elevation"
                        meta:resourcekey="Elevation">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblElevation" Text='<%#IIf(FormatLongtitude(Container.DataItem("Elevation"), False) = String.Empty, "&nbsp;", FormatLongtitude(Container.DataItem("Elevation"), false))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Asset Type" UniqueName="AssetType" HeaderStyle-Width="90px" SortExpression="AssetType"
                        meta:resourcekey="AssetType">
                        <ItemTemplate>
                            <asp:Label ID="lblAssetType" runat="server" Text='<%#IIf(Container.DataItem("AssetType") = String.Empty, "&nbsp;", Container.DataItem("AssetType"))%>'></asp:Label>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Item" UniqueName="ItemId" HeaderStyle-Width="90px" SortExpression="ItemId"
                        meta:resourcekey="ItemId">
                        <ItemTemplate>
                            <asp:HyperLink ID="hliItem" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'>
                            </asp:HyperLink>
                            <asp:Label runat="server" Text='<%#Eval("ItemId")%>' ID="lblItem"></asp:Label>&nbsp;
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Stock #" UniqueName="StockNumber" HeaderStyle-Width="100px" SortExpression="StockNumber"
                        meta:resourcekey="StockNumber">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlistock" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'>
                            </asp:HyperLink>
                            <asp:Label runat="server" Text="&nbsp;" ID="lblstock"></asp:Label>&nbsp;
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Serial #" UniqueName="SerialNumber" HeaderStyle-Width="100px" SortExpression="SerialNumber"
                        meta:resourcekey="SerialNumber">
                        <ItemTemplate>
                            <%#Container.DataItem("SerialNumber")%>&nbsp;
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Lot #" UniqueName="LotNumber" HeaderStyle-Width="100px" SortExpression="LotNumber"
                        meta:resourcekey="LotNumber">
                        <ItemTemplate>
                            <%#Container.DataItem("LotNumber")%>&nbsp;
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-Width="280px" SortExpression="Notes"
                        meta:resourcekey="Notes">
                        <ItemTemplate>
                            <span>
                                <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                            </span>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>


                </Columns>
            </telerik:RadTreeList>
        </div>
    </div>
</div>

<asp:Button ID="btnGenerateWorkOrder" runat="server" CssClass="Hide" />