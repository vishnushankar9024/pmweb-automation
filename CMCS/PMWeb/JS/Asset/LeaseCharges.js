function dllPostEverySelectedIndexChanged(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hdnPostEvry';
    var Annualized = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAnnualized';
    var Amount = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAmount';
    var hdnPostEvry = document.getElementById(HiddenField);
    var txtAnnualized = document.getElementById(Annualized);
    var txtAmount = document.getElementById(Amount);
    var SelectedItem = eventArgs.get_item();
    var Conversion = CDbl(SelectedItem.get_attributes().getAttribute("Conv"));

    if (hdnPostEvry != null) {
        hdnPostEvry.value = FPrec(Conversion);
        txtAnnualized.value = CCur(CDbl(txtAmount.value) * Conversion); 
    }
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    var OldAmount = 0;
    $("input[id*=" + gridId + "][id$=txtAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row,'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'UnitCost');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'Quantity');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
   

}
function Calculate(row, sender) {
    var txtAmount = row.find("input[id$='txtAmount']");
    var Amount = CDbl(txtAmount.val());
    var hdnPostEvry = row.find("input[id$='hdnPostEvry']");
    var Conversion = CDbl(hdnPostEvry.val());
    var txtAnnualized = row.find("input[id$='txtAnnualized']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    if (sender == 'Amount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1; 
        }
        txtUnitCost.val(CCur(Amount / Quantity));

    }

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
        txtAmount.val(CCur(CDbl(txtUnitCost.val()) * Quantity));

    }
    if (sender == 'Quantity') {
       
        txtAmount.val(CCur(CDbl(txtUnitCost.val()) * Quantity));

    }

    txtAnnualized.val(CCur(CDbl(txtAmount.val()) * Conversion));
}
