<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EstimateItemsSelect.aspx.vb"
    Inherits="Website.EstimateItemsSelect" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Items</title>
    <%--<link href="CSS/TreeView.PM.css" rel="stylesheet" type="text/css" />
<link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
            function pageLoad() {
                var value = $('#hdnopenDiv').val()
                if (value == '' || value == 'ToggleSplitter') return false;
                var pane = $find('treeGroupsAndItemsPane');
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
                        var pane = $find('treeGroupsAndItemsPane');
                        pane.set_visible(true);
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        

                        break;
                    case 'OpenHeadDiv':
                        var popup = $('#headpopup')[0];
                        popup.style.display = 'block';
                        break;
                    case 'OpenUploadDiv':
                        var popup = $('#uploadToolbar')[0];
                        popup.style.display = 'block';
                        $('tr.ToolBar').css("cssText", "z-index:3001 !important");
                        break;
                }
            }
            function headToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'closeHead') {
                    var popup = $('#headpopup')[0];
                    popup.style.display = 'none';
                    $('#hdnopenDiv').val('')
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
                    var pane = $find('treeGroupsAndItemsPane');
                    pane.set_visible(false);
                    $('#hdnopenDiv').val('')
                    return false;
                }
            }
            function AdjustCostCalculation(gridId) {
                var grid = $("#" + "rdgItems");

                // On change Unit Cost
                $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first"); Calculate(row);
                });

                // On change quantity
                $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first"); Calculate(row);
                });

                //On change TotalCost
                $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first"); Calculate(row, 2);
                });
            }
            function Calculate(row, index) {
                index = index || 1;
                var txtTotalCost = row.find("input[id$='txtTotalCost']");
                var txtQuantity = row.find("input[id$='txtQuantity']");
                var txtUnitCost = row.find("input[id$='txtUnitCost']");
                var AmountVal = CDbl(txtTotalCost.val());
                var QantityVal = CDbl(txtQuantity.val());
                if (index == 2) {
                    if (QantityVal == 0) {
                        QantityVal = 1;
                        txtQuantity.val(FPrec(1));

                    }

                    txtUnitCost.val(CCur(AmountVal / QantityVal));


                }
                else {
                    txtTotalCost.val(FPrec(CDbl(txtUnitCost.val()) * CDbl(txtQuantity.val())));
                }
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
            function ValidateCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value > 0 && value != '') {
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
            function btnSearchClick() {
                if ($('input[id$=txtBarCode]').val() !== '') {
                    var btnRefreshGrid = $("[id$=btnRefreshGrid]");
                    btnRefreshGrid.click();
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
        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 52px) !important;
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

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .tdBarCode {
                padding-left: 0 !important;
            }
             .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 4px) !important;
        }
            .BarcodeToolbar1 {
                margin-left: 5px !important;
            }
            .documentSplitter{margin-top:0px !important;padding-top: 0px}
        }
        .MarginLeft{
            margin-left: 65px;
        }
        .ToolBarTreePane .txtSearch {
        margin: 8px;
        width: 395px;
       padding-left: 22px !important;
    }
         .SearchIcon {
        background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png);
        background-position: -144px 0;
        width: 16px;
        height:16px;
        position: absolute;
        left: 12px;
        top: 12px;
    }
    </style>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="treeGroupsAndItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="treeGroupsAndItems"/>
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="treeGroupsAndItems"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="pnlRadioButtonSelection">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnRefreshGrid">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgItems" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>

        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <div>
            <table border="0" width="100%" cellpadding="0" cellspacing="0" style="table-layout: fixed; background-color: RGB(237,237,237); background-image: none;">
                <tr>
                    <td style="width: 220px">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarBarcode ShowOnMobile" PostBack="false" CommandName="OpenUploadDiv"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarHeader ShowOnMobile" PostBack="false" CommandName="OpenHeadDiv"></telerik:RadToolBarButton>
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
                                        <td class="HideOnMobilePopup" style="width: 50px; height: 30px;padding-left: 18px;">
                                            <img src="CSS/Images/ResponsiveIcons/Barcode.png" class="barBarcode" />
                                        </td>
                                        <td style="width: 120px;" class="HideOnMobilePopup">
                                            <asp:RadioButton ID="rbtnMobileOrBrowse" runat="server" meta:resourcekey="rbtnMobileOrBrowse" Text="Mobile/Browse1"
                                                GroupName="BarCodeGroup" AutoPostBack="true" CssClass="RadioCss" />
                                        </td>
                                        <td style="width: 100px" class="HideOnMobilePopup">
                                            <asp:RadioButton ID="rbtnScanOrType" runat="server" meta:resourcekey="rbtnScanOrType" Text="Scan/Type1"
                                                GroupName="BarCodeGroup" AutoPostBack="true" CssClass="RadioCss" />
                                        </td>
                                        <td style="width: 200px; padding-left: 24px;" class="tdBarCode">
                                            <asp:LinkButton ID="btnUploadBarcode" runat="server" CssClass="PopupFileUpload ShowOnMobile" OnClientClick="PMBrowseFiles();return false;">
                                                <span class="Icon"></span>
                                                <asp:label runat="server" text="BROWSE FOR FILE" CssClass="uploadLabel" />  
                                            </asp:LinkButton>
                                            <asp:FileUpload ID="flUploadBarcode" CssClass="RemoveOnMobile" runat="server" Width="100%" onchange="UploadFileNow()" />
                                            <asp:TextBox ID="txtBarCode" CssClass="PopupTextUpload" runat="server" Width="220" onkeypress="return keypress(event);" Height="24px"></asp:TextBox>
                                            <div class="UploadSearchIcon" id="searchIcon" runat="server" style="background-position: -216px; margin-left: 15px;" onclick="btnSearchClick()"></div>
                                            <asp:Button ID="btnBarcode" CssClass="Hide" runat="server" Text="Upload" />
                                            <%--<telerik:RadAsyncUpload runat="server" ID="FileToUpload" Skin="Default"
                                OnClientFileUploadFailed="onUploadFailed"
                                OnClientFileSelected="onFileSelected" OnClientFileUploaded="onFileUploaded"
                                MultipleFileSelection="Automatic" OnClientValidationFailed="ClientValidationFailed"
                                OnFileUploaded="FileToUpload_FileUploaded" Width="235px" Style="margin-bottom: -8px;">
                            </telerik:RadAsyncUpload>--%>
                                            <asp:Label ID="lblmessage" runat="server" CssClass="Validator" Style="display: block;"></asp:Label>

                                        </td>
                                        <td class="HideOnMobilePopup">
                                            <asp:LinkButton ID="lblSettings" runat="server" meta:resourcekey="lblSettings" Style="white-space: nowrap; font-size:12px !important; color:#666666 !important;" CssClass="MarginLeft"
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

            <div class="PMPopupMainPage">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="documentSplitter" Style="height: 50px;"
                            SplitBarsSize="">
                            <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="420px" CssClass="NormalWhiteBack SplitterPanePopup" Style="position: fixed; background: white; top: 0; height: 100%;"
                                EnableEmbeddedBaseStylesheet="False" Index="0" Skin="" OnClientExpanded="ClientResized">
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
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%;" class="treePaddingOnMobile">
                                        <tr class="ToolBarTreePane">
                                            <td colspan="2" style="position:relative;">
                                                <span class="SearchIcon"></span>
                                                <asp:TextBox ID="txtItemsSearch" CssClass="txtSearch" runat="server" AutoPostBack="true"/>
                                            </td>
                                        </tr>
                                      <tr class="ToolBarTreePane">
                                            <td valign="middle" class="labelWidth" style="background: transparent !important; padding-left: 8px;box-sizing:border-box;">
                                                <asp:Label ID="lblGroupBy" runat="server" Text="Group By" meta:ResourceKey="lblGroupBy"></asp:Label>
                                            </td>
                                            <td class="controlWidth" style="background: #EDEDED !important;">
                                                <telerik:RadComboBox ID="ddlGroupBy" runat="server" AutoPostBack="true" Style="width: 240px !important; margin-bottom:8px;">
                                                    <Items>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemNone" Value="None" Text="None"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemsCategory" Value="Category" Text="Category"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemItemsGroup" Value="ItemsGroup" Text="ItemsGroup"></telerik:RadComboBoxItem>
                                                        <telerik:RadComboBoxItem meta:Resourcekey="ListItemsType" Value="Type" Text="Type"></telerik:RadComboBoxItem>
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="100%"></td>
                                        </tr>
                                </table>
                                <div style="padding-top:5px">
                                <telerik:RadTreeView ID="treeGroupsAndItems" runat="server" EnableDragAndDrop="True" CheckBoxes="true" TriStateCheckBoxes="true"
                                    OnNodeDrop="treeGroupsAndItems_NodeDrop" OnClientNodeDropping="onNodeDropping" Style="margin-left:0px;"
                                    OnNodeExpand="treeGroupsAndItems_NodeExpand" OnClientNodeDragging="onNodeDragging" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                    Skin="Default" MultipleSelect="True" CssClass="CheckBoxesTreeview ">
                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                    <CollapseAnimation Duration="100" Type="OutQuint" />
                                    <%--       <NodeTemplate>
                                       <span class="rtSp" ></span>
                                        <span runat="server" id="lbltest"  class="rtIn">
                             <asp:Literal ID="lblNode" Mode="Encode" runat="server" Text='<%# DataBinder.Eval(Container,"Text")%>'/>
                                             DataBinder.Eval(Container,"Text")
                                        </span>
                    </NodeTemplate>--%>
                                </telerik:RadTreeView>
                                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                <div class="btnTreeDropItems">
                                                   &nbsp; 
                                                </div>
                                </asp:LinkButton>
                                    </div>
                            </telerik:RadPane>
                            <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="TreeToolbarSplitbar" CollapseMode="Forward" />
                            <telerik:RadPane ID="RadContentPane" runat="server" Index="2" Skin="Default" CssClass="fullWidthPane" OnClientResized="ClientResized">
                                <div id="headpopup" class="popupDiv">
                                    <telerik:RadToolBar ID="RadToolBar1" Height="50px" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick">
                                        <Items>
                                            <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel ShowOnMobile" PostBack="false" CommandName="closeHead"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                                    <div class="PMMainPage PMPopupMainPage">
                                        <div class="row">
                                            <div class="col-4 col-4-left">
                                                <table class="colTable">
                                                    <tr id="trProject" runat="server">
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                                                CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Skin="Default"
                                                                meta:Resourcekey="ddlProjects" NoWrap="true" Width="100%"
                                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" Height="150px"
                                                                OnItemsRequested="ddl_ItemsRequested">
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="rfvProjects" meta:Resourcekey="rfvProjects" runat="server"
                                                                CssClass="Validator" InitialValue="" ErrorMessage="Project Required." ControlToValidate="ddlProjects"
                                                                Display="Dynamic" Enabled="true" ForeColor="" ValidationGroup="Save">
                                                            </asp:RequiredFieldValidator>
                                                            <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                                CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                                            </asp:CustomValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlProjectPhases" runat="server" Width="100%" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlLocations" runat="server" Width="100%" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblCostCode" runat="server" meta:resourcekey="lblCostCode"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlCostCodes" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                runat="server" Width="100%" Filter="Contains" MarkFirstMatch="True" Skin="Default" AllowCustomText="true"
                                                                NoWrap="True" Height="200px">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-4 col-4-right">
                                                <table class="colTable">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                                                                Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..." NoWrap="True"
                                                                AllowCustomText="true" meta:Resourcekey="ddlCompanies" EnableLoadOnDemand="True"
                                                                ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblType" runat="server" meta:resourcekey="lblType"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlCostType" runat="server" Width="100%" AllowCustomText="true"  Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblPeriod" runat="server" Text="Period" meta:resourcekey="lblPeriod"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlPeriods" runat="server" Height="150px" Skin="Default" Width="100%"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlPeriods" EmptyMessage="Select Period..." NoWrap="False"
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" AllowCustomText="true"
                                                                OnItemsRequested="ddl_ItemsRequested" Filter="Contains">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                                    <div class="row">
                                        <div class="col-12">
                                            <telerik:RadGrid ID="rdgItems" runat="server" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="15" Width="100%"
                                                ShowFooter="true" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" SetWidth="true" AppendMenus="true"
                                                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" UseEditFormInMobile="true">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" Width="100%" CommandItemDisplay="Top" TableLayout="Fixed" EditMode="InPlace">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="#" UniqueName="Id">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddingTimes" runat="server" Width="100%" Text='<%# Eval("AddingTimes") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtAddingTimes" runat="server" CssClass="PositiveInteger" MaxLength="2"
                                                                    Text='<%# Eval("AddingTimes") %>' Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="50px" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Item" UniqueName="ItemId">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblItemCode" runat="server" CssClass="Right" Enabled="False" Text='<%# CDbl(Eval("ItemId")).ToString%>'
                                                                    Width="100%"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtItemCode" runat="server" CssClass="Right" Enabled="False" Text='<%# CDbl(Eval("ItemId")).ToString%>'
                                                                    Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                                            <ItemTemplate>
                                                                <asp:Literal ID="lblDescription" Mode="Encode" runat="server" Text='<%# Eval("Description") %>'></asp:Literal>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                                                                    Width="100%" MaxLength="500"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="Phase">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhase" runat="server" Width="100%" Text='<%# Eval("Phase") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlPhases" runat="server" Width="150px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCostCode" runat="server" Width="100%" Text='<%# Eval("CostCode") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlCostCodes" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                    runat="server" Filter="Contains" Height="150px" MarkFirstMatch="True" NoWrap="True" AllowCustomText="true"
                                                                    Skin="Default" Style="font-size: 11px" Width="100%" DropDownWidth="300px">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Type" UniqueName="CostType">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCostTypes" runat="server" Width="100%" Text='<%# Eval("CostType") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlCostTypes" runat="server" Width="90px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblQuantity" runat="server" Width="100%" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="Double" MaxLength="15" Text='<%# FormatNumber(Eval("Quantity")) %>'
                                                                    Width="100%" Ondblclick="OpenRedliningMeasuresLogPopup(this.id,this.id.replace('txtQuantity','ddlUOM'),'ASP',0)"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                                                            GroupByExpression="Currency [GridColumn_Currency] Group By Currency" DataField="Currency" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCurrency" runat="server" Width="100%"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" DropDownWidth="150px"
                                                                    Skin="Default" Height="250px">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px"></HeaderStyle>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUnitCost" runat="server" Text='<%# FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Eval("CurrencyId")) %>'
                                                                    Width="100%"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtUnitCost" runat="server" CssClass="Currency" MaxLength="15" Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId"))) %>'
                                                                    Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTotalCost" runat="server" Text='<%# FormatCurrency(Eval("TotalCost"), CurrencyId:=Eval("CurrencyId")) %>'
                                                                    Width="100%"></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtTotalCost" runat="server" CssClass="Currency" MaxLength="15" Text='<%# FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId"))) %>'
                                                                    Width="100%"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUOM" runat="server" Width="100%" Text='<%# Eval("UOM") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlUOM" runat="server" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true" Width="150px">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCompanies" runat="server" Width="100%" Text='<%# IIf((Container.DataItem("CompanyId") = -1 Or Container.DataItem("CompanyId") = 0), String.Format("&nbsp;"), Container.DataItem("Company"))%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="200px" DropDownWidth="300px"
                                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..." NoWrap="True"
                                                                    AllowCustomText="true" meta:Resourcekey="ddlCompanies" EnableLoadOnDemand="True"
                                                                    ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                                    Style="font-size: 11px" Height="250px">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLocations" runat="server" Width="100%" Text='<%# Eval("Location") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox ID="ddlLocations" runat="server" Width="150px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="200px" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Notes1" UniqueName="Notes1">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNotes1" runat="server" Width="100%" Text='<%# Eval("Notes1") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtNotes1" runat="server" MaxLength="4000" Text='<%# Eval("Notes1") %>'
                                                                    Width="78%" TextMode="MultiLine" Height="14px"></asp:TextBox>

                                                                <asp:LinkButton runat="server" ID="imgNotes1" CssClass="SearchButton"
                                                                    OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes1','txtNotes1'))">
                                                    <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                            Visible="<%# rdgItems.EditIndexes.Count = 0 %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                            Visible="<%# rdgItems.EditIndexes.Count > 0 %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                            OnClientClick="return ConfirmDelete()" Visible="<%# rdgItems.EditIndexes.Count = 0 And (Not rdgItems.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                            Visible="<%# rdgItems.EditIndexes.Count > 0 %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                                            CommandName="RebindGrid" Visible="<%# rdgItems.EditIndexes.Count = 0 And (Not rdgItems.MasterTableView.IsItemInserted) %>">
                                                            <span class="Icon"></span>
                                                            <asp:Label runat="server" ID="lblRefresh"></asp:Label>
                                                            &nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="true" />
                                                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                                    <Resizing AllowColumnResize="True" />
                                                </ClientSettings>
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                            </telerik:RadGrid>
                                        </div>
                                    </div>
                                </div>

                            </telerik:RadPane>
                        </telerik:RadSplitter>
                    </div>
                </div>


                <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
                <%-- <table width="100%" class="NormalWhiteBack">
                <tr>
                    <td colspan="2" align="right">
                        <asp:LinkButton ID="lbtSave" runat="server" meta:resourcekey="lbtSave" ValidationGroup="Save"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtSaveAndClose"  runat="server"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Close %>"></asp:LinkButton>&nbsp;&nbsp;
                    </td>
                </tr>
            </table>--%>
                <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
                    ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
                    IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
                    Top="">
                </telerik:RadWindowManager>
            </div>
        </div>

    </form>
</body>
</html>
