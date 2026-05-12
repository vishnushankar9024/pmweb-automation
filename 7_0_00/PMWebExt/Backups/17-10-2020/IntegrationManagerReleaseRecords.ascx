<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IntegrationManagerReleaseRecords.ascx.vb" Inherits="Website.IntegrationManagerReleaseRecords" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgReleaseRecords">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgReleaseRecords" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ddlProjects">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgReleaseRecords" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="ddlProjects" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ddlRecordType">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgReleaseRecords" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="ddlRecordType" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style type="text/css">
    #ctl00_ctl00_CPH1_IntegrationManagerReleaseRecords1_rdgReleaseRecords_ctl00_ctl02_ctl00_ddlProjectsPanel{display:inline-block !important;}
    #ctl00_ctl00_CPH1_IntegrationManagerReleaseRecords1_rdgReleaseRecords_ctl00_ctl02_ctl00_ddlRecordTypePanel{display:inline-block !important;}
</style>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgReleaseRecords" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="20" AppendMenus="true"
                ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Project" GroupByExpression="ProjectFullName [GridColumn_ProjectFullName] Group By ProjectFullName ASC"
                            UniqueName="ProjectFullName" SortExpression="ProjectFullName">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("ProjectFullName") = String.Empty, "&nbsp;", Container.DataItem("ProjectFullName"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="180px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                            UniqueName="RecordType" SortExpression="RecordType">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                            </ItemTemplate>

                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Record #" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC"
                            ItemStyle-HorizontalAlign="Right" SortExpression="RecordNumber" UniqueName="RecordNumber">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Revision" GroupByExpression="Revision [GridColumn_Revision] Group By Revision ASC"
                            ItemStyle-HorizontalAlign="Right" SortExpression="Revision" UniqueName="Revision">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Revision") = String.Empty, "&nbsp;", Container.DataItem("Revision"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                            UniqueName="Description" SortExpression="Description">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Record Status" UniqueName="RecordStatus" SortExpression="RecordStatus"
                            GroupByExpression="RecordStatus [GridColumn_RecordStatus] Group By RecordStatus ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("RecordStatus") = String.Empty, "&nbsp;", Container.DataItem("RecordStatus"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Sent" GroupByExpression="Sent [GridColumn_Sent] Group By Sent ASC"
                            ItemStyle-HorizontalAlign="Right" SortExpression="Sent" UniqueName="Sent" DataField="Sent">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("Sent")) + " " + FormatTime(Container.DataItem("Sent"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                    </Columns>
                    <ItemStyle Wrap="false" />
                    <CommandItemTemplate>
                            <table style="width:400px" runat="server">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblProject" runat="server" Text="Project" meta:Resourcekey="lblProject"></asp:Label>
                                        &nbsp;&nbsp;
                            <telerik:RadComboBox ID="ddlProjects" runat="server" OnItemsRequested="ddl_ItemsRequested" Style="padding-left: 80px;"
                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" meta:resourcekey="ddlProjects" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"
                                Width="240px" AutoPostBack="true" NoWrap="true" CausesValidation="False"
                                Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True">
                            </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblRecordType" runat="server" Text="Record Type" meta:Resourcekey="lblRecordType"></asp:Label>
                                        &nbsp;&nbsp;
                            <telerik:RadComboBox ID="ddlRecordType" runat="server" Style="padding-left: 80px;" Filter="Contains" MarkFirstMatch="true" OnSelectedIndexChanged="ddlRecordType_SelectedIndexChanged"
                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                Width="240px" DropDownWidth="400px" AutoPostBack="true" NoWrap="true" CausesValidation="False"
                                Height="400px">
                            </telerik:RadComboBox>
                                    </td>
                                    <td> 
                                        <asp:LinkButton ID="btnRelease" OnClientClick="if (!confirm(Msg_ConfirmRelease)) return;"
                                            runat="server" CausesValidation="False" CommandName="Release" CssClass="GridCmdAward"
                                            SecurityButtonType="ItemMode_Delete" Text="Release Selected records" meta:resourcekey="btnRelease"
                                            Visible='<%# rdgReleaseRecords.EditIndexes.Count = 0 And (Not rdgReleaseRecords.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRelease" runat="server" Text="Release Selected records" meta:resourcekey="btnRelease"></asp:Label>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </table>

       
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="True">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
