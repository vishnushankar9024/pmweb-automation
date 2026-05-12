<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InventoryLocationDetails.ascx.vb" Inherits="Website.InventoryLocationDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInventoryDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInventoryDetails" LoadingPanelID="ldpPM" />      
            </UpdatedControls>
        </telerik:AjaxSetting>
          
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

                                                       
   <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
        </telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
<telerik:RadGrid ID="rdgInventoryDetails" AllowMultiRowSelection="true" CssClass="WithoutTopBorder" runat="server"  AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
      HeaderStyle-Font-Size="8" Width="100%" ShowGroupPanel="true" UseEditFormInMobile ="true"  
    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true"  PageSize="250" AllowPaging="true">
     <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" TableLayout = "Fixed"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">
               
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Stock #" HeaderStyle-Width="50px" 
                HeaderStyle-Wrap="false" Groupable="false" Reorderable="true" UniqueName="StockNumber" DataField="StockNumber">
                <ItemTemplate>
                  <span> <%#Container.DataItem("StockNumber").ToString%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                   <span> <%#Eval("StockNumber").ToString%></span> 
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Sub Location" HeaderStyle-Width="50px" SortExpression="Sublocation"
            GroupByExpression="Sublocation [GridColumn_Sublocation] Group By Sublocation ASC" UniqueName="Sublocation" DataField="StockNumber">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Sublocation") = String.Empty, "&nbsp;", Container.DataItem("Sublocation"))%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlSublocation" runat="server" Skin="Default" CloseDropDownOnBlur="true" 
                        Width="100%" NoWrap="true" CausesValidation="False">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="60px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Item*" HeaderStyle-Width="50px" SortExpression="ItemCode" ItemStyle-HorizontalAlign="Right"
             GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC" DataField="ItemCode"
                UniqueName="Item">
                <ItemTemplate>
                   <span> 
                   <%#IIf(Container.DataItem("ItemCode") = String.Empty Or Container.DataItem("ItemCode") = "0", "&nbsp;", Container.DataItem("ItemCode").ToString)%>
                   </span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlLItems" OnClientLoad="ddlItemLoad" OnClientSelectedIndexChanged="ddlItems_OnClientSelectedIndexChanged"
                        Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                        CloseDropDownOnBlur="true"  height="300px" NoWrap="False" AllowCustomText="true"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddlItems_ItemsRequested">
                        <CollapseAnimation Duration="200" Type="OutQuint" />
                    </telerik:RadComboBox>
                      <asp:RequiredFieldValidator ID="rfvItems" runat="server" ControlToValidate="ddlLItems"
                                    CssClass="Validator" meta:resourcekey="rfvRequired" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                     ValidationGroup="InventoryDetails"></asp:RequiredFieldValidator>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" UniqueName="Description"
                HeaderStyle-Width="100px" SortExpression="Description"  DataField="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>  
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" MaxLength="300" runat="server" Text='<%# Eval("Description") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Condition" UniqueName="Condition" DataField="Condition" HeaderStyle-Width="100px" SortExpression="Condition" GroupByExpression="Condition [GridColumn_Condition] Group By Condition ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Condition") = String.Empty, "&nbsp;", Container.DataItem("Condition"))%></span>  
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCondition" Filter="Contains" MarkFirstMatch="true" CausesValidation="False" Width="100%" AllowCustomText="True"
                        runat="server" Skin="Default" height="300px" >
                    </telerik:RadComboBox>
                </EditItemTemplate>
             </telerik:GridTemplateColumn>
              <telerik:GridTemplateColumn HeaderText="Condition Date" DataField="ConditionDate"  SortExpression="ConditionDate"  GroupByExpression="ConditionDate [GridColumn_ConditionDate] Group By ConditionDate"
                UniqueName="ConditionDate">
                <ItemTemplate>
                     <span><%#FormatDate(Container.DataItem("ConditionDate"))%> &nbsp;</span>
                </ItemTemplate>
                  <ItemStyle HorizontalAlign="Right"></ItemStyle>
                <EditItemTemplate>
                    <telerik:RadDatePicker ID="dtpConditionDate" runat="server" EnableTyping="True" MaxDate="2100-01-01"
                        MinDate="1901-01-01" Skin="Default" Width="100%">
                        <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"
                            Skin="Default">
                        </DateInput>
                        <Calendar ID="Calendar2" runat="server"  Skin="Default">
                        </Calendar>
                    </telerik:RadDatePicker>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="UOM" DataField="UOM"  UniqueName="UOM" HeaderStyle-Width="50px" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>  
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUom" Filter="Contains" MarkFirstMatch="true" CausesValidation="False" Width="100%"
                        runat="server" Skin="Default" height="300px" AllowCustomText="True">
                    </telerik:RadComboBox>
                </EditItemTemplate>
             </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Stocked"  ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="50px" SortExpression="Stocked" DataField="Stocked" UniqueName="Stocked" GroupByExpression="Stocked [GridColumn_Stocked] Group By Stocked ASC">
                <ItemTemplate>
                 <span><%#FormatNumber(Eval("Stocked").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
           <asp:TextBox CssClass="PositiveDouble" runat="server" ID="txtStocked" MaxLength="15" Width="100%"
                Text='<%#FormatNumber(Eval("Stocked").ToString)%>' onChange="ChangeOnHand();"></asp:TextBox>
                </EditItemTemplate>
                  
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Used"  ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="50px" SortExpression="Used" UniqueName="Used" DataField="Used" GroupByExpression="Used [GridColumn_Used] Group By Used ASC">
                <ItemTemplate>
                        <span><%#FormatNumber(Eval("Used").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                        <asp:TextBox CssClass="PositiveDouble"  ReadOnly="true"  runat="server" ID="txtUsed" 
               Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Unusable"  ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="50px" SortExpression="Unusable" UniqueName="Unusable" DataField="Unusable" GroupByExpression="Unusable [GridColumn_Unusable] Group By Unusable ASC">
                <ItemTemplate>
                   <span><%#FormatNumber(Eval("Unusable").ToString)%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                 <asp:TextBox CssClass="PositiveDouble"  ReadOnly="true"  runat="server" ID="txtUnusable" 
               Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Moved" HeaderStyle-HorizontalAlign="Center"  ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="50px" SortExpression="Moved" UniqueName="Moved" DataField="Moved" GroupByExpression="Moved [GridColumn_Moved] Group By Moved ASC">
                <ItemTemplate>
                     <span><%#FormatNumber(Eval("Moved").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                        <asp:TextBox CssClass="PositiveDouble"  ReadOnly="true"  runat="server" ID="txtMoved" 
               Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="On Hand" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                HeaderStyle-Width="50px" SortExpression="OnHand" DataField="OnHand" UniqueName="OnHand" GroupByExpression="OnHand [GridColumn_OnHand] Group By OnHand ASC">
                <ItemTemplate>
                   <span><%#FormatNumber(Eval("OnHand").ToString)%></span>  
                </ItemTemplate>
                <EditItemTemplate>
                     <asp:TextBox CssClass="PositiveDouble" runat="server" ID="txtOnHand" 
                Text='<%#FormatNumber(Eval("OnHand").ToString)%>' Width="100%" ></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Unit Cost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" UniqueName="UnitCost"
                HeaderStyle-Width="50px"  DataField="UnitCost" ItemStyle-HorizontalAlign="Right"  SortExpression="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                <ItemTemplate>
                    <span><%#FormatCurrency(ParseDouble(Eval("UnitCost")))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                <asp:TextBox ID="txtUnitCost" MaxLength="15" Width="100%" Text='<%#FormatCurrency(ParseDouble(Eval("UnitCost")))%>' CssClass="Currency" onChange="CalculateExtCost();" runat="server"></asp:TextBox>  
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Ext Cost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false"
                HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DataField="ExtCost" UniqueName="ExtCost" SortExpression="ExtCost"  GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC">
                <ItemTemplate>
                   <span><%#FormatCurrency(ParseDouble(Eval("ExtCost")))%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                <asp:TextBox ID="txtExtCost" MaxLength="15" Text='<%#FormatCurrency(ParseDouble(Eval("ExtCost")))%>' CssClass="Currency" Width="100%" runat="server"></asp:TextBox>  
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Manufacturer" HeaderStyle-Width="100px"  UniqueName="ManufacturerName"
            SortExpression="ManufacturerName" DataField="ManufacturerName" GroupByExpression="ManufacturerName [GridColumn_ManufacturerName] Group By ManufacturerName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("ManufacturerName") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerName"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlManufacturer" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                        Width="100%" NoWrap="true" CausesValidation="False" AutoPostBack="false" 
                        EnableItemCaching="false" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Mfr. Number" UniqueName="MfrNumber" DataField="MfrNumber" 
                HeaderStyle-Width="50px" SortExpression="MfrNumber" GroupByExpression="MfrNumber [GridColumn_MfrNumber] Group By MfrNumber ASC">
                <ItemTemplate>
                   <span><%#IIf(Container.DataItem("MfrNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("MfrNumber").ToString)%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMfrNumber" MaxLength="50" OnclientLoad="MfrNumberLoad(this,events);" runat="server"
                        Text='<%# Eval("MfrNumber") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Serial #"  HeaderStyle-Wrap="false" DataField="SerialNumber"
                HeaderStyle-Width="50px" SortExpression="SerialNumber" UniqueName="SerialNumber"  GroupByExpression="SerialNumber [GridColumn_SerialNumber] Group By SerialNumber ASC">
                <ItemTemplate>
                   <span><%#IIf(Container.DataItem("SerialNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("SerialNumber").ToString)%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtSerialNumber" MaxLength="50" runat="server" Text='<%# Eval("SerialNumber") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Lot #" HeaderStyle-Wrap="false" UniqueName="LotNumber" DataField="LotNumber"
                HeaderStyle-Width="50px" SortExpression="LotNumber" GroupByExpression="LotNumber [GridColumn_LotNumber] Group By LotNumber ASC">
                <ItemTemplate>
                      <span><%#IIf(Container.DataItem("LotNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("LotNumber").ToString)%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLotNumber" MaxLength="50" runat="server" Text='<%# Eval("LotNumber") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Add Date" HeaderStyle-Wrap="false" UniqueName="AddDate" DataField="AddDate"
                HeaderStyle-Width="50px" SortExpression="AddDate" GroupByExpression="AddDate [GridColumn_AddDate] Group By AddDate ASC">
                <ItemTemplate>
                      <span><%#IIf(FormatDate(Container.DataItem("AddDate"))=String.Empty,"&nbsp;",FormatDate(Container.DataItem("AddDate")))%></span> 
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddDate" Width="100%"  onclick="showDatePopup(this, event,true);"
                         onfocus="showDatePopup(this, event,true);" onblur="parseDate(this, event);"
                         Text='<%#FormatDate(EVAL("AddDate"))%>' runat="server"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Notes" HeaderStyle-HorizontalAlign="Center" UniqueName="Notes"
                HeaderStyle-Width="50px" SortExpression="Notes" DataField="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
                <ItemTemplate>
                      <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span> 
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" MaxLength="500" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            
        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 AND (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1" SecurityButtonType="ItemMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="InventoryDetails" CssClass="GridCmdUpdateEdited"
                                CommandName="UpdateEdited" Visible='<%# rdgInventoryDetails.EditIndexes.Count > 0 %>'
                                meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="InventoryDetails" CommandName="PerformInsert" style="width:60px" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add" Visible='<%# rdgInventoryDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"  CssClass="GridCmdCancelAll"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count > 0 Or rdgInventoryDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 AND (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1" SecurityButtonType="ItemMode_Add">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnMove" SecurityButtonType="ItemMode_Add" runat="server" CommandName="MoveOut" OnClientClick="return OnMoveClick();" CssClass="GridCmdMoveOut_disabled"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 AND (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblMoveLine" meta:resourcekey="lblMoveLine" runat="server" Text="Move line"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnMoveHistory" SecurityButtonType="ItemMode_Add" runat="server" CommandName="MoveHistory" OnClientClick="return OnMoveClick();" CssClass="GridCmdMoveHistory_disabled"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 AND (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblMoveHistory" meta:resourcekey="lblMoveHistory" runat="server" Text="Move History"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 AND (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1"
                                SecurityButtonType="ItemMode_Delete">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 And (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1" SecurityButtonType="ItemMode">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <telerik:RadComboBox ID="ddlStockStatus" runat="server" OnSelectedIndexChanged="ddlStockStatus_SelectedIndexChanged"
                                SecurityButtonType="ItemMode" Width="205px" AutoPostBack="true"   Style="font-size: 11px"
                                Visible='<%# rdgInventoryDetails.EditIndexes.Count = 0 AND (Not rdgInventoryDetails.MasterTableView.IsItemInserted) %>'>
                                <Items>
                                    <telerik:RadComboBoxItem Text="Current Stock" Value="CURRENT" Selected="true" meta:resourcekey="ddlStockStatus_CURRENT" />
                                    <telerik:RadComboBoxItem Text="Past Stock" Value="PAST" meta:resourcekey="ddlStockStatus_PAST" />
                                    <telerik:RadComboBoxItem Text="Current & Past Stock" Value="CURRENTPAST" meta:resourcekey="ddlStockStatus_CURRENTPAST" />
                                </Items>
                            </telerik:RadComboBox>
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
    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true"  allowdragtogroup="True" allowrowsdragdrop="False">                   
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        <ClientEvents OnRowDblClick="RowDblClick" OnRowSelected="Inventory_OnRowSelected" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                    AllowColumnResize="True" />
    </ClientSettings>
</telerik:RadGrid>
</div>
        </div>
    </div>

<telerik:RadAjaxPanel ID="InventoryMovePanel" runat="server" Height="100%" Width="100%">
</telerik:RadAjaxPanel>
