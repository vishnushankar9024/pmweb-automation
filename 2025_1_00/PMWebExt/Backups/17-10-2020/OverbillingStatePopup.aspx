<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OverbillingStatePopup.aspx.vb" Inherits="Website.OverbillingStatePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Overbilling State</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function OpenRecord(sender) {
                if ($(sender).attr("LinkSrc") != "") {
                    GetRadWnd().BrowserWindow.location.href = $(sender).attr("LinkSrc");
                    CloseRadWnd();
                    return false;
                }
                return false;
            }

            function click_handler(sender, args) {
                if (args.get_item().get_commandName() == "OK") {
                    CloseRadWnd();
                }
            }

        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="OK"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage JustifyContent">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left ">
                    <table class="colTable">
                        <tr>
                            <td>
                                <div class="Warning" style="display: inline;">
                                    <span class="Icon"></span>
                                </div>
                                <asp:Label Style="position: relative; top: -8px;" ID="lblOverbilling" runat="server" meta:resourcekey="lblOverbilling" Text="Overbilling"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblOverbillingMessage" runat="server" meta:resourcekey="lblOverbillingMessage" Text="One or more Progress Invoices has caused 
                                                        an overbilling state that must be corrected before further invoice workflow action can be taken."></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCommitmentSettings" runat="server" meta:resourcekey="lblCommitmentSettings" Text="Commitment Settings:"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="rdgOverbilling" runat="server" ShowCommandItem="false" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                    AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0" Width="100%"
                                    GridLines="None">
                                    <HeaderContextMenu EnableViewState="false">
                                    </HeaderContextMenu>
                                    <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="ItemId" CommandItemDisplay="None" Width="100%">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderText="ID" UniqueName="RecordNumber">
                                                <ItemTemplate>
                                                    <span>
                                                        <asp:HyperLink ID="hliRecordNumber" runat="server" CssClass="Link NoWrap"
                                                            Text='<%#Eval("RecordNumber").ToString%>' onclick="OpenRecord(this)" LinkSrc='<%# "CostManagementProgressInvoices.aspx?Id=" & CStr(Container.DataItem("Id"))%>'></asp:HyperLink>
                                                    </span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Invoice Number" UniqueName="InvoiceNumber">
                                                <ItemTemplate>
                                                    <span><%#IIf(CStr(Eval("InvoiceNumber")) = String.Empty, "&nbsp;", Eval("InvoiceNumber"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                                <ItemTemplate>
                                                    <span><%#IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="250px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="# Of lines Over" UniqueName="NumberOflinesOver">
                                                <ItemTemplate>
                                                    <span><%#IIf(CStr(Eval("NumberOflinesOver")) = String.Empty, "&nbsp;", Eval("NumberOflinesOver"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Status" UniqueName="WorkflowStatus">
                                                <ItemTemplate>
                                                    <span><%#IIf(CStr(Eval("WorkflowStatus")) = String.Empty, "&nbsp;", Eval("WorkflowStatus"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Width="80px" ItemStyle-Wrap="false" UniqueName="Date"
                                                DataField="Date" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                                SortExpression="Date" GroupByExpression="Date [GridColumn_Date] Group By Date ASC">
                                                <ItemTemplate>
                                                    <span><%# If(Container.DataItem("Date") Is DBNull.Value, "&nbsp;", FormatDate(Container.DataItem("Date")))%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                    </MasterTableView>
                                    <ClientSettings EnableRowHoverStyle="false">
                                        <Selecting AllowRowSelect="false" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
