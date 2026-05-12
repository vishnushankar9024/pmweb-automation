/// <reference path="../jQuery-vsdoc.js" />

function chkProlog_click(e) {
    if (e.checked) {
        $('#ddlPrologUser').show("fast");
    }
    else {
        $('#ddlPrologUser').hide("fast");
    }
} 

function isCheckedById(id) {
    var checked = $("input[@id=" + id + "]:checked").length;
    if (checked == 0) {
        return false;
    }
    else {
        return true;
    }
}

function cvUserCheck(sender, args) {

    args.IsValid = isCheckedById('ctl00_CPH1_UserManagement_chkPMWeb') || isCheckedById('ctl00_CPH1_UserManagement_chkProlog') || isCheckedById('ctl00_CPH1_UserManagement_chkAcitveDirectory');
}