<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentNotes.ascx.vb"
    Inherits="Website.DocumentNotes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDocumentNotes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDocumentNotes" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="PreviewDiv" />
                <telerik:AjaxUpdatedControl ControlID="AddNoteDiv" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDocumentNotes" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshGrid" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>



<telerik:RadCodeBlock runat="server">
<style>
    @media screen and (max-height:515px) {
        .btnAddNote{
            margin-top: 6% !important;
        }
    }
    @media screen and (min-height:515px) and (max-height:715px) {
        .btnAddNote{
            margin-top: 15% !important;
        }
    }
    .btnAddNote{
        margin-top: 30%;
    }
</style>
</telerik:RadCodeBlock>
<div class="PMHeader">
    <div class="row">
        <div class="col-6">
            <telerik:RadGrid ID="rdgDocumentNotes" runat="server" CssClass="WithoutTopBorder ResponsiveMargin" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                HeaderStyle-Font-Size="8" AutoGenerateColumns="False" AllowSorting="true" ShowGroupPanel="True" SetWidth="true" AppendMenus="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                ShowStatusBar="True" GridLines="None">

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" ShowGroupFooter="true" GroupLoadMode="Client">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderStyle-HorizontalAlign="Left" DataField="IncludeInBid" ItemStyle-HorizontalAlign="Center" UniqueName="IncludeInBid" HeaderText="" Groupable="False" HeaderStyle-Width="10%">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkUserUnits_OnChekedChanged" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-HorizontalAlign="Center" UniqueName="LineNumber" Groupable="False" DataField="LineNumber" AllowFiltering="false"
                            HeaderStyle-Width="15%" SortExpression="LineNumber">
                            <ItemTemplate>
                                <%#Container.DataItem("LineNumber").ToString()%>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Right" Width="15%"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" UniqueName="Description" Groupable="true"
                            HeaderStyle-Width="25%" SortExpression="Subject" DataField="Subject" GroupByExpression="Subject [GridColumn_Description] Group By Subject ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Subject") = String.Empty, "&nbsp;", Container.DataItem("Subject"))%></span>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Width="25%"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedBy" DataField="CreatedByUser" Groupable="true"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="CreatedByUser" GroupByExpression="CreatedByUser [GridColumn_CreatedBy] Group By CreatedByUser ASC">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("CreatedByUser") = String.Empty, "&nbsp;", Container.DataItem("CreatedByUser"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCreatedBy" MaxLength="500" Enabled="false" Width="100%" runat="server" Text='<%# Eval("CreatedByUser")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Created Date" UniqueName="CreatedDate" DataField="CreateDate" Groupable="true"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="CreateDate" GroupByExpression="CreateDate [GridColumn_CreatedDate] Group By CreateDate ASC">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("CreateDate")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("CreateDate")))%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <%--   <telerik:RadDatePicker ID="dtpCreatedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Office2007" SelectedDate='<%# IIf(Eval("CreateDate") = String.Empty, Date.Today, Eval("CreateDate"))%>'
                                    Enabled="false">
                                </telerik:RadDatePicker>--%>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Edited By" UniqueName="EditedBy" DataField="LastUpdatedByUser" Groupable="true"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="LastUpdatedByUser" GroupByExpression="LastUpdatedByUser [GridColumn_EditedBy] Group By LastUpdatedByUser ASC">
                            <ItemTemplate>
                                <%# IIf(Container.DataItem("LastUpdatedByUser").ToString = String.Empty, "&nbsp;", Container.DataItem("LastUpdatedByUser").ToString)%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditedBy" MaxLength="500" Width="100%" runat="server" Enabled="false" Text='<%#Eval("LastUpdatedByUser")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Edited  Date" UniqueName="EditedDate" DataField="LastUpdateDate" Groupable="true"
                            HeaderStyle-HorizontalAlign="Center" SortExpression="LastUpdateDate" GroupByExpression="LastUpdateDate [GridColumn_EditedDate] Group By LastUpdateDate ASC">
                            <ItemTemplate>
                                <%#IIf(FormatDate(Container.DataItem("LastUpdateDate")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("LastUpdateDate")))%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpEditedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Office2007" SelectedDate='<%# Eval("LastUpdateDate")%>'
                                    Enabled="false">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                            CancelImageUrl="Cancel.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CommandName="EditRows" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                OnClientClick="return popUpNote(false);">
                                &nbsp;&nbsp; 
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                CommandName="InitNewRow" OnClientClick="return popUpNote(true);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelected" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                CommandName="RebindGrid">
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
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings Resizing-AllowColumnResize="true" ClientEvents-OnRowClick="OnNotesRowClick"
                    AllowColumnHide="true" AllowColumnsReorder="true" EnableRowHoverStyle="true" AllowDragToGroup="True" AllowRowsDragDrop="true"
                    ClientEvents-OnGridCreating="DocumentNote_Creating">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    <ClientEvents OnGridCreating="DocumentNote_Creating"></ClientEvents>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
        <div class="col-6 PreviewNotesPadding">
            <div style="overflow: auto; border: 1px solid #999; height: calc(100vh - 180px)" id="PreviewDiv" runat="server">
                <asp:Label ID="lblContent" runat="server"></asp:Label>
            </div>
            <div style="border: 1px solid #999; height: calc(100vh - 237px); text-align: center;" id="AddNoteDiv" runat="server">
                <asp:LinkButton runat="server" ID="btnAddNote" OnClientClick="return popUpNote(true);">
                                <div class="btnAddNote">&nbsp; </div>
                </asp:LinkButton>
            </div>
            <asp:LinkButton ID="btnShowNotes" Style="display: none;" runat="server"></asp:LinkButton>
        </div>
    </div>
</div>
<asp:Button ID="btnRefreshGrid" runat="server" CssClass="Hide" />
<%--OnRowDblClick="return popUpNote(false);"--%>