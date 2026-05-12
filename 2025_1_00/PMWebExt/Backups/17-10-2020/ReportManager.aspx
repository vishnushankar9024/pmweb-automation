<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="ReportManager.aspx.vb" Inherits="Website.ReportManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ReportManagerPermissions.ascx" TagName="ReportManagerPermissions" TagPrefix="uc1" %>
<%@ Register Src="ReportPrintingSetup.ascx" TagName="ReportPrintingSetup" TagPrefix="uc2" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">

            function CheckMails(sender, args) {

                var emails = args.Value;
                var emails_array = emails.replace(/(\r\n|\n|\r)/gm, ';').split(";");
                var reg = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;

                for (var i = 0; i < emails_array.length; i++) {
                    if (emails_array[i].replace(/\s/g, '') != '' && reg.test(emails_array[i]) == false) {
                        args.IsValid = false;
                        return;
                    }

                }


                args.IsValid = true;
                return;


            }
            function RemoveUserBox(argId) {
                var hfdeletedUser = $("[id$=hfdeletedUser]")[0];
                hfdeletedUser.value = argId;
                var btnRemoveUsers = $("[id$=btnRemoveUsers]");
                btnRemoveUsers.click();

            }
            function RemoveContactBox(argId) {
                var hfdeletedContact = $("[id$=hfdeletedContact]")[0];
                hfdeletedContact.value = argId;
                var btnRemoveContact = $("[id$=btnRemoveContact]");
                btnRemoveContact.click();
            }
            function AddContacts() {
                var btnAddContacts = $("[id$=btnAddContacts]");
                btnAddContacts.click();

            }
            function AddUsers() {
                var btnAddContacts = $("[id$=btnAddUsers]");
                btnAddContacts.click();
            }

            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                setMenuItemsState(args.get_menu().get_items(), treeNode);
            }

            function onClientContextMenuItemClicking(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();
                var tree = $find("<%= treeReports.ClientID %>");
                treeNode.set_selected(true);
                menuItem.get_menu().hide();
                var isGrougSelected = false;
                var isItemSelected = false;
                var nodes = tree.get_selectedNodes();

                switch (menuItem.get_value()) {
                    case "Rename":
                        treeNode.startEdit();
                        args.set_cancel(true);
                        break;
                    case "NewFolder":
                        treeNode.expand();
                        window.setTimeout(function () { addGroupNode(); }, 200);
                        args.set_cancel(true);
                        break;
                    case "NewFile":
                        var nodeValue = treeNode.get_value();
                        args.set_cancel(false);
                        break;

                    case 'AddServerReport':
                        var nodeValue = treeNode.get_value();
                        var win = OpenPOPUp('ReportsAddReportToServer.aspx?FolderId=' + nodeValue, 610, 500)
                        //var left = (screen.width - 900) / 2;
                        //var top = (screen.height - 500) / 2;
                        //var win = window.open('ReportsAddReportToServer.aspx?FolderId=' + nodeValue, '',
                        //        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=610,height=500,top=' + top + ',left=' + left);
                        var timer = setInterval(function () {
                            if (win.closed) {
                                clearInterval(timer);
                                window.location.href = window.location.href;
                                //window.location.reload();
                            }
                        }, 1000);
                        args.set_cancel(true);
                        break;

                    case "Delete":
                        var isFile = false;

                        if (tree.get_selectedNode().get_value().indexOf("R_") > -1)
                            isFile = true;
                        var result;
                        if (!isFile)
                            result = confirm(Msg_ConfirmDeleteFolder);
                        else
                            result = confirm(Msg_ConfirmDeleteReport);

                        args.set_cancel(!result);
                        break;
                }
            }

            function addGroupNode() {
                var nodeText = "";
                var tree = $find("<%= treeReports.ClientID %>");
                tree.trackChanges();

                //Instantiate a new client node
                var node = new Telerik.Web.UI.RadTreeNode();
                var parent = tree.get_selectedNode();
                //Set its value, text and image
                node.set_value(parent.get_value);
                node.set_text(nodeText);
                //node.set_imageUrl(parent.get_imageUrl())
                //Set IsNew attribute for checking on server side
                node.get_attributes().setAttribute("IsNew", "True")
                //Add the new node as the child of the selected node or the treeview if no node is selected
                //parent.expand();

                parent.get_nodes().add(node);
                node._addClassToContentElement("trvFolderWhite")
                //Expand the parent if it is not the treeview
                if (parent != tree && !parent.get_expanded())
                    parent.set_expanded(true);
                node.set_selected(true);
                window.setTimeout(function () { node.startEdit(); }, 100);
                parent.set_selected(false);

                tree.commitChanges();
                return node;
            }


            //this method disables the appropriate context menu items
            function setMenuItemsState(menuItems, treeNode) {
                var tree = $find("<%= treeReports.ClientID %>");
                var nodes = tree.get_selectedNodes();

                var isFile = false;

                if (tree.get_selectedNode().get_level() == 0) {
                    for (var i = 0; i < menuItems.get_count() ; i++) {
                        menuItems.getItem(i).set_visible(false);
                    }
                    return false;
                }

                if (tree.get_selectedNode().get_value().indexOf("R_") > -1)
                    isFile = true;

                for (var i = 0; i < menuItems.get_count() ; i++) {
                    var menuItem = menuItems.getItem(i);
                    //alert(menuItem.get_value());
                    switch (menuItem.get_value()) {
                        case "Rename":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true');
                                    menuItem.set_visible(tree.get_selectedNode().get_level() != 1);
                                    if (!(tree.get_selectedNode().get_level() != 1))
                                        menuItem.get_element().style.display = "none";
                                }
                            }


                            break;
                        case "NewFolder":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true');
                                }
                            }

                            break;
                        case "NewFile":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("AddReports").toLowerCase() == 'true');
                                }
                            }

                            break;
                        case "AddServerReport":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("AddReports").toLowerCase() == 'true');
                                }
                            }

                            break;
                        case "Delete":
                            if (isFile) {
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("DeleteReports").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("IsSystem").toLowerCase() == 'false');
                            } else {
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true' &&
                                    tree.get_selectedNode().get_attributes().getAttribute("IsSystem").toLowerCase() == 'false');
                            }

                            menuItem.set_visible(tree.get_selectedNode().get_level() != 1);
                            if (!(tree.get_selectedNode().get_level() != 1)) {
                                menuItem.get_element().style.display = "none";
                            }

                            break;
                        case "EditPermissions":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    menuItem.set_enabled(
                                    tree.get_selectedNode().get_attributes().getAttribute("EditPermissions").toLowerCase() == 'true');
                                }
                            }
                            break;
                    }
                }

            }
            function DisplayMessage(innerText) {
                alert(innerText);
            }

            ////////Report Schedules/////////////////
            function OpenSelectUserPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (screen.width - 568) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                //if (querySt("ObjectTypeId") == '94') {
                //    Bidder = 1;
                //}
                var wnd = window.radopen('SelectUserPopup.aspx?&Bidder=' + Bidder + '&Source=Report', '');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function OpenReminderMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (screen.width - 920) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                //if (querySt("ObjectTypeId") == '94') {
                //    Bidder = 1;
                //}
                var wnd = window.radopen('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source, '');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

        </script>

    </telerik:RadCodeBlock>
    <script type="text/javascript">
        var UserPos;
        var ContPos;

        function ScheduleResponseEnd(sender, eventArgs) {
            try {
                document.getElementById("dvUser").scrollTop = UserPos;
                document.getElementById("dvContact").scrollTop = ContPos;
            }
            catch (e) {

            }
        }
        function ScheduleRequestStart(sender, eventArgs) {
            try {
                UserPos = document.getElementById("dvUser").scrollTop;
                ContPos = document.getElementById("dvContact").scrollTop;
            }
            catch (e) {

            }

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
        }
        function OnClientCollapsed(sender, ags) {
            $("#ctl00_CPH1_Splitter").addClass("removeLeft");
            setTimeout(FloatDivs, 100);
            setCookie('ReportManagerStatus', 'inline', 60);
        }
        function OnClientExpanded(sender, ags) {
            $("#ctl00_CPH1_Splitter").removeClass("removeLeft");
        }
        var mainsplitter = null;
        function onResized(sender, ags) {
            ////var NewWidth = sender._panes[1].get_width() - 20;
            ////sender._panes[1].set_width(NewWidth);
            ////return false;
            mainsplitter = sender;

        }
        function AssetSplitterResized(sender, ags) {
            setTimeout(FloatDivs, 100);
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

        <%--        function ToggleAssetMenu() {
            var tdAssetMenu = document.getElementById('<%=tdAssetMenu.ClientID %>');
            var tdAssetExplorerBar = document.getElementById('<%=tdAssetExplorerBar.ClientID %>');
            var tdAssetrestofpage = document.getElementById('<%=tdAssetrestofpage.ClientID %>');
            var tdtbsDocument = document.getElementById('<%=tdtbsDocument.ClientID %>');
            var form = $('form')[0]
            var btnToggleAssetMenu = document.getElementById('<%=btnToggle.ClientID%>');
              if (tdAssetMenu.style.display == 'none') {
                  tdAssetMenu.style.display = '';
                  tdAssetExplorerBar.style.left = "285px";
                  tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBar'
                  btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                  setCookie('AssetMenuStatus', 'inline', 60);
                  // form.className = form.className + ' ReportManagerTabsvisible';
                  tdtbsDocument.className = 'ReportManagerTabs'
              } else {
                  tdAssetMenu.style.display = 'none';
                  tdAssetExplorerBar.style.left = "0px";
                  tdAssetExplorerBar.style.width = "4px";
                  tdAssetrestofpage.style.width = "100%";
                  tdAssetExplorerBar.className = 'ReportManagerBar MobileAssetExplorerBarClosed'
                  btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                  setCookie('AssetMenuStatus', 'none', 60);
                  // form.className = form.className.replace(' ReportManagerTabsVisiible', '')
                  tdtbsDocument.className = 'ReportManagerTabstreehidden'

              }
              return false;
          }--%>
    </script>
    <style type="text/css">
        .ContactBox {
            float: left;
        }

        .removeLeft {
            left: 0 !important;
        }

        body, html, form {
            height: 100%;
            margin: 0px;
            padding: 0px;
        }

        .AssetSplitterPane {
            background-color: #666666;
        }

        @media screen and (max-width: 1323px) and (min-width: 844px) {
            .ReportManagerTree {
                height: calc(100vh - 77px);
            }
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .Selected.AssetSplitterPane {
                margin-top: 33px !important;
                height: calc(100vh - 71px) !important;
            }

            .ReportManagerTree {
                height: calc(100vh - 0px) !important;
                max-height: calc(100vh - 0px) !important;
            }

            .Selected.AssetSplitter {
                margin-top: 33px !important;
                height: calc(100vh - 70px) !important;
            }
        }

        .ReportManagerTabs .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .ReportManagerTabs {
            padding-top: 0px !important;
        }

            .ReportManagerTabs li {
                width: calc(50% - 8px) !important;
            }

        .trvNewFolderWhite .rtSp {
            margin-right: -14px;
        }

        .trvNewFolderWhite .rtIn {
            margin-left: 14px;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReportManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpReportManager">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpReportManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">

            <td></td>
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True"
                    meta:resourcekey="mainToolBarResource1" Visible="true">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s"
                            ToolTip="Save (Alt+s)" Visible="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" CommandName="Preview"
                            AccessKey="p" ToolTip="Preview (Alt+p)" Visible="false">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
        <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" CssClass="AssetSplitterPane" Width="30%" EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded" OnClientResized="AssetSplitterResized">

            <telerik:RadTreeView ID="treeReports" runat="server" CssClass="ReportManagerTree WhitePlusMinus" Style="height: calc(100% - 24px); padding: 24px 0 0 24px;"
                MultipleSelect="true" EnableDragAndDrop="true"  AllowNodeEditing="false" OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                OnClientContextMenuShowing="onClientContextMenuShowing" EnableEmbeddedSkins="false" CausesValidation="false">
                <ContextMenus>
                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                        <Items>
                            <telerik:RadMenuItem Value="Rename" Text="Rename" meta:ResourceKey="MenuItem_Rename" EnableImageSprite="true" CssClass="MenuRename">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="NewFile" Text="New Report" meta:ResourceKey="MenuItem_NewFile"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="AddServerReport" Text="Add Server Report" meta:ResourceKey="MenuItem_AddServerReport"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="NewFolder" meta:ResourceKey="MenuItem_NewFolder" Text="New Folder"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="Delete" Text="Delete" meta:ResourceKey="MenuItem_Delete" EnableImageSprite="true" CssClass="MenuDelete">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem EnableImageSprite="true" CssClass="MenuPermission" meta:ResourceKey="MenuItem_EditPermissions"
                                Text="Permissions" Value="EditPermissions">
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadTreeViewContextMenu>
                </ContextMenus>
                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                <ExpandAnimation Duration="100"></ExpandAnimation>
            </telerik:RadTreeView>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="AssetSplitter" CollapseMode="Forward" />
        <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="AssetSplitterRightPane" OnClientResized="onClientResized">
            <telerik:RadTabStrip ID="tbsDocument" runat="server" CausesValidation="False" EnableViewState="true" CssClass="ReportManagerTabs"
                meta:resourcekey="tbsDocumentResource1" MultiPageID="mlpReportManager"
                OnTabClick="tbsDocument_TabClick" SelectedIndex="0" Skin="Default" Width="100%">
                <Tabs>
                    <telerik:RadTab meta:resourcekey="tab_General" Text="General" Value="General" />
                    <telerik:RadTab meta:resourcekey="tab_PrintingSetup" Text="Printing Setup" Value="PrintingSetup" />
                    <telerik:RadTab meta:resourcekey="tab_Permissions" Text="Permissions" Value="Permissions" />
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="mlpReportManager" runat="server" meta:resourcekey="mlpReportManagerResource1"
                RenderSelectedPageOnly="True" SelectedIndex="0">
                <telerik:RadPageView ID="pvReportManager" runat="server" meta:resourcekey="pvReportManagerResource1">
                    <asp:Panel ID="pnlInput" runat="server">
                        <div class="PMMainPage">
                            <div class="row">
                                <div class="col-4 col-4-left">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblReportName" meta:resourcekey="lblReportName" runat="server" Text="Report Name*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtReportName" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtReportName" runat="server" ID="rfvReportName"
                                                    ErrorMessage="Required" Enabled="true" Display="Dynamic" CssClass="Validator"
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblReportType" meta:resourcekey="lblReportType" runat="server" Text="Report Type"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlReportType" OnClientSelectedIndexChanged="DisplayReportType"
                                                    runat="server" AllowCustomText="true" MarkFirstMatch="True" Skin="Default" CloseDropDownOnBlur="true"
                                                    Height="100" Width="100%">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblFullFilePath" meta:resourcekey="lblFullFilePath" runat="server"
                                                    Text="Folder Path"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:HyperLink ID="hlifullFilePath" meta:resourcekey="hlifullFilePath" runat="server"
                                                    SecurityButtonType="Edit" Target="_blank"></asp:HyperLink>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblIsSystem" meta:resourcekey="lblIsSystem" runat="server"
                                                    Text="Is System"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <img src="Images/Global/<%=CStr(IIf(PM.ReportInfo.IsSystem, "checked.png", "unchecked.png"))%>" alt="" />
                                            </td>
                                        </tr>
                                        <tr id="trCrystalReport" runat="server">
                                            <td colspan="2">
                                                <table style="width: 100%" cellpadding="1" cellspacing="0">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblUploadFile" meta:Resourcekey="lblUploadFile" runat="server" Text="Upload File"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <input type="file" style="width: 100%" runat="server" id="flReportFile" />

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblFileName" meta:resourcekey="lblFileName" runat="server" Text="File Name"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtFileName" ReadOnly runat="server" Width="100%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDatabase" meta:resourcekey="lblDatabase" runat="server" Text="Database Name"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlDatabaseName" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                                                Skin="Default" CloseDropDownOnBlur="true" Height="100" Width="100%">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:CheckBox ID="chkEnableParameterPrompt" meta:Resourcekey="chkEnableParameterPrompt"
                                                                Text="Enable Parameter Prompt" runat="server" />
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:CheckBox ID="chkEnableDatabaseLogonPrompt" meta:Resourcekey="chkEnableDatabaseLogonPrompt"
                                                                Text="Enable Database Logon Prompt" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="trSqlReport" runat="server">
                                            <td class="labelWidth">
                                                <asp:Label ID="lblServerURL" meta:resourcekey="lblServerURL" runat="server" Text="Server URL*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtServerURL" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtServerURL" runat="server" ID="rfvServerURL"
                                                    ErrorMessage="Required" Enabled="true" meta:resourcekey="rfvServerURL" Display="Dynamic" CssClass="Validator"
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPath" runat="server" meta:Resourcekey="lblPath" Text="Path*"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPath" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtPath" runat="server" ID="rfvPath"
                                                    ErrorMessage="Required" Enabled="true" meta:resourcekey="rfvPath" Display="Dynamic" CssClass="Validator"
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-4 col-4-right" style="width: 400px !important;">
                                    <table class="colTable" style="width: 400px !important;">
                                        <tr id="trParameters" runat="server">
                                            <td colspan="2">
                                                <asp:Panel ID="pnlParameters" runat="server">
                                                    <fieldset>
                                                        <legend>
                                                            <asp:Label ID="lblProjectParameters" runat="server" Text="Projects" meta:Resourcekey="lblProjectParameters"></asp:Label>
                                                        </legend>
                                                        <asp:DataList ID="dtlParamters" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
                                                            RepeatLayout="Table" Width="400px" ItemStyle-VerticalAlign="Top">
                                                            <ItemTemplate>
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="ldpPM">
                                                                    <table style="width: 100%; vertical-align: text-top; text-align: center" border="0" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td valign="top" align="left">
                                                                                <input type="hidden" id="hdId" runat="server" value='<%#Container.DataItem("Id")%>' />
                                                                                <telerik:RadTextBox ID="txtParameterValues" runat="server" Width="300"></telerik:RadTextBox>
                                                                                <table cellpadding="0" cellspacing="0" width="400px">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <telerik:RadListBox ID="rlbParameterValuesFrom" runat="server" CssClass="ParameterValuesFrom" Height="248px" Skin="Default"
                                                                                                SelectionMode="Multiple" AllowTransfer="true" TransferToID="rlbParameterValuesTo" AutoPostBackOnTransfer="true"
                                                                                                AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true" Width="216px">
                                                                                            </telerik:RadListBox>
                                                                                        </td>
                                                                                        <td>
                                                                                            <telerik:RadListBox ID="rlbParameterValuesTo" OnClientLoad="rlbParameterValuesTo_Load" runat="server" CssClass="ParameterValuesTo" Height="248px" Skin="Default"
                                                                                                SelectionMode="Multiple" AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true" Width="184"
                                                                                                OnItemDataBound="rlbParameterValuesTo_ItemDataBound" OnInserted="rlbParameterValuesTo_Inserted" OnDeleted="rlbParameterValuesTo_Deleted">
                                                                                            </telerik:RadListBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </telerik:RadAjaxPanel>
                                                            </ItemTemplate>
                                                            <ItemStyle VerticalAlign="Top" />
                                                        </asp:DataList>
                                                    </fieldset>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table style="width: 100%; margin-top: 22px;">
                                                    <tr>
                                                        <td width="50%" valign="top" style="padding-right: 26px">
                                                            <asp:Panel ID="pnlPreviewButton" runat="server">
                                                                <asp:Button ID="btnPreview" runat="server" meta:Resourcekey="btnPreview" Text="Preview" OnClientClick="return openReport();" Width="184px" />
                                                            </asp:Panel>
                                                        </td>
                                                        <td width="50%" align="top">
                                                            <asp:Button ID="btnSave" meta:Resourcekey="btnSave" runat="server" Text="Save" Width="184px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="50%" valign="top">
                                                            <asp:Panel ID="pnlRegenerateParametersButton" runat="server" Visible="false">
                                                                <asp:Button ID="btnRegenerateParameters" meta:Resourcekey="btnRegenerateParameters"
                                                                    CssClass="LargeButton" runat="server" Text="Regenerate Parameters" />
                                                            </asp:Panel>
                                                        </td>
                                                        <td width="50%" valign="top"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblError" runat="server" Text="" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </telerik:RadPageView>
                <telerik:RadPageView ID="pvPrinting" Visible="false" runat="server">
                    <uc2:ReportPrintingSetup ID="ReportPrintingSetup1" runat="server" />
                </telerik:RadPageView>
                <telerik:RadPageView ID="pvPermissions" runat="server">
                    <uc1:ReportManagerPermissions ID="ReportManagerPermissions" runat="server" />
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </telerik:RadPane>
    </telerik:RadSplitter>
    <%--      
            <td id="tdAssetExplorerBar" runat="server" class="ReportManagerBar MobileAssetExplorerBar">
                <input id="btnToggle" runat="server" class="AsserExplorerbutton MobileAsserExplorerbutton" type="button" value=" " onclick="return ToggleAssetMenu();" />
            </td>--%>






    <telerik:RadWindowManager ID="radWindowMgr" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" ShowContentDuringLoad="false" IconUrl="Images/Global/favicon.ico"
        VisibleOnPageLoad="false" Behavior="Default" InitialBehavior="None" Left="" Top="">
        <Windows>
            <telerik:RadWindow ID="wndPreview" ShowContentDuringLoad="false" Modal="true" Skin="Default"
                runat="server" Title="Preview">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <input type="hidden" id="hdSelectedReport" runat="server" />
    <telerik:RadAjaxLoadingPanel ID="ldpReportManager" runat="server" Skin="Default" />

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" src="JS/TelerikUtilities.js"></script>
        <script language="javascript" type="text/javascript">
            function openReport() {
                //           var projects = GetProjectIds();
                //            var wnd = window.radopen('ReportPreview.aspx?projects=' + projects);
                //            wnd.setSize(900, 500);
                //            wnd.Center();
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (screen.width - 900) / 2;
                var top = (screen.height - 500) / 2;
                var Id = '<%=PM.ReportInfo.Id%>';
                var wnd = OpenReportViewerPOPUp('ReportPreview.aspx?reportId='+Id, "");
                wnd.add_close(fixSplitterSizeOnClose)
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }


            function fixSplitterSizeOnClose() {
                window.setTimeout(function () {
                    var drawer = $('form')[0];
                    var isRail = false;
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
                },500)

            }
            function pageLoad() {
                DisplayReportType();
            }
            function DisplayReportType() {
                var crystal = document.getElementById('<%= trCrystalReport.ClientID %>');
                var sql = document.getElementById('<%= trSqlReport.ClientID %>');

                if (crystal == null || sql == null)
                    return;

                var combo = document.getElementById('<%= ddlReportType.ClientID %>');

                crystal.style.display = 'none';
                sql.style.display = 'none';

                switch (combo.value) {
                    case 'Crystal Report':
                        crystal.style.display = '';
                        break;
                    case 'SQL Report':
                        sql.style.display = '';
                        break;
                    default:
                        switch (document.getElementById('<%= hdSelectedReport.ClientID %>').value) {
                            case 'Crystal Report':
                                crystal.style.display = '';
                                combo.value = document.getElementById('<%= hdSelectedReport.ClientID %>').value;
                                break;
                            case 'SQL Report':
                                sql.style.display = '';
                                combo.value = document.getElementById('<%= hdSelectedReport.ClientID %>').value;
                            break;
                    }
                    break;
            }
        }



        function CheckViewRight(chkViewOnly) {
            var tr = $(chkViewOnly).parents(".rgEditForm:first");
            if (!tr || tr.length == 0)
                tr = $(chkViewOnly).parents("tr:first");
            if (!chkViewOnly.checked) {
                tr.find("input[id $= 'chkFullControl']")[0].checked = false;
                tr.find("input[id $= 'chkManageFolder']")[0].checked = false;
                tr.find("input[id $= 'chkAddReports']")[0].checked = false;
                tr.find("input[id $= 'chkDeleteReports']")[0].checked = false;
                tr.find("input[id $= 'chkEditReports']")[0].checked = false;
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
            var chkAddReports = tr.find("input[id $= 'chkAddReports']")[0];
            var chkEditReports = tr.find("input[id $= 'chkEditReports']")[0];
            var chkDeleteReports = tr.find("input[id $= 'chkDeleteReports']")[0];
            var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
            if (chkRight.checked) {
                chkViewOnly.checked = true;
                if (chkManageFolder.checked && chkAddReports.checked && chkEditReports.checked && chkDeleteReports.checked && chkEditPermissions.checked)
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
            var chkAddReports = tr.find("input[id $= 'chkAddReports']")[0];
            var chkEditReports = tr.find("input[id $= 'chkEditReports']")[0];
            var chkDeleteReports = tr.find("input[id $= 'chkDeleteReports']")[0];
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


        var rlbParameterValuesTo;
        function rlbParameterValuesTo_Load(sender, args) {
            rlbParameterValuesTo = sender;
        }


        function GetProjectIds() {
            var projects = '';
            if (rlbParameterValuesTo) {
                var items = rlbParameterValuesTo.get_items();
                for (var i = 0; i < items.get_count() ; i++) {
                    var value = items.getItem(i).get_value();
                    if (value != null && value != "")
                        projects += value + ',';
                }

                if (projects.endsWith(","))
                    projects = projects.substring(0, projects.length - 1);
            }
            return projects;
        }

        </script>

    </telerik:RadCodeBlock>

</asp:Content>
