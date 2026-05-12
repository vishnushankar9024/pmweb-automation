<%@ Page meta:Resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SelectLeaseChargesPopup.aspx.vb" Inherits="Website.SelectLeaseChargesPopup" %>

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

                var gridId = "rpnLeaseChargesGrid";

                function pageLoad() {
                    var value = $('#hdnopenDiv').val()
                    if (value == '' || value == 'ToggleSplitter') return false;
                    var pane = $find('rpnLeaseChargesTree');
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
                    $('#hdnopenDiv').val(value)
                    openDivByCommandName(value)
                    
                }

                function openDivByCommandName(value) {

                    switch (value) {

                        case 'ToggleSplitter':
                            var pane = $find('rpnLeaseChargesTree');
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block";
                            break;
                        case 'OpenHeadDiv':
                            var popup = $('#headpopup')[0];
                            popup.style.display = 'block';
                            break;
                    }
                }

                function headToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'closeHead') {
                        $('#hdnopenDiv').val('')
                        var popup = $('#headpopup')[0];
                        popup.style.display = 'none';
                    }
                }
                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                        $('#hdnopenDiv').val('')
                        var pane = $find('rpnLeaseChargesTree');
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
                    margin-left: 20px !important;
                    margin-right: -10px !important;
                }

                td#rpnLeaseChargesTree {
                    position: relative;
                }

                .documentSplitter {
                    padding-top: 50px;
                }
                .popupDiv .RadToolBar_Horizontal .rtbItem:first-child {
                    margin-left: 16px !important;
                    margin-right: 16px !important;
                }
                @media screen and (min-width:320px) and (max-width:843px) {
                    .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                        height: calc(100vh - 2px) !important;
                    }
                }

               .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                    margin-left: 16px !important;
                    margin-right: 16px !important;
                }
            </style>

        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgLeaseCharges">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLeaseCharges" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLeaseCharges" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLeaseCharges" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rtvLeaseCharges">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLeaseCharges" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLeaseCharges" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLeaseCharges" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLeaseCharges" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td align="left" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarHeader ShowOnMobile" PostBack="false" CommandName="OpenHeadDiv"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>

            </tr>
        </table>
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass=""
            SplitBarsSize="">
            <telerik:RadPane ID="rpnLeaseChargesTree" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" OnClientExpanded="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td colspan="2" class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" Height="50px" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>

                <table class="treePaddingOnMobile TableNoSpacingNoBorder">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background: #EDEDED !important; padding-left: 24px; box-sizing: border-box; width: 160px !important;">
                            <asp:Label ID="lblGroupBy" runat="server" Text="Group By" meta:resourcekey="lblGroupBy" Width="120px"></asp:Label>&nbsp;&nbsp;
                        </td>
                        <td class="controlWidth" style="background: #EDEDED !important">
                            <telerik:RadComboBox ID="ddlGroupBy" runat="server" AutoPostBack="true" Style="width: 240px !important;">
                                <Items>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemCostCode" Value="CostCode" Text="Cost Code"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemPostEvery" Value="PostEvery" Text="Post Every"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemType" Value="Type" Text="Type"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 5px;">
                            <telerik:RadTreeView ID="rtvLeaseCharges" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="True"
                                OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" CheckBoxes="true" TriStateCheckBoxes="true"
                                OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <CollapseAnimation Duration="100" Type="OutQuint" />
                            </telerik:RadTreeView>
                            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                <div class="btnTreeDropItems">&nbsp;</div>
                            </asp:LinkButton>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False" CollapseMode="Forward"
                Index="1" Skin="" />
            <telerik:RadPane ID="rpnLeaseChargesGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane OverflowHidden" OnClientResized="ClientResized"
                Index="2" Skin="">
                <div id="headpopup" class="popupDiv">
                    <telerik:RadToolBar ID="RadToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick" height="50px">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeHead" height="50px"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                    <div class="PMMainPage PMPopupMainPage">
                        <div class="row">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStart" runat="server" Text="Start" meta:resourcekey="lblStart"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="dtpStart" AutoPostBack="false" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput2" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEnd" runat="server" Text="End" meta:resourcekey="lblEnd"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="dtpEnd" AutoPostBack="false" runat="server" Width="100%" MinDate="1901-01-01" MaxDate="2100-01-01" Skin="Default" EnableTyping="True">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput1" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                            <div>
                                                <asp:CompareValidator ID="cvTime" runat="server" ValidationGroup="ChargeSave" ControlToCompare="dtpStart"
                                                    ControlToValidate="dtpEnd" Operator="GreaterThan" Display="Dynamic" meta:resourceKey="cvEnd" ErrorMessage="End must be greater Than Start"></asp:CompareValidator>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPostEvery" runat="server" Text="Post Every" meta:resourcekey="lblPostEvery"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPostEvery" runat="server" Width="100%"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPostToCostCode" runat="server" Text="Cost Code" meta:resourcekey="lblPostToCostCode"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                                EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." meta:resourcekey="ddlCostCode"
                                                NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="PMMainPage PopupGridMargin">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgLeaseCharges" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8"
                                Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                ShowGroupPanel="false" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="false" ItemStyle-Height="20px" GridLines="None">
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                                    TableLayout="Fixed" HeaderStyle-Width="100px" UseAllDataFields="true" EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" Groupable="false">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" Groupable="false">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Post Every" ItemStyle-Wrap="false" UniqueName="PostEvery" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("PostEvery") = String.Empty, "&nbsp;", Container.DataItem("PostEvery"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Amount" UniqueName="Amount" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# FormatCurrency(Container.DataItem("Amount"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Annualized" UniqueName="Annualized" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# FormatCurrency(Container.DataItem("Annualized"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Cost Code" ItemStyle-Wrap="false" UniqueName="CostCode" Groupable="false">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                Visible='<%# rdgLeaseCharges.EditIndexes.Count = 0 AND (Not rdgLeaseCharges.MasterTableView.IsItemInserted) %>'
                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="false" Resizing-AllowColumnResize="true">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
    </form>
</body>
</html>
