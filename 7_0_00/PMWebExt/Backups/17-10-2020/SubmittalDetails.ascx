<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SubmittalDetails.ascx.vb" Inherits="Website.SubmittalDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadCodeBlock runat="server" ID="script1">
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSubmittals">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSubmittals" LoadingPanelID="ldpPM" />
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
            <telerik:RadGrid ID="rdgSubmittals" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="15"
                AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                AllowSorting="True" GridLines="None" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                    TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="CSI Code" SortExpression="CSICode" GroupByExpression="CSICode [GridColumn_CSICode] Group By CSICode" AllowFiltering="false"
                            UniqueName="CSICode">
                            <ItemTemplate>
                                <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "CSICode")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "CSICode")), "&nbsp;", DataBinder.Eval(Container.DataItem, "CSICode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCSICode" runat="server" Filter="Contains" MarkFirstMatch="True"
                                    Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                                    CausesValidation="False" Height="200px" DropDownWidth="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    CloseDropDownOnBlur="true" EnableItemCaching="false"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                                <%--   <asp:TextBox ID="txtCSICode" runat="server" Width="100%" Text='<%# Eval("CSICodeId") %>' MaxLength="100"></asp:TextBox>--%>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Sub #" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-Wrap="false" SortExpression="DocNumber" DataField="DocNumber"
                            UniqueName="SubNumber" GroupByExpression="DocNumber [GridColumn_SubNumber] Group By DocNumber">
                            <ItemTemplate>
                                <span><%#DataBinder.Eval(Container.DataItem, "DocNumber")%> &nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDocNumber" runat="server" Width="100%" Text='<%# Eval("DocNumber") %>' MaxLength="100"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" SortExpression="ItemId"
                            HeaderStyle-Wrap="false" UniqueName="Item" DataField="ItemId" GroupByExpression="ItemId [GridColumn_Item] Group By ItemId">
                            <ItemTemplate>
                                <asp:Label ID="lblItemItemTemplate" runat="server" Text='<%#IIf(Eval("ItemId") = "0", "&nbsp;", Eval("ItemId").ToString)%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblItemEditItemTemplate" runat="server"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" DataField="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description">
                            <ItemTemplate>
                                <span>
                                    <%#Eval("Description")%>
                        &nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" Width="100%" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mfr." SortExpression="ManufacturerId" DataField="Manufacturer" GroupByExpression="Manufacturer [GridColumn_ManufacturerId] Group By Manufacturer"
                            UniqueName="ManufacturerId">
                            <ItemTemplate>
                                <span>
                                    <%#Eval("Manufacturer")%>
                        &nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="100%" DropDownWidth="405px"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mfr. #" SortExpression="ManufacturerNumber" DataField="ManufacturerNumber"
                            GroupByExpression="ManufacturerNumber [GridColumn_ManufacturerNumber] Group By ManufacturerNumber" UniqueName="ManufacturerNumber">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ManufacturerNumber") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerNumber"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtManufacturerNumber" Width="100%" MaxLength="50" runat="server"
                                    Text='<%# Eval("ManufacturerNumber") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Supplier" DataField="Supplier" GroupByExpression="Supplier [GridColumn_SupplierId] Group By Supplier"
                            UniqueName="SupplierId">
                            <ItemTemplate>
                                <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Supplier")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Supplier")), "&nbsp;", DataBinder.Eval(Container.DataItem, "Supplier"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlSupplier" runat="server" Width="100%" DropDownWidth="405px"
                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" 
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Rev." SortExpression="Revision" GroupByExpression="Revision [GridColumn_Revision] Group By Revision" DataField="Revision"
                            UniqueName="Revision">
                            <ItemTemplate>
                                <span><%#Eval("Revision")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRevision" MaxLength="9" CssClass="PositiveInteger" Width="100%" runat="server"
                                    Text='<%# Eval("Revision") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status" DataField="Status" GroupByExpression="Status [GridColumn_StatusId] Group By Status"
                            UniqueName="StatusId">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlStatus" Filter="Contains" Width="100%" runat="server" AllowCustomText="true" >
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Task" SortExpression="Task" GroupByExpression="Task [GridColumn_Task] Group By Task" DataField="Task"
                            UniqueName="Task">
                            <ItemTemplate>
                                <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Task")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Task")), "&nbsp;", DataBinder.Eval(Container.DataItem, "Task"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" 
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['EarlyStartDate']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['EarlyFinishDate']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="250px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes" DataField="Notes"
                            UniqueName="Notes">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'></asp:TextBox>
                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                               <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgSubmittals.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgSubmittals.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgSubmittals.EditIndexes.Count > 0 Or rdgSubmittals.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                               <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False"
                                Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('Document_ItemsSelect.aspx?Type=1',900,600,true)">
                                <span class="Icon"></span>
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgSubmittals.EditIndexes.Count = 0 And (Not rdgSubmittals.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
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
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true"
                    ColumnsReorderMethod="Reorder" AllowDragToGroup="true" AllowRowsDragDrop="false">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>


