<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailHomePopup.aspx.vb" meta:resourcekey="Page" Inherits="Website.EmailHomePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EmailSend.ascx" TagName="EmailSend" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">

        #rdgEmailsPanel{
            height:100%;
        }

        .documentSplitter {
            padding-top: 91px;
        }

        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 100px) !important;
        }

        .ZIndex {
            z-index: 9001 !important;
        }

        #treeEmails {
            height: calc(100vh-86px);
            width: calc(100vw-5px);
        }

        @media screen and (max-width: 843px) {
            #RAD_SPLITTER_PANE_CONTENT_tdTree {
                height: 100vh !important;
                z-index: 3000;
            }

            #RadSplitter1.documentSplitter {
                z-index: 3000 !important;
                margin-top: 42px !important;
                border-top: black 1px solid;
                padding-top: 51px !important;
            }

            #RAD_SPLITTER_PANE_CONTENT_RadContentPane.fullWidthPane {
                width: 100vw !important;
            }

            .documentSinglePage {
                margin-top: 19px !important;
                margin-bottom: 0 !important;
            }
        }

        .PMHeader .row .col-2 {
            flex: 0 0 100% !important;
            max-width: 100% !important;
            margin-left: 0px !important;
            /*float:none !important;*/
        }

        .PMHeader .row .col-10 {
            flex: 0 0 100% !important;
            max-width: 100% !important;
            margin-left: 0px !important;
            /*float:none !important;*/
        }

        #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_RadContentPane, .DMHorizontalSplitter {
            height: calc(100vh - 100px) !important;
        }

        .DMHorizontalSplitter{
            border-left-width: 1px !important;
        }

        .DMHeaderPane {
            Height: calc(50vh - 80px) !important;
        }

        .DetailPane {height: calc(50vh - 30px) !important;}

        .DMContentPane {
            height:auto !important;
        }

        .RadGrid .rgDataDiv {
            max-height: calc(50vh - 210px) !important;
        }

        .RadTreeView_Default .rtSelected .rtIn, .RadTreeView_Default .rtHover .rtIn{
            background: none !important;
            color: unset !important;
            border-color: transparent !important;
        }
        .RadTreeView_Default .rtHover, .RadTreeView_Default .rtSelected{
            background:gray;
        }
        .RadTreeView_Default .rtUL .rtLI > div{
            padding: 7px 7px 7px 20px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgEmails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgEmails" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnShowEmail">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="EmailDetailsView" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <%--<telerik:AjaxSetting AjaxControlID="btnRefreshEmails"  >
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="mainToolBar"/>
					<telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM"/>
					<telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM"/>
				</UpdatedControls>
			</telerik:AjaxSetting>--%>

                <%--<telerik:AjaxSetting AjaxControlID="btnNewEmail"  >
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="divEmailsView" LoadingPanelID="ldpPM"/>
					<telerik:AjaxUpdatedControl ControlID="divEmailSend" LoadingPanelID="ldpPM"/>
				</UpdatedControls>
			</telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
            <script type="text/javascript">
                var forceMoreMenuToClose = true;
                /* <![CDATA[ */
                var toolbar;
                var grid;
                var searchButton;
                var gridId;
                var rowCheckColClicked;
                function DisableAttachmentLinkPostBack() {
                    return false;
                }
                //var detailpane = null;
                //var mainsplitter = null;
                //Sys.Application.add_load(function () {
                //    if (detailpane == null) return;
                //    $(document).scrollLeft(1);
                //    while ($(document).scrollLeft() != 0) {
                //        var NewWidth = mainsplitter.get_width() - 20

                //        mainsplitter.set_width(NewWidth);
                //        $(document).scrollLeft(1);
                //        if (NewWidth <= 100) break;
                //    }

                //    $(document).scrollTop(1);
                //    while ($(document).scrollTop() != 0) {
                //        var NewHeight = detailpane.get_height() - 20

                //        detailpane.set_height(NewHeight);
                //        $(document).scrollTop(1);
                //        if (NewHeight <= 100) {

                //            break;
                //        }
                //    }
                //})
                function pageLoad() {
                    gridId = '<%=rdgEmails.ClientID %>';
                    grid = $find("<%=rdgEmails.ClientID %>");
                    $("[id$='chkProject']").change(function () { SetDirty_ddlProjects(); });

                    //$("table[id$=rdgEmails_ctl00].rgMasterTable").find("tr>td:nth-child(1)").click(function () {
                    //    rowCheckColClicked = true;
                    //});

                    appendCheckboxAll();
                    <%--toolbar = $find("<%= mainToolBar.ClientID %>");--%>
                    //if (!toolbar) return;
                    //ReplyButton = toolbar.findButtonByCommandName("EmailReply");
                    //MobileReplyButton = toolbar.findButtonByCommandName("MobileMenu").findControl("MobileRadmen").findItemByValue("EmailReply");

                    //if (grid) {
                    //    if (grid.get_masterTableView().get_selectedItems().length == 0) {
                    //        if (ReplyButton) {
                    //            ReplyButton.disable();
                    //        }
                    //        if (MobileReplyButton) {
                    //            MobileReplyButton.disable();
                    //        }
                    //    }
                    //    searchButton = toolbar.findButtonByCommandName("doSearch");

                    //    $telerik.$(".inbox-search-textbox")
                    //    .bind("keypress", function (e) {
                    //        // searchButton.set_imageUrl("images/Email/search.gif");
                    //        searchButton.set_value("search");
                    //    });
                    //}
                }

                var mainsplitter = null;
                function onResized(sender, ags) {
                    fixSplitterSize();
                    mainsplitter = sender;
                }

                function fixSplitterSize(isRail) {
                    window.setTimeout(function () {
                        var drawer = $('form')[0];
                        isRail = false;
                        if (drawer.className.indexOf("rail") >= 0)
                            isRail = true;
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
                    }, 500)

                }


                function onClientResized(sender, ags) {
                    var browserWidth = $telerik.$(window).width();
                    if (browserWidth <= 1200) {
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
                }

                function maintoolbarClick(sender, args) {
                    var value = args.get_item().get_commandName();
                    switch (value) {
                        case 'Save':
                            grid = $find("<%=rdgEmails.ClientID %>");
                            if (grid.get_selectedItems().length > 0) {
                                Email_Selected(grid, grid.get_selectedItems()[0]);
                            } else if (grid.get_selectedItems().length == 0) {
                                break;
                            }
                        case 'Close':
                                close()
                            break;
                        default:
                            break;
                    }
                }

                function Email_Selected(sender, eventArgs) {
                    var EmailId = eventArgs.getDataKeyValue("EmailId");
                    var Subject = eventArgs.getDataKeyValue("Subject");
                    var Notes = eventArgs.getDataKeyValue("FileNames");
                    if (Subject.length > 500) {
                        Subject = Subject.substring(0, 500);
                    }
                    var From = eventArgs.getDataKeyValue("EmailFrom");
                    var To = eventArgs.getDataKeyValue("EmailTo");
                    window.parent.$("[id$=hfEmailName]").val('From:' + From + ',To:' + To);
                    window.parent.$("[id$=hfEmailDescription]").val(Subject);
                    window.parent.$("[id$=hfEmailId]").val(EmailId);
                    if (Notes != "") {
                        $("[id$=hfEmailNotes]").val("Attachments:" + Notes);
                    }

                    window.parent.document.querySelector(".SaveEmail").click();
                    CloseRadWnd();
                }

                function onCommand(sender, eventArgs) {
                    if (eventArgs.get_commandName() == 'Page') {
                        var selectedItems = sender.get_masterTableView().get_selectedItems();
                        var ToolBar = $find($("[id$=mainToolBar]")[0].id)
                        var btnSave = ToolBar.findButtonByCommandName('Save')
                    }
                }

                //function NodeChecked(sender, eventArgs) {
                //    SetDirty_ddlProjects();
                //    var combo = $find("ddlPropertiesAndProjects");
                //    var node = eventArgs.get_node();
                //    var checked = node.get_checked();
                //    var childNodes = node.get_nodes();
                //    if (checked == true) {
                //        CheckParent(node);
                //        //              UncheckAllChildren(childNodes);
                //        //              UncheckAllParent(node);
                //        var tree = $find(node.get_treeView().get_id());
                //        if (node.get_value() == "-1") {
                //            var allCheckedNodes = tree.get_checkedNodes();
                //            var TotalChecked = allCheckedNodes.length
                //            for (var i = TotalChecked - 1; i >= 0 ; i--) {
                //                var CkeckedNode = allCheckedNodes[i];
                //                if (CkeckedNode.get_value() != "-1") {
                //                    CkeckedNode.set_checked(false);

                //                }

                //            }
                //        }
                //        else {
                //            var AllNode = tree.findNodeByValue("-1");
                //            if (AllNode != null)
                //                AllNode.set_checked(false);
                //        }
                //        var selectedCount = tree.get_checkedNodes()
                //        if (selectedCount.length == 1) {

                //            var SelectedNode = tree.get_checkedNodes()[0];
                //            combo.set_text(SelectedNode.get_text());


                //        }
                //        else if (selectedCount.length > 1) {

                //            combo.set_text($("input[id$=hdnPropertyAndProjectSelectedMsg]").val());
                //        }
                //        else
                //            combo.set_text("");

                //        return;
                //    }

                //    var rdvtree = $find(node.get_treeView().get_id());
                //    var AllCheckedCount = rdvtree.get_checkedNodes().length;
                //    if (AllCheckedCount == 0) {
                //        combo.set_text("");
                //    }
                //}
                //function UncheckAllParent(node) {

                //    node = node.get_parent();
                //    while (node != null && node._element.id.toString().indexOf("ddlPropertiesAndProjects") == -1) {
                //        node.set_checked(false);
                //        node = node.get_parent();
                //    }
                //}
                function UncheckAllChildren(nodes) {
                    var i;
                    for (i = 0; i < nodes.get_count() ; i++) {
                        nodes.getNode(i).set_checked(false);

                        if (nodes.getNode(i).get_nodes().get_count() > 0)
                            UncheckAllChildren(nodes.getNode(i).get_nodes());

                    }

                }
                var detailpane = null;
                var headerPane = null;
                var maindiv = $("#ctl00_CPH1_maindiv");
                function onDetailPaneClientResized(sender, ags) {
                    var splitter = sender.get_parent();
                    var pane1 = splitter._panes[0];
                    var pane2 = splitter._panes[1];
                    var pane1Tr = pane1._element;
                    pane2.set_height(splitter._element.clientHeight - pane1Tr.clientHeight - 8);
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

                //function CheckParent(node) {
                //    node = node.get_parent();
                //    while (node != null && node._element.id.toString().indexOf("ddlPropertiesAndProjects") == -1) {
                //        node.set_checked(true);
                //        node = node.get_parent();
                //    }
                //}

                function OpenNotificationMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
                    var left = (screen.width - 920) / 2;
                    var top = (screen.height - 300) / 2;
                    var Bidder = 0;

                    var win = window.open('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source, '',
                       'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                    return false;
                }
                /* ]]> */

                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter') {
                        var pane = $find('tdTree');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        return false;
                    }
                    if (args.get_item().get_commandName() == 'Cancel') {
                        var pane = $find('tdTree');
                        pane.set_visible(false);
                    }

                }
                <%--function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                        sender.close(true);
                    if (args.get_item().get_value() == "ReceiveEmail" || args.get_item().get_value() == "Receive") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("ReceiveEmail");
                        button.click();
                    }
                    if (args.get_item().get_value() == "EmailReply") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("EmailReply");
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
                }--%>
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
                var horizantalpane = null;
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
            <script type="text/javascript" src="JS/Email/EmailHomePopup.js"></script>
        </telerik:RadScriptBlock>
        <asp:HiddenField runat="server" ID="hdnPropertyAndProjectSelectedMsg" />
        <asp:HiddenField ID="hdnProjectId" runat="server" EnableViewState="true" />
        <asp:HiddenField ID="hdnPropertyId" runat="server" EnableViewState="true" />
        <asp:Button runat="server" ID="btnSearchEmails" Text="SearchEmails" CssClass="Hide" />
        <%--<div  ID="divEmailContent" class="Hide" ></div>--%>
        <asp:HiddenField runat="server" ID="hdnSearchValue" />
        <asp:Button runat="server" ID="btnNewEmail" Text="New Email" CssClass="Hide" />
        <asp:Button runat="server" ID="btnRefreshEmails" Text="Refresh Emails" CssClass="Hide" />
        <asp:Button runat="server" ID="btnReply" Text="Reply" CssClass="Hide" />
        <asp:Button runat="server" ID="btnShowEmail" Text="ShowEmail" CssClass="Hide" />
        <asp:Button runat="server" ID="btnRefreshWithPostback" Text="Refresh Emails" CssClass="Hide" />

        <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text="" Style="text-transform: uppercase"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar NewStylePopupToolbar">
            <tr>
                <td class="ToolbarTd ">
                    <%--<telerik:RadComboBox ID="ddlPropertiesAndProjects" runat="server" Skin="Default" AllowCustomText="True" DropDownCssClass="ddlTreeviewTemplate"
                        Width="240px" CloseDropDownOnBlur="true" DropDownWidth="500px" OnClientDropDownClosing="OnClientDropDownClosing_ddlProjects">
                        <Items>
                            <telerik:RadComboBoxItem Text="" />
                        </Items>
                        <ItemTemplate>
                            <telerik:RadTreeView ID="rdvPropertiesAndProjects" Skin="Default" runat="server" CheckBoxes="true"
                                Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeChecked="NodeChecked"
                                OnNodeExpand="rdvPropertiesAndProjects_NodeExpand">
                            </telerik:RadTreeView>
                        </ItemTemplate>
                    </telerik:RadComboBox>--%>
                    <%--<asp:Button ID="btnGetProjects" class="Hide" runat="server" Text="Go" />--%>
                    <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="True" cssclass="popup-toolbar" onclientbuttonclicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save" AccessKey="s" Style="margin-left: 16px;">
                            </telerik:RadToolBarButton>
                              <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Close"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:radtoolbar>
                </td>
            </tr>
        </table>

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default" Width="100%" Height="600px">
            <telerik:RadPane ID="tdTree" runat="server" CssClass="NormalWhiteBack SplitterPanePopup ZIndex" Height="600px" Width="300px">
                <table style="width: 100%; background-color: RGB(237,237,237);" class="TableNoSpacingNoBorder">
                    <tr>
                        <td style="padding-left: 24px;">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" Height="50px" OnClientButtonClicked="treeToolbarClick" Style="line-height: 50px;">
                                <Items>
                                    <%--<telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="Cancel" Height="50px"></telerik:RadToolBarButton>--%>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>

                <telerik:RadTreeView runat="Server" ID="treeEmails" OnNodeClick="treeEmails_NodeClick"
                    EnableViewState="true" CssClass="TreeWithDarkBackground" style="height:calc(100% - 20px)">
                    <Nodes>
                        <telerik:RadTreeNode Value="-1" ContentCssClass="trvInboxWhite"></telerik:RadTreeNode>
                        <telerik:RadTreeNode Value="-2" ContentCssClass="trvSentWhite"></telerik:RadTreeNode>
                    </Nodes>
                </telerik:RadTreeView>


            </telerik:RadPane>

            <telerik:RadSplitBar ID="Splitter" runat="server" Width="100%" CssClass="DMHorizontalSplitter" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" CssClass="DMContentPane" OnClientResized="onClientResized">
                 
                <telerik:RadSplitter ID="DMHorizontalSplitter" runat="server" Orientation="Horizontal" Width="100%" CssClass="DMHorizontalSplitter" OnClientLoad="OnClientLoad">
                    <telerik:RadPane ID="DMHeaderPane" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="DMHeaderPane"
                        OnClientExpanded="OnHorizontalClientExpanded" OnClientCollapsed="OnHorizontalClientCollapsed">
                        <%--<div style="height: 32px;">
                            <telerik:RadToolBar runat="server" ID="mainToolBar" CssClass="inbox-search-toolbar"
                                Width="100%" Skin="Default" OnClientButtonClicked="treeToolbarClick" EnableViewState="false">
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarNewEmail" CommandName="NewEmail" meta:resourcekey="ToolBar_NewEmail"
                                        ToolTip="New Email" PostBack="false" Enabled="True" Value="NewEmail" />
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarRefresh" CommandName="Refresh" ToolTip="Refresh"
                                        Enabled="True" />
                                    <telerik:RadToolBarButton SecurityButtonType="Delete" EnableImageSprite="true" CssClass="ToolbarDelete" CommandName="Delete" ToolTip="Delete"
                                        Enabled="True" Value="Delete" />
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar" />
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" Text="Receive" PostBack="false" EnableImageSprite="true" CssClass="ToolbarReceiveEmail" ToolTip="Receive Emails"
                                        CommandName="ReceiveEmail" Value="ReceiveEmail" OuterCssClass="HideOnMobileToolbar" />
                                    <telerik:RadToolBarButton Text="Reply" SecurityButtonType="Add" Value="EmailReply" PostBack="false" EnableImageSprite="true" CssClass="ToolbarEmailReply"
                                        CommandName="EmailReply" ToolTip="Reply" OuterCssClass="HideOnMobileToolbar" />
                                    <telerik:RadToolBarSplitButton EnableImageSprite="true" CssClass="ToolbarLayout" CommandName="Layout" PostBack="false"
                                        EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar">
                                        <Buttons>
                                            <telerik:RadToolBarButton EnableImageSprite="true" PostBack="True" CommandName="SaveLayout" Value="SaveLayout" CssClass="ToolbarUser">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="True" EnableImageSprite="true" CommandName="LoadDefaultState" Value="LoadDefaultState" CssClass="ToolbarDelegate">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton Value="searchTextBoxButton" PostBack="false" CommandName="searchText" OuterCssClass="HideOnMobileToolbar">
                                        <ItemTemplate>
                                            <telerik:RadTextBox runat="server" ID="txtSearchInbox" EmptyMessage="Search Inbox" meta:resourcekey="txtSearchInbox"
                                                CssClass="inbox-search-textbox" Width="300px" ClientEvents-OnKeyPress="onKeyPress" />
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" Value="search" CssClass="ToolbardoSearch"
                                        CommandName="doSearch" OuterCssClass="HideOnMobileToolbar" />
                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Receive" EnableImageSprite="true" CssClass="ToolbarReceiveEmail" Value="ReceiveEmail" />
                                                            <telerik:RadMenuItem Text="Reply" Value="EmailReply" SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarEmailReply" />
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Layout" Value="Layout" CssClass="ToolbarLayout" PostBack="True">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Save Layout" EnableImageSprite="true" PostBack="True" Value="SaveLayout" CssClass="ToolbarUser"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Load Default State" EnableImageSprite="true" PostBack="True" Value="LoadDefaultState" CssClass="ToolbarDelegate"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </div>--%>
                        <table cellpadding="0" cellspacing="0" style="width: 100%; height:100%;" runat="server" id="tblContent">
                            <tr>
                                <td>
                                    <table cellpadding="0" runat="server" id="tblFiles" cellspacing="0" style="height:100%;">
                                        <tr>
                                            <td>
                                                <div class="PMHeader" style="height:100%;">
                                                    <div class="row" style="height:100%;">
                                                        <div class="col-12" style="height:100%;">

                                                            <telerik:RadGrid runat="server" ID="rdgEmails" AutoGenerateColumns="false" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" Height="250px"
                                                                GridLines="None" BorderWidth="0" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                                                AllowMultiRowSelection="false" AllowSorting="true" Style="outline: none" ShowGroupPanel="true"
                                                                AllowPaging="True" PageSize="250" >
                                                                <ClientSettings Scrolling-AllowScroll="True" Scrolling-UseStaticHeaders="true" Selecting-AllowRowSelect="true"
                                                                    AllowDragToGroup="true" EnableRowHoverStyle="true">
                                                                    <Selecting AllowRowSelect="True"></Selecting>
                                                                    <ClientEvents OnRowSelected="onGridRowSelected" OnRowDblClick="Email_Selected" OnCommand="onCommand"></ClientEvents>
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                                                                </ClientSettings>

                                                                <MasterTableView TableLayout="Fixed"  EnableHeaderContextMenu="true" GroupLoadMode="Client" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="EmailId, IsNew">
                                                                    <Columns>
                                                                        <telerik:GridTemplateColumn HeaderText="To" HeaderStyle-Width="170px" UniqueName="EmailTo" DataField="EmailTo"
                                                                            GroupByExpression="EmailTo [GridColumn_EmailTo] Group By EmailTo ASC" SortExpression="EmailTo">
                                                                            <ItemTemplate>
                                                                                <span><%#Container.DataItem("EmailTo")%>&nbsp;</span>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="120px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="From" HeaderStyle-Width="170px" UniqueName="EmailFrom"
                                                                            GroupByExpression="EmailFrom [GridColumn_EmailFrom] Group By EmailFrom ASC" SortExpression="EmailFrom" DataField="EmailFrom">
                                                                            <ItemTemplate>
                                                                                <span><%#Container.DataItem("EmailFrom")%>&nbsp;</span>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="120px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn DataField="Subject" UniqueName="Subject" SortExpression="Subject" HeaderText="Subject" GroupByExpression="Subject [GridColumn_Subject] Group By Subject ASC">
                                                                            <ItemTemplate>
                                                                                <span><%#Container.DataItem("Subject")%>&nbsp;</span>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="200px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Date" DataField="DeliveryDate" HeaderStyle-Width="150px" SortExpression="DeliveryDate" UniqueName="DeliveryDate" GroupByExpression="DeliveryDate [GridColumn_DeliveryDate]  GROUP BY DeliveryDate">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#FormatDate(CDate(Container.DataItem("DeliveryDate")))%>&nbsp;</span>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            <HeaderStyle Width="100px"></HeaderStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn Groupable="false" DataField="AttachmentsCount" UniqueName="AttachmentsCount" SortExpression="AttachmentsCount" GroupByExpression="AttachmentsCount [GridColumn_AttachmentsCount] GROUP BY AttachmentsCount" HeaderStyle-Width="120px">
                                                                            <ItemTemplate>
                                                                                <%--<asp:LinkButton ID="attachment"
                                                                                    runat="server" Visible='<%# CBool(CInt(Eval("AttachmentsCount")) > 0) %>'
                                                                                    class="AttachmentButton" OnClientClick="return DisableAttachmentLinkPostBack();">
                                                  <span class="Icon"></span>
                                                                                </asp:LinkButton>
                                                                                &nbsp;--%>
                                                                                <span>
                                                                                    <%# IIf(Container.DataItem("AttachmentsCount") = 0, "", Container.DataItem("AttachmentsCount"))%>&nbsp;
                                                                                </span>
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                                                            CancelImageUrl="Cancel.gif">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                </MasterTableView>
                                                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false"
                                                                    AllowDragToGroup="true">

                                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                                        AllowColumnResize="True"></Resizing>
                                                                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                                                </ClientSettings>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </div>

                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>

                    </telerik:RadPane>
                    <telerik:RadSplitBar ID="RadSplitBar1" runat="server" CollapseMode="Forward" />
                    <telerik:RadPane ID="DetailPane" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="DetailPane" OnClientResized="onDetailPaneClientResized">

                        <div runat="server" id="divEmailsView" style="height:100%; overflow:hidden;">
                            <div style="overflow: auto; height: 100%; border-top: 3px solid #C4DBF9">

                                <asp:DetailsView runat="server" ID="EmailDetailsView" AutoGenerateRows="false" CssClass="message-view"
                                    GridLines="None" EnableViewState="false">
                                    <Fields>
                                        <asp:TemplateField ShowHeader="false">
                                            <ItemTemplate>
                                                <ul style="list-style-type: none">
                                                    <li>
                                                        <h3 id="subject">
                                                            <%# Eval("Subject") %></h3>
                                                    </li>
                                                    <li>
                                                        <asp:Label runat="server" ID="lblFrom" Text="From: " meta:resourcekey="lblFrom"></asp:Label>
                                                        <span id="from">
                                                            <%# Eval("EmailFrom") %></span></li>
                                                    <li>
                                                        <asp:Label runat="server" ID="lblTo" Text="To: " meta:resourcekey="lblTo"></asp:Label>
                                                        <span id="To">
                                                            <%# Eval("EmailTo") %></span></li>
                                                    <li>
                                                        <asp:Label runat="server" ID="lblDate" Text="Sent: " meta:resourcekey="lblDate"></asp:Label>
                                                        <span id="sent">
                                                            <%#Eval("DeliveryDateTime")%></span></li>
                                                    <li>
                                                        <div class="MaxWidth" style="display: inline-block">
                                                            <div class="floatLeft">
                                                                <asp:Label runat="server" ID="lblAttachments" Text="Attachments:" meta:resourcekey="lblAttachments"></asp:Label>&nbsp;
                                                            </div>
                                                            <asp:Repeater ID="rptEmailAttachments" runat="server">
                                                                <ItemTemplate>
                                                                    <div class="floatLeft">
                                                                        <a id="lkDownload" runat="server" href="#" onclick='<%# Me.GetUrlLinkForDownload(Eval("FullFileName"), False) %>'>
                                                                            <%#Eval("FileWithExtension")%></a>&nbsp;
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </li>
                                                </ul>
                                                <div id="message-body">
                                                    <%#Eval("Body").ToString().Replace("\n", "<br />")%>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Fields>
                                </asp:DetailsView>
                            </div>
                            <div runat="server" id="divEmailSend" visible="false">
                                <uc1:EmailSend ID="EmailSend1" runat="server" />
                            </div>
                        </div>
                    </telerik:RadPane>
                </telerik:RadSplitter>
            </telerik:RadPane>
        </telerik:RadSplitter>
    </form>
</body>
</html>
