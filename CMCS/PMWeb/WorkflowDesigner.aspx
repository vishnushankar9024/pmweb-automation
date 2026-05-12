<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="WorkflowDesigner.aspx.vb"
    Inherits="Website.WorkflowDesigner" Title="Visual Workflow Designer11" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=9;" />
    <style type="text/css">
        body {
            background-color: rgb(196, 219, 249) !important;
        }

        .RadTabStripTop_Vista .rtsLevel .rtsLink, .RadTabStripTop_Vista .rtsLevel .rtsOut, .RadTabStripBottom_Vista .rtsLevel .rtsLink, .RadTabStripBottom_Vista .rtsLevel .rtsOut, .RadTabStripTop_Vista_Baseline .rtsLevel, .RadTabStripBottom_Vista_Baseline .rtsLevel {
            background-image: url('CSS/Tabstrip/TabStripStates2.png') !important;
        }

        .RadTabStrip_Default.WorkflowDesignerCss li.rtsLI.rtsFirst, .RadTabStrip_Default.WorkflowDesignerCss li.rtsLI.rtsLast {
            width: 49% !important;
        }

        .WorkflowDesignerCss .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .RadTabStrip_Default.WorkflowDesignerCss {
            border: 1px solid #999999 !important;
            width: calc(100% - 2px) !important;
        }

        .WorkflowDesignerCss .rtsLevel1 .rtsLink .rtsIn table {
            width: 100% !important;
        }



        .WorkflowDesignerCss .rtsSelected:after {
            position: absolute;
            content: " ";
            width: 100%;
            height: 2px;
            background-color: /*3*/ #30788A /*3*/;
            top: 36px !important;
            left: 0px;
        }
        .WorkflowDesignerCss .rtsLI:hover::after {
                content: "";
                position: absolute;
                width: 100%;
                height: 2px;
                background-color: /*3*/ #30788A /*3*/;
                top: 36px !important;
                left: 0;
                    }
  


       

        .RadTreeView.RTVCss {
            border-right: 1px solid #999999;
            overflow: auto !important;
            height: 386px;
        }

        .RadTreeView {
            margin: 0px !important;
        }

        .RadTreeViewSteps .trvCheck .rtSp {
            background-image: none !important;
        }

        .RTVCss .trvCheck .rtSp, .RTVCss .trvFolder .rtSp {
            margin-right: -36px !important;
        }

        .RTVCss .rtUL {
            margin-left: 22px !important;
        }

        .RTVCss .rtChk, .RTVCss .rtChecked, .RTVCss .rtUnchecked, .RTVCss .rtIndeterminate {
            margin-bottom: 2px !important;
        }

        .RTVCss .rtUL .rtUL, .RTVCss .rtUL .rtUL .rtUL {
            margin-left: 0px !important;
        }

            .RTVCss .rtUL .rtUL .rtUL {
                padding-left: 0px !important;
            }

                .RTVCss .rtUL .rtUL .rtUL .rtIn {
                    margin-left: -5px !important;
                }
    </style>
</head>
<body style="background-color: #FFFFFF !important;">
    <form id="form1" runat="server">
        <script src="JS/raphael-min.js" type="text/javascript"></script>
        <script src="JS/Workflow/Designer.js" type="text/javascript"></script>
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">
                var msg_missingsubmit = 'Please add Submit as the first action before adding steps, branches or Finish.';
                var msg_missingstep = 'Please create at least one step before adding the Finish action.';
                var msg_returntosubmitter = 'You cannot return to the submitter!';
                var msg_missingroles = 'All steps must contain a role before saving.';
                var msg_missingChilds = "All branches must contain at least one child step or child branch before saving."
                var msg_returntobranche = 'Workflow cannot return documents to branches!';
                var msg_removechildsbeforechangeaction = 'Remove all childs before changing the branch action!';
                var lbl_Action = 'Please remove the sub steps first!';
                var lbl_Submit = 'SUBMITTER';
                var lbl_Action = 'Action';
                var lbl_Withdraw = 'Withdraw';
                var lbl_DocumentApproved = 'Final Approve';
                var lbl_DocumentRejected = 'Document Rejected';
                var lbl_WorkflowFinished = 'Workflow Finished';

                var paper; arrSteps = []; bxW = 100; bxH = 30; connL = 15; BranchL = 50; BranchLower = 12; diaD = 36; sDiag = 8; startNX = 0; startNY = 0; intAnim = 500; isMouseOverPaper = false; hoverTime = new Date();
                var RedF = '#853118'; RedS = '#D54732'; GreenF = '#005100'; GreenS = '#019802'; BlueF = '#042859'; BlueS = '#0960D7'; OrangeS = '#EC9B1F'; OrangeF = '#EC9B1F'; WhiteS = '#fff'; BlackS = '#000'; GrayS = '#777'; GrayF = '#333'; BeigeS = '#F1EFEC';
                var Gray9 = '#e9e9e9'; Gray6 = '#666666';
                var fFamily = 'tahoma';
                var hoverStepId = 0; hoverParentId = 0; FromStepId = 0; ToStepId = 0; currRoleId = 0; currRoleName = ''; DraggingActive = false;
                var DragStartX, DragStartY, initStartX, ApproveYConn;
                DragStartX = 0; DragStartY = 0;
                initStartX = 200;

                function DateDiff(date1, date2) { return date1.getTime() - date2.getTime(); }

                var pathLine;
                var pathLineArray;
                var currSelectedStepId = 0;
                var currSelectedBranchId = 0;

                function drag_start(posx, posy, e) {
                    if (hoverStepId > 0) {
                        ToStepId = 0;
                        FromStepId = hoverStepId;
                        var objToStep = GetStepById(FromStepId);
                        this.attr({ transform: "s1.3t" });
                        if (objToStep.TYPE == 'STEP') {
                            currRoleId = this.id.substr(this.id.lastIndexOf("_") + 1);
                            var arrStepRoles = objToStep.ROLES;
                            for (var i = 0; i < arrStepRoles.length; i++) {
                                var objRole = arrStepRoles[i];
                                if (objRole.ROLEID == currRoleId) {
                                    currRoleName = objRole.ROLENAME;
                                }
                            }
                            if (paper.getById('txt_' + this.id)) { paper.getById('txt_' + this.id).attr({ transform: "s1.3t" }); }
                        }
                        if (this.id.substr(0, 3) != 'txt') {
                            this.g.remove();
                        }
                        this.toBack();
                    }
                };

                function drag_move(dx, dy, posx, posy) {
                    DraggingActive = true;
                    if ((hoverStepId > 0) && (hoverStepId != FromStepId)) {
                        ToStepId = hoverStepId;
                    }
                    this.attr({
                        transform: "...T" + (dx - DragStartX) + "," + (dy - DragStartY)
                    });
                    if (paper.getById('txt_' + this.id)) {
                        paper.getById('txt_' + this.id).attr({
                            transform: "...T" + (dx - DragStartX) + "," + (dy - DragStartY)
                        });
                    }
                    DragStartX = dx;
                    DragStartY = dy;
                    if (this.id.substr(0, 3) != 'txt') {
                        this.g.remove();
                    }
                    this.toBack();
                }

                function drag_up(posx, posy, e) {
                    DraggingActive = false;
                    if ((Math.abs(DragStartX) + Math.abs(DragStartY)) < 200) {
                        if (currSelectedStepId == FromStepId) {
                            currSelectedStepId = 0;
                        } else {
                            currSelectedStepId = FromStepId;
                        }
                        if (currSelectedBranchId == FromStepId) {
                            currSelectedBranchId = 0;
                        } else {
                            currSelectedBranchId = FromStepId;
                        }
                        reDrawAll();
                        return false;
                    }
                    if (((Math.abs(DragStartX) + Math.abs(DragStartY)) > 200) && (ToStepId == 0)) {
                        var objToStep = GetStepById(FromStepId);
                        if ((objToStep.TYPE == 'FINISH') || (objToStep.TYPE == 'APPROVED') || (objToStep.TYPE == 'REJECT')) {
                            for (var i = 0; i < arrSteps.length; i++) {
                                if (arrSteps[i].TYPE == 'FINISH') arrSteps.splice(i, 1);
                            }
                            for (var i = 0; i < arrSteps.length; i++) {
                                if (arrSteps[i].TYPE == 'APPROVED') arrSteps.splice(i, 1);
                            }
                            for (var i = 0; i < arrSteps.length; i++) {
                                if (arrSteps[i].TYPE == 'REJECT') arrSteps.splice(i, 1);
                            }
                            DragStartX = 0;
                            DragStartY = 0;
                            this.attr({ transform: "" });
                            if (paper.getById('txt_' + this.id)) { paper.getById('txt_' + this.id).transform(""); }
                            reDrawAll();
                            return false;
                        }
                        this.remove();
                        DeleteRole(FromStepId, currRoleId);
                        recalCulatedDivDimensions();
                        reDrawAll();
                    }
                    DragStartX = 0;
                    DragStartY = 0;
                    this.attr({ transform: "" });
                    if (paper.getById('txt_' + this.id)) { paper.getById('txt_' + this.id).transform(""); }
                    hoverStepId = 0;
                    if (ToStepId > 0) {
                        var objToStep = GetStepById(ToStepId);
                        var arrStepRoles = objToStep.ROLES;
                        for (var i = 0; i < arrStepRoles.length; i++) {
                            var objRole = arrStepRoles[i];
                            if (objRole.ROLEID == currRoleId) {
                                ToStepId = 0;
                                return false;
                            }
                        }
                        if (currRoleId > 1) AddRole(objToStep, currRoleName, currRoleId);
                        this.remove();
                        DeleteRole(FromStepId, currRoleId);
                        recalCulatedDivDimensions();
                        reDrawAll();
                    }
                    hoverParentId = 0; hoverStepId = 0;
                }

                var return_start = function (x, y) {
                    if (hoverStepId > 0) {
                        var objStep = GetStepById(hoverStepId);
                        FromStepId = hoverStepId;
                        pathLineArray[0][1] = objStep.DiagX + diaD / 2; //- $('#divDraw').offset().left;
                        pathLineArray[0][2] = objStep.DiagY //- $('#divDraw').offset().top;
                        pathLineArray[1][1] = objStep.DiagX + 65 //- $('#divDraw').offset().left;
                        pathLineArray[1][2] = objStep.DiagY //- $('#divDraw').offset().top;
                        pathLineArray[2][1] = objStep.DiagX + 65 //- $('#divDraw').offset().left;
                        pathLineArray[2][2] = objStep.DiagY //- $('#divDraw').offset().top;
                        pathLineArray[3][1] = objStep.DiagX //- $('#divDraw').offset().left;
                        pathLineArray[3][2] = objStep.DiagY //- $('#divDraw').offset().top;
                        pathLine.attr({ path: pathLineArray }).attr({
                            stroke: Gray6,
                            "stroke-width": 1.5
                        });
                        pathLine.toBack();
                    }
                },
            return_move = function (dx, dy, posx, posy) {
                DraggingActive = true;
                $('#spnHoverStep').text(ToStepId);
                if (((hoverStepId > 0) || (hoverStepId == -2)) && (FromStepId != hoverStepId)) {
                    ToStepId = hoverStepId;
                }
                var objStep = GetStepById(hoverStepId);
                posx = posx - $('#divDraw').offset().left;
                posy = posy - $('#divDraw').offset().top;
                pathLineArray[1][2] = pathLineArray[1][2];
                pathLineArray[2][2] = posy - 3;
                pathLineArray[3][1] = posx - 3;
                pathLineArray[3][2] = posy - 3;
                pathLine.toBack();
                pathLine.attr({ path: pathLineArray }).attr({
                    stroke: Gray6,
                    "stroke-width": 1.5,
                    "arrow-end": "open-wide-long"
                });
            },
            return_up = function () {
                DraggingActive = false;
                hoverStepId = 0;
                DragStartX = 0;
                DragStartY = 0;
                pathLineArray[0][1] = 0;
                pathLineArray[0][2] = 0;
                pathLineArray[1][1] = 0;
                pathLineArray[1][2] = 0;
                pathLineArray[2][1] = 0;
                pathLineArray[2][2] = 0;
                pathLineArray[3][1] = 0;
                pathLineArray[3][2] = 0;
                pathLine.toBack();
                pathLine.attr({ path: pathLineArray }).attr({
                    stroke: Gray6,
                    "stroke-width": 1.5
                });
                if (((ToStepId > 0) || (ToStepId == -2)) && (FromStepId > 0) && (FromStepId != ToStepId)) {
                    var objFromStep = GetStepById(FromStepId);
                    var objToStep = GetStepById(ToStepId);

                    if (objToStep.TYPE == 'BRANCH') {
                        alert(msg_returntobranche);
                        reDrawAll();
                        return false;
                    }
                    if (objFromStep.TYPE == 'BRANCH') {
                        if (hasChilds(objFromStep.STEPID) == true) {
                            alert(msg_removechildsbeforechangeaction);
                            reDrawAll();
                            return false;
                        }

                        if (objToStep.TYPE == 'APPROVED') {
                            objFromStep.BranchAction = 'FinalApprove';
                            objFromStep.ReturnToStepId = 0;
                            reDrawAll();
                            return false;
                        }

                        if (objToStep.TYPE == 'REJECT') {
                            objFromStep.BranchAction = 'Reject';
                            objFromStep.ReturnToStepId = 0;
                            reDrawAll();
                            return false;
                        }

                        objFromStep.BranchAction = 'Return';
                        objFromStep.ReturnToStepId = ToStepId;
                        reDrawAll();
                        return false;
                    }
                    if ((objToStep.TYPE == 'STEP') || (objToStep.TYPE == 'SUBMIT')) {
                        objFromStep.ReturnToStepId = ToStepId;
                        reDrawAll();
                        return false;
                    }

                }
            };

                var DrawPos, intDiffTop, intDiffLeft;
                $(document).ready(function () {
                    if (!paper) { paper = Raphael("divDraw"); }
                    $('#divDraw').mouseout(function () {
                        isMouseOverPaper = false;
                    });
                    $('#divDraw').mouseover(function () {
                        isMouseOverPaper = true;
                    });
                    DrawPos = $('#divParent').position();
                });

                function scrollTop() {
                    if (intDiffTop > 500) intDiffTop = intDiffTop - 500;
                    $('#divParent').scrollTop(parseInt($('#divParent').scrollTop()) + intDiffTop);
                }

                function scrollLeft() {
                    if (intDiffLeft > 500) intDiffLeft = intDiffLeft - 500;
                    $('#divParent').scrollLeft(parseInt($('#divParent').scrollLeft()) + intDiffLeft);
                }

                $(document).mousemove(function (e) {
                    if (DraggingActive == true) {
                        intDiffTop = e.pageY - DrawPos.top;
                        intDiffLeft = e.pageX - DrawPos.left;
                        if ((intDiffTop < 0) || (intDiffTop > 500))
                            setTimeout(scrollTop, 100);
                        if ((intDiffLeft < 0) || (intDiffLeft > 799))
                            setTimeout(scrollLeft, 100);
                    }
                });

                function GetMaxStepNumber(argParent) {
                    var mxNbr = -1;
                    if (argParent) {
                        for (var i = 0; i < arrSteps.length; i++) {
                            var objStep = arrSteps[i];
                            if ((parseInt(objStep.STEPNBR) > mxNbr) && (objStep.PARENTID == argParent) && (objStep.TYPE != 'APPROVED') && (objStep.TYPE != 'REJECT') && (objStep.TYPE != 'FINISH')) {
                                mxNbr = objStep.STEPNBR;
                            }
                        }
                    } else {
                        for (var i = 0; i < arrSteps.length; i++) {
                            var objStep = arrSteps[i];
                            if ((parseInt(objStep.STEPNBR) > mxNbr) && (objStep.TYPE != 'APPROVED') && (objStep.TYPE != 'REJECT') && (objStep.TYPE != 'FINISH')) {
                                mxNbr = objStep.STEPNBR;
                            }
                        }
                    }
                    return mxNbr;
                }

                function GetStepById(argStepId) {
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if (objStep.STEPID == argStepId) {
                            return objStep;
                        }
                    }
                    return null;
                }

                function hasChilds(argStepId) {
                    var isChild = false;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if (objStep.PARENTID == argStepId) {
                            isChild = true;
                        }
                    }
                    return isChild;
                }

                function GetStepByType(argStepType) {
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if (objStep.TYPE == argStepType) {
                            return objStep;
                        }
                    }
                    return null;
                }

                function GetPreviousStepByParentId(ParentId, argStep) {
                    var stepId = 0;
                    var mxNbr = -1;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((parseInt(objStep.STEPNBR) > mxNbr) && (objStep.PARENTID == ParentId) && (objStep.STEPID != argStep.STEPID) && (parseInt(objStep.STEPNBR) < parseInt(argStep.STEPNBR))) {
                            if ((objStep.TYPE == 'SUBMIT') || (objStep.TYPE == 'STEP') || (objStep.TYPE == 'BRANCH')) {
                                mxNbr = objStep.STEPNBR;
                                stepId = objStep.STEPID;
                            }
                        }
                    }
                    if ((stepId > 0) || (stepId == -2)) return GetStepById(stepId);
                    return null;
                }

                function GetFarthestX() {
                    var FarthestX = 0;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.RECT) && (objStep.RECT.attrs) && (objStep.RECT.attrs.x > FarthestX)) {
                            FarthestX = objStep.RECT.attrs.x;
                        }
                    }
                    return FarthestX;
                }

                function GetFarthestY() {
                    var FarthestY = 0;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.RECT) && (objStep.RECT.attrs) && (objStep.RECT.attrs.y > FarthestY)) {
                            FarthestY = objStep.RECT.attrs.y;
                        }
                    }
                    return FarthestY;
                }

                function HasFarthestYInBranch(argStep) {
                    var blnResult = true;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((argStep.PARENTID == objStep.PARENTID) && ((objStep.TYPE == 'SUBMIT') || (objStep.TYPE == 'STEP') || (objStep.TYPE == 'BRANCH'))) {
                            if (objStep.DiagY > argStep.DiagY) blnResult = false;
                        }
                    }
                    return blnResult;
                }

                function isFinishStepDrawn(argArr) {
                    var blnDrawn = false;
                    for (var i = 0; i < argArr.length; i++) {
                        var objStep = argArr[i];
                        if (objStep.TYPE == 'APPROVED') {
                            blnDrawn = true;
                        }
                    }
                    return blnDrawn;
                }

                function DrawSubmit(argStep) {
                    var tmpStepId = 0;
                    if (argStep.IsNew == false) {
                        tmpStepId = argStep.STEPID; intAnim = 0;
                    } else {
                        tmpStepId = -2; intAnim = 500;
                    }
                    paper.clear();
                    pathLine = paper.path("M0 0L0 0L0 0L0 0");
                    pathLineArray = ParsePath(pathLine.attr("path"));
                    var startX = initStartX - (bxW / 2);
                    var startY = 10;

                    var rectS = paper.rect(startX + (bxW / 2), startY + (bxH / 2), 0, 0, 2)
                        .attr({
                            stroke: Gray6,
                            fill: "90-" + Gray9 + "-" + Gray9,
                            StepNbr: "0",
                            StepId: tmpStepId,
                            ParentId: 0,
                            cursor: "pointer"
                        }).animate({ "width": bxW, "height": bxH, "x": startX, "y": startY }, intAnim, '<',
                            function () {
                                var sConn = paper.path("M" + parseInt(rectS.attrs.x + rectS.attrs.width / 2) + " " + parseInt(rectS.attrs.y + rectS.attrs.height) + "L" + parseInt(rectS.attrs.x + rectS.attrs.width / 2) + " " + parseInt(rectS.attrs.y + rectS.attrs.height + connL))
                                    .attr({
                                        PMWebType: "sConn",
                                        stroke: Gray6,
                                        "stroke-width": 1.5,
                                        "arrow-end": "open-wide-long"
                                    });

                                var objPathArray = [];
                                objPathArray = ParsePath(sConn.attr("path"));
                                startNX = (objPathArray[1][1]) - bxW / 2;
                                startNY = objPathArray[1][2];

                                var rectWithdraw = paper.rect(startX - bxW - connL, startY, bxW, bxH, 15)
                                    .attr({
                                        stroke: BlueS,
                                        "stroke-width": 1.5,
                                        fill: "90-" + BeigeS + "-" + BeigeS
                                    });

                                WriteTextToBox(rectWithdraw, lbl_Withdraw, BlueS);

                                var wConn = paper.path("M" + parseInt(rectWithdraw.attrs.x + rectWithdraw.attrs.width) + " " + parseInt(rectS.attrs.y + rectS.attrs.height / 2) + "L" + parseInt(rectS.attrs.x) + " " + parseInt(rectS.attrs.y + rectS.attrs.height / 2))
                                    .attr({
                                        stroke: BlueS,
                                        "stroke-width": 1.5
                                    });

                            });

                    var txtSubmit = paper.text(rectS.attrs.x + rectS.attrs.width / 2, rectS.attrs.y + rectS.attrs.height / 2, lbl_Submit)
                                    .attr({
                                        Stroke: "none", fill: Gray6, "font-weight": "normal",
                                        "font-family": fFamily,
                                        "font-size": "10",
                                        cursor: "pointer"
                                    });

                    var submitSet = paper.set();
                    submitSet.push(rectS);
                    submitSet.push(txtSubmit);
                    submitSet.hover(function () { hoverParentId = 0; hoverStepId = tmpStepId; rectS.g = rectS.glow(); }, function () { hoverParentId = 0; hoverStepId = 0; rectS.g.remove(); });
                    argStep.STEPID = tmpStepId;
                    argStep.RECT = rectS;
                    argStep.ReturnX = parseInt(startX + bxW);
                    argStep.ReturnY = parseInt(startY + bxH / 2);
                    argStep.NextX = parseInt(startX);
                    argStep.NextY = startY + bxH + connL;

                }

                function DrawNewStep(argStep) {
                    argStep.RECT = null;
                    var tmpStepId = 0;
                    if (argStep.IsNew == false) {
                        tmpStepId = argStep.STEPID; intAnim = 0
                    } else {
                        if (argStep.STEPID == 0) { tmpStepId = GetNextRnd(); } else { tmpStepId = argStep.STEPID; }
                        intAnim = 500;
                    }
                    var stpParentId = argStep.PARENTID;


                    var PreviousStep = GetPreviousStepByParentId(stpParentId, argStep);
                    var tmpStepNumber = 0; tmpX = 0; tmpY = 0;
                    if (PreviousStep) {
                        tmpStepNumber = parseInt(PreviousStep.STEPNBR) + 1;
                        tmpX = PreviousStep.NextX; tmpY = PreviousStep.NextY;
                    } else {
                        PreviousStep = GetStepById(stpParentId);
                        tmpStepNumber = 1;
                        if ((PreviousStep.BranchNextX <= GetFarthestX()) && (argStep.IsNew == true)) {
                            PreviousStep.BranchNextX = (GetFarthestX() + bxW + BranchL);
                        }
                        tmpX = PreviousStep.BranchNextX;
                        tmpY = PreviousStep.BranchNextY + BranchLower;
                        // Draw Branch Conn
                        var BConn = paper.path("M" + parseInt(PreviousStep.DiagX + diaD / 2) + " " + PreviousStep.DiagY +
                                            "L" + parseInt(tmpX + bxW / 2) + " " + parseInt(tmpY - BranchLower) +
                                            "L" + parseInt(tmpX + bxW / 2) + " " + parseInt(tmpY - 2))
                                    .attr({
                                        PMWebType: "BConn",
                                        stroke: GrayS,
                                        "stroke-width": 1.5,
                                        "arrow-end": "open-wide-long"
                                    });
                    }
                    var rectS = paper.rect(tmpX, tmpY, bxW, bxH, 2)
                .attr({
                    stroke: Gray6,
                    fill: "90-" + Gray9 + "-" + Gray9,
                    StepNbr: tmpStepNumber,
                    cursor: "pointer",
                    StepId: tmpStepId,
                    ParentId: stpParentId,
                    hoverTimer: null,
                    cursor: "pointer"
                });
                    rectS.id = 'RECT_' + tmpStepId + '_' + '0';

                    var stepSet = paper.set();
                    stepSet.push(rectS);

                    var sConn = paper.path("M" + parseInt(rectS.attrs.x + rectS.attrs.width / 2) + " " + parseInt(rectS.attrs.y + rectS.attrs.height) + "L" + parseInt(rectS.attrs.x + rectS.attrs.width / 2) + " " + parseInt(rectS.attrs.y + rectS.attrs.height + connL))
                .attr({
                    PMWebType: "sConn",
                    "stroke-width": 1.5,
                    stroke: Gray6
                });
                    //paper.set(rectS).drag(drag_move, drag_start, drag_up);

                    argStep.RECT = rectS;
                    //Draw Roles
                    var RoleCount = argStep.ROLES.length;
                    var arrStepRoles = argStep.ROLES;
                    for (var i = 0; i < arrStepRoles.length; i++) {
                        var objRole = arrStepRoles[i];
                        if (i == 0) {
                            argStep.RECT.id = 'RECT_' + tmpStepId + '_' + objRole.ROLEID
                            var txtPath = WriteTextToBox(argStep.RECT, objRole.ROLENAME);
                            stepSet.push(txtPath);
                            //paper.set(argStep.RECT).drag(drag_move, drag_start, drag_up);
                            objRole.RECT = argStep.RECT;
                        } else {
                            var rectRoleStartX = arrStepRoles[i - 1].RECT.attrs.x;
                            var rectRoleStartY = arrStepRoles[i - 1].RECT.attrs.y + bxH + connL / 3;
                            var rectRole = paper.rect(rectRoleStartX, rectRoleStartY, bxW, bxH, 2)
                                    .attr({
                                        stroke: Gray6,
                                        fill: "90-" + Gray9 + "-" + Gray9,
                                        cursor: "pointer"
                                    });
                            rectRole.id = 'RECT_' + tmpStepId + '_' + objRole.ROLEID;
                            var txtRoleName = WriteTextToBox(rectRole, objRole.ROLENAME);
                            stepSet.push(rectRole, txtRoleName);
                            sConn = paper.path("M" + parseInt(rectRole.attrs.x + rectRole.attrs.width / 2) + " " + parseInt(rectRole.attrs.y + rectRole.attrs.height) + "L" + parseInt(rectRole.attrs.x + rectRole.attrs.width / 2) + " " + parseInt(rectRole.attrs.y + rectRole.attrs.height + connL))
                                        .attr({
                                            PMWebType: "sConn",
                                            "stroke-width": 1.5,
                                            stroke: Gray6,
                                            cursor: "pointer"
                                        });
                            //paper.set(rectRole).drag(drag_move, drag_start, drag_up);
                            objRole.RECT = rectRole;

                        }
                    }


                    objPathArray = ParsePath(sConn.attr("path"));
                    startX = objPathArray[1][1];
                    startY = objPathArray[1][2];

                    var objDia = paper.path("M" + startX + " " + startY + " L" + parseInt(startX + diaD / 2) + " " + parseInt(startY + diaD / 2)
                                                                    + " L" + startX + " " + parseInt(startY + diaD)
                                                                    + " L" + parseInt(startX - diaD / 2) + " " + parseInt(startY + diaD / 2)
                                                                    + " Z")
                             .attr({
                                 stroke: Gray6,
                                 fill: "180-" + Gray9 + ":0-" + Gray9 + ":100",
                                 cursor: "pointer",
                                 StepId: tmpStepId,
                                 ParentId: stpParentId
                             })
                             .animate({
                                 transform: "r90"
                             }, intAnim).hover(function () { hoverParentId = stpParentId; hoverStepId = tmpStepId; this.g = this.glow(); }, function () { this.g.remove(); })



                    //Write 'Status' in objDia
                    objPathArray = ParsePath(objDia.attr("path"));
                    startX = objPathArray[1][1];
                    startY = objPathArray[1][2];
                    var txtStatus = paper.text(startX - diaD / 2, startY, lbl_Action)
                        .attr({
                            Stroke: "none", fill: Gray6,
                            "font-family": fFamily,
                            "font-size": "9",
                            cursor: "pointer"
                        });
                    txtStatus.hover(function () { hoverParentId = stpParentId; hoverStepId = tmpStepId; objDia.g = objDia.glow(); }, function () { objDia.g.remove(); });
                    var sConn = paper.path("M" + parseInt(startX - diaD / 2) + " " + parseInt(startY + diaD / 2) +
                                          " L" + parseInt(startX - diaD / 2) + " " + parseInt(startY + diaD / 2 + connL)
                            ).attr({
                                PMWebType: "sConn",
                                stroke: Gray6,
                                "stroke-width": 1.5,
                                "arrow-end": "open-wide-long"
                            });

                    paper.set(objDia).drag(return_move, return_start, return_up);

                    if (currSelectedStepId == tmpStepId) {
                        stepSet.forEach(function (e) {
                            if (e.node.nodeName == 'rect') {
                                e.attr({ fill: '#F9AA33' })
                            }
                        })
                    }


                    stepSet.drag(drag_move, drag_start, drag_up).hover(function () {
                        hoverParentId = stpParentId; hoverStepId = tmpStepId;
                        for (var i = 0; i < stepSet.length; i++) {
                            if (stepSet[i].id.indexOf('RECT_') == 0) stepSet[i].g = stepSet[i].glow();
                        }
                    }, function () {
                        hoverParentId = 0;
                        for (var i = 0; i < stepSet.length; i++) {
                            if (stepSet[i].g) stepSet[i].g.remove();
                        }
                    });
                    //.click(function () {
                    //if (tmpStepId == currSelectedStepId) {
                    //    currSelectedStepId = 0;
                    //    reDrawAll();
                    //} else {
                    //    currSelectedStepId = tmpStepId;
                    //    reDrawAll();
                    //}
                    //}
                    //);


                    argStep.STEPID = tmpStepId;
                    argStep.PARENTID = stpParentId;
                    argStep.STEPNBR = tmpStepNumber;
                    argStep.DiagX = startX - diaD / 2;
                    argStep.DiagY = startY;
                    argStep.ReturnX = startX - diaD / 2;
                    argStep.ReturnY = startY - diaD / 2;
                    argStep.NextX = parseInt(startX - diaD / 2 - bxW / 2);
                    argStep.NextY = parseInt(startY + diaD / 2 + connL);
                }

                function DrawNewBranch(argStep) {
                    var tmpStepId = 0;
                    argStep.RECT = null;
                    if (argStep.IsNew == false) {
                        tmpStepId = argStep.STEPID; intAnim = 0
                    } else {
                        if (argStep.STEPID == 0) { tmpStepId = GetNextRnd(); } else { tmpStepId = argStep.STEPID; }
                        intAnim = 500;
                    }
                    var stpParentId = argStep.PARENTID;
                    if (!(GetMaxStepNumber() > -1)) { alert(msg_missingsubmit); return false; }

                    var PreviousStep = GetPreviousStepByParentId(stpParentId, argStep);
                    var tmpStepNumber = 0; tmpX = 0; tmpY = 0;
                    if (PreviousStep) {
                        tmpStepNumber = parseInt(PreviousStep.STEPNBR) + 1;
                        tmpX = PreviousStep.NextX; tmpY = PreviousStep.NextY;
                    } else {
                        PreviousStep = GetStepById(stpParentId);
                        tmpStepNumber = 1;
                        if ((PreviousStep.BranchNextX <= GetFarthestX()) && (argStep.IsNew == true)) {
                            PreviousStep.BranchNextX = (GetFarthestX() + bxW + BranchL);
                        }
                        tmpX = PreviousStep.BranchNextX;
                        tmpY = PreviousStep.BranchNextY + BranchLower;
                        // Draw Branch Conn
                        var BConn = paper.path("M" + parseInt(PreviousStep.DiagX + diaD / 2) + " " + PreviousStep.DiagY +
                                            "L" + parseInt(tmpX + bxW / 2) + " " + parseInt(tmpY - BranchLower) +
                                            "L" + parseInt(tmpX + bxW / 2) + " " + parseInt(tmpY - 2))
                                    .attr({
                                        PMWebType: "BConn",
                                        stroke: Gray6,
                                        "stroke-width": 1.5
                                    });
                    }
                    var branchSet = paper.set();
                    var rectS = paper.rect(tmpX, tmpY, bxW, bxH, 15)
                .attr({
                    stroke: Gray6,
                    fill: "90-" + Gray9 + "-" + Gray9,
                    StepNbr: tmpStepNumber,
                    cursor: "pointer",
                    StepId: tmpStepId,
                    ParentId: stpParentId
                });
                    //    .hover(function () { hoverParentId = tmpStepId; hoverStepId = tmpStepId; this.g = this.glow(); }, function () {
                    //    hoverParentId = 0; hoverStepId = 0; this.g.remove();
                    //});
                    branchSet.push(rectS);
                    if (argStep.IsBranch == "True" || argStep.IsBranch == true) {
                        var txtBranchName = WriteTextToBox(rectS, argStep.BranchName, Gray6);
                        branchSet.push(txtBranchName);
                        //txtBranchName.hover(function () { hoverParentId = tmpStepId; hoverStepId = tmpStepId; rectS.g = rectS.glow(); }, function () {
                        //    hoverParentId = 0; hoverStepId = 0; rectS.g.remove();
                        //});
                    }

                    //paper.set(rectS).drag(drag_move, drag_start, drag_up);

                    var sConn = paper.path("M" + parseInt(rectS.attrs.x + rectS.attrs.width / 2) + " " + parseInt(rectS.attrs.y + rectS.attrs.height) + "L" + parseInt(rectS.attrs.x + rectS.attrs.width / 2) + " " + parseInt(rectS.attrs.y + rectS.attrs.height + connL))
                .attr({
                    PMWebType: "sConn",
                    "stroke-width": 1.5,
                    stroke: Gray6
                });

                    objPathArray = ParsePath(sConn.attr("path"));
                    startX = objPathArray[1][1];
                    startY = objPathArray[1][2];

                    if (currSelectedBranchId == tmpStepId) {
                        branchSet.forEach(function (e) {
                            if (e.node.nodeName == 'rect') {
                                e.attr({ fill: '#F9AA33' })
                            }
                        })
                    }

                    branchSet.drag(drag_move, drag_start, drag_up).hover(function () { hoverParentId = tmpStepId; hoverStepId = tmpStepId; rectS.g = rectS.glow(); }, function () {
                        hoverParentId = 0; hoverStepId = 0; rectS.g.remove();
                    });

                    var objDia = paper.path("M" + startX + " " + startY + " L" + parseInt(startX + diaD / 2) + " " + parseInt(startY + diaD / 2)
                                                                    + " L" + startX + " " + parseInt(startY + diaD)
                                                                    + " L" + parseInt(startX - diaD / 2) + " " + parseInt(startY + diaD / 2)
                                                                    + " Z")
                             .attr({
                                 stroke: Gray6,
                                 fill: "180-" + Gray9 + ":0-" + Gray9 + ":100",
                                 cursor: "pointer",
                                 StepId: tmpStepId,
                                 ParentId: stpParentId
                             })
                             .animate({
                                 transform: "r90"
                             }, intAnim).hover(function () { hoverParentId = stpParentId; hoverStepId = tmpStepId; this.g = this.glow(); }, function () { hoverParentId = 0; hoverStepId = 0; this.g.remove(); });


                    //Write 'Status' in objDia
                    objPathArray = ParsePath(objDia.attr("path"));
                    startX = objPathArray[1][1];
                    startY = objPathArray[1][2];
                    var txtStatus = paper.text(startX - diaD / 2, startY, lbl_Action)
                        .attr({
                            Stroke: "none", fill: Gray6,
                            "font-family": fFamily,
                            "font-size": "9",
                            cursor: "pointer"
                        });
                    txtStatus.hover(function () { hoverParentId = stpParentId; hoverStepId = tmpStepId; objDia.g = objDia.glow(); }, function () { hoverParentId = 0; hoverStepId = 0; objDia.g.remove(); });
                    var sConn = paper.path("M" + parseInt(startX - diaD / 2) + " " + parseInt(startY + diaD / 2) +
                                          " L" + parseInt(startX - diaD / 2) + " " + parseInt(startY + diaD / 2 + connL)
                            ).attr({
                                PMWebType: "sConn",
                                stroke: Gray6,
                                "stroke-width": 1.5,
                                "arrow-end": "open-wide-long"
                            });


                    //paper.set(objDia).drag(return_move, return_start, return_up);

                    argStep.STEPID = tmpStepId;
                    argStep.PARENTID = stpParentId;
                    argStep.STEPNBR = tmpStepNumber;
                    argStep.RECT = rectS;
                    argStep.DiagX = startX - diaD / 2;
                    argStep.DiagY = startY;
                    argStep.ReturnX = startX - diaD / 2;
                    argStep.ReturnY = startY - diaD / 2;
                    argStep.NextX = parseInt(startX - diaD / 2 - bxW / 2);
                    argStep.NextY = parseInt(startY + diaD / 2 + connL);
                    if (argStep.IsNew == true) {
                        argStep.BranchNextX = parseInt(startX - diaD / 2 + bxW / 2 + BranchL);
                    }
                    argStep.BranchNextY = parseInt(startY);
                }

                function DrawFinish(argStartX, argStartY) {
                    // argStartX is used to draw horizontal connection line
                    if (!(GetMaxStepNumber() > 0)) { alert(msg_missingstep); return false; }

                    var startX = initStartX - (bxW / 2);

                    ApproveYConn = argStartY;
                    paper.path("M" + initStartX + " " + parseInt(argStartY) + "L" + initStartX + " " + parseInt(argStartY + connL))
                                        .attr({
                                            PMWebType: "sConn",
                                            stroke: Gray6,
                                            "stroke-width": 1.5
                                        });

                    argStartY = argStartY + connL;
                    var rectA = paper.rect(startX, argStartY, bxW, bxH, 2)
                .attr({
                    stroke: Gray6,
                    fill: "90-" + GreenS + "-" + GreenS
                });
                    WriteTextToBox(rectA, lbl_DocumentApproved, WhiteS);
                    var objApproveStep = GetStepByType('APPROVED');
                    objApproveStep.RECT = rectA;
                    if (objApproveStep.STEPID == 0) { objApproveStep.STEPID = GetNextRnd(); intAnim = 500; } else { intAnim = 0; }
                    rectA.hover(function () { hoverStepId = objApproveStep.STEPID; this.g = this.glow(); }, function () { hoverStepId = 0; this.g.remove(); });

                    var rectR = paper.rect(startX, argStartY, bxW, bxH, 2)
                .attr({
                    stroke: RedF,
                    fill: "90-" + RedS + "-" + RedS
                });
                    var objRejectStep = GetStepByType('REJECT');
                    objRejectStep.RECT = rectR;
                    if (objRejectStep.STEPID == 0) objRejectStep.STEPID = GetNextRnd();
                    rectR.hover(function () { hoverStepId = objRejectStep.STEPID; this.g = this.glow(); }, function () { hoverStepId = 0; this.g.remove(); });

                    rectR.animate({ "y": argStartY + bxH + connL }, intAnim, '<', function () { WriteTextToBox(rectR, lbl_DocumentRejected, WhiteS); });
                    setTimeout(DrawRejectApproveLines, 2 * intAnim);
                }

                function DrawRejectApproveLines() {
                    var objRejectStep;
                    var objApproveStep;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if (objStep.TYPE == 'REJECT') {
                            objRejectStep = objStep
                        }
                        if (objStep.TYPE == 'APPROVED') {
                            objApproveStep = objStep
                        }
                    }
                    var RejectLineEndX = objRejectStep.RECT[0].x.baseVal.value;
                    var RejectLineEndY = objRejectStep.RECT[0].y.baseVal.value + bxH / 2;
                    var ApproveLineEndX = objApproveStep.RECT[0].x.baseVal.value;
                    var ApproveLineEndY = objApproveStep.RECT[0].y.baseVal.value + bxH / 2;

                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.TYPE == 'STEP') || ((objStep.TYPE == 'BRANCH') && (objStep.BranchAction == 'Reject'))) {
                            var RConn = paper.path("M" + parseInt(objStep.DiagX - diaD / 2) + " " + objStep.DiagY + "L" + parseInt(initStartX - bxW / 2 - 15) + " " + objStep.DiagY
                                                + "L" + parseInt(initStartX - bxW / 2 - 15) + " " + RejectLineEndY
                                                + "L" + parseInt(RejectLineEndX - 2) + " " + RejectLineEndY)
                                    .attr({
                                        PMWebType: "RConn",
                                        stroke: Gray6,
                                        "stroke-width": 1.5,
                                        "arrow-end": "open-wide-long"
                                    });

                        }


                        if ((objStep.TYPE == 'BRANCH') && (objStep.BranchAction == 'FinalApprove')) {
                            var FConn = paper.path("M" + parseInt(objStep.DiagX - diaD / 2) + " " + objStep.DiagY + "L" + parseInt(initStartX - bxW / 2 - 25) + " " + objStep.DiagY
                                                + "L" + parseInt(initStartX - bxW / 2 - 25) + " " + ApproveLineEndY
                                                + "L" + parseInt(ApproveLineEndX - 2) + " " + ApproveLineEndY)
                                    .attr({
                                        PMWebType: "RConn",
                                        stroke: Gray6,
                                        "stroke-width": 1.5
                                    });
                        }

                        if (((objStep.TYPE == 'STEP') || (objStep.TYPE == 'BRANCH')) && (HasFarthestYInBranch(objStep) == true)) {
                            var ApproveConn = paper.path("M" + parseInt(objStep.DiagX) + " " + parseInt(objStep.DiagY + diaD / 2) + "L" + parseInt(objStep.DiagX) + " " + ApproveYConn
                                                + "L" + parseInt(initStartX) + " " + ApproveYConn)
                                    .attr({
                                        PMWebType: "RConn",
                                        stroke: Gray6,
                                        "stroke-width": 1.5
                                    });
                        }
                    }

                }

                function DrawReturnPath(FromStepId, ToStepId) {
                    if ((ToStepId == 0) && (FromStepId != 1)) {
                        alert(msg_returntosubmitter);
                        return false;
                    }

                    if (paper.getById("rtrn_" + FromStepId)) { paper.getById("rtrn_" + FromStepId).remove(); }
                    var objStepFrom = GetStepById(FromStepId);
                    var objStepTo = GetStepById(ToStepId);

                    var ReturnConn = paper.path("M" + parseInt(objStepFrom.DiagX + diaD / 2) + " " + objStepFrom.DiagY + "L" + parseInt(objStepFrom.DiagX + 55 + 5 * objStepFrom.STEPNBR) + " " + objStepFrom.DiagY
                                            + "L" + parseInt(objStepFrom.DiagX + 55 + 5 * objStepFrom.STEPNBR) + " " + parseInt(objStepTo.ReturnY - 2)
                                            + "L" + parseInt(objStepTo.ReturnX) + " " + parseInt(objStepTo.ReturnY - 2))
                                    .attr({
                                        PMWebType: "ReturnConn",
                                        stroke: Gray6,
                                        "stroke-width": 1.5,
                                        "arrow-end": "open-wide-long"
                                    });
                    ReturnConn.id = "rtrn_" + FromStepId;
                    objStepFrom.ReturnToStepId = ToStepId;
                }

                function ClientNodeDropped(sender, eventArgs, AddByClick) {
                    intAnim = 500;
                    var trvSteps = $find($("[id$=trvSteps]")[0].id);
                    var NodeValue = -1;
                    var nodes = trvSteps.get_nodes();
                    if (AddByClick) {
                        for (var i = 0; i < nodes.get_count() ; i++) {
                            if (nodes.getItem(i).get_checked() == true) {
                                NodeValue = nodes.getItem(i).get_value();
                            }
                        }
                    }
                    else {
                        NodeValue = eventArgs.get_sourceNode().get_value();
                    }
                    if (NodeValue == -1) {
                        return false;
                    }
                    if (isMouseOverPaper == true || AddByClick) {
                        if ((NodeValue == 1) && (!(GetMaxStepNumber() > -1))) {

                            arrSteps.push({
                                'TYPE': 'SUBMIT', 'STEPID': 0, 'PARENTID': 0, 'STEPNBR': 0, 'RECT': null, 'ROLES': [], 'DiagX': null, 'DiagY': null, 'ReturnToStepId': 0, 'ReturnX': null, 'ReturnY': null,
                                'NextX': null, 'NextY': null,
                                'BranchNextX': null, 'BranchNextY': null, 'BranchId': 0, 'BranchName': '', 'BranchAction': 'Branch', 'IsBranch': true, 'IsNew': true
                            });
                            reDrawAll();
                        }
                        if (NodeValue == 2) {
                            if (!(GetMaxStepNumber() > -1)) { alert(msg_missingsubmit); return false; }
                            var tmpStepNbr = GetMaxStepNumber(hoverParentId) + 1;
                            arrSteps.push({
                                'TYPE': 'STEP', 'STEPID': 0, 'PARENTID': hoverParentId, 'STEPNBR': tmpStepNbr, 'RECT': null, 'ROLES': [], 'DiagX': null, 'DiagY': null, 'ReturnToStepId': 0, 'ReturnX': null, 'ReturnY': null,
                                'NextX': null, 'NextY': null,
                                'BranchNextX': null, 'BranchNextY': null, 'BranchId': 0, 'BranchName': '', 'BranchAction': 'Branch', 'IsBranch': true, 'IsNew': true
                            });
                            reDrawAll();
                        }
                        if (NodeValue == 3) {
                            if (!(GetMaxStepNumber() > -1)) { alert(msg_missingsubmit); return false; }
                            var tmpStepNbr = GetMaxStepNumber(hoverParentId) + 1;
                            arrSteps.push({
                                'TYPE': 'BRANCH', 'STEPID': 0, 'PARENTID': hoverParentId, 'STEPNBR': tmpStepNbr, 'RECT': null, 'ROLES': [], 'DiagX': null, 'DiagY': null, 'ReturnToStepId': 0, 'ReturnX': null, 'ReturnY': null,
                                'NextX': null, 'NextY': null,
                                'BranchNextX': null, 'BranchNextY': null,
                                'BranchId': 0, 'BranchName': '', 'BranchAction': 'Branch', 'IsBranch': true, 'IsNew': true
                            });
                            reDrawAll();
                        }
                        if ((NodeValue == 4) && (isFinishStepDrawn(arrSteps) == false)) {
                            if (!(GetMaxStepNumber() > 0)) { alert(msg_missingstep); return false; }
                            var tmpStepNbr = GetMaxStepNumber(0) + 1;
                            arrSteps.push({ 'TYPE': 'APPROVED', 'STEPID': 0, 'PARENTID': 0, 'STEPNBR': tmpStepNbr, 'RECT': null, 'ROLES': [], 'IsNew': true });
                            arrSteps.push({ 'TYPE': 'REJECT', 'STEPID': 0, 'PARENTID': 0, 'STEPNBR': tmpStepNbr, 'RECT': null, 'ROLES': [], 'IsNew': true });
                            reDrawAll();
                        }
                    }
                    recalCulatedDivDimensions();
                    var tree = $find("trvSteps");
                    tree.uncheckAllNodes();
                    var btn = document.querySelector("#btnTreeDropSteps");
                    btn.classList.add("Hide");
                    return false;
                }

                function RoleNodeDropped(sender, eventArgs, AddByClick) {
                    intAnim = 500;
                    var rtvRoles = $find($("[id$=rtvRoles]")[0].id);
                    var nodes = rtvRoles.get_nodes().getItem(0).get_nodes();
                    if (AddByClick) {
                        if (currSelectedStepId > 0) {
                            for (var i = 0; i < nodes.get_count() ; i++) {
                                if (nodes.getItem(i).get_checked() == true) {
                                    AddRole(GetStepById(currSelectedStepId), nodes.getItem(i).get_text(), nodes.getItem(i).get_value());
                                }
                            }
                            currSelectedStepId = 0;
                        }
                    } else {
                        if (isMouseOverPaper == true) {
                            if (hoverStepId > 0) {
                                AddRole(GetStepById(hoverStepId), eventArgs.get_sourceNode().get_text(), eventArgs.get_sourceNode().get_value());
                            }
                        }
                    }
                    reDrawAll();
                    var tree = $find("rtvRoles");
                    tree.uncheckAllNodes();
                    var btn = document.querySelector("#btnTreeDropItems");
                    btn.classList.add("Hide");
                    return false;
                }

                function BranchNodeDropped(sender, eventArgs, AddByClick) {
                    intAnim = 500;
                    if (AddByClick) {
                        if (currSelectedBranchId > 0 && (GetStepById(currSelectedBranchId).TYPE == 'BRANCH')) {
                            var rtvBranches = $find($("[id$=rtvBranches]")[0].id);
                            var nodesLvl1 = rtvBranches.get_nodes();
                            for (var i = 0 ; i < nodesLvl1.get_count() ; i++) {
                                if (nodesLvl1.getItem(i).get_checked() == true) {
                                    var nodesLvl2 = nodesLvl1.getItem(i).get_nodes();
                                    for (var j = 0 ; j < nodesLvl2.get_count() ; j++) {
                                        if (nodesLvl2.getItem(j).get_checked() == true) {
                                            var nodesLvl3 = nodesLvl2.getItem(j).get_nodes();
                                            for (var k = 0 ; k < nodesLvl3.get_count() ; k++) {
                                                if (nodesLvl3.getItem(k).get_checked() == true) {
                                                    GetStepById(currSelectedBranchId).BranchId = nodesLvl3.getItem(k).get_value().substr(1);
                                                    GetStepById(currSelectedBranchId).BranchName = nodesLvl3.getItem(k).get_text();
                                                    currSelectedBranchId = 0;
                                                    reDrawAll();
                                                    for (var l = 0 ; l < nodesLvl1.get_count() ; l++) {
                                                        if (nodesLvl1.getItem(i).get_checked() == true) {
                                                            nodesLvl1.getItem(i).set_checked(false);
                                                        }
                                                    }
                                                    return false;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        if (isMouseOverPaper == true) {
                            if ((hoverStepId > 0) && (GetStepById(hoverStepId).TYPE == 'BRANCH')) {
                                GetStepById(hoverStepId).BranchId = eventArgs.get_sourceNode().get_value().substr(1);
                                GetStepById(hoverStepId).BranchName = eventArgs.get_sourceNode().get_text();
                            }
                        }
                    }
                    reDrawAll();
                    var tree = $find("rtvBranches");
                    tree.uncheckAllNodes();
                    var btn = document.querySelector("#btnTreeDropBranches");
                    btn.classList.add("Hide");
                    return false;
                }

                function AddRole(argStep, argRoleName, argRoleId) {
                    var arrStepRoles = argStep.ROLES;
                    for (var i = 0; i < arrStepRoles.length; i++) {
                        var objRole = arrStepRoles[i];
                        if (objRole.ROLEID == argRoleId) {
                            return false;
                        }
                    }
                    var RoleCount = argStep.ROLES.length;
                    argStep.ROLES.push({ 'ROLEID': argRoleId, 'ROLENAME': argRoleName, 'ROLENBR': RoleCount + 1, 'RECT': null });
                    reDrawAll();
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
                    if (charNum <= 18) { return 9; }
                    if (charNum > 18) { return 9; }
                    //            if (charNum <= 20) { return 8; }
                    //            if (charNum > 20) { return 7; }
                }

                function reDrawStep(StepId) {
                    var currStep = GetStepById(StepId);
                    var RoleCount = currStep.ROLES.length;
                    var arrStepRoles = currStep.ROLES;
                    arrStepRoles.sort(function (R1, R2) { return R1.ROLENBR - R2.ROLENBR });
                    for (var i = 0; i < arrStepRoles.length; i++) {
                        var objRole = arrStepRoles[i];
                        if (paper.getById('RECT_' + StepId + '_' + objRole.ROLEID)) { paper.getById('RECT_' + StepId + '_' + objRole.ROLEID).remove(); }
                        if (paper.getById('sConn_' + StepId + '_' + objRole.ROLEID)) { paper.getById('sConn_' + StepId + '_' + objRole.ROLEID).remove(); }
                    }
                }

                function DeleteRole(StepId, argRoleId) {
                    var currStep = GetStepById(StepId);
                    var arrStepRoles = currStep.ROLES;
                    var tmpParentId = currStep.PARENTID;
                    var roleNbr = 0;
                    var StepNbr = 0;
                    for (var i = 0; i < arrStepRoles.length; i++) {
                        var objRole = arrStepRoles[i];
                        if ((objRole.ROLEID == argRoleId) || (argRoleId == 0)) {
                            roleNbr = objRole.ROLENBR;
                            arrStepRoles.splice(i, 1);
                        }
                    }
                    arrStepRoles = currStep.ROLES;
                    for (var i = 0; i < arrStepRoles.length; i++) {
                        var objRole = arrStepRoles[i];
                        if (parseInt(objRole.ROLENBR) > roleNbr) {
                            objRole.ROLENBR = objRole.ROLENBR - 1;
                        }
                    }
                    if (arrStepRoles.length == 0) {
                        if (currStep.TYPE == 'BRANCH') {
                            for (var i = 0; i < arrSteps.length; i++) {
                                var objStep = arrSteps[i];
                                if (objStep.PARENTID == StepId) {
                                    alert(lbl_Action)
                                    reDrawAll();
                                    return false;
                                }
                            }
                        }
                        for (var i = 0; i < arrSteps.length; i++) {
                            var objStep = arrSteps[i];
                            if (objStep.STEPID == StepId) {
                                StepNbr = objStep.STEPNBR;
                                arrSteps.splice(i, 1);
                            }
                        }
                        for (var i = 0; i < arrSteps.length; i++) {
                            var objStep = arrSteps[i];
                            if ((parseInt(objStep.STEPNBR) > StepNbr) && (objStep.PARENTID == tmpParentId)) {
                                objStep.STEPNBR = objStep.STEPNBR - 1;
                            }
                            if (objStep.ReturnToStepId == StepId) {
                                objStep.ReturnToStepId = 0;
                            }
                        }
                    }
                    if (paper.getById('RECT_' + StepId + '_' + argRoleId)) { paper.getById('RECT_' + StepId + '_' + argRoleId).remove(); }
                    if (paper.getById('sConn_' + StepId + '_' + argRoleId)) { paper.getById('sConn_' + StepId + '_' + argRoleId).remove(); }
                }

                function DeleteStep(argStepId) {
                    var currStep = GetStepById(argStepId);


                }

                function reDrawAll(argRecallDimensions) {
                    var arrSteps2 = [];
                    arrSteps2 = arrSteps;
                    paper.clear();
                    if (arrSteps2.length > 0) {
                        var currStep;
                        for (var i = 0; i < arrSteps2.length; i++) {
                            currStep = arrSteps2[i];
                            if (currStep.TYPE == 'SUBMIT') {
                                DrawSubmit(currStep);
                                currStep.IsNew = false;
                            }
                            if (currStep.TYPE == 'STEP') {
                                DrawNewStep(currStep);
                                currStep.IsNew = false;
                            }
                            if (currStep.TYPE == 'BRANCH') {
                                if (hasChilds(currStep.STEPID) == true) { currStep.BranchAction = 'Branch'; currStep.ReturnToStepId = 0; }
                                DrawNewBranch(currStep);
                                currStep.IsNew = false;
                            }
                        }
                        for (var i = 0; i < arrSteps2.length; i++) {
                            currStep = arrSteps2[i];
                            if ((currStep.ReturnToStepId > 0) || (currStep.ReturnToStepId == -2)) {
                                DrawReturnPath(currStep.STEPID, currStep.ReturnToStepId);
                            }
                        }
                        if (isFinishStepDrawn(arrSteps2) == true) {
                            var mxNbr = -1;
                            var mxNextY = -1;
                            var mxNextX = -1;
                            var objStep;
                            for (var i = 0; i < arrSteps.length; i++) {
                                objStep = arrSteps[i];
                                if ((objStep.ParentId == 0) && (parseInt(objStep.STEPNBR) > mxNbr)) {
                                    mxNbr = objStep.STEPNBR;
                                }
                                if (parseInt(objStep.NextY) > mxNextY) {
                                    mxNextY = parseInt(objStep.NextY);
                                }
                                if (parseInt(objStep.NextX) > mxNextX) {
                                    mxNextX = parseInt(objStep.NextX);
                                }
                            }
                            DrawFinish(mxNextX, mxNextY);
                        }
                    }
                    if (!(argRecallDimensions)) recalCulatedDivDimensions();
                }

                function WriteTextToBox(objBox, strText, argColor) {
                    var tmpColor = Gray6;
                    if (argColor) tmpColor = argColor;  //'#F4F4F4';
                    var rectX = objBox.attr("x");
                    var rectY = objBox.attr("y");
                    var rectWidth = objBox.attr("width");
                    var rectHeight = objBox.attr("height");
                    if (strText.length > 23) {
                        strText = strText.substr(0, 17);
                        strText = strText + '...';
                    }
                    var txt = paper.text(rectX + rectWidth / 2, rectY + rectHeight / 2, strText)
                    .attr({
                        id: 'txt_' + objBox.id,
                        Stroke: "none", fill: tmpColor, "font-weight": "normal",
                        "font-family": fFamily,
                        "font-size": getFontSize(strText),
                        cursor: "pointer"
                    })
                    txt.id = 'txt_' + objBox.id;
                    //if (strText.length > 18) {
                    //    var txtBxWidth = txt.node.getBBox().width;
                    //    var origTextX = rectX + rectWidth / 2;
                    //    setTimeout(function () { animateTxtRight(txt, origTextX, txtBxWidth - rectWidth, 4000); }, GetNextRndAnim());
                    //}
                    return txt;
                }
                function animateTxtLeft(argtxt, origTextX, argdiffWidth, argintAnim) {
                    argtxt.animate({ "x": origTextX - (argdiffWidth / 2 + 10) }, argintAnim, 'linear',
                            function () {
                                animateTxtRight(argtxt, origTextX, argdiffWidth, argintAnim);
                            });
                }
                function animateTxtRight(argtxt, origTextX, argdiffWidth, argintAnim) {
                    argtxt.animate({ "x": origTextX + (argdiffWidth / 2 + 10) }, argintAnim, 'linear',
                            function () {
                                animateTxtLeft(argtxt, origTextX, argdiffWidth, argintAnim);
                            });

                }

                function AddArrowEnd(objLine, Direction) {
                    var arrowX = objBox.attr("x");
                    var arrowY = objBox.attr("y");
                    var arrowPath = paper.path("M" + parseInt(arrowX - 5) + " " + parseInt(arrowY - 5)
                                                + "L" + arrowX + " " + arrowY + ""
                                                + "L" + parseInt(arrowX - 5) + " " + parseInt(arrowY + 5)).attr({
                                                    PMWebType: "arrowEnd",
                                                    stroke: BlackS
                                                });

                    if (Direction == 'UP') { compassScale.animate({ rotation: "90 " + arrowX + " " + arrowY }, 10); };

                    if (Direction == 'LEFT') { compassScale.animate({ rotation: "180 " + arrowX + " " + arrowY }, 10); };

                    if (Direction == 'DOWN') { compassScale.animate({ rotation: "270 " + arrowX + " " + arrowY }, 10); };
                }

                function toolbarclick_handler(sender, args) {
                    switch (args.get_item().get_commandName()) {
                        case 'Clear':
                            args.set_cancel(true);
                            ResetAll();
                            break;

                        case 'Save':
                            args.set_cancel(true);
                            SaveSteps(sender, false);
                            break;

                        case 'SaveAndClose':
                            args.set_cancel(true);
                            SaveSteps(sender, true);
                            CloseDesigner();
                            break;

                        case 'Cancel':
                            args.set_cancel(true);
                            CloseDesigner();
                            break;

                        default:
                            break;
                    }
                }

                function CloseDesigner() {
                    //   window.opener.CloseDesigner();
                    CloseRadWnd();
                }

                function SaveSteps(sender, argClose) {
                    if (ValidateRoles() == false) { alert(msg_missingroles); return false; }
                    if (ValidateRuleBranches() == false) { alert(msg_missingChilds); return false; }
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if (objStep.RECT) {
                            objStep.RECT = null;
                        }
                        if (objStep.ROLES.length > 0) {
                            for (var j = 0; j < objStep.ROLES.length; j++) {
                                objStep.ROLES[j].RECT = null;
                            }
                        }
                    }

                    PageMethods.SaveSteps(arrSteps,
                                    function (response) {
                                        if (argClose == true) {
                                            __doPostBack("Page", 'SaveTemplateStepsAndClose');
                                        } else {
                                            __doPostBack("Page", 'SaveTemplateSteps');

                                        }
                                    },
                                    function (msg) { alert(msg) },
                                                null);
                    return false;
                }

                function ValidateRoles() {
                    var isValid = true;
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.ROLES.length == 0) && (objStep.TYPE == 'STEP')) {
                            isValid = false;
                        }
                    }
                    return isValid;
                }

                function ValidateRuleBranches() {
                    for (var i = 0; i < arrSteps.length; i++) {
                        var objStep = arrSteps[i];
                        if ((objStep.TYPE == 'BRANCH') && (objStep.BranchAction == 'Branch')) {
                            for (var j = 0; j < arrSteps.length; j++) {
                                if (hasChilds(objStep.STEPID) == false) {
                                    return false;
                                    break;
                                }
                            }
                        }
                    }
                    return true;
                }

                function recalCulatedDivDimensions() {
                    if (arrSteps.length > 3) {
                        var intHeight = 200 + parseInt(GetFarthestY());
                        $('#divDraw').height(intHeight);

                        var intWidth = 200 + parseInt(GetFarthestX());
                        $('#divDraw').width(intWidth);
                        if (intWidth < 800) intWidth = 800;
                        paper.setSize(intWidth, intHeight);
                        //reDrawAll(true);
                    }

                }

                function ParsePath(objPath) {
                    var arrReturn = [];
                    if (typeof objPath == "string") {
                        arrReturn = objPath.split("L");
                        for (var i = 0; i < arrReturn.length; i++) {
                            if (arrReturn[i].indexOf("M") > -1) {
                                arrReturn[i] = arrReturn[i].replace("M", "M ");
                            } else {
                                arrReturn[i] = '0 ' + arrReturn[i];
                            }
                            arrReturn[i] = arrReturn[i].split(" ");
                        }
                        return arrReturn;
                    }
                    return objPath;
                }

                function GetNextRnd() {
                    return Math.floor((Math.random() * 10000000000) + 1);
                }
                function GetNextRndAnim() {
                    return Math.floor((Math.random() * 9999) + 1);
                }
                function ResetAll() {
                    paper.clear();
                    arrSteps = [];
                    return false;
                }
                function afterClientCheck(tree, eventArgs) {
                    var node = eventArgs.get_node();
                    if (node.get_checked()) {
                        for (var i = 0; i < tree.get_allNodes().length; i++) {
                            if (tree.get_allNodes()[i] != node)
                                tree.get_allNodes()[i].set_checked(false);
                        }
                    }
                    if (tree.get_checkedNodes().length > 0) {
                        $("[id$=btnTreeDropSteps]").removeClass("Hide");
                    }
                    else
                        $("[id$=btnTreeDropSteps]").addClass("Hide");
                }
                function afterClientNodeCheck(tree, eventArgs) {
                    var node = eventArgs.get_node();
                    if (node.get_checked()) {
                        var rtvBranches = $find($("[id$=rtvBranches]")[0].id);
                        var nodesLvl1 = rtvBranches.get_nodes();
                        for (var i = 0 ; i < nodesLvl1.get_count() ; i++) {
                            if (nodesLvl1.getItem(i).get_checked() == true) {
                                var nodesLvl2 = nodesLvl1.getItem(i).get_nodes();
                                for (var j = 0 ; j < nodesLvl2.get_count() ; j++) {
                                    if (nodesLvl2.getItem(j).get_checked() == true) {
                                        var nodesLvl3 = nodesLvl2.getItem(j).get_nodes();
                                        for (var k = 0 ; k < nodesLvl3.get_count() ; k++) {
                                            if (nodesLvl3.getItem(k) != node) {
                                                nodesLvl3.getItem(k).set_checked(false);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (tree.get_checkedNodes().length > 0) {
                        $("[id$=btnTreeDropBranches]").removeClass("Hide");
                    }
                    else
                        $("[id$=btnTreeDropBranches]").addClass("Hide");
                }
            </script>
        </telerik:RadScriptBlock>
        <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="true">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Height="25px" Width="100%" runat="server" Skin="Default" CssClass="small-toolbar"
                        AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave"
                                CommandName="Save" AccessKey="s" PostBack="false">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveAndClose" AccessKey="s">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarClear"
                                CommandName="Clear" AccessKey="s">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row row-8-4-fit8 documentSinglePage">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td id="tdTools" valign="top" style="width: 100%; height: 500px;">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblSteps" runat="server" Text="Steps" meta:resourcekey="lblSteps"></asp:Label>
                                    </legend>
                                    <table id="tblSteps" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px #8d8b8b; position: relative !important;">
                                        <tr>
                                            <td>
                                                <telerik:RadTreeView ID="trvSteps" runat="server" EnableDragAndDrop="True" OnClientNodeDropping="ClientNodeDropped" Skin="Default"
                                                    Width="98%" ShowLineImages="false" Style="margin: 5px" CheckBoxes="true" TriStateCheckBoxes="true" CssClass="RadTreeViewSteps"
                                                    OnClientNodeChecked="afterClientCheck">
                                                    <Nodes>
                                                        <telerik:RadTreeNode runat="server" Text="Submit" Value="1" AllowDrag="true" AllowDrop="true"
                                                            ContentCssClass="trvCheck">
                                                        </telerik:RadTreeNode>
                                                        <telerik:RadTreeNode runat="server" Text="Step" Value="2" AllowDrag="true" ContentCssClass="trvCheck">
                                                        </telerik:RadTreeNode>
                                                        <telerik:RadTreeNode runat="server" Text="Branch" Value="3" AllowDrag="true" ContentCssClass="trvBranch">
                                                        </telerik:RadTreeNode>
                                                        <telerik:RadTreeNode runat="server" Text="Finish" Value="4" AllowDrag="true" ContentCssClass="trvCheck">
                                                        </telerik:RadTreeNode>
                                                    </Nodes>
                                                </telerik:RadTreeView>
                                                <asp:LinkButton runat="server" ID="btnTreeDropSteps" OnClientClick="return ClientNodeDropped(null,null,true);" CssClass="Hide">
                                                    <div class="btnTreeDropItems" style="display: inline-block !important; bottom:10px !important;">
                                                       &nbsp; 
                                                    </div>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblRolesAPMRules" runat="server" CssClass="legend" Text="Roles & Branch Rules" meta:resourcekey="lblRolesAPMRules"></asp:Label>
                                    </legend>
                                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                                        SelectedIndex="0" CssClass="WorkflowDesignerCss">
                                        <Tabs>
                                            <telerik:RadTab Text="Roles" Value="Roles"
                                                PageViewID="RadPageView1" Height="38px" style="position:relative">
                                                <TabTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton runat="server" ID="imgCheck" Style="cursor: pointer" CssClass="UserButton">
                                                                     <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblRolesName" meta:Resourcekey="RadTab_Roles"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </TabTemplate>
                                            </telerik:RadTab>
                                            <telerik:RadTab IsSeparator="true" CssClass="SeperatorCssTabWorkflow" Visible="true" Enabled="false"
                                                ID="SeperatorTab" runat="server" OuterCssClass="SeperatorCssTabWorkflow">
                                            </telerik:RadTab>
                                            <telerik:RadTab Text="Branches" Value="Branches"
                                                PageViewID="RadPageView2" Height="38px" style="position:relative">
                                                <TabTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton runat="server" ID="imgBranch" Style="cursor: pointer" CssClass="BranchButton">
                                                                     <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblBranchRulesName" meta:Resourcekey="RadTab_Branches"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </TabTemplate>
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>
                                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" Width="100%">
                                        <telerik:RadPageView ID="RadPageView1" runat="server" Style="width: 100%; height: 387px; border: 1px solid #999999; border-top: none;">
                                            <telerik:RadTreeView ID="rtvRoles" runat="server" EnableDragAndDrop="True" OnClientNodeDropping="RoleNodeDropped" Skin="Default"
                                                Width="100%" ShowLineImages="false" Style="margin-top: 2px" Height="386px" CssClass="RTVCss RadTreeViewRoles" CheckBoxes="true" 
                                                TriStateCheckBoxes="true" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                            </telerik:RadTreeView>
                                            <asp:LinkButton runat="server" ID="btnTreeDropItems" OnClientClick="return RoleNodeDropped(null,null,true);">
                                                <div class="btnTreeDropItems" style="display: inline-block !important;">
                                                    &nbsp; 
                                                </div>
                                            </asp:LinkButton>
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="rdpSeperator" runat="server"></telerik:RadPageView>
                                        <telerik:RadPageView ID="RadPageView2" runat="server" Style="width: 100%; height: 387px; border: 1px solid #999999; border-top: none;">
                                            <telerik:RadTreeView ID="rtvBranches" runat="server" EnableDragAndDrop="True" OnClientNodeDropping="BranchNodeDropped" Skin="Default"
                                                Width="100%" ShowLineImages="false" Style="margin-top: 2px" Height="386px" CssClass="RTVCss" CheckBoxes="true" TriStateCheckBoxes="true"
                                                OnClientNodeChecked="afterClientNodeCheck">
                                            </telerik:RadTreeView>
                                            <asp:LinkButton runat="server" ID="btnTreeDropBranches" OnClientClick="return BranchNodeDropped(null,null,true);">
                                                <div class="btnTreeDropItems" style="display: inline-block !important;">
                                                    &nbsp; 
                                                </div>
                                            </asp:LinkButton>
                                        </telerik:RadPageView>
                                    </telerik:RadMultiPage>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-8">
                    <table class="colTable">
                        <tr>
                            <td id="tdDrawing" valign="top" style="width: 100%; height: 400px;">
                                <table id="tblDrawing" cellpadding="0" cellspacing="0" style="width: calc(100% - 10px);">
                                    <%--<tr style="background-color: rgb(226, 226, 226); width: 100%; text-align: Left; font-size: 11px; height: 20px">
                                        <td width="100%" align="center">
                                            <span style="color: black; font-family: arial">
                                                <asp:Label ID="lblVWorkflow" runat="server" Text="Visual Workflow Designer" meta:resourcekey="lblVWorkflow"></asp:Label></span>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td style="background-color: #FFFFFF; border: 1px solid #999999;">
                                            <div id="divParent" style="height: 577px; width: 100%; overflow: auto;">
                                                <div id="divDraw" style="height: 100%; width: 100%; max-width: 400px;">
                                                </div>
                                            </div>
                                            <div id="divStepNbr">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnTemplateId" runat="server" ValidateRequestMode="Disabled" />
        <asp:PlaceHolder ID="plcSteps" runat="server"></asp:PlaceHolder>
        <asp:HiddenField ID="hdnArrSteps" runat="server" ValidateRequestMode="Disabled" />
    </form>
</body>
</html>
