<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LocationProgramsLocations.ascx.vb"
    Inherits="Website.LocationProgramsLocations" %>


<telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLocations">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLocations" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshDocumentGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLocations" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnRefreshDocumentGrid" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>



<telerik:RadGrid ID="rdgLocations" runat="server"  
    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" PageSize="10" CssClass="WithoutTopBorder"
    AllowPaging="true" AllowFilteringByColumn="true" AllowMultiRowEdit="false" AllowMultiRowSelection="false"
    AllowSorting="true" ShowGroupPanel="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
    <PagerStyle Mode="NextPrevAndNumeric" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Location Code" CurrentFilterFunction="Contains"
                UniqueName="Code" DataField="Code" AutoPostBackOnFilter="true"
                SortExpression="Code" DataType="System.String" FilterListOptions="VaryByDataType"
                GroupByExpression="Code [GridColumn_Code] Group By Code ASC">
                <ItemTemplate>
                    <a class="Link" href="<%#Me.GetUrlByObjectType(Library.PmAsset.PropertyInfo.OBJECT_TYPE_NAME,Container.DataItem("Id") ) %>">
                        <%# Container.DataItem("Code")%></a>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
                <HeaderStyle Width="120px" HorizontalAlign="Center" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Location Name" CurrentFilterFunction="Contains"
                SortExpression="Name" UniqueName="Name" DataField="Name"
                GroupByExpression="Name [GridColumn_Name] Group By Name ASC"
                AutoPostBackOnFilter="true" DataType="System.String" FilterListOptions="VaryByDataType">
                <ItemTemplate>
                    <span>
                        <%# Container.DataItem("Name")%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
                <HeaderStyle Width="160px" HorizontalAlign="Center" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Location Type" CurrentFilterFunction="Contains"
                UniqueName="Type" SortExpression="Type" DataField="Type" AutoPostBackOnFilter="true"
                GroupByExpression="Type [GridColumn_Type] Group By Type ASC" DataType="System.String">
                <ItemTemplate>
                    <span>
                        <%# IIf(IsDBNull(Container.DataItem("Type")), "&nbsp;", Container.DataItem("Type"))%></span>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
                <HeaderStyle Width="200px" HorizontalAlign="Center" />
            </telerik:GridTemplateColumn>
        </Columns>
        <SortExpressions>
            <telerik:GridSortExpression FieldName="Code"></telerik:GridSortExpression>
        </SortExpressions>
        <CommandItemTemplate>
            <div style="padding: 2px">
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows" 
                    CommandName="EditRows" Visible='<%# rdgLocations.EditIndexes.Count = 0 AND (Not rdgLocations.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow" 
                    CommandName="InitNewRow" Visible='<%# rdgLocations.EditIndexes.Count = 0 AND (Not rdgLocations.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                    Visible='<%# rdgLocations.EditIndexes.Count = 0 AND (Not rdgLocations.MasterTableView.IsItemInserted) %>'
                    SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                   <span class="Icon"></span>
                    <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid" 
                    CommandName="RebindGrid" Visible='<%# rdgLocations.EditIndexes.Count = 0 AND (Not rdgLocations.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings EnableRowHoverStyle="true" ClientEvents-OnRowDblClick="RowDblClick"
        AllowDragToGroup="True" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
    </ClientSettings>
    <%-- <ValidationSettings ValidationGroup="Users" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />--%>
</telerik:RadGrid>
<asp:Button runat="server" ID="btnRefreshDocumentGrid" CssClass="Hide" />
