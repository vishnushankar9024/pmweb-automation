<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InspectionDetails.ascx.vb" Inherits="Website.InspectionDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInspectionDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInspectionDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadCodeBlock ID="CodeBlock1" runat="server">
    <style>
        .Description input {
            width: 90%;
        }
    </style>
</telerik:RadCodeBlock>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgInspectionDetails" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" AppendMenus="true"
                EnableHeaderContextFilterMenu="true" AllowMultiRowEdit="true" AutoGenerateColumns="false" ShowStatusBar="False" ClientSettings-Scrolling-AllowScroll="true"
                UseEditFormInMobile="true" AllowMultiRowSelection="true" FilterMenu-EnableViewState="false" Width="100%"
                MasterTableView-EnableColumnsViewState="false" EnableViewState="true" Font-Size="8px" PageSize="15" ShowFooter="true" AllowPaging="True" SetWidth="true"
                ShowGroupPanel="True" AllowSorting="false" GridLines="None" GroupPanel-EnableViewState="false" MasterTableView-AllowSorting="false">

                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="InspectionDetailId" CommandItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true"
                    EnableHeaderContextMenu="true" EditMode="InPlace">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="60px" UniqueName="LineNumber" AllowFiltering="false"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True">
                            <ItemTemplate>
                                <%#Container.DataItem("RowNumber").ToString%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("RowNumber").ToString%></span>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Asset" AllowFiltering="true" UniqueName="Asset"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Asset"
                            GroupByExpression="Asset [GridColumn_Asset] Group By Asset">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliAsset" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#IIf(Eval("Asset") Is DBNull.Value OrElse String.IsNullOrEmpty(Eval("Asset")), "", Eval("Asset"))%>' NavigateUrl='<%#IIf(Eval("AssetPostbackURL") Is DBNull.Value, "", Eval("AssetPostbackURL"))%>'></asp:HyperLink>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HyperLink ID="hliAssetEdit" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#IIf(Eval("Asset") Is DBNull.Value OrElse String.IsNullOrEmpty(Eval("Asset")), "", Eval("Asset"))%>' NavigateUrl='<%#IIf(Eval("AssetPostbackURL") Is DBNull.Value, "", Eval("AssetPostbackURL"))%>'></asp:HyperLink>
                                <asp:HiddenField ID="hdnAssetId" Value='<%#IIf(Eval("AssetId") Is DBNull.Value, 0, Eval("AssetId"))%>' runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Asset Type" SortExpression="AssetType" DataField="AssetType" AllowFiltering="true"
                            UniqueName="AssetType" GroupByExpression="AssetType [GridColumn_AssetType] Group By AssetType ASC">
                            <ItemTemplate>
                                <span><%#Container.DataItem("AssetType")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblAssetType" runat="server" Text='<%#IIf(Eval("AssetType") Is DBNull.Value OrElse String.IsNullOrEmpty(Eval("AssetType")), "", Eval("AssetType"))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description"
                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'
                                    Width="200px"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Condition" SortExpression="Condition" UniqueName="Condition" DataField="Condition"
                            GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Condition") = "", "&nbsp;", Container.DataItem("Condition"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCondition" runat="server" Width="100%" meta:resourcekey="ddlCondition"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Condition..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Material" SortExpression="Material" UniqueName="Material" DataField="Material"
                            GroupByExpression="Material [GridColumn_Material] Group By Material ASC" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Material") = "", "&nbsp;", Container.DataItem("Material"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlMaterial" runat="server" Width="100%" meta:resourcekey="ddlMaterial"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Material..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Recommend" SortExpression="Recommend" UniqueName="Recommend" DataField="Recommend"
                            GroupByExpression="Recommend [GridColumn_Recommend] Group By Recommend ASC" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Recommend") = "", "&nbsp;", Container.DataItem("Recommend"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlRecommend" runat="server" Width="100%" meta:resourcekey="ddlRecommend"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Recommend..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="Priority" UniqueName="Priority" DataField="Priority"
                            GroupByExpression="Priority [GridColumn_Priority] Group By Priority ASC" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Priority") = "", "&nbsp;", Container.DataItem("Priority"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPriority" runat="server" Width="100%" meta:resourcekey="ddlPriority"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Priority..."
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" DataField="Notes"
                            SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>'
                                    Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>



                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Edit"
                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Edit"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgInspectionDetails.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save"
                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgInspectionDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1" SecurityButtonType="AddEditMode_Add">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count > 0 Or rdgInspectionDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add Line"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="hplAddItems" runat="server" CausesValidation="false" CommandName="AddItems" CssClass="GridCmdAddItems"
                                OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Inspections', 910, 600, true);"
                                SecurityButtonType="ItemMode_Add" Visible="<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnlinkAsset" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdlinkAsset" CommandName="linkAsset" OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=6',1035, 710,true,'rdgInspectionDetails');"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1"
                                SecurityButtonType="ItemMode_Delete">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCreateWorkOrder" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdCreateWorkOrder" CommandName="CreateWorkOrder" OnClientClick="return OpenGenerateWorkOrderPopup('GenerateWorkOrderPopup.aspx',450, 250);"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblCreateWorkOrder" Text="Create Work Order"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <%-- <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                    CommandName="SaveState">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </asp:LinkButton>
                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                    CausesValidation="False" CommandName="LoadDefaultState">
                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                </asp:LinkButton>--%>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="false" AllowDragToGroup="true" AllowRowsDragDrop="false" ReorderColumnsOnClient="false">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>



<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
<asp:Button ID="btnGenerateWorkOrder" runat="server" CssClass="Hide" />