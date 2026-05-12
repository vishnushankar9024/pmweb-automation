<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="OnlineUsers.ascx.vb" Inherits="Website.OnlineUsers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgOnlineUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOnlineUsers" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlLicenses" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<div class="PMHeader" style="padding-top:40.81px !important">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgOnlineUsers" runat="server" CssClass="WithoutTopBorder" SetWidth="true" AppendMenus="true"
                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                PageSize="10" AllowPaging="true" Width="100%"
                AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ShowGroupPanel="true">
                <PagerStyle Mode="NextPrevAndNumeric" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="SessionId, Username" CommandItemDisplay="Top">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Session Id" SortExpression="SessionId" UniqueName="SessionId" DataField="SessionId" CurrentFilterFunction="Contains"
                            GroupByExpression="SessionId [GridColumn_SessionId] Group By SessionId ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("SessionId") = String.Empty, "&nbsp;", Container.DataItem("SessionId"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="170px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="User Name" SortExpression="Username" UniqueName="Username" DataField="Username" CurrentFilterFunction="Contains"
                            GroupByExpression="Username [GridColumn_Username] Group By Username ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Username") = String.Empty, "&nbsp;", Container.DataItem("Username"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Login Date" SortExpression="LoginDate" UniqueName="LoginDate" DataField="LoginDate" CurrentFilterFunction="GreaterThanOrEqualTo"
                            GroupByExpression="LoginDate [GridColumn_LoginDate] Group By LoginDate ASC" DataType="System.DateTime" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><span><%#FormatDate(Container.DataItem("LoginDate")) + " " + FormatTime(Container.DataItem("LoginDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Activity Date" SortExpression="LastActivityDate" UniqueName="LastActivityDate" DataField="LastActivityDate" CurrentFilterFunction="GreaterThanOrEqualTo"
                            GroupByExpression="LastActivityDate [GridColumn_LastActivityDate] Group By LastActivityDate ASC" DataType="System.DateTime" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatDate(Container.DataItem("LastActivityDate")) + " " + FormatTime(Container.DataItem("LastActivityDate"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Requested Url" SortExpression="LastRequestUrl" UniqueName="LastRequestUrl" DataField="LastRequestUrl" CurrentFilterFunction="Contains" Visible="false"
                            GroupByExpression="LastRequestUrl [GridColumn_LastRequestUrl] Group By LastRequestUrl ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("LastRequestUrl") = String.Empty, "&nbsp;", Container.DataItem("LastRequestUrl"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="License Type" UniqueName="LicenseType" DataField="LicenseType" CurrentFilterFunction="Contains"
                            GroupByExpression="LicenseType [GridColumn_LicenseType] Group By LicenseType ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#CStr(If(Container.DataItem("LicenseType") Is System.DBNull.Value, "&nbsp;", Container.DataItem("LicenseType")))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Named" UniqueName="IsNamedLic" DataField="IsNamedLic" CurrentFilterFunction="Contains"
                            GroupByExpression="IsNamedLic [GridColumn_IsNamedLic] Group By IsNamedLic ASC" DataType="System.Boolean" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#CStr(If(Container.DataItem("IsNamedLic") Is System.DBNull.Value, "&nbsp;", IIf(CBool(Container.DataItem("IsNamedLic")), Me.GetLocalResourceObject("LICENSE_NAMED"), Me.GetLocalResourceObject("LICENSE_CONCURRENT"))))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn HeaderText="IP" SortExpression="IPAddress" UniqueName="IPAddress" DataField="IPAddress" CurrentFilterFunction="Contains"
                            GroupByExpression="IPAddress [GridColumn_IPAddress] Group By IPAddress ASC" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#CStr(If(Container.DataItem("IPAddress") Is System.DBNull.Value, "&nbsp;", Container.DataItem("IPAddress")))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <EditItemStyle Wrap="false" />
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="Username"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">

                            <asp:LinkButton ID="btnEndSession" CausesValidation="false" CssClass="GridCmdEndSession"
                                SecurityButtonType="ItemMode_Delete"
                                runat="server" CommandName="EndSession">
                                <span class="Icon"></span>
                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode"
                                CommandName="RebindGrid">
                                <span class="Icon"></span>
                                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>

                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true" ClientEvents-OnRowDblClick="RowDblClick"
                    AllowDragToGroup="True" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />

                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>


