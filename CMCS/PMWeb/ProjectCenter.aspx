<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectCenter.aspx.vb" Inherits="Website.ProjectCenter" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Home_ProjectCenterDetails.ascx" TagName="ProjectCenterDetails" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
       <link href="CSS/ControlsCSS/Button.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Combobox.css" rel="stylesheet" /> 
    <link href="CSS/ControlsCSS/Editor.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Grid.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Menu.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Scheduler.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/TabMultipage.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Toolbar.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Tree.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Calendar.css" rel="stylesheet" /> 
    <link href="CSS/ControlsCSS/Rotator.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/RadDock.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Input.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Upload.css" rel="stylesheet" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
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
              
                $(".tbsSpecPC > .rtsLevel").css("cssText", "width: " + $("[id$=rdgSpecifications]")[0].offsetWidth + 'px !important;');
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
        </script>
    </telerik:RadCodeBlock>
    
  
<%--    <style type="text/css"> 
        body{background:#fff !important;} 
a.menu
{
    color:#0085d9 !important;
    cursor: pointer;
   width:auto;
   margin-left:5px;
   font-size:12px;
   white-space:nowrap;
}

a:disabled.menu
{
    color: #999999 !important;homer
    cursor: pointer;
    text-decoration: none;
}
</style>--%>
    <style>
        body{
            overflow-x:hidden;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <telerik:RadFormDecorator ID="rfdMaster" runat="server" DecoratedControls="Buttons,CheckBoxes,Default,H4H5H6,Label,LoginControls,RadioButtons,Scrollbars,Select,ValidationSummary" />
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <script type="text/javascript">
            function pageLoad() {
                ResizeSpectabsInProjectCenter()
            }
            $(window).on('load', function () {
              
                $('#fader img:not(:first)').hide();
                //$('#fader img').css('position', 'absolute');
                //$('#fader img').css('top', '-16px');
                //$('#fader img').css('left', '50%');
                //$('#fader img').each(function () {
                //    var img = $(this);
                //    $('<img>').attr('src', $(this).attr('src')).on('load', function () {
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

                var rotate = setInterval(doRotate, 5000);
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
            return OpenPOPUp("ProjectCenterTempate.aspx", 500, 420, false)
        }
        </script>
        <div style="padding-left: 0px;">
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar" valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td style="width: 20%" class="ToolbarTd">
                            <telerik:RadComboBox ID="ddlProjects" runat="server" Height="400px"
                            meta:Resourcekey="ddlProjects" Skin="Default" AllowCustomText="true"
                            EmptyMessage="Select Project...11" Width="290px" AutoPostBack="True" NoWrap="true"
                            DropDownWidth="300px" CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                        </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                <Items>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                                CommandName="New" AccessKey="n" Width="120px" CausesValidation="false" >
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="NewFromTemplate">
                                            </telerik:RadToolBarButton>
                                           
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton  ImageUrl="Images/ToolBar/Save.png"  CssClass="ToolbarPrint"
                                        CommandName="PrintProject" SecurityButtonType="Read" PostBack="false">
                                    </telerik:RadToolBarButton>

                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                    <tr><td><asp:label ID ="lblError" runat="server" Visible="false" CssClass="Validator" style="margin:5px"></asp:label></td></tr>
                </table>
            </td>
            <td></td>

        </tr>
        <tr>
            <td style="height: 8px"></td>
        </tr>
    </table>
            <div class="PMHeader" id="iframContent">
                        <uc1:ProjectCenterDetails ID="ProjectCenterDetails" runat="server"></uc1:ProjectCenterDetails>
                </div>
        </div>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <ClientEvents OnRequestStart="RequestStart" />
        </telerik:RadAjaxManager>
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Style="display: none;">
        </telerik:RadWindowManager>
        <asp:Button runat="server" ID="btnRefereshAfterCopy" CssClass="Hide" />
    </form>
</body>
</html>
