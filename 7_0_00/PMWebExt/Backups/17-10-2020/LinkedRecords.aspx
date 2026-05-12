<%@ Page Language="vb" Title="Linked Records" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="LinkedRecords.aspx.vb"
    Inherits="Website.LinkedRecords" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">

            var gridId = "RadContentPane";

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('rpLinkedRecords');
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

                var grid = isMouseOverGrid(target);
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
                        var pane = $find('rpLinkedRecords');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        break;
                }
            }

            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    $('#hdnopenDiv').val('')
                    var pane = $find('rpLinkedRecords');
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
            #rpLinkedRecords {
                position: relative;
            }

            .RadTreeView.CheckBoxesTreeview .trvFolder label .rtChk {
                display: none !important;
            }

            .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                height: calc(100vh - 56px) !important;
            }

            .CheckBoxesTreeview .rtTop.trvProject .rtChk {
                display: none !important;
            }

            @media screen and (max-width: 843px) and (min-width: 320px) {
                .SplitterPanePopup {
                    left: 0 !important;
                }
            }

            .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                margin-left: 16px !important;
                margin-right: 16px !important;
            }

            .documentSplitter {
                padding-top: 50px;
            }
        </style>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server" EnableScriptGlobalization="True">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rtvLinkedRecords">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSaveToRecord">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLinkedRecords" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <div>
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Cancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </div>



        <telerik:RadSplitter ID="RadSplitter1" CssClass="documentSplitter" runat="server" Orientation="vertical" Skin="Default"
            Width="100%" Height="560px">
            <telerik:RadPane ID="rpLinkedRecords" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" Width="420px" OnClientExpanded="ClientResized"
                Height="560px">
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
                <telerik:RadTreeView ID="rtvLinkedRecords" CssClass="treePaddingOnMobile" runat="server" EnableDragAndDrop="True" AllowNodeEditing="false"
                    OnNodeDrop="rtvLinkedRecords_NodeDrop" Skin="Default" OnClientNodeDropping="onNodeDropping" CheckBoxes="true"
                    OnClientNodeDragging="onNodeDragging" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                     <div class="btnTreeDropItems">&nbsp;</div>
                </asp:LinkButton>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Width="100%" Height="600px" CssClass="fullWidthPane" OnClientResized="ClientResized">
                <div id="LinkedRecordsPane" style="vertical-align: top;" class="NormalWhiteBack">
                    <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                        <div class="row RowWithNoPaddingTop">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgLinkedRecords" runat="server" Skin="Default" AutoGenerateColumns="False" FitPageHeightOffset="5"
                                    ShowStatusBar="true" HeaderStyle-Font-Size="8" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true" ClientSettings-Scrolling-UseStaticHeaders="true">
                                    <MasterTableView DataKeyNames="Id" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Record Type" UniqueName="RecordType" HeaderStyle-Width="18%">
                                                <ItemTemplate>
                                                    <span><%# IIF(Eval("RecordType")=string.empty,"&nbsp;",Eval("RecordType")) %></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Doc #" UniqueName="DocNumber" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocumentId" runat="server" Text='<%# Eval("DocumentNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Document Date" UniqueName="DocumentDate" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="15%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocDate" runat="server" Text='<%# FormatDate(Eval("DocumentDate")) %>'></asp:Label>
                                                    &nbsp;
                                                </ItemTemplate>
                                                <HeaderStyle Width="100px" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Rev." UniqueName="Rev" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRevision" runat="server" Text='<%# Eval("Revision") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="100px" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# IIF(Eval("Status")=String.empty,"&nbsp;",Eval("Status")) %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="45%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Width="98%" Text='<%# Eval("Description") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="250px" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                        AllowDragToGroup="false" AllowRowsDragDrop="false">
                                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True"></Resizing>
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
