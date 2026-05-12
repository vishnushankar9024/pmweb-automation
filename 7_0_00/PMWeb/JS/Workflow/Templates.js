/// <reference path="../jQuery-vsdoc.js" />
var rdtSteps;
var rtvRoles;
var rtvBranchRules;

$(document).ready(function()
{
//    ResizeToScreen();
});
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

function ddlEntities_DropDownTextChange(sender, args) {
    if (sender.get_value() == '') {
        args.set_cancel(true);
    }
}

function OnButtonClicking_Toolbar(sender, args) {
    var comandName = args.get_item().get_commandName();
    if (comandName == "Save") {
        if (!Page_ClientValidate('TemplateValidation')) {
            stop(event);
            args.set_cancel(true);
        }
    }
}

function ResizeToScreen()
{
   if ($.browser.msie){$('#imgWorkflow').css({ 'width': screen.width - 235 });}
     else{$('#imgWorkflow').css({ 'width': screen.width - 235 });}
}

function cvRolesList_validate(sender, args)
{
    try
    {
        $("#" + sender.id).parent("div").find("input[type='checkbox']").each(function()
        { if (this.checked == true) { args.IsValid = true; throw true; } });

        args.IsValid = false;
        $("#" + sender.id).parent("div")[0].scrollTop = 0;
    }
    catch (e) { /*error throw true just to break the each itiration*/ }
}




function ComboCheckBox(comboId) {
    var combo = $find(comboId);
    var items = combo.get_items();
    var text = "";
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function() {
        var item = items.getItem(i);
        if (this.checked) {
            text += item.get_text() + ";";
        }
        i++;
    });

    if (text.length > 0) {
        text = removeLastSemiColon(text.trim());
        combo.set_text(text);
    }
    else {
        combo.set_text("");
    }
}


function StopPropagation(e) {
    var event = event || window.event;
    if (event == null) { return; }

    if (event.stopPropagation) { event.stopPropagation(); }
    else { event.cancelBubble = true; }
}



function Validate_OnNodeClick(sender, eventArgs) {
    var rtvBranchRules = $find("ctl00_CPH1_ucBusinessProcesses_rtvBranchRules");
    var node = eventArgs.get_node();

    if (node.get_value().indexOf("R") == -1) {
        eventArgs.set_cancel(true);
    }
}


function onContextMenuShowing(sender, args) {
    var treeNode = args.get_node();
    treeNode.set_selected(true);
    setMenuItemsState(args.get_menu().get_items(), treeNode);
}

function setMenuItemsState(menuItems, treeNode) {
    var tree = $find(treeNode.get_treeView().get_id());
    var nodes = tree.get_selectedNodes();
    if (nodes.length > 1) {
        for (var i = 0; i < menuItems.get_count(); i++) {
            var menuItem = menuItems.getItem(i);
            menuItem.set_enabled(false);
        }
    }
    else {
        for (var i = 0; i < menuItems.get_count(); i++) {
            var menuItem = menuItems.getItem(i);
            switch (menuItem.get_value()) {
                case "EditBranchRule":
                    menuItem.set_enabled(false);
                    if (nodes[0].get_value().indexOf("R") == 0)
                        menuItem.set_enabled(true);
                    break;
                case "DeleteBranchRule":
                    menuItem.set_enabled(false);
                    if (nodes[0].get_value().indexOf("R") == 0)
                        menuItem.set_enabled(tree.get_element().getAttribute("Edit").toLowerCase() == 'true');
                    break;
                case "AddBranchRule":
                    menuItem.set_enabled(false);
                    if (nodes[0].get_value().indexOf("OT") == 0)
                        menuItem.set_enabled(tree.get_element().getAttribute("Edit").toLowerCase() == 'true');
                    break;
                case "EditRole":
                    menuItem.set_enabled(false);
                    if (nodes[0].get_value() != 0 && nodes[0].get_value().indexOf("S") <0)
                        menuItem.set_enabled(true);
                    break;
                case "AddRole":
                    menuItem.set_enabled(false);
                    if(nodes[0].get_value() ==0)
                        menuItem.set_enabled(tree.get_element().getAttribute("Edit").toLowerCase() == 'true');
                    break;
            }
        }
    }
}

function onClientContextMenuItemClicking(sender, args) {
    var left = (screen.width - 900) / 2;
    var top = (screen.height - 500) / 2;
    var menuItem = args.get_menuItem();
    var treeNode = args.get_node();
    var tree = $find(treeNode.get_treeView().get_id());
    treeNode.set_selected(true);
    menuItem.get_menu().hide();
    var isGrougSelected = false;
    var isItemSelected = false;
    var nodes = tree.get_selectedNodes();
    var Id = args.get_node().get_value();
    if (nodes.length > 1)
        return;
    switch (menuItem.get_value()) {
        case "AddBranchRule":
            OpenPopupToRefreshTree("WorkflowDefineBranchRule.aspx?RecordTypeId=" + Id, 1190, 540);
            break;
        case "EditBranchRule":
            var ParentId = args.get_node().get_parent().get_value();
            OpenPopupToRefreshTree("WorkflowDefineBranchRule.aspx?RuleId=" + Id + "&RecordTypeId=" + ParentId, 1190, 540);
            break;
        //case "AddRole":
        //    OpenPopupToRefreshTree("WorkflowDefineRolePopup.aspx", 400, 280);
        //    break;
        //case "EditRole":
        //    OpenPopupToRefreshTree("WorkflowDefineRolePopup.aspx?Id=" + Id, 400, 280);
            break;
    }
}


function OnClientDropDownClosed(sender, args) {
    var btn = $("[id$=btnAssociate]");
    btn.click();
}


function OnRolesClientDropDownClosed(sender, args) {
    var btn = $("[id$=btnRoles]");
    btn.click();
}


/*********** Drag and Drop ********/
var canDrop = false;

function itemDragging(sender, args) {
    var isChild;
    var dropClue;
    var target = args.get_htmlElement();
    if (!target) return;
    if ((sender == rtvRoles) || (rtvBranchRules == sender)) { dropClue = sender._draggingClue; args._node.set_allowDrop(false); }
    if (sender == rdtSteps) { dropClue = $telerik.findElement(args.get_draggedContainer(), "DropClue"); args.set_canDrop(false); }
    dropClue.className = "dropClue dropDisabled";
    canDrop = false;
    var grid = isMouseOverRdtSteps(target);
    if (grid) {
        dropClue.className = "dropClue dropEnabled";
        canDrop = true;
    }

    return false;

    if ((sender == rtvRoles) || (rtvBranchRules == sender)) {
        dropClue = sender._draggingClue;
        if (!args._node.get_allowDrop()) //trying to drag a parent item onto its own child
        {
            dropClue.className = "dropClue dropDisabled";
            return;
        }
    } else {
        dropClue = $telerik.findElement(args.get_draggedContainer(), "DropClue");
        args.set_dropClueVisible(true);  //drop clue is always visible
        if (!args.get_canDrop()) //trying to drag a parent item onto its own child
        {
            dropClue.className = "dropClue dropDisabled";
            return;
        }
    }
}
function itemDropping(sender, args) {
    
    if (!canDrop) { args.set_cancel(true); return false; }
    if (droppedOnRdtSteps(args)) return false;
}


function findParentItem(element) {
    if (element.tagName.toLowerCase() == "html")
        return null;
    while (!(element.id != "" && typeof element.tagName != "undefined" && element.tagName.toLowerCase() == "tr")) {
        if (element.parentNode == null)
            return null;
        element = element.parentNode;
    }
    return element;
}

function get_isTreeListChild(elem) {
    var isInrdtSteps = $telerik.isDescendant(rdtSteps.get_element(), elem);
    var isInrtvRoles = false; //$telerik.isDescendant(rtvRoles.get_element(), elem);
    var isInrtvBranchRules = false;// $telerik.isDescendant(rtvBranchRules.get_element(), elem);
    if (rdtSteps || rtvRoles || rtvBranchRules) {
        return true;
    } else {
        return false;
    }
}

function get_dropTarget(domEvent) {
    return domEvent.srcElement || domEvent.target;
}



function isMouseOverRdtSteps(target) {
    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id != null && parentNode.id.indexOf("rdtSteps") > 0) {
            return parentNode;
        }
        parentNode = parentNode.parentNode;
    }
    return null;
}

function droppedOnRdtSteps(args) {
    var target = args.get_htmlElement();
    while (target) {
        if (target.id != null && target.id.indexOf("rdtSteps") > 0) {
            args.set_htmlElement(target);
            return;
        }
        target = target.parentNode;
    }
    args.set_cancel(true);
}


function OpenPopupToRefreshTree(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RefreshTree);
    return false;
}

function isMobileScreen() {
    var browserWidth = $telerik.$(window).width();
    if (browserWidth <= MobileScreenWidth)
        return true;
    return false;
}

function RefreshTree(Opener) {
    var btnRefreshTree = $("input[id$=btnRefreshTree]")[0];
    if (btnRefreshTree) { btnRefreshTree.click(); }
}


function OpenPopupToRefreshTreeList(URL, Width, Height) {
    var wnd = window.radopen(URL);
    wnd.setSize(Width, Height);
    wnd.add_close(RefreshTreeList);
    wnd.Center();
    return false;
}



function RefreshTreeList(Opener) {
    eval($("a[id$=lbtRefresh]")[0].href);
}


function OpenSelectUserPopup() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('SelectUserPopup.aspx?&Bidder=0&Source=WorkflowTemplate&ShowRoles=1&IsSingleSelect=0');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}

function AddUsersAndRolesToCC() {

    var btnAddSuperUsers = $("[id$=btnAddSuperUsers]");
    btnAddSuperUsers.click();
}

function RemoveUserBox(argId) {

    var hfdeletedSuperUsers = $("[id$=hfdeletedSuperUsers]")[0];
    hfdeletedSuperUsers.value = argId;
    var btnRemoveSuperUsers = $("[id$=btnRemoveSuperUsers]");
    btnRemoveSuperUsers.click();

}