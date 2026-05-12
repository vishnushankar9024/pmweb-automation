<%@ Page Language="vb" Title="Select Fields" AutoEventWireup="false" CodeBehind="SelectFieldsPopup.aspx.vb" Inherits="Website.SelectFieldsPopup" %>

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
                <telerik:AjaxSetting AjaxControlID="rdgHeaders">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgHeaders" LoadingPanelID="ldpFields" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgDetails" LoadingPanelID="ldpFields" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div>
            <telerik:RadAjaxLoadingPanel ID="ldpFields" runat="server" BackgroundPosition="Center" Skin="Default" />



            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="ToolbarTd">
                                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                        <Items>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
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
                                                <telerik:RadGrid ID="rdgHeaders" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="20" UseEditFormInMobile="true"
                                                    ShowFooter="false" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True"
                                                    AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                                        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                                        EditMode="InPlace" EnableHeaderContextMenu="False">
                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderText="Field Order"
                                                                UniqueName="FieldOrder" SortExpression="FieldOrder">
                                                                <ItemTemplate>
                                                                    &nbsp;
                                                                    <span><%#IIf(CBool(Eval("Send")) = CBool(1), Eval("FieldOrder"), String.Empty)%></span>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <span><%#IIf(CBool(IIf(Eval("Send") Is System.DBNull.Value, 0, Eval("Send"))) = CBool(1), Eval("FieldOrder"), String.Empty)%>&nbsp;</span>
                                                                </EditItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Type"
                                                                UniqueName="Type" SortExpression="Type">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%></span>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <span><%#Eval("Type")%>&nbsp;</span>
                                                                </EditItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Send" HeaderStyle-HorizontalAlign="Left" SortExpression="Send"
                                                                HeaderStyle-Width="100px" UniqueName="Send" Groupable="false">
                                                                <ItemTemplate>
                                                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Send")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:CheckBox ID="chkHeaderSend" Checked='<%# CBool(IIf(Eval("Send") Is System.DBNull.Value, 0, Eval("Send")))%>' runat="server" />
                                                                </EditItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Field"
                                                                UniqueName="Field" SortExpression="Field">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#IIf(Container.DataItem("Type") = "C", "&nbsp;", Container.DataItem("Field"))%>&nbsp;</span>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtField" runat="server" Text='<%# Eval("Field") %>' Width="100%"
                                                                        MaxLength="200"></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Alias" UniqueName="Alias" SortExpression="Alias">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#IIf(Container.DataItem("Alias") = String.Empty, "&nbsp;", Container.DataItem("Alias"))%></span>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <div>
                                                                        <asp:TextBox ID="txtHeadeAlias" runat="server" Text='<%# Eval("Alias") %>' Width="100%"
                                                                            MaxLength="300"></asp:TextBox>
                                                                    </div>
                                                                    <div>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtHeadeAlias"
                                                                            ValidationGroup="Header"
                                                                            runat="server" ForeColor="" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                                                        </asp:RequiredFieldValidator>
                                                                    </div>
                                                                </EditItemTemplate>
                                                                <HeaderStyle Width="200px"></HeaderStyle>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Custom Value"
                                                                UniqueName="CustomValue">
                                                                <ItemTemplate>
                                                                    <span>
                                                                        <%#IIf(Container.DataItem("Type") <> "C", "&nbsp;", Container.DataItem("Field"))%>&nbsp;</span>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtCustomValue" runat="server" Text="" Width="100%"
                                                                        MaxLength="200"></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <HeaderStyle Width="150px"></HeaderStyle>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <ItemStyle Wrap="false" />
                                                        <CommandItemTemplate>
                                                            <div style="padding: 2px">
                                                                &nbsp;&nbsp;
                                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgHeaders.EditIndexes.Count = 0 And (Not rdgHeaders.MasterTableView.IsItemInserted) %>'
                                                                    meta:resourcekey="btnEditSelectedResource1">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgHeaders.EditIndexes.Count > 0 %>'
                                                                    meta:resourcekey="btnUpdateEditedResource1" ValidationGroup="Header">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgHeaders.MasterTableView.IsItemInserted %>'
                                                                    meta:resourcekey="btnSaveResource1" ValidationGroup="Header">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                                    SecurityButtonType="AddEditMode" Visible='<%# rdgHeaders.EditIndexes.Count > 0 Or rdgHeaders.MasterTableView.IsItemInserted %>'
                                                                    meta:resourcekey="btnCancelResource1">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgHeaders.EditIndexes.Count = 0 And (Not rdgHeaders.MasterTableView.IsItemInserted) %>'
                                                                    meta:resourcekey="btnAddResource1">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgHeaders.EditIndexes.Count = 0 And (Not rdgHeaders.MasterTableView.IsItemInserted) %>'
                                                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </div>
                                                        </CommandItemTemplate>
                                                    </MasterTableView>
                                                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="True">
                                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                                            AllowColumnResize="True" />
                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                                        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                                    </ClientSettings>
                                                    <%--  <ValidationSettings ValidationGroup="Header" EnableValidation="true" CommandsToValidate="UpdateEdited" />--%>
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
        </div>

    </form>
</body>
</html>
