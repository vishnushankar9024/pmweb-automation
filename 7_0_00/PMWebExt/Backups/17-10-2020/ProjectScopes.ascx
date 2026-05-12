<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectScopes.ascx.vb" Inherits="Website.ProjectScopes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 

<telerik:RadAjaxManagerProxy ID="RamScope" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgScope" >
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgScope" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpScope" runat="server" Skin="Default" />  

<table style="width:100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadGrid ID="rdgScope" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8" 
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" >
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Active" HeaderStyle-Width="10%"  ItemStyle-Wrap="false"
                                SortExpression="Active" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" >
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Active"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                 <asp:CheckBox ID="chbActive" Checked='<%# Cbool(IIF(Eval("Active") is system.DBNULL.value, 0,Eval("Active")))%>' runat="server" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                 
                 
                 <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Date">
                            <ItemTemplate>
                                <%#FormatDate(Eval("Date"))%>&nbsp;
                            </ItemTemplate>
                     <ItemStyle HorizontalAlign="Right"></ItemStyle>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtPhaseName" runat="server" Text='<%# Eval("PhaseName") %>' ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvPhaseName" runat="server" ControlToValidate="txtPhaseName" 
                            CssClass="Validator" ErrorMessage="<br />Enter The Phase Name" 
                            Display="Dynamic" ForeColor="" ValidationGroup="PhaseGroup"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>             
                        
                                                  
                        <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Description">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' ></asp:TextBox>
                                               
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                                               
 <telerik:GridTemplateColumn HeaderText="Notes" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30%" SortExpression="Notes">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="200px" ></asp:TextBox>
                        
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                    
                                  
                    </Columns>
                     <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
            <div style="padding:2px">
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CssClass="GridCmdEditRows" 
                    CommandName="EditRows" 
                    Visible='<%# rdgScope.EditIndexes.Count = 0 AND (Not rdgScope.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CssClass="GridCmdUpdateEdited" 
                    ValidationGroup="PhaseGroup" CommandName="UpdateEdited" 
                    Visible='<%# rdgScope.EditIndexes.Count > 0 %>' 
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
</asp:LinkButton>
                &nbsp;&nbsp;
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="PhaseGroup"  CssClass="GridCmdPerformInsert" 
                    CommandName="PerformInsert" 
                    Visible='<%# rdgScope.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"  CssClass="GridCmdCancelAll" 
                    CommandName="CancelAll" 
                    Visible='<%# rdgScope.EditIndexes.Count > 0 Or rdgScope.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
</asp:LinkButton>
                &nbsp;&nbsp;                   
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"  CssClass="GridCmdInitNewRow" 
                    CommandName="InitNewRow" 
                    Visible='<%# rdgScope.EditIndexes.Count = 0 AND (Not rdgScope.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows" 
                    Visible='<%# rdgScope.EditIndexes.Count = 0 AND (Not rdgScope.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
</asp:LinkButton>
                    &nbsp;&nbsp;
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"  CssClass="GridCmdRebindGrid" 
                    CommandName="RebindGrid" 
                    Visible='<%# rdgScope.EditIndexes.Count = 0 AND (Not rdgScope.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
</asp:LinkButton>
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowRowsDragDrop="true" AllowDragToGroup="True" Resizing-AllowColumnResize="False" >
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="True"  />
                   
                </ClientSettings>
            </telerik:RadGrid>
        </td>
    </tr>
</table>
