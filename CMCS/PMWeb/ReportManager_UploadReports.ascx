<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ReportManager_UploadReports.ascx.vb" Inherits="Website.ReportManager_UploadReports" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">
    //On insert and update buttons click temporarily disables ajax to perform upload actions
        function RequestStart(e, sender)
    {
//        var btnUpdateSelectedId = 'ctl00$CPH1$DocumentAttachments$rdgDocumentAttachments$ctl00$ctl02$ctl00$btnUpdateEdited';
//        var btnSaveId = 'ctl00$CPH1$DocumentAttachments$rdgDocumentAttachments$ctl00$ctl02$ctl00$btnSave';
//        

//        if (sender.EventTarget == btnUpdateSelectedId || sender.EventTarget == btnSaveId) {
//            var upload = $find(window['UploadId']);
//            if (upload.getFileInputs()[0].value != "")
//            {
                //alert(upload.getFileInputs()[0] == null);
                sender.EnableAjax = false;
//            }
//        }
            }
            function DocAttachRowDblClick(sender, eventArgs) {

                var btnEditSelectedId = 'ctl00_CPH1_DocumentAttachments_rdgDocumentAttachments_ctl00_ctl02_ctl00_btnEditSelected';

                if (document.getElementById(btnEditSelectedId)) {
                    document.getElementById(btnEditSelectedId).focus();
                    document.getElementById(btnEditSelectedId).click();
                }
            }

            function cvUpload_validate(sender, args) {
                    if (sender.UploadedFiles.Count > 0)
                    {args.IsValid = true;}
                    else
                    {args.IsValid = false;}                   
            }
    </script>
</telerik:RadScriptBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDocumentAttachments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDocumentAttachments" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                   
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpDocumentAttachments" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>

<table style="width:100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="RequestStart">
                <telerik:RadGrid ID="rdgDocumentAttachments" runat="server" Skin="Default" HeaderStyle-Font-Size="8" 
                            Width="99%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true">
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                        EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Report Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="28%" SortExpression="InstanceName">
                                <ItemTemplate>
                                     <%#IIf(Container.DataItem("InstanceName") = String.Empty, "&nbsp;", Container.DataItem("InstanceName"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" width="300px" runat="server" Text='<%#Eval("InstanceName") %>' ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                                            ControlToValidate="txtDescription" CssClass="Validator" ValidationGroup="DocumentAttachments"
                                            ErrorMessage="&lt;br&gt;Enter the Report Name" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                 </EditItemTemplate>
                           </telerik:GridTemplateColumn>
                           
                           
                            <%--<telerik:GridTemplateColumn HeaderText="File" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="29%" >
                                <ItemTemplate>
                                     <asp:hyperlink ID="hplDownload" runat="server" CausesValidation="false" Text='<%#IIf(Container.DataItem("FileName") = String.Empty, "&nbsp;", Container.DataItem("FileName"))%>'
                                      ToolTip="Download" style="text-decoration:underline;cursor:hand;" ></asp:hyperlink>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadUpload ID="fluUpload" width="300px" runat="server" InitialFileInputsCount="1" MaxFileInputsCount="1"
                                                        ControlObjectsVisibility="None" />
                                  <asp:CustomValidator ID="cvUpload" runat="server" CssClass="Validator" ValidationGroup="DocumentAttachments"
                                                ErrorMessage="&lt;br&gt;Choose a file" Display="Dynamic" ForeColor=""
                                                ClientValidationFunction="cvUpload_validate" ControlToValidate="fluUpload" ></asp:CustomValidator>
                                    <asp:LinkButton ID="btnDownloadEdit" runat="server" CausesValidation="false" CommandName="Download" 
                                     Text='<%#Eval("FileName")%>' ToolTip="Download" style="text-decoration:underline;" ></asp:LinkButton>
                                </EditItemTemplate>
                           </telerik:GridTemplateColumn>--%>
                           
                            
                            <telerik:GridTemplateColumn HeaderText="Report Type" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="38%" SortExpression="ReportTypeId">
                                <ItemTemplate>
                                     <%#IIf(Container.DataItem("ReportTypeId") = 0, "&nbsp;", Container.DataItem("ReportTypeId"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                <asp:DropDownList ID="ddlReportType" runat="server">
                                 <asp:ListItem Text="-- Select --" Value="0" Selected ='<%#IIf(val(Container.DataItem("ReportTypeId"))<>2 and IIf(val(Container.DataItem("ReportTypeId"))<>2 ,"true","false") %>'></asp:ListItem>
                                <asp:ListItem Text="Crystal Report" Value="2" Selected='<%#IIf(val(Container.DataItem("ReportTypeId"))=2,"true","false") %>'></asp:ListItem>
                                <asp:ListItem Text="SQL Report" Value="3" Selected='<%#IIf(val(Container.DataItem("ReportTypeId"))=3,"true","false") %>'></asp:ListItem>
                                </asp:DropDownList>
                                </EditItemTemplate>
                           </telerik:GridTemplateColumn>
                           
                          <telerik:GridTemplateColumn HeaderText="Module" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="38%" SortExpression="ModuleId">
                                <ItemTemplate>
                                     <%#IIf(Container.DataItem("ModuleId") = 0, "&nbsp;", Container.DataItem("ModuleName"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                <asp:DropDownList ID="ddlModule" runat="server">                                                         
                                </asp:DropDownList>
                                </EditItemTemplate>
                           </telerik:GridTemplateColumn>      
                           
                           
                                 
                        </Columns>
                        <CommandItemTemplate>
                            <div style="padding:2px">
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                    CommandName="EditRow" CssClass="GridCmdEditRow" Visible='<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span> 
                                    Edit selected line
                                </asp:LinkButton>
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="DocumentAttachments" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"  Visible='<%# rdgDocumentAttachments.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span> 
                                    Update record
                                </asp:LinkButton>
                                &nbsp;&nbsp;
                                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="DocumentAttachments" CommandName="PerformInsert"  CssClass="GridCmdPerformInsert" Visible='<%# rdgDocumentAttachments.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    Save
                                </asp:LinkButton>
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgDocumentAttachments.EditIndexes.Count > 0 Or rdgDocumentAttachments.MasterTableView.IsItemInserted %>'>
                                   <span class="Icon"></span>
                                    Cancel
                                </asp:LinkButton>                
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>'>
                                   <span class="Icon"></span> 
                                        Add line
                                </asp:LinkButton>
                                &nbsp;&nbsp;
                                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                    Visible='<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRow" CssClass="GridCmdDeleteRow" >
                                    <span class="Icon"></span>
                                    Delete selected line</asp:LinkButton>
                                    &nbsp;&nbsp;
                               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>'>
                                   <span class="Icon"></span>
                                    Refresh
                               </asp:LinkButton>
                            </div>
                        </CommandItemTemplate>
                    </MasterTableView>
                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings ClientEvents-OnRowDblClick="DocAttachRowDblClick" AllowColumnHide="true" AllowColumnsReorder="true"
                                    Resizing-AllowColumnResize="true">
                        <%--<Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />--%>
                    </ClientSettings>
                    <ValidationSettings ValidationGroup="DocumentAttachments" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
            </telerik:RadGrid>
            </telerik:RadAjaxPanel>
        </td>
    </tr>
</table>