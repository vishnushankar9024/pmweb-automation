var isCommentsRequired = false;
var isTeamInputPopup = false;
var MobileScreenWidth = 1024;

function TeamInputConfirmAction() {
    if (TeamInputCount > 0) {
        var tdActions = $("#tdAction").find("input[type='radio']");
        var checked = false;
        for (var i = 0; i < tdActions.length; i++) {
            if (tdActions[i].checked == true) {
                checked = true
            }
        } 
        var rdbReviewComplete;
        var rdbComment;
        var rdbDelegate;
        var rdbApproverComment;

        if ($("#tdAction").find("input[type='radio']").context != null) {
            rdbReviewComplete = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbReviewComplete");
            rdbComment = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbComment");
            rdbDelegate = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbDelegate");
            rdbApproverComment = $("#tdAction").find("input[type='radio']").context.getElementById("ctl00_CPH1_WorkflowDocument_rdbApproverComment");
        }

        if (rdbDelegate == null && rdbApproverComment == null && rdbComment != null && rdbReviewComplete != null) {
            if (checked == false || (checked == true && (rdbReviewComplete.checked || rdbComment.checked))) {
                            return;
                        }
        }

        if (rdbDelegate != null && rdbApproverComment != null && rdbComment == null && rdbReviewComplete == null) {
            if (checked == false || (checked == true && (rdbDelegate.checked || rdbApproverComment.checked))) {
                return;
            }
        }
        
        if (isTeamInputPopup) {
            return;
        }

        var answer = confirm(unescape(WarningMsg_TeamInput));
        if (!answer) {
            return false;
        }
        
    }
    return true;
}


function cvComments_validate(sender, args) {
    if (isCommentsRequired == true) {
        if ($("#WorkflowDocument textarea[id$='txtComments']").val() == '') {
            args.IsValid = false;
        } else { 
            args.IsValid = true;
        }
            
    } else {
        args.IsValid = true;
    }
}


function cvAction_validate(sender, args) {
    try {
        $("#tdAction").find("input[type='radio']").each(function () {
            if (this.checked == true) { args.IsValid = true; throw true; }
        });
        if (isTeamInputPopup == true) { args.IsValid = true; throw true; }
        args.IsValid = false;
    }
    catch (e) { /*error throw true just to break the each itiration*/ }
}

function ResizeToScreen()
{
//    if ($.browser.msie) { $('#imgWorkflow').css({ 'width': screen.width - 245 }); }
//    else { $('#imgWorkflow').css({ 'width': screen.width - 230 }); }
}

function SubmitWorkflowError(errorMsg, url)
{
   alert("'" + errorMsg + "'");
    window.location = url;
}

function AlertOnEdit(ctrlId, msg)
{
    var pos = $("#" + ctrlId).offset();
    AlertMessage((pos.top - 320), (pos.left - 190), unescape(msg), 4000);
}

function EditSelectedStep(ctrl)
{
    var grid = $find(WorkflowDocumentGrid);
    if (grid.get_masterTableView().get_selectedItems().length > 0)
    {
        return GetSelectedNames(ctrl);

    } else
    {
        return false;
    }
}

function GetSelectedNames(ctrl)
{
    var grid = $find(WorkflowDocumentGrid);
    var MasterTable = grid.get_masterTableView();

    var selectedRows = MasterTable.get_selectedItems();
    var row = selectedRows[0];
    var stepNumber = $(MasterTable.getCellByColumnUniqueName(row, "StepNumber")).text().trim();
    var arrStepNumbers = $("#WorkflowDocument [id$=hdnEditableSteps]")[0].value.split(",");
    if (jQuery.inArray(stepNumber, arrStepNumbers) < 0)
    {
        AlertOnEdit(ctrl.id,Msg_ActionsCannotBeEdited);
        return false;
    }
    else return true;
}

function OpenResendMessagesPopup() {
    var grid = $find(workflowLogGrid);
    var row = grid.MasterTableView.get_selectedItems();
    if (row.length == 0) return;
    var ActionId = row[0].getDataKeyValue("ActionId");
    var StepId = row[0].getDataKeyValue("StepId");
    return OpenPOPUp("WorkflowResendMessages.aspx?ActionId=" + ActionId + "&StepId=" + StepId, 950, 570, false, "");
}

function OpenWorkflowDocuSignPopup() {
    var wnd = window.radopen("WorkflowDocuSignPopup.aspx?ObjectType=ot&Id=id&RecordDescription=rd");
    wnd.setSize(950, 570);
    wnd.add_close();
    wnd.Center();
    return false;
}

function OpenMessagesPopupFromLine(ActionId,StepId) {
    return OpenPOPUp("WorkflowResendMessages.aspx?ActionId=" + ActionId + "&StepId=" + StepId, 950, 570, false, "");
}

function OpenSelectGeneratedRecordsPopup(StepActionId) {
    return OpenPOPUp("SelectGeneratedRecordPopup.aspx?StepActionId=" + StepActionId, 550, 270, false, "");
}


function OpenTeamInputPopup() {
    var tdActions = $("#tdAction").find("input[type='radio']");
    for (var i = 0; i < tdActions.length; i++) {
        tdActions[i].checked = false;
    }
    arrActionsSettings = BuildArrayActionsSettings();
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = radopen("WorkflowTeamInput.aspx");
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(TeamInputClosed);
    FillEmailInfo('TeamInput');
    return false;
}


function FillEmailInfo(target) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    $("[id$=pnlQuickFileUpload]").show();
    if (target != 'ReviewComplete' && target != 'Comment') {
        if (target == 'ApproverComment') {
            $("[id$=dvTeamMemberView]").show();
            $("[id$=dvApproversView]").hide();
        } else {
            $("[id$=dvTeamMemberView]").hide();
            $("[id$=dvApproversView]").show();
        }
    }
    arrActionsSettings = BuildArrayActionsSettings();
    if (blnShowReturnPopup == 1 && target == 'Return') {
        $("#WorkflowDocument input[id$='txtSubject']").val(''); $("#WorkflowDocument [id$=dvEmailBody]").html('');
        var wnd = window.radopen("WorkflowReturnToPopup.aspx?DocumentId=0");
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        wnd.add_close(ReturnClosed);
        return false;
    }

    if (target == 'Comment') {
        $("#WorkflowDocument input[id$='txtSubject']").val(''); $("#WorkflowDocument [id$=dvEmailBody]").html('');
        return false;
    }

    if (blnShowDelegatePopup == 1 && target == 'Delegate') {
        $("#WorkflowDocument input[id$='txtSubject']").val(''); $("#WorkflowDocument [id$=dvEmailBody]").html('');
        var wnd = window.radopen("WorkflowDelegateStepPopup.aspx?DocumentId=0");
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        wnd.add_close(DelegateClosed);
        return false;
    }

    for (var i = 0; i < arrActionsSettings.length; i++) {
        var objActionSettings = arrActionsSettings[i];
        if (objActionSettings.Action == target) {
            $("#WorkflowDocument input[id$='txtSubject']").val(Encoder.htmlDecode(objActionSettings.Subject));
            $("#WorkflowDocument [id$=dvEmailBody]").html(Encoder.htmlDecode(objActionSettings.Body));
            isCommentsRequired = false;
            if (objActionSettings.RequireComments == 'True') isCommentsRequired = true;
        }
    }
}

function DeleteWorkflowConfirmaction() {
    return confirm(WarningMsg_ConfirmDeleteWorkflow);
}

function isMobileScreen() {
    var browserWidth = $telerik.$(window).width();
    if (browserWidth <= MobileScreenWidth)
        return true;
    return false;
}