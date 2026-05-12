<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UnitSpaces.ascx.vb" Inherits="Website.UnitSpaces" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgUnitSpaces">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgUnitSpaces" LoadingPanelID="ldpPM" />
                </UpdatedControls> 
                </telerik:AjaxSetting>         
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
  
    <telerik:RadGrid ID="rdgUnitSpaces" runat="server"   
                    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                    PageSize="250" AllowPaging="true" width="100%"
                    AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true"  InsertItemPageIndexAction="ShowItemOnFirstPage">
                    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="Top" Width="100%">
                                     <Columns>    
                       <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" >
                             <ItemTemplate> 
                            <asp:Label ID="lblProperty" runat="server" Text='<%#iif(Eval("Property")=string.empty,"&nbsp;",Eval("Property"))%>'></asp:Label>
                            </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="Building" HeaderText="Building" > 
                            <ItemTemplate> 
                            <asp:Label ID="lblBuilding" runat="server" Text='<%# iif(Eval("Building")=string.empty,"&nbsp;",Eval("Building")) %>'></asp:Label>
                            </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Floor" UniqueName="Floor" > 
    <ItemTemplate> 
                            <asp:Label ID="lblFloor" runat="server" Text='<%# iif(Eval("Floor")=string.empty,"&nbsp;",Eval("Floor")) %>'></asp:Label>
                            </ItemTemplate>
   </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Space" UniqueName="Space" >
                             <ItemTemplate> 
                            <asp:Label ID="lblSpace" runat="server" Text='<%#iif(Eval("Space")=string.empty,"&nbsp;",Eval("Space")) %>'></asp:Label>
                            </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                         <CommandItemTemplate>
                                    <div style="padding:2px">
                                        &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" OnClientClick="return OpenPOPUp('SelectAsset.aspx?Id=-1',1035, 710,true);">
                                           <span class="Icon"></span>
                                              <asp:Label ID="lblAdd" runat="server" Text="Add Line" ></asp:Label>
                                        </asp:LinkButton>
                                         &nbsp;&nbsp;
                                       <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                            runat="server" CommandName="DeleteRows"  CssClass="GridCmdDeleteRows" >
                                           <span class="Icon"></span>
                                              <asp:Label ID="lblDeleteRows" runat="server" Text="Delete Selected Lines" ></asp:Label>
                                            </asp:LinkButton>
                                            &nbsp;&nbsp;
                                       <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" >
                                          <span class="Icon"></span>
                                             <asp:Label ID="lblRefresh" runat="server" Text="Refresh" ></asp:Label></asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                    </MasterTableView>
                    <ClientSettings 
                        AllowDragToGroup="true"  Resizing-AllowColumnResize="true">
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                </telerik:RadGrid>
    
    