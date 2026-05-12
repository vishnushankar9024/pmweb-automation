<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="EscalationDetailsPopup.aspx.vb" Inherits="Website.EscalationDetailsPopup" %>

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
            CloseRadWnd();
            btnRefreshId = $(window.parent.document).find("input[id$=btnEscRefreshGrid]")
            if (btnRefreshId) {
                btnRefreshId.click();
            }
        }
        function SaveAmount(closeval) {
            var txtAmountId = querySt('txtNewAmountId');
            var txtAmount = window.parent.document.getElementById(txtAmountId);
            var txtUnitCostId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtNewUnitCost'
            var txtQuantityId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtNewQuantity'
            var txtUnitCost = window.parent.document.getElementById(txtUnitCostId);
            var txtQuantity = window.parent.document.getElementById(txtQuantityId);
            var Amount = CDbl($("input[id$=txtNewAmount]").val());
            txtAmount.value = CCur(Amount);
            var Quantity = CDbl(txtQuantity.value);
            if (CDbl(txtQuantity.value) == 0) {
                txtQuantity.value = FPrec(1);
                Quantity = 1;
            }
            txtUnitCost.value = CCur(Amount / Quantity);
            if (closeval == "1") {
                CloseRadWnd();
            }
            return false;
        }
        function SetImages() {
            var img = $("input[id$=hdnEscPercent]").val();
            if (img != "1") {
                $('#imgEscPercent').attr("class", "smallUnlock")
            }
            else
                $('#imgEscPercent').attr("class", "smalllock");

            if ($("input[id$=hdnPreliminaryEsc]").val() != "1") {
                $('#imgPreliminaryEsc').attr("class", "smallUnlock");

            }
            else
                $('#imgPreliminaryEsc').attr("class", "smalllock");
            if ($("input[id$=hdnEscAmount]").val() != "1") {
                $('#imgEscAmount').attr("class", "smallUnlock");

            }
            else
                $('#imgEscAmount').attr("class", "smalllock");

            if ($("input[id$=hdnNewAmount]").val() != "1") {
                $('#imgNewAmount').attr("class", "smallUnlock");

            }
            else
                $('#imgNewAmount').attr("class", "smalllock");

        }

        function AutoCalculate() {
            $('input[id$=txtNextIndex]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculatePercentChage();
                    CalculateEscPercent();
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtPreviousIndex]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculatePercentChage();
                    CalculateEscPercent();
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtPercentageOfIndexChange]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscPercent();
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtPercentageChange]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscPercent();
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtEscalationPercent]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtBase]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtPreliminaryEscalation]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtEscalationAmount]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtLowThreshold]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('input[id$=txtHighThreshold]').change(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('#chkLowThreshold').click(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });
            $('#chkHighThreshold').click(function (sender) {
                if ($("input[id=chkAutocalculate]")[0].checked) {
                    CalculateEscAmount();
                    CalculateNewAmount();

                }

            });


        }
        function pageLoad() {
            //            $("input.Double").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: 3, DecimalSeparator: Global_DecimalSeparator }).blur(function (e) { $(this).val(); });
            SetImages();
            AutoCalculate();
            $('#imgEscPercent').click(function () {

                var cssclass = $('#imgEscPercent').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgEscPercent').attr("class", "smalllock");
                    $("input[id$=hdnEscPercent]").val(1);
                }
                else {
                    $("input[id$=hdnEscPercent]").val('');
                    $('#imgEscPercent').attr("class", "smallUnlock");
                }

            });
            $('#imgPreliminaryEsc').click(function () {
                var cssclass = $('#imgPreliminaryEsc').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgPreliminaryEsc').attr("class", "smalllock");
                    $("input[id$=hdnPreliminaryEsc]").val(1);
                }
                else {

                    $('#imgPreliminaryEsc').attr("class", "smallUnlock");
                    $("input[id$=hdnPreliminaryEsc]").val('');
                }

            });

            $('#imgEscAmount').click(function () {
                var cssclass = $('#imgEscAmount').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgEscAmount').attr("class", "smalllock");
                    $("input[id$=hdnEscAmount]").val(1);
                }
                else {

                    $('#imgEscAmount').attr("class", "smallUnlock");
                    $("input[id$=hdnEscAmount]").val('');

                }

            });
            $('#imgNewAmount').click(function () {
                var cssclass = $('#imgNewAmount').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgNewAmount').attr("class", "smalllock");
                    $("input[id$=hdnNewAmount]").val(1);

                }
                else {

                    $('#imgNewAmount').attr("class", "smallUnlock");
                    $("input[id$=hdnNewAmount]").val('');
                }

            });


        }

        function CalculatePercentChage() {
            var PreviousAmount = CDbl($("input[id$=txtPreviousIndex]").val());
            var NextAmount = CDbl($("input[id$=txtNextIndex]").val());
            if (PreviousAmount != 0) {
                var Res = ((NextAmount - PreviousAmount) / PreviousAmount) * 100;
                $("input[id$=txtNextIndex]").val(CPrct(Res));
            }
            else {
                $("input[id$=txtNextIndex]").val(CPrct(0));
            }

        }
        function CalculatePercentChage() {
            var PreviousAmount = CDbl($("input[id$=txtPreviousIndex]").val());
            var NextAmount = CDbl($("input[id$=txtNextIndex]").val());
            if (PreviousAmount != 0) {
                var Res = ((NextAmount - PreviousAmount) / PreviousAmount) * 100;
                $("input[id$=txtPercentageChange]").val(CPrct(Res));
            }
            else {
                $("input[id$=txtPercentageChange]").val(CPrct(0));
            }

        }
        function CalculateEscPercent() {
            var cssclass = $('#imgEscPercent').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var Res = CDbl(100 * (CDbl($("input[id$=txtPercentageChange]").val()) / 100) * (CDbl($("input[id$=txtPercentageOfIndexChange]").val()) / 100))
            $("input[id$=txtEscalationPercent]").val(CPrct(Res));


        }
        function CalculatePreliminaryEsc() {

            var cssclass = $('#imgPreliminaryEsc').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var Res = CDbl((CDbl($("input[id$=txtEscalationPercent]").val()) / 100) * CDbl($("input[id$=txtBase]").val()));
            $("input[id$=txtPreliminaryEscalation]").val(CCur(Res));
        }

        function CalculateEscAmount() {
            var cssclass = $('#imgEscAmount').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var PreliminaryEsc = CDbl($("input[id$=txtPreliminaryEscalation]").val());
            var LowThreshold = CDbl($("input[id$=txtLowThreshold]").val());
            var UpperThreshold = CDbl($("input[id$=txtHighThreshold]").val());
            var RecoveryHasLowerThreshold = false;
            var RecoveryHasUpperThreshold = false;
            if ($("input[id=chkLowThreshold]")[0].checked == false) {
                RecoveryHasLowerThreshold = true;
            }
            if ($("input[id=chkHighThreshold]")[0].checked == false) {
                RecoveryHasUpperThreshold = true;
            }
            if (RecoveryHasLowerThreshold && RecoveryHasUpperThreshold && UpperThreshold < LowThreshold) {
                $("input[id$=txtEscalationAmount]").val(CCur(PreliminaryEsc));
                return;

            }

            if (RecoveryHasLowerThreshold && RecoveryHasUpperThreshold) {
                if (PreliminaryEsc >= LowThreshold && PreliminaryEsc <= UpperThreshold) {
                    $("input[id$=txtEscalationAmount]").val(CCur(PreliminaryEsc));

                }
                else if (PreliminaryEsc < LowThreshold) {
                    $("input[id$=txtEscalationAmount]").val(CCur(LowThreshold));

                }
                else {
                    $("input[id$=txtEscalationAmount]").val(CCur(UpperThreshold));
                }


            }
            if (RecoveryHasLowerThreshold == false && RecoveryHasUpperThreshold == false) {

                $("input[id$=txtEscalationAmount]").val(CCur(PreliminaryEsc));

            }
            if (RecoveryHasLowerThreshold && RecoveryHasUpperThreshold == false) {
                if (PreliminaryEsc >= LowThreshold) {
                    $("input[id$=txtEscalationAmount]").val(CCur(PreliminaryEsc));

                }
                else {
                    $("input[id$=txtEscalationAmount]").val(CCur(LowThreshold));
                }
            }
            if (RecoveryHasUpperThreshold && RecoveryHasLowerThreshold == false) {

                if (PreliminaryEsc <= UpperThreshold) {
                    $("input[id$=txtEscalationAmount]").val(CCur(PreliminaryEsc));
                }
                else {
                    $("input[id$=txtEscalationAmount]").val(CCur(UpperThreshold));
                }
            }


        }

        function CalculateNewAmount() {
            var cssclass = $('#imgNewAmount').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var Res = CDbl($("input[id$=txtCurrentAmount]").val()) + CDbl($("input[id$=txtEscalationAmount]").val())
            $("input[id$=txtNewAmount]").val(CCur(Res));
        }

        function Calculate(sender, args) {

            switch (args.get_item().get_commandName()) {
                case 'Calculate':
                    var PreviousAmount = CDbl($("input[id$=txtPreviousIndex]").val());
                    var NextAmount = CDbl($("input[id$=txtNextIndex]").val());
                    if (PreviousAmount > 0 || NextAmount > 0) {
                        CalculatePercentChage();
                    }
                    CalculateEscPercent();
                    CalculatePreliminaryEsc();
                    CalculateEscAmount();
                    CalculateNewAmount();
                    break;
                default:
                    break;

            }
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
                                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="Calculate" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton PostBack="false" CommandName="Calculate" EnableImageSprite="true" CssClass="ToolbarCalculate"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td align="left" class="NoWrap">
                                <asp:CheckBox runat="server" ID="chkAutocalculate" Text="Auto-calculate" meta:resourcekey="chkAutocalculate" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage R24SidePadding">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblIndex" runat="server" Text="Index" meta:Resourcekey="lblIndex"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlIndex" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Width="100%"
                                    AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="300px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNextIndex" runat="server" Text="Next Index" meta:Resourcekey="lblNextIndex"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td align="right" style="width: 50%">
                                            <telerik:RadComboBox ID="ddlNextIndex" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default" EnableLoadOnDemand="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                CloseDropDownOnBlur="true" Height="300px" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2" AutoPostBack="true">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width: 50%; padding-left: 5px;">
                                            <asp:TextBox ID="txtNextIndex" runat="server" Precision="3" CssClass="Double" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPreviousIndex" runat="server" Text="Previous Index" meta:Resourcekey="lblPreviousIndex"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td align="right" style="width: 50%">
                                            <telerik:RadComboBox ID="ddlPreviousIndex" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                                EnableLoadOnDemand="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                CloseDropDownOnBlur="true" Height="300px" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2" AutoPostBack="true">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width: 50%; padding-left: 5px;">
                                            <asp:TextBox ID="txtPreviousIndex" Precision="3" runat="server" CssClass="Double" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPercentChange" runat="server" Text="% Change = (Next - Previous)/Previous" meta:Resourcekey="lblPercentChange"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPercentageChange" runat="server" CssClass="Percent" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPercentageOfIndexChange" runat="server" Text="x % Of Index Change" meta:Resourcekey="lblPercentageOfIndexChange"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPercentageOfIndexChange" runat="server" CssClass="Percent" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblEscalationPercent" runat="server" Font-Bold="true" Text="= Escalation %" meta:Resourcekey="lblEscalationPercent"></asp:Label>
                                </div>
                                <div style="float: right; padding-top: 3px; padding-right: 2px;">
                                    <span class="smallUnlock" id="imgEscPercent" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <div class="LocktextBoxContainer">
                                    <asp:TextBox ID="txtEscalationPercent" runat="server" CssClass="Percent LockTextbox" Width="100%"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBase" runat="server" Text="x Base" meta:Resourcekey="lblBase"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="width: 50%">
                                            <telerik:RadComboBox ID="ddlBase" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Width="100%"
                                                AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="300px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width: 50%; padding-left: 5px;">
                                            <asp:TextBox ID="txtBase" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblPreliminaryEscalation" Font-Bold="true" runat="server" Text="= Preliminary Escalation" meta:Resourcekey="lblPreliminaryEscalation"></asp:Label>
                                </div>
                                <div style="float: right; padding-top: 3px; padding-right: 2px;">
                                    <span class="smallUnlock" id="imgPreliminaryEsc" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <div class="LocktextBoxContainer">
                                    <asp:TextBox ID="txtPreliminaryEscalation" runat="server" CssClass="Currency LockTextbox" Width="100%"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLowerThreshold" runat="server" Text="Lower Threshold" meta:Resourcekey="lblLowerThreshold"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLowThreshold" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblVs" runat="server" Text="vs." meta:Resourcekey="lblVs"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkLowThreshold" runat="server" Text="No Lower Threshold" meta:Resourcekey="chkLowThreshold" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblHighThreshold" runat="server" Text=" Upper Threshold" meta:Resourcekey="lblHighThreshold"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtHighThreshold" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">&nbsp;</td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkHighThreshold" runat="server" Text="No Upper Threshold" meta:Resourcekey="chkHighThreshold" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblEqualEscalationAmount" runat="server" Font-Bold="true" Text="=Escalation Amount" meta:Resourcekey="lblEqualEscalationAmount"></asp:Label>

                                </div>
                                <div style="float: right; padding-top: 3px; padding-right: 2px;">
                                    <span class="smallUnlock" id="imgEscAmount" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <div class="LocktextBoxContainer">
                                    <asp:TextBox ID="txtEscalationAmount" runat="server" CssClass="Currency LockTextbox" Width="100%"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrentAmount" runat="server" Text="+ Current Amount" meta:Resourcekey="lblCurrentAmount"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrentAmount" Enabled="false" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidthChkBox">
                                <div style="float: left;">
                                    <asp:Label ID="lblNewEesultAmount" runat="server" Font-Bold="true" Text="= New Amount" meta:Resourcekey="lblNewEesultAmount"></asp:Label>
                                </div>
                                <div style="float: right; padding-top: 3px; padding-right: 2px;">
                                    <span class="smallUnlock" id="imgNewAmount" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <div class="LocktextBoxContainer">
                                    <asp:TextBox ID="txtNewAmount" runat="server" CssClass="Currency LockTextbox" Style="background-color: #666666; color: #ffffff;" Width="100%"></asp:TextBox>
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top: 8px;">
                                <asp:Label ID="lblColoredFields" runat="server" Text="Fields with a colored background are calculated fields." meta:Resourcekey="lblColoredFields"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hdnEscPercent" />
        <asp:HiddenField runat="server" ID="hdnPreliminaryEsc" />
        <asp:HiddenField runat="server" ID="hdnEscAmount" />
        <asp:HiddenField runat="server" ID="hdnNewAmount" />
    </form>
</body>
</html>
