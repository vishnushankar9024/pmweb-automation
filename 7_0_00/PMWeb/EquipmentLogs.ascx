<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EquipmentLogs.ascx.vb" Inherits="Website.EquipmentLogs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="Ram" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgEquLogs">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquLogs" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblPredictiveMaintenance" />
                <telerik:AjaxUpdatedControl ControlID="hdnCurrentUsage" />
                <telerik:AjaxUpdatedControl ControlID="hdnLogUsage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
<telerik:RadGrid ID="rdgEquLogs" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
    FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
    ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true"
    AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" UseEditFormInMobile ="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace" EnableHeaderContextMenu="true">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" DataField="LineNumber"
                SortExpression="LineNumber" GroupByExpression="LineNumber [Line #] Group By LineNumber ASC"
                Groupable="false" Reorderable="true" AllowFiltering="false">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblLineNumber" Text='<%#Container.DataItem("LineNumber").ToString%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="lblLineNumber" Text='<%#Eval("LineNumber").ToString%>'></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Source" UniqueName="Source" SortExpression="Source" DataField="Source"
                GroupByExpression="Source [GridColumn_Source] Group By Source ASC">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Source") = String.Empty, "&nbsp;", Container.DataItem("Source"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox  ID="ddlType" runat="server" Width="100%">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Link" ItemStyle-Wrap="false" UniqueName="Link" DataField="Link"
                SortExpression="Link" GroupByExpression="Link [GridColumn_Link] Group By Link ASC">
                <ItemTemplate>
                    <asp:HyperLink ID="hliLinkedRecord" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                        Text='<%#Eval("Link")%>' NavigateUrl='<%#Eval("LinkedRecordPostbackURL").ToString%>'></asp:HyperLink>
                    <asp:Label runat="server" Text='<%#Eval("Link")%>' ID="lblLinkedRecord"></asp:Label>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HyperLink ID="hliLinkedRecordEdit" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                        Text='<%#Eval("Link")%>' NavigateUrl='<%#Eval("LinkedRecordPostbackURL").ToString%>'></asp:HyperLink>
                    <asp:Label runat="server" Text='<%#Eval("Link")%>' ID="lblLinkedRecordEdit"></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="60px" HorizontalAlign="Left" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Record #" HeaderStyle-Width="50px" HeaderStyle-Wrap="false" DataField="RecordNumber"
                Groupable="True" Reorderable="true" UniqueName="RecordNumber"
                GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                <ItemTemplate>
                    <%#Container.DataItem("RecordNumber")%>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtRecordNumber" runat="server" Width="100%"
                        MaxLength="100" Text='<%#Eval("RecordNumber")%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="left" UniqueName="Description"
                HeaderStyle-Width="190px" SortExpression="Description" DataField="Description"
                GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" MaxLength="4000" runat="server" Text='<%# Eval("Description") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date" DataField="Date"
                ItemStyle-HorizontalAlign="left" GroupByExpression="Date [GridColumn_Date] Group By Date ASC"
                SortExpression="Date" HeaderStyle-HorizontalAlign="left">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Container.DataItem("Date"))%>&nbsp;</span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDate" Width="100%" Text='<%#FormatDate(Eval("Date"))%>'
                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                        runat="server"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
                <%--          <ItemStyle HorizontalAlign="left"></ItemStyle>--%>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Time" UniqueName="Time" HeaderStyle-Width="90px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" SortExpression="Time" Groupable="false"
                AutoPostBackOnFilter="true" GroupByExpression="Time [GridColumn_Time] Group By Time ASC" DataField="Time" DataType="System.Date">
                <ItemTemplate>
                    <span>
                        <%# CultureFormatTime(Eval("Time"))%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadTimePicker ID="tpTime"
                        runat="server" Skin="Default" Width="100%">
                    </telerik:RadTimePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="90px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Fluid Type" UniqueName="FluidType" SortExpression="FluidType"
                GroupByExpression="Source [GridColumn_FluidType] Group By FluidType ASC" DataField="FluidType">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("FluidType") = String.Empty, "&nbsp;", Container.DataItem("FluidType"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlFluidType" runat="server" AllowCustomText="True" Filter="Contains" Width="100%">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC"
                DataField="UOM">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" AllowCustomText="True" Filter="Contains">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="80px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" DataField="Quantity">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                        MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Unit Cost" DataField="UnitCost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                SortExpression="UnitCost">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" HeaderText="Ext. Cost" ItemStyle-Wrap="false" UniqueName="ExtCost" DataField="ExtCost"
                SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <span><%# FormatCurrency(Eval("ExtCost"))%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"))%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Previous reading" UniqueName="PreviousReading"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="left" DataField="PreviousReading"
                SortExpression="PreviousReading" GroupByExpression="PreviousReading [GridColumn_PreviousReading] Group By PreviousReading ASC">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblPreviousReading" Text='<%#FormatNumber(Container.DataItem("PreviousReading"))%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="lblPreviousReading" Text='<%#FormatNumber(IIF(Eval("PreviousReading") is system.DBNULL.value, "0", Eval("PreviousReading"))) %>'></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Current reading" UniqueName="CurrentReading" DataField="CurrentReading"
                ItemStyle-HorizontalAlign="Right" GroupByExpression="CurrentReading [GridColumn_CurrentReading] Group By CurrentReading ASC"
                HeaderStyle-HorizontalAlign="left" SortExpression="CurrentReading">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblCurrentReading" Text='<%#FormatNumber(Container.DataItem("CurrentReading"))%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCurrentReading" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15" Text='<%#FormatNumber(IIF(Eval("CurrentReading") is system.DBNULL.value, "0", Eval("CurrentReading"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Usage" UniqueName="Usage" DataField="Usage"
                ItemStyle-HorizontalAlign="Right" GroupByExpression="Usage [GridColumn_Usage] Group By Usage ASC"
                HeaderStyle-HorizontalAlign="left" SortExpression="Usage">
                <ItemTemplate>
                    <asp:Label ID="lblUsage" runat="server" Width="100%" CssClass="Right"
                        Text='<%#FormatNumber(Container.DataItem("Usage"))%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblUsage" runat="server" Width="100%" CssClass="Right"
                        Text='<%#FormatNumber(IIF(Eval("Usage") is system.DBNULL.value, "0", Eval("Usage"))) %>'></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" DataField="Notes"
                UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>

                    <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                        OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                    </asp:LinkButton>

                </EditItemTemplate>
                <HeaderStyle Width="280px" HorizontalAlign="Left"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="right" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgEquLogs.EditIndexes.Count = 0 And (Not rdgEquLogs.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgEquLogs.EditIndexes.Count > 0 %>'
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgEquLogs.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode" Visible='<%# rdgEquLogs.EditIndexes.Count > 0 Or rdgEquLogs.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgEquLogs.EditIndexes.Count = 0 And (Not rdgEquLogs.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgEquLogs.EditIndexes.Count = 0 And (Not rdgEquLogs.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode" Visible='<%# rdgEquLogs.EditIndexes.Count = 0 And (Not rdgEquLogs.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                    EnableShadows="true" CausesValidation="false"
                    Visible="true">
                </telerik:RadMenu>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true" AllowRowsDragDrop="true">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
        <Selecting AllowRowSelect="true" />
    </ClientSettings>
</telerik:RadGrid>
            </div>
        </div>
    </div>