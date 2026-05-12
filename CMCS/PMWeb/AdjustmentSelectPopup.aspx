<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" Title="Adjustments" CodeBehind="AdjustmentSelectPopup.aspx.vb" Inherits="Website.AdjustmentSelectPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

            <style type="text/css">
  
         .documentSplitter,.fullWidthPane,.SplitterPanePopup{height:calc(100vh - 55px) !important}
         .RadTreeView.CheckBoxesTreeview label .rtChk{margin-left:17px !important;margin-right:-1px !important;}
      /*   .documentSplitter{padding-top:50px}*/

      @media screen and (min-width:320px) and (max-width:843px) {
                div#rtvAdjustments {max-height: none !important;}
                        .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left: 16px !important;
            margin-right: 16px !important;
        }
        }
      #rpnResourceTree{position:relative;}
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script language="javascript" type="text/javascript">
                var gridId = "rpnAdjustmentGrid";

                function pageLoad() {
                    var value = $('#hdnopenDiv').val()
                    if (value == '' || value == 'ToggleSplitter') return false;
                    var pane = $find('rpnResourceTree');
                    pane.set_visible(false);
                    openDivByCommandName(value);
                }

                function OnClientLoad(editor, args) {
                    editor.get_contentArea().style.backgroundColor = "white";
                    editor.get_contentArea().style.backgroundImage = "none";
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
                function openDivByCommandName(value){
                switch (value) {

                    case 'ToggleSplitter':
                        var pane = $find('rpnResourceTree');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        break;
                }
                }
                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                        $('#hdnopenDiv').val('')
                        var pane = $find('rpnResourceTree');
                        pane.set_visible(false);
                        var td = pane._element;
                        td.style.visibility = "visible";
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

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlGroups">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rtvAdjustments" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgAdjustments">
                    <UpdatedControls> 
                        <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls> 
                        <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="rtvAdjustments" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvAdjustments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvAdjustments" LoadingPanelID="ldpCostCodes" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
       

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter"
            Height="400px" SplitBarsSize="">
            <telerik:RadPane ID="rpnResourceTree" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" OnClientExpanded="ClientResized" OnClientCollapsed="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
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
                 <table class="treePaddingOnMobile TableNoSpacingNoBorder">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background:#EDEDED !important; padding-left:24px; box-sizing:border-box; width:160px !important;">
                            <asp:Label ID="lblTreeFilter" meta:resourcekey="lblTreeFilter" runat="server" Text="Group By"></asp:Label>
                        </td>
                          <td class="controlWidth" style="background:#EDEDED !important">
                            <telerik:RadComboBox ID="ddlGroups" runat="server" style="width:240px !important;" AutoPostBack="true">
                                <Items>
                                <telerik:RadComboBoxItem meta:resourcekey="ListItemNone" Text="None" Value="0" />
                                <telerik:RadComboBoxItem meta:resourcekey="ListItemColumn" Text="Column" Value="1"></telerik:RadComboBoxItem>
                                <telerik:RadComboBoxItem meta:resourcekey="ListItemAdjustmentGroup" Text="Adjustment Group" Value="2"></telerik:RadComboBoxItem>
                                <telerik:RadComboBoxItem meta:resourcekey="ListItemAdjustmentType" Text="Adjustment Type" Value="3"></telerik:RadComboBoxItem>
                                <telerik:RadComboBoxItem meta:resourcekey="ListItemAdjustmentGroupType" Text="Adjustment Group Type" Value="4"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" valign="top">
                            <telerik:RadTreeView ID="rtvAdjustments" runat="server" EnableDragAndDrop="True" CheckBoxes="true" TriStateCheckBoxes="true"
                                OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging"
                                Skin="Default" MultipleSelect="True" OnClientNodeChecked="ShowHidebtnTreeDropItems">
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

            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False" CollapseMode="Forward"
                Index="1" Skin="" />
            <telerik:RadPane ID="rpnAdjustmentGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane OverflowHidden" OnClientResized="ClientResized"
                Index="2" Skin="">
                <table style="width: 100%; vertical-align: top;" cellpadding="0" cellspacing="0" class="NormalWhiteBack">
                    <tr>
                        <td >
                            <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                        </td>
                    </tr>
                </table>
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgAdjustments" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" AllowMultiRowSelection="True" GridLines="None" FitPageHeightOffset="5">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Column" SortExpression="AdjustmentColumn" GroupByExpression="AdjustmentColumn [GridColumn_AdjustmentColumn] Group By AdjustmentColumn ASC" UniqueName="AdjustmentColumn">
                                            <ItemTemplate>
                                                <span><%#IIf(CStr(Eval("AdjustmentColumn")) = String.Empty, "&nbsp;", Eval("AdjustmentColumn"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="110px" />
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="ID*" SortExpression="Code" Groupable="false" UniqueName="Code">
                                            <ItemTemplate>
                                                <span><%#IIf(CStr(Eval("Code")) = String.Empty, "&nbsp;", Eval("Code"))%></span>&nbsp;
                                            </ItemTemplate>

                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description"
                                            GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                            <ItemTemplate>
                                                <span>
                                                    <span><%#IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>&nbsp;
                                            </ItemTemplate>

                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company" UniqueName="Company"
                                            GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CompanyId") = -1 Or Container.DataItem("CompanyId") = 0, "&nbsp;", Container.DataItem("Company"))%></span>&nbsp;
                                            </ItemTemplate>

                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Rate %" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage ASC" UniqueName="Percentage"
                                            SortExpression="Percentage">
                                            <ItemTemplate>
                                                <span><%#IIf(CStr(Eval("Percentage")) = "0", "&nbsp;", FormatPercent(Container.DataItem("Percentage")))%></span>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="72px" HorizontalAlign="Center"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostTypes" GroupByExpression="CostTypes [GridColumn_CostTypes] Group By CostTypes ASC" UniqueName="CostTypes">
                                            <ItemTemplate>
                                                <span><%#IIf(CStr(Eval("CostTypes")) = String.Empty, "&nbsp;", Eval("CostTypes"))%></span>
                                            </ItemTemplate>

                                            <HeaderStyle Width="100px" />
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                                            GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                                            <ItemTemplate>
                                                <span>
                                                    <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="AppendLine" SortExpression="AppendLine" UniqueName="AppendLine"
                                            GroupByExpression="AppendLine [GridColumn_AppendLine] Group By AppendLine ASC">
                                            <ItemTemplate>
                                                <span>
                                                    <img src='Images/Global/<%# CStr(IIf(Eval("AppendLine"), "checked.png", "unchecked.png")) %>' /></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <CommandItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="<%#rdgAdjustments.EditIndexes.Count = 0 And (Not rdgAdjustments.MasterTableView.IsItemInserted) %>">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt" />
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
