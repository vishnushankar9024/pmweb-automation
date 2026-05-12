<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CostLedgerRecordHistory.aspx.vb" Inherits="Website.CostLedgerRecordHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Record History</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgHistory">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgHistory" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgHistory" runat="server" ShowFooter="false"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="7"
                        AllowPaging="True" AllowMultiRowEdit="True" ShowGroupPanel="True" setwidth="true" allow-scroll="true"
                        AllowSorting="True" GridLines="None" Width="99.5%">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" VerticalAlign="Bottom" Position="Bottom"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false"
                            TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="ActionType1" SortExpression="ActionType" UniqueName="ActionType"
                                    GroupByExpression="ActionType [GridColumn_ActionType] Group By ActionType ASC" DataField="ActionType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("ActionType") = String.Empty, "&nbsp;", Container.DataItem("ActionType"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="LastUpdatedBy" DataField="LastUpdatedBy"
                                    AutoPostBackOnFilter="true" UniqueName="LastUpdatedBy" SortExpression="LastUpdatedBy" GroupByExpression="LastUpdatedBy [GridColumn_LastUpdatedBy] Group By LastUpdatedBy ASC">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LastUpdatedBy")%></span>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="LastUpdateDate1" DataField="LastUpdateDate"
                                    AutoPostBackOnFilter="true" UniqueName="LastUpdateDate" SortExpression="LastUpdateDate" GroupByExpression="LastUpdateDate [GridColumn_LastUpdateDate] Group By LastUpdateDate ASC">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("LastUpdateDate"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="CostCode1" SortExpression="CostCode" UniqueName="CostCode"
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
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Quantity1" DataField="Quantity" DataType="System.Decimal" AutoPostBackOnFilter="true"
                                    GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" UniqueName="Quantity"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblSumQuantity" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Unit Cost1" UniqueName="UnitCost"
                                    DataField="UnitCost" DataType="System.Decimal" AutoPostBackOnFilter="true"
                                    SortExpression="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblSumUnitCost" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Total Amount1" UniqueName="TotalAmount"
                                    DataField="TotalAmount" DataType="System.Decimal" AutoPostBackOnFilter="true"
                                    GroupByExpression="TotalAmount [GridColumn_TotalAmount] Group By TotalAmount ASC" SortExpression="TotalAmount"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:N}">
                                    <ItemTemplate>
                                        <span>
                                            <asp:Label Text='<%#FormatCurrency(Eval("TotalAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalAmount" /></span>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblSumTotalAmount" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Worksheet Column1" SortExpression="WorksheetColumn" DataField="WorksheetColumn" AutoPostBackOnFilter="true"
                                    UniqueName="WorksheetColumn" GroupByExpression="WorksheetColumn [GridColumn_WorksheetColumn] Group By WorksheetColumn ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("WorksheetColumn") = String.Empty, "&nbsp;", Container.DataItem("WorksheetColumn"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Status1" DataField="Status" AutoPostBackOnFilter="true"
                                    UniqueName="Status" SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                                    <ItemTemplate>
                                        <span><%#CStr(Container.DataItem("Status"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Period1" SortExpression="Period" UniqueName="Period"
                                    GroupByExpression="Period [GridColumn_Period] Group By Period ASC" DataField="Period" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIf(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Notes1" DataField="Notes" AutoPostBackOnFilter="true"
                                    SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                            </Columns>
                        </MasterTableView>
                        <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="True">
                            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True"></Resizing>
                            <Selecting EnableDragToSelectRows="true" AllowRowSelect="true" />

                        </ClientSettings>
                        <GroupingSettings CaseSensitive="false" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>


    </form>
</body>
</html>
