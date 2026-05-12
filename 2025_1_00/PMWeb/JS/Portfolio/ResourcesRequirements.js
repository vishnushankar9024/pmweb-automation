var CalculateChanges = true;

function AdjustRequirementDetailsCalculations(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=dtpStartDate]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        InvokeDetailCustomValidator(row); Calculate(row, "StartDate");
    });

    $("input[id*=" + gridId + "][id$=dtpFinishDate]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        InvokeDetailCustomValidator(row); Calculate(row, "FinishDate");
    });

    $("input[id*=" + gridId + "][id$=dtpStartTime]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        InvokeDetailCustomValidator(row);
    });

    $("input[id*=" + gridId + "][id$=dtpFinishTime]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        InvokeDetailCustomValidator(row);
    });

    $("input[id*=" + gridId + "][id$=txtPctComplete]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "PctComplete");
    });
    $("input[id*=" + gridId + "][id$=txtHourPerDay]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "HourPerDay");
    });

    $("input[id*=" + gridId + "][id$=chkAllDay]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "AllDay");
    });

    $("select[id*=" + gridId + "][id$=ddlAmountTypes]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "AmountTypes");
    });


    $("input[id*=" + gridId + "][id$=txtAssignedHours]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "txtAssignedHours");
    });

    $("input[id*=" + gridId + "][id$=txtCurrencyValue]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "txtCurrencyValue");
    });

}

function InvokeDetailCustomValidator(row) {
    ValidatorValidate(row.find("span[id$='csvDetailDate']")[0]);
}

function Calculate(row, sender) {

    if (sender == "PctComplete" || sender == "HourPerDay" || sender == "StartDate" || sender == "FinishDate") {
        var txtAssignedHours = row.find("input[id$='txtAssignedHours']")[0];
        var txtHoursPerDay = row.find("input[id$='txtHourPerDay']")[0];
        var txtPctComplete = row.find("input[id$='txtPctComplete']")[0];
        if ( txtHoursPerDay.value > 24) {
            txtHoursPerDay.value = 24;
        } else if (txtHoursPerDay.value <= 0) {
            txtHoursPerDay.value = 0.01;
        }
        var StartDate = $find(row.find("input[id$='dtpStartDate']")[0].id)._dateInput.get_selectedDate();
        var FinishDate = $find(row.find("input[id$='dtpFinishDate']")[0].id)._dateInput.get_selectedDate();

        if (txtPctComplete.value > 100) {
            txtPctComplete.value = 100
        } else if (txtPctComplete.value < 0) {
            txtPctComplete.value = 0
        }
        if (StartDate != '' && StartDate != null && FinishDate != '' && FinishDate != null) {
            var Duration = CalculateDuration(StartDate, FinishDate);
            txtAssignedHours.value = CDbl(txtHoursPerDay.value * Duration * (parseInt(txtPctComplete.value) / 100));
            Calculate(row, "txtCurrencyValue")
        }
    }
    if (sender == "AllDay") {

        var chkAllDay = row.find("input[type='checkbox'][id$='chkAllDay']")[0];
        var txtHourPerDay = $find(row.find("input[id$='txtHourPerDay']")[0].id);
        if (chkAllDay.checked) {
            if ($find(row.find("[id$='ddlResources']")[0].id).get_selectedItem() != null) {
                var defaultHoursPerDay = $find(row.find("[id$='ddlResources']")[0].id).get_selectedItem().get_attributes().getAttribute('DefaultHoursPerDay')
                txtHourPerDay.set_value(parseInt(defaultHoursPerDay));
                Calculate(row, "HourPerDay");
                txtHourPerDay.disable();
            } else {
                var defaultHoursPerDay = $find(row.find("[id$='ddlResources']")[0].id).get_attributes().getAttribute('DefaultHoursPerDay')
                if (defaultHoursPerDay > 0) {
                    txtHourPerDay.set_value(parseInt(defaultHoursPerDay));
                    Calculate(row, "HourPerDay");
                    txtHourPerDay.disable();
                }

            }
        } else {
            txtHourPerDay.enable();
        }
    }

    if (sender == "txtCurrencyValue" || sender == "txtAssignedHours") {
        var txtTotalHours = row.find("input[id$='txtTotalHours']")[0];
        var txtCurrencyValue = row.find("input[id$='txtCurrencyValue']")[0];
        var txtAssignedHours = row.find("input[id$='txtAssignedHours']")[0];
        var value = $find(row.find("[id$='ddlRateBasis']")[0].id).get_selectedItem().get_value();

        if (value == 1) {
            txtTotalHours.value = CCur(txtCurrencyValue.value);
        }
        else {
            txtTotalHours.value = CCur(txtAssignedHours.value * CDbl(txtCurrencyValue.value));
        }
    }

    if (sender == "txtAssignedHours") {
        var txtAssignedHours = row.find("input[id$='txtAssignedHours']")[0];
        var txtHoursPerDay = row.find("input[id$='txtHourPerDay']")[0];
        var txtPctComplete = row.find("input[id$='txtPctComplete']")[0];
        if (txtHoursPerDay.value < 0 || txtHoursPerDay.value > 24) {
            return;
        }
        var StartDate = $find(row.find("input[id$='dtpStartDate']")[0].id)._dateInput.get_selectedDate();
        var FinishDate = $find(row.find("input[id$='dtpFinishDate']")[0].id)._dateInput.get_selectedDate();

        if (StartDate != '' && StartDate != null && FinishDate != '' && FinishDate != null) {
            var Duration = CalculateDuration(StartDate, FinishDate);
            var pctComplete = (txtAssignedHours.value * 100) / (Duration * txtHoursPerDay.value); 
            txtPctComplete.value = CPrct(pctComplete);
        }

    }

    if (sender == "AmountTypes") {
        var txtCurrencyValue = row.find("input[id$='txtCurrencyValue']");
        var SelectedAmountType = row.find("select[id$='ddlAmountTypes']")[0].selectedIndex;
        if (SelectedAmountType == 0) {
            txtCurrencyValue.removeAttr("readOnly");
        } else {
            txtCurrencyValue.attr("readOnly", "readOnly");
        }
    }

}

function CalculateDuration(StartDate, EndDate) {
    var duration = 0;
    if ((EndDate == '') || (EndDate == null)) { return 0; }
    if ((StartDate == '') || (StartDate == null)) { return 0; }
    StartDate = Date.UTC(StartDate.getFullYear(), StartDate.getMonth(), StartDate.getDate());
    EndDate = Date.UTC(EndDate.getFullYear(), EndDate.getMonth(), EndDate.getDate());
    return ((EndDate - StartDate) / (3600000 * 24)) + 1;
}

function Requirements_CostCodeChanged(combobox, eventArgs) {
    var item = eventArgs.get_item();
    var ddlPostAs = $find(combobox._element.id.replace('_ddlCostCodes', '_ddlPostAs'));
    var PostAsfirstTable = $("[id='" + combobox._element.id.replace('_ddlCostCodes', '_ddlPostAs') + "'] table:first");
    if (ddlPostAs == null) { return;}
    if (item == null) {
        ddlPostAs.set_enabled(false);
        PostAsfirstTable.addClass("rcbDisabled");
    } else {
        ddlPostAs.set_enabled(true);
        PostAsfirstTable.removeClass("rcbDisabled");
    }
}

function Requirements_CostCodeTextChanged(sender, args) {
    if (sender.get_value() == '') {
        var ddlPostAs = $find(sender._element.id.replace('_ddlCostCodes', '_ddlPostAs'));
        $("[id='" + sender._element.id.replace('_ddlCostCodes', '_ddlPostAs') + "'] table:first").addClass("rcbDisabled");
        if (ddlPostAs == null) { return; }
        ddlPostAs.set_enabled(false);
    }
}

