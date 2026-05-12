<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectCompanies.ascx.vb" Inherits="Website.ProjectCompanies" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="rmProjectCompanies" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCompanies">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCompanies" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
 <telerik:RadGrid ID="rdgCompanies" AllowMultiRowSelection="true"  runat="server"  FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
       HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" CssClass="WithoutTopBorder"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true"  ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="250" >
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>
                     
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">

                <Columns>
                    <telerik:GridTemplateColumn HeaderText="Company Code" UniqueName="CompanyCode" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="CompanyCode" AutoPostBackOnFilter="true"
                        SortExpression="CompanyCode" GroupByExpression="CompanyCode [GridColumn_CompanyCode] Group By CompanyCode ASC">
                        <ItemTemplate>
                            <span> <%#IIf(Container.DataItem("CompanyCode").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyCode").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                        
                    <telerik:GridTemplateColumn HeaderText="Company Name" UniqueName="CompanyName" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="CompanyName" AutoPostBackOnFilter="true"
                        SortExpression="CompanyName" GroupByExpression="CompanyName [GridColumn_CompanyName] Group By CompanyName ASC">
                        <ItemTemplate>
                            <span> <%#IIf(Container.DataItem("CompanyName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Address 1" UniqueName="Address1" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="Address1" AutoPostBackOnFilter="true"
                        SortExpression="Address1" GroupByExpression="Address1 [GridColumn_Address1] Group By Address1 ASC">
                        <ItemTemplate>
                            <span> <%# IIf(Container.DataItem("Address1").ToString = String.Empty, "&nbsp;", Container.DataItem("Address1").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Address 2" UniqueName="Address2" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="Address2" AutoPostBackOnFilter="true"
                        SortExpression="Address2" GroupByExpression="Address2 [GridColumn_Address2] Group By Address2 ASC">
                        <ItemTemplate>
                            <span> <%# IIf(Container.DataItem("Address2").ToString = String.Empty, "&nbsp;", Container.DataItem("Address2").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="City" UniqueName="City" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="City" AutoPostBackOnFilter="true"
                        SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City ASC">
                        <ItemTemplate>
                            <span> <%# IIf(Container.DataItem("City").ToString = String.Empty, "&nbsp;", Container.DataItem("City").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn HeaderText="State" UniqueName="State" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="State" AutoPostBackOnFilter="true"
                        SortExpression="State" GroupByExpression="State [GridColumn_State] Group By State ASC">
                        <ItemTemplate>
                            <span> <%# IIf(Container.DataItem("State").ToString = String.Empty, "&nbsp;", Container.DataItem("State").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Zip" UniqueName="Zip" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="Zip" AutoPostBackOnFilter="true"
                        SortExpression="Zip" GroupByExpression="Zip [GridColumn_Zip] Group By Zip ASC">
                        <ItemTemplate>
                            <span> <%# IIf(Container.DataItem("Zip").ToString = String.Empty, "&nbsp;", Container.DataItem("Zip").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Country" UniqueName="Country" HeaderStyle-Width="150px" CurrentFilterFunction="Contains" DataField="Country" AutoPostBackOnFilter="true"
                        SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country ASC">
                        <ItemTemplate>
                            <span> <%# IIf(Container.DataItem("Country").ToString = String.Empty, "&nbsp;", Container.DataItem("Country").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="Phone" UniqueName="Phone" HeaderStyle-Width="100px" CurrentFilterFunction="Contains" DataField="Phone" AutoPostBackOnFilter="true"
                        SortExpression="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone ASC">
                            <ItemTemplate>
                                 <span> <%#IIf(Container.DataItem("Phone").ToString = String.Empty, "&nbsp;", Container.DataItem("Phone").ToString)%></span>
                            </ItemTemplate>
                    </telerik:GridTemplateColumn>
                        
                    <telerik:GridTemplateColumn HeaderText="Ext" UniqueName="Ext" HeaderStyle-Width="100px" CurrentFilterFunction="Contains" DataField="Ext" AutoPostBackOnFilter="true"
                        SortExpression="Ext" GroupByExpression="Ext [GridColumn_Ext] Group By Ext ASC">
                        <ItemTemplate>
                            <span> <%#IIf(Container.DataItem("Ext").ToString = String.Empty, "&nbsp;", Container.DataItem("Ext").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                        
                    <telerik:GridTemplateColumn HeaderText="Fax" UniqueName="Fax" HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="Fax" AutoPostBackOnFilter="true"
                        SortExpression="Fax" GroupByExpression="Fax [GridColumn_Fax] Group By Fax ASC">
                        <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Fax").ToString = String.Empty, "&nbsp;", Container.DataItem("Fax").ToString)%></span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn> 
                        
                    <telerik:GridTemplateColumn HeaderText="Email" UniqueName="Email" HeaderStyle-Width="20%" CurrentFilterFunction="Contains" DataField="Email" AutoPostBackOnFilter="true"
                        SortExpression="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC">
                            <ItemTemplate>
                                <span> <%#IIf(Container.DataItem("Email").ToString = String.Empty, "&nbsp;", Container.DataItem("Email").ToString)%></span>
                            </ItemTemplate>
                    </telerik:GridTemplateColumn>          
                </Columns>
                <FooterStyle CssClass="GridFooter" />
                <CommandItemTemplate>
                    <div style="padding:2px">
                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow" 
                            CommandName="InitNewRow" OnClientClick="return OpenPOPUp('ProjectCompaniesPopup.aspx',950, 506,true);"
                            Visible='<%# rdgCompanies.EditIndexes.Count = 0 And (Not rdgCompanies.MasterTableView.IsItemInserted)%>' meta:resourcekey="btnAddResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                            Visible='<%# rdgCompanies.EditIndexes.Count = 0 And (Not rdgCompanies.MasterTableView.IsItemInserted)%>' runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                            <span class="Icon"></span>
                            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid" 
                            Visible='<%# rdgCompanies.EditIndexes.Count = 0 And (Not rdgCompanies.MasterTableView.IsItemInserted)%>' meta:resourcekey="btnRefreshResource1">
                           <span class="Icon"></span>
                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="True" AllowColumnHide="true" >
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="true"  />
                    <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true" AllowColumnResize="True"></Resizing>
                </ClientSettings>
</telerik:RadGrid>