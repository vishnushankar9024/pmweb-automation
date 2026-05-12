<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MergePopup_PrintPreview.aspx.vb" Inherits="Website.MergePopup_PrintPreview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<style type="text/css">
    .NotForPrint {
        display: none;
    }

    .ForPrint {
        display: block;
    }

    .ChartArea {
        page-break-after: always;
    }

    .break {
        page-break-after: always;
    }

    thead {
        display: table-header-group;
    }

    tfoot {
        display: table-footer-group;
    }

    .Repeat {
        display: table-header-group;
    }

    .RadGrid .rgHeader {
        padding: 0px !important;
    }

    .PreviewMaxWidth {
        max-width: calc(99vw);
        overflow: auto;
    }

    .rfdSelect_Default {
        display: none;
    }

    @media screen and (min-width:320px) and (max-width:843px) {
        .PopupToolbarPaddingTop {
            padding-top: 0px !important;
        }
    }
</style>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">
                var intGridHeight = 0;
                var intGridWidth = 0;
                var intGridFixedWidth = 0;
                var intChartHeight = 0;
                var intChartWidth = 0;
                var intDPI = 96;


                function GridCreated(sender, eventArgs) {
                    MoveLine();
                    $('a').click(function (n) {
                        if (this.href.toLowerCase().indexOf('.aspx?id=') > 0) {
                            window.parent.location.href = this.href;
                            self.close();
                        }
                    });
                }

                function MoveLine() {
                    document.getElementById('hrPageRight').style.display = '';
                    if (!(document.getElementById('nem'))) {
                        var nem = document.body.appendChild(document.createElement('div'));
                        nem.innerHTML = "<div id='nem' style='width:1in'>&nbsp;</div>";
                    }

                    if (parseInt(document.getElementById('nem').clientWidth)) {
                        intDPI = document.getElementById('nem').clientWidth
                    }
                    if (isPortrait == 'true') {
                        document.getElementById('hrPageRight').style.left = ((intPaperWidth * 72) - ((intMarginRight) + (intMarginLeft))) + 'pt';
                    } else {
                        document.getElementById('hrPageRight').style.left = ((intPaperHeight * 72) - ((intMarginRight) + (intMarginLeft))) + 'pt';
                    }
                }


                function MarginChanged(sender, eventArgs) {
                    var sldrAll = $find('<%=sldrAll.ClientID%>');
                    var sldrTop = $find('<%=sldrTop.ClientID%>');
                    var sldrBottom = $find('<%=sldrBottom.ClientID%>');
                    var sldrLeft = $find('<%=sldrLeft.ClientID%>');
                    var sldrRight = $find('<%=sldrRight.ClientID%>');

                    if (sender._uniqueID == 'sldrAll') {
                        intMarginAll = (sender.get_value());
                        intMarginTop = intMarginAll;
                        intMarginBottom = intMarginAll;
                        intMarginRight = intMarginAll;
                        intMarginLeft = intMarginAll;

                        sldrTop.set_value(intMarginAll);
                        sldrBottom.set_value(intMarginAll);
                        sldrLeft.set_value(intMarginAll);
                        sldrRight.set_value(intMarginAll);

                        document.getElementById('lblAllMarginsValue').innerHTML = intMarginAll + ' px';
                        document.getElementById('lblTopValue').innerHTML = intMarginAll + ' px';
                        document.getElementById('lblBottomValue').innerHTML = intMarginAll + ' px';
                        document.getElementById('lblLeftValue').innerHTML = intMarginAll + ' px';
                        document.getElementById('lblRightValue').innerHTML = intMarginAll + ' px';

                    }

                    if (sender._uniqueID == 'sldrTop') {
                        document.getElementById('lblAllMarginsValue').innerHTML = '';
                        intMarginTop = (sender.get_value());
                        document.getElementById('lblTopValue').innerHTML = intMarginTop + ' px';
                    }
                    if (sender._uniqueID == 'sldrBottom') {
                        document.getElementById('lblAllMarginsValue').innerHTML = '';
                        intMarginBottom = (sender.get_value());
                        document.getElementById('lblBottomValue').innerHTML = intMarginBottom + ' px';
                    }
                    if (sender._uniqueID == 'sldrLeft') {
                        document.getElementById('lblAllMarginsValue').innerHTML = '';
                        intMarginLeft = (sender.get_value());
                        document.getElementById('lblLeftValue').innerHTML = intMarginLeft + ' px';
                    }
                    if (sender._uniqueID == 'sldrRight') {
                        document.getElementById('lblAllMarginsValue').innerHTML = '';
                        intMarginRight = (sender.get_value());
                        document.getElementById('lblRightValue').innerHTML = intMarginRight + ' px';
                    }
                    MoveLine();

                }

                function PaperSizeChange(SenderId) {
                    var senderElement = document.getElementById(SenderId);
                    intPaperWidth = senderElement[senderElement.selectedIndex].getAttribute('PaperWidth');
                    intPaperHeight = senderElement[senderElement.selectedIndex].getAttribute('PaperHeight');
                    MoveLine();
                }

                function PaperOrientationChange(SenderId) {
                    var senderElement = document.getElementById(SenderId);
                    if (senderElement[senderElement.selectedIndex].value == '0') {
                        isPortrait = 'true';
                    } else {
                        isPortrait = 'false';
                    }

                    MoveLine();
                }
                document.ready = (function (n) {
                    document.getElementById('lblAllMarginsValue').innerHTML = intMarginAll + ' px';
                    document.getElementById('lblTopValue').innerHTML = intMarginTop + ' px';
                    document.getElementById('lblBottomValue').innerHTML = intMarginBottom + ' px';
                    document.getElementById('lblLeftValue').innerHTML = intMarginLeft + ' px';
                    document.getElementById('lblRightValue').innerHTML = intMarginRight + ' px';
                    $('#pnlParameters').hide(200, function () {
                        document.getElementById('hrPageRight').style.top = $('#pnlReport')[0].offsetTop + 'px';;

                    });
                    MoveLine();
                });

                function ClientButtonClicking(sender, args) {
                    if (args.get_item().get_commandName() == "Close") {
                        window.close();
                        args.set_cancel(true);
                        return false;
                    }
                    if (args.get_item().get_commandName() == "Toggle") {
                        $('#pnlParameters').toggle(200, function () {
                            document.getElementById('hrPageRight').style.top = $('#pnlReport')[0].offsetTop + 'px';;
                        });
                        args.set_cancel(true);
                    }

                }


            </script>
        </telerik:RadScriptBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpOffice2007">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpOffice2007" runat="server" BackgroundPosition="Center" Skin="Default" />
        <asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
        <asp:Panel ID="pnlSettings" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="ToolBar">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar2" Height="25px" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="ClientButtonClicking">
                            <Items>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="ExportPDF" EnableImageSprite="true" CssClass="ToolbarExportPDF">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarRefresh" CommandName="Refresh">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CssClass="ToolbarToggleReport" CommandName="Toggle" Value="Toggle">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                    Value="Close">
                                </telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>

            <asp:Panel ID="pnlParameters" runat="server">
                <%--<table id="tblToggle" style="background-color:Window" width="700px" cellpadding="0" cellspacing="0" border="0">
        <tr>
        <td align="center"> 
        </td>
        </tr>
        </table>--%>
                <div class="PMMainPage documentSinglePage">
                    <div class="row JustifyContent">
                        <div class="col-4">
                            <table id="tblParam" style="background-color: Window" class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important;">
                                        <asp:Label ID="lblPaperSize" runat="server" meta:resourcekey="lblPaperSize"></asp:Label></td>
                                    <td class="controlWidth" style="width: 240px !important;">
                                        <telerik:RadComboBox ID="ddlPaperSize" runat="server" Width="100%" onchange="PaperSizeChange(this.id)">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="A0" PaperHeight="46.8" PaperWidth="33.1" Value="4" meta:resourcekey="ListItem_PaperSize_A0"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A1" PaperHeight="33.1" PaperWidth="23.4" Value="5" meta:resourcekey="ListItem_PaperSize_A1"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A2" PaperHeight="23.4" PaperWidth="16.5" Value="6" meta:resourcekey="ListItem_PaperSize_A2"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A3" PaperHeight="16.5" PaperWidth="11.7" Value="7" meta:resourcekey="ListItem_PaperSize_A3">
                                                </telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A4" PaperHeight="11.7" PaperWidth="8.3" Value="8" meta:resourcekey="ListItem_PaperSize_A4"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A5" PaperHeight="8.3" PaperWidth="5.8" Value="9" meta:resourcekey="ListItem_PaperSize_A5"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A6" PaperHeight="5.8" PaperWidth="4.1" Value="10" meta:resourcekey="ListItem_PaperSize_A6"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A7" PaperHeight="4.1" PaperWidth="2.9" Value="11" meta:resourcekey="ListItem_PaperSize_A7"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A8" PaperHeight="2.9" PaperWidth="2.0" Value="12" meta:resourcekey="ListItem_PaperSize_A8"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A9" PaperHeight="2.0" PaperWidth="1.5" Value="13" meta:resourcekey="ListItem_PaperSize_A9"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="A10" PaperHeight="1.5" PaperWidth="1" Value="14" meta:resourcekey="ListItem_PaperSize_A10"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="ArchA" PaperHeight="12" PaperWidth="9" Value="25" meta:resourcekey="ListItem_PaperSize_ArchA"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="ArchB" PaperHeight="18" PaperWidth="12" Value="24" meta:resourcekey="ListItem_PaperSize_ArchB"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="ArchC" PaperHeight="24" PaperWidth="18" Value="23" meta:resourcekey="ListItem_PaperSize_ArchC"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="ArchD" PaperHeight="36" PaperWidth="24" Value="22" meta:resourcekey="ListItem_PaperSize_ArchD"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="ArchE" PaperHeight="48" PaperWidth="36" Value="21" meta:resourcekey="ListItem_PaperSize_ArchE"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="B0" PaperHeight="55.67" PaperWidth="39.37" Value="15" meta:resourcekey="ListItem_PaperSize_B0"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="B1" PaperHeight="39.37" PaperWidth="27.83" Value="16" meta:resourcekey="ListItem_PaperSize_B1"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="B2" PaperHeight="27.83" PaperWidth="19.69" Value="17" meta:resourcekey="ListItem_PaperSize_B2"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="B3" PaperHeight="19.69" PaperWidth="13.90" Value="18" meta:resourcekey="ListItem_PaperSize_B3"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="B4" PaperHeight="13.90" PaperWidth="9.84" Value="19" meta:resourcekey="ListItem_PaperSize_B4"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="B5" PaperHeight="9.84" PaperWidth="6.93" Value="20" meta:resourcekey="ListItem_PaperSize_B5"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Flsa" PaperHeight="13" PaperWidth="8.5" Value="26" meta:resourcekey="ListItem_PaperSize_Flsa"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="HalfLetter" PaperHeight="5.5" PaperWidth="8.5" Value="27" meta:resourcekey="ListItem_PaperSize_HalfLetter"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Ledger" PaperHeight="17" PaperWidth="11" Value="29" meta:resourcekey="ListItem_PaperSize_Ledger"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Legal" PaperHeight="14" PaperWidth="8.5" Value="3" meta:resourcekey="ListItem_PaperSize_Legal"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Letter" PaperHeight="11" PaperWidth="8.5" Value="1" meta:resourcekey="ListItem_PaperSize_Letter"></telerik:RadComboBoxItem>
                                            </Items>

                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaperOrientation" runat="server" meta:resourcekey="lblPaperOrientation"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPaperOrientation" runat="server" Width="100%" onchange="PaperOrientationChange(this.id)">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Portrait" Value="0" meta:resourcekey="ListItem_Portrait"></telerik:RadComboBoxItem>
                                                <telerik:RadComboBoxItem Text="Landscape" Value="1" meta:resourcekey="ListItem_Landscape"></telerik:RadComboBoxItem>
                                            </Items>

                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-8">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblMargins" runat="server" meta:resourcekey="lblMargins"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblAllMargins" runat="server" meta:resourcekey="lblAllMargins"></asp:Label></td>
                                        <td style="padding-left: 10px">
                                            <telerik:RadSlider ID="sldrAll" runat="server" Skin="Default" Width="75px" LiveDrag="true" ShowDragHandle="true"
                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                        </td>
                                        <td align="center"><span id="lblAllMarginsValue">0 px</span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px">
                                            <asp:Label ID="lblTop" runat="server" meta:resourcekey="lblTop"></asp:Label>
                                            <telerik:RadSlider ID="sldrTop" runat="server" Skin="Default" Width="75px"
                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                            <span id="lblTopValue">0 px</span>
                                        </td>
                                        <td style="padding-left: 10px" align="center">
                                            <asp:Label ID="lblBottom" runat="server" meta:resourcekey="lblBottom"></asp:Label>
                                            <telerik:RadSlider ID="sldrBottom" runat="server" Skin="Default" Width="75px"
                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                            <span id="lblBottomValue">0 px</span>
                                        </td>
                                        <td style="padding-left: 10px" align="center">
                                            <asp:Label ID="lblLeft" runat="server" meta:resourcekey="lblLeft"></asp:Label>
                                            <telerik:RadSlider ID="sldrLeft" runat="server" Skin="Default" Width="75px"
                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                            <span id="lblLeftValue">0 px</span>
                                        </td>
                                        <td style="padding-left: 10px" align="center">
                                            <asp:Label ID="lblRight" runat="server" meta:resourcekey="lblRight"></asp:Label>
                                            <telerik:RadSlider ID="sldrRight" runat="server" Skin="Default" Width="75px"
                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                            <span id="lblRightValue">0 px</span>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </asp:Panel>
        <div class="PMMainPage documentSinglePage">
            <div class="row ">
                <div class="col-12">
                    <table>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlReport" runat="server" CssClass="PreviewMaxWidth PopupToolbarPaddingTop">
                                    <asp:Label runat="server" Text="" ID="lblMergeBody"></asp:Label>
                                </asp:Panel>
                                <div id="hrPageRight" style="color: Red; font-size: 18px; font-weight: bold; display: none; position: absolute; z-index: 1100; left: 0px; top: 0px; border: 0px; padding: 0px; margin: 0px" data-exclude="true">T</div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
