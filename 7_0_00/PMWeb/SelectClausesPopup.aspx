<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SelectClausesPopup.aspx.vb" Inherits="Website.SelectClausesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            //$("input[id$='txtSearch']").unbind().keydown(function (event) { searchFiles(event); });

            //function searchFiles(event) {
            //    if (event.keyCode == 13) {
            //        document.querySelector(".divSearch").click();
            //        return false;
            //    }
            //}
            var gridId = "rpnClausesGrid";
            
            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('rpnClausesTree');
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
                    var splitter = $find("RadSplitter1");
                    var pane = splitter._panes[0];
                    pane.set_visible(false);
                    return false;
                }
            }


            function ClientCollapsed() {
                var splitter = $find("RadSplitter1");
                var pane = splitter._panes[1];
                pane.addCssClass("FullPane");
            }

            function ClientExpanded() {
                var splitter = $find("RadSplitter1");
                var pane = splitter._panes[1];
                pane.removeCssClass("FullPane");
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
     #rpnClausesTree{position:relative;}
        .divSearch .btnSearch {
            width: 24px;
            height: 24px;
            background-image: url("CSS/Images/ResponsiveIcons/24Enabled.png");
            display: inline-block;
            background-position: -216px 0px;
        }
        .documentSplitter {
        padding-top:50px
        }
        .RadTreeView .rtLines .rtMid {
            background-image: none !important;
        }

        .RadTreeView .rtLines .rtFirst {
            background-image: none !important;
        }

        .RadTreeView .rtLines .rtLI {
            background-image: none !important;
        }

        .RadTreeView .rtLines .rtBot {
            background-image: none !important;
        }

        #RAD_SPLITTER_PANE_CONTENT_rpnClausesTree {
            height: calc(100vh - 51px) !important;
            
        }

        #RAD_SPLITTER_PANE_CONTENT_rpnClausesGrid {
            height: calc(100vh - 51px) !important;
            
        }
      
        @media screen and (max-width: 843px) and (min-width: 320px) {
            #RAD_SPLITTER_PANE_CONTENT_rpnClausesTree {
                height: 100vh !important;
            }
      
          .row{ /*the row gets out of the div from the left side if the min-width is 404px*/
              min-width:100% !important;            
          }
           
        }

        .NoPadding {
            padding: 0 !important;
        }
        .FullPane{
            width:calc(100vw - 9px) !important;
        }
        @media screen and (min-width:844px){
            .PMPopupMainPage.documentSinglePage{
                margin-top: 0 !important;
            } 
        }
                 .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left: 16px !important;
            margin-right: 16px !important;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rtvClauses">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgAssets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                 <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rtvClauses" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgClauses" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rtvClauses" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
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

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter" SplitBarsSize="">
            <telerik:RadPane ID="rpnClausesTree" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" OnClientExpanded="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" >
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Height="50px" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick" Style="line-height: 45px; height: 50px;">
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
                            <asp:Label ID="lblGroupBy" runat="server" Text="Group By" meta:resourcekey="lblGroupBy"></asp:Label>
                        </td>
                          <td class="controlWidth" style="background:#EDEDED !important">
                            <telerik:RadComboBox ID="ddlGroupBy" runat="server" AutoPostBack="true" style="width:240px !important;">
                                <Items>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemCategory" Value="Category" Text="Category"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemGroupId" Value="GroupID" Text="Group ID"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemResponsible" Value="Responsible" Text="Responsible"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem meta:Resourcekey="ListItemType" Value="Type" Text="Type"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" valign="top">
                            <telerik:RadTreeView ID="rtvClauses" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="True" CheckBoxes="true" TriStateCheckBoxes="true"
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
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="TreeToolbarSplitbar" CollapseMode="Forward"
                Index="1" Skin="" />
            <telerik:RadPane ID="rpnClausesGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane OverflowHidden" OnClientResized="ClientResized"
                Index="2" Skin="">

                <div id="headpopup" class="popupDiv">
                    <table border="0" style="width: 100%;" cellpadding="0" cellspacing="0" class="ShowOnMobile">
                        <tr class="ToolBar" style="width: 70vw !important;">
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="RadToolBar1" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick" Style="line-height: 45px;">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeHead"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                    <div class="PMMainPage PMPopupMainPage documentSinglePage" style="margin-bottom:0">
                        <div class="row ">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblParagraph" runat="server" Text="Paragraph" meta:resourcekey="lblParagraph"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtParagraph" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblCategory"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblType" runat="server" Text="Type" meta:resourcekey="lblType"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlType" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblResponsible" runat="server" Text="Responsible" meta:resourcekey="lblResponsible"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlResponsible" AllowCustomText="true" runat="server" Width="100%" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStart" runat="server" Text="Start" meta:resourcekey="lblStart"></asp:Label></td>
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
                                            <asp:Label ID="lblEnd" runat="server" Text="End" meta:resourcekey="lblEnd"></asp:Label></td>
                                        <td class="controlWidth">
                                            <telerik:RadDatePicker ID="dtpEnd" AutoPostBack="false" runat="server" Width="100%" MinDate="1901-01-01" MaxDate="2100-01-01" Skin="Default" EnableTyping="True">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput1" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </div>
                    </div>

                    <%--  <div class="colpopup-6">
                            
                        </div>--%>
                </div>
                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgClauses" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" SetWidth="true"
                                ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                ShowGroupPanel="false" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="false" ItemStyle-Height="20px" GridLines="None">
                                <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                                    TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Paragraph" ItemStyle-Wrap="false" UniqueName="Paragraph" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Paragraph").ToString = String.Empty, "&nbsp;", Container.DataItem("Paragraph").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Category" UniqueName="Category" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Category").ToString = String.Empty, "&nbsp;", Container.DataItem("Category").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Type").ToString = String.Empty, "&nbsp;", Container.DataItem("Type").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Text" ItemStyle-Wrap="false" UniqueName="Text" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Text") = String.Empty, "&nbsp;", Container.DataItem("Text"))%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Responsible" UniqueName="Responsible" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Responsible").ToString = String.Empty, "&nbsp;", Container.DataItem("Responsible").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Start" UniqueName="Start" DataField="Start" Groupable="false"
                                            SortExpression="Start" GroupByExpression="Start [GridColumn_Start] Group By Start ASC" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#FormatDate(Eval("Start"))%></span>&nbsp;
                                            </ItemTemplate>

                                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="End" UniqueName="End" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#FormatDate(Eval("End"))%></span>&nbsp;
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" Groupable="false" HeaderStyle-Width="150px">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">
                                            &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                Visible='<%# rdgClauses.EditIndexes.Count = 0 AND (Not rdgClauses.MasterTableView.IsItemInserted) %>'
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
        <table width="100%" class="NormalWhiteBack" style="display: none">
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnSave" runat="server" Text="Save" meta:resourcekey="btnSave" />&nbsp;&nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" meta:resourcekey="btnCancel" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
