<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SelectLeasePopup.aspx.vb" Inherits="Website.SelectLeasePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function RowClick(sender, eventArgs) {
            var value = eventArgs.getDataKeyValue("Id");
            var text = eventArgs.getDataKeyValue("Lease");
            var combo = window.parent.$find(querySt('ddlId'));
            var hdnLeaseId = window.parent.document.getElementById((querySt('hdnId')));
            if (querySt('Source') == 'Tenant') {
                hdnLeaseId.value = value;
                $(window.parent.document).find("input[id$=btnLease]").click();
            }
            if (combo != null ) {
                combo.trackChanges();
                combo.set_text(text);
                combo.set_value(value);
                combo.commitChanges();
            }
            window.close();
            return false;
        }

        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }
     
    </script>
</head>
<body>
<form id="form1" runat="server">
<asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

<telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
   <ClientEvents OnRequestStart="RequestStart" />
        <AjaxSettings> 
                <telerik:AjaxSetting AjaxControlID="rdgSelectLease">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSelectLease" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
<telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

    <telerik:RadGrid ID="rdgSelectLease" Width="99%" runat="server"   AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" 
         AllowPaging="True"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AllowFilteringByColumn="true" PageSize="250" HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="True" AllowSorting="true" >
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <GroupPanel Text="Group by"></GroupPanel>
               <MasterTableView ClientDataKeyNames="Id,Lease" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                    Width="99%" TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">
                <Columns>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Lease" UniqueName="Lease" SortExpression="Lease"
                        GroupByExpression="Lease [GridColumn_Lease] Group By Lease ASC" DataField="Lease" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Lease").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Suite" UniqueName="Suite" SortExpression="Suite"
                        GroupByExpression="Suite [GridColumn_Suite] Group By Suite ASC" DataField="Suite" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Suite").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Tenant" UniqueName="Tenant" SortExpression="Tenant"
                        GroupByExpression="Tenant [GridColumn_Tenant] Group By Tenant ASC" DataField="Tenant" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Tenant").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Building" UniqueName="Building" SortExpression="Building" DataField="Building"
                        GroupByExpression="Building [GridColumn_Building] Group By Building ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Building").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Floor" UniqueName="Floor" SortExpression="Floor"
                        GroupByExpression="Floor [GridColumn_Floor] Group By Floor ASC" DataField="Floor" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Floor").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Space" UniqueName="Space" SortExpression="Space"
                        GroupByExpression="Space [GridColumn_Space] Group By Space ASC" DataField="Space" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Space").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Equipment" UniqueName="Equipment" SortExpression="Equipment" DataField="Equipment"
                        GroupByExpression="Equipment [GridColumn_Equipment] Group By Equipment ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"> 
                        <ItemTemplate> 
                            <%# Eval("Equipment").ToString%>&nbsp;
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                </Columns>
                <ItemStyle Wrap="false" />
                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                <CommandItemTemplate>
                    <div >
                        <table>
                            <tr>
                                <td> 
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False" CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="true">
                <ClientEvents  OnRowClick="RowClick" />
                <Resizing EnableRealTimeResize="true" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="True" />
                <Selecting AllowRowSelect="true" /></ClientSettings>
            </telerik:RadGrid>
</form>
</body>
</html>
