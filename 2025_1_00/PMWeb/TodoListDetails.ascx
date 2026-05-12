<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TodoListDetails.ascx.vb" Inherits="Website.TodoListDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy2" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgTodoListDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgTodoListDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgTodoListDetails" ShowGroupPanel="true" runat="server" HeaderStyle-Font-Size="8" ClientSettings-Scrolling-AllowScroll="true"
                CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true"
                EnableHeaderContextFilterMenu="true" Width="100%" AutoGenerateColumns="False" PageSize="250" AllowPaging="true" SetWidth="true"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="true" UseEditFormInMobile="true"  HasPasteFromExcel="true">

                <PagerStyle PagerTextFormat="" Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" EditMode="InPlace" Width="100%" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="75px" AllowFiltering="false"
                            SortExpression="LineNumber" UniqueName="LineNumber" Groupable="false">
                            <ItemTemplate>
                                <span>
                                    <%#Container.DataItem("LineNumber").ToString%>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <%#Eval("LineNumber").ToString%>  
                                </span>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal" AllowFiltering="True"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="200px" DataField="Description"
                            SortExpression="Description" UniqueName="Description" GroupByExpression="Description [Description] Group By Description ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" MaxLength="500" Width="100%" ID="txtDescription" Text='<%#Eval("Description") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assigned To" HeaderStyle-Width="220px" ItemStyle-HorizontalAlign="Right" DataField="AssignedTo"
                            HeaderStyle-Wrap="false" Groupable="True" GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC"
                            UniqueName="AssignedTo" SortExpression="AssignedTo">
                            <ItemTemplate>
                                <span><%#Container.DataItem("AssignedTo")%>&nbsp;</span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlAssignedTo" runat="server" Width="85%" DropDownWidth="405px"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                        OnClientDropDownClosed="dllcompClientClosed"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested"
                                        Style="font-size: 11px" Height="250px">
                                        <HeaderTemplate>
                                            <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                    <td style="width: 135px;">
                                                        <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                    </td>
                                                    <td style="width: 135px;">
                                                        <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:LinkButton runat="server" ID="imgfilter"
                                        OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlAssignedTo'),'Contacts')"
                                        CssClass="SearchButton">
                                               <span class="Icon"></span>
                                    </asp:LinkButton>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="170px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Due" ItemStyle-HorizontalAlign="Right" DataField="DueDate"
                            HeaderStyle-Width="100px" SortExpression="DueDate" UniqueName="DueDate" GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate ASC">
                            <ItemTemplate>
                                <%#FormatDate(Container.DataItem("DueDate"))%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDue" Width="100%" Text='<%#FormatDate(Eval("DueDate"))%>'
                                    onclick="showDatePopup(this, event,false);" onfocus="showDatePopup(this, event,false);" onblur="parseDate(this, event)"
                                    runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Completed" ItemStyle-HorizontalAlign="Right" DataField="CompletedDate"
                            HeaderStyle-Width="100px" SortExpression="CompletedDate" UniqueName="CompletedDate" GroupByExpression="CompletedDate [GridColumn_CompletedDate] Group By CompletedDate ASC">
                            <ItemTemplate>
                                <%#FormatDate(Container.DataItem("CompletedDate"))%>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCompleted" Width="100%" Text='<%#FormatDate(Eval("CompletedDate"))%>'
                                    onclick="showDatePopup(this, event,false);" onfocus="showDatePopup(this, event,false);" onblur="parseDate(this, event)"
                                    runat="server"></asp:TextBox>

                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="Notes" HeaderText="Notes" DataField="Notes" HeaderStyle-Width="200px" SortExpression="Notes" GroupByExpression="Notes [Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span>
                                    <%# IIF(Container.DataItem("Notes") = String.empty, "&nbsp;", Container.DataItem("Notes"))%>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" MaxLength="4000" Width="80%" TextMode="MultiLine" Height="24px" ID="txtNotes" Text='<%#Eval("Notes") %>'></asp:TextBox>
                                <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                    CssClass="SearchButton">
                                               <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Done" HeaderStyle-Width="55px" ItemStyle-Wrap="false" DataField="IsDone" DataType="System.Boolean"
                            SortExpression="IsDone" UniqueName="Done" GroupByExpression="IsDone [GridColumn_Done] Group By IsDone ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsDone"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsDone" Checked='<%# Cbool(IIF(Eval("IsDone") is system.DBNULL.value, 0,Eval("IsDone")))%>' runat="server" />
                            </EditItemTemplate>
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
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                CommandName="EditRows" Visible='<%# rdgTodoListDetails.EditIndexes.Count = 0 AND (Not rdgTodoListDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgTodoListDetails.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgTodoListDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode"
                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgTodoListDetails.EditIndexes.Count > 0 or (rdgTodoListDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgTodoListDetails.EditIndexes.Count = 0 AND (Not rdgTodoListDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgTodoListDetails.EditIndexes.Count = 0 And (Not rdgTodoListDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgTodoListDetails.EditIndexes.Count = 0 AND (Not rdgTodoListDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgTodoListDetails.EditIndexes.Count = 0 And (Not rdgTodoListDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Copy To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>


                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;&nbsp;
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
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="true">
                    <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                        AllowColumnResize="True"></Resizing>
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
            </telerik:RadGrid>
            <input type="button" id="btnClipborad" class="Hide" runat="server" />
            <input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>
<br />

