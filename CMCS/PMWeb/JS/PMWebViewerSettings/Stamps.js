

       var uploadsDocFileInProgress = 0;


function onDocFileSelected(sender, args) {

    //if (uploadsDocFileInProgress == 2) {
    //    $telerik.$(".ruRemove", args.get_row()).click();
    //return;
    //}
    uploadsDocFileInProgress++;

}

function onDocFileUploading(sender, args) { 
    var async =$("[id$=rauStamps]")
    $telerik.$(async[0].getElementsByTagName(".ruCancel")).bind('click', function () {
        decrementUploadsDocFileInProgress();
        args.set_cancel(true)
    });
}

function onDocFileUploaded(sender, args) {
    decrementUploadsDocFileInProgress();
    if (uploadsDocFileInProgress <= 0) {
        var btnRefreshAttributesSelected = $("[id$=btnRefreshAttributesSelected]");
        btnRefreshAttributesSelected.click();
        setTimeout(function () {
            sender.deleteAllFileInputs();
        }, 10);
    }
}

function onDocFileUploadFailed(sender, args) {
    decrementUploadsDocFileInProgress();
}

function decrementUploadsDocFileInProgress() {

    uploadsDocFileInProgress--;
}

function addedDocFile(sender, args) {
    if (document.getElementById('lblUploadOption')) {
        if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
            $("#lblUploadOption").html(lblUploadOptionChFFText);
        } else {
            var senderelement = sender.get_element();
            var inputs = senderelement.getElementsByTagName("span");
            for (var i = 0; i < inputs.length; i++)
            {
                var input = inputs[i]
                if (input.className == "ruButton ruBrowse")
                {
                    $(input).html(lblBrowseIEText)
                }
            }
            var tdUploadOption = $("[id$=tdUploadOption]");
            tdUploadOption[0].style.display = 'none';
        }
    }
}

function ClientDocFileValidationFailed(sender, args) {
    decrementUploadsDocFileInProgress();
    alert(WarningMsg_InvalidFile);
}
      
