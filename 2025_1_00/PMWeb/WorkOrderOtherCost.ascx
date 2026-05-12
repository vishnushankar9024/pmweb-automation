<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderOtherCost.ascx.vb" Inherits="Website.WorkOrderOtherCost" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgOtherCosts">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOtherCosts" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblWorkOrderHeader" />
            </UpdatedControls>
        </telerik:AjaxSetting>      
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
   
<%--<table style="width:100%" >
<tr>
<td>--%>
<telerik:RadGrid ID="rdgOtherCosts" UseEditFormInMobile="true" AllowMultiRowSelection="true" runat="server" CssClass="WithoutTopBorder"
      HeaderStyle-Font-Size="8"  ShowGroupPanel="true" GroupHeaderItemStyle-Width="1%" AllowMultiRowEdit="True" SetWidth="true" AppendMenus = "true"
    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true"  AllowPaging="true" PageSize="250" ShowFooter="True" Width="100%">
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
        TableLayout="Fixed" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" 
        EditMode="InPlace" >
         <PagerStyle Mode="NextPrevAndNumeric"  AlwaysVisible="true"/>
        <Columns>
           <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Width="55px" 
                HeaderStyle-Wrap="false" Groupable="false" Reorderable="false"    >
                <ItemTemplate>             
                    <%#IIf(Container.DataItem("LineNumber").ToString = "0", "&nbsp;", Container.DataItem("LineNumber").ToString)%> 
                </ItemTemplate>
                <EditItemTemplate>
                   <%#IIf(Eval("LineNumber").ToString = "0", "&nbsp;", Eval("LineNumber").ToString)%> 
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>    
            <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-Width="60px" SortExpression="ItemDescription" 
             GroupByExpression="ItemDescription [GridColumn_Item] Group By ItemDescription ASC"
                UniqueName="Item">
                <ItemTemplate>
                <span>
                    <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                     <asp:TextBox ID="txtItem" runat="server" Text='<%# Eval("ItemCode") %>' ReadOnly="true" Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-HorizontalAlign="Center" UniqueName="Description"
                HeaderStyle-Width="200px" SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                <ItemTemplate>
                <span>
                    <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" Text='<%# Eval("Description") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>   
            <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="90px" SortExpression="OtherCostType" UniqueName="OtherCostType"
             GroupByExpression="OtherCostType [GridColumn_OtherCostType] Group By OtherCostType ASC" >
                <ItemTemplate>
                <span>
                    <%#IIf(Container.DataItem("OtherCostType") = String.Empty, "&nbsp;", Container.DataItem("OtherCostType"))%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                 <telerik:RadComboBox ID="ddlCostType" Filter="Contains" MarkFirstMatch="true" CausesValidation="False" AllowCustomText="True"
                        runat="server" Skin="Default" Width="100%">
                    </telerik:RadComboBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="CostCode" ItemStyle-Wrap="false" HeaderText="Cost Code" SortExpression="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC"> 
                <ItemTemplate> 
                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                    </asp:HyperLink>
                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostCode" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                        EnableItemCaching="false" MarkFirstMatch="true"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                        NoWrap="True" AllowCustomText="true" Style="font-size: 11px" Height="250px" OnItemsRequested="ddl_ItemsRequested"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderStyle-Width="110px" UniqueName="Period"  ItemStyle-Wrap="false" HeaderText="Cost Period"
                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Groupable="true" Reorderable="true"
                    SortExpression="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC" > 
                <ItemTemplate>
                    <span><%# IIf(CStr(Eval("Period")) = String.Empty, "&nbsp;", Eval("Period"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%" DropDownWidth="255px" 
                        EnableItemCaching="false"  OnItemsRequested="ddl_ItemsRequested"
                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." meta:resourcekey="ddlPeriods"
                        NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="200px"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" HeaderStyle-Width="90px" SortExpression="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                <ItemTemplate>
                <span>
                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUom" Filter="Contains" MarkFirstMatch="true" CausesValidation="False" AllowCustomText="True"
                        runat="server" Skin="Default" Width="100%" Height="250px" >
                    </telerik:RadComboBox>
                </EditItemTemplate>    
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Quantity" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right" UniqueName="Quantity"
                HeaderStyle-Width="60px" SortExpression="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC">
                <ItemTemplate>
                <span>
            <%#FormatNumber(Container.DataItem("Quantity"))%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15"  MinNumber="0" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "0", Eval("Quantity"))) %>'
                       ></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            
            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                 GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC">
                <ItemTemplate>
                    <span><%#Eval("Currency")%></span>
                </ItemTemplate>
                <EditItemTemplate>
                     <telerik:RadComboBox Width="100%"  ID="ddlCurrencies" DropDownWidth="250px" runat="server" Skin="Default" Style="font-size: 11px" Height="300px">
                                 </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="85px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Unit Cost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" UniqueName="UnitCost"
                HeaderStyle-Width="60px" ItemStyle-HorizontalAlign="Right"  SortExpression="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC">
                <ItemTemplate>
                <span>
                    <%#FormatCurrency(ParseDouble(Eval("UnitCost")),CurrencyId:=Eval("CurrencyId"))%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                   <asp:textbox ID="txtUnitCost" runat="server" Width="100%" CssClass="Currency" MaxLength="15"
                         Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId"))) %>'></asp:textbox>
                </EditItemTemplate>
                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                    <ItemStyle HorizontalAlign="Right" Wrap="False" Width="120px"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Ext Cost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" UniqueName="ExtCost"
                HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" SortExpression="ExtCost"  GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC">
                <ItemTemplate>
                <span>
                    <%#FormatCurrency(ParseDouble(Eval("ExtCost")),CurrencyId:=Eval("CurrencyId"))%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                   <asp:textbox ID="txtExtCost" runat="server" Width="100%" CssClass="Currency" MaxLength="15"
                         Text='<%# FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId"))) %>' Enabled="false" ></asp:textbox>
                         
                </EditItemTemplate>
                   <FooterTemplate>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" ></asp:Label>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                    <ItemStyle HorizontalAlign="Right" Wrap="False" Width="120"></ItemStyle>
            </telerik:GridTemplateColumn>  
            <telerik:GridTemplateColumn HeaderText="Stock #" HeaderStyle-Width="60px" 
                HeaderStyle-Wrap="false" UniqueName="StockNumber" GroupByExpression="StockNumber [GridColumn_StockNumber] Group By StockNumber ASC"  >
                <ItemTemplate>  
                <span>         
                    <%#IIf(Container.DataItem("StockNumber").ToString = "0", "&nbsp;", Container.DataItem("StockNumber").ToString)%> 
                </span>  
                </ItemTemplate>
                <EditItemTemplate>
                <asp:TextBox ID="txtStockNumber" ReadOnly="true" runat="server" Text='<%#IIf((Eval("StockNumber").ToString = String.Empty Or Eval("StockNumber").ToString = "0"), "&nbsp;", Eval("StockNumber").ToString) %>  '
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>               
            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center"
                HeaderStyle-Width="120px" SortExpression="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" >
                <ItemTemplate>
                <span>
                    <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                </span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" MaxLength="300" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
            </telerik:GridTemplateColumn>    
        </Columns>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" 
                    SecurityButtonType="ItemMode_Edit" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems" 
                    SecurityButtonType="ItemMode_Add" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'
                    OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=WorkOrderOtherCost',910,580,true,'rdgOtherCosts');">
                   <span class="Icon"></span>
                    <asp:Label ID="lblAddItems" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton> 
                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="EstimateMarkup" CssClass="GridCmdUpdateEdited" 
                    SecurityButtonType="AddEditMode_Edit" 
                    CommandName="UpdateEdited" Visible='<%# rdgOtherCosts.EditIndexes.Count > 0 %>'
                    meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="EstimateMarkup" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" 
                    SecurityButtonType="AddEditMode_Add" 
                    Visible='<%# rdgOtherCosts.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" 
                    SecurityButtonType="AddEditMode" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count > 0 Or rdgOtherCosts.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" 
                    SecurityButtonType="ItemMode_Add" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" CssClass="GridCmdDeleteRows" 
                    SecurityButtonType="ItemMode_Delete" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" 
                    SecurityButtonType="ItemMode" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnPickInventory" runat="server" CommandName="PickInventory"  CssClass="GridCmdPickInventory" 
                    OnClientClick="return OpenPOPUp('PickInventory.aspx?Id=0',900, 600,true,'rdgOtherCosts');"
                    SecurityButtonType="ItemMode_Add" 
                    Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'>
                     <span class="Icon"></span>
                    <asp:Label ID="lblPickInventory" meta:resourceKey="lblPickInventory" runat="server" Text="Pick Inventory"></asp:Label>
                </asp:LinkButton>
                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                 OnClientClick="return OpenPreviewConversionCosts();" style="float:none !important" 
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgOtherCosts.EditIndexes.Count = 0 AND (Not rdgOtherCosts.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                 &nbsp;&nbsp;
                            </asp:LinkButton>
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <HeaderStyle Font-Size="8pt"></HeaderStyle>
    <ClientSettings EnableRowHoverStyle="true"   allowdragtogroup="True" allowrowsdragdrop="False">                   
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        <ClientEvents OnRowDblClick="RowDblClick"   />
                <Resizing EnableRealTimeResize="True"  ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" 
             AllowColumnResize="True" />
    </ClientSettings>
</telerik:RadGrid>
<%--</td>
</tr>
</table>
--%>