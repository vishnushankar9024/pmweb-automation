<%@ Page Language="vb" meta:resourcekey="Page" Title="Contacts" AutoEventWireup="false" CodeBehind="ProjectContactPopup.aspx.vb" Inherits="Website.ProjectContactPopup" %>

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
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
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
                    <div class="PMMainPage">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="true" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                HeaderStyle-Font-Size="8" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                                 AutoGenerateColumns="False" AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="250">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="none" InsertItemDisplay="Top"
                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-HorizontalAlign="Left"
                                                            HeaderStyle-Width="30px" UniqueName="Select" Groupable="false">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Company Code" UniqueName="CompanyCode" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="150px" SortExpression="CompanyCode" CurrentFilterFunction="Contains"
                                                            DataField="CompanyCode" AutoPostBackOnFilter="true"
                                                            GroupByExpression="CompanyCode [GridColumn_CompanyCode] Group By CompanyCode ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("CompanyCode").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyCode").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="150px" SortExpression="Company" CurrentFilterFunction="Contains"
                                                            DataField="Company" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Title" UniqueName="Title" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="150px" SortExpression="Title" CurrentFilterFunction="Contains"
                                                            DataField="Title" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Title [GridColumn_Title] Group By Title ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Title").ToString = String.Empty, "&nbsp;", Container.DataItem("Title").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="100px" SortExpression="Type" CurrentFilterFunction="Contains"
                                                            DataField="Type" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Reference" UniqueName="Reference" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="120px" SortExpression="Reference" CurrentFilterFunction="Contains"
                                                            DataField="Reference" AutoPostBackOnFilter="true"
                                                            GroupByExpression="Reference [GridColumn_Reference] Group By Reference ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Reference").ToString = String.Empty, "&nbsp;", Container.DataItem("Reference").ToString)%></span>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Contact" CurrentFilterFunction="Contains"
                                                            DataField="Contact" AutoPostBackOnFilter="true"
                                                            UniqueName="Contact" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="220px" SortExpression="Contact"
                                                            GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Contact").ToString = String.Empty, "&nbsp;", Container.DataItem("Contact").ToString)%></span>&nbsp;
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
