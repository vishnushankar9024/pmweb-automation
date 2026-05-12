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


function CalculateExt(row, index) {
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var txtExtCost = row.find("input[id$='txtExtCost']");
    var hdnRevisedBy = row.find("input[id$='hdnRevisedBy']");
    var prec = Global_DecimalPrecision;
    Global_DecimalPrecision = 5
    var QantityVal = CDbl(txtQuantity.val());
    Global_DecimalPrecision = prec
    //txtExtCost.val(
    //        CDbl(CDbl(txtQuantity.val()) * CDbl(txtUnitCost.val()))
    //        );

    if (index == 0) { //
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        hdnRevisedBy.val('Q');

        if (txtUnitCost[0].isDisabled == true ||txtUnitCost[0].disabled == true) {
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
      
        txtExtCost.val(
            CCur(CDbl(QantityVal * CDbl(txtUnitCost.val())))
            );
    }

    if (index == 2) { //
        hdnRevisedBy.val('EC');
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