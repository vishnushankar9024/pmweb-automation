<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ViewReminders.aspx.vb" Inherits="Website.ViewReminders" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <script type="text/javascript">
        function OpenReminderPopupForEdit() {
            var grid = $find($("[id$=rdgReminders]")[0].id);
            if (grid.MasterTableView.get_selectedItems().length == 1) {
                var btnOpenReminderEdit = $("[id$=btnOpenReminderEdit]");
                btnOpenReminderEdit.click();
            }
            return false;
        }

        function OpenEditPopup() {
            var grid = $find($("[id$=rdgReminders]")[0].id);
            if (grid.MasterTableView.get_selectedItems().length == 1) {
                var row = grid.MasterTableView.get_selectedItems()[0];
                var TemplateId = row.getDataKeyValue("Id")
                return OpenPOPUp("DefineReminderPopup.aspx?Id=" + TemplateId + "&Source=ViewReminders", 477, 630, true, 'rdgReminders');
            }
            return false;
        }
    </script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgReminders">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgReminders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnOpenReminderEdit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnOpenReminderEdit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgReminders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnOpenReminderEdit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"  CssClass="popup-toolbar" >
                    <items>
                    </items>
                </telerik:RadToolBar>

                <telerik:RadGrid ID="rdgReminders" runat="server" CssClass="TopMarginWhenMobileMenuShown"
                    AutoGenerateColumns="False" ShowStatusBar="false" ShowFooter="False"
                    Font-Size="8px" PageSize="20" AllowPaging="True" ShowGroupPanel="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                    AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true">

                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" ClientDataKeyNames="Id"
                        EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter="false" GroupLoadMode="Client">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="System ID" UniqueName="Id" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Id" Groupable="false"
                                Reorderable="true" DataField="Id" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#Container.DataItem("Id")%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Program" UniqueName="Program" SortExpression="Program" DataField="Program"
                                ItemStyle-HorizontalAlign="Right" GroupByExpression="Program [GridColumn_Program] Group By Program ASC"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Program") = String.Empty, "&nbsp;", Container.DataItem("Program"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project" SortExpression="Project" DataField="Project"
                                ItemStyle-HorizontalAlign="Right" GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Project") = String.Empty, "&nbsp;", Container.DataItem("Project"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" SortExpression="Location"
                                GroupByExpression="Location [GridColumn_Location] Group By Location" DataField="Location" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" Wrap="false"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Record Type" UniqueName="RecordType" DataField="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field" UniqueName="Field" SortExpression="Field"
                                GroupByExpression="Field [GridColumn_Field] Group By Field ASC" DataField="Field" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Field") = String.Empty, "&nbsp;", Container.DataItem("Field"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Record" GroupByExpression="Record [GridColumn_Record] Group By Record ASC" DataField="Record" SortExpression="Record"
                                UniqueName="Record" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hliRecord" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                        Text='<%#Eval("Record").ToString%>' NavigateUrl='<%#Eval("Link").ToString%>'></asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle Width="110px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Reference Date" SortExpression="ReferenceDate"
                                UniqueName="ReferenceDate" DataField="ReferenceDate" GroupByExpression="ReferenceDate [GridColumn_ReferenceDate] Group By ReferenceDate ASC"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%# FormatDate(Container.DataItem("ReferenceDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="125px"></HeaderStyle>
                                <ItemStyle Wrap="false" HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Create Reminder" UniqueName="CreateReminder" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="CreateReminder [GridColumn_CreateReminder] Group By CreateReminder ASC" SortExpression="CreateReminder" DataField="CreateReminder"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CreateReminder") = -1, "&nbsp;", Container.DataItem("CreateReminder"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Create Reminder Period" GroupByExpression="CreateReminderPeriod [GridColumn_CreateReminderPeriod] Group By CreateReminderPeriod ASC"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="CreateReminderPeriod" DataType="System.String" FilterListOptions="VaryByDataType"
                                ItemStyle-HorizontalAlign="Left" SortExpression="EventDate" UniqueName="CreateReminderPeriod">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CreateReminderPeriod") = String.Empty, "&nbsp;", Container.DataItem("CreateReminderPeriod"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="90px" />
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Create Reminder Before After" UniqueName="CreateReminderBeforeAfter" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="CreateReminderBeforeAfter [GridColumn_CreateReminderBeforeAfter] Group By CreateReminderBeforeAfter ASC" SortExpression="CreateReminderBeforeAfter" DataField="CreateReminderBeforeAfter"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CreateReminderBeforeAfter") = String.Empty, "&nbsp;", Container.DataItem("CreateReminderBeforeAfter"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Reminder Date" UniqueName="ReminderDate" SortExpression="ReminderDate"
                                GroupByExpression="ReminderDate [GridColumn_ReminderDate] Group By ReminderDate ASC" DataField="ReminderDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%# FormatDate(Container.DataItem("ReminderDate"))%></span>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle Wrap="false" HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Time" UniqueName="Time" SortExpression="Time"
                                GroupByExpression="Time [GridColumn_Time] Group By Time ASC" DataField="Time" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span>
                                        <%# CultureFormatTime(Container.DataItem("Time"))%></span>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle Wrap="false" HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Remind User(s)" UniqueName="RemindUsers" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="RemindUsers [GridColumn_RemindUsers] Group By RemindUsers ASC" SortExpression="CreateReminderBeforeAfter" DataField="RemindUsers"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("RemindUsers") = String.Empty, "&nbsp;", Container.DataItem("RemindUsers"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Remind Contact(s)" UniqueName="RemindContacts" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="RemindContacts [GridColumn_RemindContacts] Group By RemindContacts ASC" SortExpression="RemindContacts" DataField="RemindContacts"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("RemindContacts") = String.Empty, "&nbsp;", Container.DataItem("RemindContacts"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Event Email" UniqueName="UseEmail" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="UseEmail [GridColumn_UseEmail] Group By UseEmail ASC" SortExpression="UseEmail" DataField="UseEmail"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("UseEmail"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Event Text (SMS)" UniqueName="UseText" ItemStyle-HorizontalAlign="Right" Visible="false"
                                GroupByExpression="UseText [GridColumn_UseText] Group By UseText ASC" SortExpression="UseText" DataField="UseText"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("UseText"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Event Onscreen Message" UniqueName="UseOnscreenMessage" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="UseOnscreenMessage [GridColumn_UseOnscreenMessage] Group By UseOnscreenMessage ASC" SortExpression="UseOnscreenMessage" DataField="UseOnscreenMessage"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("UseOnscreenMessage"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Message" UniqueName="Message" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="Message [GridColumn_Message] Group By Message ASC" SortExpression="Message" DataField="Message"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Message") = String.Empty, "&nbsp;", Container.DataItem("Message"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Subject" UniqueName="Subject" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC" SortExpression="Subject" DataField="Subject"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Subject") = String.Empty, "&nbsp;", Container.DataItem("Subject"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Initiative" UniqueName="IsInitiative" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="IsInitiative [GridColumn_IsInitiative] Group By IsInitiative ASC" SortExpression="IsInitiative" DataField="IsInitiative"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsInitiative"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <HeaderStyle Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Created By" UniqueName="CreatedBy" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="CreatedBy [GridColumn_CreatedBy] Group By CreatedBy ASC" SortExpression="CreatedBy" DataField="CreatedBy"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CreatedBy") = String.Empty, "&nbsp;", Container.DataItem("CreatedBy"))%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Created Date" UniqueName="CreatedDate" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="CreatedDate [GridColumn_CreatedDate] Group By CreatedDate ASC" SortExpression="CreatedDate" DataField="CreatedDate"
                                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%# FormatDate(Container.DataItem("CreatedDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Created Time" UniqueName="CreatedTime" ItemStyle-HorizontalAlign="Right"
                                GroupByExpression="CreatedDate [GridColumn_CreatedTime] Group By CreatedDate ASC" SortExpression="CreatedTime" DataField="CreatedDate"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%# CultureFormatTime(Container.DataItem("CreatedDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <FooterStyle CssClass="GridFooter" />
                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                    OnClientClick="return OpenReminderPopupForEdit()"
                                    CommandName="EditRows" Visible='<%# rdgReminders.EditIndexes.Count = 0 AND (Not rdgReminders.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label5" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" OnClientClick="return ContextCreateReminder()" CssClass="GridCmdInitNewRow"
                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgReminders.EditIndexes.Count = 0 AND (Not rdgReminders.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgReminders.EditIndexes.Count = 0 AND (Not rdgReminders.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                    SecurityButtonType="ItemMode"
                                    Visible='<%# rdgReminders.EditIndexes.Count = 0 AND (Not rdgReminders.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnRefreshResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCopyToExcel" CommandName="CopyToExcel" runat="server" CausesValidation="False" CssClass="GridCmdCopyToExcel">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCopyToExcel" meta:resourcekey="lblCopyToExcel" runat="server" Text="Copy To Excel"></asp:Label>
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
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True" />
                        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                    </ClientSettings>
                </telerik:RadGrid>
                <asp:Button ID="btnOpenReminderEdit" runat="server" CssClass="Hide"
                    Text="" />

</asp:Content>
