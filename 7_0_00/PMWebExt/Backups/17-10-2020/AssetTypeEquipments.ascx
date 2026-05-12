<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AssetTypeEquipments.ascx.vb" Inherits="Website.AssetTypeEquipments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAssetTypeEquipments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAssetTypeEquipments" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgAssetTypeEquipments" runat="server"   HeaderStyle-Font-Size="8"  CssClass="WithoutTopBorder" SetWidth="true" MasterTableView-AllowSorting="true"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="15">
                <PagerStyle Mode="NextPrevAndNumeric"
                     AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" AllowCustomPaging="true"  CommandItemDisplay="Top">
                   
                    <Columns>                                    
                        <telerik:GridTemplateColumn Uniquename="RecordNumber" HeaderStyle-HorizontalAlign="Center"  ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="200px" SortExpression="RecordNumber">
                            <ItemTemplate>
                                 <%#Container.DataItem("RecordNumber").ToString%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                
                        <telerik:GridTemplateColumn Uniquename="Description" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="400px" SortExpression="Description">
                            <ItemTemplate>
                                 <%#Container.DataItem("Description")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                            
                    </Columns>
                     <CommandItemTemplate>
                  <div style="padding: 2px">
                   <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid"
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
                    <ClientEvents OnRowClick="AssetEquipmentRowClick" />
                </ClientSettings>
            </telerik:RadGrid>
            
</div>
        </div>
    </div>