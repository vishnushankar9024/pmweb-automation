<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalApplications.ascx.vb" Inherits="Website.VendorApprovalApplications" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="rampApplications" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgApplications">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgApplications" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadGrid ID="rdgApplications" runat="server"  SetWidth="true"  AutoGenerateColumns="False" ShowStatusBar="True" CssClass="WithoutTopBorder"
    ShowFooter="false" AllowPaging="true" PageSize="10" ShowGroupPanel="true" AllowMultiRowEdit="False" AllowMultiRowSelection="False" 
    AllowSorting="True" ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8"  >
    
    <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"   
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
        EnableHeaderContextMenu="true">
    
             <Columns>    
                <telerik:GridTemplateColumn UniqueName="ApplicationID"  ItemStyle-Wrap="false" HeaderText="Application ID" 
                    SortExpression="ApplicationID" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="ApplicationID [GridColumn_ApplicationID] Group By ApplicationID ASC"> 
                    <ItemTemplate> 
                        <asp:Label ID="lblApplicationID" runat="server" Text='<%# iif(Eval("ApplicationID")=string.empty,"&nbsp;",Eval("ApplicationID")) %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Application Year"  ItemStyle-Wrap="false" UniqueName="ApplicationYear"
                            SortExpression="Year" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Year [GridColumn_ApplicationYear] Group By Year ASC" > 
                    <ItemTemplate> 
                        <asp:Label ID="lblYear" runat="server" Text='<%# Eval("Year") %>' ></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Submitted"  ItemStyle-Wrap="false" UniqueName="Submitted" DataField ="Submitted"
                            SortExpression="Submitted" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Submitted [GridColumn_Submitted] Group By Submitted ASC" >
                    <ItemTemplate> 
                        <asp:Label ID="lblSubmitted" runat="server" Text='<%# FormatDate(Eval("Submitted")) %>'></asp:Label>
                     </ItemTemplate>
                    <HeaderStyle Width="150px" />
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Width="75px"   ItemStyle-Wrap="false"  HeaderText="Status" UniqueName="Status"
                            SortExpression="DocStatusId" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="DocStatusId [GridColumn_Status] Group By DocStatusId ASC">
                    <ItemTemplate> 
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("WorkflowStatus") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="75px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Width="220px" ItemStyle-Wrap="false"  HeaderText="Approval Starts" UniqueName="ApprovalStarts" DataField ="Approval_Starts"
                            SortExpression="Approval_Starts" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Approval_Starts [GridColumn_ApprovalStarts] Group By Approval_Starts ASC" >
                    <ItemTemplate> 
                        <asp:Label ID="lblApprovalStarts" runat="server" Text='<%# FormatDate(Eval("Approval_Starts")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="150px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Width="220px"   ItemStyle-Wrap="false"  HeaderText="Approval Expiress" UniqueName="ApprovalExpires" DataField ="Approval_Expires"
                            SortExpression="Approval_Expires" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true"   
                            Groupable="true" Reorderable="true"  GroupByExpression="Approval_Expires [GridColumn_ApprovalExpires] Group By Approval_Expires ASC" >
                    <ItemTemplate> 
                        <asp:Label ID="lblApprovalExpires" runat="server" Text='<%# FormatDate(Eval("Approval_Expires")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    <HeaderStyle Width="150px" />
                </telerik:GridTemplateColumn>
            </Columns>
            <CommandItemTemplate>
                <div style="padding:2px">
                    
                    <asp:LinkButton ID="btnEdit" runat="server" CausesValidation="false" CommandName="EditRow" CssClass="GridCmdEditRow" >
                        <span class="Icon"></span>
                         <asp:Label ID="lblEdit" runat="server" Text="Open Selected Line" ></asp:Label>
                   </asp:LinkButton>
                </div>  
            </CommandItemTemplate>
    </MasterTableView>
    <ClientSettings AllowDragToGroup="true"  Resizing-AllowColumnResize="true" >
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" UseClientSelectColumnOnly="true" />
    </ClientSettings>
    </telerik:RadGrid>
