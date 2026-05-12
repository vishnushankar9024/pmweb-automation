<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectedBids.aspx.vb" Inherits="Website.SelectedBids" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <style>
        .rgRow, .rgAltRow {
            background-color: #EDEDED;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">
                        <telerik:RadGrid ID="rdgCompany" runat="server" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true" AppendMenus="true" allow-scroll="true"
                            AutoGenerateColumns="False" ShowStatusBar="False"
                            Font-Size="8px" PageSize="20" AllowPaging="True" ShowGroupPanel="False"
                            AllowMultiRowEdit="False" AllowMultiRowSelection="false"
                            AllowSorting="true" GridLines="None" Width="100%">

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="None" TableLayout="Fixed"
                                Width="100%" UseAllDataFields="true"
                                EditMode="InPlace" EnableHeaderContextMenu="False">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                <Columns>

                                    <telerik:GridTemplateColumn HeaderText="" UniqueName="Display" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" OnCheckedChanged="chkSelect_OnChekedChanged" AutoPostBack="true" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="50px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Rev." SortExpression="RevisionNumber" UniqueName="Revision" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("RevisionNumber")%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        <HeaderStyle Wrap="false" Width="50px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("Description").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="left" />
                                        <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Total" SortExpression="BidTotal" UniqueName="Total" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#FormatCurrency(Eval("BidTotal"), CurrencyId:=Eval("CurrencyId"))%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                        <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Leveled" SortExpression="LeveledAmount" UniqueName="Leveled" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#FormatCurrency(Eval("LeveledAmount"), CurrencyId:=Eval("CurrencyId"))%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="right" />
                                        <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Status" SortExpression="BidStatus" UniqueName="Status" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("BidStatus").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>

                                </Columns>

                            </MasterTableView>
                            <ClientSettings AllowColumnHide="False" AllowColumnsReorder="false" AllowDragToGroup="false" AllowRowsDragDrop="false">
                                <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false" AllowColumnResize="True" />
                            </ClientSettings>
                        </telerik:RadGrid>

                    </telerik:RadAjaxPanel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
