<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InitiativeBudgetDetails.ascx.vb" Inherits="Website.InitiativeBudgetDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadAjaxLoadingPanel ID="ldpInitiativeDetails" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<textarea type="text" id="txtClipboard" runat="server" readonly="readonly" class="txtClipboard"/>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgInitiativeBudgetDetails" runat="server" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" HasPasteFromExcel="true"
                AutoGenerateColumns="False" ShowStatusBar="False" CssClass="WithoutTopBorder" UseEditFormInMobile="true"
                Font-Size="8px" PageSize="250" ShowFooter="true" AllowPaging="True" ShowGroupPanel="True"
                AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">

                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                    EditMode="InPlace" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right"
                            SortExpression="LineNumber" GroupByExpression="LineNumber [GridColumn_Line] Group By LineNumber ASC" DataField="LineNumber"
                            Groupable="false" Reorderable="true" AllowFiltering="false">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString()%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span><%#Eval("LineNumber").ToString()%></span>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
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
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Assembly" SortExpression="AssemblyCode" GroupByExpression="AssemblyCode,AssemblyDescription, SUM(TotalCost) TCost, MIN(AssemblyMultiplier) Qty [Assembly] Group By AssemblyCode"
                            UniqueName="AssemblyCode" CurrentFilterFunction="Contains" DataField="AssemblyCode" DataType="System.String" FilterListOptions="VaryByDataType">
                            <ItemTemplate>

                                <asp:LinkButton runat="server" ID="btnAssemblyPass">
                                <span><%#IIf(Container.DataItem("AssemblyCode") = String.Empty, "&nbsp;", Container.DataItem("AssemblyCode"))%></span>
                                </asp:LinkButton>
                                <asp:Label runat="server" ID="lblAssemblyPass"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAssemblyCode" CssClass="Right" runat="server" Text='<%# Eval("AssemblyCode") %>'
                                    Width="100%" Enabled="False"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="Item" SortExpression="ItemCode" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC" DataField="ItemCode">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtItemCode" MaxLength="50" runat="server" Text='<%# Eval("ItemCode") %>'
                                    Width="100%" Enabled="false"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="BIM ID" UniqueName="BIMId" SortExpression="BIMId" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="BIMId [GridColumn_BIMId] Group By BIMId ASC" DataField="BIMId">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("BIMId") = String.Empty, "&nbsp;", Container.DataItem("BIMId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtBIMId" MaxLength="50" runat="server" Text='<%# Eval("BIMId")%>'
                                    Width="100%" Enabled="false"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                            GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Width="100%" ID="ddlCurrencies" DropDownWidth="250px" runat="server" Skin="Default" Style="font-size: 11px" Height="300px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Resource" HeaderStyle-HorizontalAlign="Left" GroupByExpression="Labor [GridColumn_Labor] Group By Labor ASC"
                            HeaderStyle-Width="150px" UniqueName="Labor" SortExpression="Labor" DataField="Labor">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Labor").ToString = String.Empty, "&nbsp;", Container.DataItem("Labor").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlLabors" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Resource Type" HeaderStyle-HorizontalAlign="Left" GroupByExpression="ResourceType [GridColumn_ResourceType] Group By ResourceType ASC"
                            HeaderStyle-Width="150px" UniqueName="ResourceType" SortExpression="ResourceType" DataField="ResourceType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ResourceType").ToString = String.Empty, "&nbsp;", Container.DataItem("ResourceType").ToString)%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%#Eval("ResourceType")%> &nbsp;
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" DataField="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                            GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            DataField="Quantity" DataType="System.Decimal">
                            <ItemTemplate>
                                <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                                    MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'
                                    Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOMs'),'ASP',0)"></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext. Quantity"
                            HeaderStyle-Wrap="false" GroupByExpression="ExtendedQuantity [GridColumn_ExtendedQuantity] Group By ExtendedQuantity ASC"
                            SortExpression="ExtendedQuantity" UniqueName="ExtendedQuantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                            DataField="ExtendedQuantity" DataType="System.Decimal" FilterListOptions="VaryByDataType">
                            <ItemTemplate>
                                <span><%#FormatNumber(ParseDouble(Container.DataItem("ExtendedQuantity")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblExtentedQuantity" runat="server" EnableViewState="False" Text='<%# FormatNumber(ParseDouble(Eval("ExtendedQuantity"))) %>'
                                    CssClass="Right"></asp:Label>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                            SortExpression="UnitCost" DataField="UnitCost">
                            <ItemTemplate>
                                <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle CssClass="HighlightedItem" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext Cost" UniqueName="ExtCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCost" GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC"
                            DataField="ExtCost" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" DataType="System.String">

                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblExtCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" CssClass="HighlightedItem"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" ItemStyle-HorizontalAlign="Right" DataType="System.String"
                            SortExpression="TotalCost" DataField="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTotalCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalCost" CssClass="Currency" runat="server"
                                    Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" CssClass="HighlightedItem"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right" DataType="System.String"
                            SortExpression="Adjustment1" DataField="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblShipping" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment1"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Tax" UniqueName="Tax" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Tax" DataField="Tax" GroupByExpression="Tax [GridColumn_Tax] Group By Tax ASC" DataType="System.String"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTax" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Tax"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditTax" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2" UniqueName="Adjustment2" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2" DataField="Adjustment2" GroupByExpression="Adjustment2 [GridColumn_Adjustment2] Group By Adjustment2 ASC" DataType="System.String"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostTypeId] Group By CostType ASC"
                            UniqueName="CostTypeId" DataField="CostType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostType" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" DataField="CostCode">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="300px"
                                    Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="False"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Funding Source" SortExpression="FundingSource"
                            UniqueName="FundingSource" GroupByExpression="FundingSource [GridColumn_FundingSource] Group By FundingSource ASC" DataField="FundingSource">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("FundingSourceId") = -1, "&nbsp;", IIf(Container.DataItem("FundingSourceId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("FundingSource")))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlFundingSources" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true" Height="250px"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" NoWrap="True" OnItemsRequested="ddl_ItemsRequested"></telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company" UniqueName="Company" DataField="Company"
                            GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("CompanyId") = -1 Or Container.DataItem("CompanyId") = 0, "&nbsp;", Container.DataItem("Company"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                    NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" DataField="Period"
                            GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIF(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox Skin="Default" ID="ddlPeriods"
                                    OnClientSelectedIndexChanged="ddlPeriods_OnClientSelectedIndexChanged" runat="server" Width="100%"
                                    OnItemsRequested="ddl_ItemsRequested" CloseDropDownOnBlur="true"
                                    NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year" ItemStyle-HorizontalAlign="Right" SortExpression="Year" DataField="Year"
                            GroupByExpression="Year [GridColumn_Year] Group By Year">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Year") is system.DBNULL.value, "&nbsp;", Container.DataItem("Year"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadNumericTextBox ID="rntYear" ShowSpinButtons="true"
                                    IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                    Label="" runat="server" Width="70px" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>"
                                    MaxValue="2100" MinValue="1899">
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                                    MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
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
                                                    <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                </td>
                                                <td style="width: 80px;">
                                                    <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" DataField="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>'
                                    Width="80%" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                            <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                            Groupable="false" DataField="Field1" AllowFiltering="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" DataField="Field2" AllowFiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" DataField="Field3" AllowFiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" DataField="Field4" AllowFiltering="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" DataField="Field5" AllowFiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" DataField="Field6" AllowFiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" DataField="Field7" AllowFiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" DataField="Field8" AllowFiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" DataField="Field9" AllowFiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" DataField="Field10" AllowFiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                            Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" Visible="false" UniqueName="UnitCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="UnitCostConverted" DataField="UnitCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ext Cost Converted" Visible="false" UniqueName="ExtCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ExtCostConverted" DataField="ExtCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ExtCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblExtCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Cost Converted" Visible="false" UniqueName="TotalCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalCostConverted" DataField="TotalCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TotalCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 1 Converted" Visible="false" UniqueName="Adjustment1Converted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment1Converted" DataField="Adjustment1Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment1Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment1Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Tax Converted" Visible="false" UniqueName="TaxConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TaxConverted" DataField="TaxConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TaxConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTaxConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Adjustment 2 Converted" Visible="false" UniqueName="Adjustment2Converted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="Adjustment2Converted" DataField="Adjustment2Converted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2Converted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustment2Converted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>


                    </Columns>
                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="LineNumber" meta:resourcekey="GridSortExpressionResource1"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px">



                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnEditSelectedResource1">
                                &nbsp;&nbsp;  
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                SecurityButtonType="AddEditMode_Add"
                                Visible='<%# rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count > 0 Or rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted %>'
                                meta:resourcekey="btnCancelResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <%--                            <telerik:RadToolBar ID="rtbAdd" runat="server" AutoPostBack="true" Style="z-index: 0; border: 0px transparent none; position: static"  CssClass="rtbAdd"
                                 Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'  SecurityButtonType="ItemMode_Add"
                                onclientbuttonclicked="InitiativeDetailCommandItemClicked">
                                <Items>
                                    <telerik:RadToolBarSplitButton  Text="Add11" CssClass="GridCmdInitNewRow" CommandName="AddToolbar"
                                        EnableDefaultButton="false" PostBack="false" EnableImageSprite="true">
                                        <Buttons>
                                            <telerik:RadToolBarButton Width="150px"  CssClass="GridCmdInitNewRow"  Text="<%$ Resources:PMWeb, InitNewRow%>" 
                                                CommandName="InitNewRow" PostBack="true" EnableImageSprite="true" >
                                            </telerik:RadToolBarButton>
                                             <telerik:RadToolBarButton Width="150px"   CssClass="GridCmdAddItems" Text="<%$ Resources:PMWeb, AddItems%>" 
                                                CommandName="AddItems" PostBack="false" EnableImageSprite="true">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton Width="150px" CssClass="GridCmdAddAssembly"  Text="<%$ Resources:PMWeb, AddAssembly%>" 
                                                CommandName="AddAssembly" PostBack="false" EnableImageSprite="true">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton Width="150px"  CssClass="GridCmdWorkOrderAddResources" Text="<%$ Resources:PMWeb, AddResource%>" 
                                                CommandName="WorkOrderAddResources"  PostBack="false"  EnableImageSprite="true">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                </Items>
                            </telerik:RadToolBar>--%>
                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddItems" CommandName="AddItems" runat="server" CausesValidation="False" CssClass="GridCmdAddItems"
                                SecurityButtonType="ItemMode_Add"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=BudgetInitiatives', 910, 580, true);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddAssemblies" CommandName="AddAssembly" runat="server" CausesValidation="False" CssClass="GridCmdAddAssembly"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('EstimateAssembliesSelect.aspx?Source=Initiative',1180,560,true)">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddAssemblies" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddResource" runat="server" CausesValidation="False" CommandName="WorkOrderAddResources" CssClass="GridCmdWorkOrderAddResources"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectResourcesPopup.aspx?Source=Initiative',900,540,true)"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddResource" runat="server" Text="Add Resource(s)" meta:resourcekey="lblAddResource"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                SecurityButtonType="ItemMode_Delete" Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'
                                runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                    meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid "
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label8" Text="Copy To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted)%>'>

                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                            </asp:LinkButton>

                            <span style="text-align: right">
                                <asp:CheckBox runat="server" CssClass="chkAlignMiddle" ID="ckbUseUnits" Text="Use Units" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false"
                                    CssClass="Hide" OnClick="chkUserUnits_OnChekedChanged" />
                            </span>

                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgInitiativeBudgetDetails.EditIndexes.Count = 0 And (Not rdgInitiativeBudgetDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label11" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack "
                                EnableShadows="true" CausesValidation="false"
                                Visible="true">
                            </telerik:RadMenu>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
