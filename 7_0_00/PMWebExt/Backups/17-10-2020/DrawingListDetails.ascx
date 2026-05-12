<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DrawingListDetails.ascx.vb"
    Inherits="Website.DrawingListDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
</telerik:RadCodeBlock>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDrawingLists">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDrawingLists" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="dtpDocumentDate" UpdatePanelRenderMode="Inline" />
                <telerik:AjaxUpdatedControl ControlID="txtRevision" UpdatePanelRenderMode="Inline" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />


            <telerik:RadGrid ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-EnableVirtualScrollPaging="true" ID="rdgDrawingLists" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="15" Width="100%"
                AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                AllowSorting="True" GridLines="None" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                    TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false"
                            Groupable="false" Reorderable="true" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <%#Eval("LineNumber")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblLineNumber" Width="100%" runat="server" Text='<%# Eval("LineNumber") %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="45px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
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
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Sheet" SortExpression="Sheet" DataField="Sheet" GroupByExpression="Sheet [GridColumn_Sheet] Group By Sheet"
                            UniqueName="Sheet">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Sheet") = String.Empty, "&nbsp;", Container.DataItem("Sheet"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSheet" Width="100%" runat="server" MaxLength="50" Text='<%# Eval("Sheet") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="45px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Rev." SortExpression="Revision" GroupByExpression="Revision [GridColumn_Revision] Group By Revision"
                            UniqueName="Revision" DataField="Revision">
                            <ItemTemplate>
                                <%#Eval("Revision")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRevision" MaxLength="9" CssClass="PositiveInteger" Width="100%" runat="server"
                                    Text='<%# Eval("Revision") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Date" SortExpression="DrawingDate" DataField="DrawingDate" GroupByExpression="DrawingDate [GridColumn_DrawingDate] Group By DrawingDate"
                            UniqueName="DrawingDate">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("DrawingDate")) %> &nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpDrawingDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default" EnableTyping="True">
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                        runat="server">
                                    </DateInput>
                                    <Calendar ID="Calendar2" Skin="Default" runat="server">
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="90px"></HeaderStyle>
                            <%--    <ItemStyle HorizontalAlign="Left"></ItemStyle>--%>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
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
                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description" DataField="Description">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" Width="100%" MaxLength="1000" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CSI Division" SortExpression="CSIDivision" DataField="CSIDivision"
                            GroupByExpression="CSIDivision [GridColumn_CSIDivisionId] Group By CSIDivision" UniqueName="CSIDivisionId">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("CSIDivision") = String.Empty, "&nbsp;", Container.DataItem("CSIDivision"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCSIDivision" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="--Select--"
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CSI Code" SortExpression="CSICode" DataField="CSICode"
                            GroupByExpression="CSICode [GridColumn_CSICodeId] Group By CSICode"
                            UniqueName="CSICodeId">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("CSICode") = String.Empty, "&nbsp;", Container.DataItem("CSICode"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCSICode" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="--Select--"
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" SortExpression="Category" DataField="Category"
                            GroupByExpression="Category [GridColumn_CategoryId] Group By Category"
                            UniqueName="CategoryId">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Category") = String.Empty, "&nbsp;", Container.DataItem("Category"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains" MarkFirstMatch="True"
                                    Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                                    CausesValidation="False" Height="200px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
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
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Task..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="Details_ddlTasks_SelectedIndexChanged"
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
                                <telerik:RadComboBox AllowCustomText="true" ID="ddlProjectLocations" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status" GroupByExpression="Status [GridColumn_Status] Group By Status"
                            UniqueName="Status" DataField="Status">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlStatus" runat="server" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="%" SortExpression="Percentage" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage"
                            UniqueName="Percentage" DataField="Percentage">
                            <ItemTemplate>
                                <span><%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "Percentage")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "Percentage")), "&nbsp;", FormatNumber(DataBinder.Eval(Container.DataItem, "Percentage")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%--<telerik:RadNumericTextBox ID="txtPercentage" MaxValue="100"  MinValue="0" ShowButton="false"
                        ShowSpinButtons="false" Width="100%" runat="server">
                    </telerik:RadNumericTextBox>--%>
                                <asp:TextBox ID="txtPercentage" MaxLength="1000" CssClass="Double" Width="100%" runat="server" Text='<%# FormatNumber(Eval("Percentage")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="40px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes"
                            UniqueName="Notes" DataField="Notes">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Notes") Is DBNull.Value, "&nbsp;", Container.DataItem("Notes") & "&nbsp;")%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>'></asp:TextBox>
                                <asp:LinkButton runat="server" ID="imgNotes"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" CssClass="SearchButton">
                       <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Set #" SortExpression="DocNumber" GroupByExpression="DocNumber [GridColumn_DocNumber] Group By DocNumber"
                            UniqueName="DocNumber" DataField="DocNumber">
                            <ItemTemplate>
                                <%#Eval("DocNumber")%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblDocNumber" Width="100%" runat="server" Text='<%# Eval("DocNumber") %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="45px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CE #" DataField="CENumber" Visible="false" SortExpression="CENumber" GroupByExpression="CENumber [GridColumn_CENumber] Group By CENumber"
                            UniqueName="CENumber">
                            <ItemTemplate>
                                <%#Eval("CENumber")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCENumber" Width="100%" runat="server" Text='<%# Eval("CENumber") %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="45px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" DataField="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" DataField="Field2" DataType="System.String" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" DataField="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" DataField="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" DataField="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" DataField="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" DataField="Field7" UniqueName="Field7" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" DataField="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" DataField="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9" AllowFiltering="false"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" DataField="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10" AllowFiltering="false"
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
                    <EditFormSettings>
                        <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                            CancelImageUrl="Cancel.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgDrawingLists.EditIndexes.Count = 0 And (Not rdgDrawingLists.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgDrawingLists.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgDrawingLists.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgDrawingLists.EditIndexes.Count > 0 Or rdgDrawingLists.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgDrawingLists.EditIndexes.Count = 0 And (Not rdgDrawingLists.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems"
                                Visible='<%# rdgDrawingLists.EditIndexes.Count = 0 And (Not rdgDrawingLists.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('Document_ItemsSelect.aspx?Type=2',900,600,true)">
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgDrawingLists.EditIndexes.Count = 0 And (Not rdgDrawingLists.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows">
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
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgDrawingLists.EditIndexes.Count = 0 And (Not rdgDrawingLists.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label12" Text="Export To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <%--  <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                    SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard"
                    Visible='<%# rdgDrawingLists.EditIndexes.Count = 0 AND (Not rdgDrawingLists.MasterTableView.IsItemInserted) %>'>
                    <img style="border: 0px; vertical-align: middle;" src="Images/ToolBar/Paste.gif" />
                    <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                </asp:LinkButton>
                &nbsp;&nbsp;&nbsp;--%>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                    AllowDragToGroup="true">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                </ClientSettings>
            </telerik:RadGrid>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>
