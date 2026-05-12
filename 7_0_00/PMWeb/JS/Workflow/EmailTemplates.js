

function OnClientLoad(editor) {
    editor.get_contentArea().style.backgroundColor = "white";
    editor.get_contentArea().style.backgroundImage = "none";
    var tree = $find("ctl00_CPH1_tree");
    makeUnselectable(tree.get_element());
    editor = $find("ctl00_CPH1_RadEditor1");

    var element = document.all ? editor.get_document().body : editor.get_document();
    $telerik.addExternalHandler(element, "click", function (e) {
        focusId = 'RadEditor1';
    });
}


function AllAttachmentCheckClicked(iObj) {
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

function SelectAttachmentParent(chk) {
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