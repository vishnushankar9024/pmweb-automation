var OldQuantityVal = 0;
var OldUnitCostVal = 0;
var OldTotalVal = 0;


function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var description = item._attributes.getAttribute("Description");
   
    var row = $("#" + itemId).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $("#" + itemId).parents("tr:first")
    row.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));

}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitCost");
    }).focus(function () { OldUnitCostVal = $(this).val(); });

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "Quantity");
    }).focus(function () { OldQuantityVal = $(this).val(); });

    //On change Total
    $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalAmount");
    }).focus(function () { OldExtUnitCostVal = $(this).val(); });

}

function Calculate(row, sender) {
    var txtTotalAmount = row.find("input[id$='txtTotalAmount']");
    var TotalAmountVal = txtTotalAmount.val();

    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QantityVal = txtQuantity.val();
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();

    if (sender == "TotalAmount") {
        //CalculateSumTotalAmountVal(OldExtUnitCostVal, TotalAmountVal);
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }

        txtUnitCost.val(CCur(CDbl(TotalAmountVal) / CDbl(QantityVal)));
    //    CalculateSumUnitCost(UnitCostVal, txtUnitCost.val());
    } else {
        //if (sender == "Quantity") { CalculateSumQuantity(OldQuantityVal, QantityVal); }
       // else if (sender == "UnitCost") { CalculateSumUnitCost(OldUnitCostVal, UnitCostVal); }
        txtTotalAmount.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));
      //  CalculateSumTotalAmountVal(TotalAmountVal, txtTotalAmount.val());
    }
}

//function CalculateSumTotalAmountVal(oldValue, newValue) {
//   
//    var lblSumTotalAmount = $("span[id$=lblSumTotalAmount]");
//    var newTotalExtCostAmount = CDbl(lblSumTotalAmount.html()) + CDbl(newValue) - (CDbl(lblSumTotalAmount.html()) == 0 ? 0 : CDbl(oldValue));
//    lblSumTotalAmount.html(CCur(newTotalExtCostAmount));
//}

//function CalculateSumQuantity(oldValue, newValue) {
//    var lblSumQuantity = $("span[id$=lblSumQuantity]");
//    var newQuantitySum = CDbl(lblSumQuantity.html()) + CDbl(newValue) -  (CDbl(lblSumQuantity.html()) == 0 ? 0:CDbl(oldValue));
//    lblSumQuantity.html(FPrec(newQuantitySum));
//}

//function CalculateSumUnitCost(oldValue, newValue) {
//    var lblSumUnitCost = $("span[id$=lblSumUnitCost]");
//    var newUnitCostySum = CDbl(lblSumUnitCost.html()) + CDbl(newValue) - (CDbl(lblSumUnitCost.html()) == 0 ? 0 : CDbl(oldValue));
//    lblSumUnitCost.html(CCur(newUnitCostySum));
//}




function RDG_OnRowSelecting(sender, eventArgs) {
    var img = $("#" + eventArgs.get_id()).find("div[class$=SmallLink]")
    //var img2 = $("#" + eventArgs.get_id()).find("img[src$=smallGlobe.png]")
    if (img.length > 0)
        eventArgs.set_cancel(true);
}


