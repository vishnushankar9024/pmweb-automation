<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RedliningPrint.aspx.vb" Inherits="Website.RedliningPrint" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
<script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
<script src="JS/PMJS.js" type="text/javascript"></script>
<script src="JS/TelerikUtilities.js" type="text/javascript"></script>
<script src="JS/raphael-min.js" type="text/javascript"></script>
<script src="JS/Redlining/wz_jsgraphics.js" type="text/javascript"></script>
<script src="JS/Redlining/Redlining.js" type="text/javascript"></script>
<script src="JS/Redlining/raphael.free_transform.js" type="text/javascript"></script>
<script src="JS/Redlining/Raphael.inlineTextEditing.js" type="text/javascript"></script>


<link href="CSS/Ribbon.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .rmLink, .rmRootLink {
        display: none !important;
    }

    .RedliningGrid .rgRow td div, .RedliningGrid .rgAltRow td div, .RedliningGrid .rgRow td span, .RedliningGrid .rgAltRow td span {
        white-space: normal !important;
    }

    .stampItems {
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
        padding: 0 5px 0 5px !important;
    }




    svg {
        position: absolute !important;
        /*top: 34px !important;*/
        left: 0 !important;
    }

    #Canvas > div {
        position: absolute !important;
        z-index: 10;
    }


    div.RadGrid .rgRow td,
    div.RadGrid .rgAltRow td {
        padding: 2px;
    }
</style>
<script type="text/javascript">
    var downloadWindow;
    var printAll = '<%= DirectCast(Website.PageHelper.FindControlRecursive(mainToolBar2, "cbxAllPages"), CheckBox).Checked%>';
    var totalpages = <%= PM.RedliningInfo.currPagesCount %>
    function InitiateSizesP() {
        // intZoomMultiplier = 1;
        var imgCanvas = document.getElementById('imgCanvas');
        imgCanvasInitWidth = parseInt(imgCanvas.style.width);
        imgCanvasInitHeight = parseInt(imgCanvas.style.height);

        var tdCanvas = document.getElementById('tdCanvas');
        tdCanvas.style.width = imgCanvasInitWidth + 'px';
        tdCanvas.style.height = imgCanvasInitHeight + 'px';

        var divZoomer = document.getElementById('divZoomer');
        divZoomerInitWidth = parseInt(divZoomer.style.width);
        divZoomerInitHeight = parseInt(divZoomer.style.height);

    }
    function click_handler(sender, args) {
        switch (args.get_item().get_commandName()) {
            case 'ExportPDF':
                downloadWindow = window.open('', '_blank')
                downloadWindow.document.write('Please wait. Your download is in progress....')
                document.cookie = downloadWindow
                break;
        }
    }



    function doZoomP() {

        var imgCanvas = document.getElementById('imgCanvas');
        imgCanvas.style.width = (imgCanvasInitWidth * 1) + 'px';
        imgCanvas.style.height = (imgCanvasInitHeight * 1) + 'px';

    }

    $(document).ready(function () {
        for (var i = 0; i < arrDrawings.length; i++) {
            if (arrDrawings[i].TYPE == 'NOTE' || arrDrawings[i].TYPE == 'TEXT' || arrDrawings[i].TYPE == 'printednote') {
                var arrText = arrDrawings[i].VALUE.split('@!~');
                var ObjText = arrText[0];
                for (var j = 1; j < arrText.length; j++) {
                    ObjText = ObjText + String.fromCharCode(10) + arrText[j];
                }
                for (var q = 0; q < ObjText.split('@~#').length; q++) {
                    ObjText = ObjText.replace("@~#", "'");
                }
                arrDrawings[i].VALUE = ObjText.replace("@~#", "'");
            }

        }
        if (totalpages == 1 || printAll.toLowerCase() == 'false') {
            InitiateSizesP();
            doZoomP();

        }

        ReDrawANNP();
        if (totalpages > 1 && printAll.toLowerCase() == 'true') {
            $("#Canvas0").find("svg")[0].style.top = "34px";
        }
        if ($telerik.isIE) {

            if (totalpages > 1 && printAll.toLowerCase() == 'true') {
                var height = 0;
                for (var pageN = 1; pageN <= totalpages; pageN++) {
                    var divId = '[id=Canvas' + (pageN - 1) + '] Div';
                    $(divId)[0].style.position = 'absolute';
                    height = $("[id=Canvas0]")[0].offsetHeight;
                    $(divId)[0].style.top = 34 + height * (pageN - 1);
                }
            }
            else {
                for (var i = 0; i < $("[id=Canvas] Div").length; i++) {
                    $("[id=Canvas] Div")[i].style.position = 'absolute'
                    $("[id=Canvas] Div")[i].style.top = '34px';
                }

            }


            // $("[id=Canvas] Div")[0].style.top = '34px';
        }
        //if ($telerik.isIE) {
        //    $("[id=Canvas] Div")[0].style.top = '34px';
        //}
    });

    function ReDrawANNP() {
        clickNumber = 0;
        bufferStamp = tempStamp;
        bufferType = tempType;
        bufferColor = currColor;
        bufferThickness = intThickness;
        bufferequipmentId = equipmentId;
        bufferspaceId = spaceId;
        countId = 0;
        var imgHeight;
        arrSets = [];
        if (drawingsCateg == "ANN") {
            $('#Canvas')[0].innerHTML = $('#Canvas')[0].children['ctl00_CPH1_PMWebViewerDrawing1_imgCanvas'].outerHTML + $('#Canvas')[0].children['divResize'].outerHTML
        }
        else if (drawingsCateg == "MSR") {
            $('#Canvas')[0].innerHTML = $('#Canvas')[0].children['imgCanvas'].outerHTML + $('#Canvas')[0].children['divResize'].outerHTML;
        }
        var divId;
        if (totalpages > 1 && printAll.toLowerCase() == 'true') {
            imgHeight = $("[id=Canvas0]")[0].offsetHeight;
        }
        else {
            imgHeight = $("[id=Canvas]")[0].offsetHeight;
            divId = "Canvas"
        }
        var PageNumber = ''
        skin = $("[id$=hdnSkin]").val();
        var DrawLinkNumber = "1";
        var DrawNoteNumber = "1";
        for (var pageN = 1; pageN <= totalpages; pageN++) {
            if (totalpages > 1 && printAll.toLowerCase() == 'true') {
                divId = "Canvas" + (pageN - 1)
            }
            paper = new Raphael(divId);
            paper.top = 34 + imgHeight * (pageN - 1);

            for (var i = 0; i < arrDrawings.length; i++) {
                var PageNumber = arrDrawings[i].PAGENUMBER;

                if (PageNumber != pageN) continue;
                tempType = arrDrawings[i].TYPE;
                currColor = arrDrawings[i].COLOR;
                intThickness = arrDrawings[i].STROKE + 1;
                isVisible = arrDrawings[i].VISIBLE;
                strTransform = arrDrawings[i].TRANSFORM;

                if (strTransform != '' && strTransform && (strTransform.indexOf('m') == -1 || strTransform.indexOf('m') > 0)) {

                    var arr2 = strTransform.split('R')
                    var arr = arr2[1].split(',');
                    arr[1] = parseFloat(arr[1]) * intZoomMultiplier;
                    var arrR = arr[2].split('S');
                    arr[2] = parseFloat(arrR[0]) * intZoomMultiplier + 'S' + arrR[1];
                    var a = strTransform.split('R')
                    strTransform = a[0] + 'R' + arr.join(',');

                    arr2 = strTransform.split('S')
                    arr = arr2[1].split(',');
                    arr[2] = parseFloat(arr[2]) * intZoomMultiplier;

                    var arrT = arr[3].split('T');
                    arr[3] = parseFloat(arrT[0]) * intZoomMultiplier + 'T' + arrT[1];
                    a = strTransform.split('S')
                    strTransform = a[0] + 'S' + arr.join(',');



                    arr2 = strTransform.split('T')
                    arr = arr2[1].split(',');
                    arr[0] = parseFloat(arr[0]) * intZoomMultiplier;


                    if (isNumeric(arr[1])) {
                        arr[1] = parseFloat(arr[1]) * intZoomMultiplier;
                        a = strTransform.split('T')
                        strTransform = a[0] + 'T' + arr[0] + ',' + arr[1];
                    }
                    else {


                        var arrm = arr[1].split('m');
                        arrm[0] = parseFloat(arrm[0]) * intZoomMultiplier;
                        a = strTransform.split('T')
                        strTransform = a[0] + 'T' + arr[0] + ',' + arrm[0] + 'm' + arrm[1] + ',' + arr[2] + ',' + arr[3] + ',' + arr[4] + ',' + arr[5] + ',' + arr[6];//+ ',' + arr[7] + ',' + arr[8] + ',' + arr[9] + ',' + arr[10] + ',' + arr[11];

                        arr[5] = parseFloat(arr[5]) * intZoomMultiplier;
                        arr[6] = parseFloat(arr[6]) * intZoomMultiplier;
                        strTransform = 'm' + arrm[1] + ',' + arr[2] + ',' + arr[3] + ',' + arr[4] + ',' + arr[5] + ',' + arr[6];

                    }



                }
                else {
                    if (strTransform.indexOf('m') == 0) {
                        var arrSkew = strTransform.split(',');
                        arrSkew[4] = parseFloat(arrSkew[4]) / intZoomMultiplier;
                        arrSkew[5] = parseFloat(arrSkew[5]) / intZoomMultiplier;
                        strTransform = arrSkew.join(',');
                    }
                }
                if (!arrDrawings[i].ISNEW)
                { isNew = 'true'; }
                else { isNew = arrDrawings[i].ISNEW; }

                countId = countId + 1
                if (isVisible == true) {
                    switch (tempType) {
                        case 'BUBBLE':

                            var cloudattributes = arrDrawings[i].CLOUDATTRIBUTES[0];
                            var cloudX = cloudattributes.X * intZoomMultiplier;
                            var cloudY = cloudattributes.Y * intZoomMultiplier;
                            var cloudWidth = cloudattributes.WIDTH * intZoomMultiplier;
                            var cloudHeight = cloudattributes.HEIGHT * intZoomMultiplier;
                            var cloudSet = paper.set()
                            var eltcloud;

                            if (cloudWidth >= cloudHeight) {

                                var widthRadius = cloudWidth / 3;
                                var heightHalf = cloudHeight / 2;

                                heightRadius = Math.sqrt(widthRadius * widthRadius + heightHalf * heightHalf) / 2;

                                var widthACurveTransString = "A" + 2 * widthRadius / 3 + "," + 2 * widthRadius / 3 + " 0 0,1 "
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
                                var heightACurveTransString = "A" + 2 * heightRadius / 3 + "," + 2 * heightRadius / 3 + " 0 0,1 "

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

                            arrDrawings[i].TransformID = 'BUBBLE_' + countId;

                            eltcloud.attr({
                                stroke: currColor,
                                "stroke-width": intThickness
                            });



                            cloudSet.mousedown(function (e) {
                                if (e.button == 2) {

                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });


                            cloudSet.dblclick(function () { ObjectDblClicked(this); });

                            cloudSet.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }) } }, function (e) { if (this.g != null) { this.g.remove() } });

                            arrSets.push(cloudSet);

                            if (strTransform != '')
                            { cloudSet.transform(strTransform) }

                            break;
                        case 'LINE':
                            tempX1 = arrDrawings[i].X1;
                            tempY1 = arrDrawings[i].Y1;
                            tempX2 = arrDrawings[i].X2;
                            tempY2 = arrDrawings[i].Y2;
                            if (isNew.toLowerCase() == 'false') {
                                tempX1 = tempX1 + intThickness / 2
                                tempY1 = tempY1 + intThickness / 2
                                tempX2 = tempX2 + intThickness / 2
                                tempY2 = tempY2 + intThickness / 2
                            }
                            var linepath = 'M' + tempX1 * intZoomMultiplier + ' ' + tempY1 * intZoomMultiplier + 'L' + tempX2 * intZoomMultiplier + ' ' + tempY2 * intZoomMultiplier

                            var Line = paper.path(linepath);
                            Line.attr({
                                stroke: currColor,
                                "stroke-width": intThickness

                            });
                            arrDrawings[i].TransformID = 'line' + countId
                            Line.id = 'line' + countId
                            Line.mousedown(function (e) {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });
                            Line.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });

                            Line.dblclick(function () { ObjectDblClicked(this); });

                            if (strTransform != '')
                            { Line.transform(strTransform) }

                            break;

                        case 'POLYLINE':

                            var arrPoints = arrDrawings[i].ARRPOINTS;
                            var polypath = ""
                            for (var j = 0; j < arrPoints.length; j++) {
                                tempX1 = arrPoints[j].X1;
                                tempY1 = arrPoints[j].Y1;
                                tempX2 = arrPoints[j].X2;
                                tempY2 = arrPoints[j].Y2;
                                if (isNew.toLowerCase() == 'false') {
                                    tempX1 = tempX1 + intThickness / 2
                                    tempY1 = tempY1 + intThickness / 2
                                    tempX2 = tempX2 + intThickness / 2
                                    tempY2 = tempY2 + intThickness / 2
                                }
                                polypath = polypath + 'L' + tempX1 * intZoomMultiplier + ' ' + tempY1 * intZoomMultiplier + 'L' + tempX2 * intZoomMultiplier + ' ' + tempY2 * intZoomMultiplier
                            }

                            polypath = polypath.replace("L", "M");
                            var path = paper.path(polypath)
                                .attr({
                                    stroke: currColor,
                                    "stroke-width": intThickness
                                });
                            path.id = 'polyline' + countId
                            arrDrawings[i].TransformID = 'polyline' + countId
                            if (strTransform != '')
                            { path.transform(strTransform) }
                            path.mousedown(function (e) {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });
                            path.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });

                            path.dblclick(function () { ObjectDblClicked(this); });

                            break;

                        case 'RECTANGLE':
                            tempX1 = arrDrawings[i].X1;
                            tempY1 = arrDrawings[i].Y1;
                            tempX2 = arrDrawings[i].X2;
                            tempY2 = arrDrawings[i].Y2;
                            if (isNew.toLowerCase() == 'false') {
                                tempX1 = tempX1 + intThickness / 2
                                tempY1 = tempY1 + intThickness / 2
                            }
                            var rectangle = paper.rect(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, tempX2 * intZoomMultiplier, tempY2 * intZoomMultiplier);
                            rectangle.attr({
                                stroke: currColor,
                                "stroke-width": intThickness
                            });
                            if (strTransform != '')
                            { rectangle.transform(strTransform) }
                            rectangle.id = 'rect' + countId
                            arrDrawings[i].TransformID = 'rect' + countId

                            rectangle.mousedown(function (e) {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });
                            rectangle.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });

                            rectangle.dblclick(function () { ObjectDblClicked(this); });

                            break;

                        case 'ELLIPSE':
                            tempX1 = arrDrawings[i].X1;
                            tempY1 = arrDrawings[i].Y1;
                            tempX2 = arrDrawings[i].X2;
                            tempY2 = arrDrawings[i].Y2;
                            var CX, CY, RH, RV;
                            CX = (tempX1 + tempX2 / 2) * intZoomMultiplier;
                            CY = (tempY1 + tempY2 / 2) * intZoomMultiplier;
                            RH = (tempX2 / 2) * intZoomMultiplier;
                            RV = (tempY2 / 2) * intZoomMultiplier;
                            CX = CX + intThickness / 2
                            CY = CY + intThickness / 2
                            var ellipse = paper.ellipse(CX, CY, RH, RV);
                            arrDrawings[i].TransformID = 'ellipse' + countId
                            if (strTransform != '')
                            { ellipse.transform(strTransform) }
                            ellipse.id = 'ellipse' + countId
                            ellipse.mousedown(function (e) {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });
                            ellipse.attr({
                                stroke: currColor,
                                "stroke-width": intThickness
                            });

                            ellipse.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });

                            ellipse.dblclick(function () { ObjectDblClicked(this); });
                            break;

                        case 'TEXT':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE;
                            var font = arrDrawings[i].FONT.split(";");
                            if (isNew.toLowerCase() == 'false') {
                                tempY1 = tempY1 + 7
                            }
                            var newfs = parseInt(font[0].replace('px', ''));
                            newfs = String(newfs * intZoomMultiplier) + 'px';
                            var text = paper.text(tempX1 * intZoomMultiplier, (tempY1 + 7) * intZoomMultiplier, tempStamp).attr({
                                stroke: 'none',
                                fill: currColor,
                                "text-anchor": "start",
                                "stroke-width": intThickness,
                                font: newfs + ' "verdana,geneva,helvetica,sans-serif"',
                                "font-family": "verdana,geneva,helvetica,sans-serif",
                                "font-weight": font[1],
                                "font-style": font[2],
                                "text-anchor": "start"

                            });
                            text.node.setAttribute('data-mapping-enabled', 'true');
                            text.node.setAttribute('data-mapping-id', arrDrawings[i].ID);

                            if (strTransform != '')
                            { text.transform(strTransform) }
                            arrDrawings[i].TransformID = 'text' + countId
                            text.id = 'text' + countId
                            text.mousedown(function (e) {
                                if (e.button == 2) {
                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });

                            text.dblclick(function () { ObjectDblClicked(this); });
                            break;

                        case 'STAMP':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE;
                            arrDrawings[i].TransformID = 'stamp' + countId
                            if (isNew.toLowerCase() == 'false') {
                                tempX1 = tempX1 + 10
                                tempY1 = tempY1 + 18
                            }
                            var scaledSize = 14 * intZoomMultiplier
                            var text = paper.text(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, tempStamp).attr(
                                  {
                                      font: scaledSize + 'px "Segoe UI,Arial,Helvetica,sans-serif"',
                                      "font-family": "Segoe UI,Arial,Helvetica,sans-serif",
                                      "text-anchor": "start",
                                      stroke: 'none',
                                      fill: "red",

                                      "font-weight": "normal"
                                  });
                            text.id = 'stamp' + countId;
                            DrawStamp(paper, text, strTransform)
                            break;

                        case 'IMAGESTAMP':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            var stamp = arrDrawings[i].VALUE.split(";");
                            var value = stamp[0];
                            var width = stamp[1];
                            var height = stamp[2];
                            arrDrawings[i].TransformID = 'imgstamp' + countId
                            var img = paper.image(value, tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, width, height)
                            img.mousedown(function (e) {
                                if (e.button == 2) {

                                    var upX = e.clientX + $(window).scrollLeft() - 5;
                                    var upY = e.clientY + $(window).scrollTop() - 5;
                                    OpenMenu(this, upX, upY);
                                }
                            });
                            img.id = 'imgstamp' + countId;

                            img.dblclick(function () { ObjectDblClicked(this); });

                            if (strTransform != '')
                            { img.transform(strTransform) }
                            break;

                        case 'SPACE':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE;
                            spaceId = arrDrawings[i].SPACEID;
                            strRnd = arrDrawings[i].RANDOM;
                            arrDrawings[i].TransformID = 'SPACE_' + arrDrawings[i].SPACEID + '_' + arrDrawings[i].RANDOM;
                            var img = paper.image("Images/Redlining/smallSpaceOffice2007.png", tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, 16, 16)

                            img.id = 'SPACE_' + arrDrawings[i].SPACEID + '_' + arrDrawings[i].RANDOM;

                            img.click(OpenSpaceToolTip)

                            var text = paper.text((tempX1 * intZoomMultiplier) + 18, (tempY1 * intZoomMultiplier) + 7, tempStamp).attr(
                            {
                                "text-anchor": "start",
                                stroke: 'none',
                                fill: currColor,
                                "stroke-width": intThickness,
                                font: '12px "verdana,geneva,helvetica,sans-serif"',
                                "font-family": "verdana,geneva,helvetica,sans-serif"

                            }).click(OpenSpaceToolTip)
                            var underline = underlineText(paper, text)
                            underline.id = 'SPACE_' + arrDrawings[i].SPACEID + '_' + arrDrawings[i].RANDOM;
                            text.id = 'SPACE_' + arrDrawings[i].SPACEID + '_' + arrDrawings[i].RANDOM;
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

                            if (strTransform != '')
                            { SpaceSet.transform(strTransform) }
                            break;

                        case 'EQUIPMENT':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE;
                            equipmentId = 'EQU_' + countId + '_' + arrDrawings[i].EQUIPMENTID;
                            arrDrawings[i].TransformID = equipmentId;
                            var img = paper.image("Images/Redlining/smallEquipmentOffice2007.png", tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, 16, 16)
                            img.id = equipmentId
                            img.click(GoToEquipment);
                            var text = paper.text((tempX1 * intZoomMultiplier) + 18, (tempY1 * intZoomMultiplier) + 7, tempStamp).attr(
                                 {
                                     "text-anchor": "start",
                                     stroke: 'none',
                                     fill: currColor,
                                     font: '12px "verdana,geneva,helvetica,sans-serif"',
                                     "font-family": "verdana,geneva,helvetica,sans-serif"

                                 }).click(GoToEquipment)
                            var underline = underlineText(paper, text)
                            underline.id = equipmentId
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
                            equSet.ID = equipmentId

                            arrSets.push(equSet);
                            text.id = equipmentId;
                            if (strTransform != '')
                            { equSet.transform(strTransform) }
                            break;

                        case 'NOTE':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE.split("~!@");
                            LinkedRecordId = arrDrawings[i].ID;
                            var DrawingCount = arrDrawings[i].DRAWINGCOUNT;
                            var font = arrDrawings[i].FONT.split(";");


                            var NoteRect = paper.rect((tempX1 - 10) * intZoomMultiplier, (tempY1 - 10) * intZoomMultiplier, 20 * intZoomMultiplier, 20 * intZoomMultiplier).attr(
                                            {
                                                fill: currColor,
                                                x: (tempX1 - 10) * intZoomMultiplier,
                                                y: (tempY1 - 10) * intZoomMultiplier

                                            })

                            NoteRect.id = arrDrawings[i].ID + '~!@' + arrDrawings[i].VALUE + '~!@' + font.join("~!@");//'NOTE_' + tempStamp.join("@!~") + '_' + arrDrawings[i].RANDOM;
                            var mapID = arrDrawings[i].ID.replace("NOTE_", '')
                            NoteRect.node.setAttribute('data-mapping-enabled', 'true');
                            NoteRect.node.setAttribute('data-mapping-id', mapID);

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
                                var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Edit');
                                wnd.setSize(400, 250);
                                wnd.Center();
                                Click = 0;


                            });

                            var text = paper.text(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, DrawingCount).attr(
                                                    {
                                                        "text-anchor": "middle",
                                                        stroke: 'none',
                                                        //fill: currColor,
                                                        "stroke-width": intThickness,
                                                        font: '12px "verdana,geneva,helvetica,sans-serif"',
                                                        "font-family": "verdana,geneva,helvetica,sans-serif",
                                                        "color": "black"


                                                    })

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
                                var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Edit');
                                wnd.setSize(400, 250);
                                wnd.Center();
                                Click = 0;


                            });


                            text.id = arrDrawings[i].ID + '~!@' + arrDrawings[i].VALUE + '~!@' + font.join("~!@");//'NOTE_' + arrDrawings[i].ID + '_' + arrDrawings[i].RANDOM;
                            text.node.setAttribute('data-mapping-enabled', 'true');
                            text.node.setAttribute('data-mapping-id', mapID);

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

                            noteSet.ID = arrDrawings[i].ID + '~!@' + arrDrawings[i].VALUE + '~!@' + font.join("~!@");

                            arrSets.push(noteSet);
                            if (strTransform != '')
                            { noteSet.transform(strTransform) }

                            arrDrawings[i].TransformID = arrDrawings[i].ID + '~!@' + arrDrawings[i].VALUE + '~!@' + font.join("~!@");
                            DrawNoteNumber = parseInt(DrawingCount) + 1;
                            break;


                        case 'printednote':
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE.split("~!@");
                            LinkedRecordId = arrDrawings[i].ID;
                            var font = arrDrawings[i].FONT.split(";");
                            var mapID = arrDrawings[i].ID.replace("NOTE_", '')
                            var arrNoteText = arrDrawings[i].VALUE.split('~!@');

                            var text = paper.text(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, arrNoteText[0] + String.fromCharCode(10) + String.fromCharCode(10) + arrNoteText[1]).attr(
                                                    {
                                                        "text-anchor": "middle",
                                                        stroke: 'none',
                                                        "stroke-width": intThickness,
                                                        font: font[0] + ' "verdana,geneva,helvetica,sans-serif"',
                                                        "font-family": "verdana,geneva,helvetica,sans-serif",
                                                        "font-weight": font[1],
                                                        "font-style": font[2],
                                                        "color": currColor
                                                    });

                            text.id = arrDrawings[i].ID + '~!@' + arrDrawings[i].VALUE + '~!@' + font.join("~!@");
                            text.node.setAttribute('data-mapping-enabled', 'true');
                            text.node.setAttribute('data-mapping-id', mapID);
                            break;
                        default:

                            var DrawingCount = arrDrawings[i].DRAWINGCOUNT;
                            tempX1 = arrDrawings[i].X;
                            tempY1 = arrDrawings[i].Y;
                            tempStamp = arrDrawings[i].VALUE;
                            LinkedRecordId = arrDrawings[i].ID;
                            strRnd = arrDrawings[i].RANDOM;
                            arrDrawings[i].TransformID = 'linkedrecord_' + arrDrawings[i].RECORDTYPE + '_' + arrDrawings[i].ID + '_' + arrDrawings[i].VALUE + '~!@' + arrDrawings[i].MAINPAGE;;
                            var ellipse = paper.ellipse(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, 10 * intZoomMultiplier, 10 * intZoomMultiplier);
                            ellipse.id = 'linkedrecord_' + arrDrawings[i].RECORDTYPE + '_' + arrDrawings[i].ID + '_' + arrDrawings[i].VALUE + '~!@' + arrDrawings[i].MAINPAGE;

                            ellipse.MainPage = arrDrawings[i].MAINPAGE;
                            ellipse.attr({
                                fill: currColor,
                                MainPage: arrDrawings[i].MAINPAGE,
                                VALUE: arrDrawings[i].VALUE,
                                x: tempX1 * intZoomMultiplier,
                                y: tempY1 * intZoomMultiplier
                            })

                            ellipse.click(function () { OpenLinkToolTip(this); });

                            var text = paper.text(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, DrawingCount).attr(
                            {
                                "text-anchor": "middle",
                                stroke: 'none',
                                "stroke-width": intThickness,
                                font: '12px "verdana,geneva,helvetica,sans-serif"',
                                "font-family": "verdana,geneva,helvetica,sans-serif",
                                "color": "black"

                            }).click(function () { OpenLinkToolTip(this); });
                            text.MainPage = arrDrawings[i].MAINPAGE;
                            text.id = 'linkedrecord_' + arrDrawings[i].RECORDTYPE + '_' + arrDrawings[i].ID + '_' + arrDrawings[i].VALUE + '~!@' + arrDrawings[i].MAINPAGE;

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

                            linkedrecordSet.ID = 'linkedrecord_' + arrDrawings[i].RECORDTYPE + '_' + arrDrawings[i].ID + '_' + arrDrawings[i].VALUE + '~!@' + arrDrawings[i].MAINPAGE;

                            arrSets.push(linkedrecordSet);
                            if (strTransform != '')
                            { linkedrecordSet.transform(strTransform) }
                            DrawLinkNumber = parseInt(DrawingCount) + 1;

                            break;
                    }
                }
            }
        }
        tempStamp = bufferStamp;
        tempType = bufferType;
        currColor = bufferColor;
        intThickness = bufferThickness;
        equipmentId = bufferequipmentId;
        spaceId = bufferspaceId;

    }


</script>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server" EnableScriptGlobalization="True" EnablePageMethods="true"
            EnableTheming="True" ScriptMode="Release">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpRedlining">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpRedlining" runat="server" BackgroundPosition="Center" Skin="Default" />



        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar2" Width="100%" runat="server" Skin="Default" AutoPostBack="true" data-exclude="true">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="ExportPDF" EnableImageSprite="true" CssClass="ToolbarExportPDF">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton PostBack="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbxAllPages" runat="server" AutoPostBack="True" Checked="false" />
                                                <asp:Label ID="lblAllPages" runat="server" Text="AllPages" meta:Resourcekey="lblAllPages"> </asp:Label>
                                            </ItemTemplate>
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td id="tdCanvas">
                                            <div id="divZoomer" style="">
                                                <div id="Canvas" runat="server" onclick="CanvasClicked();">
                                                    <div id="divImage">
                                                    </div>
                                                    <asp:Image ID="imgCanvas" ondragstart="return false;" runat="server" />
                                                </div>
                                            </div>
                                            <asp:PlaceHolder ID="placeholder" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend>Actions</legend>
                                            <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <telerik:RadGrid ID="rdgActions" runat="server" AllowMultiRowSelection="false" AutoGenerateColumns="False" CssClass="RedliningGrid"
                                                            GridLines="None" ShowStatusBar="false" AllowPaging="false" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                            AllowSorting="true" ShowFooter="false" Width="100%" AllowFilteringByColumn="false">

                                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
                                                                DataKeyNames="Id" Width="100%" >
                                                                <SortExpressions>
                                                                    <telerik:GridSortExpression FieldName="PageNumber" SortOrder="Ascending"></telerik:GridSortExpression>

                                                                </SortExpressions>
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="ActionType" UniqueName="ActionType" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.String" DataField="ActionType">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblActionType" runat="server" Text='<%#If(Eval("Description") = String.Empty, "&nbsp;", Eval("ActionType"))%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="100px" />
                                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="DrawingCount" UniqueName="DrawingCount" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.Int32" DataField="DrawingCount">
                                                                        <ItemTemplate>

                                                                            <asp:Label ID="lblDrawingCount" runat="server" Text='<%#If(Eval("DrawingCount") = 0, "&nbsp;", Eval("DrawingCount"))%>'></asp:Label>
                                                                            <telerik:RadDiagram ID="thediagram" CssClass="diagram" runat="server" Width="20px" Height="20px " Editable="false" Zoom="1" ZoomMax="1" ZoomMin="1">
                                                                                <ShapesCollection>
                                                                                    <telerik:DiagramShape Id="start" Width="20" Height="20" Type="rectangle" Editable="false" Selectable="false">
                                                                                        <FillSettings Color="#cf3737" />
                                                                                        <ContentSettings Text="2" />
                                                                                    </telerik:DiagramShape>
                                                                                </ShapesCollection>
                                                                            </telerik:RadDiagram>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="50px" />
                                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.String" DataField="Description">
                                                                        <ItemTemplate>

                                                                            <asp:Label ID="lblDescription" runat="server" Text='<%#If(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%>'></asp:Label>
                                                                            <%--                                                            <span><%#IIf(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%></span>--%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="200px" />
                                                                        <HeaderStyle Width="200px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="User" UniqueName="User" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.String" DataField="User">
                                                                        <ItemTemplate>

                                                                            <span><%#IIf(Eval("User") = String.Empty, "&nbsp;", Eval("User"))%></span>

                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="150px" />
                                                                        <HeaderStyle Width="120px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="Date" UniqueName="ActionDate" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.DateTime" DataField="ActionDate">
                                                                        <ItemTemplate>

                                                                            <span><%#If(Eval("ActionDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("ActionDate")) + "<br/>" + FormatTime(Eval("ActionDate")))%></span>

                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                        <ItemStyle Width="150px" />
                                                                        <HeaderStyle Width="150px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.String" DataField="Company">
                                                                        <ItemTemplate>

                                                                            <span><%#IIf(Eval("Company") = String.Empty, "&nbsp;", Eval("Company"))%></span>

                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="150px" />
                                                                        <HeaderStyle Width="150px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="LinkType" UniqueName="LinkType" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.String" DataField="LinkType">
                                                                        <ItemTemplate>

                                                                            <span><%#IIf(Eval("LinkType") = String.Empty, "&nbsp;", Eval("LinkType"))%></span>

                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="100px" />
                                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="HyperLink" UniqueName="HyperLink" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.String" DataField="HyperLink">
                                                                        <ItemTemplate>

                                                                            <asp:LinkButton runat="server" ID="btnHyperLink" style="color:blue;" > 
                                                                <span style="color :blue"><%#IIf(Eval("HyperLink") = String.Empty, " ", Eval("HyperLink"))%></span>
                                                                            </asp:LinkButton>

                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="150px" />
                                                                        <HeaderStyle Width="150px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn HeaderText="Page1" UniqueName="PageNumber" ItemStyle-HorizontalAlign="Right" Reorderable="true"
                                                                        AllowFiltering="false" DataType="System.Int32" DataField="PageNumber">
                                                                        <ItemTemplate>
                                                                            <span><%# Eval("PageNumber")%></span>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="50px" />
                                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                                <NoRecordsTemplate>
                                                                    <table style="height: 50px; width: 100%">
                                                                        <tr>
                                                                            <td class="Top Center">
                                                                                <asp:Label ID="lblNoFileToDisplay" runat="server" meta:ResourceKey="lblNoFileToDisplay"
                                                                                    Text="No Files to display."></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </NoRecordsTemplate>
                                                            </MasterTableView>
                                                            <ClientSettings AllowColumnsReorder="False">
                                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="False" AllowColumnResize="False" />
                                                                <Selecting EnableDragToSelectRows="False" AllowRowSelect="False" />
                                                            </ClientSettings>
                                                            <ItemStyle />
                                                            <AlternatingItemStyle />
                                                            <HeaderStyle />
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>

                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>


        <asp:HiddenField ID="hnDrawings" runat="server" />
        <asp:HiddenField runat="server" ID="hdnSkin" />
        <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>
        <telerik:RadToolTipManager runat="server" ID="RadToolTipManager1" Position="TopCenter"
            RelativeTo="Mouse" Width="395px" Height="185px" Animation="Resize" HideEvent="ManualClose"
            Skin="Default" OnAjaxUpdate="OnAjaxUpdate" EnableShadow="true" RenderInPageRoot="true" AnimationDuration="200">
        </telerik:RadToolTipManager>

    </form>
</body>
</html>
