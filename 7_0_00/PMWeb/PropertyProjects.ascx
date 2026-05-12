<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PropertyProjects.ascx.vb" Inherits="Website.PropertyProjects" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
 <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>      
        <telerik:AjaxSetting AjaxControlID="rdgPropertyProjects">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPropertyProjects" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                                  
    </AjaxSettings>      
</telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPropertyProjects"  runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" SetWidth="true"  ClientSettings-Scrolling-AllowScroll="true"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="50">
                <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                     DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top">
                   
                    <Columns>                                    
                        <telerik:GridTemplateColumn Uniquename="ID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" SortExpression="ID">
                            <ItemTemplate>
                                 <%#Container.DataItem("Id")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn Uniquename="ProjectNumber" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" SortExpression="ProjectNumber">
                            <ItemTemplate>
                                 <%#Container.DataItem("ProjectNumber")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                   
                        <telerik:GridTemplateColumn Uniquename="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px" SortExpression="ProjectName">
                            <ItemTemplate>
                                 <%#Container.DataItem("ProjectName")%>
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
                    <ClientEvents OnRowClick="AssetPropertyProjectsRowClick" />
                </ClientSettings>
            </telerik:RadGrid>
            
</div>
        </div>
    </div>