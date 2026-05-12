<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="QueryBuilder.aspx.vb" Inherits="Website.QueryBuilder" %>

<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="QueryBuilderDetails.ascx" TagName="QueryBuilderDetails" TagPrefix="uc1" %>
<%@ Register Src="QueryBuilderResults.ascx" TagName="QueryBuilderResults" TagPrefix="uc2" %>
<%@ Register Src="QueryBuilderHeaders.ascx" TagName="QueryBuilderHeaders" TagPrefix="uc7" %>
<%@ Register Src="QueryBuilderChart.ascx" TagName="QueryBuilderChart" TagPrefix="uc8" %>
<%@ Register Src="QueryBuilderHeaders.ascx" TagName="QueryBuilderHeaders" TagPrefix="uc10" %>
<%@ Register Src="QueryBuilderPermissions.ascx" TagName="QueryBuilderPermissions" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc9" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpQueries">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpQueries" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpQueries" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function onNodeDropping(sender, args) {
                var dest = args.get_destNode();
                if (dest) {
                }
                else {
                    dropOnHtmlElement(args);
                }
            }

            function OnClientSelectedIndexChanged(sender, eventArgs) {
                var item = eventArgs.get_item();
                var prefix = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
                SelectedChartChanged(item.get_value(), prefix);
            }

            function OnClientLoadHandler(sender) {
                var prefix = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
                SelectedChartChanged(sender.get_value(), prefix);
            }

            function GridCreated(sender, args) {
                $("[id*='txtLeftBrackets']").keypress(function (e) {
                    var intKey = (window.Event) ? e.which : e.keyCode;
                    if (!((intKey == 40) || (intKey == 41))) {
                        return false;
                    }

                });
                $("[id*='txtRightBrackets']").keypress(function (e) {
                    var intKey = (window.Event) ? e.which : e.keyCode;
                    if (!((intKey == 40) || (intKey == 41))) {
                        return false;
                    }

                });
                $("[id*='txtBrackets']").keypress(function (e) {
                    var intKey = (window.Event) ? e.which : e.keyCode;
                    if (!((intKey == 40) || (intKey == 41))) {
                        return false;
                    }
                });
            }

            function SelectedChartChanged(Chart, prefix) {
                switch (Chart) {
                    case '9':
                        $("[id = '" + prefix + "_ddlLabelsField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlXField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlYField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlX2Field']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlY2Field']").removeAttr('disabled');
                        break;

                    case '12':
                        $("[id = '" + prefix + "_ddlLabelsField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlXField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlYField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlX2Field']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlY2Field']").removeAttr('disabled');
                        break;

                    case '8':
                        $("[id = '" + prefix + "_ddlLabelsField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlXField']").attr('disabled', true).val('0');
                        $("[id = '" + prefix + "_ddlYField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlX2Field']").attr('disabled', true).val('0');
                        $("[id = '" + prefix + "_ddlY2Field']").attr('disabled', true).val('0');
                        break;


                    default:
                        $("[id = '" + prefix + "_ddlLabelsField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlXField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlYField']").removeAttr('disabled');
                        $("[id = '" + prefix + "_ddlX2Field']").attr('disabled', true).val('0');
                        $("[id = '" + prefix + "_ddlY2Field']").attr('disabled', true).val('0');
                        break;
                }
            }

            function click_handler(sender, args) {

                maintoolbarClick(args.get_item().get_commandName())
            }
             var gridId1 = "<%= rdgSelect.ClientID %>";
            var gridId2 = "<%= rdgWhere.ClientID %>";

            function dropOnHtmlElement(args) {
                if (droppedOnGrid(args))
                    return;
            }
            function droppedOnGrid(args) {
                var target = args.get_htmlElement();
                while (target) {
                    if ((target.id == gridId1) || (target.id == gridId2)) {
                        args.set_htmlElement(target);
                        return;
                    }
                    target = target.parentNode;
                }
                args.set_cancel(true);
            }

            function openCalculationPopup(FieldId) {
                return OpenPOPUp('QueryBuilderCalculatedField.aspx?Id=' + FieldId, 728, 550, true, 'rdgSelect');
            }

            function maintoolbarClick(Value) {
                switch (Value) {
                    case 'PrintPreview':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 400) / 2;
                        OpenPOPUp('QueryBuilder_PrintResults.aspx', 1045, 515, false);

                        break;

                    case 'ExportSQL':
                        OpenPOPUp('QueryBuilder_ExportSQL.aspx', 1045, 515, false);

                        break;

                    case 'Notification':
                        var Id = '<%= PM.QueryBuilderInfo.Id%>';
                        var Code = '<%=JSEscape(PM.QueryBuilderInfo.QueryCode)%>';
                        var Description = '<%=JSEscape(PM.QueryBuilderInfo.Name)%>';
                        var RecordDescription = Code + ' - ' + Description;
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=QUERY_BUILDER&Id=" +
                               '<%= PM.QueryBuilderInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", 1045, 515, false);
                        break;
                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }

            }
            function pageLoad() {
                var sldrAll = $find('<%=sldrAll.ClientID%>');
                var sldrTop = $find('<%=sldrTop.ClientID%>');
                var sldrBottom = $find('<%=sldrBottom.ClientID%>');
                var sldrLeft = $find('<%=sldrLeft.ClientID%>');
                var sldrRight = $find('<%=sldrRight.ClientID%>');
                if (sldrTop == null || sldrBottom == null || sldrLeft == null || sldrRight == null) return;
                if (sldrTop.get_value() == sldrBottom.get_value() && sldrLeft.get_value() == sldrRight.get_value() && sldrLeft.get_value() == sldrTop.get_value())
                    document.getElementById('lblAllMarginsValue').innerHTML = sldrAll.get_value() + ' px';
                else
                    document.getElementById('lblAllMarginsValue').innerHTML = '';
                document.getElementById('lblTopValue').innerHTML = sldrTop.get_value() + ' px';
                document.getElementById('lblBottomValue').innerHTML = sldrBottom.get_value() + ' px';
                document.getElementById('lblLeftValue').innerHTML = sldrLeft.get_value() + ' px';
                document.getElementById('lblRightValue').innerHTML = sldrRight.get_value() + ' px';
            }

            function MarginChanged(sender, eventArgs) {
                var sldrAll = $find('<%=sldrAll.ClientID%>');
                var sldrTop = $find('<%=sldrTop.ClientID%>');
                var sldrBottom = $find('<%=sldrBottom.ClientID%>');
                var sldrLeft = $find('<%=sldrLeft.ClientID%>');
                var sldrRight = $find('<%=sldrRight.ClientID%>');

                if (sender._uniqueID == 'ctl00$CPH1$sldrAll') {
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
                if (sender._uniqueID == 'ctl00$CPH1$sldrTop') {
                    document.getElementById('lblAllMarginsValue').innerHTML = '';
                    intMarginTop = (sender.get_value());
                    document.getElementById('lblTopValue').innerHTML = intMarginTop + ' px';
                }
                if (sender._uniqueID == 'ctl00$CPH1$sldrBottom') {
                    document.getElementById('lblAllMarginsValue').innerHTML = '';
                    intMarginBottom = (sender.get_value());
                    document.getElementById('lblBottomValue').innerHTML = intMarginBottom + ' px';
                }
                if (sender._uniqueID == 'ctl00$CPH1$sldrLeft') {
                    document.getElementById('lblAllMarginsValue').innerHTML = '';
                    intMarginLeft = (sender.get_value());
                    document.getElementById('lblLeftValue').innerHTML = intMarginLeft + ' px';
                }
                if (sender._uniqueID == 'ctl00$CPH1$sldrRight') {
                    document.getElementById('lblAllMarginsValue').innerHTML = '';
                    intMarginRight = (sender.get_value());
                    document.getElementById('lblRightValue').innerHTML = intMarginRight + ' px';
                }
               // MoveLine();
            }
            function PaperSizeChange(SenderId) {
                var senderElement = document.getElementById(SenderId);
                intPaperWidth = senderElement[senderElement.selectedIndex].getAttribute('PaperWidth');
                intPaperHeight = senderElement[senderElement.selectedIndex].getAttribute('PaperHeight');
               // MoveLine();
            }
            function PaperOrientationChange(SenderId) {
                var senderElement = document.getElementById(SenderId);
                if (senderElement[senderElement.selectedIndex].value == '0') {
                    isPortrait = 'true';
                } else {
                    isPortrait = 'false';
                }

                //MoveLine();
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

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);

                maintoolbarClick(args.get_item().get_value())
            }

            function MoreMenuOpening(sender, args) {

                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }

            function MoreMenuClosing(sender, args) {

                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function ShowHidebtnTreeFilterDropItems(sender, args) {
                if (sender.get_checkedNodes().length > 0) {
                    $("[id$=btnFilterDropItems]").removeClass("Hide");
                }
                else
                    $("[id$=btnFilterDropItems]").addClass("Hide");
            }

            function CheckViewRight(chkViewOnly) {
                var tr = $(chkViewOnly).parents(".rgEditForm:first");
                if (!tr || tr.length == 0)
                    tr = $(chkViewOnly).parents("tr:first");
                if (!chkViewOnly.checked) {
                    tr.find("input[id $= 'chkFullControl']")[0].checked = false;
                    tr.find("input[id $= 'chkManageFolder']")[0].checked = false;
                    tr.find("input[id $= 'chkAddQuery']")[0].checked = false;
                    tr.find("input[id $= 'chkDeleteQuery']")[0].checked = false;
                    tr.find("input[id $= 'chkEditQuery']")[0].checked = false;
                    tr.find("input[id $= 'chkEditPermissions']")[0].checked = false;

                }
            }

            function CheckRight(chkRight) {
                var tr = $(chkRight).parents(".rgEditForm:first");
                if (!tr || tr.length == 0)
                    tr = $(chkRight).parents("tr:first");
                var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
                var chkViewOnly = tr.find("input[id $= 'chkViewOnly']")[0];
                var chkManageFolder = tr.find("input[id $= 'chkManageFolder']")[0];
                var chkAddQuery = tr.find("input[id $= 'chkAddQuery']")[0];
                var chkEditQuery = tr.find("input[id $= 'chkEditQuery']")[0];
                var chkDeleteQuery = tr.find("input[id $= 'chkDeleteQuery']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkRight.checked) {
                    chkViewOnly.checked = true;
                    if (chkManageFolder.checked && chkAddQuery.checked && chkEditQuery.checked && chkDeleteQuery.checked && chkEditPermissions.checked)
                        chkFullControl.checked = true;
                } else {
                    chkFullControl.checked = false;
                }
            }

            function CheckFullControlRight(chkFullControl) {
                var tr = $(chkFullControl).parents(".rgEditForm:first");
                if (!tr || tr.length == 0)
                    tr = $(chkFullControl).parents("tr:first");
                var chkViewOnly = tr.find("input[id $= 'chkViewOnly']")[0];
                var chkManageFolder = tr.find("input[id $= 'chkManageFolder']")[0];
                var chkAddReports = tr.find("input[id $= 'chkAddQuery']")[0];
                var chkEditReports = tr.find("input[id $= 'chkEditQuery']")[0];
                var chkDeleteReports = tr.find("input[id $= 'chkDeleteQuery']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkFullControl.checked) {
                    chkViewOnly.checked = true;
                    chkManageFolder.checked = true;
                    chkAddReports.checked = true;
                    chkEditReports.checked = true;
                    chkDeleteReports.checked = true;
                    chkEditPermissions.checked = true;
                } else {
                    chkViewOnly.checked = false;
                    chkManageFolder.checked = false;
                    chkAddReports.checked = false;
                    chkEditReports.checked = false;
                    chkDeleteReports.checked = false;
                    chkEditPermissions.checked = false;
                }
            }

            function OnDesignClientTabSelected(sender, args) {
                if (args.get_tab().get_value() == 'Print') {
                    window.setTimeout(function () { 
                    document.getElementById('lblAllMarginsValue').innerHTML = intMarginAll + ' px';
                    document.getElementById('lblTopValue').innerHTML = intMarginTop + ' px';
                    document.getElementById('lblBottomValue').innerHTML = intMarginBottom + ' px';
                    document.getElementById('lblLeftValue').innerHTML = intMarginLeft + ' px';
                    document.getElementById('lblRightValue').innerHTML = intMarginRight + ' px';
                    }, 1000);
                }
            }
            function toggleMargins() {
                var MarginsDiv = $('.MarginsDiv');
                var btnShowHide = $('.ShowMargins');
                if (MarginsDiv[0].className.indexOf('Hide') >= 0) {
                    MarginsDiv[0].className = MarginsDiv[0].className.replace(' Hide', '');
                    btnShowHide[0].className = btnShowHide[0].className + ' HideMargins';
                }
                else{
                    MarginsDiv[0].className = MarginsDiv[0].className + ' Hide';
                    btnShowHide[0].className = btnShowHide[0].className.replace(' HideMargins', '');
                }
                return false;
            }
        </script>
        <style>
            input[type="checkbox"] + label, input[type="radio"] + label {
                top: -2px;
                left: 5px;
                color: #666666;
            }
            .TreeHeight{height:calc(100vh - 210px)}
            .FullWidth{max-width:calc(100vw - 374px) !important;
                       width:calc(100vw - 374px) !important;
            }
            .rail .FullWidth{max-width:calc(100vw - 246px) !important;
                              width:calc(100vw - 246px) !important;
            }
            .gridWidth{max-width:65%}
            .btnTreeDropItems {
                display: block !important;
            }
            @media screen and (max-width: 1323px) and (min-width: 844px) {
             .FullWidth{max-width:calc(100vw - 383px) !important;
                        width:calc(100vw - 383px) !important}
                .rail .FullWidth {
                    max-width: calc(100vw - 257px) !important;
                    width: calc(100vw - 257px) !important;
                }
            
         
            }
            @media screen and (max-width: 1160px) and (min-width: 844px) {
            .gridWidth{max-width:55% !important}
            }

            @media screen and (max-width: 843px) and (min-width: 320px) {
                .RadTreeView.RadTreeView_Default {
                    width: 100% !important;
                }
                .FullWidth {
                    max-width: 100% !important;
                    width:100% !important;
                }
                 .gridWidth{max-width:100%}
                .tbsDocSpec{display:inline-block !important}
                .PMHeader .row .col-10{float:none !important;margin-left: 150px;}
                .paddingLeftMobile{padding-left:8px !important;min-width: 300px;}
            }

            #ctl00_CPH1_Qd1_tbsDesign .rtsScroll {
                left: 0 !important;
                width: 100% !important;
            }

            #ctl00_CPH1_Qd1_tbsDesign .rtsLevel.rtsLevel1 {
                width: 100% !important;
            }

            @media screen and (max-width: 843px) {
                #ctl00_CPH1_Qd1_tbsDesign {
                    height: 32px !important;
                }
            }
        </style>
    </telerik:RadCodeBlock>
    <table class="LargeToolBar ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=173">
                                <div class="btnToolbarSearchDocument"> 
                                     &nbsp;                                                
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent"> 
                                     &nbsp;                                                   
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchTree" PostBackUrl="QueryViewer.aspx">
                                <div class="btnToolbarSearchTree">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar ShowDropDown showOnIpad">
                <telerik:RadComboBox ID="ddlQueries" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" Width="240px" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    meta:resourcekey="ddlQueries" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" CheckForDirt="True" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="QueryViewer.aspx" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" Value="Edit" AccessKey="s" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="New" AccessKey="n" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification"
                            ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" PostBack="false" CausesValidation="false" CommandName="PrintPreview"
                            ImageUrl="Images/ToolBar/Printer.png" Visible="true" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CommandName="separator" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" PostBack="false" CommandName="ExportSQL"
                            ImageUrl="Images/ToolBar/Sql.png" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="PrintPreview" CssClass="Print" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Export SQL" Value="ExportSQL" CssClass="ExportSQL" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('QUERY_BUILDER');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" CssClass="documentTabs"
        runat="server" MultiPageID="mlpQueries" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Design" Value="Design" Selected="True" />
            <%--<telerik:RadTab Value="Details" CssClass="HideTabWhenDetailShownInHeader" />--%>
            <telerik:RadTab Value="ViewPrint" Text="View / Print" />
            <telerik:RadTab Value="Notes" />
            <telerik:RadTab Value="Attachments" />
            <telerik:RadTab Value="Workflow" Visible="false" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpQueries" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvDesign" runat="server" Selected="True">
            <div class="PMHeader">
                <div class="row">
                    <div class="col-2" style="width:150px">
                        <telerik:RadTabStrip ID="tbsDesign" OnClientTabSelecting="onTabSelecting" OnClientTabSelected="OnDesignClientTabSelected" ScrollChildren="true" ScrollButtonsPosition="Left" 
                            runat="server" SelectedIndex="0" MultiPageID="mlpDesign" Skin="Default" Orientation="VerticalLeft" CssClass="tbsSpecPC tbsFolderManagerSpecs tbsDocSpec"
                            Width="100%" EnableViewState="True">
                            <Tabs>
                                <telerik:RadTab Text="1 Select Fields" Value="Fields"></telerik:RadTab>
                                <telerik:RadTab Text="2 Create Filters" Value="Filters"></telerik:RadTab>
                                <telerik:RadTab Text="3 Add a chart" Value="Charts"></telerik:RadTab>
                                <telerik:RadTab Text="4 Headers/Footer" Value="HeadersFooter"></telerik:RadTab>
                                <telerik:RadTab Text="5 Permissions" meta:resourcekey="Permission" Value="Permission"></telerik:RadTab>
                                <telerik:RadTab Text="6 Print Layout" Value="Print"></telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                    </div>
                    <div class="col-10 FullWidth" id="divGrids">
                        <telerik:RadMultiPage ID="mlpDesign" SelectedIndex="0" runat="server" RenderSelectedPageOnly="false">
                            <telerik:RadPageView runat="server" ID="pvFields">
                                <div style="padding-top:24px;padding-left:24px;display:flex">
                                        <div style="width:400px">
                                            <fieldset id="tdTreeFields" style="position: relative;">
                                                <legend>
                                                    <asp:Label ID="lblFields" runat="server" Text="Fields" meta:resourcekey="lblFields"></asp:Label>
                                                </legend>
                                                <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="True" CssClass="TreeHeight TreeWithoutIcons"  OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                                    OnClientNodeDropping="onNodeDropping" MultipleSelect="True" Width="100%" CheckBoxes="true" TriStateCheckBoxes="true">
                                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                                    <CollapseAnimation Duration="100" Type="OutQuint" />
                                                </telerik:RadTreeView>
                                                <asp:LinkButton runat="server" ID="btnTreeDropItems">
                                                    <div class="btnTreeDropItems" style="display: inline-block !important;">&nbsp;</div>
                                                </asp:LinkButton>
                                            </fieldset>
                                        </div>
                                        <div style="padding-left:24px;" class="gridWidth">
                                            <telerik:RadGrid ID="rdgSelect" runat="server" UseEditFormInMobile="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10" ShowFooter="false" FitParentContainer="true"
                                                AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AppendMenus="True"
                                                AllowSorting="True" GridLines="None">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber">
                                                            <ItemTemplate>
                                                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%#Eval("LineNumber").ToString%>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Table" UniqueName="TableName">
                                                            <ItemTemplate>
                                                                <%# Eval("TableName") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%# Eval("TableName") %>&nbsp;
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="175px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Field" UniqueName="FieldName">
                                                            <ItemTemplate>
                                                                <%# Eval("FieldName") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%# Eval("FieldName") %>&nbsp;
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="170px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Alias" UniqueName="AliasName">
                                                            <ItemTemplate>
                                                                <%# Eval("AliasName") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtAliasName" runat="server" Text='<%# Eval("AliasName") %>' Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Calculation" UniqueName="Calculation">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="imgCalculation" runat="server" Visible='<%# Eval("IsCalculated") %>'
                                                                    OnClientClick='<%# "return openCalculationPopup(" &  Eval("Id") & ");" %>' CssClass="FormulaButton">
                                                <span class="Icon"></span></asp:LinkButton>
                                                                &nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                &nbsp; 
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Subtotal" UniqueName="AggregateEnumId">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblAggregate"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlAggregates" runat="server" Width="100%">
                                                                    <Items>
                                                                          <telerik:RadComboBoxItem Text="None" Value="0" meta:resourcekey="ListItem_None"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Sum" Value="1" meta:resourcekey="ListItem_Sum"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Min" Value="2" meta:resourcekey="ListItem_Min"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Max" Value="3" meta:resourcekey="ListItem_Max"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Last" Value="4" meta:resourcekey="ListItem_Last"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="First" Value="5" meta:resourcekey="ListItem_First"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Count" Value="6" meta:resourcekey="ListItem_Count"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Avg" Value="7" meta:resourcekey="ListItem_Avg"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Count Distinct" Value="8" meta:resourcekey="ListItem_CountDistinct"></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Width" UniqueName="Width">
                                                            <ItemTemplate>
                                                                <span><%#CStr(Eval("Width")) & "&nbsp;px"%>&nbsp;</span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtWidth" runat="server" Text='<%# Eval("Width") %>' Width="100%" CssClass="Integer"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="80px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Show" UniqueName="Show">
                                                            <ItemTemplate>
                                                                <span>
                                                                    <img alt="" src='<%#IIf(Container.DataItem("Show"), "Images/Global/checked.png", "Images/Global/unchecked.png")%>' /></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chkShow" runat="server" Checked=' <%# IIf(Eval("Show") Is System.DBNull.Value, False, Eval("Show")) %>' />
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="50px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Header / Footer" UniqueName="ShowInHeader">
                                                            <ItemTemplate>
                                                                <span>
                                                                    <img alt="" src='<%#IIf(Container.DataItem("ShowInHeader"), "Images/Global/checked.png", "Images/Global/unchecked.png")%>' /></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:CheckBox ID="chkShowInHeader" runat="server" Checked=' <%# IIf(Eval("ShowInHeader") Is System.DBNull.Value, False, Eval("ShowInHeader")) %>' />
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="80px" Wrap="true" />
                                                        </telerik:GridTemplateColumn>

                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <div style="padding: 2px">
                                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                                                CommandName="InitNewCalculatedRow" CssClass="GridCmdInitNewCalculatedRow" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblAddCalculatedLine"  runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSelect.EditIndexes.Count > 0 %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnSave" runat="server" SecurityButtonType="AddEditMode_Add"
                                                                CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgSelect.MasterTableView.IsItemInserted %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                                                CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgSelect.EditIndexes.Count > 0 Or rdgSelect.MasterTableView.IsItemInserted %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>

                                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                                                OnClientClick="return ConfirmDelete()" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'
                                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'>
                                                                <span class="Icon"></span>
                                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </asp:LinkButton>
                                                        </div>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="false" AllowColumnsReorder="false"
                                                    AllowDragToGroup="false" AllowRowsDragDrop="true">
                                                    <ClientEvents></ClientEvents>
                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                        AllowColumnResize="True" />
                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                                </ClientSettings>
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                            </telerik:RadGrid>
                                        </div>
                                 </div>
                            </telerik:RadPageView>
                            <telerik:RadPageView runat="server" ID="pvFilters">
                               <div style="padding-top:24px;padding-left:24px;display:flex">
                                        <div style="width:400px">
                                            <fieldset style="position: relative;">
                                                <legend>
                                                    <asp:Label ID="Label1" runat="server" Text="Fields" meta:resourcekey="lblFields"></asp:Label>
                                                </legend>
                                                <telerik:RadTreeView ID="treeFilter" runat="server" EnableDragAndDrop="True" CssClass="TreeHeight" OnClientNodeChecked="ShowHidebtnTreeFilterDropItems"
                                                    OnClientNodeDropping="onNodeDropping" MultipleSelect="True" Width="100%" CheckBoxes="true" TriStateCheckBoxes="true">
                                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                                    <CollapseAnimation Duration="100" Type="OutQuint" />
                                                </telerik:RadTreeView>
                                                <asp:LinkButton runat="server" ID="btnFilterDropItems">
                                                <div class="btnTreeDropItems" style="display: inline-block !important;">&nbsp; </div>
                                                </asp:LinkButton>
                                            </fieldset>
                                        </div>
                                         <div style="padding-left:24px" class="gridWidth">
                                            <telerik:RadGrid ID="rdgWhere" runat="server" UseEditFormInMobile="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="5" ShowFooter="false" FitParentContainer="true"
                                                AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                                AllowSorting="True" GridLines="None">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber"
                                                            Groupable="false" Reorderable="false" AllowFiltering="false">
                                                            <ItemTemplate>
                                                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%#Eval("LineNumber").ToString%>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridTemplateColumn HeaderText="()" UniqueName="LeftBrackets">
                                                            <ItemTemplate>
                                                                <%# Eval("LeftBrackets") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtLeftBrackets" runat="server" Text='<%# Eval("LeftBrackets") %>' Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="50px" />
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridTemplateColumn HeaderText="And/Or" UniqueName="AndOr">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblLogicalOperators" Text=' <%# Eval("AndOr") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlAndOr" runat="server">
                                                                    <Items>
                                                                     <telerik:RadComboBoxItem Text="" Value=""></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="And" Value="AND" Selected="True" meta:resourcekey="ListItem_AND"></telerik:RadComboBoxItem>
                                                                    <telerik:RadComboBoxItem Text="Or" Value="OR" Selected="False" meta:resourcekey="ListItem_OR"></telerik:RadComboBoxItem>
                                                                    </Items>
                                                          
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="50px" />
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridTemplateColumn HeaderText="()" UniqueName="RightBrackets">
                                                            <ItemTemplate>
                                                                <%# Eval("RightBrackets") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtRightBrackets" runat="server" Text='<%# Eval("RightBrackets") %>' Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="50px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Field" UniqueName="FieldName">
                                                            <ItemTemplate>
                                                                <%# Eval("FieldName") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%# Eval("FieldName") %>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Operator" UniqueName="Operator">
                                                            <ItemTemplate>
                                                                <%# Eval("Operator") %>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:DropDownList ID="ddlOperators" Width="100%" runat="server" />
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value">
                                                            <ItemTemplate>
                                                                <asp:Image runat="server" ID="imgCheck" />
                                                                <asp:Label runat="server" ID="lblValue"></asp:Label>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtValueString" Width="100%" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueString" CssClass="Validator"
                                                                    ValidationGroup="SaveWhere" ControlToValidate="txtValueString" Display="Dynamic"
                                                                    meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                                <asp:TextBox ID="txtValueNumber" Width="100%" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueNumber" CssClass="Validator"
                                                                    ValidationGroup="SaveWhere" ControlToValidate="txtValueNumber" Display="Dynamic"
                                                                    meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                                <telerik:RadDatePicker ID="txtValueDate" Height="25px" runat="server"
                                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                                    <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False"
                                                                        ViewSelectorText="x">
                                                                    </Calendar>
                                                                    <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default" CausesValidation="True"
                                                                        Height="13px" ValidationGroup="SaveWhere">
                                                                    </DateInput>
                                                                    <DatePopupButton CssClass="" HoverImageUrl="" ImageUrl="" />
                                                                </telerik:RadDatePicker>
                                                                <asp:CheckBox ID="chkValueBoolean" Checked="true" runat="server"></asp:CheckBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="155px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="()" UniqueName="Bracket">
                                                            <ItemTemplate>
                                                                <%# Eval("Brackets")%>&nbsp;
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtBrackets" runat="server" Text='<%# Eval("Brackets")%>' Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="50px" />
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                                            CommandName="EditRows" CssClass="GridCmdEditRows" Visible="<%# rdgWhere.EditIndexes.Count = 0 %>"
                                                            SecurityButtonType="ItemMode_Edit">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False"
                                                            CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible="<%# rdgWhere.EditIndexes.Count > 0 %>"
                                                            SecurityButtonType="AddEditMode_Edit">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" SecurityButtonType="ItemMode_Delete"
                                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgWhere.EditIndexes.Count = 0 And (Not rdgWhere.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" SecurityButtonType="AddEditMode" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible="<%# rdgWhere.EditIndexes.Count > 0 %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                            CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgWhere.EditIndexes.Count = 0 And (Not rdgWhere.MasterTableView.IsItemInserted) %>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                                    AllowDragToGroup="false" AllowRowsDragDrop="true">
                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                                    <ClientEvents OnRowDblClick="RowDblClick" OnGridCreated="GridCreated"></ClientEvents>
                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                        AllowColumnResize="True" />
                                                </ClientSettings>
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                            </telerik:RadGrid>
                                        </div>
                                    </div>
                            </telerik:RadPageView>
                            <telerik:RadPageView runat="server" ID="pvChart">
                                <uc8:QueryBuilderChart ID="QBC" runat="server" />
                            </telerik:RadPageView>
                            <telerik:RadPageView runat="server" ID="pvHeadersFooter">
                                <uc10:QueryBuilderHeaders ID="QueryBuilderHeaders1" runat="server" />
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="pvPermissions" runat="server">
                                <uc11:QueryBuilderPermissions ID="QueryBuilderPermissions1" runat="server" />
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="pvPrint" runat="server">
                                <div class="PMMainPage JustifyContent">
                                    <div class="row">
                                        <div class="col-4 col-4-left">
                                            <table class="colTable" id="tblQuery1">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblQueryCode" runat="server" Text="ID*" meta:resourcekey="lblQueryCode"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtQueryCode" MaxLength="200" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvQueryCode" runat="server" ControlToValidate="txtQueryCode" ErrorMessage="Required"
                                                            CssClass="Validator" ValidationGroup="Save" Display="Dynamic" ForeColor="" meta:resourcekey="rfvQueryCode"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblName" runat="server" Text="Name" meta:resourcekey="lblName"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtName" MaxLength="200" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblRecordType" runat="server" Text="Record Type*" meta:resourcekey="lblRecordType"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlRecordTypes" runat="server" Width="100%" Height="300px" Skin="Default"
                                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" AutoPostBack="true" AllowCustomText="true" Filter="Contains">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                          <asp:CustomValidator ID="csvRecordTypes" runat="server" ControlToValidate="ddlRecordTypes"
                                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                            CssClass="Validator" meta:resourcekey="cmpRecordTypes">
                                                        </asp:CustomValidator>
                                                         <asp:RequiredFieldValidator ValidationGroup="Save"  ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlRecordTypes" ErrorMessage="Required"
                                                            CssClass="Validator" Display="Dynamic" ForeColor=""  meta:resourcekey="cmpRecordTypes"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblStatusRevision" runat="server" Text="Status / Revision" meta:resourcekey="lblStatusRevision"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default"
                                                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                                    <asp:TextBox ID="txtRevisionNumber" runat="server" Width="100%" Enabled="false" CssClass="PositiveInteger"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                 <tr id="trCurrency" runat="server">
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblCurrency" meta:Resourcekey="lblCurrency" runat="server" Text="Currency"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlCurrency" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblReportType" runat="server" Text="Report Type" meta:resourcekey="lblReportType"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlReportType" runat="server" Width="100%" Height="300px" Skin="Default">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblReportNotes" runat="server" Text="Report Notes" meta:resourcekey="lblReportNotes"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadTextBox runat="server" TextMode="MultiLine" ID="txtReportNotes" Height="80px" InputType="Text"></telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLastRun" runat="server" meta:resourcekey="lblLastRun" Text="Last Run"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtLastRun" MaxLength="15" runat="server" CssClass="Date" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLastRunBy" runat="server" meta:resourcekey="lblLastRunBy" Text="Last Run By"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtLastRunBy" runat="server" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblRecordsReturned" runat="server" meta:resourcekey="lblRecordsReturned" Text="Records Returned"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtRecordsReturned" MaxLength="15" runat="server" CssClass="PositiveInteger" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="width: 100%">
                                                        <fieldset>
                                                            <legend>
                                                                <asp:Label ID="lblDefaultPrintSetup" runat="server" Text="Default Print Setup" meta:resourcekey="lblDefaultPrintSetup"></asp:Label>
                                                            </legend>
                                                        </fieldset>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblGridTheme" runat="server" Text="Grid Theme" meta:resourcekey="lblGridTheme"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth"> 
                                                        <telerik:RadComboBox runat="server" ID="ddlGridSkins" Skin="Default" Width="100%" Height="300px">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="Black" Value="Black" meta:resourcekey="ListItem_Black" />
                                                                <telerik:RadComboBoxItem Text="Default" Value="Default" meta:resourcekey="ListItem_Default" />
                                                                <telerik:RadComboBoxItem Text="Green" Value="Telerik" meta:resourcekey="ListItem_Green" />
                                                                <telerik:RadComboBoxItem Text="Metro" Value="Metro" meta:resourcekey="ListItem_Metro" />
                                                                <telerik:RadComboBoxItem Text="Office2007" Value="Office2007" meta:resourcekey="ListItem_Office2007" />
                                                                <telerik:RadComboBoxItem Text="Office2010Black" Value="Office2010Black" meta:resourcekey="ListItem_Office2010Black" />
                                                                <telerik:RadComboBoxItem Text="Office2010Blue" Value="Office2010Blue" meta:resourcekey="ListItem_Office2010Blue" />
                                                                <telerik:RadComboBoxItem Text="Outlook" Value="Outlook" meta:resourcekey="ListItem_Outlook" />
                                                                <telerik:RadComboBoxItem Text="Simple" Value="Simple" meta:resourcekey="ListItem_Simple" />
                                                                <telerik:RadComboBoxItem Text="Sunset" Value="Sunset" meta:resourcekey="ListItem_Sunset" />
                                                                <telerik:RadComboBoxItem Text="Vista" Value="Vista" meta:resourcekey="ListItem_Vista" />
                                                                <telerik:RadComboBoxItem Text="Web20" Value="Web20" meta:resourcekey="ListItem_Web20" />
                                                                <telerik:RadComboBoxItem Text="WebBlue" Value="WebBlue" meta:resourcekey="ListItem_WebBlue" />
                                                                <telerik:RadComboBoxItem Text="Windows7" Value="Windows7" meta:resourcekey="ListItem_Windows7" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblPageSize" runat="server" Text="Page Size" meta:Resourcekey="lblPageSize"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlPaperSize" runat="server" onchange="PaperSizeChange(this.id)">
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
                                                        <asp:Label ID="lblOrientation" runat="server" Text="Orientation" meta:Resourcekey="lblOrientation"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlPaperOrientation" runat="server" Width="100%" onchange="PaperOrientationChange(this.id)">
                                                           
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblShowPageNumber" runat="server" Text="Show Page Number" meta:Resourcekey="lblShowPageNumber"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkShowPageNumber" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblFooterText" runat="server" Text="Footer Text" meta:Resourcekey="lblFooterText"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtFooterText" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblPageText" runat="server" Text="Page Text" meta:Resourcekey="lblPageText"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtPageText" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblPDFPassword" runat="server" Text="PDF Password" meta:Resourcekey="lblPDFPassword"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtPDFPassword" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-4 col-4-middle">
                                            <uc12:AssetRotator ID="PMrot" runat="server" />
                                            <table class="colTable">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblShowGrid" runat="server" Text="Show Grid" meta:Resourcekey="lblShowGrid"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkShowGrid" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblDistinctLinesOnly" runat="server" Text="Distinct Lines Only" meta:Resourcekey="lblDistinctLinesOnly"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkDistinctLinesOnly" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblShowChart" runat="server" Text="Show Chart" meta:Resourcekey="lblShowChart"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkShowChart" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblChartOnTop" runat="server" Text="Chart On Top" meta:Resourcekey="lblChartOnTop"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkChartOnTop" runat="server"  />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblPageBreakBeforeChart" runat="server" Text="Page Break Before Chart" meta:Resourcekey="lblPageBreakBeforeChart"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkPageBreakBeforeChart" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblPageBreakAfterChart" runat="server" Text="Page Break After Chart" meta:Resourcekey="lblPageBreakAfterChart"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:CheckBox ID="chkPageBreakAfterChart" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                             <fieldset style="width: 100%">
                                    <legend>
                                        <asp:Label ID="lblMargins" runat="server" meta:resourcekey="lblMargins"></asp:Label></legend>
                                    <table class="colTable">
                                        <tr>
                                            <td align="left" style="color:#666">
                                                <asp:Label ID="lblAllMargins" runat="server" meta:resourcekey="lblAllMargins"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <telerik:RadSlider ID="sldrAll" runat="server" Skin="MetroTouch" Width="50px" LiveDrag="true" ShowDragHandle="true" 
                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                            </td>
                                            <td align="center" style="color:#666"><span id="lblAllMarginsValue">0 px</span></td>
                                            <td>
                                                 <asp:LinkButton runat="server" ID="btnToggleMargins"  OnClientClick="return toggleMargins();">
                                                                <div class="ShowMargins HideMargins"> 
                                                                     &nbsp;                                                
                                                                                </div>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                        </table>
                                                 <div class="MarginsDiv">
                                                     <table class="colTable">
                                                        <tr>
                                                            <td align="left" style="color:#666">
                                                                   <asp:Label ID="lblTop"  runat="server" meta:resourcekey="lblTop"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <telerik:RadSlider ID="sldrTop" runat="server" Skin="Default" Width="50px" 
                                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                            </td>
                                                             <td align="center" style="color:#666"> 
                                                                 <span id="lblTopValue">0 px</span>
                                                             </td>
                                                            <td></td>
                                                            </tr>
                                                        <tr>
                                                             <td align="left" style="color:#666">
                                                                  <asp:Label ID="lblBottom" runat="server" meta:resourcekey="lblBottom"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <telerik:RadSlider ID="sldrBottom" runat="server" Skin="Default" Width="50px" 
                                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                               
                                                            </td>
                                                             <td align="center" style="color:#666"> 
                                                                 <span id="lblBottomValue">0 px</span>
                                                             </td>
                                                            </tr>
                                                        <tr>
                                                              <td align="left" style="color:#666">
                                                                  <asp:Label ID="lblLeft" runat="server" meta:resourcekey="lblLeft"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <telerik:RadSlider ID="sldrLeft" runat="server" Skin="Default" Width="50px" 
                                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                             </td>
                                                             <td align="center" style="color:#666"> 
                                                                  <span id="lblLeftValue">0 px</span>
                                                             </td>
                                                            </tr>
                                                        <tr>
                                                             <td align="left" style="color:#666">
                                                                   <asp:Label ID="lblRight" runat="server" meta:resourcekey="lblRight"></asp:Label>
                                                            </td>
                                                            <td align="right">
                                                                <telerik:RadSlider ID="sldrRight" runat="server" Skin="Default" Width="50px" 
                                                                    Value="0" ShowIncreaseHandle="false" ShowDecreaseHandle="false" Orientation="Horizontal" OnClientValueChange="MarginChanged"
                                                                    MinimumValue="0" MaximumValue="30" ToolTip="" />
                                                            </td>
                                                             <td align="center" style="color:#666"> 
                                                                   <span id="lblRightValue">0 px</span>
                                                             </td>
                                                            </tr>
                                                    </table>
                                                     </div>
                                </fieldset>
                                        </div>
                                        <div class="col-4 col-4-right">
                                            <table class="colTable" style="visibility: hidden">
                                                <tr id="trParameters" runat="server">
                                                    <td>
                                                        <asp:Panel ID="pnlParameters" runat="server">
                                                            <fieldset>
                                                                <legend>
                                                                    <asp:Label ID="lblProjectParameters" runat="server" Text="Projects" meta:Resourcekey="lblProjectParameters"></asp:Label>
                                                                </legend>
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="ldpPM">

                                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td style="width: 216px;">
                                                                                <telerik:RadListBox ID="rlbParameterValuesFrom" runat="server" Height="250px" Skin="Default" Width="100%"
                                                                                    SelectionMode="Multiple" AllowTransfer="true" TransferToID="rlbParameterValuesTo" AutoPostBackOnTransfer="true"
                                                                                    AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true">
                                                                                </telerik:RadListBox>
                                                                            </td>
                                                                            <td style="width: 184px;">
                                                                                <telerik:RadListBox ID="rlbParameterValuesTo" runat="server" Height="250px" Skin="Default" Width="100%"
                                                                                    SelectionMode="Multiple" AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true">
                                                                                </telerik:RadListBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>

                                                                </telerik:RadAjaxPanel>
                                                            </fieldset>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table style="width: 99%" cellpadding="5" cellspacing="0">
                                                            <tr>
                                                                <td width="30%">
                                                                    <asp:Panel ID="pnlPreviewButton" runat="server">
                                                                        <asp:Button ID="btnPreview" runat="server" meta:Resourcekey="btnPreview" Style="max-width: 150px;" Text="Preview" OnClientClick="return openReport();" />
                                                                    </asp:Panel>
                                                                </td>
                                                                <td width="40%" style="float: left">
                                                                    <asp:Button ID="btnSave" meta:Resourcekey="btnSave" Style="max-width: 150px;" runat="server" Text="Save" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </div>
                </div>
            </div>
            <div style="display: none;">
                <fieldset style="height: 380px" id="tdQuery">
                    <legend>
                        <asp:Label ID="lblSQL" runat="server" Text="SQL" meta:resourcekey="lblSQL"></asp:Label>
                    </legend>
                    <div style="width: 100%; height: 375px; overflow: auto;">
                        <asp:Label ID="lblSqlQuery" runat="server"></asp:Label>
                    </div>
                </fieldset>
            </div>
            <%--     <div class="PMMainPage JustifyContent">
                <div class="row">
                    <div class="col-4 col-4-left">
                    </div>
                    <div class="col-4 col-4-middle">
                        <table class="colTable" id="Table1">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDistinct" runat="server" meta:resourcekey="chkDistinct"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkDistinct" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDate"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <span runat="server" id="rmd_txtRevisionDate" style="display: block">
                                        <asp:TextBox ID="txtRevisionDate" Enabled="false" runat="server"></asp:TextBox>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCurrency" meta:Resourcekey="lblCurrency" runat="server" Text="Currency"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurrency" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblType" runat="server" meta:resourcekey="lblType" Text="Type"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlQueryTypes" runat="server" Width="100%" Height="300px" Skin="Default"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" AllowCustomText="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-right">
                        <table id="tblRecap" class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblRecordsSelected" runat="server" meta:resourcekey="lblRecordsSelected" Text="Records Selected" Visible="false"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtRecordsSelected" MaxLength="15" runat="server" CssClass="PositiveInteger" ReadOnly="true" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblRecordsNotSelected" runat="server" meta:resourcekey="lblRecordsNotSelected" Text="Records Not Selected" Visible="false"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtRecordsNotSelected" MaxLength="15" runat="server" CssClass="PositiveInteger" ReadOnly="true" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
            </div>--%>
        </telerik:RadPageView>
        <%--<telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive" Style="margin-top: 24px;">
            <uc1:QueryBuilderDetails ID="Qd1" runat="server" />
        </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvViewPrint" runat="server">
            <uc2:QueryBuilderResults ID="QBR" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="false">
            <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc9:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
