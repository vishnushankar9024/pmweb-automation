var NotificationfocusId;
var Notificationeditor;

$(function () {
    $(":input").focus(function () { NotificationfocusId = this.id; });
});


function pasteNotTextInEditor(text) {
    Notificationeditor = $find("ctl00_CPH1_NotificationTemplate1_RadEditor1");
    Notificationeditor.pasteHtml(text);
}


function OnNotClientItemDoubleClicked(sender, eventArgs) {
    if (!NotificationfocusId) { return; }
    var node = eventArgs.get_node();
    var ae = document.activeElement;
    if (node.get_value() == null) { return; }
    if (NotificationfocusId.indexOf('txtSubject') > 0) {
        insertAtCaret(NotificationfocusId, node.get_value());
    }
    else {
        pasteNotTextInEditor(node.get_value());
    }

}
function makeUnselectable(element) {
    var nodes = element.getElementsByTagName("*");
    for (var index = 0; index < nodes.length; index++) {
        var elem = nodes[index];
        elem.setAttribute("unselectable", "on");
    }
}

function OnClientNotLoad(Notificationeditor) {
    Notificationeditor.get_contentArea().style.backgroundColor = "white";
    Notificationeditor.get_contentArea().style.backgroundImage = "none";
    var tree = $find("ctl00_CPH1_NotificationTemplate1_tree");
    makeUnselectable(tree.get_element());
    Notificationeditor = $find("ctl00_CPH1_NotificationTemplate1_RadEditor1");

    var element = document.all ? Notificationeditor.get_document().body : Notificationeditor.get_document();
    $telerik.addExternalHandler(element, "click", function (e) {
        NotificationfocusId = 'RadEditor1';
    });
}


function insertAtCaret(areaId, text) {
    var txtarea = document.getElementById(areaId);
    var scrollPos = txtarea.scrollTop;
    var strPos = 0;
    var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
        "ff" : (document.selection ? "ie" : false));
    if (br == "ie") {
        txtarea.focus();
        var range = document.selection.createRange();
        range.moveStart('character', -txtarea.value.length);
        strPos = range.text.length;
    }
    else if (br == "ff") strPos = txtarea.selectionStart;

    var front = (txtarea.value).substring(0, strPos);
    var back = (txtarea.value).substring(strPos, txtarea.value.length);
    txtarea.value = front + text + back;
    strPos = strPos + text.length;
    if (br == "ie") {
        txtarea.focus();
        var range = document.selection.createRange();
        range.moveStart('character', -txtarea.value.length);
        range.moveStart('character', strPos);
        range.moveEnd('character', 0);
        range.select();
    }
    else if (br == "ff") {
        txtarea.selectionStart = strPos;
        txtarea.selectionEnd = strPos;
        txtarea.focus();
    }
    txtarea.scrollTop = scrollPos;
}

function AllNotificationCheckClicked(iObj) {


    var i = 0;
    var rdgRights = $("div[id$='rdgAttachToEmail']");
    var j = 0;
    var k = 0;
    rdgRights.find("input[type='checkbox']").each(function () {
        if (i > 0) {
            if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                if (!this.checked)
                    j = j + 1;
                if (this.checked)
                    k = k + 1;
                this.checked = iObj.checked;
            }

        }
        i++;
    });

}

function SelectNotificationParent(chk) {

    var rdgRights = $("div[id$='rdgAttachToEmail']");
    var chkPArent = rdgRights.find("input[type='checkbox']")[0];

    var i = 0;
    var isChecked = true;
    rdgRights.find("input[type='checkbox']").each(function () {
        if (i > 0) {
            if (chk.checked) {
                if (!this.disabled && !this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
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

function CheckNotificationParentBox() {


    var rdgRights = $("div[id$='rdgAttachToEmail']");
    if (rdgRights.find("input[type='checkbox']")[0] == null) return;
    var ParentIsNotChecked = true;
    var i = 0;
    var d = 1;
    var c = 1;
    rdgRights.find("input[type='checkbox']").each(function () {
        if (i > 0) {
            if (!this.disabled && !this.checked) {
                if (this.id.indexOf("chkSelect") > 0)
                    ParentIsNotChecked = false;
            }
            if (this.disabled) {
                d = d + 1;
            }
            if (this.id.indexOf("chkSelect") > 0) {

                c = c + 1;
            }

        }
        i++;
    });

    if (d == c) {
        ParentIsNotChecked = false;

    }

    if (!ParentIsNotChecked) {
        rdgRights.find("input[type='checkbox']")[0].checked = false;

    } else {
        if (i > 0) {
            rdgRights.find("input[type='checkbox']")[0].checked = true;
        }

    }
}