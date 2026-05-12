<%@ Page Language="vb" AutoEventWireup="false" meta:resourceKey="Page" CodeBehind="PickInventory.aspx.vb" Inherits="Website.PickInventory" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Pick Inventory</title>
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
                            var pane = $find('treeGroupAssetsPane');
                            pane.set_visible(true);
                            var paneContent = pane._contentElement;
                            paneContent.style.display = "block";
                            break;
                        case 'OpenUploadDiv':
                            var popup = $('#uploadToolbar')[0];
                            popup.style.display = 'block';
                            $('tr.ToolBar').css("cssText", "z-index:3001 !important");
                            break;
                    }
                }

                function UploadToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'closeUploadDiv') {
                        var popup = $('#uploadToolbar')[0];
                        $('tr.ToolBar').css("z-index", "");
                        popup.style.display = 'none';
                        $('#hdnopenDiv').val('')
                    }
                    else
                        if (args.get_item().get_commandName() == 'OpenBarCodeSettings') {
                            OpenBarCodeSettingsPopup('htnBarcodeField', 'htnBarcodeFormat', 0);
                        }
                }
                function treeToolbarClick(sender, args) {
                    if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                        var pane = $find('treeGroupAssetsPane');
                        pane.set_visible(false);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "none";
                        $('#hdnopenDiv').val('')
                        return false;
                    }
                }

                function AdjustCostCalculation(gridId) {
                    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () { var row = $(this).parents("tr:first"); Calculate(row); });
                }

                function Calculate(row) {
                    var txtTotalCost = row.find("input[id$='txtTotalCost']");
                    var txtQuantity = row.find("input[id$='txtQuantity']");
                    var txtUnitCost = row.find("input[id$='txtUnitCost']");
                    var txtOnHand = row.find("span[id$='lblOnHand']");
                    if (CDbl(txtQuantity.val()) == 0) {
                        txtQuantity.val(FPrec(1));
                    }
                    if (CDbl(txtQuantity.val()) > CDbl(txtOnHand.html())) {
                        txtQuantity.val(FPrec(CDbl(txtOnHand.html())));
                    }
                    txtTotalCost.val(FPrec(CDbl(txtUnitCost.val()) * CDbl(txtQuantity.val())));

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


                function UploadFileNow() {
                    var btnBarcode = $("[id$=btnBarcode]");
                    btnBarcode.click();
                }

                function btnSearchClick() {
                    if ($('input[id$=txtBarCode]').val() !== '') {
                        var btnRefreshGrid = $("[id$=btnRefreshGrid]");
                        btnRefreshGrid.click();
                    }

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
                .documentSplitter, .fullWidthPane, .SplitterPanePopup {
                    height: calc(100vh - 55px) !important;
                }

                .rfdSkinnedButton {
                    text-decoration: none !important;
                }

                .BarcodeToolbar1 {
                    margin-left: -48px;
                }

                .RadToolBar_Horizontal .rtbItem:first-child {
                    margin-left: 16px !important;
                    margin-right: 16px !important;
                }

                .RadToolBar_Horizontal .rtbItem {
                    margin-right: 16px !important;
                }

                .RadTreeView.CheckBoxesTreeview .trvInventory label .rtChk {
                    display: none !important;
                }

                .rtIn.trvInventory, .rtIn.InventorySubLocation {
                    background-color: transparent !important;
                    border: 0px !important;
                    padding: 0 !important;
                    background-image: none !important;
                }

                @media screen and (max-width: 843px) and (min-width: 320px) {
                    .tdBarCode {
                        padding-left: 0 !important;
                    }

                    .BarcodeToolbar1 {
                        margin-left: 5px !important;
                    }

                    .SplitterPanePopup {
                        height: 100% !important;
                    }
                }

                td#treeGroupAssetsPane {
                    position: relative;
                }
            </style>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdvInventory">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventories" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgInventories">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventories" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventories" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="rdvInventory"/>
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="pnlRadioButtonSelection">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventories" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdvInventory"/>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventories" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />

        <telerik:RadAjaxLoadingPanel ID="ldpAssets" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
        <div style="height: 100%">
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                <tr class="ToolBar">
                    <td style="width: 220px">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarBarcode ShowOnMobile" PostBack="false" CommandName="OpenUploadDiv"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                    <td>
                        <div class="toolbarPopup" id="uploadToolbar">
                            <telerik:RadToolBar ID="RadToolBar2" Height="50px" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="UploadToolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeUploadDiv"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarSettings ShowOnMobile PopupbarSettings" PostBack="false" CommandName="OpenBarCodeSettings"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                            <asp:Panel ID="pnlRadioButtonSelection" runat="server">
                                <table style="width: 100%" class="BarcodeToolbar1">
                                    <tr>
                                        <td class="HideOnMobilePopup" style="width: 24px; height: 30px; padding-right: 10px;padding-left: 18px;">
                                            <img src="CSS/Images/ResponsiveIcons/Barcode.png" class="barBarcode" />
                                        </td>
                                        <td style="width: 120px;" class="HideOnMobilePopup">
                                            <asp:RadioButton ID="rbtnMobileOrBrowse" runat="server" meta:resourcekey="rbtnMobileOrBrowse" Text="Mobile/Browse1"
                                                GroupName="BarCodeGroup" AutoPostBack="True" CssClass="RadioCss" />
                                        </td>
                                        <td style="width: 100px" class="HideOnMobilePopup">
                                            <asp:RadioButton ID="rbtnScanOrType" runat="server" meta:resourcekey="rbtnScanOrType" Text="Scan/Type1"
                                                GroupName="BarCodeGroup" AutoPostBack="True" CssClass="RadioCss" />
                                        </td>
                                        <td style="width: 200px; padding-left: 24px;" class="tdBarCode">
                                            <asp:LinkButton ID="btnUploadBarcode" runat="server" CssClass="PopupFileUpload ShowOnMobile" OnClientClick="PMBrowseFiles();return false;">
                                                <span class="Icon"></span>
                                                <asp:label runat="server" text="BROWSE FOR FILE" CssClass="uploadLabel" />  
                                            </asp:LinkButton>
                                            <asp:FileUpload ID="flUploadBarcode" CssClass="RemoveOnMobile" runat="server" Width="100%" onchange="UploadFileNow()" />
                                            <asp:TextBox ID="txtBarCode" CssClass="PopupTextUpload abcs" runat="server" Width="200" onkeypress="return keypress(event);" Height="24px"></asp:TextBox>
                                            <div class="UploadSearchIcon" id="searchIcon" runat="server" style="background-position: -216px; margin-left: 15px;" onclick="btnSearchClick()"></div>
                                            <asp:Button ID="btnBarcode" CssClass="Hide" runat="server" Text="Upload" />
                                            <asp:Label ID="lblmessage" runat="server" CssClass="Validator" Style="display: block;"></asp:Label>
                                        </td>
                                        <td class="HideOnMobilePopup">
                                            <asp:LinkButton ID="lblSettings" runat="server" meta:resourcekey="lblSettings" Style="margin-left: 65px; white-space: nowrap; font-size:12px !important; color:#666666 !important;"
                                                Text="Barcode Settings1" OnClientClick="return OpenBarCodeSettingsPopup('htnBarcodeField','htnBarcodeFormat',0);"></asp:LinkButton>
                                            <asp:Button ID="btnRefreshGrid" runat="server" CssClass="Hide" />
                                            <asp:HiddenField ID="htnBarcodeField" runat="server" />
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 100%; ">
            <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default" Width="100%" CssClass="documentSplitter" Style="height: 50px; "
                SplitBarsSize="">
                <telerik:RadPane ID="treeGroupAssetsPane" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup " Style="position: fixed; background: white; top: 0; height: 100%;"
                    EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" OnClientExpanded="ClientResized">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                        <tr>
                            <td colspan="2" class="treeToolbar">
                                <telerik:RadToolBar ID="TreeToolbar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px" CssClass="ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheckMark ShowOnMobile" Height="50px" CommandName="SaveExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile" Height="50px" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                    <telerik:RadTreeView ID="rdvInventory" runat="server" EnableDragAndDrop="True" Skin="Default" MultipleSelect="true" CssClass="CheckBoxesTreeview treePaddingOnMobile"
                        OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" OnNodeDrop="rdvInventory_NodeDrop" CheckBoxes="true" TriStateCheckBoxes="true"
                        OnClientNodeChecked="ShowHidebtnTreeDropItems">
                        <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                        <ExpandAnimation Duration="100"></ExpandAnimation>
                    </telerik:RadTreeView>
                    <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                        <div class="btnTreeDropItemswithBackground">&nbsp; </div>
                    </asp:LinkButton>
                </telerik:RadPane>
                <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="TreeToolbarSplitbar" CollapseMode="Forward" />
                <telerik:RadPane ID="RadContentPane" runat="server" Index="2" Skin="Default" CssClass="fullWidthPane" OnClientResized="ClientResized">

                    <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                        <div class="row RowWithNoPaddingTop">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgInventories" runat="server" Skin="Default" Width="100%" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true"
                                    AllowMultiRowSelection="True" AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" FitPageHeightOffset="5">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="IndexId" Width="100%" CommandItemDisplay="Top">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Item" ItemStyle-Wrap="false" UniqueName="Item" HeaderStyle-Width="60px">
                                                <ItemTemplate>
                                                    <span>
                                                        <%# CDbl(Eval("ItemId")).ToString%>&nbsp;
                                                    </span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="170px">
                                                <ItemTemplate>
                                                    <span>
                                                        <%# Eval("Description") %>&nbsp;
                                                    </span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" ItemStyle-Wrap="false" HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <span>
                                                        <%# Eval("UOM") %>&nbsp;
                                                    </span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="OnHand" HeaderText="On Hand" ItemStyle-Wrap="false" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOnHand" runat="server" Width="100%" Text='<%# FormatNumber(Eval("OnHand")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Quantity to Pick" UniqueName="QuantitytoPick" HeaderStyle-Width="100px">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtQuantity" runat="server" CssClass="PositiveDouble" MaxLength="15"
                                                        Text='<%# FormatNumber(Eval("Quantity")) %>' Width="100%"></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Unit Cost" HeaderStyle-Wrap="false" UniqueName="UnitCost"
                                                HeaderStyle-Width="75px" ItemStyle-HorizontalAlign="Right" SortExpression="UnitCost">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtUnitCost" runat="server" Enabled="false" CssClass="PositiveDouble" MaxLength="15"
                                                        Text='<%# FormatNumber(Eval("UnitCost")) %>' Width="100%"></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" HeaderStyle-Wrap="false"
                                                HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Right" SortExpression="TotalCost">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTotalCost" runat="server" Enabled="false" CssClass="PositiveDouble" MaxLength="15"
                                                        Text='<%# FormatNumber(Eval("TotalCost")) %>' Width="100%"></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="StockNumber" HeaderText="Stock #" HeaderStyle-Width="80px" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <span>
                                                        <%# Cdbl(Eval("StockNumber")).toString%>
                                                    </span>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-Width="150px">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtNotes" runat="server" Width="100%" Text='<%# Eval("Notes") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                OnClientClick="return ConfirmDelete()" Visible="<%# rdgInventories.EditIndexes.Count = 0 And (Not rdgInventories.MasterTableView.IsItemInserted)%>">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                                CommandName="RebindGrid" Visible="<%# rdgInventories.EditIndexes.Count = 0 And (Not rdgInventories.MasterTableView.IsItemInserted)%>">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblRefresh"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </CommandItemTemplate>
                                        <NoRecordsTemplate>
                                            <table style="height: 200px; width: 100%">
                                                <tr>
                                                    <td align="center" valign="middle">
                                                        <asp:Label ID="lblNoRecords" meta:resourceKey="lblNoRecords" runat="server" Text="Drag inventory items from the treeview and drop them here."></asp:Label></td>
                                                </tr>
                                            </table>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="true" />
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>

                </telerik:RadPane>
            </telerik:RadSplitter>
            <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
            <%--<tr>
                <td align="right">
                    <table width="500px">
                        <tr align="right">
                            <td style="padding-left: 22px" align="right">
                                <asp:LinkButton ID="lbtSave" meta:resourceKey="lbtSave" runat="server" Text="Save"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                        <asp:LinkButton ID="lbtCancel" runat="server" meta:resourceKey="lbtCancel" Text="Cancel"></asp:LinkButton>
                            </td>
                        </tr> 
                    </table>
                </td>
            </tr>--%>
            <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
                ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
                IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
                Top="">
            </telerik:RadWindowManager>
        </div>
    </form>
</body>
</html>
