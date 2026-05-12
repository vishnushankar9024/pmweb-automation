<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CloseOpenPeriods.aspx.vb" Inherits="Website.CloseOpenPeriods" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgCloseOpenPeriods">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgCloseOpenPeriods" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
        <Items>
        </Items>
    </telerik:RadToolBar>

    <telerik:RadGrid ID="rdgCloseOpenPeriods" runat="server" CssClass="TopMarginWhenMobileMenuShown"
        AllowFilteringByColumn="true" PageSize="20" AllowPaging="true" HeaderStyle-Font-Size="8" ShowStatusBar="true"
        AutoGenerateColumns="false" AllowSorting="true" ShowGroupPanel="True" GridLines="None" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        AllowMultiRowEdit="True" AllowMultiRowSelection="true" GroupLoadMode="Client">
        <PagerStyle Mode="NextPrevAndNumeric" />
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
            DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" GroupLoadMode="Client">
            <Columns>
                <telerik:GridClientSelectColumn HeaderText="Select" Groupable="false" UniqueName="Select" Reorderable="true" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                </telerik:GridClientSelectColumn>

                <telerik:GridTemplateColumn HeaderText="Program" UniqueName="ProgramName" Groupable="true" GroupByExpression="ProgramName [GridColumn_ProgramName] Group By ProgramName ASC"
                    DataField="ProgramName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                    SortExpression="ProgramName">
                    <ItemTemplate>
                        <%#Container.DataItem("ProgramName")%>
                    </ItemTemplate>

                    <HeaderStyle Width="150px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectFullName" Groupable="true" GroupByExpression="ProjectFullName [GridColumn_ProjectName] Group By ProjectFullName ASC"
                    SortExpression="ProjectFullName"
                    DataField="ProjectFullName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#Container.DataItem("ProjectFullName")%>
                    </ItemTemplate>

                    <HeaderStyle Width="150px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn SortExpression="LineNumber" HeaderText="Period #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" Groupable="true" GroupByExpression="LineNumber [GridColumn_LineNumber] Group By LineNumber ASC"
                    DataField="LineNumber" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#Container.DataItem("LineNumber")%>
                    </ItemTemplate>

                    <HeaderStyle Width="100px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn SortExpression="Period" HeaderText="Description" UniqueName="Period" Groupable="true" GroupByExpression="Period [GridColumn_Period] Group By Period ASC"
                    DataField="Period" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#Container.DataItem("Period")%>
                    </ItemTemplate>

                    <HeaderStyle Width="150px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn SortExpression="BudgetYear" HeaderText="Budget Year" UniqueName="BudgetYear" ItemStyle-HorizontalAlign="Right" Groupable="true" GroupByExpression="BudgetYear [GridColumn_BudgetYear] Group By BudgetYear ASC"
                    DataField="BudgetYear" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#Container.DataItem("BudgetYear")%>
                    </ItemTemplate>

                    <HeaderStyle Width="100px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn SortExpression="FromDate" HeaderText="From" UniqueName="FromDate" ItemStyle-HorizontalAlign="Right" Groupable="true" GroupByExpression="FromDate [GridColumn_FromDate] Group By FromDate ASC"
                    DataField="FromDate" CurrentFilterFunction="EqualTo" DataType="System.DateTime" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#FormatDate(Container.DataItem("FromDate"))%>&nbsp;
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="120px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn SortExpression="ToDate" HeaderText="To" UniqueName="ToDate" ItemStyle-HorizontalAlign="Right" Groupable="true" GroupByExpression="ToDate [GridColumn_ToDate] Group By ToDate ASC"
                    DataField="ToDate" CurrentFilterFunction="EqualTo" DataType="System.DateTime" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#FormatDate(Container.DataItem("ToDate"))%>&nbsp;
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="120px" />
                    <%--                  <ItemStyle Wrap="false" />--%>
                </telerik:GridTemplateColumn>

                <telerik:GridTemplateColumn SortExpression="IsClosed" HeaderStyle-Width="150px" HeaderText="Closed" UniqueName="IsClosed" Groupable="true" GroupByExpression="IsClosed [GridColumn_IsClosed] Group By IsClosed ASC"
                    HeaderStyle-Wrap="false" DataField="IsClosed" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>

                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("IsClosed")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <HeaderStyle Width="80px" />

                </telerik:GridTemplateColumn>
            </Columns>

            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnCloseSelectedPeriods" runat="server" SecurityButtonType="ItemMode_Edit" CausesValidation="False"
                        CommandName="CloseSelectedPeriods" CssClass="GridCmdCloseSelectedPeriods">
                        <span class="Icon"></span>
                        <asp:Label ID="Label3" runat="server">Close Selected Periods</asp:Label>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnOpenSelectedPeriods" runat="server" SecurityButtonType="ItemMode_Edit"
                        CausesValidation="False" CommandName="OpenSelectedPeriods" CssClass="GridCmdOpenSelectedPeriods">
                        <span class="Icon"></span>
                        <asp:Label ID="Label4" runat="server">Open Selected Periods</asp:Label>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                        Visible='<%# rdgCloseOpenPeriods.EditIndexes.Count = 0 And (Not rdgCloseOpenPeriods.MasterTableView.IsItemInserted)%>'
                        meta:resourcekey="btnRefreshResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="Label1" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
        </ClientSettings>
    </telerik:RadGrid>

</asp:Content>
