<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourceMaterials.ascx.vb" Inherits="Website.ResourceMaterials" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamMaterials" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMaterials">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMaterials" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpMaterials" runat="server" Skin="Default" />  

<table style="width:100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadGrid ID="rdgMaterials" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8" 
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" >
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ID" UniqueName="ID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Code">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Code").ToString = String.Empty, "&nbsp;", Container.DataItem("Code").ToString)%>
                            </ItemTemplate>
                      <EditItemTemplate>
                        <asp:TextBox ID="txtCode" runat="server" Text='<%# Eval("Code") %>' ReadOnly="true"></asp:TextBox>
          
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>  
                                                    
                        
                                                  
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="Description">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' ></asp:TextBox>
                                           <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                            CssClass="Validator" ErrorMessage="<br />Enter the Description" Display="Dynamic"
                            ForeColor="" ValidationGroup="EstimateMarkup" meta:resourcekey="rfvDescription"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                   <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="10%" SortExpression="CompanyName">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("CompanyName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>  
                                 <telerik:RadComboBox ID="ddlCompany" Skin="Default" runat="server">
                                 </telerik:RadComboBox>            
                                
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn Visible="false" DataField="CompanyId"></telerik:GridBoundColumn>
                    
                        <telerik:GridBoundColumn Visible="false" DataField="ContactId"></telerik:GridBoundColumn>
                         <telerik:GridBoundColumn Visible="false" DataField="ResourceGroupId"></telerik:GridBoundColumn>
                         <telerik:GridBoundColumn Visible="false" DataField="ClassId"></telerik:GridBoundColumn>
                          <telerik:GridBoundColumn Visible="false" DataField="DivisionId"></telerik:GridBoundColumn>                                 
                                                                                       
                               
                        <telerik:GridTemplateColumn HeaderText="Contact" UniqueName="ContactName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="10%" SortExpression="ContactName">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("ContactName").ToString =" ", "&nbsp;", Container.DataItem("ContactName").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>  
                                  <telerik:RadComboBox ID="ddlContact" Skin="Default" runat="server" AutoPostBack="true" >
                                 </telerik:RadComboBox>
                                 
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                               
               <telerik:GridTemplateColumn HeaderText="Resource Group" UniqueName="ResourceGroup" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="GroupName">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("GroupName").ToString = String.Empty, "&nbsp;", Container.DataItem("GroupName").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>   
                                        <telerik:RadComboBox ID="ddlGroup" Skin="Default" runat="server">
                                 </telerik:RadComboBox>
                               
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                                 

               <telerik:GridTemplateColumn HeaderText="CSI Division" UniqueName="CSIDivision" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%" SortExpression="DivisionName">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("DivisionName").ToString = String.Empty, "&nbsp;", Container.DataItem("DivisionName").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>     
                                              <telerik:RadComboBox ID="ddlDivision" Skin="Default" runat="server">
                                 </telerik:RadComboBox>
                                 
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>

               <telerik:GridTemplateColumn HeaderText="Classification" UniqueName="Classification">
                    <ItemTemplate>
                     <asp:Label ID="lblCostTypes" runat="server" Text= '<%#IIf(Container.DataItem("ClassName").ToString = String.Empty, "&nbsp;", Container.DataItem("ClassName").ToString)%>'/>
                        
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlClassification" runat="server"
                            AllowCustomText="True" Width="150px" Skin="Default">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <asp:CheckBox runat="server" ID="chkApply" 
                                      />
                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply" 
                                       ></asp:Label>
                                       <%#Eval("Class")%>
                                       
                                </div>
                            </ItemTemplate>
                        </telerik:RadComboBox>

                    </EditItemTemplate>
                    <ItemStyle Wrap="true" Width="150"/>
                    <HeaderStyle HorizontalAlign="Center" />
               </telerik:GridTemplateColumn>
                                               
               <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="30%" SortExpression="Notes">
                            <ItemTemplate>
                                 <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="200px" ></asp:TextBox>
                        
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
               <telerik:GridTemplateColumn HeaderText="Inactive" UniqueName="Inactive" HeaderStyle-Width="10%"  ItemStyle-Wrap="false"
SortExpression="IsActive" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" >
<ItemTemplate>
<img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsActive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
</ItemTemplate>
<EditItemTemplate>
<asp:CheckBox ID="chbInactive" Checked='<%# Cbool(IIF(Eval("IsActive") is system.DBNULL.value, 0,Eval("IsActive")))%>' runat="server" />
</EditItemTemplate>
</telerik:GridTemplateColumn>                   
                    </Columns>
                     <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
            <div style="padding:2px">
          
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                    CommandName="EditRows" CssClass="GridCmdEditRows" 
                    Visible='<%# rdgMaterials.EditIndexes.Count = 0 AND (Not rdgMaterials.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
</asp:LinkButton>
               
                <asp:LinkButton ID="btnUpdateEdited" runat="server" 
                    ValidationGroup="EstimateMarkup" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgMaterials.EditIndexes.Count > 0 %>' 
                    meta:resourcekey="btnUpdateEditedResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
</asp:LinkButton>
               
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateMarkup" 
                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert" 
                    Visible='<%# rdgMaterials.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnSaveResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
</asp:LinkButton>
           
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" 
                    CommandName="CancelAll"  CssClass="GridCmdCancelAll" 
                    Visible='<%# rdgMaterials.EditIndexes.Count > 0 Or rdgMaterials.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
</asp:LinkButton>
                               
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" 
                    CommandName="InitNewRow"  CssClass="GridCmdInitNewRow" 
                    Visible='<%# rdgMaterials.EditIndexes.Count = 0 AND (Not rdgMaterials.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
</asp:LinkButton>
              
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    Visible='<%# rdgMaterials.EditIndexes.Count = 0 AND (Not rdgMaterials.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
</asp:LinkButton>
                   
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" 
                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgMaterials.EditIndexes.Count = 0 AND (Not rdgMaterials.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnRefreshResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
</asp:LinkButton>
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings  EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="False" >
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="False"  />
                   
                </ClientSettings>
            </telerik:RadGrid>
        </td>
    </tr>
</table>
