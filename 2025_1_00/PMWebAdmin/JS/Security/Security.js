
/*******************************************************************
*
************************** Users-Entities Access *******************
*
********************************************************************/


function onNodeDropping(sender, args) {
    if (droppedOnBlank(sender, args)) return;
}

function isMouseOverTree(target, TreeId) {
    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id == TreeId) {
            return parentNode;
        }
        parentNode = parentNode.parentNode;
    }

    return null;
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


function droppedOnBlank(sender, args) {
    var dest = args.get_destNode();
    var target = args.get_htmlElement();
    if (!dest) {
        return;
    }
    args.set_cancel(true);
}

function onClientContextMenuShowing(sender, args) {
    var treeNode = args.get_node();
    treeNode.set_selected(true);
}

/*** User Access ***/
var UserAccess_UsersId = "ctl00_ContentPlaceHolder1_UserEntities_rdvUsers";
//var UserAccess_EntitiesId = "ctl00_ContentPlaceHolder1_UserEntities_rdvEntities";

function UserAccess_onNodeDragging(sender, args) {
    var target = args.get_htmlElement();
    if (!target) return;
    var tree = isMouseOverTree(target, UserAccess_UsersId)
    if (tree) {
        tree.style.cursor = "hand";
    }
}

function UserAccess_onEntitiesNodeDropping(sender, args) {
    if (droppedOnTarget(args, UserAccess_UsersId)) return;
}

function UserAccess_onEntityNodeDblClicking(sender, args) {
    var node = args.get_node();
    var usersTree = $find(UserAccess_UsersId);
    if (node.get_expanded()) {
        node.collapse();
    }
    else {
        node.expand();
    }
    getSimilarEntityNode(node, usersTree);
}

function getSimilarEntityNode(node, parentNode) {
    var userNodes = parentNode.get_nodes();
    var entityId = node.get_attributes().getAttribute("EntityId");
    var entityTypeId = node.get_attributes().getAttribute("EntityTypeId");
    for (var i = 0; i < userNodes.get_count(); i++) {
        var userNode = userNodes.getNode(i);
        userNode.set_selected(false);
        userNode.set_expanded(false);
        var entityNodes = userNode.get_nodes();
        var isFound = false;
        for (var j = 0; j < entityNodes.get_count(); j++) {
            var entityNode = entityNodes.getNode(j);
            entityNode.set_selected(false);
            if (isFound) {
                continue;
            }
            var userEntityId = entityNode.get_attributes().getAttribute("EntityId");
            var userEntityTypeId = entityNode.get_attributes().getAttribute("EntityTypeId");
            if (userEntityTypeId == entityTypeId && userEntityId == entityId) {
                entityNode.set_selected(true);
                userNode.set_expanded(true);
                isFound = true;
            }
        }

    }
}
function inform(message) {
    message = message.replace(/\\n/g, "\n").replace(/\\t/g, "\t");
    alert(message);
    //alert("The user Chris Wagner is used in the following: \n \t Roles: \n \t LIJ Nurse Station Renovation - Chairman \n \n\r \t Templates: \n \t LIJ Nurse Station Renovation - AIG Template \n");
}


/******************/

/*** Entity Access ***/
var EntityAccess_EntitiesId = "ctl00_ContentPlaceHolder1_EntityUsers_rdvEntities";
//var EntityAccess_UsersId = "ctl00_ContentPlaceHolder1_UserEntities_rdvUsers";

function EntityAccess_onNodeDragging(sender, args) {
    var target = args.get_htmlElement();
    if (!target) return;
    var tree = isMouseOverTree(target, EntityAccess_EntitiesId)
    if (tree) {
        tree.style.cursor = "hand";
    }
}

function EntityAccess_onUsersNodeDropping(sender, args) {
    if (droppedOnTarget(args, EntityAccess_EntitiesId)) return;
}

function EntityAccess_onUserNodeDblClicking(sender, args) {
    var node = args.get_node();
    var entitiesTree = $find(EntityAccess_EntitiesId);
    getSimilarUserNode(node, entitiesTree.get_nodes().getNode(0));
}

function getSimilarUserNode(node, parentNode) {
    var nodes = parentNode.get_nodes();
    parentNode.set_selected(false);
    if (parentNode.get_attributes().getAttribute("EntityId") > 0) {
        parentNode.set_expanded(false);
    } else {
        parentNode.set_expanded(true);
    }
    var userId = node._getData().value;
    for (var i = 0; i < nodes.get_count(); i++) {
        var childNode = nodes.getNode(i);
        if (childNode.get_nodes().get_count() > 0)
            getSimilarUserNode(node, childNode)
        else {
            childNode.set_selected(false);
            childNode.set_expanded(false);
            var userIdAttr = childNode.get_attributes().getAttribute("UserId");
            if (userIdAttr != 0 && userIdAttr == userId) {
                childNode.select();
                var parentNode2 = childNode.get_parent();
                do {
                    parentNode2.expand();
                    parentNode2 = parentNode2.get_parent();
                }
                while (parentNode2.get_element().tagName != "DIV" && parentNode2.get_level() != 0)
            }
        }
    }
}

/******************/
/*******************************************************************
********************************************************************
********************************************************************/


function CheckLicense(ddlLicenses, ddlUsersId, Guest, validatorId) {
    var ddlGroups = document.getElementById(ddlUsersId);
    var validator = document.getElementById(validatorId);
    if (ddlLicenses.options[ddlLicenses.selectedIndex].text == Guest) {
        ddlGroups.selectedIndex = 0;
        ddlGroups.setAttribute("disabled", "disabled");
        ValidatorEnable(validator, false);
    }
    else if (ddlLicenses.selectedIndex != 0) {
        ddlGroups.setAttribute("disabled", "");
        ValidatorEnable(validator, true);
    }
}


function Validate(validatorId, isValid) {
    var validator = document.getElementById(validatorId);
    ValidatorEnable(validator, isValid);
}

function ChangeState(imgAllId) {
    var imgAll = document.getElementById(imgAllId);
    imgAll.ImageChecked = (imgAll.ImageChecked == "Checked") ? "Unchecked" : "Checked";
}

function CheckParentRight(imgCanReadAllId, imgAllId, CheckedUrl, UncheckedUrl) {
    var imgCanReadAll = document.getElementById(imgCanReadAllId);
    var imgAll = document.getElementById(imgAllId);
    if (imgAll.ImageChecked == "Checked") {
        imgCanReadAll.ImageChecked = "Checked";
    }
    imgAll.src = (imgAll.ImageChecked == "Checked") ? CheckedUrl : UncheckedUrl;
    imgCanReadAll.src = (imgCanReadAll.ImageChecked == "Checked") ? CheckedUrl : UncheckedUrl;

}

function CheckRight(chkCanReadId, chkId, parentId, CheckedUrl, UncheckedUrl, UnknowUrl) {
    var chkCanRead = document.getElementById(chkCanReadId);
    var chk = document.getElementById(chkId);
    var tr = $("#" + chkCanReadId).parents("tr:first");

    var isAllChecked = chk.checked;
    var isAllNotChecked = !chk.checked;
    try {
        $("input[type='checkbox'][parentId='" + parentId + "']").each(function() {
            if (chk.checked) {
                if (!isAllChecked) throw true;
                isAllChecked = this.checked;
            } else {
                if (!isAllNotChecked) throw true;
                isAllNotChecked = !this.checked;
            }
        });
    }
    catch (e) { }
        
    /******* Fires the click events of other checkboxes that have same first item id **********/
    var hdnFirstItem = tr.find("input[id$='hdnFirstItemId']")[0];
    var trId = tr[0].id;
    var firstItemValue = hdnFirstItem.value;
    var chkIdSplit = chkId.split("_");
    var chkCommonId = chkIdSplit[chkIdSplit.length - 1];

    var checkBoxes = $("input[type='checkbox'][id$='" + chkCommonId + "']").filter(function() {
        var trOthers = $("#" + this.id).parents("tr:first");
        if (trOthers[0].id == trId) return false;
        var hdnMenuItemtrOthers = trOthers.find("input[id$='hdnMenuItemId']")[0];
        var hdnFirstItemtrOthers = trOthers.find("input[id$='hdnFirstItemId']")[0];
        return ($(hdnFirstItemtrOthers).val() == firstItemValue);
    });

    checkBoxes.each(function() {
        $("#" + this.id).trigger('click');
    });
    /***********************************************/

    var imgAll = document.getElementById(parentId);
    if (isAllChecked) {
        imgAll.src = CheckedUrl;
        imgAll.ImageChecked = "Checked";
    } else if (isAllNotChecked) {
        imgAll.src = UncheckedUrl;
        imgAll.ImageChecked = "Unchecked";
    } else {
        imgAll.src = UnknowUrl;
        imgAll.ImageChecked = "Unchecked";
    }

    if (chk.checked && !chkCanRead.checked) {
        $("#" + chkCanReadId).trigger('click');
    }

}

function CheckParentViewRight(imgCanReadAllId, imgCanAddAllId, imgCanDeleteAllId, imgCanEditAllId, CheckedUrl, UncheckedUrl) {
    var imgCanReadAll = document.getElementById(imgCanReadAllId);
    var imgCanAddAll = document.getElementById(imgCanAddAllId);
    var imgCanEditAll = document.getElementById(imgCanEditAllId);
    var imgCanDeleteAll = document.getElementById(imgCanDeleteAllId);

    if (imgCanReadAll.ImageChecked == "Unchecked") {
        imgCanAddAll.ImageChecked = "Unchecked";
        imgCanEditAll.ImageChecked = "Unchecked";
        imgCanDeleteAll.ImageChecked = "Unchecked";
    }
    imgCanReadAll.src = (imgCanReadAll.ImageChecked == "Checked") ? CheckedUrl : UncheckedUrl;
    if (imgCanAddAll.ImageChecked == "Checked") imgCanAddAll.src = CheckedUrl;
    if (imgCanEditAll.ImageChecked == "Checked") imgCanEditAll.src = CheckedUrl;
    if (imgCanDeleteAll.ImageChecked == "Checked") imgCanDeleteAll.src = CheckedUrl;


}

function CheckViewRight(chkCanReadId, chkCanAddId, chkCanDeleteId, chkCanEditId, parentId, CheckedUrl, UncheckedUrl, UnknowUrl) {
    var chkCanRead = document.getElementById(chkCanReadId);
    var chkCanAdd = document.getElementById(chkCanAddId);
    var chkCanEdit = document.getElementById(chkCanEditId);
    var chkCanDelete = document.getElementById(chkCanDeleteId);
    var tr = $("#" + chkCanReadId).parents("tr:first");

    var isAllChecked = chkCanRead.checked;
    var isAllNotChecked = !chkCanRead.checked;
    try {
        $("input[type='checkbox'][parentId='" + parentId + "']").each(function() {
            if (chkCanRead.checked) {
                if (!isAllChecked) throw true;
                isAllChecked = this.checked;
            } else {
                if (!isAllNotChecked) throw true;
                isAllNotChecked = !this.checked;
            }
        });
    }
    catch (e) { }

    /******* Fires the click events of other checkboxes that have same first item id **********/
    var hdnFirstItem = tr.find("input[id$='hdnFirstItemId']")[0];
    var trId = tr[0].id;
    var firstItemValue = hdnFirstItem.value;
    var chkIdSplit = chkCanReadId.split("_");
    var chkCommonId = chkIdSplit[chkIdSplit.length - 1];

    var checkBoxes = $("input[type='checkbox'][id$='" + chkCommonId + "']").filter(function() {
        var trOthers = $("#" + this.id).parents("tr:first");
        if (trOthers[0].id == trId) return false;
        var hdnMenuItemtrOthers = trOthers.find("input[id$='hdnMenuItemId']")[0];
        var hdnFirstItemtrOthers = trOthers.find("input[id$='hdnFirstItemId']")[0];
        return ($(hdnFirstItemtrOthers).val() == firstItemValue);
    });

    checkBoxes.each(function() {
        $("#" + this.id).trigger('click');
    });
    /***********************************************/
    
    var imgAll = document.getElementById(parentId);
    if (isAllChecked) {
        imgAll.src = CheckedUrl;
        imgAll.ImageChecked = "Checked";
    } else if (isAllNotChecked) {
        imgAll.src = UncheckedUrl;
        imgAll.ImageChecked = "Unchecked";
    } else {
        imgAll.src = UnknowUrl;
        imgAll.ImageChecked = "Unchecked";
    }
    if (!chkCanRead.checked) {
        if (chkCanAdd.checked) $("#" + chkCanAddId).trigger('click');
        if (chkCanEdit.checked) $("#" + chkCanEditId).trigger('click');
        if (chkCanDelete.checked) $("#" + chkCanDeleteId).trigger('click');
    }

}

function CheckChildrenRights(imgAllId, CheckedUrl, UncheckedUrl) {
    var imgAll = document.getElementById(imgAllId);
    var isChecked = (imgAll.ImageChecked == "Checked") ? true : false;
    $("input[type='checkbox'][parentId='" + imgAllId + "']").each(function() {
        if (this.checked != isChecked) {
            $("#" + this.id).trigger('click');
        }
        this.checked = isChecked;
    });

}


function GroupsClick(sender, eventArgs) {
    var btnEditSelected = $("a[id$=btnEditSelected]")[0];
    var btnUpdateEdited = $("a[id$=btnUpdateEdited]")[0];

    if (btnEditSelected) { eval(btnEditSelected.href.split(":")[1]); }
    else if (btnUpdateEdited) { eval(btnUpdateEdited.href.split(":")[1]); }
}