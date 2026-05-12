<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PBS.aspx.vb" Inherits="Website.PBS" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PBSTemplate.ascx" TagName="PBSTemplate" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function click_handler(sender, args) {
                switch (args.get_item().get_commandName()) {
                    //case 'CopyWBS':
                    //    OpenCopyPopup();
                    //    break; 
                    case 'Import':
                        OpenPOPUp('PBS_Import.aspx?SourceId=PBS_Import', 710, 590);
                        break;

                    default:
                        break;
                }
            }
            function SetFocus(Value) {
                var tree = $find("ctl00_CPH1_rdvPBS")
                var selectedNode = tree.findNodeByValue(Value);
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
                var tree = $find("ctl00_CPH1_rdvPBS")
                var selectedNode = tree.findNodeByAttribute("IsInEditMode", "true");
                if (selectedNode != null) {
                    selectedNode.select();
                }
            }

            function OnClientNodeDragging(sender, eventArgs) {
                var tree = $find("ctl00_CPH1_rdvPBS")

                //if (parseInt(tree._sourceDragNodes[0]._getData().value)) {
                //    tree.set_enableDragAndDropBetweenNodes(tree._enableDragAndDrop);
                //}
                //else {
                tree.set_enableDragAndDropBetweenNodes(false);
                //}
            }



            //function OpenCopyPopup() {
            //    var wnd = window.radopen('CopyWBSPopup.aspx?ObjectType=WBS');
            //    wnd.setSize(380, 357);
            //    wnd.add_close(CopyPopupClosed);
            //    wnd.Center();
            //    return false;
            //}

            //function CopyPopupClosed() {
            //    var btnHiddenButton = $("[id$=RefreshPage]");
            //    if (btnHiddenButton != null) {
            //        btnHiddenButton.click();
            //    }
            //}

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RamPBS" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdvPBS">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdvPBS" LoadingPanelID="ldpPM" />
                    <%--<telerik:AjaxUpdatedControl ControlID="btnCopy" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr>
            <%--                <td>              
                <telerik:RadComboBox ID="ddlEntities" Runat="server"  Skin="Default" CloseDropDownOnBlur="true" 
                        EmptyMessage="Select..." Width="200px" AutoPostBack="True" AllowCustomText="true" DropDownWidth="300px"
                        CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"         
                        ShowMoreResultsBox="True" EnableLoadOnDemand="true"  meta:Resourcekey="ddlEntities"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">                                                               
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
                </td>
                <td    style="padding-top:10px;height:15px" >
                    <b>
                        <asp:RadioButtonList ID="rdbWBS" Width="250px"  runat="server" Height="15px" AutoPostBack="true" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Portfolio" meta:resourcekey="rdbPortfolio" Value="UsePortfolio"
                                Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Program" class="NoWrap"  meta:resourcekey="rdbMapView" Value="UseProgram"></asp:ListItem>
                        <asp:ListItem Text="Project" class="NoWrap" meta:resourcekey="rdbReport" Value="CustomWBS"></asp:ListItem>
                         
                        </asp:RadioButtonList>
                    </b>
                    <br />
                </td>--%>
            <td class="ToolbarTd" valign="middle">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default">
                    <Items>
                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarImport" ValidationGroup="Save" CommandName="Import"></telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CopyWBS" ImageUrl="Images/ToolBar/Revision.png"  PostBack="false"></telerik:RadToolBarButton>--%>
                        <%-- <telerik:RadToolBarSplitButton EnableImageSprite="true" SecurityButtonType="Add" CommandName="SaveExit" Enabled="true" CssClass="ToolbarSaveAndExit"
                            PostBack="false" EnableDefaultButton="false" Value="SaveExit">
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
        <div class="row ">
            <div class="col-12" >
                <telerik:RadTreeView ID="rdvPBS" runat="server" EnableDragAndDropBetweenNodes="false" EnableDragAndDrop="true" Width="100%"
                    OnClientNodeClicked="OnClientNodeClicking" OnClientNodeDragging="OnClientNodeDragging" CssClass="WhiteTree"
                    MultipleSelect="true" OnClientContextMenuShowing="onClientContextMenuShowing">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                    <ContextMenus>
                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" CssClass="trvContextMenu">
                            <Items>
                                <telerik:RadMenuItem Value="AddChild" meta:resourcekey="MenuItem_AddChild" Text="Add PBS1" EnableImageSprite="true" CssClass="MenuAdd">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="DELETE" meta:resourcekey="MenuItem_DELETE" Text="Delete1" EnableImageSprite="true" CssClass="MenuDelete">
                                </telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="Rename" meta:resourcekey="MenuItem_Rename" Text="Rename1" EnableImageSprite="true" CssClass="MenuRename">
                                </telerik:RadMenuItem>
                            </Items>
                        </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                    <NodeTemplate>
                        <asp:PlaceHolder runat="server" ID="nodeTemplate"></asp:PlaceHolder>
                    </NodeTemplate>
                </telerik:RadTreeView>
            </div>
        </div>
    </div>


    <asp:Button runat="server" ID="RefreshPage" CssClass="Hide" />
</asp:Content>
