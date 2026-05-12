<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="QueryViewer.aspx.vb" Inherits="Website.QueryViewer" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="QueryBuilderPermissions.ascx" TagName="QueryBuilderPermissions" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <style>
            .removeLeft {
                left: 0 !important;
            }

             .documentTabs.AssetExplorerVisible .rtsLevel.rtsLevel1 {
                width: 100% !important;
            }
            @media screen and (min-width:320px) and (max-width:843px) {
                .AssetSplitterRightPane {
                    height: calc(100vh - 36px) !important;
                }

                .AssetExplorerTree {
                    height: calc(100vh - 37px) !important;
                    max-height: calc(100vh - 37px) !important;
                    margin-top: 0px !important;
                }

                .AssetSplitter {
                    margin-top: 0px !important;
                }

                .MobileAssetExplorerBar {
                    position: fixed;
                    z-index: 9999;
                    left: 288px !important;
                    height: calc(100vh - 37px) !important;
                }

                .AssetSplitterPane {
                    margin-top: 0px !important;
                    height: calc(100vh - 37px) !important;
                    background-color: #666666 !important;
                }

                .documentTabs {
                    margin-top: 0px !important;
                    padding-top: 4px !important;
                    top: 0px !important;
                }
            }

            @media screen and (min-width:843px) and (max-width:1201px) {
                .AssetExplorerTree {
                    height: calc(110vh - 189px) !important;
                    max-height: calc(110vh - 189px) !important;
                    margin-top: 0px !important;
                }
            }

            .rspPane.rspFirstItem {
                background-color: #666666;
            }
        </style>

        <script language="javascript" type="text/javascript">
            function openReport() {
                OpenPOPUp('QueryBuilder_PrintResults.aspx?Source=QueryViewr', 900, 500, true);
                return false;
            }
            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                setMenuItemsState(args.get_menu().get_items(), treeNode);
            }
            function setMenuItemsState(menuItems, treeNode) {
                var tree = $find("<%= trvQueries.ClientID %>");
                var nodes = tree.get_selectedNodes();

                var isFile = false;
                var isSystemFile = false

                if (tree.get_selectedNode().get_value().indexOf("Q_") > -1)
                    isFile = true;
                if (tree.get_selectedNode().get_value().indexOf("P_") > -1 || tree.get_selectedNode().get_value().indexOf("PC_") > -1 || tree.get_selectedNode().get_value().indexOf("C_") > -1)
                    isSystemFile = true;
                for (var i = 0; i < menuItems.get_count() ; i++) {
                    var menuItem = menuItems.getItem(i);
                    //alert(menuItem.get_value());
                    switch (menuItem.get_value()) {
                        case "AddReport":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                                break;
                            }
                            if (isFile) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                                break;
                            }
                            if ((tree.get_selectedNode().get_attributes().getAttribute("ObjectTypeId") == "0")) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                                break;

                            }
                            if (tree.get_selectedNode().get_attributes().getAttribute("ObjectTypeId") != "0") {
                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                menuItem.set_enabled(tree.get_selectedNode().get_attributes().getAttribute("AddQuery").toLowerCase() == 'true'
                                                        && tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                                break;

                            }
                            break;
                        case "OpenReport":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile) {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";

                                } else {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                }
                            }
                            break;
                        case "Rename":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {
                                if (isFile || isSystemFile) {
                                    menuItem.set_visible(false);
                                    menuItem.get_element().style.display = "none";
                                } else {
                                    menuItem.set_visible(true);
                                    menuItem.get_element().style.display = "";
                                    menuItem.set_enabled(tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true');

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
                                    if (tree.get_selectedNode().get_attributes().getAttribute("ObjectTypeId") == "0") {
                                        menuItem.set_visible(false);
                                        menuItem.get_element().style.display = "none";
                                    }
                                    else {
                                        menuItem.set_visible(true);
                                        menuItem.get_element().style.display = "";
                                        menuItem.set_enabled(tree.get_selectedNode().get_attributes().getAttribute("ManageFolder").toLowerCase() == 'true'
                                                             && tree.get_selectedNode().get_attributes().getAttribute("ObjectTypeId") != "0");
                                    }
                                }
                            }

                            break;
                        case "Delete":
                            var j = 0;
                            var enableDelete = false;
                            var hideDelete = false;
                            for (j = 0; j < nodes.length; j++) {
                                if (nodes[j].get_value().indexOf("P_") > -1 || nodes[j].get_value().indexOf("PC_") > -1 || nodes[j].get_value().indexOf("C_") > -1)
                                    hideDelete = true;
                                else if (nodes[j].get_value().indexOf("F_") > -1) {
                                    if (nodes[j].get_attributes().getAttribute("ManageFolder").toLowerCase() == 'false'
                                    || (nodes[j].get_attributes().getAttribute("IsSystem").toLowerCase() == 'true'
                                         && nodes[j].get_attributes().getAttribute("DeleteQuery").toLowerCase() == 'false')
                                    || (nodes[j].get_attributes().getAttribute("IsSystem").toLowerCase() == 'true'
                                         && tree.get_element().getAttribute("CanDelete").toLowerCase() == 'false'))
                                        enableDelete = true;

                                }
                                else if (nodes[j].get_value().indexOf("Q_") > -1) {
                                    if (tree.get_element().getAttribute("CanDelete").toLowerCase() == 'false'
                                       || nodes[j].get_attributes().getAttribute("DeleteQuery").toLowerCase() == 'false')
                                        enableDelete = true;

                                }

                                if (enableDelete || hideDelete)
                                    break;
                            }
                            menuItem.set_visible(!hideDelete);
                            if (hideDelete) {
                                menuItem.get_element().style.display = "none";
                            }
                            menuItem.set_enabled(!enableDelete);
                            break;

                        case "EditPermissions":
                            if (nodes.length > 1) {
                                menuItem.set_visible(false);
                                menuItem.get_element().style.display = "none";
                            } else {

                                menuItem.set_visible(true);
                                menuItem.get_element().style.display = "";
                                menuItem.set_enabled(
                                tree.get_selectedNode().get_attributes().getAttribute("EditPermissions").toLowerCase() == 'true');
                            }
                            break;
                    }
                }
            }
            function onClientContextMenuItemClicking(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();
                var tree = $find("<%= trvQueries.ClientID %>");
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
                    case "Delete":
                        result = confirm(QueryMsg_ConfirmDeleteFolder);
                        args.set_cancel(!result);
                        break;
                }
            }
            function addGroupNode() {
                var nodeText = "";
                var tree = $find("<%= trvQueries.ClientID %>");
                tree.trackChanges();

                //Instantiate a new client node
                var node = new Telerik.Web.UI.RadTreeNode();
                var parent = tree.get_selectedNode();
                //Set its value, text and image
                node.set_value("F_");
                node.set_text("");

                //Set IsNew attribute for checking on server side
                node.get_attributes().setAttribute("IsNew", "True")
                //Add the new node as the child of the selected node or the treeview if no node is selected
                //parent.expand();

                parent.get_nodes().add(node);
                node._addClassToContentElement("trvFolder")
                //Expand the parent if it is not the treeview
                if (parent != tree && !parent.get_expanded())
                    parent.set_expanded(true);
                node.set_selected(true);
                window.setTimeout(function () { node.startEdit(); }, 100);
                parent.set_selected(false);

                tree.commitChanges();
                return node;
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
            function droppedOnGroup(sender, args) {
                var dest = args.get_destNode();
                var nodes = args.get_sourceNodes();
                var target = args.get_htmlElement();
                if (dest) {
                    var destNodeValue = dest.get_attributes().getAttribute("ObjectTypeId");
                    var canaddReport = dest.get_attributes().getAttribute("AddQuery");
                    if (canaddReport == 'false') {
                        args.set_cancel(true);
                        return;
                    }
                    if (destNodeValue == "0") {
                        args.set_cancel(true);
                        return;
                    }
                    for (var i = 0; i < nodes.length; i++) {
                        if (nodes[i].get_attributes().getAttribute("ObjectTypeId") != destNodeValue) {
                            args.set_cancel(true);
                            return;
                        }
                    }
                    return;
                }
                args.set_cancel(false);
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
            function OnClientCollapsed(sender, ags) {
                $("#ctl00_CPH1_Splitter").addClass("removeLeft");
                setTimeout(FloatDivs, 100);
                setCookie('QueryViewerStatus', 'inline', 60);
            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_Splitter").removeClass("removeLeft");
                ClientResized(sender, ags);
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
            <%--     function ToggleAssetMenu() {
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

            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
            }
            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function check(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    if (vlue.indexOf("-1") > -1 && resultId != "-1") {
                        hdnField.value = ""
                        hdnNames.value = "";
                        vlue = "";
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() == "-1") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                                break;
                            }
                        }
                    }
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                    if (resultId == "-1") {
                        hdnField.value = resultId;
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() != "-1") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                            }
                        }
                    }
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];
                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }
            }
        </script>
    </telerik:RadCodeBlock>
    <%--<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>            
        
            <telerik:AjaxSetting AjaxControlID="btnPreview">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnPreview" />
                </UpdatedControls>
            </telerik:AjaxSetting>
           
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>

    <%--    <table style="width: 100%; padding: 0px; height: 50px;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr>
   
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True"
                    meta:resourcekey="mainToolBarResource1" CssClass="popup-toolbar">
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
    </table>--%>
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
        <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" CssClass="AssetSplitterPane" Width="30%" EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded" OnClientResized="AssetSplitterResized">

            <telerik:RadTreeView ID="trvQueries" runat="server" CssClass="AssetExplorerTree WhitePlusMinus TreeWithDarkBackground"
                MultipleSelect="true" EnableDragAndDrop="true" AllowNodeEditing="false" Style="height: calc(100% - 24px); padding: 24px 0 0 24px;"
                EnableEmbeddedSkins="false" CausesValidation="false"
                OnClientContextMenuShowing="onClientContextMenuShowing" OnClientNodeDropping="droppedOnGroup"
                OnClientContextMenuItemClicking="onClientContextMenuItemClicking">
                <ContextMenus>
                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                        <Items>
                            <telerik:RadMenuItem Value="Rename" Text="Rename" meta:ResourceKey="MenuItem_Rename" EnableImageSprite="true" CssClass="MenuRename">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="OpenReport" Text="Edit" meta:ResourceKey="MenuItem_Edit" EnableImageSprite="true" CssClass="MenuEdit">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="NewFolder" meta:ResourceKey="MenuItem_NewFolder" Text="New Folder"
                                EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="AddReport" meta:ResourceKey="MenuItem_AddReport" Text="Add Report"
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
        <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="AssetSplitterRightPane" OnClientResized="ClientResized">
             <table cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td valign="top" id="tdtbsDocument" runat="server">
                        <telerik:RadTabStrip ID="tbsDocument" runat="server" CausesValidation="False" EnableViewState="true"
                            meta:resourcekey="tbsDocumentResource1" MultiPageID="mlpReportManager" CssClass="documentTabs AssetExplorerVisible ReportManagerTop"
                            SelectedIndex="0" Skin="Default" Width="100%">
                            <Tabs>
                                <telerik:RadTab meta:resourcekey="tab_General" Text="General" Value="General" />
                                <telerik:RadTab meta:resourcekey="tab_Permissions" Text="Permissions" Value="Permissions" />
                            </Tabs>
                        </telerik:RadTabStrip>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadMultiPage ID="mlpReportManager" runat="server" RenderSelectedPageOnly="True" SelectedIndex="0" Width="100%" Style="margin-bottom: 24px !important;">
                              <telerik:RadPageView ID="pvGeneral" runat="server">
                                  <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar SmallToolbar">
                <tr>
                    <td class="ToolbarTd">
                        <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=173">
                                <div class="btnToolbarSearchDocument">
                                    &nbsp; 
                                </div>
                        </asp:LinkButton>
                    </td>
                    <td class="ToolbarTd Recent">
                        <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                    &nbsp; 
                                </div>
                        </asp:LinkButton>
                    </td>
                    <td style="width: 240px !important;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                       <telerik:RadComboBox ID="ddlQueries" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                            Skin="Default" Width="240px" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                            meta:resourcekey="ddlQueries" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" CheckForDirt="True">
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>
                    </td>
                    <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                        <telerik:RadToolBar ID="ReportToolBar" runat="server" Skin="Default" AutoPostBack="true">
                            <Items>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                    CausesValidation="false" CommandName="EditReport" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                    SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                                    <Buttons>
                                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                            CommandName="New" AccessKey="n" CausesValidation="false" PostBack="true">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton Width="150px" SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add" Visible="false"
                                            CommandName="Revise">
                                        </telerik:RadToolBarButton>
                                    </Buttons>
                                </telerik:RadToolBarSplitButton>

                                <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                    CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton IsSeparator="true" ></telerik:RadToolBarButton>
                                 <telerik:RadToolBarButton PostBack="true" CommandName="Print" ImageUrl="Images/ToolBar/Printer.png"
                                    SecurityButtonType="Read" CssClass="ToolbarPrint">
                                </telerik:RadToolBarButton>

                               <%-- <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CssClass="ToolbarToggle"
                                    CommandName="Toggle" Value="Toggle" Style="margin-right: 0px !important;">
                                </telerik:RadToolBarButton>--%>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                   <%-- <td style="width: 240px !important; padding-left: 0px !important" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                        <telerik:RadComboBox ID="ddlExtensions" runat="server" AllowCustomText="false"
                            Width="240px" NoWrap="true" CausesValidation="False" AutoPostBack="false">
                            <Items>
                                <telerik:RadComboBoxItem Text="CSV (Comma Delimited)" />
                                <telerik:RadComboBoxItem Text="MHTML (Web Archive)" />
                                <telerik:RadComboBoxItem Text="MS Excel" />
                                <telerik:RadComboBoxItem Text="MS Word" />
                                <telerik:RadComboBoxItem Text="PDF" />
                                <telerik:RadComboBoxItem Text="TIFF" />
                                <telerik:RadComboBoxItem Text="XML (With Report Data)" />
                            </Items>
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>
                    </td>--%>
                   
                    <td></td>
                </tr>
            </table>
                                  <div class="PMMainPage">
                <div class="row">
                    <div class="col-4 col-4-left">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblParameters" Text="Parameters" meta:resourcekey="lblParameters"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr id="trTitle" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTitle" runat="server" Text="Title*" meta:Resourcekey="lblTitle"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTitle" runat="server" MaxLength="30"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" CausesValidation="False"
                                            Height="300px" meta:Resourcekey="ddlProjects" OnItemsRequested="ddl_ItemsRequested"
                                            NoWrap="true" Skin="Default" Width="100%"  OnClientItemsRequesting="GetValueToReturn"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                             <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />

                                                    <%#DataBinder.Eval(Container, "Attributes['ProjectName']")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnIds" />
                                        <asp:HiddenField runat="server" ID="hddnNames" />
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:Resourcekey="rfvProgram"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr style="display:none">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCommitmentId" runat="server" Text="Commitment ID*" meta:Resourcekey="lblCommitmentId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="RadComboBox1" UseProjectFilter="1" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" Height="300px" meta:Resourcekey="ddlProjects"
                                            NoWrap="true" Skin="Default" Width="100%" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required" meta:Resourcekey="rfvProgram"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblRecap" Text="Recap" meta:resourcekey="lblRecap"></asp:Label>
                            </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReportName" runat="server" Text="Report Name" meta:Resourcekey="lblReportName"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtName" Enabled="false" MaxLength="200" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblSystemReport" runat="server" Text="System Report" meta:Resourcekey="lblSystemReport"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkSystemReport" runat="server"/>
                                </td>
                            </tr>
                             <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblOrientation" runat="server" Text="Orientation" meta:Resourcekey="lblOrientation"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtOrientation" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPageSize" runat="server" Text="Page Size" meta:Resourcekey="lblPageSize"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPageSize" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAssociatedWith" runat="server" Text="Associated With" meta:Resourcekey="lblAssociatedWith"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" ID="txtRecordType" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDefaultReport" runat="server" Text="Default Report?" meta:Resourcekey="lblDefaultReport"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkDefaultReport" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAuthoredBy" runat="server" Text="Authored By" meta:Resourcekey="lblAuthoredBy"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtAuthoredBy" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAdded" runat="server" Text="Added" meta:Resourcekey="lblAdded"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtAdded" runat="server" MaxLength="30" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                            </fieldset>
                    </div>
                </div>
            </div>
                              </telerik:RadPageView>
                             <telerik:RadPageView ID="pvPermissions" runat="server">
                                <uc1:QueryBuilderPermissions ID="QueryBuilderPermissions1"
                                    runat="server" />
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </td>
                </tr>
            </table>
            
            
           
        </telerik:RadPane>
    </telerik:RadSplitter>
</asp:Content>
