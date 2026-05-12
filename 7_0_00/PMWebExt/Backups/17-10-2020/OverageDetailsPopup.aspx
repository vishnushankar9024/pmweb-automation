<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="OverageDetailsPopup.aspx.vb" Inherits="Website.OverageDetailsPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }

        function CloseAndRebindGrid() {
            var btnRefreshId;
            var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
            radWindow.close();
            btnRefreshId = $(window.parent.document).find("input[id$=btnOverageRefreshGrid]")
            if (btnRefreshId) {
                btnRefreshId.click();
            }
        }
        function SaveAndExit() {
            var txtAmount = window.opener.document.getElementById(querySt('txtActualAmountId'));
            var txtAmountId = querySt('txtOverageAmountId');
            var txtUnitCostId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtUnitCost'
            var txtQuantityId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtQuantity'
            var txtOv = window.opener.document.getElementById(txtAmountId);
            var txtUnitCost = window.parent.document.getElementById(txtUnitCostId);
            var txtQuantity = window.parent.document.getElementById(txtQuantityId);
            var Amount = CDbl($("input[id$=txtOverageAmount]").val());
            txtOv.value = CCur(Amount);
            txtAmount.value = CCur(CDbl($("input[id$=txtActualAmount]").val()));
            var Quantity = CDbl(txtQuantity.value);
            if (CDbl(txtQuantity.value) == 0) {
                txtQuantity.value = FPrec(1);
                Quantity = 1;
            }
            txtUnitCost.value = CCur(Amount / Quantity);
            window.close();
            return false;
        }
        function Save() {
            var txtAmount = window.opener.document.getElementById(querySt('txtActualAmountId'));
            var txtAmountId = querySt('txtOverageAmountId');
            var txtUnitCostId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtUnitCost'
            var txtQuantityId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtQuantity'
            var txtOv = window.opener.document.getElementById(txtAmountId);
            var txtUnitCost = window.parent.document.getElementById(txtUnitCostId);
            var txtQuantity = window.parent.document.getElementById(txtQuantityId);
            var Amount = CDbl($("input[id$=txtOverageAmount]").val());
            txtOv.value = CCur(Amount);
            txtAmount.value = CCur(CDbl($("input[id$=txtActualAmount]").val()));
            var Quantity = CDbl(txtQuantity.value);
            if (CDbl(txtQuantity.value) == 0) {
                txtQuantity.value = FPrec(1);
                Quantity = 1;
            }
            txtUnitCost.value = CCur(Amount / Quantity);
            return false;
        }
 
        function SetImages() {
            var img = $("input[id$=hdnOverage]").val();
            if (img != "1") {
                $('#imgOverage').attr("class", "smallUnlock")
            }
            else
                $('#imgOverage').attr("class", "smalllock");


        }
        function AutoCalculate() {
            $('input[id$=txtActualAmount]').change(function (sender) {
                if ($("input[id=chkAutoCalculate]")[0].checked) {
                    calculate();

                }

            });
        }
        function pageLoad() {
            SetImages();
            AutoCalculate();
            $('#imgOverage').click(function () {
                var cssclass = $('#imgOverage').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgOverage').attr("class", "smalllock");
                    $("input[id$=hdnOverage]").val(1);

                }
                else {

                    $('#imgOverage').attr("class", "smallUnlock");
                    $("input[id$=hdnOverage]").val('');
                }

            });
        }
        function mainToolClick(sender, args) {

            switch (args.get_item().get_commandName()) {
                case 'Calculate':
                    calculate();
                    break;
                default:
                    break;

            }
        }
        function MoreMenuClicked(sender, args) {
            if (args.get_item().get_value() == "Calculate") {
                var mainToolBar = $find("mainToolBar");
                var button = mainToolBar.findItemByValue("Calculate");
                button.click();
            }
        }

        function calculate() {
            var Exist = false;
            $('span[id$=lblBreakPoint]').each(function (sender) {
                var me = $(this);
                var row = me.parents("tr:first");
                row.find("span[id$='lblSubject']").html(CCur(0));
                row.find("span[id$='lblOverage']").html(CCur(0));
                Exist = true;
            });
            if (Exist == false) return;
            var SubjectAmount = 0;
            var Overage = 0;
            var ValueToAchieve = CDbl($("input[id$=txtActualAmount]").val());
            if (ValueToAchieve <= CDbl($('span[id$=lblBreakPoint]')[0].innerHTML)) {
                SubjectAmount = ValueToAchieve;
                Overage = CDbl((CDbl($('span[id$=lblPercent]')[0].innerHTML) * SubjectAmount) / 100);

            }
            else {
                SubjectAmount = CDbl($('span[id$=lblBreakPoint]')[0].innerHTML);
                Overage = CDbl((CDbl($('span[id$=lblPercent]')[0].innerHTML) * SubjectAmount) / 100);
            }
            var Total = SubjectAmount;
            $('span[id$=lblSubject]')[0].innerHTML = CCur(SubjectAmount);
            $('span[id$=lblOv]')[0].innerHTML = CCur(Overage);
            var i = 0;
            var TotalSubjectAmount = SubjectAmount;
            var TotalOverage = Overage;
            $('span[id$=lblBreakPoint]').each(function (sender) {
                var me = $(this);
                var row = me.parents("tr:first");
                if (i > 0) {


                    SubjectAmount = 0
                    Overage = 0
                    var TempSubjectAmount = CDbl(CDbl(row.find("span[id$='lblBreakPoint']").html()) - CDbl(row.prev().find("span[id$='lblBreakPoint']").html()));
                    if (Total == ValueToAchieve) {
                        row.find("span[id$='lblSubject']").html(CCur(0));
                        row.find("span[id$='lblOv']").html(CCur(0));

                    }
                    else if (TempSubjectAmount + Total <= ValueToAchieve) {
                        row.find("span[id$='lblSubject']").html(CCur(TempSubjectAmount));
                        var ov = CDbl((CDbl(row.find('span[id$=lblPercent]').html()) * TempSubjectAmount) / 100);
                        row.find("span[id$='lblOv']").html(CCur(ov));
                        Total = Total + TempSubjectAmount;
                        TotalSubjectAmount = TotalSubjectAmount + TempSubjectAmount;
                        TotalOverage = TotalOverage + ov;
                    }
                    else if (TempSubjectAmount + Total > ValueToAchieve) {
                        TempSubjectAmount = CDbl(ValueToAchieve - Total);
                        row.find("span[id$='lblSubject']").html(CCur(TempSubjectAmount));
                        var rov = CDbl((CDbl(row.find('span[id$=lblPercent]').html()) * TempSubjectAmount) / 100);
                        row.find("span[id$='lblOv']").html(CCur(rov));
                        Total = Total + TempSubjectAmount;
                        TotalSubjectAmount = TotalSubjectAmount + TempSubjectAmount;
                        TotalOverage = TotalOverage + rov;
                    }


                }
                i = i + 1;
            });
            $('span[id$=lblOverage]').html(CCur(TotalOverage));
            $('span[id$=lblSubjectAmount]').html(CCur(TotalSubjectAmount));
            var cssclass = $('#imgOverage').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            $("input[id$=txtOverageAmount]").val(CCur(TotalOverage));
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="mainToolClick" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton PostBack="false" CommandName="Calculate" OuterCssClass="HideOnMobileToolbar" Value="Calculate" EnableImageSprite="true" CssClass="ToolbarCalculate"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            <ItemTemplate>
                                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                    <Items>
                                                        <telerik:RadMenuItem CssClass="menuMore">
                                                            <Items>
                                                                <telerik:RadMenuItem Text="Calculate" Value="Calculate"></telerik:RadMenuItem>
                                                            </Items>
                                                        </telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenu>
                                            </ItemTemplate>
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td>
                                <asp:CheckBox runat="server" Checked="true" meta:resourcekey="chkAutoCalculate" ID="chkAutoCalculate" Text="Auto-calculate" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMMainPage documentSinglePage">
                        <div class="row ">
                            <div class="col-4">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblActualAmount" runat="server" Text="Actual Amount" meta:resourcekey="lblActualAmount"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtActualAmount" runat="server" Width="99%" CssClass="Currency"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgOverageDetails" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                            ShowGroupPanel="False" ItemStyle-Height="20px" GridLines="None" ShowFooter="true" AllowPaging="false">
                                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"
                                                TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="false" Width="400px">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Break Point" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" UniqueName="BreakPoint" DataField="BreakPoint" SortExpression="BreakPoint">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBreakPoint" Text='<%# FormatCurrency(Eval("BreakPoint")).ToString%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="150px" />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="%" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" UniqueName="Percentage" DataField="Percentage" SortExpression="Percentage">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblPercent" Text='<%# FormatPercent(Eval("Percent")).ToString%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="150px" />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderText="Subject Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" UniqueName="SubjectAmount" DataField="SubjectAmount" SortExpression="SubjectAmount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblSubject" Text='<%# FormatCurrency(Eval("SubjectAmount")).ToString%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="150px" />
                                                        <FooterTemplate>
                                                            <asp:Label runat="server" ID="lblSubjectAmount"></asp:Label>
                                                        </FooterTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="100px" HeaderText="Overage" ItemStyle-HorizontalAlign="Right" ItemStyle-Wrap="false" UniqueName="Overage" DataField="Overage" SortExpression="Overage">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblOv" Text='<%# FormatCurrency(Eval("Overage")).ToString%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label runat="server" ID="lblOverage"></asp:Label>
                                                        </FooterTemplate>
                                                        <HeaderStyle Width="150px" />
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                            <ClientSettings AllowDragToGroup="False" Resizing-AllowColumnResize="true" AllowColumnsReorder="False">
                                                <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                 <asp:Label ID="lblOverageAmount" runat="server" Text="Overage Amount" meta:resourcekey="lblOverageAmount"></asp:Label>                                          
                                            </div>
                                            <div style="float: right">
                                                 <span class="smallUnlock" id="imgOverage" style="cursor: pointer"></span>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div class="NoWrap LocktextBoxContainer">
                                                <asp:TextBox ID="txtOverageAmount" runat="server" Width="99%" CssClass="Currency LockTextbox"></asp:TextBox>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField runat="server" ID="hdnOverage" />
    </form>
</body>
</html>
