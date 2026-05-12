<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ApplicationAttachments.ascx.vb" Inherits="Website.ApplicationAttachments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxAttachment1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAttachments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAttachments" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
<script type="text/javascript">
    function BindFileAttachement() {
        $("input[id$=rdbUpload]").click(function() { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
    }
</script>
</telerik:RadScriptBlock>


<fieldset style="width:100%;" id="fldtest" runat="server">
<legend><asp:Label ID="lblAttachments" runat="server" meta:resourcekey="lblAttachments" Text="Attachments"></asp:Label></legend>

<%--<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">--%>
<telerik:RadProgressManager ID="RadProgressManager1" runat="server" />

<telerik:RadGrid ID="rdgAttachments" runat="server"   AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True"  GroupingEnabled="false" Width="100%"
                       ItemStyle-Height="20px" GridLines="None" HeaderStyle-Font-Size="8">
    
    <HeaderContextMenu  EnableViewState="false"></HeaderContextMenu>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" 
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" 
                        EditMode="InPlace" EnableHeaderContextMenu="true">
        
        <Columns>    
            <telerik:GridTemplateColumn HeaderStyle-Width="90px" UniqueName="Description"  ItemStyle-Wrap="false" HeaderText="Description" > 
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" MaxLength="100" runat="server" Text='<%# Eval("Description") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="250px" HeaderText="File"  ItemStyle-Wrap="false" UniqueName="File" > 
                <ItemTemplate> 
                    <asp:HyperLink ID="hplDownload" runat="server" CausesValidation="false" Style="text-decoration: underline;
                                    cursor: hand;" Text='' ToolTip="<%$ Resources:PMWeb, Download %>">
                    </asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:FileUpload ID="FileToUpload" runat="server" Width="180px" />
                    <telerik:RadUpload ID="FileToUpload1" runat="server" CssClass="Hide" Skin="Default" ControlObjectsVisibility="none"
                                                    MaxFileInputsCount="1" Visible="true" Width="300px">
                        <Localization Add="<%$ Resources:PMWeb, RadUploadAdd %>" Clear="<%$ Resources:PMWeb, RadUploadClear %>"
                            Delete="<%$ Resources:PMWeb, RadUploadDelete %>" Remove="<%$ Resources:PMWeb, RadUploadRemove %>"
                            Select="<%$ Resources:PMWeb, RadUploadSelect %>" />
                    </telerik:RadUpload>
                    <asp:HyperLink ID="btnDownloadEdit" runat="server" CausesValidation="false" Style="text-decoration: underline;
                                                cursor: hand;" Text='' ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                    <asp:Label ID="lblFileError"  CssClass="Validator" runat="server" Text=""></asp:Label>
                    <asp:HiddenField ID="hdnFileId" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderStyle-Width="150px" HeaderText="Notes"  ItemStyle-Wrap="false" UniqueName="Notes" >
                <ItemTemplate> 
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" MaxLength="100" runat="server" Text='<%# Eval("Notes") %>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="100px" />
            </telerik:GridTemplateColumn>
        </Columns>
        
        <CommandItemTemplate>
            <div style="padding:2px">
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="EditRows" CssClass="GridCmdEditRows" 
                    Visible='<%# rdgAttachments.EditIndexes.Count = 0 AND (Not rdgAttachments.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>' meta:resourcekey="btnEditSelectedResource1">
                     <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnAppAttachUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited" 
                    Visible='<%# rdgAttachments.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnAppAttachSave" runat="server" ValidationGroup="Save" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert" 
                    CommandName="PerformInsert" Visible='<%# rdgAttachments.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll" 
                    CommandName="CancelAll" Visible='<%# rdgAttachments.EditIndexes.Count > 0 Or rdgAttachments.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                     <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow" 
                        CommandName="InitNewRow" Visible='<%# rdgAttachments.EditIndexes.Count = 0 AND (Not rdgAttachments.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue %>' 
                        meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                        Visible='<%# rdgAttachments.EditIndexes.Count = 0 AND (Not rdgAttachments.MasterTableView.IsItemInserted) AND Not PM.Application.ApplicationInfo.Submitted.HasValue%>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                     <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid"  CssClass="GridCmdRebindGrid" 
                    meta:resourcekey="btnRefreshResource1" Visible='<%# rdgAttachments.EditIndexes.Count = 0 And (Not rdgAttachments.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    
    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Resizing-AllowColumnResize="true">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True"  />
    </ClientSettings>
</telerik:RadGrid>
<%--</telerik:RadAjaxPanel>--%>

</fieldset>
<table id="table7" cellpadding="0" cellspacing="0" runat="server">
    <tr>
        <td style="padding-top:10px;">
              <asp:LinkButton ID="btntopPage" runat="server" CausesValidation="False" href="#topPage" CssClass="TopPageButton" >
                    <asp:Label ID="lblTopofPage" runat="server" Text="Top of Page" meta:resourcekey="lblTopofPage"></asp:Label>
                </asp:LinkButton>
        </td>
    </tr>
</table>