/// <reference path="../jQuery-vsdoc.js" />
$(document).ready(function() {
$("a[id$=lbtClose]").click(function() { CloseRadWnd(); return false; });
});

function BindCheckBoxes() {
    $("input[id$=chkMasterSelect]").click(function() {
        var MasterRow = $(this).parents("tr:first");
        var DetailRow = $(MasterRow).next();
        DetailRow.find("input[id$=chkDetailSelect]").attr('checked', $(this).is(':checked'));
    });

    $("input[id$=chkDetailSelect]").click(function() {
        var DetailRow = $(this).parents("table:first").parents("tr:first");
        var MasterRow = $(DetailRow).prev();

        try {
            if (!$(this).is(':checked')) { MasterRow.find("input[id$=chkMasterSelect]").attr('checked', false); }
            else {
                DetailRow.find("input[id$=chkDetailSelect]").each(function() {
                    if (!$(this).is(':checked')) {
                        MasterRow.find("input[id$=chkMasterSelect]").attr('checked', false);
                        throw true;
                    }
                });/* End foreach */
                MasterRow.find("input[id$=chkMasterSelect]").attr('checked', true);
            }
        }
        catch (e) { /*error throw true just to break the each itiration*/ }
    });
}