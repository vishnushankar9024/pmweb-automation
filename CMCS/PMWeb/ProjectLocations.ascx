<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProjectLocations.ascx.vb" Inherits="Website.ProjectLocations" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamLocation" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgLocation">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLocation" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpLocation" runat="server" Skin="Default" />  

<table style="width:100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadGrid ID="rdgLocation" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="True" PageSize="250" UseEditFormInMobile ="true">
                 <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true">
                   </PagerStyle>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn Visible="false" HeaderText="ID" UniqueName="Id" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" SortExpression="Id">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("SortOrder").ToString = String.Empty, "&nbsp;", Container.DataItem("SortOrder").ToString)%>
                            </ItemTemplate>
                      <EditItemTemplate>
                        <%#IIf(Eval("SortOrder") Is DBNull.Value, String.Empty, Eval("SortOrder").ToString)%>
          
                    </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>  
                                                    
                        
                                                  
                        <telerik:GridTemplateColumn HeaderText="Code*" UniqueName="Code" DataField="Description" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="Description">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="100" Width="100%" runat="server" Text='<%# Eval("Description") %>' ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtDescription" 
                            CssClass="Validator" ErrorMessage="<br/>Enter The Code."  meta:Resourcekey="rfvCode"
                            Display="Dynamic" ForeColor="" ValidationGroup="LocationGroup"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                         <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Location" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="20%" SortExpression="Location">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtLocation" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("Location") %>' ></asp:TextBox>
                                               
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                                                                                     
 <telerik:GridTemplateColumn HeaderText="Notes" HeaderStyle-HorizontalAlign="Center" UniqueName="Notes" HeaderStyle-Width="30%" SortExpression="Notes">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" Width="100%" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>'  ></asp:TextBox>
                        
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                 
                                  
                    </Columns>
                     <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
            <div style="padding:2px">
             
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CssClass="GridCmdEditRows" 
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows" 
                    Visible='<%# rdgLocation.EditIndexes.Count = 0 AND (Not rdgLocation.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server"  CssClass="GridCmdUpdateEdited" 
                    SecurityButtonType="AddEditMode_Edit"
                    ValidationGroup="LocationGroup" CommandName="UpdateEdited" 
                    Visible='<%# rdgLocation.EditIndexes.Count > 0 %>' 
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="LocationGroup"  CssClass="GridCmdPerformInsert" 
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" 
                    Visible='<%# rdgLocation.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False"  CssClass="GridCmdCancelAll" 
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" 
                    Visible='<%# rdgLocation.EditIndexes.Count > 0 Or rdgLocation.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False"  CssClass="GridCmdInitNewRow" 
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" 
                    Visible='<%# rdgLocation.EditIndexes.Count = 0 AND (Not rdgLocation.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows" 
                    OnClientClick="javascript:return ConfirmDelete();" Visible='<%# rdgLocation.EditIndexes.Count = 0 AND (Not rdgLocation.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False"  CssClass="GridCmdRebindGrid" 
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" 
                    Visible='<%# rdgLocation.EditIndexes.Count = 0 AND (Not rdgLocation.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true" Resizing-AllowColumnResize="true" >
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="True"  />
                   
                </ClientSettings>
            </telerik:RadGrid>
        </td>
    </tr>
</table>
