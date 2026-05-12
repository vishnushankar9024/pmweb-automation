<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="Home_AddPMWebReportLink.aspx.vb" Inherits="Website.Home_AddPMWebReportLink" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="Server">
        <script language="javascript" type="text/javascript">

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('treeGroupsAndItemsPane');
                pane.set_visible(false);
                openDivByCommandName(value);
            }

            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                $('#hdnopenDiv').val(value)
                openDivByCommandName(value)
            }

            function openDivByCommandName(value) {
                switch (value) {
                    case 'ToggleSplitter':
                        var pane = $find('treeGroupsAndItemsPane');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";


                        break;
                }
            }

            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    var pane = $find('treeGroupsAndItemsPane');
                    pane.set_visible(false);
                    $('#hdnopenDiv').val('')
                    return false;
                }
            }

            function ClientResized(sender, ags) {

                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                var pane2Td = pane2._element;
                pane2.set_width(splitter.get_width() - pane1Td.clientWidth - 10);


            }

            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                setMenuItemsState(args.get_menu().get_items(), treeNode);
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
                //            switch (menuItem.get_value()) {
                //                case "Rename":
                //                    treeNode.startEdit();
                //                    args.set_cancel(true);
                //                    break;
                //                case "NewFolder":
                //                    treeNode.expand();
                //                    window.setTimeout(function() { addGroupNode(); }, 200);
                //                    args.set_cancel(true);
                //                    break;
                //                case "Delete":
                //                    result = confirm(QueryMsg_ConfirmDeleteFolder);
                //                    args.set_cancel(!result);
                //                    break;

                //            }
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
            function refreshLinkGrid() {
                var btn = window.parent.$("[id$=btnRebindLinkGrid]")[0];
                window.close();
                if (btn != null) {
                    btn.click();
                    //                   var refreshbtn=window.opener.document.getElementById(btn.id)
                    //                if(refreshbtn!=null)
                    //                    refreshbtn.click();
                    //                }
                }

            }
        </script>
    </telerik:RadCodeBlock>

    <style type="text/css">
        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 52px) !important;
        }

        .treeReports {
            color: #ffffff !important;
            background-color: #666666 !important;
            overflow: auto;
        }

        div#RAD_SPLITTER_PANE_CONTENT_treeGroupsAndItemsPane {
            background-color: #666666 !important;
        }

        .documentSplitter {
            padding-top: 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <div style="height: 100%">
            <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </div>


        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass=""
            SplitBarsSize="">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" CssClass="NormalWhiteBack SplitterPanePopup" Style="position: fixed; background: white; top: 0; height: 100%;"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" OnClientExpanded="ClientResized">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td colspan="2" class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px" CssClass="ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" Style="right: auto; margin-left: 16px" Height="50px" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>

                        </td>
                    </tr>
                </table>

                <telerik:RadTreeView ID="trvQueries" runat="server" Height="370px" Width="300px"
                    MultipleSelect="true" AllowNodeEditing="false"
                    EnableEmbeddedSkins="false" CausesValidation="false" ShowLineImages="false"
                    OnClientContextMenuShowing="onClientContextMenuShowing" OnClientNodeDropping="droppedOnGroup"
                    OnClientContextMenuItemClicking="onClientContextMenuItemClicking" CssClass="treePaddingOnMobile treeReports WhitePlusMinus AssetExplorerTree TreeWithDarkBackground">
                    <ContextMenus>
                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default">
                        </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="TreeToolbarSplitbar" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="fullWidthPane" OnClientResized="ClientResized">

                <div class="PMMainPage PMPopupMainPage">
                    <div class="row">
                        <div class="col-4">
                            <table id="tblQuery1" class="colTable" border="0">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblQueryCode" runat="server" Text="Query ID*" meta:resourcekey="lblQueryCode"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtQueryCode" Enabled="false" MaxLength="200" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" runat="server" Text="Name" meta:resourcekey="lblName"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtName" Enabled="false" MaxLength="200" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-8">
                            <table border="0" runat="server" id="tblQuery" class="colTable">
                                <tr valign="top">
                                    <td></td>
                                </tr>
                                <tr id="trParameters" runat="server">
                                    <td>
                                        <asp:Panel ID="pnlParameters" runat="server">
                                            <fieldset style="width: 100%">
                                                <legend>
                                                    <asp:Label ID="lblProjectParameters" runat="server" Text="Projects" meta:Resourcekey="lblProjectParameters"></asp:Label></legend>
                                                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="ldpPM">
                                                    <table style="width: 99%; vertical-align: text-top; text-align: center" border="0">
                                                        <tr>
                                                            <td valign="top" align="left">
                                                                <telerik:RadListBox ID="rlbParameterValuesFrom" runat="server" Width="225px" Height="200px" Skin="Default"
                                                                    SelectionMode="Multiple" AllowTransfer="true" TransferToID="rlbParameterValuesTo" AutoPostBackOnTransfer="true"
                                                                    AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true">
                                                                </telerik:RadListBox>
                                                                <telerik:RadListBox ID="rlbParameterValuesTo" runat="server" Width="220px" Height="200px" Skin="Default"
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
                            </table>

                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />

    </form>
</body>
</html>
