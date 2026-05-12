<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="DefineReportSchedules.aspx.vb" Inherits="Website.DefineReportSchedules" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadGrid ID="rdgReportSchedules" runat="server" ShowGroupPanel="True" setwidth="true" Width="100%" CssClass="TopMarginWhenMobileMenuShown"
        HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="true" GridLines="None" AllowFilteringByColumn="true"
        PageSize="20" AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id"
            ClientDataKeyNames="Id" AllowSorting="true" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top">
            <Columns>
                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" Groupable="false" UniqueName="SelectAll" Reorderable="true"></telerik:GridClientSelectColumn>

                <telerik:GridTemplateColumn HeaderText="System ID" SortExpression="Id" UniqueName="Id" Reorderable="true"
                    ItemStyle-HorizontalAlign="Right" DataField="Id" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="Id [GridColumn_Id] Group By Id">
                    <ItemTemplate>
                        <span><%#Eval("Id")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Report Name" SortExpression="ReportName" UniqueName="ReportName" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="ReportName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="ReportName [GridColumn_ReportName] Group By ReportName">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblReportName" runat="server" Text='<%# Eval("ReportName")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Report Path" SortExpression="ReportPath" UniqueName="ReportPath" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="ReportPath" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="ReportPath [GridColumn_ReportPath] Group By ReportPath">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblReportPath" runat="server" Text='<%# Eval("ReportPath")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="System Report" SortExpression="IsSystem" UniqueName="IsSystem" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="IsSystem" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataType="System.Boolean"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="IsSystem [GridColumn_IsSystem] Group By IsSystem">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsSystem")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Report Schedule" SortExpression="Frequency" UniqueName="Frequency" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="Frequency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="Frequency [GridColumn_Frequency] Group By Frequency">
                    <ItemTemplate>
                        <span><%# Eval("Frequency")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Day(s) of the week" SortExpression="WeeksDays" UniqueName="WeeksDays" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="WeeksDays" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="WeeksDays [GridColumn_WeeksDays] Group By WeeksDays">
                    <ItemTemplate>
                        <span><%# Eval("WeeksDays")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Day" SortExpression="MonthlyOnDay" UniqueName="MonthlyOnDay" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="MonthlyOnDay" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="MonthlyOnDay [GridColumn_MonthlyOnDay] Group By MonthlyOnDay">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("MonthlyOnDay")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Day Number" SortExpression="DaysOfMonth" UniqueName="DaysOfMonth" Reorderable="true"
                    ItemStyle-HorizontalAlign="Right" DataField="DaysOfMonth" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="DaysOfMonth [GridColumn_DaysOfMonth] Group By DaysOfMonth">
                    <ItemTemplate>
                        <span><%# Eval("DaysOfMonth")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="The Occurrence" SortExpression="TheOccurrence" UniqueName="TheOccurrence" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="TheOccurrence" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="TheOccurrence [GridColumn_TheOccurrence] Group By TheOccurrence">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("TheOccurrence")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Ordinal" SortExpression="strOrdinal" UniqueName="strOrdinal" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="strOrdinal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="strOrdinal [GridColumn_strOrdinal] Group By strOrdinal">
                    <ItemTemplate>
                        <span><%# Eval("strOrdinal")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Day of the week" SortExpression="strMonthlyWeekDay" UniqueName="strMonthlyWeekDay" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="strMonthlyWeekDay" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="strMonthlyWeekDay [GridColumn_strMonthlyWeekDay] Group By strMonthlyWeekDay">
                    <ItemTemplate>
                        <span><%# Eval("strMonthlyWeekDay")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="From" SortExpression="StartDate" UniqueName="StartDate" Reorderable="true" DataType="System.DateTime"
                    ItemStyle-HorizontalAlign="Left" DataField="StartDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate">
                    <ItemTemplate>
                        <span><%# FormatDate(Eval("StartDate"))%>&nbsp;</span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="To" SortExpression="EndDate" UniqueName="EndDate" Reorderable="true" DataType="System.DateTime"
                    ItemStyle-HorizontalAlign="Left" DataField="EndDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="EndDate [GridColumn_EndDate] Group By EndDate">
                    <ItemTemplate>
                        <span><%# FormatDate(Eval("EndDate"))%>&nbsp;</span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="User(s)" SortExpression="Users" UniqueName="Users" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="Users" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="Users [GridColumn_Users] Group By Users">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblUsers" runat="server" Text='<%# Eval("Users")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Contact(s)" SortExpression="Contacts" UniqueName="Contacts" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="Contacts" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="Contacts [GridColumn_Contacts] Group By Contacts">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblContacts" runat="server" Text='<%# Eval("Contacts")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="CC(s)" SortExpression="CCEmails" UniqueName="CCEmails" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="CCEmails" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="CCEmails [GridColumn_CCEmails] Group By CCEmails">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblCCEmails" runat="server" Text='<%# Eval("CCEmails")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Subject" SortExpression="Subject" UniqueName="Subject" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="Subject" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="Subject [GridColumn_Subject] Group By Subject">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblSubject" runat="server" Text='<%# Eval("Subject")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Message" SortExpression="Message" UniqueName="Message" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="Message" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="Message [GridColumn_Message] Group By Message">
                    <ItemTemplate>
                        <span>
                            <asp:Label ID="lblMessage" runat="server" Text='<%# Eval("Message")%>' CssClass="NoWrap"></asp:Label>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Created By" SortExpression="CreatedBy" UniqueName="CreatedBy" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="CreatedBy" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="CreatedBy [GridColumn_CreatedBy] Group By CreatedBy">
                    <ItemTemplate>
                        <span><%# Eval("CreatedBy")%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Created Date" SortExpression="CreatedDate" UniqueName="CreatedDate" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="CreatedDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="CreatedDate [GridColumn_CreatedDate] Group By CreatedDate">
                    <ItemTemplate>
                        <span><%# FormatDate(Eval("CreatedDate"))%>&nbsp;</span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Created Time" SortExpression="CreatedTime" UniqueName="CreatedTime" Reorderable="true"
                    ItemStyle-HorizontalAlign="Left" DataField="CreatedTime" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                    AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" GroupByExpression="CreatedTime [GridColumn_CreatedTime] Group By CreatedTime">
                    <ItemTemplate>
                        <span><%# CultureFormatTime(Container.DataItem("CreatedTime"))%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px" />
                </telerik:GridTemplateColumn>
            </Columns>
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                        SecurityButtonType="ItemMode_Delete"
                        Visible='<%# rdgReportSchedules.EditIndexes.Count = 0 And (Not rdgReportSchedules.MasterTableView.IsItemInserted)%>'
                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                        <span class="Icon"></span>
                        <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete"></asp:Label>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                        Visible='<%# rdgReportSchedules.EditIndexes.Count = 0 And (Not rdgReportSchedules.MasterTableView.IsItemInserted)%>'>
                        <span class="Icon"></span>
                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
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
        <ClientSettings AllowColumnsReorder="true" Selecting-AllowRowSelect="true" AllowDragToGroup="true">
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
        </ClientSettings>
    </telerik:RadGrid>
</asp:Content>
