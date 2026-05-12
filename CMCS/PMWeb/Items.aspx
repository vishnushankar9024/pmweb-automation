<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Items.aspx.vb" Inherits="Website.Items" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="AssetRotator.ascx" TagName="ItemRotator" TagPrefix="uc4" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc5" %>
<%@ Register Src="ItemPurchaseHistory.ascx" TagName="ItemPurchaseHistory" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc7" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .PurchaseHistoryDisabled {
            width: 100% !important;
            font-family: 'Work Sans' !important;
            height: 24px !important;
            line-height: 24px !important;
            color: #666666 !important;
            background: #EDEDED !important;
            border-color: #666;
            background-color: #ededed;
            border-radius: 0px;
            box-sizing: border-box;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript" src="JS/Estimates/Items.js"></script>

        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value().indexOf("Generate_") == 0) {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findButtonByCommandName(args.get_item().get_value());
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                var left = (screen.width - 910) / 2;
                var top = (screen.height - 380) / 2;
                var HasPMWebReports = '<%=PM.QueryBuilderPermissionController.HasReports("ITEM")%>';
                var Id = '<%= PM.ItemInfo.id %>';
                var HasReports = '<%= PM.ItemInfo.HasReports%>';
                 var RecordDescription = '<%=JSEscape(PM.ItemInfo.RecordDescription)%>';

                switch (Value) {
                     case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ITEM&Id=" +
                            '<%= PM.ItemInfo.id %>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=0&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ITEM&Id=" +
                            '<%= PM.Estimate.EstimateInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%= PM.ItemInfo.TemplateId %>' +"&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=ITEM&Id=" + Id
                            + "&EntityId=" + '<%= PM.ItemInfo.TemplateId %>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);

                        }
                        break;
                    default:
                        break;
                }
            }

            function LOD_DropDownTextChange(sender, args) {
                if (sender.get_value() == '') {
                    args.set_cancel(true);
                }
            }

        </script>

    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpItems">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpItems" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpItems" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchTree" PostBackUrl="ItemsSearch.aspx">
                                <div class="btnToolbarSearchTree">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" CssClass="item-toolbar">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/Global/AddLine.png"
                            CommandName="New">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                     </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="ExporttoExcel" ImageUrl="Images/toolbar/Excel.png" Visible="False"
                            Enabled="false" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Export to Excel" Value="ExporttoExcel" CssClass="Export" Visible="false" Enabled="false">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ITEM');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Estimating.htm#Items">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" CssClass="documentTabs"
        runat="server" MultiPageID="mlpItems" Skin="Default" OnTabClick="tbsDocument_TabClick" Enabled="true"
        Width="100%" EnableViewState="true" CausesValidation="False" ScrollChildren="true" ScrollButtonsPosition="Left">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Checklist" Value="Checklists" />
            <telerik:RadTab Text="Purchase History33" Value="ItemPurchaseHistory" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpItems" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True" BorderWidth="0px" meta:resourcekey="mlpItems">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <div class="PMMainPage ">
                <div class="row JustifyContent R3Cols">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label runat="server" ID="lblItemId" meta:resourcekey="lblItemId" Text="Item ID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" MaxLength="200" ID="txtItemId" Style="text-align: right;"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" MaxLength="200" ID="txtDescription"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescription" ValidationGroup="Save"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvRequired"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblItemGroup" runat="server" meta:resourcekey="lblItemGroup" Text="Item Group"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlItemGroup" runat="server" Width="100%"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" DropDownCssClass="ddlTreeviewTemplate" Skin="Default" OnClientDropDownOpened="OnClientDropDownOpenedHandler"
                                        meta:resourcekey="ddlItemGroup">

                                        <Items>
                                            <telerik:RadComboBoxItem Value="0" Text="" runat="server" />
                                        </Items>
                                        <ItemTemplate>
                                            <telerik:RadTreeView ID="treeItemGroups" Skin="Default" runat="server" Width="300px"
                                                Height="250px">
                                            </telerik:RadTreeView>
                                        </ItemTemplate>
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvItems" meta:Resourcekey="rfvRequired" runat="server" ControlToValidate="ddlItemGroup"
                                        CssClass="Validator"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblRequired" runat="server" Text="Required" meta:resourcekey="lblRequired" ForeColor="Red" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="LblType" runat="server" meta:resourcekey="LblType" Text="Type"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategory" Text="Category"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCategory" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblManufacturer" runat="server" meta:resourcekey="lblManufacturer" Text="Manufacturer"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlManufacturers" runat="server" Width="100%"
                                        Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlManufacturers"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                        OnItemsRequested="ddl_ItemsRequested"
                                        Height="400px">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblMfrNumber" runat="server" meta:resourcekey="lblManufacturersNumber" Text="Mfr.#"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtMfrNumber" MaxLength="50" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBIMID" runat="server" meta:resourcekey="lblBIMID" Text="BIM ID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBIMID" MaxLength="50" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblInventory" CssClass="legend" runat="server" meta:resourcekey="lblInventory" Text="Inventory"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReorderPoint" runat="server" meta:resourcekey="lblReorderPoint" Text="Reorder Point"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReorderPoint" MaxLength="15" runat="server" Style="text-align: right;" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInventoryUOM" runat="server" meta:resourcekey="lblInventoryUOM" Text="Inventory UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlInventoryUOM" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains" 
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblTags" CssClass="legend" meta:Resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblPMWebBarcode" runat="server" meta:resourcekey="lblPMWebBarcode" Text="PMWeb Barcode"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <%--<img id="imgPMbarcode" src="Images/Asset/Barcode.jpg" style="vertical-align: middle; cursor: pointer" alt=""
                                onclick="return OpenBarCodePopup('txtPMWebBarcode','htnPMWebBarcodeFormat','ITEM','<%= PM.ItemInfo.Id %>')" />--%>
                                            <asp:LinkButton runat="server" ID="imgPMbarcode" CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPMWebBarcode" runat="Server" Style="vertical-align: middle;" MaxLength="255" Text="Mfr's Barcode"></asp:TextBox>
                                        <asp:HiddenField ID="htnPMWebBarcodeFormat" runat="server" />
                                        <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblMfrBarcode" runat="server" meta:resourcekey="lblMfrBarcode" Text="Mfr's Barcode"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <%--<img id="imgMfBarcode1" src="Images/Asset/Barcode.jpg" style="vertical-align: middle; cursor: pointer" alt=""
                                onclick="return OpenBarCodePopup('txtMfrBarcode','htnMfrBarcodeFormat','ITEM','<%= PM.ItemInfo.Id %>');" />--%>
                                            <asp:LinkButton runat="server" ID="imgMfBarcode" CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>

                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtMfrBarcode" runat="Server" Style="vertical-align: middle;" MaxLength="255"></asp:TextBox>
                                            <asp:HiddenField ID="htnMfrBarcodeFormat" runat="server" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="width: 100%">
                            <legend>
                                <asp:Label ID="lblEstimating" runat="server" CssClass="legend" meta:resourcekey="lblEstimating" Text="Estimating"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEstimatingUOM" runat="server" meta:resourcekey="lblEstimatingUOM" Text="UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlEstimatingUOM" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains" 
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblEstimatingCurrency" meta:Resourcekey="lblEstimatingCurrency" Text="Currency1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlEstimatingCurrencies" runat="server" Skin="Default">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCost" runat="server" meta:resourcekey="lblCost" Text="Cost"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCost" MaxLength="15" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidthChkBox" colspan="2">
                                        <asp:Label ID="lblUseUnitPriceWhenEstimating" runat="server" meta:resourcekey="chkUseUnitPriceWhenEstimating" Text="Use Unit Price When Estimating"></asp:Label>
                                        <asp:CheckBox ID="chkUseUnitPriceWhenEstimating" runat="server" Text="" Style="float: right;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidthChkBox" colspan="2">
                                        <asp:Label ID="lblSubmittalItem" runat="server" meta:resourcekey="chkSubmittalItem" Text="Submittal Item"></asp:Label>
                                        <asp:CheckBox ID="chkSubmittalItem" runat="server" Text="" Style="float: right;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidthChkBox" colspan="2">
                                        <asp:Label ID="lblProcurementItem" runat="server" meta:resourcekey="chkProcurementItem" Text="Procurement Item"></asp:Label>
                                        <asp:CheckBox ID="chkProcurementItem" runat="server" Text="" Style="float: right;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCostUpdated" runat="server" meta:resourcekey="lblCostUpdated" Text="Cost Updated"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCostUpdated" CssClass="Right" runat="Server"></asp:TextBox>
                                    </td>
                                </tr>

                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-middle">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblPurchaseHistory" CssClass="legend" meta:resourcekey="lblPurchaseHistory" Text="Purchase History"></asp:Label>
                            </legend>
                            <table class="colTable">

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblLowest" meta:resourcekey="lblLowest" Text="Lowest"></asp:Label>
                                    </td>

                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtPurcharseHistoryLowest" ReadOnly="true" CssClass="Right" Enabled="false"></asp:TextBox>
                                        <asp:Label ID="lblPurcharseHistoryLowestDate" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblHighest" meta:resourcekey="lblHighest" Text="Highest"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtPurcharseHistoryHighest" CssClass="Right" ReadOnly="true" Enabled="false"></asp:TextBox>
                                        <asp:Label ID="lblPurcharseHistoryHighestDate" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblMedian" meta:resourcekey="lblMedian" Text="Median"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtPurcharseHistoryMedian" CssClass="Right" ReadOnly="true" Enabled="false"></asp:TextBox>
                                        <asp:Label ID="lblPurcharseHistoryMedianDate" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblAverage" meta:resourcekey="lblAverage" Text="Average"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtPurcharseHistoryAverage" CssClass="Right" ReadOnly="true" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblDefaults" runat="server" CssClass="legend" meta:resourcekey="lblDefaults" Text="Defaults"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTemplate" runat="server" meta:Resourcekey="lblTemplate" Text="Template"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" Height="390px"
                                            meta:Resourcekey="ddlProjects" Skin="Default" AllowCustomText="true"
                                            AutoPostBack="True" NoWrap="true"
                                            CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase" Text="Phase"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhases" AllowCustomText="true" Filter="Contains" MarkFirstMatch="false" runat="server" Skin="Default"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation" Text="Location"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocations" AllowCustomText="true" Filter="Contains" MarkFirstMatch="false" runat="server" Skin="Default"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink ID="hplCostCode" runat="server" meta:Resourcekey="lblCostCode"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostCodes" runat="server"
                                            Skin="Default" AllowCustomText="true" AutoPostBack="False" NoWrap="true"
                                            CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" meta:Resourcekey="ddlDefaultCostCodes">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCostType" runat="server" meta:resourcekey="lblCostType" Text="Cost Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostTypes" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true"
                                            NoWrap="True" AllowCustomText="true" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" meta:Resourcekey="ddlDefaultCompanies">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidCategory" meta:Resourcekey="lblBidCategory" runat="server" Text="Bid Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBidCategories" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblPurchasing" CssClass="legend" runat="server" meta:resourcekey="lblPurchasing" Text="Purchasing"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPurchasingUOM" runat="server" meta:resourcekey="lblPurchasingUOM" Text="UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPurchasingUOM" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains" 
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblPurshasingCurrency" meta:Resourcekey="lblPurshasingCurrency" Text="Currency1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPurshasingCurrencies" runat="server" Skin="Default">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPrice" runat="server" meta:resourcekey="lblPrice" Text="Price"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPrice" MaxLength="15" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblConversion" runat="server" meta:resourcekey="lblConversion" Text="Conversion"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtConversion" MaxLength="15" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblUnitPrice" runat="server" meta:resourcekey="lblUnitPrice" Text="Unit Price"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtUnitPrice" MaxLength="15" runat="server" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPriceUpdated" runat="server" meta:resourcekey="lblPriceUpdated" Text="Price Updated"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPriceUpdated" CssClass="Right" runat="Server"></asp:TextBox>
                                    </td>
                                </tr>

                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">
                        <uc4:ItemRotator ID="PMrot" runat="server" />
                        <uc7:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblComponent" CssClass="legend" runat="server" meta:resourcekey="lblComponent" Text="Component"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlComponentType" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblQuantityUOM" runat="server" meta:resourcekey="lblQuantityUOM" Text="Quantity UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlQuantityUOM" runat="server" Skin="Default" AllowCustomText="true" Filter="Contains" 
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblServiceIntervalUsage" runat="server" meta:resourcekey="lblServiceIntervalUsage" Text="Service Interval Usage"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtServiceIntervalUsage" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblServiceByDays" runat="server" meta:resourcekey="lblServiceByDays" Text="Service By Days"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="float: right;">
                                        <asp:CheckBox ID="chkServiceByDays" runat="server" Style="float: right;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblServiceIntervalDays" runat="server" meta:resourcekey="lblServiceIntervalDays" Text="Service Interval Days"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtServiceIntervalDays" runat="server" MaxLength="15" CssClass="Days"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLateralOffset" runat="server" meta:resourcekey="lblLateralOffset" Text="Lateral Offset"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLateralOffset" runat="server" MaxLength="15" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLateralOffsetUOM" runat="server" meta:resourcekey="lblLateralOffsetUOM" Text="Lateral Offset UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLateralOffsetUOM" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains" 
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVerticalOffset" runat="server" meta:resourcekey="lblVerticalOffset" Text="Vertical Offset"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtVerticalOffset" runat="server" MaxLength="15" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVerticalOffsetUOM" runat="server" meta:resourcekey="lblVerticalOffsetUOM" Text="Vertical Offset UOM"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlVerticalOffsetUOM" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains" 
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRadialOffset" runat="server" meta:resourcekey="lblRadialOffset" Text="Radial Offset"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRadialOffset" runat="server" MaxLength="15" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
        <%-- <telerik:RadPageView ID="pvDetails" runat="server" meta:resourcekey="pvDetails" cssclass="Hide">
                                    <uc1:ItemDetails ID="ItemsDetails" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc5:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc8:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvPurchaseHistory" runat="server">
            <uc6:ItemPurchaseHistory ID="ItemPurchaseHistory2" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <%--<telerik:radwindowmanager ID="PMWindowManager" ShowContentDuringLoad="false" VisibleStatusbar="false"
        ReloadOnShow="true" runat="server" >
        <Windows>
             <telerik:RadWindow ID="wndImport" ShowContentDuringLoad="false" Modal="true" Skin="Default" runat="server" 
                Title="Import">           
             </telerik:RadWindow>
        </Windows>
    </telerik:radwindowmanager>  --%>
    <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
</asp:Content>
