<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="EmailHome.aspx.vb" Inherits="Website.EmailHome" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EmailSend.ascx" TagName="EmailSend" TagPrefix="uc1" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgEmails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgEmails" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mainToolBar">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="treeEmails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="hdnProjectId" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="hdnPropertyId" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnShowEmail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EmailDetailsFrame" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearchEmails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnReply">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlPropertiesAndProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnGetProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
         <link href="CSS/EmailHome.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            /* <![CDATA[ */
            var toolbar;
            var grid;
            var searchButton;
            var gridId;
            var MobileReplyButton;
            var rowCheckColClicked;
            var forceMoreMenuToClose = true;
            function DisableAttachmentLinkPostBack() {
                return false;
            }
            function pageLoad() {
                gridId = '<%=rdgEmails.ClientID %>';
                grid = $find("<%=rdgEmails.ClientID %>");

                $("[id$='chkProject']").change(function () { SetDirty_ddlProjects(); });

                $("table[id$=rdgEmails_ctl00].rgMasterTable").find("tr>td:nth-child(1)").click(function () {
                    rowCheckColClicked = true;
                });

                appendCheckboxAll();
                toolbar = $find("<%= mainToolBar.ClientID%>");
                if (!toolbar) return;
                ReplyButton = toolbar.findButtonByCommandName("EmailReply");
                MobileReplyButton = toolbar.findButtonByCommandName("MobileMenu").findControl("MobileRadmen").findItemByValue("EmailReply");


                if (grid) {
                    if (grid.get_masterTableView().get_selectedItems().length == 0) {
                        if (ReplyButton) {
                            ReplyButton.disable();
                            MobileReplyButton.disable();
                        }
                    }
                    searchButton = toolbar.findButtonByCommandName("doSearch");

                    $telerik.$(".inbox-search-textbox")
                    .bind("keypress", function (e) {
                        // searchButton.set_imageUrl("images/Email/search.gif");
                        searchButton.set_value("search");
                    });
                }
            }


            function NodeChecked(sender, eventArgs) {
                SetDirty_ddlProjects();
                var combo = $find("ctl00_CPH1_ddlPropertiesAndProjects");
                var node = eventArgs.get_node();
                var checked = node.get_checked();
                var childNodes = node.get_nodes();
                if (checked == true) {
                    CheckParent(node);
                    UncheckAllChildren(childNodes);
                    //               UncheckAllParent(node);
                    var tree = $find(node.get_treeView().get_id());
                    if (node.get_value() == "-1") {
                        var allCheckedNodes = tree.get_checkedNodes();
                        var TotalChecked = allCheckedNodes.length
                        for (var i = TotalChecked - 1; i >= 0 ; i--) {

                            var CkeckedNode = allCheckedNodes[i];
                            if (CkeckedNode != null) {
                                if (CkeckedNode.get_value() != "-1") {
                                    CkeckedNode.set_checked(false);

                                }
                            }
                        }

                    }
                    else {
                        var AllNode = tree.findNodeByValue("-1");
                        if (AllNode != null)
                            AllNode.set_checked(false);
                    }
                    var selectedCount = tree.get_checkedNodes()
                    if (selectedCount.length == 1) {

                        var SelectedNode = tree.get_checkedNodes()[0];
                        combo.set_text(SelectedNode.get_text());


                    }
                    else if (selectedCount.length > 1) {

                        combo.set_text($("input[id$=ctl00_CPH1_hdnPropertyAndProjectSelectedMsg]").val());
                    }
                    else
                        combo.set_text("");

                    return;
                }

                var rdvtree = $find(node.get_treeView().get_id());
                var AllCheckedCount = rdvtree.get_checkedNodes().length;
                if (AllCheckedCount == 0) {
                    combo.set_text("");

                }

            }

            function OnHorizontalClientExpanded(sender, ags) {
                //$("#RAD_SPLITTER_ctl00_CPH1_DMHorizontalSplitter").removeClass("MarginTop");
                var maindiv = $("#ctl00_CPH1_maindiv");
                if (maindiv.hasClass("DMIframe"))
                    detailpane.set_height(document.documentElement.clientHeight - headerPane.get_height() - 20);
                else
                    detailpane.set_height(document.documentElement.clientHeight - headerPane.get_height() - 80);
                onDetailPaneClientResized(sender, ags);
            }

            function OnHorizontalClientCollapsed(sender, ags) {
                //  $("#RAD_SPLITTER_ctl00_CPH1_DMHorizontalSplitter").addClass("MarginTop");
                var maindiv = $("#ctl00_CPH1_maindiv");
                if (maindiv.hasClass("DMIframe"))
                    detailpane.set_height(document.documentElement.clientHeight - 20);
                else
                    detailpane.set_height(document.documentElement.clientHeight - 80);

            }

            function UncheckAllParent(node) {

                node = node.get_parent();
                while (node != null && node._element.id.toString().indexOf("ctl00_CPH1_ddlPropertiesAndProjects") == -1) {
                    node.set_checked(false);
                    node = node.get_parent();
                }
            }
            function UncheckAllChildren(nodes) {
                var i;
                for (i = 0; i < nodes.get_count() ; i++) {
                    nodes.getNode(i).set_checked(false);

                    if (nodes.getNode(i).get_nodes().get_count() > 0)
                        UncheckAllChildren(nodes.getNode(i).get_nodes());
                }

            }
            function CheckParent(node) {
                node = node.get_parent();
                while (node != null && node._element.id.toString().indexOf("ctl00_CPH1_ddlPropertiesAndProjects") == -1) {
                    node.set_checked(true);
                    node = node.get_parent();
                }
            }
            /* ]]> */

            function OpenNotificationMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
                var left = (screen.width - 920) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;


                OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source, '', 850, 460, true)
              
                return false;
            }
            <%--function ToggleAssetMenu() {
                var tdAssetMenu = document.getElementById('<%=tdAssetMenu.ClientID %>');
                var tdAssetExplorerBar = document.getElementById('<%=tdAssetExplorerBar.ClientID %>')
                var form = $('form')[0]
                var btnToggleAssetMenu = document.getElementById('<%=btnToggle.ClientID%>');
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    //tdAssetExplorerBar.style.left = "290px";
                    tdAssetExplorerBar.className = 'AssetExplorerBar MobileAssetExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'inline', 60);
                    form.className = form.className + ' AssetExplorerVisible';
                    ResizeAllGrids();
                } else {
                    tdAssetMenu.style.display = 'none';
                    //tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.className = 'AssetExplorerBar MobileAssetExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'none', 60);
                    form.className = form.className.replace(' AssetExplorerVisible', '');
                    ResizeAllGrids();
                }
                return false;
            }--%>
            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "ReceiveEmail") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("ReceiveEmail");
                    button.click();
                }
                if (args.get_item().get_value() == "EmailReply") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findButtonByCommandName("EmailReply");
                    button.click();
                }
                if (args.get_item().get_value() == "SaveLayout") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("SaveLayout");
                    button.click();
                }
                if (args.get_item().get_value() == "LoadDefaultState") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("LoadDefaultState");
                    button.click();
                }
                //maintoolbarClick(args.get_item().get_value())
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
            var mainsplitter = null;
            function onResized(sender, ags) {
                mainsplitter = sender;

            }
            function OnClientCollapsed(sender, ags) {
                $("#ctl00_CPH1_Splitter").addClass("removeLeft");
                var drawer = $('form')[0]
                var israil = false;
                if (drawer.className.indexOf("rail") >= 0)
                    israil = true;
                fixSplitterSize(israil)
                if (document.documentElement.clientWidth <= 843) {
                    var pane = $find("ctl00_CPH1_DetailPane");
                    pane.set_width(pane.get_width() - 1);
                }
            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_Splitter").removeClass("removeLeft");
                var drawer = $('form')[0]
                var israil = false;
                if (drawer.className.indexOf("rail") >= 0)
                    israil = true;
                fixSplitterSize(israil);
                if (document.documentElement.clientWidth <= 843) {
                    var pane = $find("ctl00_CPH1_DetailPane");
                    pane.set_width(pane.get_width() - 1);
                }
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
                    sender.set_width(browserWidth - 2);

                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 1
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }


            }
            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
            }

            function onDetailPaneClientResized(sender, ags) {
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Tr = pane1._element;
                pane2.set_height(splitter._element.clientHeight - pane1Tr.clientHeight - 8);
            }
            function onClientResized(sender, ags) {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 20
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
                OpenRecentDocumentsPopup('');
            }

            function OnClientLoad(sender, args) {
                detailpane = sender._panes[1];
                headerPane = sender._panes[0];
                horizantalpane = sender;
                setTimeout(function () {
                    var browserHeight = $telerik.$(window).height();

                    var maindiv = $("#ctl00_CPH1_maindiv");
                    if (maindiv.hasClass("DMIframe")) {
                        sender._panes[0].set_height((document.documentElement.clientHeight / 2) - 20);
                        sender._panes[1].set_height((document.documentElement.clientHeight / 2) - 20);
                    }
                    else {
                        sender._panes[0].set_height((document.documentElement.clientHeight / 2) - 60);
                        sender._panes[1].set_height((document.documentElement.clientHeight / 2) - 60);
                    }
                    //setTimeout(function () {}, 400);
                }, 500);

                return false;
            }
        </script>
        <script type="text/javascript" src="JS/Email/EmailHome.js"></script>
        <style type="text/css">
            .reToolbarWrapper ul:nth-child(3){display:none;}
            .TreeHeight {
                height: 100%;
                background-color: #666666;
                color: #ffffff;
            }

            .removeLeft {
                left: 0 !important;
            }

            .EmailVerticalSplitter, .TreeSplitterPane, .EmailPreviewPane {
                height: calc(100vh - 110px) !important;
            }

            @media screen and (min-width:320px) and (max-width:843px) {
                .ToolBar {
                    margin-top: 0px !important;
                }

                .DMSplitterPane {
                    margin-top: 50px;
                    position: fixed;
                    width: 60vw !important;
                    background: white;
                    top: 0;
                    height: 100% !important;
                    z-index: 2000;
                    border: 1px solid #999;
                }

                .TreeSplitterPane {
                    position: fixed;
                    width: 60vw !important;
                    background: white;
                    top: 0;
                    height: 100% !important;
                    z-index: 3000;
                    border: 1px solid #999;
                    height: calc(100vh - 38px) !important;
                }

                .EmailPreviewPane {
                    height: calc(100vh - 40px) !important;
                    margin-top: 37px !important;
                }

                .TreeHeight {
                    height: 100% !important;
                    background-color: #666666;
                    color: #ffffff;
                }

                .MarginTopOnMobileEmail {
                    margin-top: 12px;
                }

                .DMSplitter, .AssetSplitter {
                    height: calc(100vh - 38px) !important;
                }
            }

            @media screen and (max-width:550px) {
                .WidthOnMobile {
                    width: 80px !important;
                }

                span#ctl00_CPH1_mainToolBar_i8_txtSearchInbox_wrapper {
                    width: 80px !important;
                }
            }

            @media screen and (min-width:320px) and (max-width:1243px) {
                .searchTextBoxHideOnMobileToolbar {
                    display: none !important;
                }
            }

            #ctl00_CPH1_RadSplitter1 {
                width: 100% !important;
            }


            .RadSplitter.RadSplitter_Default {
                width: 100%;
            }

            #RAD_SPLITTER_ctl00_CPH1_RadSplitter1 {
                height: calc(100vh - 111px) !important;
            }

            #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane,
            #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_RadContentPane {
                height: 100% !important;
            }



            @media screen and (max-width: 843px) and (min-width: 320px) {

                .DMVerticalSplitter {
                    height: calc(100vh - 80px) !important;
                    margin-top: 50px;
                }


                #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_RadContentPane, .DMHorizontalSplitter, .DMSplitterPane {
                    height: calc(100vh - 85px) !important;
                }

                #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_DMHeaderPane, #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_RadContentPane {
                    width: calc(100vw - 3px) !important;
                }


                .DMHorizontalSplitter {
                    width: 100% !important;
                    height: 100% !important;
                }
            }

            @media screen and (min-width:844px) {
                .DMHorizontalSplitter, #RAD_SPLITTER_ctl00_CPH1_DMHorizontalSplitter {
                    height: 100% !important;
                    width: 100% !important;
                }

                .DMVerticalSplitter {
                    height: calc(100vh - 110px) !important;
                    margin-top: 80px;
                }
            }
        </style>
    </telerik:RadScriptBlock>
    <table class="ToolBar SmallToolbar" style="width: 100%; height: 50px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlPropertiesAndProjects" runat="server" Skin="Default" AllowCustomText="True"
                    Width="240px" CloseDropDownOnBlur="true" OnClientDropDownClosing="OnClientDropDownClosing_ddlProjects" DropDownCssClass="ddlTreeviewTemplate">
                    <Items>
                        <telerik:RadComboBoxItem Text="" />
                    </Items>
                    <ItemTemplate>
                        <telerik:RadTreeView ID="rdvPropertiesAndProjects" Skin="Default" runat="server" CheckBoxes="true" Height="250px"
                            MultipleSelect="false" ShowLineImages="false" OnClientNodeChecked="NodeChecked" OnNodeExpand="rdvPropertiesAndProjects_NodeExpand">
                            <NodeTemplate>
                                <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                            </NodeTemplate>
                        </telerik:RadTreeView>
                    </ItemTemplate>
                </telerik:RadComboBox>
                <asp:Button ID="btnGetProjects" class="Hide" runat="server" Text="Go" />
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar runat="server" ID="mainToolBar" CssClass="inbox-search-toolbar" EnableImageSprites="true"
                    Width="100%" Skin="Default" OnClientButtonClicked="onToolbarClicked" EnableViewState="false">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton CssClass="ToolbarRefresh" CommandName="Refresh"
                            ToolTip="Refresh" Enabled="True" />
                        <telerik:RadToolBarButton SecurityButtonType="Add" CssClass="ToolbarNewEmail"
                            CommandName="NewEmail" meta:resourcekey="ToolBar_NewEmail" ToolTip="New Email" PostBack="false" Enabled="True" />

                        <telerik:RadToolBarButton SecurityButtonType="Delete" CssClass="ToolbarDelete"
                            CommandName="Delete" ToolTip="Delete" Enabled="True" />

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CssClass="ToolbarReceiveEmail"
                            ToolTip="Receive Emails" CommandName="ReceiveEmail" Value="ReceiveEmail" OuterCssClass="HideOnMobileToolbar" />

                        <telerik:RadToolBarButton Text="Reply" SecurityButtonType="Add" PostBack="false"
                            EnableImageSprite="true" CssClass="ToolbarEmailReply" CommandName="EmailReply" ToolTip="Reply" OuterCssClass="HideOnMobileToolbar" />

                        <telerik:RadToolBarSplitButton CssClass="ToolbarLayout" CommandName="Layout" PostBack="false" EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="True" CommandName="SaveLayout" Value="SaveLayout" CssClass="ToolbarUser"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="True" CommandName="LoadDefaultState" Value="LoadDefaultState" CssClass="ToolbarDelegate"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton Value="searchTextBoxButton" PostBack="false" CommandName="searchText" CssClass="searchTextBoxHideOnMobileToolbar">
                            <ItemTemplate>
                                <telerik:RadTextBox runat="server" ID="txtSearchInbox" EmptyMessage="Search Inbox" meta:resourcekey="txtSearchInbox"
                                    CssClass="inbox-search-textbox WidthOnMobile" Width="300px" ClientEvents-OnKeyPress="onKeyPress" />
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton CssClass="ToolbardoSearch searchTextBoxHideOnMobileToolbar" PostBack="false" Value="search" CommandName="doSearch" />

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Receive" Value="ReceiveEmail" CssClass="ReceiveEmail" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Reply" Value="EmailReply" CssClass="EmailReply" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Layout" Value="Layout" CssClass="Layout" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Save Layout" Value="SaveLayout"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Load Default State" Value="LoadDefaultState"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
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
    <div id="maindiv" runat="server">
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="DMVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" CssClass="NormalWhiteBack DMSplitterPane" Style="position: fixed; background: white; top: 0;"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" MaxWidth="400" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded">
                <telerik:RadTreeView runat="Server" ID="treeEmails" OnNodeClick="treeEmails_NodeClick" EnableViewState="true" Width="100%"
                    CssClass="WhitePlusMinus TreeHeight">
                    <NodeTemplate>
                        <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                    </NodeTemplate>
                </telerik:RadTreeView>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="DMSplitter" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" OnClientResized="onClientResized">


                <telerik:RadSplitter ID="DMHorizontalSplitter" runat="server" Orientation="Horizontal" Width="100%" CssClass="DMHorizontalSplitter" OnClientLoad="OnClientLoad">
                    <telerik:RadPane ID="DMHeaderPane" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="DMHeaderPane"
                        OnClientExpanded="OnHorizontalClientExpanded" OnClientCollapsed="OnHorizontalClientCollapsed">
                        <div runat="server" id="divEmailsView">

                            <telerik:RadGrid runat="server" ID="rdgEmails" AutoGenerateColumns="false" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                BorderWidth="0" AllowMultiRowSelection="false"
                                AllowSorting="true" Style="outline: none;" PagerStyle-Visible="false" ShowGroupPanel="true" AllowPaging="True" PageSize="50" Width="100%">

                                <MasterTableView TableLayout="Fixed" EnableHeaderContextMenu="true" GroupLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="" UniqueName="CheckEmail" Groupable="false" HeaderStyle-CssClass="tdchkHeader">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelected" runat="server" CssClass="ChkEmail" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="35px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn UniqueName="Name" DataField="Name" HeaderText="Project/Location Name" GroupByExpression="Name [GridColumn_Name] Group By Name ASC"
                                            SortExpression="Name">
                                            <ItemTemplate>
                                                <span>
                                                    <%# Container.DataItem("Name")%>&nbsp;</span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="To" UniqueName="EmailTo" SortExpression="EmailTo" DataField="EmailTo"
                                            GroupByExpression="EmailTo [GridColumn_EmailTo] Group By EmailTo ASC">
                                            <ItemTemplate>
                                                <span>
                                                    <%#Container.DataItem("EmailTo")%>&nbsp;</span>
                                            </ItemTemplate>

                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="From" UniqueName="EmailFrom" SortExpression="EmailFrom"
                                            GroupByExpression="EmailFrom [GridColumn_EmailFrom] Group By EmailFrom ASC" DataField="EmailFrom">
                                            <ItemTemplate>
                                                <span>
                                                    <%#Container.DataItem("EmailFrom")%>&nbsp;</span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="Subject" UniqueName="Subject" SortExpression="Subject" HeaderText="Subject"
                                            GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC">
                                            <ItemTemplate>
                                                <span>
                                                    <%#Container.DataItem("Subject")%>&nbsp;</span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Date" SortExpression="DeliveryDate" UniqueName="DeliveryDate" DataField="DeliveryDate"
                                            GroupByExpression="DeliveryDate [GridColumn_DeliveryDate]  GROUP BY DeliveryDate">
                                            <ItemTemplate>
                                                <span>
                                                    <%#FormatDate(CDate(Container.DataItem("DeliveryDate")))%>&nbsp;</span>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="" UniqueName="AttachmentColumn" Groupable="false">
                                            <HeaderTemplate>
                                                <div class="AttachmentButton">
                                                    <span class="Icon"></span>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="attachment"
                                                    runat="server" Visible='<%# CBool(CInt(Eval("AttachmentsCount")) > 0) %>'
                                                    class="AttachmentButton" OnClientClick="return DisableAttachmentLinkPostBack();">
                                                  <span class="Icon"></span>
                                                </asp:LinkButton>
                                                &nbsp;
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif" CancelImageUrl="Cancel.gif"></EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                                    <Scrolling AllowScroll="true" EnableVirtualScrollPaging="True" UseStaticHeaders="true" />
                                    <Selecting AllowRowSelect="True"></Selecting>
                                    <ClientEvents OnRowSelected="onGridRowSelected"></ClientEvents>
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false" AllowColumnResize="true"></Resizing>
                                </ClientSettings>
                            </telerik:RadGrid>
                    
                        </div>
                       <div runat="server" id="divEmailSend" visible="false">
                               <uc1:EmailSend ID="EmailSend1" runat="server" />
                         </div>
                    </telerik:RadPane>
                    <telerik:RadSplitBar ID="RadSplitBar1" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CollapseMode="Forward" />
                    <telerik:RadPane ID="DetailPane" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="DetailPane" OnClientResized="onDetailPaneClientResized">
                        <div style="overflow: auto;" class="EmailHometd">
                            <iframe src="" runat="server" frameborder="0" id="EmailDetailsFrame" visible="false" width="100%"
                                style="background-image: none !important; border: 0px; height: 100vh"></iframe>
                        </div>
                        
                    </telerik:RadPane>
                </telerik:RadSplitter>
            </telerik:RadPane>
        </telerik:RadSplitter>
    </div>


    <asp:HiddenField runat="server" ID="hdnPropertyAndProjectSelectedMsg" />
    <asp:HiddenField ID="hdnProjectId" runat="server" EnableViewState="true" />
    <asp:HiddenField ID="hdnPropertyId" runat="server" EnableViewState="true" />
    <asp:Button runat="server" ID="btnSearchEmails" Text="SearchEmails" CssClass="Hide" />
    <asp:Button runat="server" ID="btnShowEmail" Text="ShowEmail" CssClass="Hide" />
    <asp:HiddenField runat="server" ID="hdnSearchValue" />
    <asp:Button runat="server" ID="btnNewEmail" Text="New Email" CssClass="Hide" />
    <asp:Button runat="server" ID="btnRefreshEmails" Text="Refresh Emails" CssClass="Hide" />
    <asp:Button runat="server" ID="btnReply" Text="Reply" CssClass="Hide" />
    <asp:Button runat="server" ID="btnRefreshWithPostback" Text="Refresh Emails" CssClass="Hide" />
</asp:Content>
