/// <reference path="../jQuery-vsdoc.js" />

function WindowClosed(sender, eventArgs) {
    var btnRefreshId = $("a[id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}

function CheckManualFromMarkup(chkManual, txtAmountId) {
    var txtAmount = $($('#' + txtAmountId)[0]);  
    if (txtAmount && chkManual) {
        if (chkManual.checked) {
            txtAmount.removeAttr("readOnly");
        }
        else {
            txtAmount.attr("readOnly", "readOnly");
        }
    }
}



