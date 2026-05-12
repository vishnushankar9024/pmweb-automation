<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Leases.ascx.vb" Inherits="Website.Leases1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLeases">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLeases" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgLeases" runat="server" Width="100%"   HeaderStyle-Font-Size="8" AutoGenerateColumns="False" AllowSorting="true" 
    CssClass="WithoutTopBorder ResponsiveMargin" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    ShowStatusBar="true" TabIndex="11" AllowMultiRowSelection="false" AllowPaging="true" PageSize="20" 
    ShowGroupPanel="true" AllowFilteringByColumn="true" GridLines="None">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>
    <mastertableview datakeynames="Id" commanditemdisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Record #" ItemStyle-Wrap="false" UniqueName="RecordNumber"
                GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC" SortExpression="RecordNumber"
                Reorderable="true" DataField="RecordNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" >
                <ItemTemplate>
                    <a id="hypLinkedRecordNumber" href='<%#Eval("PostBackUrl")%>'><%# IIf(CStr(Eval("RecordNumber")) = String.Empty, "&nbsp;", Eval("RecordNumber"))%></a>  
                </ItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>        
            <telerik:GridTemplateColumn HeaderText="Status" ItemStyle-Wrap="false" UniqueName="Status"
                GroupByExpression="Status [GridColumn_Status] Group By Status ASC" SortExpression="Status"
                Reorderable="true" DataField="Status" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:label id="lblStatus" Text="" runat="server"></asp:label>
                </ItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Parent Lease" ItemStyle-Wrap="false" UniqueName="ParentLease"
                GroupByExpression="ParentLease [GridColumn_ParentLease] Group By ParentLease ASC" SortExpression="ParentLease"
                Reorderable="true" DataField="ParentLease" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <a id="hypLinkedParentLease" href='<%#Eval("ParentLeasePostBackUrl")%>'><%# IIf(CStr(Eval("ParentLease")) = String.Empty, "&nbsp;", Eval("ParentLease"))%></a>
                </ItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Lease Type" ItemStyle-Wrap="false" UniqueName="LeaseType"
                GroupByExpression="LeaseType [GridColumn_LeaseType] Group By LeaseType ASC" SortExpression="LeaseType"
                Reorderable="true" DataField="LeaseType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span> <%# IIf(Container.DataItem("LeaseType") = String.Empty, "&nbsp;", Container.DataItem("LeaseType"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description"
                GroupByExpression="Description [GridColumn_Description] Group By Description ASC" SortExpression="Description"
                Reorderable="true" DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span> <%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Landlord" ItemStyle-Wrap="false" UniqueName="Landlord"
                GroupByExpression="Landlord [GridColumn_Landlord] Group By Landlord ASC" SortExpression="Landlord"
                Reorderable="true" DataField="Landlord" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span> <%# IIf(Container.DataItem("Landlord") = String.Empty, "&nbsp;", Container.DataItem("Landlord"))%></span>&nbsp;
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Tenant" ItemStyle-Wrap="false" UniqueName="Tenant"
                GroupByExpression="Tenant [GridColumn_Tenant] Group By Tenant ASC" SortExpression="Tenant"
                Reorderable="true" DataField="Tenant" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span> <%# IIf(Container.DataItem("Tenant") = String.Empty, "&nbsp;", Container.DataItem("Tenant"))%></span>&nbsp;
                </ItemTemplate>
                <HeaderStyle Width="160px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Lease Start" ItemStyle-Wrap="false" UniqueName="LeaseStart"
                GroupByExpression="LeaseStart [GridColumn_LeaseStart] Group By LeaseStart ASC" SortExpression="LeaseStart"
                Reorderable="true" DataField="LeaseStart" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# FormatDate(Eval("LeaseStart"))%></span>&nbsp;
                </ItemTemplate>
               <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Lease Finish" ItemStyle-Wrap="false" UniqueName="LeaseFinish"
                GroupByExpression="LeaseFinish [GridColumn_LeaseFinish] Group By LeaseFinish ASC" SortExpression="LeaseFinish"
                Reorderable="true" DataField="LeaseFinish" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%# FormatDate(Eval("LeaseFinish"))%></span>&nbsp;
                </ItemTemplate>
               <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Rent Month" ItemStyle-Wrap="false" UniqueName="RentMonth"
                GroupByExpression="RentMonth [GridColumn_RentMonth] Group By RentMonth ASC" SortExpression="RentMonth"
                Reorderable="true" DataField="RentMonth" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span> <%# FormatCurrency(Eval("RentMonth"))%></span>&nbsp;
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Active" ItemStyle-Wrap="false" UniqueName="Active"
                GroupByExpression="Active [GridColumn_Active] Group By Active ASC" SortExpression="Active"
                Reorderable="true" DataField="Active" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate> 
                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Active"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                </ItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <CommandItemTemplate>
            <div style="padding:2px">
                <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  >
                    <span class="Icon"></span>
                    <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
            </div>
        </CommandItemTemplate>
    </mastertableview>
    <headerstyle font-size="8pt"></headerstyle>
    <clientsettings AllowDragToGroup="true" AllowColumnsReorder="true">
        <Selecting AllowRowSelect="false" EnableDragToSelectRows="false"  />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
    </clientsettings>
</telerik:RadGrid>
