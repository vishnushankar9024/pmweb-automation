<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="APPaymentSchedule.aspx.vb" Inherits="Website.APPaymentSchedule" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
  

        .RadGrid_PM .rgRow td div, .RadGrid_PM .rgAltRow td div, .RadGrid_PM .rgRow td span, .RadGrid_PM .rgAltRow td span {
            white-space: normal !important;
            text-align: left;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">

            var TotalAmount = 0
            var UnappliedAmount = 0
            var AppliedAmount = 0
            var OpenBalanceHidden = false;
            var arrPayments = [];

            function AdjustCalculation() {




                $('input[id$=txtPercentage]').change(function (sender) {

                    var me = $(this);
                    var row = me.parents("tr:first");

                    var dblOpenBalance = CDbl($("input[id$=txtOriginalValue]").val());
                    var txtPercentage = row.find("input[id$=txtPercentage]");
                    var dblPct = CDbl(row.find("input[id$=txtPercentage]").val());
                    if (dblPct > 100) { dblPct = 100; txtPercentage.val(CPrct(100)); }
                    if (dblPct < 0) { dblPct = 0; txtPercentage.val(CPrct(0)); }
                    var txtApplied = row.find("input[id$=txtApplied]");
                    var NeededAmount = CDbl(dblOpenBalance * (dblPct / 100));
                    txtApplied.val(CCur(NeededAmount));

                });


                $('input[id$=txtApplied]').change(function (sender) {

                    var me = $(this);
                    var row = me.parents("tr:first");
                    //var OpenBalance = $("input[id=txtOpenBalance]").val();
                    var dblOpenBalance = CDbl($("input[id$=txtOriginalValue]").val());
                    var txtPercentage = row.find("input[id$=txtPercentage]");
                    var dblPct = CDbl(row.find("input[id$=txtPercentage]").val());
                    var txtApplied = row.find("input[id$=txtApplied]");
                    var dblApplied = CDbl(row.find("input[id$=txtApplied]").val());
                    //                 if (dblApplied > dblOpenBalance) { dblApplied = dblOpenBalance; txtApplied.val(CDbl(dblApplied)); }
                    if (dblApplied < 0) { dblApplied = 0; txtApplied.val(CDbl(0)); }


                    //                 var spnRecordId = row.find("span[id$=spnId]").text(); ;
                    //                 var currId = spnRecordId;
                    //                 for (var i = 0; i < arrPayments.length; i++) {
                    //                     var objPayment = arrPayments[i];
                    //                     if (objPayment.ID == currId) {
                    //                         arrPayments.splice(i, 1);
                    //                     }
                    //                 }
                    var NeededAmount = dblApplied;
                    dblPct = CDbl((NeededAmount * 100) / dblOpenBalance);

                    txtApplied.val(CCur(NeededAmount));
                    if (dblPct > 100 || dblPct < 0)
                        txtPercentage.val(CPrct(0));
                    else
                        txtPercentage.val(CPrct(dblPct));

                });

            }

            function SaveClicked() {
                var btn = window.parent.$("[id$=btnLoadPaymentTab]")[0];
                btn.click();
                window.close();
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage" id="trTbsDetails">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblProject" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" Enabled="false" ID="txtProject" Text="" Width="100%"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblCompany" meta:resourcekey="lblCompany" Text="Company"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" Enabled="false" ID="txtCompany" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblCommitment" meta:resourcekey="lblCommitment" Text="Commitmemt"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" Enabled="false" ID="txtCommitment" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblType" meta:resourcekey="lblType" Text="Type"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" Enabled="false" ID="txtType" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblOriginalValue" meta:resourcekey="lblOriginalValue" Text="Original Value"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" Enabled="false" ID="txtOriginalValue" CssClass="Currency" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblOriginalDays" meta:resourcekey="lblOriginalDays" Text="Original Days"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" Enabled="false" ID="txtOriginalDays" CssClass="Double" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%; color: #666666 !important;">
                                <br />
                                <asp:Label runat="server" ID="lblroundingMsg" meta:resourcekey="lblroundingMsg" Text="Rounding will be added to the last line in the spreadsheet"></asp:Label>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <fieldset>
                        <legend>
                            <asp:Label runat="server" ID="lblCreate" meta:resourcekey="lblCreate" Text="Create"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" ID="lblNbrOfTransaction" meta:resourcekey="lblNbrOfTransaction" Text="# of Transactions"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadNumericTextBox ID="txtnbrOftransactions" CssClass="Right" Value="1"
                                        MinValue="1" Type="Number" ShowSpinButtons="true" Width="70px" runat="server">
                                        <NumberFormat DecimalDigits="0" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" ID="lblUseDates" meta:resourcekey="lblUseDates" Text="Use Dates"></asp:Label>

                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox AutoPostBack="true" runat="server" ID="chkUseDates" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button runat="server" ID="btnCreate" meta:resourcekey="btnCreate" Text="Create" />
                                </td>
                            </tr>
                        </table>


                    </fieldset>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset runat="server" id="fldDates">
                        <legend>
                            <asp:Label runat="server" ID="lblDates" meta:resourcekey="lblDates" Text="Dates"></asp:Label>
                        </legend>
                        <table class="colTable" cellpadding="5">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStartDate" runat="server" meta:resourcekey="lblStartDate" Text="Start Date*">  </asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadDatePicker ID="dtpMonthlyStartDate" Width="100%" runat="server" Skin="Default">
                                    </telerik:RadDatePicker>
                                    <asp:Label runat="server" ID="lblStartDateRequire" CssClass="Validator" meta:resourcekey="lblStartDateRequire" Text="Required" Visible="false"></asp:Label>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:RadioButton ID="rdoMonthlyOnDay" Checked="true" CssClass="RadioCss" runat="server" Text="Day" meta:resourcekey="rdoMonthlyOnDay" GroupName="Monthly" />
                                </td>
                                <td class="controlWidth">
                                    <table width="100%">
                                        <tr>
                                            <td width="50%">
                                                <telerik:RadNumericTextBox ID="txtDaysOfMonth" CssClass="Right" Value="1" MinValue="1"
                                                    Type="Number" ShowSpinButtons="true" MaxValue="31" Width="90px" runat="server">
                                                    <NumberFormat AllowRounding="False" DecimalDigits="0" NegativePattern="n" PositivePattern="n" />
                                                </telerik:RadNumericTextBox>

                                            </td>
                                            <td width="50%">
                                                <asp:Label ID="lbloftheMonth" runat="server" meta:resourcekey="lbloftheMonth" Text="of the month">  </asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:RadioButton ID="rdoMonthlyOnThe" meta:resourcekey="rdoMonthlyOnThe" runat="server" CssClass="RadioCss" Text="The" GroupName="Monthly" />
                                </td>
                                <td class="controlWidth">
                                    <table>
                                        <tr>
                                            <td width="50%">
                                                <telerik:RadComboBox ID="ddlWeekDayPart" Width="73px" Skin="Default" runat="server">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="50%">
                                                <telerik:RadComboBox ID="ddlWeekDay" Width="73px" Skin="Default" runat="server">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEvery" runat="server" meta:resourcekey="lblEvery" Text="Every">  </asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%">
                                        <tr>
                                            <td width="50%">
                                                <telerik:RadNumericTextBox ID="txtEveryMonth" CssClass="Right" Value="1" MinValue="1"
                                                    Type="Number" ShowSpinButtons="true" Width="90px" runat="server">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                            <td width="50%">
                                                <asp:Label ID="lblMonth" runat="server" meta:resourcekey="lblMonth" Text="Month(s)">  </asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblUseperiods" runat="server" meta:resourcekey="lblUseperiods" Text="Use periods">  </asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox runat="server" ID="chkUsePeriods" class="mobile-switch" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgPayments" runat="server" AllowFilteringByColumn="false" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" ShowFooter="False"
                        AllowPaging="False" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True" SetWidth="true" AppendMenus="true"
                        AllowSorting="True" GridLines="None" Width="823px">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="true" FooterStyle-HorizontalAlign="Right"
                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true"
                            TableLayout="Fixed" Width="823px">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber"
                                    Groupable="false" Reorderable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="PaymentDate" ItemStyle-Wrap="false" HeaderText="Date"
                                    Groupable="false" Reorderable="true"
                                    SortExpression="PaymentDate">
                                    <ItemTemplate>
                                        <telerik:RadDatePicker ID="rdpPaymentDate" runat="server" MinDate="1901-01-01"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" UniqueName="Period" ItemStyle-Wrap="false" HeaderText="Period"
                                    Groupable="false" Reorderable="true"
                                    SortExpression="Period" GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                                    <ItemTemplate>

                                        <telerik:RadComboBox ID="ddlPeriods" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="False" Skin="Default" DropDownWidth="255px" NoWrap="true" Width="100%"
                                            Height="200px" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                        </div>
                                    </ItemTemplate>

                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="ID" SortExpression="RecordNumber" Groupable="false"
                                    GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber"
                                    UniqueName="RecordNumber">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRecordNumber" MaxLength="50" runat="server" Text='<%# Eval("RecordNumber") %>'
                                            Width="100%"></asp:TextBox>
                                        <div>
                                            <asp:RequiredFieldValidator ID="rfvRecordNumber" runat="server" ControlToValidate="txtRecordNumber"
                                                CssClass="Validator" InitialValue="" ErrorMessage="Required." meta:resourcekey="rfvRecordNumber"
                                                Display="Dynamic" ForeColor="" ValidationGroup="SaveAndExit"></asp:RequiredFieldValidator>
                                            <asp:Label runat="server" Text="Record # must be unique." meta:resourcekey="lblCodeUnique" ID="lblCodeUnique" Visible="false" CssClass="Validator"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle Width="171px"></HeaderStyle>
                                    <ItemStyle Wrap="False"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Transaction Type" SortExpression="TransactionType"
                                    GroupByExpression="TransactionType [GridColumn_TransactionType] Group By TransactionType ASC"
                                    UniqueName="TransactionType" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("TransactionType") = String.Empty, "&nbsp;", Container.DataItem("TransactionType"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description"
                                    UniqueName="Description" Groupable="false">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'
                                            Width="100%"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle Wrap="False"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="%" HeaderStyle-Width="60px" ItemStyle-Wrap="false" UniqueName="Percent" Groupable="false" SortExpression="Percent">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPercentage" runat="server" CssClass="Percent" Width="100%" Text='<%#FormatPercent(Eval("Percent")) %>'></asp:TextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Amount" HeaderStyle-Width="90px" ItemStyle-Wrap="false" UniqueName="Amount" Groupable="false" SortExpression="Amount">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtApplied" Width="99%" CssClass="Currency" Text='<%#FormatCurrency(Eval("Amount"), CurrencyId:=Eval("CurrencyId"))%>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        SecurityButtonType="ItemMode_Add">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                        SecurityButtonType="ItemMode_Delete"
                                        runat="server" CommandName="DeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder"
                            AllowDragToGroup="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
