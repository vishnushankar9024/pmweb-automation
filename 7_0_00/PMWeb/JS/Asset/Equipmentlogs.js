var OldVal;
function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtCurrentReading]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "totalHours");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateCurrencies(row, 'Amount');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateCurrencies(row, 'UnitCost');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateCurrencies(row, 'Quantity');
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );

}
function CalculateCurrencies(row, sender) {

    var txtAmount = row.find("input[id$='txtExtCost']");
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


function Calculate(row, sender) {
    var txtPreviousReading = row.find("span[id$='lblPreviousReading']");
    var txtCurrentReading = row.find("input[id$='txtCurrentReading']");
    var lblUsage = row.find("span[id$='lblUsage']");
    lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.val()) - CDbl(txtPreviousReading.html()))));
    var CurrentReading = txtCurrentReading.val();
    var OldRow = row;
     var lineNumber = CDbl(row.find("span[id$='lblLineNumber']").html());
    row = row.next();
    var Finish = 0;
    while (row.length > 0) {
        var NewLineNumber = CDbl(row.find("span[id$='lblLineNumber']").html());
        if (lineNumber + 1 == NewLineNumber) {
            var txtPreviousReading = row.find("span[id$='lblPreviousReading']");
            txtPreviousReading.html(FPrec(CDbl(CurrentReading)))
            var txtCurrentReading = row.find("input[id$='txtCurrentReading']");
            var lblUsage = row.find("span[id$='lblUsage']");
            if (txtCurrentReading.length > 0) {
                lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.val()) - CDbl(txtPreviousReading.html()))));
                CurrentReading = txtCurrentReading.val();
            }
            else {
                txtCurrentReading = row.find("span[id$='lblCurrentReading']");
                lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.html()) - CDbl(txtPreviousReading.html()))));
                CurrentReading = txtCurrentReading.html();
            }
            Finish = 1;
            break;
        }
       row = row.next();
    }

   if (Finish == 0) {
       row = OldRow.prev();

       while (row.length > 0) {
       var lblLineNumber=row.find("span[id$='lblLineNumber']");
            if (lblLineNumber.length == 0) { break; }
            var NewLineNumber = CDbl(lblLineNumber.html());
           if (lineNumber + 1 == NewLineNumber) {
               var txtPreviousReading = row.find("span[id$='lblPreviousReading']");
               txtPreviousReading.html(FPrec(CDbl(CurrentReading)))
               var txtCurrentReading = row.find("input[id$='txtCurrentReading']");
               var lblUsage = row.find("span[id$='lblUsage']");
               if (txtCurrentReading.length > 0) {
                   lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.val()) - CDbl(txtPreviousReading.html()))));
                   CurrentReading = txtCurrentReading.val();
               }
               else {
                   txtCurrentReading = row.find("span[id$='lblCurrentReading']");
                   lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.html()) - CDbl(txtPreviousReading.html()))));
                   CurrentReading = txtCurrentReading.html();
               }
               Finish = 1;
               break;
           }
           row = row.prev();
       }
    
    
    }

}

function CalculateRemainingPercentage(PercentRemaining) {
    if ($("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage").length > 0) {
        $("#ctl00_ctl00_CPH1_ACPH1_ImgRemainingPercentage").animate({ width: PercentRemaining + "%" }, 400);
    }
}