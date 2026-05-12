<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ItemPurchaseHistory.ascx.vb" Inherits="Website.ItemPurchaseHistory" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgPurchaseHistory" runat="server" CssClass="WithoutTopBorder" setwidth="true"
                AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="15"
                ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" GroupingEnabled="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Commitment" UniqueName="Commitment"
                            SortExpression="Commitment" GroupByExpression="Commitment [GridColumn_Commitment] Group By Commitment ASC"
                            Groupable="true" Reorderable="true" DataField="Commitment" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Commitment") = String.Empty, "&nbsp;", Container.DataItem("Commitment"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="144px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status"
                            SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC"
                            Groupable="true" Reorderable="true" DataField="Status" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date"
                            SortExpression="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC"
                            Groupable="true" Reorderable="true" DataField="Date" CurrentFilterFunction="Equalto" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("Date"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="141px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project"
                            SortExpression="Project" GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                            Groupable="true" Reorderable="true" DataField="Project" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Project") = String.Empty, "&nbsp;", Container.DataItem("Project"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="130px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company"
                            SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC"
                            Groupable="true" Reorderable="true" DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="126px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM"
                            SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                            Groupable="true" Reorderable="true" DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="500px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity"
                            SortExpression="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC"
                            Groupable="true" Reorderable="true" DataField="Quantity" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("Quantity")%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="133px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Price" UniqueName="Price"
                            SortExpression="Price" GroupByExpression="Price [GridColumn_Price] Group By Price ASC"
                            Groupable="true" Reorderable="true" DataField="Price" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("Price"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="105px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Cost" UniqueName="ExtCost"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            Groupable="true" Reorderable="true" DataField="ExtCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("ExtCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="155px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1"
                            SortExpression="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            Groupable="true" Reorderable="true" DataField="Adjustment1" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("Adjustment1"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="115px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax"
                            SortExpression="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            Groupable="true" Reorderable="true" DataField="Tax" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("Tax"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2"
                            SortExpression="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            Groupable="true" Reorderable="true" DataField="Adjustment2" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("Adjustment2"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost"
                            SortExpression="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC"
                            Groupable="true" Reorderable="true" DataField="TotalCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("TotalCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="right" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:Label runat="server" ID="lblCurrency" meta:resourcekey="lblCurrency" Text="Currency"></asp:Label>&nbsp;&nbsp;
                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="300px" Style="font-size: 11px" Width="150px" ShowMoreResultsBox="True"
                    OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged" AutoPostBack="true">
                </telerik:RadComboBox>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgPurchaseHistory.EditIndexes.Count = 0 And (Not rdgPurchaseHistory.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>

