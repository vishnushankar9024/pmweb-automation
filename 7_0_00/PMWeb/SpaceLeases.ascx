<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SpaceLeases.ascx.vb" Inherits="Website.SpaceLeases" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamSpaceLeases" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgSpaceLeases">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgSpaceLeases" LoadingPanelID="ldpPM" />
                
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
   <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
<telerik:RadAjaxLoadingPanel ID="ldpEquipmentMove" runat="server" Skin="Default" />
            <telerik:RadGrid ID="rdgSpaceLeases" AllowMultiRowSelection="true"  runat="server" Width="100%"  SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                 ShowGroupPanel ="true"  HeaderStyle-Font-Size="8"  CssClass="WithoutTopBorder"
                AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="15">
                  <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
               
                    <Columns>
                    
               <telerik:GridTemplateColumn SortExpression ="Description" HeaderText="Lease" GroupByExpression="Description [GridColumn_Lease] Group By Description"
                    UniqueName="Lease"  >
                    <ItemTemplate>
                    <asp:HyperLink ID="hliLease" runat="server" CssClass="NoWrap,Link"
                     Text='<%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>'
                      NavigateUrl='<%# CStr(Container.DataItem("LeaseUrl"))%>'></asp:HyperLink> &nbsp;
                    </ItemTemplate>
                    <HeaderStyle Width="130px" />
                    <ItemStyle  Wrap ="false " />                      
           
                </telerik:GridTemplateColumn>
                
                        <telerik:GridTemplateColumn HeaderText="Start"  SortExpression="LeaseStartDate" UniqueName="LeaseStartDate" DataField="LeaseStartDate" GroupByExpression="LeaseStartDate [GridColumn_LeaseStartDate] Group By LeaseStartDate">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("LeaseStartDate"))%>&nbsp;</span>
                            </ItemTemplate>
                       <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="115px"  ></HeaderStyle>
                 </telerik:GridTemplateColumn>
                 
                           <telerik:GridTemplateColumn HeaderText="Finish"  SortExpression="LeaseFinishDate" UniqueName="LeaseFinishDate" DataField="LeaseFinishDate" GroupByExpression="LeaseFinishDate [GridColumn_LeaseFinishDate] Group By LeaseFinishDate">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("LeaseFinishDate"))%>&nbsp;</span>
                            </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="115px"  ></HeaderStyle>
                 </telerik:GridTemplateColumn>
                 
                 
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                        <table style="display:inline;padding: 0px; border: 0px transparent none; height: 15px; width:100%;" cellpadding="0"
                            cellspacing="0">
                        <tr>
                        <td>
                           
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  SecurityButtonType="ItemMode" 
                                Visible='<%# rdgSpaceLeases.EditIndexes.Count = 0 AND (Not rdgSpaceLeases.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                            </asp:LinkButton>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <telerik:RadComboBox ID="ddlLeaseStatus" AutoPostBack="true" AllowCustomText="false" SecurityButtonType="ItemMode" 
                                runat="server"   CloseDropDownOnBlur="true" OnSelectedIndexChanged="ddlLeaseStatus_SelectedIndexChanged"
                                 NoWrap="true" ShowToggleImage="true">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                <Items>
                                    <telerik:RadComboBoxItem Text="All leases" Value="ALL" Selected="true" meta:resourcekey="ddlLeaseStatus_ALL" />
                                    <telerik:RadComboBoxItem Text="Current leases only" Value="CURRENT" meta:resourcekey="ddlLeaseStatus_CURRENT" />
                                    <telerik:RadComboBoxItem Text="Past leases only" Value="PAST" meta:resourcekey="ddlLeaseStatus_PAST" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        </tr>
                        <td>
                        
                           </td>
                        </table></div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                </ClientSettings>
            </telerik:RadGrid>
    
 <telerik:RadAjaxPanel ID="occupantPanel" runat="server" Height="100%" Width="100%">
 </telerik:RadAjaxPanel>