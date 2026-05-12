<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="GlobalLinkedRecords.aspx.vb" Inherits="Website.GlobalLinkedRecords" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <style type="text/css">
        body {
            background: white none !important;
            color: #000000;
        } 

        .TSearchButton {
            padding: 4px 4px 4px 27px;
            border: 1px solid #CCCCCC;
            width: 260px !important;
            height: 10px;
        }

        #rpLinkedRecords {
            position: relative;
        }

        .RadTreeView.CheckBoxesTreeview .trvFolder label .rtChk {
            display: none !important;
        }

        .CheckBoxesTreeview .rtTop.trvProject .rtChk {
            display: none !important;
        }

         .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                margin-left: 16px !important;
                margin-right: 16px !important;
            }
        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 52px) !important;
        }
        .documentSplitter{padding-top:50px;}
        @media screen and (max-width: 843px) and (min-width: 320px) {
            .SplitterPanePopup {
                top: -4px !important;
            }
        }
    </style>

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

            function lbtSaveAndClose_OnClientClick() {
                var Source = '<%=QueryStringSource%>';
                var from = '<%=QueryStringFrom%>'
                if (Source == 'PMWebViewer') {
                    var grid = $find("<%=rdgLinkedRecords.ClientID %>");
                    var gridItem = grid.get_masterTableView().get_dataItems()[0];
                    if (gridItem) {
                        var RecordId = gridItem.getDataKeyValue("Id");
                        var RecordType = gridItem.getDataKeyValue("RecordType");
                        var Description = gridItem.getDataKeyValue("Description");
                        var RecordTypeId = gridItem.getDataKeyValue("ObjectTypeId");
                        var RecordNumber = gridItem.getDataKeyValue("RecordNumber");
                        if (from == 'Menu')
                        { window.parent.AddLinkedRecordFromMenu(RecordId, Description, RecordType, RecordTypeId, RecordNumber); }
                        else
                        {
                            window.parent.LinkedRecordClicked(RecordId, Description, RecordType, RecordTypeId, RecordNumber);
                        }
                    }
                    CloseRadWnd();
                }


            }

            function InitiateAjaxRequest() {
                var NodeValue = '';
                var ObjectTypeId = 0;
                var tree = $find("<%= rtvLinkedRecords.ClientID %>");
                if (tree != null) {
                    var Node = tree.get_selectedNode();
                    if (Node != null) {
                        NodeValue = Node._getData().value;
                        ObjectTypeId = Node._getData().attributes.ObjectTypeId;//Node._attributes.getAttribute('ObjectTypeId');
                    }
                }
                if (NodeValue == '' || NodeValue.indexOf('M_') == 0 || NodeValue.indexOf('P_') == 0) {  }
                else {
                    var arg = String(NodeValue) + ',' + String(ObjectTypeId);
                    var ajaxManager = $find("<%= PMAjaxManager.ClientID %>");
                    ajaxManager.ajaxRequest(arg);
                }
            }

            function RadSplitterClientLoad() {

            }

            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('rpLinkedRecords');
                pane.set_visible(false);
                openDivByCommandName(value);
            }


            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                $('#hdnopenDiv').val(value);
                openDivByCommandName(value);
            }
            function openDivByCommandName(value){
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
                var pane = $find('rpLinkedRecords');
                $('#hdnopenDiv').val('')
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

        function btnSearchClick() {
            if ($('input[id$=txtSearch]').val() !== '') {
                var btnSearch = $("[id$=btnSearch]");
                btnSearch.click();
            }

        }

        </script>

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
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLinkedRecords"/>
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="lbtMoveItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="PMAjaxManager">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLinkedRecords"/>
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
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save" style="margin-right:-8px !important;"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </div>

        <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default" OnClientLoad="RadSplitterClientLoad" CssClass="documentSplitter"
            Width="100%" Height="100%">
            <telerik:RadPane ID="rpLinkedRecords" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" Width="420px" OnClientExpanded="ClientResized"
                Height="590px">
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
                <table class="treePaddingOnMobile TableNoSpacingNoBorder" width="100%">
                    <tr class="ToolBarTreePane" id="ddlLabelProject" runat="server">
                        <td class="labelWidth" style="background: transparent !important; padding-left: 24px; box-sizing: border-box; width: 160px !important;">
                            <asp:Label ID="lblProject" runat="server" Text="Project" meta:Resourcekey="lblProject"></asp:Label>
                        </td>
                        <td class="controlWidth" style="background: #EDEDED !important;">
                            <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:Resourcekey="ddlProjects"
                                NoWrap="true" Skin="Default" Style="width: 240px !important" DropDownWidth="400px" ShowMoreResultsBox="True"
                                EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                            </telerik:RadComboBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="background: #EDEDED !important;padding:8px;">
                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" Style="width:360px;">
                                <telerik:RadTextBox ID="txtSearch" style="margin-left: 20px;" Width="300px" EmptyMessageStyle-Font-Italic="true" EmptyMessage="<%$Resources: txtSearchEmptyMessage %>" MaxLength="100" CssClass="TSearchButton" runat="server"></telerik:RadTextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" cssclass="Hide" />
                              <div class="UploadSearchIcon" id="searchIcon" runat="server" style="background-position: -216px; position:static !important;float:right;margin-top:0!important" onclick="btnSearchClick()"></div>
                            </asp:Panel>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <telerik:RadTreeView ID="rtvLinkedRecords" runat="server" EnableDragAndDrop="True" AllowNodeEditing="false" CheckBoxes="true"
                                Skin="Default" MultipleSelect="true" OnClientNodeDropping="onNodeDropping" OnClientDoubleClick="InitiateAjaxRequest"
                                OnClientNodeDragging="onNodeDragging" Height="100%" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <%-- <NodeTemplate>
                                    <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                                </NodeTemplate>--%>
                            </telerik:RadTreeView>
                            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                <div class="btnTreeDropItems">&nbsp;</div>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Height="100%" CssClass="fullWidthPane" OnClientResized="ClientResized">
                <div id="LinkedRecordsPane" style="vertical-align: top;" class="NormalWhiteBack">
                    <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                        <div class="row RowWithNoPaddingTop">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgLinkedRecords" runat="server" AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                    ShowStatusBar="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" HeaderStyle-Font-Size="8" FitPageHeightOffset="5">
                                    <MasterTableView DataKeyNames="Id,ObjectTypeId" ClientDataKeyNames="Id,RecordType,Description,ObjectTypeId,RecordNumber" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                        <Columns>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Record Type" UniqueName="RecordType" HeaderStyle-Width="15%">
                                                <ItemTemplate>
                                                    <span><%# IIF(Eval("RecordType")=string.empty,"&nbsp;",Eval("RecordType")) %></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Record #" UniqueName="RecordNumber" HeaderStyle-HorizontalAlign="left"
                                                HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocumentId" runat="server" Text='<%# Eval("RecordNumber") %>'></asp:Label>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right" HeaderText="Date" UniqueName="RevisionDate" HeaderStyle-HorizontalAlign="left"
                                                HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDocDate" runat="server" Text='<%# FormatDate(Eval("RevisionDate")) %>'></asp:Label>
                                                    &nbsp;
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right" HeaderText="Revision" UniqueName="RevisionNumber" HeaderStyle-HorizontalAlign="left"
                                                HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRevision" runat="server" Text='<%# Eval("RevisionNumber") %>'></asp:Label>&nbsp;
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Status" UniqueName="Status" HeaderStyle-HorizontalAlign="left"
                                                HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# IIF(Eval("Status")=String.empty,"&nbsp;",Eval("Status")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Description" UniqueName="Description" HeaderStyle-HorizontalAlign="left"
                                                HeaderStyle-Width="180px">
                                                <ItemTemplate>
                                                    <span style="white-space: nowrap">
                                                        <%# Eval("Description") %>
                                                    </span>

                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                OnClientClick="return ConfirmDelete()" Visible="True">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                        AllowDragToGroup="false" AllowRowsDragDrop="false">
                                        <Selecting AllowRowSelect="true" />
                                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
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
