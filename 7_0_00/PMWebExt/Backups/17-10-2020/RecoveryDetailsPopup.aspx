<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="RecoveryDetailsPopup.aspx.vb" Inherits="Website.RecoveryDetailsPopup" %>

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
            window.close();
            btnRefreshId = $(window.parent.document).find("input[id$=btnRecovRefreshGrid]")
            if (btnRefreshId) {
                btnRefreshId.click();
            }
        }
        function SaveAmount() {
            var txtAmountId = querySt('txtId');
            var txtAmount = window.parent.document.getElementById(txtAmountId);
            var txtUnitCostId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtUnitCost'
            var txtQuantityId = txtAmountId.substring(txtAmountId.lastIndexOf('_'), txtAmountId.lenght - 1) + '_txtQuantity'
            var txtUnitCost = window.parent.document.getElementById(txtUnitCostId);
            var txtQuantity = window.parent.document.getElementById(txtQuantityId);
            var Amount = CDbl($("input[id$=txtRecoveryAmount]").val());
            txtAmount.value = CCur(Amount);
            var Quantity = CDbl(txtQuantity.value);
            if (CDbl(txtQuantity.value) == 0) {
                txtQuantity.value = FPrec(1);
                Quantity = 1;
            }
            txtUnitCost.value = CCur(Amount / Quantity);
            window.close();
            return false;
        }
        function SetImages() {
            var img = $("input[id$=hdnAdjustedCostToRecover]").val();
            if (img != "1") {
                $('#imgadjustToRecover').attr("class", "smallUnlock")
            }
            else
                $('#imgadjustToRecover').attr("class", "smalllock");

            if ($("input[id$=hdnTeanentShare]").val() != "1") {
                $('#imgTeanentShare').attr("class", "smallUnlock");

            }
            else
                $('#imgTeanentShare').attr("class", "smalllock");
            if ($("input[id$=hdnSelectedAmount]").val() != "1") {
                $('#imgSelectedAmount').attr("class", "smallUnlock");

            }
            else
                $('#imgSelectedAmount').attr("class", "smalllock");

            if ($("input[id$=hdnRecoveryAmount]").val() != "1") {
                $('#imgReCoveryAmount').attr("class", "smallUnlock");

            }
            else
                $('#imgReCoveryAmount').attr("class", "smallUnlock");

        }
        function pageLoad() {
            //var x = $('#mainToolBar').findButtonByCommandName('Autocalculate').get_element().firstElementChild;
            var x = $('#mainToolBar').find('Autocalculate');
            SetImages();
            $('input[id$=txtCostToRecover]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    AdjustedCostToRecover();
                    TenantShare();
                    SelectedAmount();
                    RecoveryAmount();
                }
            });

            $('input[id$=txtLosstoVacancy]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    AdjustedCostToRecover();
                    TenantShare();
                    SelectedAmount();
                    RecoveryAmount();
                }
            });

            $('input[id$=txtAdjustedToRecover]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    TenantShare();
                    SelectedAmount();
                    RecoveryAmount();
                }
            });

            $('input[id$=txtProrationMethod]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    TenantShare();
                    SelectedAmount();
                    RecoveryAmount();
                }
            });
            $('input[id$=txtPercentageFactor]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    TenantShare();
                    SelectedAmount();
                    RecoveryAmount();
                }
            });

            $('input[id$=txtSelectedAmount]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    RecoveryAmount();
                }
            });

            $('input[id$=txtEstimatedCharge]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    RecoveryAmount();
                }
            });

            $('input[id$=txtLowThreshold]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    SelectedAmount();
                    RecoveryAmount();

                }

            });
            $('input[id$=txtHighThreshold]').change(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    SelectedAmount();
                    RecoveryAmount();

                }

            });

            $('#chkLowThreshold').click(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    SelectedAmount();
                    RecoveryAmount();

                }

            });
            $('#chkUpperThreshold').click(function (sender) {
                if (y.hasClass('ToolbarActive')) {
                    SelectedAmount();
                    RecoveryAmount();

                }

            });

            $('#imgadjustToRecover').click(function () {

                var cssclass = $('#imgadjustToRecover').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgadjustToRecover').attr("class", "smalllock");
                    $("input[id$=hdnAdjustedCostToRecover]").val(1);
                }
                else {
                    $("input[id$=hdnAdjustedCostToRecover]").val('');
                    $('#imgadjustToRecover').attr("class", "smallUnlock");
                }

            });
            $('#imgTeanentShare').click(function () {
                var cssclass = $('#imgTeanentShare').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgTeanentShare').attr("class", "smalllock");
                    $("input[id$=hdnTeanentShare]").val(1);
                }
                else {

                    $('#imgTeanentShare').attr("class", "smallUnlock");
                    $("input[id$=hdnTeanentShare]").val('');
                }

            });

            $('#imgReCoveryAmount').click(function () {
                var cssclass = $('#imgReCoveryAmount').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgReCoveryAmount').attr("class", "smalllock");
                    $("input[id$=hdnRecoveryAmount]").val(1);
                }
                else {

                    $('#imgReCoveryAmount').attr("class", "smallUnlock");
                    $("input[id$=hdnRecoveryAmount]").val('');

                }

            });
            $('#imgSelectedAmount').click(function () {
                var cssclass = $('#imgSelectedAmount').attr("class");
                if (cssclass.indexOf("smallUnlock") >= 0) {
                    $('#imgSelectedAmount').attr("class", "smalllock");
                    $("input[id$=hdnSelectedAmount]").val(1);

                }
                else {

                    $('#imgSelectedAmount').attr("class", "smallUnlock");
                    $("input[id$=hdnSelectedAmount]").val('');
                }

            });


        }


        function AdjustedCostToRecover() {
            var cssclass = $('#imgadjustToRecover').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var CostToRecover = CDbl($("input[id$=txtCostToRecover]").val());
            var LossToVacancy = CDbl($("input[id$=txtLosstoVacancy]").val());
            var AdjustCostToRecover = CostToRecover - (CostToRecover * LossToVacancy / 100);
            $("input[id$=txtAdjustedToRecover]").val(CCur(AdjustCostToRecover))

        }

        function TenantShare() {
            var cssclass = $('#imgTeanentShare').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var AdjustCostToRecover = CDbl($("input[id$=txtAdjustedToRecover]").val());
            var ProrationMethod = CDbl($("input[id$=txtProrationMethod]").val());
            var PercentFactor = CDbl($("input[id$=txtPercentageFactor]").val());
            var TenantShare = AdjustCostToRecover * (ProrationMethod / 100) * (PercentFactor / 100);
            $("input[id$=txtTenantShare]").val(CCur(TenantShare))

        }

        function SelectedAmount() {
            var cssclass = $('#imgSelectedAmount').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            var TeanentShare = CDbl($("input[id$=txtTenantShare]").val());
            var LowThreshold = CDbl($("input[id$=txtLowThreshold]").val());
            var UpperThreshold = CDbl($("input[id$=txtHighThreshold]").val());
            var RecoveryHasLowerThreshold = false;
            var RecoveryHasUpperThreshold = false;
            if ($("input[id=chkLowThreshold]")[0].checked == false) {
                RecoveryHasLowerThreshold = true;
            }
            if ($("input[id=chkUpperThreshold]")[0].checked == false) {
                RecoveryHasUpperThreshold = true;
            }
            if (RecoveryHasLowerThreshold && RecoveryHasUpperThreshold && UpperThreshold < LowThreshold) {
                $("input[id$=txtSelectedAmount]").val(CCur(TeanentShare));
                return;

            }

            if (RecoveryHasLowerThreshold && RecoveryHasUpperThreshold) {
                if (TeanentShare >= LowThreshold && TeanentShare <= UpperThreshold) {
                    $("input[id$=txtSelectedAmount]").val(CCur(TeanentShare));

                }
                else if (TeanentShare < LowThreshold) {
                    $("input[id$=txtSelectedAmount]").val(CCur(LowThreshold));

                }
                else {
                    $("input[id$=txtSelectedAmount]").val(CCur(UpperThreshold));
                }


            }
            if (RecoveryHasLowerThreshold == false && RecoveryHasUpperThreshold == false) {

                $("input[id$=txtSelectedAmount]").val(CCur(TeanentShare));

            }
            if (RecoveryHasLowerThreshold && RecoveryHasUpperThreshold == false) {
                if (TeanentShare >= LowThreshold) {
                    $("input[id$=txtSelectedAmount]").val(CCur(TeanentShare));

                }
                else {
                    $("input[id$=txtSelectedAmount]").val(CCur(LowThreshold));
                }
            }
            if (RecoveryHasUpperThreshold && RecoveryHasLowerThreshold == false) {

                if (TeanentShare <= UpperThreshold) {
                    $("input[id$=txtSelectedAmount]").val(CCur(TeanentShare));
                }
                else {
                    $("input[id$=txtSelectedAmount]").val(CCur(UpperThreshold));
                }
            }


        }

        function RecoveryAmount() {
            var SelectedAmount = CDbl($("input[id$=txtSelectedAmount]").val());
            var EstimatedCharge = CDbl($("input[id$=txtEstimatedCharge]").val());
            var RecoveryAmount = SelectedAmount - EstimatedCharge;
            var cssclass = $('#imgReCoveryAmount').attr("class");
            if (cssclass.indexOf("smalllock") >= 0) { return; }
            $("input[id$=txtRecoveryAmount]").val(CCur(RecoveryAmount));


        }


        function MoreMenuClicked(sender, args) {
            Calculate(args.get_item().get_value())
        }


        function Calculate(sender, args) {
            switch (args.get_item().get_commandName()) {
                case 'Calculate':
                    AdjustedCostToRecover();
                    TenantShare();
                    SelectedAmount();
                    RecoveryAmount();
                    break;
                case 'Autocalculate':
                    var x = sender.findButtonByCommandName('Autocalculate').get_element().firstElementChild;
                    if (x.getAttribute('class').indexOf('ToolbarActive') >= 0) {
                        x.setAttribute('class',x.getAttribute('class').replace('ToolbarActive', 'ToolbarInActive'))
                    } else {
                        x.setAttribute('class', x.getAttribute('class').replace('ToolbarInActive', 'ToolbarActive'))
                    }
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
        <asp:HiddenField runat="server" ID="hdnAdjustedCostToRecover" />
        <asp:HiddenField runat="server" ID="hdnTeanentShare" />
        <asp:HiddenField runat="server" ID="hdnSelectedAmount" />
        <asp:HiddenField runat="server" ID="hdnRecoveryAmount" />
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar SmallToolbar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="Calculate" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton PostBack="false" CommandName="Calculate" EnableImageSprite="true" CssClass="ToolbarCalculate"></telerik:RadToolBarButton>
                            <%--<telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
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
                            </telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" PostBack="false" 
                                CommandName="Autocalculate" AccessKey="p" ToolTip="Auto-Calculate" Value="Post" CausesValidation="false" CssClass="ToolbarActive">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <%--<td class="ToolbarTd">
                    <asp:CheckBox runat="server" ID="chkAutocalculate" Checked="true" Text="Auto-calculate" meta:resourcekey="chkAutocalculate" />
                </td>--%>
                <td style="width: 100%"></td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width:160px !important;">
                                <asp:Label ID="lblCostToRecover" runat="server" Text="Cost To Recover" meta:Resourcekey="lblCostToRecover" Width="100%"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:240px !important;">
                                <asp:TextBox ID="txtCostToRecover" runat="server" Width="100%" CssClass="Currency"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLossToVacancy" runat="server" Text="Loss To Vacancy" meta:Resourcekey="lblLossToVacancy" Width="100%"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLosstoVacancy" runat="server" Width="100%" CssClass="Percent"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblAdjustedCostToRecover" runat="server" Text="Adjusted Cost To Recover" Font-Bold="true" meta:Resourcekey="lblAdjustedCostToRecover" style="width: 123px !important;"
                                         ToolTip="Adjusted Cost To Recover"></asp:Label>
                                </div>
                                <div style="float: right;width:16px !important;">
                                    <span class="smallUnlock" id="imgadjustToRecover" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtAdjustedToRecover" runat="server" CssClass="Currency LockTextbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProrationMethod" runat="server" Text="x Proration Method" meta:Resourcekey="lblProrationMethod"></asp:Label>
                            </td>
                            <td class="controlWidth"></td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="padding-right: 8px;">
                                <telerik:RadComboBox ID="ddlProrationMethod" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default"
                                    CloseDropDownOnBlur="true" Height="300px" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2" AutoPostBack="true">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProrationMethod" runat="server" Width="100%" CssClass="Percent"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPercentageFactor" runat="server" Text="x Percentage Factor" meta:Resourcekey="lblPercentageFactor"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPercentageFactor" runat="server" Width="100%" CssClass="Percent"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblTenantShare" runat="server" Text="= Tenant's Share" meta:Resourcekey="lblTenantShare" Font-Bold="true"></asp:Label>
                                </div>
                                <div style="float: right;width:16px !important;">
                                    <span class="smallUnlock" id="imgTeanentShare" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtTenantShare" runat="server" CssClass="Currency LockTextbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLowThreshold" runat="server" Text="Lower Threshold" meta:Resourcekey="lblLowThreshold"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLowThreshold" runat="server" Width="100%" CssClass="Currency"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblVs" runat="server" Text="vs." meta:Resourcekey="lblVs"></asp:Label>
                            </td>
                            <td class="controlWidth" style="color:#666666;">
                                <asp:CheckBox ID="chkLowThreshold" runat="server" meta:Resourcekey="chkLowThreshold" Text="No Lower Threshold" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblHighThreshold" runat="server" Text="Upper Threshold" meta:Resourcekey="lblHighThreshold"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtHighThreshold" runat="server" Width="100%" CssClass="Currency"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth"></td>
                            <td class="controlWidth" style="color:#666666;">
                                <asp:CheckBox ID="chkUpperThreshold" runat="server" meta:Resourcekey="chkUpperThreshold" Text="No Upper Threshold" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblSelectedAmount" runat="server" Text="= Selected Amount" Font-Bold="true" meta:Resourcekey="lblSelectedAmount" style="width:115px !important;"></asp:Label>
                                </div>
                                <div style="float: right;width:16px !important;">
                                    <span class="smallUnlock" id="imgSelectedAmount" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtSelectedAmount" runat="server" CssClass="Currency LockTextbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEstimatedCharge" runat="server" Text="- Estimated Charge" meta:Resourcekey="lblEstimatedCharge"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtEstimatedCharge" runat="server" Width="100%" CssClass="Currency"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblRecoveryAmount" runat="server" Text="= Recovery Amount" Font-Bold="true" meta:Resourcekey="lblRecoveryAmount" style="width:115px !important;"></asp:Label>
                                </div>
                                <div style="float: right;width:16px !important;">
                                    <span class="smallUnlock" id="imgReCoveryAmount" style="cursor: pointer"></span>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtRecoveryAmount" runat="server" CssClass="Currency LockTextbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-top: 8px;color:#666666;">
                                <asp:Label ID="lblColoredFields" runat="server" Text="Fields with a colored background are calculated fields" meta:Resourcekey="lblColoredFields"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
