function AdjustSCheduleChargesCalculation(gridId) {
    var grid = $("#" + gridId);
    var OldAmount = 0;
    $("input[id*=" + gridId + "][id$=txtAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateSCheduleCharges(row, 'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateSCheduleCharges(row, 'UnitCost');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateSCheduleCharges(row, 'Quantity');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
}
function CalculateSCheduleCharges(row, sender) {

    var txtAmount = row.find("input[id$='txtAmount']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var Amount = CDbl(txtAmount.val());
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    if (sender == 'Amount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtUnitCost.val(CCur(Amount / Quantity));
    }
    if (sender == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
    }

    if (sender == 'Quantity') {
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));

    }
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + "rdgCosts");

    // On change Unit Cost
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'UnitCost');
    });

    // On change quantity
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'Quantity');
    });

    //On change TotalCost
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtTotalAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'TotalAmount');
    });

    $("input[id*=" + gridId + "][id *='_Detail'][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateSCheduleCharges(row, 'UnitCost');
    });

    // On change quantity
    $("input[id*=" + gridId + "][id *='_Detail'][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateSCheduleCharges(row, 'Quantity');
    });

    //On change TotalCost
    $("input[id*=" + gridId + "][id *='_Detail'][id$=txtAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateSCheduleCharges(row, 'Amount');
    });
}

function Calculate(row, index) {
    var txtAmount = row.find("input[id$='txtTotalAmount']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var Quantity = CDbl(txtQuantity.val());
    var Amount = CDbl(txtAmount.val());
    if (index == 'TotalAmount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtUnitCost.val(CCur(Amount / Quantity));
    }
    if (index == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
    }

    if (index == 'Quantity') {
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));

    }


}

function AdjustEscalationCalculation(gridId) {
    var grid = $("#" + gridId);
    var OldAmount = 0;
    $("input[id*=" + gridId + "][id$=txtCurrentAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateCurrentEscCharges(row, 'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtCurrentUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateCurrentEscCharges(row, 'UnitCost');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtCurrentQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateCurrentEscCharges(row, 'Quantity');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtNewAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateNewEscCharges(row, 'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtNewUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateNewEscCharges(row, 'UnitCost');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtNewQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateNewEscCharges(row, 'Quantity');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
}

function CalculateCurrentEscCharges(row, sender) {

    var txtAmount = row.find("input[id$='txtCurrentAmount']");
    var txtUnitCost = row.find("input[id$='txtCurrentUnitCost']");
    var Amount = CDbl(txtAmount.val());
    var txtQuantity = row.find("input[id$='txtCurrentQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    if (sender == 'Amount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtUnitCost.val(CCur(Amount / Quantity));
    }
    if (sender == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
    }

    if (sender == 'Quantity') {
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));

    }
}
function CalculateNewEscCharges(row, sender) {

    var txtAmount = row.find("input[id$='txtNewAmount']");
    var txtUnitCost = row.find("input[id$='txtNewUnitCost']");
    var Amount = CDbl(txtAmount.val());
    var txtQuantity = row.find("input[id$='txtNewQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    if (sender == 'Amount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtUnitCost.val(CCur(Amount / Quantity));
    }
    if (sender == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
    }

    if (sender == 'Quantity') {
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));

    }
}

function AdjustOverageCalculation(gridId) {
    var grid = $("#" + gridId);
    var OldAmount = 0;
    $("input[id*=" + gridId + "][id$=txtOverageAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOverageCharges(row, 'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOverageCharges(row, 'UnitCost');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOverageCharges(row, 'Quantity');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
}

function CalculateOverageCharges(row, sender) {

    var txtAmount = row.find("input[id$='txtOverageAmount']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var Amount = CDbl(txtAmount.val());
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    if (sender == 'Amount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtUnitCost.val(CCur(Amount / Quantity));
    }
    if (sender == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
    }

    if (sender == 'Quantity') {
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));

    }
}



function OpenSCheduleChargeLeasePopup(ddlId) {
    var left = (screen.width - 568) / 2;
    var top = (screen.height - 300) / 2;
    var Id = "0";
    var ddlPropertyClientId = ddlId.replace('_ddlLeases', '_ddlProperties');
    var ddlprop = $find(ddlPropertyClientId);
    if (ddlprop.get_value() != '') {
        Id = ddlprop.get_value();
    }
    var win = window.open('SelectLeasePopup.aspx?Id=' + Id + '&ddlId=' + ddlId, '',
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=850,height=350,top=' + top + ',left=' + left);
    return false;
}

function ClearCostCodeAndLeaseddl(sender, args) {

    var item = args.get_item();
    var ddlLease = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlLeases');
    var ddlCostCode = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlCostCodes');
    var hdnPropertyId = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnPropertyId');
    sender.trackChanges();
    sender.set_value(item.get_value());
    sender.commitChanges();
    hdnPropertyId.value = item.get_value();
    ddlLease.clearItems();
    ddlCostCode.clearItems();
    if (ddlLease.get_value() != "0" && ddlLease.get_value() != "") {
        ddlLease.set_text('');
        ddlLease.set_value('');
    }
    if (ddlCostCode.get_value() != "0" && ddlCostCode.get_value() != "") {
        ddlCostCode.set_text('');
        ddlCostCode.set_value('');
    }

}
function ScheduleLeaseddlClose(sender, args) {
    var ddlprop = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlProperties');
    SelectedValue = ddlprop.get_value();
    if (SelectedValue == '') {
        var ddlLease = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlLeases');
        var ddlCostCode = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlCostCodes');
        var hdnPropertyId = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnPropertyId');
        ddlLease.clearItems();
        ddlCostCode.clearItems();
        hdnPropertyId.value = "0";
        if (ddlLease.get_value() != "0" && ddlLease.get_value() != "") {
            ddlLease.set_text('');
            ddlLease.set_value('');
        }
        if (ddlCostCode.get_value() != "0" && ddlCostCode.get_value() != "") {
            ddlCostCode.set_text('');
            ddlCostCode.set_value('');
        }

    }

}


function GetValueToReturnScheduleCharge(sender, eventArgs) {
    var SelectedValue;
    var hdnPropertyId = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnPropertyId');
    SelectedValue = hdnPropertyId.value;
    var context = eventArgs.get_context();
    context[sender.get_id()] = SelectedValue;


}
