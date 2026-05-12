<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="AssetPayARInvoices.aspx.vb" Inherits="Website.AssetPayARInvoices" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script src="JS/jquery.min.js" type="text/javascript"></script>
            <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
            <script type="text/javascript">

                var TotalAmount = 0
                var UnappliedAmount = 0
                var AppliedAmount = 0
                //         var blnCheckPaidInFull = false;

                var msg_InsufficientFund = 'Insufficient fund11!'
                var arrPayments = [];
                var blnCheckPaid = false;


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
                        if (dblPct < 0) { dblPct = 0; txtPercentage.val(CPrct(0)); }
                        var txtApplied = row.find("input[id$=txtApplied]");
                        //var spnRecordType = row.find("span[id$=spnRecordType]").text();
                        var spnRecordId = row.find("span[id$=spnRecordId]").text();
                        var currId = spnRecordId;
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
                        if (dblApplied < 0) { dblApplied = 0; txtApplied.val(CDbl(0)); }

                        //var spnRecordType = row.find("span[id$=spnRecordType]").text(); ;
                        var spnRecordId = row.find("span[id$=spnRecordId]").text();;
                        var currId = spnRecordId;
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
                    var grid = $find("<%=rdgPayARInvoices.ClientID %>");
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
                    //var spnRecordType = objGridSelectedRow.findElement('spnRecordType').innerText;
                    var spnRecordId = objGridSelectedRow.findElement('spnRecordId').innerText;
                    var currId = spnRecordId;

                    AppliedAmount = GetAppliedAmount();
                    UnappliedAmount = TotalAmount - AppliedAmount;

                    if (UnappliedAmount > 0) {
                        var NeededAmount = dblOpenBalance;
                        if (NeededAmount <= UnappliedAmount) {
                            txtApplied.value = CCur(NeededAmount);
                            txtPercentage.value = CPrct(100);
                            //                         if (blnCheckPaid == true) {
                            chkPaidInFull.checked = true;
                            //                         }
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
            </script>
            <style>
                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .documentSinglePage {
                        margin-top: 50px !important;
                    }
                }
            </style>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgPayARInvoices">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgPayARInvoices" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="400px" CssClass="popup-toolbar">
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
                    <table class="colTable" border="0">
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
                                <asp:Label ID="lblLocation" runat="server" Text="Location" meta:Resourcekey="lblLocation"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLocation" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
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
                <%-- <td valign="top">
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

                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="NoWrap labelWidth">
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
                    <telerik:RadGrid ID="rdgPayARInvoices" runat="server" AutoGenerateColumns="False" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        ShowStatusBar="True" HeaderStyle-Font-Size="8" AllowFilteringByColumn="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        ShowGroupPanel="true" AllowMultiRowEdit="false" SetWidth="true" AppendMenus="true" AllowMultiRowSelection="True" AllowSorting="true" ItemStyle-Height="20px" GridLines="None" AllowPaging="false">
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                            TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">

                            <Columns>

                                <telerik:GridClientSelectColumn HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="false"></telerik:GridClientSelectColumn>

                                <telerik:GridTemplateColumn HeaderText="Program1" HeaderStyle-Width="100px" ItemStyle-Wrap="false" UniqueName="Program" SortExpression="Program" DataField="Program" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="Program [GridColumn_Program] Group By Program ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Program").ToString = String.Empty, "&nbsp;", Container.DataItem("Program").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Location" HeaderStyle-Width="100px" UniqueName="Location" SortExpression="Location" DataField="Location" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="Location [GridColumn_Location] Group By Location ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Location").ToString = String.Empty, "&nbsp;", Container.DataItem("Location").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Company1" HeaderStyle-Width="100px" UniqueName="Company" SortExpression="Company" DataField="Company" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="RecordId" ItemStyle-Wrap="false" UniqueName="RecordId" HeaderStyle-Width="100px" SortExpression="RecordId" DataField="RecordId" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="RecordId [GridColumn_RecordId] Group By RecordId ASC">
                                    <ItemTemplate>
                                        <span id="spnRecordId" runat="server"><%# IIf(Container.DataItem("RecordId") = 0, "&nbsp;", Container.DataItem("RecordId"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description1" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="100px" SortExpression="Description" DataField="Description" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Invoice #1" ItemStyle-Wrap="false" UniqueName="InvoiceNumber" HeaderStyle-Width="100px" SortExpression="InvoiceNumber" DataField="InvoiceNumber" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="InvoiceNumber [GridColumn_InvoiceNumber] Group By InvoiceNumber ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Container.DataItem("InvoiceNumber") = String.Empty, "&nbsp;", Container.DataItem("InvoiceNumber"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Invoice Due1" ItemStyle-Wrap="false" UniqueName="InvoiceDue" HeaderStyle-Width="100px" SortExpression="InvoiceDue" DataField="InvoiceDue" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="InvoiceDue [GridColumn_InvoiceDue] Group By InvoiceDue ASC">
                                    <ItemTemplate>
                                        <span><%# FormatDate(Container.DataItem("InvoiceDue"))%></span>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Open Balance1" ItemStyle-Wrap="false" UniqueName="OpenBalance" HeaderStyle-Width="100px" SortExpression="OpenBalance" DataField="OpenBalance" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" GroupByExpression="OpenBalance [GridColumn_OpenBalance] Group By OpenBalance ASC">
                                    <ItemTemplate>
                                        <span id="spnOpenBalance" runat="server"><%# IIf(Container.DataItem("OpenBalance") = 0, 0, FormatCurrency(Container.DataItem("OpenBalance")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="%1" ItemStyle-Wrap="false" UniqueName="Percentage" Groupable="false" HeaderStyle-Width="100px" SortExpression="" DataField="PctApplied" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPercentage" runat="server" CssClass="Percent" Width="100%" Text='<%# FormatPercent(Container.DataItem("PctApplied")) %>'></asp:TextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Applied1" ItemStyle-Wrap="false" UniqueName="Applied" HeaderStyle-Width="100px" Groupable="false" SortExpression="" DataField="AppliedAmount" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtApplied" Width="99%" CssClass="Currency" Text='<%# FormatCurrency(Container.DataItem("AppliedAmount")) %>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Paid In Full1" UniqueName="PaidInFull" HeaderStyle-Width="100px" DataField="AppliedInFull" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" ItemStyle-HorizontalAlign="Left" Groupable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkPaidInFull" runat="server" Checked='<%# Container.DataItem("AppliedInFull") %>' class="mobile-switch" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                            </Columns>


                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAutoApply" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CommandName="AutoApply" CssClass="GridCmdAutoApply" OnClientClick="return AutoApply();">
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
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" />
    </form>
</body>
</html>
