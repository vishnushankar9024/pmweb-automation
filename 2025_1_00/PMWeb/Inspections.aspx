<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Inspections.aspx.vb" Inherits="Website.Inspections" %>

<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc2" %>
<%@ Register Src="InspectionDetails.ascx" TagName="InspectionDetail" TagPrefix="uc3" %>
<%@ Register Src="InspectionImage.ascx" TagName="Image" TagPrefix="uc4" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc5" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc7" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc8" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc9" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc10" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:radcodeblock id="radCode1" runat="server">
        <style type="text/css">
            .dynamicFields >tbody{display:flex;flex-direction:column}
            .InspectionColor {
            position: relative;
            width: 100%;
            height: 24px;
            line-height: 24px;
            border: 1px solid #666666;
            background-color: #c9c9c9;
            box-sizing: border-box;
            cursor: pointer;
            box-shadow: inset 0 0 0 1px white;
        }

            .InspectionColor:before {
                content: '';
                position: absolute;
                height: 0;
                width: 0;
                border-width: 0 0 6px 6px;
                border-style: solid;
                border-color: transparent transparent #666666 transparent;
                right: 0;
                bottom: 0;
                z-index: 1;
            }

            .InspectionColor:after {
                content: '';
                position: absolute;
                height: 0;
                width: 0;
                border-width: 0 0 7px 7px;
                border-style: solid;
                border-color: transparent transparent #FFFFFF transparent;
                right: 0;
                bottom: 0;
            }

            .NewColorPicker {
            margin: 0 auto;
        }
        </style>
        <script type="text/javascript">
            var paper;
            var canvas;
            var IE = document.all ? true : false
            var arrDrawings = [];
            var arrDetails = [];
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;

            function unbindDropEvent() {
                var dropZone = document.querySelector('.Js-DropZone');
                if (!dropZone) return;
                dropZone.removeEventListener('drop', DropEvent);
            }

            function appendDropEvent() {
                unbindDropEvent();
                var dropZone = document.querySelector('.Js-DropZone');
                if (!dropZone) return;
                dropZone.addEventListener('dragover', function (event) {
                    event.stopPropagation();
                    event.preventDefault();
                    // Style the drag-and-drop as "copy file" operation
                    event.dataTransfer.dropEffect = 'move';
                })
                dropZone.addEventListener('drop', DropEvent);
            }

            function DropEvent(event) {
                var rauFiles = document.querySelector(".inputFile");
                var lst = new DataTransfer();
                lst.items.add(event.dataTransfer.files[0]);
                rauFiles.files = lst.files;
                event.stopPropagation();
                event.preventDefault();
                    var btn = document.querySelector(".btnUpload");
                    btn.click();
            }

            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }

            function goToProject() {
                var projectId = '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.LinkedProjectId%>'
                window.location.href = "Projects.aspx?Id=" + projectId + "&ModuleId=7&PageId=53";
            }

            function Close() {
                __doPostBack('Enable');
            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=Initiative');
                wnd.setSize(424, 435);
                wnd.add_close(RefreshRating);
                wnd.Center();
                return false;
            }

            function RefreshRating(Opener) {
                var updatePanel = $find($("[id$=pnlRating]")[0].id);
                var btnRefreshRating = $("a[id*=rdgRating][id$=btnRefreshRating]")[0];;
                if (updatePanel && btnRefreshRating == null) { __doPostBack(updatePanel.get_id()); }
                else if (btnRefreshRating) {
                    eval(btnRefreshRating.href.split(":")[1]);;
                }
            }

            function InspectionResponseEnd() {
                redrawPoints();
            }

            $(document).ready(function () {
                $('body').click(function (e) {
                    var q = e.target;
                    var s = $(q);
                    var targetid = e.target.id;
                    if (targetid.indexOf('divInspectionColor') < 0)
                        $("[id$='InspectionColorPicker']").addClass("Hide");
                })
            })

            function toggleRCP() {
                if ($("[id$='InspectionColorPicker']").hasClass("Hide")) {
                    $("[id$='InspectionColorPicker']").removeClass("Hide");
                }
                else {
                    $("[id$='InspectionColorPicker']").addClass("Hide");
                }
                FloatDivs();
            }

            function UpdateUserColor(sender) {
                color = sender.get_selectedColor();
                $("[id$='divInspectionColor']").css("background-color", color);
                $("[id$='InspectionColorPicker']").addClass("Hide");
                FloatDivs();
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/UpdateUserColor",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Color: sender.get_selectedColor() }),
                    dataType: "json",
                    async: true
                });
                if (!sender.get_docked())
                { sender.set_dockOnOpen(false) }
                else { sender.set_dockOnOpen(true) }
                return false;
            }

            function OpenSelectAssetPopup() {
                var ParentWidth = $telerik.$(window.parent).width();
                var Parentheight = $telerik.$(window.parent).height();
                var canEdit = '<%=PM.Workflow.DocumentInfo.CanEditDocument%>';
                if (canEdit =='True'){
                    var wnd = window.radopen('SelectAsset.aspx?Id=6&opener=btnAssetFlyoutPopup', 1035, 710, true);
                    wnd.add_close(clickAddAssetButton);
                    if (isMobileScreen()) {
                        wnd.setSize(ParentWidth - 75, Parentheight - 50);
                        wnd.Center();

                    }
                    else {
                        wnd.setSize(ParentWidth - 200, Parentheight - 150);
                        wnd.Center();
                    }

                    return false;
                }
                else {
                    return false;
                }
            }

            function clickAddAssetButton(wnd) {
                var IsAssetSaved = $("[id$='hdnAssetSaved']")[0].value
                if (IsAssetSaved == 1) {
                    $("[id$='hdnAssetSaved']")[0].value = "0";
                    var btn = $("input[id$=btnAddAsset]");
                    btn.click();
                }
                wnd.remove_close(clickAddAssetButton);
            }

                function OpenGenerateWorkOrderPopup(URL, Width, Height) {
                    var wnd = window.radopen(URL);
                    wnd.setSize(Width, Height);
                    wnd.add_close(ClickGenerateWorkOrderButton);
                    wnd.Center();
                    return false;
                }

                function ClickGenerateWorkOrderButton() {
                    var btn = $("input[id$=btnGenerateWorkOrder]");
                    btn.click();
                }


                function OpenPreviewConversion() {
                    var RecordCurrencyId = '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.CurrencyId%>';
                    return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=BUDGETINITIATIVES&Id=" +
                                         '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>'
                              + "&ProjectId=" + '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
                }

                function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                        sender.close(true);
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        if (args.get_item().get_value() == "GenerateWorkOrder") {
                            var button = mainToolBar.findItemByValue("GenerateWorkOrder");
                            button.click();
                        }

                        if (args.get_item().get_value() == "GenerateInitiative") {
                            var button = mainToolBar.findItemByValue("GenerateInitiative");
                            button.click();
                        }
                        if (args.get_item().get_value() == "UpdateAsset") {
                            var button = document.getElementById("ctl00_CPH1_btnUpdateAsset");
                            button.click();
                        }
                        maintoolbarClick(args.get_item().get_value(),args)
                    }
            }

                function click_handler(sender, args) {
                    maintoolbarClick(args.get_item().get_commandName(), args)
                }

                function maintoolbarClick(Value,args) {
                    var HasReports = 'True';
                    var HasMergeTemplate = '<%= PM.Document.InspectionInfo.HasMergeTemplate%>';;
                    var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("INSPECTIONS")%>';
                    var RecordDescription = '<%=PM.Document.InspectionInfo.Description%>';
                    var Description = '<%=PM.Document.InspectionInfo.Description%>';
                    var Id = '<%= PM.Document.InspectionInfo.Id%>';
                    switch (Value) {
                        case 'ViewTemplates':
                            if (HasMergeTemplate == 'True') {
                                var left = (screen.width - 1045) / 2;
                                var top = (screen.height - 515) / 2;
                                OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=Inspections&Id=" +
                                '<%= PM.Document.InspectionInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                            }
                            break;
                        case 'Notification':
                            if (Id == 0) break;
                            var left = (screen.width - 900) / 2;
                            var top = (screen.height - 500) / 2;
                            OpenPOPUp("Notification.aspx?ObjectType=INSPECTIONS&Id=" +
                                   '<%= PM.Document.InspectionInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0", "Notification",
                    'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                            break;
                        case 'ViewReports':
                            if (HasReports == 'True') {
                                OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=INSPECTIONS&Id=" +
                            '<%= PM.Document.InspectionInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                            }
                            break;

                        case 'Print':

                            if (HasReports == 'True') {
                                OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=INSPECTIONS&Id=" +
                            '<%= PM.Document.InspectionInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                            } else {
                                window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                                args.set_cancel(true);
                            }
                            break;

                        case 'BIReporting':

                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                            break;

                        case 'ViewPMWebReports':
                            var left = (screen.width - 900) / 2;
                            var top = (screen.height - 500) / 2;
                            if (HasPMWebReports == 'True' && Id > 0) {
                                OpenPOPUp("PMWebReports.aspx?ObjectType=INSPECTIONS&Id=" + Id
                        + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                            }
                            break;
                        case 'New':
                            window.location = "Inspections.aspx";
                            break;
                        case 'GenerateProject':
                            OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?Source=InspectionProject', 1020, 520)
                            break;
                        case 'GenerateWorkOrder':
                            var InspectionPropertyId = '<%=PM.Document.InspectionInfo.LocationId%>';
                            if (InspectionPropertyId == '0') {
                                args.set_cancel(true);
                                alert(Msg_InspectionSelectProperty);
                            }
                            break;
                        case 'Submit':
                            return OpenWorkflowSubmitPopup('INSPECTIONS');
                            break;
                        default:
                            break;
                    }
            }

                function OpenWorkflowSubmitPopup(ObjectType) {
                    OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
                }

                function OpenLinkEstimatesPopup() {
                    var grid = $find($("[id$=rdgEstimateDetails]")[0].id);
                    var InitiativeId = '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>';
                    return OpenPOPUp('LinkEstimatesPopup.aspx?InitiativeId=' + InitiativeId, 1000, 600, true, 'rdgEstimateDetails');
                    return false;
            }

                var MobileScreenWidth = 1024;
                function isMobileScreen() {
                    var browserWidth = $telerik.$(window).width();
                    if (browserWidth <= MobileScreenWidth)
                        return true;
                    return false;
                }

                function ConfirmUpdateAsset() {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("UpdateAssetsPopup.aspx", 'welcome')
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        wnd.setSize((browserWidth * 0.3) + 20, browserHeight * 0.3);
                        wnd.Center();
                    }
                }

                function PopupConfirmationMessage() {
                    var wnd = window.radopen("ConfirmMessagePopUp.aspx");
                    wnd.setSize(370, 150);
                    wnd.Center();
                }

                function OnClientDropDownOpened() {
                    var tree = $find($("[id$=rdvPBS]")[0].id);
                    if (tree != null) {
                        var Node = tree.get_selectedNode();
                        if (Node != null) {
                            Node.scrollIntoView(false);
                        }
                    }
            }

                function MenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                        sender.close(true);
            }

                function CloseAssignMenu(sender, args) {
                    forceradmenuToClose = true;
                    $find($('.DocumentAssign')[0].id).close()

                    return false;
            }

                function OnClientItemClosing(sender, args) {
                    if (forceradmenuToClose) {
                        forceradmenuToClose = false;
                        return;
                    }
                    args.set_cancel(true);
                }

                function CloseMoreAssignMenu(sender, args) {
                    forceMoreMenuToClose = true;
                    var MoreMenu = $find($('.MoreMenu')[0].id);
                    MoreMenu.findItemByValue('Assign').close()
                    return false;
                }

                function MoreMenuOpening(sender, args) {
                    if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                    if (args.get_item().get_value() == 'Assign') {
                        var lblAssigned = $('.lblAssigned');
                        if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                            forceMoreMenuToClose = false;
                    }

            }

                function MoreMenuClosing(sender, args) {
                    if (forceMoreMenuToClose) {
                        return;
                    }
                    args.set_cancel(true);
            }

                function HandleColorChanged(sender, eventArgs) {
                    currColor = sender.get_selectedColor();
                    UpdateDrawingOptions(currColor, intThickness);
            }

                function UpdateDrawingOptions(color, thickness) {
                    PageMethods.UpdateDrawingOptions(color, thickness - 1)
                    return false;
            }

                function LoadColor(sender, eventArgs) {
                    currColor = sender.get_selectedColor();
                    if (isScaled == true || drawingsCateg == 'ANN') {
                        UpdateDrawingOptions(currColor, intThickness);
                    }
            }

        </script>


            <style  type="text/css">
        .InspectionImageImg >svg {
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
        }

            .InspectionImageImg >svg :hover {
                background-color: yellow !important;
            }

        .btnTreeDropItemswithBackground {
            background-image: url('../CSS/Images/ResponsiveIcons/TreeDropItemsWithBackground.png');
            width: 50px !important;
            height: 50px !important;
            display: inline-block;
            cursor: pointer;
            position: absolute;
            right: 30px;
            bottom: 24px; 
            border-radius: 25px;
        }



        /*#imgCanvas {
            height:100%;
            width:100%;
           
        }*/



        /*#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane,
        #RAD_SLIDING_PANE_CONTENT_ctl00_CPH1_InspectionImage1_RadSlidingPane1,
        #ctl00_CPH1_InspectionImage1_RadSlidingPane1*/

        /*.rspSlideContent , .rspPaneTabContainer {
            width:500px !important;
        }*/
       
               @media screen and (min-width:1750px) {

                #Canvas > div {
                    position: absolute !important;
                    z-index: 10;
                }

                    .floatButton {
                        position: absolute !important;
                        bottom: 24px !important;
}


                }
     
               
                .floatButton {
                position: fixed;
                right: 35px;
                bottom: 24px;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background: #316888;
                text-align: center;
                box-sizing: border-box;
                cursor: pointer;
                z-index: 999;
                }
     

        .InspectionTable {
            margin-top: 24px;
            padding-right: 24px;
            padding-left: 24px;
            padding-bottom: 24px;
        }

          .FirstArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -1968px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
            transform: rotate(-90deg);
        }
         
        .BackArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -177px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
        }

        .ForWardArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -191px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
        }

         .LastArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -1968px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
            transform: rotate(90deg);
        }



            .floatButton .circle {
                width: 8px;
                height: 8px;
                display: inline-block;
                border-radius: 50%;
                background: white;
                margin-top: 21px;
            }

   
    

        .InspectionMenu.RadMenu ul.rmGroup {
            border: 3px solid #316888 !important;
            border-radius: 8px;
            padding: 10px !important;
        }

        .InspectionMenu .rmSeparator {
            background: #C5C5C5;
          height: 2px;
          margin: 2px 0px 2px 0px ;
            }
       .RadMenu_Default .rmGroup .rmSeparator .rmText {
            border:none;
            border-color:none;
            }

               .InspectionCenteredMenu {
            position: fixed;
            top: 50% !important;
            left: 50% !important;
            -o-transform: translate(-50%,-50%);
            -webkit-transform: translate(-50%,-50%);
            -moz-transform: translate(-50%,-50%);
            transform: translate(-50%,-50%);
        }

    </style>
    <script src="JS/raphael-min.js" type="text/javascript"></script>
    <script type="text/javascript">


        var menuX; var menuY;
        var mouseX = 100; var mouseY = 100;
        var tempX1 = 0; var tempY1 = 0;
        var currColor = '<%=PM.Document.InspectionInfo.color%>';
        var textColor = "white";
        var intThickness = 1;
        var ptLocation = 0;
        var isDraggingActive = false;
        var DragStartX = 0
        var DragStartY = 0
        var isDragged = true;
        function redrawPoints() {
            if ($("#Canvas").length==0)
                return;
            if (paper) {
                paper.remove()
                paper = new Raphael("Canvas");
            }
            else
                paper = new Raphael("Canvas");

            $("#Canvas").mousemove(function (e) {
                var offset = $(this).offset();
                mouseX = e.pageX;
                mouseY = e.pageY;
                mouseX = e.pageX - offset.left;
                mouseY = e.pageY - offset.top;
            });


      

            paper.clear();
            var hasPoint = false;
            //var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            for (var i = 0; i < arrDrawings.length; i++) {
                LoadInspectionPoint(arrDrawings[i].X, arrDrawings[i].Y, arrDrawings[i].ID, arrDrawings[i].LineNumber)
                //if(arrDrawings[i].ID ==selectedId)
                //    hasPoint = true
            }
            //if(hasPoint==true)
            //{
            //    var diagram = $find('ctl00_CPH1_InspectionImage1_thediagram')
            //    diagram.addCssClass('Hide')
            //}
            //else {
            //    var diagram = $find('ctl00_CPH1_InspectionImage1_thediagram')
            //    diagram.removeCssClass('Hide')
            //}
        }
        window.onresize = function () {
            SetFloatButtonPosition();
            
        }
        function SetFloatButtonPosition() {

            
            var browserheight = $telerik.$(window).height();
            var browserwidth = $telerik.$(window).width();
            var FloatButton = $('#' + ($("[id$=floatButtonMenu]")[0].id))[0];
            if (browserwidth <= 1750) {
                var canvasheight = $telerik.$("#Canvas").height();
                if (browserheight - 110 > canvasheight) {
                    if (browserwidth >= 1300 && (ctl00_CPH1_InspectionImage1_RadSlidingPane1.style.position == "absolute" || ctl00_CPH1_InspectionImage1_RadSlidingPane1.style.position == "")) {                       
                        FloatButton.style.position = "absolute";
                        FloatButton.style.bottom = 20 + 'px';

                    }
                    else {
                        FloatButton.style.position = "Fixed";
                        if (browserwidth >= 850) {
                            FloatButton.style.bottom = browserheight - canvasheight - 77 + 'px';
                        }
                        else {
                            FloatButton.style.bottom = browserheight - canvasheight - 50 + 'px';
                        }
                        
                    }

                        
                }
                else {
                    FloatButton.style.position = "Fixed";
                    FloatButton.style.bottom = 70 + 'px';

                }
                   
                }
            else {
                   
                FloatButton.style.bottom = 20 + 'px';
                }

            }
        
        function DrawInspectionPointAfterSave(inspectionDetailId, lineNumber) {
            RightMouseX = $("[id$='hdnMouseX']")[0].value
            RightMouseY = $("[id$='hdnMouseY']")[0].value
            if (RightMouseX == 0 || RightMouseY == 0) {
                return;
            }
            ptLocation = RightMouseX + "$" + RightMouseY;
            var ellipse = paper.ellipse(RightMouseX, RightMouseY, 12, 12);
            ellipse.id = 'InspectionDetail_' + inspectionDetailId;
            ellipse.attr({
                fill: currColor,
                'fill-opacity': 0,
                stroke: currColor,
                "stroke-width": '2'
            });

            var text = paper.text(RightMouseX, RightMouseY, lineNumber).attr(
            {
                "text-anchor": "middle",
                stroke: 'none',
                fill: currColor,
                "stroke-width": intThickness,
                font: '14px "verdana,geneva,helvetica,sans-serif"',
                "font-family": "verdana,geneva,helvetica,sans-serif"
            });
            text.id = 'InspectionDetailText_' + inspectionDetailId;
            var diagram = $find('ctl00_CPH1_InspectionImage1_thediagram')
            var gridId = diagram.get_element().getAttribute('selectedId')
            if (gridId == inspectionDetailId) {
                diagram.addCssClass('Hide');
            }

            var InspectionDetailSet = paper.set()
            InspectionDetailSet.push(text);
            InspectionDetailSet.push(ellipse);
            InspectionDetailSet.ID = inspectionDetailId;
            InspectionDetailSet.hover(function () {
                if (isDraggingActive == false) {
                    var textElement;
                    var ellipseElement;
                    if (this.id.indexOf('Text') > 0) {
                        textElement = this;
                        ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))
                    }
                    else {
                        ellipseElement = this;
                        textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
                    }

                    textElement.transform('s1.333333,1.3333333')
                    ellipseElement.transform('s1.333333,1.3333333')
                    textElement.attr({ fill: 'white' })
                    ellipseElement.attr({ fill: currColor, 'fill-opacity': 1 })
                }
            }, function () {
                if (isDraggingActive == false) {
                    var textElement;
                    var ellipseElement;
                    if (this.id.indexOf('Text') > 0) {
                        textElement = this;
                        ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))

                    }
                    else {
                        ellipseElement = this;
                        textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
                    }

                    textElement.transform('')
                    ellipseElement.transform('')
                    ellipseElement.attr({ 'fill-opacity': 0 })
                    textElement.attr({ fill: currColor })
                }
            })

            InspectionDetailSet.click(function (e) {
                RefreshInspectionData(inspectionDetailId);
                redrawPoints()


            });
            InspectionDetailSet.mousedown(function (e) {
                if (e.button == 2) {
                    RemoveInspectionCenteredMenuClass();
                    imageMenu = $find($('[id$=rcmInspection]')[0].id);
                    pointMenu = $find($('[id$=rcmInspectionPoint]')[0].id);
                        if (imageMenu)
                            imageMenu.hide()
                   
                    if (pointMenu) {
                        var upX = e.clientX + $(window).scrollLeft() - 5;
                        var upY = e.clientY + $(window).scrollTop() - 5;
                        pointMenu.showAt(upX, upY);
                    }
                    setTimeout(function () { $("[id$='hdnRefreshInspectionData']")[0].value = inspectionDetailId;
                    redrawPoints()}, 200)
                    
                    //var viewDetails = document.querySelector('.ViewDetails');
                    //var RemoveSelectedPoint = document.querySelector('.RemoveSelectedPoint');
                    //var DeleteSelectedPoint = document.querySelector('.DeleteSelectedPoint');
                    //var AddPoint = document.querySelector('.AddPoint');
                    //viewDetails.classList.remove('Hide');
                    //RemoveSelectedPoint.classList.remove('Hide');
                    //DeleteSelectedPoint.classList.remove('Hide');
                    //AddPoint.classList.add('Hide');

                }

            });
            //PageMethods.DeletePoint(inspectionDetailId);
            InspectionDetailSet.drag(drag_move, drag_start, drag_end)
            arrDrawings.push({ 'X': RightMouseX, 'Y': RightMouseY, "ID": inspectionDetailId, "LineNumber": lineNumber });
            PageMethods.SavePoint(inspectionDetailId, ptLocation);
            redrawPoints();
        }

        function DrawInspectionPoint(inspectionDetailId, lineNumber) {
            tempX1 = mouseX;
            tempY1 = mouseY;
            ptLocation = tempX1 + "$" + tempY1;
            var ellipse = paper.ellipse(tempX1, tempY1, 12, 12);
            ellipse.id = 'InspectionDetail_' + inspectionDetailId;
            ellipse.attr({
                fill: currColor,
                'fill-opacity': 0,
                stroke: currColor,
                "stroke-width": '2'
            });

            var text = paper.text(tempX1, tempY1, lineNumber).attr(
            {
                "text-anchor": "middle",
                stroke: 'none',
                fill: currColor,
                "stroke-width": intThickness,
                font: '14px "verdana,geneva,helvetica,sans-serif"',
                "font-family": "verdana,geneva,helvetica,sans-serif"
            });
            text.id = 'InspectionDetailText_' + inspectionDetailId;
            var diagram = $find('ctl00_CPH1_InspectionImage1_thediagram')
            var gridId = diagram.get_element().getAttribute('selectedId')
            if (gridId == inspectionDetailId) {
                diagram.addCssClass('Hide');
            }
            var InspectionDetailSet = paper.set()
            InspectionDetailSet.push(text);
            InspectionDetailSet.push(ellipse);
            InspectionDetailSet.ID = inspectionDetailId;

            InspectionDetailSet.hover(function () {
                if (isDraggingActive == false) {
                    var textElement;
                    var ellipseElement;
                    if (this.id.indexOf('Text') > 0) {
                        textElement = this;
                        ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))
                    }
                    else {
                        ellipseElement = this;
                        textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
                    }

                    textElement.transform('s1.333333,1.3333333')
                    ellipseElement.transform('s1.333333,1.3333333')
                    textElement.attr({ fill: 'white' })
                    ellipseElement.attr({ fill: currColor, 'fill-opacity': 1 })
                }
            }, function () {
                if (isDraggingActive == false) {
                    var textElement;
                    var ellipseElement;
                    if (this.id.indexOf('Text') > 0) {
                        textElement = this;
                        ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))

                    }
                    else {
                        ellipseElement = this;
                        textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
                    }

                    textElement.transform('')
                    ellipseElement.transform('')
                    ellipseElement.attr({ 'fill-opacity': 0 })
                    textElement.attr({ fill: currColor })
                }
            })

            InspectionDetailSet.click(function (e) {
                RefreshInspectionData(inspectionDetailId);
                redrawPoints()


            });
            InspectionDetailSet.mousedown(function (e) {
                if (e.button == 2) {
                    RemoveInspectionCenteredMenuClass();
                    imageMenu = $find($('[id$=rcmInspection]')[0].id);
                    pointMenu = $find($('[id$=rcmInspectionPoint]')[0].id);
                        if (imageMenu)
                            imageMenu.hide()
                    if (pointMenu) {
                        var upX = e.clientX + $(window).scrollLeft() - 5;
                        var upY = e.clientY + $(window).scrollTop() - 5;
                        pointMenu.showAt(upX, upY);
                    }
                    setTimeout(function () { $("[id$='hdnRefreshInspectionData']")[0].value = inspectionDetailId;
                    redrawPoints()}, 200)
                    
                    //var viewDetails = document.querySelector('.ViewDetails');
                    //var RemoveSelectedPoint = document.querySelector('.RemoveSelectedPoint');
                    //var DeleteSelectedPoint = document.querySelector('.DeleteSelectedPoint');
                    //var AddPoint = document.querySelector('.AddPoint');
                    //viewDetails.classList.remove('Hide');
                    //RemoveSelectedPoint.classList.remove('Hide');
                    //DeleteSelectedPoint.classList.remove('Hide');
                    //AddPoint.classList.add('Hide');

                }

            });
            //PageMethods.DeletePoint(inspectionDetailId);
            InspectionDetailSet.drag(drag_move, drag_start, drag_end)
            arrDrawings.push({ 'X': tempX1, 'Y': tempY1, "ID": inspectionDetailId, "LineNumber": lineNumber });
            PageMethods.SavePoint(inspectionDetailId, ptLocation);
            redrawPoints();
        }

        function LoadInspectionPoint(x, y, inspectionDetailId, lineNumber) {
            var ellipse = paper.ellipse(x, y, 12, 12);
            var text = paper.text(x, y, lineNumber)

            if (inspectionDetailId != $("[id$='hdnRefreshInspectionData']")[0].value) {
                ellipse.id = 'InspectionDetail_' + inspectionDetailId;
                ellipse.attr({
                    fill: currColor,
                    'fill-opacity': 0,
                    stroke: currColor,
                    "stroke-width": '2'
                });

                text.attr(
                {
                    "text-anchor": "middle",
                    stroke: 'none',
                    fill: currColor,
                    "stroke-width": intThickness,
                    font: '14px "verdana,geneva,helvetica,sans-serif"',
                    "font-family": "verdana,geneva,helvetica,sans-serif"
                });
                text.id = 'InspectionDetailText_' + inspectionDetailId;
                var InspectionDetailSet = paper.set()
                InspectionDetailSet.push(text);
                InspectionDetailSet.push(ellipse);
                InspectionDetailSet.ID = inspectionDetailId;
                InspectionDetailSet.hover(function () {
                    if (isDraggingActive == false) {
                        var textElement;
                        var ellipseElement;
                        if (this.id.indexOf('Text') > 0) {
                            textElement = this;
                            ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))
                        }
                        else {
                            ellipseElement = this;
                            textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
                        }

                        textElement.transform('s1.333333,1.3333333')
                        ellipseElement.transform('s1.333333,1.3333333')
                        textElement.attr({ fill: 'white' })
                        ellipseElement.attr({ fill: currColor, 'fill-opacity': 1 })
                    }
                }, function () {
                    if (isDraggingActive == false) {
                        var textElement;
                        var ellipseElement;
                        if (this.id.indexOf('Text') > 0) {
                            textElement = this;
                            ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))

                        }
                        else {
                            ellipseElement = this;
                            textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
                        }

                        textElement.transform('')
                        ellipseElement.transform('')
                        ellipseElement.attr({ 'fill-opacity': 0 })
                        textElement.attr({ fill: currColor })
                    }
                })

            }
            else {
                ellipse.id = 'InspectionDetail_' + inspectionDetailId;
                ellipse.attr({
                    fill: currColor,
                    'fill-opacity': 0,
                    stroke: currColor,
                    "stroke-width": '2'
                });

                text.attr(
                {
                    "text-anchor": "middle",
                    stroke: 'none',
                    fill: currColor,
                    "stroke-width": intThickness,
                    font: '14px "verdana,geneva,helvetica,sans-serif"',
                    "font-family": "verdana,geneva,helvetica,sans-serif"
                });
                text.id = 'InspectionDetailText_' + inspectionDetailId;
                var InspectionDetailSet = paper.set()
                InspectionDetailSet.push(text);
                InspectionDetailSet.push(ellipse);
                InspectionDetailSet.ID = inspectionDetailId;
                ellipse.transform('s1.333333,1.3333333')
                text.transform('s1.333333,1.3333333')
                text.attr({ fill: 'white' })
                ellipse.attr({ fill: currColor, 'fill-opacity': 1 })
            }
            InspectionDetailSet.click(function (e) {
                if (e.button == 0) {
                    RefreshInspectionData(inspectionDetailId);
                    redrawPoints()
                }
            });
            InspectionDetailSet.mousedown(function (e) {
                if (e.button == 2) {
                    RemoveInspectionCenteredMenuClass();
                    imageMenu = $find($('[id$=rcmInspection]')[0].id);
                    pointMenu = $find($('[id$=rcmInspectionPoint]')[0].id);
                   
                            if (imageMenu)
                                imageMenu.hide()

                            if (pointMenu) {
                                var upX = e.clientX + $(window).scrollLeft() - 5;
                                var upY = e.clientY + $(window).scrollTop() - 5;
                                pointMenu.showAt(upX, upY);
                            }
                        
                          
                    setTimeout(function () { $("[id$='hdnRefreshInspectionData']")[0].value = inspectionDetailId;
                        redrawPoints();}, 200)
                    //var viewDetails = document.querySelector('.ViewDetails');
                    //var RemoveSelectedPoint = document.querySelector('.RemoveSelectedPoint');
                    //var DeleteSelectedPoint = document.querySelector('.DeleteSelectedPoint');
                    //var AddPoint = document.querySelector('.AddPoint');
                    //viewDetails.classList.remove('Hide');
                    //RemoveSelectedPoint.classList.remove('Hide');
                    //DeleteSelectedPoint.classList.remove('Hide');
                    //AddPoint.classList.add('Hide');

                }



            });
            InspectionDetailSet.drag(drag_move, drag_start, drag_end)



        }
        function ShowContextMenu(evt) {
            $("[id$='hdnMouseX']")[0].value = 0
            $("[id$='hdnMouseY']")[0].value = 0
            imageMenu = $find($('[id$=rcmInspection]')[0].id);
            pointMenu = $find($('[id$=rcmInspectionPoint]')[0].id);
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            //var h =document.documentElement.offsetHeight
            //var w = document.documentElement.offsetWidth
            //centerX =  w / 2
            //centerY = $('#Canvas').offset().top + h / 2
            var imagecontextMenu = document.getElementById("ctl00_CPH1_InspectionImage1_rcmInspection_detached");
            var PointcontextMenu = document.getElementById("ctl00_CPH1_InspectionImage1_rcmInspectionPoint_detached");
            var ImageContextMenu = document.getElementById("ctl00_CPH1_InspectionImage1_rcmInspectionPoint_detached");
            var pointMenuContextMenu = document.getElementById("ctl00_CPH1_InspectionImage1_rcmInspection_detached");
            ImageContextMenu.classList.add("InspectionCenteredMenu");
            pointMenuContextMenu.classList.add("InspectionCenteredMenu");
            if (selectedId > 0) {
                pointMenu.showAt('21', '21');
            }
            else {
                imageMenu.showAt('21', '21');
            }
            $telerik.cancelRawEvent(evt);

            //pointMenu.sh
            //var upX = e.clientX + $(window).scrollLeft() - 5;
            //var upY = e.clientY + $(window).scrollTop() - 5;

        }
        //var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
        ////$("[id$='hdnRefreshInspectionData']")[0].value = inspectionDetailId;
        //redrawPoints()
        //if (selectedId == null || selectedId <= 0) return false;

        //if (selectedId == 0) {

        //}




        function drag_start(x, y, e) {
            if (e.button == 2) {
                isDraggingActive = false;
                return
            }
            isDraggingActive = true;
        }
        function drag_move(dx, dy, posx, posy) {
            if (isDraggingActive == false)
                return
            var textElement;
            var ellipseElement;
            if (this.id.indexOf('Text') > 0) {
                textElement = this;
                ellipseElement = paper.getById(this.id.replace('InspectionDetailText_', 'InspectionDetail_'))
            }
            else {
                ellipseElement = this;
                textElement = paper.getById(this.id.replace('InspectionDetail_', 'InspectionDetailText_'))
            }

            ellipseElement.attr({
                transform: "...T" + (dx - DragStartX) + "," + (dy - DragStartY)
            });
            textElement.attr({
                transform: "...T" + (dx - DragStartX) + "," + (dy - DragStartY)
            });
            DragStartX = dx;
            DragStartY = dy;
        }
        function drag_end() {
            if (isDraggingActive == false)
                return
            DragStartX = 0
            DragStartY = 0
            var transformation = this.transform()
            var tempX1 = 0
            var tempY1 = 0
            var ptLocation = '';
            var id = this.id.replace('InspectionDetailText_', '').replace('InspectionDetail_', '')

            for (var i = 0; i < transformation.length; i++) {
                if (transformation[i][0] == 'T') {
                    tempX1 += CInt(transformation[i][1])
                    tempY1 += CInt(transformation[i][2])
                }
            }
            if (tempX1 == 0 && tempY1 == 0) {
                isDraggingActive = false
                RefreshInspectionData(id);
                redrawPoints()
                return;
            }
            paper.clear()
            for (var i = 0; i < arrDrawings.length; i++) {              
                if (arrDrawings[i].ID == id) {
                    arrDrawings[i].X = CDbl(arrDrawings[i].X) + CInt(tempX1);
                    arrDrawings[i].Y = CDbl(arrDrawings[i].Y) + CInt(tempY1);
                    ptLocation = arrDrawings[i].X + "$" + arrDrawings[i].Y;
                    PageMethods.SavePoint(id, ptLocation)

                }
                LoadInspectionPoint(arrDrawings[i].X, arrDrawings[i].Y, arrDrawings[i].ID, arrDrawings[i].LineNumber)
            }
            isDraggingActive = false;


        }



        //function ImageClick(e) {
        //    
        //    if (e.button == 2) {
        //        var viewDetails = document.querySelector('.ViewDetails');
        //        var RemoveSelectedPoint = document.querySelector('.RemoveSelectedPoint');
        //        var DeleteSelectedPoint = document.querySelector('.DeleteSelectedPoint');
        //        var AddPoint = document.querySelector('.AddPoint');
        //        AddPoint.classList.remove('Hide');
        //        viewDetails.classList.add('Hide');
        //        RemoveSelectedPoint.classList.add('Hide');
        //        DeleteSelectedPoint.classList.add('Hide');

        //    }

        //}

        function RadContextMenu_ClientItemClicking(sender, args) {
            $("[id$='hdnDrawPoint']")[0].value = '';
            switch (args.get_item().get_value()) {
                case 'AddPoint':
                    AddPoint();
                    break;
                    //case 'MoveSelectedPoint':
                    //    MoveSelectedPoint();
                    //    break;
                case 'RemoveSelectedPoint':
                    DeleteSelectedPoint(false);
                    break;
                case 'DeleteSelectedPoint':
                    //var result = ConfirmDelete();
                    //if (result == false)
                    //    return false;
                    var deletebtn = document.querySelector('.Deletebtn');
                    deletebtn.click();
                    break;
                case 'ChangeImage':
                    
                    var ChangeImage = document.getElementById('ctl00_CPH1_InspectionImage1_rauInspectionImagefile0');
                    ChangeImage.click();
                    break;
                case 'DeleteImage':
                    var deleteimage = document.querySelector('.DeleteImage');
                    deleteimage.click();
                    break;
                case 'ViewDetails':
                    ViewDetail();
                    break;
            }
        }

        function OpenSyncUpload(evt) {
            
            var UploadImage = document.getElementById('ctl00_CPH1_InspectionImage1_rauInspectionImagefile0');
            UploadImage.click();
            $telerik.cancelRawEvent(evt);
        }


        function MoveSelectedPoint() {
            tempX1 = mouseX;
            tempY1 = mouseY;
            ptLocation = tempX1 + "$" + tempY1;
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            if (selectedId == null || selectedId <= 0) return false;

            for (var i = 0; i < arrDrawings.length; i++) {
                elementId = arrDrawings[i].ID;
                lineNumber = arrDrawings[i].LineNumber;
                if (elementId == selectedId) {
                    arrDrawings.splice(i, 1);
                    arrDrawings.push({ 'X': tempX1, 'Y': tempY1, "ID": selectedId, "LineNumber": lineNumber });
                    PageMethods.SavePoint(selectedId, ptLocation)
                }
            }
            LoadAllInspectionPoints();
        }


        function AddPoint() {
            if (isMobileScreen()) {
                OpenViewInspectionDetailPopup();
            }
            else {
                var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');

                if (TabPane.style.visibility == 'hidden') {
                    $("[id$='hdnRefreshInspectionData']")[0].value = 0;
                    $("[id$='hdnGridId']")[0].value = 0;
                    $("[id$='btnRefreshInspectionData']")[0].click();
                    var NewEntry = document.querySelector('.NewEntry');
                    NewEntry.click();
                }
                else {
                    OpenViewInspectionDetailPopup();
                }


            }
            function OpenViewInspectionDetailPopup() {
                var wnd = window.radopen('ViewInspectionDetailPopup.aspx');
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var width = 448
                if (browserWidth <= width)
                    width = browserWidth * 0.9;
                wnd.setSize(width, browserHeight * 0.9);
                wnd.Center();
                wnd.add_close(OnDetailPopupClosed)
            }
            //var wnd = window.radopen('InspectionDetailsPopup.aspx');
            //wnd.setSize(700, 700);
            ////wnd.set_behaviors(Telerik.Web.UI.WindowBehaviors.Minimize + Telerik.Web.UI.WindowBehaviors.Maximize + Telerik.Web.UI.WindowBehaviors.Close);
            //wnd.Center();
        }
        function ViewDetail() {
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            var wnd = window.radopen('ViewInspectionDetailPopup.aspx?Id=' + selectedId);
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var width = 448
            if (browserWidth <= width)
                width = browserWidth * 0.9;
            wnd.setSize(width, browserHeight * 0.9);
            wnd.Center();
            wnd.add_close(OnDetailPopupClosed)
        }

        function OpenviewInspectionsAttachmentPopup(DocumentType, LineId, DocumentId, EntityTypeId, EntityId, IsLastRevision) {
            var ParentWidth = $telerik.$(window.parent).width();
            var Parentheight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen('ViewAttachments.aspx?DocumentType=' + DocumentType + '&LineId=' + LineId + '&DocumentId=' +
                 DocumentId + '&EntityTypeId=' + EntityTypeId + '&EntityId=' + EntityId +
                  '&IsLastRevision=' + IsLastRevision, true);           
                wnd.add_close(OnDetailPopupClosed)          
            
                if (isMobileScreen()) {
                    wnd.setSize(ParentWidth - 75, Parentheight - 50);
                    wnd.Center();

                }
                else {
                    wnd.setSize(ParentWidth - 100, Parentheight - 75);
                    wnd.Center();
                }

        }
        function OnDetailPopupClosed() {
            $("[id$='btnRefreshAfterClose']")[0].click()
        }
        var MobileScreenWidth = 1024;
        function isMobileScreen() {
            var browserWidth = $telerik.$(window).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }


        function SelectAsset(node) {
            var assetText = ""
            var AssetId = node.get_attributes().getAttribute("AssetId");
            switch (node.get_contentCssClass()) {
                case "trvProperty":
                    assetText = "Property"
                    break;
                case "trvBuilding":
                    assetText = "Building"
                    break;
                case "trvFloor":
                    assetText = "Floor"
                    break;
                case "trvSpace":
                    assetText = "Space"
                    break;
                case "trvEquipment":
                    assetText = "Equipment"
                    break;
            }
            //$("[id$=txtAssetType]")[0].value = assetText

            //
            $("[id$='txtAssetType']").val(assetText)
            $("[id$='hdnAssetId']")[0].value = AssetId;
            $("[id$='txtAsset']")[0].value = node.get_text();
            $("[id$='txtDescription']").val(node.get_text());
        }


        function DeleteSelectedPointFromGrid(bool) {
            var selectedId = $("[id$='hdnGridId']")[0].value
            var selectedLineNumber;
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDrawings.length; i++) {
                elementId = arrDrawings[i].ID
                if (elementId == selectedId) {
                    selectedLineNumber = arrDrawings[i].LineNumber;
                    arrDrawings.splice(i, 1);
                    PageMethods.DeletePoint(selectedId)
                    var diagram = $find('ctl00_CPH1_InspectionImage1_thediagram')
                    var gridId = diagram.get_element().getAttribute('selectedId')
                    if (gridId == selectedId) {
                        diagram.removeCssClass('Hide');
                    }
                }
            }
            if (bool) {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (selectedLineNumber < arrDrawings[i].LineNumber) {
                        arrDrawings[i].LineNumber = arrDrawings[i].LineNumber - 1;
                    }
                }
            } else {
                //document.getElementById("ctl00_CPH1_InspectionImage1_lblSelectionLabel").style.display = "block";
                //document.getElementById("ctl00_CPH1_InspectionImage1_pnlAsset").style.display = "none";

            }
            LoadAllInspectionPoints();
        }


        function OpenConfirmPopup() {
            $("[id$='hdnDrawPoint']")[0].value = $("[id$='hdnGridId']")[0].value;
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen("ConfirmInspectionPointPopup.aspx", 'welcome')

            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize((browserWidth * 0.3) + 20, browserHeight * 0.3);
                wnd.Center();
            }
            
        }
        function ImageClick(e) {
            if (e.button == 0) {
                var inspectionDetailId = $("[id$='hdnDrawPoint']")[0].value
                var lineNumber;
                if (inspectionDetailId == '')
                    return;
                for (var i = 0; i < arrDetails.length; i++) {
                    if (arrDetails[i].ID == inspectionDetailId)
                        lineNumber = arrDetails[i].LineNumber
                }
                DrawInspectionPoint(inspectionDetailId, lineNumber)
                $("[id$='hdnDrawPoint']")[0].value = '';
            }
            else if (e.button == 2) {               
                $("[id$='hdnRefreshInspectionData']")[0].value = '';
                $("[id$='hdnMouseX']")[0].value = mouseX
                $("[id$='hdnMouseY']")[0].value = mouseY
                RemoveInspectionCenteredMenuClass();
                redrawPoints();

            }
       

        }
        function MobileImgClick(e) {
            var mouseDownX = e.touches[0].pageX;
            var mouseDownY = e.touches[0].pageY;
           $("[id$='hdnRefreshInspectionData']")[0].value = '';
           $("[id$='hdnMouseX']")[0].value = mouseDownX
           $("[id$='hdnMouseY']")[0].value = mouseDownY
           RemoveInspectionCenteredMenuClass();
           redrawPoints();
           
        }
        //function DrawInspectionfterSave() {

        //    var inspectionDetailId = $("[id$='hdnGridId']")[0].value;
        //    var lineNumber;
        //    if (inspectionDetailId == '')
        //        return;
        //    for (var i = 0; i < arrDetails.length; i++) {
        //        if (arrDetails[i].ID == inspectionDetailId)
        //            lineNumber = arrDetails[i].LineNumber
        //    }
        //    DrawInspectionPoint(inspectionDetailId, lineNumber)
        //    $("[id$='hdnDrawPoint']")[0].value = '';
        //}

        function DeleteSelectedPoint(bool) {
            
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            var selectedLineNumber;
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDrawings.length; i++) {
                elementId = arrDrawings[i].ID
                if (elementId == selectedId) {
                    selectedLineNumber = arrDrawings[i].LineNumber;
                    arrDrawings.splice(i, 1);
                    PageMethods.DeletePoint(selectedId)
                    var diagram = $find('ctl00_CPH1_InspectionImage1_thediagram')
                    var gridId = $("[id$='hdnGridId']")[0].value
                    if (gridId == selectedId) {
                        diagram.removeCssClass('Hide');
                    }
                }
            }
            if (bool) {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (selectedLineNumber < arrDrawings[i].LineNumber) {
                        arrDrawings[i].LineNumber = arrDrawings[i].LineNumber - 1;
                    }
                }
            } else {
                //document.getElementById("ctl00_CPH1_InspectionImage1_lblSelectionLabel").style.display = "block";
                //document.getElementById("ctl00_CPH1_InspectionImage1_pnlAsset").style.display = "none";

            }
            LoadAllInspectionPoints();
        }


        function LoadFirst() {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var selectedId = $("[id$='hdnGridId']")[0].value;
            if (selectedId == null || selectedId <= 0) return false;
            RefreshInspectionData(arrDetails[0].ID);
            redrawPoints()
        }


        function LoadPrevious() {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var selectedId = $("[id$='hdnGridId']")[0].value;
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDetails.length; i++) {
                elementId = arrDetails[i].ID
                if (elementId == selectedId) {
                    RefreshInspectionData(arrDetails[i - 1].ID)
                }
            }
            redrawPoints()
        }


        function LoadNext() {
            var selectedId = $("[id$='hdnGridId']")[0].value;
            $("[id$='hdnDrawPoint']")[0].value = '';
            if (selectedId == null || selectedId <= 0) return false;
         
            for (var i = 0; i < arrDetails.length; i++) {
                elementId = arrDetails[i].ID
                if (elementId == selectedId) {
                    RefreshInspectionData(arrDetails[i + 1].ID)
                }
            }
            redrawPoints()
        }


        function LoadLast() {
            var selectedId = $("[id$='hdnGridId']")[0].value;
            $("[id$='hdnDrawPoint']")[0].value = '';
            if (selectedId == null || selectedId <= 0) return false;
                    RefreshInspectionData(arrDetails[arrDetails.length -1].ID)
            redrawPoints()
        }

        function LoadCanvas() {
            var canvas = $("#Canvas");
            if (canvas.length == 0) return;
            if (arrDetails) {
                if (paper) {
                    paper.remove()
                    paper = new Raphael("Canvas");
                }
                else
                    paper = new Raphael("Canvas");
                $("#Canvas").mousemove(function (e) {
                    var offset = $(this).offset();
                    mouseX = e.pageX;
                    mouseY = e.pageY;
                    mouseX = e.pageX - offset.left;
                    mouseY = e.pageY - offset.top;
                });
                //$("[id$='btnRefreshInspectionData']")[0].click()
                if ((arrDetails.length > 0)) {
                    RefreshInspectionData(arrDetails[0].ID, true);
                }
                redrawPoints()
            }
        }

        function RefreshInspectionData(id,onload) {
            var isMin = true;
            var isMax = true;
            var index = arrDetails.findIndex(el => el.ID == id)
            for (var i = 0; i < arrDetails.length; i++) {
                if (arrDetails[i].LineNumber > arrDetails[index].LineNumber)
                    isMax = false;
                if (arrDetails[i].LineNumber < arrDetails[index].LineNumber)
                    isMin = false;
            }

            //if (isMax == true) 
            //    ForWardArrow.Enabled = "false";
            //else
            //    ForWardArrow.Enabled = "true";

            if ((isMin == true)) {
                $("[id$='hdnBackArrowDisabled']")[0].value = 'true'

            }
            else {
                $("[id$='hdnBackArrowDisabled']")[0].value = 'false'
            }


            if (isMax == true) {
                $("[id$='hdnForwardArrowDisabled']")[0].value = 'true'
            }

            else {
                $("[id$='hdnForwardArrowDisabled']")[0].value = 'false'
            }


            $("[id$='hdnRefreshInspectionData']")[0].value = id;

            if (!onload)
                $("[id$='btnRefreshInspectionData']")[0].click();

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


        function OnMenuShowing(menu,args) {
            //menuX = mouseX
            //menuY = mouseY
            //if (cursorType == 'Move') {
            //    cursorType = 'Default';
            //    $('#Canvas').hover(function () { $(this).css('cursor', 'default') })
            //}
            var canEdit='<%=PM.Workflow.DocumentInfo.CanEditDocument%>';
            if (canEdit == 'False') {
                for (i = 0; i < menu.get_items().get_count(); i++) {
                    menu.get_items().getItem(i).disable();
                }
                
            }


        }


        function LoadAllInspectionPoints() {
            $('#Canvas')[0].innerHTML = $('#Canvas')[0].children['ctl00_CPH1_InspectionImage1_imgCanvas'].outerHTML + $('#Canvas')[0].children['ctl00_CPH1_InspectionImage1_floatButtonMenu'].outerHTML;
            paper = new Raphael("Canvas");
            redrawPoints()
        }



       

        function OnInspectionClientBeforeExpand(sender, eventArgs) {
            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
            TabPane.style.visibility = 'hidden';
        }

        function OnInspectionClientCollapsed(sender, eventArgs) {
            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
            TabPane.style.visibility = 'visible';
        }



        function detailClick_handler(sender, args) {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var value = args.get_item().get_commandName();
            if (value == "Delete") {
                
               var result= ConfirmDelete();
                if (result==false)
                {
                    args.set_cancel(true);
                    return false;
                }
                DeleteSelectedPointFromGrid(false);
            }
            else if (value == "New") {
                $("[id$='hdnRefreshInspectionData']")[0].value = 0;
                $("[id$='hdnGridId']")[0].value = 0;
                $("[id$='btnRefreshInspectionData']")[0].click();
            }


        }

        function UpdatePanelSettings(sender) {
           
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateInspectionPanelSettings",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ isPinned: sender.get_docked(), Width: sender.get_width() }),
                dataType: "json",
                async: true
            });
            var Undockbtn = document.getElementById('RAD_SPLITTER_SLIDING_PANE_UNDOCK_ctl00_CPH1_InspectionImage1_RadSlidingPane1');           
            var dockbtn = document.getElementById('RAD_SPLITTER_SLIDING_PANE_DOCK_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
            dockbtn.title = "Pin";
            Undockbtn.title = "Unpin";
            if (!sender.get_docked()) {               
                sender.set_dockOnOpen(false)
                var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane');
                TabPane.style.visibility = 'visible'; 
                TabPane1.className = 'drawing-viewer-UnDockrdLeftPane';
               
            }
            else {
                sender.set_dockOnOpen(true)
                var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane');
                TabPane.style.visibility = 'hidden';
                TabPane1.className = '';
             
            }

            SetFloatButtonPosition();
            //var LeftPanewidth = $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane").width();
            //var argheight = $("#ctl00_CPH1_InspectionImage1_RadSplitter1").height();
            //var argwidth = $("#ctl00_CPH1_InspectionImage1_RadSplitter1").width() - LeftPanewidth;

            //$("#RAD_SLIDING_PANE_CONTENT_ctl00_CPH1_InspectionImage1_RadSlidingPane1").width(argwidth - 4).height(argheight - 4);


            //return false;
        }

        function OpenAssetPopup() {
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            if (selectedId == null || selectedId <= 0) return false;
            return OpenPOPUp('SelectAsset.aspx?Id=6&From=InspectionPopup', 350, 700)
        }

        function SaveRefreshInspectionData(DetailId) {
            $("[id$='hdnRefreshInspectionData']")[0].value = DetailId
        }

        function RemoveInspectionCenteredMenuClass() {
            
                    var ImageContextMenu = document.getElementById("ctl00_CPH1_InspectionImage1_rcmInspectionPoint_detached");
                    var pointMenuContextMenu = document.getElementById("ctl00_CPH1_InspectionImage1_rcmInspection_detached");
                    ImageContextMenu.classList.remove("InspectionCenteredMenu");
                    pointMenuContextMenu.classList.remove("InspectionCenteredMenu");
        }
       

    </script>

    </telerik:radcodeblock>
    <telerik:radajaxmanagerproxy id="RadAjaxManager1" runat="server">
    <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="mlpInspection">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpInspection" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpInspection" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
    </AjaxSettings>
</telerik:radajaxmanagerproxy>
   <div style="position:sticky;top:0;z-index:999;">
     <telerik:RadAjaxPanel ID="PnlInspectionToolbar" runat="server" Width="100%" EnableAJAX="true">
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="true" >
                                <Items>
                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                                        Value="Save">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="New">
                                            </telerik:RadToolBarButton>
                                                     <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" Value="CopyRecord"  ValidationGroup="Save">
                                </telerik:RadToolBarButton>

                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                                        CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint" SecurityButtonType="Read"
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

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" RenderMode="Lightweight" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Word" Value="ViewPMWebWord"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" CssClass="Generate">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Generate Work Request" Value="GenerateWorkRequest"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate Work Order" Value="GenerateWorkOrder"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate Initiative" Value="GenerateInitiative"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate Project" Value="GenerateProject"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Update Asset" Value="UpdateAsset" cssclass="Submit"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Import" Value="Assign" CssClass="Assign">
                                                                <Items>
                                                                    <telerik:RadMenuItem>
                                                                        <ItemTemplate>
                                                                            <table style="width: 100%">
                                                                                <tr>
                                                                                    <td colspan="2">
                                                                                        <asp:LinkButton runat="server" ID="btnAssign" CssClass="btnToolbarAssign" OnClick="MobileMenubtnAssign_Click">
                                                                                                                                                                    <div class="Icon">
                                                                                                                                                                       &nbsp; 
                                                                                                                                                                    </div>
                                                                                        </asp:LinkButton>
                                                                                        &nbsp;&nbsp;
                                                                                        <asp:LinkButton runat="server" ID="btnCancelAssign" CssClass="btnToolbarCancelAssign" OnClientClick="return CloseMoreAssignMenu()">
                                                                                            <div class="Icon">
                                                                                                                &nbsp; 
                                                                                                            </div>
                                                                                        </asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2">
                                                                                        <asp:Label runat="server" ID="lblAssigned" CssClass="lblAssigned"></asp:Label>
                                                                                        <asp:LinkButton runat="server" ID="lnkRemoveAssignment" CssClass="removeAssign" OnClick="lnkRemoveAssignment_click">
                                                                                                                                                                    <div class="Icon">
                                                                                                                                                                                       &nbsp; 
                                                                                                                                                                                    </div>
                                                                                        </asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblDueDate" Text="Due Date" runat="server" meta:Resourcekey="lblDueDate"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span runat="server" id="rmd_rdCalendar" style="display: block">
                                                                                            <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                                SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                                                EnableTyping="True">
                                                                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                                    runat="server">
                                                                                                </DateInput>
                                                                                                <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                                                </Calendar>
                                                                                            </telerik:RadDatePicker>
                                                                                        </span>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblUser" Text="User" runat="server" meta:Resourcekey="lblUser"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <telerik:RadComboBox ID="ddlCalendarUsers" runat="server" AllowCustomText="true" ZIndex="9001"
                                                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                                                                            OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="150px">
                                                                                        </telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                             <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('INSPECTIONS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('INSPECTIONS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" CssClass="Help"></telerik:RadMenuItem>

                                                                                              <telerik:RadMenuItem Text="UpdateAssets" Value="UpdateAssets" onclick="OpenRecentDocumentsPopup('INSPECTIONS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('INSPECTIONS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" CssClass="Help"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton EnableDefaultButton="false" PostBack="false" CommandName="Generate" Value="Generate"
                                        ImageUrl="Images/ToolBar/Generate.png" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                CommandName="GenerateWorkRequest" Value="GenerateWorkRequest">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="True" Value="GenerateWorkOrder" CausesValidation="true" ValidationGroup="Gen"  CommandName="GenerateWorkOrder" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="True" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                CommandName="GenerateInitiative" Value="GenerateInitiative">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="False" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                CommandName="GenerateProject" Value="GenerateProject">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="Hide">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton PostBack="false" SecurityButtonType="Calendar" OuterCssClass="HideOnMobileToolbar" CommandName="Assign" Value="btnAssign" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" RenderMode="Lightweight" CssClass="DocumentAssign" OnClientItemClosing="OnClientItemClosing" ID="radmen" ClickToOpen="true" OnClientItemClicked="MenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="assign">
                                                        <Items>
                                                            <telerik:RadMenuItem>
                                                                <ItemTemplate>
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:LinkButton runat="server" ID="btnAssign" CssClass="btnToolbarAssign" OnClick="btnAssign_Click">
                                                                                            <div class="Icon">
                                                                                               &nbsp; 
                                                                                            </div>
                                                                                </asp:LinkButton>
                                                                                &nbsp;&nbsp;
                                                                                        <asp:LinkButton runat="server" ID="btnCancelAssign" CssClass="btnToolbarCancelAssign" OnClientClick="return CloseAssignMenu()">
                                                                                            <div class="Icon">
                                                                                                               &nbsp; 
                                                                                                            </div>
                                                                                        </asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblDueDate" Text="Due Date" runat="server" meta:Resourcekey="lblDueDate"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <span runat="server" id="rmd_rdCalendar" style="display: block">
                                                                                    <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                        SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                                        EnableTyping="True">
                                                                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                            runat="server">
                                                                                        </DateInput>
                                                                                        <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                                        </Calendar>
                                                                                    </telerik:RadDatePicker>
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblUser" Text="User" runat="server" meta:Resourcekey="lblUser"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <telerik:RadComboBox ID="ddlCalendarUsers" runat="server" AllowCustomText="true" ZIndex="9001"
                                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                                                                    OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="150px">
                                                                                </telerik:RadComboBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton Value="btnDeleteAssign" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarDeleteAssign" SecurityButtonType="Calendar" ImageUrl="Images/Toolbar/user.png" CommandName="DeleteAssign" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" CausesValidation="false"
                                        Target="_blank" NavigateUrl="Help/PMWebUserManual_Portfolio.htm">
                                    </telerik:RadToolBarButton>

                                     <telerik:RadToolBarButton ID="btnUpdateAsset" PostBack="false" runat="server" CssClass="lnkCreateNext" OuterCssClass="HideOnMobileToolbar" Value="UpdateAsset" Tooltip="Update Assets"
                            meta:resourcekey="btnUpdateAsset" CommandName="CreateNext"   OnClick="return ConfirmUpdateAsset();" Text="Update Asset" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                                </Items>
                            </telerik:radtoolbar>
                          
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
         </telerik:RadAjaxPanel>
       </div>
    <telerik:radtabstrip onclienttabselecting="onTabSelecting" id="tbsDocument" selectedindex="0" scrollchildren="true" scrollbuttonsposition="Left" cssclass="documentTabs"
        runat="server" multipageid="mlpInspection" skin="Default" width="100%" enableviewstate="True"
        causesvalidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Image" Value="Image" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Checklists" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:radtabstrip>

    <telerik:radmultipage id="mlpInspection" runat="server" selectedindex="0" cssclass="documentMultiPages" renderselectedpageonly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" meta:Resourcekey="lblProject" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                            Skin="Default" CausesValidation="false"
                                            Filter="Contains" MarkFirstMatch="true" AutoPostBack="true"
                                            NoWrap="true" Width="100%" Height="300px"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProject"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProject"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" meta:Resourcekey="lblLocation" Text="Location"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLocation" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" meta:Resourcekey="lblPhase"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInspectionId" runat="server" meta:Resourcekey="lblInspectionId"
                                            Text="Inspection ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtInspectionId" Text="" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" meta:Resourcekey="rfvCode"
                                            ValidationGroup="Save" ControlToValidate="txtInspectionId" CssClass="Validator"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblIDUnique" meta:Resourcekey="lblIDUnique" runat="server" Text="ID must be unique."
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" meta:Resourcekey="lblDescription" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" meta:Resourcekey="lblType" Text="Type*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Skin="Default" CloseDropDownOnBlur="true" AutoPostBack="true"
                                            Width="100%" Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Height="300px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvTypes" runat="server" ControlToValidate="ddlTypes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvTypes" runat="server" ControlToValidate="ddlTypes"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Reuqired">
                                        </asp:CustomValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:Resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Width="100%" Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested"
                                            Height="300px" EnableLoadOnDemand="True" AutoPostBack="true" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" meta:Resourcekey="lblReference" runat="server" Text="Reference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblInspectionDate" Text="Inspection Date">  </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDate" style="display: block">
                                        <telerik:RadDatePicker ID="dtpDate" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default" Width="100%">
                                            <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar4" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                            </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime" meta:Resourcekey="lbInspectionlTime" runat="server" Text="InspectionTime"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="rtpTime" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default" Width="100%">
                                            <DateInput ID="DateInput5" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar5" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        
                                  
                                          <div style="float: left;">
                                                    <asp:Label ID="lblInspectedBy" runat="server" meta:ResourceKey="lblInspectedBy" Text="Inspected By"></asp:Label>
                                            </div>
                                               <div style="float: right;">
                                                    <asp:LinkButton runat="server" ID="imgfilter"
                                                        OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlInspectedBy'),'Contacts')"
                                                        CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            
                                        
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlInspectedBy" runat="server" Width="100%" DropDownWidth="490px"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvSubmittedBy" runat="server" ControlToValidate="ddlInspectedBy"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvSubmittedBy" runat="server" ControlToValidate="ddlInspectedBy"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />


                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInspectionPointColor" meta:Resourcekey="lblInspectionPointColor" runat="server" Text="Inspection Point Color"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <div id="divInspectionColor" class="InspectionColor" onclick="toggleRCP();" runat="server">
                                        </div>
                                        <telerik:RadColorPicker runat="server" ID="InspectionColorPicker" ShowIcon="false" CssClass="Hide NewColorPicker"
                                            KeepInScreenBounds="true" ShowEmptyColor="false" OnClientColorChange="UpdateUserColor" Columns="18" Width="240px"
                                            PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true">
                                        </telerik:RadColorPicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status / Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="Right" 
                                                        Text=""></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>
                          
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc1:AssetRotator ID="PMrot" runat="server" />
                        </div>
                        <div class="col-4 col-4-right">
                            <uc2:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>

               <div id="EmptyInspectionTypes" runat="server" style="display: table; text-align: center; height: 100%; width: 100%;padding-top:300px" visible="false">
                    <div style="display: table-cell; vertical-align: middle">
                        <asp:Image ID="imgEmptyInspectionTypes" Style="height: 200px; width: 200px; display: inline-block" runat="server" ImageUrl="CSS/Images/NoInspectionTypes.png"></asp:Image>
                        <br />
                        <asp:Label ID="lblEmptyInspectionTypes" runat="server" meta:Resourcekey="lblEmptyInspectionTypes" Text="Before creating an inspection,at Least one inspection Type must be defined </br> Contact your system administrator" Style="font-size: 14px; color: #666;"></asp:Label>
                    </div>
                </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc3:InspectionDetail ID="InspectionDetail1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvImage" runat="server">
            <uc4:Image ID="InspectionImage1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc5:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc6:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc7:DocumentClauses id="DocumentClauses1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc8:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc9:DocumentAttachments id="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc10:WorkflowDocument id="WorkflowDocument" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam id="DocumentTeam1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc12:Notificationlog id="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:radmultipage>



</asp:Content>
