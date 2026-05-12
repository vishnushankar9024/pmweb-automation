<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="EstimateProcurements.aspx.vb" Inherits="Website.EstimateProcurements" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EstimateProcurementDetails.ascx" TagName="ProcurementDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="ManageBids.ascx" TagName="ManageBids" TagPrefix="uc6" %>
<%@ Register Src="DocumentProcurementClauses.ascx" TagName="DocumentProcurementClauses" TagPrefix="uc9" %>
<%@ Register Src="BidderMatrix.ascx" TagName="BidderMatrix" TagPrefix="uc8" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc10" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc11" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc12" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc13" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc14" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
		
		<link rel="stylesheet" href="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/styles/jqx.base.css" type="text/css" />
		<link rel="stylesheet" href="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/styles/jqx.summer.css" type="text/css" />
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/scripts/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/jqxcore.js"></script>
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/jqxwindow.js"></script>
		<script type="text/javascript" src="Custom/jqwidgets-ver19.2.0/jqwidgets-ver19.2.0/jqwidgets/jqxbuttons.js"></script>
		
    <script src="JS/Scoring.js" type="text/javascript"></script>
    <%--<link href="JS/Estimates/jquery.countdown.css" rel="stylesheet" type="text/css" />--%>
    <script src="JS/Estimates/Procurements.js" type="text/javascript"></script>
    <script src="JS/Estimates/jquery.countdown.js" type="text/javascript"></script>


    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <style>
            .TableOptionsNoSpacingNoBorder tr td{
                padding: 0 0 5px 0;
            }
            .labelChkWidth {
                width: 80% !important;
                height: 24px;
                line-height: 24px;
                background: #FFFFFF;
                color: #666666 !important;
            }

            .lblchkAll {
                height: 24px;
                line-height: 24px;
                background: #FFFFFF;
                color: #666666 !important;
                padding-bottom: 3px;
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
        <script type="text/javascript">
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
			// Added by deepika
			function handleRightClick(sender, event) {
			event.preventDefault();  // Prevent the default right-click context menu

			// Trigger the logic you want to run when right-clicking on the link
			ebConfirm(sender, event, 'rightclick');   
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



            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.Estimate.ProcurementInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=ESTIMATE_PROCUREMENT&Id=" +
                                          '<%= PM.Estimate.ProcurementInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.Estimate.ProcurementInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);

                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                {
                    var HasMergeTemplate = '<%= PM.Estimate.ProcurementInfo.HasMergeTemplate%>';
                    var RecordDescription = '<%=JSEscape(PM.Estimate.ProcurementInfo.RecordDescription)%>';
                    var Description = '<%=JSEscape(PM.Estimate.ProcurementInfo.Description)%>';
                    var HasReports = '<%= PM.Estimate.ProcurementInfo.HasReports%>';
                    var Id = '<%= PM.Estimate.ProcurementInfo.Id%>';
                    var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("ESTIMATE_PROCUREMENT")%>';
                    switch (Value) {
                        case 'ViewTemplates':
                            if (HasMergeTemplate == 'True') {
                                var left = (screen.width - 1045) / 2;
                                var top = (screen.height - 515) / 2;
                                OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=ESTIMATE_PROCUREMENT&Id=" +
                                         '<%= PM.Estimate.ProcurementInfo.Id%>' + "&Description="
                                              + Description
                                              + "&RecordDescription=" + RecordDescription
                                              + "&EntityId=" + '<%=PM.Estimate.ProcurementInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);

                            }
                            break;
                        case 'ViewReports':
                            if (HasReports == 'True') {
                                OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ESTIMATE_PROCUREMENT&Id=" +
                                '<%= PM.Estimate.ProcurementInfo.Id%>'
                                      + "&RecordDescription=" + RecordDescription
                                      + "&EntityId=" + '<%=PM.Estimate.ProcurementInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                            }
                            break;

                        case 'Print':

                            if (HasReports == 'True') {
                                OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ESTIMATE_PROCUREMENT&Id=" +
                                '<%= PM.Estimate.ProcurementInfo.Id%>'
                                      + "&RecordDescription=" + RecordDescription
                                      + "&EntityId=" + '<%=PM.Estimate.ProcurementInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                        case 'Notification':
                            if (Id == 0) break;
                            var left = (screen.width - 900) / 2;
                            var top = (screen.height - 500) / 2;
                            OpenPOPUp("Notification.aspx?ObjectType=ESTIMATE_PROCUREMENT&Id=" +
                                   '<%= PM.Estimate.ProcurementInfo.Id%>' + "&Description="
                                 + Description
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Estimate.ProcurementInfo.ProjectId%>' + "&EntityType=0", "Notification",
                     'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                            break;

                        case 'Submit':
                            return OpenWorkflowSubmitPopup('ESTIMATE_PROCUREMENT');
                            break;

                        case 'Commitment':
                            OpenPOPUpToRedirect('ProcurementContracts.aspx?type=Subcontract', 950, 500);
                            break;

                        case 'CopyRevision':
                            if (Id == 0) break;
                            var result = OpenSmallPOPUp('ProcurementRevisionPopup.aspx', 400, 200, false);
                            break;

                        case 'PurchaseOrder':
                            OpenPOPUpToRedirect('ProcurementContracts.aspx?type=PurchaseOrder', 950, 500);
                            break;

                        case 'ViewPMWebReports':
                            var left = (screen.width - 900) / 2;
                            var top = (screen.height - 500) / 2;
                            if (HasPMWebReports == 'True' && Id > 0) {
                                OpenPOPUp("PMWebReports.aspx?ObjectType=ESTIMATE_PROCUREMENT&Id=" + Id
                            + "&EntityId=" + '<%=PM.Estimate.ProcurementInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                            }
                            break;

                        case 'New':
                            window.location = "EstimateProcurements.aspx";
                            break;

                        default:
                            //                        eventArgs.set_cancel(false);
                            break;
                    }
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function RebindBidders() {
                var btnRefreshId = $("a[id*=rdgProcurementBidders][id$=btnRefresh]")[0];
                if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
            }


            function OpenSelectedBidsPopup(Id) {
                OpenPOPUp('SelectedBids.aspx?Id=' + Id, 530, 300, true, 'rdgProcurementBidders');
                return false;
            }





            function OpenNDAEditorPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var ChkRequireNDAAcceptance = $("[id$=ChkRequireNDAAcceptance]")[0];
                var CanEdit = (ChkRequireNDAAcceptance.disabled ? 'False' : 'True');
                var wnd = window.radopen('NDAEditorPopUp.aspx?ObjectType=ESTIMATE_PROCUREMENT&CanEdit=' + CanEdit);
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




            function OpenBidderDaysRecapPopup() {
                OpenPOPUp('BidderDaysRecap.aspx', 920, 415, false);
                return false;
            }

            function OpenBidderMWDBERecapPopup() {
                OpenPOPUp('BidderMWDBERecap.aspx', 920, 415, false);
                return false;
            }

            function OpenBidAcknowledgementRecapPopup() {
                OpenPOPUp('BidAcknowledgementRecap.aspx', 920, 415, false);
                return false;
            }


            function OpenProcurementUniCostPopup(Id) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('ProcurementUniCostPopup.aspx?Id=' + Id);
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

            function StopLink() {

                return false;
            }
            function OpenBestBidPopup(Id) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('SelectedBids.aspx?Id=' + Id);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(WindowCloseBestBid);
                return false;
            }


            function WindowCloseBestBid() {
                var btnRefreshId = $("a[id*=rdgProcurementDetails][id$=btnRefresh]")[0];
                if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
                RebindBidders();

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





            function ResetCombos(combobox, eventArgs) {
                var item = eventArgs.get_item();

                if (combobox.get_id().indexOf('ddlProjects') > 0) {
                    var ddlWBS = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlWBS');
                    ddlWBS.clearItems();
                    ddlWBS.set_text('');
                    ddlWBS.set_value('');
                    //            combobox.trackChanges();
                    //            combobox.set_value(item.get_value());
                    //            combobox.commitChanges();

                    var ddlPhase = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPhase');
                    ddlPhase.clearItems();
                    ddlPhase.set_text('');
                    ddlPhase.set_value('');
                    var ddlCostCode = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCostCodes');
                    ddlCostCode.clearItems();
                    ddlCostCode.set_text('');
                    ddlCostCode.set_value('');

                    for (var i = 1; i <= 10; i++) {
                        var ddlData = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_EditUserDefinedFields' + i + '_ddlData');
                        if (ddlData != null) {
                            var ListId = ddlData._attributes.getAttribute("ListId");
                            if (ListId == 207 || ListId == 214 || ListId == 215 || ListId == 217 || ListId == 206 || ListId == 62) {
                                ddlData.clearItems();
                                ddlData.set_text('');
                                ddlData.set_value('');
                            }

                        }


                    }



                }

            }


            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                if ((combobox.get_id().indexOf('ddlWBS') > 0) || (combobox.get_id().indexOf('ddlCostCodes') > 0) || (combobox.get_id().indexOf('ddlPhase') > 0)) {
                    var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                    SelectedValue = ddlProjects.get_value();

                    var context = eventArgs.get_context();
                    context["FilterString"] = SelectedValue;
                }

            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
			document.addEventListener("DOMContentLoaded", function () {
			// Select the Submit BID button using querySelector (you can use any selector that matches the button)
			var submitBIDButton = document.querySelector("[title='Save (Alt+s)");

			if (submitBIDButton) {
					// Create a new button element
				var newButton = document.createElement("a");		
				newButton.href = "javascript:void(0);"; // Prevent navigation
				newButton.className = "RadToolBarButton"; // Add the RadToolBarButton styling class
				newButton.innerHTML = 'Procurement URL'; // Define the content of the new button

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
        <script type="text/javascript">
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


        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpProcurements">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProcurements" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProcurements" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <asp:HiddenField runat="server" ID="hdnCounterSeconds" />
    <%-- <asp:HiddenField runat="server" ID="hdnBidDueMonth" />  
       <asp:HiddenField runat="server" ID="hdnBidDueYear" />  
        <asp:HiddenField runat="server" ID="hdnBidDueMinute" />  
         <asp:HiddenField runat="server" ID="hdnBidDueHours" />  
              <asp:HiddenField runat="server" ID="hdnTimeZoneOffset" />  --%>



    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=94">
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
                <telerik:RadComboBox ID="ddlProcurements" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Metro" AllowCustomText="true" EmptyMessage="Select Procurement..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" AutoPostBack="False" NoWrap="true" CausesValidation="False" Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>

            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Delete" NavigateUrl="SearchDocument.aspx?O=94" CausesValidation="false">
                                         </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" CausesValidation="true" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                       <%-- <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add"
                                    CommandName="CreateRevision" Visible="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Copy" PostBack="false" CommandName="CopyRevision" ImageUrl="Images/ToolBar/Revision.png">
                                    </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
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
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="View Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Commitment" Value="Commitment"></telerik:RadMenuItem>

                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ESTIMATE_PROCUREMENT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('ESTIMATE_PROCUREMENT');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Estimating.htm#Procurements">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" CommandName="Commitment" ImageUrl="Images/ToolBar/PMWebW.gif">
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

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" OnClientTabSelecting="onTabSelecting" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpProcurements" Width="100%" EnableViewState="True"
        CausesValidation="false" OnTabClick="tbsDocument_TabClick">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="Bidder Matrix" Value="BidderMatrix" Selected="false" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Bid Items" Value="BidItems" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Scoring" Value="Scoring"></telerik:RadTab>
            <telerik:RadTab Text="Manage Bids" Value="ManageBids" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />


        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpProcurements" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" ClientEvents-OnRequestStart="ProcurementRequestStart" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">

                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Metro" NoWrap="true" Width="100%" SkipValue="0"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>

                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvProgramRequired" runat="server" ControlToValidate="ddlProgram"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Program required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProgram" runat="server" ControlToValidate="ddlProgram"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Program required" meta:Resourcekey="rfvProgramRequired">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:Resourcekey="lblProject" runat="server"
                                            Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:Resourcekey="ddlProjects"
                                            NoWrap="true" Skin="Metro" Width="100%" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjectsRequired" runat="server" ControlToValidate="ddlProjects" meta:Resourcekey="rfvProjectsRequired"
                                            CssClass="Validator" InitialValue="" 
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblProcurementNumber" meta:Resourcekey="lblProcurementCode" runat="server" Text="Procurement #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProcurementNumber" ReadOnly="false" runat="server" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvProcurementNumber" runat="server" ValidationGroup="Save" ControlToValidate="txtProcurementNumber"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="Procurement # is required" meta:resourcekey="rfvProcurementNumberRequired"
                                            ForeColor=""></asp:RequiredFieldValidator>

                                        <asp:Label ID="lblUniqueProcNumber" runat="server" Text="<br/>the Procurement # must be unique by Project." meta:Resourcekey="lblUniqueCode" Visible="False" Class="Validator"></asp:Label>
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
                                        <telerik:RadComboBox ID="ddlBidCategories" runat="server" AllowCustomText="true" Width="100%" Skin="Metro" Filter="Contains" MarkFirstMatch="true">
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
                                            ID="ddlCompanies" runat="server" Height="200px" Skin="Metro" Width="100%"
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
                                        <telerik:RadComboBox ID="ddlBidderContact" runat="server" Width="100%" 
                                            Skin="Metro" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" DropDownWidth="385px"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                            Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px">
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table cellspacing="0" cellpadding="2" style="width:385px">
                                                    <tr>
                                                        <td style="width: 250px">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" meta:Resourcekey="lblCommitmentType" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Skin="Metro" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="hplCurrency" Height="18px" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="ImgfilterCurrency">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="300px" Skin="Default" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" meta:Resourcekey="lblRevisionDate" Text="Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Culture="English (United States)"
                                                EnableTyping="False">
                                                <DateInput ID="DateInput2" runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar2" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder" runat="server" id="tblStatusRevision">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Metro" Style="width: 182px !important">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="padding-left: 8px; width: 50px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server"></asp:TextBox>
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
                                                Width="100%" EnableTyping="true">
                                                <DateInput ID="DateInput3" runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar3" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>

                                </tr>
                                <tr>

                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime" meta:Resourcekey="lblTime" runat="server" Text="Bids Due Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="rtpTime" runat="server" Skin="Metro" Width="100%" SelectedDate="7:00 AM">
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr style="line-height: 24px;" runat="server" id="trServerTime">
                                    <td colspan="2" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <asp:Label runat="server" ID="lblServerTime" class="labelColor"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPreBid" meta:Resourcekey="lblPreBid" runat="server" Text="Pre-bid" Visible="false"></asp:Label>
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliPreBid" meta:Resourcekey="lblPreBid" Text="Pre-bid" Visible="false"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox
                                            ID="ddlPreBids" runat="server" Height="200px" Skin="Metro" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlPreBids" EmptyMessage="Select PreBid..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEstimateNumber" meta:Resourcekey="lblEstimateNumber" runat="server"
                                            Text="Estimate #"></asp:Label>
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliEstimateNumber" meta:Resourcekey="lblEstimateNumber" Text="Estimate #" Visible="false"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEstimateNumber" runat="server" ReadOnly="true" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCommitmentID" meta:Resourcekey="lblCommitment" runat="server" Visible="false"></asp:Label>
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliCommitmentID" meta:Resourcekey="lblCommitment" Visible="false"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCommitmentID" ReadOnly="true" runat="server" Text="" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
								<tr>
								<td class="labelWidth">
									<!-- Label for Custom URL -->
									<asp:LinkButton runat="server" CssClass="Link" ID="lblCustomUrl" OnClientClick="return ebConfirm(this, event, 'click');" oncontextmenu="handleRightClick(this, event)" Text="Procurement URL"></asp:LinkButton>
								</td>
								<td class="controlWidth">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<!-- TextBox for Custom URL -->
												<asp:TextBox runat="server" ID="txtCustomUrl" Width="100%" CssClass="custom-textbox" Placeholder="Enter Custom URL" ReadOnly="true"/>
												</asp:TextBox>
											</td>
										</tr>
									</table>
								</td>
							</tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset style="width: 100%">
                                <legend id="lgdOptions" runat="server">
                                    <asp:Label runat="server" ID="lblOptions" Text="Options" meta:Resourcekey="lblOptions" CssClass="legend"></asp:Label>
                                </legend>
                                <table id="tblOptions" class="TableOptionsNoSpacingNoBorder" width="100%" cellpadding="0" cellspacing="0" runat="server">
                                    <tr>
                                        <td></td>
                                        <td style="text-align: right;">
                                            <asp:Label runat="server" CssClass="lblchkAll" ID="lblAll" Text="ALL"></asp:Label>
                                            <asp:CheckBox runat="server" ClientIDMode="Static" ID="chkAll" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelChkWidth">
                                            <asp:Label runat="server" ID="lblSealdBid" Text=" This is a Sealed Bid" meta:Resourcekey="chkSealdBid"></asp:Label>
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
                                            <table style="width: 100%;" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 79%;">
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
                                            <asp:Label runat="server" ID="lblLockBidQuantity" Text=" Lock Quantity in Online Bids" meta:Resourcekey="chkLockBidQuantity"></asp:Label>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:CheckBox runat="server" ID="chkLockBidQuantity" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <div runat="server" id="fldClock" style="padding-top: 15px; text-transform: uppercase;">
                                <div id="defaultCountdown"></div>
                            </div>
                            <asp:Label ID="lblHidenRows" runat="server" Text="Some of the detail lines are hidden for security reasons." Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows" style="display:block"></asp:Label>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc10:AssetRotator ID="PMrot" runat="server" />
                            <uc14:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvBidderMatrix" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc8:BidderMatrix ID="BidderMatrix1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%">
            <uc1:ProcurementDetails ID="ProcurementDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc12:DocumentScoring ID="DocumentScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvManageBids" runat="server">
            <uc6:ManageBids ID="ManageBids" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc11:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentProcurementClauses ID="DocumentProcurementClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc13:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server">
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
    <asp:Button ID="btnProject" runat="server" CssClass="Hide" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<div id="EBConfirmModal" style="display: none;">
    
    <div> <!-- Content -->
         
    </div>
</div>
</asp:Content>
