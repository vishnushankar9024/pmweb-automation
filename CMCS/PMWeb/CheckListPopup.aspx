<%@ Page Language="vb" Title="Tasks" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="CheckListPopup.aspx.vb" Inherits="Website.CheckListPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script src="JS/EngeneeringForms/ResourcePopup.js" type="text/javascript"></script>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var splitter = $find("RadSplitter1");
                var pane = splitter._panes[0];
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
                        var splitter = $find("RadSplitter1");
                        var pane = splitter._panes[0];

                        if (pane.get_visible()) {
                            pane.set_visible(false);
                        }
                        else {
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block";
                        }
                        break;
                }
            }
            function ClientResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                pane1.set_visible(true);
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter.get_width() - pane1Td.clientWidth - 10);
            }

            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    $('#hdnopenDiv').val('')
                    var pane = $find("rpnResourceTree");
                    pane.set_visible(false);
                    return false;
                }
            }
            function PaneCollapsed(sender, args) {
                var pane = $find("rpnResourceTree");
                pane.set_visible(false);
                return false;
            }
        </script>

    </telerik:RadCodeBlock>
</head>
<style>
    #RAD_SPLITTER_PANE_CONTENT_rpnResourceTree {
        height: calc(100vh - 50px) !important;
    }
    #rpnResourceTree{position:relative;}
    @media screen and (max-width: 843px) and (min-width: 320px) {
        #RAD_SPLITTER_PANE_CONTENT_rpnResourceTree {
            height: 100vh !important;         
        }
    }
    .height {
        height: calc(100vh - 51px) !important;
    }
    .documentSplitter{padding-top:50px}
          .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left: 16px !important;
            margin-right: 16px !important;
        }
</style>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlGroups">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rtvCheckList" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgChecklist">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgChecklist" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                 <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgChecklist" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="rtvCheckList"/>
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvCheckList">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgChecklist" LoadingPanelID="ldpCostCodes" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgChecklist" LoadingPanelID="ldpItems" />
                    <telerik:AjaxUpdatedControl ControlID="rtvCheckList"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Default" />

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

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="RDSplitter"
            Height="100%" SplitBarsSize="">
            <telerik:RadPane ID="rpnResourceTree" runat="server" Width="420px" CssClass="RDLeftPane" EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" >
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Height="50px" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick" Style="line-height: 45px; height: 50px;">
                                <Items>

                                    <telerik:RadToolBarButton EnableImageSprite="true"  CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true"  CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                                
                 <table class="treePaddingOnMobile TableNoSpacingNoBorder">
                    <tr class="ToolBarTreePane">
                        <td class="labelWidth" style="background:#EDEDED !important; padding-left:24px; box-sizing:border-box; width:160px !important;">
                            <asp:Label ID="lblGroupBy" meta:resourcekey="lblGroupBy" runat="server" Text="Group By"></asp:Label>
                        </td>
                        <td class="controlWidth" Style="background:#EDEDED !important;">
                            <telerik:RadComboBox ID="ddlGroups" runat="server" width="100%" AutoPostBack="true" Height="100px" Style="width:240px !important">
                                <Items>
                                    <telerik:RadComboBoxItem Text="<%$Resources: ListItemCheckListType %>" Value="1"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="<%$Resources: ListItemTaskType %>" Value="3"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="<%$Resources: ListItemCheckList %>" Value="2"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>                    
                    <tr>
                        <td colspan="3" valign="top" style="background-color: white !important">
                            <telerik:RadTreeView ID="rtvCheckList" runat="server" EnableDragAndDrop="True"
                                OnClientNodeDropping="onNodeDropping" CheckBoxes="true" TriStateCheckBoxes="true"
                                OnClientNodeDragging="onNodeDragging" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                Skin="Default" MultipleSelect="True">
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
                Index="1" Skin="" CssClass="height" CollapseMode="Forward" />
            <telerik:RadPane ID="rpnResourceGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="RDRightPane" 
                Index="2" Skin="">
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row RowWithNoPaddingTop">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgChecklist" runat="server" AllowScroll="true" FitPageHeightOffset="5"
                                AutoGenerateColumns="False" ShowStatusBar="True" Width="100%" SetWidth="true"
                                AllowMultiRowSelection="True" AllowSorting="True" ShowGroupPanel="True"
                                GridLines="None">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Checklist" GroupByExpression="CheckList [GridColumn_CheckList] Group By CheckList ASC"
                                            UniqueName="Checklist" SortExpression="CheckList">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CheckList") = String.Empty, "&nbsp;", Container.DataItem("CheckList"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="70px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Checklist Type" GroupByExpression="CheckListType [GridColumn_CheckListType] Group By CheckListType ASC"
                                            UniqueName="ChecklistType" SortExpression="CheckListType">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CheckListType") = String.Empty, "&nbsp;", Container.DataItem("CheckListType"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="70px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="TaskNumber" ItemStyle-HorizontalAlign="Right"
                                            SortExpression="TaskNumber" GroupByExpression="TaskNumber [GridColumn_TaskNumber] Group By TaskNumber ASC"
                                            Reorderable="true">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("TaskNumber").ToString%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="50px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Task Type" UniqueName="TaskType" SortExpression="TaskType" GroupByExpression="TaskType [GridColumn_TaskType] Group By TaskType ASC">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("TaskType") = String.Empty, "&nbsp;", Container.DataItem("TaskType"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="70px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description"
                                            GroupByExpression="Description [GridColumn_Description] Group By Description">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Skills" SortExpression="SkillName" UniqueName="SkillName"
                                            GroupByExpression="SkillName [GridColumn_SkillName] Group By SkillName ASC">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("SkillName").ToString = String.Empty, "&nbsp;", Container.DataItem("SkillName").ToString)%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Optional" UniqueName="Optional" HeaderStyle-Width="50px" ItemStyle-Wrap="false"
                                            SortExpression="Optional" GroupByExpression="Optional [GridColumn_Optional] Group By Optional ASC"
                                            ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Optional"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="70px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgChecklist.EditIndexes.Count = 0 AND (Not rdgChecklist.MasterTableView.IsItemInserted) %>">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings AllowDragToGroup="true">
                                    <Resizing AllowColumnResize="True" />
                                </ClientSettings>
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
