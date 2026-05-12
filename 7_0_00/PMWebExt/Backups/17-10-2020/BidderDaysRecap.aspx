<%@ Page meta:Resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="BidderDaysRecap.aspx.vb" Inherits="Website.BidderDaysRecap" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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


        <asp:Label ID="lblCompany" runat="server"></asp:Label>


        <div class="PMMainPage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server" Width="100%">
                        <telerik:RadGrid ID="rdg" runat="server"
                            AutoGenerateColumns="False" ShowStatusBar="False"
                            Font-Size="8px" PageSize="20" AllowPaging="True" ShowGroupPanel="False"
                            AllowMultiRowEdit="False" AllowMultiRowSelection="false" SetWidth="true" AppendMenus="true" allow-scroll="true"
                            AllowSorting="true" GridLines="None" Width="500px">

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="None" TableLayout="Fixed"
                                Width="500px" UseAllDataFields="true"
                                EditMode="InPlace" EnableHeaderContextMenu="False">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" UniqueName="LineNumber"
                                        Reorderable="false">
                                        <ItemTemplate>
                                            <span>
                                                <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                                        </ItemTemplate>
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("Description").ToString%>&nbsp;
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
