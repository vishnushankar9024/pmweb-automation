function ddlReqCode_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var description = item.get_text();
    var id = item.get_value();
    var txtDescription = $("#" + itemId).parents("tr:first").find("input[id$='txtReqCode']");
    if (id > 0)
        txtDescription.val(description);

}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}

function OpenCEPopup() {
    OpenPOPUp('PrimeContractCOCEPopup.aspx', 800, 500, true);
}

function Calculate(row, toCalculate) {
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QuantityVal = CDbl(txtQuantity.val());
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    var UnitPrice = CDbl(txtUnitPrice.val());

    var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
    var OwnerBudgetVal = CDbl(txtOwnerBudget.val());

    var txtMarkupPct = row.find("input[id$='txtMarkupPct']");
    var MarkupPctVal = CDbl(txtMarkupPct.val());
    if (CDbl(MarkupPctVal) > 100) {
        MarkupPctVal = 100;

    }
    if (CDbl(MarkupPctVal) < 0) {
        MarkupPctVal = 0;

    }
    var txtMarkup = row.find("input[id$='txtMarkup']");
    var MarkupVal = CDbl(txtMarkup.val());
    var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
    if (toCalculate == "UnitPrice" || toCalculate == "Quantity") {
        txtOwnerBudget.val(CDbl(UnitPrice * QuantityVal));
    }
    else if (toCalculate == "OwnerBudget") {
        txtUnitPrice.val(CDbl(OwnerBudgetVal / QuantityVal));
        txtMarkup.val(CDbl(MarkupPctVal * CDbl(txtOwnerBudget.val()) / 100));
    }
    else if (toCalculate == "MarkupPct") {
        txtMarkup.val(CDbl(MarkupPctVal * CDbl(OwnerBudgetVal) / 100));
    }
    else if (toCalculate == "Markup") {
        var per = 0;
        if (OwnerBudgetVal > 0)
            per = CDbl(txtMarkup.val()) / CDbl(OwnerBudgetVal);            
        txtMarkupPct.val(CPrct(CDbl(per)));
    }
    lblTotalPrice.html(CDbl(CDbl(txtOwnerBudget.val()) + CDbl(txtMarkup.val())));

}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var me = $(this);
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        //        Calculate(row, "Quantity");
        var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
        var QuantityVal = CDbl(me.val());
        var UnitPriceVal = CDbl(txtUnitPrice.val());
        var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
        txtOwnerBudget.val(CCur(UnitPriceVal * QuantityVal));
        var Adjustment1Val = CDbl(row.find("span[id$='lblEditAdjustment1']").html());
        var Adjustment2Val = CDbl(row.find("span[id$='lblEditAdjustment2']").html());
        var TaxVal = CDbl(row.find("span[id$='lblEditTax']").html());
        var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
        var OwnderBudgetVal = CDbl(txtOwnerBudget.val());
        lblTotalPrice.html(CCur(CDbl(OwnderBudgetVal + Adjustment1Val + Adjustment2Val + TaxVal)));

    });


    $("input[id*=" + gridId + "][id$=txtUnitPrice]").change(function() {
        var me = $(this);
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        //        Calculate(row, "UnitPrice");
        var txtQuantity = row.find("input[id$='txtQuantity']");
        var UnitPriceVal = CDbl(me.val());
        var QuantityVal = CDbl(txtQuantity.val());
        var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");

        txtOwnerBudget.val(CCur(UnitPriceVal * QuantityVal));
        var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
        var Adjustment1Val = CDbl(row.find("span[id$='lblEditAdjustment1']").html());
        var Adjustment2Val = CDbl(row.find("span[id$='lblEditAdjustment2']").html());
        var TaxVal = CDbl(row.find("span[id$='lblEditTax']").html());
        var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
        var OwnderBudgetVal = CDbl(txtOwnerBudget.val());
        lblTotalPrice.html(CCur(CDbl(OwnderBudgetVal + Adjustment1Val + Adjustment2Val + TaxVal)));
    });


    $("input[id*=" + gridId + "][id$=txtOwnerBudget]").change(function () {
        var me = $(this);
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        //        Calculate(row, "OwnerBudget");
        var txtQuantity = row.find("input[id$='txtQuantity']");
        var OwnerBudgetVal = CDbl(me.val());
        var QuantityVal = CDbl(txtQuantity.val());
        var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
        var Adjustment1Val = CDbl(row.find("span[id$='lblEditAdjustment1']").html());
        var Adjustment2Val = CDbl(row.find("span[id$='lblEditAdjustment2']").html());
        var TaxVal = CDbl(row.find("span[id$='lblEditTax']").html());

        //        if (QuantityVal == 0 && OwnerBudgetVal ==0 ) {
        //        txtUnitPrice.val(FPrec(0));
        //        }
        //        else 
        //        {
        if (QuantityVal == 0) {
            QuantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        txtUnitPrice.val(CCur(CDbl(OwnerBudgetVal / QuantityVal)));

        var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
        lblTotalPrice.html(CCur(CDbl(OwnerBudgetVal + Adjustment1Val + Adjustment2Val + TaxVal)));

        //        var txtMarkupPct = row.find("input[id$='txtMarkupPct']");
        //        var MarkupPctVal = CDbl(txtMarkupPct.val());
        //        var txtMarkup = row.find("input[id$='txtMarkup']");
        //        txtMarkup.val(CCur(OwnerBudgetVal * MarkupPctVal / 100));
        //        txtMarkup.trigger('change', ['automaticaly']);
    });


//    $("input[id*=" + gridId + "][id$=txtMarkupPct]").change(function() {
//        var me = $(this);
//        var row = me.parents("tr:first");
//        //        Calculate(row, "MarkupPct");
//        var MarkupPctVal = CDbl(me.val());
//        var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
//        var OwnerBudgetVal = CDbl(txtOwnerBudget.val());
//        var txtMarkup = row.find("input[id$='txtMarkup']");
//        txtMarkup.val(CCur(OwnerBudgetVal * MarkupPctVal / 100));
//        txtMarkup.trigger('change', ['automaticaly']);
//    });


//    $("input[id*=" + gridId + "][id$=txtMarkup]").bind('change', function(e, param1) {
//        var me = $(this);
//        var row = me.parents("tr:first");
//        //        Calculate(row, "Markup");
//        var MarkupVal = CDbl(me.val());
//        var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
//        var OwnerBudgetVal = CDbl(txtOwnerBudget.val());
//        
//        // if the event come from real change not from the code
//        // if (e.originalEvent) // it works also, in this case we don't need to pass parameters
//        if (param1 != 'automaticaly') {
//            var txtMarkupPct = row.find("input[id$='txtMarkupPct']");
//            if (OwnerBudgetVal == 0)
//                txtMarkupPct.val(CPrct(0));
//            else
//                txtMarkupPct.val(CPrct(MarkupVal / OwnerBudgetVal * 100));

//        }

//        var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
//        lblTotalPrice.html(CCur(MarkupVal + OwnerBudgetVal));

//    });

}