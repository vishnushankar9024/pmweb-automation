<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Tasks.aspx.vb" Inherits="Website.Tasks" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="TaskDetails.ascx" TagName="TaskDetails" TagPrefix="uc1" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="~/LinkedSchedule.ascx" TagName="LinkedSchedule" TagPrefix="uc6" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc7" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc8" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc9" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <asp:PlaceHolder ID="phStyle" runat="server"></asp:PlaceHolder>
    <asp:PlaceHolder ID="phCalendars" runat="server"></asp:PlaceHolder>
    <script src="Utilities/TreeGrid/GridE.js" type="text/javascript"> </script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <style type="text/css">
            .GQMenuMain { position:absolute; left:0px; top:0px; z-index:7005 !important; }
            .labelChkWidth {
                width: 80% !important;
                height: 24px;
                line-height: 24px;
                background: #FFFFFF;
                color: #666666 !important;
                padding-bottom: 3px;
            }

            @media screen and (min-width:880px) and (max-width:1518px) {
                .ToolbarMobileMenu {
                    display: inline-block !important;
                    padding-left: 5px;
                }
            }

            @media screen and (min-width:1324px) and (max-width:1519px) {
                .HideOniPadToolbar {
                    display: none !important;
                }
            }

            .SettingsMainTab.RadTabStrip_Default .rtsLevel .rtsLink {
                line-height: 30px !important;
            }

            .VerticalTabs .rtsLevel.rtsLevel1 {
                width: 106px !important;
            }

            .VerticalTabs {
                background-color: RGB(237,237,237) !important;
                margin-left: -4px !important;
            }


                .VerticalTabs.RadTabStrip_Default .rtsLevel .rtsSelected .rtsOut {
                    color: RGB(249,170,51);
                }

                .VerticalTabs.RadTabStrip_Default .rtsLevel .rtsOut {
                    color: rgb(102,102,102);
                }

                .VerticalTabs.RadTabStripVertical .rtsLI {
                    color: #999;
                    height: 50px;
                }

                .VerticalTabs.RadTabStrip_Default.RadTabStripVertical .rtsLevel1 .rtsLink {
                    border: solid 1px #999;
                }

                .VerticalTabs.RadTabStrip_Default .rtsLevel .rtsLink {
                    line-height: 50px;
                }

                .VerticalTabs.RadTabStrip_Default .rtsLevel .rtsSelected .rtsOut {
                    border-bottom: none;
                }

                .VerticalTabs.RadTabStrip_Default.RadTabStripVertical .rtsLevel1 .rtsLink.rtsSelected {
                    background-color: white;
                    height: 50px;
                    border-right: none;
                }

            .RPTaskTabsTop td {
                vertical-align: top;
            }

            .PMHead .row .col-10 {
                display: inline-block;
                box-sizing: border-box;
                float: left;
                width: 90%;
            }

            .PMHead .row .col-2 {
                display: inline-block;
                box-sizing: border-box;
                vertical-align: top;
                float: left;
                width: 10%;
            }

            .rtsLevel {
                width: 100%;
            }

     

            @media screen and (min-width:320px) and (max-width:1350px) {
                .VerticalTabs {
                    margin-right: 4px !important;
                }

                .PMHead .row .col-10 {
                    max-width: 100%;
                    flex: 0 0 100%;
                    float: left;
                    width: 100%;
                }

                .col-8 {
                    width: 100% !important;
                }

                .PMHead .row .col-2 {
                    max-width: 100%;
                    flex: 0 0 100%;
                    float: left;
                    width: 100%;
                }

                .SpecificationPadding {
                    padding-left: 0px !important;
                }
            }

            .rmSlide .rmLevel1 {
                left: 0px !important;
            }

            .ToolbarMobileMenu .rmSlide {
                left: -131px !important;
            }

            .ShowHeaderButton .Icon {
                background-image: url(css/Images/ResponsiveIcons/16Enabled.png) !important;
                background-position: 192px 0px !important;
                display: inline-block !important;
                width: 16px !important;
                height: 16px !important;
                margin-right: 8px !important;
            }

            .HideHeaderButton .Icon {
                background-image: url(css/Images/ResponsiveIcons/16Enabled.png) !important;
                background-position: 176px 0px !important;
                display: inline-block !important;
                width: 16px !important;
                height: 16px !important;
                margin-right: 8px !important;
            }
        </style>
        <script type="text/javascript">

        var MainSaveClicked = false;
        delete Number.prototype._toFormattedString;
        delete Number.prototype.format;
        delete Number.prototype.localeFormat;

        function RefreshTasks() {
            __doPostBack("ddlTaskSheets", 'CopyTaskSheet');
        }

        function DisableValidator() {
            var validator = document.querySelector("#ctl00_CPH1_rfvProjects");
            ValidatorEnable(validator, false);
        }

        function OpenTaskSheetsPopUp() {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen('TaskSheetsLookup.aspx');
            if (isMobileScreen()) {             
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }  
            wnd.add_close(RefreshTasks);       
            return false;
        }

        function ProjectScheduleChecked() {
            var callBackFn = function (arg) {
                chkProjectSchedule.checked = arg;
            }
            if ((IsOtherTaskSheetsLinked == 1) && (chkProjectSchedule.checked == true)) {
                radconfirm(unescape(NotificationMessage), callBackFn, 600, 200, null, "", "42");
            }
        }
        function ConfirmUnlink() { return confirm(Msg_ConfirmUnlink); }

        function GetDefaultCalendar() {
            var ddlCalendars = $find("<%= ddlCalendars.ClientID %>");
            var value = ddlCalendars.get_value();
            if (parseInt(value) > 0) {
                return ddlCalendars.get_text();
            } else {
                return '';
            }
        }
          

        </script>


        <script language="javascript" type="text/javascript">
            var forceMoreMenuToClose = true;

            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Toggle") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("ToggleTaskTabs");
                    button.click();
                }
                if (args.get_item().get_value() == "Lock") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("LockSchedule");
                    button.click();
                }
                if (args.get_item().get_value() == "SaveAsBaseline") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("SaveAsBaseline");
                    button.click();
                }
                if (args.get_item().get_value() == "PctCompleteTimesheets") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("PctCompleteTimesheets");
                    button.click();
                } 
                if (args.get_item().get_value() == "LinkSchedule") {
                    OpenLinkedTasksPopUp();
                }
                //click_handler(args.get_item().get_value(), args)
                maintoolbarClick(args.get_item().get_value())
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

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function CycleDetected(argCycle) {
                // var UserRightCanEdit = 'UserRight.CanEdit%>';
                // var mainToolBar = $find(=mainToolBar.ClientID %>");
                //var button = mainToolBar.findItemByValue("Recalculate");
                if (argCycle == 1) {
                    //button.disable();
                    alert('Cycle(s) Detected!');
                }
                // else {
                // if (UserRightCanEdit == 'True') button.enable();
                //}

            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Scheduling.TaskSheetInfo.HasMergeTemplate %>';
                var HasReports = '<%= PM.Scheduling.TaskSheetInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Scheduling.TaskSheetInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Scheduling.TaskSheetInfo.Description)%>';
                var Id = '<%= PM.Scheduling.TaskSheetInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("TASKSHEET")%>';
                switch (Value) {

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=TASKSHEET&Id=" +
                               '<%= PM.Scheduling.TaskSheetInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Scheduling.TaskSheetInfo.ProjectId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TASKSHEET&Id=" +
                        '<%= PM.Scheduling.TaskSheetInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.Scheduling.TaskSheetInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TASKSHEET&Id=" +
                        '<%= PM.Scheduling.TaskSheetInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.Scheduling.TaskSheetInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=TASKSHEET&Id=" + Id
                        + "&EntityId=" + '<%=PM.Scheduling.TaskSheetInfo.ProjectId%>' + "&EntityType=0",
                'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=TASKSHEET&Id=" +
                            '<%= PM.Scheduling.TaskSheetInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Scheduling.TaskSheetInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;


                    case 'New':
                        window.location = "Tasks.aspx";
                        break;
                    case 'CopyFromSchedule':
                        OpenTaskSheetsPopUp();
                        break;
                    case 'Save':
                        MainSaveClicked = true;
                        if (TaskSheetId > 0 && CanEditDetails == 'True' && Grids != null && Grids.length == 1) {
                            Grids[0].Save();
                        } else {
                            var btnSaveTaskSheet = $("[id$=btnSaveTaskSheet]");
                            btnSaveTaskSheet.click();
                        }
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('TASKSHEET');
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function pageLoad() {
                if ($("[id$='tblTaskHeader']").length == 0) return;
                if (IsExpanded == 'True') {
                    $("[id$='tblTaskHeaderimg']")[0].src = 'Images/Workflow/wMinus.png';
                    var ShowHeaderButton = $(".ShowHeaderButton");
                    ShowHeaderButton.removeClass("ShowHeaderButton").addClass("HideHeaderButton");
                    $("[id$='tblTaskHeader']").show();
                }
                if (IsExpanded == 'False') {
                    $("[id$='tblTaskHeaderimg']")[0].src = 'Images/Workflow/wPlus.png';
                    var ShowHeaderButton = $(".HideHeaderButton");
                    ShowHeaderButton.removeClass("HideHeaderButton").addClass("ShowHeaderButton");
                    $("[id$='tblTaskHeader']").hide();
                }
                var urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get("Id") == null) {
                    var ShowHeaderButton = $(".ShowHeaderButton");
                    $("[id$='tblTaskHeaderimg']")[0].src = 'Images/Workflow/wMinus.png';
                    ShowHeaderButton.removeClass("ShowHeaderButton").addClass("HideHeaderButton");
                    document.querySelector("#ctl00_CPH1_tblTaskHeader").style.display = 'block';
                }
            }

            function ToggleTaskHeaderSection(sender) {
                if (sender.src.indexOf("Plus") > 0) {
                    IsExpanded = 'True';
                    sender.src = 'Images/Workflow/wMinus.png';
                    var ShowHeaderButton = $(".ShowHeaderButton");
                    ShowHeaderButton.removeClass("ShowHeaderButton").addClass("HideHeaderButton");
                    $("[id$='tblTaskHeader']").show(50, function () {
                        this.style.display = '';
                        FloatDivs(false, true);
                        $.ajax({
                            type: "POST",
                            url: "AjaxService.aspx/ToggleTaskHeaderSection",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ blnVisible: true }),
                            dataType: "json",
                            async: true
                        });
                    });
                } else {
                    IsExpanded = 'False';
                    sender.src = 'Images/Workflow/wPlus.png';
                    var ShowHeaderButton = $(".HideHeaderButton");
                    ShowHeaderButton.removeClass("HideHeaderButton").addClass("ShowHeaderButton");
                    $("[id$='tblTaskHeader']").hide(50, function () {
                        $.ajax({
                            type: "POST",
                            url: "AjaxService.aspx/ToggleTaskHeaderSection",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ blnVisible: false }),
                            dataType: "json",
                            async: true
                        });
                    });
                }
                return false;
            }

            function HideHeaderCheckedChanged(sender) {
                //if (!(sender.checked)) {
                //    IsExpanded = 'True';
                //    $("[id$='tblTaskHeader']").show(50, function () {
                //        this.style.display = '';
                //        $.ajax({
                //            type: "POST",
                //            url: "AjaxService.aspx/ToggleTaskHeaderSection",
                //            contentType: "application/json; charset=utf-8",
                //            data: "{'blnVisible':" + true + "}",
                //            dataType: "json",
                //            async: true
                //        });
                //    });
                //} else {
                //    IsExpanded = 'False';
                //    $("[id$='tblTaskHeader']").hide(50, function () {
                //        $.ajax({
                //            type: "POST",
                //            url: "AjaxService.aspx/ToggleTaskHeaderSection",
                //            contentType: "application/json; charset=utf-8",
                //            data: "{'blnVisible':" + false + "}",
                //            dataType: "json",
                //            async: true
                //        });
                //    });
                //}
                //return false;
            }
            window.onresize = function () {
                TabStyle();
                //ChangeOrder();
            }

            function TabStyle() {
                var tab = $find("ctl00_CPH1_TaskDetails1_tbsDocumentDetails");
                if (tab != null) {
                    if (window.innerWidth <= "1350") {
                        tab.removeCssClass("RadTabStripVertical");
                        tab.removeCssClass("tbsSpecPC");
                        tab.removeCssClass("tbsFolderManagerSpecs");
                        tab.removeCssClass("tbsDocSpec");
                        tab.removeCssClass("SettingsDetailTab");
                        tab.removeCssClass("RadTabStripLeft");
                        tab.removeCssClass("RadTabStripLeft_Default");
                        tab.addCssClass("RadTabStopTop");
                        tab.addCssClass("RadTabStrip");
                        tab.addCssClass("RadTabStrip_Default");
                        tab.addCssClass("RadTabStripTop_Default");
                        tab.addCssClass("RadTabStripTop");
                        tab.addCssClass("SettingsMainTab");
                        window.resizeTo(document.documentElement.clientWidth - 1, document.documentElement.clientHeight);
                    }
                    else {
                        tab.removeCssClass("SettingsDetailTab");
                        tab.removeCssClass("SettingsMainTab");
                        tab.removeCssClass("RadTabStripTop_Default");
                        tab.removeCssClass("RadTabStrip");
                        tab.removeCssClass("RadTabStopTop");
                        tab.addCssClass("tbsSpecPC");
                        tab.addCssClass("tbsFolderManagerSpecs");
                        tab.addCssClass("tbsDocSpec");
                        tab.addCssClass("RadTabStripLeft");
                        tab.addCssClass("RadTabStripLeft_Default");
                        tab.addCssClass("RadTabStrip_Default");
                        tab.addCssClass("RadTabStripVertical");

                    }
                }
                var divs = document.querySelectorAll('.divBox');
                var divBox = Array.prototype.slice.call(divs);
                divBox.forEach(function (curr) {
                    if (curr.innerHTML.trim() === "") {
                        curr.style.display = 'none';
                    }
                })
                return false;
            }

            window.onload = function () {
                TabStyle();
                debugger;
                document.addEventListener("click", function (event) {
                    if (!event.target.classList.contains("arrow") && !event.target.classList.contains("js_searchFolders") && !(event.target.classList.contains("DocumentMoreResultsBox") || $(event.target).parents('.DocumentMoreResultsBox').length > 0)) {
                        var div = document.querySelector(".FoldersParentDiv");
                        div.style.display = "none";
                    }
                    const Segments = document.querySelectorAll('.BreadCrumbSegment');
                    if (Segments[0] != undefined && (event.target.id === Segments[0].id || event.target.id === Segments[1].id || event.target.id === Segments[2].id || event.target.id === $("[id$=lnkBtnRecords]")[0].id || event.target.id === $("[id$=btnPortfolio]")[0].id)) {
                        OpenBreadCrumbSegment(event);

                    } else if (!ClickOutside(event)) {
                        CloseSegment();
                    }
                });
                document.querySelector(".ModulesDiv").addEventListener('scroll', function (event) {
                    var SegmentElement = event.target;
                    if (SegmentElement.scrollTop + SegmentElement.clientHeight >= SegmentElement.scrollHeight - 8)
                        if (event.target.classList.contains("RecordsDiv")) {
                            if ($("[id$=txtsearchRecords]")[0] !== undefined) {
                                if ($("[id$=txtsearchRecords]")[0].value == '') {
                                    DocumentLoadMoreRecords();
                                }
                            }

                        } else {
                            DocumentLoadMoreRecordTypes();
                        }
                });
            }
            function ClickOutside(event) {
                var element = event.target;
                var found = false;
                if (event.target.parentElement == null && !event.target.parentElement == undefined) {
                    found = false;
                }

                while (element) {
                    if (element.classList != null && element.classList != undefined && element.classList.length > 0 && (element.classList[0].indexOf('ModulesParentDiv') >= 0 || element.classList[0].indexOf('ModulesTabletd') >= 0 || element.classList[0].indexOf('flyoutPopup') >= 0 || element.classList[0].indexOf('rcbSlide') >= 0 || element.classList[0].indexOf('BreadCrumb-custom-dropdown') >= 0 || element.classList[0].indexOf('BreadCrumb-custom-Arrow')) >= 0) {
                        found = true;
                        break;
                    }
                    element = element.parentElement;
                }
                return found;
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

        </script>
    </telerik:RadCodeBlock>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar LargeToolBar">
        <tr>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Save.png" SecurityButtonType="Edit" ValidationGroup="Save" PostBack="false" CommandName="Save" CausesValidation="true" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" PostBack="false"
                                    CommandName="CopyFromSchedule" SecurityButtonType="Add" Value="Copy From Schedule" Text="Copy From Schedule">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/DeleteDoc.png" SecurityButtonType="Delete" CausesValidation="false"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/LinkSchedule.png" ToolTip="Link Schedule" Value="Link" CommandName="LinkSchedule" SecurityButtonType="Edit" PostBack="false" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="PctCompleteTimesheets" Value="PctCompleteTimesheets" ImageUrl="Images/ToolBar/PctCompleteTimesheets.png" ToolTip="Update %C From Timesheets" Visible="true" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="SaveAsBaseline" Value="SaveAsBaseline" ImageUrl="Images/ToolBar/Check.png" ToolTip="Save As Baseline" Visible="true" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="True" CommandName="LockSchedule" Value="LockSchedule" CausesValidation="false" EnableImageSprite="true" Visible="true" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton PostBack="True" CommandName="ToggleTaskTabs" Value="ToggleTaskTabs" CausesValidation="false" EnableImageSprite="true" Visible="true" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#Tasks" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CommandName="Notification" CausesValidation="false" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
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
                                                <telerik:RadMenuItem Text="Toggle Task Tabs" Value="Toggle"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Lock Schedule" Value="Lock"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Save As Baseline" Value="SaveAsBaseline"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Update %C From Timesheets" Value="PctCompleteTimesheets"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Link " Value="LinkSchedule"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('TASKSHEET');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('TASKSHEET');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>

    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr id="trTaskDetails" runat="server" valign="top">
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
                    runat="server" MultiPageID="mlpTaskSheet" Skin="Default" Width="100%" EnableViewState="true" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
                    CausesValidation="False">
                    <Tabs>
                        <telerik:RadTab Text="Header" Value="Header" Selected="True" />
                        <telerik:RadTab runat="server" Text="Linked Schedule" Value="LinkedSchedule" />
                        <telerik:RadTab runat="server" Text="Notes" Value="Notes" />
                        <telerik:RadTab Text="Attachments" Value="Attachments" />
                        <telerik:RadTab Text="Workflow" Value="Workflow" />
                        <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
                        <telerik:RadTab Text="Notification" Value="NotificationLog" />
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
        <tr valign="top">
            <td>
                <telerik:RadMultiPage ID="mlpTaskSheet" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
                    RenderSelectedPageOnly="true">
                    <telerik:RadPageView ID="pvHeader" runat="server">
                        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="False">


                            <div class="PMMainPage">
                                <div class="row" style="padding-top: 4px; padding-bottom: 4px;">
                                    <div class="col-4">
                                        <asp:LinkButton CssClass="ShowHeaderButton" src="Images/Workflow/wMinus.png" runat="server" ID="tblTaskHeaderimg" OnClientClick="return ToggleTaskHeaderSection(this);">
                                             <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            <div class="PMMainPage" style="padding-bottom: 24px;" id="tblTaskHeader" runat="server">
                                <div class="row JustifyContent R3Cols" style="padding-top: 0px;">
                                    <div class="col-4 col-4-left">
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project*"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlProjects" runat="server"
                                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px" Height="390px" UseProjectFilter="1"
                                                        CausesValidation="false" EnableLoadOnDemand="true" NoWrap="true"
                                                        AllowCustomText="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                                        CssClass="Validator" InitialValue="" meta:resourcekey="cmpProjectsRequired" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                                        ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" meta:resourcekey="cmpProjectsRequired">
                                                    </asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label></td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" Text="2009 Schedule"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlType" runat="server" Skin="Default" Style="font-size: 11px"
                                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" AllowCustomText="true" Filter="Contains">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                                        Skin="Default" Style="font-size: 11px">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                                        CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory"
                                                        ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblStatus" meta:resourcekey="lblStatusRevision" runat="server" Text="Status/Revision"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                                        <tr>
                                                            <td style="width: 182px; padding-right: 8px">
                                                                <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px"
                                                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                            <td style="width: 50px">
                                                                <asp:TextBox ID="txtRevision" CssClass="PositiveInteger" runat="server" MaxLength="9"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevision"
                                                                    runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                                    ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblCalendar" meta:resourcekey="lblCalendar"
                                                        runat="server" Text="Calendar"></asp:Label></td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlCalendars" runat="server"
                                                        Skin="Default" DropDownWidth="400px" CausesValidation="false"
                                                        NoWrap="true" Height="300px" AutoPostBack="true"
                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                                        EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelChkWidth">
                                                    <asp:Label ID="lblProjectSchedule" runat="server" meta:ResourceKey="chkSetAsProjectSchedule" Text="Set As Project Schedule"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:CheckBox ID="chkProjectSchedule" runat="server" onClick="ProjectScheduleChecked();" CssClass="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelChkWidth">
                                                    <asp:Label ID="lblAllowPctCompleteUpdateActual" runat="server" meta:ResourceKey="chkAllowPctCompleteUpdateActual" Text="Link % Complete to Actual Costs"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:CheckBox ID="chkAllowPctCompleteUpdateActual" runat="server" CssClass="mobile-switch" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelChkWidth">
                                                    <asp:Label ID="lblAllowPctCompleteUpdateRemDuration" runat="server" meta:ResourceKey="chkAllowPctCompleteUpdateRemDuration" Text="Link % Complete to Remaining Duration"></asp:Label>
                                                </td>
                                                <td style="text-align: right;">
                                                    <asp:CheckBox ID="chkAllowPctCompleteUpdateRemDuration" runat="server" CssClass="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblScheduleTasks" runat="server" Text="Schedule Tasks" meta:resourcekey="lblScheduleTasks"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlScheduleTasks" Width="100%" runat="server"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblStatusDate" meta:resourcekey="lblStatusDate"
                                                        runat="server" Text="Status Date"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <span runat="server" id="rmd_rdpStatusDate" style="display: block">
                                                        <telerik:RadDatePicker ID="rdpStatusDate" runat="server" MinDate="1901-01-01"
                                                            MaxDate="2100-01-01" Skin="Default" Style="display: inline" EnableTyping="true">
                                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server" Width="100%"></DateInput>
                                                            <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-4 col-4-middle">
                                        <uc8:AssetRotator id="PMrot" runat="server" />
                                        <fieldset runat="server" id="fldsetRecap">
                                            <legend>
                                                <asp:Label ID="lblRecap" meta:resourcekey="lblRecap" runat="server" Text="Schedule Recap"></asp:Label>
                                            </legend>
                                            <table class="colTable">
                                                <tr>
                                                    <td class="labelWidth" style="width: 120px !important;"></td>
                                                    <td class="controlWidth">
                                                        <table width="100%" cellpadding="0" cellspacing="0" style="text-align: center; color: #666666;">
                                                            <tr>
                                                                <td style="width: 33%; padding-left: 5px;" class="NoWrap">
                                                                    <asp:Label ID="lblEarly" meta:resourcekey="lblEarly" runat="server" Text="Early"></asp:Label>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;" class="NoWrap">
                                                                    <asp:Label ID="lblLate" meta:resourcekey="lblLate" runat="server" Text="Late"></asp:Label>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;" class="NoWrap">
                                                                    <asp:Label ID="lblActual" meta:resourcekey="lblActual" runat="server" Text="Actual"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth" style="width: 120px !important;">
                                                        <asp:Label ID="lblScheduleStartDate" meta:resourcekey="lblScheduleStartDate" runat="server" Text="Start"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleEarlyStartDate" runat="server" Style="text-align: right;"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleLateStartDate" runat="server" Style="text-align: right;"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleActualStartDate" runat="server" Style="text-align: right;"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth" style="width: 120px !important;">
                                                        <asp:Label ID="lblScheduleFinishDate" meta:resourcekey="lblScheduleFinishDate" runat="server" Text="Finish"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleEarlyFinishDate" runat="server" Style="text-align: right;"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleLateFinishDate" runat="server" Style="text-align: right;"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleActualFinishDate" runat="server" Style="text-align: right;"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth" style="width: 120px !important;">
                                                        <asp:Label ID="lblScheduleDuration" meta:resourcekey="lblScheduleDuration" runat="server" Text="Duration"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleEarlyDuration" MaxLength="200" runat="server" CssClass="Double"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleLateDuration" MaxLength="200" runat="server" CssClass="Double"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 33%; padding-left: 5px;">
                                                                    <asp:TextBox ID="txtScheduleActualDuration" MaxLength="200" runat="server" CssClass="Double"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>

                                            </table>
                                        </fieldset>
                                    </div>
                                    <div class="col-4 col-4-right">
                                        <uc9:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </telerik:RadAjaxPanel>
                        <uc1:TaskDetails ID="TaskDetails1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvLinkedSchedule" runat="server" Visible="False">
                        <uc6:LinkedSchedule ID="LinkedSchedule" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
                        <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                        <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
                        <uc3:WorkflowDocument ID="WorkflowDocument" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                        <uc7:DocumentTeam ID="DocumentTeam1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotificationLog" runat="server">
                        <uc2:NotificationLog ID="NotificationLog1" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
        <asp:HiddenField runat="server" ID="hdnTaskrecordId" Value="0"></asp:HiddenField>
    </table>
    <script type="text/javascript">
        /*****************   Controls **************************/
        var chkProjectSchedule = document.getElementById("ctl00_CPH1_chkProjectSchedule");
    </script>
    <asp:Button runat="server" ID="btnSaveTaskSheet" ValidationGroup="Save" CssClass="Hide" />
</asp:Content>
