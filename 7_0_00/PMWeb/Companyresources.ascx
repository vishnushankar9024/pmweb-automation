<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Companyresources.ascx.vb" Inherits="Website.Companyresources" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCompanyResources">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCompanyResources" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgCompanyResources" runat="server"  CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                  AutoGenerateColumns="False" ShowStatusBar="True"
                Font-Size="8px" PageSize="20" ShowFooter="false" AllowPaging="True" ShowGroupPanel="true"
                AllowSorting="True" GridLines="None" AllowMultiRowSelection="true" AllowMultiRowEdit="false">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ClientDataKeyNames="Id"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                         <telerik:GridTemplateColumn HeaderText="Resource Category" SortExpression="ResourceCategory" UniqueName="ResourceCategory" DataField="ResourceCategory"
                            GroupByExpression="ResourceCategory [GridColumn_ResourceCategory] Group By ResourceCategory ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ResourceCategory") = "", "&nbsp;", Container.DataItem("ResourceCategory"))%>
                            </ItemTemplate>
                            <HeaderStyle Width="80px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Name" UniqueName="Name"  DataField="Name"
                            GroupByExpression="Name [GridColumn_Name] Group By Name ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%>
                            </ItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                      <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"  DataField="Notes"
                        GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                            </ItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                           <telerik:GridTemplateColumn HeaderText="Added by" SortExpression="AddedBy" UniqueName="AddedBy" DataField="AddedBy"
                            GroupByExpression="AddedBy [GridColumn_AddedBy] Group By AddedBy ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("AddedBy") = String.Empty, "&nbsp;", Container.DataItem("AddedBy"))%>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                          <telerik:GridTemplateColumn HeaderText="Added" HeaderStyle-HorizontalAlign="left" DataField ="AddedDate"
                            HeaderStyle-Width="70px" SortExpression="AddedDate" UniqueName="AddedDate"
                             GroupByExpression="AddedDate [GridColumn_AddedDate] Group By AddedDate ASC">
                            <ItemTemplate>
                                <%#FormatDate(Container.DataItem("AddedDate"))%>&nbsp;
                            </ItemTemplate>
                              <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Last Edited by" SortExpression="LastEditedBy" UniqueName="LastEditedBy" DataField="LastEditedBy"
                            GroupByExpression="LastEditedBy [GridColumn_LastEditedBy] Group By LastEditedBy ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("LastEditedBy") = String.Empty, "&nbsp;", Container.DataItem("LastEditedBy"))%>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Last Edited" HeaderStyle-HorizontalAlign="left" DataField ="LastEditedDate" 
                            HeaderStyle-Width="70px" SortExpression="LastEditedDate" UniqueName="LastEditedDate"
                               GroupByExpression="LastEditedDate [GridColumn_LastEditedDate] Group By LastEditedDate ASC">
                            <ItemTemplate>
                                <%#FormatDate(Container.DataItem("LastEditedDate"))%>&nbsp;
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left"/>
                      <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgCompanyResources.EditIndexes.Count = 0 AND (Not rdgCompanyResources.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                 runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                 EnableShadows="true" CausesValidation="false"
                                 Visible="true">                                 
                             </telerik:RadMenu> 
                          </div>
                    </CommandItemTemplate>
                      </MasterTableView>
                   <ClientSettings AllowDragToGroup="true" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                      <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True"></Resizing>
                    <Selecting AllowRowSelect="true"  />
                        <ClientEvents  OnRowClick="GoToResourceList" />
                </ClientSettings>
                <ValidationSettings ValidationGroup="Save" EnableValidation="true"  />
            </telerik:RadGrid>