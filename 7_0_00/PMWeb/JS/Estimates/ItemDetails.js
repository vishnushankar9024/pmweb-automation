function AdjustCostCalculation(gridId, QuantityMultiplier) {
    var grid = $("#" + gridId);
    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var Quantity = $(this).val();
        var UnitCost = row.find("input[id$='txtUnitCost']").val();
        var txtTotalCost = row.find("input[id$='txtTotalCost']");
        var lblExtentedQuantity = row.find("span[id$='lblExtentedQuantity']")
        var txtExtCost = row.find("input[id$='txtExtCost']");
        var ExtCostVal = txtExtCost.val();
        var lblEditAdjustment1 = row.find("span[id$='lblEditAdjustment1']");
        var Adjustment1Val = lblEditAdjustment1.html();
        var lblEditAdjustment2 = row.find("span[id$='lblEditAdjustment2']");
        var Adjustment2Val = lblEditAdjustment2.html();
        var lblEditTax = row.find("span[id$='lblEditTax']");
        var TaxVal = lblEditTax.html();

        lblExtentedQuantity.text(FPrec(CPDbl(Quantity) * QuantityMultiplier));
        txtExtCost.val(CCur(CPDbl(Quantity) * QuantityMultiplier * CDbl(UnitCost)));
        ExtCostVal = txtExtCost.val();
        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));


    });

    // On change unit cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var UnitCost = $(this).val();
        var Quantity = row.find("input[id$='txtQuantity']").val();
        var txtTotalCost = row.find("input[id$='txtTotalCost']");
        var lblExtentedQuantity = row.find("span[id$='lblExtentedQuantity']")
        var txtExtCost = row.find("input[id$='txtExtCost']");
        var ExtCostVal = txtExtCost.val();
        var lblEditAdjustment1 = row.find("span[id$='lblEditAdjustment1']");
        var Adjustment1Val = lblEditAdjustment1.html();
        var lblEditAdjustment2 = row.find("span[id$='lblEditAdjustment2']");
        var Adjustment2Val = lblEditAdjustment2.html();
        var lblEditTax = row.find("span[id$='lblEditTax']");
        var TaxVal = lblEditTax.html();

        txtExtCost.val(CCur(CPDbl(Quantity) * QuantityMultiplier * CDbl(UnitCost)));
        ExtCostVal = txtExtCost.val();
        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));

    });

    // On change ExtCost

    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var ExtCostVal = $(this).val();
        var txtUnitCost = row.find("input[id$='txtUnitCost']");
        var Quantity = row.find("input[id$='txtQuantity']").val();
        var txtQuantity = row.find("input[id$='txtQuantity']");
        var txtTotalCost = row.find("input[id$='txtTotalCost']");
        var lblExtentedQuantity = row.find("span[id$='lblExtentedQuantity']")
        var lblEditAdjustment1 = row.find("span[id$='lblEditAdjustment1']");
        var Adjustment1Val = lblEditAdjustment1.html();
        var lblEditAdjustment2 = row.find("span[id$='lblEditAdjustment2']");
        var Adjustment2Val = lblEditAdjustment2.html();
        var lblEditTax = row.find("span[id$='lblEditTax']");
        var TaxVal = lblEditTax.html();
        if (Quantity == 0) {
            Quantity = 1;
            txtQuantity.val(FPrec(1));
        }
        lblExtentedQuantity.text(FPrec(CPDbl(Quantity) * QuantityMultiplier));
        txtUnitCost.val(CCur(CDbl(ExtCostVal) / (CDbl(Quantity) * QuantityMultiplier)));

        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));

    });

    // On change TotalCost
    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var TotalCostVal = $(this).val();
        var txtUnitCost = row.find("input[id$='txtUnitCost']");
        var Quantity = row.find("input[id$='txtQuantity']").val();
        var txtQuantity = row.find("input[id$='txtQuantity']");
        var lblExtentedQuantity = row.find("span[id$='lblExtentedQuantity']")
        var txtExtCost = row.find("input[id$='txtExtCost']");
        var lblEditAdjustment1 = row.find("span[id$='lblEditAdjustment1']");
        var Adjustment1Val = lblEditAdjustment1.html();
        var lblEditAdjustment2 = row.find("span[id$='lblEditAdjustment2']");
        var Adjustment2Val = lblEditAdjustment2.html();
        var lblEditTax = row.find("span[id$='lblEditTax']");
        var TaxVal = lblEditTax.html();
        if (Quantity == 0) {
            Quantity = 1;
            txtQuantity.val(FPrec(1));
        }
        lblExtentedQuantity.text(FPrec(CPDbl(Quantity) * QuantityMultiplier));
        txtExtCost.val(CCur(CDbl(TotalCostVal) - CDbl(Adjustment1Val) - CDbl(Adjustment2Val) - CDbl(TaxVal)));
        var ExtCostVal = txtExtCost.val();
        txtUnitCost.val(CCur(CDbl(ExtCostVal) / (CDbl(Quantity) * QuantityMultiplier)));

    });


}


