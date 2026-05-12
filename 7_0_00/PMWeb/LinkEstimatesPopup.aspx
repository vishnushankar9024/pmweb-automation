<%@ Page meta:resourcekey="PageTitle" Title="Link Estimate(s)." Language="vb" AutoEventWireup="false" CodeBehind="LinkEstimatesPopup.aspx.vb" Inherits="Website.LinkEstimatesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
       
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgEstimates">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgEstimates" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="False">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="Save" Value="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" Value="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMHeader">
            <div class="row documentSinglePage" style="margin-bottom: 0px;">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgEstimates" GroupingEnabled="true" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" PageSize="10" 
                        AutoGenerateColumns="False" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" FitPageHeightOffset="1"
                        ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8" AllowPaging="true" ShowGroupPanel="True" AllowSorting="true"
                        ShowStatusBar="true" ShowFooter="true" AllowFilteringByColumn="true" AllowMultiRowEdit="false" AllowMultiRowSelection="True">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" ClientDataKeyNames="Id"
                            TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true" ShowGroupFooter="true" CommandItemDisplay="Top">
                            <Columns>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="40px" Groupable="false" UniqueName="Checked" Reorderable="false" ItemStyle-HorizontalAlign="Center"></telerik:GridClientSelectColumn>

                                <telerik:GridTemplateColumn HeaderText="Project" Reorderable="true" UniqueName="ProjectName" ItemStyle-HorizontalAlign="Right" DataField="ProjectName"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="ProjectName"
                                    GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName">
                                    <ItemTemplate>
                                        <%# Eval("ProjectName")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Record #" Reorderable="true" UniqueName="DocumentNumber" ItemStyle-HorizontalAlign="Right" DataField="DocumentNumber"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="DocumentNumber"
                                    GroupByExpression="DocumentNumber [GridColumn_DocumentNumber] Group By DocumentNumber">
                                    <ItemTemplate>
                                        <%# Eval("DocumentNumber")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" Reorderable="true" UniqueName="Description" ItemStyle-HorizontalAlign="Right" DataField="Description"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description">
                                    <ItemTemplate>
                                        <%# Eval("Description")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Workflow Status" Reorderable="true" UniqueName="DocStatus" ItemStyle-HorizontalAlign="Right" DataField="DocStatus"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="DocStatus"
                                    GroupByExpression="DocStatus [GridColumn_DocStatus] Group By DocStatus">
                                    <ItemTemplate>
                                        <%# Eval("DocStatus")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Created By" Reorderable="true" UniqueName="CreatedBy" ItemStyle-HorizontalAlign="Right" DataField="CreatedBy"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="CreatedBy"
                                    GroupByExpression="CreatedBy [GridColumn_CreatedBy] Group By CreatedBy">
                                    <ItemTemplate>
                                        <%# Eval("CreatedBy")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Created Date" Reorderable="true" UniqueName="CreatedDate" ItemStyle-HorizontalAlign="Right" DataField="CreatedDate"
                                    CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" DataType="System.DateTime" Groupable="true" AllowFiltering="true" SortExpression="CreatedDate"
                                    GroupByExpression="CreatedDate [GridColumn_CreatedDate] Group By CreatedDate">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("CreatedDate")) + " " + FormatTime(Eval("CreatedDate")) %>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="140px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Category" Reorderable="true" UniqueName="Category" ItemStyle-HorizontalAlign="Right" DataField="Category"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="Category"
                                    GroupByExpression="Category [GridColumn_Category] Group By Category">
                                    <ItemTemplate>
                                        <%# Eval("Category")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Reference" Reorderable="true" UniqueName="Reference" ItemStyle-HorizontalAlign="Right" DataField="Reference"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="Reference"
                                    GroupByExpression="Reference [GridColumn_Reference] Group By Reference">
                                    <ItemTemplate>
                                        <%# Eval("Reference")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" Reorderable="true" UniqueName="UOM" ItemStyle-HorizontalAlign="Right" DataField="UOM"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="UOM"
                                    GroupByExpression="UOM [GridColumn_UOM] Group By UOM">
                                    <ItemTemplate>
                                        <%# Eval("UOM")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="left"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Unit" Reorderable="true" UniqueName="EstimateUnit" ItemStyle-HorizontalAlign="Right" DataField="EstimateUnit"
                                    FilterListOptions="VaryByDataType" DataType="System.Decimal" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="EstimateUnit"
                                    GroupByExpression="EstimateUnit [GridColumn_EstimateUnit] Group By EstimateUnit">
                                    <ItemTemplate>
                                        <%# Eval("EstimateUnit")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Revision #" Reorderable="true" UniqueName="RevisionNumber" ItemStyle-HorizontalAlign="Right" DataField="RevisionNumber"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" Groupable="true" AllowFiltering="true" SortExpression="RevisionNumber"
                                    GroupByExpression="RevisionNumber [GridColumn_RevisionNumber] Group By RevisionNumber">
                                    <ItemTemplate>
                                        <%# Eval("RevisionNumber")%>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px;">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                    SecurityButtonType="ItemMode"
                                                    Visible='<%# rdgEstimates.EditIndexes.Count = 0 And (Not rdgEstimates.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnRefreshResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                                    CommandName="SaveState" Visible="true">
                                                    <asp:Label ID="Label1" runat="server" Text="Save"></asp:Label>
                                                </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                                    CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" Text="Load Default State" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings Resizing-AllowColumnResize="true" AllowDragToGroup="true" AllowColumnsReorder="true">
                            <Resizing AllowColumnResize="True"></Resizing>
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
