<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ChangeEventDetails.ascx.vb" Inherits="Website.ChangeEventDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<telerik:RadAjaxLoadingPanel ID="ldpChangeEventDetails" runat="server" EnableSkinTransparency="true"
    BackgroundPosition="Center" Skin="Default" />
<style>
    .RadMultiPage .rmpView.rmpHidden.ShowInHeaderWhenFit .ResponsiveMargin {
        padding-top: 0px;
    }
</style>


<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <fieldset>
                <legend>
                    <asp:Label ID="lblBudget" runat="server" meta:resourcekey="lblBudget" Text="Budget"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgChangeEventDetails" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true"
                    PageSize="10" AllowPaging="true" ShowFooter="true" ShowGroupPanel="True"
                    AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="true" CssClass="WithoutTopBorder">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <GroupPanel Text="<%$Resources:PMWeb, Grid_GroupPanel %>"></GroupPanel>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        NoDetailRecordsText="" DataKeyNames="Id"
                        CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" Name="Budget"
                        UseAllDataFields="true" EditMode="InPlace" EnableHeaderContextMenu="true" TableLayout="Fixed" ShowGroupFooter="true" GroupLoadMode="Client">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" Groupable="false" Reorderable="true" UniqueName="Line" AllowFiltering="false">
                                <ItemTemplate>
                                    <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate>

                                <HeaderStyle Width="60px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Status" SortExpression="CostLedgerStatus" DataField="CostLedgerStatus"
                                UniqueName="CostLedgerStatus" GroupByExpression="CostLedgerStatus [GridColumn_CostLedgerStatus] Group By CostLedgerStatus">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("CostLedgerStatus") = String.Empty, "&nbsp;", Container.DataItem("CostLedgerStatus"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox runat="server" ID="ddlCostLedgerStatuses" Width="100%" />
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Item " SortExpression="ItemCode" UniqueName="ItemCode" DataField="ItemCode"
                                GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtItemCode" runat="server"
                                        Text='<%#Eval("ItemCode")%>' Width="100%" ReadOnly="true"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description" DataField="Description"
                                GroupByExpression="Description [GridColumn_Description] Group By Description">
                                <ItemTemplate>
                                    <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" runat="server" MaxLength="500" Text='<%#Eval("Description")%>' Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="220px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency" DataField="Currency"
                                GroupByExpression="Currency [GridColumn_Currency] Group By Currency">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%"
                                        Skin="Default" Height="250px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" DataField="UOM"
                                GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox runat="server" ID="ddlUOMs" Width="100%" AllowCustomText="true">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity"
                                GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity" DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                <ItemTemplate>
                                    <div id='<%# "Detail_" & Eval("DetailId").ToString()%>' oncontextmenu="BudgetcontextM(this,event)" style="width: 100%; height: 100%;">
                                        <span style="float: right"><%# FormatNumber(Container.DataItem("Quantity"))%></span>&nbsp;
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtQuantity" MaxLength="15" runat="server" Text='<%#FormatNumber(ParseDouble(Eval("Quantity"), 1))%>'
                                        Width="100%" CssClass="Double" Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOMs'),'ASP',0)"></asp:TextBox>

                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn HeaderText="Unit Cost" SortExpression="UnitCost" UniqueName="UnitCost"
                                GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost" DataField="UnitCost">
                                <ItemTemplate>
                                    <%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUnitCost" runat="server" Text='<%#FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                        Width="100%" MaxLength="15" CssClass="Currency"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>



                            <telerik:GridTemplateColumn HeaderText="Adjustment 1" UniqueName="Adjustment1" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Adjustment1" DataField="Adjustment1" GroupByExpression="Adjustment1 [GridColumn_Adjustment1] Group By Adjustment1 ASC"
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
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
                                CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <asp:Label Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblAdjustments" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label CssClass="Currency" Text='<%#FormatCurrency(Eval("Adjustment2"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' runat="server" ID="lblEditAdjustment2" />
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="110px"></HeaderStyle>
                            </telerik:GridTemplateColumn>



                            <telerik:GridTemplateColumn HeaderText="Project Budget" SortExpression="ProjectBudget"
                                UniqueName="ProjectBudget" GroupByExpression="ProjectBudget [GridColumn_ProjectBudget] Group By ProjectBudget" DataField="ProjectBudget">
                                <ItemTemplate>
                                    <asp:Label ID="lblProjectBudget" runat="server" Text='<%#FormatCurrency(Container.DataItem("ProjectBudget"), CurrencyId:=Container.DataItem("CurrencyId"))%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtProjectBudget" MaxLength="15" runat="server" CssClass="Currency" Text='<%#FormatCurrency(Eval("ProjectBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                        Width="100%"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>



                            <telerik:GridTemplateColumn HeaderText="Unit Price" SortExpression="UnitPrice" UniqueName="UnitPrice"
                                GroupByExpression="UnitPrice [GridColumn_UnitPrice] Group By UnitPrice" DataField="UnitPrice">
                                <ItemTemplate>
                                    <%#FormatCurrency(Container.DataItem("UnitPrice"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUnitPrice" runat="server" Text='<%#FormatCurrency(Eval("UnitPrice"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                        Width="100%" CssClass="Currency" MaxLength="15"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>




                            <telerik:GridTemplateColumn HeaderText="Owner Budget" SortExpression="OwnerBudget"
                                UniqueName="OwnerBudget" GroupByExpression="OwnerBudget [GridColumn_OwnerBudget] Group By OwnerBudget" DataField="OwnerBudget">
                                <ItemTemplate>
                                    <asp:Label ID="lblOwnerBudget" runat="server" Text='<%#FormatCurrency(Container.DataItem("OwnerBudget"), CurrencyId:=Container.DataItem("CurrencyId"))%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtOwnerBudget" runat="server" Text='<%#FormatCurrency(Eval("OwnerBudget"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                        Width="100%" MaxLength="15" CssClass="Currency"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>



                            <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC" DataField="CostType"
                                UniqueName="CostType">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="90px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase" DataField="Phase"
                                HeaderStyle-Width="150px" SortExpression="Phase" GroupByExpression="Phase [GridColumn_Phase] Group By Phase ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                        Skin="Default" Height="200px" CloseDropDownOnBlur="true"
                                        Width="100%" NoWrap="true" CausesValidation="False">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                                GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" AutoPostBack="false"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
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
                            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" DataField="Location"
                                HeaderStyle-Width="150px" SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location").ToString)%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlLocation" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                        Skin="Default" CloseDropDownOnBlur="true"
                                        Width="100%" Height="200px" NoWrap="true" CausesValidation="False">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Contract" SortExpression="Contract" UniqueName="PrimeContract" DataField="Contract"
                                GroupByExpression="Contract [GridColumn_PrimeContract] Group By Contract ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Contract") = String.Empty, "&nbsp;", Container.DataItem("Contract"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlPrimeContract" runat="server" Width="100%" Filter="Contains"
                                        Skin="Default" CloseDropDownOnBlur="true" OnSelectedIndexChanged="ResetContractCombos" AutoPostBack="True"
                                        NoWrap="True" AllowCustomText="true"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" ValidationGroup="SaveBudgetDetails"
                                        Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Contract Line" SortExpression="BudgetContractLine" DataField="BudgetContractLine"
                                UniqueName="BudgetContractLine" GroupByExpression="BudgetContractLine [GridColumn_BudgetContractLine] Group By BudgetContractLine ASC">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("BudgetContractLine") = String.Empty, "&nbsp;", Container.DataItem("BudgetContractLine"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlbudgetContractLine" Width="100%" runat="server" Skin="Default"
                                        CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="False"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Details_GetContractValueToReturn" AutoPostBack="True" OnSelectedIndexChanged="ddlbudgetContractLine_OnSelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
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
                                <HeaderStyle Width="90px" />
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" DataField="CostCode"
                                GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                    </asp:HyperLink>
                                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                        Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AllowCustomText="False"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" ValidationGroup="SaveBudgetDetails"
                                        Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>
                                    <div>
                                        <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>"
                                            Display="Dynamic" Enabled="false" ForeColor="" ValidationGroup="SaveBudgetDetails"></asp:RequiredFieldValidator>

                                        <%--   <asp:CustomValidator Enabled ="false" ID="csvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"           
                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>">
                        </asp:CustomValidator> --%>
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" DataField="Period"
                                GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIF(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlPeriods" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                        runat="server" AutoPostBack="False" Skin="Default" NoWrap="true" Width="100%"
                                        Height="200px" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" Style="font-size: 11px" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="80px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task" DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%"
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

                            <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                                GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                <ItemTemplate>
                                    <div><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" runat="server" Text='<%#Eval("Notes")%>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                    <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
    					                        <span class="Icon"></span>
                                    </asp:LinkButton>

                                </EditItemTemplate>
                                <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Cost Ledger ID" SortExpression="CostLedgerId" DataField="CostLedgerId"
                                UniqueName="CostLedgerId" GroupByExpression="CostLedgerId [GridColumn_CostLedgerId] Group By CostLedgerId ASC">
                                <ItemTemplate>
                                    <%#Container.DataItem("CostLedgerId")%>
                                </ItemTemplate>
                                <EditItemTemplate><span>&nbsp;</span></EditItemTemplate>
                                <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Contract CO ID" ItemStyle-HorizontalAlign="Right" DataField="PostBackUrl"
                                SortExpression="ContractCoId" UniqueName="ContractCoId" GroupByExpression="ContractCoId [GridColumn_ContractCoId] Group By ContractCoId ASC">
                                <ItemTemplate><a runat="server" id="hypCENumber" href='<%#Eval("PostBackUrl")%>'><%# Eval("ContractCoId")%> </a>&nbsp;</ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Requisition ID" ItemStyle-HorizontalAlign="Right" DataField="RequisitionNumber"
                                SortExpression="RequisitionNumber" UniqueName="RequisitionNumber" GroupByExpression="RequisitionNumber [GridColumn_RequisitionNumber] Group By RequisitionNumber ASC">
                                <ItemTemplate>
                                    <%#Eval("RequisitionNumber")%>&nbsp;
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                                Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />

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

                            <telerik:GridTemplateColumn HeaderText="Project Budget Converted" Visible="false" UniqueName="ProjectBudgetConverted" ItemStyle-HorizontalAlign="Right"
                                SortExpression="ProjectBudgetConverted" DataField="ProjectBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <asp:Label Text='<%#FormatCurrency(Eval("ProjectBudgetConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblProjectBudgetConverted" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    &nbsp;
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Unit Price Converted" Visible="false" UniqueName="UnitPriceConverted" ItemStyle-HorizontalAlign="Right"
                                SortExpression="UnitPriceConverted" DataField="UnitPriceConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <asp:Label Text='<%#FormatCurrency(Eval("UnitPriceConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblUnitPriceConverted" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    &nbsp;
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Owner Budget Converted" Visible="false" UniqueName="OwnerBudgetConverted" ItemStyle-HorizontalAlign="Right"
                                SortExpression="OwnerBudgetConverted" DataField="OwnerBudgetConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <asp:Label Text='<%#FormatCurrency(Eval("OwnerBudgetConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblOwnerBudgetConverted" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    &nbsp;
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <FooterStyle CssClass="GridFooter" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <ItemStyle Wrap="false" />
                        <SortExpressions>
                            <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                        </SortExpressions>
                        <CommandItemTemplate>
                            <div style="padding: 2px">

                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false"
                                    SecurityButtonType="ItemMode_Edit"
                                    CommandName="EditRows" CssClass="GridCmdEditSelectedLines" Visible='<%# rdgChangeEventDetails.EditIndexes.Count = 0 And (Not rdgChangeEventDetails.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelected" runat="server" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="SaveBudgetDetails"
                                    SecurityButtonType="AddEditMode_Edit"
                                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgChangeEventDetails.EditIndexes.Count > 0 %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdateEdited" runat="server" Text="s"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="SaveBudgetDetails"
                                    SecurityButtonType="AddEditMode_Add"
                                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgChangeEventDetails.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="Save"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false"
                                    SecurityButtonType="AddEditMode"
                                    CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgChangeEventDetails.EditIndexes.Count > 0 Or rdgChangeEventDetails.MasterTableView.IsItemInserted %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                    SecurityButtonType="ItemMode_Add"
                                    CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible='<%# rdgChangeEventDetails.EditIndexes.Count = 0 And (Not rdgChangeEventDetails.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAdd" runat="server" Text="Add line"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False"
                                    SecurityButtonType="ItemMode_Add" CommandName="AddItems" CssClass="GridCmdAddItems"
                                    Visible='<%# rdgChangeEventDetails.EditIndexes.Count = 0 And (Not rdgChangeEventDetails.MasterTableView.IsItemInserted) %>'
                                    OnClientClick="return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=ChangeEvent', 910, 580, true, 'rdgChangeEventDetails');">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddItems" runat="server" Text=""></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                    Visible='<%# rdgChangeEventDetails.EditIndexes.Count = 0 And (Not rdgChangeEventDetails.MasterTableView.IsItemInserted) %>'
                                    SecurityButtonType="ItemMode_Delete" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDelete" runat="server" Text="Delete selected lines"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                    SecurityButtonType="ItemMode"
                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgChangeEventDetails.EditIndexes.Count = 0 And (Not rdgChangeEventDetails.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                <span style="width: 100%; text-align: right">
                                    <asp:CheckBox runat="server" ID="ckbUseUnits" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                    <asp:Button runat="server" ID="btnUseUnits" CausesValidation="false"
                                        CssClass="Hide" OnClick="chkUserUnits_OnChekedChanged" />
                                </span>

                                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                    OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                    SecurityButtonType="ItemMode"
                                    Visible='<%# rdgChangeEventDetails.EditIndexes.Count = 0 And (Not rdgChangeEventDetails.MasterTableView.IsItemInserted)%>'
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
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true"
                        AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                            AllowColumnResize="True"></Resizing>
                        <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                    </ClientSettings>
                    <ValidationSettings ValidationGroup="SaveBudgetDetails" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <fieldset>
                <legend>
                    <asp:Label ID="lblCost" runat="server" meta:resourcekey="lblCost" Text="Cost"></asp:Label>
                </legend>
                <telerik:RadGrid ID="rdgCost"
                    FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" ShowFooter="true"
                    runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="10" HeaderStyle-Font-Size="8" AllowMultiRowEdit="true"
                    AllowFilteringByColumn="true" AllowMultiRowSelection="true" ShowGroupPanel="True" AllowSorting="true" UseEditFormInMobile="true">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <GroupPanel Text="Group by"></GroupPanel>

                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace" Name="Cost" ShowGroupFooter="true" GroupLoadMode="Client">

                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right" AllowFiltering="false"
                                SortExpression="LineNumber" Groupable="false">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <span><%#Eval("LineNumber").ToString%></span>
                                </EditItemTemplate>
                                <HeaderStyle Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Status" SortExpression="CostLedgerStatus" DataField="CostLedgerStatus"
                                UniqueName="CostLedgerStatus" GroupByExpression="CostLedgerStatus [GridColumn_CostLedgerStatus] Group By CostLedgerStatus ASC">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("CostLedgerStatus") = String.Empty, "&nbsp;", Container.DataItem("CostLedgerStatus"))%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox runat="server" ID="ddlCostLedgerStatuses" Width="100%" />
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Linked Budget Line" SortExpression="ChangeEventDetailId" UniqueName="ChangeEventDetailId" DataField="ChangeEventDetailDescription"
                                GroupByExpression="ChangeEventDetailId [GridColumn_ChangeEventDetailId] Group By ChangeEventDetailId ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("ChangeEventDetailId") = "-1" Or Container.DataItem("ChangeEventDetailId") = "0", "&nbsp;", Container.DataItem("ChangeEventDetailDescription"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlLinkedBudgetLine" runat="server" OnClientSelectedIndexChanged="ddlLinkSelectedIndexChanged" Width="100%" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Item" UniqueName="ItemCode" SortExpression="ItemCode" DataField="ItemCode"
                                ItemStyle-HorizontalAlign="Right" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtItemCode" runat="server" Text='<%# Eval("ItemCode") %>' Width="100%" Enabled="false"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description" DataField="Description"
                                GroupByExpression="Description [GridColumn_Description] Group By Description">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency" DataField="Currency"
                                GroupByExpression="Currency [GridColumn_Currency] Group By Currency">
                                <ItemTemplate>
                                    <span>
                                        <%#IIf(Container.DataItem("Currency") = String.Empty, "&nbsp;", Container.DataItem("Currency"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%"
                                        Skin="Default" Height="250px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" DataField="UOM"
                                GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%" AllowCustomText="true"></telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right" DataField="Quantity" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" SortExpression="Quantity">
                                <ItemTemplate>
                                    <div id='<%# "Detail_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                                        <span style="float: right"><%# IIf(CDbl(ParseDouble(Container.DataItem("Quantity"), 1)) = CInt(ParseDouble(Container.DataItem("Quantity"), 1)), FormatNumber(ParseDouble(Container.DataItem("Quantity"), 1)), FormatNumber(ParseDouble(Container.DataItem("Quantity"), 1), 5).TrimEnd("0"))%></span>&nbsp;
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>

                                    <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double" Precision="5" MaxLength="15"
                                        Text='<%# IIf(CDbl(ParseDouble(Eval("Quantity"), 1)) = CInt(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1), 5).TrimEnd("0"))%>'
                                        Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOMs'),'ASP',0)"></asp:TextBox>
                                    <asp:HiddenField ID="hdnRevisedBy" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" DataField="UnitCost"
                                GroupByExpression="UnitCost [GridColumn_UnitCost] Group By UnitCost ASC" SortExpression="UnitCost">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Ext. Cost" UniqueName="ExtCost" DataField="ExtCost"
                                GroupByExpression="ExtCost [GridColumn_ExtCost] Group By ExtCost ASC" SortExpression="ExtCost">
                                <ItemTemplate>
                                    <div id='<%# "DetailV_" & Eval("DetailId").ToString()%>' oncontextmenu="contextM(this,event)" style="width: 100%; height: 100%;">
                                        <span style="float: right"><%#FormatCurrency(Container.DataItem("ExtCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>&nbsp;
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtExtCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(Eval("ExtCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Commitment" UniqueName="Commitment" DataField="Commitment"
                                GroupByExpression="Commitment [GridColumn_Commitment] Group By Commitment ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Commitment") = String.Empty, "&nbsp;", Container.DataItem("Commitment"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCommitments" runat="server" Width="100%" Filter="Contains" Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" OnSelectedIndexChanged="ResetCombos" AutoPostBack="True" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostType" GroupByExpression="CostType [GridColumn_CostType] Group By CostType ASC"
                                UniqueName="CostType" DataField="CostType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="110px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase" HeaderStyle-Width="150px" DataField="Phase"
                                SortExpression="Phase" GroupByExpression="Phase [GridColumn_Phase] Group By Phase ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                        Skin="Default" Height="200px" CloseDropDownOnBlur="true"
                                        Width="100%" NoWrap="true" CausesValidation="False">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                                GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlWBSCost" runat="server" Width="110px" AutoPostBack="false"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>

                                        <asp:LinkButton runat="server" ID="imgWBSCost" CssClass="SearchButton">
    					    <span class="Icon"></span>
                                        </asp:LinkButton>

                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" DataField="Location"
                                HeaderStyle-Width="150px" SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location").ToString)%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlLocation" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                        Skin="Default" CloseDropDownOnBlur="true"
                                        Width="100%" Height="200px" NoWrap="true" CausesValidation="False">
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Commitment Line" SortExpression="ContractLine" DataField="ContractLine"
                                UniqueName="ContractLine" GroupByExpression="ContractLine [GridColumn_ContractLine] Group By ContractLine ASC">
                                <ItemTemplate>
                                    <span><%# IIf(Container.DataItem("ContractLine") = String.Empty, "&nbsp;", Container.DataItem("ContractLine"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlContractLine" Width="100%" runat="server" Skin="Default"
                                        CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="False"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Details_GetValueToReturn" OnSelectedIndexChanged="ddlContractLine_OnSelectedIndexChanged" AutoPostBack="true">
                                    </telerik:RadComboBox>

                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Cost Code" SortExpression="CostCode" UniqueName="CostCode" DataField="CostCode"
                                GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                    </asp:HyperLink>
                                    <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" Filter="Contains" Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>
                                    <div>
                                        <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>"
                                            Display="Dynamic" Enabled="false" ForeColor="" ValidationGroup="SaveCostDetails">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Days" UniqueName="Days" ItemStyle-HorizontalAlign="Right" DataField="Days" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                GroupByExpression="Days [GridColumn_Days] Group By Days ASC" SortExpression="Days">
                                <ItemTemplate>
                                    <span><%# FormatNumber(Container.DataItem("Days"), 2)%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDays" runat="server" Width="100%" CssClass="Double" MaxLength="15" Text='<%#FormatNumber(ParseDouble(Eval("Days")),2) %>'></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="75px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Period" UniqueName="Period" SortExpression="Period" DataField="Period"
                                GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIF(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlPeriods" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                        runat="server" AutoPostBack="False" Skin="Default" NoWrap="true" Width="100%"
                                        Height="200px" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" Style="font-size: 11px" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Assigned To" SortExpression="AssignedTo" UniqueName="AssignedTo" DataField="AssignedTo"
                                GroupByExpression="AssignedTo [GridColumn_AssignedTo] Group By AssignedTo ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("AssignedToId") = "-1" Or Container.DataItem("AssignedTo") = "0", "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div style="width: 100%; white-space: nowrap">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="85%" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>

                                        <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
    					            <span class="Icon"></span>
                                        </asp:LinkButton>

                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </div>
                                </EditItemTemplate>
                                <HeaderStyle Width="120px"></HeaderStyle>
                                <ItemStyle Wrap="false" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Funding" SortExpression="Funded" UniqueName="Funded" DataField="Funded" GroupByExpression="Funded [GridColumn_Funded] Group By Funded ASC">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Container.DataItem("Funded"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                    <asp:LinkButton ID="btnGenerateFunding" CssClass="FilledDetails" Text="" runat="server">
                            <span class="Icon"></span>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFunded" runat="server" Text='<%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' Width="80%" CssClass="Currency"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                                <HeaderStyle Width="130px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Funding Code" UniqueName="FundingCode" SortExpression="FundingCode" DataField="FundingCode"
                                GroupByExpression="FundingCode [GridColumn_FundingCode] Group By FundingCode ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("FundingCodeId") = "-1", "&nbsp;", IIf(Container.DataItem("FundingCodeId") = "0", PM.LanguagesInfo.SPLIT, Container.DataItem("FundingCode")))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlFundingCodes" runat="server" Width="100%" Filter="Contains" Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested" ValidationGroup="SaveCostDetails" Style="font-size: 11px" Height="250px">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes"
                                GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000" TextMode="MultiLine" Height="14px" meta:resourcekey="txtNotes1Resource1"></asp:TextBox>

                                    <asp:LinkButton runat="server" ID="imgNotes1" CssClass="SearchButton" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes1','txtNotes'))">
    					    <span class="Icon"></span>
                                    </asp:LinkButton>

                                </EditItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Change Request ID" ItemStyle-HorizontalAlign="left" DataField="ChangeRequestID"
                                SortExpression="ChangeRequestID" UniqueName="ChangeRequestID" GroupByExpression="ChangeRequestID [GridColumn_ChangeRequestID] Group By ChangeRequestID ASC">
                                <ItemTemplate>
                                    <a runat="server" id="hypOCRNumber" href='<%#Eval("OCRPostBackUrl")%>'><%# Eval("ChangeRequestID")%> </a>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtChangeRequestID" runat="server" Enabled="false" Width="100%" MaxLength="9" Text='<%#Eval("ChangeRequestID")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Commitment CO" ItemStyle-HorizontalAlign="left" DataField="CommitmentCOID"
                                SortExpression="CommitmentCOID" UniqueName="CommitmentCOID" GroupByExpression="CommitmentCOID [GridColumn_CommitmentCOID] Group By CommitmentCOID ASC">
                                <ItemTemplate>
                                    <a runat="server" id="hypCENumber" href='<%#Eval("PostBackUrl")%>'><%# Eval("CommitmentCOID")%> </a>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCommitmentCOID" runat="server" Enabled="false" Width="100%" MaxLength="9" Text='<%#Eval("CommitmentCOId")%>' meta:resourcekey="txtCommitmentCOIdResource1"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Invoice #" ItemStyle-HorizontalAlign="Right" DataField="InvoiceNumber"
                                SortExpression="InvoiceNumber" UniqueName="InvoiceNumber" GroupByExpression="InvoiceNumber [GridColumn_InvoiceNumber] Group By InvoiceNumber ASC">
                                <ItemTemplate>
                                    <%#Eval("InvoiceNumber")%>&nbsp;
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Unit Cost Approved" ItemStyle-HorizontalAlign="Right" UniqueName="UnitCostApproved" DataField="UnitCostApproved"
                                SortExpression="UnitCostApproved" GroupByExpression="UnitCostApproved [GridColumn_UnitCostApproved] Group By UnitCostApproved ASC">
                                <ItemTemplate>
                                    <%#FormatCurrency(Container.DataItem("UnitCostApproved"), CurrencyId:=Container.DataItem("CurrencyId"))%>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUnitCostApproved" CssClass="Currency" runat="server" Enabled="false" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("UnitCostApproved"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' meta:resourcekey="txtUnitCostApprovedResource1"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Ext. Cost Approved" ItemStyle-HorizontalAlign="Right" DataField="ExtCostApproved"
                                SortExpression="ExtCostApproved" UniqueName="ExtCostApproved" GroupByExpression="ExtCostApproved [GridColumn_ExtCostApproved] Group By ExtCostApproved ASC">
                                <ItemTemplate>
                                    <span><%#FormatCurrency(Container.DataItem("ExtCostApproved"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtExtCostApproved" CssClass="Currency" runat="server" Enabled="false" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("ExtCostApproved"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' meta:resourcekey="txtExtCostApprovedResource1"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Cost Ledger" ItemStyle-HorizontalAlign="Right" DataField="CostLedgerID"
                                SortExpression="CostLedgerID" UniqueName="CostLedgerId" GroupByExpression="CostLedgerID [GridColumn_CostLedgerId] Group By CostLedgerID ASC">
                                <ItemTemplate>
                                    <%#Container.DataItem("CostLedgerID")%>&nbsp;
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCostLedgerID" runat="server" ReadOnly="true" Width="100%" MaxLength="9" Text='<%#Eval("CostLedgerID")%>' meta:resourcekey="txtCostLedgerIDResource1"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10" Groupable="false">
                                <ItemTemplate>
                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                                </EditItemTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn Aggregate="SUM" DataField="Quantity" Visible="False" />
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
                        </Columns>

                        <FooterStyle CssClass="GridFooter" />
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />

                        <CommandItemTemplate>
                            <div style="padding: 2px">
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditSelectedLines"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>'
                                    SecurityButtonType="ItemMode_Edit">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="<%$ Resources:PMWeb, EditRows %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnUpdateEdited" ValidationGroup="SaveCostDetails" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgCost.EditIndexes.Count > 0 %>'
                                    meta:resourcekey="btnUpdateEditedResource1" SecurityButtonType="AddEditMode_Edit">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblUpdate" runat="server" Text="<%$ Resources:PMWeb, UpdateEdited %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="SaveCostDetails" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" SecurityButtonType="AddEditMode_Add"
                                    Visible='<%# rdgCost.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblSave" runat="server" Text="<%$ Resources:PMWeb, PerformInsert %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                    Visible='<%# rdgCost.EditIndexes.Count > 0 Or rdgCost.MasterTableView.IsItemInserted %>'
                                    meta:resourcekey="btnCancelResource1" SecurityButtonType="AddEditMode">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblCancel" runat="server" Text="<%$ Resources:PMWeb, CancelAll %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>' SecurityButtonType="ItemMode_Add">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddLine" runat="server" Text="<%$ Resources:PMWeb, InitNewRow %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnAddItems" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>' CommandName="AddItems" CssClass="GridCmdAddItems">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblAddItems" runat="server" Text="<%$ Resources:PMWeb, AddItems %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnAddLinked" runat="server" CommandName="AddLinked" CssClass="GridCmdAddLinked" SecurityButtonType="ItemMode_Add" OnClientClick="return AddLinkedRow()"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:PMWeb, AddLinked %>"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnLinkOCR" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdLinkOCR"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>'
                                    OnClientClick="return OpenPOPUp('OCRCEPopup.aspx', 500, 600, true,'rdgCost');">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblLinkOCR" runat="server" Text="Link Change Request(s)" meta:resourcekey="lblLinkOCR"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>'
                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1" SecurityButtonType="ItemMode_Delete">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDelete" runat="server" Text="<%$ Resources:PMWeb, DeleteRows %>"></asp:Label>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" SecurityButtonType="ItemMode"
                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted) %>'>
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                                </asp:LinkButton>

                                &nbsp;&nbsp;
                                             <span style="width: 100%; text-align: right;">
                                                 <asp:CheckBox ID="chbUseUnits" runat="server" AutoPostBack="true" Text="Use Units" CssClass="chkAlignMiddle mobile-switch" OnCheckedChanged="chbCostUserUnits_OnChekedChanged" meta:resourcekey="chbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                             </span>
                                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridPreviewConversion"
                                    OnClientClick="return OpenPreviewConversionCost();" Style="float: none !important"
                                    SecurityButtonType="ItemMode"
                                    Visible='<%# rdgCost.EditIndexes.Count = 0 And (Not rdgCost.MasterTableView.IsItemInserted)%>'
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
                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>
</div>
