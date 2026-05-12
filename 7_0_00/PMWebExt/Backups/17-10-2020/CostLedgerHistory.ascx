<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostLedgerHistory.ascx.vb" Inherits="Website.CostLedgerHistory" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RDG">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RDG" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="sldDate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RDG" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<div class="PMMainPage">
    <div class="row">
        <div class="col-4 col-4-left">
            <table class="colTable" border="0">
                <tr>
                    <td style="width: 30%;">
                        <span id="lblFromDate"></span>
                    </td>
                    <td style="width: 40%;">
                        <telerik:RadSlider runat="server" ID="sldDate" IsSelectionRangeEnabled="true" OnClientLoad="sldDate_Changed" Width="180px"
                            SmallChange="1" AutoPostBack="true" Skin="Default" OnClientValueChange="sldDate_Changed"
                            ShowDecreaseHandle="false" ShowIncreaseHandle="false" />
                    </td>
                    <td style="width: 30%;" align="right">
                        <span id="lblToDate"></span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="RDG" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" CssClass="WithoutTopBorder ResponsiveMargin"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" EditMode="InPlace"
                    EnableHeaderContextMenu="true" TableLayout="Fixed" ShowGroupFooter="false" GroupLoadMode="Client">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ActionType1" SortExpression="ActionType" UniqueName="ActionType"
                            GroupByExpression="ActionType [GridColumn_ActionType] Group By ActionType ASC" DataField="ActionType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ActionType") = String.Empty, "&nbsp;", Container.DataItem("ActionType"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Cost Code1" SortExpression="CostCode" UniqueName="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Description1" SortExpression="Description" UniqueName="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency1" SortExpression="Currency" UniqueName="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM1" DataField="UOM" AutoPostBackOnFilter="true"
                            SortExpression="UOM" UniqueName="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity1" DataField="Quantity" DataType="System.Decimal" AutoPostBackOnFilter="true"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" UniqueName="Quantity">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit Cost1" UniqueName="UnitCost"
                            DataField="UnitCost" DataType="System.Decimal" AutoPostBackOnFilter="true"
                            SortExpression="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Amount1" UniqueName="TotalAmount"
                            DataField="TotalAmount" DataType="System.Decimal" AutoPostBackOnFilter="true"
                            GroupByExpression="TotalAmount [GridColumn_TotalAmount] Group By TotalAmount ASC" SortExpression="TotalAmount">
                            <ItemTemplate>
                                <span>
                                    <asp:Label Text='<%#FormatCurrency(Eval("TotalAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalAmount" /></span>
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Worksheet Column1" SortExpression="WorksheetColumn" DataField="WorksheetColumn" AutoPostBackOnFilter="true"
                            UniqueName="WorksheetColumn" GroupByExpression="WorksheetColumn [GridColumn_WorksheetColumn] Group By WorksheetColumn ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("WorksheetColumn") = String.Empty, "&nbsp;", Container.DataItem("WorksheetColumn"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Statu111s" DataField="Status" AutoPostBackOnFilter="true"
                            UniqueName="Status" SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                            <ItemTemplate>
                                <span><%#CStr(Container.DataItem("Status"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn Display="false" HeaderText="Per11iod" SortExpression="Period" UniqueName="Period"
                            GroupByExpression="Period [GridColumn_Period] Group By Period ASC" DataField="Period" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIf(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn Display="false" HeaderText="No11tes" DataField="Notes" AutoPostBackOnFilter="true"
                            SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Docu11ment" DataField="Document" AutoPostBackOnFilter="true"
                            UniqueName="Document" GroupByExpression="Document [GridColumn_Document] Group By Document ASC"
                            SortExpression="Document">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Document") = String.Empty, "&nbsp;", Container.DataItem("Document"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Docu11ment Type" DataField="DocumentType" AutoPostBackOnFilter="true"
                            UniqueName="DocumentType" GroupByExpression="DocumentType [GridColumn_DocumentType] Group By DocumentType ASC"
                            SortExpression="DocumentType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("DocumentType") = String.Empty, "&nbsp;", Container.DataItem("DocumentType"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn Display="false" HeaderText="R11eq. Code" DataField="ReqCodeName" AutoPostBackOnFilter="true"
                            UniqueName="ReqCode" SortExpression="ReqCodeName" GroupByExpression="ReqCodeName [GridColumn_ReqCode] Group By ReqCodeName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ReqCodeName") = String.Empty, "&nbsp;", Container.DataItem("ReqCodeName"))%></span>
                            </ItemTemplate>

                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn Display="false" HeaderText="R11eq. #" DataField="ReqNumber" AutoPostBackOnFilter="true"
                            UniqueName="ReqNumber" SortExpression="ReqNumber" GroupByExpression="ReqNumber [GridColumn_ReqNumber] Group By ReqNumber ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ReqNumber") = String.Empty, "&nbsp;", Container.DataItem("ReqNumber"))%></span>
                            </ItemTemplate>

                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn Display="false" HeaderText="Pro11file ID" DataField="ProfileCode"
                            AutoPostBackOnFilter="true" UniqueName="ProfileCode" SortExpression="ProfileCode" GroupByExpression="ProfileCode [GridColumn_ProfileCode] Group By ProfileCode ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProfileCode") = String.Empty, "&nbsp;", Container.DataItem("ProfileCode"))%></span>
                            </ItemTemplate>

                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn Display="false" HeaderText="Imp11ort Date" DataField="IntegrationImportDate" DataType="System.DateTime" AutoPostBackOnFilter="true"
                            UniqueName="IntegrationImportDate" SortExpression="IntegrationImportDate" GroupByExpression="IntegrationImportDate [GridColumn_IntegrationImportDate] Group By IntegrationImportDate ASC">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("IntegrationImportDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalAmount" Visible="False" />

                        <telerik:GridTemplateColumn HeaderText="LastUpd11ateDate" DataField="LastUpdateDate"
                            AutoPostBackOnFilter="true" UniqueName="LastUpdateDate" SortExpression="LastUpdateDate" GroupByExpression="LastUpdateDate [GridColumn_LastUpdateDate] Group By LastUpdateDate ASC">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("LastUpdateDate"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="LastU11pdateBy" DataField="LastUpdatedBy"
                            AutoPostBackOnFilter="true" UniqueName="LastUpdateBy" SortExpression="LastUpdatedBy" GroupByExpression="LastUpdatedBy [GridColumn_LastUpdateBy] Group By LastUpdatedBy ASC">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LastUpdatedBy")%></span>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <HeaderStyle Width="108px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                    <ItemStyle Wrap="false" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="WorksheetColumnId"></telerik:GridSortExpression>
                    </SortExpressions>

                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>

</div>

