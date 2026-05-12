<%@ Page Language="vb" Title="Project Code Items" AutoEventWireup="false" CodeBehind="ProjectCodeItemsPopup.aspx.vb" Inherits="Website.ProjectCodeItemsPopup" meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgProjectCodeItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgProjectCodeItems" LoadingPanelID="ldprdgProjectCodeItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldprdgProjectCodeItems" runat="server" Skin="Default" />


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>


        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUniqueName" meta:resourcekey="lblUniqueName" runat="server"
                                    Text="Unique Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtUniqueName" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblHeaderText" meta:resourcekey="lblHeaderText" runat="server"
                                    Text="Header Text"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtHeaderText" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgProjectCodeItems" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                    PageSize="250" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false"
                    AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true"
                    ItemStyle-Height="20px">
                    <PagerStyle Mode="NextPrevAndNumeric" />
                    <GroupPanel Text="Group by"></GroupPanel>
                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id,IsUsed" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                        EditMode="InPlace" EnableHeaderContextMenu="false">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Description*" SortExpression="Description" UniqueName="Description">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" runat="server" Width="100%"
                                        Text='<%# Eval("Description") %>' MaxLength="200"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                        CssClass="Validator" ErrorMessage="<br/>Enter The description" Display="Dynamic"
                                        ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <HeaderStyle Width="250px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <SortExpressions>
                            <telerik:GridSortExpression FieldName="Id"></telerik:GridSortExpression>
                        </SortExpressions>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                                        CommandName="EditRows" Visible='<%# rdgProjectCodeItems.EditIndexes.Count = 0 And (Not rdgProjectCodeItems.MasterTableView.IsItemInserted) %>'>
                                                        <span class="Icon"></span>
                                                        <asp:Label ID="lblEdit" runat="server" Text="Edit"></asp:Label>&nbsp;&nbsp;
                                                    </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                    CommandName="UpdateEdited" Visible='<%# rdgProjectCodeItems.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdate" runat="server" Text="Update"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                                    CommandName="PerformInsert" Visible='<%# rdgProjectCodeItems.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                    CommandName="CancelAll" Visible='<%# rdgProjectCodeItems.EditIndexes.Count > 0 Or rdgProjectCodeItems.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancelAll" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                    CommandName="InitNewRow" Visible='<%# rdgProjectCodeItems.EditIndexes.Count = 0 And (Not rdgProjectCodeItems.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAdd" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="false" CssClass="GridCmdDeleteRows"
                                    OnClientClick="return ConfirmDelete();" Visible='<%# rdgProjectCodeItems.EditIndexes.Count = 0 And (Not rdgProjectCodeItems.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDelete" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                    CommandName="RebindGrid" Visible='<%# rdgProjectCodeItems.EditIndexes.Count = 0 And (Not rdgProjectCodeItems.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>

                    </MasterTableView>
                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                        AllowDragToGroup="false">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="False" />
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <ValidationSettings ValidationGroup="Save" EnableValidation="true" />
                </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
