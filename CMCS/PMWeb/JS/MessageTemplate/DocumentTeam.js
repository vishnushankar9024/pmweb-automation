var DocumentTeamfocusId;
var DocumentTeamEditor;

$(function () {
    $(":input").focus(function () { DocumentTeamfocusId = this.id; });
});


function pasteDocTeamTextInEditor(text) {
    DocumentTeamEditor = $find("ctl00_CPH1_CollaborateTemplate1_RadEditor1");
    DocumentTeamEditor.pasteHtml(text);
}


function OnDocTeamClientItemDoubleClicked(sender, eventArgs) {
    if (!DocumentTeamfocusId) { return; }
    var node = eventArgs.get_node();
    var ae = document.activeElement;
    if (node.get_value() == null) { return; }
    if (DocumentTeamfocusId.indexOf('txtSubject') > 0) {
        insertAtCaret(DocumentTeamfocusId, node.get_value());
    }
    else {
        pasteDocTeamTextInEditor(node.get_value());
    }

}


function makeUnselectable(element) {
    var nodes = element.getElementsByTagName("*");
    for (var index = 0; index < nodes.length; index++) {
        var elem = nodes[index];
        elem.setAttribute("unselectable", "on");
    }
}


function DocTeamOnClientNotLoad(DocumentTeamEditor) {
    DocumentTeamEditor.get_contentArea().style.backgroundColor = "white";
    DocumentTeamEditor.get_contentArea().style.backgroundImage = "none";
    var tree = $find("ctl00_CPH1_CollaborateTemplate1_tree");
    makeUnselectable(tree.get_element());
    DocumentTeamEditor = $find("ctl00_CPH1_CollaborateTemplate1_RadEditor1");

    var element = document.all ? DocumentTeamEditor.get_document().body : DocumentTeamEditor.get_document();
    $telerik.addExternalHandler(element, "click", function (e) {
        DocumentTeamfocusId = 'RadEditor1';
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


function AllDocTeamCheckClicked(iObj) {


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


function SelectDocTeamParent(chk) {

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


function CheckDocTeamParentBox() {


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