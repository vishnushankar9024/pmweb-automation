<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InspectionDetails.ascx.vb" Inherits="Website.InspectionDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:radajaxmanagerproxy id="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInspectionDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInspectionDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:radajaxmanagerproxy>

<telerik:radcodeblock id="CodeBlock1" runat="server">
    <style>
        .Description input {
            width: 90%;
        }
    </style>
</telerik:radcodeblock>
<telerik:raddatepicker id="RadDatePicker1" style="display: none;" mindate="01/01/1901"
    maxdate="12/31/2100" runat="server" skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:raddatepicker>
<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
        <telerik:radgrid id="rdgInspectionDetails" runat="server"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
                PageSize="10" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True"  HasPasteFromExcel="true" Width="100%"  setwidth="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true">

                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="InspectionDetailId" CommandItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true"
                    EnableHeaderContextMenu="true" EditMode="InPlace">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderStyle-Width="60px"  AllowFiltering="false" DataField="RowNumber"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True">
                            <ItemTemplate>
                                <%#Container.DataItem("RowNumber").ToString%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("RowNumber").ToString%></span>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn  SortExpression="AttachmentTotal"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="true"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Asset"
                            GroupByExpression="Asset [GridColumn_Asset] Group By Asset">
                            <ItemTemplate>
                                <span><%#Container.DataItem("Asset")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                               <telerik:RadComboBox ID="ddlAsset" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                    NoWrap="True" AllowCustomText="true" AutoPostback="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox> 
                            </EditItemTemplate>
                            
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn SortExpression="AssetType" DataField="AssetType" AllowFiltering="true"
                             GroupByExpression="AssetType [GridColumn_AssetType] Group By AssetType ASC">
                            <ItemTemplate>
                                <span><%#Container.DataItem("AssetType")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
        <telerik:RadComboBox ID="ddlAssetType" runat="server" Width="100%" OnSelectedIndexChanged="ddlAssetType_SelectedIndexChanged"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                    NoWrap="True" AllowCustomText="true" AutoPostBack="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox> 
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                 
                        <telerik:GridTemplateColumn SortExpression="Condition" DataField="Condition"
                            GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <%# Container.DataItem("Condition")%>
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

                      <%--  <telerik:GridTemplateColumn HeaderText="Material" SortExpression="Material" UniqueName="Material" DataField="Material"
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
                        </telerik:GridTemplateColumn>--%>

                       <%-- <telerik:GridTemplateColumn HeaderText="Recommend" SortExpression="Recommend" UniqueName="Recommend" DataField="Recommend"
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
                        </telerik:GridTemplateColumn>--%>

                      <%--  <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="Priority" UniqueName="Priority" DataField="Priority"
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
                        </telerik:GridTemplateColumn>--%>


                   <%--     <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" DataField="Notes"
                            SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>'
                                    Width="80%"></asp:TextBox>
                                  <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                            CssClass="SearchButton">
                                               <span class="Icon"></span>
                        </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>--%>



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
                            <%--<asp:LinkButton ID="hplAddItems" runat="server" CausesValidation="false" CommandName="AddItems" CssClass="GridCmdAddItems"
                                OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Inspections', 910, 600, true);"
                                SecurityButtonType="ItemMode_Add" Visible="<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                            </asp:LinkButton>--%>
                            <asp:LinkButton ID="btnlinkAsset" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdlinkAsset" CommandName="InspectionlinkAsset" OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=6',1035, 710,true);"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblAddAsset" Text="link Assets" meta:resourceKey="lblAddAsset"></asp:Label>
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
                             <asp:LinkButton ID="btnExportExcel" CommandName="CopyToExcel" CssClass="GridCmdCopyToExcel" runat="server" CausesValidation="False"
                                 Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label ID="lblCopyToExcel" meta:resourcekey="lblCopyToExcel" runat="server" Text="Copy To Excel"></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                </asp:LinkButton>
                             <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                        SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard"
                                 Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblPasteLines" runat="server" Text ="Past From Excel"></asp:Label>
                                        &nbsp;&nbsp;&nbsp;
                                    </asp:LinkButton>
                            <asp:LinkButton ID="btnCreateWorkOrder" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdCreateWorkOrder" CommandName="CreateWorkOrder" OnClientClick="return OpenGenerateWorkOrderPopup('GenerateWorkOrderPopup.aspx',450, 300);"
                                Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblCreateWorkOrder" Text="Create Work Order"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton  ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid Hide"
                                SecurityButtonType="ItemMode" Visible='<%# rdgInspectionDetails.EditIndexes.Count = 0 And (Not rdgInspectionDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1" CssClass="Hide"></asp:Label>
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
                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="false" AllowDragToGroup="true" AllowRowsDragDrop="true" ReorderColumnsOnClient="false">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:radgrid>
        </div>
    </div>
</div>



<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
<asp:Button ID="btnGenerateWorkOrder" runat="server" CssClass="Hide" />