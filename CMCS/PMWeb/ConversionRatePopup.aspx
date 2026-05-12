<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConversionRatePopup.aspx.vb" Inherits="Website.ConversionRatePopup" meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="105px" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblCurrencyDate"></asp:Label>
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMMainPage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="RDG1" runat="server" ShowGroupPanel="false" ShowFooter="true" setwidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        HeaderStyle-Font-Size="8" AllowPaging="true" PageSize="250" AutoGenerateColumns="false" ShowStatusBar="False" FitPageHeightOffset="24"
                        AllowMultiRowEdit="True" AllowSorting="true" AllowMultiRowSelection="true" GridLines="None" EnableViewState="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView GroupLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" EnableColumnsViewState="False"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None"
                            InsertItemDisplay="Top" EnableHeaderContextMenu="false" InsertItemPageIndexAction="ShowItemOnFirstPage"
                            EditMode="InPlace" TableLayout="Fixed" AllowMultiColumnSorting="true" Width="100%" ShowGroupFooter="false">
                            <Columns>
                                <telerik:GridBoundColumn Aggregate="SUM" DataField="Id" Visible="False" UniqueName="AggregatCol" />
                            </Columns>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings AllowDragToGroup="True" AllowColumnHide="true" AllowGroupExpandCollapse="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" ReorderColumnsOnClient="True">
                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                AllowColumnResize="True"></Resizing>
                            <Scrolling UseStaticHeaders="true" />
                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />

                        </ClientSettings>
                    </telerik:RadGrid>

                </div>
            </div>
        </div>

    </form>
</body>
</html>
