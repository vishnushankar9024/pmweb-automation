var ActivityBoardfocusId;
var ActivityBoardeditor;

$(function () {
    $(":input").focus(function () { ActivityBoardfocusId = this.id; });
});



function pasteActivityBoardTextInEditor(text) {
    editor = $find("ctl00_CPH1_ActivityBoardsTemplate1_RadEditor1");
    if (editor != null) {
        editor.pasteHtml(text);
    }
}


function OnActivityBoardClientItemDoubleClicked(sender, eventArgs) {
    if (!ActivityBoardfocusId) { return; }
    var node = eventArgs.get_node();
    var ae = document.activeElement;
    if (node.get_value() == null) { return; }
    if (ActivityBoardfocusId.indexOf('txtSubject') > 0) {
        insertAtText(ActivityBoardfocusId, node.get_value());
    }
    else {
        pasteActivityBoardTextInEditor(node.get_value());
    }

}
function makeUnselectable(element) {
    var nodes = element.getElementsByTagName("*");
    for (var index = 0; index < nodes.length; index++) {
        var elem = nodes[index];
        elem.setAttribute("unselectable", "on");
    }
}

function OnClientActivityBoardLoad(editor) {
    editor.get_contentArea().style.backgroundColor = "white";
    editor.get_contentArea().style.backgroundImage = "none";
    var tree = $find("ctl00_CPH1_ActivityBoardsTemplate1_tree");
    makeUnselectable(tree.get_element());
    editor = $find("ctl00_CPH1_ActivityBoardsTemplate1_RadEditor1");

    var element = document.all ? editor.get_document().body : editor.get_document();
    $telerik.addExternalHandler(element, "click", function (e) {
        ActivityBoardfocusId = 'RadEditor1';
    });
}


function insertAtText(areaId, text) {
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

