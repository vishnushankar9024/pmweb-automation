var AlertfocusId;
var editor;

$(function () {
    $(":input").focus(function () { AlertfocusId = this.id; });
});

function IsMouseOverEditor(events) {
    var target = (document.all) ? events.srcElement : events.target;
    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id)
            if (parentNode.id == 'ctl00_CPH1_AlertTemplate1_pnlEditor')
                return parentNode;
        parentNode = parentNode.parentNode;
    }
    return null;
}

function MyDropHandler(source, dest, events) {
    document.body.style.cursor = "default";
    alert(IsMouseOverEditor(events));
    if (IsMouseOverEditor(events)) {
    }
}


function AlertpasteTextInEditor(text) {
    editor = $find("ctl00_CPH1_AlertTemplate1_RadEditor1");
    editor.pasteHtml(text);
}

function MyMoveHandler(events) {
    if (!IsMouseOverEditor(events)) {
        document.body.style.cursor = "no-drop";
    }
    else {
        document.body.style.cursor = "hand";
    }
}

function AlertOnClientItemDoubleClicked(sender, eventArgs) {
    if (!AlertfocusId) { return; }
    var node = eventArgs.get_node();
    var ae = document.activeElement;
    if (node.get_value() == null) { return; }
    if (AlertfocusId.indexOf('txtSubject') > 0) {
        insertAtCaret(AlertfocusId, node.get_value());
    }
    else {
        AlertpasteTextInEditor(node.get_value());
    }

}
function makeUnselectable(element) {
    var nodes = element.getElementsByTagName("*");
    for (var index = 0; index < nodes.length; index++) {
        var elem = nodes[index];
        elem.setAttribute("unselectable", "on");
    }
}

function AlertOnClientLoad(editor) {
    editor.get_contentArea().style.backgroundColor = "white";
    editor.get_contentArea().style.backgroundImage = "none";
    var tree = $find("ctl00_CPH1_AlertTemplate1_tree");
    makeUnselectable(tree.get_element());
    editor = $find("ctl00_CPH1_AlertTemplate1_RadEditor1");

    var element = document.all ? editor.get_document().body : editor.get_document();
    $telerik.addExternalHandler(element, "click", function (e) {
        AlertfocusId = 'RadEditor1';
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



function AllAlertCheckClicked(iObj) {


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

function SelectAlertParent(chk) {

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