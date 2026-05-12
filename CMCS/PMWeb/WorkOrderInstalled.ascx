<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderInstalled.ascx.vb" Inherits="Website.WorkOrderInstalled" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInstalled">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInstalled" LoadingPanelID="ldpPM" />
                  <telerik:AjaxUpdatedControl ControlID="btnDeleteComponents" />
                    <telerik:AjaxUpdatedControl ControlID="btnDeleteAndReturnQuantity"  />
            </UpdatedControls>
        </telerik:AjaxSetting>
           <telerik:AjaxSetting AjaxControlID="btnDeleteComponents">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInstalled" LoadingPanelID="ldpPM" />
                  <telerik:AjaxUpdatedControl ControlID="btnDeleteComponents"  />
                    <telerik:AjaxUpdatedControl ControlID="btnDeleteAndReturnQuantity"  />
            </UpdatedControls>
        </telerik:AjaxSetting>
         <telerik:AjaxSetting AjaxControlID="btnDeleteAndReturnQuantity">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInstalled" LoadingPanelID="ldpPM" />
                  <telerik:AjaxUpdatedControl ControlID="btnDeleteComponents"  />
                    <telerik:AjaxUpdatedControl ControlID="btnDeleteAndReturnQuantity"  />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy> 



    <telerik:RadGrid ID="rdgInstalled" runat="server" 
         AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250"
        ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true"
        AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
              
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" ClientDataKeyNames="InventoryStockId,Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
            Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
            EditMode="InPlace" EnableHeaderContextMenu="true">
                      
            <Columns> 
                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right"
                    SortExpression="LineNumber" GroupByExpression="LineNumber [Line #] Group By LineNumber ASC"
                    Groupable="false" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LineNumber">
                    <ItemTemplate>
                        <asp:label runat="server" id="lblLineNumber" Text='<%#Container.DataItem("LineNumber").ToString%>'></asp:label>
                    </ItemTemplate>
                    <EditItemTemplate>
                            <asp:label runat="server" id="lblLineNumber" Text='<%#Eval("LineNumber").ToString%>'></asp:label>
                    </EditItemTemplate>
                    <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Linked Asset" UniqueName="LinkedAsset"
                    SortExpression="LinkedAsset" GroupByExpression="LinkedAsset [GridColumn_LinkedAsset] Group By LinkedAsset ASC"
                    Groupable="false" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LinkedAsset">
                    <ItemTemplate>
                        <asp:HyperLink ID="hliLinkedAsset" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                Text='<%#Eval("LinkedAsset").ToString%>' NavigateUrl='<%#Eval("LinkedAssetURL").ToString%>'></asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                       <telerik:RadComboBox ID="ddlLinkedAssets" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                                EnableItemCaching="false" MarkFirstMatch="true" OnItemsRequested="ddl_ItemsRequested"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Asset..." meta:resourcekey="ddlLinkedAssets"
                                                NoWrap="True" AllowCustomText="true" Style="font-size: 11px" Height="250px"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Add as Component" SortExpression="AddAsComponent"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AddAsComponent"
                    UniqueName="AddAsComponent" GroupByExpression="AddAsComponent [GridColumn_AddAsComponent] Group By AddAsComponent ASC">
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkAddAsComponent" runat="server" Checked='<%# CBool(IIf(Eval("AddAsComponent") Is System.DBNull.Value, 0, Eval("AddAsComponent"))) %>' class="mobile-switch" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <img src='Images/Global/<%# CStr(IIf(Eval("AddAsComponent"), "checked.png", "unchecked.png")) %>' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="80px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Asset ID" UniqueName="AssetId"
                    SortExpression="AssetId" GroupByExpression="AssetId [GridColumn_AssetId] Group By AssetId ASC"
                    Groupable="false" Reorderable="true"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AssetId">
                    <ItemTemplate>
                        <asp:HyperLink ID="hliAsset" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("EquipmentPostBackUrl").ToString%>'></asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:HyperLink ID="hliAssetEdit" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                                Text='<%#Eval("AssetId").ToString%>' NavigateUrl='<%#Eval("EquipmentPostBackUrl").ToString%>'></asp:HyperLink>
                    </EditItemTemplate>
                    <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Item" UniqueName="ItemId"
                    SortExpression="Item" GroupByExpression="Item [GridColumn_Item] Group By Item ASC"
                    Groupable="false" Reorderable="true"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Item">
                    <ItemTemplate>
                        <asp:HyperLink ID="hliItem" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'></asp:HyperLink>
                        <asp:label runat="server" Text='<%#Eval("ItemId")%>' id="lblItem"></asp:label>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:HyperLink ID="hliItemEdit" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("ItemId")%>' NavigateUrl='<%#Eval("ItemPostbackUrl").ToString%>'></asp:HyperLink>
                        <asp:label runat="server" Text='<%#Eval("ItemId")%>' id="lblItemEdit"></asp:label>&nbsp;
                    </EditItemTemplate>
                    <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="left" UniqueName="Description"
                    HeaderStyle-Width="190px" SortExpression="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Description"
                    GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="4000" runat="server" Text='<%# Eval("Description") %>' Width="100%">
                        </asp:TextBox>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Cost Type" UniqueName="CostType" SortExpression="CostType"
                    GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CostType">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlCostTypes" Width="100%" runat="server">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM"
                    GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="UOM" >
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlUOMs" runat="server" Width="100%">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Quantity"  >
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                        SortExpression="UnitCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="UnitCost">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                            Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle  HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Ext. Cost" UniqueName="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                        SortExpression="ExtCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ExtCost">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("ExtCost"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                            Text='<%# FormatCurrency(Eval("ExtCost")) %>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle  HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Adjustment1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC" SortExpression="Adjustment1" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Adjustment1" Display="False">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("Adjustment1"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAdjustment1" runat="server" Width="100%" CssClass="Double"
                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Adjustment1") Is System.DBNull.Value, "1", Eval("Adjustment1"))) %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC" SortExpression="Tax" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Tax" display="False">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("Tax"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTax" runat="server" Width="100%" CssClass="Double"
                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Tax") Is System.DBNull.Value, "1", Eval("Tax"))) %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Adjustment2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC" SortExpression="Adjustment2" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Adjustment2" display="False">
                    <ItemTemplate>
                        <span><%#FormatNumber(Container.DataItem("Adjustment2"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAdjustment2" runat="server" Width="100%" CssClass="Double"
                            MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Adjustment2") Is System.DBNull.Value, "1", Eval("Adjustment2"))) %>' ></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC"
                        SortExpression="TotalCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="TotalCost" display="False">
                    <ItemTemplate>
                        <span><%#FormatCurrency(Container.DataItem("TotalCost"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lblTotalCost" runat="server" Text='<%# FormatCurrency(Eval("TotalCost")) %>'></asp:Label>
                    </EditItemTemplate>
                    <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle  HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC"
                        SortExpression="CostCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CostCode" >
                    <ItemTemplate> 
                        <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                        </asp:HyperLink>
                        <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                                EnableItemCaching="false" MarkFirstMatch="true" OnItemsRequested="ddl_ItemsRequested"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                                                NoWrap="True" AllowCustomText="true" Style="font-size: 11px" Height="250px"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Cost Period" UniqueName="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC"
                        SortExpression="Period" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Period" >
                    <ItemTemplate> 
                        <span><%# IIf(CStr(Eval("Period")) = String.Empty, "&nbsp;", Eval("Period"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlPeriods" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" 
                            runat="server" AutoPostBack="False" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                Height="200px" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" >
                            </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Stock #" UniqueName="StockNumber"
                    SortExpression="StockNumber" GroupByExpression="StockNumber [GridColumn_StockNumber] Group By StockNumber ASC"
                    Groupable="false" Reorderable="true"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="StockNumber">
                    <ItemTemplate>
                       <asp:HyperLink ID="hlistock" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'></asp:HyperLink>
                 <asp:label runat="server" Text="&nbsp;" id="lblstock"></asp:label>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:HyperLink ID="hlistockEdit" runat="server" CssClass="Link NoWrap" style="white-space:nowrap;display:inline-block;" 
                            Text='<%#Eval("StockNumber").ToString%>' NavigateUrl='<%#Eval("InventoryPostbackUrl").ToString%>'></asp:HyperLink>
               <asp:label runat="server" Text="&nbsp;" id="lblstockdit"></asp:label>
                    </EditItemTemplate>
                    <HeaderStyle Width="70px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="Manufacturer" SortExpression="Manufacturer"
                    GroupByExpression="Manufacturer [GridColumn_Manufacturer] Group By Manufacturer ASC" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Manufacturer">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlManufacturers" runat="server" Width="100%" DropDownWidth="300px" 
                                                Skin="Default" CloseDropDownOnBlur="true"   EmptyMessage="Select ..." 
                                                NoWrap="True" AllowCustomText="true"  meta:Resourcekey="ddlManufacturers"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested"
                                                Style="font-size: 11px" Height="400px" >
                                            </telerik:RadComboBox>
                    </EditItemTemplate>
                    <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Mfr. #" HeaderStyle-Wrap="false"
                    Groupable="True" Reorderable="false" UniqueName="ManufacturerNumber"  SortExpression="ManufacturerNumber"
                    GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber ASC"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ManufacturerNumber">
                    <ItemTemplate>
                        <%#Container.DataItem("MfrNumber")%>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtManufacturerNumber" runat="server" Width="100%"
                            MaxLength="100" Text='<%#Eval("MfrNumber")%>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Serial #" HeaderStyle-Wrap="false"
                    Groupable="True" Reorderable="false" UniqueName="SerialNumber"  SortExpression="SerialNumber"
                    GroupByExpression="SerialNumber [GridColumn_SerialNumber] Group By SerialNumber ASC"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="SerialNumber">
                    <ItemTemplate>
                        <%#Container.DataItem("SerialNumber")%>&nbsp;
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtSerialNumber" runat="server" Width="100%"
                            MaxLength="100" Text='<%#Eval("SerialNumber")%>'></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Component Type" UniqueName="ComponentType" SortExpression="ComponentType"
                    GroupByExpression="ComponentType [GridColumn_ComponentType] Group By ComponentType ASC" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ComponentType">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("ComponentType") = String.Empty, "&nbsp;", Container.DataItem("ComponentType"))%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlComponentTypes" Width="100%" runat="server">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Lot #" UniqueName="LotNumber" ItemStyle-HorizontalAlign="Right"
                    SortExpression="LotNumber" GroupByExpression="LotNumber [Lot #] Group By LotNumber ASC"
                    Groupable="false" Reorderable="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LotNumber">
                    <ItemTemplate>
                        <asp:label runat="server" id="lblLotNumber" Text='<%#Container.DataItem("LotNumber")%>'></asp:label>
                    </ItemTemplate>
                    <EditItemTemplate>
                            <asp:label runat="server" id="lblLotNumber" Text='<%#Eval("LotNumber")%>'></asp:label>
                    </EditItemTemplate>
                    <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes"
                    UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" 
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Notes">
                        <ItemTemplate>
                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>

                            <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                            </asp:LinkButton>

                        </EditItemTemplate>
                        <HeaderStyle Width="280px" HorizontalAlign="Left"></HeaderStyle>
                </telerik:GridTemplateColumn>
            </Columns>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="right" />
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" 
                        SecurityButtonType="ItemMode_Edit" Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnEditSelectedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
                        SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgInstalled.EditIndexes.Count > 0 %>'
                        meta:resourcekey="btnUpdateEditedResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" 
                        SecurityButtonType="AddEditMode_Add" Visible='<%# rdgInstalled.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnSaveResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                        SecurityButtonType="AddEditMode" Visible='<%# rdgInstalled.EditIndexes.Count > 0 Or rdgInstalled.MasterTableView.IsItemInserted %>'
                        meta:resourcekey="btnCancelResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" 
                        SecurityButtonType="ItemMode_Add" Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return DeleteInstalledLines();" CssClass="GridCmdDeleteRows" 
                        SecurityButtonType="ItemMode_Delete" Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False"  CssClass="GridCmdAddItems" 
                        SecurityButtonType="ItemMode_Add"
                        Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenInstalledItemPopup();">
                       <span class="Icon"></span>
                        <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnPickInventory" runat="server" CommandName="PickInventory"  CssClass="GridCmdPickInventory" 
                        OnClientClick="return OpenPOPUp('PickInventory.aspx?Id=2',900, 600,true,'rdgInstalled');"
                            SecurityButtonType="ItemMode_Add" 
                            Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblPickInventory" meta:resourceKey="lblPickInventory" runat="server" Text="Pick Inventory"></asp:Label>
                            &nbsp;&nbsp;
                        </asp:LinkButton>
                    <asp:LinkButton ID="btnlinkAsset" runat="server" CausesValidation="false" CssClass="GridCmdlinkAsset" 
                         SecurityButtonType="ItemMode_Add" CommandName="linkAsset" OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=1&IsInstalled=1',1035, 710,true);"
                        Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'>
                                   <span class="Icon"></span>
                                    <asp:Label runat="server" ID="lblAddAsset" Text = "link Asset(s)"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>    
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                        SecurityButtonType="ItemMode" Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'
                        meta:resourcekey="btnRefreshResource1">
                       <span class="Icon"></span>
                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False" 
                            CommandName="SaveState"  Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'>
                            <asp:Label ID="lblSaveState" runat="server" Text="Save"></asp:Label>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                            CausesValidation="False" CommandName="LoadDefaultState"  Visible='<%# rdgInstalled.EditIndexes.Count = 0 And (Not rdgInstalled.MasterTableView.IsItemInserted) %>'>
                            &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="lblLoadDefaultState" Text="Load Default State" runat="server"></asp:Label>
                        </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true"  AllowRowsDragDrop="true">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True" />
            <Selecting AllowRowSelect="true" />  
        </ClientSettings>
    </telerik:RadGrid>
    <asp:button runat="server" id="btnDeleteAndReturnQuantity" style="display:none;"  />
    <asp:button runat="server" id="btnDeleteComponents" style="display:none;"  />
