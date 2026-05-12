<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PropertySpaces.ascx.vb" Inherits="Website.PropertySpaces" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
 <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPropertySpaces">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPropertySpaces" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPropertySpaces" runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"  SetWidth="true"  ClientSettings-Scrolling-AllowScroll="true"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="50">
                   <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top">
                   
                    <Columns>
                        <telerik:GridTemplateColumn Uniquename="Building" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px" SortExpression="BuildingCode">
                            <ItemTemplate>
                                 <%#Container.DataItem("BuildingCode") + "-" + Container.DataItem("BuildingName")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn Uniquename="Floor" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" SortExpression="FloorCode">
                            <ItemTemplate>
                                 <%#Container.DataItem("FloorCode") + "-" + Container.DataItem("FloorName")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                                  
                        <telerik:GridTemplateColumn Uniquename="ID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" SortExpression="ID">
                            <ItemTemplate>
                                 <%#Container.DataItem("Id")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn Uniquename="Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" SortExpression="Code">
                            <ItemTemplate>
                                 <%#Container.DataItem("Code")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                   
                        <telerik:GridTemplateColumn Uniquename="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px" SortExpression="Name">
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
                    <ClientEvents OnRowClick="PropertySpacesRowClick" />
                </ClientSettings>
            </telerik:RadGrid>
            
</div>
        </div>
    </div>