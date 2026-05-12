<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="GroupsV2.ascx.vb" Inherits="Website.GroupsV2" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>    
        <telerik:AjaxSetting AjaxControlID="btnSave" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>    
        <telerik:AjaxSetting AjaxControlID="btnCancel" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>      
        <telerik:AjaxSetting AjaxControlID="btnDelete" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="pnlRights" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<telerik:RadAjaxLoadingPanel ID="ldpGroups" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
<![if !IE]>
    <style type="text/css">
         p {Display:none  !important; }
     </style>
<![endif]>
<div style="overflow:auto; width:100%; text-align:left;">
     <telerik:RadGrid ID="rdgGroups" runat="server"   CssClass="WithoutTopBorder"
            AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
            PageSize="10" AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="false" 
            AllowSorting="true" >
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage">
             <Columns> 
               
                <telerik:GridTemplateColumn HeaderText="Group"  UniqueName="Group" >
                    <ItemTemplate>
                         <%#IIf(Container.DataItem("Group") = String.Empty, "&nbsp;", Container.DataItem("Group"))%>
                    </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                        <HeaderStyle Wrap="false" Width="20%" HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>    
               
               <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                    <ItemTemplate>
                         <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                    </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                        <HeaderStyle Wrap="false" Width="50%" HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>   
               
               <telerik:GridTemplateColumn HeaderText="Guest" UniqueName="Guest">
                    <ItemTemplate>
                         <img src="Images/Global/<%#CStr(IIF(Eval("IsGuest"),"checked.png" , "unchecked.png"))%>" />
                    </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                        <HeaderStyle Wrap="false" Width="15%" HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>   
               
               <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default">
                    <ItemTemplate>
                         <img src="Images/Global/<%#CStr(IIF(Eval("IsDefault"),"checked.png" , "unchecked.png"))%>" />
                    </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                        <HeaderStyle Wrap="false" Width="15%" HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>     
               
            </Columns>
            <SortExpressions>
                <telerik:GridSortExpression FieldName="Group"></telerik:GridSortExpression>
            </SortExpressions>
            <CommandItemStyle HorizontalAlign="Left" />
            <CommandItemTemplate >
                <div style="padding:2px">
                                  
                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow" 
                        SecurityButtonType="ItemMode_Add"
                        CommandName="InitNewRow" Visible='<%# rdgGroups.EditIndexes.Count = 0 AND (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label runat="server" ID="lblAddLine" Text="Add line"></asp:Label>
                    </asp:LinkButton>
            
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid" 
                        SecurityButtonType="ItemMode"
                        CommandName="RebindGrid" Visible='<%# rdgGroups.EditIndexes.Count = 0 AND (Not rdgGroups.MasterTableView.IsItemInserted) %>'>
                        <span class="Icon"></span>
                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                       
                    </asp:LinkButton>
                </div>
            </CommandItemTemplate>
            
        </MasterTableView>
        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true"
            Resizing-AllowColumnResize="true">
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
        </ClientSettings>
    </telerik:RadGrid>
    <br />   
    <asp:panel ID="pnlRights" runat="server" Width="100%" style="display:none" > 
    <table style="width:100%; text-align:left; margin-top:10px;" cellspacing="2"> 
        <tr>
            <td style="width:5%;">
                <asp:Label ID="lblGroup" meta:resourcekey="lblGroup" runat="server" Text="Group*"></asp:Label>
            </td>
            <td style="width:20%;">
                <asp:TextBox ID="txtGroup" MaxLength="100" Width="170px" runat="server" Columns="25"></asp:TextBox>
                 <asp:Label ID="lblGroupUnique" meta:resourcekey="lblGroupUnique" Text="<br>Each group must have a unique name." runat="server" CssClass="Validator" Visible="false"></asp:Label>
            </td>
            <td style="width:8%;">
                <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description*"></asp:Label>
            </td>
            <td style="width:47%;">
                <asp:TextBox ID="txtDescription" MaxLength="255" Width="250px" runat="server" Columns="70"></asp:TextBox>
            </td>
            <td style="width:10%;">
                <asp:CheckBox ID="chkIsGuest" runat="server" Text="Guest" meta:resourcekey="chkIsGuest" onclick="chkIsGuest_Click(this);"/>
            </td>
            <td style="width:10%;">
                <asp:CheckBox ID="chkIsDefault" runat="server" Text="Default" meta:resourcekey="chkIsDefault" />
            </td>
        </tr>
        <tr valign="top">
            <td></td>
            <td valign="top">
                <asp:RequiredFieldValidator ID="rfvGroup" meta:Resourcekey="rfvGroup" runat="server"
                    ControlToValidate="txtGroup" CssClass="Validator" ErrorMessage="Enter the Group"
                    Display="Dynamic" ForeColor="" ValidationGroup="GroupRight"></asp:RequiredFieldValidator>
            </td>
            <td></td>
            <td>
                <asp:RequiredFieldValidator ID="rfvDescription" meta:resourcekey="rfvDescription"
                    runat="server" ControlToValidate="txtDescription" CssClass="Validator" ErrorMessage="Enter the Description"
                    Display="Dynamic" ForeColor="" ValidationGroup="GroupRight"></asp:RequiredFieldValidator>
            </td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td style="height:10px;" colspan="6">
            </td>
        </tr>
        <tr>
            <td colspan="6" style="padding-right:1px;">  
                
            </td> 
        </tr>
        <tr>
            <td style="height:10px;" colspan="6">
            </td>
        </tr>        
        <tr>
            <td colspan="6" style="padding-right:1px;">
                <asp:GridView ID="gvMiscellaneousPermission" runat="server" ShowFooter="false" ShowHeader="false"
                    AutoGenerateColumns="False" DataKeyNames="MiscellaneousPermissionId" GridLines="None" BorderStyle="None">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdnMiscellaneousPermission" runat="server"
                                    Value='<%# Eval("MiscellaneousPermissionId") %>' />
                                       <asp:HiddenField ID="hdnMiscellaneousKey" runat="server"
                                    Value='<%# Eval("MiscellaneousPermissionKey") %>' />
                                <asp:CheckBox ID="chkMiscellaneousPermission"  runat="server" Checked='<%# Eval("MiscellaneousPermissionChecked") %>'
                                    Text='<%# GetLocalResourceObject("MiscPermission_" + Eval("MiscellaneousPermissionKey")) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="height:10px;" colspan="6">
            </td>
        </tr>
        <tr>
            <td align="right" style="padding-right:3px;" colspan="6">
                <asp:Button ID="btnSave" meta:Resourcekey="btnSave" runat="server" Text="Save" Style="margin-right: 10px;"
                    ValidationGroup="GroupRight" />
                <asp:Button ID="btnDelete" meta:Resourcekey="btnDelete" runat="server" Text="Delete"
                    Style="margin-right: 10px;" />
                <asp:Button ID="btnCancel" meta:Resourcekey="btnCancel" runat="server" Text="Cancel" />
            </td>
        </tr>
    </table>
    </asp:panel>

</div>