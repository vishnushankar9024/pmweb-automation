<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EstimateDetails.ascx.vb"
    Inherits="Website.EstimateDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>



<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgEstimateDetails" runat="server" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="250" ShowFooter="true" UseEditFormInMobile="true" Skin="Default"
                AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True" CssClass="WithoutTopBorder" HasPasteFromExcel="true"
                AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="true" FooterStyle-HorizontalAlign="Right"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                    TableLayout="Fixed">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber"
                            Groupable="false" Reorderable="true" AllowFiltering="false">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("LineNumber").ToString%>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assembly" SortExpression="AssemblyCode" GroupByExpression="AssemblyCode [GridColumn_AssemblyCode],AssemblyDescription, SUM(TotalCost) TCost, MIN(AssemblyMultiplier) Qty Group By AssemblyCode"
                            UniqueName="AssemblyCode" CurrentFilterFunction="Contains" DataField="AssemblyCode" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAssemblyPass">
                                <span><%#IIf(Container.DataItem("AssemblyCode") = String.Empty, "&nbsp;", Container.DataItem("AssemblyCode"))%></span>
                                </asp:LinkButton>
                                <asp:Label runat="server" ID="lblAssemblyPass"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssemblyCode" CssClass="Right" runat="server" Text='<%# Eval("AssemblyCode") %>'
                                    Width="100%" Enabled="False"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Item" SortExpression="ItemCode" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC"
                            UniqueName="ItemCode" CurrentFilterFunction="Contains" DataField="ItemCode" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" CssClass="Right" runat="server" Text='<%# Eval("ItemCode") %>'
                                    Width="100%" ReadOnly='<%# Not rdgEstimateDetails.MasterTableView.IsItemInserted %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="BIM ID" SortExpression="BIMId" GroupByExpression="BIMId [GridColumn_BIMId] Group By BIMId ASC"
                            UniqueName="BIMId" CurrentFilterFunction="Contains" DataField="BIMId" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("BIMId") = String.Empty, "&nbsp;", Container.DataItem("BIMId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBIMId" MaxLength="50" runat="server" Text='<%# Eval("BIMId")%>'
                                    Width="100%" Enabled="false"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description"
                            UniqueName="Description" CurrentFilterFunction="Contains" DataField="Description" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="230px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlCurrencies" runat="server" Skin="Default" Style="font-size: 11px" Height="300px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Resource" HeaderStyle-HorizontalAlign="Left" GroupByExpression="Resource [GridColumn_Resource] Group By Resource ASC" DataField="Resource"
                            HeaderStyle-Width="150px" UniqueName="Resource" SortExpression="Resource" Reorderable="true" Groupable="true" FilterListOptions="VaryByDataType" CurrentFilterFunction="Contains" DataType="System.String">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("Resource").ToString = String.Empty, "&nbsp;", Container.DataItem("Resource").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlResources" runat="server" Width="100%" ValidationGroup="Save"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Resource..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" meta:resourcekey="ddlResources"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Resource Type" HeaderStyle-HorizontalAlign="Left" GroupByExpression="ResourceType [GridColumn_ResourceType] Group By ResourceType ASC" DataField="ResourceType"
                            HeaderStyle-Width="150px" UniqueName="ResourceType" SortExpression="ResourceType" Reorderable="true" Groupable="true" FilterListOptions="VaryByDataType" CurrentFilterFunction="Contains" DataType="System.String">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ResourceType").ToString = String.Empty, "&nbsp;", Container.DataItem("ResourceType").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("ResourceType")%> &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Manufacturer" ItemStyle-Wrap="false" GroupByExpression="Manufacturer [GridColumn_ManufacturerId] Group By Manufacturer ASC"
                            SortExpression="Manufacturer" UniqueName="ManufacturerId"
                            CurrentFilterFunction="Contains" DataField="Manufacturer" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox
                                    ID="ddlManufacturers" runat="server" Height="200px" Skin="Default" Width="100%"
                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mfr. #" SortExpression="ManufacturerNumber"
                            GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber"
                            UniqueName="ManufacturerNumber" CurrentFilterFunction="Contains" DataField="ManufacturerNumber" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ManufacturerNumber") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMfrNumber" MaxLength="500" runat="server" Text='<%# Eval("ManufacturerNumber") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName"
                            GroupByExpression="PhaseName [GridColumn_PhaseId] Group By PhaseName ASC"
                            UniqueName="PhaseId" CurrentFilterFunction="Contains" DataField="PhaseName" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlProjectPhases" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Cost Code" ItemStyle-Wrap="false"
                            GroupByExpression="CostCode [GridColumn_CostCodeId] Group By CostCode ASC" SortExpression="CostCode" UniqueName="CostCodeId"
                            CurrentFilterFunction="Contains" DataField="CostCode" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCodeWithDescription")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCodeWithDescription") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                    EnableItemCaching="true" AllowCustomText="False" meta:resourcekey="ddlCostCodes"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                    NoWrap="True"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostTypeId] Group By CostType ASC"
                            UniqueName="CostTypeId" CurrentFilterFunction="Contains" DataField="CostType" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" runat="server" AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Bid Category" SortExpression="BidCategory" GroupByExpression="BidCategory [GridColumn_BidCategory] Group By BidCategory ASC"
                            UniqueName="BidCategory" CurrentFilterFunction="Contains" DataField="BidCategory" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("BidCategory") = String.Empty, "&nbsp;", Container.DataItem("BidCategory"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlBidCategory" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                            GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(val(Container.DataItem("WBSId").toString()) = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" AutoPostBack="false"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                <span class="Icon"></span>
                                    </asp:LinkButton>

                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM"
                            GroupByExpression="UOM [GridColumn_UOMId] Group By UOM ASC"
                            UniqueName="UOMId" CurrentFilterFunction="Contains" DataField="UOM" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOM" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC"
                            SortExpression="Quantity" UniqueName="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            DataField="Quantity" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatNumber(ParseDouble(Container.DataItem("Quantity")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" MaxLength="15" Text='<%# FormatNumber(ParseDouble(Eval("Quantity"))) %>'
                                    CssClass="Double" Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOM'),'ASP',0)"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                            SortExpression="UnitCost" UniqueName="UnitCost"
                            DataField="UnitCost" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%# FormatCurrency(ParseDouble(Container.DataItem("UnitCost")), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(ParseDouble(Eval("UnitCost")), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            DataField="ExtCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">

                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCost"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblExtCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle CssClass="HighlightedItem" HorizontalAlign="Right"></ItemStyle>
                            <FooterTemplate>
                                <asp:Label ID="lblSumExtCost" runat="server"></asp:Label>
                            </FooterTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext. Quantity"
                            HeaderStyle-Wrap="false" GroupByExpression="ExtendedQuantity [GridColumn_ExtendedQuantity] Group By ExtendedQuantity ASC"
                            SortExpression="ExtendedQuantity" UniqueName="ExtendedQuantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            DataField="ExtendedQuantity" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatNumber(ParseDouble(Container.DataItem("ExtendedQuantity")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblExtentedQuantity" runat="server" EnableViewState="False" Text='<%# FormatNumber(ParseDouble(Eval("ExtendedQuantity"))) %>'
                                    CssClass="Right"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Cost"
                            GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC" SortExpression="TotalCost"
                            UniqueName="TotalCost"
                            DataField="TotalCost" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("TotalCost")),CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalCost" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(ParseDouble(Eval("TotalCost")), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Funding Source" SortExpression="FundingSource"
                            UniqueName="FundingSource" GroupByExpression="FundingSource [GridColumn_FundingSource] Group By FundingSource ASC"
                            CurrentFilterFunction="Contains" DataField="FundingSource" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("FundingSourceId") = -1, "&nbsp;", IIf(Container.DataItem("FundingSourceId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("FundingSource")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlFundingSources" Width="100%" runat="server" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested" Filter="Contains" MarkFirstMatch="true"
                                    EnableLoadOnDemand="true" NoWrap="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True" Height="300px"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC"
                            CurrentFilterFunction="Contains" DataField="Period" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%# IIf(CStr(Eval("Period")) = String.Empty, "&nbsp;", Eval("Period"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Skin="Default" ID="ddlPeriods"
                                    OnClientSelectedIndexChanged="ddlPeriods_OnClientSelectedIndexChanged" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"
                                    OnItemsRequested="ddl_ItemsRequested" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." meta:resourcekey="ddlPeriods"
                                    NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year" SortExpression="Year" GroupByExpression="Year [GridColumn_Year] Group By Year"
                            CurrentFilterFunction="EqualTo" DataField="Year" DataType="System.Int32" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Year") is system.DBNULL.value, "&nbsp;", Container.DataItem("Year"))%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadNumericTextBox ID="rntYear" ShowSpinButtons="true"
                                    IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                    Label="" runat="server" Width="70px"
                                    MaxValue="2100" MinValue="1899">
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" Filter="Contains" DropDownWidth="465px"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Task..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Sbtl" HeaderStyle-Width="80px" GroupByExpression="IsSubmittal [GridColumn_IsSubmittal] Group By IsSubmittal ASC"
                            SortExpression="IsSubmittal" UniqueName="isSubmittal"
                            CurrentFilterFunction="EqualTo" DataField="IsSubmittal" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("IsSubmittal"), "Y", "N")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsSubmittal" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Company" ItemStyle-Wrap="false" GroupByExpression="Company [GridColumn_CompanyId] Group By Company ASC"
                            SortExpression="Company" UniqueName="CompanyId"
                            CurrentFilterFunction="Contains" DataField="Company" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox
                                    ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="100%"
                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested">
                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                </telerik:RadComboBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Location" GroupByExpression="Location [GridColumn_LocationId] Group By Location ASC"
                            SortExpression="Location" UniqueName="LocationId"
                            CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLocations" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes1" GroupByExpression="Notes1 [GridColumn_Notes1] Group By Notes1 ASC"
                            SortExpression="Notes1" UniqueName="Notes1"
                            CurrentFilterFunction="Contains" DataField="Notes1" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes1") = String.Empty, "&nbsp;", Container.DataItem("Notes1"))%></span>
                                <%--                  <input id="btnNotes1" onclick="return OpenLinkedAssetPOPUp('InventoryLinkedAssets.aspx',300, 400,true)"
                                      type="button" class="SmallButton" />--%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes1" runat="server" Text='<%# Eval("Notes1") %>' Width="80%"
                                    MaxLength="4000" TextMode="MultiLine" Height="20px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes1'))">
                <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" Visible="False" GroupByExpression="UnitCostConverted [GridColumn_UnitCostConverted] Group By UnitCostConverted ASC"
                            SortExpression="UnitCostConverted" UniqueName="UnitCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            DataField="UnitCostConverted" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%# FormatCurrency(ParseDouble(Container.DataItem("UnitCostConverted")), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" Visible="False" UniqueName="ExtCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCostConverted" GroupByExpression="ExtCostConverted [GridColumn_ExtCostConverted] Group By ExtCostConverted ASC"
                            DataField="ExtCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">

                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label3" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle CssClass="HighlightedItem" HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted" Visible="False" UniqueName="Adjustment1Converted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1Converted" DataField="Adjustment1Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment1Converted [GridColumn_Adjustment1Converted] Group By Adjustment1Converted ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label4" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax Converted" UniqueName="TaxConverted" Visible="False" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TaxConverted" DataField="TaxConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="TaxConverted [GridColumn_TaxConverted] Group By TaxConverted ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label5" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right" Visible="False"
                            SortExpression="Adjustment2Converted" DataField="Adjustment2Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment2Converted [GridColumn_Adjustment2Converted] Group By Adjustment2Converted ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"),CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="Label7" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost Converted" Visible="False"
                            GroupByExpression="TotalCostConverted [GridColumn_TotalCostConverted] Group By TotalCostConverted ASC" SortExpression="TotalCostConverted"
                            UniqueName="TotalCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            DataField="TotalCostConverted" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("TotalCostConverted")),CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
                    </Columns>

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert"
                                SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                                SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Estimate',910,580,true)">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddAssemblies" CommandName="AddAssembly" runat="server" CausesValidation="False" CssClass="GridCmdAddAssembly"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('EstimateAssembliesSelect.aspx?Source=Estimate',1180,560,true)">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddAssemblies" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddResource" runat="server" CausesValidation="False" CommandName="WorkOrderAddResources" CssClass="GridCmdWorkOrderAddResources"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectResourcesPopup.aspx?Source=Estimate',900,540,true)"
                                Visible='<%# rdgEstimateDetails.EditIndexes.Count = 0 And (Not rdgEstimateDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddResource" runat="server" Text="Add Resource(s)" meta:resourcekey="lblAddResource"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgEstimateDetails.EditIndexes.Count = 0 And (Not rdgEstimateDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Copy To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgEstimateDetails.EditIndexes.Count = 0 And (Not rdgEstimateDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPreviewConversion" runat="server" Text="Preview Conversion" ></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <%--<asp:LinkButton ID="lbtShowFilter" style="line-height:16px;"  runat="server" Text='<%# Me.GetLocalResourceObject("ToggleFilters") %>' CommandName="ShowFilter"></asp:LinkButton>--%>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>



                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ExportSettings IgnorePaging="true" OpenInNewWindow="true">
                    <Excel Format="ExcelML" FileExtension="xls" />
                </ExportSettings>
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                    AllowDragToGroup="true">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />