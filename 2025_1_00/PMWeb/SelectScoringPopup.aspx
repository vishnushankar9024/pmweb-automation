<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SelectScoringPopup.aspx.vb" Inherits="Website.SelectScoringPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>  
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">

            var gridId = "rdgScoring";

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('rpnScoringTree');
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

            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    $('#hdnopenDiv').val('')
                    var pane = $find('rpnScoringTree');
                    pane.set_visible(false);
                    return false;
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
                        var pane = $find('rpnScoringTree');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        break;
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
        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 55px) !important;
        }

        #rpnScoringTree {
            position: relative;
        }

        .RadTreeView.CheckBoxesTreeview label .rtChk {
            margin-left: 20px !important;
            margin-right: -10px !important;
        }

        .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left: 16px !important;
            margin-right: 16px !important;
        }
    /*    .documentSplitter{padding-top:50px;}*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rtvScoring">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgScoring" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgScoring" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgScoring" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvScoring"/>
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td style="width: 220px">
                    <telerik:RadToolBar ID="mainToolBar" Height="50px" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton Height="50px" EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton Height="50px" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton Height="50px" IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton Height="50px" EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter"
            Height="500px" SplitBarsSize="">
            <telerik:RadPane ID="rpnScoringTree" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" OnClientExpanded="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" Width="420px">
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
                <table class="treePaddingOnMobile TableNoSpacingNoBorder">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background: transparent !important; padding-left: 24px; box-sizing: border-box; width: 160px !important;">
                            <asp:Label ID="lblGroupBy" runat="server" Text="Group By" meta:resourcekey="lblGroupBy" Width="126px"></asp:Label>&nbsp;&nbsp;

                        </td>
                        <td class="controlWidth" style="background: #EDEDED !important;">
                            <telerik:RadComboBox ID="ddlGroupBy" runat="server" AutoPostBack="true" Style="width: 240px !important">
                                <Items>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemNone" Value="None" Text="--None--"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemGroupDescription" Value="GroupDescription" Text="Group Description"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-top: 5px;">
                            <telerik:RadTreeView ID="rtvScoring" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="True" CheckBoxes="true" TriStateCheckBoxes="true"
                                OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" CssClass="CheckBoxesTreeview" OnClientNodeChecked="ShowHidebtnTreeDropItems">
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
            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="TreeToolbarSplitbar" CollapseMode="Forward" />
            <telerik:RadPane ID="rpnScoringGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane" OnClientResized="ClientResized"
                Index="2" Skin="">
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgScoring" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" Width="100%" SetWidth="true"
                                ShowGroupPanel="true" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="false" ItemStyle-Height="20px" GridLines="None"
                                ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="5">
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" HeaderStyle-Width="100px"
                                    TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">

                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="Question ID" ItemStyle-Wrap="false" UniqueName="QuestionId" Groupable="true" GroupByExpression="QuestionId [GridColumn_QuestionId] Group By QuestionId">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("QuestionId") = String.Empty, "&nbsp;", Container.DataItem("QuestionId"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Abbreviation" ItemStyle-Wrap="false" UniqueName="Abbreviation" Groupable="true" GroupByExpression="Abbreviation [GridColumn_Abbreviation] Group By Abbreviation">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Abbreviation").ToString = String.Empty, "&nbsp;", Container.DataItem("Abbreviation").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Question" ItemStyle-Wrap="false" UniqueName="Question" Groupable="true" GroupByExpression="Question [GridColumn_Question] Group By Question">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Question").ToString = String.Empty, "&nbsp;", Container.DataItem("Question").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Answer" ItemStyle-Wrap="false" UniqueName="Answer" Groupable="true" GroupByExpression="Answer [GridColumn_Answer] Group By Answer">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Answer").ToString = String.Empty, "&nbsp;", Container.DataItem("Answer").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Score" ItemStyle-Wrap="false" UniqueName="Score" Groupable="true" GroupByExpression="Score [GridColumn_Score] Group By Score">
                                            <ItemTemplate>
                                                <span><%#FormatNumber(Container.DataItem("Score"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="right" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Points Available" ItemStyle-Wrap="false" UniqueName="AvailablePoints" Groupable="true" GroupByExpression="AvailablePoints [GridColumn_AvailablePoints] Group By AvailablePoints">
                                            <ItemTemplate>
                                                <span><%# FormatNumber(Container.DataItem("AvailablePoints"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="right" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Weight" ItemStyle-Wrap="false" UniqueName="Weight" Groupable="true" GroupByExpression="Weight [GridColumn_Weight] Group By Weight">
                                            <ItemTemplate>
                                                <span><%#FormatPercent(Container.DataItem("Weight"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="right" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Weighted Score" ItemStyle-Wrap="false" UniqueName="WeightedScore" Groupable="true" GroupByExpression="WeightedScore [GridColumn_WeightedScore] Group By WeightedScore">
                                            <ItemTemplate>
                                                <span><%#FormatNumber(Container.DataItem("WeightedScore"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="right" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" Groupable="true" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                                            <ItemTemplate>
                                                <span><%# IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" Width="150px" />
                                        </telerik:GridTemplateColumn>

                                    </Columns>

                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                            Visible='<%# rdgScoring.EditIndexes.Count = 0 AND (Not rdgScoring.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        </div>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true">
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
