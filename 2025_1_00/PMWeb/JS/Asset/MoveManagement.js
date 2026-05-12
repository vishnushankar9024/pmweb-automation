var UserAccess_UsersId = "ctl00_CPH1_rdvTargetAssetTree"; //destination Tree Id
var listBoxDragInProgress = false;
function UserAccess_onEntitiesNodeDropping(sender, args) {
    if (droppedOnTarget(args, UserAccess_UsersId)) return;
}

function droppedOnTarget(args, TreeId) {
    var target = args.get_htmlElement();

    while (target) {
        if (target.id == TreeId) {
            args.set_htmlElement(target);
            return;
        }
        target = target.parentNode;
    }
    args.set_cancel(true);
}


function UserAccess_onNodeDragging(sender, args) {
    var target = args.get_htmlElement();
    if (!target) return;
    var tree = isMouseOverTree(target, UserAccess_UsersId)
    if (tree) {
        tree.style.cursor = "hand";
    }
}

function isMouseOverTree(target, TreeId) {
    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id == TreeId) {
        }
        parentNode = parentNode.parentNode;
    }

    return null;
}

function onListBoxDragging(sender, args) {
    var target = args.get_htmlElement();
    if (!target) return;
    var tree = isMouseOverTree(target, UserAccess_UsersId)
    if (tree) {
        tree.style.cursor = "hand";
    }
}

function onListBoxDropping(sender, args) {
    if (droppedOnTarget(args, UserAccess_UsersId)) {
        listBoxDragInProgress = false;
    return; }
}

function onListBoxDragStart(sender, args) {
    listBoxDragInProgress = true;
}

function onTreeViewMouseOver(sender, args) {
    if (listBoxDragInProgress) {
        var node = args.get_node()
     if (node !=null){
         if (node.get_value().indexOf("O") > 0 || node.get_value().indexOf("S") > 0)
          node.select();
     }
        
       
    }
}

function ddlTasks_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $(this).parents("tr:first");
    var txtStart = tr.find("input[id$='txtScheduleStart']");
    var txtFinish = tr.find("input[id$='txtScheduleFinish']");
    txtStart.val(item.get_attributes().getAttribute("Start"));
    txtFinish.val(item.get_attributes().getAttribute("Finish"));
}
