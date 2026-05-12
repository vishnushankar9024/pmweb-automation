<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ClauseDetails.ascx.vb" Inherits="Website.ClauseDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgClauseDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgClauseDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgClauseDetails" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                ShowGroupPanel="True" AllowMultiRowEdit="True" PageSize="20" AllowPaging="true" AllowMultiRowSelection="True" AllowSorting="True" ItemStyle-Height="20px" GridLines="None" UseEditFormInMobile="true">

                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                    EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Line #" ItemStyle-Wrap="false" UniqueName="LineNumber" DataField="LineNumber" AllowFiltering="false"
                            SortExpression="LineNumber" Groupable="false">
                            <ItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="70px" />
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
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="75px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Paragraph" ItemStyle-Wrap="false" UniqueName="Paragraph" DataField="Paragraph"
                            SortExpression="Paragraph" GroupByExpression="Paragraph [GridColumn_Paragraph] Group By Paragraph ASC">
                            <ItemTemplate>
                                <span><%#Eval("Paragraph").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtParagraph" MaxLength="500" runat="server" Text='<%# Eval("Paragraph") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Category" UniqueName="Category" DataField="Category"
                            SortExpression="Category" GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                            <ItemTemplate>
                                <span><%#Eval("Category").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                    Style="font-size: 11px" Width="100%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                            SortExpression="Type" GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                            <ItemTemplate>
                                <span><%#Eval("Type").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlType" AllowCustomText="true" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                    Style="font-size: 11px" Width="100%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                                <span><%#Eval("Description").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>' Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Text" ItemStyle-Wrap="false" UniqueName="Text" DataField="Text"
                            SortExpression="Text" GroupByExpression="Text [GridColumn_Text] Group By Text ASC">
                            <ItemTemplate>
                                <span><%#Eval("Text").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtText" runat="server" Text='<%#Eval("Text")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgText" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgText','txtText'))">
    					                    <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Responsible" UniqueName="Responsible" DataField="Responsible"
                            SortExpression="Responsible" GroupByExpression="Responsible [GridColumn_Responsible] Group By Responsible ASC">
                            <ItemTemplate>
                                <span><%#Eval("Responsible").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlResponsible" AllowCustomText="true" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                    Style="font-size: 11px" Width="100%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Start" UniqueName="Start" DataField="Start"
                            SortExpression="Start" GroupByExpression="Start [GridColumn_Start] Group By Start ASC">
                            <ItemTemplate>
                                <span><%#FormatDate(Eval("Start"))%></span>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpStart" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>

                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="End" UniqueName="End" DataField="End"
                            SortExpression="End" GroupByExpression="End [GridColumn_End] Group By End ASC">
                            <ItemTemplate>
                                <span><%#FormatDate(Eval("End"))%></span>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpEnd" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                            SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <span><%#Eval("Notes").ToString%></span>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					                        <span class="Icon"></span>
                                </asp:LinkButton>

                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" DataField="Inactive"
                            SortExpression="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("Inactive") is system.DBNULL.value, 0,Eval("Inactive")))%>' runat="server" class="mobile-switch" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle Width="70px" />
                        </telerik:GridTemplateColumn>

                    </Columns>

                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgClauseDetails.EditIndexes.Count = 0 AND (Not rdgClauseDetails.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                Visible='<%# rdgClauseDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                Visible='<%# rdgClauseDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdgClauseDetails.EditIndexes.Count > 0 Or rdgClauseDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                Visible='<%# rdgClauseDetails.EditIndexes.Count = 0 AND (Not rdgClauseDetails.MasterTableView.IsItemInserted) %>' meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgClauseDetails.EditIndexes.Count = 0 And (Not rdgClauseDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                Visible='<%# rdgClauseDetails.EditIndexes.Count = 0 And (Not rdgClauseDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <telerik:RadComboBox ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDisplay_OnSelectedIndexChanged" Visible='<%# rdgClauseDetails.EditIndexes.Count = 0 AND (Not rdgClauseDetails.MasterTableView.IsItemInserted) %>'>
                                <Items>
                                <telerik:RadComboBoxItem meta:Resourcekey="ListItemAll" Value="0" Text="-- All --" Selected="True"></telerik:RadComboBoxItem>
                                <telerik:RadComboBoxItem meta:Resourcekey="ListItemActiveOnly" Value="1" Text="Active Only"></telerik:RadComboBoxItem>
                                <telerik:RadComboBoxItem meta:Resourcekey="ListItemInactiveOnly" Value="2" Text="Inactive Only"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
        </div>
    </div>
</div>
