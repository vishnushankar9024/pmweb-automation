function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    var OldAmount = 0;
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); QuantityChanged(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );

    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateExtCost(row); CalculatePrice(row); CalculateUnitPrice(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateUnitCost(row); CalculatePrice(row); CalculateUnitPrice(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );


    $("input[id*=" + gridId + "][id$=txtAdjustment1]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculatePrice(row); CalculateUnitPrice(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtAdjustment2]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculatePrice(row); CalculateUnitPrice(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );

    $("input[id*=" + gridId + "][id$=txtTax]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculatePrice(row); CalculateUnitPrice(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitPrice]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculatePriceByHand(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtPrice]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateUnitPrice(row);
    }
    ).focus(function () {
        OldAmount = $(this).val();
    }
    );



}

function QuantityChanged(row) {
    var Quantity = CDbl(row.find("input[id$='txtQuantity']").val());
    var txtExtCost = row.find("input[id$='txtExtCost']")
    var UnitCost = CDbl(row.find("input[id$='txtUnitCost']").val());
    txtExtCost.val(CCur(Quantity * UnitCost));
    var ExtCost = CDbl(row.find("input[id$='txtExtCost']").val());
    var Adjustment1 = CDbl(row.find("input[id$='txtAdjustment1']").val());
    var Adjustment2 = CDbl(row.find("input[id$='txtAdjustment2']").val());
    var Tax = CDbl(row.find("input[id$='txtTax']").val());
    var txtPrice = row.find("input[id$='txtPrice']");
    txtPrice.val(CCur(ExtCost + Adjustment1 + Adjustment2 + Tax));
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    if (Quantity == 0) {
        txtPrice.val(CCur(0));
        txtUnitPrice.val(CCur(0));
    }
    else {
        txtUnitPrice.val(CCur(CDbl(txtPrice.val()) / Quantity));
    } 

}



function CalculateUnitCost(row) {
    var Quantity = CDbl(row.find("input[id$='txtQuantity']").val());
    var ExtCost = CDbl(row.find("input[id$='txtExtCost']").val());
    var txtUnitCost = row.find("input[id$='txtUnitCost']");

    if (Quantity == 0) {
        row.find("input[id$='txtQuantity']").val(FPrec(1));
        Quantity = 1;
    }
   
        txtUnitCost.val(CCur(ExtCost/Quantity));
    
   

}

function CalculateExtCost(row) {
    var Quantity = CDbl(row.find("input[id$='txtQuantity']").val());
    var UnitCost = CDbl(row.find("input[id$='txtUnitCost']").val());
    var txtExtCost = row.find("input[id$='txtExtCost']");
    txtExtCost.val(CCur(Quantity * UnitCost));

}

function CalculatePrice(row) {
    var Quantity = CDbl(row.find("input[id$='txtQuantity']").val());
    if (Quantity == 0) {
        row.find("input[id$='txtQuantity']").val(FPrec(1));
        Quantity = 1;
        CalculateExtCost(row);
    }
    var ExtCost = CDbl(row.find("input[id$='txtExtCost']").val());
    var Adjustment1 = CDbl(row.find("input[id$='txtAdjustment1']").val());
    var Adjustment2 = CDbl(row.find("input[id$='txtAdjustment2']").val());
    var Tax = CDbl(row.find("input[id$='txtTax']").val());
    var txtPrice = row.find("input[id$='txtPrice']");
   
    txtPrice.val(CCur(ExtCost + Adjustment1 + Adjustment2 +Tax));
}

function CalculateUnitPrice(row) {
    var Quantity = CDbl(row.find("input[id$='txtQuantity']").val());
    var Price = CDbl(row.find("input[id$='txtPrice']").val());
    var txtPrice = row.find("input[id$='txtPrice']");
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    if (Quantity == 0) {
        row.find("input[id$='txtQuantity']").val(FPrec(1));
        Quantity = 1;
        CalculateExtCost(row); 
    }
   
        txtUnitPrice.val(CCur(Price/Quantity));
   
  
}
function CalculatePriceByHand(row) {
    var Quantity = CDbl(row.find("input[id$='txtQuantity']").val());
    var UnitPrice = CDbl(row.find("input[id$='txtUnitPrice']").val());
    var txtPrice = row.find("input[id$='txtPrice']");
    if (Quantity == 0) {
        row.find("input[id$='txtQuantity']").val(FPrec(1));
        Quantity = 1;
        CalculateExtCost(row); 
    }
   
    txtPrice.val(CCur(Quantity * UnitPrice));

}

