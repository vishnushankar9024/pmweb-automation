function OnSelectedFileAttachementChanged(row) {
    var rdbFileManager = row.find("input[id$='rdbFileManager']");
    var rdbLink = row.find("input[id$='rdbLink']");
    var rdbWSS = row.find("input[id$='rdbWSS']");
    var rdbUpload = row.find("input[id$='rdbUpload']");

    if ($(rdbFileManager).is(":checked")) {
        row.find('input[id$=txtFileName]').attr("readOnly", "readOnly").show();
        row.find('[id$=btnBrowseFileManager]').show();
        //            row.find('[id$=spFileManager]').show();
        row.find('input[id$=txtLink]').hide();
        row.find('[id$=FileToUpload]').hide();
        var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
        if (isChecked == "0") isChecked = $(chkRotator).is(":checked");
        $(chkRotator).attr("checked", isChecked).removeAttr("disabled");
    }
    else if ($(rdbLink).is(":checked")) {
        row.find('input[id$=txtFileName]').hide();
        row.find('[id$=btnBrowseFileManager]').hide();
        //            row.find('[id$=spFileManager]').hide();
        row.find('input[id$=txtLink]').show();
        row.find('[id$=FileToUpload]').hide();
        var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
        isChecked = $(chkRotator).is(":checked");
        $(chkRotator).attr("checked", false).attr("disabled", "disabled");
    }
    else if ($(rdbWSS).is(":checked")) {
        row.find('input[id$=txtFileName]').hide();
        row.find('[id$=btnBrowseFileManager]').hide();
        //            row.find('[id$=spFileManager]').hide();
        row.find('input[id$=txtLink]').show();
        row.find('[id$=FileToUpload]').hide();
        var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
        isChecked = $(chkRotator).is(":checked");
        $(chkRotator).attr("checked", false).attr("disabled", "disabled");
    }
    else if ($(rdbUpload).is(":checked")) {
        row.find('input[id$=txtFileName]').hide();
        row.find('[id$=btnBrowseFileManager]').hide();
        //            row.find('[id$=spFileManager]').hide();
        row.find('input[id$=txtLink]').hide();
        row.find('[id$=FileToUpload]').show();
        var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
        if (isChecked == "0") isChecked = $(chkRotator).is(":checked");
        $(chkRotator).attr("checked", isChecked).removeAttr("disabled");
    }
    row.find('[id$=FileToUpload]').removeClass("Hide");
    row.find('[id$=txtLink]').removeClass("Hide");
    row.find('[id$=btnBrowseFileManager]').removeClass("Hide");
    row.find('[id$=txtFileName]').removeClass("Hide");

}

function BindFileAttachement() {
    $("input[id$=rdbFileManager]").click(function() { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
    $("input[id$=rdbLink]").click(function() { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
    $("input[id$=rdbWSS]").click(function() { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
    $("input[id$=rdbUpload]").click(function() { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
    $("input[id$='rdbFileManager']").each(function() { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
}

function Validate() {
    var rdbFileManager = $("input[id$='rdbFileManager']");
    var rdbLink = $("input[id$='rdbLink']");
    var rdbWSS = $("input[id$='rdbWSS']");
    var rdbUpload = $("input[id$='rdbUpload']");
   
    if ($(rdbFileManager).is(":checked")) {
      

        if ($('input[id$=txtFileName]').val() == "") {
            $('[id$=lblFileError]').html(Msg_ChooseFile);
            return false;
        }
    }
    else if ($(rdbLink).is(":checked")) {
        if ($('input[id$=txtLink]').val() == "") {
            $('[id$=lblFileError]').html(Msg_InvalidLink);
            return false;
        }
    }
    else if ($(rdbWSS).is(":checked")) {
        if ($('input[id$=txtLink]').val() == "") {
            $('[id$=lblFileError]').html(Msg_InvalidLink);
            return false;
        }
    }
    else if ($(rdbUpload).is(":checked")) {
        if ($('[id$=FileToUploadfile0]').val() == "") {
            $('[id$=lblFileError]').html(Msg_ChooseFile);
            return false;
        }
        return true;
    }
}


function AttachFileForFileManager(me) {
    var row = $(me).parents("tr:first");
    var hdnFileId = row.find("input[id$='hdnFileId']");
    $(hdnFileId).attr("IsWaiting", "true");
    $("input[id$='hdnSelectedElementId']").val($(hdnFileId)[0].id);
    return OpenPOPUp('FilesLookup.aspx?EntityId=' + DocId, 1135, 680, true);
}