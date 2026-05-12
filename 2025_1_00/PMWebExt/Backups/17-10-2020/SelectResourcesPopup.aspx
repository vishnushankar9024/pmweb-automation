<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SelectResourcesPopup.aspx.vb" Inherits="Website.SelectResourcesPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:radcodeblock id="CodeBlock" runat="server">
        <script type="text/javascript">
            var gridId = "rpnResourcesGrid";

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('rpnLaborsTree');
                pane.set_visible(false);
                openDivByCommandName(value);
            }

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
            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    $('#hdnopenDiv').val('');
                    var pane = $find('rpnLaborsTree');
                    pane.set_visible(false);
                    return false;
                }
            }
            function onNodeDragging(sender, args) {
                var target = args.get_htmlElement();
                if (!target) return;
                if (target.tagName == "INPUT") {
                    target.style.cursor = "hand";
                }
                var grid = isMouseOverGrid(target)

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
            function EquipClicked(sender, args) {
                if ($("input[id=chkIncludeLaborResources]")[0].checked) {
                    var node = args.get_node();
                    if (node.get_value().indexOf("E") != 0) {
                        return;
                    }
                    var Childs = node.get_nodes();
                    var count = Childs.get_count() - 1;
                    var i = 0;
                    for (i = 0; i <= count; i++) {
                        Childs.getNode(i).select()
                    }
                }
            }
            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                $('#hdnopenDiv').val(value)
                openDivByCommandName(value)
            }

            function openDivByCommandName(value) {
                switch (value) {
                    case 'ToggleSplitter':
                        var pane = $find('rpnLaborsTree');
                        if (pane.get_visible()) {
                            pane.set_visible(false);
                        }
                        else {
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block"
                        }
                        break;
                }
            }

            function ShowHidebtnEquipmentTreeDropItems(sender, args) {
                if (sender.get_checkedNodes().length > 0) {
                    $("[id$=btnEquipmentTreeDropItems]").removeClass("Hide");
                }
                else
                    $("[id$=btnEquipmentTreeDropItems]").addClass("Hide");
            }
        </script>


<style type="text/css">
    @media screen and (min-width:844px) {
        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 55px) !important;
        }

        .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .SelectResourcesPopupTbas li {
            width: calc(50% - 8px) !important;
        }

        #rpnLaborsTree {
            position: relative;
        }
    }

    @media screen and (min-width:320px) and (max-width:843px) {
        .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left: 16px !important;
            margin-right: 16px !important;
        }

        div#rtvLabors {
            max-height: none !important;
        }

        div#rtvEquipment {
            max-height: none !important;
        }

        .RadTreeView.CheckBoxesTreeview label .rtChk {
            margin-left: 17px !important;
            margin-right: -10px !important;
        }
    }

    .RadToolBar_Horizontal .rtbItem:first-child {
        margin-left: 24px !important;
    }
    .ToolBarTreePane .txtSearch {
        margin: 8px;
        width: 395px;
        padding-left: 22px !important;
    }

    .SearchIcon {
        background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png);
        background-position: -144px 0;
        width: 16px;
        height:16px;
        position: absolute;
        left: 12px;
        top: 12px;
    }
</style>
      </telerik:radcodeblock>
        <telerik:radajaxmanager id="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="chkIncludeLaborResources">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="chkIncludeLaborResources" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvEquipment">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvLabors">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnEquipmentTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                 <telerik:AjaxSetting AjaxControlID="btnLaborTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLabors" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                               <telerik:AjaxSetting AjaxControlID="EQuTreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvEquipment" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgResources">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgResources" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:radajaxmanager>
        <telerik:radajaxloadingpanel id="ldpItems" runat="server" skin="Default" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="left">
                    <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="true" height="50px" width="100%" cssclass="popup-toolbar" onclientbuttonclicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" Height="50px" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" Height="50px" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:radtoolbar>
                </td>
            </tr>
        </table>
        <telerik:radsplitter id="RadSplitter1" runat="server" skin="Default" width="100%" splitbarssize="">
            <telerik:RadPane ID="rpnLaborsTree" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                             <telerik:RadToolBar ID="EQuTreeToolbar" Visible="false" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
               
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;" class="treePaddingOnMobile">
                    <tr>
                        <td>
                            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1" runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" CausesValidation="False">
                                <Tabs>
                                    <telerik:RadTab Value="TabLabor" Text="labor" meta:resourcekey="Tab_labor" Selected="true" />
                                    <telerik:RadTab Value="TabEquipment" Text="Equipment" meta:resourcekey="Tab_Equipment" />
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadMultiPage Style="" ID="mlpList" runat="server" SelectedIndex="1" Width="100%" RenderSelectedPageOnly="True">
                                <telerik:RadPageView ID="pvLabor" runat="server" Selected="true">
                                    <table class="TableNoSpacingNoBorder">
                                        <tr class="ToolBarTreePane">
                                            <td colspan="2" style="position:relative;">
                                                <span class="SearchIcon"></span>
                                                <asp:TextBox ID="txtLaborsSearch" CssClass="txtSearch" runat="server" AutoPostBack="true"/>
                                            </td>
                                        </tr>
                                        <tr class="ToolBarTreePane">
                                            <td valign="middle" class="labelWidth" style="background: transparent !important; padding-left: 8px;box-sizing:border-box;">
                                                <asp:Label ID="lblGroupBy" runat="server" Text="Group By" meta:ResourceKey="lblGroupBy"></asp:Label>
                                            </td>
                                            <td class="controlWidth" style="background: #EDEDED !important;">
                                                <telerik:RadComboBox ID="ddlGroupBy" runat="server" AutoPostBack="true" Style="width: 240px !important; margin-bottom:8px;">
                                                    <Items>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemNone" Value="None" Text="None1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemCompany" Value="Company" Text="Company1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemContact" Value="Contact" Text="Contact1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemResourceGroup" Value="ResourceGroup" Text="ResourceGroup1"></telerik:RadComboBoxItem>
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="100%"></td>
                                        </tr>
                                    </table>
                                    <div style="padding-top:5px">
                                              <telerik:RadTreeView ID="rtvLabors" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="True" CheckBoxes="true" TriStateCheckBoxes="true"
                                                    OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                                    <CollapseAnimation Duration="100" Type="OutQuint" />
                                                </telerik:RadTreeView>
                                                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                                    <div class="btnTreeDropItems">&nbsp;</div>
                                                </asp:LinkButton>
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvEquipment" runat="server">
                                    <table class="TableNoSpacingNoBorder">
                                        <tr class="ToolBarTreePane">
                                            <td colspan="2" style="position:relative;">
                                                <span class="SearchIcon"></span>
                                                <asp:TextBox ID="txtEquipmentSearch" CssClass="txtSearch" runat="server" AutoPostBack="true"/>
                                            </td>
                                        </tr>
                                        <tr class="ToolBarTreePane" style="margin-bottom:8px;">
                                            <td class="labelWidth" style="background: transparent !important; padding-left: 8px;box-sizing:border-box;">
                                                <asp:Label ID="lblEquipmentGroupBy" runat="server" Text="Group By" meta:ResourceKey="lblGroupBy"></asp:Label>
                                            </td>
                                            <td class="controlWidth" style="background-color: RGB(237,237,237) !important;">
                                                <telerik:RadComboBox ID="ddlEquipmentGroupBy" runat="server" Style="width: 240px !important; margin-bottom:8px;" AutoPostBack="true">
                                                    <Items>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemNone" Value="None" Text="None1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemCSIDivision" Value="CSIDivision" Text="CSI Division1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemEquipment" Value="Equipment" Text="Equipment1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemLaborResource" Value="LaborResource" Text="Labor Resource1"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemResourceGroup" Value="EquipmentResourceGroup" Text="Resource Group1"></telerik:RadComboBoxItem>
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="100%"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <asp:CheckBox ID="chkIncludeLaborResources" AutoPostBack="true" runat="server" Text="Always Include Labor Resources" meta:ResourceKey="chkIncludeLaborResources" />
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="padding-top:5px">
                                         <telerik:RadTreeView ID="rtvEquipment" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="True" CheckBoxes="true" TriStateCheckBoxes="true"
                                                    OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" OnClientNodeClicked="EquipClicked" 
                                                    OnClientNodeChecked="ShowHidebtnEquipmentTreeDropItems">
                                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                                    <CollapseAnimation Duration="100" Type="OutQuint" />
                                                </telerik:RadTreeView>
                                                 <asp:LinkButton runat="server" ID="btnEquipmentTreeDropItems" CssClass="Hide">
                                                    <div class="btnTreeDropItems">&nbsp;</div>
                                                </asp:LinkButton>
                                    </div>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CollapseMode="Forward" />
            <telerik:RadPane ID="rpnResourcesGrid" CssClass="fullWidthPane OverflowHidden" runat="server" EnableEmbeddedBaseStylesheet="False" Index="2" Skin="">
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgResources" runat="server" Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8"
                                SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true" FitPageHeightOffset="5"
                                ShowGroupPanel="false" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="false" ItemStyle-Height="20px" GridLines="None">
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="IndexId" CommandItemDisplay="Top"
                                    TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Resource" UniqueName="Resource" Groupable="false" HeaderStyle-Width="400px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Resource").ToString = String.Empty, "&nbsp;", Container.DataItem("Resource").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="false" Resizing-AllowColumnResize="false">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:radsplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
    </form>
</body>
</html>
