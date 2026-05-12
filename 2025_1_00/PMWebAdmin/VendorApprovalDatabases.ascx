<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalDatabases.ascx.vb" Inherits="Website.VendorApprovalDatabases" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProx1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDatabases">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDatabases" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    .RadGrid_Default {
    border: 1px solid #666666;
    color: #333333 !important;
    background-color: #ffffff;
    line-height: 16px;
    width: 99.5% !important;
}
</style>

            <telerik:RadGrid ID="rdgDatabases" runat="server" EnableEmbeddedSkins="False" Skin="Default" AutoGenerateColumns="False" ShowStatusBar="True" FitParentContainer="true" Width="100%"
                ShowFooter="false" AllowPaging="true" ShowGroupPanel="false" AllowMultiRowEdit="True" AllowMultiRowSelection="True" SetWidth="true"
                AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8">
                <HeaderContextMenu EnableEmbeddedSkins="False" EnableViewState="false"></HeaderContextMenu>
                <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Display" UniqueName="Display"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="Display">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Display"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbDisplay" Checked='<%# Cbool(IIF(Eval("Display") is system.DBNULL.value, 0,Eval("Display")))%>' runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="70px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="100px" UniqueName="Database" HeaderText="Database" ItemStyle-Wrap="false"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="DatabaseName">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("DatabaseName").ToString = String.Empty, "&nbsp;", Container.DataItem("DatabaseName").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDatabaseName" MaxLength="50" runat="server" Text='<%# Eval("DatabaseName") %>' Width="100%"></asp:TextBox>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvDatabaseName" runat="server" ControlToValidate="txtDatabaseName"
                                        CssClass="Validator" ErrorMessage="Enter Database Name"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="400px" HeaderText="Link" ItemStyle-Wrap="false" UniqueName="Link"
                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Reorderable="true" SortExpression="Link">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Link").ToString = String.Empty, "&nbsp;", Container.DataItem("Link").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtLink" runat="server" Text='<%# Eval("Link") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="400px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;


                              <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEdit"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgDatabases.EditIndexes.Count = 0 And (Not rdgDatabases.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                               &nbsp;&nbsp;  
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CssClass="GridCmdSave"
                                SecurityButtonType="AddEditMode_Edit"
                                ValidationGroup="Save" CommandName="UpdateEdited"
                                Visible='<%# rdgDatabases.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"  CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                CommandName="PerformInsert"
                                Visible='<%# rdgDatabases.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CssClass="GridCmdCancel"
                                SecurityButtonType="AddEditMode"
                                CommandName="CancelAll"
                                Visible='<%# rdgDatabases.EditIndexes.Count > 0 Or rdgDatabases.MasterTableView.IsItemInserted %>'>
                                 <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CssClass="GridCmdRefresh "
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid"
                                Visible='<%# rdgDatabases.EditIndexes.Count = 0 AND (Not rdgDatabases.MasterTableView.IsItemInserted) %>'>
                                 <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
 
