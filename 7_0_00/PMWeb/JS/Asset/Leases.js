function ddllandlord_OnClientSelectedIndexChanged(sender, eventArgs) {
    var IsNew = $("[id$=hdfIsNewRecord]").val();
    if (IsNew == "true") {
        var txtLessor = $("[id$=txtLessor]");
        txtLessor.val(sender.get_text());
    }
}

function ddltenant_OnClientSelectedIndexChanged(sender, eventArgs) {
    var IsNew = $("[id$=hdfIsNewRecord]").val();
    if (IsNew == "true") {
        var txtLessor = $("[id$=txtLessee]");
        txtLessor.val(sender.get_text());
    }
}



function CalculateDaysOverDue(gridId) {
    var lblDaysOverDue = $('input[id$=lblDaysOverdue]');
    var CurrentDate = new Date();
    CurrentDate.setHours(0, 0, 0, 0);
    var grid = $("#" + gridId);
    var OldAmount = 0;
    var ONE_DAY = 1000 * 60 * 60 * 24



    $("input[id*=" + gridId + "][id$=dtpDueDate]").change(function () {

        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var txtDueDate = row.find("[id$='dtpDueDate']");
        var lblDaysOverDue = row.find("span[id$='lblDaysOverdue']");

        var txtDueDateVal = txtDueDate.val();

        var DueDate = new Date(Date.parse(txtDueDateVal.replace(/-/g, "/")));

        var difference = Math.abs(CurrentDate - DueDate) / ONE_DAY;
        if (CurrentDate < DueDate) {
            difference = 0
        }
        lblDaysOverDue.html(Math.ceil(difference));
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );

}


function CalculateSnapShot() {

    var txtMonthlyRent = $('input[id$=txtMonthlyRent]');
    var MonthlyRentVal = txtMonthlyRent.val();
    var txtRentable = $('input[id$=txtRentable]');
    var RentableVal = txtRentable.val();

    var txtYearlyRent = $('input[id$=txtYearlyRent]');
    var txtRentAreaMonth = $('input[id$=txtRentAreaMonth]');
    var txtRentAreaYear = $('input[id$=txtRentAreaYear]');




    txtYearlyRent.val(CCur(CDbl(MonthlyRentVal) * 12));


    if (CDbl(RentableVal) > 0) {

        txtRentAreaMonth.val(CCur(CDbl(MonthlyRentVal) / CDbl(RentableVal)));
        txtRentAreaYear.val(CCur(CDbl(MonthlyRentVal) * 12 / CDbl(RentableVal)));
    }
    else {
        txtRentAreaMonth.val(CCur(CDbl(0)));
        txtRentAreaYear.val(CCur(CDbl(0)));
    }

}

function dllPostEverySelectedIndexChanged(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hdnPostEvry';
    var Annualized = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAnnualized';
    var Amount = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAmount';
    var DetailRentable = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hdnDetailRentable';
    var lblAnnual = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_lblAnnual'
    var hdnPostEvry = document.getElementById(HiddenField);
    var txtAnnualized = document.getElementById(Annualized);
    var hdnDetailRentable = document.getElementById(DetailRentable);
    var txtAmount = document.getElementById(Amount);
    var AnnualSpan = $("#" + lblAnnual);
    var SelectedItem = eventArgs.get_item();
    var Conversion = CDbl(SelectedItem.get_attributes().getAttribute("Conv"));

    if (hdnPostEvry != null) {
        hdnPostEvry.value = FPrec(Conversion);
        txtAnnualized.value = CCur(CDbl(txtAmount.value) * Conversion);
        if (CDbl(hdnDetailRentable.value) == 0)
            AnnualSpan.html(CCur(0));
        else
            AnnualSpan.html(CCur((CDbl(txtAmount.value) * Conversion) / CDbl(hdnDetailRentable.value)));



    }
}

function AdjustAmountCalculation(gridId) {
    var grid = $("#" + gridId);
    var OldAmount = 0;
    $("input[id*=" + gridId + "][id$=txtAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );

    $("input[id*=" + gridId + "][id$=txtAnnualized]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'Annualized');
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
    var hdnDetailRentable = row.find("input[id$='hdnDetailRentable']");
    var lblAnnual = row.find("span[id$='lblAnnual']");
    var txtAmount = row.find("input[id$='txtAmount']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var Amount = CDbl(txtAmount.val());
    var hdnPostEvry = row.find("input[id$='hdnPostEvry']");
    var Conversion = CDbl(hdnPostEvry.val());
    var txtAnnualized = row.find("input[id$='txtAnnualized']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    if (sender == 'Amount') {
        txtAnnualized.val(CCur(Amount * Conversion));
        lblAnnual.html(CCur(CDbl((Amount * Conversion) / CDbl(hdnDetailRentable.val()))));
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;

        }

        txtUnitCost.val(CCur(Amount / Quantity));



    }

    if (sender == 'Annualized') {
        if (CDbl(hdnDetailRentable.val()) == 0) {
            lblAnnual.html(CCur(0));
        }
        else
            lblAnnual.html(CCur(CDbl(CDbl(txtAnnualized.val()) / CDbl(hdnDetailRentable.val()))));
    }

    if (sender == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
        txtAnnualized.val(CCur(CDbl(txtAmount.val()) * Conversion));
        if (CDbl(hdnDetailRentable.val()) == 0) {
            lblAnnual.html(CCur(0));
        }
        else
            lblAnnual.html(CCur(CDbl(CDbl(txtAnnualized.val()) / CDbl(hdnDetailRentable.val()))));
    }

    if (sender == 'Quantity') {
        txtAmount.val(CCur(Quantity * CDbl(txtUnitCost.val())));
        txtAnnualized.val(CCur(CDbl(txtAmount.val()) * Conversion));
        if (CDbl(hdnDetailRentable.val()) == 0) {
            lblAnnual.html(CCur(0));
        }
        else
            lblAnnual.html(CCur(CDbl(CDbl(txtAnnualized.val()) / CDbl(hdnDetailRentable.val()))));
    }




}


function OpenChargeLinkToAsset(Id, hdnLinkedAsset, IsEditMode) {
    var Value = $("#" + hdnLinkedAsset)[0].value;
    return OpenPOPUp('LinkedAssetChargesPopup.aspx?Id=' + Id + '&IsEditMode=' + IsEditMode + '&hdnLinkedAsset=' + hdnLinkedAsset + '&LinkedAssetIds=' + Value, 885, 390, true);
}

function ChargesPopup() {

    return OpenPOPUp('SelectLeaseChargesPopup.aspx', 885, 580, true);
}

function OpenChargeDetailPopup(Id) {
    return OpenPOPUp('ChargesDetailsPopup.aspx?Id=' + Id, 832, 730, true);

}

function OpenGenerateRecurringChargesPopup() {
    var grid = $find($("[id$=rdgLeaseCharges]")[0].id);
    if (grid.get_masterTableView().get_selectedItems().length == 1) {
        var row = grid.get_masterTableView().get_selectedItems()[0];
        if (row.getDataKeyValue("HasDetails") == 0 && row.getDataKeyValue("HasRecurrences") == 0) {
            var Id = row.getDataKeyValue("Id");
            return OpenPOPUp('GenerateRecurringChargesPopup.aspx?Id=' + Id, 832, 730, true);
        }
    }
    return false;
}

function OpenLeaseAnalyzer() {
    return OpenPOPUp('LeaseAnalyzerPopup.aspx?', 396, 535, true);

}