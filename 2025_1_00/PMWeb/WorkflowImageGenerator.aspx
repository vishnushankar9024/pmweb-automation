<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowImageGenerator.aspx.vb" Inherits="Website.WorkflowImageGenerator1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <style type="text/css">
            body {
                text-transform: uppercase !important;
                background-color: #FFFFFF;
            }

            svg {
                height: 160px !important;
            }

            a.smallUp .Icon {
                background-image: url('CSS/Images/ResponsiveIcons/24x24 Enabled.png') !important;
                background-position: -2976px 0px !important;
                width: 24px !important;
                height: 24px !important;
                display: inline-block;
            }

            a.smallUpAll .Icon {
                background-image: url('CSS/Images/ResponsiveIcons/24x24 Enabled.png') !important;
                background-position: -2952px 0px !important;
                width: 24px !important;
                height: 24px !important;
                display: inline-block;
            }
        </style>
        <script src="JS/jquery.min.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
        <script src="JS/raphael-min.js" type="text/javascript"></script>
        <script src="JS/TelerikUtilities.js" type="text/javascript"></script>
        <script type="text/javascript">
            var lbl_Submitter = 'Submitter11';
            var lbl_Withdrawal = 'Withdrawal11';
            var lbl_FinalApprove = 'Final Approve11';
            var lbl_Rejection = 'Rejection11';
            var lbl_Multiple = '- Multiple -';
            var currParentId = 0;

            var bxW = 120; var bxH = 40; var connL = 20; var returnConnL = 15; var returnConnLTmp = 15; var startNX = 0; var startNY = 0; var intAnim = 500; var isMouseOverPaper; var hoverTime = new Date();
            var RedF = '#FF6464'; var RedS = '#F05342'; var GreenF = '#009D00'; var GreenS = '#246C50'; var BlueF = '#2F92FF'; var GrayL = '#e9e9e9';
            var OrangeS = '#FF6600'; var OrangeF = '#FF6464'; var GrayD = '#666666'; var BlackS = '#000'; var BrownS = '#D0A375'; var GrayS = "#999999";
            var fFamily = 'arial'; var BranchCurve = 17;
            var startX = 5; var initialStartY = 30; var startY = initialStartY;
            var paper; var arrSteps = []; var RectFinalApprove; var RectRejection; var RectSubmit; var RectWithdraw;
            var EntryStep; var ExitStep; var RectEntryStep; var RectExitStep;
            var UseRoleNames = true;

            function DateDiff(date1, date2) { return date1.getTime() - date2.getTime(); }
            var pathLine;
            var pathLineArray;

            $(document).ready(function () {
                if (!paper) { paper = Raphael("divDraw"); }
                $('#divDraw').mouseout(function () {
                    isMouseOverPaper = false;
                });
                $('#divDraw').mouseover(function () {
                    isMouseOverPaper = true;
                });
            });

            function GetMaxStepNumber() {
                var mxNbr = -1;
                for (var i = 0; i < arrSteps.length; i++) {
                    var objStep = arrSteps[i];
                    if ((parseInt(objStep.StepNumber) > mxNbr) && (parseInt(objStep.ParentStepId) == currParentId)) {
                        mxNbr = objStep.StepNumber;
                    }
                }
                return mxNbr;
            }

            function GetStepByNumber(argNbr, argParentId) {
                var step = null;
                if (argParentId != null) {
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.StepNumber == argNbr) && (parseInt(objStep.ParentStepId) == argParentId)) {
                            step = objStep;
                        }
                    }
                } else {
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.StepNumber == argNbr) && (parseInt(objStep.ParentStepId) == currParentId)) {
                            step = objStep;
                        }
                    }
                }

                return step;
            }

            function GetStepById(argStepId, argParentId) {
                var step = null;
                for (var i = 0; i < arrSteps.length; i++) {
                    var objStep = arrSteps[i];
                    if ((argParentId) && (argStepId != argParentId)) {
                        if ((objStep.StepId == argStepId) && (objStep.ParentStepId == argParentId)) {
                            step = objStep;
                        }
                    } else {
                        if (objStep.StepId == argStepId) {
                            step = objStep;
                        }
                    }
                }
                return step;
            }
            function pageLoad() {
                if (currParentId > 0) { $('#divLevels').show(); } else { $('#divLevels').hide(); }
            }

            function DrawImage(ParentId) {
                paper.clear();
                returnConnLTmp = returnConnL;
                recalCulatedDivDimensions();

                if (arrSteps.length == 0) return;
                if (currParentId > 0) { $('#divLevels').show(); } else { $('#divLevels').hide(); }

                var tmpBox; var currStartX = startX;
                tmpBox = DrawSubmit();
                currStartX = tmpBox.attrs.x + tmpBox.attrs.width + connL;
                EntryStep = null; ExitStep = null;
                RectEntryStep = null; RectExitStep = null;
                var arrTempSteps = [];
                //Draw Entry Step
                if (currParentId > 0) {
                    EntryStep = GetStepById(currParentId);
                    if (EntryStep) {
                        tmpBox = DrawStep(EntryStep, currStartX);
                        currStartX = tmpBox.attrs.x + tmpBox.attrs.width + connL;
                    }
                }
                //Draw All Steps
                for (var i = 0; i < arrSteps.length; i++) {
                    if (arrSteps[i].ParentStepId == currParentId) {
                        tmpBox = DrawStep(arrSteps[i], currStartX);
                        currStartX = tmpBox.attrs.x + tmpBox.attrs.width + connL;
                    }
                }
                //DrawExit Step
                if (currParentId > 0) {
                    var EntryParentId = EntryStep.ParentStepId;
                    ExitStep = GetStepByNumber(EntryStep.StepNumber + 1, EntryParentId);
                    if (ExitStep) {
                        tmpBox = DrawStep(ExitStep, currStartX);
                        currStartX = tmpBox.attrs.x + tmpBox.attrs.width + connL;
                    }
                }
                tmpBox = DrawFinish(currStartX);
                currStartX = tmpBox.attrs.x + tmpBox.attrs.width + connL;
                for (var i = 0; i < arrSteps.length; i++) {
                    if (arrSteps[i].ParentStepId == currParentId) {
                        var currStep = arrSteps[i];
                        var currStepNumber = currStep.StepNumber;
                        //Submit
                        if (currStep.Type == 'Submit') {
                            var NextStep = GetStepByNumber(parseInt(currStepNumber) + 1);
                            if (NextStep) {
                                LinkBoxes(currStep.Rect, NextStep.Rect, 'RConn', 'LConn', 'Direct', GrayD);
                            }
                        }
                        //Step
                        if (currStep.Type == 'Step') {
                            //Approve
                            var NextStep = GetStepByNumber(parseInt(currStepNumber) + 1);
                            if (NextStep) {
                                LinkBoxes(currStep.Rect, NextStep.Rect, 'RConn', 'LConn', 'Direct', GrayD);
                            } else {
                                LinkBoxes(currStep.Rect, RectFinalApprove, 'RConn', 'LConn', 'Direct', GrayD);
                            }
                            //Return
                            var ReturnToStepId = 0;
                            var PreviousStep;
                            if (currStep.ReturnToStepId > 0) {
                                ReturnToStepId = currStep.ReturnToStepId;
                                PreviousStep = GetStepById(ReturnToStepId, currParentId)
                                if (PreviousStep) {
                                    LinkBoxes(currStep.Rect, PreviousStep.Rect, 'TConn', 'TConn', 'Return', GrayD, currStepNumber);
                                }
                            }
                            if (currStep.ReturnToSpecialStepId < 0) {
                                if (currStep.ReturnToSpecialStepId == -2) {
                                    LinkBoxes(currStep.Rect, RectSubmit, 'TConn', 'TConn', 'Return', GrayD, currStepNumber);
                                }
                                if (currStep.ReturnToSpecialStepId == -5) {
                                    PreviousStep = GetStepByNumber(currStepNumber - 1);
                                    if (PreviousStep) {
                                        LinkBoxes(currStep.Rect, PreviousStep.Rect, 'TConn', 'TConn', 'Return', GrayD, currStepNumber);
                                    }
                                }
                            }
                            //Rejection
                            LinkBoxes(currStep.Rect, RectRejection, 'BConn', 'LConn', 'Rejection', GrayD, 0);
                        }
                        //Branch
                        if (currStep.Type == 'Branch') {
                            //Approve
                            var NextStep = GetStepByNumber(parseInt(currStepNumber) + 1);
                            if (NextStep) {
                                LinkBoxes(currStep.Rect, NextStep.Rect, 'RConn', 'LConn', 'Direct', GrayD);
                            }
                            //Return
                            if (currStep.BranchAction == 'Return') {
                                var ReturnToStepId = 0;
                                var PreviousStep;
                                if (currStep.ReturnToStepId > 0) {
                                    ReturnToStepId = currStep.ReturnToStepId;
                                    PreviousStep = GetStepById(ReturnToStepId, currParentId)
                                    if (PreviousStep) {
                                        LinkBoxes(currStep.Rect, PreviousStep.Rect, 'TConn', 'TConn', 'Return', GrayD, currStepNumber);
                                    }
                                }
                                if (currStep.ReturnToSpecialStepId < 0) {
                                    if (currStep.ReturnToSpecialStepId == -2) {
                                        LinkBoxes(currStep.Rect, RectSubmit, 'TConn', 'TConn', 'Return', GrayD, currStepNumber);
                                    }
                                    if (currStep.ReturnToSpecialStepId == -5) {
                                        PreviousStep = GetStepByNumber(currStepNumber - 1);
                                        if (PreviousStep) {
                                            LinkBoxes(currStep.Rect, PreviousStep.Rect, 'TConn', 'TConn', 'Return', GrayD, currStepNumber);
                                        }
                                    }
                                }
                            }
                            //Rejection
                            if (currStep.BranchAction == 'Reject') { LinkBoxes(currStep.Rect, RectRejection, 'BConn', 'LConn', 'Rejection', GrayD, 0); }
                            //Final Approve
                            if (currStep.BranchAction == 'Final Approve') { LinkBoxes(currStep.Rect, RectFinalApprove, 'RConn', 'LConn', 'Direct', GrayD); }
                        }
                    }
                }

            }

            function DrawSubmit() {
                paper.clear();
                var DrawColor = GrayL;
                if (currParentId > 0) { DrawColor = GrayL; }
                var rectS = paper.rect(startX, startY, bxW, bxH, 0)
                    .attr({
                        stroke: GrayD,
                        fill: "90-" + DrawColor + "-" + DrawColor,
                        cursor: "pointer"
                    }).click(function () {
                        SpecialStepBoxClicked(1);
                    });
                AddBoxConnAttributes(rectS);
                WriteTextToBox(rectS, lbl_Submitter, GrayD);

                var rectW = paper.rect(startX, startY + connL + bxH, bxW, bxH, BranchCurve)
                    .attr({
                        stroke: DrawColor,
                        fill: "90-" + GrayD + "-" + GrayD,
                        cursor: "pointer"
                    }).click(function () {
                        SpecialStepBoxClicked(6);
                    });
                AddBoxConnAttributes(rectW);
                WriteTextToBox(rectW, lbl_Withdrawal, DrawColor);
                LinkBoxes(rectS, rectW, 'BConn', 'TConn', 'Direct', GrayD);

                RectWithdraw = rectW;
                RectSubmit = rectS;
                return rectS;
            }

            function DrawFinish(argStartX) {
                var DrawColorA = GreenF;
                var DrawColorR = RedS;
                var rectA = paper.rect(argStartX, startY, bxW, bxH, 0)
                    .attr({
                        stroke: GrayD,
                        fill: "90-" + DrawColorA + "-" + DrawColorA,
                        cursor: "pointer"
                    }).click(function () {
                        SpecialStepBoxClicked(7);
                    });
                AddBoxConnAttributes(rectA);
                WriteTextToBox(rectA, lbl_FinalApprove, GrayL);

                RectFinalApprove = rectA;

                var rectR = paper.rect(argStartX, startY + connL + bxH, bxW, bxH, BranchCurve)
                    .attr({
                        stroke: GrayD,
                        fill: "90-" + DrawColorR + "-" + DrawColorR,
                        cursor: "pointer"
                    }).click(function () {
                        SpecialStepBoxClicked(5);
                    });
                AddBoxConnAttributes(rectR);
                WriteTextToBox(rectR, lbl_Rejection, GrayL);
                RectRejection = rectR;

                return rectA;
            }


            function DrawStep(objStep, argStartX) {
                var intBranchCurve = 0;
                if (objStep.Type == 'Branch') { intBranchCurve = BranchCurve; }
                var StepText = GetStepText(objStep);
                var DrawColor = GrayL;
                if (currParentId != objStep.ParentStepId) { DrawColor = GrayL; }

                var rectS = paper.rect(argStartX, startY, bxW, bxH, intBranchCurve)
                        .attr({
                            stroke: GrayD,
                            fill: "90-" + DrawColor + "-" + DrawColor,
                            cursor: "pointer"
                        }).click(function () {
                            StepBoxClicked(objStep.StepId);
                        });
                AddBoxConnAttributes(rectS);
                WriteTextToBox(rectS, StepText, GrayD);
                objStep.Rect = rectS;

                if ((objStep.Type == 'Branch') && (objStep.BranchAction == 'Branch') && (objStep.StepId != currParentId)) {
                    var objStartPoint = rectS.data('BConn')[0];
                    //var path1 = paper.path("M" + objStartPoint.X + " " + objStartPoint.Y)
                    //                .attr({
                    //                    PMWebType: "Conn",
                    //                    stroke: GrayS,
                    //                    "stroke-width": 4,
                    //                    cursor: "pointer",
                    //                    "StepId": objStep.StepId
                    //                }).animate({
                    //                    "path": "M" + objStartPoint.X + " " + objStartPoint.Y +
                    //                                "L" + objStartPoint.X + " " + parseInt(objStartPoint.Y + connL / 2) +
                    //                                "L" + parseInt(objStartPoint.X - bxW / 8) + " " + parseInt(objStartPoint.Y + connL) +
                    //                                "M" + objStartPoint.X + " " + parseInt(objStartPoint.Y + connL / 2) +
                    //                                "L" + parseInt(objStartPoint.X + bxW / 8) + " " + parseInt(objStartPoint.Y + connL) +
                    //                                "M" + objStartPoint.X + " " + parseInt(objStartPoint.Y + connL / 2) +
                    //                                "L" + objStartPoint.X + " " + parseInt(objStartPoint.Y + 22)
                    //                }, 1000, '<', function () { }
                    //                ).click(function () {
                    //                    currParentId = this.data("StepId");
                    //                    DrawImage(currParentId);
                    //                });
                    var path1 = paper.image('CSS/Images/ResponsiveIcons/WorkflowBranch.png', objStartPoint.X - 12, objStartPoint.Y + 5, 24, 24)
                       .attr({
                           PMWebType: "Conn",
                           stroke: GrayS,
                           "stroke-width": 4,
                           cursor: "pointer",
                           "StepId": objStep.StepId
                       }).click(function () {
                           currParentId = this.data("StepId");
                           DrawImage(currParentId);
                       });
                    path1.data("StepId", objStep.StepId)
                }
                return rectS;
            }

            function GetStepText(objStep) {
                var StepText = '';
                if (objStep.Roles.length > 1) { StepText = '- Multiple -'; }
                if (objStep.Roles.length == 0) { StepText = '-----'; }
                if (objStep.Roles.length == 1) {
                    if ((objStep.Roles[0].RoleId > 0) && (UseRoleNames == true)) { StepText = objStep.Roles[0].RoleName; }
                    if ((objStep.Roles[0].RoleId > 0) && (UseRoleNames == false)) { StepText = objStep.Roles[0].FullName; }
                    if (objStep.Roles[0].SpecialRoleId > 0) { StepText = objStep.Roles[0].SpecialRoleName; }
                }
                if (objStep.Type == 'Branch') { StepText = objStep.BranchName; }
                if (objStep.Type == 'Submit') { StepText = lbl_Submitter; }
                if (objStep.Type == 'Rejection') { StepText = lbl_Rejection; }

                return StepText;
            }

            function AddBoxConnAttributes(objBox) {
                var rectX = objBox.attrs.x;
                var rectY = objBox.attrs.y;
                var rectWidth = objBox.attrs.width;
                var rectHeight = objBox.attrs.height;
                objBox.data('TConn', [{ X: rectX + rectWidth / 2, Y: rectY - 2 }]);
                objBox.data('BConn', [{ X: rectX + rectWidth / 2, Y: rectY + rectHeight }]);
                objBox.data('LConn', [{ X: rectX, Y: rectY + rectHeight / 2 }]);
                objBox.data('RConn', [{ X: rectX + rectWidth, Y: rectY + rectHeight / 2 }]);
            }

            function LinkBoxes(objBox1, objBox2, SourceConn, TargetConn, LinkType, argColor, argStepNumber) {
                if (!objBox2) return;
                if (!objBox1) return;
                var objStartPoint = objBox1.data(SourceConn)[0];
                var objFinishPoint = objBox2.data(TargetConn)[0];
                switch (LinkType) {
                    case 'Direct':
                        paper.path("M" + objStartPoint.X + " " + objStartPoint.Y + "L" + objFinishPoint.X + " " + objFinishPoint.Y)
                                            .attr({
                                                PMWebType: "Conn",
                                                stroke: argColor,
                                                "stroke-width": 1.5,
                                                "arrow-end": "open-wide-long"
                                            });
                        return;
                    case 'Return':
                        returnConnLTmp += 4;
                        paper.path("M" + objStartPoint.X + " " + objStartPoint.Y +
                                           "L" + objStartPoint.X + " " + parseInt(objStartPoint.Y - returnConnLTmp) +
                                           "L" + parseInt(objFinishPoint.X + 10) + " " + parseInt(objStartPoint.Y - returnConnLTmp) +
                                           "L" + parseInt(objFinishPoint.X + 10) + " " + parseInt(objFinishPoint.Y)
                                           )
                                    .attr({
                                        PMWebType: "Conn",
                                        stroke: argColor,
                                        "stroke-width": 1.5,
                                        "arrow-end": "open-wide-long"
                                    });
                        return;

                    case 'Rejection':
                        paper.path("M" + objStartPoint.X + " " + objStartPoint.Y +
                                           "L" + objStartPoint.X + " " + parseInt(objStartPoint.Y + connL + bxH / 2) +
                                           "L" + objFinishPoint.X + " " + parseInt(objStartPoint.Y + connL + bxH / 2) +
                                           "L" + objFinishPoint.X + " " + parseInt(objFinishPoint.Y)
                                           )
                                    .attr({
                                        PMWebType: "Conn",
                                        stroke: argColor,
                                        "stroke-width": 1.5,
                                        "arrow-end": "open-wide-long"
                                    });
                        return;

                    default:
                        return;
                }

            }


            function ResetAll() {
                paper.clear();
                arrSteps = [];
                return false;
            }

            function LevelUp(argToFirstLevel) {
                var newParentId = 0
                if (argToFirstLevel == true) {
                    newParentId = 0;
                } else {
                    EntryStep = GetStepById(currParentId);
                    if (EntryStep) {
                        newParentId = EntryStep.ParentStepId;
                    }
                }
                currParentId = newParentId;
                DrawImage(currParentId);
            }


            function WriteTextToBox(objBox, strText, argColor) {
                var rectX = objBox.attr("x");
                var rectY = objBox.attr("y");
                var rectWidth = objBox.attr("width");
                var rectHeight = objBox.attr("height");
                if (strText.length > 18) {
                    strText = strText.substr(0, 20);
                    strText = strText + '...';
                }
                var txt = paper.text(rectX + rectWidth / 2, rectY + rectHeight / 2, strText)
                        .attr({
                            id: 'txt_' + objBox.id,
                            Stroke: "none", fill: argColor, "font-weight": "bold",
                            "font-family": fFamily,
                            "font-size": getFontSize(strText)
                        })
                txt.id = 'txt_' + objBox.id;
                return txt;
            }


            function EvenMultiplier(value) {
                if (value % 2 == 0)
                    return 1;
                else
                    return -1;
            }

            function getFontSize(strText) {
                var charNum = strText.length;
                if (charNum <= 15) { return 10; }
                if (charNum < 18) { return 9; }
                if (charNum >= 18) { return 8; }
            }


            function StepBoxClicked(argStepId) {
                var argIsBranch = false;
                var tmpStep = GetStepById(argStepId, currParentId)
                if (tmpStep) { if (tmpStep.Type == 'Branch') argIsBranch = true; }
                var browserWidth = window.parent.document.documentElement.clientWidth;
                var browserHeight = window.parent.document.documentElement.clientHeight;
                if (argIsBranch == true || argIsBranch == 'True') {
                    var wnd = window.parent.radopen('WorkflowDefineBranchStep.aspx?FromTemplateImage=1&StepId=' + argStepId + '&Type=Template', 'BranchStep',
                             'location=0,status=0,menubar=0,addressbar=0,resizable=0,scrollbars=1');
                    if (browserWidth < 1024) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(5, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    return false;
                } else {
                    var wnd = window.parent.radopen('WorkflowDefineRoleStep.aspx?FromTemplateImage=1&StepId=' + argStepId + '&Type=Template', 'Step',
                             'location=0,status=0,menubar=0,addressbar=0,resizable=0,scrollbars=1');
                    if (browserWidth < 1024) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(5, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    return false;
                }
            }


            function SpecialStepBoxClicked(argType) {
                var browserWidth = window.parent.document.documentElement.clientWidth;
                var browserHeight = window.parent.document.documentElement.clientHeight;
                var wnd = window.parent.radopen('WorkflowTemplateActions.aspx?FromTemplateImage=1&ActionTypeId=' + argType + '&Type=Template', 'SpecialStep',
                             'location=0,status=0,menubar=0,addressbar=0,resizable=0,scrollbars=1');
                if (browserWidth < 1024) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function recalCulatedDivDimensions() {
                var currStepNumber = 0;
                var intHeight = 60;
                var intReturnCounter = 0;
                var intReturnAproxHeight = 0;
                startY = initialStartY;

                for (var i = 0; i < arrSteps.length; i++) {
                    if (arrSteps[i].ParentStepId == currParentId) {
                        if (GetStepById(arrSteps[i].ReturnToStepId, currParentId)) {
                            intReturnCounter += 1;
                        }
                    }
                }

                for (var i = 0; i < arrSteps.length; i++) {
                    if (arrSteps[i].ReturnToSpecialStepId < 0) {
                        if (arrSteps[i].ReturnToSpecialStepId == -2) {
                            intReturnCounter += 1;
                        }
                        if (arrSteps[i].ReturnToSpecialStepId == -5) {
                            PreviousStep = GetStepByNumber(arrSteps[i].StepNumber - 1);
                            if (PreviousStep) {
                                intReturnCounter += 1;
                            }
                        }
                    }
                }

                intReturnAproxHeight = returnConnL + (intReturnCounter * 5);

                if (intReturnAproxHeight > 32) {
                    intHeight = intHeight + (parseInt(intReturnAproxHeight));
                    startY = (intHeight * 1) / 2;
                }

                for (var i = 0; i < arrSteps.length; i++) {
                    if (arrSteps[i].ParentStepId == currParentId) currStepNumber += 1;
                }

                if (currStepNumber > 3) {
                    var intWidth = parseInt(700 + (parseInt((currStepNumber - 3)) * 140))
                    $('#divDraw').width(intWidth);
                    paper.setSize(intWidth, intHeight);
                } else {
                    $('#divDraw').width(1080);
                    paper.setSize(1080, intHeight);
                }
            }

        </script>
        <table width="100%">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbRoles" meta:resourcekey="rdbRoles" CssClass="RadioCss" runat="server" Text="Roles1" GroupName="rdb1" Checked="true"
                                    onclick="javascript:UseRoleNames=true;DrawImage(currParentId);" />
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbNames" runat="server" meta:resourcekey="rdbNames" CssClass="RadioCss" Text="Names2" GroupName="rdb1" onclick="javascript:UseRoleNames=false;DrawImage(currParentId);" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <div id="divParent" style="width: 100%; overflow: hidden !important;">
                        <div id="divDraw" style="width: 95%;">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divLevels" style="margin-top: -10px">
                        <a onclick="LevelUp(true);" style="cursor: pointer" class="smallUpAll">
                            <span class="Icon"></span>
                        </a>
                        <a onclick="LevelUp(false);" style="cursor: pointer" class="smallUp">
                            <span class="Icon"></span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
        <asp:PlaceHolder ID="plcSteps" runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
