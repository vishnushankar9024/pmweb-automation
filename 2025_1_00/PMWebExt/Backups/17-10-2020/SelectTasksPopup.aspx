
<%@ Page Language="vb" Title="Select Tasks" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="SelectTasksPopup.aspx.vb" Inherits="Website.SelectTasksPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var gridId;
            function pageLoad() {
                gridId = $find("<%= rdgTasks.ClientID%>").get_id();
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('rpnTasksTree');
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

            function ResetCombos(combobox, eventArgs) {
                var item = eventArgs.get_item();
                if (combobox.get_id() == 'ddlResources') {
                    var ddlResourcePayTypes = $find('ddlPayTypes');
                    ddlResourcePayTypes.clearItems();
                    ddlResourcePayTypes.set_text(item.get_attributes().getAttribute("ResourcePayType"));
                    ddlResourcePayTypes.set_value(item.get_attributes().getAttribute("PayTypeId"));

                    var ddlResourceClasses = $find('ddlClassifications');
                    ddlResourceClasses.clearItems();
                    ddlResourceClasses.set_text(item.get_attributes().getAttribute("ResourceClassification"));
                    ddlResourceClasses.set_value(item.get_attributes().getAttribute("ClassificationId"));

                }
            }

            function GetValueToReturn(combobox, eventArgs) {
                if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
                    eventArgs.set_cancel(true);
                } else {
                    eventArgs.set_cancel(false);
                }
                var SelectedValue;
                if ((combobox.get_id() == 'ddlPayTypes') || (combobox.get_id() == 'ddlClassifications')) {
                    var ddlResources = $find('ddlResources');
                    SelectedValue = ddlResources.get_value();
                }

                var context = eventArgs.get_context();
                context["FilterString"] = SelectedValue;
            }
            function ValidateResourcesCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value != '') {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    }
                }
                else
                    args.IsValid = true;
            }

            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();
                $('#hdnopenDiv').val(value)
                openDivByCommandName(value)
            }
            function openDivByCommandName(value) {

                switch (value) {

                    case 'ToggleSplitter':
                        var pane = $find('rpnTasksTree');
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
                    var pane = $find('rpnTasksTree');
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
        .PopupToolbarPaddingTop{padding-top:50px;}
        .documentSplitter {
            height: calc(100vh - 52px) !important;
            position: sticky !important;
        }

        .SplitterPanePopup {
            height: calc(100vh - 52px) !important;
            position: sticky !important;
        }

        .fullWidthPane {
            height: calc(100vh - 52px) !important;
            position: sticky !important;
        }
        @media screen and (min-width:844px){
            #RAD_SPLITTER_PANE_CONTENT_rpnTasksTree.SplitterPanePopup {
                position:relative !important;
            }
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .fullWidthPane {
                width: calc(100vw - 24px) !important;
                padding-top: 0px !important;
            }

            .SplitterPanePopup {
                height: calc(100vh - 52px) !important;
                position: fixed !important;
                padding-top: 0px !important;
            }
            .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left: 16px !important;
            margin-right: 16px !important;
        }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgTasks">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgTasks" LoadingPanelID="ldpTasks" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvTasks">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgTasks" LoadingPanelID="ldpTasks" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgTasks" LoadingPanelID="ldpTasks" />
                        <telerik:AjaxUpdatedControl ControlID="rtvTasks" LoadingPanelID="ldpTasks" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpTasks" runat="server" Skin="Default" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ToolBar" style="z-index:0 !important">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarHeader ShowOnMobile" PostBack="false" CommandName="OpenHeadDiv"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>

            </tr>
        </table>
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="PopupToolbarPaddingTop"
            SplitBarsSize="">
            <telerik:RadPane ID="rpnTasksTree" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" Width="420px" OnClientExpanded="ClientResized"
                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr>
                        <td colspan="2" class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px" CssClass="ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheckMark  ShowOnMobile" Height="50px" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel  ShowOnMobile" Height="50px" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td>
                            <telerik:RadTreeView ID="rtvTasks" runat="server" EnableDragAndDrop="True" CssClass="CheckBoxesTreeview treePaddingOnMobile"
                                OnClientNodeDropping="onNodeDropping" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                OnClientNodeDragging="onNodeDragging" CheckBoxes="true" TriStateCheckBoxes="true"
                                Skin="Default" MultipleSelect="True" Width="100%">
                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                <CollapseAnimation Duration="100" Type="OutQuint" />
                            </telerik:RadTreeView>
                            <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                <div class="btnTreeDropItems">&nbsp; </div>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False" CollapseMode="Forward"
                Index="1" Skin="" />
            <telerik:RadPane ID="rpnTasksGrid" runat="server" EnableEmbeddedBaseStylesheet="False" CssClass="fullWidthPane OverflowHidden" OnClientResized="ClientResized"
                Index="2" Skin="">
                <div id="headpopup" class="popupDiv" style="z-index:10000 !important">
                  <telerik:RadToolBar ID="RadToolBar1" Height="50px" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick">
                                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeHead"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                    <div class="PMMainPage PMPopupMainPage">
                        <div class="row">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblResource" meta:resourcekey="lblResource" runat="server" Text="Resource1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlResources" AutoPostBack="true" runat="server" Width="100%" Filter="Contains" ValidationGroup="Save"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Resource..." meta:resourcekey="ddlResources"
                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="ResetCombos"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvResources" meta:Resourcekey="rfvResources" runat="server"
                                                CssClass="Validator" InitialValue="" ErrorMessage="Resource Required." ControlToValidate="ddlResources"
                                                Display="Dynamic" Enabled="true" ForeColor="" ValidationGroup="Save">
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvResources" runat="server" ControlToValidate="ddlResources"
                                                ClientValidationFunction="ValidateResourcesCombo" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" ErrorMessage="Enter The Resource" meta:Resourcekey="csvResources">
                                            </asp:CustomValidator></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblClassification" meta:resourcekey="lblClassification" runat="server" Text="Classification1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlClassifications" runat="server" Width="200px" Filter="Contains" meta:resourcekey="ddlClassifications"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Class..."
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPayType" meta:resourcekey="lblPayType" runat="server" Text="Pay Type1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPayTypes" runat="server" Width="200px" Filter="Contains" meta:resourcekey="ddlResourcePayTypes"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Pay Type..."
                                                NoWrap="True" AllowCustomText="false" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                Style="font-size: 11px" Height="200px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="PMMainPage PMPopupMainPage PopupGridMargin">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgTasks" runat="server" SetWidth="true" AppendMenus="true" ClientSettings-Scrolling-AllowScroll="true"
                                Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" AllowMultiRowSelection="True"
                                GridLines="None">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="ID" UniqueName="TaskID">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Id") = 0, "&nbsp;", Container.DataItem("Id"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="150px" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Code1" UniqueName="Code">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Project1" UniqueName="Project">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Project") = String.Empty, "&nbsp;", Container.DataItem("Project"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="300px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Task" UniqueName="Task">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Task") = String.Empty, "&nbsp;", Container.DataItem("Task"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="400px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Start" UniqueName="Start">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Start") = String.Empty, "&nbsp;", Container.DataItem("Start"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="Finish">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Finish") = String.Empty, "&nbsp;", Container.DataItem("Finish"))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="% Complete" UniqueName="PercentageComplete">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("PercComplete") = 0, "&nbsp;", FormatNumber(Container.DataItem("PercComplete")))%></span>
                                            </ItemTemplate>
                                            <HeaderStyle Width="200px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgTasks.EditIndexes.Count = 0 And (Not rdgTasks.MasterTableView.IsItemInserted)%>">
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
        <table width="100%" class="NormalWhiteBack" style="display: none">
            <tr>
                <td align="right">
                    <asp:LinkButton ID="lbtSave" runat="server" Text="Save to record" meta:resourcekey="lbtSave" ValidationGroup="Save"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtSaveAndClose" runat="server" Text="<%$ Resources:PMWeb, SaveClose %>" ValidationGroup="Save"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Close %>"></asp:LinkButton>&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
    </form>
</body>
</html>
