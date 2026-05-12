<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="SharePointIntegration.aspx.vb" Inherits="Website.SharePointIntegration" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>
      </AjaxSettings>
</telerik:RadAjaxManagerProxy>


 <telerik:RadAjaxLoadingPanel ID="ldpSharePoint" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>

<table style="width: 100%;" cellpadding="0" cellspacing="0" >
    <tr>
        <td>
           <table style="width: 100%;" cellpadding="3" cellspacing="0" >
            <tr class="ToolBar">
                <td width="150px"><b><asp:Label ID="lblSharePoint" meta:Resourcekey="lblSharePoint" runat="server" Text="SharePoint Integration"></asp:Label></b></td>
                <td>
                     <asp:LinkButton ID="imgHelp" runat="server" CausesValidation="False"  CssClass="HelpButton" >
                            <span class="Icon"></span>  
                            </asp:LinkButton>          
                <telerik:RadToolTip ID="rtlHelp" runat="server" RelativeTo="Element" Height="60px"  meta:resourcekey="rtlHelp"
                Text="(*)PMWeb SharePoint Integration works with both Forms- and Windows-authenticated SharePoint Sites.<br/>In order to use Form-authentication, PMWeb's application server needs access to http://SharepointServer/_vti_bin/Authentication.asmx Web Service." 
                TargetControlID="imgHelp" IsClientID="true"
                Position="BottomCenter" EnableAriaSupport="true" EnableShadow="true"  HideEvent="LeaveToolTip" >
            </telerik:RadToolTip>
                </td>
             </tr>
            </table>
        </td>
    </tr>
     <tr>
        <td style="height:8px">
            <table width="750px" id="tblMain" runat="server" cellpadding="0" cellspacing="0" >  
                <tr>
                    <td colspan="2">
                        <telerik:RadGrid ID="rdgUsers" runat="server"   HeaderStyle-Font-Size="8" UseEditFormInMobile="true"
                            AutoGenerateColumns="False" ShowStatusBar="true" Width="750px" PageSize="30" AllowPaging="True"
                            AllowMultiRowEdit="True" AllowMultiRowSelection="true" >
                           <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"/>
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                <Columns>
                                       <telerik:GridTemplateColumn HeaderText="PMWeb User" UniqueName="PMWebUser">
                                            <ItemTemplate>
                                                <%#Container.DataItem("PMWebUser")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <%#Container.DataItem("PMWebUser")%>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="300px" />
                                        </telerik:GridTemplateColumn>
                                        
                                       <telerik:GridTemplateColumn HeaderText="SharePoint Username" UniqueName="SharePointUsername">
                                            <ItemTemplate>
                                                <%#IIF(Container.DataItem("SharePointUsername") = String.Empty ,"&nbsp;",Container.DataItem("SharePointUsername"))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtSharePointUsername" MaxLength="500" runat="server" Text='<%#Eval("SharePointUsername")%>' Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        
                                       <telerik:GridTemplateColumn HeaderText="SharePoint Password" UniqueName="SharePointPassword">
                                            <ItemTemplate>
                                                <%#IIF(Container.DataItem("SharePointPassword").Length = 0 ,"&nbsp;","***")%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtSharePointPassword" TextMode="Password" MaxLength="500" runat="server" Text="***" Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        
                                       <telerik:GridTemplateColumn HeaderText="Domain" UniqueName="SharePointDomain">
                                            <ItemTemplate>
                                                <%#IIF(Container.DataItem("SharePointDomain") = String.Empty ,"&nbsp;",Container.DataItem("SharePointDomain"))%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtSharePointDomain" MaxLength="500" runat="server" Text='<%#Eval("SharePointDomain")%>' Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        
                                </Columns>             
                                <SortExpressions>
                            </SortExpressions>
                            <CommandItemTemplate>
                                <div style="padding:2px">
                                   
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit"
                                        CommandName="EditRows" CssClass="GridCmdEditRows"  Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                       <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>                        
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" 
                                        SecurityButtonType="AddEditMode_Edit"
                                        CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgUsers.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" 
                                        SecurityButtonType="AddEditMode_Add"
                                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgUsers.MasterTableView.IsItemInserted %>'>
                                      <span class="Icon"></span>
                                        <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" 
                                        SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll"  Visible='<%# rdgUsers.EditIndexes.Count > 0 Or rdgUsers.MasterTableView.IsItemInserted %>'>
                                       <span class="Icon"></span>
                                        <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnClear" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Delete"
                                        Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="ClearRows" CssClass="GridCmdClearRows">
                                  <span class="Icon"></span>
                                        <asp:Label runat="server" Text="Clear selected lines" ID="lblClear" meta:resourcekey="lblClear"></asp:Label>&nbsp;&nbsp;</asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnCopyUsernames" CausesValidation="false"
                                        SecurityButtonType="ItemMode_Edit"
                                        Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                        runat="server" CommandName="CopyUsernames" CssClass="GridCmdCopyUsernames" >
                                       <span class="Icon"></span>
                                        <asp:Label runat="server" Text="Copy Usernames" ID="lblCopyUsernames" meta:resourcekey="lblCopyUsernames"></asp:Label>&nbsp;&nbsp;</asp:LinkButton>
                                        
                                   <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgUsers.EditIndexes.Count = 0 AND (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                       <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>   
                                     </asp:LinkButton>
                                    
                                </div>
                            </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings EnableRowHoverStyle="true" AllowRowsDragDrop="False">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                         AllowColumnResize="True"></Resizing>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</asp:Content>
