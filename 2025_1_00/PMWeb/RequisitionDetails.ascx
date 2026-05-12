<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RequisitionDetails.ascx.vb" Inherits="Website.RequisitionDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="UserDefinedFields.ascx" tagname="UserDefinedFields" tagprefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRequisitionDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRequisitionDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tblRecap" />
               
            </UpdatedControls>
        </telerik:AjaxSetting>  
    </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
            MaxDate="12/31/2100" runat="server" Skin="Default">
            <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
<telerik:RadGrid ID="rdgRequisitionDetails" AllowMultiRowSelection="true" runat="server" ShowGroupPanel="true"
      HeaderStyle-Font-Size="8" ShowFooter="true"   FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
    AutoGenerateColumns="False"  AllowMultiRowEdit="true"  AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="250" AllowFilteringByColumn="true">
                         <PagerStyle Mode="NextPrevAndNumeric"
         AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id,Manually" ClientDataKeyNames="Id,Manually" CommandItemDisplay="Top" Width="100%"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
        Name="Master" EnableHeaderContextMenu="true" ShowFooter ="true" ShowGroupFooter="true">
        
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber"  SortExpression="LineNumber"
                Groupable="false" Reorderable="false" DataField="LineNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                   <asp:HiddenField runat="server" ID="hdnRequisitionDetailId" Value='<%#Eval("Id")%>' />
                     <span><%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span><%#Eval("LineNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="45px" />
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" 
                SortExpression="Description"  GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblDescription" runat="server" Text='<%#IIf(Eval("Description").ToString = String.Empty, "&nbsp;", Eval("Description").ToString)%>' Width="100%"></asp:Label>
                    <asp:TextBox ID="txtDescription" MaxLength ="500" runat="server" Text='<%# Eval("Description") %>'
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="156px" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox Width="100%"  ID="ddlCurrency"  runat="server" Skin="Default" Style="font-size: 11px">
                                 </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                           <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" 
                 GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblUOM" runat="server" Width="100%" 
                        Text='<%#IIf(Eval("UOM") Is System.DBNull.Value, "&nbsp;", Eval("UOM"))%>'></asp:Label>
                    <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                </EditItemTemplate> 
                <HeaderStyle Width="40px" />
            </telerik:GridTemplateColumn>
           <telerik:GridTemplateColumn HeaderText="Scheduled<br/>Quantity" UniqueName="ScheduledQuantity" 
              SortExpression="ScheduledQuantity"   Groupable="false" DataField ="ScheduledQuantity"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
               CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                      <div id='<%# "Detail_" & Eval("DetailId").tostring()%>' oncontextmenu="contextM(this,event)" style="width:100%;height:100%;" >
                                <span style="float:right"><%# FormatNumber(Container.DataItem("ScheduledQuantity"))%></span>&nbsp;</div>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblScheduledQuantity" runat="server" Width="100%" CssClass="Right"
                        Text='<%#FormatNumber(IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "1", Eval("ScheduledQuantity"))) %>'></asp:Label>
                    <asp:TextBox ID="txtScheduledQuantity" runat="server" Width="100%" CssClass="Double"
                        MaxLength="15" Text='<%#FormatNumber(IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "1", Eval("ScheduledQuantity"))) %>'
                       ></asp:TextBox>
                </EditItemTemplate>
             <%--   <FooterTemplate>
                    <asp:Label ID="lblSumScheduledQuantity" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="60px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField ="Adjustment1"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            >
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("Adjustment1"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                            <asp:Label Text='<%#FormatNumber(Eval("Adjustment1"))%>' runat="server" ID="lblEditAdjustment1" CssClass ="Double" />
                        </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                                      <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField ="Tax"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("Tax"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                    <asp:Label Text='<%#FormatNumber(Eval("Tax"))%>' runat="server" ID="lblEditTax" CssClass ="Double" /> </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                                     <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField ="Adjustment2"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                 <asp:Label Text='<%#FormatCurrency(Container.DataItem("Adjustment2"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label Text='<%#FormatNumber(Eval("Adjustment2"))%>' runat="server" ID="lblEditAdjustment2" CssClass ="Double" /></EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Unit Price" UniqueName="UnitCost"
                 SortExpression="UnitCost" Groupable="false" DataField ="UnitCost"  Aggregate="Avg" FooterAggregateFormatString="{0:F6}"
                  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblUnitPrice" runat="server" Width="100%" CssClass="Right"
                        Text='<%# FormatNumber(Eval("UnitCost")) %>'></asp:Label>
                    <asp:TextBox ID="txtUnitPrice"   CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("UnitCost")) %>'></asp:TextBox>
                </EditItemTemplate>
              <%--  <FooterTemplate>
                    <asp:Label ID="lblSumUnitCost" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Prior<br/>Quantity" UniqueName="PriorQuantity" 
            SortExpression="PriorQuantity"   Groupable="false" DataField ="PriorQuantity"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
             CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem( "PriorQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorQuantity" runat="server" Width="100%" CssClass="Right"
                        Text='<%#FormatNumber(IIF(Eval("PriorQuantity") is system.DBNULL.value, "0", Eval("PriorQuantity"))) %>'></asp:Label>
                </EditItemTemplate>
              <%--  <FooterTemplate>
                    <asp:Label ID="lblSumPriorQuantity" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="60px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Current<br/>Quantity"   Groupable="false"  DataField ="CurrentQuantity"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
            UniqueName="CurrentQuantity" SortExpression="CurrentQuantity" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("CurrentQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCurrentQuantity" runat="server" Width="100%" CssClass="Double"
                        MaxLength="15"   Text='<%#FormatNumber(IIF(Eval("CurrentQuantity") is system.DBNULL.value, "0", Eval("CurrentQuantity"))) %>'
                       ></asp:TextBox>
                </EditItemTemplate>
                 <%-- <FooterTemplate>
                    <asp:Label ID="lblSumCurrentQuantity" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="60px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Total<br/>Quantity"  Groupable="false"  DataField ="TotalQuantity"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                UniqueName="TotalQuantity" SortExpression="TotalQuantity" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatNumber(Container.DataItem("TotalQuantity"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTotalQuantity" runat="server" Width="100%" CssClass="Double"
                        MaxLength="15"   Text='<%#FormatNumber(IIF(Eval("TotalQuantity") is system.DBNULL.value, "0", Eval("TotalQuantity"))) %>'
                       ></asp:TextBox>
                       <%-- <asp:CustomValidator id="cusTotalQuantity"
                           ControlToValidate="txtTotalQuantity"
                           ClientValidationFunction="ValidateTotalQty"
                           Display="Dynamic"
                           CssClass="validator"
                           ErrorMessage="*"
                           runat="server"
                           ValidationGroup="Requisition"/>--%>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalQuantity" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="60px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
           <telerik:GridTemplateColumn HeaderText="% Complete"  Groupable="false" 
            UniqueName="PctComplete" SortExpression="PctComplete" DataField="PctComplete" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
             <telerik:GridTemplateColumn   Groupable="false"
             HeaderText="Scheduled<br/>Value" UniqueName="ScheduledValue" DataField ="ScheduledValue"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                 SortExpression="ScheduledValue" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("ScheduledValue"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblScheduledValue" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("ScheduledValue")) %>'></asp:Label>
                    <asp:TextBox ID="txtScheduledValue"   CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("ScheduledValue")) %>'></asp:TextBox>
                </EditItemTemplate>
               <%-- <FooterTemplate>
                    <asp:Label ID="lblSumScheduledValue" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="75px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn   Groupable="false"
                HeaderText="Prior<br/>Invoices" UniqueName="PriorInvoices"  DataField ="PriorInvoices"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                 SortExpression="PriorInvoices" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("PriorInvoices"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorInvoices" runat="server" Width="100%" CssClass="Double"
                         Text='<%# FormatNumber(Eval("PriorInvoices")) %>'></asp:Label>
                </EditItemTemplate>
              <%--  <FooterTemplate>
                    <asp:Label ID="lblSumPriorInvoices" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
               <telerik:GridTemplateColumn   Groupable="false"
               HeaderText="Current<br/>Invoice" UniqueName="CurrentInvoice" DataField ="CurrentInvoice"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                 SortExpression="CurrentInvoice" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("CurrentInvoice"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCurrentInvoices"  CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("CurrentInvoice")) %>'></asp:TextBox>
                </EditItemTemplate>
                 <%-- <FooterTemplate>
                    <asp:Label ID="lblSumCurrentInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="65px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>                     
                    <telerik:GridTemplateColumn HeaderText="Prior Stored<br/>Material" GroupByExpression="PriorStoredMaterial [GridColumn_PriorStoredMaterial] Group By PriorStoredMaterial ASC" UniqueName="PriorStoredMaterial"
                 SortExpression="PriorStoredMaterial" DataField ="PriorStoredMaterial"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("PriorStored"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorStoredMaterial" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("PriorStoredMaterial")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
                                  <telerik:GridTemplateColumn HeaderText="Current Stored<br/>Material" GroupByExpression="CurrentStoredMaterial [GridColumn_CurrentStoredMaterial] Group By CurrentStoredMaterial ASC" UniqueName="CurrentStoredMaterial"
                 SortExpression="CurrentStoredMaterial" DataField ="CurrentStoredMaterial"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("CurrentStoredMaterial"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblCurrentStoredMaterial" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("CurrentStoredMaterial")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            
                   <telerik:GridTemplateColumn HeaderText="Total Stored<br/>Material" GroupByExpression="StoredMaterial [GridColumn_TotalStoredMaterial] Group By StoredMaterial ASC" UniqueName="TotalStoredMaterial"
                 SortExpression="StoredMaterial" DataField ="StoredMaterial"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("StoredMaterial"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtStoredMaterial" CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("StoredMaterial")) %>'></asp:TextBox>
                </EditItemTemplate>
               <%-- <FooterTemplate>
                    <asp:Label ID="lblSumStoredMaterial" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn   Groupable="false" DataField ="TotalThisInvoice"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                HeaderText="Total This<br/>Invoice" UniqueName="TotalThisInvoice"
                 SortExpression="TotalThisInvoice" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("TotalThisInvoice"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblTotalThisInvoice" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("TotalThisInvoice")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
          <telerik:GridTemplateColumn   Groupable="false"
          HeaderText="Total<br/>Invoiced" UniqueName="TotalInvoiced" DataField ="TotalInvoiced"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                 SortExpression="TotalInvoiced" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("TotalInvoiced"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblTotalInvoiced" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("TotalInvoiced")) %>'></asp:Label>
                </EditItemTemplate>
               <%--   <FooterTemplate>
                    <asp:Label ID="lblSumTotalInvoiced" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            <telerik:GridTemplateColumn   Groupable="false" DataField ="BalanceToInvoice"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
            HeaderText="Balance to<br/>Invoice" UniqueName="BalanceToInvoice"
                 SortExpression="BalanceToInvoice" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("BalanceToInvoice"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblBalanceToInvoice" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("BalanceToInvoice")) %>'></asp:Label>
                </EditItemTemplate>
               <%-- <FooterTemplate>
                    <asp:Label ID="lblSumBalanceToInvoice" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="72px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="Services<br/>Retain %" UniqueName="PctServicesRetain"
                 SortExpression="PctServicesRetain"  Groupable="false" DataField="PctServicesRetain" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
   
            
                          <telerik:GridTemplateColumn HeaderText="Prior Services <br/> Retain Amount" GroupByExpression="PriorServicesRetainAmount [GridColumn_PriorServicesRetainAmount] Group By PriorServicesRetainAmount ASC" UniqueName="PriorServicesRetainAmount"
                 SortExpression="PriorServicesRetainAmount" DataField ="PriorServicesRetainAmount"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("PriorServicesRetainAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorServicesRetainAmount" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("PriorServicesRetainAmount")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            
                          <telerik:GridTemplateColumn HeaderText="Current Services <br/> Retain Amount" GroupByExpression="CurrentServicesRetainAmount [GridColumn_CurrentServicesRetainAmount] Group By CurrentServicesRetainAmount ASC" UniqueName="CurrentServicesRetainAmount"
                 SortExpression="CurrentServicesRetainAmount" DataField ="CurrentServicesRetainAmount"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("CurrentServicesRetainAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblCurrentServicesRetainAmount" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("CurrentServicesRetainAmount")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            
            
             <telerik:GridTemplateColumn HeaderText="Total Services Retain<br/>Amount" GroupByExpression="ServicesRetainAmount [GridColumn_TotalServicesRetainAmount] Group By ServicesRetainAmount ASC" UniqueName="TotalServicesRetainAmount"
                 SortExpression="ServicesRetainAmount" DataField ="ServicesRetainAmount"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("ServicesRetainAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtServicesRetainAmount" CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("ServicesRetainAmount")) %>'></asp:TextBox>
                </EditItemTemplate>
               <%-- <FooterTemplate>
                    <asp:Label ID="lblSumServicesRetainAmount" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            <telerik:GridTemplateColumn HeaderText="Materials<br/>Retain %" UniqueName="PctMaterialsRetain"
                 SortExpression="PctMaterialsRetain" Groupable="false" DataField="PctMaterialsRetain" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
         <telerik:GridTemplateColumn HeaderText="Prior Materials <br/>Retain Amount" GroupByExpression="PriorMaterialsRetainAmount [GridColumn_PriorMaterialsRetainAmount] Group By PriorMaterialsRetainAmount ASC" UniqueName="PriorMaterialsRetainAmount"
                 SortExpression="PriorMaterialsRetainAmount" DataField ="PriorMaterialsRetainAmount"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("PriorMarterialsRetainAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblPriorMaterialsRetainAmount" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("PriorMaterialsRetainAmount")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            
            <telerik:GridTemplateColumn HeaderText="Current Materials <br/>Retain Amount" GroupByExpression="CurrentMaterialsRetainAmount [GridColumn_CurrentMaterialsRetainAmount] Group By CurrentMaterialsRetainAmount ASC" UniqueName="CurrentMaterialsRetainAmount"
                 SortExpression="CurrentMaterialsRetainAmount" DataField ="CurrentMaterialsRetainAmount"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("CurrentMaterialsRetainAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblCurrentMaterialsRetainAmount" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("CurrentMaterialsRetainAmount")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            
            
        <telerik:GridTemplateColumn HeaderText="Total Materials Retain<br/>Amount" GroupByExpression="MaterialsRetainAmount [GridColumn_TotalMaterialsRetainAmount] Group By MaterialsRetainAmount ASC" UniqueName="TotalMaterialsRetainAmount"
                 SortExpression="MaterialsRetainAmount" DataField ="MaterialsRetainAmount"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("MaterialsRetainAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMaterialsRetainAmount" CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("MaterialsRetainAmount")) %>'></asp:TextBox>
                </EditItemTemplate>
               <%-- <FooterTemplate>
                    <asp:Label ID="lblSumMaterialsRetainAmount" runat="server"></asp:Label> 
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
              <telerik:GridTemplateColumn HeaderText="Total<br/>Retained" UniqueName="TotalRetained"
                 SortExpression="TotalRetained"  Groupable="false" DataField ="TotalRetained"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("TotalRetained"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTotalRetained" CssClass="Double" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatNumber(Eval("TotalRetained")) %>'></asp:TextBox>
                </EditItemTemplate>
               <%--   <FooterTemplate>
                    <asp:Label ID="lblSumTotalRetained" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="75px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" DataField ="CostCode"
             UniqueName="CostCodeId"
                GroupByExpression="CostCode [GridColumn_CostCodeId] Group By CostCode ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                    </asp:HyperLink>
                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostCodes" Width="100%" DropDownWidth="300px" runat="server"
                         Skin="Default" CloseDropDownOnBlur="true"
                        NoWrap="False" AllowCustomText="False" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                        EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                 <telerik:GridTemplateColumn HeaderText="Current<br/>Total Due" GroupByExpression="CurrentPayment [GridColumn_CurrentPayment] Group By CurrentPayment ASC" UniqueName="CurrentPayment"
                 SortExpression="CurrentPayment" DataField ="CurrentPayment"  Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#FormatCurrency(Container.DataItem("CurrentPayment"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblCurrentPayment" runat="server" Width="100%" CssClass="Right"
                         Text='<%# FormatNumber(Eval("CurrentPayment")) %>'></asp:Label>
                </EditItemTemplate>
                <%--  <FooterTemplate>
                    <asp:Label ID="lblSumTotalThisInvoice" runat="server"></asp:Label>
                </FooterTemplate>--%>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn> 
            
            
               <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                 UniqueName="CostType" DataField="CostType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            
            
            <telerik:GridTemplateColumn HeaderText="Req Code" ItemStyle-HorizontalAlign="Right"
                             SortExpression="ReqCode" GroupByExpression="ReqCode [GridColumn_ReqCode] Group By ReqCode ASC" UniqueName="ReqCode" 
                             DataField="ReqCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                             <ItemTemplate>
                                 <span>
                                     <%#IIf(Container.DataItem("ReqCode") = String.Empty, "&nbsp;", Container.DataItem("ReqCode"))%></span>
                             </ItemTemplate>
                             <EditItemTemplate>
                                         <telerik:RadComboBox ID="ddlReqCodes" Runat="server"  AllowCustomText="false" 
                                Skin="Default" CloseDropDownOnBlur="true" Width="100%" DropDownWidth="300px" AutoPostBack="false" NoWrap="true"
                                height="250px" CausesValidation="False" DropDownCssClass="ddlTreeviewTemplate">
                                <Items>
                                    <telerik:RadComboBoxItem Text="" /> 
                                </Items>
                                <ItemTemplate>
                                        <telerik:RadTreeView ID="rdvReqCode" Skin="Default" runat="server" OnClientNodeClicking="rdvReqNodeClicking"
                                            Height="250px" MultipleSelect="false" ShowLineImages="false" 
                                            OnNodeDataBound="rdvReqCode_NodeDataBound"  >
                                        </telerik:RadTreeView> 
                                </ItemTemplate>                   
                            </telerik:RadComboBox>
                             </EditItemTemplate>
                             <HeaderStyle Width="180px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="Task" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC" DataField ="TaskName" UniqueName="Task" HeaderStyle-Width="100px" 
                          CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <%#IIf(Container.DataItem("TaskName") = string.empty, "&nbsp;", Container.DataItem("TaskName"))%>
                    </ItemTemplate>
                    <EditItemTemplate>
                              <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="405px" Filter="Contains"
                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"  EmptyMessage="Select Task..." 
                            NoWrap="True" AllowCustomText="true" 
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                            OnItemsRequested="ddl_ItemsRequested"
                            Style="font-size: 11px" Height="250px" >
                                    <HeaderTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="0">
                                            <tr>                                                
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 50px;">
                                                     <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 50px;">
                                                     <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 385px" cellspacing="0" cellpadding="2" >
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 50px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                </td>
                                                <td style="width: 50px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                </td>
                                            </tr>
                                        </table>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
               </telerik:GridTemplateColumn> 
            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" 
                SortExpression="Notes"    GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" DataField="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" MaxLength ="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>
                   
                    <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                    <span class="Icon"></span>
                    </asp:LinkButton>
                    
                     </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>
             <telerik:GridTemplateColumn HeaderText="CCO #" UniqueName="CCONumber" 
                SortExpression="CCONumber"    GroupByExpression="CCONumber [GridColumn_CCONumber] Group By CCONumber ASC" 
                DataField="CCONumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CCONumber").ToString = String.Empty, "&nbsp;", Container.DataItem("CCONumber").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCCONumber" MaxLength ="10" runat="server" Text='<%# Eval("CCONumber") %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            
        <telerik:GridBoundColumn Aggregate="SUM" DataField="MaterialsRetainAmount" Visible="False" />
              <telerik:GridTemplateColumn HeaderText="Field1" AllowFiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2"  AllowFiltering="false"   GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3"  AllowFiltering="false"   GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
               Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4"  AllowFiltering="false"   GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5"  AllowFiltering="false"  GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6"  AllowFiltering="false"   GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7"  AllowFiltering="false"  GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8"  AllowFiltering="false"   GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9"  AllowFiltering="false"   GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
               Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10"  AllowFiltering="false"  GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                 Groupable="false" >
                <ItemTemplate>
                  <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                     <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
        </Columns>
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="true" Height="30px" HorizontalAlign="Left"/>
        <FooterStyle CssClass="GridFooter" />
        <CommandItemTemplate>
            <div style="padding: 2px">
                <table>
                <tr>
                 <td>                                   
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" 
                    SecurityButtonType="ItemMode_Add"
                    CommandName="InitNewRow" CssClass="GridCmdInitNewRow"  Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                   <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                </td>
                <td>
                <asp:LinkButton ID="btnEditSelected" SecurityButtonType="ItemMode_Edit" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                </td>
                <td>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Requisition"
                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgRequisitionDetails.EditIndexes.Count > 0 %>' >
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                    </td>
                    <td>
                    <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Requisition" 
                        SecurityButtonType="AddEditMode_Add"
                        CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgRequisitionDetails.MasterTableView.IsItemInserted %>'>
                      <span class="Icon"></span>
                        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    </td>
                    <td>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    Visible='<%# rdgRequisitionDetails.EditIndexes.Count > 0 Or rdgRequisitionDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                </td>
                <td> 
                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                    Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                    SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                    <span class="Icon"></span>
                    <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>
                </td>
                <td>  
                <asp:LinkButton ID="btnDeleteActualCosts" runat="server" CausesValidation="False" CommandName="DeleteActualCosts"
                    SecurityButtonType="ItemMode_Delete" Text="Delete Actual Costs" meta:resourcekey="btnDeleteActualCosts"
                    Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                    OnClientClick="javascript:return ConfirmDeleteActualCosts();" >
                    &nbsp;&nbsp;
                </asp:LinkButton>
                </td>
                <td>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                 </td>
                 <td>
                 <asp:LinkButton ID="btnSaveState" runat="server"  CausesValidation="False"
                        CommandName="SaveState"  Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </asp:LinkButton>
                </td>
                <td>
                <asp:LinkButton ID="btnLoadDefaultState" runat="server" 
                    CausesValidation="False" CommandName="LoadDefaultState" Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'>
                    &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                </asp:LinkButton>
                </td>
              <td>
                  <asp:LinkButton ID="btnChangeOrders" runat="server" CausesValidation="False" CommandName="LinkChangeOrders" CssClass="GridCmdLinkChangeOrders"
                      SecurityButtonType="ItemMode_Add" Text="Link Change Orders" meta:resourcekey="btnLinkChangeOrders"
                      Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                      OnClientClick="return OpenCOPopup(); ">
                      <span class="Icon"></span>
                      <asp:Label ID="Label3" runat="server" Text="<%$ Resources:PMWeb, LinkChangeOrders %>"></asp:Label>
                      &nbsp;&nbsp;
                  </asp:LinkButton>
              </td>

                    <td>


                          <asp:LinkButton ID="btnProduction" runat="server" CausesValidation="False" CommandName="Production" CssClass="GridCmdProduction" 
                              SecurityButtonType="ItemMode_Edit" Text="Production" meta:resourcekey="btnProduction"
                              Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                              OnClientClick="return OpenProductionPopup(); ">
                              <span class="Icon"></span>
                              <asp:Label ID="Label4" runat="server" Text="Production"></asp:Label>
                              &nbsp;&nbsp;
                          </asp:LinkButton>
                     </td>
                 <td>   
                <asp:Button ID="btnAddActualCosts" runat="server" CausesValidation="False" CommandName="AddActualCosts"
                    SecurityButtonType="ItemMode_Add" Text="Add Actual Costs" meta:resourcekey="btnAddActualCosts"
                    Visible='<%# rdgRequisitionDetails.EditIndexes.Count = 0 AND (Not rdgRequisitionDetails.MasterTableView.IsItemInserted) %>'
                    OnClientClick="return OpenActualCostsPopup();" /> 
                 </td>
                <td>
                <asp:Button runat="server" ID="btnActualCostsPopup" CommandName="ActualCostsPopup" CausesValidation="false"
                            CssClass="Hide" />
            </td>
            </tr>
            </table>
            </div>
          
        </CommandItemTemplate>
         <DetailTables>
          <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="true" CommandItemDisplay="None"  AllowSorting="false"  AllowPaging="false"
                DataKeyNames="Id,RequisitionDetailId,CostLedgerDetailId"  Width="100%"  EditMode="InPlace" Name="ActualCosts">
                <ParentTableRelation>
                    <telerik:GridRelationFields DetailKeyField="RequisitionDetailId" MasterKeyField="Id" />
                </ParentTableRelation>
                     <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                     <Columns>
                         <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LineNumber %>" UniqueName="LineNumber" Groupable="false"
                             Reorderable="false"  DataField="LineNumber">
                             <ItemTemplate>
                                 <span>
                                     <%#Container.DataItem("LineNumber").ToString%></span>
                             </ItemTemplate>
                             <HeaderStyle Width="45px" />
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Date %>" UniqueName="Date" SortExpression="CreateDate"
                             Groupable="false" Reorderable="false" DataField="CreateDate">
                             <ItemTemplate>
                                 <span>
                                     <%#FormatDate(Container.DataItem("CreateDate"))%></span>
                             </ItemTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                             <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                             <HeaderStyle Width="100px"></HeaderStyle>
                         </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Document %>" UniqueName="Document" 
                            SortExpression="Document"  Reorderable="false" Groupable="false" DataField="Document">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Document") = String.Empty, "&nbsp;", Container.DataItem("Document"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_DocumentType %>" UniqueName="DocumentType"  Groupable="false"
                            SortExpression="DocumentType" Reorderable="false" DataField="DocumentType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("DocumentType") = String.Empty, "&nbsp;", Container.DataItem("DocumentType"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_CompanyResource %>" UniqueName="CompanyResource"  Groupable="false"
                            SortExpression="CompanyResource" Reorderable="false" DataField="CompanyResource">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CompanyResource") = String.Empty, "&nbsp;", Container.DataItem("CompanyResource"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                      <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" SortExpression="Description" UniqueName="Description"
                             Groupable="false" Reorderable="false" DataField="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                             
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UOM %>" SortExpression="UOM" UniqueName="UOM" Reorderable="false"
                         Groupable="false" DataField="UOM">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>  
                                                                               
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Quantity %>" 
                             Groupable="false" SortExpression="Quantity" UniqueName="Quantity" Reorderable="false" DataField="Quantity">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UnitCost %>" UniqueName="UnitCost"
                            SortExpression="UnitCost"  Groupable="false" Reorderable="false" DataField="UnitCost">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_TotalAmount %>" UniqueName="TotalAmount"
                           Groupable="false" SortExpression="TotalAmount" Reorderable="false" DataField="TotalAmount">
                            <ItemTemplate>
                                 <span><asp:Label Text='<%#FormatCurrency(Container.DataItem("TotalAmount"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTotalAmount" /></span>
                            </ItemTemplate>
                            <FooterTemplate>
                                    <asp:Label ID="lblSumTotalAmount" runat="server"></asp:Label>
                            </FooterTemplate>
                             <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                     </Columns>
                     
                </telerik:GridTableView>
                
         </DetailTables>
    </MasterTableView>
    <HeaderStyle Font-Size="8pt"></HeaderStyle>
    <ClientSettings  ClientEvents-OnRowDeselected="Requisition_RowDeselected" ClientEvents-OnRowSelected="Requisition_RowSelected" EnableRowHoverStyle="true" AllowColumnHide="true" AllowColumnsReorder="true" allowdragtogroup="true" allowrowsdragdrop="False">                   
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False"  />
                      <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
            AllowColumnResize="True"></Resizing>
    </ClientSettings>
</telerik:RadGrid>