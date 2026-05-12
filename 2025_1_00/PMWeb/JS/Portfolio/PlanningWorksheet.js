var OldYearVal = 0;
function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    
    // On change Year Value
    $("input[id*=" + gridId + "][id*=txtYear]").change(function() {
        var me = $(this);
        var row = me.parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");

        var txtTotal = row.find("input[id$='txtTotal']");
        var total = CDbl(txtTotal.val());

        var NewYearVal = CDbl(me.val());
        total = total + NewYearVal - OldYearVal;
        txtTotal.val(CCur(total));
    }
    ).focus(function() {
        OldYearVal = CDbl($(this).val());

    }
    );

}


function GoToInitiative() {
    window.location = 'InitiativesBudget.aspx?Source=Plan';
    return false;
}

function OpenAddInitiativeTemplatePopup(sender, eventArgs) {
    var value = eventArgs.get_item().get_commandName();
    if (value == 'NewInitiativeFromTemplate') {
        return OpenPOPUp('AddInitiativeFromTemplatePopup.aspx?PageId=189&Source=Plan', 1020, 520, true, 'rdgPortfolioPlanningDetails');
    }
    if (value == 'NewInitiative') {
        window.location = "InitiativesBudget.aspx?Source=Plan&ModuleId=1&PageId=190";
        return;
    }
    //if (value != 'Add') {
    //    sender.close();
    //}
    return false;

}
