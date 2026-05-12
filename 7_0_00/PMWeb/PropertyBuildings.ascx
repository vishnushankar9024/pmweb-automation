<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PropertyBuildings.ascx.vb" Inherits="Website.PropertyBuildings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPropertyBuildings">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPropertyBuildings" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPropertyBuildings" runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
                 AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="50" SetWidth="true"  ClientSettings-Scrolling-AllowScroll="true" >
                  <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id"  CommandItemDisplay="Top" >
                   
                    <Columns>                                    
                        <telerik:GridTemplateColumn  UniqueName="ID"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" SortExpression="ID">
                            <ItemTemplate>
                                 <%#Container.DataItem("Id")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" SortExpression="Code">
                            <ItemTemplate>
                                 <%#Container.DataItem("Code")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                   
                        <telerik:GridTemplateColumn  UniqueName="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px" SortExpression="Name">
                            <ItemTemplate>
                                 <%#Container.DataItem("Name")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                   
                    </Columns>
                  <CommandItemTemplate>
                  <div style="padding: 2px">
                   <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                    Visible="true">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                  </div>
                  </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="true" Resizing-AllowColumnResize="true" >
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
                    <ClientEvents OnRowClick="PropertyBuildingsRowClick" />
                </ClientSettings>
            </telerik:RadGrid>
            
</div>
        </div>
    </div>