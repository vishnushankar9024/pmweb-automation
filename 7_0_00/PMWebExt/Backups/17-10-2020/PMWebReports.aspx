<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PMWebReports.aspx.vb" Inherits="Website.PMWebReports" Title="PMWeb Reports" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
   
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
             <style type="text/css" media="print">
        .NotForPrint {
            display: none;
        }
    </style>
    <style type="text/css">
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

        .PMHeader .row .col-12 {
            flex: 0 0 100%;
            max-width: 100%;
            float: left;
            /* padding-left: 24px; */
        }



        input[type="checkbox"] + label {
            margin: 0px 0px 10px 3px;
            position: relative;
            bottom: 3px;
        }

        input, textarea, select, button {
            font-size: inherit;
            margin-left: 0;
        }

            input[type="radio"] + label {
                margin: 0px 0px 10px 3px;
                padding-left: 16px;
            }

            input[type="password" i] {
                -webkit-text-security: disc !important;
                width: 100%;
                font-family: inherit;
                height: 24px;
                line-height: 24px;
                color: #000000;
                background: #FFFFFF;
                border: 1px solid #666;
                border-radius: 0px;
                box-sizing: border-box;
            }


        @media screen and (max-width:1233px) {
            .paddingtop {
                padding-top: 24px;
            }
        }

        .toggleUp {
            background-image: url('../css/Images/ResponsiveIcons/ddlArrowUp.png');
            height: 16px !important;
            width: 16px !important;
            border: 0px !important;
        }

        .toggleDown {
            background-image: url('../css/Images/ResponsiveIcons/ddlArrowDown.png');
            height: 16px !important;
            width: 16px !important;
            border: 0px !important;
        }

        @media screen and (max-width:1150px) {
            .imgDiv {
                width: calc(100vw - 67px);
                overflow: auto;
            }
        }
    </style>

            <script type="text/javascript">

                var currentLoadingPanel = $find("<%= ldpPM1.ClientID%>");
                var currentUpdatedControl = "<%= pnlReport.ClientID %>";
                var currentUpdatedControl2 = "<%= pnlSettings.ClientID %>";

                //function SelectCurrentRow(ctrl) {
                //    debugger;
                //    var tr = $("#" + ctrl.id).parents("tr:eq(0)");
                //    var grid = $find($("[id$=rdgReports]")[0].id);
                //    var masterTable = grid.get_masterTableView();
                //    masterTable.selectItem(tr[0].sectionRowIndex);
                //}

                function SelectCurrentRow(sender, args) {
                    let grid = sender.get_masterTableView();
                    grid.selectItem(args.get_itemIndexHierarchical());
                    grid.fireCommand("Preview", "");
                    //var master = sender.get_masterTableView();
                    //var selectedItem = master.get_selectedItems()[0];
                    //master.selectItem(selectedItem.get_itemIndex());
                }

                var intGridHeight = 0;
                var intGridWidth = 0;
                var intGridFixedWidth = 0;
                var intChartHeight = 0;
                var intChartWidth = 0;
                var intDPI = 96;


                function GridCreated(sender, eventArgs) {
                    MoveLine();
                    $('a').click(function (n) {
                        if ((this.href.toLowerCase().indexOf('.aspx?id=') > 0) ||
                            (this.href.toLowerCase().indexOf('items.aspx?itemid=') > 0) ||
                            (this.href.toLowerCase().indexOf('assemblies.aspx?assemblyid=') > 0) ||
                            (this.href.toLowerCase().indexOf('customforms.aspx?typeid=') > 0)) {
                            window.parent.location.href = this.href;
                            self.close();
                        }
                    });
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

                function PaperSizeChange(sender, args) {
                    if (sender) {
                        intPaperWidth = sender.get_selectedItem().get_attributes().getAttribute("PaperWidth");
                        intPaperHeight = sender.get_selectedItem().get_attributes().getAttribute("PaperHeight");
                        MoveLine();
                    }
                }

                function PaperOrientationChange(sender, args) {
                    if (sender) {
                        if (sender.get_selectedItem().get_value() == '0') {
                            isPortrait = 'true';
                        } else {
                            isPortrait = 'false';
                        }
                        MoveLine();
                    }
                }
                document.ready = (function (n) {

                    if (document.getElementById('lblAllMarginsValue') != null) {
                        document.getElementById('lblAllMarginsValue').innerHTML = intMarginAll + ' px';
                        document.getElementById('lblTopValue').innerHTML = intMarginTop + ' px';
                        document.getElementById('lblBottomValue').innerHTML = intMarginBottom + ' px';
                        document.getElementById('lblLeftValue').innerHTML = intMarginLeft + ' px';
                        document.getElementById('lblRightValue').innerHTML = intMarginRight + ' px';
                        //$('#pnlParameters').hide(500, function () {
                        //    document.getElementById('hrPageRight').style.top = $('#pnlReport')[0].offsetTop + 'px';
                        //    currentLoadingPanel = $find("ldpPM1");
                        //});
                    }
                });

               

                function ClientButtonClicking(sender, args) {
                    if (args.get_item().get_commandName() == "Close") {
                        window.close();
                        args.set_cancel(true);
                        return false;
                    }
                    if (args.get_item().get_commandName() == "Toggle") {
                        $('#pnlParameters').toggle(200, function () {
                            document.getElementById('hrPageRight').style.top = $('#pnlReport')[0].offsetTop + 'px';
                        });
                        args.set_cancel(true);
                    }
                    if (args.get_item().get_commandName() == "ExportPDF") {
                        args.get_item().disabled = true;
                        currentLoadingPanel = $find("<%= ldpPM1.ClientID%>");
                        currentLoadingPanel.show(currentUpdatedControl);
                        currentLoadingPanel.show(currentUpdatedControl2);
                    }
                }


                function ToggleMargins() {
                    $('#tblAllMargins').toggle(200, function () {
                        if ($('#btnToggle')[0].className == 'toggleUp') {
                            $('#btnToggle')[0].className = 'toggleDown';
                            $('#tblAllMargins')[0].className = 'TableNoSpacingNoBorder';
                        }
                        else {
                            $('#btnToggle')[0].className = 'toggleUp';
                            $('#tblAllMargins')[0].className = 'TableNoSpacingNoBorder Hide';
                        }
                        document.getElementById('hrPageRight').style.top = $('#pnlReport')[0].offsetTop + 'px';
                    });
                }


            </script>
        </telerik:RadScriptBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <telerik:RadAjaxLoadingPanel ID="ldpPM1" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>


        <asp:Panel ID="pnlSettings" runat="server">
            <table class="ToolBar" style="width: 100%;">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar2" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="ClientButtonClicking">
                            <Items>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                    Value="Close">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="ExportPDF" EnableImageSprite="true" CssClass="ToolbarPDFButton" Value="ExportPDF">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CssClass="ToolbarExcelButton" EnableImageSprite="true" CommandName="ExportQuery"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarRefresh" CommandName="Refresh">
                                </telerik:RadToolBarButton>
                                <%--<telerik:RadToolBarButton CssClass="ToolbarToggle" CommandName="Toggle" meta:resourcekey="RadToolBarButton_Toggle">
                                </telerik:RadToolBarButton>--%>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>

            <div class="PMMainPage PMPopupMainPage documentSinglePage ">
                <div class="row row-8-4">
                    <div class="col-8">

                        <asp:Panel runat="server" ID="pnlNoPrint" CssClass="NotForPrint" GroupingText="Reports" meta:resourcekey="pnlNoPrint">
                            <telerik:RadGrid ID="rdgReports" runat="server" ShowFooter="false" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10" ClientSettings-ClientEvents-OnRowClick="SelectCurrentRow"
                                AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="false"
                                AllowSorting="True" GridLines="None">
                                <PagerStyle Mode="NumericPages" AlwaysVisible="true" VerticalAlign="Bottom" Position="Bottom"></PagerStyle>

                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top" UseAllDataFields="true"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false"
                                    TableLayout="Fixed">
                                    <Columns>

                                      <%--  <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="70px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnPreviewFile" OnClientClick="SelectCurrentRow(this);" CommandName="Preview" CssClass="SearchButton"
                                                    runat="server">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="False" />
                                        </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn HeaderText="Report Id" ItemStyle-Wrap="false" SortExpression="ReportId"
                                            UniqueName="ReportId">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("ReportId") = String.Empty, "&nbsp;", Container.DataItem("ReportId"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="80px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Report" ItemStyle-Wrap="false" SortExpression="ReportName"
                                            UniqueName="ReportName">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("ReportName") = String.Empty, "&nbsp;", Container.DataItem("ReportName"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Report Type" ItemStyle-Wrap="false" SortExpression="ReportType"
                                            UniqueName="ReportType">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("ReportType") = String.Empty, "&nbsp;", Container.DataItem("ReportType"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="110px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Last Run By" ItemStyle-Wrap="false" SortExpression="LastRunBy"
                                            UniqueName="LastRunBy">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("LastRunBy") = String.Empty, "&nbsp;", Container.DataItem("LastRunBy"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="132px"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Last Run" ItemStyle-Wrap="false" SortExpression="LastRun"
                                            UniqueName="LastRun">
                                            <ItemTemplate>
                                                <%#FormatDate(Eval("LastRun"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px"></HeaderStyle>
                                            <ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Records Returned" ItemStyle-Wrap="false" SortExpression="RecordsReturned"
                                            UniqueName="RecordsReturned">
                                            <ItemTemplate>
                                                <%#Container.DataItem("RecordsReturned")%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px"></HeaderStyle>
                                            <ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <ClientSettings Selecting-AllowRowSelect="true" AllowColumnHide="true" AllowColumnsReorder="true">
                                    <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="True"></Resizing>
                                </ClientSettings>
                            </telerik:RadGrid>
                        </asp:Panel>
                     

                    </div>
                    <div class="col-4 paddingtop">
                        <table id="pnlParameters" runat="server" class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important">
                                    <asp:Label ID="lblPaperSize" runat="server" meta:resourcekey="lblPaperSize"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPaperSize" runat="server" Width="100%" OnClientSelectedIndexChanged="PaperSizeChange">
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
                                    <asp:Label ID="lblPaperOrientation" runat="server" meta:resourcekey="lblPaperOrientation"></asp:Label></td>
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
                                    <asp:Label ID="lblPageNumber" runat="server" Text="FooterText11" meta:resourcekey="lblPageNumber"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkPageNumber" runat="server" Checked="true" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFooterText" runat="server" Text="FooterText11" meta:resourcekey="lblFooterText"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtFooterText" runat="server" MaxLength="2000"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPageText" runat="server" Text="PageText11" meta:resourcekey="lblPageText"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPageText" runat="server" MaxLength="50"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPDFPassword" runat="server" Text="PDFPassword11" meta:resourcekey="lblPDFPassword"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPDFPassword" Width="100%" runat="server" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblShowChart" runat="server" meta:resourcekey="lblShowChart"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkPrintChart" runat="server" Checked="true" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblShowGrid" runat="server" meta:resourcekey="lblShowGrid"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkPrintGrid" runat="server" Checked="true" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblChartBefore" runat="server" meta:resourcekey="lblChartBefore"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkChartBefore" runat="server" Checked="true" />
                                    <%--<asp:RadioButton ID="rdbChartBefore" runat="server" GroupName="ChartBefore" CssClass="RadioCss" Style="margin-left: -3px;" />--%>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblChartAfter" runat="server" meta:resourcekey="lblChartAfter"></asp:Label></td>

                                <td class="controlWidth">
                                    <asp:RadioButton ID="rdbChartAfter" runat="server" GroupName="ChartBefore" CssClass="RadioCss" Style="margin-left: -3px;" />
                                </td>
                            </tr>--%>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAddPageBreakBefore" runat="server" meta:resourcekey="lblAddPageBreakBefore"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkAddPageBreakBefore" runat="server" Checked="false" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAddPageBreakAfter" runat="server" meta:resourcekey="lblAddPageBreakAfter"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkAddPageBreakAfter" runat="server" Checked="false" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="width: 100%;">
                                    <fieldset>
                                        <legend>
                                            <asp:Label ID="lblMargins" runat="server" meta:resourcekey="lblMargins"></asp:Label>
                                        </legend>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth" style="width: 160px !important">
                                                    <asp:Label ID="lblAllMargins" runat="server" meta:resourcekey="lblAllMargins"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <telerik:RadSlider ID="sldrAll" runat="server" Skin="Default" Width="50px" LiveDrag="true" ShowDragHandle="true"  CssClass="SmallSlider"
                                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                            </td>
                                                            <td>
                                                                <span id="lblAllMarginsValue">0 px</span>
                                                            </td>
                                                            <td>
                                                                <input id="btnToggle" class="toggleUp" type="button" onclick="return ToggleMargins();" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table id="tblAllMargins" class="TableNoSpacingNoBorder Hide" width="100%">
                                                        <tr>
                                                            <td class="labelWidth" style="width: 160px !important">
                                                                <asp:Label ID="lblTopMargin" runat="server" meta:resourcekey="lblTopMargin"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth" style="width: 240px !important">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadSlider ID="sldrTop" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                                        </td>
                                                                        <td style="padding-right: 20px;">
                                                                            <span id="lblTopValue">0 px</span>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblBottomMargin" runat="server" meta:resourcekey="lblBottomMargin"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadSlider ID="sldrBottom" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                                        </td>
                                                                        <td style="padding-right: 20px;">
                                                                            <span id="lblBottomValue">0 px</span>

                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblLeftMargin" runat="server" meta:resourcekey="lblLeftMargin"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadSlider ID="sldrLeft" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                                        </td>
                                                                        <td style="padding-right: 20px;"><span id="lblLeftValue">0 px</span></td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblRightMargin" runat="server" meta:resourcekey="lblRightMargin"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadSlider ID="sldrRight" runat="server" Skin="Default" Width="50px" CssClass="SmallSlider"
                                                                                Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                                MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                                        </td>
                                                                        <td style="padding-right: 20px;"><span id="lblRightValue">0 px</span></td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlReport" runat="server" CssClass="PMMainPage" style="margin-top:-60px !important;">
            <asp:Label ID="lblMessage2" runat="server" CssClass="Validator"></asp:Label>
            <table>
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
                            <div class="imgDiv">
                                <asp:Image ID="imgChart1" runat="server" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlDetails" runat="server">
                                <telerik:RadGrid ID="RDG" runat="server" AllowFilteringByColumn="false" GridLines="None"
                                    AutoGenerateColumns="True" ShowStatusBar="True" PageSize="20"
                                    AllowPaging="False" ShowGroupPanel="True" AllowMultiRowSelection="false"
                                    AllowSorting="False">
                                    <PagerStyle Mode="NextPrevAndNumeric" Visible="false" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ShowGroupFooter="true" CellSpacing="0"
                                        CommandItemDisplay="None" UseAllDataFields="true" EnableHeaderContextMenu="false" FilterItemStyle-Width="100px">
                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" ColumnsReorderMethod="Reorder" AllowDragToGroup="false">
                                        <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="false" />
                                        <ClientEvents OnGridCreated="GridCreated" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </asp:Panel>
                        </td>
                    </tr>
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
            <div id="hrPageRight" style="color: Red; font-size: 18px; font-weight: bold; display: none; position: absolute; z-index: 1100; left: 0px; top: 0px; border: 0px; padding: 0px; margin: 0px" data-exclude="true"></div>
        </asp:Panel>
    </form>
</body>
</html>
