<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="DailyReports.aspx.vb" Inherits="Website.DailyReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="DailyReportDetails.ascx" TagName="DailyReportDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="DailyReportTimeSheet.ascx" TagName="DailyReportTimeSheet" TagPrefix="uc2" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc9" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/EngeneeringForms/DailyReport.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.Document.DailyReportInfo.ProjectId %>';
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "GenerateTransmittal") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Generate");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function onClientContextMenuItemClicking(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();
                var tree = $find(treeNode.get_treeView().get_id());
                treeNode.set_selected(true);
                menuItem.get_menu().hide();
                var isGrougSelected = false;
                var isItemSelected = false;
                var nodes = tree.get_selectedNodes();
                switch (menuItem.get_value()) {
                    case "AddChild":
                        treeNode.expand();
                        AddChild(treeNode.get_treeView().get_id());
                        args.set_cancel(true);
                        break;
                    case "Rename":
                        var val = treeNode.get_value();
                        treeNode.startEdit();
                        args.set_cancel(true);
                        break;

                }
            }
            function AddChild(treeId) {
                var nodeText = "";
                var tree = $find(treeId);
                tree.trackChanges();
                var node = new Telerik.Web.UI.RadTreeNode();
                var parent = tree.get_selectedNode() || tree;
                node.set_text(nodeText);
                node.get_attributes().setAttribute("NEWCHILD", "True");
                node.set_value("NEWCHILD");
                parent.get_nodes().add(node);
                if (parent != tree && !parent.get_expanded())
                    parent.set_expanded(true);
                node.set_selected(true);
                window.setTimeout(function () { node.startEdit(); }, 200);
                parent.set_selected(false);
                tree.commitChanges();
                return node;
            }
            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                setMenuItemsState(args.get_menu().get_items(), treeNode);
            }

            function setMenuItemsState(menuItems, treeNode) {
                var tree = $find(treeNode.get_treeView().get_id());
                var nodes = tree.get_selectedNodes();
                if (nodes.length >= 1) {

                    for (var i = 0; i < menuItems.get_count() ; i++) {
                        var menuItem = menuItems.getItem(i);
                        switch (menuItem.get_value()) {
                            case "AddChild":
                                menuItem.set_enabled(false)
                                if (nodes.length == 1) {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                                }
                                break;
                            case "Rename":
                                menuItem.set_enabled(false)
                                if (nodes.length == 1) {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true');
                                }
                                break;
                            case "DELETE":
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true')
                        }
                    }
                }
            }
            function droppedOnGroup(sender, args) {
                var dest = args.get_destNode();
                var nodes = args.get_sourceNodes();
                var target = args.get_htmlElement();
                if (dest) {
                    args.set_cancel(true);
                }
            }
            var gridId = "ctl00_CPH1_DailyReportDetails_rdgOnSite";
            function isMouseOverGrid(target) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id == gridId) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }

                return null;
            }


            function onNodeDragging(sender, args) {
                var target = args.get_htmlElement();

                if (!target) return;

                if (target.tagName == "INPUT") {
                    target.style.cursor = "hand";
                }

                var grid = isMouseOverGrid(target);
                if (grid) {
                    grid.style.cursor = "hand";
                }
            }


            function droppedOnGrid(args) {
                var target = args.get_htmlElement();

                while (target) {
                    if (target.id == gridId) {
                        args.set_htmlElement(target);
                        return;
                    }
                    target = target.parentNode;
                }
                args.set_cancel(true);
            }


            function onNodeDropping(sender, args) {
                if (droppedOnGrid(args)) return;
            }

            function AddFirstNode(sender, args) {
                switch (args.get_item().get_value()) {
                    case "AddRootNode":
                        var tree = $find($("[id$=rdvLocations]")[0].id);
                        tree.trackChanges();
                        var node = new Telerik.Web.UI.RadTreeNode();
                        node.set_text("");
                        node.set_value("FIRSTNODE")
                        node.get_attributes().setAttribute("FIRSTNODE", "True")
                        tree.get_nodes().add(node);
                        tree.commitChanges();
                        node.set_selected(true);
                        window.setTimeout(function () { node.startEdit(); }, 200);
                        tree.commitChanges();
                        return node
                        break;
                    case "DELETE":
                        var IsConfirm = confirm("Deleting all nodes cannot be undone are you sure do you want to continue?");
                        if (IsConfirm) {
                            args.get_item().set_postBack(true);
                        }
                        break;
                }
            }
            function OnClientNodeEditStartHandler(sender, eventArgs) {
                var node = eventArgs.get_node();
                var textInput = node.get_inputElement();
                textInput.maxLength = 255;
            }
            function rdvLocations_OnClientNodeEditing(sender, args) {
                if (args.get_newText() == '') {
                    var treeNode = args.get_node();
                    if (isNaN(treeNode.get_value())) {
                        sender.trackChanges();
                        treeNode.get_parent().get_nodes().remove(treeNode);
                        sender.commitChanges();
                    }
                    args.set_cancel(true);
                }
            }
            function GoToDocument(sender, eventArgs) {
                window.location = eventArgs.getDataKeyValue("Url");
            }
            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Document.DailyReportInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Document.DailyReportInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Document.DailyReportInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Document.DailyReportInfo.Description)%>';
                var Id = '<%= PM.Document.DailyReportInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("DAILYREPORT") %>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=DAILYREPORT&Id=" +
                                '<%= PM.Document.DailyReportInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.DailyReportInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=DAILYREPORT&Id=" +
                               '<%= PM.Document.DailyReportInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Document.DailyReportInfo.ProjectId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=DAILYREPORT&Id=" +
                                '<%= PM.Document.DailyReportInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.DailyReportInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=DAILYREPORT&Id=" + Id
                            + "&EntityId=" + '<%=PM.Document.DailyReportInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'New':
                        window.location = "DailyReports.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function ToggleAssetMenu() {
                var tdAssetMenu = $('[id$=tdAssetMenu]')[0];
                var tdAssetExplorerBar = $('[id$=tdAssetExplorerBar]')[0];
                var form = $('form')[0]
                var btnToggleAssetMenu = $('[id$=btnToggle]')[0];
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    tdAssetExplorerBar.style.left = "285px";
                    tdAssetExplorerBar.className = 'AssetExplorerBar MobileFormsExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                } else {
                    tdAssetMenu.style.display = 'none';
                    tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.className = 'AssetExplorerBar MobileAssetExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                }
                return false;
            }

            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() === "ToggleSplitter") {
                    var pane = $find("ctl00_CPH1_DailyReportDetails_treeGroupsAndItemsPane");
                    pane.set_visible(false);
                }
            }
            function MaintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                if (value === "ToggleSplitter") {
                    var pane = $find("ctl00_CPH1_DailyReportDetails_treeGroupsAndItemsPane");
                    pane.set_visible(true);
                    var paneContent = pane._contentElement;
                    paneContent.style.display = "block";
                }
            }
            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 10);
            }


            function fixSplitterSize(isRail) {
                if (mainsplitter == null) return;
                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }


            }
            var mainsplitter = null;
            function onResized(sender, ags) {
                mainsplitter = $find(sender._element.id);
                var pane = mainsplitter._panes[0];
                if (getCookie('DailyReportStatus') === 'none') {
                    $("#ctl00_CPH1_DailyReportDetails_Splitter").addClass("removeLeft");
                    pane.set_visible(false);
                }
                else {
                    $("#ctl00_CPH1_DailyReportDetails_Splitter").removeClass("removeLeft");
                    pane.set_visible(true);
                }
            }
            function OnClientCollapsed(sender, ags) {
                var pane = mainsplitter._panes[0];
                $("#ctl00_CPH1_DailyReportDetails_Splitter").addClass("removeLeft");
                pane.set_visible(false);
                setTimeout(FloatDivs, 100);
                setCookie('DailyReportStatus', 'none', 60);
                ClientResized(sender, ags);
            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_DailyReportDetails_Splitter").removeClass("removeLeft");
                setCookie('DailyReportStatus', 'inline', 60);
                var pane = mainsplitter._panes[0];
                pane.set_visible(true);
                ClientResized(sender, ags);
            }

            function OpenLinkedRecordsPopup() {                
                var Description = '<%=JSEscape(PM.Document.DailyReportInfo.Description)%>';
                var Id = '<%= PM.Document.DailyReportInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkedRecordsPopup.aspx?ObjectType=DAILYREPORT&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkedRecordsPopup);
                return false;
            }

            function CloseLinkedRecordsPopup() {
                var btnRefreshLinkedRecords = $("[id$=btnRefreshLinkedRecords]");
                if (btnRefreshLinkedRecords) {
                    btnRefreshLinkedRecords.click();
                }
            }

            function OpenTransmittalsPopup() {
                var Description = '<%=JSEscape(PM.Document.DailyReportInfo.Description)%>';
                var Id = '<%= PM.Document.DailyReportInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('TransmittalsPopup.aspx?ObjectType=DAILYREPORT&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseTransmittalsPopup);
                return false;
            }

            function CloseTransmittalsPopup() {
                var btnRefreshTransmittals = $("[id$=btnRefreshTransmittals]");
                if (btnRefreshTransmittals) {
                    btnRefreshTransmittals.click();
                }
            }
        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
              <telerik:AjaxSetting AjaxControlID="mlpDailyReport">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpDailyReport" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpDailyReport" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=139">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                            <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                            <telerik:RadComboBox ID="ddlDailyReports" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                Width="240px" AutoPostBack="false" NoWrap="true" CausesValidation="False"
                                Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                            </telerik:RadComboBox>
                        </td>
                        <td style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                <Items>
                                    <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=139" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="New" PostBack="false" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="New" SecurityButtonType="Add">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="Copy" SecurityButtonType="Copy">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                                        Value="Delete">
                                    </telerik:RadToolBarButton>
                                    <%--<telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                    </telerik:RadToolBarButton>--%>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                                        EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate"
                                        ImageUrl="Images/ToolBar/Generate.png" EnableDefaultButton="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton Text="Transmittal" Value="Generate" CommandName="GenerateTransmittal"
                                                ImageUrl="Images/ToolBar/PMWebW.gif">
                                            </telerik:RadToolBarButton>
                                            <%--<telerik:RadToolBarButton PostBack="True" Text="" Value="Empty" CommandName="Empty">
                                            </telerik:RadToolBarButton>--%>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewTemplates"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Transmittal" Value="GenerateTransmittal"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('DAILYREPORT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
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
            </td>
        </tr>
        <%--   <tr>
            <td>
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM">
                    <table id="tblDailyReportInfo" style="width: 100% !important;" cellspacing="0"
                        class="Padding7">
                        <tr valign="top">
                            <td valign="top">
                                <span class="Padding7"></span>
                            </td>
                            <td colspan="2"></td>
                        </tr>
                        <tr valign="top">
                            <td valign="top" style="width: 400px">
                                <table style="width: 100%;" cellspacing="0" cellpadding="2">
                                </table>
                            </td>
                            <td valign="top" style="width: 320px">
                                <table style="width: 300px;" cellspacing="0" cellpadding="2">

                                    <tr>
                                        <td runat="server" id="tdNewTimesheet">
                                            <asp:Button ID="btnNewTimesheet" runat="server" OnClientClick="DisablePanelAjax()"
                                                meta:resourcekey="btnNewTimesheet" Text="New Timesheet" />
                                        </td>
                                        <td runat="server" id="tdNewProduction">
                                            <asp:Button ID="btnNewProduction" runat="server" OnClientClick="DisablePanelAjax()"
                                                meta:resourcekey="btnNewProduction" Text="New Production" />
                                        </td>
                                    </tr>
                                </table>
                            </td>

                            <td valign="top" style="padding-left: 20px">
                                <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td></td>
        </tr>--%>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpDailyReport" Skin="Default"
        Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>

            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="On Site" Value="OnSite" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
            <telerik:RadTab Text="Timesheet" Value="Timesheet"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpDailyReport" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="true" Skin="Default"
                                            NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvProject"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfvProject">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" AutoPostBack="true" NoWrap="True" AllowCustomText="True"
                                            DropDownWidth="240px" CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPhaseName" runat="server" ControlToValidate="ddlPhase"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPhaseName" runat="server" ControlToValidate="ddlPhase"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblWBS" Text="<%$ Resources:ProjectManagement, Label_WBS %>"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" AutoPostBack="false"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                            NoWrap="True" AllowCustomText="true"
                                            OnClientDropDownClosed="dllcompClientClosed1"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvWBS" runat="server" ControlToValidate="ddlWBS"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvWBS" runat="server" ControlToValidate="ddlWBS"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportDate" meta:resourcekey="lblReportDate" runat="server" Text="Report Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpReportDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpReportDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput5" Skin="Default" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvReportDate" runat="server" ControlToValidate="dtpReportDate"
                                            CssClass="Validator" meta:resourcekey="rfvReportDates"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" runat="server" Text="Record #*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                            CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvCodes"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCommIDUnique" runat="server" meta:Resourcekey="lblCommIDUniques"
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblSubmittedBy" runat="server" meta:ResourceKey="lblSubmittedBy" Text="Submitted By"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgfilter"
                                                OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlSubmittedBy'),'Contacts')"
                                                CssClass="SearchButton">
                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSubmittedBy" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 60%">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 40%;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 60%;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 40%;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvSubmittedBy" runat="server" ControlToValidate="ddlSubmittedBy"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvSubmittedBy" runat="server" ControlToValidate="ddlSubmittedBy"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lblPostNonComitment" Style="color: #666666; height: 24px; line-height: 24px;" runat="server" meta:ResourceKey="chkPostNonCommitment" Text="Post to Non-commitment Costs"></asp:Label>
                                        <div style="float: right;">
                                            <asp:CheckBox ID="chkPostNonCommitment" runat="server" CssClass="mobile-switch" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status / Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" runat="server" Width="100%" MaxLength="9"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevisionNumber"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" meta:Resourcekey="lblDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_txtRevisionDate">
                                            <telerik:RadDatePicker ID="txtRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblLinkedRecords" meta:resourcekey="LblLinkedRecords" runat="server" Text="Linked Records"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedRecords" OnClientClick="return OpenLinkedRecordsPopup();">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshLinkedRecords" runat="server" class="Hide"></asp:Button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtLinkedRecords" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr> 
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblTransmittals" meta:resourcekey="LblTransmittals" runat="server" Text="Transmittals"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtTransmittals" OnClientClick="return OpenTransmittalsPopup();">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshTransmittals" runat="server" class="Hide"></asp:Button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtTransmittals" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <fieldset runat="server" id="fsWeather">
                                            <legend>
                                                <asp:Label ID="lblWeather" meta:resourcekey="lblWeather" runat="server" Text="Weather" CssClass="legend"></asp:Label>
                                            </legend>
                                        </fieldset>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblConditions" meta:resourcekey="lblConditions" runat="server" Text="Conditions"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlConditions" Height="250px" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                        AllowCustomText="True" Skin="Default">
                                                        <ItemTemplate>
                                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                <asp:CheckBox runat="server" ID="chkApply" CssClass="mobile-switch" />
                                                                <asp:Label runat="server" ID="Label1" AssociatedControlID="chkApply"></asp:Label>
                                                                <%--      <%#Eval("Condition")%>--%>
                                                            </div>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvConditions" runat="server" ControlToValidate="ddlConditions"
                                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvConditions" runat="server" ControlToValidate="ddlConditions"
                                                        ClientValidationFunction="ValidateComboWithMultipleSelection" ValidationGroup="Save" Display="Dynamic"
                                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblTemperature" meta:resourcekey="lblTemperature" runat="server" Text="Temperature"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td style="width: 50%">
                                                                <asp:TextBox ID="txtTemperature" runat="server" CssClass="Double" Width="98%" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvTemperature" ControlToValidate="txtTemperature"
                                                                    runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                            <td style="width: 50%; padding-left: 20px">
                                                                <asp:RadioButtonList ID="rblFrequency" AutoPostBack="False" CssClass="RadioCss RadioPadding" runat="server" RepeatLayout="Table" RepeatColumns="2" RepeatDirection="Horizontal" Width="100%">
                                                                    <asp:ListItem Selected="True" Text="F" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="C" Value="1"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblPrecip" meta:resourcekey="lblPrecip" runat="server" Text="Precip. Amount"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td style="width: 118px">
                                                                <asp:TextBox ID="txtPrecip" runat="server" CssClass="Double" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvPrecipAmount" ControlToValidate="txtPrecip"
                                                                    runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td style="width: 118px; padding-left: 4px">
                                                                <telerik:RadComboBox ID="ddlUOM" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains"></telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="rfvUOM" ControlToValidate="ddlUOM"
                                                                    runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                                </asp:RequiredFieldValidator>
                                                                <asp:CustomValidator ID="csvUOM" runat="server" ControlToValidate="ddlUOM"
                                                                    ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                                    CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                                </asp:CustomValidator>
                                                                <%--<asp:CompareValidator ID="cmvUOM" runat="server" Visible="false" 
                                                                                    ControlToValidate="ddlUOM" CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                                                    ForeColor="" Operator="GreaterThan" ValidationGroup="Save" ValueToCompare="0"></asp:CompareValidator>--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server" id="trNewButtons">
                                    <td></td>
                                    <td>
                                        <table cellspacing="0" cellpadding="0" border="0" style="width: 100%;">
                                            <tr>
                                                <td  style="width: 50%; padding-left: 2px; padding-right: 2px;">
                                                    <asp:Button ID="btnNewTimesheet" runat="server" OnClientClick="DisablePanelAjax()"
                                                        meta:resourcekey="btnNewTimesheet" Text="New Timesheet" />
                                                </td>
                                                <td style="width: 50%; padding-left: 2px; padding-right: 2px">
                                                    <asp:Button ID="btnNewProduction" runat="server" OnClientClick="DisablePanelAjax()"
                                                        meta:resourcekey="btnNewProduction" Text="New Production" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">

                            <fieldset runat="server" id="fsIncidents">
                                <legend>
                                    <asp:Label ID="lblIncidents" runat="server" meta:resourcekey="lblIncidents" Text="Incidents" CssClass="legend"></asp:Label></legend>
                                <telerik:RadGrid ID="rdgIncidents" AllowMultiRowSelection="true" runat="server" AllowMultiRowEdit="false" CssClass="LightWeight"
                                    HeaderStyle-Font-Size="8" SetWidth="true" AppendMenus="true" FitParentContainer="true" UseEditFormInMobile="true"
                                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="10"
                                    AllowPaging="True" ShowFooter="false">
                                    <PagerStyle Mode="NextPrevAndNumeric" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                        InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Type" SortExpression="Type" UniqueName="Type">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Type") = String.Empty, "&nbsp;", Container.DataItem("Type"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox ID="ddlType" runat="server" Width="100%">
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="100px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Company/Contact" HeaderStyle-Width="250px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" SortExpression="AssignedTo"
                                                Reorderable="true" UniqueName="CompanyContact">
                                                <ItemTemplate>
                                                    <span><%#Container.DataItem("AssignedTo")%></span> &nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div style="white-space: nowrap">
                                                        <telerik:RadComboBox ID="ddlAssignTo" runat="server" Filter="Contains" MarkFirstMatch="True" Width="80%" DropDownWidth="300px"
                                                            Skin="Default" AutoPostBack="False" NoWrap="True" AllowCustomText="True" OnClientDropDownClosed="onSelectedIndexChanging"
                                                            CausesValidation="False" Height="250px" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                            OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                        </telerik:RadComboBox>
                                                        <asp:LinkButton runat="server" ID="imgfilter" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlAssignTo'),'Contacts')"
                                                            CssClass="SearchButton">
                                                                                                            <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                                    </div>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                <ItemStyle Wrap="false" HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" ItemStyle-Wrap="false"
                                                HeaderStyle-Width="98px" SortExpression="Notes">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%> </span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtNote" MaxLength="4000" runat="server" Text='<%# Eval("Notes") %>' Width="80%"></asp:TextBox>
                                                    <asp:LinkButton runat="server" ID="imgNotesIncidents" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotesIncidents','txtNote'))"
                                                        CssClass="SearchButton">
                                                                                                        <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <FooterStyle CssClass="GridFooter" />
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                &nbsp;&nbsp;
                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                                                    SecurityButtonType="ItemMode_Edit"
                                                                                    Visible='<%# rdgIncidents.EditIndexes.Count = 0 And (Not rdgIncidents.MasterTableView.IsItemInserted) %>'
                                                                                    meta:resourcekey="btnEditSelectedResource1">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label ID="Label1" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton2" runat="server" ValidationGroup="WorkOrder" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                    SecurityButtonType="AddEditMode_Edit"
                                                    Visible='<%# rdgIncidents.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label2" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton3" runat="server" ValidationGroup="WorkOrder" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                    SecurityButtonType="AddEditMode_Add"
                                                    Visible='<%# rdgIncidents.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label3" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                    SecurityButtonType="AddEditMode"
                                                    Visible='<%# rdgIncidents.EditIndexes.Count > 0 Or rdgIncidents.MasterTableView.IsItemInserted %>'
                                                    meta:resourcekey="btnCancelResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label4" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                    SecurityButtonType="ItemMode_Add"
                                                    Visible='<%# rdgIncidents.EditIndexes.Count = 0 And (Not rdgIncidents.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnAddResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label5" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton6" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgIncidents.EditIndexes.Count = 0 And (Not rdgIncidents.MasterTableView.IsItemInserted) %>'
                                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label6" runat="server" Text="Delete selected lines"
                                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton7" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                    SecurityButtonType="ItemMode"
                                                    Visible='<%# rdgIncidents.EditIndexes.Count = 0 And (Not rdgIncidents.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnRefreshResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label7" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings Resizing-AllowColumnResize="true">
                                        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True"></Resizing>
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:DailyReportDetails ID="DailyReportDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvTimeSheet" runat="server">
            <uc2:DailyReportTimeSheet ID="DailyReportTimeSheet1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc9:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc10:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc3:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
