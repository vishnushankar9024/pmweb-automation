<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Home.aspx.vb" Inherits="Website.Home" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Home_Weather.ascx" TagName="Home_Weather" TagPrefix="uc1" %>
<%@ Register Src="Home_CurrenciesRates.ascx" TagName="Home_CurrenciesRates" TagPrefix="uc2" %>
<%@ Register Src="Home_WorkflowInbox.ascx" TagName="Home_WorkflowInbox" TagPrefix="uc3" %>
<%@ Register Src="Home_DocumentTeamInbox.ascx" TagName="Home_DocumentTeamInbox" TagPrefix="uc10" %>
<%@ Register Src="Home_Calendar.ascx" TagName="Home_Calendar" TagPrefix="uc4" %>
<%@ Register Src="Home_SQLReport.ascx" TagName="Home_SQLReport" TagPrefix="uc5" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<%@ Register Src="NotificationInbox.ascx" TagName="NotificationInbox" TagPrefix="uc6" %>
<%@ Register Src="HomeDashboard.ascx" TagName="HomeDashboard" TagPrefix="uc7" %>
<%@ Register Src="Home_PortfolioOverView.ascx" TagName="Home_PortfolioOverView" TagPrefix="uc8" %>
<%@ Register Src="ViewEvents.ascx" TagName="ViewEvents" TagPrefix="uc9" %>
<%@ Register Src="Home_ProjectCenterDetails.ascx" TagName="ProjectCenterDetails" TagPrefix="uc11" %>
<%@ Register Src="UserProfile.ascx" TagName="UserProfile" TagPrefix="uc12" %> 
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="Server">
         
        <script language="javascript" type="text/javascript">
            var projectCenterSelected = '<%=  pvProjectCenter.Selected.ToString.ToLower%>';
            $(document).ready(function () {
                var backgroundimage = '<%= PM.HomeInfo.BackgroundImage %>';
                var showImage = '<%= PM.HomeInfo.ShowBackgroundImage %>';
                var pvWidget = '<%= pvWidget.ClientID%>';

                var webPageFrame = '<%= WebPageFrame.ClientID%>';
                if (pvWidget) {
                    var divPvWidget = $('#' + pvWidget)
                    if (showImage == "True") {
                        divPvWidget.css('background-image', 'url(backgroundimages/' + backgroundimage + ')');
                        divPvWidget.css('background-attachment', 'fixed');
                        divPvWidget.css('background-repeat', 'no-repeat');
                        divPvWidget.css('background-size', '100% 100%');
                        divPvWidget.css('max-height:', '100%');
                        divPvWidget.css('background-image', 'url(backgroundimages/' + backgroundimage + ')');
                    }
                    else
                        $('#' + pvWidget).css('background-image', 'none');

                }


                 
                $('#' + webPageFrame).load(function () {
                    $(this).contents().find("head")
                        .append($("<style type='text/css'> .ToolBar.MsgTemplateToolbarHomePage{top: 33px !important;} .ToolBar.SecurityHomePageToolbar{top: 31px !important;} .SecurityMainTab .rtsLevel.rtsLevel1{width: 100% !important} .GroupsToolbarOnHomePage{margin-top:2px !important} .RadTabStrip.SecurityMainTab,.RadTabStrip.documentTabWithoutToolbar {top: 0 !important; padding-top: 0 !important;}  .ToolBar.ToolboxSettingsHomePage{top: 41px !important} .ToolBar.ManagerLayoutToolbarForHomePage{top: 41px !important} .MultiPageForHomePage {padding-top:50px !important} .HomePageManagerLayoutMargin{margin-top:35px !important}.SettingsMainTab .rtsLevel.rtsLevel1 {width: calc(100vw - 17px) !important;}.RadTabStrip.SettingsMainTab{width:100vw !important} .ToolBar.documentSubToolbar{margin-top:38px !important;top: 0 !important;} .RadTabStrip.EmailSetupTabs,.RadTabStrip.SettingsMainTab {top:0 !important} .AssetExplorerVerticalSplitter .documentTabs{top:0 !important} .MobileFixedMenu div{display:none !important} .RadTabStrip.WorkflowTabsOnMobile{top:0 !Important} .TopToolbarWorkflowCss{margin-top:0px !important;} .divContentHolder{padding-top:0px !important;} .ToolBar{top:0px; margin-top:0px;} .RadTabStrip{top:50px !important;left:0px !important;} .WhiteDarkBlueBack ,.bottomtoolbar,.MobileFixedMenu, .MenuContainer {display:none !important;} .divContentHolder{margin-top:0;} .ContentPane{width:100% !important;} @media screen and (min-width: 844px){.ToolbarPositionOnMobile {left: unset !important; top:0 !important}} @media screen and (max-width: 843px) and (min-width: 320px){.GroupsToolbarOnHomePage{margin-top:33px !important}}</style>"));
                    var FixedElementsHeight = $(".toolbartop:visible").height() + $(".bottomtoolbar:visible").height() + $(".MobileFixedMenu:visible").height();
                    $(".ToolBar:visible").each(function (index) {
                        if ($(this).css('Position') == 'fixed')
                            FixedElementsHeight += (this.offsetHeight > 5) ? 45 : 0;
                    });
                    $(".RadTabStrip.HomeTabTabs:visible").each(function (index) {
                        FixedElementsHeight += (this.offsetHeight > 5) ? 45 : 0;
                    });
                    $(this).css('height', document.documentElement.clientHeight - FixedElementsHeight - 15);
                });

                $(window).resize(function () {
                    var FixedElementsHeight = $(".toolbartop:visible").height() + $(".bottomtoolbar:visible").height() + $(".MobileFixedMenu:visible").height();
                    $(".ToolBar:visible").each(function (index) {
                        if ($(this).css('Position') == 'fixed')
                            FixedElementsHeight += (this.offsetHeight > 5) ? 45 : 0;
                    });
                    $(".RadTabStrip.HomeTabTabs:visible").each(function (index) {
                        FixedElementsHeight += (this.offsetHeight > 5) ? 45 : 0;
                    });
                    $('#' + webPageFrame).css('height', document.documentElement.clientHeight - FixedElementsHeight - 15);
                })

            })


            function OpenPopup(myLink, windowName) {
                var href;
                var left = (screen.width - 600) / 2;
                var top = (screen.height - 400) / 2;

                if (typeof (myLink) == 'string')
                    href = myLink;
                else
                    href = myLink.href;
                //alert(myLink);
                window.open(href, windowName, 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=700,height=400,top=' + top + ',left=' + left);
                return false;
            }

            var MobileScreenWidth = 1024;


            function isMobileScreen() {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= MobileScreenWidth)
                    return true;
                return false;
            }

            function GotoEventCenterFromHome() {
                window.location = "EventCenter.aspx";
                return false
            }
            function GotoMySettingsFromHome() {
                window.location = "UserProfile.aspx";
                return false

            }
            function RedirectParentToPage(url) {
                window.location = url;
                return false;
            }

            var Rtime;
            var RTimeout = false;
            var RDelta = 100;

            $(document).ready(function () {
                resizeProjectCenter()
                $(window).resize(function () {
                    Rtime = new Date();
                    if (RTimeout == false) {
                        RTimeout = true;
                        setTimeout(WindowResizeEnd, RDelta);
                    }
                });
            });
            function WindowResizeEnd() {
                if (new Date() - Rtime < RDelta) {
                    setTimeout(WindowResizeEnd, RDelta);
                } else {
                    RTimeout = false;
                    resizeProjectCenter()

                }
            }

            function resizeProjectCenter() {
                if (projectCenterSelected == 'true') {
                    var browserWidth = $telerik.$(window).width();
                    if (browserWidth < 1440)
                        ShowRail();
                }

            }
            function fixSplitterSize() {
                if ($find('ctl00_CPH1_RadScheduler1'))
                        $find('ctl00_CPH1_RadScheduler1').repaint();
            }
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .WhiteDarkBlueBack.Top.toolbartop {
            display: none !important;
        }

        .divContentHolderHome {
            margin-top: 0 !important;
        }


        div.RadScheduler .rsAptContent, div.RadScheduler .rsAptIn, div.RadScheduler .rsAptMid, div.RadScheduler .rsAptOut {
            background: none;
            margin: 0;
            padding: 0;
            right: auto;
            bottom: auto;
        }

        div.RadScheduler .rsAptOut {
            padding-bottom: 0px;
        }

        div.RadScheduler .rsAptMid {
            border: 1px solid gray;
            padding-bottom: 0px;
        }


        div.RadScheduler .rsWrap {
            z-index: auto !important;
        }

        div#ctl00_CPH1_RadScheduler1formElement {
            top: 10px !important;
        }
        /*.Widget .rdContent
        {
            border: 1px solid #316888  !important;
        }*/

        .RadDock .rdTable {
            border: 2px solid #316888 !important;
        }

        .RadDock .rdBottom .rdLeft, .RadDock .rdBottom .rdCenter, .RadDock .rdBottom .rdRight {
            height: 0px !important;
        }

        .RadMultiPage .rmpView .ProjectCenterIframe {
            height: calc(100vh - 80px) !important;
        }

        .rdkInbox .rdCollapse {
            margin-top: 3px;
        }

        .rdkInbox .rdClose {
            margin-top: 3px;
        }

        .rdkInbox .rdExpand {
            margin-top: 3px;
        }

        .rdkInbox.RadDock.rdCollapsed {
            margin-bottom: 16px;
        }

        .RadDock .rdTop .rdLeft, .RadDock .rdTop .rdRight {
            Width: 0px !important;
        }

        @media screen and (min-width:320px) and (max-width:843px) {

            .RadMultiPage .rmpView .ProjectCenterIframe {
                height: calc(100vh - 40px) !important;
            }

            .divMenuPages {
                top: 0 !important;
            }
        }

        .HomeTabTabs.RadTabStrip .rtsNextArrow, .HomeTabTabs.RadTabStrip .rtsNextArrowDisabled {
            top: 10px !important;
            left: 28px !important;
        }

        .HomeTabTabs.RadTabStrip .rtsPrevArrow, .HomeTabTabs.RadTabStrip .rtsPrevArrowDisabled {
            top: 10px !important;
            left: 10px !important;
        }

        .divMenuPages {
            top: 51px;
        }


        .RadScheduler .rsAdvancedEdit .rsAdvOptionsScroll {
            overflow-x: auto !important;
        }

        .RadScheduler .rsAdvancedModal {
            max-width: calc(100vw - 35px);
            z-index: 10001 !important;
        }
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            function rowDropping(sender, eventArgs) {
                // Fired when the user drops a grid row
                var htmlElement = eventArgs.get_destinationHtmlElement();
                var scheduler = $find('<%= RadScheduler1.ClientID %>');

                if (isPartOfSchedulerAppointmentArea(htmlElement)) {
                    // The row was dropped over the scheduler appointment area
                    // Find the exact time slot and save its unique index in the hidden field
                    var timeSlot = scheduler._activeModel.getTimeSlotFromDomElement(htmlElement);

                    document.getElementById("<%= TargetSlotHiddenField.ClientID %>").value = timeSlot.get_index();

                    // The HTML needs to be set in order for the postback to execute normally
                    eventArgs.set_destinationHtmlElement("TargetSlotHiddenField");
                }
                else {
                    // The node was dropped elsewhere on the document
                    eventArgs.set_cancel(true);
                }
            }

            function isPartOfSchedulerAppointmentArea(htmlElement) {
                // Determines if an html element is part of the scheduler appointment area
                // This can be either the rsContent or the rsAllDay div (in day and week view)
                return $telerik.$(htmlElement).parents().is("div.rsAllDay") ||
                            $telerik.$(htmlElement).parents().is("div.rsContent")
            }

            function RedirectToDocument(sender, eventArgs) {
                var appointment = eventArgs.get_appointment();

                var ObjectTypeId = appointment.get_attributes()._data.ObjectTypeId;
                var ObjectId = appointment.get_attributes()._data.ObjectId;
                if (ObjectTypeId > 0 || ObjectId > 0) {
                    appointment.set_allowEdit(false)
                    $("input[id$=ObjectTypeId]").val(ObjectTypeId);
                    $("input[id$=ObjectId]").val(ObjectId);
                    $("input[id$=btnRedirectToDoc]").click();
                }
            }

            function BackToTopLevel(sender, eventArgs) {

                var btnHiddenButton = $("[id$=btnBack]");
                var hfEnableBackButton = $("[id$=hfEnableBackButton]");
                if (hfEnableBackButton.length == 0) { return; }
                if (hfEnableBackButton.val() == "1") {
                    $(window.document).find("[id$=hfEnableBackButton]").val(0);
                    btnHiddenButton.click();
                }

            }

            function appointmentContextMenu(sender, eventArgs) {
                selectedAppointment = eventArgs.get_appointment();
                if (selectedAppointment != null) {
                    var ObjectTypeId = selectedAppointment.get_attributes()._data.ObjectTypeId;
                    var ObjectId = selectedAppointment.get_attributes()._data.ObjectId;
                    if (ObjectTypeId > 0 || ObjectId > 0) {
                        eventArgs.get_domEvent().preventDefault();
                    }
                }
            }

            function UpdateDockSettings(sender, args) {
                var rdkNYTimesNews = $find('<%= rdkNYTimesNews.ClientID %>');
                var rdkLinks = $find('<%= rdkLinks.ClientID %>');
                var rdkWeather = $find('<%= rdkWeather.ClientID %>');
                var rdkW = $find('<%= rdkW.ClientID %>');
                var rdkCalendar = $find('<%= rdkCalendar.ClientID %>');
                var rdkNotification = $find('<%= rdkNotification.ClientID %>');
                var rdkDT = $find('<%= rdkDT.ClientID %>');
                var userid = '<%= PM.UserInfo.UserId %>';
                if (args && args.command) {
                    if (args.command.get_name() == 'Close') {
                        var rdkNewsVisible = false;
                        var rdkLinksVisible = false;
                        var rdkWeatherVisible = false;
                        var rdkInboxVisible = false;
                        var rdkCalendarVisible = false;
                        var rdkNotificationVisible = false;
                        var rdkDocumentTeamVisible = false;

                        if (rdkNYTimesNews)
                            rdkNewsVisible += rdkNYTimesNews.get_visible()
                        if (rdkLinks)
                            rdkLinksVisible += rdkLinks.get_visible()
                        if (rdkWeather)
                            rdkWeatherVisible += rdkWeather.get_visible()
                        if (rdkW)
                            rdkInboxVisible += rdkW.get_visible()
                        if (rdkCalendar)
                            rdkCalendarVisible += rdkCalendar.get_visible();
                        if (rdkNotification)
                            rdkNotificationVisible += rdkNotification.get_visible();
                        if (rdkDT)
                            rdkDocumentTeamVisible += rdkDT.get_visible();
                        PageMethods.UpdateHomeControlsVisibility(Boolean(rdkNewsVisible), Boolean(rdkLinksVisible), Boolean(rdkWeatherVisible), Boolean(rdkInboxVisible), Boolean(rdkCalendarVisible), Boolean(rdkNotificationVisible), Boolean(rdkDocumentTeamVisible))
                        return false;
                    }
                }

                var cookievalue = '';
                if (rdkNYTimesNews)
                    cookievalue += rdkNYTimesNews.get_id() + '#' + rdkNYTimesNews.get_index() + '#' + rdkNYTimesNews.get_collapsed() + '#' + rdkNYTimesNews.get_dockZoneID() + '$'
                if (rdkLinks)
                    cookievalue += rdkLinks.get_id() + '#' + rdkLinks.get_index() + '#' + rdkLinks.get_collapsed() + '#' + rdkLinks.get_dockZoneID() + '$'
                if (rdkWeather)
                    cookievalue += rdkWeather.get_id() + '#' + rdkWeather.get_index() + '#' + rdkWeather.get_collapsed() + '#' + rdkWeather.get_dockZoneID() + '$'
                if (rdkW)
                    cookievalue += rdkW.get_id() + '#' + rdkW.get_index() + '#' + rdkW.get_collapsed() + '#' + rdkW.get_dockZoneID() + '$'
                if (rdkCalendar)
                    cookievalue += rdkCalendar.get_id() + '#' + rdkCalendar.get_index() + '#' + rdkCalendar.get_collapsed() + '#' + rdkCalendar.get_dockZoneID() + '$'
                if (rdkNotification)
                    cookievalue += rdkNotification.get_id() + '#' + rdkNotification.get_index() + '#' + rdkNotification.get_collapsed() + '#' + rdkNotification.get_dockZoneID() + '$'
                if (rdkDT)
                    cookievalue += rdkDT.get_id() + '#' + rdkDT.get_index() + '#' + rdkDT.get_collapsed() + '#' + rdkDT.get_dockZoneID()

                setCookie('HomeDocks_' + userid, cookievalue, 365)
            }

            /////////////////////////////////////////////////////////////////////////////Project Center///////////////////////////////////////////////////////////////////////////
            function getCookie(c_name) {
                var i, x, y, ARRcookies = document.cookie.split(";");
                for (i = 0; i < ARRcookies.length; i++) {
                    x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
                    y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
                    x = x.replace(/^\s+|\s+$/g, "");
                    if (x == c_name) {
                        return unescape(y);
                    }
                }
            }

            function ToggleNavigatorSection(sender, section) {
                if (sender.src.indexOf("Plus") > 0) {
                    sender.src = 'Images/Workflow/wMinus.png';
                    $("[id$='" + section + "']").show(400, function () { SaveHiddenModules(); });
                } else {
                    sender.src = 'Images/Workflow/wPlus.png';
                    $("[id$='" + section + "']").hide(400, function () { SaveHiddenModules(); });
                }

                //setCookie("PMwebProjectCenterNavigator", CollapsedNodes, 60);
                return false;
            }

            function SaveHiddenModules() {
                var CollapsedModules = "";
                $('.moduleToggle').each(function () {
                    if (!$(this).is(":visible")) {
                        CollapsedModules += $(this).attr("moduleid") + ";";
                    }

                });
                setCookie("PMWebProjectCenterNavigator", CollapsedModules, 60);

            }


            function RedirectPage(str) {
                window.top.location.href = str
            }

            function ViewReport() {
                var Id = '<%= PM.ProjectInfo.Id%>';
                var HasReports = '<%= PM.ProjectInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.ProjectInfo.ProjectNumber & " - " & PM.ProjectInfo.ProjectName)%>';
                if (HasReports == 'True') {
                    var left = (screen.width - 890) / 2;
                    var top = (screen.height - 430) / 2;
                    window.open("ReportsPreviewPopup.aspx?ObjectType=PROJECT&Id=" + Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0&EntityType=0",
                                    'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                }
                return false;
            }
            //    function RedirectToSearchDocument(str) {
            //        window.top.location.href = str.substring(2)
            //        //.substr(str.indexOf("~/"))
            //        return false;
            //    }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                switch (Value) {
                    case 'NewFromTemplate':
                        OpenProjectTemplate();
                        break;
                    case 'PrintProject':
                        return ViewReport();
                        break;
                    default:
                        break;
                }
            }


            function ResizeSpectabsInProjectCenter() {
                if ($(".ProjectCenterSepcs").length == 0 || $("[id$=rdgSpecifications]").length == 0 || $('#ProjectCenterDetails_pnlCustomFields').hasClass('Hide')) return;

                $(".tbshorizantaltabs > .rtsLevel").css("cssText", "width: " + $("[id$=rdgSpecifications]")[0].offsetWidth + 'px !important;');
                $(".tbshorizantaltabs").css("cssText", "width: " + $("[id$=rdgSpecifications]")[0].offsetWidth + 'px !important;');
                if ($("[id$=tbsSpecshorizantal]").length > 0) {
                    var tbsSpecshorizantal = $find($("[id$=tbsSpecshorizantal]")[0].id);
                    if (tbsSpecshorizantal != null) tbsSpecshorizantal._resize();
                }
            }
            var CenterRtime;
            var CenterRTimeout = false;
            var CenterRDelta = 100;

            function CenterWindowResizeEnd() {
                if (new Date() - CenterRtime < CenterRDelta) {
                    setTimeout(CenterWindowResizeEnd, CenterRDelta);
                } else {
                    CenterRTimeout = false;
                    ResizeSpectabsInProjectCenter();
                }
            }

            function pageLoad() {
                ResizeSpectabsInProjectCenter()
            }
            $(window).load(function () {

                $('#fader img:not(:first)').hide();
                //$('#fader img').css('position', 'absolute');
                //$('#fader img').css('top', '-16px');
                //$('#fader img').css('left', '50%');
                //$('#fader img').each(function () {
                //    var img = $(this);
                //    $('<img>').attr('src', $(this).attr('src')).load(function () {
                //        img.css('margin-left', -this.width / 2 + 'px');
                //    });
                //});
                var pause = false;

                function fadeNext() {
                    $('#fader img').first().hide().fadeOut().appendTo($('#fader'));
                    $('#fader img').first().fadeIn();
                }

                function fadePrev() {
                    $('#fader img').first().hide().fadeOut();
                    $('#fader img').last().prependTo($('#fader')).fadeIn();
                }

                $('#next').click(function () {
                    fadeNext();
                    clearInterval(rotate);
                });

                $('#prev').click(function () {
                    fadePrev();
                    clearInterval(rotate);
                });

                $('#fader, .button').hover(function () {
                    pause = true;
                }, function () {
                    pause = false;
                });

                function doRotate() {
                    if (!pause) {
                        fadeNext();
                    }
                }
                if ($("[id$=hdnImgCount]").length > 0) {
                    if ($("[id$=hdnImgCount]")[0].value > 1) {
                        var rotate = setInterval(doRotate, 5000);
                    }
                }
                //            var distance = 190,
                //            frames = 38,
                //            current_frame = 0,
                //            time = 400,
                //            step = 5,
                //            $element = $("#ProjectCenterStats_pnlTarget"),
                //            $pnlProjected = $("#ProjectCenterStats_pnlProjected"),
                //            currentProjectedFrames = 0,
                //            pnlTarget_Timer,
                //            pnlProjected_Timer;

                //            pnlTarget_Timer = setInterval(function () {
                //                if (current_frame < frames) {
                //                    var width = parseInt($element.css('width').replace('px', ''), 10);
                //                    $element.css('width', (width + step) + 'px');
                //                } else {
                //                    clearInterval(pnlTarget_Timer)
                //                }
                //                current_frame++;
                //            }, Math.floor(time / frames))

                //            pnlProjected_Timer = setInterval(function () {
                //                if (currentProjectedFrames < frames) {
                //                    var width = parseInt($pnlProjected.css('width').replace('px', ''), 10);
                //                    $pnlProjected.css('width', (width + step) + 'px');
                //                } else {
                //                    clearInterval(pnlTarget_Timer)
                //                }
                //                currentProjectedFrames++;
                //            }, Math.floor(time / frames))

                if ($('#divBudgetBar').length > 0) {
                    var perc = '<%=PM.ProjectInfo.pnlTargetBudgetWidth%>'
                        var background = 'linear-gradient(to right, #fc9107 ' + perc + '%, #999999 ' + perc + '%,  #999999 100%)'
                        $('#divBudgetBar').css('background', background);
                    }

                if ($('#divScheduleBar').length > 0) {
                    var perc = '<%=PM.ProjectInfo.pnlProjectedWidth%>'
                    var background = 'linear-gradient(to right, #4ba64f ' + perc + '%, #999999 ' + perc + '%,  #999999 100%)'
                    $('#divScheduleBar').css('background', background);
                }

                if ($('#divDocumentBar').length > 0) {
                    var perc = '<%=PM.ProjectInfo.pnlDocumentWidth%>'
                    var background = 'linear-gradient(to right, #478baf ' + perc + '%, #999999 ' + perc + '%,  #999999 100%)'
                    $('#divDocumentBar').css('background', background);
                }
            });

            function RedirectUrl(Url) {
                window.parent.location.href = Url;
            }

            $(document).ready(function () {
                $(window).resize(function () {
                    CenterRtime = new Date();
                    if (CenterRTimeout == false) {
                        CenterRTimeout = true;
                        setTimeout(CenterWindowResizeEnd, RDelta);
                    }
                });
                var values = getCookie('PMWebProjectCenterNavigator');
                if (values == null) { return; }
                if (values == ";" || values == "") { return; }
                var tblModules = values.split(";");
                for (var i = 0; i < tblModules.length; i++) {
                    if (tblModules[i] != "") {
                        $('.moduleToggle').each(function () {
                            if ($(this).attr("moduleid") == tblModules[i]) {
                                $(this).hide();
                                $(this).prev().find('img')[0].src = 'Images/Workflow/wPlus.png';
                            }

                        });
                    }
                }
            });

            function ResponsenavigatorEnd() {
                var values = getCookie('PMWebProjectCenterNavigator');
                if (values == null) { return; }
                if (values == ";" || values == "") { return; }
                var tblModules = values.split(";");
                for (var i = 0; i < tblModules.length; i++) {
                    if (tblModules[i] != "") {
                        $('.moduleToggle').each(function () {
                            if ($(this).attr("moduleid") == tblModules[i]) {
                                $(this).hide();
                                $(this).prev().find('img')[0].src = 'Images/Workflow/wPlus.png';
                            }

                        });
                    }
                }
            }
            function OpenProjectTemplate() {
                return OpenPOPUp("ProjectCenterTempate.aspx", 454, 500)
            }

            //function ToggleMobileMenu() {
            //    var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
            //    if (FlyoutMenu.classList.contains("Hide") == false) {
            //        HideFlyoutMobileMenu(FlyoutMenu)
            //        return false;
            //    }
            //    panel = $('.MobileMenuItems');
            //    if (panel[0].className.indexOf('closeanimation') > 0 || panel[0].className.indexOf('hiddenMobileMenuItems') > 0) {
            //        panel[0].className = panel[0].className.replace(' hiddenMobileMenuItems', '').replace(' closeanimation', '') + ' openanimation';
            //        $('.MobileFixedMenu')[0].className = $('.MobileFixedMenu')[0].className + ' open'
            //        document.getElementsByClassName('imgMobileLogo')[0].src = "CSS/Images/ResponsiveIcons/LeftArrow.png";
            //        document.getElementsByClassName('imgMobileLogo')[0].style['width'] = '25px'
            //        document.getElementsByClassName('imgMobileLogo')[0].style['padding-top'] = '12px'
            //        document.getElementsByClassName('imgMobileLogo')[0].style['margin-left'] = '13px'
            //        document.getElementsByClassName('imgMobileLogo')[0].style['margin-right'] = '5px'
            //        return false;
            //    }
            //    panel[0].className = panel[0].className.replace(' hiddenMobileMenuItems', '').replace(' openanimation', '') + ' closeanimation';
            //    $('.MobileFixedMenu')[0].className = $('.MobileFixedMenu')[0].className.replace(' open', '')
            //    document.getElementsByClassName('imgMobileLogo')[0].src = "CSS/Images/Wlogo.png";
            //    document.getElementsByClassName('imgMobileLogo')[0].style['width'] = '35px'
            //    document.getElementsByClassName('imgMobileLogo')[0].style['padding-top'] = '7px'
            //    document.getElementsByClassName('imgMobileLogo')[0].style['margin-left'] = '8px'
            //    document.getElementsByClassName('imgMobileLogo')[0].style['margin-right'] = '0px'
            //    return false;
            //}

        </script>

    </telerik:RadCodeBlock>
    <%--<table style="width: 100%; padding: 0px;padding-bottom: 3px;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <td class="Padding7" style="padding:4px;">
                <div style="float:left; padding:2px;width:100%;">
                    <asp:Label ID="lblWelcome" meta:resourceKey="lblWelcome" runat="server" Text="Welcome back"></asp:Label>&nbsp;
                    <%= PM.UserInfo.FirstName %>&nbsp;<%=PM.UserInfo.LastName%><asp:Label ID="lblLastLogin"
                        meta:resourceKey="lblLastLogin" runat="server" Text="your last login"></asp:Label>&nbsp;<%= FormatDate(PM.UserInfo.LastLoginDate) + " " + FormatTime(PM.UserInfo.LastLoginDate)%>
                </div>
            </td>
        </tr>
    </table>--%>
    <table style="width: 100%; table-layout: fixed" cellpadding="0" cellspacing="0">
        <tr>
            <td class="NoWrap">
                <table style="width: 100%;" cellpadding="0" cellspacing="0" class="HomeTabTabsMobile">
                    <tr>

                        <td class="color1" style="height: 51px;">
                            <div>
                                <asp:Image ID="imgLogo" runat="server" CssClass="imgIpadLogo" ImageUrl="~/CSS/Images/PMWebLogoSmall.png"  Style="margin-bottom: 4px;"  onclick="OpenIpadMenu()" onmouseover="this.style.cursor='hand'" />
                                <asp:LinkButton ID="imgToggleAssetMenu" runat="server" OnClientClick="return ToggleAssetMenu();">
                                </asp:LinkButton>
                                <asp:HyperLink ID="hplHelp" class="HeaderMenuHelp" Style="margin-left: 15px; margin-bottom: 1px;" runat="server" Target="_blank" Visible="true">
                                </asp:HyperLink>
                            </div>

                        </td>
                        <td>
                            <telerik:RadTabStrip ID="tbsHomeDocument" MultiPageID="mlpHome" runat="server" CssClass="HomeTabTabs" Height="30px"
                                OnClientDoubleClick="BackToTopLevel" Width="100%" EnableViewState="True" CausesValidation="False"
                                ShowBaseLine="True" ScrollChildren="true" ScrollButtonsPosition="Left">
                                <Tabs>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td class="toolbartopExit" style="background-color: #316888; height: 51px;">
                            <div style="padding-top: 11px;">
                                <asp:LinkButton runat="server" ID="btnExit" OnClientClick="return CheckDirtLogout();"><table><tr><td><div class="ExitIpad">&nbsp;</div></td></tr></table></asp:LinkButton>
                            </div>

                        </td>
                    </tr>
                </table>


            </td>
        </tr>

        <tr>
            <td>
                <telerik:RadMultiPage ID="mlpHome" runat="server" SelectedIndex="0" Width="100%"
                    RenderSelectedPageOnly="True" CssClass="ProjectCenterMultiPage">
                    <telerik:RadPageView ID="pvWidget" runat="server" Width="100%" Style="min-height: calc(100vh - 80px);">
                        <table style="width: 99%; padding: 0px" class="tblHomeControls" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <telerik:RadDockLayout ID="rdlHome" runat="server" StoreLayoutInViewState="false">
                                        <table cellpadding="5" cellspacing="0" style="width: 100%">
                                            <tr valign="top">
                                                <td style="width: 34%;" runat="server" id="tdRadDockZone2">
                                                    <telerik:RadDockZone ID="RadDockZone2" runat="server" Orientation="vertical" Style="border: 0px; width: 100%;"
                                                        CssClass="HomeDockZone">
                                                        <telerik:RadDock ID="rdkNYTimesNews" runat="server" DockMode="Docked" EnableAnimation="true" CssClass="Widget"
                                                            meta:resourceKey="rdkRSSFEED" Title="New York Times Headlines" Width="100%">
                                                            <ContentTemplate>
                                                                <telerik:RadRotator ID="rtrNYTimesNews" runat="server" CssClass="NormalWhiteBack"
                                                                    FrameDuration="4000" Height="40px" ScrollDirection="Up" ScrollDuration="500"
                                                                    Skin="Default" Width="400px">
                                                                    <ItemTemplate>
                                                                        <div style="height: 40px; width: 400px; padding: 10px">
                                                                            <telerik:RadTicker ID="NYTimesNewsTicker" runat="server" Skin="Default" Width="400px">
                                                                                <Items>
                                                                                    <telerik:RadTickerItem Text='<%# IIf(Me.JSEscape(XPath("title")) = "", XPath("link"), Me.JSEscape(XPath("title")))%>' NavigateUrl='<%# XPath("link")%>' ForeColor="#012361" Target="_blank" />
                                                                                </Items>
                                                                            </telerik:RadTicker>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </telerik:RadRotator>
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                        <telerik:RadDock ID="rdkLinks" runat="server" DockMode="Docked" EnableAnimation="true" CssClass="Widget"
                                                            meta:resourceKey="rkdLINKS" Title="Links" Width="100%">
                                                            <ContentTemplate>
                                                                <ul>
                                                                    <asp:ListView ID="lsvLinks" runat="server" ItemPlaceholderID="linkItemContainer">
                                                                        <LayoutTemplate>
                                                                            <fieldset id="linkItemContainer" runat="server" />
                                                                        </LayoutTemplate>
                                                                        <ItemTemplate>
                                                                            <li><a href='<%#Eval("URL")%>' onclick="<%#CStr(IIf(Not String.IsNullOrEmpty(CStr(Eval("Type"))) AndAlso CStr(Eval("Type")) <> "", "return OpenPopup(this, 'Report')", ""))%>"
                                                                                target='<%#CStr(IIF(Cbool(Eval("NewPage"))=Cbool(1),"_blank" , "_self"))%>' title='<%#Eval("Description")%>'>
                                                                                <%#Eval("Description")%></a></li>
                                                                            </li>
                                                                        </ItemTemplate>
                                                                    </asp:ListView>
                                                                </ul>
                                                                <%--       <ul style="padding-top:10px">
                                                                    <li>
                                                                    <li><a title="Google" target="_blank" href="http://www.google.com">Google</a></li>
                                                                    <li><a title="Yahoo" target="_blank" href="http://www.yahoo.com">Yahoo</a></li>
                                                                    <li><a title="Amazon" target="_blank" href="http://www.amazon.com">Amazon</a></li>
                                                                    <li><a title="New York Times" target="_blank" href="http://www.nytimes.com/">New York Times</a></li>
                                                                    <li><a title="Facebook" target="_blank" href="http://www.facebook.com/home.php/">Facebook</a></li>
                                                                    </ul>--%>
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                        <telerik:RadDock ID="rdkWeather" runat="server" DockMode="Docked" EnableAnimation="true" CssClass="Widget"
                                                            meta:resourceKey="rdkWEATHER" Title="Weather" Width="100%">
                                                            <ContentTemplate>
                                                                <uc1:Home_Weather ID="Home_Weather1" runat="server" />
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                    </telerik:RadDockZone>
                                                </td>
                                                <td style="width: 66%;" runat="server" id="tdrdkzW">
                                                    <telerik:RadDockZone ID="rdkzW" runat="server" Orientation="vertical" Style="border: 0px; width: 100%;"
                                                        CssClass="HomeDockZone">
                                                        <telerik:RadDock ID="rdkW" runat="server" DockMode="Docked" CssClass="rdkInbox"
                                                            EnableAnimation="true" Width="100%">
                                                            <TitlebarTemplate>
                                                                <table style="display: inline-table; width: calc(100% - 50px);">
                                                                    <tr>
                                                                        <td style="width: calc(100% - 170px); min-width: 105px">
                                                                            <a href="WorkflowInbox.aspx">
                                                                                <asp:Label ID="lblWorkflowInbox" runat="server" Style="float: left; /*margin-top: 6px*/"
                                                                                    meta:resourceKey="lblWORKFLOWINBOX" Text="Workflow Inbox" CssClass="WorkflowInboxLink"></asp:Label>
                                                                            </a>
                                                                        </td>
                                                                        <td style="width: 150px; padding-top: 2px; padding-right: 8px;">
                                                                            <telerik:RadComboBox ID="ddlSortInbox" runat="server" AutoPostBack="True" Width="150px"
                                                                                HighlightTemplatedItems="True" DropDownWidth="190px"
                                                                                Height="200px">
                                                                                <ItemTemplate>
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="width: 85px !important;">
                                                                                                <%# DataBinder.Eval(Container, "Text")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <span class="Icon"></span>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </ItemTemplate>
                                                                            </telerik:RadComboBox>
                                                                        </td>
                                                                        <td style="width: 16px">
                                                                            <asp:LinkButton ID="lbtRefresh2" runat="server" CausesValidation="False" OnClick="lbtRefresh_Click" CssClass="RefreshButton" Style="float: right"><span class="Icon"></span></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </TitlebarTemplate>
                                                            <ContentTemplate>
                                                                <uc3:Home_WorkflowInbox ID="WI1" runat="server" style="min-width: 400px" />
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                        <telerik:RadDock ID="rdkDT" runat="server" DockMode="Docked" Visible="false"
                                                            EnableAnimation="true" Width="100%" CssClass="rdkInbox">
                                                            <TitlebarTemplate>
                                                                <table style="display: inline-table; width: calc(100% - 50px);">
                                                                    <tr>
                                                                        <td style="width: calc(100% - 170px); min-width: 125px">
                                                                            <asp:Label ID="lblCollaborateInbox" runat="server" Style="float: left; /*margin-top: 6px*/"
                                                                                meta:resourceKey="lblCOLLABORATEINBOX" Text="Collaborate Inbox11" CssClass="WorkflowInboxLink"></asp:Label>
                                                                        </td>


                                                                        <td style="width: 150px; padding-top: 2px; padding-right: 8px;">
                                                                            <telerik:RadComboBox ID="ddlDocumenTeamSortInbox" runat="server" AutoPostBack="True" Width="150px"
                                                                                HighlightTemplatedItems="True" DropDownWidth="190px"
                                                                                Height="200px">
                                                                                <ItemTemplate>
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="width: 85px !important;">
                                                                                                <%# DataBinder.Eval(Container, "Text")%>
                                                                                            </td>
                                                                                            <td>
                                                                                                <span class="Icon"></span>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </ItemTemplate>
                                                                            </telerik:RadComboBox>
                                                                        </td>

                                                                        <td style="width: 16px">
                                                                            <asp:LinkButton ID="lbtDTRefresh" runat="server" CausesValidation="False" OnClick="lbtDTRefresh_Click" CssClass="RefreshButton"><span class="Icon" style="float:right;"></span></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </TitlebarTemplate>
                                                            <ContentTemplate>
                                                                <uc10:Home_DocumentTeamInbox ID="DTI1" runat="server" style="min-width: 400px" />
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                        <telerik:RadDock ID="rdkNotification" runat="server" DockMode="Docked" EnableAnimation="true"
                                                            Title="Notification Inbox" meta:resourceKey="rdkNOTIFICATIONINBOX" Width="100%">
                                                            <ContentTemplate>
                                                                <uc6:NotificationInbox ID="NotificationInbox1" runat="server" />
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                        <telerik:RadDock ID="rdkCalendar" runat="server" DockMode="Docked" EnableAnimation="true"
                                                            meta:resourceKey="rdkCALENDAR" Title="Calendar" Width="100%" EnableDrag="true">
                                                            <ContentTemplate>
                                                                <uc4:Home_Calendar ID="Home_Calendar1" runat="server" />
                                                            </ContentTemplate>
                                                        </telerik:RadDock>
                                                    </telerik:RadDockZone>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadDockLayout>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvDashboard" runat="server" Width="100%">
                        <uc7:HomeDashboard ID="HomeDashboard1" runat="server" />
                        <%--   <uc9:HomePMWebReport ID="HomePMWebReport1" runat="server" />--%>
                        <iframe runat="server" id="Iframe1" frameborder="0" visible="false" width="100%" class="ProjectCenterIframe"
                            height="600px" style="background-image: none !important; border: 0px;"></iframe>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvPortfolioOverView" runat="server" Width="100%">
                        <uc8:Home_PortfolioOverView ID="Home_PortfolioOverView1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvMapView" runat="server" Width="100%">
                        <iframe src="ProjectsMapViewFrame.aspx" class="ProjectCenterIframe" runat="server" id="ProjectsFrame" visible="false"
                            width="100%" height="520px" style="background-image: none !important; border: 0px;"></iframe>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvProjectCenter" runat="server" Width="100%">
                        <div style="padding-left: 0px;">
                            <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                <tr class="ProjectCenterToolbar" valign="top">
                                    <td>
                                        <table style="width: 100%; table-layout: fixed" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="width: 20%" class="ToolbarTd ProjectCenterDDLWidth">
                                                    <telerik:RadComboBox ID="ddlProjects" runat="server" Height="400px"
                                                        meta:Resourcekey="ddlProjects" Skin="Default" AllowCustomText="true"
                                                        EmptyMessage="" Width="100%" AutoPostBack="True" NoWrap="true"
                                                        CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                                        EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td valign="middle" style="vertical-align: middle; width: 80%" class="ToolbarTd ProjectCenterToolbarWidth">
                                                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                                        <Items>

                                                            <telerik:RadToolBarButton IsSeparator="true">
                                                            </telerik:RadToolBarButton>

                                                            <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" CssClass="ToolbarSave"
                                                                CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                                                            </telerik:RadToolBarButton>

                                                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                                                SecurityButtonType="Add" EnableDefaultButton="false">
                                                                <Buttons>
                                                                    <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                                                        CommandName="New" AccessKey="n" Width="120px" CausesValidation="false">
                                                                    </telerik:RadToolBarButton>
                                                                    <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                                                        CommandName="NewFromTemplate">
                                                                    </telerik:RadToolBarButton>

                                                                </Buttons>
                                                            </telerik:RadToolBarSplitButton>

                                                            <telerik:RadToolBarButton CssClass="ToolbarPrint" EnableImageSprite="true"
                                                                CommandName="PrintProject" SecurityButtonType="Read" PostBack="false">
                                                            </telerik:RadToolBarButton>

                                                        </Items>
                                                    </telerik:RadToolBar>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator" Style="margin: 5px"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td></td>

                                </tr>
                                <tr>
                                    <td style="height: 8px"></td>
                                </tr>
                            </table>
                            <div class="ProjectCenterContainer" id="iframContent">
                                <uc11:ProjectCenterDetails ID="ProjectCenterDetails" runat="server"></uc11:ProjectCenterDetails>
                            </div>
                        </div>
                        <asp:Button runat="server" ID="btnRefereshAfterCopy" CssClass="Hide" />
                        <%-- <iframe src="ProjectCenter.aspx" frameborder="0" runat="server" id="projectCenterFrame" class="ProjectCenterIframe"
                            visible="false" width="100%" style="background-image: none !important; border: 0px; overflow-x: hidden;"></iframe>--%>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvWebPage" runat="server" Width="100%">
                        <iframe src="" runat="server" frameborder="0" id="WebPageFrame" visible="false" width="100%"
                            height="545px" style="background-image: none !important; border: 0px;"></iframe>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvPDF" runat="server" Width="100%">
                        <iframe src="" runat="server" frameborder="0" id="PDFFrame" visible="false" width="100%"
                            height="545px" style="background-image: none !important; border: 0px;" class="PDFIframe"></iframe>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvCalendar" runat="server" Width="100%">
                        <div class="PMMainPage">
                            <div class="row row-8-4">
                                <div class="col-4">
                                    <fieldset>
                                        <legend>
                                            <asp:Label runat="server" ID="lblEvents" Text="Events" meta:resourcekey="lblEvents"></asp:Label>
                                        </legend>
                                        <telerik:RadGrid ID="rdgSchedulerEvents" AllowMultiRowSelection="false" runat="server"
                                            HeaderStyle-Font-Size="8" AutoGenerateColumns="False"
                                            AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True"
                                            PageSize="10">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                Width="100%" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                                                InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Display by Default" UniqueName="DefaultDisplay"
                                                        HeaderStyle-Width="90px" ItemStyle-Wrap="false" SortExpression="DefaultDisplay"
                                                        HeaderStyle-Wrap="false">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chbDisplay" AutoPostBack="true" OnCheckedChanged="ChkboxSelected_Changed"
                                                                Checked='<%# Cbool(IIF(Eval("DefaultDisplay") is system.DBNULL.value, 0,Eval("DefaultDisplay")))%>'
                                                                runat="server" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" HeaderStyle-Width="100px"
                                                        SortExpression="EventName">
                                                        <ItemTemplate>
                                                            <span>
                                                                <%#IIf(Container.DataItem("EventName").ToString = String.Empty, "&nbsp;", Container.DataItem("EventName").ToString)%></span>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Color" UniqueName="Color" HeaderStyle-Width="40px">
                                                        <ItemTemplate>
                                                            <asp:Label Text="&nbsp;" Width="100%" runat="server" ID="lblColor"></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <FooterStyle CssClass="GridFooter" />
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px">
                                                        &nbsp;&nbsp;
                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="true"
                                                Resizing-AllowColumnResize="False">
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                                <ClientEvents OnRowDropping="rowDropping" />
                                            </ClientSettings>
                                            <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                                        </telerik:RadGrid>
                                    </fieldset>
                                    <fieldset>
                                        <legend>
                                            <asp:Label runat="server" ID="lblOptions" Text="Options" meta:resourcekey="lblOptions"></asp:Label>
                                        </legend>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" ID="lblProject" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlProject" runat="server" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                                        EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" Skin="Default"
                                                        Width="200px" AutoPostBack="True" NoWrap="True" AllowCustomText="True" DropDownWidth="300px"
                                                        CausesValidation="False" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <asp:CheckBox runat="server" AutoPostBack="True" Text="Display My Assignments" meta:resourcekey="chkDisplayMyAssignments"
                                                        ID="chkDisplayMyAssignments"></asp:CheckBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div class="col-8" style="padding-bottom: 24px;">
                                    <telerik:RadScheduler runat="server" Height="" ID="RadScheduler1"
                                        Style="padding-top: 5px" DayStartTime="08:00:00" DayEndTime="20:00:00" DataKeyField="IndexId"
                                        DataSubjectField="Subject" OnClientAppointmentDoubleClick="RedirectToDocument"
                                        DataStartField="Start" DataEndField="End" DataRecurrenceField="RecurrenceRule"
                                        EnableAdvancedForm="true" DataDescriptionField="Description" DataRecurrenceParentKeyField="RecurrenceParentID"
                                        OnClientAppointmentContextMenu="appointmentContextMenu">
                                        <AdvancedForm Modal="true" />
                                        <AppointmentContextMenus>
                                            <telerik:RadSchedulerContextMenu runat="server" ID="SchedulerAppointmentContextMenu">
                                                <Items>
                                                    <telerik:RadMenuItem Text="<%$Resources: ContextMenuEdit %>" Value="CommandEdit" />
                                                    <telerik:RadMenuItem IsSeparator="True" />
                                                    <telerik:RadMenuItem Text="<%$Resources: ContextMenuDelete %>" Value="CommandDelete"
                                                        EnableImageSprite="true" CssClass="MenuDelete" />
                                                </Items>
                                            </telerik:RadSchedulerContextMenu>
                                            <telerik:RadSchedulerContextMenu Visible="false" runat="server" ID="RadSchedulerContextMenu2">
                                                <Items>
                                                </Items>
                                            </telerik:RadSchedulerContextMenu>
                                        </AppointmentContextMenus>
                                        <TimeSlotContextMenus>
                                            <telerik:RadSchedulerContextMenu runat="server" ID="SchedulerTimeSlotContextMenu">
                                                <Items>
                                                    <telerik:RadMenuItem Text="<%$Resources: ContextMenuNewEvent %>" EnableImageSprite="true" CssClass="MenuAdd"
                                                        Value="CommandAddAppointment" />
                                                    <telerik:RadMenuItem Text="<%$Resources: ContextMenuNewReccuringevent %>" ImageUrl="Images/Scheduler/recurring.gif"
                                                        Value="CommandAddRecurringAppointment" />
                                                    <telerik:RadMenuItem IsSeparator="true" />
                                                    <%-- Custom command --%>
                                                    <telerik:RadMenuItem Text="<%$Resources: ContextMenuGoToDay %>" Value="CommandGoToToday" />
                                                </Items>
                                            </telerik:RadSchedulerContextMenu>
                                        </TimeSlotContextMenus>
                                        <ResourceTypes>
                                            <telerik:ResourceType KeyField="Id" Name="<%$Resources: EVENT_Name %>" TextField="EventName"
                                                ForeignKeyField="EventId" />
                                            <telerik:ResourceType KeyField="Id" Name="<%$Resources: lblProject.Text %>" TextField="ProjectName"
                                                ForeignKeyField="ProjectId" />
                                        </ResourceTypes>
                                        <WeekView HeaderDateFormat="MMM-dd-yyyy" />
                                        <TimelineView HeaderDateFormat="MMM-dd-yyyy" ColumnHeaderDateFormat="MMM-dd-yyyy" />
                                    </telerik:RadScheduler>

                                </div>
                            </div>
                        </div>
                        <input type="hidden" runat="server" id="TargetSlotHiddenField" />
                        <asp:HiddenField ID="hdnObjectTypeId" runat="server" Value="" ValidateRequestMode="Disabled" />
                        <asp:HiddenField ID="hdnObjectId" runat="server" Value="" ValidateRequestMode="Disabled" />
                        <asp:Button ID="btnRedirectToDoc" runat="server" CssClass="Hide" Text="Redirect" />
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="pvSettings" runat="server" Width="100%">
                        <uc12:UserProfile ID="UserProf" runat="server" />
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="pvEvents" runat="server" Width="100%">
                        <uc9:ViewEvents ID="ViewEvents1" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>

    <uc1:Message ID="Message1" runat="server" />
    <asp:XmlDataSource ID="xdsrNYTimesNews" XPath="rss/channel/item" runat="server"></asp:XmlDataSource>
</asp:Content>
