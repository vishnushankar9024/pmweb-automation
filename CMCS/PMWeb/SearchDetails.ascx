<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SearchDetails.ascx.vb" Inherits="Website.SearchDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSearchDetailsDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSearchDetailsDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="PMHeader" style="padding-top:24px;margin-bottom:34px;">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgSearchDetailsDetails" runat="server" SetWidth="true" Width="100%" ClientSettings-Scrolling-AllowScroll="true" 
                AllowFilteringByColumn="True"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder" AppendMenus="true"
                Font-Size="8px" PageSize="250" ShowFooter="false" AllowPaging="True" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" >
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" AllowFilteringByColumn="true"
                    EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" Groupable="False" HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Center">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Record #" UniqueName="RecordNumber" DataField="RecordNumber"
                            SortExpression="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliCode" runat="server" CssClass="NoWrap"
                                    Text='<%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%>'
                                    NavigateUrl='<%#CStr(Container.DataItem("PostBackUrl"))%>'></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle Width="230px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Record Type" DataField="RecordType"
                            UniqueName="RecordType" SortExpression="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="255px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project #" GroupByExpression="ProjectNumber [GridColumn_ProjectNumber] Group By ProjectNumber ASC" DataField="ProjectNumber"
                            UniqueName="ProjectNumber" SortExpression="ProjectNumber">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProjectNumber") = String.Empty, "&nbsp;", Container.DataItem("ProjectNumber"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="284px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Project Name" UniqueName="ProjectName" SortExpression="ProjectName" DataField="ProjectName"
                            GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ProjectName") = String.Empty, "&nbsp;", Container.DataItem("ProjectName"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="292px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                            UniqueName="Description" SortExpression="Description" DataField="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="308px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value" DataField="Value"
                            SortExpression="Value" Groupable="false">
                            <ItemTemplate>
                                <asp:Label ID="lblValue" runat="server"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="180px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <ItemStyle Wrap="false" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnAddIssue" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="InitNewIssue" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSearchDetailsDetails.EditIndexes.Count = 0 And (Not rdgSearchDetailsDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAppendIssue" runat="server" CausesValidation="false"
                                SecurityButtonType="ItemMode_Add"
                                CommandName="AppendIssue" CssClass="GridCmdInitNewIssue" Visible='<%# rdgSearchDetailsDetails.EditIndexes.Count = 0 And (Not rdgSearchDetailsDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible="<%# rdgSearchDetailsDetails.EditIndexes.Count = 0 And (Not rdgSearchDetailsDetails.MasterTableView.IsItemInserted) %>">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <span style="width: 100%; text-align: right;margin-left:5px;">
                                <asp:CheckBox runat="server" ID="ckbSelectAllRecords" CssClass="chkAlignMiddle mobile-switch" AutoPostBack="true" OnCheckedChanged="chkUserUnits_OnChekedChanged" Text="Select All Records1" meta:resourcekey="ckbSelectAllRecords" SecurityButtonType="ItemMode_Edit" />
                            </span>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                    EnableShadows="true" CausesValidation="false"
                                    Visible="true">
                                </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>

