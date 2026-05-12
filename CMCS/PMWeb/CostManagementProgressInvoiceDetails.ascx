<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementProgressInvoiceDetails.ascx.vb" Inherits="Website.CostManagementProgressInvoiceDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript">
        function HeaderShowing(sender, args) {
            args.get_menu().findItemByValue("ColumnsContainer").get_items().forEach
                (
                function (item) {
                    item.set_text(item.get_text().replace('<br>', ''));

                }
                )
        }

    </script>
</telerik:RadCodeBlock>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <Calendar Width="200px"></Calendar>
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdg1" AllowMultiRowSelection="true" runat="server" ShowGroupPanel="true"
                HeaderStyle-Font-Size="8" ShowFooter="true" CssClass="WithoutTopBorder"
                AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowSorting="true" ShowStatusBar="false" AllowPaging="true"
                PageSize="250" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true"
                EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
                <%--<HeaderContextMenu EnableAutoScroll="true" EnableScreenBoundaryDetection="true" EnableViewState="false"></HeaderContextMenu>--%>
                <PagerStyle Mode="NextPrevAndNumeric"
                    AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                    InsertItemDisplay="Top" ShowFooter="true" ShowGroupFooter="true" GroupLoadMode="Client"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true" Name="Master">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber"
                            Groupable="false" Reorderable="true" DataField="LineNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                                <asp:HiddenField runat="server" ID="hdnCanDelete" Value='<%#Eval("CanDelete").ToString%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                            UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                            GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnAttachments"> 
                              <span> (<%#Container.DataItem("AttachmentTotal")%>)</span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="75px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>




                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC" DataField="Currency" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>

                                <span><%#Eval("Currency")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="250px"
                                    Skin="Default" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="85px"></HeaderStyle>
                        </telerik:GridTemplateColumn>





                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description"
                            SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC" DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
                        <telerik:GridTemplateColumn HeaderText="Cost Code" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode" UniqueName="CostCode" SortExpression="CostCode"
                            DataField="CostCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" GroupByExpression="UOM [UOM] Group By UOM ASC"
                            DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                <%--<asp:TextBox ID="txtUOM" ReadOnly="true" runat="server" Text='<%# Eval("UOM") %>'
                        Width="100%"></asp:TextBox>--%>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Scheduled<br/>Quantity" UniqueName="ScheduledQuantity"
                            SortExpression="ScheduledQuantity" DataField="ScheduledQuantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="ScheduledQuantity [GridColumn_ScheduledQuantity] Group By ScheduledQuantity ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <div id='<%# "Detail_" & Eval("DetailId").tostring()%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                                    <span style="float: right"><%# ParseDouble(Container.DataItem("ScheduledQuantity"))%></span>&nbsp;
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblScheduledQuantity" runat="server" Width="100%" CssClass="Right" Precision="5"
                                    Text='<%#ParseDouble(IIf(Eval("ScheduledQuantity") Is System.DBNull.Value, "0", Eval("ScheduledQuantity")))%>'></asp:Label>
                                <%--<asp:TextBox ID="txtScheduledQuantity" ReadOnly="true" runat="server" Width="100%" CssClass="PositiveDouble"
                        MaxLength="15" Text='<%#FormatNumber(IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "0", Eval("ScheduledQuantity"))) %>'
                       ></asp:TextBox>--%>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1" DataField="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Unit<br/>Cost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC" UniqueName="UnitCost"
                            SortExpression="UnitCost" DataField="UnitCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblUnitCost" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Prior<br/>Quantity" DataField="PriorQuantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" UniqueName="PriorQuantity" GroupByExpression="PriorQuantity [GridColumn_PriorQuantity] Group By PriorQuantity ASC" SortExpression="PriorQuantity"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("PriorQuantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblPriorQuantity" runat="server" Width="100%" CssClass="Right"
                                    Text='<%#FormatNumber(IIF(Eval("PriorQuantity") is system.DBNULL.value, "0", Eval("PriorQuantity"))) %>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Current<br/>Quantity" DataField="CurrentQuantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" UniqueName="CurrentQuantity" GroupByExpression="CurrentQuantity [GridColumn_CurrentQuantity] Group By CurrentQuantity ASC"
                            SortExpression="CurrentQuantity" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("CurrentQuantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCurrentQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIF(Eval("CurrentQuantity") is system.DBNULL.value, "0", Eval("CurrentQuantity"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total<br/>Quantity" DataField="TotalQuantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" UniqueName="TotalQuantity" GroupByExpression="TotalQuantity [GridColumn_TotalQuantity] Group By TotalQuantity ASC"
                            SortExpression="TotalQuantity" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("TotalQuantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIF(Eval("TotalQuantity") is system.DBNULL.value, "0", Eval("TotalQuantity"))) %>'></asp:TextBox>
                                <%-- <div>
                        <asp:RangeValidator ID="rgvalTotalQuantity" ValidationGroup="ProgressInvoice" ControlToValidate="txtTotalQuantity" Display="Dynamic" CssClass="validator" runat="server" ErrorMessage="*" MinimumValue='<%#FormatNumber(IIF(Eval("PriorQuantity") is system.DBNULL.value, "0", Eval("PriorQuantity"))) %>' MaximumValue='<%#FormatNumber(IIF(Eval("ScheduledQuantity") is system.DBNULL.value, "0", Eval("ScheduledQuantity"))) %>' Type="Double"></asp:RangeValidator>
                    </div>--%>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Scheduled<br/>Value" UniqueName="ScheduledValue" GroupByExpression="ScheduledValue [GridColumn_ScheduledValue] Group By ScheduledValue ASC"
                            SortExpression="ScheduledValue" DataField="ScheduledValue" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <div id='<%# "DetailV_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                                    <span style="float: right"><%#FormatCurrency(Container.DataItem("ScheduledValue"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>&nbsp;
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblScheduledValue" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("ScheduledValue"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>

                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Prior<br/>Invoices" GroupByExpression="PriorInvoices [GridColumn_PriorInvoices] Group By PriorInvoices ASC" UniqueName="PriorInvoices"
                            SortExpression="PriorInvoices" DataField="PriorInvoices" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorInvoices"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblPriorInvoices" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("PriorInvoices"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Current<br/>Invoice" GroupByExpression="CurrentInvoice [GridColumn_CurrentInvoice] Group By CurrentInvoice ASC" UniqueName="CurrentInvoice"
                            SortExpression="CurrentInvoice" DataField="CurrentInvoice" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentInvoice"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCurrentInvoices" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("CurrentInvoice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Prior Stored<br/>Material" GroupByExpression="PriorStoredMaterial [GridColumn_PriorStoredMaterial] Group By PriorStoredMaterial ASC" UniqueName="PriorStoredMaterial"
                            SortExpression="PriorStoredMaterial" DataField="PriorStoredMaterial" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorStoredMaterial"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblPriorStoredMaterial" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("PriorStoredMaterial"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Current Stored<br/>Material" GroupByExpression="CurrentStoredMaterial [GridColumn_CurrentStoredMaterial] Group By CurrentStoredMaterial ASC" UniqueName="CurrentStoredMaterial"
                            SortExpression="CurrentStoredMaterial" DataField="CurrentStoredMaterial" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentStoredMaterial"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCurrentStoredMaterial" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("CurrentStoredMaterial"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total Stored<br/>Material" GroupByExpression="StoredMaterial [GridColumn_TotalStoredMaterial] Group By StoredMaterial ASC" UniqueName="TotalStoredMaterial"
                            SortExpression="StoredMaterial" DataField="StoredMaterial" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("StoredMaterial"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStoredMaterial" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("StoredMaterial"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>

                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total Services" GroupByExpression="TotalServices [GridColumn_TotalServices] Group By TotalServices ASC" UniqueName="TotalServices"
                            SortExpression="TotalServices" DataField="TotalServices" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalServices"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalServices" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("TotalServices"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total This<br/>Invoice" GroupByExpression="TotalThisInvoice [GridColumn_TotalThisInvoice] Group By TotalThisInvoice ASC" UniqueName="TotalThisInvoice"
                            SortExpression="TotalThisInvoice" DataField="TotalThisInvoice" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalThisInvoice"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblTotalThisInvoice" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("TotalThisInvoice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total<br/>Invoiced" GroupByExpression="TotalInvoiced [GridColumn_TotalInvoiced] Group By TotalInvoiced ASC" UniqueName="TotalInvoiced"
                            SortExpression="TotalInvoiced" DataField="TotalInvoiced" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalInvoiced"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblTotalInvoiced" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("TotalInvoiced"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="% Complete" UniqueName="PctComplete" SortExpression="PctComplete" GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC"
                            DataField="PctComplete" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatPercent(Container.DataItem("PctComplete"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPctComplete" runat="server" Width="100%" CssClass="Percent"
                                    MaxLength="15" MinNumber="0" Text='<%# FormatPercent(IIF(Eval("PctComplete") is system.DBNULL.value, "0", Eval("PctComplete"))) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Balance to<br/>Invoice" GroupByExpression="BalanceToInvoice [GridColumn_BalanceToInvoice] Group By BalanceToInvoice ASC" UniqueName="BalanceToInvoice"
                            SortExpression="BalanceToInvoice" DataField="BalanceToInvoice" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("BalanceToInvoice"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblBalanceToInvoice" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("BalanceToInvoice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>

                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Services<br/>Retain %" GroupByExpression="PctServicesRetain [GridColumn_PctServicesRetain] Group By PctServicesRetain ASC" UniqueName="PctServicesRetain"
                            SortExpression="PctServicesRetain" DataField="PctServicesRetain" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatPercent(Container.DataItem("PctServicesRetain"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPctServicesRetain" MinNumber="0" MaxNumber="100" CssClass="Percent" runat="server" Width="100%" MaxLength="15"
                                    Text='<%#  FormatPercent(Eval("PctServicesRetain")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Prior Services <br/> Retain Amount" GroupByExpression="PriorServicesRetainAmount [GridColumn_PriorServicesRetainAmount] Group By PriorServicesRetainAmount ASC" UniqueName="PriorServicesRetainAmount"
                            SortExpression="PriorServicesRetainAmount" DataField="PriorServicesRetainAmount" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorServicesRetainAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblPriorServicesRetainAmount" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("PriorServicesRetainAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Current Services <br/> Retain Amount" GroupByExpression="CurrentServicesRetainAmount [GridColumn_CurrentServicesRetainAmount] Group By CurrentServicesRetainAmount ASC" UniqueName="CurrentServicesRetainAmount"
                            SortExpression="CurrentServicesRetainAmount" DataField="CurrentServicesRetainAmount" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentServicesRetainAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCurrentServicesRetainAmount" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("CurrentServicesRetainAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total Services Retain<br/>Amount" GroupByExpression="ServicesRetainAmount [GridColumn_TotalServicesRetainAmount] Group By ServicesRetainAmount ASC" UniqueName="TotalServicesRetainAmount"
                            SortExpression="ServicesRetainAmount" DataField="ServicesRetainAmount" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("ServicesRetainAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtServicesRetainAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("ServicesRetainAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Materials<br/>Retain %" GroupByExpression="PctMaterialsRetain [GridColumn_PctMaterialsRetain] Group By PctMaterialsRetain ASC" UniqueName="PctMaterialsRetain"
                            SortExpression="PctMaterialsRetain" DataField="PctMaterialsRetain" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatPercent(Container.DataItem("PctMaterialsRetain"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPctMaterialsRetain" CssClass="Percent" runat="server" Width="100%" MaxLength="15"
                                    Text='<%#  FormatPercent(Eval("PctMaterialsRetain")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Prior Materials <br/>Retain Amount" GroupByExpression="PriorMaterialsRetainAmount [GridColumn_PriorMaterialsRetainAmount] Group By PriorMaterialsRetainAmount ASC" UniqueName="PriorMaterialsRetainAmount"
                            SortExpression="PriorMaterialsRetainAmount" DataField="PriorMaterialsRetainAmount" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorMaterialsRetainAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblPriorMaterialsRetainAmount" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("PriorMaterialsRetainAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Current Materials <br/>Retain Amount" GroupByExpression="CurrentMaterialsRetainAmount [GridColumn_CurrentMaterialsRetainAmount] Group By CurrentMaterialsRetainAmount ASC" UniqueName="CurrentMaterialsRetainAmount"
                            SortExpression="CurrentMaterialsRetainAmount" DataField="CurrentMaterialsRetainAmount" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentMaterialsRetainAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCurrentMaterialsRetainAmount" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("CurrentMaterialsRetainAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total Materials Retain<br/>Amount" GroupByExpression="MaterialsRetainAmount [GridColumn_TotalMaterialsRetainAmount] Group By MaterialsRetainAmount ASC" UniqueName="TotalMaterialsRetainAmount"
                            SortExpression="MaterialsRetainAmount" DataField="MaterialsRetainAmount" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("MaterialsRetainAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtMaterialsRetainAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("MaterialsRetainAmount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Total<br/>Retained" GroupByExpression="TotalRetained [GridColumn_TotalRetained] Group By TotalRetained ASC" UniqueName="TotalRetained"
                            SortExpression="TotalRetained" DataField="TotalRetained" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalRetained"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblTotalRetained" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("TotalRetained"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Current<br/>Total Due" GroupByExpression="CurrentPayment [GridColumn_CurrentPayment] Group By CurrentPayment ASC" UniqueName="CurrentPayment"
                            SortExpression="CurrentPayment" DataField="CurrentPayment" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentPayment"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCurrentPayment" runat="server" Width="100%" CssClass="Currency"
                                    Text='<%# FormatCurrency(Eval("CurrentPayment"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Funding" SortExpression="Funded" UniqueName="Funded"
                            GroupByExpression="Funded [GridColumn_Funded] Group By Funded" DataField="Funded" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("Funded"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                <asp:LinkButton ID="btnGenerateFunding" CssClass="FilledDetails" Text="" runat="server">
                            <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFunded" runat="server"
                                    Text='<%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="80%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Phase" SortExpression="PhaseName" DataField="PhaseName"
                            GroupByExpression="PhaseName [GridColumn_Phase] Group By PhaseName ASC"
                            UniqueName="Phase" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PhaseName") = String.Empty, "&nbsp;", Container.DataItem("PhaseName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:radcombobox ID="ddlProjectPhases" runat="server" Width="100%" AllowCustomText="true">
                                </telerik:radcombobox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                            <ItemTemplate>
                                <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>

                                    <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC"
                            SortExpression="Location" UniqueName="Location" DataField="Location" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:radcombobox ID="ddlLocation" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                    Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="200px"
                                    Width="100%" Height="200px" NoWrap="true" CausesValidation="False">
                                     <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:radcombobox>
                            </EditItemTemplate>
                            <HeaderStyle Width="160px"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                            UniqueName="CostType" DataField="CostType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Task" DataField="TaskName" UniqueName="Task" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Task..."
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="2">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <%# DataBinder.Eval(Container, "Text")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['EarlyStartDate']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['EarlyFinishDate']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Assigned To" SortExpression="AssignedTo" UniqueName="AssignedTo"
                            GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC" DataField="AssignedTo" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("AssignedToId") = "-1" Or Container.DataItem("AssignedTo") = "0", "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div style="width: 100%; white-space: nowrap">
                                    <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="85%" DropDownWidth="300px" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                        NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                        OnClientDropDownClosed="dllcompClientClosed"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested"
                                        Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>


                                    <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                                        OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
                        <span class="Icon"></span>
                                    </asp:LinkButton>

                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" UniqueName="Notes"
                            SortExpression="Notes" DataField="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Req. Code" SortExpression="ReqCodeName" DataField="ReqCodeName" GroupByExpression="ReqCodeName [GridColumn_ReqCode] Group By ReqCodeName ASC" UniqueName="ReqCode"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ReqCodeName") = String.Empty, "&nbsp;", Container.DataItem("ReqCodeName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlReqCodes" runat="server" AllowCustomText="false"
                                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" DropDownWidth="300px" AutoPostBack="false" NoWrap="true"
                                    Height="250px" CausesValidation="False" DropDownCssClass="ddlTreeviewTemplate">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" />
                                    </Items>
                                    <ItemTemplate>
                                        <telerik:RadTreeView ID="rdvReqCode" Skin="Default" runat="server"
                                            Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvReqNodeClicking"
                                            OnNodeDataBound="rdvReqCode_NodeDataBound" OnNodeExpand="rdvReqCode_NodeExpand">
                                        </telerik:RadTreeView>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="CCO #" GroupByExpression="CCONumber [GridColumn_CCONumber] Group By CCONumber ASC" UniqueName="CCONumber"
                            SortExpression="CCONumber" DataField="CCONumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CCONumber").ToString = String.Empty, "&nbsp;", Container.DataItem("CCONumber").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#IIf(Container.DataItem("CCONumber").ToString = String.Empty, "&nbsp;", Container.DataItem("CCONumber").ToString)%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Orig./Rev." GroupByExpression="PostAs [GridColumn_PostAs] Group By PostAs ASC" UniqueName="PostAs"
                            SortExpression="PostAs" DataField="PostAs" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PostAs").ToString = String.Empty, "&nbsp;", Container.DataItem("PostAs").ToString)%></span>
                            </ItemTemplate>

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted" UniqueName="Adjustment1Converted" ItemStyle-HorizontalAlign="Right" Visible="false"
                            SortExpression="Adjustment1Converted" DataField="Adjustment1Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment1Converted [GridColumn_Adjustment1Converted] Group By Adjustment1Converted ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment1Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax Converted" UniqueName="TaxConverted" ItemStyle-HorizontalAlign="Right" Visible="false"
                            SortExpression="TaxConverted" DataField="TaxConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="TaxConverted [GridColumn_TaxConverted] Group By TaxConverted ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTaxConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right" Visible="false"
                            SortExpression="Adjustment2Converted" DataField="Adjustment2Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" GroupByExpression="Adjustment2Converted [GridColumn_Adjustment2Converted] Group By Adjustment2Converted ASC"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustmentsConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Unit<br/>Cost Converted" GroupByExpression="UnitCostConverted [GridColumn_UnitCostConverted] Group By UnitCostConverted ASC" UniqueName="UnitCostConverted" Visible="false"
                            SortExpression="UnitCostConverted" DataField="UnitCostConverted" Aggregate="Avg" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Scheduled<br/>Value Converted" UniqueName="ScheduledValueConverted" GroupByExpression="ScheduledValueConverted [GridColumn_ScheduledValueConverted] Group By ScheduledValueConverted ASC" Visible="false"
                            SortExpression="ScheduledValueConverted" DataField="ScheduledValueConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("ScheduledValueConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Prior<br/>Invoices Converted" GroupByExpression="PriorInvoicesConverted [GridColumn_PriorInvoicesConverted] Group By PriorInvoicesConverted ASC" UniqueName="PriorInvoicesConverted" Visible="false"
                            SortExpression="PriorInvoicesConverted" DataField="PriorInvoicesConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorInvoicesConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Current<br/>Invoice Converted" GroupByExpression="CurrentInvoiceConverted [GridColumn_CurrentInvoiceConverted] Group By CurrentInvoiceConverted ASC" UniqueName="CurrentInvoiceConverted" Visible="false"
                            SortExpression="CurrentInvoiceConverted" DataField="CurrentInvoiceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentInvoiceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Prior Stored<br/>Material Converted" GroupByExpression="PriorStoredMaterialConverted [GridColumn_PriorStoredMaterialConverted] Group By PriorStoredMaterialConverted ASC" UniqueName="PriorStoredMaterialConverted" Visible="false"
                            SortExpression="PriorStoredMaterialConverted" DataField="PriorStoredMaterialConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorStoredMaterialConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Current Stored<br/>Material Converted" GroupByExpression="CurrentStoredMaterialConverted [GridColumn_CurrentStoredMaterialConverted] Group By CurrentStoredMaterialConverted ASC" UniqueName="CurrentStoredMaterialConverted" Visible="false"
                            SortExpression="CurrentStoredMaterialConverted" DataField="CurrentStoredMaterialConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentStoredMaterialConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Stored<br/>Material Converted" GroupByExpression="StoredMaterialConverted [GridColumn_TotalStoredMaterialConverted] Group By StoredMaterialConverted ASC" UniqueName="TotalStoredMaterialConverted" Visible="false"
                            SortExpression="StoredMaterialConverted" DataField="StoredMaterialConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("StoredMaterialConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Services Converted" GroupByExpression="TotalServicesConverted [GridColumn_TotalServicesConverted] Group By TotalServicesConverted ASC" UniqueName="TotalServicesConverted" Visible="false"
                            SortExpression="TotalServicesConverted" DataField="TotalServicesConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalServicesConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total This<br/>Invoice Converted" GroupByExpression="TotalThisInvoiceConverted [GridColumn_TotalThisInvoiceConverted] Group By TotalThisInvoiceConverted ASC" UniqueName="TotalThisInvoiceConverted" Visible="false"
                            SortExpression="TotalThisInvoiceConverted" DataField="TotalThisInvoiceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalThisInvoiceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total<br/>Invoiced Converted" GroupByExpression="TotalInvoicedConverted [GridColumn_TotalInvoicedConverted] Group By TotalInvoicedConverted ASC" UniqueName="TotalInvoicedConverted" Visible="false"
                            SortExpression="TotalInvoicedConverted" DataField="TotalInvoicedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalInvoicedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Balance to<br/>Invoice Converted" GroupByExpression="BalanceToInvoiceConverted [GridColumn_BalanceToInvoiceConverted] Group By BalanceToInvoiceConverted ASC" UniqueName="BalanceToInvoiceConverted" Visible="false"
                            SortExpression="BalanceToInvoiceConverted" DataField="BalanceToInvoiceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("BalanceToInvoiceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Prior Services <br/> Retain Amount Converted" GroupByExpression="PriorServicesRetainAmountConverted [GridColumn_PriorServicesRetainAmountConverted] Group By PriorServicesRetainAmountConverted ASC" UniqueName="PriorServicesRetainAmountConverted" Visible="false"
                            SortExpression="PriorServicesRetainAmountConverted" DataField="PriorServicesRetainAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorServicesRetainAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Current Services <br/> Retain Amount Converted" GroupByExpression="CurrentServicesRetainAmountConverted [GridColumn_CurrentServicesRetainAmountConverted] Group By CurrentServicesRetainAmountConverted ASC" UniqueName="CurrentServicesRetainAmountConverted" Visible="false"
                            SortExpression="CurrentServicesRetainAmountConverted" DataField="CurrentServicesRetainAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentServicesRetainAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Services Retain<br/>Amount Converted" GroupByExpression="ServicesRetainAmountConverted [GridColumn_TotalServicesRetainAmountConverted] Group By ServicesRetainAmountConverted ASC" UniqueName="TotalServicesRetainAmountConverted" Visible="false"
                            SortExpression="ServicesRetainAmountConverted" DataField="ServicesRetainAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("ServicesRetainAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Prior Materials <br/>Retain Amount Converted" GroupByExpression="PriorMaterialsRetainAmountConverted [GridColumn_PriorMaterialsRetainAmountConverted] Group By PriorMaterialsRetainAmountConverted ASC" UniqueName="PriorMaterialsRetainAmountConverted" Visible="false"
                            SortExpression="PriorMaterialsRetainAmountConverted" DataField="PriorMaterialsRetainAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("PriorMaterialsRetainAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Current Materials <br/>Retain Amount Converted" GroupByExpression="CurrentMaterialsRetainAmountConverted [GridColumn_CurrentMaterialsRetainAmountConverted] Group By CurrentMaterialsRetainAmountConverted ASC" UniqueName="CurrentMaterialsRetainAmountConverted" Visible="false"
                            SortExpression="CurrentMaterialsRetainAmountConverted" DataField="CurrentMaterialsRetainAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentMaterialsRetainAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Materials Retain<br/>Amount Converted" GroupByExpression="MaterialsRetainAmountConverted [GridColumn_TotalMaterialsRetainAmountConverted] Group By MaterialsRetainAmountConverted ASC" UniqueName="TotalMaterialsRetainAmountConverted" Visible="false"
                            SortExpression="MaterialsRetainAmountConverted" DataField="MaterialsRetainAmountConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("MaterialsRetainAmountConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total<br/>Retained Converted" GroupByExpression="TotalRetainedConverted [GridColumn_TotalRetainedConverted] Group By TotalRetainedConverted ASC" UniqueName="TotalRetainedConverted" Visible="false"
                            SortExpression="TotalRetainedConverted" DataField="TotalRetainedConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("TotalRetainedConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Current<br/>Total Due Converted" GroupByExpression="CurrentPaymentConverted [GridColumn_CurrentPaymentConverted] Group By CurrentPaymentConverted ASC" UniqueName="CurrentPaymentConverted" Visible="false"
                            SortExpression="CurrentPaymentConverted" DataField="CurrentPaymentConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("CurrentPaymentConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn Aggregate="SUM" DataField="MaterialsRetainAmount" Visible="False" />

                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="true" Height="30px" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" SecurityButtonType="ItemMode_Edit" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="ProgressInvoice"
                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdg1.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                Visible='<%# rdg1.EditIndexes.Count > 0 Or rdg1.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnChangeOrders" runat="server" CausesValidation="False" CommandName="LinkChangeOrders" CssClass="GridCmdLinkChangeOrders"
                                SecurityButtonType="ItemMode_Add" Text="Link Change Orders" meta:resourcekey="btnLinkChangeOrders"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenCOPopup(); ">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="<%$ Resources:PMWeb, LinkChangeOrders %>"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnProduction" runat="server" CausesValidation="False" CommandName="Production" CssClass="GridCmdLinkProduction"
                                SecurityButtonType="ItemMode_Edit" Text="Production" meta:resourcekey="btnProduction"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenProductionPopup(); ">

                                <span class="Icon"></span>
                                <asp:Label ID="LblProduction" runat="server" Text="Production" meta:resourcekey="LblProduction"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPctComplete" runat="server"
                                SecurityButtonType="ItemMode_Edit" CausesValidation="False" CommandName="PctComplete" CssClass="GridCmdPctComplete"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted)%>' ToolTip="% Complete From Schedule">
                                <span class="Icon"></span>
                                <asp:Label ID="Label12" Text="% Complete From Schedule1" runat="server"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <span style="width: 100%; text-align: right">
                                <asp:CheckBox runat="server" ID="ckbUseUnits" CssClass="chkAlignMiddle mobile-switch" Text="Use Units" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false"
                                    CssClass="Hide" OnClick="chkUserUnits_OnChekedChanged" />
                            </span>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdg1.EditIndexes.Count = 0 And (Not rdg1.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ClientSettings EnableRowHoverStyle="true" ClientEvents-OnRowSelected="rdg1_OnRowClick" AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="true" AllowRowsDragDrop="False">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <ClientEvents OnHeaderMenuShowing="HeaderShowing" />

                </ClientSettings>

            </telerik:RadGrid>
        </div>
    </div>
</div>

