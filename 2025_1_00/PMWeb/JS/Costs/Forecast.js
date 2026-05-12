
function ForeCast_RowDeselected(sender, args) {
    var btnForecastLine = $("[id*=" + sender.get_id() + "][id$=btnForeCastSelectedLine]");
    if (args.get_tableView().get_selectedItems().length > 1) {
        btnForecastLine.hide();
    } else {
        btnForecastLine.show();
    }
}


function ForeCast_RowSelected(sender, args) {
    var btnForecastLine = $("[id*=" + sender.get_id() + "][id$=btnForeCastSelectedLine]");
    if (args.get_tableView().get_selectedItems().length <= 1) {
        btnForecastLine.show();
    } else {
        btnForecastLine.hide();
    }
}

function OpenForecastCostsPopup(ForecastDetailId, UnitCost, ForecastToComplete, BalanceToComplete, Quantity, CurrencyId) {
    var grid = $find($("[id$=rdgForecastDetails]")[0].id);
//    if (grid.get_masterTableView().get_selectedItems().length > 0) {
//        var row = grid.get_masterTableView().get_selectedItems()[0];
//        var ForecastDetailId = row.findElement("hdnForecastDetailId").value;
    OpenPOPUp('CostManagementForecastPopup.aspx?ForecastDetailId=' + ForecastDetailId + '&UnitCost=' + UnitCost + '&ForecastToComplete=' + ForecastToComplete + '&BalanceToComplete=' + BalanceToComplete + '&Quantity=' + Quantity + '&CurrencyId=' + CurrencyId, 940, 550, true, 'rdgForecastDetails');
    return false;
        //  }
}

function Calculate(row,Sender) {
    
    
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QantityVal = txtQuantity.val();
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();
    var txtTotalAmount = row.find("input[id$='txtTotalAmount']");
    var TotalAmountVal = txtTotalAmount.val();
        if ((Sender == 'Quantity') || (Sender == 'UnitCost')) {
            txtTotalAmount.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));
        }
        if (Sender == 'TotalAmount') {
            if (QantityVal == 0) {
                QantityVal = 1;
                txtQuantity.val(FPrec(1));
            }
            txtUnitCost.val(CCur(CDbl(TotalAmountVal) / CDbl(QantityVal)));
        }
    }

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
    var row = $(this).parents("tr:first");
     Calculate(row, "Quantity");
    });

    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "UnitCost");
    });

    $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "TotalAmount");
    });
}


function ddlTasks_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first");
    var txtStart = tr.find("input[id$='txtStart']");
    var txtFinish = tr.find("input[id$='txtFinish']");
    var txtPctComplete = tr.find("input[id$='txtPctComplete']"); 
    txtStart.val(item.get_attributes().getAttribute("Start"));
    txtFinish.val(item.get_attributes().getAttribute("Finish"));
    txtPctComplete.val(item.get_attributes().getAttribute("PctComplete"));

    var QuantityToComplete = CDbl(tr.find("input[id$='txtQuantity']").val());
    var txtquantityCompleted = tr.find("input[id$='txtQuantityCompleted']");
    var QuantityCompleted;
    var PctComplete = CDbl(txtPctComplete.val())

    QuantityCompleted = CDbl((PctComplete * QuantityToComplete) / 100);
    txtquantityCompleted.val(CDbl(QuantityCompleted));
}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}
function AdjustDetailGridCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        DetailGridCalculate(row, "UnitCost");
    }
    ).focus(function() {
        OldUnitCostVal = $(this).val();
    }
    );

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        DetailGridCalculate(row, "Quantity");
        var quantityCompleted = CDbl(row.find("input[id$='txtQuantityCompleted']").val());
        var txtPctComplete = row.find("input[id$='txtPctComplete']");
        var pctComplete;
        var QuantityToComplete = CDbl($(this).val());

        if (QuantityToComplete != 0) {
            pctComplete = (quantityCompleted * 1.0 / QuantityToComplete) * 100;
            txtPctComplete.val(CPrct(pctComplete));
        }
        else {
            txtPctComplete.val(CPrct(0));
        }
    }
    ).focus(function() {
        OldQuantityVal = $(this).val();
    }
    );

    // On change ExtCost
    $("input[id*=" + gridId + "][id$=txtForecastToComplete]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        DetailGridCalculate(row, "TotalCost");
    }
    ).focus(function() {
        OldTotalCostVal = $(this).val();
    }
    );

    $("input[id*=" + gridId + "][id$=txtForecastAtCompletion]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var txtTotalCost = row.find("input[id$='txtForecastToComplete']");
        var AntCost = CDbl(row.find("input[id$='hdnAntCost']").val());
        var QuantityToComplete = CDbl(row.find("input[id$='txtQuantity']").val());
        txtTotalCost.val(CCur(CDbl($(this).val()) - CDbl(AntCost)));
        var txtUnitCost = row.find("input[id$='txtUnitCost']");
      
       
            if (QuantityToComplete == 0) {
                row.find("input[id$='txtQuantity']").val(1);
                txtUnitCost.val(txtTotalCost.val());
            }
            else {

                txtUnitCost.val(CCur(CDbl(txtTotalCost.val())/ QuantityToComplete));
            }

       
   
        }
   
    );



    $("input[id*=" + gridId + "][id$=txtQuantityCompleted]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var QuantityToComplete = CDbl(row.find("input[id$='txtQuantity']").val());
        var txtPctComplete = row.find("input[id$='txtPctComplete']");
        var pctComplete;
        var quantityCompleted = CDbl($(this).val());

        if (QuantityToComplete != 0) {
            pctComplete = (quantityCompleted * 1.0 / QuantityToComplete) * 100;
            txtPctComplete.val(CPrct(pctComplete));

        }
        else {
            txtPctComplete.val(CPrct(0));
        }

    }
    );

    $("input[id*=" + gridId + "][id$=txtPctComplete]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var QuantityToComplete = CDbl(row.find("input[id$='txtQuantity']").val());
        var txtquantityCompleted = row.find("input[id$='txtQuantityCompleted']");
        var QuantityCompleted;
        var PctComplete = CDbl($(this).val());

        QuantityCompleted = CDbl((PctComplete * QuantityToComplete) / 100);
        txtquantityCompleted.val(CDbl(QuantityCompleted));


    }
);
  

}


function OpenProductionPopup() {
    OpenPOPUp("ProductionPopup.aspx?Source=COSTMANAGEMENT_FORECAST", 700, 500, true);
}


function DetailGridCalculate(row, sender) {
    var txtTotalCost = row.find("input[id$='txtForecastToComplete']");
    var TotalCostVal = txtTotalCost.val();

    var txtForecastAtCompletion = row.find("input[id$='txtForecastAtCompletion']");
    var AntCost = CDbl(row.find("input[id$='hdnAntCost']").val());

    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QantityVal = txtQuantity.val();
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();

    if (sender == "TotalCost") {
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        txtUnitCost.val(CCur(CDbl(TotalCostVal) / CDbl(QantityVal)));
        txtForecastAtCompletion.val(CCur(CDbl(AntCost) + CDbl(TotalCostVal)));
    }
    else {
        txtTotalCost.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));
        txtForecastAtCompletion.val(CCur(CDbl(AntCost) + CDbl(txtTotalCost.val())));
    }
}