<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="SelectAssetAPPayment.aspx.vb" Inherits="Website.SelectAssetAPPayment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <style type="text/css">
                .documentSplitter {
                    margin-top: 50px !important;
                }

                .SplitterPanePopup {
                    border-top: 0;
                }

                .ToolBarTreePane .labelWidth span {
                    position: relative;
                    top: 12px;
                }

                .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                    height: calc(100vh - 55px) !important;
                }

                @media screen and (min-width:320px) and (max-width:843px) {
                    div#rtvAPPayments {
                        max-height: none !important;
                        /*margin-top: 34px;*/
                    }

                    .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                        height: calc(100vh - 2px) !important;
                    }

                    table.groupBy {
                        margin-top: 50px;
                    }

                    .ToolBarTreePane .labelWidth span {
                        top: 4px;
                    }
                }

                td#rpnAPPaymentsTree {
                    position: relative;
                }

                table.groupBy {
                    border-collapse: collapse;
                }

                .ToolBarTreePane {
                    border: 1px solid #666;
                    border-left: none;
                }

                .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                    margin-left: 16px !important;
                    margin-right: 16px !important;
                }
            </style>
            <script type="text/javascript">

                var gridId = "rpnAPPaymentsGrid";

                function pageLoad() {
                    var value = $('#hdnopenDiv').val()
                    if (value == '' || value == 'ToggleSplitter') return false;
                    var pane = $find('rpnAPPaymentsTree');
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
                            var pane = $find('rpnAPPaymentsTree');
                            pane.set_visible(true)
                            break;
                    }

                }
                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                        var pane = $find('rpnAPPaymentsTree');
                        pane.set_visible(false);
                        return false;
                    }
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rtvAPPayments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAPPayments" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rtvAPPayments" />
                        <telerik:AjaxUpdatedControl ControlID="rdgAPPayments" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAPPayments" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvAPPayments" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgAPPayments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAPPayments" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <div style="height: 100%">
            <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
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
            Height="500px" SplitBarsSize="">
            <telerik:RadPane ID="rpnAPPaymentsTree" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Height="50px" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                <table class="treePaddingOnMobile TableNoSpacingNoBorder groupBy">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background: #EDEDED !important; padding-left: 24px; box-sizing: border-box; width: 160px !important;">
                            <asp:Label ID="lblGroupBy" runat="server" Text="Group By" meta:resourcekey="lblGroupBy"></asp:Label>&nbsp;&nbsp;
                        </td>
                        <td class="controlWidth" style="background: #EDEDED !important;">
                            <telerik:RadComboBox ID="ddlGroupBy" runat="server" AutoPostBack="true" Style="width: 240px !important">
                                <Items>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemCategory" Value="Category" Text="Category"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemCompany" Value="Company" Text="Company"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemProgram" Value="Program" Text="Program"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemLocation" Value="Location" Text="Location1"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemType" Value="Type" Text="Type"></telerik:RadComboBoxItem>
                                </Items>

                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 5px;">
                            <telerik:RadTreeView ID="rtvAPPayments" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="True"
                                OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" CheckBoxes="true" TriStateCheckBoxes="true"
                                OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <CollapseAnimation Duration="100" Type="OutQuint" />
                            </telerik:RadTreeView>
                            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                <div class="btnTreeDropItems">&nbsp;</div>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False"
                Index="1" Skin="" />
            <telerik:RadPane ID="rpnAPPaymentsGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane OverflowHidden"
                Index="2" Skin="">
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgAPPayments" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" Width="100%" SetWidth="true"
                                ShowGroupPanel="false" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="true" ItemStyle-Height="20px"
                                ClientSettings-Scrolling-AllowScroll="true" GridLines="None" FitPageHeightOffset="5">
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                                    TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Program1" ItemStyle-Wrap="false" UniqueName="ProgramName" Groupable="false" SortExpression="ProgramName">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("ProgramName").ToString = String.Empty, "&nbsp;", Container.DataItem("ProgramName").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Location Name1" UniqueName="LocationName" Groupable="false" SortExpression="LocationName">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("LocationName").ToString = String.Empty, "&nbsp;", Container.DataItem("LocationName").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Company1" UniqueName="Company" Groupable="false" SortExpression="Company">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Company").ToString = String.Empty, "&nbsp;", Container.DataItem("Company").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Payment ID1" ItemStyle-Wrap="false" UniqueName="RecordNumber" Groupable="false" SortExpression="RecordNumber">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("RecordNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("RecordNumber").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Payment1" ItemStyle-Wrap="false" UniqueName="Description" Groupable="false" SortExpression="Description">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                Visible='<%# rdgAPPayments.EditIndexes.Count = 0 AND (Not rdgAPPayments.MasterTableView.IsItemInserted) %>'
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
