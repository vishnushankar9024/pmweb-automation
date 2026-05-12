<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="WBS.aspx.vb" Inherits="Website.WBS1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="WBSTemplate.ascx" TagName="WBSTemplate" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function click_handler(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'CopyWBS':
                        OpenCopyPopup();
                        break;

                    case 'Import':
                        OpenPOPUp('WBS_Import.aspx?SourceId=WBS_Import', 710, 590);
                        break;

                    default:
                        break;
                }
            }
            function SetFocus() {

                var tree = $find("ctl00_CPH1_rdvLocations")
                var selectedNode = tree.findNodeByValue("-1");
                if (selectedNode != null) {
                    selectedNode.scrollIntoView();
                }

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
                                    menuItem.set_enabled(tree.get_element().getAttribute("CanEdit").toLowerCase() == 'true' && nodes[0].get_value() > 0);
                                }
                                break;
                            case "DELETE":

                                var isProjectSelected = false;
                                var CanDelete = true;
                                for (var j = 0; j < nodes.length; j++) {
                                    if (nodes[j].get_value() == 0) {
                                        isProjectSelected = true;
                                        break;
                                    }
                                    if (nodes[j].get_attributes().getAttribute("CanDelete") == 'false') {
                                        CanDelete = false;
                                        break;
                                    }
                                }
                                menuItem.set_enabled(tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true' && isProjectSelected == false && CanDelete == true)
                        }
                    }
                }
            }

            function OnClientNodeClicking(sender, eventArgs) {
                var tree = $find("ctl00_CPH1_rdvLocations")
                var selectedNode = tree.findNodeByAttribute("IsInEditMode", "true");
                if (selectedNode != null) {
                    selectedNode.select();
                }
            }

            function RefreshWBS() {
                var btnHiddenButton = $("[id$=btnRefreshWBS]");
                if (btnHiddenButton != null) {
                    btnHiddenButton.click();
                }
            }

            function OpenCopyPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('CopyWBSPopup.aspx?ObjectType=WBS');
                wnd.add_close(CopyPopupClosed);
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

            function CopyPopupClosed() {
                var btnHiddenButton = $("[id$=RefreshPage]");
                if (btnHiddenButton != null) {
                    btnHiddenButton.click();
                }
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RamWorKOrderResource" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdvLocations">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdvLocations" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnCopy" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RefreshPage">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdvLocations" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="RefreshPage" />
                    <telerik:AjaxUpdatedControl ControlID="btnCopy" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr>
            <td class="ToolbarTd" valign="middle" style="width: 240px">
                <telerik:RadComboBox ID="ddlEntities" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                    EmptyMessage="Select..." Width="240px" AutoPostBack="True" AllowCustomText="true"
                    CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:Resourcekey="ddlEntities"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td  id="TdrdbWBS" runat="server" class="ToolbarTd" style="width: 250px">
                <b>
                    <asp:RadioButtonList ID="rdbWBS" Width="250px" runat="server" Height="15px" AutoPostBack="true" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Portfolio" meta:resourcekey="rdbPortfolio" Value="UsePortfolio"
                            Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Program" class="NoWrap" meta:resourcekey="rdbMapView" Value="UseProgram"></asp:ListItem>
                        <asp:ListItem Text="Project" class="NoWrap" meta:resourcekey="rdbReport" Value="CustomWBS"></asp:ListItem>
                    </asp:RadioButtonList>
                </b>
            </td>
            <td class="ToolbarTd" style="width:100%">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CopyWBS" ImageUrl="Images/ToolBar/Revision.png" PostBack="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarImport" ValidationGroup="Save" CommandName="Import" PostBack="false"></telerik:RadToolBarButton>
                        <%--      <telerik:RadToolBarSplitButton SecurityButtonType="Add" CommandName="Import" Enabled="true"
                            PostBack="false" EnableDefaultButton="false">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Records" CommandName="ImportRecords" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <div class="PMMainPage">
        <div class="row documentSinglePage">
            <div class="col-12">
                <telerik:RadTreeView ID="rdvLocations" runat="server" EnableDragAndDropBetweenNodes="true" EnableDragAndDrop="true" Width="100%" OnClientNodeClicked="OnClientNodeClicking"
                    MultipleSelect="true" OnClientContextMenuShowing="onClientContextMenuShowing">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                    <ContextMenus>
                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" CssClass="trvContextMenu">
                            <Items>
                                <telerik:RadMenuItem Value="AddChild" meta:resourcekey="MenuItem_AddChild" Text="Add WBS" EnableImageSprite="true" CssClass="MenuAdd">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="DELETE" meta:resourcekey="MenuItem_DELETE" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="Rename" meta:resourcekey="MenuItem_Rename" Text="Rename" EnableImageSprite="true" CssClass="MenuRename">
                                </telerik:RadMenuItem>
                            </Items>
                        </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                    <NodeTemplate>
                        <uc1:WBSTemplate ID="WBSTemplate1" runat="server" />
                    </NodeTemplate>
                </telerik:RadTreeView>
            </div>
        </div>
    </div>


    <%--<asp:Button runat="server" ID="btnRefreshWBS" CssClass="Hide" />--%>
    <asp:Button runat="server" ID="RefreshPage" CssClass="Hide" />
</asp:Content>
