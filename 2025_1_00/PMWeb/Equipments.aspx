<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/AssetMaster.Master" CodeBehind="Equipments.aspx.vb" Inherits="Website.Equipments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EquipmentDetails.ascx" TagName="EquipmentDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc2" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="AssetTypeWorkOrder.ascx" TagName="AssetTypeWorkOrder" TagPrefix="uc9" %>
<%@ Register Src="EquipmentMaintenance.ascx" TagName="EquipmentMaintenance" TagPrefix="uc10" %>
<%@ Register Src="EquipmentMoves.ascx" TagName="EquipmentMoves" TagPrefix="uc5" %>
<%@ Register Src="AssetRotator.ascx" TagName="ItemRotator" TagPrefix="uc7" %>
<%@ Register Src="EquipmentCostWorkSheet.ascx" TagName="EquipmentCostWorkSheet" TagPrefix="uc6" %>
<%@ Register Src="EquipmentLogs.ascx" TagName="EquipmentLogs" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>
<%@ Register Src="AssetComponents.ascx" TagName="AssetComponents" TagPrefix="uc8" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc13" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ACPH1" runat="server">
  
    <script src="JS/Asset/Equipmentlogs.js" type="text/javascript"></script>
    <script src="JS/Asset/Components.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var CurrentRecordProjectId = 0;
            $(window).on('load', function () {
                if ($("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage").length > 0) {
                    $("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage").animate({ width: '<%=PM.Asset.EquipmentInfo.PercentRemaining%>' + "%" }, 400);
                }
            });

            var MobileScreenWidth = 1024;
            function isMobileScreen() {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= MobileScreenWidth)
                    return true;
                return false;
            }
            function OpenGoogleEquipmentAddressesPicker() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var Id = '<%= PM.Asset.EquipmentInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=Equipment&ObjectId=" + Id + "&PickerSender=RecordAddress");
                }
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value().indexOf("Generate_") == 0) {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findButtonByCommandName(args.get_item().get_value());
                        button.click();
                    }
                    if (args.get_item().get_value() == "Active") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Activate");
                        button.click();
                    }
                    if (args.get_item().get_value() == "InActive") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Activate");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value(), args)
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var Id = '<%= PM.Asset.EquipmentInfo.Id%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.EquipmentInfo.Description)%>';
                var HasReports = '<%= PM.Asset.EquipmentInfo.HasReports%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;

                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=Equipment&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=" + '<%=PM.Asset.EquipmentInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                        case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;

                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=Equipment&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=" + '<%=PM.Asset.EquipmentInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;


                    default:
                        break;
                }
            }

            function OpenComponentItemPopup() {
                return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Components&IsComponent=1', 910, 580, true);
            }

            function OnClientDropDownOpenedHandler(sender, eventArgs) {
                var tree = sender.get_items().getItem(0).findControl("trvLocations");
                var selectedNode = tree.get_selectedNode();
                if (selectedNode) {
                    selectedNode.scrollIntoView();
                }
            }

            function AssetWorkOrderRowClick(sender, eventArgs) {
                window.location = "WorkOrders.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }


            function rdvAssetNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlLocation]")[0].id);
                var node = args.get_node();

                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);

                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }

            function OpenEquipmentMovePOPUp(URL, Width, Height, AddClose) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(460, browserHeight * 0.9);
                    wnd.Center();
                }
                if (AddClose == true) {
                    wnd.add_close(WindowMoveClosed);
                }
                return false;
            }

            function WindowMoveClosed(Opener) {
                var btnRefreshId = $("a[id$=btnRefresh]")[0];
                if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }


            }
            function CostWorkSheetChanged() {
                __doPostBack("ctl00_ctl00_CPH1_ACPH1_EquipmentCostWorkSheet1_rdpCostWorkSheet");

            }
            function HoursRateValueChanged(sender, args) {

                var totalcost = $("[id$=txtTotalpercost]");
                var result = $("[id$=txtCostToOwn]");
                var Ownership = $("[id$=txtTotalOwnership]");
                var Operate = $("[id$=txtOperate]");
                if (sender.get_value() == "") {
                    sender.set_value(args._oldValue);
                }
                else {
                    result.val(CCur(CDbl(totalcost.val()) / CDbl(sender.get_value())));
                    Ownership.val(CCur(CDbl(result.val()) + CDbl(Operate.val())));
                }

            }

            function OperateHourRatechanged(sender, args) {
                var totalcost = $("[id$=txtOperateCostPeriod]");
                var result = $("[id$=txtOperate]");
                var CostToOwn = $("[id$=txtCostToOwn]");
                var Ownership = $("[id$=txtTotalOwnership]");
                if (sender.get_value() == "") {
                    sender.set_value(args._oldValue);
                }
                else {
                    result.val(CCur(CDbl(totalcost.val()) / CDbl(sender.get_value())));
                    Ownership.val(CCur(CDbl(result.val()) + CDbl(CostToOwn.val())));
                }
            }

            function ContexMenu(toolbar, args) {
                args._domEvent.preventDefault();
                return false;

            }

            function pageLoad() {
                AutoCalculate();
            }

            function AutoCalculate() {
                $('input[id$=txtServiceInterval]').change(function (sender) {
                    CalculatePredictiveMaintenanceFields();
                });
                $('input[id$=txtLastService]').change(function (sender) {
                    CalculatePredictiveMaintenanceFields();
                });
                $("input[id$=chkTrackUseByDays]").click(function () {

                    calculateByDaysResult();
                });
            }

            function OpenEquipmentBarCodePopup() {
                return OpenBarCodePopup('txtBarcode', 'htnBarcodeFormat', 'EQUIPMENT', '<%= PM.Asset.EquipmentInfo.Id %>');
            }

            function CalculatePredictiveMaintenanceFields() {
                var ServiceInterval = CDbl($("input[id$=txtServiceInterval]").val());
                var LastService = CDbl($("input[id$=txtLastService]").val());
                var CurrentUsage = CDbl($("input[id$=txtCurrentUsage]").val());
                var ServiceDue = ServiceInterval + LastService;
                var LifeRemaining = ServiceDue - CurrentUsage;
                $("input[id$=txtServiceDue]").val(FPrec(ServiceDue));
                $("input[id$=txtLifeRemaining]").val(FPrec(LifeRemaining));
                if (ServiceInterval == 0) {
                    $("input[id$=txtRemainigPercentage]").val(CPrct(100));
                }
                else {
                    if ((LifeRemaining / ServiceInterval) * 100 > 100) {
                        $("input[id$=txtRemainigPercentage]").val(CPrct(100));
                    }
                    else {
                        $("input[id$=txtRemainigPercentage]").val(CPrct((LifeRemaining / ServiceInterval) * 100));
                    }
                }
                if (CDbl($("input[id$=txtLifeRemaining]").val()) < 0) {
                    $("input[id$=txtRemainigPercentage]").val(CPrct(0));
                }
                if ($("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage").length > 0) {
                    $("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage").animate({ width: $("input[id$=txtRemainigPercentage]").val() }, 400);
                    $("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage")[0].title = 'Remaining: ' + $("input[id$=txtRemainigPercentage]").val();
                }
            }

            function InServiceDate(sender, args) {
                var hdnEquipmentTodayDate = $("[id$=hdnEquipmentTodayDate]")[0];
                var today = new Date(parseFloat(hdnEquipmentTodayDate.value));
                today = new Date(today.format("MM/dd/yyyy"));
                if ($("input[id$=chkTrackUseByDays]")[0].checked) {
                    if (sender.get_selectedDate() != null) {
                        var ServiceDate = new Date(sender.get_selectedDate().format("MM/dd/yyyy"));
                        var duration = today.getTime() - ServiceDate.getTime();
                        var CurrentUsage = FPrec(Math.ceil(duration / (1000 * 3600 * 24)));
                        $("input[id$=txtCurrentUsage]").val(CurrentUsage);
                    }
                    else {
                        $("input[id$=txtCurrentUsage]").val(FPrec(0));

                    }
                    CalculatePredictiveMaintenanceFields();
                }
            }

            function calculateByDaysResult() {
                var chk = $("input[id$=chkTrackUseByDays]");
                var strId = chk[0].id;
                var dtpInServiceDate = $find(strId.substring(strId.lastIndexOf('_'), strId.lenght - 1) + '_dtpInServiceDate');
                var hdnEquipmentTodayDate = $("[id$=hdnEquipmentTodayDate]")[0];
                var hdnLogUsage = $("[id$=hdnLogUsage]")[0];
                var today = new Date(parseFloat(hdnEquipmentTodayDate.value));
                today = new Date(today.format("MM/dd/yyyy"));
                if (chk[0].checked) {
                    if (dtpInServiceDate.get_selectedDate() != null) {
                        var ServiceDate = new Date(dtpInServiceDate.get_selectedDate().format("MM/dd/yyyy"));
                        var duration = today.getTime() - ServiceDate.getTime();
                        var CurrentUsage = FPrec(Math.ceil(duration / (1000 * 3600 * 24)));
                        $("input[id$=txtCurrentUsage]").val(CurrentUsage);
                    }
                    else {
                        $("input[id$=txtCurrentUsage]").val(FPrec(0));
                    }
                }
                else {
                    $("input[id$=txtCurrentUsage]").val(FPrec(CDbl(hdnLogUsage.value)));
                }

                CalculatePredictiveMaintenanceFields();
            }
        </script>

    </telerik:RadCodeBlock>
    <style type="text/css">
        #ctl00_ctl00_CPH1_ACPH1_EquipmentDetails_dtpWarrantyExpires_wrapper {
            width: 118px !important;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>  
              <telerik:AjaxSetting AjaxControlID="mlpEquipments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEquipments" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEquipments" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="trvLocations">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtGoogleAddress" />
                    <telerik:AjaxUpdatedControl ControlID="ddlLocations" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUpdateEquipmentLocation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnUpdateEquipmentLocation" />
                    <telerik:AjaxUpdatedControl ControlID="ddlLocations" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <asp:HiddenField runat="server" ID="hdnCurrentUsage"></asp:HiddenField>
    <asp:HiddenField runat="server" ID="hdnLogUsage"></asp:HiddenField>
    <asp:HiddenField runat="server" ID="hdnEquipmentTodayDate"></asp:HiddenField>
    <asp:Button runat="server" ID="btnUpdateEquipmentLocation" CssClass="Hide" />
    <asp:Button runat="server" ID="btnSwitchComponents" CssClass="Hide" />


            <table style="width:100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr valign="top">
                                <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                                    <telerik:RadToolBar ID="mainToolBar" OnClientContextMenu="ContexMenu" runat="server" AutoPostBack="true">
                                        <Items>
                                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" CausesValidation="true" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>


                                               <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                                     EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                                             </telerik:RadToolBarButton>

                                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>


                                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                            </telerik:RadToolBarButton>

                                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                                                SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                                                <Buttons>
                                                    <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                                    </telerik:RadToolBarButton>
                                                    <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                                </Buttons>
                                            </telerik:RadToolBarSplitButton>

                                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                                <ItemTemplate>
                                                    <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                        <Items>
                                                            <telerik:RadMenuItem CssClass="menuMore">
                                                                <Items>
                                                                    <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                                        <Items>
                                                                            <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                                            <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                        </Items>
                                                                    </telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate" EnableImageSprite="true" Value="Generate" CssClass="Generate" PostBack="true"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Active" EnableImageSprite="true" Value="Active" CssClass="ActiveLocation"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="InActive" EnableImageSprite="true" Value="InActive" CssClass="InactiveLocation"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('EQUIPMENT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Help" EnableImageSprite="true" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenu>
                                                </ItemTemplate>
                                            </telerik:RadToolBarButton>

                                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Generate.png" CommandName="Generate" Value="Generate" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate" SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                            </telerik:RadToolBarSplitButton>

                                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                                                Value="Activate" CommandName="Activation" ToolTip="Activate">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#Equipments"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                                </td>
                                <td style="width: 100%"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" CssClass="documentTabs"
                            runat="server" MultiPageID="mlpEquipments" ScrollChildren="true" ScrollButtonsPosition="Left"
                            OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="True">
                            <Tabs>
                                <telerik:RadTab Text="Header" Value="Header" Selected="true" />
                                <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
                                <telerik:RadTab Text="Moves" Value="Moves" />
                                <telerik:RadTab Text="Components" Value="Components" />
                                <telerik:RadTab Text="Maintenance" Value="Maintenance" Visible="false"></telerik:RadTab>
                                <telerik:RadTab Text="Log" Value="Log"></telerik:RadTab>
                                <telerik:RadTab Text="Work Orders" Value="WorkOrders" />
                                <telerik:RadTab Text="Cost Worksheet" Value="CostWorkSheet" />
                                <telerik:RadTab Text="Notes" Value="Notes" />
                                <telerik:RadTab Text="Attachments" Value="Attachments" />
                                <telerik:RadTab Text="Workflow" Value="Workflow" />
                            </Tabs>
                        </telerik:RadTabStrip>
                </td>
                </tr>
            </table>

    <div id="trMplDetails" runat="server">
        <telerik:RadMultiPage ID="mlpEquipments" runat="server" SelectedIndex="0"
            Width="100%" RenderSelectedPageOnly="true">
            <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">

                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                    <div class="PMMainPage">
                        <div class="row JustifyContent R3Cols">
                            <div class="col-4 col-4-left">
                                <table class="colTable" id="tblPredictiveMaintenance">

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEquipmentId" runat="server" meta:resourcekey="lblEquipmentId" Text="Equipment ID*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtEquipmentId" MaxLength="30" Text="10002ABC"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ControlToValidate="txtEquipmentId" CssClass="Validator" ValidationGroup="Save"
                                                meta:resourcekey="rfvRequired" Display="Dynamic" ForeColor="">
                                            </asp:RequiredFieldValidator>
                                            <asp:Label ID="lblCodeUnique" meta:resourcekey="lblCodeUnique" CssClass="Validator" runat="server" Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblName" Text="Name*" runat="server" meta:resourcekey="lblName" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtName" MaxLength="50"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ControlToValidate="txtName" CssClass="Validator" ValidationGroup="Save" meta:resourcekey="rfvRequired"
                                                ErrorMessage="&lt;br&gt;Enter the name" Display="Dynamic" ForeColor="">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCurrentLocation" Text="Current location*" runat="server" meta:resourcekey="lblCurrentLocation" />
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLocations" runat="server" DropDownCssClass="ddlTreeviewTemplate"
                                                OnClientDropDownOpened="OnClientDropDownOpenedHandler">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="" Value="0" />
                                                </Items>
                                                <ItemTemplate>
                                                    <telerik:RadTreeView ID="trvLocations" OnNodeClick="trvNodeClick" runat="server" Width="100%" Height="250px"></telerik:RadTreeView>
                                                </ItemTemplate>
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvLocation" meta:resourcekey="rfvRequired" runat="server"
                                                ControlToValidate="ddlLocations" CssClass="Validator" ValidationGroup="Save"
                                                ErrorMessage="<br/>Enter the Location" Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" valign="top">
                                            <div style="float: left">
                                                <asp:Label runat="server" ID="lblComponentOf" meta:Resourcekey="hliComponentOf" Text="Component Of"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:HyperLink runat="server" ID="hliComponentOf" CssClass="SearchButton">
                                                                                    <span class="Icon"></span>
                                                </asp:HyperLink>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtComponentOf" Enabled="false" ReadOnly="true" MaxLength="500"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEquipmentType" Text="Equipment Type" runat="server" meta:resourcekey="lblEquipmentType" />
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlEquipmentTypes" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" CloseDropDownOnBlur="true" Height="500px"
                                                AutoPostBack="false" NoWrap="true" AllowCustomText="True"
                                                CausesValidation="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOwnership" Text="Ownership" runat="server" meta:resourcekey="lblOwnership" />
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlOwnership" runat="server" Filter="Contains" AllowCustomText="True"
                                                CloseDropDownOnBlur="true"
                                                AutoPostBack="false" NoWrap="true"
                                                CausesValidation="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFunctionStatus" Text="Function Status" runat="server" meta:resourcekey="lblFunctionStatus" />
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlFunctionStatus" runat="server" Filter="Contains"
                                                CloseDropDownOnBlur="true" AllowCustomText="True"
                                                AutoPostBack="false" NoWrap="true"
                                                CausesValidation="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCondition" runat="server" meta:resourcekey="lblConditions"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCondition" runat="server" Filter="Contains"
                                                AllowCustomText="true" CloseDropDownOnBlur="true"
                                                AutoPostBack="false" NoWrap="true"
                                                CausesValidation="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblConditionDate" runat="server" Text="Condition Date" meta:resourcekey="lblConditionDate"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpConditionDate">
                                                <telerik:RadDatePicker ID="dtpConditionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    Culture="English (United States)"
                                                    EnableTyping="true">
                                                    <DateInput ID="DateInput2" runat="server"></DateInput>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblInServiceDate" Text="In Service Date" runat="server" meta:resourcekey="lblInServiceDate" />
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpInServiceDate" style="display: block">
                                                <telerik:RadDatePicker ID="dtpInServiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    EnableTyping="True">
                                                    <DateInput ID="DateInput5" runat="server"></DateInput>
                                                    <ClientEvents OnDateSelected="InServiceDate" />
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatus"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlStatus" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" CloseDropDownOnBlur="true"
                                                AutoPostBack="false" NoWrap="true"
                                                CausesValidation="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblReceivedDate" runat="server" meta:resourcekey="lblReceivedDate" Text="Received Date"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpReceivedDate" style="display: block">
                                                <telerik:RadDatePicker ID="dtpReceivedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    Style="margin-right: 2px;" EnableTyping="True">
                                                    <DateInput ID="DateInput1" runat="server"></DateInput>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label ID="lblVendor" runat="server" meta:resourcekey="lblVendor" Text="Vendor"></asp:Label>
                                            </div>

                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton"
                                                    OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlVendor'),'Companies')">
                                                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>

                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlVendor" runat="server" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1" Height="300px"
                                                OnClientDropDownClosed="dllcompClientClosed1" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:HiddenField ID="HiddenField2" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label ID="lblManufacturer" runat="server" meta:resourcekey="lblManufacturer" Text="Manufacturer"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                                                    OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlManufacturer'),'Companies')">
                                                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>

                                        </td>
                                        <td class="controlWidth">

                                            <telerik:RadComboBox ID="ddlManufacturer" runat="server" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" Height="300px"
                                                OnClientDropDownClosed="dllcompClientClosed"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblManufacturerNumber" runat="server" meta:resourcekey="lblManufacturerNumber" Text="Mfr. #"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtManufacturerNumber" MaxLength="15" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSerialNumber" runat="server" meta:resourcekey="lblSerialNumber" Text="Serial #"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtSerialNumber" MaxLength="15" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLotNumber" runat="server" meta:resourcekey="lblLotNumber" Text="Lot #"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtLotNumber" MaxLength="15" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblItem" runat="server" meta:resourcekey="lblItem" Text="Item"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlItem" runat="server"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="300px"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPrice" runat="server" meta:resourcekey="lblPrice" Text="Price"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPrice" MaxLength="15" runat="server" CssClass="Currency"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblWarrantyExpires" runat="server" meta:resourcekey="lblWarrantyExpires" Text="Warranty Expires"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpWarrantyExpires" style="display: block">
                                                <telerik:RadDatePicker ID="dtpWarrantyExpires" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    Style="margin-right: 2px;" EnableTyping="True">
                                                    <DateInput ID="DateInput7" runat="server"></DateInput>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlComponentType" runat="server" AllowCustomText="True"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="labelWidth" valign="top">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Geolocation">
                                                </asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton runat="server" ID="btnGoogleAddress" CssClass="SearchButton"
                                                    OnClientClick="return OpenGoogleEquipmentAddressesPicker();">
                                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" rowspan="2" valign="top">
                                            <div style="float: left">
                                                <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="imgPMbarcode" CssClass="SearchButton"
                                                    OnClientClick="return OpenEquipmentBarCodePopup();">
                                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                                <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                            </div>
                                        </td>
                                        <td class="controlWidth" rowspan="2">
                                            <asp:TextBox ID="txtBarcode" runat="Server" MaxLength="255"></asp:TextBox>
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                        </td>
                                    </tr>
                                </table>


                            </div>

                            <div class="col-4 col-4-middle">

                                <fieldset style="width: 100%">
                                    <legend>
                                        <asp:Label ID="lblPredictiveMaintenance" runat="server" meta:resourcekey="lblPredictiveMaintenance" Text="Predictive Maintenance"></asp:Label></legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblTrackUse" runat="server" meta:resourcekey="lblTrackUseBy" Text="Track Use By"></asp:Label>
                                            </td>
                                            <td class="controlWidth chkBox">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%;">
                                                            <telerik:RadComboBox ID="ddlTrackUse" runat="server" Filter="Contains"
                                                                MarkFirstMatch="true" CloseDropDownOnBlur="true" Height="500px"
                                                                AutoPostBack="false" NoWrap="true" Width="100%" AllowCustomText="True"
                                                                CausesValidation="False">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td style="padding-left: 10px; color: #666666;">
                                                            <asp:Label ID="lblTrackUseByDays" runat="server" meta:resourcekey="lblTrackUseByDays" Width="100%" Text="Or By Days11"></asp:Label>
                                                        </td>
                                                        <td style="width: 20px">
                                                            <asp:CheckBox ID="chkTrackUseByDays" runat="server" />
                                                            <label for="ctl00_ctl00_CPH1_ACPH1_chkTrackUseByDays">
                                                                <i class="icon"></i>
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblServiceInterval" runat="server" meta:resourcekey="lblServiceInterval" Text="Service Interval"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtServiceInterval" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblLastService" runat="server" meta:resourcekey="lblLastService" Text="Last Service"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLastService" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblServiceDue" runat="server" meta:resourcekey="lblServiceDue" Text="Service Due"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtServiceDue" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblCurrentUsage" runat="server" meta:resourcekey="lblCurrentUsage" Text="Current Usage"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtCurrentUsage" MaxLength="15" runat="server" CssClass="PositiveDouble"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblLifeRemaining" runat="server" meta:resourcekey="lblLifeRemaining" Text="Life Remaining"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtLifeRemaining" MaxLength="15" runat="server" CssClass="Double"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblRemainigPercentage" runat="server" meta:resourcekey="lblRemainigPercentage" Text="% Remaining"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtRemainigPercentage" MaxLength="15" runat="server" CssClass="Percent"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="width: 100%;">
                                                <asp:Panel ID="pnlRemaining" Style="width: 100%;" runat="server">
                                                    <asp:Image ID="ImgRemainingPercentage" ImageUrl="~/Images/Global/ProgressBar.png" runat="server"></asp:Image>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>

                                <fieldset style="width: 100%;">
                                    <legend>
                                        <asp:Label runat="server" ID="lblLinearDefinition" meta:resourcekey="lblLinearDefinition" Text="Linear Definition"></asp:Label></legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="lbtLinearAssets" runat="server" CssClass="SearchButton"><span class="Icon"> </span></asp:LinkButton>
                                            </td>
                                            <td style="text-align: center; color: #666666; text-transform: uppercase" class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td width="45%"></td>
                                                        <td style="padding-left: 10px; width: 45%; padding-right: 4px;">

                                                            <asp:Label runat="server" ID="lblDirection" meta:resourcekey="lblDirection" Text="Direction"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblBegin" meta:resourcekey="lblBegin" Text="Begin"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px">
                                                            <asp:TextBox ID="txtBegin" runat="server" Width="100%"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlBeginDirections" runat="server" Filter="Contains"
                                                                AllowCustomText="true" CloseDropDownOnBlur="true"
                                                                AutoPostBack="false" NoWrap="true" Width="100%"
                                                                CausesValidation="False">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblEnd" meta:resourcekey="lblEnd" Text="End"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px">
                                                            <asp:TextBox ID="txtEnd" runat="server" Width="100%"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlEndDirections" runat="server" Filter="Contains"
                                                                AllowCustomText="true" CloseDropDownOnBlur="true"
                                                                AutoPostBack="false" NoWrap="true" Width="100%"
                                                                CausesValidation="False">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblLength" meta:resourcekey="lblLength" Text="Length"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px">
                                                            <asp:TextBox ID="txtLength" runat="server" Width="100%" CssClass="PositiveDouble"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlLengthUOM" runat="server" Filter="Contains"
                                                                AllowCustomText="true" CloseDropDownOnBlur="true"
                                                                AutoPostBack="false" NoWrap="true" Width="100%"
                                                                CausesValidation="False" OnClientSelectedIndexChanging="LinearLengthUOMChanging">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblLinearArea" meta:resourcekey="lblLinearArea" Text="Area"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px">
                                                            <asp:TextBox ID="txtLinearArea" runat="server" Width="100%" CssClass="PositiveDouble"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlLinearAreaUOM" runat="server" Filter="Contains"
                                                                AllowCustomText="true" CloseDropDownOnBlur="true"
                                                                AutoPostBack="false" NoWrap="true" Width="100%"
                                                                CausesValidation="False" OnClientSelectedIndexChanging="LinearAreaUOMChanging">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>

                            <div class="col-4 col-4-right">
                                <uc7:ItemRotator ID="PMrot" runat="server" />
                                <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                            </div>
                        </div>
                    </div>
                </telerik:RadAjaxPanel>

            </telerik:RadPageView>
            <telerik:RadPageView ID="PvSpec" runat="server">
                <uc13:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvEquipmentMoves" runat="server">
                <uc5:EquipmentMoves ID="EquipmentMoves" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvEquipmentComponents" runat="server">
                <uc8:AssetComponents ID="AssetComponents1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvMaintenance" runat="server" Visible="false">
                <uc10:EquipmentMaintenance ID="EquipmentMaintenance" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvLog" runat="server">
                <uc11:EquipmentLogs ID="EquipmentLogs" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWorkOrders" runat="server">
                <uc9:AssetTypeWorkOrder ID="AssetTypeWorkOrder1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvCostWorkSheet" runat="server">
                <uc6:EquipmentCostWorkSheet ID="EquipmentCostWorkSheet1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotes" runat="server">
                <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvAttachments" runat="server">
                <uc2:DocumentAttachments ID="DocumentAttachments" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWorkflow" runat="server">
                <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>







</asp:Content>
