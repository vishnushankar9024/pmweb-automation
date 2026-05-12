<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ManageBids.ascx.vb" Inherits="Website.ManageBids" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgManageBids">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgManageBids" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="hdnCreatedNotificationLog" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgManageBids" runat="server" CssClass="WithoutTopBorder"
    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
    PageSize="250" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True" AllowMultiRowEdit="True"
    AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" AllowFilteringByColumn="true"
    FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
        InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace">

        <Columns>

            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" SortExpression="BestBid" DataField="BestBid" UniqueName="BestBid" HeaderText="Best Bid" GroupByExpression="BestBid [GridColumn_BestBid] Group By BestBid ASC" HeaderStyle-Width="80px"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" OnCheckedChanged="chkSelect_OnChekedChanged" AutoPostBack="true" runat="server" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company" UniqueName="Company" CurrentFilterFunction="Contains" DataField="Company" DataType="System.String"
                AutoPostBackOnFilter="true" FilterListOptions="VaryByDataType" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
                <ItemStyle Wrap="false" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Bid #" Groupable="true" UniqueName="BidNumber" CurrentFilterFunction="EqualTo" DataField="Id" DataType="System.Int64"
                AutoPostBackOnFilter="true" SortExpression="Id" FilterListOptions="VaryByDataType" GroupByExpression="Id [GridColumn_BidNumber] Group By Id ASC">
                <ItemTemplate>
                    <a runat="server" id="hyBidNunumber" href='<%#GetUrlByObjectType(Library.PmEstimate.BidderInfo.OBJECT_TYPE,Eval("Id").ToString)%>'><%#Eval("Id").ToString%> </a>
                </ItemTemplate>
                <HeaderStyle Width="85px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Rev." CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" DataField="RevisionNumber" DataType="System.Int64" FilterListOptions="VaryByDataType"
                SortExpression="RevisionNumber" GroupByExpression="RevisionNumber [GridColumn_Revision] Group By RevisionNumber" UniqueName="Revision">
                <ItemTemplate>
                    <span><%#Eval("RevisionNumber")%>&nbsp;</span>
                </ItemTemplate>
                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Date" DataField="RevisionDate" UniqueName="RevisionDate" SortExpression="RevisionDate" DataType="System.DateTime"
                GroupByExpression="RevisionDate [GridColumn_RevisionDate] Group By RevisionDate ASC"
                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("RevisionDate"))%></span>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                <HeaderStyle Width="108px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Bid Total" SortExpression="BidTotal" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" UniqueName="BidTotal" DataField="BidTotal" GroupByExpression="BidTotal [GridColumn_BidTotal] Group By BidTotal">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("BidTotal"), CurrencyId:=PM.Estimate.ProcurementInfo.CurrencyId)%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle Width="100px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Leveled Total" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="LeveledAmount" DataField="LeveledAmount" UniqueName="LeveledTotal" GroupByExpression="LeveledAmount [GridColumn_LeveledTotal] Group By LeveledAmount">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("LeveledAmount"), CurrencyId:=PM.Estimate.ProcurementInfo.CurrencyId)%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle Width="100px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Bid Status" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="BidStatus" UniqueName="BidStatus"
                GroupByExpression="BidStatus [GridColumn_BidStatus] Group By BidStatus" DataField="BidStatus" DataType="System.String" Groupable="true">
                <ItemTemplate>
                    <span><%#Eval("BidStatus")%>&nbsp;</span>
                </ItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Bid Expires" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="BidExpires"
                DataField="BidExpires" DataType="System.DateTime" Groupable="true" UniqueName="BidExpires" GroupByExpression="BidExpires [GridColumn_BidExpires] Group By BidExpires">
                <ItemTemplate>
                    <span><%#FormatDate(Container.DataItem("BidExpires"))%></span>
                </ItemTemplate>
                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Bidder Comments" HeaderStyle-Width="300px" ItemStyle-HorizontalAlign="Right" ItemStyle-VerticalAlign="Top"
                HeaderStyle-Wrap="true" ItemStyle-Wrap="true" SortExpression="BidderComments" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Reorderable="true" UniqueName="Comment"
                DataField="BidderComments" Groupable="true" GroupByExpression="BidderComments [GridColumn_Comment] Group By BidderComments ASC">
                <ItemTemplate>
                    <div style="max-height: 75px; max-width: 100%">
                        <asp:Label runat="server" ID="lblComment" Text='<%# Eval("BidderComments") %>'></asp:Label>
                    </div>
                </ItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" UniqueName="Synch" DataField="Synch" HeaderText="Synch" SortExpression="Synch" Groupable="true" HeaderStyle-Width="80px" GroupByExpression="Synch [GridColumn_Synch] Group By Synch ASC">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSynch" OnCheckedChanged="chkSynch_OnChekedChanged" AutoPostBack="true" runat="server" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" UniqueName="Lock" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="Lock" HeaderText="Lock" DataField="Lock" Groupable="true" HeaderStyle-Width="80px" GroupByExpression="Lock [GridColumn_Lock] Group By Lock ASC">
                <ItemTemplate>
                    <asp:CheckBox ID="chkLock" OnCheckedChanged="chkLocked_OnChekedChanged" AutoPostBack="true" runat="server" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>

        </Columns>
        <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnReissueBids" runat="server" CssClass="GridCmdReissueBids"
                    OnClientClick="return OpenPOPUp('ReissueBidsPopUp.aspx' , 596, 360, true, 'rdgManageBids');"
                    CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="ReissueBids">
                    <span class="Icon"></span>
                    <asp:Label ID="lblReissueBids" runat="server" Text="Reissue Bid(s)" meta:resourcekey="lblReissueBids"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode">
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
                <span style="width: 100%; text-align: right">
                    <asp:CheckBox runat="server" ID="ckbLatestRevision" Text="Latest Revision Only" meta:resourcekey="ckbLatestRevision"
                        OnCheckedChanged="ckbLatestRevision_OnChekedChanged" AutoPostBack="true" />
                </span>
            </div>
        </CommandItemTemplate>

    </MasterTableView>
    <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="true" EnableRowHoverStyle="false">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" AllowRowResize="false" />
    </ClientSettings>

</telerik:RadGrid>
<asp:HiddenField runat="server" ID="hdnCreatedNotificationLog" />
