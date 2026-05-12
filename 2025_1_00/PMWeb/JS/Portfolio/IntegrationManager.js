var gridId = "ctl00_CPH1_IntegrationManagerProjects1_RadListBox1";
function isMouseOverGrid(target) {
    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id == gridId) {
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

    var grid = isMouseOverGrid(target);
    if (grid) {
        grid.style.cursor = "hand";
    }
}


function droppedOnGrid(args) {
    var target = args.get_htmlElement();

    while (target) {
        if (target.id == gridId) {
            args.set_htmlElement(target);
            return;
        }
        target = target.parentNode;
    }
    args.set_cancel(true);
}


function droppedOutGrid(args) {
    var target = args.get_htmlElement();

    while (target) {
        if (target.id != gridId) {
            args.set_cancel(false);
            return;
        }
        target = target.parentNode;
    }
    args.set_cancel(true);
}



function onNodeDropping(sender, args) {
    if (droppedOnGrid(args)) return;
}


function OnClientDroppingHandler(sender, eventArgs) {

    if (droppedOutGrid(eventArgs)) return;


}
function EnableDisableCredential(sender, args) {
    var txtWebServiceUser = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkInUseCredential')) + '_txtInUser' + "]")[0];
    var txtWebServicePass = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkInUseCredential')) + '_txtInPassword' + "]")[0];
    var chkUseCredential = $("[id$=" + sender.id + "]")[0];
    txtWebServiceUser.disabled = !(chkUseCredential.checked);
    txtWebServicePass.disabled = !(chkUseCredential.checked);
}
function EnableDisableOutCredential(sender, args) {
    var txtWebServiceUser = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkOutUseCredential')) + '_txtOutUser' + "]")[0];
    var txtWebServicePass = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkOutUseCredential')) + '_txtOutPassword' + "]")[0];
    var chkUseCredential = $("[id$=" + sender.id + "]")[0];
    txtWebServiceUser.disabled = !(chkUseCredential.checked);
    txtWebServicePass.disabled = !(chkUseCredential.checked);
}