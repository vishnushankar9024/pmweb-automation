<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostImpacts.ascx.vb" Inherits="Website.CostImpacts" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
  <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgCostImpacts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgCostImpacts" LoadingPanelID="ldpPM"/>
            </UpdatedControls>                    
        </telerik:AjaxSetting>                       
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

            <telerik:RadGrid ID="rdgCostImpacts" runat="server" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
                 AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15"
                ShowFooter="false" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="true"
                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                   <GroupPanel Text="Group by"></GroupPanel>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true" >
                    <Columns> 
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" DataField="LineNumber" allowfiltering="false"
                            SortExpression="LineNumber" GroupByExpression="LineNumber [Line #] Group By LineNumber ASC"
                            Groupable="false" Reorderable="true">
                            <ItemTemplate>
                                <asp:label runat="server" id="lblLineNumber" Text='<%#Container.DataItem("LineNumber").ToString%>'></asp:label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <asp:label runat="server" id="lblLineNumber" Text='<%#Eval("LineNumber").ToString%>'></asp:label>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                          
                        <telerik:GridTemplateColumn HeaderText="Status" SortExpression="ImpactStatus" DataField="ImpactStatus"
                             UniqueName="ImpactStatus" GroupByExpression="ImpactStatus [GridColumn_ImpactStatus] Group By ImpactStatus">
                             <ItemTemplate>
                                <%#IIf(Container.DataItem("ImpactStatus") = String.Empty, "&nbsp;", Container.DataItem("ImpactStatus"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:DropDownList runat="server" ID="ddlImpactStatuses" Width="100%" />
                             </EditItemTemplate>
                             <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                         </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Item " SortExpression="ItemCode" UniqueName="ItemCode" DataField="ItemCode"
                            GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" runat="server" 
                                    Text='<%#Eval("ItemCode")%>' Width="100%" enabled="false"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                       </telerik:GridTemplateColumn> 

                       <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description" DataField="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description">
                            <ItemTemplate>
                                <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" MaxLength="500" Text='<%#Eval("Description")%>' Width="100%" ></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="220px" HorizontalAlign="Left"></HeaderStyle>
                       </telerik:GridTemplateColumn> 

                        <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" DataField="UOM"
                             GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="ddlUOMs" Width="100%">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                       </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity"  DataField="Quantity"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" >
                            <ItemTemplate>
                                <span style="float:right"><%# FormatNumber(Container.DataItem("Quantity"))%></span>&nbsp;</div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" MaxLength="15" runat="server" Text='<%#FormatNumber(ParseDouble(Eval("Quantity"), 1))%>'
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                       </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Unit Cost" SortExpression="UnitCost" UniqueName="UnitCost" DataField="UnitCost"
                             GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost">
                             <ItemTemplate>
                                 <%#FormatCurrency(Container.DataItem("UnitCost"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtUnitCost" runat="server" Text='<%#FormatCurrency(Eval("UnitCost"))%>'
                                     Width="100%" MaxLength="15" CssClass="Currency"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                             <ItemStyle HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Total Cost" SortExpression="TotalCost" UniqueName="TotalCost" DataField="TotalCost"
                             GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost">
                             <ItemTemplate>
                                 <%#FormatCurrency(Container.DataItem("TotalCost"))%>
                             </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtTotalCost" runat="server" Text='<%#FormatCurrency(Eval("TotalCost"))%>'
                                     Width="100%" MaxLength="15" CssClass="Currency"></asp:TextBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                             <ItemStyle HorizontalAlign="Right" />
                         </telerik:GridTemplateColumn>

                         <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode"   DataField="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px" 
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                    NoWrap="True" AllowCustomText="False" 
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="SaveBudgetDetails" 
                                    Style="font-size: 11px" Height="250px" >
                                </telerik:RadComboBox>
                                  <div>                            
                                    <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>" 
                                        Display="Dynamic" Enabled ="false"  ForeColor="" ValidationGroup="SaveBudgetDetails"></asp:RequiredFieldValidator>
                                  </div>
                           </EditItemTemplate>
                           <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                       </telerik:GridTemplateColumn>
                        
                       <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes"  DataField="Notes"
                                UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
                         <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                         </ItemTemplate>
                         <EditItemTemplate>
                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>
                 
                        
                             <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"  OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					        <span class="Icon"></span>
				            </asp:LinkButton>
                         
                         </EditItemTemplate>
                        <HeaderStyle Width="280px" HorizontalAlign="Left"></HeaderStyle>
                      </telerik:GridTemplateColumn>    
                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="right" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgCostImpacts.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgCostImpacts.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnSaveResource1">
                              <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgCostImpacts.EditIndexes.Count > 0 Or rdgCostImpacts.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add" Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                             <asp:LinkButton ID="btnAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False" 
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1"  OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=CostImpact',910,580,true)">
                               <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                               <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                             <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                 CommandName="SaveState"  Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'>
                                 <asp:Label ID="lblSaveState" runat="server" Text="Save"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                 CausesValidation="False" CommandName="LoadDefaultState"  Visible='<%# rdgCostImpacts.EditIndexes.Count = 0 AND (Not rdgCostImpacts.MasterTableView.IsItemInserted) %>'>
                                 &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="lblLoadDefaultState" Text="Load Default State" runat="server"></asp:Label>
                             </asp:LinkButton>
                             </CommandItemTemplate>
                 </MasterTableView>
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
        AllowDragToGroup="true">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
       </ClientSettings>
             </telerik:RadGrid>
   