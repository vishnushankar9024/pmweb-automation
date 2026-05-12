function BindCheckBoxes() {
    $("input[id$=chkMasterSelect]").click(function () {
        var MasterRow = $(this).parents("tr:first");
        var DetailRow = $(MasterRow).next();
        var checked = this.checked
        DetailRow.find("input[id$=chkDetailSelect]").each(function () {
            if (!this.disabled) {
                this.checked = checked;
            }
        });
    });

    $("input[id$=chkDetailSelect]").click(function () {
        var DetailRow = $(this).parents("table:first").parents("tr:first");
        var MasterRow = $(DetailRow).prev();

        try {
            if (!$(this).is(':checked')) { MasterRow.find("input[id$=chkMasterSelect]").attr('checked', false); }
            else {
                DetailRow.find("input[id$=chkDetailSelect]").each(function () {
                    if (!$(this).is(':checked') && !$(this).is(':disabled')) {
                        MasterRow.find("input[id$=chkMasterSelect]").attr('checked', false);
                        throw true;
                    }
                }); /* End foreach */
                MasterRow.find("input[id$=chkMasterSelect]").attr('checked', true);
            }
        }
        catch (e) { /*error throw true just to break the each itiration*/ }
    });
}