<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="NotificationInbox.ascx.vb" Inherits="Website.NotificationInbox" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgNotificationInbox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgNotificationInbox" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
 <telerik:RadGrid ID="rdgNotificationInbox" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        ShowGroupPanel="false" AllowPaging="true" PageSize="7" GroupingEnabled="false" AllowFilteringByColumn="True" SetWidth ="true" AppendMenus="true" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                    AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="True" AllowMultiRowSelection="True" 
                    ShowStatusBar="false" GridLines="None" ShowHeader="true" >
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle> 
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="IndexId,PostBackUrl" TableLayout="Fixed" Width="100%" EnableHeaderContextMenu="true" CommandItemDisplay="Top" >
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="ID" DataField="RecordNumber" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType"
                            SortExpression="RecordNumber" UniqueName="RecordNumber">
                                <ItemTemplate>
                                    <span><asp:LinkButton Text='<%# Container.DataItem("RecordNumber") %>'
                                        ID="lbtRecordId" runat="server" CausesValidation="False" CommandName="NotificationInboxClicked"></asp:LinkButton></span>
                                </ItemTemplate>
                                <HeaderStyle Width="57px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Document Type" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="RecordType" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="RecordType" UniqueName="RecordType">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("RecordType")%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="500px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Project/Location" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="EntityName" DataType="System.String" FilterListOptions="VaryByDataType"
                             SortExpression="EntityName"  UniqueName="EntityName">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("EntityName")%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>
                                          <telerik:GridTemplateColumn HeaderText="From" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" 
                                   DataField="From" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="From" UniqueName="From" >
                                <ItemTemplate>
                                    <span><%#Container.DataItem("From")%> &nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                              <telerik:GridTemplateColumn HeaderText="Due Date" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" DataField="DueDate" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                              ItemStyle-HorizontalAlign="Right" SortExpression="DueDate"  UniqueName="DueDate">
                                <ItemTemplate>
                                    <span><%# FormatDate(Container.DataItem("DueDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                  <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Description" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="Description" DataType="System.String" FilterListOptions="VaryByDataType"
                                SortExpression="Description" UniqueName="Description" >
                                <ItemTemplate>
                                    <span><%#Container.DataItem("Description")%> &nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                     
                            
                        </Columns>
                           <CommandItemTemplate>
            <div style="padding: 2px">
                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                    CommandName="SaveState">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </asp:LinkButton>
                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                    CausesValidation="False" CommandName="LoadDefaultState">
                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                </asp:LinkButton>
                 &nbsp;&nbsp;
<%--                  <asp:LinkButton ID="lbtShowFilter" runat="server" Text='<%# Me.GetLocalResourceObject("ToggleFilters") %>' CommandName="ShowFilter"></asp:LinkButton>
                  &nbsp;&nbsp;--%>
                  <asp:LinkButton ID="lbtDismissSelectedReminders" runat="server" Text='<%# Me.GetLocalResourceObject("DismissSelectedReminders") %>' CommandName="DismissSelectedReminders"></asp:LinkButton>
                  &nbsp;&nbsp;
            </div>
        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    
                    <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true" AllowDragToGroup="false"
                    AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
                     <Selecting AllowRowSelect ="true " />
                    </ClientSettings>
                </telerik:RadGrid>