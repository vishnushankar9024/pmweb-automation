<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PMMaster.Master" CodeBehind="WorkOrders.aspx.vb" Inherits="Website.WorkOrders" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="WorkOrderDetails.ascx" TagName="WorkOrderDetails" TagPrefix="uc1" %>
<%@ Register Src="WorkOrderPreventive.ascx" TagName="WorkOrderPreventive" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc16" %>
<%@ Register Src="WorkOrderMarkup.ascx" TagName="WorkOrderMarkup" TagPrefix="uc4" %>
<%@ Register Src="WorkOrderResources.ascx" TagName="WorkOrderResources" TagPrefix="uc7" %>
<%@ Register Src="WorkOrderOtherCost.ascx" TagName="WorkOrderOtherCost" TagPrefix="uc8" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc10" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc9" %>
<%@ Register Src="WorkOrderInstalled.ascx" TagName="WorkOrderInstalled" TagPrefix="uc12" %>
<%@ Register Src="WorkOrderServiced.ascx" TagName="WorkOrderServiced" TagPrefix="uc13" %>
<%@ Register Src="WorkOrderEstimates.ascx" TagName="WorkOrderEstimates" TagPrefix="uc14" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc15" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc17" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc18" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <style type="text/css">
        .divMsgContainer {
            position: relative;
        }

        span#ctl00_CPH1_txtApproximateDuration_wrapper {
            width: 100% !Important;
        }

        @media screen and (min-width:870px) and (max-width:1057px) {
            .LargeToolBar .HideOnMobileToolbar {
                display: none !important;
            }

            .LargeToolBar .ToolbarMobileMenu {
                display: inline-block !important;
            }

            .LargeToolBar .HideOnMobileToolbar.showOnIpad {
                display: table-cell !important;
            }

                .LargeToolBar .HideOnMobileToolbar.showOnIpad.Recent {
                    display: none !important;
                }

            .rail .LargeToolBar .HideOnMobileToolbar {
                display: none !important;
            }

            .rail .LargeToolBar .ToolbarMobileMenu {
                display: inline-block !important;
            }

            .rail .LargeToolBar .ToolbarTd.HideOnMobileToolbar {
                display: table-cell !important;
            }

            .rail .LargeToolBar .Recent {
                display: table-cell !important;
            }

            .LargeToolBar .MoreMenu .Recent {
                display: list-item !important;
            }

            .rail .LargeToolBar .MoreMenu .Recent {
                display: none !important;
            }
        }

        @media screen and (max-width:869px) {
            .ToolbarTd.HideOnMobileToolbar.showOnIpad {
                display: none !important;
            }
        }

    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript" src="JS/Estimates/Markup.js"></script>
        <script src="JS/Asset/WorkOrder.js" type="text/javascript"></script>


        <script type="text/javascript">

            var allowdropdownClose;

            function OpenWorkOrderBarCodePopup() {
                return OpenBarCodePopup('txtBarcode', 'htnBarcodeFormat', 'WORKORDER', '<%= PM.Asset.WorkOrderInfo.Id %>');
            }

            function OpenContactPOPUp(URL, Width, Height, AddClose) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(WindowContactClosed);
                return false;
            }

            function OpenPreviewConversionEstimates() {
                var RecordCurrencyId = '<%=PM.Asset.WorkOrderInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=WORKORDER&Id=" +
                                 '<%= PM.Asset.WorkOrderInfo.Id%>'
                          + "&LocationId=" + '<%=PM.Asset.WorkOrderInfo.PropertyId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function OpenPreviewConversionCosts() {
                var RecordCurrencyId = '<%=PM.Asset.WorkOrderInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=WORKORDERMATERIALS&Id=" +
                                     '<%= PM.Asset.WorkOrderInfo.Id%>'
                          + "&LocationId=" + '<%=PM.Asset.WorkOrderInfo.PropertyId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function OpenPreviewConversionResources() {
                var RecordCurrencyId = '<%=PM.Asset.WorkOrderInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=WORKORDERRESOURCES&Id=" +
                                         '<%= PM.Asset.WorkOrderInfo.Id%>'
                          + "&LocationId=" + '<%=PM.Asset.WorkOrderInfo.PropertyId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function OpenGooglepWorkOrderAddressesPicker() {
                var Id = '<%= PM.Asset.WorkOrderInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=WORKORDER&ObjectId=" + Id + "&PickerSender=RecordAddress", 920, 415, false);
                }
                return false;
            }

            function WindowContactClosed(Opener) {
                var updatePanel = $("[id$=RadAjaxPanel1]")[0];
                if (updatePanel) { __doPostBack(updatePanel.id) }

            }
            var currentTextBox = null;
            var currentDatePicker = null;
            function showPopup(sender, e) {

                currentTextBox = sender;
                var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
                currentDatePicker = datePicker;
                datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
                var position = datePicker.getElementPosition(sender);
                datePicker.showPopup(position.x, position.y + sender.offsetHeight);
            }

            function dateSelected(sender, args) {
                if (currentTextBox != null) {

                    currentTextBox.value = args.get_newValue();
                }
            }

            function TimeSelected(sender, args) {
                if (currentTextBox != null) {

                    currentTextBox.value = args.get_newValue();
                }
            }
            function showTimePopup(sender, e) {

                currentTextBox = sender;
                var datePicker = $find($("[id$=RadTimePicker1]")[0].id);
                currentDatePicker = datePicker;
                datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
                var position = datePicker.getElementPosition(sender);

                datePicker.showTimePopup(position.x, position.y + sender.offsetHeight);

            }


            function parseDate(sender, e) {
                if (currentDatePicker != null) {
                    var date = currentDatePicker.get_dateInput().parseDate(sender.value);
                    var dateInput = currentDatePicker.get_dateInput();

                    if (date == null) {
                        date = currentDatePicker.get_selectedDate();
                    }

                    var formattedDate = dateInput.get_dateFormatInfo().FormatDate(date, dateInput.get_displayDateFormat());
                    sender.value = formattedDate;
                }
            }
            function CalculateExtCost(sender, args) {
                var Quantity = $find($("[id$=txtQuantity]")[0].id);
                var UnitCost = $find($("[id$=txtUnitCost]")[0].id);
                var ExtCost = $find($("[id$=txtExtCost]")[0].id);
                ExtCost.set_value(Quantity.get_value() * UnitCost.get_value());
            }
            function AlertMessage(top, left, text, time) {

                var color = "#ffd79d";
                $("#divMsg").stop(true, true);
                $("#divMsg").css({ 'top': top + 'px', 'left': left + 'px', 'visibility': 'visible', 'background-color': color }).show();
                clearTimeout(t);
                var t = setTimeout("$('#divMsg').fadeOut(3000)", time);
                $("#MsgText").text(text);
            }
            function CreateLinkedWorkOrders_Click(ctrl) {
                var txtStatus = $("[id$=hdfStatus]");

                if (txtStatus.val() != 1) {
                    var a = ctrl.id
                    var pos = $("#" + ctrl.id).offset();
                    var width = $("#" + ctrl.id).width();
                    AlertMessage(pos.top, pos.left, Msg_ConfirmApprovedWorkOrder, 6000);
                    return false;
                }

                return true;
            }

            function CreateLinkedWorkOrders_Confirm(WorkOrderToCreate) {
                if (WorkOrderToCreate <= 0) {
                    var ctrl = $("[id$=lbtnCreateLinkedWorkOrders]");
                    var a = ctrl[0].id
                    var pos = $("#" + ctrl[0].id).offset();
                    var width = $("#" + ctrl[0].id).width();
                    AlertMessage(pos.top, pos.left, Msg_ConfirmChangeSettings, 6000);
                    return false;
                }
                var Msg = Msg_ConfirmPreventiveCreate.replace("[WorkOrderToCreate]", WorkOrderToCreate);

                var IsAccept = confirm(Msg);
                if (IsAccept) {
                    var btnCreateWorkOrder = $("[id$=btnCreate]");
                    btnCreateWorkOrder.click();
                }
                else
                    return false;
            }

            
            function OpenLinkAssetsPopup() {
                var Description = '<%= PM.Asset.WorkOrderInfo.Description%>';
                var Id = '<%=PM.Asset.WorkOrderInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkAssetsPopup.aspx?ObjectType=WORKORDER&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkAssetsPopup);
                return false;
            }

            function CloseLinkAssetsPopup() {
                var btnRefreshHeader = $("[id$=btnRefreshHeader]");
                if (btnRefreshHeader) {
                    btnRefreshHeader.click();
                }
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
                var HasReports = '<%= PM.Asset.WorkOrderInfo.HasReports%>';
                var Description = '<%= JSEscape(PM.Asset.WorkOrderInfo.Description)%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.WorkOrderInfo.RecordDescription)%>';
                var Id = '<%=PM.Asset.WorkOrderInfo.Id%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=WORKORDER&Id=" +
                                    '<%= PM.Asset.WorkOrderInfo.Id%>'
                            + "&RecordDescription=" + '<%=JSEscape(PM.Asset.WorkOrderInfo.RecordDescription)%>'
                            + "&EntityId=" + '<%=PM.Asset.WorkOrderInfo.PropertyId%>' + "&EntityType=1", 890, 430, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=WORKORDER&Id=" +
                               '<%= PM.Asset.WorkOrderInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.WorkOrderInfo.PropertyId%>' + "&EntityType=1", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'New':
                        window.location = "WorkOrders.aspx";
                        break;
                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function AdjustInstalledCalculation(gridId) {
                var grid = $("#" + gridId);

                $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    Calculate(row, "ExtCost");
                });

                $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    Calculate(row, "ExtCost");
                });

                $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    Calculate(row, "UnitPrice");
                });

            }
            function Calculate(row, toCalculate) {
                var txtQuantity = row.find("input[id$='txtQuantity']");
                var txtUnitCost = row.find("input[id$='txtUnitCost']");
                var txtExtCost = row.find("input[id$='txtExtCost']");

                var QantityVal = CDbl(txtQuantity.val());
                var UnitPriceVal = CDbl(txtUnitCost.val());
                var AmountVal = CDbl(txtExtCost.val());


                if (toCalculate == "ExtCost") {
                    txtExtCost.val(CCur(UnitPriceVal * QantityVal));
                }

                else if (toCalculate == "UnitPrice") {
                    if (QantityVal == 0) {
                        QantityVal = 1;
                        txtQuantity.val(FPrec(1));
                    }
                    txtUnitCost.val(CCur(AmountVal / QantityVal));
                }
            }
            function OpenInstalledItemPopup() {
                return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Installed&IsInstalled=1', 910, 580, true);
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
            function check(sender, ddl, resultId, ResultName) {
                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    if (ddl.indexOf('ddlServicePerformed') > 0) {
                        var Idresults = vlue.split(',');
                        var Activevlue = '';
                        for (i = 0; i < Idresults.length; i++) {
                            if (Idresults[i]) {
                                if (combo.findItemByValue(Idresults[i]))
                                    if (combo.findItemByValue(Idresults[i])._attributes._data.Inactive && combo.findItemByValue(Idresults[i])._attributes._data.Inactive == "False") {
                                        Activevlue = Activevlue + ',' + Idresults[i];
                                    }
                            }

                        }
                        vlue = Activevlue;
                    }
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
            function GetServicedPerformedValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }

            function OpenselectComponentPopup(ServicedId, LocationId, BuildingId, FloorId, SpaceId, EquipmentId) {
                var URL = 'SelectComponentPopup.aspx?ServicedId=' + ServicedId + '&LocationId=' + LocationId + '&BuildingId=' + BuildingId + '&FloorId=' + FloorId + '&SpaceId=' + SpaceId + '&EquipmentId=' + EquipmentId
                return OpenPOPUp(URL, 1000, 550, true, 'rdgServiced');
                //        var wnd = window.radopen('SelectComponentPopup.aspx?ServicedId=' + ServicedId + '&LocationId=' + LocationId + '&BuildingId=' + BuildingId + '&FloorId=' + FloorId + '&SpaceId=' + SpaceId + '&EquipmentId=' + EquipmentId);
                //        wnd.setSize(900, 550);
                //        return false;
            }

            function Item_DblClick(sender, args) {

                var btnEditSelected = $("a[id*=" + sender.ClientID + "][id$=btnEditSelected]")[0];
                var btnUpdateEdited = $("a[id*=" + sender.ClientID + "][id$=btnUpdateEdited]")[0];
                var btnEditSelectedComponent = $("a[id*=" + sender.ClientID + "][id$=btnEditSelectedComponent]")[0];
                var btnUpdateEditedComponent = $("a[id*=" + sender.ClientID + "][id$=btnUpdateEditedComponent]")[0];



                if ((btnEditSelected) || (btnUpdateEdited) || (btnEditSelectedComponent) || (btnUpdateEditedComponent)) {
                    var btn = document.getElementById("ctl00_CPH1_WorkOrderServiced1_btnEditModeOnDblClick");
                    btn.click();
                }
                return false;

            }

            function ddlPeriods_OnClientSelectedIndexChanged(sender, eventArgs) {

                var item = eventArgs.get_item();
                var itemId = item.get_parent()._clientStateFieldID;

                var year = item.get_attributes().getAttribute("BudgetYear")

                var RowContainer = $("#" + itemId).parents(".rgEditForm:first");
                if (!RowContainer || RowContainer.length == 0)
                    RowContainer = $("#" + itemId).parents("tr:first");
                var rntYear = $find(RowContainer.find("input[id*='rntYear']")[0].id);

                if (year.length > 0) {
                    rntYear.set_value(year);
                }
                else
                    rntYear.clear();
            }

            function AdjustCostCalculation(gridId, QuantityMultiplier) {
                var grid = $("#" + gridId);
                // On change quantity
                $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    var Quantity = $(this).val();
                    var UnitCost = row.find("input[id$='txtUnitCost']").val();
                    var txtTotalCost = row.find("input[id$='txtTotalCost']");
                    var lblExtentedQuantity = row.find("span[id$='lblExtentedQuantity']")
                    txtTotalCost.val(CCur(CPDbl(Quantity) * QuantityMultiplier * CDbl(UnitCost)));
                    lblExtentedQuantity.text(FPrec(CPDbl(Quantity) * QuantityMultiplier));
                });

                // On change unit cost
                $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
                    var row = $(this).parents(".rgEditForm:first");
                    if (!row || row.length == 0)
                        row = $(this).parents("tr:first");
                    var UnitCost = $(this).val();
                    var Quantity = row.find("input[id$='txtQuantity']").val();
                    var txtTotalCost = row.find("input[id$='txtTotalCost']");
                    txtTotalCost.val(CCur(CDbl(UnitCost) * QuantityMultiplier * CPDbl(Quantity)));
                });
            }
        </script>

    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
         <telerik:AjaxSetting AjaxControlID="mlpWorkOrders">
                <UpdatedControls>  
                    <telerik:AjaxUpdatedControl ControlID="mlpWorkOrders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpWorkOrders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="WorkOrdersSearch.aspx">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlWorkOrders" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" NoWrap="true"
                    CausesValidation="False" Height="300px"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" CausesValidation="true" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>


                           <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>



                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" PostBack="false" CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>


                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>

                                                <%--  <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>

                                                            <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>--%>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('WORKORDER');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#WorkOrders"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton CommandName="IsClosed" CssClass="SwitchButton">
                            <ItemTemplate>
                                <div>
                                    <asp:CheckBox runat="server" ID="chkClosed" ClientIDMode="Static" />
                                    <label for="chkClosed">
                                        <i class="icon"></i>
                                    </label>
                                </div>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                    </Items>
                </telerik:RadToolBar>
                <div style="display: inline-block">
                </div>

            </td>
            <td></td>
        </tr>
    </table>


    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" runat="server" MultiPageID="mlpWorkOrders" Skin="Default" CssClass="documentTabs"
        OnTabClick="tbsDocument_TabClick" ScrollChildren="true" ScrollButtonsPosition="Left" Width="100%" EnableViewState="True">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <%--<telerik:RadTab Text="Details" Value="Details" />--%>
            <telerik:RadTab Text="Preventive" Value="Preventive" />
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Estimate" Value="Estimate" />
            <telerik:RadTab Text="Resource Costs" Value="Resources" />
            <telerik:RadTab Text="Installed" Value="Installed" />
            <telerik:RadTab Text="Serviced" Value="Serviced" />
            <telerik:RadTab Text="Material Costs" Value="OtherCosts" />
            <telerik:RadTab Text="Cost Totals" Value="CostTotalsMarkups" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpWorkOrders" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">

            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" meta:resourceKey="lblLocation" runat="server" Text="Location*"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" NoWrap="true" Height="300px"
                                            CausesValidation="False" AutoPostBack="true"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:TextBox ID="txtProperty" ReadOnly="True" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvPropertiess"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfvPropertiess">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                                    </td>
                                    <td class="controlWidth" id="tblWorkOrderHeader">
                                        <telerik:RadComboBox ID="ddlProject" runat="server" AutoPostBack="true"
                                            Skin="Default" OnItemsRequested="ddl_ItemsRequested"
                                            NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblChangeEventNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" MaxLength="30" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" ValidationGroup="Save"
                                            runat="server" Display="Dynamic" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                        </asp:RequiredFieldValidator>
                                        <br />
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                            Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:resourceKey="lblDesc" runat="server" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="255" ID="txtDescription" TabIndex="1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" AllowCustomText="true"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                            NoWrap="true"
                                            CausesValidation="False" TabIndex="2">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategoy" runat="server" Filter="Contains" AllowCustomText="true"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                            NoWrap="true"
                                            CausesValidation="False" TabIndex="2">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="lblWBS" Text="<%$ Resources:ProjectManagement, Label_WBS %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" AutoPostBack="false"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                            NoWrap="True"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgress" meta:resourceKey="lblProgress" runat="server" Text="Progress"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgress" runat="server" Filter="Contains" AllowCustomText="True"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="true" CausesValidation="False" TabIndex="2">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblCurrency" runat="server" Text="Currency" meta:Resourcekey="hplCurrency" />
                                        </div>
                                        <div style="float: right">
                                            <asp:HyperLink runat="server" CssClass="SearchButton" ID="hplCurrency">
                                                                     <span class="Icon"></span>
                                            </asp:HyperLink>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" meta:resourceKey="lbl_StatusRevision" runat="server" Text="Status"></asp:Label></td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" width="100%" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Filter="Contains" Style="width: 182px !important"
                                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                        NoWrap="true"
                                                        CausesValidation="False" TabIndex="2">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblScope" meta:resourcekey="lblScope" Text="Scope"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtNotes" runat="server" MaxLength="4000" TextMode="MultiLine" Style="box-sizing: border-box"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="lblGoogleAddress" Text="Geolocation" meta:resourcekey="lblGoogleAddress" />
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" OnClientClick=" return OpenGooglepWorkOrderAddressesPicker();" ID="btnGoogleAddress" CssClass="SearchButton">
                                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgPMbarcode" CssClass="SearchButton"
                                                OnClientClick="return OpenWorkOrderBarCodePopup();">
                                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBarcode" runat="Server" MaxLength="255"></asp:TextBox>
                                        <%-- <img id="" src="Images/Asset/Barcode.jpg" style="vertical-align: middle; cursor: pointer" alt=""
                                                                                    onclick="return OpenBarCodePopup('txtBarcode','htnBarcodeFormat','WORKORDER','<%= PM.Asset.WorkOrderInfo.Id %>')" />--%>
                                        <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                        <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblLinkedAssets" meta:resourcekey="LblLinkedAssets" runat="server" Text="Linked Assets"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedAsset" OnClientClick="return OpenLinkAssetsPopup();">
                                                                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:button id="btnRefreshHeader" runat="server" class="Hide"></asp:button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtLinkedAsset" runat="Server" Width="100%" MaxLength="255" style="text-align: right;" Enabled="false" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controllWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 50%; text-align: center; color: #666; text-transform: uppercase;">
                                                    <asp:Label runat="server" ID="lblLabor" meta:resourcekey="lblLabor" Text="Labor"></asp:Label>
                                                </td>
                                                <td style="width: 50%; text-align: center; color: #666; text-transform: uppercase;">
                                                    <asp:Label runat="server" ID="lblEquipment" meta:resourcekey="lblEquipment" Text="Equipment"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblEstimatedHours" meta:resourcekey="lblEstimatedHours" Text="Estimated Hours"></asp:Label>
                                    </td>
                                    <td class="controllWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 50%;">
                                                    <asp:TextBox runat="server" ID="txtLaborEstHours" ReadOnly="true" CssClass="Double" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td style="padding-left: 8px; width: 50%;">
                                                    <asp:TextBox runat="server" ID="txtEquipmentEstHours" ReadOnly="true" CssClass="Double" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                            <asp:HyperLink runat="server" ID="hliDispatchedHours" CssClass="Link" Text="Dispatched Hours" meta:Resourcekey="hliDispatchedHours"></asp:HyperLink>
                                    </td>
                                    <td class="controllWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 50%;">
                                                    <asp:TextBox runat="server" ID="txtLaborDisHours" ReadOnly="true" CssClass="Double" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td style="padding-left: 8px; width: 50%;">
                                                    <asp:TextBox runat="server" ID="txtEquipmentDisHours" ReadOnly="true" CssClass="Double" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblActualHours" meta:resourcekey="lblActualHours" Text="Actual Hours"></asp:Label>
                                    </td>
                                    <td class="controllWidth">
                                        <table class="TableNoSpacingNoBorder" width="100%">
                                            <tr>
                                                <td style="width: 50%;">
                                                    <asp:TextBox runat="server" ID="txtLaborActHours" ReadOnly="true" CssClass="Double" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td style="padding-left: 8px; width: 50%;">
                                                    <asp:TextBox runat="server" ID="txtEquipmentActHours" ReadOnly="true" CssClass="Double" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubmitted" meta:resourceKey="lblSubmitted" runat="server" Text="Submitted By"></asp:Label>
                                    </td>
                                    <td class="controllWidth">
                                        <asp:TextBox runat="server" ID="txtSubmittedBy" ReadOnly="true" TabIndex="4" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                            <asp:HyperLink runat="server" ID="hliWorkRequest" CssClass="Link"  Text="Request ID" meta:Resourcekey="hliWorkRequest"></asp:HyperLink> 
                                    </td>
                                    <td class="controllWidth">
                                        <asp:TextBox runat="server" ID="txtRequestId"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                            <asp:HyperLink runat="server" ID="hliMaintContract" CssClass="Link"  Text="Maintenance Contract" meta:Resourcekey="hliMaintContract"></asp:HyperLink>
                                    </td>
                                    <td class="controllWidth">
                                        <telerik:RadComboBox ID="ddlMaintContracts" runat="server" Width="100%"
                                            Skin="Default" OnItemsRequested="ddl_ItemsRequested"
                                            NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPriority" meta:resourcekey="lblPriority" runat="server" Text="Priority"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPriority" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                            Style="font-size: 11px" NoWrap="true" TabIndex="5" Height="300px" AllowCustomText="True">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReported" meta:resourcekey="lblReported" runat="server" Text="Reported"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_calReportedDate" style="display: block">
                                            <telerik:RadDatePicker ID="calReportedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%#Date.Today %>' Skin="Default" TabIndex="6">
                                                <DateInput ID="DateInput1" ReadOnly="true"
                                                    Skin="Default" runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar1" Skin="Default" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label meta:resourcekey="lblEstimatedStart" ID="lblEstimatedStart" runat="server" Text="Estimated Start"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_calEstimatedStartDate" style="display: block">
                                            <telerik:RadDatePicker ID="calEstimatedStartDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%#Date.Today %>' Skin="Default"
                                                TabIndex="7">
                                                <DateInput ID="DateInput2" Skin="Default"
                                                    runat="server" Height="20px">
                                                </DateInput>
                                                <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                </Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEstimatedFinish" meta:resourcekey="lblFinish" runat="server" Text="Finish"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_calEstimatedFinishDate" style="display: block">
                                            <telerik:RadDatePicker ID="calEstimatedFinishDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%#Date.Today %>' Skin="Default"
                                                TabIndex="8">
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
                                        <asp:Label meta:resourcekey="lblApproximateDuration" ID="lblApproximateDuration"
                                            runat="server" Text="Approximate Duration"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="text-align: left;">
                                        <telerik:RadMaskedTextBox ID="txtApproximateDuration" CssClass="PositiveInteger" Width="100%" LabelWidth="100%"
                                            runat="server" DisplayMask="#### d\ays" Mask="#### d\ays" TabIndex="9" NumericRangeAlign="Left">
                                        </telerik:RadMaskedTextBox>
                                    </td>
                                </tr>
                            </table>
                            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Width="100%" EnableAJAX="false">
                                <fieldset runat="server" id="fldsetContactInfo">
                                    <legend>
                                        <asp:Label ID="lblContactInfo" class="legend" meta:resourcekey="lblContactInfo" runat="server" Text="Contact Info"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <div style="float: left">
                                                    <asp:Label runat="server" meta:resourcekey="lblContactName" ID="lblContactName" Text="Contact Name"></asp:Label>
                                                </div>
                                                <div style="float: right">
                                                    <asp:LinkButton runat="server" OnClientClick="return OpenContactPOPUp('ContactBrowser.aspx',500, 550,true);" ID="btnContact" CssClass="SearchButton">
                                                                                    <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtContactName" MaxLength="255" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" meta:resourcekey="lblContactPhone" ID="lblContactPhone" Text="Phone (Day) / Extension"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%">
                                                            <asp:TextBox ID="txtPhone" MaxLength="50" runat="server" />
                                                        </td>
                                                        <%--<td>
                                                                                            <asp:Label runat="server" ID="lblExt" meta:resourcekey="lblExt" Text="Ext." Style="margin-left: 2px" />
                                                                                        </td>--%>
                                                        <td style="padding-left: 8px; width: 50%;">
                                                            <asp:TextBox ID="txtExt" MaxLength="50" runat="server" TabIndex="3" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" meta:resourcekey="lblCell" ID="lblCell" Text="Cell"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtCell" MaxLength="50" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" meta:resourcekey="lblPhoneNight" ID="lblPhoneNight" Text="Phone (Night) / Extension"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" class="TableNoSpacingNoBorder">
                                                    <tr>
                                                        <td style="width: 50%">
                                                            <asp:TextBox ID="txtPhoneNight" MaxLength="50" runat="server" />
                                                        </td>
                                                        <%--<td>
                                                                                            <asp:Label runat="server" ID="lblExtNight" meta:resourcekey="lblExt" Text="Ext." Style="margin-left: 2px" />
                                                                                        </td>--%>
                                                        <td style="padding-left: 8px; width: 50%;">
                                                            <asp:TextBox ID="txtExtNight" MaxLength="50" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" meta:resourcekey="lblEmail" ID="lblEmail" Text="Email"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtEmail" MaxLength="255" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                                    CssClass="Validator" ErrorMessage="Not valid email" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="Save" Display="Dynamic" meta:resourcekey="revEmail">
                                                </asp:RegularExpressionValidator>
                                            </td>
                                        </tr>


                                        <tr>
                                            <td class="labelWidth">
                                                <%-- Default Budget Code--%>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox Visible="false" ID="ddlDefaultBudgetCode" runat="server"
                                                    Skin="Default" Style="font-size: 11px" NoWrap="true" TabIndex="10">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </telerik:RadAjaxPanel>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <uc18:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>

        </telerik:RadPageView>


        <%-- <telerik:RadPageView ID="pvDetails" runat="server">
                                    <uc1:WorkOrderDetails ID="WorkOrderDetails" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvPreventive" runat="server">
            <uc2:WorkOrderPreventive ID="Preventive" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc9:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvEstimate" Width="100%" runat="server">
            <uc14:WorkOrderEstimates ID="WorkOrderEstimates1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView Width="100%" ID="pvResources" runat="server">
            <uc7:WorkOrderResources ID="WorkOrderResources1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView Width="100%" ID="pvInstalled" runat="server">
            <uc12:WorkOrderInstalled ID="WorkOrderInstalled1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView Width="100%" ID="pvServiced" runat="server">
            <uc13:WorkOrderServiced ID="WorkOrderServiced1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvOtherCosts" Width="100%" runat="server">
            <uc8:WorkOrderOtherCost ID="WorkOrderOtherCost" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvCostTotalsMarkups" runat="server">
            <uc4:WorkOrderMarkup ID="WorkOrderMarkup1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc15:DocumentClauses ID="DocumentClauses" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc16:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc17:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc10:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>




</asp:Content>
