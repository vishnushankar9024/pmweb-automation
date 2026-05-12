<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderPermissions.ascx.vb" Inherits="Website.QueryBuilderPermissions" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="" />

            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSaveGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="btnSaveGroups" LoadingPanelID="" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnEdit">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnSaveAdvanced" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="btnSaveGroups" LoadingPanelID="" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
    <AjaxSettings>

        <telerik:AjaxSetting AjaxControlID="btnSaveAdvanced">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnSaveAdvanced" LoadingPanelID="" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    div#ctl00_CPH1_QueryBuilderPermissions1_rdgGroups_GridData {
        max-height: 177px !important;
    }

    table#ctl00_CPH1_QueryBuilderPermissions1_rdgUsers_ctl00 {
        height: 244px !important;
    }

    div#ctl00_CPH1_QueryBuilderPermissions1_rdgUsers_GridData {
        height: 244px !important;
    }

    .RadGrid_Default .rgAltRow, .RadGrid_Default .rgRow{
        height: 27px !important;
        max-height: 27px !important;
    }
</style>
<div class="PMMainPage">
    <div class="row">
        <div class="col-12">
            <table class="colTable">
                <tr>
                    <td>
                        <table class="colTable">
                            <tr>
                                <td style="width: 270px; color: #666666;">
                                    <asp:Label ID="lblApplyToChildren" runat="server" Text="Apply to All Child Folders and Reports" meta:resourcekey="chkApplyToAll"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkApplyToChildren" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblGroupPermissions" meta:resourcekey="lblGroupPermissions" runat="server" Text="Role Permissions"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <asp:Panel ID="pnlEditInheritance" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td style="padding-left: 15px;">
                                                        <asp:Button ID="btnEdit" meta:resourcekey="btnEdit" Style="max-width: 200px" runat="server" Text="Edit Permissions" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblInheritedMessage" runat="server" CssClass="Italic" Text="(Permissions are inherited from parent)"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgGroups" runat="server" AllowMultiRowSelection="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                            AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                                            Skin="Default" AllowMultiRowEdit="true" Width="100%">
                                            <HeaderStyle Font-Size="8pt" />
                                            <ClientSettings Selecting-AllowRowSelect="true">
                                                <Selecting AllowRowSelect="True" />
                                            </ClientSettings>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                CommandItemDisplay="None" CssClass="MaxWidth" DataKeyNames="GroupId">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Role" UniqueName="Role" ItemStyle-Width="300px" HeaderStyle-Width="300px">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("GroupName")%>' />
                                                            <asp:HiddenField ID="hdnHasAdminRole" Value='<%#Eval("HasAdminRole")%>' runat="server" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Full Control" UniqueName="FullControl" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#CStr(Container.DataItem("FullControl"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Add Report" UniqueName="AddQuery" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAddQuery" runat="server" Checked='<%#ParseBool(Eval("AddQuery"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Delete Report" UniqueName="DeleteQuery" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkDeleteQuery" runat="server" Checked='<%#ParseBool(Eval("DeleteQuery"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Edit Report" UniqueName="EditQuery" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkEditQuery" runat="server" Checked='<%#ParseBool(Eval("EditQuery"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <asp:Button ID="btnSaveGroups" runat="server" Text="Save" meta:resourcekey="btnSaveGroups" Style="max-width: 200px;" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblUserPermissions" meta:resourcekey="lblUserPermissions" runat="server" Text="User Permissions"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgUsers" runat="server" AllowMultiRowSelection="True" UseEditFormInMobile="true" SetWdith="true" ClientSettings-Scrolling-AllowScroll="true"
                                            AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                                            Skin="Default" AllowPaging="True" AllowMultiRowEdit="true" PageSize="10" Width="100%">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                CssClass="MaxWidth" DataKeyNames="UserId" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                                InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                                                EditMode="InPlace">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="User" UniqueName="Username" ItemStyle-Width="300px" HeaderStyle-Width="300px">
                                                        <ItemTemplate>
                                                            <span><%#IIf(Container.DataItem("Username") = String.Empty, "&nbsp;", Container.DataItem("Username"))%></span>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" Filter="Contains"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select user..."
                                                                NoWrap="True" AllowCustomText="true" ValidationGroup="Save" Height="250px">
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="rfvUsers" runat="server" meta:resourcekey="rfvUsers" ControlToValidate="ddlUsers"
                                                                CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                                                ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' />
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Full Control" UniqueName="FullControl" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("FullControl")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#ParseBool(Eval("FullControl"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ViewOnly")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ManageFolder")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Add Reports" UniqueName="AddQuery" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("AddQuery")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkAddQuery" runat="server" Checked='<%#ParseBool(Eval("AddQuery"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Delete Reports" UniqueName="DeleteQuery" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("DeleteQuery")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkDeleteQuery" runat="server" Checked='<%#ParseBool(Eval("DeleteQuery"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Edit Reports" UniqueName="EditQuery" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("EditQuery")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkEditQuery" runat="server" Checked='<%#ParseBool(Eval("EditQuery"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="125px" HeaderStyle-Width="125px">
                                                        <ItemTemplate>
                                                            <img src="Images/Global/<%#CStr(IIf(CBool(Eval("EditPermissions")), "checked.png", "unchecked.png"))%>" alt="" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <EditItemStyle Wrap="false" />
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">
                                                        &nbsp;&nbsp;
                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                                            SecurityButtonType="ItemMode_Edit"
                                                            CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                                            SecurityButtonType="AddEditMode_Edit"
                                                            CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgUsers.EditIndexes.Count > 0 %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                                            SecurityButtonType="AddEditMode_Add"
                                                            CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgUsers.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                                            SecurityButtonType="AddEditMode"
                                                            CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgUsers.EditIndexes.Count > 0 Or rdgUsers.MasterTableView.IsItemInserted %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                                            SecurityButtonType="ItemMode_Add"
                                                            CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                                            Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                                            SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                                            SecurityButtonType="ItemMode"
                                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                                AllowDragToGroup="false">
                                                <Selecting AllowRowSelect="True" />
                                            </ClientSettings>
                                            <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />

                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <asp:Button ID="btnSaveAdvanced" runat="server" Text="Save" meta:resourcekey="btnSaveAdvanced" Style="max-width: 200px;" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
