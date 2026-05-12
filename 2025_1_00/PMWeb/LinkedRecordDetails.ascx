<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinkedRecordDetails.ascx.vb"
    Inherits="Website.LinkedRecordDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxPanel ID="pnlLinkedRecords" runat="server">
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgLinkedRecords">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="pnlLinkedRecords" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

    <telerik:RadGrid ID="rdgLinkedRecords" runat="server"  SetWidth="true" AppendMenus="true" FitParentContainer="true" CssClass="LightWeight "
         AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250"
        AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="True"
        AllowSorting="False" GridLines="None">
        <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
        <HeaderContextMenu   EnableViewState="false">
        </HeaderContextMenu>
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" ClientDataKeyNames="Id,Url" CommandItemDisplay="Top" InsertItemDisplay="Top"
            UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
            EnableHeaderContextMenu="true" TableLayout="Fixed">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-HorizontalAlign="Right"
                    UniqueName="Description" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                        <div><%#IIf(Container.DataItem("Description") Is System.DBNull.Value, "&nbsp;", Container.DataItem("Description"))%>&nbsp;</div>
                    </ItemTemplate>
                    <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Wrap ="false"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Rev." ItemStyle-HorizontalAlign="Right"
                    UniqueName="Revision" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                        <%# Container.DataItem("Revision")%>
                    </ItemTemplate>
                    <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-HorizontalAlign="Right"
                    UniqueName="Date" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                       <asp:Label ID="lblDate" Text="" runat="server" ></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-HorizontalAlign="Left"
                    UniqueName="Type" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                    </ItemTemplate>
                    <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                </telerik:GridTemplateColumn>
            </Columns>
            <EditFormSettings>
                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                    CancelImageUrl="Cancel.gif">
                </EditColumn>
            </EditFormSettings>
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnAddLink" CommandName="AddLink" runat="server" CausesValidation="False" CssClass="GridCmdAddLink" 
                        SecurityButtonType="ItemMode_Add" OnClientClick="return OpenLinkRecordsPopup();" >
                        <span class="Icon"></span>
                        <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                    </asp:LinkButton>
                     
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"  CssClass="GridCmdRebindGrid"  SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
                 </asp:LinkButton>
                    <asp:LinkButton ID="btnDeleteLink" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteLink" 
                        SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteLink">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="false" Resizing-AllowColumnResize="true">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
         <ClientEvents  OnRowDblClick="GoToDocument" />
        </ClientSettings>
    </telerik:RadGrid>
            

     <asp:Button Id="btnRefreshLinkRecords" runat="server"  CssClass="Hide"  />
</telerik:RadAjaxPanel>
