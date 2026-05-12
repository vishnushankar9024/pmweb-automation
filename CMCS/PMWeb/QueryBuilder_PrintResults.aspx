<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilder_PrintResults.aspx.vb" Inherits="Website.QueryBuilder_PrintResults" Title="Print" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <style type="text/css">
  .PMMainPage .row.displayNone{display:none !important}
  .RadGrid .rgGroupPanel{display:none;}
    .NotForPrint {
        display: block;
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

    input#chkPageNumber {
        margin-left: 0px !important;
    }

    @media screen and (min-width:320px) and (max-width:843px) {
        .documentSinglePage {
            margin-top: 0px !important;
            padding-top: 24px !important;
        }
    }

    @media screen and (min-width:320px) and (max-width:1056px) {
        .paddingLeft0 {
            padding-left: 0 !important;
        }
    }
</style>
<style type="text/css" media="print">
    .NotForPrint {
        display: none;
    }
</style>
            <script type="text/javascript">
                var intGridHeight = 0;
                var intGridWidth = 0;
                var intGridFixedWidth = 0;
                var intChartHeight = 0;
                var intChartWidth = 0;
                var intDPI = 96;

                var currentLoadingPanel = $find("<%= ldpPM.ClientID%>");
                var currentUpdatedControl = "<%= pnlReports.ClientID %>";
                var currentUpdatedControl2 = "<%= pnlParameter.ClientID %>";

                Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(initRequest);
                function initRequest(sender, args) {
                    if (args.get_postBackElement().id.indexOf("ExportPDF") != -1) {
                        args.set_cancel(true);  //stop async request
                        sender._form["**EVENTTARGET"].value = args.get_postBackElement().id.replace(/\_/g, "$");
                        sender._form["**EVENTARGUMENT"].value = "";
                        sender._form.submit();
                        return;
                    }
                }

                function GridCreated(sender, eventArgs) {
                    MoveLine();
                    $('a').click(function (n) {
                        if (this.href.toLowerCase().indexOf('.aspx?id=') > 0) {
                            window.opener.location.href = this.href;
                            self.close();
                        }
                    });
                    currentLoadingPanel = $find("<%= ldpPM.ClientID%>");
                    if (currentLoadingPanel) {
                        currentLoadingPanel.hide(currentUpdatedControl);
                        currentLoadingPanel.hide(currentUpdatedControl2);
                    }
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

                function PaperSizeChange(combobox, eventArgs) {
                    var senderElement = combobox;
                    intPaperWidth = senderElement._selectedItem._attributes.getAttribute('PaperWidth')
                    intPaperHeight = senderElement._selectedItem._attributes.getAttribute('PaperHeight');
                    MoveLine();
                }

                function PaperOrientationChange(combobox, eventArgs) {
                    var senderElement = combobox;
                    if (senderElement._selectedItem.get_value() == '0') {
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
                    $('#pnlParameter').hide(200, function () {
                        //$('#pnlReport').addClass("paddingTop");
                        if ($('#pnlReports')[0] != undefined && $('#pnlReports')[0] != null)
                            document.getElementById('hrPageRight').style.top = $('#pnlReports')[0].offsetTop + 'px';
                        if ($('#pnlParameter')[0].offsetTop == 0)
                            $('#ParameterRow').addClass("displayNone");
                        else {
                            $('#ParameterRow').removeClass("displayNone");
                        }
                        currentLoadingPanel = $find("ldpPM");
                    });
                });


                function ClientButtonClicking(sender, args) {

                    if (args.get_item().get_commandName() == "Close") {
                        window.close();
                        args.set_cancel(true);
                        return false;
                    }
                    if (args.get_item().get_commandName() == "Toggle") {
                        $('#ParameterRow').removeClass("displayNone");
                        $('#pnlParameter').toggle(200, function () {
                            if ($('#pnlReports')[0] == undefined || $('#pnlReports')[0] == null)
                                document.getElementById('hrPageRight').style.top = $('#GridRow')[0].offsetTop + 'px';
                            else
                                document.getElementById('hrPageRight').style.top = $('#pnlReports')[0].offsetTop + 'px';
                            if ($('#pnlParameter')[0].offsetTop == 0) {
                                $('#ParameterRow').addClass("displayNone");
                                document.getElementById('hrPageRight').style.top = '0px';
                            }
                            else {
                                $('#ParameterRow').removeClass("displayNone");
                                MoveLine();
                            }
                                
                        });

                        args.set_cancel(true);
                    }
                    if (args.get_item().get_commandName() == "ExportPDF") {
                        args.get_item().disabled = true;
                        currentLoadingPanel = $find("ldpPM");
                        currentLoadingPanel.show(currentUpdatedControl);
                        currentLoadingPanel.show(currentUpdatedControl2);
                    }
                }
            </script>
        </telerik:RadScriptBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
            <asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
           
                <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
                    <tr>
                        <td class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar2" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="ClientButtonClicking">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CssClass="ToolbarPDFButton" CommandName="ExportPDF">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CssClass="ToolbarExcelButton" ToolTip="Export Query" CommandName="ExportQuery"></telerik:RadToolBarButton>
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
                <div class="PMMainPage" style="padding-top:50px">
                             <div class="row" id="ParameterRow">
                               <asp:Panel  runat="server" ID="pnlParameter" style="display:flex">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth" style="width: 160px !important;">
                                            <asp:Label ID="lblPaperSize" runat="server" meta:resourcekey="lblPaperSize"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width: 240px !important;">
                                            <telerik:RadComboBox ID="ddlPaperSize" runat="server" OnClientSelectedIndexChanged="PaperSizeChange">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="A0" PaperHeight="46.8" PaperWidth="33.1" Value="4" meta:resourcekey="ListItem_PaperSize_A0"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text="A1" PaperHeight="33.1" PaperWidth="23.4" Value="5" meta:resourcekey="ListItem_PaperSize_A1"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text="A2" PaperHeight="23.4" PaperWidth="16.5" Value="6" meta:resourcekey="ListItem_PaperSize_A2"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text="A3" PaperHeight="16.5" PaperWidth="11.7" Value="7" meta:resourcekey="ListItem_PaperSize_A3"></telerik:RadComboBoxItem>
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
                                            <asp:Label ID="lblPaperOrientation" runat="server" meta:resourcekey="lblPaperOrientation"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPaperOrientation" runat="server" Width="100%" OnClientSelectedIndexChanged="PaperOrientationChange">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Portrait" Value="0" meta:resourcekey="ListItem_Portrait"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Text="Landscape" Value="1" meta:resourcekey="ListItem_Landscape"></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPrintChart" runat="server" meta:resourcekey="chkPrintChart"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:CheckBox ID="chkPrintChart" runat="server" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPrintGrid" runat="server" meta:resourcekey="chkPrintGrid"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:CheckBox ID="chkPrintGrid" runat="server" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAddPageBreakBefore" runat="server" meta:resourcekey="chkAddPageBreakBefore"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:CheckBox ID="chkAddPageBreakBefore" runat="server" Checked="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAddPageBreakAfter" runat="server" meta:resourcekey="chkAddPageBreakAfter"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:CheckBox ID="chkAddPageBreakAfter" runat="server" Checked="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="width: 100%; height: 24px;">
                                            <asp:RadioButton ID="rdbChartBefore" runat="server" GroupName="ChartBefore" meta:resourcekey="rdbChartBefore" CssClass="RadioCss" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="width: 100%; height: 24px;">
                                            <asp:RadioButton ID="rdbChartAfter" runat="server" GroupName="ChartBefore" meta:resourcekey="rdbChartAfter" CssClass="RadioCss" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-middle">
                                <fieldset style="width: 100%">
                                    <legend>
                                        <asp:Label ID="lblMargins" runat="server" meta:resourcekey="lblMargins"></asp:Label></legend>
                                    <table class="colTable">
                                        <tr>
                                            <td align="center" style="color:#666">
                                                <asp:Label ID="lblAllMargins" runat="server" meta:resourcekey="lblAllMargins"></asp:Label>
                                            </td>
                                            <td style="padding-left: 10px">
                                                <telerik:RadSlider ID="sldrAll" runat="server" Skin="Default" Width="50px" LiveDrag="true" ShowDragHandle="true" CssClass="MarginsSlider"
                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                            </td>
                                            <td align="center" style="color:#666"><span id="lblAllMarginsValue">0 px</span></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 10px;color:#666" align="center">
                                                <asp:Label ID="lblTop" runat="server" meta:resourcekey="lblTop"></asp:Label>
                                                <telerik:RadSlider ID="sldrTop" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                <span id="lblTopValue" style="color:#666">0 px</span>
                                            </td>
                                            <td style="padding-left: 10px;color:#666" align="center">
                                                <asp:Label ID="lblBottom" runat="server" meta:resourcekey="lblBottom"></asp:Label>
                                                <telerik:RadSlider ID="sldrBottom" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                <span id="lblBottomValue" style="color:#666">0 px</span>
                                            </td>
                                            <td style="padding-left: 10px;color:#666;" align="center">
                                                <asp:Label ID="lblLeft" runat="server" meta:resourcekey="lblLeft"></asp:Label>
                                                <telerik:RadSlider ID="sldrLeft" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                <span id="lblLeftValue" style="color:#666">0 px</span>
                                            </td>
                                            <td style="padding-left: 10px;color:#666" align="center">
                                                <asp:Label ID="lblRight" runat="server" meta:resourcekey="lblRight"></asp:Label>
                                                <telerik:RadSlider ID="sldrRight" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                <span id="lblRightValue" style="color:#666">0 px</span>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>
                            <div class="col-4 col-4-right">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblSettings" runat="server" Text="Settings11" meta:resourcekey="lblSettings"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth" style="width: 160px !important;">
                                                <asp:Label ID="lblFooterText" runat="server" Text="FooterText11" meta:resourcekey="lblFooterText"></asp:Label>
                                            </td>
                                            <td class="controlWidth" style="width: 240px !important;">
                                                <asp:TextBox ID="txtFooterText" runat="server" MaxLength="2000"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPageText" runat="server" Text="PageText11" meta:resourcekey="lblPageText"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPageText" runat="server" Width="100%" MaxLength="50"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPageNumber" runat="server" meta:resourcekey="chkPageNumber" Text="sHOW page "></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkPageNumber" runat="server" Checked="true" Style="margin-right: 0px;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPDFPassword" runat="server" Text="PDFPassword11" meta:resourcekey="lblPDFPassword"></asp:Label></td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPDFPassword" runat="server" Width="100%" TextMode="Password" Style="box-sizing: border-box;"></asp:TextBox></td>
                                        </tr>

                                    </table>
                                </fieldset>
                            </div>
                                  </asp:Panel>
                          </div> 
                <asp:Panel ID="pnlMain" runat="server">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
<div class="row" id="pnlReports" runat="server">
                         <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                                <div class="col-4">
                                    <table class="colTable">
                                        <thead>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlHeader" runat="server">
                                                        <div id="divRepeatedHeader">
                                                            <asp:Label runat="server" Text="" ID="lblRepeatedHeader"></asp:Label>
                                                        </div>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div id="divHeader">
                                                        <asp:Label runat="server" Text="" ID="lblHeader"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="trImgChart1" style="page-break-before: avoid; page-break-after: avoid">
                                                <td align="center">
                                                    <asp:Panel ID="pnlChart" runat="server">
                                                        <telerik:RadChart ID="RC" runat="server" AutoLayout="true" Visible="false">
                                                        </telerik:RadChart>
                                                    </asp:Panel>
                                                    <asp:Image ID="imgChart1" runat="server" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                    </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
<div style="padding-top:24px" id="GridRow">
                          <asp:Panel ID="pnlGrid" runat="server">
                                <telerik:RadGrid ID="RDG" runat="server" AllowFilteringByColumn="false" GridLines="None" EnableViewState="false"
                                    AutoGenerateColumns="True" ShowStatusBar="True" PageSize="250"  
                                    AllowPaging="False" ShowGroupPanel="True" AllowMultiRowSelection="false" AllowSorting="False" OnExcelExportCellFormatting="RDG_ExcelExportCellFormatting">
                                    <PagerStyle Mode="NextPrevAndNumeric" Visible="false" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="true" CellSpacing="0"
                                        CommandItemDisplay="None" UseAllDataFields="true" EnableHeaderContextMenu="false" FilterItemStyle-Width="100px" GroupLoadMode="Client">
                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" ColumnsReorderMethod="Reorder" AllowDragToGroup="false">
                                        <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false"
                                            AllowColumnResize="false" />
                                        <ClientEvents OnGridCreated="GridCreated" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </asp:Panel>
                        </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
<div class="row">
                        <div class="col-4">
                            <table class="colTable">
                                <tbody>
                                    <tr id="trImgChart2" style="page-break-before: avoid; page-break-after: avoid">
                                        <td align="center">
                                            <asp:Image ID="imgChart2" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divFooter">
                                                <asp:Label runat="server" Text="" ID="lblFooter"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>
                                            <div id="divRepeatedFooter">
                                                <asp:Label runat="server" Text="" ID="lblrepeatedFooter"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                            </td>
                        </tr>
                    </table>
                     
                     
                    
                    </asp:Panel>
                   
            <div id="hrPageRight" style="color: Red; font-size: 18px; font-weight: bold; position: absolute; z-index: 1100; left: 0px; top: 0px; border: 0px; padding: 0px; margin: 0px" data-exclude="true">T</div>

                </div>



               <%-- <asp:Panel ID="pnlParameters" CssClass="Margins" runat="server" GroupingText="Page Setup" meta:resourcekey="pnlParameters" style="padding-top:50px">
                    <div class="PMMainPage" style="padding-left:0px !important;padding-right:0px !important;padding-bottom:0px">
                        <div class="row" style="padding-top: 0">
                           
                        </div>
                    </div>
                </asp:Panel>
            </asp:Panel>--%>
           <%-- <asp:Panel ID="pnlReport" runat="server">
               
                <div class="PMMainPage" style="padding-bottom:0px">
                   
                </div>
                <asp:Panel ID="pnlDetails" runat="server">
                    <div class="PMMainPage" style="padding-bottom:0px">
                       
                    </div>
                </asp:Panel>
                <div class="PMMainPage">
                    
                </div>--%>
 
    </form>
</body>

</html>
