<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TransmittlesItems.ascx.vb" Inherits="Website.TransmittlesItems" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgtransmittlItems">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgtransmittlItems" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgRemarks">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRemarks" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshLinkRecords">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgtransmittlItems" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<asp:Button ID="btnRefreshLinkRecords" runat="server" CssClass="Hide" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
                        <telerik:RadGrid ID="rdgtransmittlItems" runat="server" AllowFilteringByColumn="true" Width="100%" SetWidth="true"
                            AutoGenerateColumns="False" ShowStatusBar="false" Font-Size="8px" PageSize="10" UseEditFormInMobile="true"
                            AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true" ClientSettings-Scrolling-AllowScroll="true"
                            FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                            AllowSorting="True" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                                EnableHeaderContextMenu="true" TableLayout="Fixed">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="" Groupable="false" AllowFiltering="false" UniqueName="Imported">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="imgLink" Style="cursor: pointer" runat="server">
                                                   <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            &nbsp;
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        <HeaderStyle Width="50px" ForeColor="#d0e0f2" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="100px" UniqueName="LineNumber" AllowFiltering="false"
                                        HeaderStyle-Wrap="false" Groupable="false" Reorderable="true">
                                        <ItemTemplate>
                                            <%#Container.DataItem("LineNumber").ToString%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("LineNumber").ToString%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal" AllowFiltering="true" Groupable="false"
                                        UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Set #" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" DataField="SetNumber"
                                        HeaderStyle-Wrap="false" Groupable="false" UniqueName="SetNumber">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSetNumber" runat="server" Text='<%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "SetNumber")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "SetNumber")) OrElse DataBinder.Eval(Container.DataItem, "SetNumber") = "0", "&nbsp;", DataBinder.Eval(Container.DataItem, "SetNumber"))%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lblSetNumberEdit" runat="server" Text='<%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "SetNumber")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "SetNumber")) OrElse DataBinder.Eval(Container.DataItem, "SetNumber") = "0", "&nbsp;", DataBinder.Eval(Container.DataItem, "SetNumber"))%>'></asp:Label>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" DataField="Description"
                                        UniqueName="Description" Groupable="false">
                                        <ItemTemplate>
                                            <span>
                                                <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                            </span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDescription" Width="100%" MaxLength="1000" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="250px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status" UniqueName="StatusId" DataField="Status"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text="&nbsp;"></asp:Label>
                                            &nbsp;
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%--        <asp:DropDownList ID="ddlStatus" runat="server" Width="100%">
                                                </asp:DropDownList>--%>
                                            <telerik:RadComboBox ID="ddlStatus" runat="server" AllowCustomText="true" Height="200px" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Rev." SortExpression="Rvision" UniqueName="Revision" DataField="Rvision"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Rvision") = String.Empty, "&nbsp;", Container.DataItem("Rvision"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtRevision" MaxLength="13" Width="100%"
                                                runat="server" Text='<%# Eval("Rvision") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Date" SortExpression="Date" UniqueName="Date" DataField="Date"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStart" Text='<%#IIF(Eval("Date") is dbnull.value,"&nbsp;",Formatdate(Eval("Date"))) %>'
                                                runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDate" onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);"
                                                onblur="parseDate(this, event);" runat="server" Width="100%"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type" UniqueName="Type" DataField="Type"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:radcombobox ID="ddlType" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                            </telerik:radcombobox>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" SortExpression="Quantity" DataField="Quantity"
                                        Groupable="false">
                                        <ItemTemplate>
                                            <%#FormatNumber(Container.DataItem("Quantity"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="PositiveInteger"
                                                MaxLength="9" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "0", Eval("Quantity"))) %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Source ID" UniqueName="SourceId" DataField="SourceId"
                                        HeaderStyle-Wrap="false" Groupable="false">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("SourceId") = 0, "&nbsp;", Container.DataItem("SourceId").ToString)%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("SourceId").ToString%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Source Line #" UniqueName="SourceLineNumber" DataField="SourceLineNumber"
                                        HeaderStyle-Wrap="True" Groupable="false">
                                        <ItemTemplate>
                                            <%#IIf(Container.DataItem("SourceLineNumber") = String.Empty, "&nbsp;", Container.DataItem("SourceLineNumber").ToString)%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#IIf(IsDBNull(DataBinder.Eval(Container.DataItem, "SourceLineNumber")) OrElse String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem, "SourceLineNumber")), "&nbsp;", DataBinder.Eval(Container.DataItem, "SourceLineNumber"))%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="True" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1" Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                                        Groupable="false" AllowFiltering="false">
                                        <ItemTemplate>
                                            <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
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
                                            SecurityButtonType="ItemMode_Edit" Visible='<%# rdgtransmittlItems.EditIndexes.Count = 0 AND (Not rdgtransmittlItems.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                            SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgtransmittlItems.EditIndexes.Count > 0 %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                            SecurityButtonType="AddEditMode_Add" Visible='<%# rdgtransmittlItems.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                            SecurityButtonType="AddEditMode" Visible='<%# rdgtransmittlItems.EditIndexes.Count > 0 Or rdgtransmittlItems.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                            SecurityButtonType="ItemMode_Add" Visible='<%# rdgtransmittlItems.EditIndexes.Count = 0 AND (Not rdgtransmittlItems.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAddLink" CommandName="AddLink" CssClass="GridCmdAddLink" runat="server" CausesValidation="False"
                                            SecurityButtonType="ItemMode_Add" OnClientClick="return OpenLinkRecordsPopup();"
                                            Visible='<%# rdgtransmittlItems.EditIndexes.Count = 0 AND (Not rdgtransmittlItems.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                            SecurityButtonType="ItemMode_Delete" Visible='<%# rdgtransmittlItems.EditIndexes.Count = 0 And (Not rdgtransmittlItems.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                            <span class="Icon"></span>
                                            <asp:Label ID="Label2" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                            SecurityButtonType="ItemMode" Visible='<%# rdgtransmittlItems.EditIndexes.Count = 0 And (Not rdgtransmittlItems.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                                AllowDragToGroup="false" AllowRowsDragDrop="false">
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True"></Resizing>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                        </telerik:RadGrid>
                        <br />
        </div>
    </div>
</div>
