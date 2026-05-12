<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectPhases.ascx.vb" Inherits="Website.ProjectPhases" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamPhase" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPhase">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPhase" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpPhase" runat="server" Skin="Default" />  

<table style="width:100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadGrid ID="rdgPhase" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="15" UseEditFormInMobile ="true">
                   <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true">
                   </PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderText="Phase ID" UniqueName="PhaseNumber" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="5%" SortExpression="PhaseNumber">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("PhaseNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("PhaseNumber").ToString)%>
                            </ItemTemplate>
                      <EditItemTemplate>
                      <%#IIf(Eval("PhaseNumber") Is DBNull.Value, String.Empty, Eval("PhaseNumber").ToString) %>
          
                    </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>  
                 
                 
                 <telerik:GridTemplateColumn HeaderText="Code*" UniqueName="Code" DataField="PhaseName" HeaderStyle-HorizontalAlign="Center"
                     HeaderStyle-Width="20%" SortExpression="PhaseName">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("PhaseName").ToString = String.Empty, "&nbsp;", Container.DataItem("PhaseName").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtPhaseName" MaxLength="100" Width="100%" runat="server" Text='<%# Eval("PhaseName") %>' ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvPhaseName" runat="server" ControlToValidate="txtPhaseName" 
                            CssClass="Validator" ErrorMessage="<br />Enter The Phase Name"  meta:Resourcekey="rfvPhaseName" 
                            Display="Dynamic" ForeColor="" ValidationGroup="PhaseGroup"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>             
                        
                                                  
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="Description">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Description") %>' ></asp:TextBox>
                                               
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                                               
 <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30%" SortExpression="Notes">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Notes") %>'  ></asp:TextBox>
                        
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                    
                                  
                    </Columns>
                     <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
            <div style="padding:2px">
                
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CssClass="GridCmdEditRows" 
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows" 
                    Visible='<%# rdgPhase.EditIndexes.Count = 0 AND (Not rdgPhase.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server"  CssClass="GridCmdUpdateEdited" 
                    SecurityButtonType="AddEditMode_Edit"
                    ValidationGroup="PhaseGroup" CommandName="UpdateEdited" 
                    Visible='<%# rdgPhase.EditIndexes.Count > 0 %>' 
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="PhaseGroup"  CssClass="GridCmdPerformInsert" 
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" 
                    Visible='<%# rdgPhase.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnSaveResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"  CssClass="GridCmdCancelAll" 
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" 
                    Visible='<%# rdgPhase.EditIndexes.Count > 0 Or rdgPhase.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CssClass="GridCmdInitNewRow" 
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" 
                    Visible='<%# rdgPhase.EditIndexes.Count = 0 AND (Not rdgPhase.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows" 
                    OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgPhase.EditIndexes.Count = 0 AND (Not rdgPhase.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"  CssClass="GridCmdRebindGrid" 
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" 
                    Visible='<%# rdgPhase.EditIndexes.Count = 0 AND (Not rdgPhase.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
</asp:LinkButton>
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowRowsDragDrop="true" AllowDragToGroup="True" Resizing-AllowColumnResize="true" >
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="True"  />
                   
                </ClientSettings>
            </telerik:RadGrid>
        </td>
    </tr>
</table>
