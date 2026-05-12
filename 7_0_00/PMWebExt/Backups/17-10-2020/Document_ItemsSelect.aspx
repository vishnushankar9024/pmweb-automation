<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Document_ItemsSelect.aspx.vb"
    Inherits="Website.Document_ItemsSelect" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Items</title>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            var gridId = "RadContentPane";

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('treeGroupsAndItemsPane');
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

            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                $('#hdnopenDiv').val(value);
                openDivByCommandName(value);

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
                    $('#hdnopenDiv').val('')
                    var pane = $find('treeGroupsAndItemsPane');
                    pane.set_visible(false);
                    return false;
                }
            }
            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter.get_width() - pane1Td.clientWidth - 10);
            }
        </script>

    </telerik:RadCodeBlock>
    <style type="text/css">
       .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
    margin-left: 16px !important;
    margin-right: 16px !important;
}

        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 52px) !important;
        }

        .documentSplitter {
            padding-top: 50px;
        }

        .RadToolBar_Horizontal .rtbItem:first-child {
            margin-right: 16px !important;
        }

        .RadToolBar_Horizontal .rtbItem {
            margin-right: 16px !important;
        }

        .CheckBoxesTreeview .rtChk {
            margin-left: 18px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="treeGroupsAndItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="treeGroupsAndItems" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="treeGroupsAndItems" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSaveToRecord">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="treeGroupsAndItems" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
        <div style="height: 100%">
            <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                    CommandName="SaveAndExit" style="margin-right: -8px !important;">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </div>

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter"
            Height="520px" SplitBarsSize="">
            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" OnClientExpanded="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">

                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td colspan="2" class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" Height="50px" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                <telerik:RadTreeView ID="treeGroupsAndItems" runat="server" EnableDragAndDrop="True" OnNodeExpand="treeGroupsAndItems_NodeExpand" CheckBoxes="true" TriStateCheckBoxes="true"
                    OnNodeDrop="treeGroupsAndItems_NodeDrop" OnClientNodeDropping="onNodeDropping" CssClass="treePaddingOnMobile" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                    OnClientNodeDragging="onNodeDragging" Skin="Default" MultipleSelect="True" Width="100%" Style="max-height: 90%;margin-left:0px !important;">
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                    <CollapseAnimation Duration="100" Type="OutQuint" />
                </telerik:RadTreeView>
                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                    <div class="btnTreeDropItems">&nbsp;</div>
                </asp:LinkButton>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="TreeToolbarSplitbar" CollapseMode="Forward"
                Index="1" Skin="" meta:resourcekey="Splitter" />
            <telerik:RadPane ID="RadContentPane" runat="server" EnableEmbeddedBaseStylesheet="False" OnClientResized="ClientResized"
                Index="2" Skin="" CssClass="fullWidthPane">
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgItems" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" AllowMultiRowSelection="True" AllowPaging="true" PageSize="15"
                                GridLines="None" FitPageHeightOffset="5">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="#" UniqueName="TemplateColumn">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtAddingTimes" runat="server" CssClass="PositiveInteger" MaxLength="2"
                                                    Text="1" Width="100%"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="Id">
                                            <ItemTemplate>
                                                <asp:Label ID="lblItemsId" CssClass="Right" Text='<%# CDbl(Eval("ItemId")).ToString %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" Text='<%# Eval("Description") %>'
                                                    Width="98%"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                            <ItemStyle Wrap="False" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="ManufacturerId">
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="100%"
                                                    Skin="Default" CloseDropDownOnBlur="true"
                                                    NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlManufacturer"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested"
                                                    Style="font-size: 11px" Height="250px">
                                                </telerik:RadComboBox>
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px" Wrap="false" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Manufacturer Number" UniqueName="ManufacturerNumber">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtManufacturerNumber" MaxLength="50" runat="server" Text='<%# Eval("ManufacturerNumber") %>'
                                                    Width="98%"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                            UpdateImageUrl="Update.gif">
                                        </EditColumn>
                                    </EditFormSettings>
                                    <CommandItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgItems.EditIndexes.Count = 0 AND (Not rdgItems.MasterTableView.IsItemInserted) %>">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt" />
                                <HeaderContextMenu EnableViewState="false">
                                </HeaderContextMenu>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />

        <script type="text/javascript" language="javascript">
            function CloseWindow() {
                var oWindow = GetRadWindow();
                oWindow.Close();
            }
        </script>

    </form>
</body>
</html>
