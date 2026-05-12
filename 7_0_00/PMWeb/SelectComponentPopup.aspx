lectta1<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="SelectComponentPopup.aspx.vb" Inherits="Website.SelectComponentPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">

                var gridId = "RadContentPane";
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

                function pageLoad() {
                    var value = $('#hdnopenDiv').val();
                    if (value == '' || value == 'ToggleSplitter') return false;
                    var pane = $find('treeGroupComponentsPane');
                    pane.set_visible(false);
                    openDivByCommandName(value);
                }

                function maintoolbarClick(sender, args) {
                    var value = args.get_item().get_commandName();
                    $('#hdnopenDiv').val(value);
                    openDivByCommandName(value);
                }

                function openDivByCommandName(value) {
                    switch (value) {
                        case 'ToggleSplitter':
                            var pane = $find('treeGroupComponentsPane');
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block";
                            break;
                    }
                }

                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                        var pane = $find('treeGroupComponentsPane');
                        $('#hdnopenDiv').val('');
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
            <style type="text/css">
                .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                    height: calc(100vh - 55px) !important;
                }

                .RadTreeView.CheckBoxesTreeview label .rtChk {
                    margin-left: 17px !important;
                    margin-right: -1px !important;
                }

                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                        height: calc(100vh - 2px) !important;
                    }

                    .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                        margin-left: 16px !important;
                        margin-right: 16px !important;
                    }
                }

                td#treeGroupComponentsPane {
                    position: relative;
                }
            </style>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgComponents" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="trvGroupedComponents" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="trvGroupedComponents">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgComponents" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="trvGroupedComponents" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgComponents">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgComponents" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="trvGroupedComponents" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgComponents" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="trvGroupedComponents" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Default" />

        <table width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td valign="middle" align="left" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="280px" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default" Width="100%" Height="500px" CssClass="documentSplitter" OnClientResized="ClientResized">
            <telerik:RadPane ID="treeGroupComponentsPane" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" Width="420px" OnClientExpanded="ClientResized">
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Height="50px" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                <telerik:RadTreeView ID="trvGroupedComponents" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true"
                    CssClass="treePaddingOnMobile" CheckBoxes="true" TriStateCheckBoxes="true" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                    OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                    <div class="btnTreeDropItems">&nbsp;</div>
                </asp:LinkButton>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" CssClass="fullWidthPane OverflowHidden" OnClientResized="ClientResized">
                <div id="ComponentsPane" style="vertical-align: top;" class="NormalWhiteBack fullWidthPane">
                    <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                        <div class="row RowWithNoPaddingTop">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgComponents" runat="server" Width="100%" AllowMultiRowSelection="True"
                                    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" SetWidth="true"
                                    ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true" FitPageHeightOffset="5">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" CommandItemDisplay="Top">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="ID" ItemStyle-Wrap="false" UniqueName="RecordNumber" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="39px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Asset ID" ItemStyle-Wrap="false" UniqueName="AssetId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="75px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("AssetId") = String.Empty, "&nbsp;", Container.DataItem("AssetId"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="ItemId" ItemStyle-Wrap="false" HeaderText="Item" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Item") = String.Empty, "&nbsp;", Container.DataItem("Item"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="ComponentType" ItemStyle-Wrap="false" HeaderText="Component Type" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="111px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("ComponentType") = String.Empty, "&nbsp;", Container.DataItem("ComponentType"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Description" ItemStyle-Wrap="false" HeaderText="Description" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="85px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Serial #" ItemStyle-Wrap="false" UniqueName="SerialNumber" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("SerialNumber") = String.Empty, "&nbsp;", Container.DataItem("SerialNumber"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Manufacturer" ItemStyle-Wrap="false" UniqueName="Manufacturer" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="95px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Manufacturer") = String.Empty, "&nbsp;", Container.DataItem("Manufacturer"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Mfr. #" ItemStyle-Wrap="false" UniqueName="ManufacturerNumber" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="58px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("ManufacturerNumber") = String.Empty, "&nbsp;", Container.DataItem("ManufacturerNumber"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Stock #" ItemStyle-Wrap="false" UniqueName="StockNumber" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="70px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("StockNumber") = 0 , "&nbsp;", Container.DataItem("StockNumber"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Lot #" ItemStyle-Wrap="false" UniqueName="LotNumber" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="55px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("LotNumber") = String.Empty, "&nbsp;", Container.DataItem("LotNumber"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                    Visible='<%# rdgComponents.EditIndexes.Count = 0 AND (Not rdgComponents.MasterTableView.IsItemInserted) %>'
                                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                        <NoRecordsTemplate>
                                            <table style="height: 200px; width: 100%">
                                                <tr>
                                                    <td align="center" valign="middle">
                                                        <asp:Label ID="lblDrag" meta:resourceKey="lblDrag" runat="server" Text="Drag Components from the treeview and drop them here."> </asp:Label></td>
                                                </tr>
                                            </table>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
    </form>
</body>
</html>
