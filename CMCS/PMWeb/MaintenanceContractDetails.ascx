<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MaintenanceContractDetails.ascx.vb" Inherits="Website.MaintenanceContractDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLinkedWorkOrders">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLinkedWorkOrders" LoadingPanelID="ldpPM"/>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<table>
<tr>
<td>

</td>
<td>


</td>
<td>

</td>
<td rowspan="6" style="width:100%" valign="top" >
<fieldset>
<legend>
    <asp:Label ID="lblLinkedWorkOrder" runat="server" meta:resourcekey="lblLinkedWorkOrder" Text="Linked Work Orders"></asp:Label>
</legend>
<telerik:RadGrid ID="rdgLinkedWorkOrders" runat="server"   HeaderStyle-Font-Size="8" 
                              Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true"   AllowSorting="true" ShowStatusBar="true">
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" EditMode="InPlace">
                    <Columns>                                    
                        <telerik:GridTemplateColumn HeaderText="WO ID" UniqueName="WOID" HeaderStyle-Width="10%" SortExpression="Id" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                        <asp:HyperLink Id="hliId" runat="server"  Text='<%# Eval("Id").Tostring%>' NavigateUrl='<%# "WorkOrders.aspx?Id=" & Cstr(Eval("Id"))%>' ></asp:HyperLink>
                       
                        </ItemTemplate>
                       </telerik:GridTemplateColumn> 
                        <telerik:GridTemplateColumn HeaderText="Scheduled" UniqueName="Scheduled" HeaderStyle-Width="10%" SortExpression="Scheduled">
                        <ItemTemplate>
                        <asp:Label ID="lblScheduled" Text="&nbsp;" runat="server"></asp:Label>    
                        </ItemTemplate> 
                       </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assigned To" HeaderStyle-Width="20%" UniqueName="AssignedTo" SortExpression="AssignedTo">
                           <ItemTemplate>
                              <span><%#IIf(Container.DataItem("AssignedTo") = String.Empty, "&nbsp;", Container.DataItem("AssignedTo"))%></span>     
                       </ItemTemplate>
                       </telerik:GridTemplateColumn>                         
                    </Columns>
                    <CommandItemTemplate>
                        <div style="padding:2px">
                            &nbsp;&nbsp;
                                     <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow"  CssClass="GridCmdInitNewRow" 
                                    SecurityButtonType="ItemMode_Add" 
                                    Visible="true" 
                                    meta:resourcekey="btnAddResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                 &nbsp;&nbsp;
                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                                    SecurityButtonType="ItemMode_Delete" Visible="true" runat="server" CommandName="DeleteRows"
                                    meta:resourcekey="btnDeleteResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                  <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"  SecurityButtonType="ItemMode" 
                    Visible="true" >
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings Resizing-AllowColumnResize="true">
                <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                </ClientSettings>
             </telerik:RadGrid>
</fieldset>

</td>
</tr>
<tr>
<td valign="top" class="NoWrap">
    <asp:Label ID="lblOverview" meta:resourcekey="lblOverview" runat="server" Text="Overview"></asp:Label>
</td>
<td>
    <asp:TextBox ID="txtOverview" MaxLength="500" runat="server" TextMode="MultiLine" Height="82px" 
        Width="287px"></asp:TextBox>
</td>
</tr>
<tr>
<td class="NoWrap">
<asp:Label ID="lblStart"  meta:resourcekey="lblStart" runat="server" Text="Start"></asp:Label>
</td>
<td>
<span runat="server" id="rmd_dtpStart" style="display:block">
<telerik:RadDatePicker ID="dtpStart" Skin="Default" runat="server" SharedCalendarID=""
 MinDate="01-01-1900">
<DateInput ID="DateInput1" runat="server" />
</telerik:RadDatePicker></span>
</td>
</tr>
<tr>
<td class="NoWrap">
<asp:Label ID="lblEnd" meta:resourcekey="lblEnd" runat="server" Text="End"></asp:Label>
</td>
<td>
<span runat="server" id="rmd_dtpEnd" style="display:block">
<telerik:RadDatePicker ID="dtpEnd" Skin="Default" runat="server" SharedCalendarID=""
 MinDate="01-01-1900">
<DateInput ID="DateInput2" runat="server" />
</telerik:RadDatePicker></span>
</td>
</tr>
<tr>
<td class="NoWrap">
<asp:Label ID="lblValue" meta:resourcekey="lblValue" runat="server" Text="Value"></asp:Label>
</td>
<td>
<asp:TextBox ID="txtValue" MaxLength="15" runat="server" CssClass="Currency" Width="120px"></asp:TextBox>
</td>
</tr>
<tr>
<td class="NoWrap">
<asp:Label ID="lblBilling" meta:resourcekey="lblBilling" runat="server" Text="Billing"></asp:Label>
</td>
<td>
<telerik:RadComboBox ID="ddlBilling" runat="server" Width="175px" Skin="Default" AllowCustomText="True"
        Style="font-size: 11px" Height="100px">
  <CollapseAnimation Duration="200" Type="OutQuint" />
 </telerik:RadComboBox>
 </td>
</tr>
</table>