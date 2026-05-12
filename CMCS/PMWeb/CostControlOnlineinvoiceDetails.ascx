<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostControlOnlineinvoiceDetails.ascx.vb" Inherits="Website.CostControlOnlineinvoiceDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgOnlineInvoiceDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgOnlineInvoiceDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
<telerik:RadGrid ID="rdgOnlineInvoiceDetails" AllowMultiRowSelection="true" runat="server" ShowGroupPanel="false" AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
      HeaderStyle-Font-Size="8" ShowFooter="true"  
    AutoGenerateColumns="False"  AllowMultiRowEdit="True"  AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="250">
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
        Name="Master">
        <PagerStyle Mode="NextPrevAndNumeric"
         AlwaysVisible="true" />
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber"  DataField="LineNumber" allowfiltering="false"
                Groupable="false" Reorderable="false">
                <ItemTemplate>
                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("LineNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="45px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description"
                SortExpression="Description">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                    <%--<asp:TextBox ID="txtDescription" ReadOnly="true" runat="server" Text='<%# Eval("Description") %>'
                        Width="100%"></asp:TextBox>--%>
                </EditItemTemplate>
                <HeaderStyle Width="156px" />
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" DataField="UOM" SortExpression="UOM" GroupByExpression="UOM [UOM] Group By UOM ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                    <%--<asp:TextBox ID="txtUOM" ReadOnly="true" runat="server" Text='<%# Eval("UOM") %>'
                        Width="100%"></asp:TextBox>--%>
                </EditItemTemplate> 
                <HeaderStyle Width="40px" />
            </telerik:GridTemplateColumn>
           <telerik:GridTemplateColumn HeaderText="Scheduled<br/>Quantity" UniqueName="ScheduledQuantity" DataField="ScheduledQuantity"
              SortExpression="ScheduledQuantity">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("ScheduledQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblScheduledQuantity" runat="server" Width="100%" CssClass="Right"
                        Text='<%#FormatNumber(IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "0", Eval("ScheduledQuantity"))) %>'></asp:Label>
             <%--      <asp:TextBox ID="txtScheduledQuantity"   runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="9" Text='<%#FormatNumber(IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "0", Eval("ScheduledQuantity"))) %>'
                       ></asp:TextBox>--%>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumScheduledQuantity" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="80px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Unit<br/>Cost" UniqueName="UnitCost"  DataField="UnitCost"
                 SortExpression="UnitCost">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("UnitCost"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblUnitCost" runat="server" Width="100%" CssClass="Right"
                        Text='<%# FormatCurrency(Eval("UnitCost")) %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumUnitCost" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Prior<br/>Quantity"  DataField="PriorQuantity" UniqueName="PriorQuantity" SortExpression="PriorQuantity">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("PriorQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorQuantity" runat="server" Width="100%" CssClass="Right"
                        Text='<%#FormatNumber(IIF(Eval("PriorQuantity") is system.DBNULL.value, "0", Eval("PriorQuantity"))) %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumPriorQuantity" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="60px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Current<br/>Quantity" UniqueName="CurrentQuantity" SortExpression="CurrentQuantity" DataField="CurrentQuantity">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("CurrentQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCurrentQuantity" Precision="2" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15"  MinNumber="0" Text='<%#FormatNumber(IIF(Eval("CurrentQuantity") is system.DBNULL.value, "0", Eval("CurrentQuantity"))) %>'
                       ></asp:TextBox>
                </EditItemTemplate>
                  <FooterTemplate>
                    <asp:Label ID="lblSumCurrentQuantity" runat="server"></asp:Label>
                </FooterTemplate>
                <HeaderStyle Width="60px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Total<br/>Quantity" UniqueName="TotalQuantity" DataField="TotalQuantity" SortExpression="TotalQuantity">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("TotalQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTotalQuantity" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15"  MinNumber="0" Text='<%#FormatNumber(IIF(Eval("TotalQuantity") is system.DBNULL.value, "0", Eval("TotalQuantity")),2) %>'
                       ></asp:TextBox>
                        <asp:RangeValidator runat="server"  ID="rgvalTotalQuantity" ValidationGroup="ProgressInvoice" ControlToValidate="txtTotalQuantity" Display="Dynamic" CssClass="validator" ErrorMessage="*"  
                            MinimumValue='<%#FormatNumber(IIF(Eval("PriorQuantity") is system.DBNULL.value, "0", Eval("PriorQuantity"))) %>'
                            MaximumValue='<%#IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "0", Eval("ScheduledQuantity")) %>'></asp:RangeValidator>
                </EditItemTemplate>
                  <FooterTemplate>
                    <asp:Label ID="lblSumTotalQuantity" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="60px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
           <telerik:GridTemplateColumn HeaderText="% Complete" UniqueName="PctComplete" SortExpression="PctComplete" DataField="PctComplete">
                <ItemTemplate>
                    <span><%#FormatPercent(Container.DataItem("PctComplete"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPctComplete" runat="server" Width="100%" CssClass="Percent"
                        MaxLength="15"  MinNumber="0" Text='<%# FormatPercent(IIF(Eval("PctComplete") is system.DBNULL.value, "0", Eval("PctComplete"))) %>'
                       ></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Scheduled<br/>Value" UniqueName="ScheduledValue" DataField="ScheduledValue"
                 SortExpression="ScheduledValue">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("ScheduledValue"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblScheduledValue" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatCurrency(Eval("ScheduledValue")) %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumScheduledValue" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="75px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Prior<br/>Invoices" UniqueName="PriorInvoices" DataField="PriorInvoices"
                 SortExpression="PriorInvoices">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("PriorInvoices"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorInvoices" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatCurrency(Eval("PriorInvoices")) %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumPriorInvoices" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn HeaderText="Current<br/>Invoice" UniqueName="CurrentInvoice" DataField="CurrentInvoice"
                 SortExpression="CurrentInvoice">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("CurrentInvoice"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCurrentInvoices"  MinNumber="0" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("CurrentInvoice")) %>'></asp:TextBox>
                </EditItemTemplate>
                  <FooterTemplate>
                    <asp:Label ID="lblSumCurrentInvoice" runat="server"></asp:Label>
                </FooterTemplate>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>                     
                   <telerik:GridTemplateColumn HeaderText="Stored<br/>Material" UniqueName="StoredMaterial" DataField="StoredMaterial"
                 SortExpression="StoredMaterial">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("StoredMaterial"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtStoredMaterial" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("StoredMaterial")) %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumStoredMaterial" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Total This<br/>Invoice" UniqueName="TotalThisInvoice" DataField="TotalThisInvoice"
                 SortExpression="TotalThisInvoice">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("TotalThisInvoice"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblTotalThisInvoice" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatCurrency(Eval("TotalThisInvoice")) %>'></asp:Label>
                </EditItemTemplate>
                  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
          <telerik:GridTemplateColumn HeaderText="Total<br/>Invoiced" UniqueName="TotalInvoiced" DataField="TotalInvoiced"
                 SortExpression="TotalInvoiced">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("TotalInvoiced"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblTotalInvoiced" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatCurrency(Eval("TotalInvoiced")) %>'></asp:Label>
                </EditItemTemplate>
                  <FooterTemplate>
                    <asp:Label ID="lblSumTotalInvoiced" runat="server"></asp:Label>
                </FooterTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            <telerik:GridTemplateColumn HeaderText="Balance to<br/>Invoice" UniqueName="BalanceToInvoice" DataField="BalanceToInvoice"
                 SortExpression="BalanceToInvoice">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("BalanceToInvoice"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblBalanceToInvoice" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatCurrency(Eval("BalanceToInvoice")) %>'></asp:Label>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumBalanceToInvoice" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="72px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Services<br/>Retain %" UniqueName="PctServicesRetain" DataField="PctServicesRetain"
                 SortExpression="PctServicesRetain">
                <ItemTemplate>
                    <span><%#FormatPercent(Container.DataItem("PctServicesRetain"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPctServicesRetain" MinNumber="0" MaxNumber="100" CssClass="Percent" runat="server" Width="100%" MaxLength="15"
                        Text='<%#  FormatPercent(Eval("PctServicesRetain")) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="72px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Services Retain<br/>Amount" UniqueName="ServicesRetainAmount" DataField="ServicesRetainAmount"
                 SortExpression="ServicesRetainAmount">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("ServicesRetainAmount"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtServicesRetainAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("ServicesRetainAmount")) %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumServicesRetainAmount" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="92px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            <telerik:GridTemplateColumn HeaderText="Materials<br/>Retain %" UniqueName="PctMaterialsRetain" DataField="PctMaterialsRetain"
                 SortExpression="PctMaterialsRetain">
                <ItemTemplate>
                    <span><%#FormatPercent(Container.DataItem("PctMaterialsRetain"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPctMaterialsRetain" CssClass="Percent" runat="server" Width="100%" MaxLength="15"
                        Text='<%#  FormatPercent(Eval("PctMaterialsRetain")) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="72px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
        <telerik:GridTemplateColumn HeaderText="Materials Retain<br/>Amount" UniqueName="MaterialsRetainAmount" DataField="MaterialsRetainAmount"
                 SortExpression="MaterialsRetainAmount">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("MaterialsRetainAmount"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMaterialsRetainAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("MaterialsRetainAmount")) %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblSumMaterialsRetainAmount" runat="server"></asp:Label> 
                </FooterTemplate>
                <HeaderStyle Width="92px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
              <telerik:GridTemplateColumn HeaderText="Total<br/>Retained" UniqueName="TotalRetained" DataField="TotalRetained"
                 SortExpression="TotalRetained">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("TotalRetained"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTotalRetained" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("TotalRetained")) %>'></asp:TextBox>
                </EditItemTemplate>
                  <FooterTemplate>
                    <asp:Label ID="lblSumTotalRetained" runat="server"></asp:Label>
                </FooterTemplate>
                <HeaderStyle Width="75px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes"  DataField="Notes"
                SortExpression="Notes"  >
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="CCO #" UniqueName="CCONumber"  DataField="CCONumber"
                SortExpression="CCONumber"  >
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CCONumber").ToString = String.Empty, "&nbsp;", Container.DataItem("CCONumber").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCCONumber" runat="server" Text='<%# Eval("CCONumber") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="true" Height="30px" HorizontalAlign="Left"/>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                &nbsp;&nbsp;
                <asp:Button ID="btnChangeOrders" runat="server" CausesValidation="False" CommandName="ChangeOrders" 
                    SecurityButtonType="ItemMode_Add" Text="Change Orders" meta:resourcekey="btnChangeOrders"
                    Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count = 0 AND (Not rdgOnlineInvoiceDetails.MasterTableView.IsItemInserted) %>'
                    />
                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" 
                    Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count = 0 AND (Not rdgOnlineInvoiceDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="ProgressInvoice"
                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"  Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count > 0 %>' >
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"  CssClass="GridCmdCancelAll" 
                    Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count > 0 Or rdgOnlineInvoiceDetails.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                     <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>     
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count = 0 AND (Not rdgOnlineInvoiceDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                     <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                 <asp:LinkButton ID="btnSaveState" runat="server"  CausesValidation="False"
                        CommandName="SaveState"  Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count = 0 AND (Not rdgOnlineInvoiceDetails.MasterTableView.IsItemInserted) %>'>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" 
                        CausesValidation="False" CommandName="LoadDefaultState" Visible='<%# rdgOnlineInvoiceDetails.EditIndexes.Count = 0 AND (Not rdgOnlineInvoiceDetails.MasterTableView.IsItemInserted) %>'>
                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                    </asp:LinkButton>
                    &nbsp;&nbsp;            
            </div>
        </CommandItemTemplate>
    </MasterTableView>
    <HeaderStyle Font-Size="8pt"></HeaderStyle>
    <ClientSettings EnableRowHoverStyle="true"  allowdragtogroup="True" allowrowsdragdrop="False">                   
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        <Resizing EnableRealTimeResize="True"  ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" 
             AllowColumnResize="True" />
    </ClientSettings>
</telerik:RadGrid>