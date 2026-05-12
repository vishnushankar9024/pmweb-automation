<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="NotificationLog.ascx.vb"
    Inherits="Website.NotificationLog" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMergeLogs">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMergeLogs" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRebindNotificationGrid" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRebindNotificationGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMergeLogs" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRebindNotificationGrid" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
<telerik:RadGrid ID="rdgMergeLogs" runat="server"  
    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250" CssClass="WithoutTopBorder ResponsiveMargin"
    AllowPaging="True" ShowGroupPanel="true" AllowMultiRowEdit="true" AllowMultiRowSelection="true" UseEditFormInMobile ="true"
    AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
        TableLayout="Fixed" Width="100%">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="ID" UniqueName="Projection" Groupable="False"
                AllowFiltering="false">
                <ItemTemplate>
                  <asp:HyperLink ID="imgPreview" runat="server" Text='<%#Eval("Id")%>' style ="text-decoration:underline;">
                  </asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                    <span></span>
                </EditItemTemplate>
                <HeaderStyle Width="65px"/>
                <ItemStyle Wrap="false" HorizontalAlign="right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn Visible="false" ItemStyle-HorizontalAlign="Center" UniqueName="IncludeInBid"
                HeaderText="Include In Bid" Groupable="False" HeaderStyle-Width="80px">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkUserUnits_OnChekedChanged" />
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;</EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Created Date" UniqueName="Date" HeaderStyle-Width="200px" CurrentFilterFunction="GreaterThanOrEqualTo"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="NotificationDate" 
                AutoPostBackOnFilter="true" GroupByExpression="NotificationDate [GridColumn_Date] Group By NotificationDate ASC"
                DataType="System.DateTime" DataField="NotificationDate">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Eval("NotificationDate"))%></span>&nbsp;
                </ItemTemplate>
             <EditItemTemplate>
                    <span>
                        <%#FormatDate(Eval("NotificationDate"))%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Created Time" UniqueName="Time" HeaderStyle-Width="200px" 
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" SortExpression="NotificationTime" Groupable="false"
                AutoPostBackOnFilter="true" GroupByExpression="NotificationTime [GridColumn_Time] Group By NotificationTime ASC"
                DataType="System.String" DataField="NotificationTime">
                <ItemTemplate>
                    <span>
                        <%# CultureFormatTime(Eval("NotificationTime"))%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%# CultureFormatTime(Eval("NotificationTime"))%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Created by" UniqueName="Created" HeaderStyle-Width="200px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="From"
                AutoPostBackOnFilter="true" GroupByExpression="From [GridColumn_Created] Group By From ASC"
                DataType="System.String" DataField="From">
                <ItemTemplate>
                    <span>
                        <%#Eval("From")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("From")%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Send Date" UniqueName="SendDate" HeaderStyle-Width="200px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="SendDate"
                AutoPostBackOnFilter="true" GroupByExpression="SendDate [GridColumn_SendDate] Group By SendDate ASC"
                DataType="System.DateTime" DataField="SendDate">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Eval("SendDate"))%></span>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="griddtpSendDate" Enabled="false" AutoPostBack="false"
                        runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default"
                        EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                            Skin="Default">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false">
                        </DateInput>
                        <ClientEvents OnDateSelected="GridSendDateDateSelected" />
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Send Time" UniqueName="SendTime"
                HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false"
                Groupable="false" SortExpression="SendTime" AutoPostBackOnFilter="true" GroupByExpression="SendTime [GridColumn_SendTime] Group By SendTime ASC"
                DataType="System.String" DataField="SendTime">
                <ItemTemplate>
                    <span>
                        <%# CultureFormatTime(Eval("SendTime"))%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadTimePicker ID="griddtpSendTime" runat="server" Enabled="false"
                        EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                        Skin="Default" Width="103px">
                        <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                            Skin="Default">
                        </DateInput>
                        <Calendar ID="Calendar2" runat="server"  Skin="Default">
                        </Calendar>
                    </telerik:RadTimePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Sent by" UniqueName="SentUser" HeaderStyle-Width="200px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="SentUser"
                AutoPostBackOnFilter="true" GroupByExpression="SentUser [GridColumn_SentUser] Group By SentUser ASC"
                DataType="System.String" DataField="SentUser">
                <ItemTemplate>
                    <span>
                        <%#Eval("SentUser")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("SentUser")%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Reference" UniqueName="Reference" HeaderStyle-Width="110px" DataType="System.String" 
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="Reference"
                DataField="Reference" AutoPostBackOnFilter="true" GroupByExpression="Reference [GridColumn_Reference] Group By Reference ASC">
                <ItemTemplate>
                    <span>
                        <%#Eval("Reference")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" Width="100%" MaxLength="255" ID="txtReference" Text='<%#Eval("Reference")%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="135px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="From" UniqueName="From" HeaderStyle-Width="200px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="FromContact"
                AutoPostBackOnFilter="true" GroupByExpression="FromContact [GridColumn_From] Group By FromContact ASC"
                DataType="System.String" DataField="FromContact">
                <ItemTemplate>
                    <span>
                        <%#Eval("FromContact")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("FromContact")%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="130px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="To Company" DataField="Company" AutoPostBackOnFilter="true"
                HeaderStyle-Wrap="true" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="Company [GridColumn_ToCompany] Group By Company ASC"
                UniqueName="ToCompany" SortExpression="Company">
                <ItemTemplate>
                    <span>
                        <%#Container.DataItem("Company")%>&nbsp;</span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("Company")%>&nbsp;</span>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="To Contact" HeaderStyle-Width="110px" DataField="Contact"
                AutoPostBackOnFilter="true" HeaderStyle-Wrap="false" Groupable="true" GroupByExpression="Contact [GridColumn_ToContact] Group By Contact ASC"
                UniqueName="ToContact" SortExpression="Contact">
                <ItemTemplate>
                    <span>
                        <%#Container.DataItem("Contact")%></span> &nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("Contact")%>&nbsp;</span>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Subject" UniqueName="Subject" HeaderStyle-Width="200px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="Subject"
                DataField="Subject" AutoPostBackOnFilter="true" GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC">
                <ItemTemplate>
                    <span>
                        <%#Eval("Subject")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("Subject")%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="135px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Reminder" HeaderStyle-Width="100px" ItemStyle-Wrap="false"
                GroupByExpression="IsAssigned [GridColumn_IsAssigned] Group By IsAssigned ASC"
                SortExpression="IsAssigned" UniqueName="IsAssigned" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Wrap="false" DataType="System.Boolean" DataField="IsAssigned">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsAssigned"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkIsAssigned" Checked='<%# Cbool(IIF(Eval("IsAssigned") is system.DBNULL.value, 0,Eval("IsAssigned")))%>'
                        runat="server" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Due Date" UniqueName="DueDate" HeaderStyle-Width="200px"
                ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false" Groupable="true" SortExpression="DueDate"
                AutoPostBackOnFilter="true" GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate ASC"
                DataType="System.DateTime" DataField="DueDate">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Eval("DueDate"))%></span>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="griddtpDueDate" AutoPostBack="false" runat="server" MinDate="1901-01-01"
                        MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                            Skin="Default">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false">
                        </DateInput>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Due Time" UniqueName="DueTime"
                HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false"
                Groupable="false" SortExpression="DueTime" AutoPostBackOnFilter="true" GroupByExpression="DueTime [GridColumn_DueTime] Group By DueTime ASC"
                DataType="System.String" DataField="DueDate">
                <ItemTemplate>
                    <span>
                        <%# CultureFormatTime(Eval("DueTime"))%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadTimePicker ID="griddtpDueTime" runat="server" 
                        EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                        Skin="Default" Width="103px">
                        <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                            Skin="Default">
                        </DateInput>
                        <Calendar ID="Calendar2" runat="server"  Skin="Default">
                        </Calendar>
                    </telerik:RadTimePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Completed" HeaderStyle-Width="90px" ItemStyle-Wrap="false"
                GroupByExpression="IsCompleted [GridColumn_IsCompleted] Group By IsCompleted ASC"
                SortExpression="IsCompleted" UniqueName="IsCompleted" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Wrap="false" DataType="System.Boolean" DataField="IsCompleted">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsCompleted"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkIsCompleted" OnClick='NotificationCompletedChecked(this, event);'
                        Checked='<%# Cbool(IIF(Eval("IsCompleted") is system.DBNULL.value, 0,Eval("IsCompleted")))%>'
                        runat="server" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Completed Date" UniqueName="CompletedDate"
                HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false"
                Groupable="true" SortExpression="CompletedDate" AutoPostBackOnFilter="true" GroupByExpression="CompletedDate [GridColumn_CompletedDate] Group By CompletedDate ASC"
                DataType="System.DateTime" DataField="CompletedDate">
                <ItemTemplate>
                    <span>
                        <%#FormatDate(Eval("CompletedDate"))%></span>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="griddtpCompletedDate" AutoPostBack="false" runat="server"
                        MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                            Skin="Default">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false">
                        </DateInput>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Completed Time" UniqueName="CompletedTime"
                HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right" HeaderStyle-Wrap="false"
                Groupable="false" SortExpression="CompletedTime" AutoPostBackOnFilter="true" GroupByExpression="CompletedTime [GridColumn_CompletedTime] Group By CompletedTime ASC"
                DataType="System.String" DataField="CompletedDate">
                <ItemTemplate>
                    <span>
                        <%# CultureFormatTime(Eval("CompletedTime"))%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadTimePicker ID="griddtpCompletedTime" runat="server"
                        EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                        Skin="Default" Width="103px">
                        <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                            Skin="Default">
                        </DateInput>
                        <Calendar ID="Calendar2" runat="server"  Skin="Default">
                        </Calendar>
                    </telerik:RadTimePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notification Type" UniqueName="NotificationType"
                HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false"
                Groupable="true" SortExpression="NotificationType" DataField="NotificationType"
                AutoPostBackOnFilter="true" GroupByExpression="NotificationType [GridColumn_NotificationType] Group By NotificationType ASC">
                <ItemTemplate>
                    <span>
                        <%#Eval("NotificationType")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("NotificationType")%></span>&nbsp;
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notification Status" UniqueName="Status"
                HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="left" HeaderStyle-Wrap="false"
                Groupable="true" SortExpression="Status" DataField="Status" AutoPostBackOnFilter="true"
                GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                <ItemTemplate>
                    <span>
                        <%#Eval("Status")%></span>&nbsp;
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlStatus" Width="100%" runat="server" Filter="Contains"
                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="300px"
                        NoWrap="False" AllowCustomText="true">
                        <CollapseAnimation Duration="200" Type="OutQuint" />
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Use System" HeaderStyle-Width="90px" ItemStyle-Wrap="false"
                GroupByExpression="IsSystem [GridColumn_IsSystem] Group By IsSystem ASC"
                SortExpression="IsSystem" UniqueName="IsSystem" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-Wrap="false" DataType="System.Boolean" DataField="IsSystem">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsSystem"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkIsSystem"
                        Checked='<%# Cbool(IIF(Eval("IsSystem") is system.DBNULL.value, 0,Eval("IsSystem")))%>'
                        runat="server" />
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                    CommandName="EditRows" Visible='<%# rdgMergeLogs.EditIndexes.Count = 0 AND (Not rdgMergeLogs.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"  SecurityButtonType="ItemMode_Add" CommandName="InitNewRow"  CssClass="GridCmdInitNewRow"
                     meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span> 
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgMergeLogs.EditIndexes.Count = 0 AND (Not rdgMergeLogs.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows">
                    <span class="Icon"></span>
                    <asp:Label ID="Label5" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                    CommandName="UpdateEdited" Visible='<%# rdgMergeLogs.EditIndexes.Count > 0 %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" 
                    Visible='<%# rdgMergeLogs.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                    CommandName="CancelAll" Visible='<%# rdgMergeLogs.EditIndexes.Count > 0 Or rdgMergeLogs.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                    CommandName="RebindGrid" Visible="true">
                    <span class="Icon"></span>
                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
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
    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
        AllowDragToGroup="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
    </ClientSettings>
</telerik:RadGrid>
<asp:Button runat="server" ID="btnRebindNotificationGrid" CssClass="Hide" />
<asp:HiddenField runat="server" ID="hddnNotificationReviewTime" />
<asp:HiddenField runat="server" ID="hddnNotificationTodyDate" />
                    </div>
    </div>
</div>