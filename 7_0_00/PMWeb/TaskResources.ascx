<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TaskResources.ascx.vb" Inherits="Website.TaskResources" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgResources">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style>
    .row{
        min-width:100%;
    }
</style>
<div class="PMHeader" style="padding-top:24px;padding-left:24px">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgResources" runat="server" UseEditFormInMobile="true" Width="50%"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                PageSize="12" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true"
                ItemStyle-Height="20px" CssClass="ResponsiveMargin">
                <PagerStyle Mode="NextPrevAndNumeric" />
                <GroupPanel Text="Group by"></GroupPanel>
                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Resource" Groupable="false" SortExpression="Resource" UniqueName="Resource">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Resource") = String.Empty, "&nbsp;", Container.DataItem("Resource"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlResources" runat="server" Width="300px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="250px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            &nbsp;&nbsp;

                       <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                           SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                           CommandName="PerformInsert" Visible='<%# rdgResources.MasterTableView.IsItemInserted %>'>
                           <span class="Icon"></span>
                           <asp:Label ID="Label14" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                       </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                CommandName="CancelAll" Visible='<%# rdgResources.EditIndexes.Count > 0 Or rdgResources.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label15" runat="server" Text="Cancel All"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" Visible='<%# rdgResources.EditIndexes.Count = 0 AND (Not rdgResources.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label16" runat="server" Text="Add"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="return ConfirmDelete();" Visible='<%# rdgResources.EditIndexes.Count = 0 AND (Not rdgResources.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label17" runat="server" Text="Delete"></asp:Label>&nbsp;&nbsp;
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
