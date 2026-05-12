<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PreBid.aspx.vb" Inherits="Website.PreBid" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc1" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc2" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc4" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="DocumentProcurementClauses.ascx" TagName="DocumentProcurementClauses" TagPrefix="uc7" %>
<%@ Register Src="PreBidBidderMatrix.ascx" TagName="PreBidBidderMatrix" TagPrefix="uc8" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc9" %>
<%@ Register Src="PreBidDetails.ascx" TagName="PreBidDetails" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc14" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
	<link rel="stylesheet" href="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/styles/jqx.base.css" type="text/css" />
		<link rel="stylesheet" href="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/styles/jqx.summer.css" type="text/css" />
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/scripts/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/jqxcore.js"></script>
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/jqxwindow.js"></script>
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/jqxbuttons.js"></script>
  	
    <style>
        .labelChkWidth {
            width: 80% !important;
            height: 24px;
            line-height: 24px;
            background: #FFFFFF;
            color: #666666 !important;
            padding-bottom: 3px;
        }

        .lblchkAll {
            height: 24px;
            line-height: 24px;
            background: #FFFFFF;
            color: #666666 !important;
            padding-bottom: 3px;
        }

        #tblOptions > tbody > tr > td {
            padding: 0 0 5px 0;
        }
/* Ensure the modal and body use full screen but prevent overflow */

html, body {
    width: 100%;
    height: 100%; /* Ensure the body takes up full height */
    margin: 0;
    padding: 0;
    /* overflow: hidden;  Prevent scrollbars */
}
.jqx-widget-header {
	display:none;
}

#EBConfirmModal {
    display: none;  /* Initially hidden */
    position: fixed;
    top: 0;
    left: 0;
    z-index: 9999;
    background-color: rgba(0, 0, 0, 0.7);  /* Background overlay */
    display: flex;  /* Flexbox for layout */
    flex-direction: column;  /* Align header and iframe vertically */
	/*  overflow: auto !important; */
    /* Removed width, height, max-width, max-height */
}


#EBConfirmModal .jqx-widget-content {
    width: 100%; /* Let content take full width */
    height: 100%; /* Let content take full height */
    padding: 0;  /* Remove any padding from content area */
    margin: 0;   /* Remove any margin */
	flex: 1;
}


#btnEBCCancel {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: red;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    z-index: 10001;  /* Ensure it is above iframe */
}

iframe {
    width: 100%;
    height: calc(100vh - 100px); /* Adjust based on your header height */
    border: none;
    flex-grow: 1;  /* Allow iframe to grow and fill the remaining space */
}
      
    </style>
    <script src="JS/Estimates/jquery.countdown.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
			// Added by deepika
			function handleRightClick(sender, event) {
			event.preventDefault();  // Prevent the default right-click context menu

			// Trigger the logic you want to run when right-clicking on the link
			ebConfirm(sender, event, 'rightclick');   
			}
            function isMobileScreen() {
                var browserWidth = $telerik.$(window.parent).width();
                if (browserWidth <= MobileScreenWidth)
                    return true;
                return false;
            }

            function pageLoad() {
			$('#EBConfirmModal').hide();   
                chkParent();
                $("#chkAll").change(function () {
                    if ($(this).prop("checked")) {
                        $("#tblOptions input[type='checkbox']").attr("checked", true);
                    } else {
                        $("#tblOptions input[type='checkbox']").attr("checked", false);
                    }
                })

                $('#tblOptions').not('#chkAll').on('change', 'input[type="checkbox"]:not("#chkAll")', function () {
                    if (!$(this).prop("checked")) {
                        $("#chkAll").attr("checked", false);
                    } else {
                        chkParent();
                    }
                });
            }
			

            function chkParent() {
                var checked = true;
                $('#tblOptions input[type="checkbox"]:not("#chkAll")').each(function () {
                    if (!$(this).prop("checked")) {
                        checked = false;
                        return;
                    }
                })
                $("#chkAll").attr("checked", checked);
            }
            var forceMoreMenuToClose = true;
            var allowdropdownClose;
            function ProcurementPopupClosed() {
                var btnRefreshPrebidPage = $("[id$=btnRefreshPrebidPage]");
                btnRefreshPrebidPage.click();
            }
            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.Estimate.PreBidInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=PREBID&Id=" +
                                     '<%= PM.Estimate.PreBidInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
               <%-- if (args.get_item().get_value() == "GenerateProcurement") {
                   
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Generate");
                        button.click();
                    }--%>

                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(value) {
              
                var HasMergeTemplate = '<%= PM.Estimate.PreBidInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.Estimate.PreBidInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Estimate.PreBidInfo.Description)%>';
                var HasReports = '<%= PM.Estimate.PreBidInfo.HasReports%>';
                var Id = '<%= PM.Estimate.PreBidInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("PREBID")%>';
                switch (value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 415) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=PREBID&Id=" +
                                        '<%= PM.Estimate.PreBidInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);

                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PREBID&Id=" +
                                '<%= PM.Estimate.PreBidInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'BIReporting':
                        window.location ="ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;

                    case 'Print':
                       <%-- OpenReportViewerPOPUp("PrintPreview.aspx?ReportId=127&Param=ProcurementId&Values=" + '<%=PM.Estimate.PreBidInfo.Id%>');--%>
                        //            eventArgs.set_cancel(true);
                         if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PREBID&Id=" +
                                '<%= PM.Estimate.PreBidInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                         }
                         else {
                             window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                         }

                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=PREBID&Id=" +
                     '<%= PM.Estimate.PreBidInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'Procurement':
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var wnd = window.radopen('PreBidGenerateProcurementPopup.aspx');
                        if (isMobileScreen()) {
                            wnd.setSize(browserWidth - 10, browserHeight);
                            wnd.moveTo(0, 0);
                        }
                        else {
                            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                            wnd.Center();
                        }
                        wnd.add_close(ProcurementPopupClosed);
                        break;

                    case 'CopyRevision':
                        if (Id == 0) break;
                        var result = OpenPOPUp('ProcurementRevisionPopup.aspx', 640, 280, false);
                        break;

                    case 'PurchaseOrder':
                        OpenPOPUpToRedirect('ProcurementContracts.aspx?type=PurchaseOrder', 950, 500);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=PREBID&Id=" + Id
                        + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=900,height=500,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = "PreBid.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('PREBID');
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }


            function GenerateCounter() {
                hdnCounterSeconds = $("[id$=hdnCounterSeconds]")[0];
                //        hdnBidDueMonth = $("[id$=hdnBidDueMonth]")[0];
                //        hdnBidDueYear = $("[id$=hdnBidDueYear]")[0];
                //        hdnBidDueMinute = $("[id$=hdnBidDueMinute]")[0];
                //        hdnBidDueHours = $("[id$=hdnBidDueHours]")[0];
                //        ///////////////
                //        hdnTimeZoneOffset = $("[id$=hdnTimeZoneOffset]")[0];

                if (hdnCounterSeconds.value != "") {
                    //            var Servertimezone = hdnTimeZoneOffset.value;
                    //            var ServerDate = new Date(hdnBidDueYear.value, hdnBidDueMonth.value - 1, hdnBidueDay.value,hdnBidDueHours.value, hdnBidDueMinute.value);
                    //$('#defaultCountdown').countdown({ until: ServerDate, timezone: Servertimezone });
                    $('#defaultCountdown').countdown({ until: hdnCounterSeconds.value });
                }

            }

            function OpenMultipleCompaniesPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var left = (browserWidth - (browserWidth * 0.9)) / 2;
                var top = (browserHeight - (browserHeight * 0.9)) / 2;
                var ProjectId = 0;
                if ($("div[id*=ddlProject]")[0] != null)
                    ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
                var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=NOTExist&txtEmail=NOTExist&Type=Companies&txtIds=NotExist&ddlType=Multiple&Source=PreBid&ProjectId=' + ProjectId + '&ProjectRequired=1', '',
                    'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + browserWidth * 0.9 + ',height=' + browserHeight * 0.9 + ',top=' + top + ',left=' + left);
                return false;

            }

            function OpenNDAEditorPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var ChkRequireNDAAcceptance = $("[id$=ChkRequireNDAAcceptance]")[0];
                var CanEdit = (ChkRequireNDAAcceptance.disabled ? 'False' : 'True');
                var wnd = window.radopen('NDAEditorPopUp.aspx?ObjectType=PREBID&CanEdit=' + CanEdit);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;



            }
            function rdvOccupantNodeClicking(sender, args) {
                var comboBox = $find(sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlTypes')) + '_ddlTypes');
                var node = args.get_node();
                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                if (strValue.indexOf("D") > 0) return;
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

            function DeleteSelectedLines(ctrl) {
                var gridId = $("[id$=" + ctrl + "]")[0].id;
                var grid = $find(gridId);
                if (grid.get_masterTableView().get_selectedItems().length > 0) {
                    return ConfirmDelete();
                }
                return false;
            }

            function AdjustPreBidCalculation(gridId) {
                var grid = $("#" + gridId);

                $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    Calculate(row, "TotalAmount");
                });

                $("input[id*=" + gridId + "][id$=txtEstimatedUnitCost]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    Calculate(row, "TotalAmount");
                });

                $("input[id*=" + gridId + "][id$=txtEstimatedTotal]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    Calculate(row, "UnitPrice");
                });
            }
            function Calculate(row, toCalculate) {
                var txtQuantity = row.find("input[id$='txtQuantity']");
                var txtUnitPrice = row.find("input[id$='txtEstimatedUnitCost']");
                var txtTotalAmount = row.find("input[id$='txtEstimatedTotal']");

                var QantityVal = CDbl(txtQuantity.val());
                var UnitPriceVal = CDbl(txtUnitPrice.val());
                var AmountVal = CDbl(txtTotalAmount.val());

                if (toCalculate == "TotalAmount") {
                    txtTotalAmount.val(CCur(UnitPriceVal * QantityVal));
                }
                else if (toCalculate == "UnitPrice") {
                    if (QantityVal == 0) {
                        QantityVal = 1;
                        txtQuantity.val(FPrec(1));
                    }
                    txtUnitPrice.val(CCur(AmountVal / QantityVal));
                }
            }
            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function check(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }
            function OnClientSelectedIndexChanging(combobox, eventArgs) {
                allowdropdownClose = false;
                eventArgs.set_cancel(true);
            }
            function OnClientDropDownClosing(combobox, eventArgs) {
                if (allowdropdownClose == false) {
                    eventArgs.set_cancel(true);
                }
                allowdropdownClose = true;

            }
					
		   document.addEventListener("DOMContentLoaded", function () {
			// Select the Submit BID button using querySelector (you can use any selector that matches the button)
			var submitBIDButton = document.querySelector("[title='Save (Alt+s)");

			if (submitBIDButton) {
					// Create a new button element
				var newButton = document.createElement("a");
				newButton.href = "javascript:void(0);"; // Prevent navigation
				newButton.className = "RadToolBarButton"; // Add the RadToolBarButton styling class
				newButton.innerHTML = 'PreBid URL'; // Define the content of the new button

				// Attach a click event handler to the new button
				newButton.addEventListener("click", function () {
					
					ebConfirm(newButton,  event, 'click');
					alert("New Action button clicked!");
				});
				// Insert the new button after the Submit BID button
				//submitBIDButton.parentElement.insertBefore(newButton, submitBIDButton.nextSibling); // Adds it immediately after the Submit BID button

		}
		});
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>  
             <telerik:AjaxSetting AjaxControlID="mlpPreBids">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPreBids" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPreBids" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
            <telerik:AjaxSetting AjaxControlID="rdgBidderMatrix">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgBidderMatrix" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshBidderMatrix" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefreshBidderMatrix">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgBidderMatrix" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btnRefreshBidderMatrix" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <asp:HiddenField runat="server" ID="hdnCounterSeconds" />
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=244">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlPreBids" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" AllowCustomText="true" EmptyMessage="Select PreBid..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" AutoPostBack="False" NoWrap="true" CausesValidation="False" Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>

            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Delete" NavigateUrl="SearchDocument.aspx?O=244" CausesValidation="false">
                                         </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" CausesValidation="true" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">

                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/Revision.png"
                                    CommandName="CreateRevision" Value="CreateRevision" Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>

                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting" Value="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports" Value="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports" Value="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates" Value="ViewTemplates">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                          <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb View Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Procurement" Value="Procurement"></telerik:RadMenuItem>

                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('PREBID');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('PREBID');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Estimating.htm#Procurements">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton CommandName="Generate" Value="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png" CssClass="ToolbarGenerate HideOnMobileToolbar"
                            EnableDefaultButton="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Value="Procurement" CommandName="Procurement" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" ScrollChildren="true" OnClientTabSelecting="onTabSelecting" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpPreBids" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="false" OnTabClick="tbsDocument_TabClick">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Bidder Matrix" Value="PreBidBidderMatrix" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Bid Items" Value="PreBidDetails" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Checklist" Value="Checklists" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />


        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpPreBids" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:Resourcekey="lblProject" runat="server" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" Width="100%" Skin="Default"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px"
                                            NoWrap="True" EnableLoadOnDemand="True" MarkFirstMatch="true" Filter="Contains" AllowCustomText="true"
                                            ShowMoreResultsBox="True" AutoPostBack="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="cmpProject" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" meta:resourcekey="cmpProject">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblPreBidNumber" meta:Resourcekey="lblPreBidNumber" Width="100%" runat="server" Text="Pre-bid #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPreBidNumber" ReadOnly="false" runat="server" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPreBidNumber" runat="server" ValidationGroup="Save" ControlToValidate="txtPreBidNumber"
                                            CssClass="Validator" Display="Dynamic" meta:resourcekey="rfvPreBidNumbers"
                                            ForeColor=""></asp:RequiredFieldValidator>

                                        <asp:Label ID="lblUniquePreBidNumber" runat="server" Text="<br/>the Pre-bid # must be unique by Project." meta:Resourcekey="lblUniqueCode" Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server"
                                            Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidCategory" meta:Resourcekey="lblBidCategory" runat="server"
                                            Text="Bid Category*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBidCategories" AllowCustomText="true" runat="server" Width="100%" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                            Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBiddingCompany" meta:Resourcekey="lblBiddingCompany" runat="server" Text="Bidding Company"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox
                                            ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBiddingContact" runat="server" meta:resourcekey="lblBiddingContact"
                                            Text="Bidding Contact"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBidderContact" runat="server" dropdownwidth="385px"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                            Height="250px">
                                            <HeaderTemplate>
                                                <table  style="width:385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width:250px">
                                                            <asp:Literal ID="Literal3"  runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td>
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width:385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width:250px" >
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width:135px" >
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" Skin="Default" Height="300px"
                                            Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus_Revision" meta:Resourcekey="lblStatus_Revision" runat="server" Text="Status/Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" id="tblStatusRevision" runat="server">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px; width: 182px !important">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="padding-left: 8px; width: 50px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" Width="100%" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidsDueDate" meta:Resourcekey="lblBidsDue" runat="server" Text="Bids Due Date"></asp:Label>
                                    </td>

                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpBidsDue" style="display: block">
                                            <telerik:RadDatePicker ID="rdpBidsDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Skin="Default" EnableTyping="true">
                                                <DateInput ID="DateInput3" Skin="Default"
                                                    runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime" meta:Resourcekey="lblDueTime" runat="server" Text="Bids Due Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="rtpTime" runat="server" Skin="Default" Width="100%" SelectedDate="7:00 AM">
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr style="line-height: 24px;" runat="server" id="tdServerTime">
                                    <td colspan="2" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <asp:Label runat="server" ID="lblServerTime" class="labelColor"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCommitmentType" meta:Resourcekey="lblCommitmentType" runat="server" Text="Commitment Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Skin="Default" AllowCustomText="true" Style="font-size: 11px" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliProcurement" meta:Resourcekey="lblProcurement" Text="Procurement"></asp:HyperLink>
                                        <asp:Label runat="server" ID="lblProcurement" meta:Resourcekey="lblProcurement" Text="Procurement1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlProcurement" runat="server" Width="100%"
                                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListProcurementEmptyMsg %>'
                                                        NoWrap="True" AllowCustomText="true" OnClientDropDownClosing="OnClientDropDownClosing" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                        OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn"
                                                        Style="font-size: 11px" Height="250px">
                                                        <ItemTemplate>
                                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                <asp:CheckBox runat="server" ID="chkApplyRole" />
                                                            </div>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:HiddenField runat="server" ID="hddnIds" />
                                                    <asp:HiddenField runat="server" ID="hddnNames" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
							<tr>
							<td class="labelWidth">
								<!-- Label for Custom URL -->
								<asp:LinkButton runat="server" CssClass="Link" ID="lblCustomUrl" OnClientClick="return ebConfirm(this, event, 'click');" oncontextmenu="handleRightClick(this, event)" Text="PreBid URL"></asp:LinkButton>
							</td>
							<td class="controlWidth">
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td>
											<!-- TextBox for Custom URL -->
											<asp:TextBox runat="server" ID="txtCustomUrl" Width="100%" CssClass="custom-textbox" Placeholder="Enter Custom URL" ReadOnly="true" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend runat="server" id="lgdOptions">
                                    <asp:Label runat="server" ID="lblOptions" Text="Options" meta:Resourcekey="lblOptions" CssClass="legend"></asp:Label>
                                </legend>
                                <table id="tblOptions" class="TableNoSpacingNoBorder" style="width: 100%" runat="server">
                                    <tr>
                                        <td></td>
                                        <td style="text-align: right;">
                                            <asp:Label runat="server" CssClass="lblchkAll" ID="lblAll" Text="ALL"></asp:Label>
                                            <asp:CheckBox runat="server" ClientIDMode="Static" ID="chkAll" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblSealBid" Text=" This is a Sealed Bid" meta:Resourcekey="chkSealdBid"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkSealdBid" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblLockBidsAfterDue" Text=" Lock Online Bids After Bids Due" meta:Resourcekey="chkLockBidsAfterDue"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkLockBidsAfterDue" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblIncludeDaysColumn" Text=" Include Days Column in Online Bids" meta:Resourcekey="chkIncludeDaysColumn"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkIncludeDaysColumn" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblIncludeMWDBEColumn" Text=" Include MWDBE % Column in Online Bids" meta:Resourcekey="chkIncludeMWDBEColumn"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkIncludeMWDBEColumn" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblIncludeMfrColumn" Text=" Include Manufacturer Columns in Online Bids" meta:Resourcekey="chkIncludeMfrColumn"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkIncludeMfrColumn" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblIncludeUDFS" Text=" Include Bid Item UDFs in Online Bids" meta:Resourcekey="chkIncludeUDFS"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkIncludeUDFS" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblRequireAcnoledgements" Text=" Require Acknowledgements" meta:Resourcekey="chkRequireAcnoledgements"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkRequireAcnoledgements" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblRequireNDAAcceptance" Text=" Require Nondisclosure Agreement" meta:Resourcekey="ChkRequireNonDisclosureAgrmt"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton runat="server" ID="BtnEditDNA" OnClientClick="return OpenNDAEditorPopup();" CssClass="SearchButton">
    					                                                                <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox runat="server" ID="ChkRequireNDAAcceptance" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblShowCountdown" Text=" Show Bid Due Countdown Clock" meta:Resourcekey="chkShowCountdown"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkShowCountdown" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblLockBidQuantity" Text="Lock Quantity in Online Bids" meta:Resourcekey="chkLockBidQuantity"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkLockBidQuantity" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <div runat="server" id="fldClock" style="margin-top: 15px;">
                                <div id="defaultCountdown"></div>
                            </div>
                        </div>
                        <div class="col-4 col-4-right">

                            <uc9:AssetRotator ID="PMrot" runat="server" />
                            <uc14:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />

                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvBidderMatrix" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc8:PreBidBidderMatrix ID="PreBidBidderMatrix1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPreBidDetails" runat="server">
            <uc10:PreBidDetails ID="PreBidDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc4:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
         <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc6:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc1:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc2:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc7:DocumentProcurementClauses ID="DocumentProcurementClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc3:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <asp:Button runat="server" ID="btnRefreshPrebidPage" CssClass="Hide" />
	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<div id="EBConfirmModal" style="display: none;">
    
    <div> <!-- Content -->
         
    </div>
</div>

</asp:Content>
