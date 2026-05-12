<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ReportManagerPermissions.ascx.vb" Inherits="Website.ReportManagerPermissions" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgUsers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM"/>
                    <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="ldpPM" />
                    
                </UpdatedControls>                    
            </telerik:AjaxSetting>   
            <telerik:AjaxSetting AjaxControlID="btnEdit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlEditInheritance" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnSaveGroups" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnSaveAdvanced" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>   
            <telerik:AjaxSetting AjaxControlID="btnSaveGroups">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnSaveGroups" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnSaveAdvanced" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<table width="99%" cellpadding="0" cellspacing="0">
    <tr>
        <td class="Padding7" style="white-space:nowrap" nowrap>
            <asp:Label ID="lblGroupPermissions" meta:resourcekey="lblGroupPermissions" CssClass="Bold" runat="server" Text="Role Permissions"></asp:Label>
        </td>
        <td style="width:100%" >
            <asp:Panel ID="pnlEditInheritance" runat="server">
                <asp:Button ID="btnEdit" meta:resourcekey="btnEdit" runat="server" Text="Edit Permissions" />&nbsp;
                <asp:Label ID="lblInheritedMessage" runat="server" CssClass="Italic" Text="(Permissions are inherited from parent)"></asp:Label>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="width: 100%" class="Top">
            <telerik:RadGrid ID="rdgGroups" runat="server" AllowMultiRowSelection="True"
                AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                Skin="Default" AllowMultiRowEdit="true" Width="98%">
                <HeaderStyle Font-Size="8pt" />
                <ClientSettings Selecting-AllowRowSelect="true">
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="None" CssClass="MaxWidth"  DataKeyNames="GroupId">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Role" UniqueName="Role" ItemStyle-Width="40%">
                            <ItemTemplate>
                                <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("GroupName")%>' />
                                <asp:HiddenField ID="hdnHasAdminRole" Value='<%#Eval("HasAdminRole")%>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                           
                           <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#CStr(Container.DataItem("FullControl"))%>' />
                                </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Wrap="false" Width="10%" HorizontalAlign="Center" />
                           </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Add Reports" UniqueName="AddReports" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkAddReports" runat="server" Checked='<%#ParseBool(Eval("AddReports"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Delete Reports" UniqueName="DeleteReports" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkDeleteReports" runat="server" Checked='<%#ParseBool(Eval("DeleteReports"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Edit Reports" UniqueName="EditReports" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkEditReports" runat="server" Checked='<%#ParseBool(Eval("EditReports"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="10%">
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
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" style="text-align:right; padding-right:19px;">
            <asp:Button ID="btnSaveGroups" runat="server" Text="Save" meta:resourcekey="btnSaveGroups" width="140px"/>
        </td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2" style="width: 100%" class="Padding7">
            <asp:Label ID="lblUserPermissions" meta:resourcekey="lblUserPermissions" CssClass="Bold" runat="server" Text="User Permissions"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="width: 100%" class="Top">
            <telerik:RadGrid ID="rdgUsers" runat="server" AllowMultiRowSelection="True" UseEditFormInMobile ="true"
                AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                Skin="Default" AllowPaging="True" AllowMultiRowEdit="true" PageSize="250" Width="98%">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CssClass="MaxWidth"  DataKeyNames="UserId" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                    EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="User" UniqueName="Username" ItemStyle-Width="40%">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Username") = String.Empty, "&nbsp;", Container.DataItem("Username"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" DropDownWidth="200px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select user..."
                                    NoWrap="True" AllowCustomText="true" ValidationGroup="Save" 
                                    Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvUsers" runat="server" meta:resourcekey="rfvUsers" ControlToValidate="ddlUsers"
                                    CssClass="Validator" ErrorMessage="Select user" Display="Dynamic" ForeColor=""
                                    ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                           <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl">
                                <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("FullControl")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#ParseBool(Eval("FullControl"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="View" UniqueName="View" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("ViewOnly")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkViewOnly" runat="server" Checked='<%#ParseBool(Eval("ViewOnly"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Manage Folders" UniqueName="ManageFolder" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("ManageFolder")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkManageFolder" runat="server" Checked='<%#ParseBool(Eval("ManageFolder"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Add Reports" UniqueName="AddReports" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("AddReports")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkAddReports" runat="server" Checked='<%#ParseBool(Eval("AddReports"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Delete Reports" UniqueName="DeleteReports" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("DeleteReports")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkDeleteReports" runat="server" Checked='<%#ParseBool(Eval("DeleteReports"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Edit Reports" UniqueName="EditReports" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("EditReports")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkEditReports" runat="server" Checked='<%#ParseBool(Eval("EditReports"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("EditPermissions")),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditItemStyle Wrap="false" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                    <CommandItemTemplate> 
                        <div style="padding:2px">
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
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
                                CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span> 
                               <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>                        
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" 
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
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
        <td colspan="2" style="height:30px;"></td>
    </tr>
    <tr>
        <td colspan="2" style="width: 100%" class="Padding7">
            <asp:Label ID="lblAdvanced" meta:resourcekey="lblAdvanced" CssClass="Bold" runat="server" Text="Advanced Security Settings"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:CheckBox ID="chkApplyToChildren" meta:resourcekey="chkApplyToChildren" runat="server" Text="Apply to all children folders and sub-folders" />
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align:right; padding-right:19px;padding-top:15px;padding-bottom:24px;">
            <asp:Button ID="btnSaveAdvanced" runat="server" Text="Save" meta:resourcekey="btnSaveAdvanced" width="140px" />
        </td>
    </tr>
</table>

