<%@ Page meta:Resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="ProcurementUniCostPopup.aspx.vb" Inherits="Website.ProcurementUniCostPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />



        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-4">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLineNumber" Text="Line #" runat="server" meta:Resourcekey="lblLineNumber"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" Width="99%" ID="txtLineNumber" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDescription" Text="Description" runat="server" meta:Resourcekey="lblDescription"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" Width="99%" ID="txtDescription" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">
                                                <telerik:RadGrid ID="rdg" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                    AutoGenerateColumns="False" ShowStatusBar="False"
                                                    Font-Size="8px" PageSize="250" AllowPaging="True" ShowGroupPanel="False"
                                                    AllowMultiRowEdit="False" AllowMultiRowSelection="false"
                                                    AllowSorting="true" GridLines="None" Width="100%">

                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                        DataKeyNames="Id" CommandItemDisplay="None" TableLayout="Fixed"
                                                        Width="500px" UseAllDataFields="true"
                                                        EditMode="InPlace" EnableHeaderContextMenu="False">
                                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                        <Columns>

                                                            <telerik:GridTemplateColumn HeaderText="Bidder" UniqueName="Bidder" ItemStyle-HorizontalAlign="Left" SortExpression="Bidder">
                                                                <ItemTemplate>
                                                                    <%#Eval("Bidder").ToString%>&nbsp;
                                                                </ItemTemplate>
                                                                <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                                <HeaderStyle Wrap="false" Width="300px" HorizontalAlign="Left" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" ItemStyle-HorizontalAlign="Left" SortExpression="UOM">
                                                                <ItemTemplate>
                                                                    <%#Eval("UOM").ToString%>&nbsp;
                                                                </ItemTemplate>
                                                                <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                                <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity">
                                                                <ItemTemplate>
                                                                    <%#FormatNumber(Container.DataItem("Quantity"))%>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Unit Cost" SortExpression="UnitCost"
                                                                UniqueName="UnitCost">
                                                                <ItemTemplate>
                                                                    <%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Total Cost" SortExpression="TotalCost"
                                                                UniqueName="TotalCost">
                                                                <ItemTemplate>
                                                                    <%#FormatCurrency(Container.DataItem("TotalCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </telerik:GridTemplateColumn>

                                                        </Columns>

                                                    </MasterTableView>
                                                    <ClientSettings AllowColumnHide="False" AllowColumnsReorder="false" AllowDragToGroup="false" AllowRowsDragDrop="false">
                                                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false" AllowColumnResize="True" />

                                                    </ClientSettings>
                                                </telerik:RadGrid>

                                            </telerik:RadAjaxPanel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
