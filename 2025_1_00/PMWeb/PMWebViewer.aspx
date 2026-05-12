<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PMWebViewer.aspx.vb" Inherits="Website.PMWebViewer" %>

<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="PMWebViewerDrawing.ascx" TagName="PMWebViewerDrawing" TagPrefix="uc6" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="PMWebViewerMeasurements.ascx" TagName="PMWebViewerMeasurement" TagPrefix="uc8" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>
<%@ Register Src="PMWebViewerDocumentSettings.ascx" TagName="PMWebViewerSettings" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <%--     <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="mlpPMWebViewer">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPMWebViewer" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPMWebViewer" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>
    <asp:PlaceHolder ID="phPMWebViewer" runat="server"></asp:PlaceHolder>
    <script src="JS/raphael-min.js" type="text/javascript"></script>
    <script src="JS/Redlining/wz_jsgraphics.js" type="text/javascript"></script>
    <script src="JS/Redlining/Redlining.js" type="text/javascript"></script>
    <script src="JS/Redlining/raphael.free_transform.js" type="text/javascript"></script>
    <script src="JS/Redlining/Raphael.inlineTextEditing.js"></script>

    <script type="text/javascript">
        var Grid;
        var btnDelete;
        var initScrollTop = 0;
        var initScrollLeft = 0;
        var initClientMouseX = 0;
        var initClientMouseY = 0;
        var ClientMouseX = 0;
        var ClientMouseY = 0;
        var cursorType = "Default";
        var autoSave = true; var printAllPages = 'False';
        var CanEdit = '<%= UserRight.CanEdit%>';
        var editedObject = '';
        function confirmDelete() { return confirm(Msg_ConfirmDeleteDocument); }

        function GridCreated(sender, args) {
            Grid = $find($("[id$=rdgPMWebViewerDocumentSettings]")[0].id);
            btnDelete = $($("a[id$=btnDelete]")[0]);

        }
        function rdgPMWebViewerDocumentSettings_OnRowSelecting(sender, eventArgs) {
            var CanDelete = $("#" + eventArgs.get_id())[0].getAttribute("CanDelete")
            if (btnDelete[0] == 'undefined' && btnDelete[0].id == null)
                return;

            if (Grid.get_masterTableView().get_selectedItems().length > 0) {
                if (btnDelete.is(":visible") == true) {
                    if (CanDelete == "false") { btnDelete.hide(); }
                }
            }
            else {
                if (CanDelete == "false") {
                    btnDelete.hide();
                } else {
                    btnDelete.show();
                }
            }
        }
        function OpenStampsTextPopup(LineId, hdnStampTextIds, IsInEditMode, Source) {
            return OpenPOPUp('PMWebViewerSettingsStampsTextPopup.aspx?LineId=' + LineId + '&hdnStampTextIds=' + hdnStampTextIds + '&IsInEditMode=' + IsInEditMode + '&Source=' + Source, 400, 300, true);
        }
        function OpenStampsImagesPopup(LineId, hdnStampImagesIds, IsInEditMode, Source) {
            return OpenPOPUp('AllowAccesTostampsPopUp.aspx?LineId=' + LineId + '&hdnStampImagesIds=' + hdnStampImagesIds + '&IsInEditMode=' + IsInEditMode + '&Source=' + Source, 400, 300, true);
        }

        function DrawTextRect(paper, textElement) {
            var textbox = textElement.getBBox();
            var NoteRect = paper.rect((textbox.x - 3) * intZoomMultiplier, (textbox.y - 3) * intZoomMultiplier, (textbox.width + 5) * intZoomMultiplier, (textbox.height + 5) * intZoomMultiplier).attr(
                                {
                                    //fill: currColor,
                                    stroke: currColor,
                                    "stroke-width": 2
                                }).click(GoToLink);

            return NoteRect;
        }

        var ShowHeader;
        var HideHeader;

        function ToggleAllPages(sender) {
            if (sender.checked) {
                printAllPages = 'True';
            }
            else { printAllPages = 'False'; }
        }
        function ToggleAutoSave(sender) {
            if (sender.checked) {
                autoSave = 'True';
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/TogglePMWebViewerAutoSave",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ autosave: true }),
                    dataType: "json",
                    async: true
                });
            } else {
                autoSave = 'False';
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/TogglePMWebViewerAutoSave",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ autosave: false }),
                    dataType: "json",
                    async: true
                });
            }
            if (autoSave == 'True') {
                AutoSaveDrawings()
            }
            return false;
        }

        function AutoSaveDrawings() {
            var arrayAll = [];
            arrayAll.push(arrDrawings);
            arrayAll.push(arrMeasures);
            PageMethods.AutoSaveDrawings(arrayAll, drawingsCateg, function (response) {
                update_Ids(String(response));
                if (autoSave == 'True' && drawingsCateg == 'ANN') {
                    __doPostBack('ctl00$CPH1$PMWebViewerDrawing1$rdgActions$ctl00$ctl02$ctl00$btnRefresh', '');

                }
            });

            return false;
        }

        function AutoSavePixelColor() {
            PageMethods.AutoSavePixelColor(currColor, intThickness - 1);
        }
        function AutoDeleteDrawings(Id, Source) {
            PageMethods.AutoDeleteDrawings(Id, Source)
            return false;
        }
        function UpdateDrawingOptions(color, thickness) {
            PageMethods.UpdateDrawingOptions(color, thickness - 1)
            return false;
        } 
        function UpdateLastSelectedTool(tool) {
            PageMethods.UpdateLastSelectedTool(tool)
            return false;
        }
        function update_Ids(Ids) {
            var arrId = Ids.split(';')
            if (drawingsCateg == 'ANN') {
                for (var i = 0; i < arrDrawings.length; i++) {
                    arrDrawings[i].ID = arrId[i];
                }
            }
            else {
                for (var i = 0; i < arrMeasures.length; i++) {
                    arrMeasures[i].ID = arrId[i];
                }
            }
        }

        function UpdateImageSize() {
            if (imgCanvasInitHeight < 0) imgCanvasInitHeight = 0
            if (imgCanvasInitWidth < 0) imgCanvasInitWidth = 0
            var size = parseInt(imgCanvasInitWidth) + ';' + parseInt(imgCanvasInitHeight)

            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateImageSize",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ Source: drawingsCateg, Size: size }),
                dataType: "json",
                async: true
            });
        }
    </script>

    <link href="CSS/Ribbon.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .EditScales .rtbIcon {
            background-image: url(css/Images/ResponsiveIcons/24Enabled.png);
            background-position: -888px 0px !important;
            height: 24px;
            width: 24px;
        }

        .rdgActions.RadGrid.RadGrid_Default .rgDataDiv {
            height: 373px !important;
        }

        div#ctl00_CPH1_PMWebViewerDrawing1_RadSplitter1 {
            max-width: calc(100% - 5px);
            width: calc(100% - 5px) !important;
        }

        div#ctl00_CPH1_PMWebViewerDrawing1_cmDrawing_i1_i0_RadToolbar1 .rtbOuter {
            background: white !important;
        }

        .RadSplitter_Default .rspPaneTabContainer {
            background-image: url(css/Images/Splitter/ExpandCollapseBarsCommands.gif) !IMPORTANT;
            background-color: #FAFAFA;
            background-position: 1px 0 !important;
            BORDER: none;
        }

        .drawing-viewer-toolbar .RadSlider_Default div.rslHorizontal a.rslHandle.rslDecrease {
            width: 16px;
            height: 16px;
            background-image: url(css/Images/2007Small.png) !important;
            background-position: -3296px 0px;
            margin: 3px;
        }

        .drawing-viewer-toolbar .RadSlider_Default div.rslHorizontal a.rslHandle.rslIncrease {
            width: 16px;
            height: 16px;
            background-image: url(css/Images/2007Small.png) !important;
            background-position: -3312px 0px;
            margin: 3px;
            right: -8px;
        }

        .drawing-viewer-toolbar .RadSlider_Default div.rslHorizontal .rslTrack {
            left: 22px !important;
        }

        .drawing-viewer-toolbar .switch {
            position: relative;
            display: inline-block;
            width: 20px;
            height: 11px;
            bottom: -1px;
        }

        .drawing-viewer-toolbar .slider:before {
            position: absolute;
            content: "";
            height: 9px;
            width: 9px;
            left: -3px;
            bottom: -3px;
            background-color: #FFF;
            transition: 200ms;
            -webkit-transition: 200ms;
            border: 2px solid #999;
        }

        .drawing-viewer-toolbar input:checked + .slider:before {
            box-shadow: 0 0 1px #999;
            background: #FFF;
            bottom: 0px;
            border: none;
            left: -5px;
            height: 11px;
            width: 11px;
        }

        .colTable .RadioCss label {
            line-height: 16px;
        }

        .colTable .RadioCss label {
            margin-top: 0 !important;
        }

        .BrowseFileManager {
            color: #666666 !important;
            margin-top: 5px;
        }

        /*.DrawMenu .rtbOuter{
           background-color:white !important;
       }*/

        /*.ToolBar ,.documentTabs,.toolbartop{
            z-index:5 !important;
       }*/
        .drawing-viewer-toolbar a {
            min-height: 16px;
        }

        .drawing-viewer-toolbar li.rtbItem {
            margin-bottom: 18px;
        }

        .drawing-viewer-toolbar li.rtbSeparator {
            max-height: 30px;
            margin-bottom: 20px;
        }

        .drawing-viewer-toolbar .rtbLevel1 li.rtbItem {
            margin-bottom: 4px;
        }

        .drawing-viewer-toolbar .rtbItemHovered .ToolbarUndo .rtbIcon {
            background-image: url('css/Images/ResponsiveIcons/16Enabled.png') !important;
            background-position: -768px 0px;
        }

        .drawing-viewer-toolbar .rtbItemHovered .ToolbarRedo .rtbIcon {
            background-image: url('css/Images/ResponsiveIcons/16Enabled.png') !important;
            background-position: -784px 0px;
        }

        .drawing-viewer-toolbar .rtbItemFocused .ToolbarUndo .rtbIcon {
            background-image: url('css/Images/ResponsiveIcons/16Enabled.png') !important;
            background-position: -768px 0px;
        }

        .drawing-viewer-toolbar .rtbItemFocused .ToolbarRedo .rtbIcon {
            background-image: url('css/Images/ResponsiveIcons/16Enabled.png') !important;
            background-position: -784px 0px;
        }

        .drawing-viewer-toolbar .rtbItemHovered .rtbIcon {
            background-image: url(css/Images/2007Small.png) !important;
        }

        .drawing-viewer-toolbar .rtbDropDownExpanded .rtbIcon {
            background-image: url(css/Images/2007Small.png) !important;
        }

        .drawing-viewer-toolbar .rtbItemFocused .rtbIcon {
            background-image: url(css/Images/2007Small.png) !important;
        }

        .drawing-viewer-toolbar .rtbDisabled {
            opacity: 0.3 !important;
        }

        .HideMenuItem .rmLink, .HideMenuItem .rmRootLink {
            display: none !important;
        }

        .stampItems > div {
            border: 3px solid red;
            padding: 1px;
            margin: 5px;
            cursor: pointer;
            float: left;
            white-space: nowrap;
            font-size: 14px;
            color: Red;
        }

            .stampItems > div:hover {
                border: 3px dashed red;
            }

        .rmRootGroup, .rmHorizontal {
            border: none !important;
            background-color: Transparent !important;
        }

        .RadMenu .rmGroup .rmText {
            padding: 0 30px 0 30px !important;
        }

        .ViewerCanvas svg {
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
        }

        #Canvas > div {
            position: absolute !important;
            z-index: 10;
        }
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {
                canvas = $('#Canvas');
                if (canvas.length > 0) {
                    if (!paper) {
                        paper = new Raphael("Canvas");
                    }
                    if (!polylineMSR) { polylineMSR = paper.set(); }
                    originalAnnCount = arrDrawings.length;
                    originalMsrCount = arrMeasures.length;
                    InitiateSizes();
                    if (drawingsCateg == "") {
                        var divId = document.getElementById("ctl00_CPH1_mlpPMWebViewer").children[0].getAttribute("Id")
                        if (divId.indexOf("Measurement") > 0) {
                            drawingsCateg = "MSR"
                            //  ReDrawMSR()
                        }
                        else {
                            drawingsCateg = "ANN"
                            //     ReDrawANN()
                        }
                    }

                    var cbxAllPages = document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i3_cbxAllPages');
                    if (cbxAllPages) {
                        printAllPages = cbxAllPages.checked
                    }

                    if (drawingsCateg == 'ANN')
                        var cbxAutoSave = document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i13_cbxAutoSave');
                    else {
                        var cbxAutoSave = document.getElementById('ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i14_cbxAutoSave');
                        addTextToMsr = document.getElementById('ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i12_cbxText').checked;
                    }


                    autoSave = '<%= CBool(PM.HomeInfo.PMWebViewerAutoSave) %>'
                    if (cbxAutoSave) {
                        cbxAutoSave.checked = autoSave == 'False' ? false : true;
                    }
                    arrDeletedDrawings = [];
                    arrDeletedMeasures = [];
                    leftOffset = $('#Canvas').offset().left;
                    topOffset = $('#Canvas').offset().top;
                    $(".stampItem").click(function (e) {
                        if (drawingsCateg == 'ANN') {
                            //var menu = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i9_RadMenu1_ClientState");
                            //var item = menu.findItemByText('Stamps');
                            tempStamp = $(this).html();
                            clickNumber = 0;
                            tempType = 'stamp';
                            //item.close();
                        }
                    });
                    $('#menuStamps').click(function (e) {
                        if (drawingsCateg == 'ANN') {
                            var menu = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i9_RadMenu1_ClientState");
                            var item = menu.findItemByText('Stamps');
                            if (item) {
                                item.open();
                            }
                        }
                    });



                    $(canvas).on('touchstart mousedown', function (e) {
                        var offset = $(canvas).offset();

                        if (e.type == 'touchstart') {
                            mouseDownX = e.originalEvent.touches[0].pageX - offset.left;
                            mouseDownY = e.originalEvent.touches[0].pageY - offset.top;
                            initClientMouseX = e.originalEvent.touches[0].pageX + $('#divZoomer').scrollLeft();
                            initClientMouseY = e.originalEvent.touches[0].pageY + $('#divZoomer').scrollTop();
                        } else {
                            mouseDownX = e.pageX - offset.left;
                            mouseDownY = e.pageY - offset.top;
                            initClientMouseX = e.clientX + $('#divZoomer').scrollLeft();
                            initClientMouseY = e.clientY + $('#divZoomer').scrollTop();
                        }


                        initScrollTop = $('#divZoomer').scrollTop();
                        initScrollLeft = $('#divZoomer').scrollLeft();

                        mouseX = mouseX + $(divZoomer).scrollLeft();
                        mouseY = mouseY + $(divZoomer).scrollTop();

                        countId = countId + 1;
                        if (textInput) {
                            textInput.blur();
                        }
                        if (e.which == 1 || e.type == 'touchstart') {
                            isMouseDown = 1
                            if (tempType != '' && isEdit != 'Edit' && cursorType == 'Draw') {
                                $('input').each(function () {
                                    $(this).trigger('blur');
                                })
                                e.preventDefault();

                                switch (tempType) {
                                    case 'line':
                                        shap = drawLine(mouseDownX, mouseDownY, mouseDownX, mouseDownY);
                                        break;
                                    case 'rectangle':
                                        shap = drawRectangle(mouseDownX, mouseDownY, 0, 0)
                                        currX = shap.attrs.x;
                                        currY = shap.attrs.y;
                                        break;
                                    case 'bubble':
                                        shap = drawBubbleRectangle(mouseDownX, mouseDownY, 0, 0)
                                        currX = shap.attrs.x;
                                        currY = shap.attrs.y;
                                        break;
                                    case 'ellipse':
                                        shap = drawCircle(mouseDownX, mouseDownY, mouseDownX, mouseDownY);
                                        break;
                                    case 'polyline':

                                        if (clickNumber == 0) {
                                            clickNumber = clickNumber + 1
                                            polyX = mouseDownX;
                                            polyY = mouseDownY;
                                            shap = drawPolyLine(polyX, polyY, mouseDownX, mouseDownY);
                                        }
                                        else {
                                            countId = countId - 1
                                            polyX = endLine.x;
                                            polyY = endLine.y;
                                            clickNumber = clickNumber + 1
                                            shap = drawPolyLine(polyX, polyY, mouseDownX, mouseDownY);

                                        }
                                        break;
                                    case 'polygon':

                                        if (clickNumber == 0) {
                                            clickNumber = clickNumber + 1

                                            polyX = mouseDownX;
                                            polyY = mouseDownY;
                                            shap = drawPolyLine(polyX, polyY, mouseDownX, mouseDownY);
                                        }
                                        else {
                                            clickNumber = clickNumber + 1
                                            countId = countId - 1
                                            polyX = endLine.x;
                                            polyY = endLine.y;
                                            shap = drawPolyLine(polyX, polyY, mouseDownX, mouseDownY);

                                        }
                                        break;
                                    case 'text':

                                        tempX1 = mouseDownX;
                                        tempY1 = mouseDownY;
                                        EnableToolBarButton(undoIndex, true);
                                        var font = fontSize + ";" + fontWeight + ";" + fontStyle;
                                        arrDrawings.push({ 'TYPE': 'TEXT', 'ID': '', 'TRANSFORM': '', 'VALUE': textFromPopup, 'FONT': font, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'text' + countId });
                                        fontSize = fontSize.replace('px', '')
                                        var scaledSize = fontSize * intZoomMultiplier;
                                        var text = paper.text(tempX1, tempY1 + 7, textFromPopup).attr(
                                                             {
                                                                 font: scaledSize + 'px "Segoe UI,Arial,Helvetica,sans-serif"',
                                                                 "font-family": "Segoe UI,Arial,Helvetica,sans-serif",
                                                                 "text-anchor": "start",
                                                                 stroke: 'none',
                                                                 fill: currColor,
                                                                 "font-style": fontStyle,
                                                                 "font-weight": fontWeight,
                                                                 "text-anchor": "start",
                                                             });

                                        text.id = 'text' + countId;
                                        elemClicked = 'text' + countId;

                                        text.mousedown(function (e) {
                                            e.preventDefault();
                                            clicks++;

                                            setTimeout(function () { clicks = 0 }, 300)
                                            if (clicks == 2)
                                            { ObjectDblClicked(this); }
                                            else
                                            {
                                                if (e.button == 2) {
                                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                                    OpenMenu(this, upX, upY);
                                                }
                                            }

                                        });

                                        // text.dblclick(function () { ObjectDblClicked(this); });

                                        tempType = '';
                                        if (autoSave == 'True') {
                                            AutoSaveDrawings()
                                        }
                                        break;

                                    case 'stamp':
                                        tempX1 = mouseDownX;
                                        tempY1 = mouseDownY;
                                        var hdnStamp = $("input[id$=hdnStamp]").val();
                                        var stamps = hdnStamp.split(";");
                                        var type = stamps[0];

                                        if (type == 'Text') {
                                            var value = stamps[1];
                                            tempStamp = value;
                                            EnableToolBarButton(undoIndex, true);
                                            arrDrawings.push({ 'TYPE': 'STAMP', 'ID': '', 'TRANSFORM': '', 'VALUE': value, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'stamp' + countId });
                                            var scaledSize = 14 * intZoomMultiplier;

                                            var text = paper.text(tempX1, tempY1, tempStamp).attr(
                                                              {
                                                                  font: scaledSize + 'px "Segoe UI,Arial,Helvetica,sans-serif"',
                                                                  "font-family": "Segoe UI,Arial,Helvetica,sans-serif",
                                                                  "text-anchor": "start",
                                                                  stroke: 'none',
                                                                  fill: "red",

                                                                  "font-weight": "normal"
                                                              });
                                            text.id = 'stamp' + countId;

                                            DrawStamp(paper, text, '')
                                            if (autoSave == 'True') {
                                                AutoSaveDrawings()
                                            }

                                        }
                                        else if (type == 'Image') {
                                            var height = stamps[1];
                                            var width = stamps[2];
                                            var value = stamps[3];
                                            var strval = value + ';' + width + ';' + height;
                                            arrDrawings.push({ 'TYPE': 'IMAGESTAMP', 'ID': '', 'TRANSFORM': '', 'VALUE': strval, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'imgstamp' + countId });
                                            EnableToolBarButton(undoIndex, true);
                                            var img = paper.image(value, tempX1, tempY1, width, height)
                                            img.mousedown(function (e) {
                                                e.preventDefault();
                                                clicks++;

                                                setTimeout(function () { clicks = 0 }, 300)
                                                if (clicks == 2)
                                                { ObjectDblClicked(this); }
                                                else
                                                {
                                                    if (e.button == 2) {
                                                        var upX = e.clientX + $(window).scrollLeft() - 5;
                                                        var upY = e.clientY + $(window).scrollTop() - 5;
                                                        OpenMenu(this, upX, upY);
                                                    }
                                                }

                                            });
                                            if (autoSave == 'True') {
                                                AutoSaveDrawings()
                                            }
                                            img.id = 'imgstamp' + countId;

                                            //  img.dblclick(function () { ObjectDblClicked(this); });

                                        }
                                        tempType = '';
                                        break;

                                    case 'space':
                                        tempX1 = mouseDownX;
                                        tempY1 = mouseDownY;
                                        EnableToolBarButton(undoIndex, true);
                                        arrDrawings.push({ 'TYPE': 'SPACE', 'ID': '', 'VALUE': tempStamp, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'SPACEID': spaceId, 'RANDOM': '', 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'SPACE_' + spaceId + '_' + strRnd });
                                        var img = paper.image("Images/Redlining/smallSpaceOffice2007.png", tempX1, tempY1, 16, 16)
                                        img.id = 'SPACE_' + spaceId + '_' + strRnd;

                                        img.click(OpenSpaceToolTip)

                                        var text = paper.text(tempX1 + 18, tempY1 + 7, tempStamp).attr(
                                        {
                                            "text-anchor": "start",
                                            stroke: 'none',
                                            fill: currColor,
                                            "stroke-width": intThickness,
                                            font: '12px "verdana,geneva,helvetica,sans-serif"',
                                            "font-family": "verdana,geneva,helvetica,sans-serif"

                                        }).click(OpenSpaceToolTip)
                                        text.mousedown(function (e) {
                                            if (e.button == 2) {

                                                var upX = e.clientX + $(window).scrollLeft() - 5;
                                                var upY = e.clientY + $(window).scrollTop() - 5;
                                                OpenMenu(this, upX, upY);
                                            }
                                        });
                                        var underline = underlineText(paper, text)
                                        underline.ID = 'SPACE_' + spaceId + '_' + strRnd;
                                        var SpaceSet = paper.set()
                                        SpaceSet.push(text);
                                        SpaceSet.push(img);
                                        SpaceSet.push(underline);
                                        SpaceSet.mousedown(function (e) {
                                            if (e.button == 2) {

                                                var upX = e.clientX + $(window).scrollLeft() - 5;
                                                var upY = e.clientY + $(window).scrollTop() - 5;
                                                OpenMenu(this, upX, upY);
                                            }
                                        });
                                        SpaceSet.ID = 'SPACE_' + spaceId + '_' + strRnd;

                                        arrSets.push(SpaceSet);
                                        text.id = 'SPACE_' + spaceId + '_' + strRnd;
                                        if (autoSave == 'True') {
                                            AutoSaveDrawings()
                                        }
                                        break;

                                    case 'equipment':
                                        tempX1 = mouseDownX;
                                        tempY1 = mouseDownY;
                                        EnableToolBarButton(undoIndex, true);
                                        arrDrawings.push({ 'TYPE': 'EQUIPMENT', 'ID': '', 'VALUE': tempStamp, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'EQUIPMENTID': equipmentId, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'EQU_' + countId });
                                        var img = paper.image("Images/Redlining/smallEquipmentOffice2007.png", tempX1, tempY1, 16, 16)
                                        img.id = 'EQU_' + countId;
                                        var text = paper.text(tempX1 + 18, tempY1 + 7, tempStamp).attr(
                                             {
                                                 "text-anchor": "start",
                                                 stroke: 'none',
                                                 fill: currColor,
                                                 font: '12px "verdana,geneva,helvetica,sans-serif"',
                                                 "font-family": "verdana,geneva,helvetica,sans-serif"

                                             })


                                        text.id = 'EQU_' + countId;
                                        var underline = underlineText(paper, text)
                                        underline.ID = 'EQU_' + countId;
                                        var equSet = paper.set()
                                        equSet.push(text);
                                        equSet.push(img);
                                        equSet.push(underline);
                                        equSet.mousedown(function (e) {
                                            if (e.button == 2) {

                                                var upX = e.clientX + $(window).scrollLeft() - 5;
                                                var upY = e.clientY + $(window).scrollTop() - 5;
                                                OpenMenu(this, upX, upY);
                                            }
                                        });
                                        equSet.ID = 'EQU_' + countId;

                                        arrSets.push(equSet);

                                        if (autoSave == 'True') {
                                            AutoSaveDrawings()
                                        }
                                        break;
                                    case 'NOTE':
                                        tempX1 = mouseDownX;
                                        tempY1 = mouseDownY;
                                        str = NoteValue.split("~!@");
                                        var font = NFont.split(';');

                                        arrDrawings.push({ 'TYPE': 'NOTE', 'ID': 'NOTE_' + str[0] + '_' + NoteNumber, 'VALUE': NoteValue, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'FONT': NFont, 'ISNEW': 'true', 'RANDOM': '', 'COLOR': currColor, 'STROKE': intThickness - 1, 'DRAWINGCOUNT': NoteNumber, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'NOTE_' + str[0] + '_' + NoteNumber + '~!@' + NoteValue + '~!@' + font.join("~!@") });

                                        var NoteRect = paper.rect(tempX1 - 10 * intZoomMultiplier, tempY1 - 10 * intZoomMultiplier, 20 * intZoomMultiplier, 20 * intZoomMultiplier).attr(
                                                                {
                                                                    fill: currColor
                                                                })

                                        NoteRect.id = 'NOTE_' + str[0] + '_' + NoteNumber + '~!@' + NoteValue + '~!@' + font.join("~!@");//'NOTE_' + str[0] + '_' + NoteNumber;

                                        NoteRect.click(function (e) {
                                            Click++;
                                            if (Click == 1) {
                                                me = this;
                                                timer = setTimeout(function () {
                                                    OpenLinkToolTip(me);
                                                    Click = 0;
                                                }, 500)
                                            }
                                        });

                                        NoteRect.dblclick(function () {
                                            clearTimeout(timer);
                                            var hdnNotes = $("[id$=hdnNotes]")[0];
                                            hdnNotes.value = this.id;
                                            OpenViewerNotesPopup('Edit');
                                            Click = 0;
                                        });

                                        var text = paper.text(tempX1, tempY1, NoteNumber).attr(
                                                                    {
                                                                        "text-anchor": "middle",
                                                                        stroke: 'none',
                                                                        //fill: currColor,
                                                                        "stroke-width": intThickness,
                                                                        font: '12px "verdana,geneva,helvetica,sans-serif"',
                                                                        "font-family": "verdana,geneva,helvetica,sans-serif",
                                                                        "color": "black"
                                                                        // "font-weight": font[1],
                                                                        // "font-style": font[2],
                                                                        //note: 'NOTE_' + str[0] + '_' + NoteNumber + '~!@' + NoteValue + '~!@' + font.join("~!@")

                                                                    })//.click(function () { OpenLinkToolTip(this); });

                                        text.click(function (e) {
                                            Click++;
                                            if (Click == 1) {
                                                me = this;
                                                timer = setTimeout(function () {
                                                    OpenLinkToolTip(me);
                                                    Click = 0;
                                                }, 500)
                                            }
                                        });

                                        text.dblclick(function () {
                                            clearTimeout(timer);
                                            var hdnNotes = $("[id$=hdnNotes]")[0];
                                            hdnNotes.value = this.id;
                                            OpenViewerNotesPopup('Edit');
                                            Click = 0;
                                        });

                                        text.id = 'NOTE_' + str[0] + '_' + NoteNumber + '~!@' + NoteValue + '~!@' + font.join("~!@");//'NOTE_' + str[0] + '_' + NoteNumber;

                                        var noteSet = paper.set()
                                        noteSet.push(text);
                                        noteSet.push(NoteRect);
                                        noteSet.mousedown(function (e) {
                                            if (e.button == 2) {

                                                var upX = e.clientX + $(window).scrollLeft() - 5;
                                                var upY = e.clientY + $(window).scrollTop() - 5;
                                                OpenMenu(this, upX, upY);
                                            }
                                        });

                                        noteSet.ID = 'NOTE_' + str[0] + '_' + NoteNumber + '~!@' + NoteValue + '~!@' + font.join("~!@");//'NOTE_' + str[0] + '_' + NoteNumber;


                                        arrSets.push(noteSet);

                                        tempType = '';
                                        NoteNumber = parseInt(NoteNumber) + 1;
                                        EnableToolBarButton(undoIndex, true);
                                        if (autoSave == 'True') {
                                            AutoSaveDrawings()
                                        }
                                        break;

                                    case 'LinkedRecord':
                                        tempX1 = mouseDownX;
                                        tempY1 = mouseDownY;
                                        strRnd = '';
                                        EnableToolBarButton(undoIndex, true);
                                        arrDrawings.push({ 'TYPE': 'LinkedRecord', 'ID': '', 'VALUE': tempStamp, 'X': tempX1 / intZoomMultiplier, 'Y': tempY1 / intZoomMultiplier, 'RECORDTYPEID': LinkedRecordTypeId, 'RECORDNUMBER': LinkedRecordNumber, 'RECORDID': LinkedRecordId, 'RECORDTYPE': LinkedRecordType, 'RANDOM': '', 'COLOR': currColor, 'STROKE': intThickness - 1, 'DRAWINGCOUNT': LinkNumber, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'linkedrecord' + '_' + LinkedRecordType + '_' + LinkedRecordId });

                                        var ellipse = paper.ellipse(tempX1, tempY1, 10 * intZoomMultiplier, 10 * intZoomMultiplier);
                                        ellipse.id = 'linkedrecord_' + LinkedRecordType + '_' + LinkedRecordId;
                                        ellipse.attr({
                                            fill: currColor
                                        });

                                        var text = paper.text(tempX1, tempY1, LinkNumber).attr(
                                        {
                                            "text-anchor": "middle",
                                            stroke: 'none',
                                            //fill: currColor,
                                            "stroke-width": intThickness,
                                            font: '12px "verdana,geneva,helvetica,sans-serif"',
                                            "font-family": "verdana,geneva,helvetica,sans-serif"

                                        });
                                        text.id = 'linkedrecord_' + LinkedRecordType + '_' + LinkedRecordId;
                                        var linkedrecordSet = paper.set()
                                        linkedrecordSet.push(text);
                                        linkedrecordSet.push(ellipse);
                                        linkedrecordSet.mousedown(function (e) {
                                            if (e.button == 2) {

                                                var upX = e.clientX + $(window).scrollLeft() - 5;
                                                var upY = e.clientY + $(window).scrollTop() - 5;
                                                OpenMenu(this, upX, upY);
                                            }
                                        });

                                        linkedrecordSet.ID = 'linkedrecord_' + LinkedRecordType + '_' + LinkedRecordId;

                                        arrSets.push(linkedrecordSet);
                                        tempType = '';
                                        LinkNumber = parseInt(LinkNumber) + 1;
                                        if (autoSave == 'True') {
                                            AutoSaveDrawings()
                                        }
                                        break;
                                }


                            }
                        }
                    });// mouse down

                    $(canvas).on('touchend mouseup', function (e) {
                        if (isMouseDown == 1) {
                            isMouseDown = 0;

                            if ((e.which == 1 || e.type == 'touchend') && isEdit != 'Edit') {

                                switch (tempType) {
                                    case 'line':
                                        if (drawingsCateg == 'ANN') {
                                            var tempLength = LengthCalculation(startLine.x / intZoomMultiplier, startLine.y / intZoomMultiplier, endLine.x / intZoomMultiplier, endLine.y / intZoomMultiplier);
                                            if (tempLength > 0) {
                                                arrDrawings.push({ 'TYPE': 'LINE', 'ID': '', 'TRANSFORM': '', 'X1': startLine.x / intZoomMultiplier, 'Y1': startLine.y / intZoomMultiplier, 'X2': endLine.x / intZoomMultiplier, 'Y2': endLine.y / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'line' + countId });
                                                EnableToolBarButton(undoIndex, true);
                                                if (autoSave == 'True') {
                                                    AutoSaveDrawings()
                                                }
                                            }
                                        }
                                        else {
                                            var tempLength = LengthCalculation(startLine.x / intZoomMultiplier, startLine.y / intZoomMultiplier, endLine.x / intZoomMultiplier, endLine.y / intZoomMultiplier);
                                            if (scaleSetup == true) {
                                                if (tempLength > 0) {
                                                    document.getElementById(txtDisMapId).value = tempLength;
                                                    document.getElementById(txtDisGridId).value = '';
                                                }
                                            } else {
                                                var tempLength = LengthCalculation(parseInt(startLine.x / intZoomMultiplier), parseInt(startLine.y / intZoomMultiplier), parseInt(endLine.x / intZoomMultiplier), parseInt(endLine.y / intZoomMultiplier));
                                                if (tempLength > 0) {
                                                    EnableToolBarButton(undoIndex, true);
                                                    var msrSet = paper.set();
                                                    arrMeasures.push({ 'TYPE': 'LINE', 'ID': '', 'CENTROID': '', 'LENGTH': tempLength, 'AREA': 0, 'X1': startLine.x / intZoomMultiplier, 'Y1': startLine.y / intZoomMultiplier, 'X2': endLine.x / intZoomMultiplier, 'Y2': endLine.y / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'line' + countId });
                                                    var arrCenterPoints = [];
                                                    arrCenterPoints.push({ X: startLine.x, Y: startLine.y });
                                                    arrCenterPoints.push({ X: endLine.x, Y: endLine.y });
                                                    var CenterPoints = CalculateCentroid(arrCenterPoints);
                                                    var text = paper.text(CenterPoints[0].X, CenterPoints[0].Y + 7, '').attr({
                                                        stroke: 'none',
                                                        fill: currColor,
                                                        "stroke-width": intThickness,
                                                        font: '12px "verdana,geneva,helvetica,sans-serif"',
                                                        "font-family": "verdana,geneva,helvetica,sans-serif",
                                                        "font-weight": "normal",
                                                        "text-anchor": "middle"

                                                    });
                                                    text.id = msrShap.id;
                                                    elemClicked = msrShap.id
                                                    msrSet.push(msrShap);
                                                    msrSet.push(text);
                                                    msrSet.ID = msrShap.id;
                                                    msrSet.mousedown(function (e) {
                                                        if (e.button == 2) {
                                                            var upX = e.clientX + $(window).scrollLeft() - 5;
                                                            var upY = e.clientY + $(window).scrollTop() - 5;
                                                            OpenMenu(this, upX, upY);
                                                        }
                                                    });

                                                    arrSets.push(msrSet);
                                                    if (autoSave == 'True') {
                                                        AutoSaveDrawings()
                                                    }
                                                    if (addTextToMsr == true) {
                                                        editText(text, msrSet);
                                                    }
                                                    else {
                                                        msrSet.pop(text);
                                                    }
                                                }
                                            }
                                        }


                                        break;
                                    case 'bubble':
                                        var BBox = shap.getBBox();
                                        if (!BBox)
                                        { shap.remove(); }

                                        else if (BBox.width == 0 && BBox.height == 0)
                                        { shap.remove(); }
                                        else
                                        {
                                            shap.remove();
                                            var cloudX;
                                            var cloudY;
                                            var cloudWidth;
                                            var cloudHeight;

                                            mouseX = mouseX + $(divZoomer).scrollLeft();
                                            mouseY = mouseY + $(divZoomer).scrollTop();

                                            if (currX == mouseX || currY == mouseY) {
                                                break;
                                            }
                                            else {
                                                if (currX < mouseX) {

                                                    if (currY < mouseY) { cloudX = currX; cloudY = currY; cloudHeight = mouseY - currY; }
                                                    else { cloudX = currX; cloudY = mouseY; cloudHeight = currY - mouseY; }

                                                    cloudWidth = mouseX - currX;

                                                }
                                                else {

                                                    if (currY < mouseY) { cloudX = mouseX; cloudY = currY; cloudHeight = mouseY - currY; }
                                                    else { cloudX = mouseX; cloudY = mouseY; cloudHeight = currY - mouseY; }

                                                    cloudWidth = currX - mouseX;
                                                }
                                            }

                                            arrDrawings.push({ 'TYPE': 'BUBBLE', 'ID': '', 'TRANSFORM': '', 'CLOUDATTRIBUTES': [{ 'X': cloudX / intZoomMultiplier, 'Y': cloudY / intZoomMultiplier, 'WIDTH': cloudWidth / intZoomMultiplier, 'HEIGHT': cloudHeight / intZoomMultiplier }], 'COLOR': currColor, 'FONT': '', 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'BUBBLE_' + countId });
                                            drawBubbleCloud(cloudX, cloudY, cloudWidth, cloudHeight);
                                            if (autoSave == 'True') {
                                                AutoSaveDrawings()
                                            }
                                        }
                                        EnableToolBarButton(undoIndex, true);
                                        break;
                                    case 'rectangle':
                                        shap.id = 'rect' + countId
                                        var BBox = shap.getBBox();
                                        if (!BBox)
                                        { shap.remove(); }

                                        else if (BBox.width == 0 && BBox.height == 0)
                                        { shap.remove(); }
                                        else
                                        {

                                            if (drawingsCateg == 'ANN') {

                                                arrDrawings.push({ 'TYPE': 'RECTANGLE', 'ID': '', 'TRANSFORM': '', 'X1': shap.attrs.x / intZoomMultiplier, 'Y1': shap.attrs.y / intZoomMultiplier, 'X2': BBox.width / intZoomMultiplier, 'Y2': BBox.height / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'rect' + countId });
                                                if (autoSave == 'True') {
                                                    AutoSaveDrawings()
                                                }
                                            }
                                            else {
                                                var arrTempPoints = [];
                                                arrTempPoints.push({ X: parseInt(shap.attrs.x / intZoomMultiplier), Y: parseInt(shap.attrs.y / intZoomMultiplier) });
                                                arrTempPoints.push({ X: parseInt((shap.attrs.x + BBox.width) / intZoomMultiplier), Y: parseInt(shap.attrs.y / intZoomMultiplier) });
                                                arrTempPoints.push({ X: parseInt((shap.attrs.x + BBox.width) / intZoomMultiplier), Y: parseInt((shap.attrs.y + BBox.height) / intZoomMultiplier) });
                                                arrTempPoints.push({ X: parseInt(shap.attrs.x / intZoomMultiplier), Y: parseInt((shap.attrs.y + BBox.height) / intZoomMultiplier) });
                                                var tmpArea = PolygonAreaCalculation(arrTempPoints);
                                                var arrCenterPoints = [];
                                                arrCenterPoints.push({ X: shap.attrs.x, Y: shap.attrs.y });
                                                arrCenterPoints.push({ X: shap.attrs.x + BBox.width, Y: shap.attrs.y });
                                                arrCenterPoints.push({ X: shap.attrs.x + BBox.width, Y: shap.attrs.y + BBox.height });
                                                arrCenterPoints.push({ X: shap.attrs.x, Y: shap.attrs.y + BBox.height });
                                                arrMeasures.push({ 'TYPE': 'RECTANGLE', 'ID': '', 'CENTROID': '', 'LENGTH': 0, 'AREA': tmpArea, 'X1': shap.attrs.x / intZoomMultiplier, 'Y1': shap.attrs.y / intZoomMultiplier, 'X2': BBox.width / intZoomMultiplier, 'Y2': BBox.height / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'rect' + countId });
                                                var CenterPoints = CalculateCentroid(arrCenterPoints);
                                                var text = paper.text(CenterPoints[0].X, CenterPoints[0].Y + 7, '').attr({
                                                    stroke: 'none',
                                                    fill: currColor,
                                                    "stroke-width": intThickness,
                                                    font: '12px "verdana,geneva,helvetica,sans-serif"',
                                                    "font-family": "verdana,geneva,helvetica,sans-serif",
                                                    "font-weight": "normal",
                                                    "text-anchor": "middle"

                                                });
                                                text.id = 'rect' + countId;
                                                elemClicked = 'rect' + countId;
                                                var msrSet = paper.set();
                                                msrSet.push(shap);
                                                msrSet.push(text);
                                                msrSet.ID = 'rect' + countId;
                                                msrSet.mousedown(function (e) {
                                                    if (e.button == 2) {
                                                        var upX = e.clientX + $(window).scrollLeft() - 5;
                                                        var upY = e.clientY + $(window).scrollTop() - 5;
                                                        OpenMenu(this, upX, upY);
                                                    }
                                                });
                                                arrSets.push(msrSet);
                                                if (autoSave == 'True') {
                                                    AutoSaveDrawings()
                                                }
                                                if (addTextToMsr == true) {
                                                    editText(text, msrSet);
                                                }
                                                else {
                                                    msrSet.pop(text);
                                                }

                                            }
                                            EnableToolBarButton(undoIndex, true);
                                        }

                                        break;
                                    case 'ellipse':

                                        var X1 = center.x - radius.w
                                        var Y1 = center.y - radius.h

                                        if (intThickness > 1) {
                                            X1 = X1 - intThickness / 2;
                                            Y1 = Y1 - intThickness / 2;
                                        }
                                        var X2 = radius.w * 2;
                                        var Y2 = radius.h * 2;

                                        if (drawingsCateg == 'ANN') {
                                            var tmpArea = EllipseAreaCalculation(X2 / intZoomMultiplier, Y2 / intZoomMultiplier);
                                            if (tmpArea > 0) {
                                                EnableToolBarButton(undoIndex, true);
                                                arrDrawings.push({ 'TYPE': 'ELLIPSE', 'ID': '', 'TRANSFORM': '', 'X1': X1 / intZoomMultiplier, 'Y1': Y1 / intZoomMultiplier, 'X2': X2 / intZoomMultiplier, 'Y2': Y2 / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'ellipse' + countId });
                                                if (autoSave == 'True') {
                                                    AutoSaveDrawings()
                                                }
                                            }
                                        }
                                        else {
                                            var tmpArea = EllipseAreaCalculation(parseInt(X2 / intZoomMultiplier), parseInt(Y2 / intZoomMultiplier));
                                            if (tmpArea > 0) {
                                                arrMeasures.push({ 'TYPE': 'ELLIPSE', 'ID': '', 'CENTROID': '', 'LENGTH': 0, 'AREA': tmpArea, 'X1': X1 / intZoomMultiplier, 'Y1': Y1 / intZoomMultiplier, 'X2': X2 / intZoomMultiplier, 'Y2': Y2 / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'ellipse' + countId });

                                                EnableToolBarButton(undoIndex, true);
                                                var text = paper.text(center.x, center.y + 7, '').attr({
                                                    stroke: 'none',
                                                    fill: currColor,
                                                    "stroke-width": intThickness,
                                                    font: '12px "verdana,geneva,helvetica,sans-serif"',
                                                    "font-family": "verdana,geneva,helvetica,sans-serif",
                                                    "font-weight": "normal",
                                                    "text-anchor": "middle"

                                                });
                                                text.id = msrShap.id;
                                                elemClicked = msrShap.id
                                                var msrSet = paper.set()
                                                msrSet.push(msrShap);
                                                msrSet.push(text);
                                                msrSet.ID = msrShap.id;
                                                arrSets.push(msrSet);
                                                msrSet.mousedown(function (e) {
                                                    if (e.button == 2) {
                                                        var upX = e.clientX + $(window).scrollLeft() - 5;
                                                        var upY = e.clientY + $(window).scrollTop() - 5;
                                                        OpenMenu(this, upX, upY);
                                                    }
                                                });
                                                if (autoSave == 'True') {
                                                    AutoSaveDrawings()
                                                }
                                                if (addTextToMsr == true) {
                                                    editText(text, msrSet);
                                                }
                                                else {
                                                    msrSet.pop(text);
                                                }
                                            }
                                        }

                                        break;
                                    case 'polyline':
                                        if (clickNumber == 1) {
                                            arrDrawings.push({ 'TYPE': 'POLYLINE', 'ID': '', 'TRANSFORM': '', 'ARRPOINTS': [{ 'X1': startLine.x / intZoomMultiplier, 'Y1': startLine.y / intZoomMultiplier, 'X2': endLine.x / intZoomMultiplier, 'Y2': endLine.y / intZoomMultiplier }], 'COLOR': currColor, 'STROKE': intThickness - 1, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'polyline' + countId });

                                        } else if (clickNumber > 1) {
                                            arrDrawings[arrDrawings.length - 1].ARRPOINTS.push({ 'X1': startLine.x / intZoomMultiplier, 'Y1': startLine.y / intZoomMultiplier, 'X2': endLine.x / intZoomMultiplier, 'Y2': endLine.y / intZoomMultiplier });
                                        }
                                        if (autoSave == 'True') {
                                            AutoSaveDrawings()
                                        }
                                        EnableToolBarButton(undoIndex, true);
                                        break;
                                    case 'polygon':
                                        if (clickNumber == 1) {
                                            arrPolygonPoints = [];
                                            EnableToolBarButton(undoIndex, true);
                                            arrPolygonPoints.push({ 'X': parseInt(startLine.x / intZoomMultiplier), 'Y': parseInt(startLine.y / intZoomMultiplier) });
                                            arrPolygonPoints.push({ 'X': parseInt(endLine.x / intZoomMultiplier), 'Y': parseInt(endLine.y / intZoomMultiplier) });

                                        } else if (clickNumber > 1) {
                                            arrPolygonPoints.push({ 'X': parseInt(endLine.x / intZoomMultiplier), 'Y': parseInt(endLine.y / intZoomMultiplier) });
                                        }
                                        break;

                                }
                            }
                        }
                    }
                    );// mouse up





                    function drawPolyLine(startX, startY, endX, endY) {
                        startLine = {
                            x: startX,
                            y: startY
                        };
                        endLine = {
                            x: endX,
                            y: endY
                        };
                        var getPath = function () {
                            return "M" + startLine.x + " " + startLine.y + " L" + endLine.x + " " + endLine.y;
                        };

                        var redraw = function () {
                            node.attr("path", getPath());
                            node.attr({
                                stroke: polyColor,
                                "stroke-width": polyStroke
                            });
                            node.id = 'polyline' + countId;
                            node.TransformID = 'polyline' + countId
                        }

                        var node = paper.path(getPath())
                        if (clickNumber == 1) {
                            polyStroke = intThickness;
                            polyColor = currColor;

                        }
                        node.attr("path", getPath());
                        node.attr({
                            stroke: polyColor,
                            "stroke-width": polyStroke
                        });
                        //node.mousedown(function (e) {
                        //    e.preventDefault();
                        //    clicks++;

                        //    setTimeout(function () { clicks = 0 }, 300)
                        //    if (clicks == 2)
                        //    { ObjectDblClicked(this); }
                        //    else
                        //    {
                        //        if (e.button == 2) {
                        //            var upX = e.clientX + $(window).scrollLeft() - 5;
                        //            var upY = e.clientY + $(window).scrollTop() - 5;
                        //            OpenMenu(this, upX, upY);
                        //        }
                        //    }

                        //});
                        //node.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });
                        node.id = 'polyline' + countId;

                        //node.dblclick(function () { ObjectDblClicked(this); });

                        node.TransformID = 'polyline' + countId
                        msrShap = node;
                        polylineMSR.push(node);
                        return {
                            updateStart: function (x, y) {
                                startLine.x = x;
                                startLine.y = y;
                                redraw();
                                return this;
                            },
                            updateEnd: function (x, y) {

                                endLine.x = x;
                                endLine.y = y;
                                redraw();
                                return this;
                            }
                        };
                    };


                    function drawLine(startX, startY, endX, endY) {
                        startLine = {
                            x: startX,
                            y: startY
                        };
                        endLine = {
                            x: endX,
                            y: endY
                        };
                        var getPath = function () {
                            return "M" + startLine.x + " " + startLine.y + " L" + endLine.x + " " + endLine.y;
                        };

                        var redraw = function () {
                            node.attr("path", getPath());
                            node.attr({
                                stroke: currColor,
                                "stroke-width": intThickness
                            });
                            node.id = 'line' + countId;

                        }

                        var node = paper.path(getPath())
                        node.attr("path", getPath());
                        node.attr({
                            stroke: currColor,
                            "stroke-width": intThickness
                        });
                        node.mousedown(function (e) {
                            e.preventDefault();
                            clicks++;

                            setTimeout(function () { clicks = 0 }, 300)
                            if (clicks == 2)
                            { ObjectDblClicked(this); }
                            else
                            {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            }

                        });

                        //node.dblclick(function () { ObjectDblClicked(this); });

                        node.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });
                        node.id = 'line' + countId;
                        msrShap = node;
                        return {
                            updateStart: function (x, y) {
                                startLine.x = x;
                                startLine.y = y;
                                redraw();
                                return this;
                            },
                            updateEnd: function (x, y) {

                                endLine.x = x;
                                endLine.y = y;
                                redraw();
                                return this;
                            }
                        };
                    };

                    function drawRectangle(x, y, w, h) {
                        var element = paper.rect(x, y, w, h);
                        element.attr({
                            stroke: currColor,
                            "stroke-width": intThickness

                        });
                        element.id = 'rect' + countId;
                        element.mousedown(function (e) {
                            e.preventDefault();
                            clicks++;

                            setTimeout(function () { clicks = 0 }, 300)
                            if (clicks == 2)
                            { ObjectDblClicked(this); }
                            else
                            {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            }

                        });

                        //   element.dblclick(function () { ObjectDblClicked(this); });

                        element.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }) } }, function (e) { if (this.g != null) { this.g.remove() } });
                        return element;
                    }

                    function drawBubbleCloud(cloudX, cloudY, cloudWidth, cloudHeight) {



                        var cloudSet = paper.set()


                        var eltcloud;


                        if (cloudWidth >= cloudHeight) {
                            // var elcloud = paper.path('M' + currX + "," + currY + "L" + mouseX + "," + mouseY);


                            var widthRadius = cloudWidth / 3;
                            var heightHalf = cloudHeight / 2;

                            heightRadius = Math.sqrt(widthRadius * widthRadius + heightHalf * heightHalf) / 2;

                            var widthACurveTransString = "A" + 2 * widthRadius / 3 + "," + widthRadius / 3 * 2 + " 0 0,1 "
                            var heightACurveTransString = "A" + 0.9 * heightRadius + "," + 0.9 * heightRadius + " 0 0,1 "

                            eltcloud = paper.path("M" + String(parseFloat(cloudX) + parseFloat(widthRadius)) + "," + cloudY +
                                                widthACurveTransString + String(parseFloat(cloudX) + 2 * parseFloat(widthRadius)) + "," + cloudY +
                                                heightACurveTransString + String(parseFloat(cloudX) + parseFloat(cloudWidth)) + "," + String(parseFloat(cloudY) + parseFloat(heightHalf)) +
                                                heightACurveTransString + String(parseFloat(cloudX) + 2 * parseFloat(widthRadius)) + "," + String(parseFloat(cloudY) + parseFloat(cloudHeight)) +
                                                widthACurveTransString + String(parseFloat(cloudX) + parseFloat(widthRadius)) + "," + String(parseFloat(cloudY) + parseFloat(cloudHeight)) +
                                                heightACurveTransString + cloudX + "," + String(parseFloat(cloudY) + parseFloat(heightHalf)) +
                                                heightACurveTransString + String(parseFloat(cloudX) + parseFloat(widthRadius)) + "," + cloudY +
                                                widthACurveTransString + String(parseFloat(cloudX) + 2 * parseFloat(widthRadius)) + "," + cloudY);


                        }
                        else {

                            var heightRadius = cloudHeight / 3;
                            var widthHalf = cloudWidth / 2;

                            widthRadius = Math.sqrt(heightRadius * heightRadius + widthHalf * widthHalf) / 2;

                            var widthACurveTransString = "A" + 0.9 * widthRadius + "," + 0.9 * widthRadius + " 0 0,1 "
                            var heightACurveTransString = "A" + heightRadius * 2 / 3 + "," + heightRadius * 2 / 3 + " 0 0,1 "

                            eltcloud = paper.path("M" + String(parseFloat(cloudX) + parseFloat(widthHalf)) + "," + cloudY +
                                                widthACurveTransString + String(parseFloat(cloudX) + parseFloat(cloudWidth)) + "," + String(parseFloat(cloudY) + parseFloat(heightRadius)) +
                                                heightACurveTransString + String(parseFloat(cloudX) + parseFloat(cloudWidth)) + "," + String(parseFloat(cloudY) + 2 * parseFloat(heightRadius)) +
                                                widthACurveTransString + String(parseFloat(cloudX) + parseFloat(widthHalf)) + "," + String(parseFloat(cloudY) + parseFloat(cloudHeight)) +
                                                widthACurveTransString + cloudX + "," + String(parseFloat(cloudY) + 2 * parseFloat(heightRadius)) +
                                                heightACurveTransString + cloudX + "," + String(parseFloat(cloudY) + parseFloat(heightRadius)) +
                                                widthACurveTransString + String(parseFloat(cloudX) + parseFloat(widthHalf)) + "," + cloudY +
                                                widthACurveTransString + String(parseFloat(cloudX) + parseFloat(cloudWidth)) + "," + String(parseFloat(cloudY) + parseFloat(heightRadius)));
                        }


                        eltcloud.id = 'BUBBLE_' + countId;
                        cloudSet.push(eltcloud);

                        cloudSet.ID = 'BUBBLE_' + countId;


                        eltcloud.attr({
                            stroke: currColor,
                            "stroke-width": intThickness
                        });

                        cloudSet.TransformID = 'BUBBLE_' + countId;
                        elemClicked = cloudSet.TransformID
                        cloudSet.mousedown(function (e) {
                            e.preventDefault();
                            clicks++;

                            setTimeout(function () { clicks = 0 }, 300)
                            if (clicks == 2)
                            { ObjectDblClicked(this); }
                            else
                            {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            }

                        });


                        //cloudSet.dblclick(function () { ObjectDblClicked(this); });

                        cloudSet.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }) } }, function (e) { if (this.g != null) { this.g.remove() } });

                        arrSets.push(cloudSet);
                    }

                    function drawBubbleRectangle(x, y, w, h) {
                        var element = paper.rect(x, y, w, h);
                        element.attr({
                            stroke: currColor,
                            "stroke-width": intThickness

                        });
                        element.id = 'bubble' + countId;
                        return element;
                    }

                    function drawCircle(x1, y1, x2, y2) {
                        center = {
                            x: (x1 + x2) / 2,
                            y: (y1 + y2) / 2
                        };

                        radius = {

                            h: Math.sqrt((y2 - y1) * (y2 - y1)) / 2,
                            w: Math.sqrt((x2 - x1) * (x2 - x1)) / 2

                        };
                        var getPath = function () {

                            return [["M", center.x, center.y], ["m", 0, -radius.h],
                                   ["a", radius.w, radius.h, 0, 1, 1, 0, 2 * radius.h],
                                   ["a", radius.w, radius.h, 0, 1, 1, 0, -2 * radius.h],
                                   ["z"]];

                        };
                        var redraw = function () {

                            node.attr("path", getPath());
                            node.attr({
                                stroke: currColor,
                                "stroke-width": intThickness
                            });


                            //node.dblclick(function () { ObjectDblClicked(this); });

                            node.id = 'ellipse' + countId
                        };

                        var node = paper.path(getPath());
                        node.attr({ "stroke-width": 0 });
                        node.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }) } }, function (e) { if (this.g != null) { this.g.remove() } });
                        node.id = 'ellipse' + countId
                        node.mousedown(function (e) {
                            e.preventDefault();
                            clicks++;

                            setTimeout(function () { clicks = 0 }, 300)
                            if (clicks == 2)
                            { ObjectDblClicked(this); }
                            else
                            {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            }

                        });
                        msrShap = node;
                        return {
                            updateStart: function (x, y) {
                                center.x = (x1 + x) / 2;
                                center.y = (y1 + y) / 2;
                                radius.w = Math.sqrt((x - x1) * (x - x1)) / 2;
                                radius.h = Math.sqrt((y - y1) * (y - y1)) / 2;
                                redraw();
                                return this;
                            },
                            updateEnd: function (x, y) {
                                center.x = (x1 + x) / 2;
                                center.y = (y1 + y) / 2;
                                radius.w = Math.sqrt((x - x1) * (x - x1)) / 2;
                                radius.h = Math.sqrt((y - y1) * (y - y1)) / 2;
                                redraw();
                                return this;
                            }
                        };

                    }






                    var divZoomer = document.getElementById('divZoomer');

                    $(divZoomer).on('touchmove mousemove', function (e) {

                        if (e.type == 'touchmove') {
                            mouseX = e.originalEvent.touches[0].pageX;
                            mouseY = e.originalEvent.touches[0].pageY;
                        } else {
                            mouseX = e.pageX;
                            mouseY = e.pageY;
                        }
                        leftOffset = $('#divZoomer').offset().left;
                        topOffset = $('#divZoomer').offset().top;

                        if (IE) {
                            if (mouseX < 0) { mouseX = 0 } else { mouseX -= (leftOffset); }
                            if (mouseY < 0) { mouseY = 0 } else { mouseY -= (topOffset); }
                        } else {
                            if (mouseX < 0) { mouseX = 0 } else { mouseX -= (leftOffset); }
                            if (mouseY < 0) { mouseY = 0 } else { mouseY -= (topOffset); }
                        }
                        document.getElementById('MouseXSpan').innerHTML = mouseX;
                        document.getElementById('MouseYSpan').innerHTML = mouseY;
                        var img = document.getElementById(imgCanvasId)
                    });

                    $(canvas).on('touchmove mousemove', function (e) {
                        mouseElement = e.target;
                        if (e.type == 'touchmove') {
                            mouseX = e.originalEvent.touches[0].pageX;
                            mouseY = e.originalEvent.touches[0].pageY;
                            ClientMouseX = e.originalEvent.touches[0].clientX;
                            ClientMouseY = e.originalEvent.touches[0].clientY;
                        } else {
                            mouseX = e.pageX;
                            mouseY = e.pageY;
                            ClientMouseX = e.clientX;
                            ClientMouseY = e.clientY;
                        }


                        if (IE) {
                            if (mouseX < 0) { mouseX = 0 } else { mouseX -= (leftOffset); }
                            if (mouseY < 0) { mouseY = 0 } else { mouseY -= (topOffset); }
                        } else {
                            if (mouseX < 0) { mouseX = 0 } else { mouseX -= (leftOffset); }
                            if (mouseY < 0) { mouseY = 0 } else { mouseY -= (topOffset); }
                        }
                        document.getElementById('MouseXSpan').innerHTML = mouseX;
                        document.getElementById('MouseYSpan').innerHTML = mouseY;
                        var upX;
                        var upY;
                        var offset = $(canvas).offset();
                        if (e.type == 'touchmove') {
                            upX = e.originalEvent.touches[0].pageX - offset.left;
                            upY = e.originalEvent.touches[0].pageY - offset.top;

                        } else {
                            upX = e.pageX - offset.left;
                            upY = e.pageY - offset.top;
                        }


                        var width = upX - mouseDownX;
                        var height = upY - mouseDownY;

                        if (isMouseDown == 1 && cursorType == 'Draw' && isEdit != 'Edit') {

                            if (tempType == 'rectangle' || tempType == 'bubble') {

                                if (width >= 0 && height >= 0) {
                                    shap.attr({
                                        "width": Math.abs(width)
                                        , "height": Math.abs(height)
                                    });
                                }
                                if (width >= 0 && height < 0) {
                                    shap.attr({
                                        "width": Math.abs(width),
                                        "height": Math.abs(height)
                                        , "y": currY - Math.abs(height)
                                    });
                                }
                                if (width < 0 && height >= 0) {
                                    shap.attr({
                                        "width": Math.abs(width),
                                        "height": Math.abs(height)
                                        , "x": currX - Math.abs(width)
                                    });
                                }
                                if (width < 0 && height < 0) {
                                    shap.attr({
                                        "width": Math.abs(width),
                                        "height": Math.abs(height)
                                        , "x": currX - Math.abs(width)
                                        , "y": currY - Math.abs(height)
                                    });
                                }
                            } else if (tempType == 'line' || tempType == 'ellipse' || tempType == 'polyline' || tempType == 'polygon') {
                                shap.updateEnd(upX, upY);
                            }
                        }

                        if (isMouseDown == 1 && cursorType == 'Move' && isEdit != 'Edit') {
                            // $('#divZoomer').css({ "left": (xDown - e.pageX), "top": (yDown - e.pageY) });


                            $('#divZoomer').scrollTop(initClientMouseY - ClientMouseY);
                            $('#divZoomer').scrollLeft(initClientMouseX - ClientMouseX);
                        }

                    });// mouse move
                }

                $('#divZoomer').bind('wheel mousewheel', function (e) {

                    var delta;
                    if (e.originalEvent.wheelDelta !== undefined)
                        delta = e.originalEvent.wheelDelta;
                    else if (e.originalEvent.detail == 0)
                    { delta = e.originalEvent.deltaY * -1; }
                    else
                    {
                        delta = e.originalEvent.detail * -1;
                    }


                    if (delta > 0) {
                        if (intZoomMultiplier == 0) intZoomMultiplier = 0.01;
                        else if ((intZoomMultiplier * 100) < 10) intZoomMultiplier = intZoomMultiplier + 0.011;
                        else intZoomMultiplier = (intZoomMultiplier * 1.1);
                        zoomingIn = true;
                    }
                    else if (delta < 0) {
                        intZoomMultiplier = (intZoomMultiplier * 0.9);
                        zoomingIn = false;
                    }
                    if (drawingsCateg == "ANN") {
                        var sldrZoom = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i15_i0_sldrZoom");
                    }
                    else {
                        var sldrZoom = $find("ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i16_i0_sldrZoom");
                    }
                    sldrZoom.set_value(parseInt(intZoomMultiplier * 100))
                    sldrZoom.raise_valueChanged()
                    doZoom();
                });
            }); //document ready
            function FileManagerChecked(me) {
                if (me.checked === true) {
                    document.getElementById('<%= txtHFileName.ClientId %>').className = '';
                    document.getElementById('<%= btnHBrowseFileManager.ClientId %>').className = 'BrowseFileManager';
                    document.getElementById('<%= HFileToUpload.ClientId %>').className = 'Hide';
                } else {
                    document.getElementById('<%= txtHFileName.ClientId %>').className = 'Hide';
                    document.getElementById('<%= btnHBrowseFileManager.ClientId %>').className = 'Hide BrowseFileManager';
                    document.getElementById('<%= HFileToUpload.ClientId %>').className = '';

                }
            }



            function UploadChecked(me) {
                if (me.checked === true) {
                    document.getElementById('<%= txtHFileName.ClientId %>').className = 'Hide';
                    document.getElementById('<%= btnHBrowseFileManager.ClientId %>').className = 'Hide BrowseFileManager';
                    document.getElementById('<%= HFileToUpload.ClientId %>').className = '';
                } else {
                    document.getElementById('<%= txtHFileName.ClientId %>').className = '';
                    document.getElementById('<%= btnHBrowseFileManager.ClientId %>').className = 'BrowseFileManager';
                    document.getElementById('<%= HFileToUpload.ClientId %>').className = 'Hide';
                }
            }

            function GetFileForFileManager(me) {
                if (me.attributes["CanClick"].value == 'False') { return false; }

                $("input[id$=hdnHIsPMWebViewerFile]").val('true');
                var URL = "FilesLookup.aspx?EntityId=";
                var ProjectId = 0;
                var ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
                var LocationId = $find($("div[id*=ddlLocation]")[0].id).get_value();
                if (ProjectId < 0) ProjectId = 0;
                if (LocationId < 0) LocationId = 0;
                if (ProjectId > 0 && LocationId == 0)
                    URL += "1_" + ProjectId;
                else if (ProjectId == 0 && LocationId > 0)
                    URL += "9_" + LocationId;
                else if (ProjectId == 0 && LocationId == 0)
                    URL += "1_" + LocationId;
                else if (ProjectId > 0 && LocationId > 0) {
                    URL += "1_" + ProjectId;
                    URL += ";9_" + LocationId;
                }

                URL += "&Source=REDLINING"
                //return OpenPOPUp(URL, 800, 500, true);
                var wnd = window.radopen(URL)
                var divWindow = wnd._popupElement;
                wnd.set_visibleTitlebar(false);
                wnd._topResizer.parentElement.className = "";
                divWindow.classList.add("rwFolderManager");
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }


            }

            function Save() {

                var toolbar = $find('<%=mainToolBar.ClientID%>')
                toolbar.findButtonByCommandName("Save").click();

            }

            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
                updatePanel1.set_enableAJAX(false);
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.RedliningInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.RedliningInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.RedliningInfo.Description)%>';
                var Id = '<%= PM.RedliningInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("REDLINING")%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=REDLINING&Id=" +
                 '<%= PM.RedliningInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.RedliningInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=REDLINING&Id=" +
                            '<%= PM.RedliningInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.RedliningInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('REDLINING');
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=REDLINING&Id=" + Id
                    + "&EntityId=" + '<%=PM.RedliningInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;


                    case 'New':

                        window.location = "PMWebViewer.aspx";
                        break;
                    case 'PrintToPDF':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp('RedliningPrint.aspx?ZoomMultiplier=' + intZoomMultiplier, '',
                                        'location=no,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=800,height=600,top=' + top + ',left=' + left);
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function MenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
            }
            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);

                maintoolbarClick(args.get_item().get_value())
            }
            var forceMoreMenuToClose = true;
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function UploadClick() {
                var upload = document.querySelector('#ctl00_CPH1_HFileToUpload');
                upload.click();
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <style>
        .lnkBtnDownload .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png);
            background-repeat: no-repeat;
            height: 16px;
            width: 16px;
            display: inline-block;
            background-position: -929px 0;
            position: relative;
            top: 5px;
        }

        .lnkBtnDownload {
            text-align: center;
            line-height: 35px;
            border-radius: 5px;
            border: 1px solid gray;
            text-transform: uppercase;
            height: 35px !important;
            width: 100% !important;
            display: block;
            text-decoration: none;
        }

            .lnkBtnDownload .Icon2 {
                background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png);
                background-repeat: no-repeat;
                height: 16px;
                width: 16px;
                display: inline-block;
                background-position: -913px 0;
                position: relative;
                top: 5px;
            }
    </style>
    <telerik:RadStyleSheetManager ID="SSH1" EnableStyleSheetCombine="true" runat="server">
        <StyleSheets>
            <%--<telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Editor.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Editor.Office2007.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Window.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Window.Office2007.css" />--%>
        </StyleSheets>
    </telerik:RadStyleSheetManager>
    <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <asp:Button ID="btnHiddenSave" runat="server" CssClass="Hide" ValidationGroup="Save" />
                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="click_handler" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" Value="Save"
                            CommandName="Save" ValidationGroup="Save" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" Value="CopyRecord" ValidationGroup="Save">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png"
                                    Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete" PostBack="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="PrintToPDF">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Print Drawing to PDF" Value="PrintToPDF"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('REDLINING');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('REDLINING');" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
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
            <td style="padding-left: 10px;">
                <asp:CheckBox ID="chkHideHeader" Visible="false" runat="server" Text="Hide Header" onClick="HideHeaderCheckedChanged(this)" meta:resourcekey="chkHideHeader" />
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <table style="width: 100% ;display:block;overflow:hidden;" cellpadding="0" cellspacing="0">
        <tr id="trTbsDetails" runat="server" style="width: 100%">
            <td style="width: 100%">
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
                    runat="server" MultiPageID="mlpPMWebViewer" ScrollChildren="true" ScrollButtonsPosition="Left" Skin="Default" Width="100%" CssClass="documentTabs" EnableViewState="True"
                    CausesValidation="False">
                    <Tabs>
                        <telerik:RadTab Text="Header" Value="Header"></telerik:RadTab>
                        <telerik:RadTab Text="Drawing" Value="Drawing" />
                        <telerik:RadTab Text="Measurement" Value="Measurement" />
                        <telerik:RadTab Text="Settings" Value="Settings" />
                        <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
                        <telerik:RadTab Text="Notes" Value="Notes" />
                        <telerik:RadTab Text="Attachments" Value="Attachments" />
                        <telerik:RadTab Value="Workflow" Text="Workflow" />
                        <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
                        <telerik:RadTab Text="Notification" Value="NotificationLog" />
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="mlpPMWebViewer" runat="server" SelectedIndex="0" RenderSelectedPageOnly="True" CssClass="documentMultiPages"
                    BorderColor="LightBlue" BorderWidth="0">
                    <telerik:RadPageView ID="pvHeader" runat="server" Selected="true">
                        <asp:Panel ID="pnlPMWebViewerHeader" runat="server">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <%--<tr>
                                                <td valign="middle" style="padding: 5px 0px 0px 5px">
                                                    <img id="tblPMWebViewerHeaderimg" alt="" src="Images/Workflow/wMinus.png" onclick="return TogglePMWebViewerHeaderSection(this);" />
                                                    <span style="color: #09296C; font-size: 11px; font-weight: bold">
                                                        <asp:Label ID="lblPMWebViewerHeader" runat="server" meta:resourcekey="lblPMWebViewerHeader"></asp:Label></span>
                                                    <img alt="" src="Images/Workflow/wSperator.png" />
                                                </td>
                                            </tr>--%>
                                <tr>
                                    <td>
                                        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="false">
                                            <div class="PMMainPage ">
                                                <div class="row JustifyContent R3Cols">
                                                    <div class="col-4 col-4-left">
                                                        <table class="colTable" id="tblPMWebViewerHeader" border="0">
                                                            <tr>

                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblCode" meta:Resourcekey="lblCode" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <asp:TextBox ID="txtCode" MaxLength="49" runat="server" ></asp:TextBox>
                                                                    <asp:Label ID="lblCodeRequired" runat="server" Text="Enter the Code" meta:Resourcekey="lblCodeRequired_validate"
                                                                        Visible="False" Class="Validator"></asp:Label>
                                                                    <asp:Label ID="lblCodeUnique" runat="server" Text="Code must be unique" meta:Resourcekey="lblCodeUnique"
                                                                        Visible="False" Class="Validator"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <telerik:RadComboBox ID="ddlLocation" runat="server" meta:resourcekey="ddlLocation"
                                                                        Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                                        CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                                        OnItemsRequested="ddl_ItemsRequested">
                                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server" meta:resourcekey="ddlProject"
                                                                        Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                                        CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                                        OnItemsRequested="ddl_ItemsRequested">
                                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblBuilding" runat="server" meta:resourcekey="lblBuilding"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <telerik:RadComboBox ID="ddlBuilding" runat="server" meta:resourcekey="ddlBuilding"
                                                                        Skin="Default" Width="99%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                                        CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                                        OnItemsRequested="ddl_ItemsRequested">
                                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <asp:TextBox ID="txtDescription" MaxLength="100" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label runat="server" ID="lblType" meta:Resourcekey="lblType"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" meta:Resourcekey="ddlTypes"
                                                                        Skin="Default" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true">
                                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label runat="server" ID="lblCategory" meta:Resourcekey="lblCategory"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <telerik:RadComboBox ID="ddlCategories" runat="server" Width="100%" meta:Resourcekey="ddlCategories"
                                                                        Skin="Default" AllowCustomText="True">
                                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblBIMModel" runat="server" meta:resourcekey="lblBIMModel"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <telerik:RadComboBox ID="ddlBIMModel" UseProjectFilter="1" runat="server" meta:resourcekey="ddlBIMModel"
                                                                        Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                                        CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                                        OnItemsRequested="ddl_ItemsRequested">
                                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblRevision" meta:Resourcekey="lblRevision" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                                        <tr>
                                                                            <td>
                                                                                <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" meta:Resourcekey="ddlStatus"
                                                                                    Skin="Default">
                                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                                </telerik:RadComboBox>
                                                                            </td>
                                                                            <td style="width: 50px; padding-left: 8px; text-align: right">
                                                                                <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" runat="server"
                                                                                    MaxLength="9"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:HyperLink ID="hlkAttachedRecord" meta:Resourcekey="hlkLinkedRecord" runat="server" Style="color: #666666"></asp:HyperLink>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <asp:TextBox ID="txtAttachedRecordDescription" ReadOnly="true" MaxLength="300" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblImageFile" runat="server" Text="Image File" meta:Resourcekey="lblImageFile"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <asp:TextBox ID="txtImageFile" runat="server" Enabled="false"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="labelWidth"></td>
                                                                <td class="controlWidth">
                                                                    <asp:LinkButton ID="lnkBtnDownload" runat="server" Style="height: 35px; width: 100%" CssClass="lnkBtnDownload Link">
                                                                        <span id="spanIcon" runat="server" class="Icon"></span>
                                                                        <asp:Label ID="lblDownload" runat="server" Text="Download Image" meta:Resourcekey="lblDownload" Style="display: inline-block;"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td class="labelWidth">
                                                                    <asp:Label ID="lblUpload" runat="server" Text="Click To Upload"></asp:Label>
                                                                </td>
                                                                <td class="controlWidth">
                                                                    <asp:LinkButton ID="lnkBtnUpload" runat="server" CssClass="lnkBtnDownload" OnClientClick="return UploadClick();">
                                                                        <span class="Icon2"></span>
                                                                        <asp:Label ID="lblBtnUpload" runat="server" Text="Upload Image" Style="display: inline-block"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <%--<telerik:RadAjaxPanel runat="server" ID="pnlBIMViewerFile">--%>
                                                                    <fieldset id="flsUpload">
                                                                        <legend>
                                                                            <asp:Label ID="lblFile" class="legend" runat="server" meta:resourcekey="lblFile"></asp:Label></legend>
                                                                        <table class="colTable">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:RadioButton ID="rdbHFileManager" Height="24px" GroupName="AttachmentOption" meta:ResourceKey="rdbHFileManager" CssClass="RadioCss"
                                                                                        runat="server" Text="Document Manager" Checked="true" onClick="FileManagerChecked(this);" />
                                                                                    <asp:HiddenField ID="hdnHFileId" runat="server" />
                                                                                    <asp:HiddenField ID="hdnHFileSize" runat="server" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:RadioButton ID="rdbHUpload" Height="24px" GroupName="AttachmentOption" runat="server" Text="Upload"
                                                                                        meta:ResourceKey="rdbHUpload" CssClass="RadioCss" onClick="UploadChecked(this);" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100%;">
                                                                                    <span id="spHFileManager" runat="server" style="height: 24px">
                                                                                        <asp:TextBox ID="txtHFileName" runat="server" Text="" Height="24px"></asp:TextBox>
                                                                                        <asp:LinkButton ID="btnHBrowseFileManager" Height="24px" CssClass="BrowseFileManager" runat="server" Text="Browse" Style="text-decoration: underline;"
                                                                                            meta:resourcekey="btnHBrowseFileManager" OnClientClick="GetFileForFileManager(this); return false;"></asp:LinkButton>
                                                                                        <asp:HiddenField ID="hdnHIsPMWebViewerFile" runat="server" Value='false' />
                                                                                    </span>
                                                                                    <asp:FileUpload ID="HFileToUpload" runat="server" CssClass="Hide" onchange="Save()" Height="24px" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2">
                                                                                    <asp:Label ID="lblHFileError" CssClass="Validator" runat="server" Text="" Style="color: #666666"></asp:Label>
                                                                                    <div style="float: left">
                                                                                        <asp:LinkButton ID="lblFilePath" CssClass="Link" Style="vertical-align: top; color: #666666" meta:Resourcekey="lblFilePath" runat="server" Visible="false">
                                                                                        </asp:LinkButton>
                                                                                        &nbsp;&nbsp;
                                                                                        <asp:HyperLink ID="lblHFileName" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: pointer; color: #666666; vertical-align: top"
                                                                                            Text='' ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                                                                                        &nbsp;&nbsp;
                                                                                    </div>
                                                                                    <div style="float: right">
                                                                                        <asp:LinkButton ID="btnDeleteImage" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                                                                            ToolTip="<%$Resources: RemoveFileTooltip %>" runat="server" CommandName="DeleteRows" CssClass="BrowseFileManager"
                                                                                            Text="[Delete]" meta:resourcekey="btnDelete" OnClientClick="DisablePanelAjax();">
                                                                                        </asp:LinkButton>
                                                                                    </div>
                                                                                    <%--<asp:Label ID="lblHFileName" runat="server" Text=""></asp:Label>--%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </fieldset>
                                                                    <%--</telerik:RadAjaxPanel>--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div class="col-4 col-4-middle">
                                                        <uc12:AssetRotator ID="PMrot" runat="server" />
                                                    </div>
                                                    <div class="col-4 col-4-right">
                                                        <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                                                        <%--<tr>
                                                                <td>
                                                                    <asp:Label ID="lblFile" meta:Resourcekey="lblFile" runat="server"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtFile" MaxLength="100" runat="server" Width="200px" ReadOnly="true"></asp:TextBox>
                                                                </td>
                                                            </tr>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </telerik:RadAjaxPanel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="PvDrawing" runat="server">
                        <uc6:PMWebViewerDrawing ID="PMWebViewerDrawing1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="PvMeasurement" runat="server">
                        <uc8:PMWebViewerMeasurement ID="PMWebViewerMeasurement1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="PvSettings" runat="server">
                        <uc10:PMWebViewerSettings ID="PMWebViewerSettings1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="PvSpec" runat="server">
                        <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotes" runat="server">
                        <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                        <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvWorkflow" runat="server">
                        <uc4:WorkflowDocument ID="WorkflowDocument" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                        <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotificationLog" runat="server">
                        <uc5:NotificationLog ID="NotificationLog1" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
</asp:Content>
