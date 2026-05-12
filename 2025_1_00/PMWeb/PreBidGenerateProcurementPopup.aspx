<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="PreBidGenerateProcurementPopup.aspx.vb" Inherits="Website.PreBidGenerateProcurementPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function BidCategoryRowSelected(sender, eventArgs) {
            calculate();

             
        }
        function calculate() {

            var SeletedLineTotal = 0;
            var grid = $find($("[id$=rdgProcuremenrtRecords]")[0].id);
            for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
                var row = grid.MasterTableView.get_selectedItems()[i];
                SeletedLineTotal = SeletedLineTotal + CDbl($(row._element).find("span[id$='LineTotal']").html());
            }
            $("input[id$=txtSelectedLineTotal]").val(CCur(SeletedLineTotal));


        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarGenerate" ValidationGroup="Save"
                                CommandName="Generate">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" meta:Resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" MaxLength="500" runat="server"  Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPreBid" meta:Resourcekey="lblPreBid" runat="server" Text="Pre-bid"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPreBid" MaxLength="500" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDate" meta:Resourcekey="lblDate" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <table style="width: 100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 43%;">
                                            <asp:TextBox ID="txtDate" MaxLength="500" runat="server"  Enabled="false" CssClass="Date"></asp:TextBox>
                                        </td>
                                        <td style="text-align: center">
                                            <asp:Label ID="lblRevision" meta:Resourcekey="lblRevision" runat="server" Text="Rev."></asp:Label>
                                        </td>
                                        <td style="width: 43%">
                                            <asp:TextBox ID="txtRevision" MaxLength="500" runat="server" Enabled="false" CssClass="Integer"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right ">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLineTotal" meta:Resourcekey="lblLineTotal" runat="server" Text="Line Total"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLineTotal" MaxLength="500" runat="server" Enabled="false" CssClass="Double"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSelectedLineTotal" meta:Resourcekey="lblSelectedLineTotal" runat="server" Text="Selected Line Total"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtSelectedLineTotal" MaxLength="500" runat="server" Enabled="false" CssClass="Double"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgProcuremenrtRecords" Width="100%" runat="server" AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        AllowPaging="False" PageSize="250" HeaderStyle-Font-Size="8" AllowMultiRowEdit="False" AllowMultiRowSelection="true"
                        ShowGroupPanel="False" AllowSorting="False">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="BidCategoryId" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="False" EditMode="InPlace">

                            <Columns>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Bid Category" SortExpression="BidCategory" UniqueName="BidCategory" GroupByExpression="BidCategory [GridColumn_BidCategory] Group By BidCategory ASC">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlBidCategory" AllowCustomText="true" MarkFirstMatch="false" runat="server" Width="100%"></telerik:RadComboBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Description" SortExpression="Description" UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%#Eval("Description")%>' MaxLength="4000" Width="100%"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="# of Bidders" UniqueName="NbrOfBidders" SortExpression="NbrOfBidders" GroupByExpression="NbrOfBidders [GridColumn_NbrOfBidders] Group By NbrOfBidders ASC">
                                    <ItemTemplate>
                                        <%#Eval("NbrOfBidders").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="# of Lines" UniqueName="NbrofLines" SortExpression="NbrofLines" GroupByExpression="NbrofLines [GridColumn_NbrofLines] Group By NbrofLines ASC">
                                    <ItemTemplate>
                                        <%#Eval("NbrofLines").ToString%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Total" UniqueName="Total">
                                    <ItemTemplate>
                                        <span id="LineTotal"><%#FormatCurrency(Eval("Total").ToString)%>&nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Sent" UniqueName="Sent" SortExpression="Sent" GroupByExpression="Sent [GridColumn_Sent] Group By Sent ASC">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSent" runat="server" CausesValidation="false" CssClass="">
                                                                    <span class="Icon"></span>       
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                            <CommandItemTemplate>
                                <div>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CommandName="Undo" CssClass="GridCmdUndo"
                                                    Visible='<%# rdgProcuremenrtRecords.EditIndexes.Count = 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Undo"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" AllowDragToGroup="False">
                            <ClientEvents OnRowSelected="BidCategoryRowSelected" OnRowDeselected="BidCategoryRowSelected" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="False" AllowColumnResize="False" />
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
