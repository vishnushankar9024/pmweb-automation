<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourcesRequirementDetails.ascx.vb" Inherits="Website.ResourcesRequirementDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRequirementDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRequirementDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel ID="ldpRequirements" runat="server" />
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgRequirementDetails" runat="server" AllowFilteringByColumn="True" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="250" ShowFooter="false" DataKeyNames="Id" UseEditFormInMobile="true"
                AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="false" CssClass="WithoutTopBorder"
                AllowSorting="True" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="false" FooterStyle-HorizontalAlign="Right"
                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                    TableLayout="Fixed">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="Image" HeaderText="" AllowFiltering="false" Groupable="false">
                            <ItemTemplate>
                                <asp:Image ID="imgResource" runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <HeaderStyle Width="90px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="ResourceType" HeaderText="Resource Type" DataField="ResourceType"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="ResourceType [GridColumn_ResourceType] Group By ResourceType" SortExpression="ResourceType">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("ResourceType") = String.Empty, "&nbsp;", Container.DataItem("ResourceType"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlResourceTypes" runat="server" Width="100%" OnClientSelectedIndexChanged="ResetCombos" DropDownWidth="405px"
                                    Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="Resource" HeaderText="Resource" DataField="Resource"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="Resource [GridColumn_Resource] Group By Resource ASC" SortExpression="Resource">
                            <ItemTemplate>
                                <a runat="server" id="hypResource"><%#IIf(Eval("Resource") = "", "&nbsp;", Eval("Resource"))%> </a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlResources" runat="server" Width="100%" Filter="Contains" DropDownWidth="405px" ValidationGroup="Save"
                                    MarkFirstMatch="true" CloseDropDownOnBlur="true" EmptyMessage="Select Resource..." meta:resourcekey="ddlResources" AutoPostBack="true"
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos" OnClientItemsRequesting="Requirement_GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvResources" meta:resourcekey="rfvResources" runat="server" ControlToValidate="ddlResources"
                                    CssClass="Validator" InitialValue="" ErrorMessage="<br/>Select resource"
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="csvResources" meta:resourcekey="csvResources" runat="server" ControlToValidate="ddlResources"
                                    ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                    CssClass="Validator" ErrorMessage="<br/>Select resource">
                                </asp:CustomValidator>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle Wrap="false" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="StartDate" HeaderText="Start" DataField="StartDate"
                            DataType="System.DateTime" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC" SortExpression="StartDate">
                            <ItemTemplate>
                                &nbsp;<span><%#FormatDate(Eval("StartDate"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpStartDate" runat="server" MinDate="1901-01-01"
                                    MaxDate="2100-01-01" Width="100%" EnableTyping="true" LabelCssClass="radLabelCss_Office2007" Skin="Default">
                                    <DateInput ID="DateInput3" CssClass="Right" runat="server" />
                                    <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="rfvSartDate" runat="server" ValidationGroup="Save" ControlToValidate="dtpStartDate"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="<br/>required" ForeColor="">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="FinishDate" HeaderText="Finish" DataField="FinishDate"
                            DataType="System.DateTime" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="FinishDate [GridColumn_FinishDate] Group By FinishDate ASC" SortExpression="FinishDate">
                            <ItemTemplate>
                                &nbsp;<span><%#FormatDate(Eval("FinishDate"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="dtpFinishDate" runat="server" MinDate="1901-01-01"
                                    MaxDate="2100-01-01" Width="100%" EnableTyping="true">
                                    <DateInput CssClass="Right" runat="server" />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="rfvFinishDate" runat="server" ValidationGroup="Save" ControlToValidate="dtpFinishDate"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="<br/>required" ForeColor="">
                                </asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="csvDetailDate" runat="server" Display="Dynamic" ValidationGroup="Save"
                                    ErrorMessage="<br/> Start Before End date" ClientValidationFunction="ValidateDetailCombinedDate">
                                </asp:CustomValidator>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="StartTime" HeaderText="Start Time" DataField="StartTime"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            Groupable="false" SortExpression="StartTime">
                            <ItemTemplate>
                                &nbsp;<span><%#CultureFormatTime(Eval("StartTime"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadTimePicker ID="dtpStartTime" runat="server" MinDate="1901-01-01"
                                    MaxDate="2100-01-01" Width="100%" EnableTyping="true">
                                    <DateInput ID="DateInput1" CssClass="Right" runat="server" />
                                </telerik:RadTimePicker>
                                <asp:RequiredFieldValidator ID="rfvStartTime" runat="server" ValidationGroup="Save" ControlToValidate="dtpStartTime"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="<br/>required" ForeColor="">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="FinishTime" HeaderText="Finish Time" DataField="FinishTime" HeaderStyle-Width="300px"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            Groupable="false" SortExpression="FinishTime">
                            <ItemTemplate>
                                &nbsp;<span><%#CultureFormatTime(Eval("FinishTime"))%></span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <EditItemTemplate>
                                <telerik:RadTimePicker ID="dtpFinishTime" runat="server" MinDate="1901-01-01"
                                    MaxDate="2100-01-01" Width="100%" EnableTyping="true">
                                    <DateInput ID="DateInput2" CssClass="Right" runat="server" />
                                </telerik:RadTimePicker>
                                <asp:RequiredFieldValidator ID="rfvFinishTime" runat="server" ValidationGroup="Save" ControlToValidate="dtpFinishTime"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="<br/>required" ForeColor="">
                                </asp:RequiredFieldValidator>
                                <%--<asp:CompareValidator ID="cmpTime" runat="server" Display="Dynamic" ControlToValidate="dtpFinishTime" ErrorMessage="Start time must be before end time" ControlToCompare="dtpStartTime" Operator="GreaterThanEqual">
                    </asp:CompareValidator>--%>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="HoursPerDay" HeaderText="Hours Per Day" DataField="HoursPerDay" DataType="System.Double"
                            CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="HoursPerDay [GridColumn_HoursPerDay] Group By HoursPerDay ASC" SortExpression="HoursPerDay">
                            <ItemTemplate>
                                <%--<asp:Label ID="lblHourPerDay" runat="server" />--%>
                                <span><%#DecimalPrecision(FormatNumber(ParseDouble(Eval("HoursPerDay"))))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadTextBox ID="txtHourPerDay" Type="Number" MinValue="0.01" MaxValue="24" runat="server" Width="100%" CssClass="PositiveIntegerDouble"
                                    Style="text-align: right;" MaxLength="9" ClientEvents-OnBlur="ValidateDetailsHoursPerDay" LabelCssClass="">
                                </telerik:RadTextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="AllDay" HeaderText="All Day" DataField="AllDay"
                            DataType="System.Boolean" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="AllDay [GridColumn_AllDay] Group By AllDay ASC" SortExpression="AllDay">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("AllDay"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkAllDay" runat="server" Checked='<%#CBool(IIf(Eval("AllDay") Is System.DBNull.Value, 0, Eval("AllDay")))%>' />

                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="AssignedHours" HeaderText="Assigned Hours" DataField="AssignedHours" DataType="System.Decimal"
                            FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True" CurrentFilterFunction="EqualTo"
                            GroupByExpression="AssignedHours [GridColumn_AssignedHours] Group By AssignedHours ASC" SortExpression="AssignedHours">
                            <ItemTemplate>
                                <span><%#DecimalPrecision(FormatNumber(ParseDouble(Eval("AssignedHours"))))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtAssignedHours" CssClass="PositiveIntegerDouble Right" />

                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="Classification" HeaderText="Classification" DataField="Classification"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="Classification [GridColumn_Classification] Group By Classification ASC" SortExpression="Classification">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("Classification") = "", "&nbsp;", Container.DataItem("Classification"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlClassifications" runat="server" Width="100%" Filter="Contains" DropDownWidth="405px" meta:resourcekey="ddlClassifications" AutoPostBack="true"
                                    MarkFirstMatch="true" CloseDropDownOnBlur="true" EmptyMessage="Select Classification..." OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Requirement_GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="PctComplete" HeaderText="Effort %" DataField="PctComplete"
                            DataType="System.Decimal" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC" SortExpression="PctComplete">
                            <ItemTemplate>
                                <span><%#FormatPercent(Eval("PctComplete"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPctComplete" runat="server" Width="100%" MaxLength="15"
                                    Text='<%# FormatNumber(ParseDouble(Eval("PctComplete"))) %>' CssClass="Percent" maxnumber="100" minnumber="0">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="TotalHours" HeaderText="Total" DataField="TotalHours"
                            DataType="System.Decimal" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True" CurrentFilterFunction="EqualTo"
                            GroupByExpression="TotalHours [GridColumn_TotalHours] Group By TotalHours ASC" SortExpression="TotalHours">
                            <ItemTemplate>
                                <span><%#FormatCurrency(ParseDouble(Container.DataItem("TotalHours")), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTotalHours" runat="server" Width="100%" MaxLength="15" ReadOnly="true" CssClass="Currency">
                                </asp:TextBox>
                                <asp:HiddenField ID="hdnTotalHours" runat="server" />
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="PayType" HeaderText="Pay Type" DataField="PayType"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="PayType [GridColumn_PayType] Group By PayType ASC" SortExpression="PayType">
                            <ItemTemplate>
                                <%#IIf(Container.DataItem("PayType") = "", "&nbsp;", Container.DataItem("PayType"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPayTypes" runat="server" Width="100%" Filter="Contains" DropDownWidth="405px" meta:resourcekey="ddlPayTypes"
                                    MarkFirstMatch="true" CloseDropDownOnBlur="true" EmptyMessage="Select Pay Type..." AutoPostBack="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                    NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Requirement_GetValueToReturn"
                                    Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="RateBasis" HeaderText="Rate Basis" DataField="RateBasis"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="RateBasis [GridColumn_RateBasis] Group By RateBasis" SortExpression="RateBasis">
                            <ItemTemplate>
                                <span><%#IIf(Eval("RateBasis") = 1, "Fixed Amount", "Hourly Rate")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlRateBasis" OnSelectedIndexChanged="ddlRateBasis_SelectedIndexChanged" AutoPostBack="true" runat="server" Width="100%">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="UseRateFrom" HeaderText="Use Rate From" DataField="UseRateFrom"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="UseRateFrom [GridColumn_UseRateFrom] Group By UseRateFrom" SortExpression="UseRateFrom">
                            <ItemTemplate>
                                <span><%#Eval("UseRateFrom")%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlUseRateFrom" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged" DropDownWidth="405px"
                                    Width="100%">
                                </telerik:RadComboBox>
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
                                <telerik:RadComboBox Width="100%" ID="ddlCurrencies" DropDownWidth="405px" OnSelectedIndexChanged="ddl_SelectedIndexChanged" AutoPostBack="true" runat="server" Skin="Default" Style="font-size: 11px" Height="300px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="CurrencyValue" HeaderText="Rate" DataField="CurrencyValue"
                            DataType="System.Decimal" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="CurrencyValue [GridColumn_CurrencyValue] Group By CurrencyValue ASC" SortExpression="CurrencyValue">
                            <ItemTemplate>
                                <span><%# FormatCurrency(ParseDouble(Container.DataItem("CurrencyValue")), CurrencyId:=Eval("CurrencyId"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCurrencyValue" runat="server" Width="100%" MaxLength="15" CssClass="Currency">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="110px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="CostCode" HeaderText="Cost Code" DataField="CostCode"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC" SortExpression="CostCode">
                            <ItemTemplate>
                                <asp:HyperLink ID="hplCostCode" runat="server" Text='<%#Container.DataItem("CostCode")%>' CssClass="Link">
                                </asp:HyperLink>
                                <%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", "")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" DropDownWidth="405px" ShowMoreResultsBox="true"
                                    CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" EmptyMessage="Select Cost Code..."
                                    EnableItemCaching="False" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" meta:resourcekey="ddlCostCodes"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="PostAs" HeaderText="Worksheet Column" DataField="PostAs" Visible="false"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="PostAs [GridColumn_PostAs] Group By PostAs" SortExpression="PostAs">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PostAs") = String.Empty, "&nbsp;", Container.DataItem("PostAs"))%></span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ddlPostAs" runat="server" Width="100%" DropDownWidth="405px"
                                    Style="font-size: 11px">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn UniqueName="Appointment" HeaderText="Appointment" DataField="Appointment" Visible="false"
                            DataType="System.Boolean" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="Appointment [GridColumn_Appointment] Group By Appointment ASC" SortExpression="Appointment">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIf(Eval("Appointment"), "checked.png", "unchecked.png"))%>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkAppointment" runat="server" Checked='<%#CBool(IIf(Eval("Appointment") Is System.DBNull.Value, 0, Eval("Appointment")))%>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn UniqueName="Id" HeaderText="Assignment #" DataField="Id" Visible="true"
                            CurrentFilterFunction="Contains" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="True"
                            GroupByExpression="Id [GridColumn_Id] Group By Id" SortExpression="Id">
                            <ItemTemplate>
                                <span><%#Container.DataItem("Id")%></span>
                            </ItemTemplate>
                              <EditItemTemplate>
                                  <asp:Label ID="lblAssignmentNumber" runat="server"></asp:Label>
                                  <%-- <asp:TextBox ID="txtAssignmentNumber" runat="server" Width="100%" MaxLength="15" ReadOnly="true" style="text-align:right">
                                </asp:TextBox>--%>
                            </EditItemTemplate>
                            <HeaderStyle Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>

                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited"
                                SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited" ValidationGroup="Save">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert"
                                SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert" ValidationGroup="Save">
                                <span class="Icon"></span>
                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                                SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll">
                                <span class="Icon"></span>
                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAddResource" runat="server" CausesValidation="False" CommandName="WorkOrderAddResources" CssClass="GridCmdWorkOrderAddResources"
                                SecurityButtonType="ItemMode_Add" OnClientClick="return OpenPOPUp('SelectResourcesPopup.aspx?Source=ResourcesRequirements',900,540,true)"
                                Visible='<%# rdgRequirementDetails.EditIndexes.Count = 0 And (Not rdgRequirementDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnAddResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddResource" runat="server" Text="Add Resource(s)" meta:resourcekey="lblAddResource"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                SecurityButtonType="ItemMode_Add">
                                <span class="Icon"></span>
                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                runat="server" CommandName="DeleteRows">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid">
                                <span class="Icon"></span>
                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                                OnClientClick="return OpenPreviewConversion();" Style="float: none !important"
                                SecurityButtonType="ItemMode"
                                Visible='<%# rdgRequirementDetails.EditIndexes.Count = 0 And (Not rdgRequirementDetails.MasterTableView.IsItemInserted)%>'
                                meta:resourcekey="btnRefreshResource1">
                                <span class="Icon"></span>
                                <asp:Label ID="Label11" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
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
                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                    AllowDragToGroup="true" Selecting-AllowRowSelect="true">
                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
