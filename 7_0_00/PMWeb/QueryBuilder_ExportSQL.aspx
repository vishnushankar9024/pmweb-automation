<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilder_ExportSQL.aspx.vb" Inherits="Website.QueryBuilder_ExportSQL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgReports">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgReports" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>

        <script type="text/javascript">
            function SelectCurrentRow(ctrl) {
                var tr = $("#" + ctrl.id).parents("tr:eq(0)");
                var grid = $find($("[id$=rdgReports]")[0].id);
                var masterTable = grid.get_masterTableView();
                masterTable.selectItem(tr[0].sectionRowIndex);
            }

            function SelectAllRows(ctrl) {
                var tr = $("#" + ctrl.id).parents("tr:eq(0)");
                var grid = $find($("[id$=rdgReports]")[0].id);
                var masterTable = grid.get_masterTableView();
                masterTable.selectItem(tr[0].sectionRowIndex);
            }

            function ClientButtonClicking(sender, args) {
                if (args.get_item().get_commandName() == "Close") {
                    window.close();
                    args.set_cancel(true);
                    return false;
                }

            }

        </script>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar2" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="ClientButtonClicking" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="ExportToFile" EnableImageSprite="true" CssClass="ToolbarExportSQL"
                                            Value="ExportPDF" PostBack="true">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            Value="Close" PostBack="false">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="rdgReports" runat="server" ShowFooter="false" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                Skin="Default" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10"
                                                AllowPaging="True" AllowMultiRowEdit="True" ShowGroupPanel="True"
                                                AllowSorting="True" GridLines="None" Width="99.5%">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" VerticalAlign="Bottom" Position="Bottom"></PagerStyle>
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false"
                                                    TableLayout="Fixed">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn HeaderStyle-Width="50px" Groupable="false"></telerik:GridClientSelectColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Report Id" ItemStyle-Wrap="false" SortExpression="ReportId"
                                                            UniqueName="ReportId" GroupByExpression="ReportId [GridColumn_ReportId] Group By ReportId ASC">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("ReportId") = String.Empty, "&nbsp;", Container.DataItem("ReportId"))%>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="150px"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Report" ItemStyle-Wrap="false" SortExpression="ReportName"
                                                            UniqueName="ReportName" GroupByExpression="ReportName [GridColumn_ReportName] Group By ReportName ASC">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("ReportName") = String.Empty, "&nbsp;", Container.DataItem("ReportName"))%>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="200px"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Record Type" ItemStyle-Wrap="false" SortExpression="ObjectType"
                                                            UniqueName="ObjectType" GroupByExpression="ObjectType [GridColumn_ObjectType] Group By ObjectType ASC">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("ObjectType") = String.Empty, "&nbsp;", Container.DataItem("ObjectType"))%>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="200px"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
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
