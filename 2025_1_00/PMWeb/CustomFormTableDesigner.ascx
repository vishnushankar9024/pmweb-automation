<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CustomFormTableDesigner.ascx.vb" Inherits="Website.CustomFormTableDesigner1" %>
<telerik:RadAjaxManagerProxy ID="PmAjaxManager" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCustomFormTable">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCustomFormTable" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
<telerik:RadGrid ID="rdgCustomFormTable" runat="server" 
    Skin="Default" AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="250"
    AllowPaging="True" AllowMultiRowEdit="False" AllowMultiRowSelection="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
    AllowSorting="True" GridLines="None" ShowGroupPanel="false" GroupingEnabled="false" Width="100%" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace" TableLayout="Fixed">
        <Columns>
        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
                &nbsp;&nbsp; 
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit"
                    Visible='<%# rdgCustomFormTable.EditIndexes.Count = 0 And (Not rdgCustomFormTable.MasterTableView.IsItemInserted)%>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="True" ValidationGroup="DSave" CommandName="UpdateEdited"
                    SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgCustomFormTable.EditIndexes.Count > 0%>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" ValidationGroup="DSave" CommandName="PerformInsert"
                    SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgCustomFormTable.MasterTableView.IsItemInserted%>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode"
                    Visible='<%# rdgCustomFormTable.EditIndexes.Count > 0 Or rdgCustomFormTable.MasterTableView.IsItemInserted%>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add"
                    Visible='<%# rdgCustomFormTable.EditIndexes.Count = 0 And (Not rdgCustomFormTable.MasterTableView.IsItemInserted)%>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    SecurityButtonType="ItemMode_Delete"
                    Visible='<%# rdgCustomFormTable.EditIndexes.Count = 0 And (Not rdgCustomFormTable.MasterTableView.IsItemInserted)%>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgCustomFormTable.EditIndexes.Count = 0 And (Not rdgCustomFormTable.MasterTableView.IsItemInserted)%>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />

    </ClientSettings>

</telerik:RadGrid>
