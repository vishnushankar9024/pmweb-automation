<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementForecastdetails.ascx.vb"
    Inherits="Website.CostManagementForecastdetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<%--<table style="width:100%" cellpadding="0" cellspacing="0">
<tr>
<td>--%>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgForecastDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgForecastDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbldropdown" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Default"></Calendar>

    <DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" LabelWidth="40%">
        <EmptyMessageStyle Resize="None"></EmptyMessageStyle>

        <ReadOnlyStyle Resize="None"></ReadOnlyStyle>

        <FocusedStyle Resize="None"></FocusedStyle>

        <DisabledStyle Resize="None"></DisabledStyle>

        <InvalidStyle Resize="None"></InvalidStyle>

        <HoveredStyle Resize="None"></HoveredStyle>

        <EnabledStyle Resize="None"></EnabledStyle>
    </DateInput>

    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>

    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>

<textarea type="text" id="txtClipboard" style="position: absolute; left: -9999px;" runat="server" readonly="readonly" />

<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgForecastDetails" runat="server" CssClass="WithoutTopBorder" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                HeaderStyle-Font-Size="8" AutoGenerateColumns="False" AllowPaging="True" HasPasteFromExcel="true" HasCostCodePoup="true"
                PageSize="25" AllowSorting="True" ShowStatusBar="false" AllowMultiRowEdit="True"
                AllowMultiRowSelection="True" ShowGroupPanel="True" ShowFooter="True" GroupPanelPosition="Top" UseEditFormInMobile="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" CommandItemDisplay="Top" EditMode="InPlace" Width="100%" ShowFooter="true"
                    ShowGroupFooter="true" TableLayout="Fixed" EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Projection" UniqueName="Forecast" Groupable="false" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgForecast" Style="cursor: pointer" meta:resourcekey="imgForecast"
                                    ToolTip="Forecast" runat="server">
                                    <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField runat="server" ID="hdnField" />
                            </EditItemTemplate>
                            <HeaderStyle Width="27px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Group1" GroupByExpression="Group1 [GridColumn_Group1] Group By Group1"
                            UniqueName="Group1" SortExpression="Group1" DataField="Group1" DataType="System.String">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Label3" CssClass="NoWrap" Text='<%#Eval("Group1")%>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
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
                            <ItemStyle Wrap="false" HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Cost Code" GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode"
                            UniqueName="CostCode" SortExpression="CostCode" DataField="CostCode" DataType="System.String">
                            <ItemTemplate>
                                <asp:HiddenField runat="server" ID="hdnForecastDetailId" Value='<%#Eval("Id")%>' />
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <HeaderStyle Width="250px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Description" GroupByExpression="Description [GridColumn_Description] Group By Description"
                            UniqueName="Description" SortExpression="Description" DataField="Description" DataType="System.String">
                            <ItemTemplate>
                                <div>
                                    <%#CStr(IIF(Eval("Description") = String.Empty,"&nbsp;",Eval("Description")))%>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" MaxLength="500" Width="100%" ID="txtDescription" Text='<%#Eval("Description")%>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="250px" AutoPostBack="True" OnSelectedIndexChanged="ddlCurrencies_OnSelectedIndexChanged"
                                    Skin="Default" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Total Budget" GroupByExpression="TotalBudget [GridColumn_TotalBudget] Group By TotalBudget"
                            UniqueName="TotalBudget" ItemStyle-HorizontalAlign="Right" SortExpression="TotalBudget"
                            DataField="TotalBudget" DataType="System.Decimal">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TotalBudget"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalBudget" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("TotalBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblTotalBudget1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Anticipated Budget- PV" GroupByExpression="AnticipatedBudget [GridColumn_AnticipatedBudget] Group By AnticipatedBudget"
                            UniqueName="AnticipatedBudget" ItemStyle-HorizontalAlign="Right" SortExpression="AnticipatedBudget"
                            DataField="AnticipatedBudget">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("AnticipatedBudget"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAnticipatedBudget" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("AnticipatedBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblAnticipatedBudget1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Anticipated Cost" UniqueName="AnticipatedCost"
                            ItemStyle-HorizontalAlign="Right" SortExpression="AnticipatedCost" GroupByExpression="AnticipatedCost [GridColumn_AnticipatedCost] Group By AnticipatedCost"
                            DataField="AnticipatedCost">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("AnticipatedCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAnticipatedCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("AnticipatedCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblAnticipatedCost1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Anticipated Variance" UniqueName="AnticipatedVariance"
                            ItemStyle-HorizontalAlign="Right" SortExpression="AnticipatedVariance" GroupByExpression="AnticipatedVariance [GridColumn_AnticipatedVariance] Group By AnticipatedVariance"
                            DataField="AnticipatedVariance">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("AnticipatedVariance"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAnticipatedVariance" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("AnticipatedVariance"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblAnticipatedVariance1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Actual Cost" UniqueName="ActualCost" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ActualCost" GroupByExpression="ActualCost [GridColumn_ActualCost] Group By ActualCost"
                            DataField="ActualCost">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ActualCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblActualCost" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("ActualCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblActualCost1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Balance To Complete" UniqueName="BalanceToComplete"
                            ItemStyle-HorizontalAlign="Right" Groupable="false" DataType="System.Decimal" DataField="BalanceToComplete">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("BalanceToComplete"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblBalanceToComplete" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("BalanceToComplete"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblBalanceToComplete1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="120px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM"
                            GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" DataField="UOM">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("UOMId") = 0, "&nbsp;", Container.DataItem("UOM"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUOMs" Width="100%" DropDownWidth="200px" runat="server" Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" AllowCustomText="true" Height="150px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Quantity To Complete" SortExpression="Quantity" DataField="Quantity"
                            UniqueName="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity">
                            <ItemTemplate>
                                <span>
                                    <%#FormatNumber(Container.DataItem("Quantity"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%#FormatNumber(IIF(Eval("Quantity") is system.DBNULL.value, "1", Eval("Quantity"))) %>'
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="95px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Unit Cost" SortExpression="UnitCost" UniqueName="UnitCost"
                            GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost" DataField="UnitCost">
                            <ItemTemplate>
                                <span>
                                    <%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnitCost" runat="server" MaxLength="15" Text='<%#FormatCurrency(Eval("UnitCost"), , CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                    Width="100%" CssClass="Currency"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Forecast To Complete" UniqueName="ForecastToComplete"
                            GroupByExpression="ForecastToComplete [GridColumn_ForecastToComplete] Group By ForecastToComplete"
                            ItemStyle-HorizontalAlign="Right" SortExpression="ForecastToComplete" DataField="ForecastToComplete">
                            <ItemTemplate>
                                <%#FormatCurrency(Container.DataItem("ForecastToComplete"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" MaxLength="15" CssClass="Currency" ID="txtForecastToComplete"
                                    Width="100%" Text='<%#FormatCurrency(Container.DataItem("ForecastToComplete"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Period" UniqueName="Period" SortExpression="Period"
                            GroupByExpression="Period [GridColumn_Period] Group By Period" DataField="Period">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("Period") = String.Empty, "&nbsp;", Container.DataItem("Period"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Forecast At Completion" GroupByExpression="ForecastAtCompletion [GridColumn_ForecastAtCompletion] Group By ForecastAtCompletion"
                            DataField="ForecastAtCompletion" UniqueName="ForecastAtCompletion" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ForecastAtCompletion">
                            <ItemTemplate>
                                <%#FormatCurrency(Eval("ForecastAtCompletion"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="hdnAntCost" runat="server" Value='<%#FormatCurrency(Eval("AnticipatedCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' />
                                <asp:TextBox runat="server" MaxLength="15" CssClass="Currency" ID="txtForecastAtCompletion"
                                    Width="100%" Text='<%#FormatCurrency(Container.DataItem("ForecastAtCompletion"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Forecast Variance" GroupByExpression="ForecastVariance [GridColumn_ForecastVariance] Group By ForecastVariance"
                            DataField="ForecastVariance" UniqueName="ForecastVariance" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ForecastVariance">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ForecastVariance"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblForecastVariance" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("ForecastVariance"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblForecastVariance1" />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="Task"
                            GroupByExpression="Task [GridColumn_Task] Group By Task ASC" SortExpression="Task">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("Task"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px"
                                    Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                    EnableItemCaching="true" NoWrap="True" AllowCustomText="true"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ddlTasks_SelectedIndexChanged"
                                    Style="font-size: 11px" Height="250px">
                                    <HeaderTemplate>
                                        <table style="width: 435px" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 275px;">
                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal>
                                                </td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal>
                                                </td>
                                                <td style="width: 80px;">
                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal>
                                                </td>
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
                        <telerik:GridTemplateColumn HeaderText="Quantity Completed" SortExpression="QuantityCompleted" DataField="QuantityCompleted"
                            UniqueName="QuantityCompleted" GroupByExpression="QuantityCompleted [GridColumn_QuantityCompleted] Group By QuantityCompleted">
                            <ItemTemplate>
                                <span>
                                    <%#FormatNumber(Container.DataItem("QuantityCompleted"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:HiddenField ID="hdnQuantityBudgeted" runat="server" Value='<%#FormatNumber(Eval("QuantityBudgeted"))%>' />
                                <asp:TextBox ID="txtQuantityCompleted" runat="server" Text='<%#FormatNumber(IIF(Eval("QuantityCompleted") is system.DBNULL.value, "1", Eval("QuantityCompleted"))) %>'
                                    Width="100%" CssClass="Double"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="95px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="% Complete" GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC"
                            UniqueName="PctComplete" SortExpression="PctComplete" DataField="PctComplete">
                            <ItemTemplate>
                                <span>
                                    <%#FormatPercent(Container.DataItem("PctComplete"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPctComplete" CssClass="Percent" runat="server" Width="100%" MaxLength="15"
                                    Text='<%#  FormatPercent(Eval("PctComplete")) %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="72px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Start" SortExpression="StartDate" UniqueName="StartDate"
                            GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC" DataField="StartDate">
                            <ItemTemplate>
                                <asp:Label ID="lblStart" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStart" onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);"
                                    onblur="parseDate(this, event);" runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                             <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Finish" SortExpression="FinishDate" UniqueName="FinishDate"
                            GroupByExpression="FinishDate [GridColumn_FinishDate] Group By FinishDate ASC" DataField="FinishDate">
                            <ItemTemplate>
                                <asp:Label ID="lblFinish" Text="&nbsp;" runat="server"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFinish" onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);"
                                    onblur="parseDate(this, event);" runat="server" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                             <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="70px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Curve" DataField="Curve" SortExpression="Curve"
                            UniqueName="Curve" GroupByExpression="Curve [GridColumn_Curve] Group By Curve ASC">
                            <ItemTemplate>
                                <span>
                                    <%#IIf(Container.DataItem("CurveId") = 0, "&nbsp;", Container.DataItem("Curve"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <telerik:RadComboBox ID="ddlCurves" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Height="200px"></telerik:RadComboBox>

                            </EditItemTemplate>
                            <HeaderStyle Width="90px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="EV" SortExpression="EV" DataField="EV" UniqueName="EV"
                            GroupByExpression="EV [GridColumn_EV] Group By EV">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("EV"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblEV" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("EV"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEV1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CV" SortExpression="CV" DataField="CV" UniqueName="CV"
                            GroupByExpression="CV [GridColumn_CV] Group By CV">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("CV"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblCV" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("CV"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblCV1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CPI" SortExpression="CPI" UniqueName="CPI"
                            GroupByExpression="CPI [GridColumn_CPI] Group By CPI" DataField="CPI">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatNumber(Container.DataItem("CPI"))%>' runat="server" ID="lblCPI" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatNumber(Container.DataItem("CPI"))%>' runat="server" ID="lblCPI1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="SV" SortExpression="SV" DataField="SV" UniqueName="SV"
                            GroupByExpression="SV [GridColumn_SV] Group By SV">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("SV"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblSV" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("SV"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblSV1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="SPI" SortExpression="SPI" UniqueName="SPI"
                            GroupByExpression="SPI [GridColumn_SPI] Group By SPI" DataField="SPI">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatNumber(Container.DataItem("SPI"))%>' runat="server" ID="lblSPI" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label CssClass="Currency" Text='<%#FormatNumber(Container.DataItem("SPI"))%>' runat="server" ID="lblSPI1" />
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes"
                            SortExpression="Notes" DataField="Notes">
                            <ItemTemplate>
                                <div>
                                    <%#CStr(IIF(Eval("Notes") = String.Empty,"&nbsp;",Eval("Notes")))%>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" MaxLength="4000" TextMode="MultiLine" Height="14px" Width="80%"
                                    ID="txtNotes" Text='<%#Eval("Notes")%>' />

                                <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                <span class="Icon"></span>
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Id" Visible="False" />
                        <telerik:GridTemplateColumn HeaderText="Cost Ledger Id" Visible="false" UniqueName="CostLedgerId"
                            ItemStyle-HorizontalAlign="Right" SortExpression="CostLedgerId" DataField="CostLedgerId">
                            <ItemTemplate>
                                <%#Container.DataItem("CostLedgerId")%>
                            </ItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC"
                            UniqueName="Field1" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC"
                            UniqueName="Field2" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC"
                            UniqueName="Field3" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC"
                            UniqueName="Field4" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC"
                            UniqueName="Field5" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC"
                            UniqueName="Field6" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC"
                            UniqueName="Field7" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC"
                            UniqueName="Field8" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC"
                            UniqueName="Field9" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC"
                            UniqueName="Field10" Groupable="false">
                            <ItemTemplate>
                                <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Total Budget Converted" Visible="false" UniqueName="TotalBudgetConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="TotalBudgetConverted" DataField="TotalBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("TotalBudgetConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblTotalBudgetConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Anticipated Budget Converted" Visible="false" UniqueName="AnticipatedBudgetConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="AnticipatedBudgetConverted" DataField="AnticipatedBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("AnticipatedBudgetConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAnticipatedBudgetConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Anticipated Cost Converted" Visible="false" UniqueName="AnticipatedCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="AnticipatedCostConverted" DataField="AnticipatedCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("AnticipatedCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAnticipatedCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Anticipated Variance Converted" Visible="false" UniqueName="AnticipatedVarianceConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="AnticipatedVarianceConverted" DataField="AnticipatedVarianceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("AnticipatedVarianceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAnticipatedVarianceConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Actual Cost Converted" Visible="false" UniqueName="ActualCostConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ActualCostConverted" DataField="ActualCostConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ActualCostConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblActualCostConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Balance To Complete Converted" Visible="false" UniqueName="BalanceToCompleteConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="BalanceToCompleteConverted" DataField="BalanceToCompleteConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("BalanceToCompleteConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblBalanceToCompleteConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Forecast To Complete Converted" Visible="false" UniqueName="ForecastToCompleteConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ForecastToCompleteConverted" DataField="ForecastToCompleteConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ForecastToCompleteConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblForecastToCompleteConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Forecast at Completion Converted" Visible="false" UniqueName="ForecastAtCompletionConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ForecastAtCompletionConverted" DataField="ForecastAtCompletionConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ForecastAtCompletionConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblForecastAtCompletionConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Forecast Variance Converted" Visible="false" UniqueName="ForecastVarianceConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="ForecastVarianceConverted" DataField="ForecastVarianceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("ForecastVarianceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblForecastVarianceConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="EV Converted" Visible="false" UniqueName="EVConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="EVConverted" DataField="EVConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("EVConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblEVConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CV Converted" Visible="false" UniqueName="CVConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="CVConverted" DataField="CVConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("CVConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblCVConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="SVConverted" Visible="false" UniqueName="SVConverted" ItemStyle-HorizontalAlign="Right"
                            SortExpression="SVConverted" DataField="SVConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label Text='<%#FormatCurrency(Eval("SVConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblSVConverted" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="Group1"></telerik:GridSortExpression>
                    </SortExpressions>
                    <CommandItemTemplate>
                        <div style="padding: 2px; vertical-align: middle">
                            <%--  <asp:LinkButton ID="btnForeCastSelectedLine" runat="server" CausesValidation="False"
                     OnClientClick="OpenForecastCostsPopup();return false;" SecurityButtonType="ItemMode_Edit" CommandName="ForeCastSelectedLine"
                     Visible="true" meta:resourcekey="btnForeCastSelectedLineResource1">
                    <img style="border: 0px; vertical-align: middle;" src="Images/CostControl/SmallForecastLines.png" />
                    <asp:Label ID="lblForeCastSelectedLine" runat="server" Text="Forecast Selected Line"
                            meta:resourcekey="lblForeCastSelectedLine"></asp:Label>&nbsp;&nbsp;
                </asp:LinkButton>--%>
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                SecurityButtonType="ItemMode_Edit" Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditInPlace" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgForecastDetails.EditIndexes.Count > 0 %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                SecurityButtonType="AddEditMode" Visible='<%# rdgForecastDetails.EditIndexes.Count > 0 Or rdgForecastDetails.MasterTableView.IsItemInserted %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnAddCostCodes" CommandName="AddCostCodes" CssClass="GridCmdAddCostCodes" runat="server" CausesValidation="False"
                                Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenCostCodesPOPUp('COSTMANAGEMENT_FORECAST', 1000, 600);">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddCostCodes" meta:resourcekey="lblAddCostCodes" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'
                                SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                <span class="Icon"></span>

                                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUpdateTasks" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmUpdateTasks();"
                                SecurityButtonType="ItemMode_Edit" CommandName="UpdateTasks" CssClass="GridCmdUpdateTasks" Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>

                                <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                SecurityButtonType="ItemMode" Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnExportExcel" runat="server"
                                SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted)%>'>
                                <span class="Icon"></span>
                                <asp:Label ID="Label5" Text="Export To Exel" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                SecurityButtonType="ItemMode_Add" CausesValidation="False" CommandName="PasteClipBoard" CssClass="GridCmdPasteClipBoard"
                                Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'>
                                <span class="Icon"></span>
                                <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                &nbsp;&nbsp
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnProduction" runat="server" CausesValidation="False" CommandName="Production" CssClass="GridCmdProduction"
                                SecurityButtonType="ItemMode_Edit" Text="Production" meta:resourcekey="btnProduction"
                                Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'
                                OnClientClick="return OpenProductionPopup(); ">
                                <span class="Icon"></span>
                                <asp:Label ID="Label4" runat="server" Text="Production"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <span style="width: 100%; text-align: right">
                                <asp:CheckBox runat="server" ID="ckbUseUnits" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" meta:resourcekey="ckbUseUnits"
                                    SecurityButtonType="ItemMode_Edit" />
                                <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false" CssClass="Hide"
                                    OnClick="chkUserUnits_OnChekedChanged" />
                                <asp:Button runat="server" ID="btnEditRowsFromCostCodesPopup" CommandName="EditRowsFromCostCodesPopup"
                                    CausesValidation="false" CssClass="Hide" />
                            </span>

                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgForecastDetails.EditIndexes.Count = 0 And (Not rdgForecastDetails.MasterTableView.IsItemInserted) %>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label3" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                <ClientSettings ClientEvents-OnRowDeselected="ForeCast_RowDeselected" ClientEvents-OnRowSelected="ForeCast_RowSelected"
                    Selecting-AllowRowSelect="true" AllowColumnHide="true" AllowColumnsReorder="true"
                    AllowDragToGroup="true">
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>

<input type="button" id="btnClipborad" class="Hide" runat="server" />
<input type="hidden" id="hdClipboard" runat="server" />
