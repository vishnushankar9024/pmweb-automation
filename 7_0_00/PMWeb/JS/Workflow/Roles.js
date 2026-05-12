/// <reference path="../jQuery-vsdoc.js" />


function DeleteSelectedRoles() {
    var grid = $find(gridId);
    if (grid.get_masterTableView().get_selectedItems().length > 0) {
        return ConfirmDelete();
    }
    return false;
}


function DisableWarningTabs() {
    DisableTemplateTab();
    DisableRuleTab();
    DisableAssignmentsTab();
    $("div[id$='pnlWarningPanel']").show();
}

function EnableWarningTabs() {
    EnableTemplateTab();
    EnableAssignmentsTab();
    EnableRuleTab();
    $("div[id$='pnlWarning']").hide();

}

function EnableTemplateTab() {
    $("a[tabindex='1']").removeClass("rtsDisabled").css("cursor", "");
    $("a[tabindex='1']").attr("href", "#");
}

function EnableRuleTab() {
    $("a[tabindex='3']").removeClass("rtsDisabled").css("cursor", "");
    $("a[tabindex='3']").attr("href", "#");
}

function EnableAssignmentsTab() {
    $("a[tabindex='2']").removeClass("rtsDisabled").css("cursor", "");
    $("a[tabindex='2']").attr("href", "#");
}

function DisableAssignmentsTab() {
    $("a[tabindex='2']").addClass("rtsDisabled").css("cursor", "no-drop");
    $("a[tabindex='2']").attr("href", "Javascript:stop(event)");
}

function DisableTemplateTab() {
    $("a[tabindex='1']").addClass("rtsDisabled").css("cursor", "no-drop");
    $("a[tabindex='1']").attr("href", "Javascript:stop(event)");
}

function DisableRuleTab() {
    $("a[tabindex='3']").addClass("rtsDisabled").css("cursor", "no-drop");
    $("a[tabindex='3']").attr("href", "Javascript:stop(event)");
}


function stopTab(event)
{
    return stop(event);
}

function isMouseOverGrid(target) {

    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id!=null && parentNode.id.indexOf(gridId + "_ctl00__")==0) {
            return parentNode;
        }
        parentNode = parentNode.parentNode;
    }

    return null;
}

function onNodeDragging(sender, args) {
    var target = args.get_htmlElement();

    if (!target) return;
    if (target.tagName == "INPUT") {
        target.style.cursor = "hand";
    }

    var grid = isMouseOverGrid(target)
    if (grid) {
        grid.style.cursor = "hand";
    }
}

function droppedOnGrid(args) {
    var target = args.get_htmlElement();
    while (target) {
        if (target.id != null && target.id.indexOf(gridId + "_ctl00__") == 0) {
            args.set_htmlElement(target);
            return;
        }

        target = target.parentNode;
    }
    args.set_cancel(true);
}

function onNodeDropping(sender, args) {
    if (droppedOnGrid(args)) return;
}


function OpenDelegateReplaceUserPopup() {
    var tree = $find($("[id$=rtvUsers]")[0].id);
    var userId;
    var userName;
    if (tree.get_selectedNode() == null) {
        userId = 0;
    }
    else {
        userId = tree.get_selectedNode().get_value();
    }
    return OpenPOPUp("WorkflowDelegateReplaceUserPopup.aspx?Id=" + userId + "&FromSettings=0", 1355, 500,true,null);
}

function DeleteSelectedUserDelegations() {
    var grid = $find("rdgDelegates");
    if (grid.get_masterTableView().get_selectedItems().length > 0) {
        return ConfirmDelete();
    }
    return false;
}

function ddlEntities_DropDownTextChange(sender, args) {
    if (sender.get_value() == '') {
        args.set_cancel(true);
    }
}

function RowDblClick(sender, eventArgs) {
    var btnEditSelected = $("a[id*=" + sender.ClientID + "][id$=btnEditSelected]")[0];
    var btnUpdateEdited = $("a[id*=" + sender.ClientID + "][id$=btnUpdateEdited]")[0];

    if (btnEditSelected) { eval(btnEditSelected.href.split(":")[1]); }
    else if (btnUpdateEdited) { eval(btnUpdateEdited.href.split(":")[1]); }
}

function rgdDelegates_RowSelected(sender, args) {
    var grid = $find($("[id$=rdgDelegates]")[0].id);
    var EndDate = '';
    var btnDelete = $("[id*=" + sender.get_id() + "][id$=btnDelete]");
    var btnAcivate = $("[id*=" + sender.get_id() + "][id$=btnActivate]");
    var btnDeactivate = $("[id*=" + sender.get_id() + "][id$=btnDeactivate]");
    var btnEdit = $("[id*=" + sender.get_id() + "][id$=btnEditSelected]");
    var HideDelete = false;
    var HidebtnDeactivate = false;
    var HideEdit = false;
    var selectedRows = 0;
    selectedRows = selectedRows + 1;
    var HidebtnActivate = false;
    for (var i = 0; i < grid.MasterTableView.get_selectedItems().length; i++) {
        
        var row = grid.MasterTableView.get_selectedItems()[i];
        var ActivatedDate = row.getDataKeyValue("ActivatedDate");
        var DeactivatedDate = row.getDataKeyValue("DeactivatedDate");
        var Action = row.getDataKeyValue("Action");

        if (ActivatedDate != '' && DeactivatedDate == '') {
            HideDelete = true;
            HideEdit = true;
        }
        if (Action == 'D'){
            if (DeactivatedDate != '' || ActivatedDate == ''){
                HidebtnDeactivate = true;
            }
        }
        else{HidebtnDeactivate = true;}
    }

    if (selectedRows <= 1) {
        if (ActivatedDate != '' && DeactivatedDate == '') {
            HidebtnActivate = true;
        }
    }

    if (HideDelete)
    {
        btnDelete.hide();
    } 
    else{
        btnDelete.show();
    }

    if (HideEdit) {
        btnEdit.hide();
    }
    else {
        btnEdit.show();
    }

    if (HidebtnActivate)
    {
        btnAcivate.hide();
    }
    else{
        btnAcivate.show();
    }

    if(HidebtnDeactivate)
    {
        btnDeactivate.hide();
    } 
    else{
        btnDeactivate.show();
    }

    }




