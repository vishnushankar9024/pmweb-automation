<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="StageGateSetup.aspx.vb" Inherits="Website.StageGateSetup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script language="javascript" type="text/javascript">
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
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
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

            function onClientContextMenuShowing(sender, args) {
                var treeNode = args.get_node();
                treeNode.set_selected(true);
                setMenuItemsState(args.get_menu().get_items(), treeNode);
            }

            function setMenuItemsState(menuItems, treeNode) {
                var tree = $find("<%= trvStages.ClientID %>");
                var nodes = tree.get_selectedNodes();

                var isFolder = false;
                var isStage = false;
                var isActivity = false;
                if (tree.get_selectedNode().get_value().indexOf("F_") > -1)
                    isFolder = true;
                if (tree.get_selectedNode().get_value().indexOf("S_") > -1)
                    isStage = true;
                if (tree.get_selectedNode().get_value().indexOf("A_") > -1)
                    isActivity = true;
                for (var i = 0; i < menuItems.get_count() ; i++) {
                    var menuItem = menuItems.getItem(i);
                    //alert(menuItem.get_value());
                    switch (menuItem.get_value()) {
                        case "GoToStage":
                            if (nodes.length > 1) {
                                menuItem.set_enabled(false);
                                break;
                            }
                            if (isStage) {
                                menuItem.set_enabled(tree.get_element().getAttribute("CanNavigate").toLowerCase() == 'true');
                                break;
                            }
                            menuItem.set_enabled(false);
                            break;
                        case "AddStage":
                            if (nodes.length > 1) {
                                menuItem.set_enabled(false);
                                break;
                            }
                            if (isFolder) {
                                menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                                break;
                            }
                            menuItem.set_enabled(false);
                            break;
                        case "AddActivity":
                            if (nodes.length > 1) {
                                menuItem.set_enabled(false);
                            } else {
                                if (isFolder) {
                                    menuItem.set_enabled(false);

                                } else {

                                    if (isActivity) {
                                        menuItem.set_enabled(false);
                                    }
                                    else
                                        menuItem.set_enabled(tree.get_element().getAttribute("CanAdd").toLowerCase() == 'true');
                                }
                            }
                            break;
                        case "Edit":
                            if (nodes.length > 1) {
                                menuItem.set_enabled(false);
                            } else {
                                if (isFolder) {
                                    menuItem.set_enabled(false);
                                } else {
                                    menuItem.set_enabled(true);

                                }
                            }
                            break;

                        case "Delete":
                            var j = 0;
                            var enableDelete = false;
                            for (j = 0; j < nodes.length; j++) {
                                if (nodes[j].get_value().indexOf("F_") > -1)
                                    enableDelete = true;
                                if (enableDelete)
                                    break;
                            }
                            menuItem.set_enabled(!enableDelete && tree.get_element().getAttribute("CanDelete").toLowerCase() == 'true');
                            break;

                    }
                }

            }


            function onClientContextMenuItemClicking(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();
                var tree = $find("<%= trvStages.ClientID %>");
                treeNode.set_selected(true);
                menuItem.get_menu().hide();
                var isGrougSelected = false;
                var isItemSelected = false;
                var nodes = tree.get_selectedNodes();

                switch (menuItem.get_value()) {
                    case "GoToStage":
                        args.set_cancel(false);
                        break;
                    case "Edit":
                        args.set_cancel(false);
                        break;
                    case "AddStage":
                        treeNode.expand();
                        window.setTimeout(function () { addGroupNode(); }, 200);
                        args.set_cancel(true);
                        break;
                    case "AddActivity":
                        treeNode.expand();
                        window.setTimeout(function () { addActivity(); }, 200);
                        args.set_cancel(true);
                        break;
                    case "Delete":
                        result = confirm("Delete?");
                        args.set_cancel(!result);
                        break;

                }
            }

            function addGroupNode() {
                var nodeText = "";
                var tree = $find("<%= trvStages.ClientID %>");
                tree.trackChanges();

                //Instantiate a new client node
                var node = new Telerik.Web.UI.RadTreeNode();
                var parent = tree.get_selectedNode();
                //Set its value, text and image
                node.set_value("S_");
                node.set_text("");
                // node.set_imageUrl("Images/Toolbox/smallGate.png")
                //Set IsNew attribute for checking on server side
                node.get_attributes().setAttribute("IsNew", "True")
                //Add the new node as the child of the selected node or the treeview if no node is selected
                //parent.expand();

                parent.get_nodes().add(node);
                //node._addClassToContentElement("trvGateWhite");
                //Expand the parent if it is not the treeview
                if (parent != tree && !parent.get_expanded())
                    parent.set_expanded(true);
                node.set_selected(true);
                window.setTimeout(function () { node.startEdit(); }, 200);
                parent.set_selected(false);

                tree.commitChanges();
                return node;
            }



            function addActivity() {
                var nodeText = "";
                var tree = $find("<%= trvStages.ClientID %>");
                tree.trackChanges();

                //Instantiate a new client node
                var node = new Telerik.Web.UI.RadTreeNode();
                var parent = tree.get_selectedNode();
                //Set its value, text and image
                node.set_value("A_");
                node.set_text("");
                //   node.set_imageUrl("Images/Toolbox/smallDocument.png")
                //Set IsNew attribute for checking on server side
                node.get_attributes().setAttribute("IsNew", "True")
                //Add the new node as the child of the selected node or the treeview if no node is selected
                //parent.expand();

                parent.get_nodes().add(node);
                //node._addClassToContentElement("trvDocument")
                //Expand the parent if it is not the treeview
                if (parent != tree && !parent.get_expanded())
                    parent.set_expanded(true);
                node.set_selected(true);
                window.setTimeout(function () { node.startEdit(); }, 200);
                parent.set_selected(false);

                tree.commitChanges();
                return node;
            }

            function OpenMultipleCompanyFilterPopupFromStageGate(hdnIds, ddlId, hdnNames, ProjectId) {
                var left = (screen.width - 568) / 2;
                var top = (screen.height - 300) / 2;
                var win = OpenPOPUp('CompaniesFilterPopup.aspx?hdnIds=' + hdnIds + '&ddlId=' + ddlId + '&Type=Contacts' + '&hdnNames=' + hdnNames + '&ddlType=Multiple' + '&ProjectRequired=0' + '&ProjectId=' + ProjectId, '',
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                return false;
            }

            function OpenCompanyFilterPopupForFromStageGate(ddlControlId, ddlId, Type, ProjectRequired, ProjectId) {
                var left = (screen.width - 920) / 2;
                var top = (screen.height - 300) / 2;
                var win = OpenPOPUp('CompaniesFilterPopup.aspx?ControlId=' + ddlControlId + '&ddlId=' + ddlId + '&Type=' + Type + '&ProjectRequired=' + ProjectRequired + '&ProjectId=' + ProjectId, '',
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                return false;
            }
            var mainsplitter = null;
            function onResized(sender, ags) {
                mainsplitter = sender;

            }
            function OnClientExpanded(sender, ags) {
                $("#ctl00_CPH1_Splitter").removeClass("removeLeft");
            }
            function OnClientCollapsed(sender, ags) {
                $("#ctl00_CPH1_Splitter").addClass("removeLeft");
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
            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 10);
            }


        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="trvStages">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvStages" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlStage" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlActivity" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSaveStage">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvStages" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlStage" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlActivity" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSaveActivity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="trvStages" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlStage" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlActivity" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style type="text/css">
        .maxWidth {
            max-width: 250px;
        }

        div#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_treeGroupsAndItemsPane {
            background-color: #666;
        }

        .RadTreeView_Default .rtPlus, .RadTreeView_Default .rtMinus {
            background-image: url(CSS/Images/PlusMinusWhite.png) !important;
        }

        /*.trvProject .rtSp, .trvPBSProject .rtSp {
            background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
            width: 16px !important;
            height: 22px !important;
            margin-left: -3px !important;
            margin-right: -14px !important;
            background-position: -1552px 0px;
            background-repeat: no-repeat;
            margin-top: 2px;
        }*/

        .removeLeft {
            left: 0 !important;
        }

        .AssetSplitterRightPane {
            height: calc(100vh - 84px) !important;
        }

        .AssetSplitterPane {
            height: calc(100vh - 84px) !important;
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .AssetSplitterPane {
                height: calc(100vh - 84px) !important;
                max-height: calc(100vh - 50px) !important;
                top: 50px;
            }

            .AssetSplitterRightPane {
                width: calc(100vw - 3px) !important;
            }

            .ReportManagerTree {
                height: calc(100vh - 84px) !important;
                max-height: calc(100vh - 50px) !important;
                top: 50px;
            }

            .AssetSplitter {
                top: 50px !important;
                height: calc(100vh - 84px) !important;
                max-height: calc(100vh - 50px) !important;
            }
        }

        .ReportManagerTabs .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .ReportManagerTabs li {
            width: calc(50% - 8px) !important;
        }

        @media screen and (min-width:844px) {
            .SplitterHeight {
                height: calc(100vh - 110px) !important;
                margin-bottom: 0 !important;
            }
        }
    </style>
    <table style="width: 100%;" cellspacing="0" cellpadding="0" border="0" runat="server" id="tblStageGatesSetup">
        <tr class="ToolBar">
            <td style="width: 240px" class="ToolbarTd">
                <telerik:RadComboBox ID="ddlEntities" runat="server" AllowCustomText="true" Skin="Default" CssClass="maxWidth"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="-- Portfolio --"
                    Width="100%" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" CheckForDirt="True"
                    OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <div id="maindiv" runat="server" class="SplitterHeight">
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="AssetExplorerVerticalSplitter documentSinglePage SplitterHeight" SplitBarsSize="" OnClientLoad="onResized">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" CssClass="NormalWhiteBack AssetSplitterPane" Style="position: fixed; background-color: #666 !important; height: 100% !important; top: 0;"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" MaxWidth="400" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded" OnClientResized="ClientResized">
                <telerik:RadTreeView ID="trvStages" runat="server" MultipleSelect="true" Width="100%" CssClass=" ReportManagerTree WhitePlusMinus"
                    EnableDragAndDrop="false" CausesValidation="False" Style="color: #ffffff; background-color: #666666;"
                    OnClientContextMenuShowing="onClientContextMenuShowing" OnClientContextMenuItemClicking="onClientContextMenuItemClicking">
                    <ContextMenus>
                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                            <Items>
                                <telerik:RadMenuItem Value="Edit" meta:Resourcekey="MenuItem_Edit" Text="Edit" EnableImageSprite="true" CssClass="MenuEdit"></telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="AddStage" meta:Resourcekey="MenuItem_AddStage" Text="Add Stage" EnableImageSprite="true" CssClass="MenuStage"></telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="AddActivity" meta:Resourcekey="MenuItem_AddActivity" Text="Add Activity" EnableImageSprite="true" CssClass="MenuDocument"></telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="GoToStage" meta:Resourcekey="MenuItem_GoToStage" Text="Go to Stage" EnableImageSprite="true" CssClass="MenuGoToDocument"></telerik:RadMenuItem>
                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                <telerik:RadMenuItem Value="Delete" meta:Resourcekey="MenuItem_Delete" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete"></telerik:RadMenuItem>
                            </Items>
                        </telerik:RadTreeViewContextMenu>
                    </ContextMenus>
                </telerik:RadTreeView>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="AssetSplitter" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" CssClass="AssetSplitterRightPane" Skin="Default" OnClientResized="ClientResized">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4">
                            <asp:Panel runat="server" ID="pnlStage">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblStageDefaults" runat="server" CssClass="legend" Text="Stage Defaults" meta:resourcekey="lblStageDefaults"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblStageDescription" runat="server" meta:resourcekey="lblStageDescription" Text="Stage Description" />
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtStageDescription" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfvStage" runat="server" ValidationGroup="Save" ControlToValidate="txtStageDescription"
                                                    CssClass="Validator" Display="Dynamic" ErrorMessage="Required."
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <div style="float: left">
                                                    <asp:Label ID="lblGtKeeper" runat="server" meta:resourcekey="lblGKeeper" Text="Gate Keeper" />
                                                </div>
                                                <div style="float: right">
                                                    <asp:LinkButton runat="server" ID="imgfilter2" CssClass="SearchButton">
                                                                <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlGateKeeper" runat="server"
                                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                    NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                    OnClientDropDownClosed="dllcompClientClosed"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested"
                                                    Style="font-size: 11px" Height="250px">
                                                    <HeaderTemplate>
                                                        <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 65%;">
                                                                    <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                                <td style="width: 35%">
                                                                    <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="width: 100%" cellspacing="0" cellpadding="2">
                                                            <tr>
                                                                <td style="width: 65%;">
                                                                    <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                                </td>
                                                                <td style="width: 35%;">
                                                                    <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblType" runat="server" meta:resourcekey="lblType" Text="Type" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblStageDuration" runat="server" meta:resourcekey="lblStageDuration" Text="Duration" />
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtStageDuration" CssClass="PositiveDouble" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblStageDurationUOM" runat="server" meta:resourcekey="lblStageDurationUOM" Text="Duration UOM" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlStageDuration" runat="server" Skin="Default" AllowCustomText=""  Filter="Contains" MarkFirstMatch="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Days" meta:resourcekey="ListItem_Days" Value="Days" />
                                                        <telerik:RadComboBoxItem Text="Months" meta:resourcekey="ListItem_Months" Value="Months" />
                                                        <telerik:RadComboBoxItem Text="Quarters" meta:resourcekey="ListItem_Quarters" Value="Quarters" />
                                                        <telerik:RadComboBoxItem Text="Weeks" meta:resourcekey="ListItem_Weeks" Value="Weeks" />
                                                        <telerik:RadComboBoxItem Text="Years" meta:resourcekey="ListItem_Years" Value="Years" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <%-- <tr>
                                                        <td></td>
                                                        <td>
                                                            <asp:Button runat="server" ValidationGroup="Save" meta:resourcekey="btnSaveStage" ID="btnSaveStage" Text="Save" />
                                                        </td>
                                                    </tr>--%>
                                    </table>

                                </fieldset>


                            </asp:Panel>
                            <br />
                            <asp:Panel runat="server" ID="pnlActivity">

                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblActivityDefaults" runat="server" CssClass="legend" Text="Activity Defaults" meta:resourcekey="lblActivityDefaults"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblActivityDescription" runat="server" meta:resourcekey="lblActivityDescription" Text="Activity Description" />
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtActivityDescription" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfvActivity" runat="server" ValidationGroup="SaveActivity" ControlToValidate="txtActivityDescription"
                                                    CssClass="Validator" Display="Dynamic" ErrorMessage="Required."
                                                    ForeColor=""></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblRecordType" runat="server" meta:resourcekey="lblRecordType" Text="Record Type" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlRecordType" runat="server"
                                                    EmptyMessage="Select " Skin="Default" CloseDropDownOnBlur="true"
                                                    NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True"
                                                    ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested"
                                                    Style="font-size: 11px" Height="250px">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <div style="float: left">
                                                    <asp:Label ID="lblResponsible" runat="server" meta:resourcekey="lblResponsible" Text="Responsible" />
                                                </div>
                                                <div style="float: right">
                                                    <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton">
                                        <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlResponsible" runat="server"
                                                    Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>' DropDownWidth="385px"
                                                    NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                    Style="font-size: 11px" Height="250px">
                                                    <HeaderTemplate>
                                                        <table style="width: 395px" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td style="width: 10px;"></td>
                                                                <td style="width: 250px;">
                                                                    <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                                <td style="width: 135px;">
                                                                    <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                            </tr>
                                                        </table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                                            <table style="width: 395px" cellspacing="0" cellpadding="2">
                                                                <tr>
                                                                    <td style="width: 10px;">
                                                                        <asp:CheckBox runat="server" ID="chk"></asp:CheckBox>
                                                                    </td>
                                                                    <td style="width: 250px;">
                                                                        <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                                    </td>
                                                                    <td style="width: 135px;">
                                                                        <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                                <asp:HiddenField runat="server" ID="hddnIds" />
                                                <asp:HiddenField runat="server" ID="hddnNames" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblActivityDuration" runat="server" meta:resourcekey="lblActivityDuration" Text="Duration" />
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtActivityDuration" CssClass="PositiveDouble" runat="server" />
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblActivityDurationUOM" runat="server" meta:resourcekey="lblActivityDurationUOM" Text="Duration UOM" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlActivityDuration" runat="server" Skin="Default" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Days" meta:resourcekey="ListItem_Days" Value="Days" />
                                                        <telerik:RadComboBoxItem Text="Months" meta:resourcekey="ListItem_Months" Value="Months" />
                                                        <telerik:RadComboBoxItem Text="Quarters" meta:resourcekey="ListItem_Quarters" Value="Quarters" />
                                                        <telerik:RadComboBoxItem Text="Weeks" meta:resourcekey="ListItem_Weeks" Value="Weeks" />
                                                        <telerik:RadComboBoxItem Text="Years" meta:resourcekey="ListItem_Years" Value="Years" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <%--   <tr>
                                <td></td>
                                <td>
                                    <asp:Button runat="server" ValidationGroup="SaveActivity" ID="btnSaveActivity" meta:resourcekey="btnSaveActivity" Text="Save" />
                                </td>
                            </tr>--%>
                                    </table>
                                </fieldset>


                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
    </div>
</asp:Content>
