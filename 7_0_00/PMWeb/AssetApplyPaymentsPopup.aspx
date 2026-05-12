<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="AssetApplyPaymentsPopup.aspx.vb" Inherits="Website.AssetApplyPaymentsPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
          <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
        <script type="text/javascript">

            var TotalAmount = 0
            var UnappliedAmount = 0
            var AppliedAmount = 0
            var OpenBalanceHidden = false;
            var arrPayments = [];
            function pageLoad() {
                arrPayments = [];
                $("input[id$='txtApplied']").each(function () {


                    var me = $(this);
                    var row = me.parents("tr:first");
                    var Apply = CDbl($(this).val());
                    var spnRecordId = row.find("span[id$=spnId]").text();
                    var currId = spnRecordId;
                    if (Apply > 0) {
                        arrPayments.push({ 'ID': currId, 'AMOUNT': Apply });
                    }
                });

            }
            function AdjustBidderCalculation() {
                TotalAmount = CDbl($("input[id$=txtOpenBalance]").val());
                OpenBalanceHidden = $("input[id$=txtOpenBalance]").is(':hidden');



                $('input[id$=txtPercentage]').change(function (sender) {
                    var me = $(this);
                    var row = me.parents("tr:first");

                    var dblOpenBalance = CDbl(row.find("span[id$=spnUnappliedBalance]").text());
                    var txtPercentage = row.find("input[id$=txtPercentage]");
                    var dblPct = CDbl(row.find("input[id$=txtPercentage]").val());
                    var chkSelect = row.find("input[id$=chkSelect]")[0];
                    if (dblPct > 100) { dblPct = 100; txtPercentage.val(CPrct(100)); }
                    if (dblPct < 0) { dblPct = 0; txtPercentage.val(CPrct(0)); }
                    var txtApplied = row.find("input[id$=txtApplied]");
                    var spnRecordId = row.find("span[id$=spnId]").text();
                    var currId = spnRecordId;
                    for (var i = 0; i < arrPayments.length; i++) {
                        var objPayment = arrPayments[i];
                        if (objPayment.ID == currId) {
                            arrPayments.splice(i, 1);
                        }
                    }

                    var NeededAmount = CDbl(dblOpenBalance * (dblPct / 100));
                    if (OpenBalanceHidden == false) {
                        AppliedAmount = GetAppliedAmount();
                        AppliedAmount = AppliedAmount + NeededAmount;
                        if (AppliedAmount <= TotalAmount) {
                            txtApplied.val(CCur(NeededAmount));
                            if (dblPct == 100)
                                chkSelect.checked = true;
                            else
                                chkSelect.checked = false;

                            arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });
                        } else {
                            txtApplied.val(CCur(0));
                            txtPercentage.val(CPrct(0));
                        }

                        AppliedAmount = GetAppliedAmount();
                        // UnappliedAmount = TotalAmount - AppliedAmount;
                        $("input[id=txtAppliedAmount]").val(CCur(AppliedAmount));

                    }
                    else {
                        txtApplied.val(CCur(NeededAmount));
                        if (dblPct == 100)
                            chkSelect.checked = true;
                        else
                            chkSelect.checked = false;
                        arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });
                        AppliedAmount = GetAppliedAmount();
                        // UnappliedAmount = TotalAmount - AppliedAmount;
                        $("input[id=txtCPPAppliedAmount]").val(CCur(AppliedAmount));
                    }

                });


                $('input[id$=txtApplied]').change(function (sender) {

                    var me = $(this);
                    var row = me.parents("tr:first");
                    //var OpenBalance = $("input[id=txtOpenBalance]").val();
                    var dblOpenBalance = CDbl(row.find("span[id$=spnUnappliedBalance]").text());
                    var txtPercentage = row.find("input[id$=txtPercentage]");
                    var dblPct = CDbl(row.find("input[id$=txtPercentage]").val());
                    var txtApplied = row.find("input[id$=txtApplied]");
                    var dblApplied = CDbl(row.find("input[id$=txtApplied]").val());
                    var chkSelect = row.find("input[id$=chkSelect]")[0];
                    if (dblApplied > dblOpenBalance) { dblApplied = dblOpenBalance; txtApplied.val(CDbl(dblApplied)); }
                    if (dblApplied < 0) { dblApplied = 0; txtApplied.val(CDbl(0)); }


                    var spnRecordId = row.find("span[id$=spnId]").text();;
                    var currId = spnRecordId;
                    for (var i = 0; i < arrPayments.length; i++) {
                        var objPayment = arrPayments[i];
                        if (objPayment.ID == currId) {
                            arrPayments.splice(i, 1);
                        }
                    }
                    var NeededAmount = dblApplied;
                    dblPct = CDbl((NeededAmount * 100) / dblOpenBalance);
                    if (OpenBalanceHidden == false) {
                        AppliedAmount = GetAppliedAmount();
                        AppliedAmount = AppliedAmount + NeededAmount;
                        if (AppliedAmount <= TotalAmount) {
                            txtApplied.val(CCur(NeededAmount));
                            txtPercentage.val(CPrct(dblPct));
                            if (dblPct == 100)
                                chkSelect.checked = true;
                            else
                                chkSelect.checked = false;
                            arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });
                        } else {
                            txtApplied.val(CCur(0));
                            txtPercentage.val(CPrct(0));

                        }

                        AppliedAmount = GetAppliedAmount();
                        // UnappliedAmount = TotalAmount - AppliedAmount;
                        $("input[id=txtAppliedAmount]").val(CCur(AppliedAmount));
                    }
                    else {
                        txtApplied.val(CCur(NeededAmount));
                        txtPercentage.val(CPrct(dblPct));
                        if (dblPct == 100)
                            chkSelect.checked = true;
                        else
                            chkSelect.checked = false;
                        arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });

                        AppliedAmount = GetAppliedAmount();
                        // UnappliedAmount = TotalAmount - AppliedAmount;
                        $("input[id=txtCPPAppliedAmount]").val(CCur(AppliedAmount));

                    }


                });


            }




            function GetAppliedAmount() {
                var dblApplied = 0;
                for (var i = 0; i < arrPayments.length; i++) {
                    var objPayment = arrPayments[i];
                    dblApplied += objPayment.AMOUNT;
                }  
                return dblApplied;
            }

        </script>  
          <style>
        .colTable .labelWidth{
            width: 160px !important;
        }
    </style>
    </telerik:RadCodeBlock>

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgApplyAPPayments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgApplyAPPayments" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="txtAppliedAmount" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLocation" runat="server" Text="Location" meta:Resourcekey="lblLocation"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLocation" runat="server" Enabled="false" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLease" runat="server" Text="Lease" meta:Resourcekey="lblLease"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLease" Enabled="false" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" Text="Company" meta:Resourcekey="lblCompany"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" Enabled="false" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrentPaymentDue" runat="server" Text="Current Payment Due" meta:Resourcekey="lblCurrentPaymentDue"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrentPaymentDue" Enabled="false" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblLessPriorPayments" runat="server" Text="Less Prior Payments" meta:Resourcekey="lblLessPriorPayments"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLessPriorPayments" Enabled="false" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblOpenBalance" runat="server" Text="Open Balance" meta:Resourcekey="lblOpenBalance"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtOpenBalance" Enabled="false" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblAppliedAmount" runat="server" Text="Applied Amount" meta:Resourcekey="lblAppliedAmount"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtAppliedAmount" Enabled="false" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgApplyAPPayments" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" Width="100%" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        ShowGroupPanel="true" AllowMultiRowEdit="false" AllowFilteringByColumn="true" AllowMultiRowSelection="True" AllowSorting="true" ItemStyle-Height="20px" GridLines="None" AllowPaging="false" SetWidth="true" FitPageHeightOffset="24" AppendMenus="true" allow-scroll="true">
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                            TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true" Width="100%">

                            <Columns>

                                <telerik:GridTemplateColumn HeaderText="Program" HeaderStyle-Width="100px" ItemStyle-Wrap="false" UniqueName="ProgramName"
                                    DataField="ProgramName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="ProgramName" GroupByExpression="ProgramName [GridColumn_ProgramName] Group By ProgramName ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("ProgramName").ToString = String.Empty, "&nbsp;", Container.DataItem("ProgramName").ToString)%></span>
                                        <span id="spnId" style="display: none;"><%#Container.DataItem("Id").ToString%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderStyle-Width="100px" HeaderText="Location"
                                    DataField="LocationName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    UniqueName="LocationName" SortExpression="LocationName" GroupByExpression="LocationName [GridColumn_LocationName] Group By LocationName ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("LocationName").ToString = String.Empty, "&nbsp;", Container.DataItem("LocationName").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderStyle-Width="100px" HeaderText="Company" UniqueName="Company"
                                    DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Payment Method" HeaderStyle-Width="100px" ItemStyle-Wrap="false" UniqueName="PaymentMethod"
                                    DataField="PaymentMethod" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="PaymentMethod" GroupByExpression="PaymentMethod [GridColumn_PaymentMethod] Group By PaymentMethod ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("PaymentMethod").ToString = String.Empty, "&nbsp;", Container.DataItem("PaymentMethod").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Payment #" HeaderStyle-Width="70px" ItemStyle-Wrap="false" UniqueName="PaymentNumber"
                                    DataField="PaymentNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="PaymentNumber" GroupByExpression="PaymentNumber [GridColumn_PaymentNumber] Group By PaymentNumber ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("PaymentNumber") = String.Empty, "&nbsp;", Container.DataItem("PaymentNumber"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Payment Date" HeaderStyle-Width="80px" ItemStyle-Wrap="false" UniqueName="PaymentDate"
                                    DataField="PaymentDate" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="PaymentDate" GroupByExpression="PaymentDate [GridColumn_PaymentDate] Group By PaymentDate ASC">
                                    <ItemTemplate>
                                        <span><%# If(Container.DataItem("PaymentDate") Is DBNull.Value, "&nbsp;", FormatDate(Container.DataItem("PaymentDate")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="100px" ItemStyle-Wrap="false" UniqueName="Description"
                                    DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Unapplied Balance" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px"
                                    DataField="UnappliedBalance" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    ItemStyle-Wrap="false" UniqueName="UnappliedBalance" SortExpression="UnappliedBalance" GroupByExpression="UnappliedBalance [GridColumn_UnappliedBalance] Group By UnappliedBalance ASC">
                                    <ItemTemplate>
                                        <span id="spnUnappliedBalance"><%# IIf(Container.DataItem("UnappliedBalance") = 0, 0, FormatCurrency(Container.DataItem("UnappliedBalance")))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="%" HeaderStyle-Width="60px" ItemStyle-Wrap="false"
                                    DataField="Percent" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    UniqueName="Percent" Groupable="false" SortExpression="">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPercentage" runat="server" CssClass="Percent" Width="100%" Text='<%#FormatPercent(Eval("Percent")) %>'></asp:TextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Applied Amount" HeaderStyle-Width="90px" ItemStyle-Wrap="false"
                                    DataField="AppliedAmount" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    UniqueName="AppliedAmount" Groupable="false" SortExpression="">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtApplied" Width="99%" CssClass="Currency" Text='<%#FormatCurrency(Eval("AppliedAmount")) %>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Applied In Full" HeaderStyle-Width="90px"
                                    DataField="AppliedInFull" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    UniqueName="AppliedInFull" ItemStyle-HorizontalAlign="Left" SortExpression="AppliedInFull" GroupByExpression="AppliedInFull [GridColumn_AppliedInFull] Group By AppliedInFull ASC">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" Checked='<%# CBool(IIf(Eval("AppliedInFull") Is System.DBNull.Value, 0, Eval("AppliedInFull")))%>' runat="server" class="mobile-switch" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                            </Columns>


                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAutoApply" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CommandName="AutoApply" CssClass="GridCmdAutoApply">
                                        <span class="Icon"></span>
                                        <asp:Label ID="Label3" runat="server" Text="AutoApply11"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        |&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton>

                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>

                        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
