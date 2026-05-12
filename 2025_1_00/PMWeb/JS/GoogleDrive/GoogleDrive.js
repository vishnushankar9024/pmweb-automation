

function OnClientDoubleClick_FillFiles(sender, args) {
    if (args.get_node().get_value() == 1) {
        $("input[id$='txtSearch']")[0].style.display = "none";
    }
    else {
        $("input[id$='txtSearch']")[0].style.display = "inline"
    }
    setTimeout(RefreshGrid, 300);
}

function RefreshGrid() {
    var btnRefreshId = $("a[id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}

function LookupFile_RowDblClick_SelectFile(sender, args) {
    var row = $("#" + args.get_id());

    var DocId = row.find("[id$='lblDocId']").html();
    var filename = row.find("[id$='lblFileName']").html();
    var projectId = row.find("[id$='lblProjectId']").html();

    var AconexUrl = Hostname + '/api/projects/' + projectId + '/register/' + DocId + '?PMWebfilename=' + filename;

    var ctlId = $(window.parent.document).find("input[id$='hdnSelectedElementId']");

    var attachement_row = $(ctlId).parents("tr:first");

    var txtAconex = attachement_row.find("[id$=txtAconex]").val(AconexUrl);

    var filenamewithoutExt = filename.substring(0, filename.lastIndexOf('.'))
    var txtDescription = attachement_row.find("[id$='txtDescription']").val(filenamewithoutExt);

    CloseRadWnd();
}


function pageLoad() {


    $("input[id$='txtSearch']").unbind().keydown(function (event) { searchFiles(event); });
    $("input[id$='btnSearch']").attr("disabled", "");

}

function searchFiles(event) {
    if (event.keyCode == 13) {
        __doPostBack('ctl00$CPH1$btnSearch', '');
        return false;
    }

}