<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="PayAPInvoicesPopup.aspx.vb" Inherits="Website.PayAPInvoicesPopup" Title="Pay Invoices" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style>
        .ellipsis {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script type="text/javascript">

        var TotalAmount = 0
        var UnappliedAmount = 0
        var AppliedAmount = 0
        var blnCheckPaidInFull = false;

        var msg_InsufficientFund = 'Insufficient fund11!'
        var arrPayments = [];
        //         var blnCheckPaid = false;


        function firstLoad() {
            TotalAmount = CDbl($("input[id$=txtPaymentMemoTotal]").val());
            UnappliedAmount = TotalAmount;
            AppliedAmount = 0;

            $("input[id=txtApplied]").val(CCur(AppliedAmount));
            $("input[id=txtUnapplied]").val(CCur(UnappliedAmount));

            //             $("input[id=chkPaidInFull]").click(function (sender) {
            //                 blnCheckPaid = $("input[id=chkPaidInFull]")[0].checked;
            //             });

            $('input[id$=txtPaymentMemoTotal]').change(function (sender) {
                TotalAmount = CDbl($("input[id$=txtPaymentMemoTotal]").val());
                UnappliedAmount = TotalAmount;
                AppliedAmount = 0;

                $("input[id=txtApplied]").val(CCur(AppliedAmount));
                $("input[id=txtUnapplied]").val(CCur(UnappliedAmount));
                arrPayments = [];
                $("input[id$='txtPercentage']").each(function () {
                    var me = $(this);
                    var row = me.parents("tr:first");
                    var txtPercentage = row.find("input[id$=txtPercentage]");
                    var chkPaidInFull = row.find("input[id$=chkPaidInFull]")[0];
                    var txtApplied = row.find("input[id$=txtApplied]");
                    txtPercentage.val(CPrct(0));
                    chkPaidInFull.checked = false;
                    txtApplied.val(CCur(0));
                });


            });

            $('input[id$=txtPercentage]').change(function (sender) {
                var me = $(this);
                var row = me.parents("tr:first");

                var dblOpenBalance = CDbl(row.find("span[id$=spnOpenBalance]").text());
                var txtPercentage = row.find("input[id$=txtPercentage]");
                var chkPaidInFull = row.find("input[id$=chkPaidInFull]")[0];
                var dblPct = CDbl(row.find("input[id$=txtPercentage]").val());
                if (dblPct > 100) { dblPct = 100; txtPercentage.val(CPrct(100)); }
                //if (dblPct < 0) { dblPct = 0; txtPercentage.val(CPrct(0)); }
                var txtApplied = row.find("input[id$=txtApplied]");
                var spnRecordType = row.find("span[id$=spnRecordType]").text();
                var spnRecordId = row.find("span[id$=spnRecordId]").text();
                var currId = spnRecordType + spnRecordId;
                for (var i = 0; i < arrPayments.length; i++) {
                    var objPayment = arrPayments[i];
                    if (objPayment.ID == currId) {
                        arrPayments.splice(i, 1);
                    }
                }

                AppliedAmount = GetAppliedAmount();
                UnappliedAmount = TotalAmount - AppliedAmount;

                var NeededAmount = CDbl(dblOpenBalance * (dblPct / 100));

                //                 if (NeededAmount <= UnappliedAmount) {
                txtApplied.val(CCur(NeededAmount));
                if (dblPct == 100) {
                    chkPaidInFull.checked = true;
                }
                arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });
                //                 } else {
                //                     txtApplied.val(CCur(0));
                //                     txtPercentage.val(CPrct(0));
                //                     alert(msg_InsufficientFund);
                //                 }


                AppliedAmount = GetAppliedAmount();
                UnappliedAmount = TotalAmount - AppliedAmount;
                $("input[id=txtApplied]").val(CCur(AppliedAmount));
                $("input[id=txtUnapplied]").val(CCur(UnappliedAmount));


            });


            $('input[id$=txtApplied]').change(function (sender) {

                var me = $(this);
                var row = me.parents("tr:first");

                var dblOpenBalance = CDbl(row.find("span[id$=spnOpenBalance]").text());
                var txtPercentage = row.find("input[id$=txtPercentage]");
                var chkPaidInFull = row.find("input[id$=chkPaidInFull]")[0];
                var dblPct = CDbl(row.find("input[id$=txtPercentage]").val());
                var txtApplied = row.find("input[id$=txtApplied]");
                var dblApplied = CDbl(row.find("input[id$=txtApplied]").val());
                if (dblApplied > dblOpenBalance) { dblApplied = dblOpenBalance; txtApplied.val(CDbl(dblApplied)); }
                //if (dblApplied < 0) { dblApplied = 0; txtApplied.val(CDbl(0)); }

                var spnRecordType = row.find("span[id$=spnRecordType]").text();;
                var spnRecordId = row.find("span[id$=spnRecordId]").text();;
                var currId = spnRecordType + spnRecordId;
                for (var i = 0; i < arrPayments.length; i++) {
                    var objPayment = arrPayments[i];
                    if (objPayment.ID == currId) {
                        arrPayments.splice(i, 1);
                    }
                }

                AppliedAmount = GetAppliedAmount();
                UnappliedAmount = TotalAmount - AppliedAmount;

                var NeededAmount = dblApplied;
                dblPct = CDbl((NeededAmount * 100) / dblOpenBalance);


                //                 if (NeededAmount <= UnappliedAmount) {
                txtApplied.val(CCur(NeededAmount));
                txtPercentage.val(CPrct(dblPct));
                if (dblPct == 100) {
                    chkPaidInFull.checked = true;
                }
                arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });
                //                 } else {
                //                     txtApplied.val(CCur(0));
                //                     txtPercentage.val(CPrct(0));
                //                     alert(msg_InsufficientFund);
                //                 }

                AppliedAmount = GetAppliedAmount();
                UnappliedAmount = TotalAmount - AppliedAmount;
                $("input[id=txtApplied]").val(CCur(AppliedAmount));
                $("input[id=txtUnapplied]").val(CCur(UnappliedAmount));
            });

        }



        //         $(document).ready(function (n) {
        //             firstLoad();
        //         });

        function GetAppliedAmount() {
            var dblApplied = 0;
            for (var i = 0; i < arrPayments.length; i++) {
                var objPayment = arrPayments[i];
                dblApplied += objPayment.AMOUNT;
            }
            return dblApplied;
        }

        function AutoApply() {
            arrPayments = [];
            var grid = $find("<%=rdgPayAPInvoices.ClientID %>");
            var gridAllRows = grid.get_masterTableView().get_dataItems();
            for (var i = 0; i < gridAllRows.length; i++) {
                var objGridRow = gridAllRows[i];
                var txtApplied = objGridRow.findElement('txtApplied');
                var txtPercentage = objGridRow.findElement('txtPercentage');
                txtApplied.value = CCur(0);
                txtPercentage.value = CPrct(0);
            }

            var gridSelectedRows = grid.get_masterTableView().get_selectedItems()
            for (var i = 0; i < gridSelectedRows.length; i++) {
                var objGridSelectedRow = gridSelectedRows[i];
                var txtApplied = objGridSelectedRow.findElement('txtApplied');
                var chkPaidInFull = objGridSelectedRow.findElement('chkPaidInFull');
                var txtPercentage = objGridSelectedRow.findElement('txtPercentage');
                var dblOpenBalance = CDbl(objGridSelectedRow.findElement('spnOpenBalance').innerText);
                var spnRecordType = objGridSelectedRow.findElement('spnRecordType').innerText;
                var spnRecordId = objGridSelectedRow.findElement('spnRecordId').innerText;
                var currId = spnRecordType + spnRecordId;

                AppliedAmount = GetAppliedAmount();
                UnappliedAmount = TotalAmount - AppliedAmount;

                if (UnappliedAmount > 0) {
                    var NeededAmount = dblOpenBalance;
                    if (NeededAmount <= UnappliedAmount) {
                        txtApplied.value = CCur(NeededAmount);
                        txtPercentage.value = CPrct(100);
                        //                             if (blnCheckPaid == true) {
                        chkPaidInFull.checked = true;
                        //                             }
                        arrPayments.push({ 'ID': currId, 'AMOUNT': NeededAmount });

                    } else {
                        txtApplied.value = CCur(UnappliedAmount);
                        dblPct = CDbl((UnappliedAmount * 100) / dblOpenBalance);
                        arrPayments.push({ 'ID': currId, 'AMOUNT': UnappliedAmount });
                        txtPercentage.value = CPrct(dblPct);
                        break;
                    }
                }

            }

            AppliedAmount = GetAppliedAmount();
            UnappliedAmount = TotalAmount - AppliedAmount;
            $("input[id=txtApplied]").val(CCur(AppliedAmount));
            $("input[id=txtUnapplied]").val(CCur(UnappliedAmount));

            return false;
        }

        function PopToolbarButtonClicked(sender, args) {
            args.get_item().disable();
        }
    </script>
</telerik:RadCodeBlock>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgPayAPInvoices">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgPayAPInvoices" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="PopToolbarButtonClicked">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
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
                                <asp:Label ID="lblProgram" runat="server" Text="Program1" meta:Resourcekey="lblProgram"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProgram" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" runat="server" Text="Project1" meta:Resourcekey="lblProject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" Text="Company1" meta:Resourcekey="lblCompany"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPaymentMemoTotal" runat="server" Text="Payment Memo Total1" meta:Resourcekey="lblPaymentMemoTotal"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPaymentMemoTotal" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblApplied" runat="server" Text="Applied1" meta:Resourcekey="lblApplied"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtApplied" Enabled="false" Width="100%" CssClass="Currency" runat="server" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUnapplied" runat="server" Text="Unapplied1" meta:Resourcekey="lblUnapplied"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtUnapplied" Enabled="false" Width="100%" CssClass="Currency" runat="server" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                     <telerik:RadGrid ID="rdgPayAPInvoices" runat="server" AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true" FitPageHeightOffset="24"
                                            ShowStatusBar="True" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                            ShowGroupPanel="true" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="true" ItemStyle-Height="20px" GridLines="None" AllowPaging="false">

                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                                                TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">

                                                <Columns>

                                                    <telerik:GridClientSelectColumn HeaderStyle-Width="40px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Program1" HeaderStyle-Width="110px" DataField="Program" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="Program" SortExpression="Program" GroupByExpression="Program [GridColumn_Program] Group By Program ASC">
                                                        <ItemTemplate>
                                                            <span><%# IIf(Container.DataItem("Program").ToString = String.Empty, "&nbsp;", Container.DataItem("Program").ToString)%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="ProjectFullName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderText="Project" HeaderStyle-Width="110px" UniqueName="ProjectFullName" SortExpression="ProjectFullName" GroupByExpression="Project [GridColumn_Project] Group By ProjectFullName ASC">
                                                        <ItemTemplate>
                                                            <span><%# IIf(Container.DataItem("ProjectFullName").ToString = String.Empty, "&nbsp;", Container.DataItem("ProjectFullName").ToString)%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderText="Company1" HeaderStyle-Width="110px" UniqueName="Company" SortExpression="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                                        <ItemTemplate>
                                                            <span><%# IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Type1111" DataField="RecordType" ItemStyle-Wrap="false" UniqueName="RecordType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC">
                                                        <ItemTemplate>
                                                            <span id="spnRecordType" runat="server"><%# IIf(Container.DataItem("RecordType").ToString = String.Empty, "&nbsp;", Container.DataItem("RecordType").ToString)%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="RecordId1111" DataField="RecordId" ItemStyle-Wrap="false" UniqueName="RecordId" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="RecordId" GroupByExpression="RecordId [GridColumn_RecordId] Group By RecordId ASC">
                                                        <ItemTemplate>
                                                            <span id="spnRecordId" runat="server"><%# IIf(Container.DataItem("RecordId") = 0, "&nbsp;", Container.DataItem("RecordId"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Description1" DataField="Description" ItemStyle-Wrap="false" UniqueName="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                                        <ItemTemplate>
                                                            <span><%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Invoice #1" DataField="InvoiceNumber" ItemStyle-Wrap="false" UniqueName="InvoiceNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="InvoiceNumber" GroupByExpression="InvoiceNumber [GridColumn_InvoiceNumber] Group By InvoiceNumber ASC">
                                                        <ItemTemplate>
                                                            <span><%# IIf(Container.DataItem("InvoiceNumber") = String.Empty, "&nbsp;", Container.DataItem("InvoiceNumber"))%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Invoice Due1" DataField="InvoiceDue" ItemStyle-Wrap="false" UniqueName="InvoiceDue" CurrentFilterFunction="EqualTo " FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="InvoiceDue" GroupByExpression="InvoiceDue [GridColumn_InvoiceDue] Group By InvoiceDue ASC">
                                                        <ItemTemplate>
                                                            <span><%# IIf(Container.DataItem("InvoiceDue") = New Date(1900, 1, 1), "&nbsp;", FormatDate(CDate(Container.DataItem("InvoiceDue"))))%></span>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Open Balance1" DataField="OpenBalance" ItemStyle-Wrap="false" UniqueName="OpenBalance" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="OpenBalance" GroupByExpression="OpenBalance [GridColumn_OpenBalance] Group By OpenBalance ASC">
                                                        <ItemTemplate>
                                                            <span id="spnOpenBalance" runat="server"><%# IIf(Container.DataItem("OpenBalance") = 0, 0, FormatCurrency(Container.DataItem("OpenBalance"), CurrencyId:=Container.DataItem("CurrencyId")))%></span>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="%1" ItemStyle-Wrap="false" DataField="PctApplied" UniqueName="Percentage" Groupable="false" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" SortExpression="">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtPercentage" runat="server" CssClass="Percent" Width="100%" Text='<%# FormatPercent(Container.DataItem("PctApplied"))%>'></asp:TextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Applied1" ItemStyle-Wrap="false" DataField="AppliedAmount" UniqueName="Applied" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="110px" Groupable="false" SortExpression="">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtApplied" Width="99%" CssClass="Currency" Text='<%# FormatCurrency(Container.DataItem("AppliedAmount"), CurrencyId:=Container.DataItem("CurrencyId"))%>' runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText="Paid In Full1" UniqueName="PaidInFull" DataField="AppliedInFull" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" Groupable="false">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkPaidInFull" runat="server" Checked='<%# Container.DataItem("AppliedInFull") %>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>


                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">
                                                        <asp:LinkButton ID="btnAutoApply" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CommandName="AutoApply" CssClass="GridCmdAutoApply"
                                                            OnClientClick="return AutoApply();">
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

                                            <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true">
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                </div>
            </div>
        </div>
        <%--<td valign="top">
        <fieldset style="width:245px; height:60px; margin:0px; padding:0px"><legend><asp:Label ID="lblOption" runat="server" meta:resourcekey="lblOption" Text="Option1"></asp:Label></legend>
                <table> 
                <tr>
                    <td style="height:20px" valign="bottom" > 
                            <asp:CheckBox ID="chkPaidInFull" runat="server" Text="Mark Paid In Full When Using Auto Apply11" 
                                        meta:resourcekey="chkPaidInFull" />
                    </td>
                </tr>
                </table>      
        </fieldset>
    </td>--%>
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" />
    </form>
</body>
</html>
