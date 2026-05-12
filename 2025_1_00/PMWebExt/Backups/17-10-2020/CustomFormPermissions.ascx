<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomFormPermissions.ascx.vb" Inherits="Website.CustomFormPermissions" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMMainPage">
    <div class="row row-8-4">
        <div class="col-8">
            <fieldset style="padding-bottom:5px;">
                <legend>
                    <asp:Label ID="lblGroupPermissions" meta:resourcekey="lblGroupPermissions" runat="server" Text="Roles"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgGroups" runat="server" AllowMultiRowSelection="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                    Skin="Default" AllowMultiRowEdit="true">
                    <HeaderStyle Font-Size="8pt" />
                    <ClientSettings Selecting-AllowRowSelect="true">
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        CommandItemDisplay="Top" CssClass="MaxWidth" DataKeyNames="GroupId">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Role" UniqueName="Role">
                                <ItemTemplate>
                                    <asp:Label ID="lblGroupName" runat="server" Text='<%#Eval("GroupName")%>' />
                                    <asp:HiddenField ID="hdnHasAdminRole" Value='<%#Eval("HasAdminRole")%>' runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Width="230px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#CStr(Container.DataItem("FullControl"))%>' CssClass="mobile-switch" />
                                </ItemTemplate>
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="121px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_View %>" UniqueName="View">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkCanRead" runat="server" Checked='<%#CStr(Container.DataItem("CanRead"))%>' CssClass="mobile-switch" />
                                </ItemTemplate>
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Create %>" UniqueName="Create">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkCanAdd" runat="server" Checked='<%#CStr(Container.DataItem("CanAdd"))%>' CssClass="mobile-switch" />
                                </ItemTemplate>
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Delete %>" UniqueName="Delete">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkCanDelete" runat="server" Checked='<%#CStr(Container.DataItem("CanDelete"))%>' CssClass="mobile-switch" />
                                </ItemTemplate>
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Edit %>" UniqueName="Edit">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkCanEdit" runat="server" Checked='<%#CStr(Container.DataItem("CanEdit"))%>' CssClass="mobile-switch" />
                                </ItemTemplate>
                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' CssClass="mobile-switch" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Width="121px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                &nbsp;&nbsp;
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="ItemMode_Edit" CommandName="Save" CssClass="GridCmdSave" meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            </div>
                        </CommandItemTemplate>
                        <DetailTables>
                            <telerik:GridTableView SkinID="PM" ShowHeader="False" CommandItemDisplay="None" AllowSorting="false" AllowPaging="false"
                                DataKeyNames="FieldId,GroupId,IsObjectTypeField,IsCustomTable" Width="100%" EditMode="InPlace" Name="FieldRights">
                                <Columns>

                                    <telerik:GridBoundColumn DataField="FieldFriendlyName">
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Width="229px" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="121px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Visible" UniqueName="isVisible">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkFieldCanView" runat="server" Checked='<%#CStr(Container.DataItem("IsVisible"))%>' CssClass="mobile-switch" />
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="isEditable">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkFieldCanEdit" runat="server" Checked='<%#CStr(Container.DataItem("isEditable"))%>' CssClass="mobile-switch" />
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="120px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                </Columns>


                            </telerik:GridTableView>

                        </DetailTables>
                    </MasterTableView>
                </telerik:RadGrid>
            </fieldset>
            <%--<tr>
        <td style="text-align:right; padding-right:10px;">
            <asp:Button ID="btnSaveGroups" runat="server" Text="Save" meta:resourcekey="btnSaveGroups" />
        </td>
    </tr>--%>

            <fieldset>
                <legend>
                    <asp:Label ID="lblUserPermissions" meta:resourcekey="lblUserPermissions" runat="server" Text="Users"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgUsers" runat="server" AllowMultiRowSelection="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                    AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="True"
                    Skin="Default" AllowPaging="True" AllowMultiRowEdit="true" PageSize="10">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <HeaderStyle Font-Size="8pt" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        CssClass="MaxWidth" DataKeyNames="UserId" CommandItemDisplay="Top" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                        EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="User" UniqueName="Username" HeaderStyle-Width="229px">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Username") = String.Empty, "&nbsp;", Container.DataItem("Username"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" DropDownWidth="200px" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select user..."
                                        NoWrap="True" AllowCustomText="true" ValidationGroup="Save"
                                        Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvUsers" runat="server" meta:resourcekey="rfvUsers" ControlToValidate="ddlUsers"
                                        CssClass="Validator" ErrorMessage="Select user" Display="Dynamic" ForeColor=""
                                        ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_FullControl %>" UniqueName="FullControl">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectFullControl" runat="server" CssClass="mobile-switch" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkFullControl" runat="server" Checked='<%#ParseBool(Eval("FullControl"))%>' CssClass="mobile-switch" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="121px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_View %>" UniqueName="View">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectCanRead" runat="server" CssClass="mobile-switch" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkCanRead" runat="server" Checked='<%#ParseBool(Eval("CanRead"))%>' CssClass="mobile-switch" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Create %>" UniqueName="Create">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectCanAdd" runat="server" CssClass="mobile-switch" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkCanAdd" runat="server" Checked='<%#ParseBool(Eval("CanAdd"))%>' CssClass="mobile-switch" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Delete %>" UniqueName="Delete">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectCanDelete" runat="server" CssClass="mobile-switch" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkCanDelete" runat="server" Checked='<%#ParseBool(Eval("CanDelete"))%>' CssClass="mobile-switch" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Edit %>" UniqueName="Edit">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectCanEdit" runat="server" CssClass="mobile-switch" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkCanEdit" runat="server" Checked='<%#ParseBool(Eval("CanEdit"))%>' CssClass="mobile-switch" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Edit Permissions" UniqueName="EditPermissions">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectEditPermissions" runat="server" CssClass="mobile-switch" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkEditPermissions" runat="server" Checked='<%#ParseBool(Eval("EditPermissions"))%>' CssClass="mobile-switch" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Wrap="false" Width="120px" HorizontalAlign="Center" />
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
                                <asp:LinkButton ID="btnUpdatePermission" runat="server" ValidationGroup="Save"
                                    SecurityButtonType="ItemMode_Edit"
                                    CommandName="SavePermissions" CssClass="GridCmdSavePermissions" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                    SecurityButtonType="ItemMode"
                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                        <DetailTables>
                            <telerik:GridTableView SkinID="PM" ShowHeader="False" CommandItemDisplay="None" AllowSorting="false" AllowPaging="false"
                                DataKeyNames="FieldId,UserId,IsObjectTypeField,IsCustomTable" Width="100%" EditMode="InPlace" Name="FieldRights">
                                <Columns>

                                    <telerik:GridBoundColumn DataField="FieldFriendlyName">
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Width="229px" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="121px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Visible" UniqueName="isVisible">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkFieldCanView" runat="server" Checked='<%#CStr(Container.DataItem("IsVisible"))%>' CssClass="mobile-switch" />
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Edit" UniqueName="isEditable">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkFieldCanEdit" runat="server" Checked='<%#CStr(Container.DataItem("isEditable"))%>' CssClass="mobile-switch" />
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="77px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn>
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                        <HeaderStyle Wrap="false" Width="120px" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                </Columns>


                            </telerik:GridTableView>

                        </DetailTables>
                    </MasterTableView>
                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                        AllowDragToGroup="false">
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />

                </telerik:RadGrid>
            </fieldset>

        </div>
        <div class="col-4"></div>
    </div>
</div>

