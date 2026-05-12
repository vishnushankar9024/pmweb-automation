<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Settings.aspx.vb" Inherits="Website.Settings" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="NotificationSetting.ascx" TagName="NotificationSetting" TagPrefix="uc1" %>
<%@ Register Src="RecordNumbers.ascx" TagName="RecordNumbers" TagPrefix="uc2" %>
<%@ Register Src="ManagerLayout.ascx" TagName="ManagerLayout" TagPrefix="uc3" %>
<%@ Register Src="RequiredFields.ascx" TagName="RequiredFields" TagPrefix="uc4" %>
<%@ Register Src="CheckListSetting.ascx" TagName="CheckListSetting" TagPrefix="uc5" %>
<%@ Register Src="ToolboxSettings.ascx" TagName="ToolboxSettings" TagPrefix="uc6" %>
<%@ Register Src="AuditTrailSettings.ascx" TagName="AuditTrailSettings" TagPrefix="uc7" %>
<%@ Register Src="ClauseSettings.ascx" TagName="ClauseSettings" TagPrefix="uc8" %>
<%@ Register Src="CostImpactSettings.ascx" TagName="CostImpactSettings" TagPrefix="uc9" %>
<%@ Register Src="AssetGeneralSettingsDetails.ascx" TagName="AssetGeneralSettings" TagPrefix="uc10" %>
<%@ Register Src="MySettings.ascx" TagName="MySettings" TagPrefix="uc11" %>
<%@ Register Src="DocumentTeamSettings.ascx" TagName="DocumentTeamSettings" TagPrefix="uc12" %>
<%@ Register Src="BIReporting.ascx" TagName="BIReporting" TagPrefix="uc13" %>
<%@ Register Src="GridsLayout.ascx" TagName="GridsLayout" TagPrefix="uc14" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script language="javascript" type="text/javascript" src="JS/Portfolio/ManagerLayout.js"></script>
    <script language="javascript" type="text/javascript" src="JS/Portfolio/GridsLayout.js"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            function ToggleAssetMenu() {
                var tdAssetMenu = $('[id$=tdAssetMenu]')[0];
                var tdAssetExplorerBar = $('[id$=tdAssetExplorerBar]')[0];
                var form = $('form')[0]
                var btnToggleAssetMenu = $('[id$=btnToggle]')[0];
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    tdAssetExplorerBar.style.left = "285px";
                    tdAssetExplorerBar.className = 'ReportManagerBar BiReportingExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'inline', 60);
                } else {
                    tdAssetMenu.style.display = 'none';
                    tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.className = 'ReportManagerBar BiReportingExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'none', 60);
                }
                return false;
            }
            function OnClientDropDownOpened() {
                var tree = $find($("[id$=rdvGroupsUsers]")[0].id);
                if (tree != null) {
                    var Node = tree.get_selectedNode();
                    if (Node != null) {
                        Node.scrollIntoView(false);
                    }
                }
            }

            function OnClientBITreeLoad(sender, args) {

                var tree = $find($("[id$=treeReports]")[0].id);
                if (tree != null) {
                    var Node = tree.get_selectedNode();
                    if (Node != null) {
                        Node.scrollIntoView(false);
                    }
                }
            }
            function RadwindowClosed(sender, args) {

                var tblparams = sender._navigateUrl.split('PopupId=')
                if (tblparams.length == 1) {
                    WindowCloseReport();
                    return;
                }
                var PopupId = tblparams[tblparams.length - 1];
                var mainWindow = window.document.getElementById('RadWindowWrapper_' + PopupId);
                mainWindow.className = mainWindow.className.replace(' Hide');
            }

            function OpenWidgetPopup(Source, Width, Height) {
                var wnd = window.radopen('WidgetPopup.aspx?Source=' + Source);
                wnd.setSize(Width, Height);
                wnd.add_close(RefreshControlGrid);
                wnd.Center();
                return false;
            }

            function OpenWidgetPopupForWebPage(Source, Id, Width, Height) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('WidgetPopup.aspx?Source=' + Source + '&Id=' + Id);
                if (browserWidth < 700) {
                    wnd.setSize(browserWidth - 10, Height);
                }
                else {
                    wnd.setSize(650, Height);
                }
                wnd.Center();
                wnd.add_close(WindowCloseReport);
                return false;
            }

            function OpenRegionsWeatherPopup(Width, Height) {
                var wnd = window.radopen('MySettingsRegionsWeatherPopup.aspx');
                wnd.setSize(Width, Height);
                wnd.add_close(RefreshControlGrid);
                wnd.Center();
                return false;
            }

            function OpenPDFUploadPopup(FileName, Id, Width, Height) {
                OpenSmallPOPUp('Home_AddPDFPopup.aspx?FileName=' + FileName + '&Id=' + Id + '&SOURCE=MySettings')
                return false;
            }

            function OpenProjectCenterPopup() {
                OpenSmallPOPUp('MySettings_ProjectCenterPopup.aspx', 500, 400, WindowCloseReport, null)
                return false;
            }

            function OpenControlsPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();

                WndConfigureCtrlTabs = window.radopen('MySettings_ControlsPopup.aspx');
                WndConfigureCtrlTabs.SetUrl('MySettings_ControlsPopup.aspx?PopupId=' + WndConfigureCtrlTabs.get_id());

                if (isMobileScreen()) {
                    WndConfigureCtrlTabs.setSize(browserWidth - 10, browserHeight);
                    WndConfigureCtrlTabs.moveTo(8, 0);
                }
                else {
                    var popupwidth = browserWidth * 0.3;
                    if (popupwidth < 450)
                        popupwidth = 450;
                    WndConfigureCtrlTabs.setSize(popupwidth, browserHeight * 0.9);
                    WndConfigureCtrlTabs.Center();
                }
                return false;
            }

            function pageLoad() {
                var divs = document.querySelectorAll('.divBox');
                var divBox = Array.prototype.slice.call(divs);
                divBox.forEach(function (curr) {
                    if (curr.innerHTML.trim() === "") {
                        curr.style.display = 'none';
                    }
                })

                if ($("[id$='flsProfile']").length == 1) {
                    $("[id$='tdProfile']").show();
                }
                else {
                    $("[id$='tdProfile']").hide();

                }
                CheckParentBox();
               
            }

            function AllCheckClicked(iObj) {
                var i = 0;
                var rdgRights = $("div[id$='rdgConfigureProjectCenter']");
                var j = 0;
                var k = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                            if (!this.checked)
                                j = j + 1;
                            if (this.checked)
                                k = k + 1;
                            this.checked = iObj.checked;
                        }

                    }
                    i++;
                });


                var Value = 0
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
            }

            function SelectParent(chk) {
                var rdgRights = $("div[id$='rdgConfigureProjectCenter']");
                if (rdgRights.find("input[type='checkbox']")[0] == null) return;
                var chkPArent = rdgRights.find("input[type='checkbox']")[0];

                var i = 0;
                var isChecked = true;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (chk.checked) {
                            if (!this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
                        }
                    }
                    i++;
                });

                var Value = 0;
                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;


                } else {
                    chkPArent.checked = isChecked;
                    Value = Value + 1;
                }

                return false;
            }

            function CheckParentBox() {
                var rdgRights = $("div[id$='rdgConfigureProjectCenter']");
                var ParentIsNotChecked = true;
                var i = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.checked) {
                            if (this.id.indexOf("chkSelect") > 0)
                                ParentIsNotChecked = false;
                        }
                    }
                    i++;
                });

                if (!ParentIsNotChecked) {
                    rdgRights.find("input[type='checkbox']")[0].checked = false;

                } else {
                    if (i > 0) {
                        rdgRights.find("input[type='checkbox']")[0].checked = true;
                    }
                }
            }

            var uploadsDocFileInProgress = 0;

            function onDocFileSelected(sender, args) {
                uploadsDocFileInProgress++;
            }

            function onDocFileUploaded(sender, args) {

                decrementUploadsDocFileInProgress();
                if (uploadsDocFileInProgress <= 0) {
                    var btnRefreshUserImage = $("[id$=btnRefreshUserImage]");
                    btnRefreshUserImage.click();
                    setTimeout(function () {
                        sender.deleteAllFileInputs();
                    }, 10);
                }
            }

            function onDocFileUploadFailed(sender, args) {
                decrementUploadsDocFileInProgress();
            }

            function decrementUploadsDocFileInProgress() {
                uploadsDocFileInProgress--;
            }

            function ClientDocFileValidationFailed(sender, args) {
                decrementUploadsDocFileInProgress();
                alert(WarningMsg_InvalidFile);
            }

            function OpenAddPMWebReport(Id) {
                var wnd = window.radopen('Home_AddPMWebReportLink.aspx?Source=MySettingsTabs&Id=' + Id);
                wnd.setSize(1040, 435);
                wnd.add_close(WindowCloseReport);
                wnd.Center();
                return false;
            }

            function OpenAddBIReporting(Id) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('Home_AddSQLReportLink.aspx?Source=MySettingsTabs&Id=' + Id);

                if (isMobileScreen()) {
                   wnd.setSize(browserWidth - 10, browserHeight)
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(WindowCloseReport);
                return false;
            }
            function WindowCloseReport() {
                var btnRefreshGrid = $("[id$=btnRefreshGrid]");
                btnRefreshGrid.click();

            }
            function RefreshControlGrid() {
                var btnRefreshGrid = $("[id$=btnRefreshControlGrid]");
                btnRefreshGrid.click();

            }

            function OpenGroupsUsersPopUp() {
                return OpenPOPUp('GroupsUsersPopup.aspx?Source=' + DocId, 800, 500, false);
            }

            function MoreMenuClickedMySettings(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Save") {
                    var SaveToolBar = $find('ctl00_CPH1_MySettings1_SaveToolBar');
                    var button = SaveToolBar.findItemByValue("Save");
                    button.click();
                }
                //if (args.get_item().get_commandName()) {
                if (args.get_item().get_value() == "DeploySettings") {
                    var btnDeploy = $("[id$=btnDeploySettings]");
                    btnDeploy.click();
                    //}
                }
                maintoolbarClick(args.get_item().get_value())
            }
            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Save") {
                    var SaveToolBar = $find('ctl00_CPH1_BIReporting1_SaveToolBar');
                    var button = SaveToolBar.findItemByValue("Save");
                    button.click();
                }

                if (args.get_item().get_value() == "DeploySettings") {
                    var SaveToolBar = $find('ctl00_CPH1_BIReporting1_SaveToolBar');
                    var button = SaveToolBar.findItemByValue("DeploySettings");
                    button.click();
                }
                if (args.get_item().get_value() == "ToggleFlyoutTree") {
                    var SaveToolBar = $find('ctl00_CPH1_BIReporting1_SaveToolBar');
                    var button = SaveToolBar.findItemByValue("ToggleFlyoutTree");
                    button.click();
                }

                if (args.get_item().get_value() == "DeploySettings") {
                    var btnDeploy = $find('ctl00_CPH1_BIReporting1_btnDeploy');
                    btnDeploy.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(value) {
                switch (value) {
                    case 'ViewGroups':
                        OpenPOPUp('GroupsUsersPopup.aspx?Source=GROUPS', 300, 350, false);
                        break;
                    case 'ViewUsers':
                        OpenPOPUp('GroupsUsersPopup.aspx?Source=USERS', 300, 350, false);
                        break;
                    case 'LoadDeployed':
                        __doPostBack('btnLoadSettings', 'LoadDeployed');
                        break;
                }
            }

            function OnClientDeployClick(arg) {
                if (arg == 'BIReporting') {
                    if (DisplayReportDeployMessage == 'False') {
                        $("[id$=btnDeploySettings]").click();
                    }
                    else {
                        OpenPOPUp('DeploySettingsPopup.aspx?SOURCE=BIReporting', 640, 160, false);
                    }
                }

                if (arg == 'MySettings') {
                    if (DisplayMySettingsDeployMessage == 'False') {
                        $("[id$=btnDeploySettings]").click();
                    }
                    else {
                        OpenSmallPOPUp('DeploySettingsPopup.aspx?SOURCE=MySettings', 640, 160, false);
                    }
                }

                return false;
            }
            window.onresize = function () {
                TabSelected();
                //PaddingRemove();
                //ChangeOrders();
            }

            function TabStyle(ID) {

                var windowSize = 0;
                ID === "ctl00_CPH1_ManagerLayout1_tbsDocumentManager" ? windowSize = "1146" : windowSize = "843";
                var tab = $find(ID);
                if (window.innerWidth <= windowSize) {
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
            function TabSelected() {
                var tabsDocuments = $find("<%=tbsDocument.ClientID%>");
                var value = tabsDocuments.get_selectedTab().get_value();
                if (value === "GeneralSettings") {
                    TabStyle("<%=tbsGeneralSettings.ClientID%>");
                }
                else if (value === "ShowHideTabs") {
                    TabStyle("<%=tbsShowHideTabs.ClientID%>");
                }
                else if (value === "ManagerPages") {
                    TabStyle("ctl00_CPH1_ManagerLayout1_tbsDocumentManager");
                }


        }

        window.onload = function () {
            //ChangeOrders();
            TabSelected();
            //PaddingRemove();

        }
        function lnkClick() {

            var btn = document.querySelector('.btn');
            btn.click();
            return false;
        }
        function ChangeOrder() {
            if (document.querySelector('.right') != null) {
                if (document.documentElement.clientWidth <= "964") {
                    document.querySelector('.right').style.order = "2";
                    document.querySelector('.middle').style.order = "3";
                }
                else {
                    document.querySelector('.right').style.order = "3";
                    document.querySelector('.middle').style.order = "2";
                }
            }
        }
        function ToolBarClicked(sender, args) {

            var command = args.get_item().get_commandName();
            var treeCol = document.querySelector('.col-4.FlyoutFieldTree');
            if (command === "ShowHideTree") {
                if (treeCol.classList.contains("Block")) {
                    treeCol.classList.remove("Block");
                    treeCol.classList.add("Hide");
                }
                else {
                    treeCol.classList.add("Block");
                    treeCol.classList.remove("Hide");
                }
            }
        }

        function OnClientCollapsed(sender, ags) {
            var tabsDocuments = $find("<%=tbsDocument.ClientID%>");
            var value = tabsDocuments.get_selectedTab().get_value();
            switch (value) {
                case "GridsLayout":
                    $("#ctl00_CPH1_GridsLayout1_Splitter").addClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('GridMenuStatus', 'none', 60);
                    break;
                case "ManagerPages":
                    $("#ctl00_CPH1_ManagerLayout1_Splitter").addClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('ManagerMenuStatus', 'none', 60);
                    break;
                case "RequiredFields":
                    $("#ctl00_CPH1_RequiredFields1_Splitter").addClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('RequiredFieldsMenuStatus', 'none', 60);
                    break;
                case "BIReporting":
                    $("#ctl00_CPH1_BIReporting1_Splitter").addClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('BIReportingMenuStatus', 'none', 60);
                    break;
            }
            //PaddingRemove();

        }
        function OnClientExpanded(sender, ags) {
            var tabsDocuments = $find("<%=tbsDocument.ClientID%>");
            var value = tabsDocuments.get_selectedTab().get_value();
            switch (value) {
                case "GridsLayout":
                    $("#ctl00_CPH1_GridsLayout1_Splitter").removeClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('GridMenuStatus', 'inline', 60);
                    break;
                case "ManagerPages":
                    $("#ctl00_CPH1_ManagerLayout1_Splitter").removeClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('ManagerMenuStatus', 'inline', 60);
                    break;
                case "RequiredFields":
                    $("#ctl00_CPH1_RequiredFields1_Splitter").removeClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('RequiredFieldsMenuStatus', 'inline', 60);
                    break;
                case "BIReporting":
                    $("#ctl00_CPH1_BIReporting1_Splitter").removeClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('BIReportingMenuStatus', 'inline', 60);
                    break;
            }
            //PaddingRemove();
        }

        function onClientResized(sender, ags) {
            var browserWidth = $telerik.$(window).width();
            if (browserWidth <= 843) {
                sender.set_width(browserWidth - 20);
                return;
            }
            $(document).scrollLeft(1);
            while ($(document).scrollLeft() != 0) {
                var NewWidth = sender.get_width() - 20
                sender.set_width(NewWidth);
                $(document).scrollLeft(1);
                if (NewWidth <= 100) break;
            }
        }
        var mainsplitter = null;
        function onResized(sender, ags) {
            ////var NewWidth = sender._panes[1].get_width() - 20;
            ////sender._panes[1].set_width(NewWidth);
            ////return false;
            mainsplitter = $find(sender._element.id);

        }
        function AssetSplitterResized(sender, ags) {

            setTimeout(FloatDivs, 100);
            //var splitter = sender.get_parent();
            //var pane1 = splitter._panes[0];
            //var pane2 = splitter._panes[1];
            //var pane2Td = pane2._element;
            //pane2Td.style.width = splitter.get_width() - pane1.get_width() - 10 + "px";


        }
        function ManagerSplitterResized(sender, args) {
            setTimeout(FloatDivs, 100);
            ClientResized(sender, args);
        }
        function ClientResized(sender, ags) {
            setTimeout(FloatDivs, 100);
            var splitter = sender.get_parent();
            var pane1 = splitter._panes[0];
            var pane2 = splitter._panes[1];
            var pane1Td = pane1._element;
            pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 8);
            pane1.set_width(pane1Td.clientWidth);
        }

        function fixSplitterSize(isRail) {
            if (mainsplitter == null) return;
            var tabsDocuments = $find("<%=tbsDocument.ClientID%>");
            var value = tabsDocuments.get_selectedTab().get_value();

            if (value === "GridsLayout" || value === "BIReporting" || value === "RequiredFields") {

                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0]._element.clientWidth - 80 - 1);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200 - 9);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
            }
            else if (value === "ManagerPages") {
                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                var col = document.querySelector('.col-1');
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80 - col.clientWidth - 18);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200 - col.clientWidth - 24);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
            }

        }
            
    function RadAsyncUploadclcik() {

        var imageuploader = $('.ruFileInput');
        imageuploader.click();
        return false;
    }

        </script> 
<style type="text/css">
        .SettingsMainTab{
            width:calc(100vw - 200px) !important;
        }
        .rail .SettingsMainTab{
            width:calc(100vw - 72px) !important;
        }
        .rtsLevel {
            width: 100% !important;
        }

        removeLeft {
            left: 0 !important;
        }

       
    @media screen and (max-width: 843px) and (min-width: 320px) {
    .SettingsMainTab{
            width:100% !important;
        }
    .rail .SettingsMainTab{
            width:100% !important;
        }
    }
        .AssetExplorerVerticalSplitter {
            width: 100% !important;
        }
    </style>
    </telerik:RadCodeBlock>
    
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" OnClientClose="RadwindowClosed"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgParameters">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgParameters" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgAssetParameters">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAssetParameters" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlEntities">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgParameters" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlEntities" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ddlAssetEntities">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAssetParameters" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlAssetEntities" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsGeneralSettings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpGeneralSettings" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsGeneralSettings" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsShowHideTabs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpShowHideTabs" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsShowHideTabs" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsGeneralSettings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divGrids" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style>
        .SettingsMainTab {
            padding-top: 8px;
            position: fixed;
            background-color: white;
            z-index: 999;
        }

        .SettingsDetailTab {
            padding-top: 8px;
            position: fixed;
            margin-top: 41px;
            background-color: white;
            z-index: 999;
        }

        @media screen and (max-width:843px) {
            .table {
                margin-top: 0;
            }

            #tableEntities {
                padding-top: 34px !important;
            }

            #ctl00_CPH1_tbsShowHideTabs {
                height: 32px !important;
            }

            /*#ctl00_CPH1_tbsShowHideTabs .rtsScroll {
                    left: 0 !important;
                    width: 100% !important;
                    height: 32px !important;
                }*/
        }

        /*#ctl00_CPH1_tbsGeneralSettings .rtsPrevArrow, #ctl00_CPH1_tbsGeneralSettings .rtsNextArrow, #ctl00_CPH1_tbsGeneralSettings .rtsPrevArrowDisabled, #ctl00_CPH1_tbsGeneralSettings .rtsNextArrowDisabled {
            display: none !important;
        }*/

        @media screen and (min-width:843px) {
            #ctl00_CPH1_tbsShowHideTabs .rtsScroll {
                left: 0 !important;
                width: 100% !important;
            }

            #ctl00_ctl00_CPH1_tbsGeneralSettingsPanel .rtsScroll {
                left: 0 !important;
                width: 100% !important;
            }
        }
    </style>

    <telerik:RadAjaxLoadingPanel ID="ldpPeriods" Style="margin: 0px; padding: 0px" Width="100%" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="table">
        <tr class="ToolBar">
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1" ScrollChildren="true" ScrollButtonsPosition="Left"
                    runat="server" MultiPageID="mlpList" Skin="Default" CausesValidation="False" CssClass="SettingsMainTab" Width="100%">
                    <Tabs>
                        <telerik:RadTab Value="GeneralSettings" Text="Standard" Selected="True" />

                        <telerik:RadTab Text="ShowHideTabs" Value="ShowHideTabs"></telerik:RadTab>
                        <%--          <telerik:RadTab Text="Advanced" Value="NotificationSettings"  ></telerik:RadTab>
                    <telerik:RadTab Text="Advanced" Value="CheckListSettings"  ></telerik:RadTab>
                    <telerik:RadTab Text="Advanced" Value="ClauseSettings"  ></telerik:RadTab>--%>
                        <telerik:RadTab Text="Advanced" Value="CostImpactSettings" Visible="false"></telerik:RadTab>
                        <telerik:RadTab Text="Advanced" Value="AuditTrailSettings"></telerik:RadTab>
                        <telerik:RadTab Value="RequiredFields" Text="Advanced"></telerik:RadTab>
                        <telerik:RadTab Text="Advanced" Value="RecordNumber"></telerik:RadTab>
                        <telerik:RadTab Text="My Settings" Value="MySettings"></telerik:RadTab>
                        <telerik:RadTab Text="Grids & Sub-grids" Value="GridsLayout"></telerik:RadTab>
                        <telerik:RadTab Value="ManagerPages" Text="Advanced"></telerik:RadTab>
                        <telerik:RadTab Value="ToolboxSettings" Text="Toolbox1 Settings"></telerik:RadTab>
                        <%--    <telerik:RadTab Text="Document Team Settings" Value="DocumentTeamSettings"  ></telerik:RadTab>--%>
                        <telerik:RadTab Text="BI Reporting1" Value="BIReporting"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
    </table>

    <div class="td">
        <telerik:RadMultiPage ID="mlpList" runat="server" Style="margin: 0px; padding: 0px;" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPagesWithoutToolbar">
            <telerik:RadPageView ID="pvDetails" runat="server" Selected="True">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-2" style="margin-top: 41px">
                            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsGeneralSettings"
                                runat="server" MultiPageID="mlpGeneralSettings" Skin="Default" ScrollButtonsPosition="left" ScrollChildren="true"
                                Width="100%" EnableViewState="True">
                                <Tabs>
                                    <telerik:RadTab Text="Projects" Value="Projects" />
                                    <telerik:RadTab Text="Locations" Value="Locations" />
                                </Tabs>
                            </telerik:RadTabStrip>
                        </div>
                        <div class="col-10" id="divGrids">
                            <telerik:RadMultiPage ID="mlpGeneralSettings" SelectedIndex="0" runat="server">
                                <telerik:RadPageView runat="server" ID="pvProjectGeneralSettings">
                                    <table width="100%" style="padding-top: 42px" id="tableEntities" cellpadding="0" cellspacing="0">
                                        <tr style="background-color: RGB(237,237,237); background-image: none;">
                                            <td>
                                                <table style="width: 100%; height: 50px" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 160px; padding-left: 10px"><b>
                                                            <asp:Label ID="lblTitle" meta:Resourcekey="lblTitle" runat="server" Text="Entities"></asp:Label></b>
                                                        </td>
                                                        <td style="width: 240px !important;">
                                                            <telerik:RadComboBox ID="ddlEntities" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                                                EmptyMessage="Select Entity..." Width="240px" AutoPostBack="True" AllowCustomText="true"
                                                                CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"
                                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:Resourcekey="ddlEntities"
                                                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 8px">
                                                <div class="PMHeader">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <telerik:RadGrid ID="rdgParameters" CssClass="rdgParameters" runat="server" AutoGenerateColumns="False" SetWidth="true" FitPageHeightOffset="1"
                                                                ShowStatusBar="True" Font-Size="8px" AllowPaging="true" ShowGroupPanel="true" AllowMultiRowEdit="False" PageSize="20" ShowFooter="true"
                                                                AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                                <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                                                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="false" TableLayout="Fixed" GroupLoadMode="Client">
                                                                    <%-- <GroupByExpressions  >
                                                            <telerik:GridGroupByExpression>
                                                                <SelectFields>
                                                                    <telerik:GridGroupByField FieldName="TranslatedGroup"  ></telerik:GridGroupByField>
                                                                </SelectFields>
                                                                <GroupByFields>
                                                                    <telerik:GridGroupByField FieldName="TranslatedGroup"  ></telerik:GridGroupByField>
                                                                </GroupByFields>
                                                            </telerik:GridGroupByExpression>
                                                        </GroupByExpressions>--%>
                                                                    <Columns>
                                                                        <telerik:GridTemplateColumn HeaderText="Setting" ItemStyle-HorizontalAlign="Left"
                                                                            UniqueName="TranslatedSetting" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                                                            <ItemTemplate>
                                                                                <%#Container.DataItem("TranslatedSetting")%>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Wrap="False" Width="400px"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Setting" ItemStyle-HorizontalAlign="Left" UniqueName="TranslatedGroup" HeaderStyle-Wrap="false"
                                                                            GroupByExpression="TranslatedGroup [GridColumn_TranslatedGroup] Group By TranslatedGroup ASC" Reorderable="false">
                                                                            <ItemTemplate>
                                                                                <%#Container.DataItem("TranslatedGroup")%>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn HeaderText="Value" ItemStyle-CssClass="NoWrap" ItemStyle-HorizontalAlign="Left" UniqueName="ParamName" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtString" MaxLength="1000" Width="100%" Visible="false" runat="server"></asp:TextBox>
                                                                                <asp:TextBox ID="txtInteger" MaxLength="1000" Width="100%" Visible="false" runat="server"></asp:TextBox>
                                                                                <asp:CheckBox ID="chkBoolean" Visible="false" runat="server" />
                                                                                <telerik:RadComboBox ID="ddlValues" Visible="false" runat="server" Width="120px"></telerik:RadComboBox>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Wrap="False" Width="250px"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="false"></ItemStyle>
                                                                        </telerik:GridTemplateColumn>
                                                                    </Columns>
                                                                    <CommandItemTemplate>
                                                                        <div style="padding: 2px">
                                                                            <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="False" CommandName="Update" CssClass="GridCmdUpdate">
                                                                                <span class="Icon"></span>
                                                                                <asp:Label ID="lblUpdate" Text="Save" runat="server"></asp:Label>
                                                                                &nbsp;&nbsp;
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </CommandItemTemplate>
                                                                </MasterTableView>
                                                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                                                                    <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                                                                </ClientSettings>
                                                                <FilterMenu></FilterMenu>
                                                                <GroupPanel Text="Group By"></GroupPanel>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" TabIndex="1" ID="pvAssetGeneralSettings">
                                    <uc10:AssetGeneralSettings ID="AssetGeneralSettings" runat="server" />
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </div>
                    </div>
                </div>





            </telerik:RadPageView>

            <telerik:RadPageView ID="pvShowHideTabs" runat="server">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-2" style="margin-top: 42px;">
                            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsShowHideTabs" ScrollChildren="true" ScrollButtonsPosition="Left"
                                runat="server" SelectedIndex="0" MultiPageID="mlpShowHideTabs" Skin="Default"
                                Width="100%" EnableViewState="True">
                                <Tabs>
                                    <telerik:RadTab Text="Notification" Value="NotificationSettings"></telerik:RadTab>
                                    <telerik:RadTab Text="CheckList" Value="CheckListSettings"></telerik:RadTab>
                                    <telerik:RadTab Text="Clause" Value="ClauseSettings"></telerik:RadTab>
                                    <telerik:RadTab Text="Document Team Settings" Value="CollaborateSettings"></telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </div>
                        <div class="col-10">
                            <telerik:RadMultiPage ID="mlpShowHideTabs" SelectedIndex="0" runat="server">
                                <telerik:RadPageView ID="PvSpec" runat="server">
                                    <uc1:NotificationSetting ID="NotificationSetting1" runat="server" />
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="RadPageView1" runat="server">
                                    <uc5:CheckListSetting ID="CheckListSetting1" runat="server" />
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="RadPageView3" runat="server">
                                    <uc8:ClauseSettings ID="ClauseSettings1" runat="server" />
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvDocumentTeam" runat="server">
                                    <uc12:DocumentTeamSettings ID="DocumentTeamSettings1" runat="server" />
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </div>
                    </div>
                </div>





            </telerik:RadPageView>


            <%--                <telerik:RadPageView ID="PvSpec" runat="server" >
                    <uc1:NotificationSetting ID="NotificationSetting1" runat="server" />
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView1" runat="server" >
                    <uc5:CheckListSetting ID="CheckListSetting1" runat="server" />
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView3" runat="server" >
                    <uc8:ClauseSettings ID="ClauseSettings1" runat="server" />
                </telerik:RadPageView>--%>
            <telerik:RadPageView ID="RadPageView4" runat="server" Visible="false">
                <uc9:CostImpactSettings ID="CostImpactSettings1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <uc7:AuditTrailSettings ID="AuditTrailSettings1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvRequiredFields" runat="server">
                <uc4:RequiredFields ID="RequiredFields1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvRecordNumber" runat="server">
                <uc2:RecordNumbers ID="RecordNumbers1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvMySettings" runat="server">
                <uc11:MySettings ID="MySettings1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvGridsLayout" runat="server">
                <uc14:GridsLayout ID="GridsLayout1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvManagerLayout" runat="server">
                <uc3:ManagerLayout ID="ManagerLayout1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvToolboxSettings" runat="server">
                <uc6:ToolboxSettings ID="ToolboxSettings1" runat="server" />
            </telerik:RadPageView>
            <%--                <telerik:RadPageView ID="pvDocumentTeam" runat="server" >
                    <uc12:DocumentTeamSettings ID="DocumentTeamSettings1" runat="server" />
                </telerik:RadPageView>--%>
            <telerik:RadPageView ID="pvBIReporting" runat="server">
                <uc13:BIReporting ID="BIReporting1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>

</asp:Content>

