<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourceEquipment.ascx.vb" Inherits="Website.Resource_Equipment" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<telerik:RadAjaxManagerProxy ID="RamEquipment" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgEquipment">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgEquipment" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpEquipment" runat="server" Skin="Default" />  

<table style="width:100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadGrid ID="rdgEquipment" AllowMultiRowSelection="true"  runat="server"   HeaderStyle-Font-Size="8" AllowFilteringByColumn="true"
                Width="100%" AutoGenerateColumns="False" AllowSorting="true" ShowGroupPanel="true" ShowStatusBar="false" AllowPaging="True" PageSize="50">
                   <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"  />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ID" UniqueName="ID" AllowFiltering="false"  Groupable="false"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" SortExpression="Code">
                            <ItemTemplate>
                               <span> <%#IIf(Container.DataItem("Code").ToString = String.Empty, "&nbsp;", "E" & Container.DataItem("Code").ToString)%>
                            </ItemTemplate>
                      <EditItemTemplate>
                        <span> <%#IIf(Eval("Code") Is DBNull.Value, "&nbsp;", "E" & Eval("Code").ToString)%></span> 
                    </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>  
                        <telerik:GridTemplateColumn HeaderText="Description*" DataField="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                         UniqueName="Description" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="130px" SortExpression="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span> 
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" MaxLength="100" runat="server" Text='<%# Eval("Description") %>' Width="100%" ></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                     CssClass="Validator" ErrorMessage="<br />Enter the Description" Display="Dynamic"
                                     ForeColor="" ValidationGroup="Equipment" meta:resourcekey="rfvDescription"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                   <telerik:GridTemplateColumn HeaderText="Labor Resource"  GroupByExpression="LaborName [GridColumn_LaborResource] Group By LaborName ASC"
                   UniqueName="LaborResource" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" DataField="LaborName" SortExpression="LaborName">
                            <ItemTemplate>
                                <span> <%#IIf(Container.DataItem("LaborName").ToString = string.Empty , "&nbsp;", Container.DataItem("LaborName").ToString)%></span> 
                            </ItemTemplate>
                             <EditItemTemplate>              
                                  <telerik:RadComboBox ID="ddlLabor" height="250px" Filter="Contains" AllowCustomText="true" Skin="Default" runat="server" Width="100%" DropDownWidth="300px">
                                 </telerik:RadComboBox>         
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                               
                        <telerik:GridTemplateColumn HeaderText="Equipment"  GroupByExpression="EquipmentName [GridColumn_Equipment] Group By EquipmentName ASC"
                        UniqueName="Equipment" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" DataField="EquipmentName" SortExpression="EquipmentName">
                            <ItemTemplate>
                                <span> <%#IIf(Container.DataItem("EquipmentName").ToString = String.Empty, "&nbsp;", Container.DataItem("EquipmentName").ToString)%></span> 
                            </ItemTemplate>
                             <EditItemTemplate>
                              <telerik:RadComboBox ID="ddlEquipment" runat="server" ItemRequestTimeout="1000"
                                Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                                CausesValidation="False" Height="330px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                 DropDownWidth="350px" ShowMoreResultsBox="True" EnableLoadOnDemand="true" 
                                  EnableVirtualScrolling="True" OnItemsRequested="ItemsLoadRequested">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                      <telerik:GridTemplateColumn HeaderText="Resource Group"  GroupByExpression="GroupName [GridColumn_ResourceGroup] Group By GroupName ASC"
                      UniqueName="ResourceGroup" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" DataField="GroupName" SortExpression="GroupName">
                            <ItemTemplate>
                   
                                 <span><%#IIf(Container.DataItem("GroupName").ToString = String.Empty, "&nbsp;", Container.DataItem("GroupName").ToString)%></span> 
                            </ItemTemplate>
                             <EditItemTemplate>              
                                  <telerik:RadComboBox ID="ddlGroup" Filter="Contains" AllowCustomText="true" height="250px"  DropDownWidth="300px" width="100%" runat="server" Skin="Default">
                                 </telerik:RadComboBox>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                                        
               <telerik:GridTemplateColumn HeaderText="CSI Division"  GroupByExpression="DivisionName [GridColumn_CSIDivision] Group By DivisionName ASC"
                UniqueName="CSIDivision" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" DataField="DivisionName" SortExpression="DivisionName">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("DivisionName").ToString = String.Empty, "&nbsp;", Container.DataItem("DivisionName").ToString)%></span> 
                            </ItemTemplate>
                             <EditItemTemplate>     
                                              <telerik:RadComboBox ID="ddlDivision" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"  EmptyMessage="--Select--" 
                            NoWrap="True" AllowCustomText="true" 
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                 </telerik:RadComboBox>
                                 
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>                              
                           
                   <telerik:GridTemplateColumn HeaderText="Classification" GroupByExpression="ClassName [GridColumn_Classification] Group By ClassName ASC"
                   HeaderStyle-Width="150px" SortExpression="ClassName" UniqueName="Classification" DataField="ClassName">
                    <ItemTemplate>
                     <span><%#IIf(Container.DataItem("ClassName").ToString = String.Empty, "&nbsp;", Container.DataItem("ClassName").ToString)%></span>
                        
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlClassification" DropDownWidth="300px" height="250px"  runat="server"
                            AllowCustomText="True" Width="100%" Skin="Default">
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
               
               
         <telerik:GridTemplateColumn HeaderText="Operating" GroupByExpression="Operating [GridColumn_Operating] Group By Operating ASC" DataField="Operating"
         UniqueName="Operating" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" SortExpression="Operating">
                            <ItemTemplate> 
<span> <%#FormatCurrency(ParseDouble(Eval("Operating")))%></span> 
                            </ItemTemplate>
                                <EditItemTemplate>
                           <asp:TextBox ID="txtOperating"  MinNumber="0" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("Operating")) %>'></asp:TextBox>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>

  <telerik:GridTemplateColumn HeaderText="Standby" UniqueName="Standby" GroupByExpression="Standby [GridColumn_Standby] Group By Standby ASC" DataField="Standby"
  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" SortExpression="Standby">
                            <ItemTemplate>
<span> <%#FormatCurrency(ParseDouble(Eval("Standby")))%></span> 
                            </ItemTemplate>
                                <EditItemTemplate>
                           <asp:TextBox ID="txtStandby"  MinNumber="0" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("Standby")) %>'></asp:TextBox>
                   
                    </EditItemTemplate>
   </telerik:GridTemplateColumn>
                                      
 <telerik:GridTemplateColumn HeaderText="Idle"  GroupByExpression="Idle [GridColumn_Idle] Group By Idle ASC" DataField="Idle"
 UniqueName="Idle" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" SortExpression="Idle">
                            <ItemTemplate>
<span><%#FormatCurrency(ParseDouble(Eval("Idle")))%></span> 
                            </ItemTemplate>
                                <EditItemTemplate>
                               <asp:TextBox ID="txtIdle"  MinNumber="0" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("Idle")) %>'></asp:TextBox>
                   
                    </EditItemTemplate>
   </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" DataField="Notes"
                        UniqueName="Notes"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="190px" SortExpression="Notes">
                            <ItemTemplate>
                                <span>  <%#Eval("Notes")%>  &nbsp;</span> 
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" MaxLength="200" runat="server" Text='<%# Eval("Notes") %>' Width="100%" ></asp:TextBox>
                        
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Inactive" GroupByExpression="IsActive [GridColumn_Inactive] Group By IsActive ASC" DataType="System.Boolean"
                         UniqueName="Inactive"   HeaderStyle-Width="50px"  ItemStyle-Wrap="false" DataField="IsActive"
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
                    SecurityButtonType="ItemMode_Edit"
                    CommandName="EditRows"  CssClass="GridCmdEditRows" 
                    Visible='<%# rdgEquipment.EditIndexes.Count = 0 AND (Not rdgEquipment.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" 
                    SecurityButtonType="AddEditMode_Edit"
                    ValidationGroup="Equipment" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" 
                    Visible='<%# rdgEquipment.EditIndexes.Count > 0 %>' 
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Equipment" 
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgEquipment.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnSaveResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" 
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                    Visible='<%# rdgEquipment.EditIndexes.Count > 0 Or rdgEquipment.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" 
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow"  CssClass="GridCmdInitNewRow" 
                    Visible='<%# rdgEquipment.EditIndexes.Count = 0 AND (Not rdgEquipment.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    SecurityButtonType="ItemMode_Delete"
                    Visible='<%# rdgEquipment.EditIndexes.Count = 0 AND (Not rdgEquipment.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"  meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" 
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgEquipment.EditIndexes.Count = 0 AND (Not rdgEquipment.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
</asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu> 
                </div>
            </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
             <clientsettings enablerowhoverstyle="true"  AllowDragToGroup="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="False"  />
                      <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
                </clientsettings>
                <ValidationSettings ValidationGroup="Equipment" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
        </td>
    </tr>
</table>
