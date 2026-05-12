function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateExt(row,0);
    });

    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateExt(row,1);
    });

    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateExt(row, 2);
    });

   
}

function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var description = item._attributes.getAttribute("Description");

    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first")
    tr.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));
}


function CalculateExt(row, index) {
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var txtExtCost = row.find("input[id$='txtExtCost']");
    var hdnRevisedBy = row.find("input[id$='hdnRevisedBy']");
    var prec = Global_DecimalPrecision;
    Global_DecimalPrecision = 5
    
    Global_DecimalPrecision = prec
    //txtExtCost.val(
    //        CDbl(CDbl(txtQuantity.val()) * CDbl(txtUnitCost.val()))
    //        );

    if (index == 0) { //
        var QantityVal = CDbl(txtQuantity.val());
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        hdnRevisedBy.val('Q');
        if (!(txtUnitCost[0] && txtExtCost[0])) return;
            if (txtUnitCost[0].isDisabled == true || txtUnitCost[0].disabled == true) {
                txtExtCost.val(CCur(CDbl(QantityVal * CDbl(txtUnitCost.val()))));
            } else {
                txtUnitCost.val(CCur(CDbl(txtExtCost.val()) / QantityVal));
            }
            var prec = Global_DecimalPrecision;
            Global_DecimalPrecision = 5
            txtQuantity.val(FPrec(QantityVal));
            Global_DecimalPrecision = prec
    }

    if (index == 1) { //
        hdnRevisedBy.val('UC');
       
        if (!(txtQuantity[0] && txtExtCost[0])) return;
            var QantityVal = CDbl(txtQuantity.val());
            txtExtCost.val(
                CCur(CDbl(QantityVal * CDbl(txtUnitCost.val())))
                );
    }

    if (index == 2) { //
        hdnRevisedBy.val('EC');
        if (!(txtQuantity[0] && txtUnitCost[0])) return;
        var prec = Global_DecimalPrecision;
        Global_DecimalPrecision=5
        var QantityVal = CDbl(txtQuantity.val());
        Global_DecimalPrecision = prec
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        if (txtUnitCost[0].isDisabled == true || txtUnitCost[0].disabled == true) {
            if (CDbl(txtUnitCost.val()) != 0) {
                var QantityVal = CDbl(txtExtCost.val()) / CDbl(txtUnitCost.val())
                var prec = Global_DecimalPrecision;
                Global_DecimalPrecision=5
                txtQuantity.val(FPrec(CDbl(QantityVal)));
                Global_DecimalPrecision = prec
            }
          
        } else {
            txtUnitCost.val(CCur(CDbl(txtExtCost.val()) / QantityVal));
        }

    }

}

//function CalculateUnitCost(row) {
//    var txtQuantity = row.find("input[id$='txtQuantity']");
//    var txtUnitCost = row.find("input[id$='txtUnitCost']");
//    var txtExtCost = row.find("input[id$='txtExtCost']");

//    if (CDbl(txtQuantity.val()) == 0) {

//        txtUnitCost.val(
//            CDbl(CDbl(txtExtCost.val()))
//            );
//        txtQuantity.val(FPrec(1));

//    }
//    else {
//        txtUnitCost.val(
//            CDbl(CDbl(txtExtCost.val()) / CDbl(txtQuantity.val()))
//            );
    
//    }




//}