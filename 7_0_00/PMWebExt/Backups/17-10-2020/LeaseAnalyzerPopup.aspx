<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="LeaseAnalyzerPopup.aspx.vb" Inherits="Website.LeaseAnalyzerPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblTotalLease" runat="server" meta:resourcekey="lblTotalLease" Text="Total Lease"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtTotalLease" Enabled="false" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblStraightLineMonths" runat="server" meta:resourcekey="lblStraightLineMonths" Text="Straight-Line (Months)"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtStraightLineMonths" Enabled="false" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblStraightLineYears" runat="server" meta:resourcekey="lblStraightLineYears" Text="Straight-Line (Years)"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtStraightLineYears" Enabled="false" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLeaseRemaining" runat="server" meta:resourcekey="lblLeaseRemaining" Text="Lease Remaining"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLeaseRemaining" Enabled="false" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                 <div class="col-4 col-4-right">
                <telerik:RadGrid ID="rdgLeaseAnalyzer" runat="server" AutoGenerateColumns="False" ShowStatusBar="False"
                    HeaderStyle-Font-Size="8" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    ShowGroupPanel="False" AllowMultiRowEdit="true" PageSize="15" AllowPaging="False" AllowMultiRowSelection="true" AllowSorting="False" ItemStyle-Height="20px" GridLines="None">
                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false" />

                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Year" CommandItemDisplay="None"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                        EnableHeaderContextMenu="false">

                        <Columns>
                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Year" UniqueName="Year">
                                <ItemTemplate>
                                    <span><%# Eval("Year")%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" HeaderText="Total" UniqueName="Total">
                                <ItemTemplate>
                                    <span><%# FormatCurrency(Eval("TotalAmount"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" HeaderText="Avg./Month" UniqueName="AvgMonth">
                                <ItemTemplate>
                                    <span><%# FormatCurrency(Eval("AvgMonth"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" HeaderText="Annual" UniqueName="Annual">
                                <ItemTemplate>
                                    <span><%# FormatCurrency(Eval("Annual"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                        </Columns>

                    </MasterTableView>
                    <ClientSettings AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
            </div>
           

        </div>


    </form>
</body>
</html>
