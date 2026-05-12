<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourceLabors.ascx.vb"
    Inherits="Website.ResourceLabors" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RamLabors" runat="server">
    <ajaxsettings>
        <telerik:AjaxSetting AjaxControlID="rdgLabors">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgLabors" LoadingPanelID="ldpPM" />
                
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </ajaxsettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpLabors" runat="server" Skin="Default" />
<table style="width: 100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadGrid ID="rdgLabors" AllowMultiRowSelection="true" runat="server"  AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                 HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" ShowGroupPanel="true"
                AllowSorting="true" ShowStatusBar="false" AllowPaging="True" PageSize="50">
                 <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <mastertableview datakeynames="Id" clientdatakeynames="Id" commanditemdisplay="Top"
                    insertitemdisplay="Top" insertitempageindexaction="ShowItemOnFirstPage" editmode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-HorizontalAlign="Center" 
                        HeaderStyle-Width="50px" SortExpression="Code" UniqueName="ID" Groupable="false" AllowFiltering="false"  >
                            <ItemTemplate>
                                 <span><%#IIf(Container.DataItem("Code").ToString = String.Empty, "&nbsp;", "L" & Container.DataItem("Code").ToString)%></span>
                            </ItemTemplate>
                      <EditItemTemplate>
                           <%#IIf(Eval("Code") Is DBNull.Value, "&nbsp;", "L" & Eval("Code").ToString)%>
                    </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>  
                         <telerik:GridTemplateColumn HeaderText="Sub"  DataField="Sub" DataType="System.Boolean"
                         HeaderStyle-Width="50px"  ItemStyle-Wrap="false" GroupByExpression="Sub [GridColumn_Sub] Group By Sub ASC"
                                SortExpression="Sub" UniqueName="Sub" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" >
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Sub"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                 <asp:CheckBox ID="chbSub" Checked='<%# Cbool(IIF(Eval("Sub") is system.DBNULL.value, 0,Eval("Sub")))%>' runat="server" />
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>                       
                        <telerik:GridTemplateColumn HeaderText="Description*" HeaderStyle-HorizontalAlign="Center"  DataField="Description"
                        HeaderStyle-Width="120px" SortExpression="Description"
                         UniqueName="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                            <ItemTemplate>
                             <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtDescription" Width="100%" MaxLength="100" runat="server" Text='<%# Eval("Description") %>' ></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                            CssClass="Validator" ErrorMessage="<br />Enter the Description" Display="Dynamic"
                            ForeColor="" ValidationGroup="Labor" meta:resourcekey="rfvDescription"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>   
                             <telerik:GridTemplateColumn HeaderText="Quantity" DataField="Quantity"
                              GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC"
                             UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                             SortExpression="Quantity"
                           >
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'
                                    ></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Scheduling"  GroupByExpression="IsUsedInScheduling [GridColumn_IsUsedInScheduling] Group By IsUsedInScheduling ASC"
                         UniqueName="IsUsedInScheduling" HeaderStyle-Width="65px"  ItemStyle-Wrap="false" DataField="IsUsedInScheduling" DataType="System.Boolean"
                        SortExpression="IsUsedInScheduling" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" >
                        <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsUsedInScheduling"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                        </ItemTemplate>
                        <EditItemTemplate>
                        <asp:CheckBox ID="chbIsUsedInScheduling" Checked='<%# Cbool(IIF(Eval("IsUsedInScheduling") is system.DBNULL.value, 0,Eval("IsUsedInScheduling")))%>' runat="server" />
                        </EditItemTemplate>
                        </telerik:GridTemplateColumn>   
                   <telerik:GridTemplateColumn HeaderText="Company" GroupByExpression="CompanyName [GridColumn_Company] Group By CompanyName ASC"
                    UniqueName="Company" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" DataField="CompanyName" SortExpression="CompanyName">
                            <ItemTemplate>
                            <span>
                                 <%#IIf(Container.DataItem("CompanyName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%>
                            </span>
                            </ItemTemplate>
                             <EditItemTemplate>              
                                 <telerik:RadComboBox  ID="ddlCompany"  runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"  EmptyMessage="Select Company..." 
                            NoWrap="True" AllowCustomText="true" autopostback="true"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                        </telerik:RadComboBox>
                                
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>                                                                                                     
                        <telerik:GridTemplateColumn UniqueName="Contact" GroupByExpression="ContactName [GridColumn_Contact] Group By ContactName ASC"
                         HeaderText="Contact" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" DataField="ContactName" SortExpression="ContactName">
                            <ItemTemplate>
                               <span>  <%#IIf(Container.DataItem("ContactName").ToString = " ", "&nbsp;", Container.DataItem("ContactName").ToString)%></span>
                            </ItemTemplate>
                             <EditItemTemplate>              
                                 <telerik:RadComboBox  ID="ddlContact" Width="100%" runat="server"  DropDownWidth="400px" 
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                NoWrap="True" AllowCustomText="true"  EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested"  Style="font-size: 11px" Height="250px">
                                 </telerik:RadComboBox>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn> 
                      <telerik:GridTemplateColumn HeaderText="Resource Group" GroupByExpression="GroupName [GridColumn_ResourceGroup] Group By GroupName ASC"
                      UniqueName="ResourceGroup" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="90px" DataField="GroupName" SortExpression="GroupName">
                            <ItemTemplate>
                                <span> <%#IIf(Container.DataItem("GroupName").ToString = String.Empty, "&nbsp;", Container.DataItem("GroupName").ToString)%></span>
                            </ItemTemplate>
                             <EditItemTemplate>              
                                 <telerik:RadComboBox AllowCustomText="true"  ID="ddlGroup" Width="100%" runat="server">
                                 </telerik:RadComboBox>
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn> 
                        
                    <telerik:GridTemplateColumn HeaderText="Default Pay Type"  SortExpression="PayType" DataField="PayType"
                    UniqueName="PayType" GroupByExpression="PayType [GridColumn_PayType] Group By PayType ASC">
                    <ItemTemplate>
                     <asp:Label ID="Label2" runat="server" Text= '<%#IIf(Container.DataItem("PayType").ToString = String.Empty, "&nbsp;", Container.DataItem("PayType").ToString)%>'/>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlPayType" runat="server"
                             Width="100%" dropdownWidth="200px" Skin="Default">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemStyle Wrap="true" />
                    <HeaderStyle HorizontalAlign="Center" Width="95px"/>
               </telerik:GridTemplateColumn> 
               
                   <telerik:GridTemplateColumn HeaderText="Default Classification" SortExpression="ClassName" DataField="ClassName"
                   UniqueName="Classification" GroupByExpression="ClassName [GridColumn_Classification] Group By ClassName ASC">
                    <ItemTemplate>
                     <asp:Label ID="lblCostTypes" runat="server" Text= '<%#IIf(Container.DataItem("ClassName").ToString = String.Empty, "&nbsp;", Container.DataItem("ClassName").ToString)%>'/>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlClassification" runat="server"
                             Width="100%" dropdownWidth="200px" Skin="Default">
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemStyle Wrap="true" />
                    <HeaderStyle HorizontalAlign="Center" Width="120px" />
               </telerik:GridTemplateColumn> 
        
                       <telerik:GridTemplateColumn HeaderText="Skills" UniqueName="Skills" SortExpression="SkillName" DataField="SkillName"
                       GroupByExpression="SkillName [GridColumn_Skills] Group By SkillName ASC">
                    <ItemTemplate>
                        <span> <%#IIf(Container.DataItem("SkillName").ToString = String.Empty, "&nbsp;", Container.DataItem("SkillName").ToString)%></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="ddlSkills" runat="server"
                            AllowCustomText="True" Width="100%" dropdownWidth="200px" Skin="Default">
                            <ItemTemplate>
                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                    <asp:CheckBox runat="server" ID="chkApplySkills" 
                                      />
                                    <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApplySkills" 
                                       ></asp:Label>
                                       <%#Eval("Skills")%>
                                </div>
                            </ItemTemplate>
                        </telerik:RadComboBox>

                    </EditItemTemplate>
                    <ItemStyle Wrap="true" />
                    <HeaderStyle HorizontalAlign="Center" Width="100px"/>
               </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" DataField="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                         UniqueName="Notes" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" SortExpression="Notes">
                            <ItemTemplate>
                                 <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                             <EditItemTemplate>
                        <asp:TextBox ID="txtNotes" MaxLength="200" runat="server" Text='<%# Eval("Notes") %>' Width="100%" ></asp:TextBox>
                        
                    </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="Inactive" DataField="IsActive"  UniqueName="Inactive" HeaderStyle-Width="50px"  ItemStyle-Wrap="false" DataType="System.Boolean"
                        SortExpression="IsActive" GroupByExpression="IsActive [GridColumn_Inactive] Group By IsActive ASC"
                         ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" >
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
                    CommandName="EditRows" CssClass="GridCmdEditRows"
                    Visible='<%# rdgLabors.EditIndexes.Count = 0 AND (Not rdgLabors.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" 
                    Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" 
                    SecurityButtonType="AddEditMode_Edit"
                    ValidationGroup="Labor" CommandName="UpdateEdited"  CssClass="GridCmdUpdateEdited"
                    Visible='<%# rdgLabors.EditIndexes.Count > 0 %>' 
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" 
                    meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                 <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Labor" 
                    SecurityButtonType="AddEditMode_Add"
                    CommandName="PerformInsert"  CssClass="GridCmdPerformInsert"
                    Visible='<%# rdgLabors.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" 
                    meta:resourcekey="lblSaveResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" 
                    SecurityButtonType="AddEditMode"
                    CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgLabors.EditIndexes.Count > 0 Or rdgLabors.MasterTableView.IsItemInserted %>' 
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" 
                    meta:resourcekey="lblCancelResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" 
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    Visible='<%# rdgLabors.EditIndexes.Count = 0 AND (Not rdgLabors.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" 
                    meta:resourcekey="lblAddLineResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    SecurityButtonType="ItemMode_Delete"
                    Visible='<%# rdgLabors.EditIndexes.Count = 0 AND (Not rdgLabors.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"  meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" 
                    Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                &nbsp;&nbsp;
</asp:LinkButton>
               <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" 
                    SecurityButtonType="ItemMode"
                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgLabors.EditIndexes.Count = 0 AND (Not rdgLabors.MasterTableView.IsItemInserted) %>' 
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" 
                    meta:resourcekey="lblRefreshResource1"></asp:Label>&nbsp;&nbsp;
</asp:LinkButton>
              <telerik:RadMenu ID="rdmLayouts" style="float:none;display:inline-block;vertical-align: middle;" SecurityButtonType="ItemMode"  EnableRoundedCorners="true"  EnableAutoScroll="true"
                 CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick"    OnClientItemClicking="rdmLayouts_ItemClicking" 
                 runat="server" EnableSelection="true"   CssClass="trvContextMenu bringToBack"
                 EnableShadows="true" CausesValidation="false"
                 Visible="true">                                 
             </telerik:RadMenu>   

                </div>
            </CommandItemTemplate>
                </mastertableview>
                <headerstyle font-size="8pt"></headerstyle>
                <clientsettings enablerowhoverstyle="true"  AllowDragToGroup="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="True"  EnableDragToSelectRows="False"  />
                      <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
                </clientsettings>
                <ValidationSettings ValidationGroup="Labor" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
            </telerik:RadGrid>
        </td>
    </tr>
</table>
