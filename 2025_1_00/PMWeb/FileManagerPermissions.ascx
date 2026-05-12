<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FileManagerPermissions.ascx.vb" Inherits="Website.FileManagerPermissions" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="" />

            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="mlpFolderManager" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSaveAdvanced">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="mlpFolderManager" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnEdit">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdgFolderGroups" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnSave" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnSaveAdvanced" LoadingPanelID="" />
                <telerik:AjaxUpdatedControl ControlID="chkApplyToChildren" LoadingPanelID="" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    input[type="checkbox"] + label {
        position: relative;
        bottom: 3px;
    }
    .Grid-5-rows .rgDataDiv{
        max-height:177px;
    }
    .InheritedMsg{
        display:block;
        padding-top:22px;
    }

</style>

<div class="PMMainPage">
    <asp:Label ID="lblInheritedMessage" meta:resourcekey="lblInheritedPermissionMessage" runat="server" CssClass="Italic InheritedMsg" Text="(Permissions were inherited from a parent folder and edits here may be overwritten at any time)"></asp:Label>      
    <div class="row"  style="padding-top: 18px;">
        <div class="col-4 col-4-left">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblApplyToChildren" runat="server" Text="Apply to all sub-folders" meta:resourcekey="chkApplyToChildren"></asp:Label>
                    </td>
                    <td>
                        <label class="switch">
                            <input id="chkApplyToChildren" runat="server" type="checkbox" checked="checked" />
                            <span class="slider round"></span>
                        </label>
                    </td>
<%--                    <td class="controlWidth">
                        <asp:CheckBox ID="chkApplyToChildren" runat="server" />
                    </td>--%>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnSaveAdvanced" meta:resourcekey="btnSaveAdvanced" runat="server" Text="Save" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
   <%-- <div class="row">
        <div class="col-4 col-4-left">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblGroupPermissions1" meta:resourcekey="lblGroupPermissions" CssClass="Bold" runat="server" Text="Role Permissions"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:Panel ID="pnlEditInheritance" runat="server">
                            <asp:Button ID="btnEdit" meta:resourcekey="btnEdit" runat="server" Text="Edit Permissions" />&nbsp;
                <asp:Label ID="lblInheritedMessage" meta:resourcekey="lblInheritedMessage" runat="server" CssClass="Italic" Text="(Permissions are inherited from parent)"></asp:Label>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
    </div>--%>
    <div class="row" style="padding-top: 10px;">
        <div class="col-12">  
            <fieldset>
                <legend>
                    <asp:Label ID="lblGroupPermissions" meta:resourcekey="lblGroupPermissions" runat="server" Text="Role Permissions"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgGroups" runat="server" AllowMultiRowSelection="True" useeditforminmobile="true" SetWidth="true"
                    AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True" ClientSettings-Scrolling-UseStaticHeaders="true"
                    AllowMultiRowEdit="true" Width="100%" CssClass="Grid-5-rows">
                    <HeaderStyle Font-Size="8pt" />
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" />
                    </ClientSettings>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        CommandItemDisplay="None" CssClass="MaxWidth" DataKeyNames="GroupId">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Security Group" UniqueName="SecurityGroup" ItemStyle-Width="30%" Headerstyle-Width="30%">
                                <ItemTemplate>
                                    <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("GroupName")%>' />
                                    <asp:HiddenField ID="hdnHasAdminRole" Value='<%#Eval("HasAdminRole")%>' runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#CStr(Container.DataItem("FullControl"))%>' />
                                </ItemTemplate>
                                <ItemStyle Wrap="false" HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Add Files" UniqueName="UploadFiles" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkUploadFiles" runat="server" Checked='<%#ParseBool(Eval("UploadFiles"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Delete/Move Files" UniqueName="DeleteFiles" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkDeleteFiles" runat="server" Checked='<%#ParseBool(Eval("DeleteFiles"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Files" UniqueName="EditFiles" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEditFiles" runat="server" Checked='<%#ParseBool(Eval("EditFiles"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                  <telerik:RadGrid ID="rdgFolderGroups" runat="server" AllowMultiRowSelection="True" useeditforminmobile="true" SetWidth="true"
                    AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True" ClientSettings-Scrolling-UseStaticHeaders="true"
                    AllowMultiRowEdit="true" Width="100%" CssClass="Grid-5-rows">
                    <HeaderStyle Font-Size="8pt" />
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" />
                    </ClientSettings>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        CommandItemDisplay="None" CssClass="MaxWidth" DataKeyNames="GroupFolderId">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Folder Group" UniqueName="FolderGroup" ItemStyle-Width="30%" Headerstyle-Width="30%">
                                <ItemTemplate>
                                    <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("GroupFolderName")%>' />
                                    <asp:HiddenField ID="hdnHasAdminRole" Value='<%#Eval("HasAdminRole")%>' runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#CStr(Container.DataItem("FullControl"))%>' />
                                </ItemTemplate>
                                <HeaderStyle Wrap="false" Width="10%" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Add Files" UniqueName="UploadFiles" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkUploadFiles" runat="server" Checked='<%#ParseBool(Eval("UploadFiles"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Delete/Move Files" UniqueName="DeleteFiles" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkDeleteFiles" runat="server" Checked='<%#ParseBool(Eval("DeleteFiles"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Files" UniqueName="EditFiles" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEditFiles" runat="server" Checked='<%#ParseBool(Eval("EditFiles"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="10%" Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <fieldset>
                <legend>
                    <asp:Label ID="lblUserPermissions" meta:resourcekey="lblUserPermissions" runat="server" Text="User Permissions"></asp:Label>
                </legend>
                <asp:Button ID="btnSave" runat="server" Text="Save" meta:resourcekey="btnSave" />
                <telerik:RadGrid ID="rdgUsers" runat="server" AllowMultiRowSelection="True" FitPageHeightOffset="36" SetWidth="true" 
                    AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                    AllowPaging="True" AllowMultiRowEdit="true" PageSize="250" Width="100%">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <HeaderStyle Font-Size="8pt" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        CssClass="MaxWidth" DataKeyNames="UserId" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                        EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="User*" UniqueName="Username" ItemStyle-Width="30%"  Headerstyle-Width="30%">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Username") = String.Empty, "&nbsp;", Container.DataItem("Username"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AllowCustomText="true" ValidationGroup="Save" Height="250px">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvUsers" runat="server" meta:resourcekey="rfvUsers" ControlToValidate="ddlUsers"
                                        CssClass="Validator" ErrorMessage="Select user" Display="Dynamic" ForeColor=""
                                        ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' />
                                </EditItemTemplate>
                                
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("FullControl")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#ParseBool(Eval("FullControl"))%>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center"/>
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ViewOnly")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("ManageFolder")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Add Files" UniqueName="UploadFiles" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("UploadFiles")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkUploadFiles" runat="server" Checked='<%#ParseBool(Eval("UploadFiles"))%>' />
                                </EditItemTemplate>
                                <HeaderStyle HorizontalAlign="Center"/>
                                <ItemStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Delete/Move Files" UniqueName="DeleteFiles" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("DeleteFiles")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkDeleteFiles" runat="server" Checked='<%#ParseBool(Eval("DeleteFiles"))%>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center"/>
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Files" UniqueName="EditFiles" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("EditFiles")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkEditFiles" runat="server" Checked='<%#ParseBool(Eval("EditFiles"))%>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center"  />
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="10%"  Headerstyle-Width="10%">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("EditPermissions")), "checked.png", "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center"/>
                                <HeaderStyle HorizontalAlign="Center" Font-Size="8pt" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditItemStyle Wrap="false" />
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                    SecurityButtonType="AddEditMode_Edit"
                                    CommandName="UpdateEdited" Visible='<%# rdgUsers.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                                    SecurityButtonType="AddEditMode_Add"
                                    CommandName="PerformInsert" Visible='<%# rdgUsers.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                    SecurityButtonType="AddEditMode"
                                    CommandName="CancelAll" Visible='<%# rdgUsers.EditIndexes.Count > 0 Or rdgUsers.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add"
                                    CommandName="InitNewRow" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                    Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                    SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode"
                                    CommandName="RebindGrid" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                        AllowDragToGroup="false">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" />
                    </ClientSettings>
                    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />

                </telerik:RadGrid>
            </fieldset>
        </div>

    </div>

</div>



