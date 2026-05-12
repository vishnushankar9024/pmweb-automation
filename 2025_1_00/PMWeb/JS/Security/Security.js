//function Groups(value, text, isDefault, isGuest) {
//    this.value = value;
//    this.text = text;
//    this.isDefault = isDefault;
//    this.isGuest = isGuest;
//}
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
var UserAccess_UsersId = "ctl00_CPH1_UserEntities_rdvUsers";
//var UserAccess_EntitiesId = "ctl00_CPH1_UserEntities_rdvEntities";

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
}


/******************/

/*** Entity Access ***/
var EntityAccess_EntitiesId = "ctl00_CPH1_EntityUsers_rdvEntities";

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


function GetValueToReturn(combobox, eventArgs) {
    if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
        eventArgs.set_cancel(true);
    } else {
        eventArgs.set_cancel(false);
    }
    var ddlLicenseTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLicenseTypes');
    SelectedValue = ddlLicenseTypes.get_value();
    var context = eventArgs.get_context();
    context["FilterString"] = SelectedValue;
}

function ResetCombos(combobox, eventArgs) {
    var ddlGroups = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlGroups');
    ddlGroups.clearItems();
    ddlGroups.set_text("");
    ddlGroups.set_value("0");

    var ddlIsNamedLic = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlIsNamedLic');
    ddlIsNamedLic.clearItems();
    ddlIsNamedLic.set_text("");
    ddlIsNamedLic.set_value("0");

    var rfvIsNamedLic = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_rfvIsNamedLic');
    var rfvGroups = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_rfvGroups');
    if (combobox.get_value() == '3') {
        ValidatorEnable(rfvGroups, false);
        ValidatorEnable(rfvIsNamedLic, false);
    } else {
        ValidatorEnable(rfvGroups, true);
        ValidatorEnable(rfvIsNamedLic, true);
    }

    var chkCanUseActivityBoards = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_chkCanUseActivityBoards');
    if (combobox.get_value() === "3") {
        chkCanUseActivityBoards.disabled = true;
        chkCanUseActivityBoards.checked = false;
    }
    else {
        chkCanUseActivityBoards.disabled = false;
    }
}

function ddlLicenseTypesLoad(combobox, eventArgs) {
    var rfvIsNamedLic = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_rfvIsNamedLic');
    var rfvGroups = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_rfvGroups');
    if (combobox.get_value() == '3') {
        ValidatorEnable(rfvGroups, false);
        ValidatorEnable(rfvIsNamedLic, false);
    } else {
        ValidatorEnable(rfvGroups, true);
        ValidatorEnable(rfvIsNamedLic, true);
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

function CheckParentRight(imgAllId, CheckedUrl, UncheckedUrl) {
    var imgAll = document.getElementById(imgAllId);
    imgAll.src = (imgAll.ImageChecked == "Checked") ? CheckedUrl : UncheckedUrl;
}

function CheckRight(chkId, parentId, CheckedUrl, UncheckedUrl, UnknowUrl) {
    var chk = $("#" + chkId);
    var tr = chk.parents("tr:first");

//    var chkCanRead = $(tr.find("input[id $= 'chkCanRead']")[0]);
//    var chkFullControl = $(tr.find("input[id $= 'chkFullControl']")[0]);
//    var chkCanAdd = $(tr.find("input[id $= 'chkCanAdd']")[0]);
//    var chkCanEdit = $(tr.find("input[id $= 'chkCanEdit']")[0]);
//    var chkCanDelete = $(tr.find("input[id $= 'chkCanDelete']")[0]);


    var chkFullControl = $(tr.find("input[id $= 'chkFullControl']")[0]);
    var chkCanRead = $(tr.find("input[id $= 'chkCanRead']")[0]);
    var chkCanAdd = $(tr.find("input[id $= 'chkCanAdd']")[0]);
    var chkCanEdit = $(tr.find("input[id $= 'chkCanEdit']")[0]);
    var chkCanDelete = $(tr.find("input[id $= 'chkCanDelete']")[0]);

    var hdnUniqueName = $(tr.find("input[id$=hdnUniqueName]")[0]);
//    if (hdnUniqueName.val() == "Scheduling_Page_Schedules") {
//        //        chkFullControl.trigger('click');

//        if (chkCanAdd.attr("id") != chk.attr("id") && chkCanAdd.is(':checked') != chk.is(':checked')) chkCanAdd.trigger('click');
//        if (chkCanEdit.attr("id") != chk.attr("id") && chkCanEdit.is(':checked') != chk.is(':checked')) chkCanEdit.trigger('click');
//        if (chkCanDelete.attr("id") != chk.attr("id") && chkCanDelete.is(':checked') != chk.is(':checked')) chkCanDelete.trigger('click');

//    }
    if (chkCanRead.is(':checked') && chkCanAdd.is(':checked') && chkCanEdit.is(':checked') && chkCanDelete.is(':checked')) {
        if (!chkFullControl.is(':checked'))
            chkFullControl.trigger('click');
    } else {
        if (!chk.is(':checked') && chkFullControl.is(':checked'))
        //        chk[0].checked = false;
            chkFullControl.trigger('click');
    }

    var rdgRights = $("div[id$='rdgRights']");

    var isAllChecked = chk.is(':checked');
    var isAllNotChecked = !chk.is(':checked');
    try {
        rdgRights.find("input[type='checkbox'][parentId='" + parentId + "']").each(function() {
            if (chk.is(':checked')) {
                if (!isAllChecked) throw true;
                isAllChecked = this.checked;
            } else {
                if (!isAllNotChecked) throw true;
                isAllNotChecked = !this.checked;
            }
        });
    }
    catch (e) { }

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

    if (chk.is(':checked') && !chkCanRead.is(':checked')) {
        chkCanRead.trigger('click');
    }

}

function CheckFullControlRight(chkFullControlId, parentId, CheckedUrl, UncheckedUrl, UnknowUrl) {
    var chkFullControl = $("#" + chkFullControlId);
    var tr = chkFullControl.parents("tr:first");

    var rdgRights = $("div[id$='rdgRights']");

//    alert("rdgRights======" + rdgRights)
//    alert("SubModules=====" + SubModules)
//    alert(rdgRights.find("input[type='checkbox'][parentId='" + parentId + "']"))
//    alert(SubModules.find("input[type='checkbox'][parentId='" + parentId + "']"))

    var isAllChecked = chkFullControl.is(':checked');
    var isAllNotChecked = !chkFullControl.is(':checked');
    try {
        rdgRights.find("input[type='checkbox'][parentId='" + parentId + "']").each(function() {
        if (chkFullControl.is(':checked')) {
                if (!isAllChecked) throw true;
                isAllChecked = this.checked;
            } else {
                if (!isAllNotChecked) throw true;
                isAllNotChecked = !this.checked;
            }
        });
        
    }
    catch (e) { }

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

    var chkCanRead = $(tr.find("input[id $= 'chkCanRead']")[0]);
    var chkCanAdd = $(tr.find("input[id $= 'chkCanAdd']")[0]);
    var chkCanEdit = $(tr.find("input[id $= 'chkCanEdit']")[0]);
    var chkCanDelete = $(tr.find("input[id $= 'chkCanDelete']")[0]);
    

    if (chkFullControl.is(':checked')) {
        if (!chkCanRead.is(':checked')) chkCanRead.trigger('click');
        if (!chkCanAdd.is(':checked')) chkCanAdd.trigger('click');
        if (!chkCanEdit.is(':checked')) chkCanEdit.trigger('click');
        if (!chkCanDelete.is(':checked')) chkCanDelete.trigger('click');
        
    } else if (chkCanRead.is(':checked') && chkCanAdd.is(':checked') && chkCanEdit.is(':checked') && chkCanDelete.is(':checked')) {
        chkCanRead.trigger('click');
    } 

}


function CheckViewRight(chkCanReadId, parentId, CheckedUrl, UncheckedUrl, UnknowUrl) {
    var chkCanRead = $("#" + chkCanReadId);
    var tr = chkCanRead.parents("tr:first");
    var chkFullControl = $(tr.find("input[id $= 'chkFullControl']")[0]);
    if (chkFullControl.attr('disabled') == 'disabled') {
        return;
    }
    var chkCanAdd = $(tr.find("input[id $= 'chkCanAdd']")[0]);
    var chkCanEdit = $(tr.find("input[id $= 'chkCanEdit']")[0]);
    var chkCanDelete = $(tr.find("input[id $= 'chkCanDelete']")[0]);

    var rdgRights = $("div[id$='rdgRights']");

    var isAllChecked = chkCanRead.is(':checked');
    var isAllNotChecked = !chkCanRead.is(':checked');
    try {
        rdgRights.find("input[type='checkbox'][parentId='" + parentId + "']").each(function() {
        if (chkCanRead.is(':checked')) {
                if (!isAllChecked) throw true;
                isAllChecked = this.checked;
            } else {
                if (!isAllNotChecked) throw true;
                isAllNotChecked = !this.checked;
            }
        });
    }
    catch (e) { }
    
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
    if (chkCanRead.is(':checked')) {
        if (chkCanAdd.is(':checked') && chkCanEdit.is(':checked') && chkCanDelete.is(':checked')){
            if (!chkFullControl.is(':checked')) chkFullControl.trigger('click');
        }
    } else {
        if (chkFullControl.is(':checked')) chkFullControl.trigger('click');
        if (chkCanAdd.is(':checked')) chkCanAdd.trigger('click');
        if (chkCanEdit.is(':checked')) chkCanEdit.trigger('click');
        if (chkCanDelete.is(':checked')) chkCanDelete.trigger('click');
    }

}

function CheckChildrenRights(imgAllId, CheckedUrl, UncheckedUrl) {
    var imgAll = document.getElementById(imgAllId);
    var isChecked = (imgAll.ImageChecked == "Checked") ? true : false;
    var rdgRights = $("div[id$='rdgRights']");
    rdgRights.find("input[type='checkbox'][parentId='" + imgAllId + "']").each(function() {
        if (this.checked != isChecked) {
            $(this).trigger('click');
        }
    });

}

function ddlContact_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents("tr:first");
    var ddlCompanies = $find(tr.find("[id$='ddlCompanies']")[0].id);
    var txtFirstName = tr.find("input[id$='txtFirstName']");
    var txtLastName = tr.find("input[id$='txtLastName']");
    var txtUserId = tr.find("input[id$='txtUserId']");
    var txtEmail = tr.find("input[id$='txtEmail']");
   
    txtFirstName.val(item.get_attributes().getAttribute("FirstName"));
    txtLastName.val(item.get_attributes().getAttribute("LastName"));
    if (txtUserId.val() =="") {
        txtUserId.val(item.get_attributes().getAttribute("UserName"));
    }
    txtEmail.val(item.get_attributes().getAttribute("Email"));
    
    var contactId = parseInt(item.get_value());
    if (contactId > 0) {
        ddlCompanies.clearSelection();
        ddlCompanies.set_enabled(false);
        txtFirstName.attr("readOnly", "true");
        txtLastName.attr("readOnly", "true");
//        txtEmail.attr("readOnly", "true");
    } else {
        if (contactId == 0) {
            return OpenContactsPopup(452, 280);
        }
        ddlCompanies.set_enabled(true);
        txtFirstName.removeAttr("readOnly");
        txtLastName.removeAttr("readOnly");
//        txtEmail.removeAttr("readOnly");
    }
}

var Guest_HasFullAccessTo;
var Guest_HasEditAccessTo;



function pageLoad() {
    Guest_HasFullAccessTo = guestFullAccessPageIds.split(";");
    Guest_HasEditAccessTo = guestEditAccessPageIds.split(";");
    var a = document.createElement("a");
    var img = document.createElement("img");
    var hdnExpandAll = document.getElementById("ctl00_CPH1_Groups_hdnExpandAll");
    img.id = "ExpandImg";
    if (hdnExpandAll != null) {
        if (hdnExpandAll.value == 'False')
            img.src = "Images/Workflow/wPlus.png";
        else
            img.src = "Images/Workflow/wMinus.png"
    }
    a.appendChild(img);
    a.title = "Expand/CollapseAll";
    a.setAttribute("onclick", "ExpandCollapseAll();");
    var th = document.getElementsByTagName("th");
    for (var i = 0,j=th.length; i < j - 1 ; i++) {
        if(th[i].className.indexOf('rgGroupCol') > -1){
            th[i].appendChild(a);
            break;
        }
    }
}


function ExpandCollapseAll() {
    __doPostBack('btnExpand', '');
}


function include(arr, obj) {
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] == obj) return true;
    }
    return false;
}

function chkIsGuest_Click(chkIsGuest) {
    
    if (!chkIsGuest) {
        return;
    }
    var rdgRights = $("div[id$='rdgRights']");
    if (chkIsGuest.checked) {
        rdgRights.find("input[id$='imgFullControlAll']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
            if (hdnModuleKey.val() != "ProjectManagement") {
                var me = $(this);
                me.attr("ImageChecked", "Unchecked");
                me.attr("src", "Images/Global/Outlook_Unchecked.PNG");
                me.attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='imgCanAddAll']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
            if (hdnModuleKey.val() != "ProjectManagement") {
                var me = $(this);
                me.attr("ImageChecked", "Unchecked");
                me.attr("src", "Images/Global/Outlook_Unchecked.PNG");
                me.attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='imgCanEditAll']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
            if (hdnModuleKey.val() != "ProjectManagement") {
                var me = $(this);
                me.attr("ImageChecked", "Unchecked");
                me.attr("src", "Images/Global/Outlook_Unchecked.PNG");
                me.attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='imgCanDeleteAll']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
            if (hdnModuleKey.val() != "ProjectManagement") {
                var me = $(this);
                me.attr("ImageChecked", "Unchecked");
                me.attr("src", "Images/Global/Outlook_Unchecked.PNG");
                me.attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='chkFullControl']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
            var hdnPageId = $(tr.find("input[id$=hdnMenuItemId]")[0]).val();
            
            if ((hdnModuleKey.val() != "ProjectManagement") && (!(include (Guest_HasFullAccessTo,hdnPageId)))) {
                this.checked = false;
                $(this).attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='chkCanAdd']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
              var hdnPageId = $(tr.find("input[id$=hdnMenuItemId]")[0]).val();
              if ((hdnModuleKey.val() != "ProjectManagement") && (!(include(Guest_HasFullAccessTo, hdnPageId)))) {
                this.checked = false;
                $(this).attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='chkCanEdit']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
              var hdnPageId = $(tr.find("input[id$=hdnMenuItemId]")[0]).val();
              if ((hdnModuleKey.val() != "ProjectManagement") && (!(include(Guest_HasFullAccessTo, hdnPageId))) && (!(include(Guest_HasEditAccessTo , hdnPageId)))) {
                this.checked = false;
                $(this).attr('disabled', 'disabled');
            }
        });

        rdgRights.find("input[id$='chkCanDelete']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnModuleKey]")[0]);
              var hdnPageId = $(tr.find("input[id$=hdnMenuItemId]")[0]).val();
              if ((hdnModuleKey.val() != "ProjectManagement") && (!(include(Guest_HasFullAccessTo, hdnPageId)))) {
                this.checked = false;
                $(this).attr('disabled', 'disabled');
            }
        });

        var gvMiscellaneousPermission = $("div[id$='rdgMiscellaneousPermission']");
        gvMiscellaneousPermission.find("input[id$='chkMiscellaneousPermission']").each(function() {
            var tr = $(this).parents("tr:first");
            var hdnModuleKey = $(tr.find("input[id$=hdnMiscellaneousKey]")[0]).val();
            if (hdnModuleKey != "CanSendNotifications" & hdnModuleKey != "IsGuest" & hdnModuleKey != "IsDefault") {
                $(this).attr('disabled', 'disabled');
                this.checked = false;
            }

        });
        
    } else {

        var rdgRights = $("div[id$='rdgRights']");
        rdgRights.find("input[id$='imgFullControlAll']").removeAttr('disabled');
        rdgRights.find("input[id$='imgCanAddAll']").removeAttr('disabled');
        rdgRights.find("input[id$='imgCanEditAll']").removeAttr('disabled');
        rdgRights.find("input[id$='imgCanDeleteAll']").removeAttr('disabled');

        rdgRights.find("input[id$='chkFullControl']").removeAttr('disabled');
        rdgRights.find("input[id$='chkCanAdd']").removeAttr('disabled');
        rdgRights.find("input[id$='chkCanEdit']").removeAttr('disabled');
        rdgRights.find("input[id$='chkCanDelete']").removeAttr('disabled');

        var gvMiscellaneousPermission = $("div[id$='rdgMiscellaneousPermission']");
        gvMiscellaneousPermission.find("input[id$='chkMiscellaneousPermission']").removeAttr('disabled');
        
    }
}

function DeleteUserErrorConfirm(msg) {
    if (confirm(msg)) {
        __doPostBack('ctl00$CPH1$Users$rdgUsers$ctl00$ctl02$ctl00$btnInactive', '');
//        var rdgUsers = $("div[id$='rdgUsers']");
//        alert(rdgUsers.find("[id $= 'btnInactive']").length);
        //        rdgUsers.find("[id $= 'btnInactive']").click();
        
    } else {
    return false;
    }
}


//function pageLoad() {
//    CheckParentBox();
//}

function AllCheckClicked(me) {
    var i = 0;
    var rdgRights = $("div[id$='rdgMiscellaneousPermission']");
    var parentcheck = me.checked;
    rdgRights.find("input[type='checkbox']").each(function () {
        if (i > 0) {
            if (!this.disabled)
                if (this.id.indexOf('chkMiscellaneousPermission') > 0) {
                    if (i != 2) 
                        //this.checked = !me.checked;
                        //this.click();
                        this.checked = me.checked;
                }
        }
        i++;
    });
}

function SelectParent(chk) {
    var rdgRights = $("div[id$='rdgMiscellaneousPermission']");
    var chkPArent;
    chkPArent = rdgRights.find("input[type='checkbox']")[0];
    var i = 0;
    var isChecked = true;
    rdgRights.find("input[type='checkbox']").each(function () {
        if (i != 0 ) {
            if (chk.checked) {
                if (!this.checked && !this.disabled) {
                    if (this.id.indexOf('chkMiscellaneousPermission') > 0)
                        isChecked = false;
                }
            }
        }
        i++;
    });

    if (!chk.checked) {
        chkPArent.checked = false;

    } else {
        chkPArent.checked = isChecked;
    }

    return false;
}

//function CheckParentBox() {


//    var rdgRights = $("div[id$='rdgManageBids']");
//    var ParentIsNotChecked = true;
//    var PriorIsNotChecked = true;
//    var NotificationIsNotChecked = true;
//    var CopyBidIsNotChecked = true;
//    var i = 0;
//    rdgRights.find("input[type='checkbox']").each(function () {
//        if (i != 0 && i != 2 && i != 1 && i != 3) {
//            if (!this.checked) {
//                if (this.id.indexOf("chkSelect") > 0)
//                    ParentIsNotChecked = false;
//                if (this.id.indexOf("chkLockPriorBids") > 0)
//                    PriorIsNotChecked = false;
//                if (this.id.indexOf("chkSendNotification") > 0)
//                    NotificationIsNotChecked = false;
//                if (this.id.indexOf("chkCopyBid") > 0)
//                    CopyBidIsNotChecked = false;
//            }
//        }
//        i++;
//    });

//    if (!ParentIsNotChecked) {
//        rdgRights.find("input[type='checkbox']")[0].checked = false;
//    } else {
//        if (i > 0) {
//            rdgRights.find("input[type='checkbox']")[0].checked = true;
//        }

//    }
//    if (!PriorIsNotChecked) {
//        rdgRights.find("input[type='checkbox']")[3].checked = false;
//    } else {
//        if (i > 0) {
//            rdgRights.find("input[type='checkbox']")[3].checked = true;
//        }

//    }

//    if (!NotificationIsNotChecked) {
//        rdgRights.find("input[type='checkbox']")[2].checked = false;
//    } else {
//        if (i > 0) {
//            rdgRights.find("input[type='checkbox']")[2].checked = true;
//        }

//    }
//    if (!CopyBidIsNotChecked) {
//        rdgRights.find("input[type='checkbox']")[1].checked = false;
//    } else {
//        if (i > 0) {
//            rdgRights.find("input[type='checkbox']")[1].checked = true;
//        }

//    }

//}




//function SetHeaderSize(gridId) {
//    alert($("[id$=rdgLicenses]").find("th[class*='rgHeader']:first").width());
//    $("[id$=rdgLicenses]").find("th[class*='rgHeader']:first").css("width", "100px");
//    alert($("[id$=rdgLicenses]").find("th[class*='rgHeader']:first").width());
//}


