<%@ Page Language="vb" Title="Cost Level Values" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="BudgetGroupDetailsPopup.aspx.vb" Inherits="Website.BudgetGroupDetailsPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Costs/BudgetSetup.js" type="text/javascript"></script>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgBudgetGroupDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlNumCharac" />
                        <telerik:AjaxUpdatedControl ControlID="rdgBudgetGroupDetails" LoadingPanelID="ldpBudgetGroupDetails" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <ClientEvents OnRequestStart="RequestStart" />
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpBudgetGroupDetails" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width:160px !important;">
                                <asp:Label ID="lblLevelNumber" meta:resourcekey="lblLevelNumber" runat="server" Text="Level #"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:240px !important;">
                                <asp:TextBox ID="txtGroupNumber" runat="server" Style="text-align:right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" meta:resourcekey="lblDescription1" runat="server" Text="Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNumbCharacter" meta:resourcekey="lblNumbofCharacter" runat="server" Text="# Characters"></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align:right" >
                                <telerik:RadComboBox ID="ddlNumCharac" runat="server" ></telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row row-8-4">
                <div class="col-8">
                <textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>
                    
                    <telerik:RadGrid ID="rdgBudgetGroupDetails" runat="server" HasPasteFromExcel="true" CssClass="ResponsiveMargin"
                        AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8"
                        PageSize="250" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false" SetWidth="true" AppendMenus="true"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true"
                        ItemStyle-Height="20px" UseEditFormInMobile="true">
                        <PagerStyle Mode="NextPrevAndNumeric" />
                        <GroupPanel Text="Group by"></GroupPanel>
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id,IsUsed" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="true">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="ID*" Groupable="false" SortExpression="DetailNumber" UniqueName="DetailNumber">
                                    <ItemTemplate>
                                        <span><%#Eval("DetailNumber")%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDetailNumber" runat="server" Width="100%"
                                            Text='<%# Eval("DetailNumber") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDetailNumber" runat="server" ControlToValidate="txtDetailNumber"
                                            CssClass="Validator" ErrorMessage="<br/>Enter The ID" Display="Dynamic"
                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="75px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description*" Groupable="false" SortExpression="Description" UniqueName="Description">
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
                                    <HeaderStyle Width="200px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Text 1" Groupable="false" SortExpression="Text1" UniqueName="Text1">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Text1") = String.Empty, "&nbsp;", Container.DataItem("Text1"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtText1" runat="server" Width="100%"
                                            Text='<%# Eval("Text1") %>' MaxLength="500"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="140px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Text 2" Groupable="false" SortExpression="Text2" UniqueName="Text2">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Text2") = String.Empty, "&nbsp;", Container.DataItem("Text2"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtText2" runat="server" Width="100%"
                                            Text='<%# Eval("Text2") %>' MaxLength="500"></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="140px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Account" Groupable="false" UniqueName="Account" DataField="GLAccount" SortExpression="GLAccount">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("GLAccount") = String.Empty, "&nbsp;", Container.DataItem("GLAccount"))%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox MarkFirstMatch="False" Filter="Contains" AllowCustomText="True" ID="ddlGLAccount" runat="server" Width="100%" Height="200px" Skin="Default"></telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="IsUsed" UniqueName="IsUsed" Display="false"></telerik:GridBoundColumn>

                            </Columns>
                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            <SortExpressions>
                                <telerik:GridSortExpression FieldName="DetailNumber"></telerik:GridSortExpression>
                            </SortExpressions>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                            SecurityButtonType="ItemMode_Edit"
                            CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count = 0 And (Not rdgBudgetGroupDetails.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                        </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="PerformUpdate" CssClass="GridCmdPerformUpdate" Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                        SecurityButtonType="AddEditMode_Add"
                                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgBudgetGroupDetails.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                        SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count > 0 Or rdgBudgetGroupDetails.MasterTableView.IsItemInserted %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Add"
                                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count = 0 And (Not rdgBudgetGroupDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="return ConfirmDeleteDetailsRows();" Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count = 0 And (Not rdgBudgetGroupDetails.MasterTableView.IsItemInserted) %>'
                                        SecurityButtonType="ItemMode_Delete"
                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnExportExcel" runat="server"
                                        SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                        Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count = 0 And (Not rdgBudgetGroupDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label8" Text="Export To Exel" runat="server"></asp:Label>
                                        &nbsp;&nbsp
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                        SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                        Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count = 0 And (Not rdgBudgetGroupDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode"
                                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgBudgetGroupDetails.EditIndexes.Count = 0 And (Not rdgBudgetGroupDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>

                        </MasterTableView>
                        <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                            AllowDragToGroup="false">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
                    </telerik:RadGrid>

                </div>
                <div class="col-4"></div>
            </div>
        </div>

        <%--     <div style="width: 100%; text-align: right">
                        <asp:Button ID="btnClose" runat="server" Text="<%$ Resources:PMWeb, Close %>" />
                    </div>--%>
        <telerik:RadCodeBlock ID="CodeBlock1" runat="server">
            <script type="text/javascript">
                //<![CDATA[
                var rdgBudgetGroupDetails;
                function pageLoad() {
                    rdgBudgetGroupDetails = $find("<%= rdgBudgetGroupDetails.ClientID %>");
                    }
                    var gridId = "<%=rdgBudgetGroupDetails.ClientID %>";
                //]]>
            </script>
        </telerik:RadCodeBlock>


        <input type="button" id="btnClipborad" class="Hide" runat="server" />
        <input type="hidden" id="hdClipboard" runat="server" />
    </form>

</body>
</html>
