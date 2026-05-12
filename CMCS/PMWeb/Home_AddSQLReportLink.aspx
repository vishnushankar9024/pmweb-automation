<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="Home_AddSQLReportLink.aspx.vb" Inherits="Website.Home_AddSQLReportLink" %>

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
                var tree = $find("<%= treeReports.ClientID %>");
                treeNode.set_selected(true);
                menuItem.get_menu().hide();
                var isGrougSelected = false;
                var isItemSelected = false;
                var nodes = tree.get_selectedNodes();
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

            function SaveClicked(ReportId, ProjectIds, Path) {
                var txtReportId = window.parent.document.getElementById(querySt('txtReportId'));
                var txtProjectId = window.parent.document.getElementById(querySt('txtProjectId'));
                var txtPath = window.parent.document.getElementById(querySt('txtUrl'));
                txtReportId.value = ReportId;
                txtProjectId.value = ProjectIds;
                txtPath.value = Path;
                window.close();
                return false;
            }

            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
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
        .documentSplitter{padding-top:50px;}
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
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" 
            SplitBarsSize="">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" CssClass="NormalWhiteBack SplitterPanePopup" Style="position: fixed; background: white; top: 0; height: 100%;"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" OnClientExpanded="ClientResized">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td colspan="2" class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px" CssClass="ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel TreeToolbarCancel ShowOnMobile" Style="right: auto; margin-left: 16px" Height="50px" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>

                        </td>
                    </tr>
                </table>
                <telerik:RadTreeView ID="treeReports" runat="server" ShowLineImages="false"
                    MultipleSelect="true"  AllowNodeEditing="false" OnClientContextMenuItemClicking="onClientContextMenuItemClicking"
                    OnClientContextMenuShowing="onClientContextMenuShowing" EnableEmbeddedSkins="false" CausesValidation="false" CssClass="treePaddingOnMobile treeReports WhitePlusMinus">
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
                <asp:Panel ID="pnlInput" runat="server">

                    <div class="PMMainPage PMPopupMainPage">
                        <div class="row">
                            <div class="col-4">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblReportName" meta:resourcekey="lblReportName" runat="server" Text="Report Name*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtReportName" MaxLength="100" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-8">
                                <table class="colTable" border="0">
                                    <tr id="trParameters" runat="server">
                                        <td colspan="2">
                                            <asp:Panel ID="pnlParameters" runat="server">
                                                <fieldset style="width: 100%">
                                                    <legend>
                                                        <asp:Label ID="lblProjectParameters" runat="server" Text="Projects" meta:Resourcekey="lblProjectParameters"></asp:Label>
                                                    </legend>
                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="ldpPM">
                                                        <asp:DataList ID="dtlParamters" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Table" Width="99%" ItemStyle-VerticalAlign="Top">
                                                            <ItemTemplate>
                                                                <table style="width: 100%; vertical-align: text-top; text-align: center" border="0">
                                                                    <tr>
                                                                        <td valign="top" align="left">
                                                                            <input type="hidden" id="hdId" runat="server" value='<%#Container.DataItem("Id")%>' />
                                                                            <telerik:RadTextBox ID="txtParameterValues" runat="server" Width="99%">
                                                                            </telerik:RadTextBox>
                                                                            <telerik:RadListBox ID="rlbParameterValuesFrom" runat="server" Width="220px" Height="200px" Skin="Default"
                                                                                SelectionMode="Multiple" AllowTransfer="true" TransferToID="rlbParameterValuesTo" AutoPostBackOnTransfer="true"
                                                                                AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true">
                                                                            </telerik:RadListBox>
                                                                            <telerik:RadListBox ID="rlbParameterValuesTo" OnClientLoad="rlbParameterValuesTo_Load" runat="server" Width="220px" Height="200px" Skin="Default"
                                                                                SelectionMode="Multiple" AllowReorder="false" AutoPostBackOnReorder="false" EnableDragAndDrop="true"
                                                                                OnInserted="rlbParameterValuesTo_Inserted" OnDeleted="rlbParameterValuesTo_Deleted">
                                                                            </telerik:RadListBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                            <ItemStyle VerticalAlign="Top" />
                                                        </asp:DataList>
                                                    </telerik:RadAjaxPanel>
                                                </fieldset>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" id="hdSelectedReport" runat="server" />
                                <telerik:RadAjaxLoadingPanel ID="ldpReportManager" runat="server" Skin="Default" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlBIReport" runat="server" Visible="false">
                        <div class="PMMainPage" style="padding-top:60px">
                            <div class="row">
                                <div class="col-12">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="BIReportName" meta:resourcekey="lblBIReportName" runat="server" Text="Name"></asp:Label>
                                            </td>
                                            <td class="labelWidth">
                                                <asp:Label ID="BIReportNameText"  runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="URL" meta:resourcekey="lblURL" runat="server" Text="URL"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                               <asp:Label ID="URlText"  runat="server" Text="URL"></asp:Label>
                                            </td>
                                        </tr>
                                       
                                          <%--   <tr>
                                            <td class="labelWidth"></td>
                                            <td class="controlWidth" style="padding-top:25px">
                                              
                                                            <asp:Button ID="btnRun" meta:Resourcekey="btnRun" runat="server" Text="Run" Width="245px" onclientclick="RunPowerBIReport('')" />
                                                        
                                            </td>
                                        </tr>--%>
                                       
                                    </table>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />

    </form>
</body>
</html>
