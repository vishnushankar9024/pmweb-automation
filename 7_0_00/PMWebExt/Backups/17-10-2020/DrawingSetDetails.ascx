<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DrawingSetDetails.ascx.vb"
    Inherits="Website.DrawingSetDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDrawingSets">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDrawingSets" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgDrawingSets" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext"
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="15"
                AllowPaging="True" ShowGroupPanel="true" AllowMultiRowEdit="False" AllowMultiRowSelection="true"
                AllowSorting="False" GridLines="None" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                    TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="List #" ItemStyle-HorizontalAlign="Right" UniqueName="ListNumber" DataField="ListNumber"
                            HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" GroupByExpression="ListNumber [GridColumn_ListNumber] Group By ListNumber">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliTransmittal" runat="server" CssClass="NoWrap,Link"
                                    Text='<%#IIf(Container.DataItem("ListNumber") = String.Empty, "&nbsp;", Container.DataItem("ListNumber"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("PostBackUrl"))%>'></asp:HyperLink>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblListNumber" Width="100%" runat="server" Text='<%# Eval("ListNumber") %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="55px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" DataField="LineNumber" AllowFiltering="false"
                            Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <%#Eval("LineNumber")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblLineNumber" Width="100%" runat="server" Text='<%# Eval("LineNumber") %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "("+Eval("AttachmentTotal").ToString()+")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Sheet" SortExpression="Sheet" GroupByExpression="Sheet [GridColumn_Sheet] Group By Sheet" DataField="Sheet"
                            UniqueName="Sheet">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Sheet") = String.Empty, "&nbsp;", Container.DataItem("Sheet"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSheet" runat="server" MaxLength="50" Text='<%# Eval("Sheet") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Rev." DataField="Revision" SortExpression="Revision" GroupByExpression="Revision [GridColumn_Revision] Group By Revision"
                            UniqueName="Revision">
                            <ItemTemplate>
                                <%#Eval("Revision")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRevision" runat="server" CssClass="PositiveInteger" MaxLength="9" Text='<%# Eval("Revision") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" SortExpression="ItemId"
                            HeaderStyle-Wrap="false" UniqueName="Item" DataField="ItemId" GroupByExpression="ItemId [GridColumn_Item] Group By ItemId">
                            <ItemTemplate>
                                <asp:Label ID="lblItemItemTemplate" runat="server" Text='<%#iif(Eval("ItemId")="0","&nbsp;",Eval("ItemId").toString)%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblItemEditItemTemplate" runat="server"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Date" SortExpression="DrawingDate" GroupByExpression="DrawingDate [GridColumn_DrawingDate] Group By DrawingDate"
                            UniqueName="DrawingDate" DataField="DrawingDate">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("DrawingDate")) %> &nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpDrawingDate" runat="server" EnableTyping="True" MaxDate="2100-01-01"
                                    MinDate="1901-01-01" Skin="Default" Width="100%">
                                    <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"
                                        Skin="Default">
                                    </DateInput>
                                    <Calendar ID="Calendar2" runat="server" Skin="Default">
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description" DataField="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="220px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CSI Division" SortExpression="CSIDivision" DataField="CSIDivision"
                            GroupByExpression="CSIDivision [GridColumn_CSIDivisionId] Group By CSIDivision" UniqueName="CSIDivisionId">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CSIDivision") = String.Empty, "&nbsp;", Container.DataItem("CSIDivision"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCSIDivision" runat="server" AllowCustomText="true" CloseDropDownOnBlur="true"
                                    DropDownWidth="300px" EmptyMessage="--Select--" EnableItemCaching="true" EnableLoadOnDemand="True"
                                    EnableVirtualScrolling="true" Filter="Contains" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    MarkFirstMatch="true" NoWrap="True" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="true"
                                    Skin="Default" Style="font-size: 11px" Width="100%">
                                    <CollapseAnimation Duration="150" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CSI Code" SortExpression="CSICode" DataField="CSICode"
                            GroupByExpression="CSICode [GridColumn_CSICodeId] Group By CSICode"
                            UniqueName="CSICodeId">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CSICode") = String.Empty, "&nbsp;", Container.DataItem("CSICode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCSICode" runat="server" AllowCustomText="true" CloseDropDownOnBlur="true"
                                    DropDownWidth="300px" EmptyMessage="--Select--" EnableItemCaching="true" EnableLoadOnDemand="True"
                                    EnableVirtualScrolling="true" Filter="Contains" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    MarkFirstMatch="true" NoWrap="True" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="true"
                                    Skin="Default" Style="font-size: 11px" Width="100%">
                                    <CollapseAnimation Duration="150" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" SortExpression="Category" DataField="Category"
                            GroupByExpression="Category [GridColumn_CategoryId] Group By Category"
                            UniqueName="CategoryId">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCategory" runat="server" AllowCustomText="True" AutoPostBack="False"
                                    CausesValidation="False" Filter="Contains" Height="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    MarkFirstMatch="True" NoWrap="True" Skin="Default" Width="100%">
                                    <CollapseAnimation Duration="150" Type="OutQuint" />
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Task11" UniqueName="TaskName" DataField="TaskName" SortExpression="TaskName"
                            GroupByExpression="TaskName [GridColumn_TaskName] Group By TaskName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Task..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ddlTasks_SelectedIndexChanged"
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
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Location11" GroupByExpression="ProjectLocation [GridColumn_ProjectLocation] Group By ProjectLocation ASC"
                            SortExpression="ProjectLocation" UniqueName="ProjectLocation" DataField="ProjectLocation" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProjectLocation") = String.Empty, "&nbsp;", Container.DataItem("ProjectLocation"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:radcombobox ID="ddlProjectLocations" runat="server"  AllowCustomText="true" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:radcombobox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status" DataField="Status"
                            GroupByExpression="Status [GridColumn_StatusId] Group By Status"
                            UniqueName="StatusId">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%--<asp:DropDownList ID="ddlStatus" runat="server" Width="100%"></asp:DropDownList>--%>
                                <telerik:RadComboBox ID="ddlStatus" runat="server" AllowCustomText="true" DropDownWidth="300px" Filter="Contains" MarkFirstMatch="true" Skin="Default" Style="font-size: 11px" Width="100%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="%" SortExpression="Percentage" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage"
                            UniqueName="Percentage" DataField="Percentage">
                            <ItemTemplate>
                                <%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Percentage")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Percentage")), "&nbsp;", FormatNumber(DataBinder.Eval(Container.DataItem, "Percentage")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPercentage" runat="server" CssClass="Double" MaxLength="1000" Text='<%# FormatNumber(Eval("Percentage")) %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes"
                            UniqueName="Notes" DataField="Notes">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Notes") is DBNull.Value,"&nbsp;", Container.DataItem("Notes") & "&nbsp;")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Height="24px" MaxLength="4000" Text='<%# Eval("Notes") %>' TextMode="MultiLine" Width="80%"></asp:TextBox>
                                <asp:LinkButton ID="imgNotes" runat="server"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                    CssClass="SearchButton">
                    <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgDrawingSets.EditIndexes.Count = 0 AND (Not rdgDrawingSets.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgDrawingSets.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgDrawingSets.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgDrawingSets.EditIndexes.Count > 0 Or rdgDrawingSets.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnInitNewRow" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgDrawingSets.EditIndexes.Count = 0 AND (Not rdgDrawingSets.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="NewRow" OnClientClick="return OpenPOPUp('drawingsPopup.aspx',940, 540,true);" CssClass="GridCmdLinkPMWebRecords"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgDrawingSets.EditIndexes.Count = 0 AND (Not rdgDrawingSets.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" meta:resourcekey="lblAddLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgDrawingSets.EditIndexes.Count = 0 And (Not rdgDrawingSets.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                Visible='<%# rdgDrawingSets.EditIndexes.Count = 0 And (Not rdgDrawingSets.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnGenerateSubmittal" runat="server" CssClass="GridCmdGenerateSubmittal"
                                CausesValidation="False" CommandName="GenerateSubmittal"
                                Visible='<%# rdgDrawingSets.EditIndexes.Count = 0 And (Not rdgDrawingSets.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblGenerateSubmittal" meta:resourcekey="lblGenerateSubmittal" runat="server" Text="Generate Transmittal"></asp:Label>
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
                <ClientSettings EnableRowHoverStyle="true" AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true" AllowRowsDragDrop="False">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
