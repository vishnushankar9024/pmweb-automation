<%@ Page Language="vb" AutoEventWireup="false" meta:resourceKey="Page" CodeBehind="SelectAsset.aspx.vb" Inherits="Website.SelectAsset" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Assets</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">

                function pageLoad() {
                    var value = $('#hdnopenDiv').val()
                    if (value == '' || value == 'ToggleSplitter') return false;
                    var pane = $find('treeGroupAssetsPane');
                    pane.set_visible(false);
                    var paneContent = pane._contentElement;
                    paneContent.style.display = "block";
                    openDivByCommandName(value);

                }

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


                //********************* KeyPress Event


                function keypress(e) {
                    var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0; //alert(key); 
                    if ($('input[id$=txtBarCode]').val() !== '' && key == 13) {
                        var btnRefreshGrid = $("[id$=btnRefreshGrid]");
                        btnRefreshGrid.click();
                    }
                }

                $(document).ready(function (n) {
                    if ($('input[id$=txtBarCode]')) {
                        $('input[id$=txtBarCode]').focus();
                    }
                });

                function OnClientNodeClicked(sender, eventArgs) {
                    var node = eventArgs.get_node();
                    window.parent.SelectAsset(node);
                    window.close();
                    return false;
                }
     
                function maintoolbarClick(sender, args) {
                    var value = args.get_item().get_commandName();
                    var hdnAssetSaved = $(window.parent.document).find("[id$=hdnAssetSaved]");
                    if (value == 'Save' || value == 'SaveExit') {
                        
                        if (hdnAssetSaved.length !==0){
                            hdnAssetSaved[0].value = "1";
                        }
                    }
                    $('#hdnopenDiv').val(value)
                    openDivByCommandName(value);
                }

                function openDivByCommandName(value) {
                    switch (value) {
                        case 'ToggleSplitter':
                            var pane = $find('treeGroupAssetsPane');
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block";
                            break;
                        case 'OpenUploadDiv':
                            var popup = $('#uploadToolbar')[0];
                            popup.style.display = 'block';
                            var td = document.querySelector('#tdBarCode');
                            var toolBar = document.querySelectorAll('.ToolBar1');
                            toolBar[0].style.zIndex = '10';
                            td.classList.toggle('leftPad');
                            break;
                    }
                }

                function UploadToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'closeUploadDiv') {
                        var popup = $('#uploadToolbar')[0];
                        popup.style.display = 'none';
                        $('#hdnopenDiv').val('');
                        var toolBar = document.querySelectorAll('.ToolBar1');
                        toolBar[0].style.zIndex = '0'
                        var td = document.querySelector('#tdBarCode');
                        td.classList.toggle('leftPad');
                    }
                    else
                        if (args.get_item().get_commandName() == 'OpenBarCodeSettings') {
                            OpenBarCodeSettingsPopup('htnBarcodeField', 'htnBarcodeFormat', 1);
                        }
                }

                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                        var pane = $find('treeGroupAssetsPane');
                        pane.set_visible(false);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        $('#hdnopenDiv').val('');
                        return false;
                    }
                }

                function UploadFileNow() {
                    var btnBarcode = $("[id$=btnBarcode]");
                    btnBarcode.click();
                }

                function PMBrowseFiles() {
                    $('input[id$=flUploadBarcode]').click();
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
                td#treeGroupAssetsPane {
                    position: relative;
                }

                .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                    height: calc(100vh - 50px) !important;
                }

                body {
                    background: white none !important;
                    color: #000000;
                }

                .rfdSkinnedButton {
                    text-decoration: none !important;
                }

                .leftPad {
                    padding-left: 10px;
                }

                @media screen and (min-width:320px) and (max-width:843px) {
                    div#trvGroupedAssets {
                        max-height: none !important;
                    }

                    .RemoveOnMobile {
                        display: none !important;
                    }

                    .SplitterPanePopup {
                        height: calc(100vh - 0px) !important;
                    }
                }

                .RadTreeView {
                    margin: 0px !important;
                }



                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .documentSplitter1 {
                        padding-top: 8px !important;
                        position: fixed !important;
                        background: white !important;
                        z-index: 0 !important;
                    }
                }

                .documentSplitter1 {
                    height: calc(100vh - 110px) !important;
                }

                .BarCodeSettings .rtbIcon {
                    background-position: -2280px 0px !important;
                }

                .toolbarPopup .rtbUL {
                    padding-left: 8px !important;
                }

                .ToolBar1 {
                    background-color: RGB(237,237,237);
                    background-image: none;
                }



                .NormalWhiteBack .RadToolBar .rtbInner {
                    padding-left: 14px;
                }
            </style>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="trvGroupedAssets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
                         <telerik:AjaxUpdatedControl ControlID="trvGroupedAssets" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="trvGroupedAssets" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgAssets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="pnlRadioButtonSelection">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAssets" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />

        <telerik:RadAjaxLoadingPanel ID="ldpAssets" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />

        <table class="ToolBar1" border="0" cellpadding="0" cellspacing="0" width="100%" style="z-index: 0 !important; top: 0px !important">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="120px" CssClass="small-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true" CssClass="ShowOnMobile"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarBarcode ShowOnMobile" PostBack="false" CommandName="OpenUploadDiv"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                    <td>
                        <div class="toolbarPopup" id="uploadToolbar" style="z-index: 10 !important;">
                            <telerik:RadToolBar ID="RadToolBar2" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar ShowOnMobile" Height="50px" Width="100%" OnClientButtonClicked="UploadToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ShowOnMobile BarCodeSettings" PostBack="false" Height="50px" CommandName="OpenBarCodeSettings"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile PopupbarSettings" Height="50px" PostBack="false" CommandName="closeUploadDiv"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                            <asp:Panel ID="pnlRadioButtonSelection" runat="server" Style="display: inline-block; width: inherit">
                                <table style="width: inherit !important;">
                                    <tr>
                                        <td class="HideOnMobilePopup" style="width: 50px; height: 30px; padding-left: 27px;">
                                            <img src="Images/Global/BarCodeSmall.png" alt="" />
                                        </td>
                                        <td style="width: 120px" class="HideOnMobilePopup">
                                            <asp:RadioButton ID="rbtnMobileOrBrowse" runat="server" meta:resourcekey="rbtnMobileOrBrowse" Text="Mobile/Browse1"
                                                GroupName="BarCodeGroup" AutoPostBack="True" CssClass="RadioCss" />
                                        </td>
                                        <td style="width: 100px" class="HideOnMobilePopup">
                                            <asp:RadioButton ID="rbtnScanOrType" runat="server" meta:resourcekey="rbtnScanOrType" Text="Scan/Type1"
                                                GroupName="BarCodeGroup" AutoPostBack="True" CssClass="RadioCss" />
                                        </td>
                                        <td style="width: 260px;" id="tdBarCode">
                                            <asp:LinkButton ID="btnUploadBarcode" runat="server" CssClass="PopupFileUpload ShowOnMobile" OnClientClick="PMBrowseFiles();return false;">
                                                <span class="Icon"></span>
                                                <asp:label runat="server" text="BROWSE FOR FILE" CssClass="uploadLabel" />  
                                            </asp:LinkButton>
                                            <asp:FileUpload ID="flUploadBarcode" CssClass="RemoveOnMobile" runat="server" Width="100%" onchange="UploadFileNow()" />

                                            <asp:Button ID="btnBarcode" CssClass="Hide" runat="server" Text="Upload" />
                                            <asp:TextBox CssClass="PopupTextUpload" ID="txtBarCode" runat="server" Width="220" onkeypress="return keypress(event);" Height="18px"></asp:TextBox>
                                            <div class="UploadSearchIcon" id="searchIcon" runat="server" style="background-position: -216px;"></div>
                                            <asp:Label ID="lblmessage" runat="server" CssClass="Validator" Style="display: block;"></asp:Label>


                                        </td>
                                        <td style="padding-left: 50px" class="HideOnMobilePopup">
                                            <asp:LinkButton ID="lblSettings" runat="server" meta:resourcekey="lblSettings"
                                                Text="Barcode Settings1" OnClientClick="return OpenBarCodeSettingsPopup('htnBarcodeField','htnBarcodeFormat',1);"></asp:LinkButton>
                                            <asp:Button ID="btnRefreshGrid" runat="server" CssClass="Hide" />
                                            <asp:HiddenField ID="htnBarcodeField" runat="server" />
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </td>
                    <td class="HideOnMobilePopup"></td>
                </tr>
            </table>

        <telerik:RadSplitter ID="RadSplitter1" CssClass="documentSplitter1" runat="server" Orientation="vertical" Skin="Default" Width="100%">
            <telerik:RadPane ID="treeGroupAssetsPane" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" Height="600px" Width="420px" OnClientExpanded="ClientResized">
                <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="treeToolbar">
                            <telerik:RadToolBar ID="TreeToolbar" runat="server" Height="50px" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick" Style="z-index: 5 !important">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                    </tr>
                </table>
                <telerik:RadTreeView ID="trvGroupedAssets" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" CssClass="treePaddingOnMobile"
                    OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" OnNodeDrop="trvGroupedAssets_NodeDrop" Height="100%" 
                    CheckBoxes="true" TriStateCheckBoxes="false" CheckChildNodes="false" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                    <ExpandAnimation Duration="100"></ExpandAnimation>
                </telerik:RadTreeView>
                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                    <div class="btnTreeDropItemswithBackground">&nbsp;</div>
                </asp:LinkButton>
            </telerik:RadPane>
            <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward" />
            <telerik:RadPane ID="RadContentPane" runat="server" Height="600px" CssClass="fullWidthPane" OnClientResized="ClientResized">
                <div id="AssetsPane" style="vertical-align: top;" class="NormalWhiteBack">
                    <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                        <div class="row RowWithNoPaddingTop">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgAssets" runat="server" AllowMultiRowSelection="True" ItemStyle-Height="20px" SetWidth="true" FitPageHeightOffset="5"
                                    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" CommandItemDisplay="Top" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Suite" ItemStyle-Wrap="false" UniqueName="Suite" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Suite") = String.Empty, "&nbsp;", Container.DataItem("Suite"))%></span>
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Location" ItemStyle-Wrap="false" UniqueName="Property" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Property") = String.Empty, "&nbsp;", Container.DataItem("Property"))%></span>
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Building" ItemStyle-Wrap="false" HeaderText="Building" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Floor" ItemStyle-Wrap="false" HeaderText="Floor" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Floor") = String.Empty, "&nbsp;", Container.DataItem("Floor"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Space" ItemStyle-Wrap="false" HeaderText="Space" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Equipment" ItemStyle-Wrap="false" UniqueName="Equipment" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%></span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                &nbsp;&nbsp;
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmDelete();"
                                                Visible='<%# rdgAssets.EditIndexes.Count = 0 AND (Not rdgAssets.MasterTableView.IsItemInserted) %>'
                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CssClass="GridCmdRefresh"
                                                    SecurityButtonType="ItemMode" Visible='<%# rdgAssets.EditIndexes.Count = 0 And (Not rdgAssets.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnRefreshResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                        <NoRecordsTemplate>
                                            <table style="height: 200px; width: 100%">
                                                <tr>
                                                    <td align="center" valign="middle">
                                                        <asp:Label ID="lblDrag" meta:resourceKey="lblDrag" runat="server" Text="Drag assets from the treeview and drop them here."> </asp:Label></td>
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

        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
