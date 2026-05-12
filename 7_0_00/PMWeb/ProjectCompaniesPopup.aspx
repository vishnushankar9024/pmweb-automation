<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ProjectCompaniesPopup.aspx.vb" Inherits="Website.ProjectCompaniesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgContacts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                         <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
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
                                            <telerik:RadGrid ID="rdgCompanies" AllowMultiRowSelection="true" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                HeaderStyle-Font-Size="8" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                                Width="100%" AutoGenerateColumns="False" AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="10">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="none" InsertItemDisplay="Top"
                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">

                                                    <Columns>

                                                        <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="50px" UniqueName="Select" Groupable="false">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Company Code" UniqueName="CompanyCode" HeaderStyle-Width="150px" SortExpression="CompanyCode" CurrentFilterFunction="Contains" DataField="CompanyCode" AutoPostBackOnFilter="true"
                                                            GroupByExpression="CompanyCode [GridColumn_CompanyCode] Group By CompanyCode ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("CompanyCode").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyCode").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Company Name" UniqueName="CompanyName" HeaderStyle-Width="150px" SortExpression="CompanyName" CurrentFilterFunction="Contains" DataField="CompanyName" AutoPostBackOnFilter="true"
                                                            GroupByExpression="CompanyName [GridColumn_CompanyName] Group By CompanyName ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("CompanyName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Address 1" UniqueName="Address1" HeaderStyle-Width="150px" SortExpression="Address1" CurrentFilterFunction="Contains" DataField="Address1" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Address1 [GridColumn_Address1] Group By Address1 ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Address1").ToString = String.Empty, "&nbsp;", Container.DataItem("Address1").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Address 2" UniqueName="Address2" HeaderStyle-Width="150px" SortExpression="Address2" CurrentFilterFunction="Contains" DataField="Address2" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Address2 [GridColumn_Address2] Group By Address2 ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Address2").ToString = String.Empty, "&nbsp;", Container.DataItem("Address2").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="City" UniqueName="City" HeaderStyle-Width="150px" SortExpression="City" CurrentFilterFunction="Contains" DataField="City" AutoPostBackOnFilter="true"
                                                            GroupByExpression="City [GridColumn_City] Group By City ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Zip" UniqueName="Zip" HeaderStyle-Width="150px" SortExpression="Zip" CurrentFilterFunction="Contains" DataField="Zip" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Zip [GridColumn_Zip] Group By Zip ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Zip").ToString = String.Empty, "&nbsp;", Container.DataItem("Zip").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Country" UniqueName="Country" HeaderStyle-Width="150px" SortExpression="Country" CurrentFilterFunction="Contains" DataField="Country" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Country").ToString = String.Empty, "&nbsp;", Container.DataItem("Country").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Phone" UniqueName="Phone" HeaderStyle-Width="150px" SortExpression="Phone" CurrentFilterFunction="Contains" DataField="Phone" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Ext" UniqueName="Ext" HeaderStyle-Width="150px" SortExpression="Ext" CurrentFilterFunction="Contains" DataField="Ext" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Fax" UniqueName="Fax" HeaderStyle-Width="150px" SortExpression="Fax" CurrentFilterFunction="Contains" DataField="Fax" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Email" UniqueName="Email" HeaderStyle-Width="150px" SortExpression="Email" CurrentFilterFunction="Contains" DataField="Email" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                    </Columns>
                                                </MasterTableView>
                                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" Resizing-AllowColumnResize="True">
                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                                </ClientSettings>
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



        <table cellpadding="0" cellspacing="0">
            <tr>
                <td></td>
            </tr>
            <%--<tr align="right">
                <td align="right">
                <br />
                    <asp:Button ID="btnSave" runat="server" Text="<%$ Resources:PMWeb, SaveToRecord %>" />&nbsp;&nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>" />
                </td>
            </tr>--%>
        </table>
    </form>
</body>
</html>
