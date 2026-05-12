var IE = document.all ? true : false
var leftOffset = 0;
var topOffset = 0;
var arrDrawings = []; var arrDeletedDrawings = []; var arrPolygonPoints = [];
var arrMeasures = []; var arrDeletedMeasures = [];
var tempType = ''; var mouseX = 0; var mouseY = 0; var tempX1 = 0; var tempY1 = 0; var tempX2 = 0; var tempY2 = 0; var tempStamp = ''; var tempText = '';
var spaceId = 0; var equipmentId = 0; var strRnd = '';
var txtTextId = '';
var clickNumber = 0;
var intThickness = 1; 
var intZoomMultiplier = 1; 
var mouseElement; 
var currColor = ''; 
var isVisible = true; 
var strTransform = '';
var imgCanvasInitWidth = 0; var imgCanvasInitHeight = 0; var divZoomerInitWidth = 0; var divZoomerInitHeight = 0;
var bufferStamp = ''; var bufferType = ''; var bufferColor = ''; var bufferThickness = 1; var bufferequipmentId = 0; var bufferspaceId = 0; 
var drawingsCateg =''// ANN for annotations; MSR for measures
var tmpCateg = '';
var objToolBar;
var isScaled = true; var scaleMultiplier = 1; var scaleSetup = false;
var imgCanvasId = 'ctl00_CPH1_imgCanvas';
var txtDisMapId = 'ctl00_CPH1_txtDisMap';  
var txtDisGridId = 'ctl00_CPH1_txtDisGrd';
var skin;
var undoIndex = 0;
var redoIndex = 1;
var paper;
var canvas;
var mouseDownX;
var mouseDownY;
var shap;
var elemClicked;
var isMouseDown = 0;
var startLine = [];
var endLine = [];
var currX;
var currY;
var textInput;
var center = [];
var radius = [];
var polyX = -1;
var polyY = -1;
var countId = 0;
var ft = null;
var isEdit = '';
var isNew;
var arrSets = [];
var msrShap;
var CanvasImg;
var gridId;
var RecordId;
var ProjectId;
var LinkedRecordId;
var LinkedRecordTypeId;
var LinkedRecordNumber;
var LinkedRecordType;
var LinkNumber;
var NoteValue;
var NFont;
var NoteNumber;
var fontWeight;
var fontStyle;
var fontSize;
var textFromPopup;
var menuX; var menuY;
var tooltipX; var tooltipY;
var arrVisible = [];
var tooltipelement;
var Click = 0;
var timer = null;
var polyStroke; var polyColor;
var imgRotation;
var tooltip = null;
function OpenMenu(me, x1, y1) {
    if (drawingsCateg == 'ANN') {
        var contextMenu = $find("ctl00_CPH1_PMWebViewerDrawing1_cmEdit");
    }
    else {
        var contextMenu = $find("ctl00_CPH1_PMWebViewerMeasurement1_cmEdit");
    }
    if (cursorType == 'Move') {
        cursorType = 'Default';
        $('#Canvas').hover(function () { $(this).css('cursor', 'default') })
    }
    elemClicked = me.id;
    contextMenu.showAt(x1, y1);
    if (drawingsCateg == 'ANN') {
        if (!me.id.startsWith('text')) {
            contextMenu.findItemByValue('EditText').set_outerCssClass("Hide")
        }
        else {
            contextMenu.findItemByValue('EditText').set_outerCssClass("")
        }
        if (!me.id.startsWith('NOTE')) {
            contextMenu.findItemByValue('EditNote').set_outerCssClass("Hide")
        }
        else {
            contextMenu.findItemByValue('EditNote').set_outerCssClass("")

        }
        //if (!me.id.startsWith('linkedrecord') && !me.id.startsWith('NOTE') && !me.id.toLowerCase().startsWith('space') && !me.id.startsWith('EQU_')) {
        //    contextMenu.findItemByValue('Edit').set_enabled(true)
        //}
        //else {
        //    contextMenu.findItemByValue('Edit').set_enabled(false)
        //}
    }
    if (isEdit)
    { contextMenu.findItemByValue('EndEdit').set_enabled(true) }
    else
    { contextMenu.findItemByValue('EndEdit').set_enabled(false) }

}

function ReDrawANN() {
    clickNumber = 0;
    bufferStamp = tempStamp;
    bufferType = tempType;
    bufferColor = currColor;
    bufferThickness = intThickness;
    bufferequipmentId = equipmentId;
    bufferspaceId = spaceId;
    countId = 0;
    arrSets = [];
    if (drawingsCateg == "ANN") {
        $('#Canvas')[0].innerHTML = $('#Canvas')[0].children['ctl00_CPH1_PMWebViewerDrawing1_imgCanvas'].outerHTML + $('#Canvas')[0].children['divResize'].outerHTML
    }
    else if (drawingsCateg == "MSR") {
        $('#Canvas')[0].innerHTML =$('#Canvas')[0].children['imgCanvas'].outerHTML +  $('#Canvas')[0].children['divResize'].outerHTML;
    }
    paper = new Raphael("Canvas");
    paper.clear();
    skin = $("[id$=hdnSkin]").val();
    var DrawLinkNumber = "1";
    var DrawNoteNumber = "1";

    for (var i = 0; i < arrDrawings.length; i++) {
        tempType = arrDrawings[i].TYPE;
        currColor = arrDrawings[i].COLOR;
        intThickness = arrDrawings[i].STROKE;
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

                        var widthACurveTransString = "A" + 2*widthRadius/3 + "," + 2*widthRadius/3 + " 0 0,1 "
                        var heightACurveTransString = "A" + 0.9*heightRadius + "," + 0.9*heightRadius + " 0 0,1 "

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

                        var widthACurveTransString = "A" + 0.9*widthRadius + "," + 0.9*widthRadius + " 0 0,1 "
                        var heightACurveTransString = "A" + 2*heightRadius/3 + "," + 2*heightRadius/3 + " 0 0,1 "

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

                    Line.dblclick(function () { ObjectDblClicked(this);});

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
                    
                    path.dblclick(function () { ObjectDblClicked(this);});

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
                            var upX = e.clientX + $(window).scrollLeft() -5;
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
                    CX = (tempX1 + tempX2 / 2)*intZoomMultiplier;
                    CY = (tempY1 + tempY2 / 2) * intZoomMultiplier;
                    RH = (tempX2 / 2)*intZoomMultiplier;
                    RV = (tempY2 / 2) * intZoomMultiplier;
                    CX = CX + intThickness / 2
                    CY = CY + intThickness / 2
                   var ellipse = paper.ellipse(CX , CY, RH, RV);
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
                    var text = paper.text(tempX1 * intZoomMultiplier, (tempY1) * intZoomMultiplier + 7, tempStamp).attr({
                        stroke: 'none',
                        fill: currColor,
                        "text-anchor":"start",
                        "stroke-width": intThickness,
                        font: font[0] + ' "verdana,geneva,helvetica,sans-serif"',
                        "font-family": "verdana,geneva,helvetica,sans-serif",
                        "font-weight": font[1],
                        "font-style":font[2],
                        "text-anchor":"start"

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
                    var text = paper.text(tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, tempStamp).attr(
                          {
                              font: '14px "Segoe UI,Arial,Helvetica,sans-serif"',
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
                    equipmentId = 'EQU_' +countId + '_'+ arrDrawings[i].EQUIPMENTID;
                    arrDrawings[i].TransformID = equipmentId;
                    var img = paper.image("Images/Redlining/smallEquipmentOffice2007.png", tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, 16, 16)
                    img.id = equipmentId
                    img.click(GoToEquipment);
                    var text = paper.text((tempX1 * intZoomMultiplier )+ 18, (tempY1 * intZoomMultiplier) + 7, tempStamp).attr(
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
                                       x: (tempX1-10) * intZoomMultiplier,
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
                        if (CanEdit == 'True') {
                            clearTimeout(timer);
                            var hdnNotes = $("[id$=hdnNotes]")[0];
                            hdnNotes.value = this.id;
                            var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Edit');
                            wnd.setSize(400, 250);
                            wnd.Center();
                            Click = 0;
                        }

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
                        if (CanEdit == 'True') {
                            clearTimeout(timer);
                            var hdnNotes = $("[id$=hdnNotes]")[0];
                            hdnNotes.value = this.id;
                            var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Edit');
                            wnd.setSize(400, 250);
                            wnd.Center();
                            Click = 0;
                        }


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
                    ellipse.id = 'linkedrecord_'+arrDrawings[i].RECORDTYPE + '_' + arrDrawings[i].ID + '_' + arrDrawings[i].VALUE +'~!@'+ arrDrawings[i].MAINPAGE;

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
    tempStamp = bufferStamp;
    tempType = bufferType;
    currColor = bufferColor;
    intThickness = bufferThickness;
    equipmentId = bufferequipmentId;
    spaceId = bufferspaceId;
    
}

function editText(Me)
{
    paper.inlineTextEditing(Me);
    textInput = Me.inlineTextEditing.startEditing();
    try {
       
        textInput.addEventListener("blur", function (e) {
            Me.inlineTextEditing.stopEditing();
            if (drawingsCateg == 'ANN') {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (arrDrawings[i].TransformID == elemClicked) {
                        arrDrawings[i].VALUE = Me.inlineTextEditing.input.value;
                        arrDrawings[i].FONT = "12px;Normal;Normal";
                        }
                }
            }
            else {
                for (var i = 0; i < arrMeasures.length; i++) {
                    if (arrMeasures[i].TransformID == elemClicked) {
                        arrMeasures[i].CENTROID = Me.inlineTextEditing.input.value;
                    } 
                   
                    if (tempType == "polygon") {
                        ReDrawMSR()
                    }
                }
            }
            if (autoSave == 'True') {
                AutoSaveDrawings()
            }
        }, true);
    }
    catch (e) {
        $(textInput).blur(function (e) {
            Me.inlineTextEditing.stopEditing();
            if (drawingsCateg == 'ANN') {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (arrDrawings[i].TransformID == elemClicked) {
                        arrDrawings[i].VALUE = Me.inlineTextEditing.input.value;

                    }
                }
            }
            else {
                
                for (var i = 0; i < arrMeasures.length; i++) {
                    if (arrMeasures[i].TransformID == elemClicked) {
                        arrMeasures[i].CENTROID = Me.inlineTextEditing.input.value;
                    }
                }
                if (tempType == "polygon") {
                    ReDrawMSR()
                }
            }
            if (autoSave == 'True') {
                AutoSaveDrawings()
            }
        });
    }
}
function OpenSpaceToolTip() {
   
    if (tooltipelement) {
        $('#Canvas')[0].removeChild(tooltipelement);
        hideToolTip(tooltipelement);
        tooltipelement = '';
    }

    var div = document.getElementById(this.id);
    if (!div) {
        div = document.createElement("div");
        div.id = this.id;
        div.style.left = parseInt(this.attrs.x) + 'px';
        div.style.top = parseInt(this.attrs.y) + 'px';
        div.style.position = "absolute";
        $('#Canvas')[0].appendChild(div);
    }
    showToolTip(div);

}
function Testing(me) {
    if (me == null) return;
  
        var div = document.getElementById(me.id);
        if (!div) {
            div = document.createElement("div");
            div.id = me.id;
            div.setAttribute("VALUE", me.attrs.VALUE);
            div.style.left = mouseX + 'px'; //parseInt(me.attrs.x) + 'px';
            div.style.top = mouseY + 'px';// parseInt(me.attrs.y) + 'px';
            div.style.position = "absolute";
            $('#Canvas')[0].appendChild(div);
            showToolTip(div);

        } 
}
function OpenLinkToolTip(me) {
    if (tooltipelement) { 
        $('#Canvas')[0].removeChild(tooltipelement);
        hideToolTip(tooltipelement);
        tooltipelement = '';
        
    }
        Testing(me);
 
}


function HideLinkToolTip() {
    var div = document.getElementById(this.id);
    if (div) {
        $('#Canvas')[0].removeChild(div);
       hideToolTip(div);
    }
}



function GoToEquipment(equipmentid) {
    var arr = this.id.split('_');
    var id = arr[2];
    window.location.href = 'Equipments.aspx?Id=' + id + '&ModuleId=5&PageId=102';
}

function GoToLink(PageRef) {
    if (this.id) {
        if (this.id.indexOf('NOTE_') == 0) {
            var hdnNotes = $("[id$=hdnNotes]")[0];
            hdnNotes.value = this.id;
            var wnd = window.radopen('PMWebViewerNotePopup.aspx');
            wnd.setSize(400, 250);
            wnd.Center();
        }
    }
    else {
        window.location.href = PageRef;
    }
}

function underlineText(paper,textElement) {
    var textbox = textElement.getBBox();
    var textUnderline = paper.path("M" + textbox.x + " " + (textbox.y + textbox.height) + "L" + (textbox.x + textbox.width) + " " + (textbox.y + textbox.height)).attr({
        stroke: currColor,
        "stroke-width": 1
    });
    return textUnderline;
    }

function DrawStamp(paper, textElement, strTransform) {
    
    var textbox = textElement.getBBox();
    var Stamp = paper.rect(textbox.x - 3, textbox.y - 3, (textbox.width + 5), (textbox.height + 5)).attr( 
                        {
                            stroke: 'red',
                            "stroke-width": 2
                        });
    var stampSet = paper.set()
    stampSet.push(textElement);
    stampSet.push(Stamp);
    stampSet.mousedown(function (e) {
        if (e.button == 2) {
            
            var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
    });

    stampSet.dblclick(function () { ObjectDblClicked(this); });

    Stamp.id = 'stamp' + countId;
    stampSet.ID = 'stamp' + countId;
    arrSets.push(stampSet);
    if (strTransform != '')
    { stampSet.transform(strTransform) }

}

function OnClientDropDownOpened(sender, eventArgs) {
    if (drawingsCateg == "ANN") {
        var sldrZoom = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i13_i0_txtZoomValue");
        var sldrThickness = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i11_i0_sldrThickness");
    }
    else {
        var sldrZoom = $find("ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i12_i0_sldrZoom");
        var sldrThickness = $find("ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i11_i0_sldrThickness");
    }
    sldrZoom.repaint();
    sldrThickness.repaint();
}

function DrawANN() {
}

function ResetMeasures() {////////// REVIEW

    intZoomMultiplier = 1;
    imgCanvasInitWidth = 0;
    imgCanvasInitHeight = 0;

    var imgCanvas = document.getElementById(imgCanvasId);
    imgCanvas.style.width = '0px';
    imgCanvas.style.height = '0px';
}


function ReDrawMSR() {
   
    clickNumber = 0;
    bufferType = tempType;
    bufferColor = currColor;
    bufferThickness = intThickness;
    if (window.location.toString().indexOf('VisualCalculator') > 0 || window.location.toString().indexOf('RedliningMeasuresPopup') > 0) {
        $('#Canvas')[0].innerHTML = $('#Canvas')[0].children['divImage'].outerHTML + $('#Canvas')[0].children['imgCanvas'].outerHTML;

    }
    else {
       $('#Canvas')[0].innerHTML =  $('#Canvas')[0].children['ctl00_CPH1_PMWebViewerMeasurement1_imgCanvas'].outerHTML + $('#Canvas')[0].children['divResize'].outerHTML;
    }
    arrSets = [];
   paper = new Raphael("Canvas");
    for (var i = 0; i < arrMeasures.length; i++) {
        countId = countId + 1;
        tempType = arrMeasures[i].TYPE;
        currColor = arrMeasures[i].COLOR;
        intThickness = arrMeasures[i].STROKE;
        isVisible = arrMeasures[i].VISIBLE;
        tempText = arrMeasures[i].CENTROID;
        strTransform = arrMeasures[i].TRANSFORM;
        if (strTransform != '' && strTransform) {

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
         
        if (!arrMeasures[i].ISNEW)
        { isNew = 'true'; }
        else { isNew = arrMeasures[i].ISNEW; }
        if (isVisible == true) {
            switch (tempType) {
                case 'LINE':
                    tempX1 = arrMeasures[i].X1;
                    tempY1 = arrMeasures[i].Y1;
                    tempX2 = arrMeasures[i].X2;
                    tempY2 = arrMeasures[i].Y2;
                    if (isNew.toLowerCase() == 'false') {
                        tempX1 = tempX1 + intThickness / 2
                        tempY1 = tempY1 + intThickness / 2
                        tempX2 = tempX2 + intThickness / 2
                        tempY2 = tempY2 + intThickness / 2
                    }
                    drawLineMsr(tempText, tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, tempX2 * intZoomMultiplier, tempY2 * intZoomMultiplier, i, strTransform)
                    
                    break;
                    
                case 'POLYGON':
                    
              arrPolygonPoints = arrMeasures[i].ARRPOLYGONPOINTS;
              var arrXPoints;
              var arrYPoints;
              arrXPoints = [];
              arrYPoints = [];
              polyColor = currColor
              polyStroke = intThickness
              for (var j = 0; j < arrPolygonPoints.length; j++) {
                  if (isNew.toLowerCase() == 'false') {
                      arrPolygonPoints[j].X = arrPolygonPoints[j].X + intThickness / 2
                      arrPolygonPoints[j].Y = arrPolygonPoints[j].Y + intThickness / 2

                  }
                  arrXPoints.push(arrPolygonPoints[j].X * intZoomMultiplier);
                  arrYPoints.push(arrPolygonPoints[j].Y * intZoomMultiplier);
              }
              drawPolygonMSR(tempText, arrXPoints, arrYPoints, i, strTransform, 'false');
             break;

               case 'RECTANGLE':
                   tempX1 = arrMeasures[i].X1;
                   tempY1 = arrMeasures[i].Y1;
                   tempX2 = arrMeasures[i].X2;
                   tempY2 = arrMeasures[i].Y2;
                   if (isNew.toLowerCase() == 'false') {
                       tempX1 = tempX1 + intThickness / 2
                       tempY1 = tempY1 + intThickness / 2
                   }
                   drawRectangleMSR(tempText, tempX1 * intZoomMultiplier, tempY1 * intZoomMultiplier, tempX2 * intZoomMultiplier, tempY2 * intZoomMultiplier, i, strTransform)
                   break;

             case 'ELLIPSE':
                 tempX1 = arrMeasures[i].X1;
                 tempY1 = arrMeasures[i].Y1;
                 tempX2 = arrMeasures[i].X2;
                 tempY2 = arrMeasures[i].Y2;
                 var CX, CY, RH, RV;
                 CX = (tempX1 + tempX2 / 2) * intZoomMultiplier;
                 CY = (tempY1 + tempY2 / 2) * intZoomMultiplier;
                 RH = (tempX2 / 2) * intZoomMultiplier;
                 RV = (tempY2 / 2) * intZoomMultiplier;
                     CX = CX + intThickness / 2
                     CY = CY + intThickness / 2
                 drawEllipseMSR(tempText, CX, CY, RH, RV, i, strTransform);
                 break;
           }
        }
    }
    tempType = bufferType;
    currColor = bufferColor;
    intThickness = bufferThickness;
    
}

function drawLineMsr(txt, x1, y1, x2, y2, i, strTransform)
{
    
    var msrSet = paper.set()
    var linepath = 'M' + x1 + ' ' + y1 + 'L' + x2 + ' ' + y2
    var Line = paper.path(linepath).toFront();
    Line.toFront;
    Line.attr({
        stroke: currColor,
        "stroke-width": intThickness
    });
    Line.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });
    arrMeasures[i].TransformID = 'line' + countId
    Line.id = 'line' + countId
    
    var arrCenterPoints = [];
    arrCenterPoints.push({ X: x1, Y: y1 });
    arrCenterPoints.push({ X: x2, Y: y2 });
    var CenterPoints = CalculateCentroid(arrCenterPoints);
    var text = paper.text(CenterPoints[0].X, CenterPoints[0].Y + 7, txt).attr({
        stroke: 'none',
        fill: currColor,
        "stroke-width": intThickness,
        font: '12px "verdana,geneva,helvetica,sans-serif"',
        "font-family": "verdana,geneva,helvetica,sans-serif",
        "font-weight": "normal",
        "text-anchor": "middle"

    });
    text.id = 'line' + countId;
    msrSet.push(Line);
    msrSet.push(text);

    msrSet.ID = 'line' + countId;
    arrSets.push(msrSet);
    if (strTransform != '')
    { msrSet.transform(strTransform) }
    
    msrSet.mousedown(function (e) {
        if (e.button == 2) {
           var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
       
    });

    msrSet.dblclick(function () { ObjectDblClicked(this); });

}

function drawRectangleMSR(txt, x, y, width, height, i, strTransform)
{
    var msrSet = paper.set()
    var rectangle = paper.rect(x, y, width, height);
    rectangle.attr({
        stroke: currColor,
        "stroke-width": intThickness
    });
    rectangle.id = 'rect' + countId
    arrMeasures[i].TransformID = 'rect' + countId
    rectangle.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });
    
    var arrCenterPoints = [];
    arrCenterPoints.push({ X: x, Y: y });
    arrCenterPoints.push({ X: x + width, Y: y });
    arrCenterPoints.push({ X: x + width, Y: y + height });
    arrCenterPoints.push({ X: x, Y: y + height });

    var CenterPoints = CalculateCentroid(arrCenterPoints);
    var text = paper.text(CenterPoints[0].X, CenterPoints[0].Y + 7, txt).attr({
        stroke: 'none',
        fill: currColor,
        "stroke-width": intThickness,
        font: '12px "verdana,geneva,helvetica,sans-serif"',
        "font-family": "verdana,geneva,helvetica,sans-serif",
        "font-weight": "normal",
        "text-anchor": "middle"

    });
    text.id = 'rect'+countId;
    msrSet.push(rectangle);
    msrSet.push(text);

    msrSet.mousedown(function (e) {
        if (e.button == 2) {
            var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
    });

    msrSet.dblclick(function () { ObjectDblClicked(this); });

    msrSet.ID = 'rect' + countId;
    arrSets.push(msrSet);
    if (strTransform != '')
    { msrSet.transform(strTransform) }
}

function drawEllipseMSR(txt, x, y, RH, RV, i, strTransform) {
    var msrSet = paper.set();
    var ellipse = paper.ellipse(x, y, RH, RV);
    ellipse.attr({
        stroke: currColor,
        "stroke-width": intThickness
    });
    arrMeasures[i].TransformID = 'ellipse' + countId;
    ellipse.id = 'ellipse' + countId;
    ellipse.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });
    var text = paper.text(x, y + 7, txt).attr({
        stroke: 'none',
        fill: currColor,
        "stroke-width": intThickness,
        font: '12px "verdana,geneva,helvetica,sans-serif"',
        "font-family": "verdana,geneva,helvetica,sans-serif",
        "font-weight": "normal",
        "text-anchor": "middle"

    });
    text.id = 'ellipse' + countId;
    msrSet.push(ellipse);
    msrSet.push(text);

    msrSet.ID = 'ellipse' + countId;
    msrSet.mousedown(function (e) {
        if (e.button == 2) {
            var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
    });

    msrSet.dblclick(function () { ObjectDblClicked(this); });

    arrSets.push(msrSet);
    if (strTransform != '')
    { msrSet.transform(strTransform) }
}

function drawPolygonMSR(txt, arrX, arrY, j, strTransform, isNewPoly)
{
    var msrSet = paper.set();
    var polypath = ""
    for (var i = 0; i < arrX.length; i++) {
        tempX1 = arrX[i];
        tempY1 = arrY[i];
        polypath = polypath + 'L' + tempX1 + ' ' + tempY1
    }
    polypath = polypath.replace("L", "M");
    polypath+='Z'
    var path = paper.path(polypath)
        .attr({
            stroke: polyColor,
            "stroke-width": polyStroke
        });
    path.hover(function (e) { if (isMouseDown == 0) { this.g = this.glow({ color: this.attrs.stroke }); } }, function (e) { if (this.g != null) { this.g.remove() } });
    var arrCenterPoints = [];

    path.id = 'polyline' + countId;
 
    arrMeasures[j].TransformID = 'polyline' + countId;
     
    for (var i = 0; i < arrX.length; i++) {
        arrCenterPoints.push({ X: arrX[i], Y: arrY[i] });
    }
    var CenterPoints = CalculateCentroid(arrCenterPoints);

    var text = paper.text(CenterPoints[0].X, CenterPoints[0].Y, txt).attr({
        stroke: 'none',
        fill: polyColor,
        "stroke-width": polyStroke,
        font: '12px "verdana,geneva,helvetica,sans-serif"',
        "font-family": "verdana,geneva,helvetica,sans-serif",
        "font-weight": "normal",
        "text-anchor": "middle"

    });
    text.id = 'polyline' + countId;
    msrSet.push(path);
    msrSet.push(text);

    msrSet.ID = 'polyline' + countId;
    msrSet.mousedown(function (e) {
        if (e.button == 2) {
            var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
    });

    msrSet.dblclick(function () { ObjectDblClicked(this); });
   
    arrSets.push(msrSet);
    if (strTransform != '')
    { msrSet.transform(strTransform) }
    if (isNewPoly == 'true')
    {
        elemClicked = 'polyline' + countId;
        if (addTextToMsr == true) {
            editText(text);
        }
    }
}

function CalculateCentroid(arrPoints) {
    var nPts = arrPoints.length;
    var CentroidArr = [];
    var X = 0; var Y = 0;
    var f;
    var j = nPts - 1;
    var p1; var p2;
    if (nPts > 2) {
        for (var i = 0; i < nPts; j = i++) {
            p1 = arrPoints[i]; p2 = arrPoints[j];
            f = p1.X * p2.Y - p2.X * p1.Y;
            X += (p1.X + p2.X) * f;
            Y += (p1.Y + p2.Y) * f;
        }
        f = CalculateArea(arrPoints) * 6;
        CentroidArr.push({ X: X / f, Y: Y / f });
    } else {
        if (nPts == 2) {
            CentroidArr.push({ X: (arrPoints[0].X + arrPoints[1].X) / 2, Y: (arrPoints[0].Y + arrPoints[1].Y) / 2 });
        } else {
            CentroidArr.push({ X: 0, Y: 0 });
        }
    }
    return CentroidArr
}
function CalculateArea(arrPoints) {
    var area = 0;
    var nPts = arrPoints.length;
    var j = nPts - 1;
    var p1; var p2;

    for (var i = 0; i < nPts; j = i++) {
        p1 = arrPoints[i]; p2 = arrPoints[j];
        area += p1.X * p2.Y;
        area -= p1.Y * p2.X;
    }
    area /= 2;
    return area;
};

function DrawMSR() {
    
}


function CanvasDblClicked() {
    if (drawingsCateg == 'MSR') {
        switch (tempType) {
            case 'polygon':
                
                if (clickNumber >= 2) {
                    countId = countId + 1;
                    var polId = 'polyline' + countId;
                    var arrXPoints;
                    var arrYPoints;
                    arrXPoints = [];
                    arrYPoints = [];
                    for (var j = 0; j < arrPolygonPoints.length; j++) {
                        arrXPoints.push(arrPolygonPoints[j].X);
                        arrYPoints.push(arrPolygonPoints[j].Y);
                    }
                    var tmpArea = PolygonAreaCalculation(arrPolygonPoints);
                    arrMeasures.push({ 'TYPE': 'POLYGON', 'ID': '', 'CENTROID': '','LENGTH': 0, 'AREA': tmpArea, 'ARRPOLYGONPOINTS': arrPolygonPoints, 'COLOR': polyColor, 'STROKE': polyStroke, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'polyline'+ countId });
                    arrXPoints = [];
                    arrYPoints = [];
                    for (var j = 0; j < arrPolygonPoints.length; j++) {
                        arrXPoints.push(arrPolygonPoints[j].X * intZoomMultiplier);
                        arrYPoints.push(arrPolygonPoints[j].Y * intZoomMultiplier);
                    }
                   drawPolygonMSR('',arrXPoints,arrYPoints,arrMeasures.length-1, '', 'true')
                    arrPolygonPoints = [];
                }
                if (autoSave == 'True') {
                    AutoSaveDrawings()
                }
                break;
        }
        
    
        
      }
       clickNumber = 0;
    
}


function CanvasClicked() {
    //;
    //if (isEdit == 'Edit' && elemClicked)
    //{
    //    if (drawingsCateg == 'ANN') {
    //        var contextMenu = $find("ctl00_CPH1_PMWebViewerDrawing1_cmEdit");
    //    }
    //    else {
    //        var contextMenu = $find("ctl00_CPH1_PMWebViewerMeasurement1_cmEdit");
    //    }

    //    contextMenu.findItemByValue('EndEdit').click;
    //}
}

function HideTextBox(sender) {
 for (var i = 0; i < objToolBar.get_allItems().length; i++) {
        if (objToolBar.get_items().getItem(i).get_checked() == true) {
            objToolBar.get_items().getItem(i).click();
        }
    }
}


function SaveDrawings(sender) {
    var arrayAll = [];
    arrayAll.push(arrDrawings);
    arrayAll.push(arrMeasures);
    UpdateImageSize()
    PageMethods.SaveDrawings(arrayAll,
            function(response) {__doPostBack("mainToolBar", 'SaveAnnotation'); },
            function(msg) { alert(msg) },
            null);

    return false;
}


/***************************************************/



function HandleThicknessChanged(sender, eventArgs) {
    var circleWidth = sender.get_value();
    intThickness = sender.get_value();
    var imgTich = document.getElementById('imgThickness');
    var lblTich = document.getElementById('lblThickness');
    imgTich.width = circleWidth;
    imgTich.height = circleWidth;
    lblTich.innerHTML = circleWidth + ' px';
    UpdateDrawingOptions(currColor, intThickness)
}

var timeout;

function HandleZoomChanged(sender, eventArgs) {
    intZoomMultiplier = (sender.get_value()) / 100;
    if (drawingsCateg == 'ANN') {
        var txtZoomValue = document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i14_i0_txtZoomValue');
    }
    else {
        var txtZoomValue = document.getElementById('ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i16_i0_txtZoomValue');
    }
    txtZoomValue.value = sender.get_value();
    var hdnZoom;
    if (drawingsCateg == 'ANN') {
        hdnZoom = $("[id$=hdnZoom]");
    }
    else {
       hdnZoom = $("[id$=hdnZoomMsr]");
    }
    hdnZoom.val(sender.get_value());
    clearTimeout(timeout);
    doZoom();
    if (drawingsCateg == "ANN") {
        var toolbar = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar");
        if (toolbar) {
            toolbar.get_items().getItem(12).set_text(sender.get_value() + '%')
        }
    }
    else {
        var toolbar = $find("ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar");
        if (toolbar) {
            toolbar.get_items().getItem(5).set_text(sender.get_value() + '%')
        }
    }

}

var zoomingIn = false;



function doZoom() {

    var divZoomer = document.getElementById('divZoomer');
    var tdZoomer = document.getElementById('tdZoomer');

    var imgCanvas = document.getElementById(imgCanvasId);
    var initialWidth = imgCanvas.style.width.replace('px', '');
    var initialHeight = imgCanvas.style.height.replace('px', '');

    imgCanvas.style.width = (imgCanvasInitWidth * intZoomMultiplier) + 'px';
    imgCanvas.style.height = (imgCanvasInitHeight * intZoomMultiplier) + 'px';

    if (zoomingIn == true) {
        $('#divZoomer').scrollLeft($('#divZoomer').scrollLeft() + mouseX * 0.1);
        $('#divZoomer').scrollTop($('#divZoomer').scrollTop() + mouseY * 0.1);
    } else {
        $('#divZoomer').scrollLeft($('#divZoomer').scrollLeft() - mouseX * 0.1);
        $('#divZoomer').scrollTop($('#divZoomer').scrollTop() - mouseY * 0.1);
    }
    

    if (drawingsCateg == 'MSR') ReDrawMSR(); 
    if (drawingsCateg == 'ANN') ReDrawANN();

    tooltipelement = '';
}

function HandleColorChanged(sender, eventArgs) {
    currColor = sender.get_selectedColor();
    UpdateDrawingOptions(currColor, intThickness);
}


function RedliningOnClientButtonClicking(sender, args) {
    if (drawingsCateg == 'ANN') {
        var contextMenu = $find("ctl00_CPH1_PMWebViewerDrawing1_cmDrawing");
    }
    else {
        var contextMenu = $find("ctl00_CPH1_PMWebViewerMeasurement1_cmDrawing");
    }
    
    if (contextMenu)
    { contextMenu.hide() }
  
    var button = args.get_item();
    polyX = -1
    polyY = -1
switch (args.get_item().get_commandName()) {
    case 'line':
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
        cursorType = 'Draw'
        clickNumber = 0;
        tempType = 'line';
       break;

    case 'polyline':
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
        cursorType = 'Draw'
        if (drawingsCateg != 'MSR') {
            clickNumber = 0;
            tempType = 'polyline';
        } else {
            clickNumber = 0;
            tempType = 'polygon';            
        }
        break;

    case 'rectangle':
        clickNumber = 0;
        tempType = 'rectangle';
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
        cursorType = 'Draw'
        break;

    case 'ellipse':
        clickNumber = 0;
        tempType = 'ellipse';
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
        cursorType = 'Draw'
        break;

    case 'text':
        clickNumber = 0;
        var wnd = window.radopen('PMWebViewerTextPopup.aspx');
        wnd.setSize(550, 220);
        wnd.Center();
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
        cursorType = 'Draw'
        break;

    case 'bubble':
        clickNumber = 0;
        tempType = 'bubble';
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
        cursorType = 'Draw'
        break;

    case 'Save':
            args.set_cancel(true);

            if (arrVisible.length > 0) {
                 var hdnActionChecked = $("[id$=hdnActionChecked]");
                hdnActionChecked.val(arrVisible.join(','));
                arrVisible = [];
                __doPostBack('ctl00$CPH1$PMWebViewerDrawing1$rdgActions$ctl00$ctl02$ctl00$btnSave')
            }

            SaveDrawings(sender);

            break;
        case 'Delete':
            break;
        case 'Print':
            var left = (screen.width - 900) / 2;
            var top = (screen.height - 500) / 2;
            window.open('RedliningPrint.aspx?ZoomMultiplier=' + intZoomMultiplier + '&AllPages=' + printAllPages , '',
                            'location=no,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=800,height=600,top=' + top + ',left=' + left);
            args.set_cancel(true);
            break;

    case 'Undo':
        
            args.set_cancel(true);
            if (drawingsCateg == 'ANN') { 
                if (arrDrawings.length > 0) {
                    if (arrDrawings[arrDrawings.length - 1].ID == '' || arrDrawings[arrDrawings.length - 1].ID.startsWith('NOTE')) {
                        var poppedDrawing = arrDrawings.pop();
                        arrDeletedDrawings.push(poppedDrawing);
                        //EnableToolBarButton(redoIndex, true);
                        ReDrawANN();
                    }

                    if ((arrDrawings.length > 0) && (arrDrawings[arrDrawings.length - 1].ID == '')) {
                        //EnableToolBarButton(undoIndex, true);
                    } else {
                        //EnableToolBarButton(undoIndex, false);
                    }
                } else {
                   // EnableToolBarButton(undoIndex, false);
                }
            }
            if (drawingsCateg == 'MSR') {
                if (arrMeasures.length > 0) {
                    if (arrMeasures[arrMeasures.length - 1].ID == '') {
                        var poppedMeasure = arrMeasures.pop();
                        arrDeletedMeasures.push(poppedMeasure);
                        //EnableToolBarButton(redoIndex, true);
                        ReDrawMSR();
                    }
                    if ((arrMeasures.length > 0) && (arrMeasures[arrMeasures.length - 1].ID == '')) {
                        //EnableToolBarButton(undoIndex, true);
                    } else {
                        //EnableToolBarButton(undoIndex, false);
                    }
                } else {
                    //EnableToolBarButton(undoIndex, false);
                }
            }
            if (autoSave == 'True') {
                AutoSaveDrawings()
            }
            break;

    case 'Redo':
        args.set_cancel(true);
            //EnableToolBarButton(undoIndex, true);
            if (drawingsCateg == 'ANN') {
                if (arrDeletedDrawings.length > 0) {
                    var poppedDrawing = arrDeletedDrawings.pop();
                    arrDrawings.push(poppedDrawing);
                    ReDrawANN();
                }
                if (arrDeletedDrawings.length > 0) {
                    //EnableToolBarButton(redoIndex, true);
                } else {
                    //EnableToolBarButton(redoIndex, false);
                }
            }
            if (drawingsCateg == 'MSR') {
                if (arrDeletedMeasures.length > 0) {
                    var poppedMeasure = arrDeletedMeasures.pop();
                    arrMeasures.push(poppedMeasure);
                    ReDrawMSR();
                }
                if (arrDeletedMeasures.length > 0) {
                    //EnableToolBarButton(redoIndex, true); 
                } else {
                    //EnableToolBarButton(redoIndex, false);
                }
            }
         if (autoSave == 'True') {
            AutoSaveDrawings()
        }
            break;

    case 'LinkRecords':
            var Source = 'PMWebViewer';
            var wnd = window.radopen('GlobalLinkedRecords.aspx?Id=' + RecordId + '&ProjectId=' + ProjectId + '&Source=' + Source);
            wnd.setSize(300, 400);
            wnd.Center();
            $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') })
            cursorType = 'Draw' 
            break;

    case 'notes':
        var hdnNotes = $("[id$=hdnNotes]")[0];
        hdnNotes.value = '';
        var wnd = window.radopen('PMWebViewerNotePopup.aspx');
        wnd.setSize(400, 250);
        wnd.Center();
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') });
        cursorType = 'Draw';
        break;

    case 'stamps':
        tempType = 'stamp';
        $('#Canvas').hover(function () { $(this).css('cursor', 'pointer') });
        cursorType = 'Draw';
        var wnd = window.radopen('PMWebViewerStampsPopup.aspx');
        wnd.setSize(400, 400);
        wnd.Center();


        break;


        default:

            break;
    case 'Default':
        $('#Canvas').hover(function () { $(this).css('cursor', 'default') })
        cursorType = 'Default'
        tempType = '';
        break;
    case 'Move':
            $('#Canvas').hover(function () { $(this).css('cursor', 'move') })
        cursorType = 'Move'
        break;


    }
}

function UpdatePanelSettings(sender) {
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/UpdatePanelSettings",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ isPinned: sender.get_docked(), Width: sender.get_width() }),
        dataType: "json",
        async: true
    });
    if (!sender.get_docked())
    { sender.set_dockOnOpen(false) }
    else { sender.set_dockOnOpen(true) }
    return false;
}
function chkActionChange(sender) {

    var rdgActions = $("div[id$='rdgActions']");
    var chkPArent = rdgActions.find("input[type='checkbox']")[0];
    var i = 0;
        var isChecked = true;
        rdgActions.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (sender.checked) {
                    if (!this.disabled && !this.checked && this.id.indexOf("chkVisible") > 0) isChecked = false;
                }
            }
            i++;
        });


        if (!sender.checked) {
            chkPArent.checked = false;
        } else {
            chkPArent.checked = isChecked;

        }

    var elementId;
    var actionId = sender.parentElement.getAttribute("ActionId");
    if (actionId) {
        for (var i = 0; i < arrDrawings.length; i++) {
            elementId = arrDrawings[i].ID.replace("NOTE_", "");
            if (elementId == actionId) {
                arrDrawings[i].VISIBLE = sender.checked;
            }
        }

        var chkActionId = sender.checked ? actionId + '_false' : actionId + '_true';

        if (arrVisible.indexOf(chkActionId) == -1) {
            arrVisible.push(actionId + '_' + sender.checked);
        }
        else {
            arrVisible.splice(arrVisible.indexOf(chkActionId), 1);
            arrVisible.push(actionId + '_' + sender.checked);
        }
    }

}
function chkUserChange(sender) {
    var UserId = sender.getAttribute("UserId");
    for (var i = 0; i < arrDrawings.length; i++) {
        if (arrDrawings[i].USER == UserId) {
            arrDrawings[i].VISIBLE = sender.checked;
            if (sender.checked == false) {
                $('#DIVACTION_' + arrDrawings[i].ID)[0].style.display = 'none';
            } else {
                $('#DIVACTION_' + arrDrawings[i].ID)[0].style.display = '';
            }

        }
    }
    ReDrawANN();
}



function SpaceClicked(sender, eventArgs) {
    var item = eventArgs.get_item();
    spaceId = item.get_value();
    tempStamp = item.get_attributes('Code')._data.Code;
    clickNumber = 0;
    tempType = 'space';
   }

function EquipmentClicked(sender, eventArgs) {
    var item = eventArgs.get_item();
    equipmentId = item.get_value();
    tempStamp = item.get_attributes('Code')._data.Code;
    clickNumber = 0;
    tempType = 'equipment';
    }



function LinkedRecordClicked(LRId, LRCode,LRType,LRTypeId,LRNumber) {
    LinkedRecordId = LRId;
    LinkedRecordType = LRType;
    LinkedRecordTypeId = LRTypeId;
    LinkedRecordNumber = LRNumber;
    tempStamp = LRCode;
    clickNumber = 0;

    if (LRTypeId == 17) {
        spaceId = LRId;
        tempType = 'space';
        }
    else if (LRTypeId == 38) {
        equipmentId = LRId;
        tempType = 'equipment';
    }
    else {
        tempType = 'LinkedRecord';
    }
  
}

function AddLinkedRecordFromMenu(LRId, LRCode, LRType, LRTypeId, LRNumber)
{
    LinkedRecordId = LRId;
    LinkedRecordType = LRType;
    LinkedRecordTypeId = LRTypeId;
    LinkedRecordNumber = LRNumber;
    tempStamp = LRCode;
    clickNumber = 0;

    if (LRTypeId == 17) {
        spaceId = LRId;
        tempType = 'space';
       }
    else if (LRTypeId == 38) {
        equipmentId = LRId;
        tempType = 'equipment';
           }
    else {
        tempType = 'LinkedRecord';
        }

    if(tempType == 'LinkedRecord')
    {
       strRnd = '';
        //EnableToolBarButton(undoIndex, true);
        arrDrawings.push({ 'TYPE': 'LinkedRecord', 'ID': '', 'VALUE': tempStamp, 'X': menuX / intZoomMultiplier, 'Y': menuY / intZoomMultiplier, 'RECORDTYPEID': LinkedRecordTypeId, 'RECORDNUMBER': LinkedRecordNumber, 'RECORDID': LinkedRecordId, 'RECORDTYPE': LinkedRecordType, 'DRAWINGCOUNT': LinkNumber, 'RANDOM': '', 'COLOR': currColor, 'STROKE': intThickness, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'linkedrecord' + '_' + LinkedRecordType + '_' + LinkedRecordId });

        var ellipse = paper.ellipse(menuX, menuY, 10 * intZoomMultiplier, 10 * intZoomMultiplier);
        ellipse.id = 'linkedrecord_' + LinkedRecordType + '_' + LinkedRecordId;
        ellipse.attr({
            fill: currColor
        });
        var text = paper.text(menuX, menuY, LinkNumber).attr(
        {
            "text-anchor": "middle",
            stroke: 'none',
            "stroke-width": intThickness,
            font: '12px "verdana,geneva,helvetica,sans-serif"',
            "font-family": "verdana,geneva,helvetica,sans-serif"

        })
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
    }
    else if (tempType == 'space')
    {
        //EnableToolBarButton(undoIndex, true);
        arrDrawings.push({ 'TYPE': 'SPACE', 'ID': '', 'VALUE': tempStamp, 'X': menuX / intZoomMultiplier, 'Y': menuY / intZoomMultiplier, 'SPACEID': spaceId, 'RANDOM': '', 'COLOR': currColor, 'STROKE': intThickness, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'SPACE_' + spaceId + '_' + strRnd });
        var img = paper.image("Images/Redlining/smallSpaceOffice2007.png", menuX, menuY, 16, 16)
        img.id = 'SPACE_' + spaceId + '_' + strRnd;

        img.click(OpenSpaceToolTip)

        var text = paper.text(menuX + 18, menuY + 7, tempStamp).attr(
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
        text.id = 'SPACE_' + spaceId + '_' + strRnd;
        underline.id = 'SPACE_' + spaceId + '_' + strRnd;
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
    }
    else if (tempType == 'equipment') {
        //EnableToolBarButton(undoIndex, true);
        arrDrawings.push({ 'TYPE': 'EQUIPMENT', 'ID': '', 'VALUE': tempStamp, 'X': menuX / intZoomMultiplier, 'Y': menuY / intZoomMultiplier, 'EQUIPMENTID': equipmentId, 'COLOR': currColor, 'STROKE': intThickness, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'EQU_' + countId });

        var img = paper.image("Images/Redlining/smallEquipmentOffice2007.png", menuX, menuY, 16, 16)
        img.id = 'EQU_' + countId;
        var text = paper.text(menuX + 18, menuY + 7, tempStamp).attr(
             {
                 "text-anchor": "start",
                 stroke: 'none',
                 fill: currColor,
                 font: '12px "verdana,geneva,helvetica,sans-serif"',
                 "font-family": "verdana,geneva,helvetica,sans-serif"

             })
        text.mousedown(function (e) {
            if (e.button == 2) {

                var upX = e.clientX + $(window).scrollLeft() - 5;
                var upY = e.clientY + $(window).scrollTop() - 5;
                OpenMenu(this, upX, upY);
            }
        });
       text.id = 'EQU_' + countId;
        var underline = underlineText(paper, text)
        underline.id = 'EQU_' + countId;
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
    }
    if (autoSave == 'True') {
        AutoSaveDrawings()
    }
}
function NoteClicked(NoteId, NoteTitle, NoteDesc, NoteFont) {

    if (NoteId == "") {
        clickNumber = 0;
        tempType = 'NOTE';
        NoteValue = NoteTitle + '~!@' + NoteDesc;
        NFont = NoteFont;
    }
    else {

            for (var i = 0; i < arrDrawings.length; i++) {
                if (arrDrawings[i].ID == NoteId) {

                    arrDrawings[i].VALUE = NoteTitle + '~!@' + NoteDesc;
                    arrDrawings[i].FONT = NoteFont;
                
            }
            }
            ReDrawANN();
    }
    tooltipelement = '';
    if (autoSave == 'True') {
        AutoSaveDrawings()
    }
}

function AddNoteFromMenu(NoteId, NoteTitle, NoteDesc, NoteFont)
{
    tooltipelement = '';
    clickNumber = 0;
    tempType = 'NOTE';
    NoteValue = NoteTitle + '~!@' + NoteDesc;
    NFont = NoteFont;
    
    var str = NoteValue.split("~!@");
    var font = NFont.split(';');

    arrDrawings.push({ 'TYPE': 'NOTE', 'ID': 'NOTE_' + str[0] + '_' + NoteNumber, 'VALUE': NoteValue, 'X': menuX / intZoomMultiplier, 'Y': menuY / intZoomMultiplier, 'FONT': NFont, 'ISNEW': 'true', 'RANDOM': '', 'COLOR': currColor, 'STROKE': intThickness, 'DRAWINGCOUNT': NoteNumber, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TRANSFORM': '', 'TransformID': 'NOTE_' + str[0] + '_' + NoteNumber + '~!@' + NoteValue + '~!@' + font.join("~!@") });

    var NoteRect = paper.rect(menuX - 10 * intZoomMultiplier, menuY - 10 * intZoomMultiplier, 20 * intZoomMultiplier, 20 * intZoomMultiplier).attr(
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
        }});

    NoteRect.dblclick(function () {
        clearTimeout(timer);
        var hdnNotes = $("[id$=hdnNotes]")[0];
        hdnNotes.value = this.id;
        var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Edit');
        wnd.setSize(400, 250);
        wnd.Center();
        Click = 0;
       
    
    });



    var text = paper.text(menuX, menuY, NoteNumber).attr(
                                {
                                    "text-anchor": "middle",
                                    stroke: 'none',
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
    //EnableToolBarButton(undoIndex, true);
    tempType = '';
    NoteNumber = parseInt(NoteNumber) + 1;
    if (autoSave == 'True') {
        AutoSaveDrawings()
    }
}
function AddTextFromPopup(B,I,FS,txt) {
    if (B)
    { fontWeight = "Bold"; }
    else { fontWeight = "Normal"; }
    if (I)
    {fontStyle = "Italic" }
    else
    { fontStyle = "Normal" }
    fontSize = FS;
    textFromPopup = txt;
    tempType = 'text'
}

function SpaceClicked(sender, eventArgs) {
    
    var item = eventArgs.get_item();
    spaceId = item.get_value();
    tempStamp = item.get_attributes('Code')._data.Code;
    clickNumber = 0;
    tempType = 'space';
    
}

function EquipmentClicked(sender, eventArgs) {
    
    var item = eventArgs.get_item();
    equipmentId = item.get_value();
    tempStamp = item.get_attributes('Code')._data.Code;
    clickNumber = 0;
    tempType = 'equipment';
    
}

function CloseWindow(SpaceId) {
    document.location.href = 'Spaces.aspx?Id=' + SpaceId + '&ModuleId=5&PageId=42';
}

function InitiateSizes() {
    intZoomMultiplier = 1;
    var imgCanvas = document.getElementById(imgCanvasId);
   imgCanvasInitWidth = parseInt(imgCanvas.style.width);
   imgCanvasInitHeight = parseInt(imgCanvas.style.height);

   imgCanvasInitWidth = imgCanvasInitWidth || 0;
   imgCanvasInitHeight = imgCanvasInitHeight || 0;


    var divZoomer = document.getElementById('divZoomer');
    divZoomerInitWidth = parseInt(divZoomer.style.width);
    divZoomerInitHeight = parseInt(divZoomer.style.height);

}


function PolygonAreaCalculation(arrPoints) {
    var area = 0;
    var nPts = arrPoints.length;
    var j = nPts - 1;
    var p1; var p2;

    for (var i = 0; i < nPts; j = i++) {
        p1 = arrPoints[i]; p2 = arrPoints[j];
        area += (p1.X * scaleMultiplier) * (p2.Y * scaleMultiplier);
        area -= (p1.Y * scaleMultiplier) * (p2.X * scaleMultiplier);
    }
    area /= 2;
    return Math.abs(area);
}

function EllipseAreaCalculation(width, height) {
    var area = (((Math.PI) * (width * scaleMultiplier) * (height * scaleMultiplier)) / 4);
    return Math.abs(area);
}

function LengthCalculation(x1,y1,x2,y2) {
    var length = Math.sqrt(square(((x2 * scaleMultiplier) - (x1 * scaleMultiplier))) + square(((y2 * scaleMultiplier) - (y1 * scaleMultiplier))));
    return Math.abs(length);
}

function square(num) {
    return num * num;
}

function roundNumber2(rnum, rlength) { // Arguments: number to round, number of decimal places
    var newnumber = Math.round(rnum * Math.pow(10, rlength)) / Math.pow(10, rlength);
    return parseFloat(newnumber); // Output the result to the form field (change for your purposes)
}

function addText(x,y)
{
    //EnableToolBarButton(undoIndex, true);
    arrDrawings.push({ 'TYPE': 'TEXT', 'ID': '', 'TRANSFORM': '', 'VALUE': '', 'X': x / intZoomMultiplier, 'Y': y / intZoomMultiplier,'FONT':'', 'COLOR': currColor, 'STROKE': intThickness, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'text' + countId });
    var text = paper.text(x, y + 7, '').attr({
        stroke: 'none',
        fill: currColor,
        "stroke-width": intThickness,
        font: '12px "verdana,geneva,helvetica,sans-serif"',
        "font-family": "verdana,geneva,helvetica,sans-serif",
        "font-weight": "normal",
        "text-anchor": "start"

    });
    text.id = 'text' + countId;
    elemClicked = 'text' + countId;
    text.mousedown(function (e) {
        if (e.button == 2) {
            var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
    });
    editText(text);

    text.dblclick(function () { ObjectDblClicked(this); });

}

function cmDrawingClicked(sender, e)
{
    switch (e.get_item().get_value())
    {
        case 'AddText':
            
            var upX = mouseX;
            var upY = mouseY;
            addText(upX, upY);
            break;

        case 'AddNote':
            var hdnNotes = $("[id$=hdnNotes]")[0];
            hdnNotes.value = '';
            var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Menu');
            wnd.setSize(400, 250);
            wnd.Center();
            break;
        case 'AddLinkedRecord':
            var wnd = window.radopen('GlobalLinkedRecords.aspx?Id=' + RecordId + '&ProjectId=' + ProjectId + '&Source=PMWebViewer' + '&From=Menu');
            wnd.setSize(300, 400);
            wnd.Center();
            break;
        case 'AddImgStamp':
            var wnd = window.radopen('PMWebViewerStampsPopup.aspx?Source=Menu');
            wnd.setSize(400, 400);
            wnd.Center();
            break;

    }

}

function AddStampFromMenu() {
    var hdnStamp = $("input[id$=hdnStamp]").val();
    var stamps = hdnStamp.split(";");
    var type = stamps[0];

    var height = stamps[1];
    var width = stamps[2];
    var value = stamps[3];
    var strval = value + ';' + width + ';' + height;
    arrDrawings.push({ 'TYPE': 'IMAGESTAMP', 'ID': '', 'TRANSFORM': '', 'VALUE': strval, 'X': menuX / intZoomMultiplier, 'Y': menuY / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'imgstamp' + countId });
    //EnableToolBarButton(undoIndex, true);
    var img = paper.image(value, menuX, menuY, width, height)
    img.mousedown(function (e) {
        if (e.button == 2) {

            var upX = e.clientX + $(window).scrollLeft() - 5;
            var upY = e.clientY + $(window).scrollTop() - 5;
            OpenMenu(this, upX, upY);
        }
    });
    img.id = 'imgstamp' + countId;

    img.dblclick(function () { ObjectDblClicked(this); });
    if (autoSave == 'True') {
        AutoSaveDrawings()
    }
    tempType = '';
}
function stampMenuItemClicked(value) {
        //EnableToolBarButton(undoIndex, true);
        arrDrawings.push({ 'TYPE': 'STAMP', 'ID': '', 'TRANSFORM': '', 'VALUE': value, 'X': menuX / intZoomMultiplier, 'Y': menuY / intZoomMultiplier, 'COLOR': currColor, 'STROKE': intThickness, 'USER': '', 'DATE': '', 'VISIBLE': true, 'TransformID': 'stamp' + countId });
        var text = paper.text(menuX, menuY, value).attr(
                      {
                          font: '14px "Segoe UI,Arial,Helvetica,sans-serif"',
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
        tempType = '';
    
    
}


function ObjectDblClicked(me) {
    if (CanEdit == 'True') {
        if (isEdit == '') {

            elemClicked = me.id;
            if (ft != null) {
                ft.unplug();
                ft = null;
            }
            if (drawingsCateg == 'ANN') {
                if (!elemClicked.startsWith('stamp') && !elemClicked.startsWith('NOTE') && !elemClicked.startsWith('linkedrecord') && !elemClicked.startsWith('EQU') && !elemClicked.startsWith('SPACE') && !elemClicked.startsWith('BUBBLE')) {
                    var elem = paper.getById(elemClicked);
                }
                else {
                    var elem;
                    for (var i = 0; i < arrSets.length; i++) {
                        if (arrSets[i].ID == elemClicked) {
                            elem = arrSets[i]
                        }
                    }
                }
            }
            else {
                var elem;
                for (var i = 0; i < arrSets.length; i++) {
                    if (arrSets[i].ID == elemClicked) {
                        elem = arrSets[i]
                    }
                }
            }
            if (elem) {
                isEdit = 'Edit';
                ft = paper.freeTransform(elem, {}, null);
            }
        }

        else {
            isEdit = ''

            var angle;
            var SkewTrasnsform = '';

            if (ft != null) {

                var elem = paper.getById(elemClicked);

                var newX = elem.matrix.x(elem.attrs.x, elem.attrs.y)
                var newY = elem.matrix.y(elem.attrs.x, elem.attrs.y)
                var MT = 0;

                ft.unplug();
                ft = null;
                var strTrans = elem.transform().toString()
                if (strTrans != '' && strTrans.indexOf('m') > 0) {

                    var arr2 = strTrans.split('R')
                    var arr = arr2[1].split(',');


                    arr[1] = parseFloat(arr[1]) / intZoomMultiplier;
                    var arrR = arr[2].split('S');
                    arr[2] = parseFloat(arrR[0]) / intZoomMultiplier + 'S' + arrR[1];
                    var a = strTrans.split('R')
                    strTrans = a[0] + 'R' + arr.join(',');


                    arr2 = strTrans.split('S')
                    arr = arr2[1].split(',');
                    arr[2] = parseFloat(arr[2]) / intZoomMultiplier;

                    var arrT = arr[3].split('T');
                    arr[3] = parseFloat(arrT[0]) / intZoomMultiplier + 'T' + arrT[1];
                    a = strTrans.split('S')
                    strTrans = a[0] + 'S' + arr.join(',');



                    arr2 = strTrans.split('T')
                    arr = arr2[1].split(',');
                    arr[0] = parseFloat(arr[0]) / intZoomMultiplier;
                    if (isNumeric(arr[1])) {
                        arr[1] = parseFloat(arr[1]) / intZoomMultiplier;
                        a = strTrans.split('T')
                        strTrans = a[0] + 'T' + arr[0] + ',' + arr[1];
                    }
                    else {
                        MT = 1;
                        if (arr[1].indexOf('m') > 0) {
                            var arrm = arr[1].split('m');
                            arrm[0] = parseFloat(arrm[0]) / intZoomMultiplier;


                            SkewTrasnsform = elem.matrix.toTransformString();
                            var arrSkew = elem.matrix.toTransformString().split(',');
                            arrSkew[4] = parseFloat(arrSkew[4]) / intZoomMultiplier;
                            arrSkew[5] = parseFloat(arrSkew[5]) / intZoomMultiplier;
                            SkewTrasnsform = arrSkew.join(',');
                            a = strTrans.split('T');
                            strTrans = a[0] + 'T' + arr[0] + ',' + arrm[0];


                        }
                        else if (arr[1].indexOf('t') > 0) {
                            var arrt = arr[1].split('t');
                            arrt[0] = parseFloat(arrt[0]) / intZoomMultiplier;

                            a = strTrans.split('T');
                            strTrans = a[0] + 'T' + arr[0] + ',' + arrt[0];
                        }
                    }
                }
                else {
                    if (strTrans.indexOf('m') == 0) {
                        var arrSkew = elem.matrix.toTransformString().split(',');
                        arrSkew[4] = parseFloat(arrSkew[4]) / intZoomMultiplier;
                        arrSkew[5] = parseFloat(arrSkew[5]) / intZoomMultiplier;
                        strTrans = arrSkew.join(',');
                        MT = 2;
                    }

                }

                if (drawingsCateg == "ANN") {

                    for (var i = 0; i < arrDrawings.length; i++) {
                        if (arrDrawings[i].TransformID == elemClicked) {
                            if (arrDrawings[i].TRANSFORM == '' || MT == 0) {
                                arrDrawings[i].TRANSFORM = strTrans;
                            }
                            else
                                if (MT == 2) {
                                    arrDrawings[i].TRANSFORM = arrDrawings[i].TRANSFORM + strTrans;
                                }
                                else {
                                    var ar2 = arrDrawings[i].TRANSFORM.split('R')

                                    var ar = ar2[1].split(',');
                                    var arR = ar[2].split('S');


                                    var arr2 = strTrans.split('R')
                                    var arr = arr2[1].split(',');


                                    arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);


                                    arr[1] = parseFloat(ar[1]);//+ parseFloat(ar[1]);
                                    var arrR = arr[2].split('S');

                                    arr[2] = arR[0] + 'S' + arrR[1];//String(parseFloat(arrR[0]) + parseFloat(arR[0])) + 'S' + arrR[1];
                                    var a = strTrans.split('R')
                                    strTrans = a[0] + 'R' + arr.join(',');


                                    ar2 = arrDrawings[i].TRANSFORM.split('S')
                                    ar = ar2[1].split(',');

                                    var arT = ar[3].split('T');


                                    arr2 = strTrans.split('S')
                                    arr = arr2[1].split(',');
                                    arr[0] = parseFloat(arr[0]) * parseFloat(ar[0]);
                                    arr[1] = parseFloat(arr[1]) * parseFloat(ar[1]);
                                    arr[2] = parseFloat(ar[2]);//+ parseFloat(ar[2]);

                                    var arrT = arr[3].split('T');
                                    arr[3] = arT[0] + 'T' + arrT[1];//String(parseFloat(arrT[0]) + parseFloat(arT[0])) +'T' +arrT[1];
                                    a = strTrans.split('S')
                                    strTrans = a[0] + 'S' + arr.join(',');




                                    ar2 = arrDrawings[i].TRANSFORM.split('T')
                                    ar = ar2[1].split(',');


                                    arr2 = strTrans.split('T')
                                    arr = arr2[1].split(',');
                                    arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);

                                    arr[1] = parseFloat(arr[1]) + parseFloat(ar[1]);
                                    a = strTrans.split('T')
                                    strTrans = a[0] + 'T' + arr[0] + ',' + arr[1];




                                    arrDrawings[i].TRANSFORM = strTrans + SkewTrasnsform;

                                }
                        }
                    }
                }
                else {
                    for (var i = 0; i < arrMeasures.length; i++) {
                        if (arrMeasures[i].TransformID == elemClicked) {
                            if (arrMeasures[i].TRANSFORM == '' || MT == 0) {
                                arrMeasures[i].TRANSFORM = strTrans;
                            }
                            else {


                                var ar2 = arrMeasures[i].TRANSFORM.split('R')

                                var ar = ar2[1].split(',');
                                var arR = ar[2].split('S');


                                var arr2 = strTrans.split('R')
                                var arr = arr2[1].split(',');


                                arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);


                                arr[1] = parseFloat(ar[1]);//+ parseFloat(ar[1]);
                                var arrR = arr[2].split('S');

                                arr[2] = arR[0] + 'S' + arrR[1];//String(parseFloat(arrR[0]) + parseFloat(arR[0])) + 'S' + arrR[1];
                                var a = strTrans.split('R')
                                strTrans = a[0] + 'R' + arr.join(',');


                                ar2 = arrMeasures[i].TRANSFORM.split('S')
                                ar = ar2[1].split(',');

                                var arT = ar[3].split('T');


                                arr2 = strTrans.split('S')
                                arr = arr2[1].split(',');
                                arr[0] = parseFloat(arr[0]) * parseFloat(ar[0]);
                                arr[1] = parseFloat(arr[1]) * parseFloat(ar[1]);
                                arr[2] = parseFloat(ar[2]);//+ parseFloat(ar[2]);

                                var arrT = arr[3].split('T');
                                arr[3] = arT[0] + 'T' + arrT[1];//String(parseFloat(arrT[0]) + parseFloat(arT[0])) +'T' +arrT[1];
                                a = strTrans.split('S')
                                strTrans = a[0] + 'S' + arr.join(',');




                                ar2 = arrMeasures[i].TRANSFORM.split('T')
                                ar = ar2[1].split(',');


                                arr2 = strTrans.split('T')
                                arr = arr2[1].split(',');
                                arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);

                                arr[1] = parseFloat(arr[1]) + parseFloat(ar[1]);
                                a = strTrans.split('T')
                                strTrans = a[0] + 'T' + arr[0] + ',' + arr[1];




                                arrMeasures[i].TRANSFORM = strTrans + SkewTrasnsform;

                            }

                        }
                    }

                }
            }


            if (elemClicked != me.id) {
                ObjectDblClicked(me);
            }

            if (autoSave == 'True') {
                AutoSaveDrawings()
            }
        }
    }
}

function menuItemClicked(sender, e) {
    switch (e.get_item().get_value())
    {
        case 'Edit':
            isEdit = 'Edit'
            if (ft != null) {
                ft.unplug();
                ft = null;
            }
            if (drawingsCateg == 'ANN') {
                if (!elemClicked.startsWith('stamp') && !elemClicked.startsWith('NOTE') && !elemClicked.startsWith('linkedrecord') && !elemClicked.startsWith('EQU') && !elemClicked.startsWith('SPACE') && !elemClicked.startsWith('BUBBLE')) {
                    var elem = paper.getById(elemClicked);
                }
                else {
                    var elem;
                    for (var i = 0; i < arrSets.length; i++) {
                        if (arrSets[i].ID == elemClicked) {
                            elem = arrSets[i]
                        }
                    }
                }
            }
            else {
                var elem;
                for (var i = 0; i < arrSets.length; i++) {
                    if (arrSets[i].ID == elemClicked) {
                        elem = arrSets[i]
                    }
                }
            }
            ft = paper.freeTransform(elem, {}, null);
            break
        case 'EditText':
            var elem;
            if (drawingsCateg == 'ANN') {
                elem = paper.getById(elemClicked);
            }
            else {
                var set;
                for (var i = 0; i < arrSets.length; i++) {
                    if (arrSets[i].ID == elemClicked) {
                        set = arrSets[i]
                    }
                }
                var elem = set[1];
            }
            editText(elem);
            break
        case 'EditNote':
            var hdnNotes = $("[id$=hdnNotes]")[0];
            hdnNotes.value = paper.getById(elemClicked).id;
            var wnd = window.radopen('PMWebViewerNotePopup.aspx?Source=Edit');
            wnd.setSize(400, 250);
            wnd.Center();
            break;
        case 'EndEdit':
            isEdit = ''
            if (ft != null) {
               
                var elem = paper.getById(elemClicked);
              
            var newX = elem.matrix.x(elem.attrs.x, elem.attrs.y)
            var newY = elem.matrix.y(elem.attrs.x, elem.attrs.y)
            var MT = 0;
            var SkewTrasnsform = '';
                ft.unplug();
                ft = null;
                var strTrans = elem.transform().toString()
                if (strTrans != '') {

                    var arr2 = strTrans.split('R')
                    var arr = arr2[1].split(',');


                    arr[1] = parseFloat(arr[1]) / intZoomMultiplier;
                    var arrR = arr[2].split('S');
                    arr[2] = parseFloat(arrR[0]) / intZoomMultiplier + 'S' + arrR[1];
                    var a = strTrans.split('R')
                    strTrans = a[0] + 'R' + arr.join(',');


                    arr2 = strTrans.split('S')
                    arr = arr2[1].split(',');
                    arr[2] = parseFloat(arr[2]) / intZoomMultiplier;

                    var arrT = arr[3].split('T');
                    arr[3] = parseFloat(arrT[0]) / intZoomMultiplier + 'T' + arrT[1];
                    a = strTrans.split('S')
                    strTrans = a[0] + 'S' + arr.join(',');



                    arr2 = strTrans.split('T')
                    arr = arr2[1].split(',');
                    arr[0] = parseFloat(arr[0]) / intZoomMultiplier;
                    if (isNumeric(arr[1])) {
                        arr[1] = parseFloat(arr[1]) / intZoomMultiplier;
                        a = strTrans.split('T')
                        strTrans = a[0] + 'T' + arr[0] + ',' + arr[1];
                    }
                    else {
                        MT = 1;
                        if (arr[1].indexOf('m') > 0) {
                            var arrm = arr[1].split('m');
                            arrm[0] = parseFloat(arrm[0]) / intZoomMultiplier;


                            SkewTrasnsform = elem.matrix.toTransformString();
                            var arrSkew = elem.matrix.toTransformString().split(',');
                            arrSkew[4] = parseFloat(arrSkew[4]) / intZoomMultiplier;
                            arrSkew[5] = parseFloat(arrSkew[5]) / intZoomMultiplier;
                            SkewTrasnsform = arrSkew.join(',');

                            a = strTrans.split('T');
                            strTrans = a[0] + 'T' + arr[0] + ',' + arrm[0];


                        }
                        else if (arr[1].indexOf('t') > 0) {
                            var arrt = arr[1].split('t');
                            arrt[0] = parseFloat(arrt[0]) / intZoomMultiplier;

                            a = strTrans.split('T');
                            strTrans = a[0] + 'T' + arr[0] + ',' + arrt[0];
                        }
                    }
                }

                if (drawingsCateg == "ANN") {

                    for (var i = 0; i < arrDrawings.length; i++) {
                        if (arrDrawings[i].TransformID == elemClicked) {
                            if (arrDrawings[i].TRANSFORM == '' || MT == 0) {
                                arrDrawings[i].TRANSFORM = strTrans;
                            }
                            else {


                                var ar2 = arrDrawings[i].TRANSFORM.split('R')

                                var ar = ar2[1].split(',');
                                var arR = ar[2].split('S');


                                var arr2 = strTrans.split('R')
                                var arr = arr2[1].split(',');


                                arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);


                                arr[1] = parseFloat(ar[1]);//+ parseFloat(ar[1]);
                                var arrR = arr[2].split('S');

                                arr[2] = arR[0] + 'S' + arrR[1];//String(parseFloat(arrR[0]) + parseFloat(arR[0])) + 'S' + arrR[1];
                                var a = strTrans.split('R')
                                strTrans = a[0] + 'R' + arr.join(',');


                                ar2 = arrDrawings[i].TRANSFORM.split('S')
                                ar = ar2[1].split(',');

                                var arT = ar[3].split('T');


                                arr2 = strTrans.split('S')
                                arr = arr2[1].split(',');
                                arr[0] = parseFloat(arr[0]) * parseFloat(ar[0]);
                                arr[1] = parseFloat(arr[1]) * parseFloat(ar[1]);
                                arr[2] = parseFloat(ar[2]);//+ parseFloat(ar[2]);

                                var arrT = arr[3].split('T');
                                arr[3] = arT[0] + 'T' + arrT[1];//String(parseFloat(arrT[0]) + parseFloat(arT[0])) +'T' +arrT[1];
                                a = strTrans.split('S')
                                strTrans = a[0] + 'S' + arr.join(',');




                                ar2 = arrDrawings[i].TRANSFORM.split('T')
                                ar = ar2[1].split(',');


                                arr2 = strTrans.split('T')
                                arr = arr2[1].split(',');
                                arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);

                                arr[1] = parseFloat(arr[1]) + parseFloat(ar[1]);
                                a = strTrans.split('T')
                                strTrans = a[0] + 'T' + arr[0] + ',' + arr[1];




                                arrDrawings[i].TRANSFORM = strTrans + SkewTrasnsform;

                            }
                        }
                    }
                }
                else {
                    for (var i = 0; i < arrMeasures.length; i++) {
                        if (arrMeasures[i].TransformID == elemClicked) {
                            if (arrMeasures[i].TRANSFORM == '' || MT == 0) {
                                arrMeasures[i].TRANSFORM = strTrans;
                            }
                            else {


                                var ar2 = arrMeasures[i].TRANSFORM.split('R')

                                var ar = ar2[1].split(',');
                                var arR = ar[2].split('S');


                                var arr2 = strTrans.split('R')
                                var arr = arr2[1].split(',');


                                arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);


                                arr[1] = parseFloat(ar[1]);//+ parseFloat(ar[1]);
                                var arrR = arr[2].split('S');

                                arr[2] = arR[0] + 'S' + arrR[1];//String(parseFloat(arrR[0]) + parseFloat(arR[0])) + 'S' + arrR[1];
                                var a = strTrans.split('R')
                                strTrans = a[0] + 'R' + arr.join(',');


                                ar2 = arrMeasures[i].TRANSFORM.split('S')
                                ar = ar2[1].split(',');

                                var arT = ar[3].split('T');


                                arr2 = strTrans.split('S')
                                arr = arr2[1].split(',');
                                arr[0] = parseFloat(arr[0]) * parseFloat(ar[0]);
                                arr[1] = parseFloat(arr[1]) * parseFloat(ar[1]);
                                arr[2] = parseFloat(ar[2]);//+ parseFloat(ar[2]);

                                var arrT = arr[3].split('T');
                                arr[3] = arT[0] + 'T' + arrT[1];//String(parseFloat(arrT[0]) + parseFloat(arT[0])) +'T' +arrT[1];
                                a = strTrans.split('S')
                                strTrans = a[0] + 'S' + arr.join(',');




                                ar2 = arrMeasures[i].TRANSFORM.split('T')
                                ar = ar2[1].split(',');


                                arr2 = strTrans.split('T')
                                arr = arr2[1].split(',');
                                arr[0] = parseFloat(arr[0]) + parseFloat(ar[0]);

                                arr[1] = parseFloat(arr[1]) + parseFloat(ar[1]);
                                a = strTrans.split('T')
                                strTrans = a[0] + 'T' + arr[0] + ',' + arr[1];




                                arrMeasures[i].TRANSFORM = strTrans + SkewTrasnsform;

                            }

                        }
                    }

                }
                if (autoSave == 'True') {
                    AutoSaveDrawings()
                }
            }
            break;
        case 'Delete':
            if (drawingsCateg == "ANN") {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (arrDrawings[i].TransformID == elemClicked) {
                        if (arrDrawings[i].ID != '') {
                            __doPostBack("DeleteAction", arrDrawings[i].ID);
                        }
                        else {
                            
                            var poppedDrawing = arrDrawings[i];
                            arrDrawings.splice(i, 1);
                            ReDrawANN();
                            
                        }
                    }
                }
                
            }
            if (drawingsCateg == "MSR") {
                for (var i = 0; i < arrMeasures.length; i++) {
                    if (arrMeasures[i].TransformID == elemClicked) {
                        if (arrMeasures[i].ID != '') {
                            __doPostBack("DeleteMeasure", arrMeasures[i].ID);
                        }
                        else {
                            
                            var poppedDrawing = arrMeasures[i];
                            arrMeasures.splice(i, 1);
                            ReDrawMSR();
                        }
                    }
                }
            }
            

            break; 
    }

}

function OnMenuShowing()
{
    menuX = mouseX
    menuY = mouseY
    if (cursorType == 'Move') {
        cursorType = 'Default';
        $('#Canvas').hover(function () { $(this).css('cursor', 'default') })
    }

}

function resetZoom()
{
    var sldrZoom;

    if (drawingsCateg == 'ANN')
    { sldrZoom = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i12_i0_sldrZoom"); }
    else 
    { sldrZoom = $find('ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i12_i0_sldrZoom'); }
    sldrZoom.set_value(100);
}

function handleZoomChangeFromTxt(sender) {
    var sldrZoom;

    if (drawingsCateg == 'ANN')
    { sldrZoom = $find("ctl00_CPH1_PMWebViewerDrawing1_mainToolBar_i12_i0_sldrZoom"); }
    else
    { sldrZoom = $find('ctl00_CPH1_PMWebViewerMeasurement1_mainToolBar_i12_i0_sldrZoom'); }
    if (sender.value > 800)
        sldrZoom.set_value(800);
    else
    sldrZoom.set_value(sender.value);
    
}