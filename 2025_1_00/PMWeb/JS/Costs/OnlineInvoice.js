var OldCurrentQuantityVal = 0;
function DisablePanelAjax() {
    var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
    updatePanel1.set_enableAJAX(false);
}


function Calculate(row, sender) {
    var txtCurrentQuantity = row.find("input[id$='txtCurrentQuantity']");
    var CurrentQuantityVal = txtCurrentQuantity.val();

    var txtPctComplete = row.find("input[id$='txtPctComplete']");
    var PctCompleteVal = txtPctComplete.val();

    var lblScheduledQuantity = row.find("span[id$='lblScheduledQuantity']");
    var ScheduledQuantityVal = lblScheduledQuantity.html();

    var txtTotalQuantity = row.find("input[id$='txtTotalQuantity']");

    var lblPriorQuantity = row.find("span[id$='lblPriorQuantity']");
    var PriorQuantityVal = lblPriorQuantity.html();

    var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
    var CurrentInvoiceVal = txtCurrentInvoices.val();

    var lblScheduledValue = row.find("span[id$='lblScheduledValue']");
    var ScheduledValueVal = lblScheduledValue.html();
    var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
    var PriorInvoicesVal = lblPriorInvoices.html();

    if (sender == "CurrentQuantity") {
        var total = CDbl(CDbl(PriorQuantityVal) + CDbl(CurrentQuantityVal));
        var perc = (CDbl(total) / CDbl(ScheduledQuantityVal)) * 100;
        txtTotalQuantity.val(total);
        txtPctComplete.val(CPrct(perc));
        txtCurrentInvoices.val(CCur(CDbl(CDbl(perc) * CDbl(ScheduledValueVal) / 100) - CDbl(PriorInvoicesVal)));
    }
    if (sender == "TotalQuantity") {
        var lblPriorQuantity = row.find("span[id$='lblPriorQuantity']");
        var PriorQuantityVal = lblPriorQuantity.html();
        txtCurrentQuantity.val(FPrec(CDbl(txtTotalQuantity.val()) - CDbl(PriorQuantityVal), 3));
        var percComplete = (CDbl(txtTotalQuantity.val()) / CDbl(ScheduledQuantityVal)) * 100;
        txtPctComplete.val(CPrct(percComplete));
        txtCurrentInvoices.val(CCur(CDbl(CDbl(percComplete) * CDbl(ScheduledValueVal) / 100) - CDbl(PriorInvoicesVal)));

    }
    if (sender == "PctComplete") {
        if (PctCompleteVal < 0) {
            txtCurrentQuantity.val(CDbl(0.00));
            txtCurrentInvoices.val(CDbl(0.00));
            txtTotalQuantity.val(CDbl(0.00));
        }
        else {
            var TotalQuantity = CDbl((CDbl(PctCompleteVal) / 100) * CDbl(ScheduledQuantityVal));
            txtCurrentQuantity.val(FPrec(CDbl(TotalQuantity) - CDbl(PriorQuantityVal), 3));
            txtCurrentInvoices.val(CCur(CDbl(CDbl(PctCompleteVal) * CDbl(ScheduledValueVal) / 100) - CDbl(PriorInvoicesVal)));
            txtTotalQuantity.val(FPrec(TotalQuantity, 3));
        }
    }
    if (sender == "CurrentInvoices") {
        var PctComplete = CDbl(CurrentInvoiceVal) / CDbl(ScheduledValueVal) * 100;
        var TotalQuant = CDbl((CDbl(PctComplete) / 100) * CDbl(ScheduledQuantityVal));
        txtCurrentQuantity.val(FPrec(CDbl(TotalQuant) - CDbl(PriorQuantityVal)));
        txtTotalQuantity.val(FPrec(TotalQuant, 3));
        txtPctComplete.val(CPrct(PctComplete));
    }

    if (sender == "StoredMaterial") {

    }
    Calculate2(row, "StoredMaterial");
    Calculate2(row, "PctServicesRetain");
    Calculate2(row, "PctMaterialsRetain");
}
function Calculate2(row, sender) {
    var txtStoredMaterial = row.find("input[id$='txtStoredMaterial']");
    var StoredMaterialVal = txtStoredMaterial.val();

    var lblTotalThisInvoice = row.find("span[id$='lblTotalThisInvoice']");
    var TotalThisInvoiceVal = lblTotalThisInvoice.html();

    var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
    var CurrentInvoiceVal = txtCurrentInvoices.val();

    var lblTotalInvoiced = row.find("span[id$='lblTotalInvoiced']");
    var TotalInvoicedVal = lblTotalInvoiced.html();

    var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
    var PriorInvoicesVal = lblPriorInvoices.html();

    var lblScheduledValue = row.find("span[id$='lblScheduledValue']");
    var ScheduledValueVal = lblScheduledValue.html();

    var lblBalanceToInvoice = row.find("span[id$='lblBalanceToInvoice']");
    var BalanceToInvoiceVal = lblBalanceToInvoice.html();

    var txtPctServicesRetain = row.find("input[id$='txtPctServicesRetain']");
    var PctServicesRetainVal = txtPctServicesRetain.val();

    var txtServicesRetainAmount = row.find("input[id$='txtServicesRetainAmount']");
    var ServicesRetainAmountVal = txtServicesRetainAmount.val();

    var txtPctMaterialsRetain = row.find("input[id$='txtPctMaterialsRetain']");
    var PctMaterialsRetainVal = txtPctMaterialsRetain.val();

    var txtMaterialsRetainAmount = row.find("input[id$='txtMaterialsRetainAmount']");
    var MaterialsRetainAmountVal = txtMaterialsRetainAmount.val();

    var txtTotalRetained = row.find("input[id$='txtTotalRetained']");

    if (sender == "StoredMaterial") {
        lblTotalThisInvoice.html(CCur(CDbl(CurrentInvoiceVal) + CDbl(StoredMaterialVal)));
        lblTotalInvoiced.html(CCur(CDbl(PriorInvoicesVal) + CDbl(lblTotalThisInvoice.html())));
        lblBalanceToInvoice.html(CCur(CDbl(ScheduledValueVal) - CDbl(lblTotalInvoiced.html())));

    }
    if (sender == "PctServicesRetain") {
        txtServicesRetainAmount.val(CCur(CDbl(PctServicesRetainVal) * CDbl(CurrentInvoiceVal) / 100));
        txtTotalRetained.val(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())))
    }
    if (sender == "ServicesRetainAmount") {
        if (CDbl(TotalThisInvoiceVal) != 0) {
            var ServiceRetainPercent = (CDbl(ServicesRetainAmountVal) / CDbl(CurrentInvoiceVal)) * 100;
            txtPctServicesRetain.val(CPrct(ServiceRetainPercent))
        }
        txtTotalRetained.val(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())))
    }
    if (sender == "PctMaterialsRetain") {
        txtMaterialsRetainAmount.val(CCur(CDbl(PctMaterialsRetainVal) * CDbl(StoredMaterialVal) / 100));
        txtTotalRetained.val(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())))
    }

    if (sender == "MaterialsRetainAmount") {
        if (CDbl(TotalThisInvoiceVal) != 0) {
            var MaterialRetainPercent = (CDbl(MaterialsRetainAmountVal) / CDbl(StoredMaterialVal)) * 100;
            txtPctMaterialsRetain.val(CPrct(MaterialRetainPercent))
        }
        txtTotalRetained.val(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())))
    }

}
function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtCurrentQuantity]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "CurrentQuantity");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtTotalQuantity]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "TotalQuantity");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtPctComplete]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "PctComplete");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtCurrentInvoices]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "CurrentInvoices");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtStoredMaterial]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "StoredMaterial");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtPctServicesRetain]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate2(row, "PctServicesRetain");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtServicesRetainAmount]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate2(row, "ServicesRetainAmount");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtPctMaterialsRetain]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate2(row, "PctMaterialsRetain");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtMaterialsRetainAmount]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate2(row, "MaterialsRetainAmount");
    }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
    }
    );
}