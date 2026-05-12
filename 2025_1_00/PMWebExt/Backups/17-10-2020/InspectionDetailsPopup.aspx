<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InspectionDetailsPopup.aspx.vb" Inherits="Website.InspectionDetailsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Inspection Details</title>
    <script>
        function RowClick(sender, eventArgs) {
            var id = eventArgs.getDataKeyValue("Id");
            var lineNumber  = eventArgs.getDataKeyValue("RowNumber")
            window.parent.DrawInspectionPoint(id, lineNumber);
            window.close();
            return false;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <telerik:RadGrid ID="rdgInspectionDetailsPopup" runat="server" SetWidth="true" AppendMenus = "true"
                Skin="Default" AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="10" AllowMultiRowSelection="true"
                AllowPaging="True" AllowMultiRowEdit="true"
                AllowSorting="True" GridLines="None" ShowGroupPanel="false" GroupingEnabled="false">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"  ClientDataKeyNames="Id,RowNumber"
                    CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="100px" UniqueName="LineNumber" AllowFiltering="false"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True">
                            <ItemTemplate>
                                <%#Container.DataItem("RowNumber").ToString%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Asset" AllowFiltering="true" UniqueName="Asset"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Asset"
                            GroupByExpression="Asset [GridColumn_Asset] Group By Asset">
                            <ItemTemplate>
                                <asp:label ID="hliAsset" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                                    Text='<%#IIf(Eval("Asset") Is DBNull.Value OrElse String.IsNullOrEmpty(Eval("Asset")), "", Eval("Asset"))%>'></asp:label>
                            </ItemTemplate>
                            <HeaderStyle Width="180px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Asset Type" SortExpression="AssetType" DataField="AssetType"
                            UniqueName="AssetType" GroupByExpression="AssetType [GridColumn_AssetType] Group By AssetType ASC">
                            <ItemTemplate>
                                <span><%#Container.DataItem("AssetType")%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="180px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description"
                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgInspectionDetailsPopup.EditIndexes.Count = 0 And (Not rdgInspectionDetailsPopup.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                    <ClientEvents OnRowClick="RowClick" />
                </ClientSettings>
            </telerik:RadGrid>

        </div>
    </form>
</body>
</html>
