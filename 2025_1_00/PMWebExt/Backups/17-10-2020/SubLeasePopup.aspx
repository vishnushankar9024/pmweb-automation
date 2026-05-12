<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SubLeasePopup.aspx.vb" Inherits="Website.SubLeasePopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SUB-LEASES</title>
    
        <script type="text/javascript">
            function OpenRecord(sender) {
                if ($(sender).attr("LinkSrc") != "") {
                    GetRadWnd().BrowserWindow.location.href = $(sender).attr("LinkSrc");
                    CloseRadWnd();
                    return false;
                }
                return false;
            }

        </script>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgSubLeases">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgSubLeases" LoadingPanelID="ldpSubLease" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpSubLease" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarDone" CommandName="Close"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid
                        ID="rdgSubLeases" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                        HeaderStyle-Font-Size="8" Width="100%"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" TabIndex="11"
                        AllowMultiRowSelection="true" AllowPaging="true" PageSize="10">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Active" UniqueName="Active" HeaderStyle-Width="60px" ItemStyle-Wrap="false" SortExpression="Active"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Active")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                            alt="" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="ID" HeaderStyle-Width="100px" SortExpression="ID">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hliSpace" runat="server" CssClass="NoWrap Link" onclick="OpenRecord(this)"
                                            Text='<%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%>'
                                            LinkSrc='<%# "Leases.aspx?Id=" & CStr(IIf(Container.DataItem("Id") Is System.DBNull.Value, "0", Container.DataItem("Id")))%>'></asp:HyperLink>


                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="140px" SortExpression="Description">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Lease Type" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="LeaseType" HeaderStyle-Width="100px" SortExpression="LeaseType">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("LeaseType") = String.Empty, "&nbsp;", Container.DataItem("LeaseType"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tenant" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Tenant" HeaderStyle-Width="160px" SortExpression="Tenant">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Tenant") = String.Empty, "&nbsp;", Container.DataItem("Tenant"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Lease Start" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="120px" UniqueName="LeaseStart" SortExpression="LeaseStart">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("LeaseStart") Is DBNull.Value, "&nbsp;", FormatDate(Container.DataItem("LeaseStart")))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Lease End" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" HeaderStyle-Width="120px" UniqueName="LeaseEnd" SortExpression="LeaseEnd">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("LeaseEnd") Is DBNull.Value, "&nbsp;", FormatDate(Container.DataItem("LeaseEnd")))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings Resizing-AllowColumnResize="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
