<%@ Control Language="vb" AutoEventWireup="false" ClassName="CustomFormCustomTable" CodeBehind="CustomFormCustomTable.ascx.vb" Inherits="Website.CustomFormCustomTable" %>

<div class="PMHeader">
    <div class="row" style="padding-top:5px;">
        <div class="col-12">
            <fieldset runat="server" id="fldTitle">
                <legend>
                    <asp:Label runat="server" ID="lblTitle"></asp:Label>
                </legend>
                <div>
                    <telerik:RadGrid ID="rdg" runat="server" Skin="Default" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                        ClientSettings-Scrolling-AllowScroll="true" SetWidth="true" AppendMenus="true" 
                        GridLines="None" AllowPaging="true" PageSize="20" PagerStyle-AlwaysVisible="true" UseEditFormInMobile="true">
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
                                Visible='<%# rdg.EditIndexes.Count = 0 AND (Not rdg.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                                    <asp:LinkButton ID="btnCustomTableUpdateEdited" runat="server" CausesValidation="True" ValidationGroup="DSave" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                        SecurityButtonType="AddEditMode_Edit"
                                        Visible='<%# rdg.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCustomTableSave" runat="server" CausesValidation="True" ValidationGroup="DSave" CommandName="PerformInsert"
                                        SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                        Visible='<%# rdg.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                                        SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                        Visible='<%# rdg.EditIndexes.Count > 0 Or rdg.MasterTableView.IsItemInserted %>'
                                        meta:resourcekey="btnCancelResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        SecurityButtonType="ItemMode_Add"
                                        Visible='<%# rdg.EditIndexes.Count = 0 And (Not rdg.MasterTableView.IsItemInserted) And Not PM.Application.ApplicationInfo.Submitted.HasValue %>'
                                        meta:resourcekey="btnAddResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                        SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                        Visible='<%# rdg.EditIndexes.Count = 0 And (Not rdg.MasterTableView.IsItemInserted) And Not PM.Application.ApplicationInfo.Submitted.HasValue %>'
                                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                        SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        Visible='<%# rdg.EditIndexes.Count = 0 And (Not rdg.MasterTableView.IsItemInserted) %>'
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
                </div>
            </fieldset>
        </div>
    </div>
</div>

