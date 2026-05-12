<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CostManagementFundingRequestDetails.ascx.vb" Inherits="Website.CostManagementFundingRequestDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">

        function GetValueToReturn(combobox, eventArgs) {
            if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
                eventArgs.set_cancel(true);
            } else {
                eventArgs.set_cancel(false);
            }
            var SelectedValue;
            var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
            SelectedValue = ddlProjects.get_value();

            var context = eventArgs.get_context();
            context["FilterString"] = SelectedValue;
        }
        function ResetCombos(combobox, eventArgs) {


            var ddlPeriods = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPeriods');
            ddlPeriods.clearItems();
            ddlPeriods.set_text("");
            ddlPeriods.set_value("0");


            var ddlTasks = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlTasks');
            ddlTasks.clearItems();
            ddlTasks.set_text("");
            ddlTasks.set_value("0");

            var item = eventArgs.get_item();
            var itemId = item.get_parent()._clientStateFieldID;
            var tr = $("#" + itemId).parents(".rgEditForm:first");
            if (!tr || tr.length == 0)
                tr = $("#" + itemId).parents("tr:first")
            var txtProgram = tr.find("input[id$='txtProgram']");

            txtProgram.val(item.get_attributes().getAttribute("ProgramName"));


        }
    </script>
</telerik:RadCodeBlock>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadGrid ID="rdgFundingDetails" AllowMultiRowSelection="true" runat="server" CssClass="WithoutTopBorder" 
    AllowFilteringByColumn="true" FilterType ="HeaderContext" EnableHeaderContextMenu ="true" EnableHeaderContextFilterMenu="true"
    HeaderStyle-Font-Size="8" ShowGroupPanel="true" AutoGenerateColumns="False" AllowSorting="true" AllowMultiRowEdit="true" 
    ShowStatusBar="true" AllowPaging="true" PageSize="25" UseEditFormInMobile="true">
    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter="true" GroupLoadMode="Client">
        <Columns>
            <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right" DataField="LineNumber" allowfiltering="false"
                UniqueName="LineNumber" HeaderStyle-Wrap="false" Groupable="false" Reorderable="true">
                <ItemTemplate>
                    <%#Container.DataItem("LineNumber").ToString%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label runat="server" ID="lblLineNumber" Text='<%#Eval("LineNumber").ToString%>'></asp:Label>
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
                   <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Year" SortExpression="Year"
                UniqueName="Year" GroupByExpression="Year [GridColumn_Year] Group By Year" DataField="Year">
                <ItemTemplate>
                    <span>
                        <%#IIf(Eval("Year") Is System.DBNull.Value, "&nbsp;", Container.DataItem("Year"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadNumericTextBox ID="rntYear" ShowSpinButtons="true"
                        IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                        Label="" runat="server" Width="70px" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>"
                        MaxValue="2100" MinValue="1899">
                        <NumberFormat DecimalDigits="0" GroupSeparator="" />
                    </telerik:RadNumericTextBox>

                </EditItemTemplate>
                <HeaderStyle Width="60px"></HeaderStyle>
                   <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Project" SortExpression="ProjectFullName" DataField="ProjectFullName"
                UniqueName="ProjectFullName" GroupByExpression="ProjectFullName [GridColumn_ProjectFullName] Group By ProjectFullName ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("ProjectId") = -1, PM.LanguagesInfo.GlobalResource("Program"), IIf(Container.DataItem("ProjectId") = 0, PM.LanguagesInfo.GlobalResource("Portfolio"), Container.DataItem("ProjectFullName")))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlProjects" Width="100%" DropDownWidth="300px" runat="server" Filter="Contains" Height="300px" MarkFirstMatch="true" Skin="Default"
                        CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true"
                        EnableLoadOnDemand="True" OnClientSelectedIndexChanged="ResetCombos" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="150"></HeaderStyle>
                <ItemStyle Wrap="false" />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Program" SortExpression="Program" DataField="Program"
                UniqueName="Program" GroupByExpression="Program [GridColumn_Program] Group By Program ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Program") = String.Empty, "&nbsp;", Container.DataItem("Program"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtProgram" runat="server" Text='<%# Eval("Program") %>' Width="100%" ReadOnly="true"></asp:TextBox>

                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
                <ItemStyle Wrap="false" />
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
            <telerik:GridTemplateColumn HeaderText="Source" DataField="FundingSourceText" SortExpression="FundingSourceText" 
                UniqueName="FundingSource" GroupByExpression="FundingSourceText [GridColumn_FundingSource] Group By FundingSourceText ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("FundingSourceId") = -1, "&nbsp;", IIf(Container.DataItem("FundingSourceId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("FundingSourceText")))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlFundingSources" Width="100%" runat="server" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>

                </EditItemTemplate>
                <HeaderStyle Width="100px"></HeaderStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Code" SortExpression="Code" DataField="Code"
                UniqueName="Code" GroupByExpression="Code [GridColumn_Code] Group By Code ASC">
                <ItemTemplate>
                    <%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtCode" runat="server" Text='<%# Eval("Code") %>' Width="100%"
                        MaxLength="50"></asp:TextBox>

                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
                <ItemStyle />
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Funded" HeaderStyle-Width="150px"
                SortExpression="OriginalFunding" Groupable="false"
                UniqueName="OriginalFunding" DataField="OriginalFunding">
                <ItemTemplate>
                    <%#FormatCurrency(Eval("OriginalFunding"), CurrencyId:=CInt(Eval("CurrencyId")))%>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtOriginalFunding" MaxLength="15" runat="server"
                        Text='<%# FormatCurrency(Eval("OriginalFunding"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' CssClass="Currency"
                        Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="120px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Right"></ItemStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Period" SortExpression="Period" UniqueName="Period" DataField="Period"
                GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("PeriodId") = -1, "&nbsp;", IIf(Container.DataItem("PeriodId") = 0, PM.LanguagesInfo.SPLIT, Container.DataItem("Period")))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlPeriods" Width="100%" DropDownWidth="200px" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                        CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetValueToReturn"
                        OnItemsRequested="ddl_ItemsRequested">
                    </telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="WBS" SortExpression="WBS" UniqueName="WBS" DataField="WBS"
                GroupByExpression="WBS [GridColumn_WBS] Group By WBS ASC">
                <ItemTemplate>
                    <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <div style="width: 100%; white-space: nowrap">
                        <telerik:RadComboBox ID="ddlWBS" runat="server" Width="110px" DropDownWidth="405px" AutoPostBack="false"
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

            <telerik:GridTemplateColumn HeaderText="Task"  UniqueName="Task" DataField="TaskName" GroupByExpression="TaskName [GridColumn_Task] Group By TaskName ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("TaskId") = -1, "&nbsp;", Container.DataItem("TaskName"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                    <telerik:RadComboBox ID="ddlTasks" runat="server" Width="100%" DropDownWidth="465px" Filter="Contains"
                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                        NoWrap="True" AllowCustomText="true"
                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                        OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ddlTasks_SelectedIndexChanged"
                        Style="font-size: 11px" Height="250px" OnClientItemsRequesting="GetValueToReturn">
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

            <telerik:GridTemplateColumn HeaderText="Start" SortExpression="StartDate" UniqueName="StartDate" DataField="StartDate"
                GroupByExpression="StartDate [GridColumn_StartDate] Group By StartDate ASC">
                <ItemTemplate>
                    <asp:Label ID="lblStartDate" Text="&nbsp;" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtStartDate"
                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                        runat="server" Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Finish" SortExpression="FinishDate" UniqueName="FinishDate" DataField="FinishDate"
                GroupByExpression="FinishDate [GridColumn_FinishDate] Group By FinishDate ASC">
                <ItemTemplate>
                    <asp:Label ID="lblFinishDate" Text="&nbsp;" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFinishDate"
                        onclick="showDatePopup(this, event);" onfocus="showDatePopup(this, event);" onblur="parseDate(this, event);"
                        runat="server" Width="100%"></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Width="70px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Curve" DataField="CurveType" SortExpression="CurveType" UniqueName="Curve"
                GroupByExpression="CurveType [GridColumn_Curve] Group By CurveType ASC">
                <ItemTemplate>
                    <span><%#IIf(Container.DataItem("CurveId") = 0, "&nbsp;", Container.DataItem("CurveType"))%></span>
                </ItemTemplate>
                <EditItemTemplate>
                     <telerik:RadComboBox ID="ddlCurves" runat="server" Width="100%" Filter="Contains" AllowCustomText="true" Height="200px"></telerik:RadComboBox>
                </EditItemTemplate>
                <HeaderStyle Width="90px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" DataField="Notes"
                UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                <ItemTemplate>
                    <div><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="75%" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>

                    <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton"
                        OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))">
                <span class="Icon"></span>
                    </asp:LinkButton>
                </EditItemTemplate>
                <HeaderStyle Width="130px"></HeaderStyle>
            </telerik:GridTemplateColumn>

            <telerik:GridTemplateColumn HeaderText="Closed" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                SortExpression="Closed" Groupable="false" UniqueName="Closed" DataField="Closed">
                <ItemTemplate>
                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Closed")) = CBool(1), "checked.png", "unchecked.png"))%>"
                        alt="" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkClosed" Checked='<%# CBool(IIf(Eval("Closed") Is System.DBNull.Value, 0, Eval("Closed")))%>' CssClass="mobile-switch"
                        runat="server" />
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center "></ItemStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field1" DataField="Field1" allowfiltering="false" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field2" DataField="Field2" allowfiltering="false" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field3" DataField="Field3" allowfiltering="false" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field4" DataField="Field4" allowfiltering="false" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field5" DataField="Field5" allowfiltering="false" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field6" DataField="Field6" allowfiltering="false" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field7" DataField="Field7" allowfiltering="false" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field8" DataField="Field8" allowfiltering="false" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field9" DataField="Field9" allowfiltering="false" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Field10" DataField="Field10" allowfiltering="false" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                Groupable="false">
                <ItemTemplate>
                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                </ItemTemplate>
                <EditItemTemplate>
                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                </EditItemTemplate>
                <HeaderStyle Width="115px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="Funded Converted" Visible="false" UniqueName="OriginalFundingConverted" ItemStyle-HorizontalAlign="Right"
                SortExpression="OriginalFundingConverted" DataField="OriginalFundingConverted" Aggregate="Sum" FooterAggregateFormatString="{0:F6}" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                <ItemTemplate>
                    <asp:Label Text='<%#FormatCurrency(Eval("OriginalFundingConverted"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server" ID="lblOriginalFundingConverted" />
                </ItemTemplate>
                <EditItemTemplate>
                    &nbsp;
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Right" ></ItemStyle>
                <HeaderStyle Width="100px"></HeaderStyle>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn Aggregate="SUM" DataField="OriginalFunding" Visible="False" />

        </Columns>
        <ItemStyle Wrap="false" />
        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
        <FooterStyle CssClass="GridFooter" />
        <SortExpressions>
            <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
        </SortExpressions>
        <CommandItemTemplate>
            <div style="padding: 2px">

                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgFundingDetails.EditIndexes.Count = 0 And (Not rdgFundingDetails.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgFundingDetails.EditIndexes.Count > 0 %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgFundingDetails.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblSave" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                    SecurityButtonType="AddEditMode" Visible='<%# rdgFundingDetails.EditIndexes.Count > 0 Or rdgFundingDetails.MasterTableView.IsItemInserted %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>

                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgFundingDetails.EditIndexes.Count = 0 And (Not rdgFundingDetails.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgFundingDetails.EditIndexes.Count = 0 And (Not rdgFundingDetails.MasterTableView.IsItemInserted) %>'
                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                    <span class="Icon"></span>
                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                    SecurityButtonType="ItemMode" Visible='<%# rdgFundingDetails.EditIndexes.Count = 0 And (Not rdgFundingDetails.MasterTableView.IsItemInserted) %>'>
                    <span class="Icon"></span>
                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="lnkPreviewConversion" runat="server" CausesValidation="False" CommandName="PreviewConversion" CssClass="GridCmdPreviewConversion"
                    OnClientClick="return OpenPreviewConversion();" Style="float: none !important" 
                    SecurityButtonType="ItemMode"
                    Visible='<%# rdgFundingDetails.EditIndexes.Count = 0 And (Not rdgFundingDetails.MasterTableView.IsItemInserted)%>'
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
    <ExportSettings IgnorePaging="true" OpenInNewWindow="true">
        <Excel Format="Html" FileExtension="xls" />
    </ExportSettings>
    <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" AllowDragToGroup="True" AllowRowsDragDrop="False">
        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
            AllowColumnResize="True" />
    </ClientSettings>
    <ValidationSettings EnableValidation="true" ValidationGroup="Save" CommandsToValidate="PerformInsert,UpdateEdited" />
</telerik:RadGrid>
        </div>
    </div>
</div>

