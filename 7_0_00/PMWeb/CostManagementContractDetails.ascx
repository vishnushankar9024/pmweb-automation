<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementContractDetails.ascx.vb" Inherits="Website.CostManagementContractDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly"  />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgPrimeContractDetails" runat="server" HasPasteFromExcel="true"
     AutoGenerateColumns="False" ShowStatusBar="false" CssClass="WithoutTopBorder"
    Font-Size="8px" PageSize="15" ShowFooter="true" AllowPaging="True" ShowGroupPanel="true"
    AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" 
    AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" 
    EnableHeaderContextFilterMenu="true" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
        Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
        EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter="true" GroupLoadMode="Client">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right"
                SortExpression="LineNumber"
                Groupable="false" Reorderable="true" DataField="LineNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#Container.DataItem("LineNumber").ToString%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <span>
                        <%#Eval("LineNumber").ToString%></span>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                <ItemTemplate>
                    <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                    </asp:LinkButton>
                </ItemTemplate>
                <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                <HeaderStyle Width="75px" />
                <ItemStyle HorizontalAlign="Right" />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Item" UniqueName="Item" SortExpression="ItemCode" DataField="ItemCode"
                ItemStyle-HorizontalAlign="Right" GroupByExpression="ItemCode [GridColumn_Item] Group By ItemCode ASC"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("ItemCode") = 0, "&nbsp;", Container.DataItem("ItemCode").ToString)%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="lblItemCode" Text='<%#IIf(FormatItemCode(Eval("ItemCode")) = 0, "&nbsp;", Eval("ItemCode").ToString)%>' Width="100%"></asp:Label>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                GroupByExpression="Description [GridColumn_Description] Group By Description" DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
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
                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="250px"
                        Skin="Default" Height="250px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode"
                UniqueName="CostCodeId" DataField="CostCode" GroupByExpression="CostCode [GridColumn_CostCodeId] Group By CostCode ASC"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                    </asp:HyperLink>
                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlCostCodes" Width="100%" DropDownWidth="300px" runat="server"
                        Skin="Default" CloseDropDownOnBlur="true"
                        NoWrap="False" AllowCustomText="False"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM"
                GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" DataField="UOM" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" DropDownWidth="150px" AllowCustomText="true"
                        Skin="Default" Height="250px" MarkFirstMatch="true" Filter="Contains"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right"
                GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity" DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <div id='<%# "Detail_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                        <span style="float: right"><%#FormatNumber(Container.DataItem("Quantity"))%></span>&nbsp;
                    </div>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double"
                        MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC"
                SortExpression="UnitCost" DataField="UnitCost" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
                <ItemStyle  HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" ItemStyle-HorizontalAlign="Right"
                SortExpression="TotalCost" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC" DataField="TotalCost"
                CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblTotalCost" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtTotalCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                        Text='<%#FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn Visible="false" Groupable="false" HeaderText="Markup %" ItemStyle-HorizontalAlign="Right" SortExpression="MarkupPct"
                UniqueName="MarkupPct" DataField="MarkupPct" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#FormatPercent(IIf(Container.DataItem("MarkupPct") Is DBNull.Value, 0, Container.DataItem("CurrencyId")))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMarkupPct" CssClass="Percent" MaxNumber="100" MinNumber="0" runat="server"
                        Text='<%# FormatPercent(Eval("MarkupPct")) %>' Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Markup" Groupable="false" Visible="false" ItemStyle-HorizontalAlign="Right" SortExpression="Markup"
                UniqueName="Markup" DataField="Markup" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#FormatCurrency(IIf(Container.DataItem("Markup") Is DBNull.Value, 0, Container.DataItem("Markup")), CurrencyId:=Eval("CurrencyId"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtMarkup" Width="100%" MaxLength="15" runat="server" CssClass="Currency"
                        Text='<%#FormatCurrency(Eval("Markup"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Total Price" Groupable="false" UniqueName="TotalPrice" ItemStyle-HorizontalAlign="Right"
                SortExpression="TotalPrice" DataField="TotalPrice" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label Text='<%#FormatCurrency(Eval("TotalPrice"), CurrencyId:=Eval("CurrencyId"))%>' runat="server" ID="lblprice" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("TotalPrice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' Width="100%" runat="server"
                        ID="lblTotalPrice" />
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC"
                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px"
                        Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                        EnableItemCaching="true" NoWrap="True" AllowCustomText="true"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
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

            <telerik:GridTemplateColumn HeaderText="Period" UniqueName="Period" SortExpression="Period"
                GroupByExpression="Period [GridColumn_Period] Group By Period ASC" DataField="Period" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Period") = String.Empty, "&nbsp;", Container.DataItem("Period"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPeriod" runat="server" Width="100%" DropDownWidth="300px"
                        Skin="Default" CloseDropDownOnBlur="true" NoWrap="True"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested" ValidationGroup="Save"
                        Style="font-size: 11px" Height="250px">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15"
                DataField="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>
                 
                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))" >
                <span class="Icon"></span>
                </asp:LinkButton>
                </EditItemTemplate>
                <HeaderStyle Width="200px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Req<br>Code" GroupByExpression="ReqCode [GridColumn_ReqCode] Group By ReqCode ASC" ItemStyle-HorizontalAlign="Right"
                SortExpression="ReqCode" UniqueName="ReqCode" DataField="ReqCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <%#IIf(Container.DataItem("ReqCode") = String.Empty, "&nbsp;", Container.DataItem("ReqCode"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtReqCode" runat="server" Text='<%# Eval("ReqCode") %>'
                        Width="100%" MaxLength="200"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="110px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field1" AllowFiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field2" AllowFiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field3" AllowFiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field4" AllowFiltering="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5" AllowFiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6" AllowFiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7" AllowFiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8" AllowFiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9" AllowFiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10" AllowFiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Unit Cost Converted" UniqueName="UnitCostConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" ItemStyle-HorizontalAlign="Right"
                SortExpression="UnitCostConverted" DataField="UnitCostConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <asp:Label Text='<%#FormatCurrency(Eval("UnitCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitCostConverted" />
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Total Cost Converted" UniqueName="TotalCostConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                ItemStyle-HorizontalAlign="Right" SortExpression="TotalCostConverted" DataField="TotalCostConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <asp:Label Text='<%#FormatCurrency(Eval("TotalCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalCostConverted" />
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;
                </EditItemTemplate>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Total Price Converted" UniqueName="TotalPriceConverted" Visible="false" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                ItemStyle-HorizontalAlign="Right" SortExpression="TotalPriceConverted" DataField="TotalPriceConverted" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <span>
                        <asp:Label Text='<%#FormatCurrency(Eval("TotalPriceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalPriceConverted" />
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;
                </EditItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalPrice" Visible="False" />

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
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnEditSelectedResource1">
                  <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                    SecurityButtonType="AddEditMode_Edit"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                    SecurityButtonType="AddEditMode_Add"
                    Visible='<%# rdgPrimeContractDetails.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count > 0 Or rdgPrimeContractDetails.MasterTableView.IsItemInserted %>'
                    meta:resourcekey="btnCancelResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddResource1">
                 <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnAddItems" CommandName="AddItems" CssClass="GridCmdAddItems" runat="server" CausesValidation="False"
                    SecurityButtonType="ItemMode_Add"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnAddItemsResource1" OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=PrimeContract', 910, 580, true);">
                  <span class="Icon"></span>
                    <asp:Label ID="lblAddItems" runat="server" Text="Add items" meta:resourcekey="lblAddItemsResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                   <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                  <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                   <asp:LinkButton ID="btnExportExcel" runat="server"
                                    SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel" 
                                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted)%>'>
                      <span class="Icon"></span>
                                    <asp:Label ID="Label8" text="Export To Exel" runat="server"></asp:Label>
                                    &nbsp;&nbsp
                                </asp:LinkButton> 
                <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                    SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'>
                <span class="Icon"></span>
                    <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                    &nbsp;&nbsp
                </asp:LinkButton>
               
                <span style="width: 100%; text-align: right">
                    <asp:CheckBox runat="server" ID="ckbUseUnits" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" meta:ResourceKey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                    <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false"
                        CssClass="Hide" OnClick="chkUserUnits_OnChekedChanged" />
                </span>
                  <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                    OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgPrimeContractDetails.EditIndexes.Count = 0 And (Not rdgPrimeContractDetails.MasterTableView.IsItemInserted) %>'
                    meta:resourcekey="btnRefreshResource1">
                    <span class="Icon"></span>
                    <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
    <ClientSettings AllowColumnHide="true" AllowDragToGroup="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
    </ClientSettings>
</telerik:RadGrid>

<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>
