var OldQuantityVal = 0;
var OldUnitPriceVal = 0;
var OldOwnerBudgetVal = 0;
var OldUnitCostVal = 0;
var OldProjectBudgetVal = 0;
function OpenBudgetCostsPopup(BudgetRequestDetailId, UnitCost, OriginalProjectBudget, UnitPrice, OriginalOwnerBudget, Quantity, CurrencyId, ProjectId) {
    var grid = $find($("[id$=rdgBudgetRequestDetails]")[0].id);
    //    if (grid.get_masterTableView().get_selectedItems().length > 0) {
    //        var row = grid.get_masterTableView().get_selectedItems()[0];
    //        var BudgetDetailId = row.findElement("hdnBudgetDetailId").value;
    OpenPOPUp('CostManagementSpreadedBudgetRequestDetail.aspx?BudgetRequestDetailId=' + BudgetRequestDetailId + '&UnitCost=' + UnitCost + '&OriginalProjectBudget=' + OriginalProjectBudget + '&UnitPrice=' + UnitPrice + '&OriginalOwnerBudget=' + OriginalOwnerBudget + '&Quantity=' + Quantity + '&CurrencyId=' + CurrencyId + '&ProjectId=' + ProjectId, 940, 550, true);
    return false;
    //    }
}

function Calculate(row, sender, isItemInserted) {
    isItemInserted = isItemInserted || false;
    var Sync = row[0].attributes["sync"].value;
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QuantityVal = txtQuantity.val();

    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    var UnitPriceVal = txtUnitPrice.val();

    var txtScheduledQuantity = row.find("input[id$='txtUnitPrice']");
    var UnitPriceVal = txtScheduledQuantity.val();

    var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
    var OwnerBudgetVal = txtOwnerBudget.val();

    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();

    var txtProjectBudget = row.find("input[id$='txtProjectBudget']");
    var ProjectBudgetVal = txtProjectBudget.val();


    if (sender == "Quantity") {
        if (CDbl(QuantityVal) == 0) {
            QuantityVal = OldQuantityVal;
            txtQuantity.val(CDbl(OldQuantityVal));
        }

        txtOwnerBudget.val(CCur(CDbl(QuantityVal) * CDbl(UnitPriceVal)));
        txtProjectBudget.val(CCur(CDbl(QuantityVal) * CDbl(UnitCostVal)));
    }
    if (sender == "UnitPrice") {
        txtOwnerBudget.val(CCur(CDbl(QuantityVal) * CDbl(UnitPriceVal)));

    }
    if (sender == "OwnerBudget") {

        if (CDbl(QuantityVal) != 0) {
            txtUnitPrice.val(CCur(CDbl(OwnerBudgetVal) / CDbl(QuantityVal)))
        }
    }
    if (sender == "UnitCost") {
        txtProjectBudget.val(CCur(CDbl(QuantityVal) * CDbl(UnitCostVal)));
        if (Sync == 'True') {
            txtUnitPrice.val(CCur(CDbl(UnitCostVal)));
            txtOwnerBudget.val(CCur(CDbl(QuantityVal) * CDbl(UnitCostVal)));
        }
    }
    if (sender == "ProjectBudget") {

        if (CDbl(QuantityVal) != 0) {
            txtUnitCost.val(CCur(CDbl(ProjectBudgetVal) / CDbl(QuantityVal)));
            if (Sync == 'True') {
                txtUnitPrice.val(CCur(CDbl(ProjectBudgetVal) / CDbl(QuantityVal)));
                txtOwnerBudget.val(CCur(CDbl(txtProjectBudget.val())));
            }

        }

    }
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function (e) {
        chkUserUnits_OnChekedChanged(e, this);
    });

}

function AdjustCalculation(gridId, isItemInserted) {
    var grid = $("#" + gridId);
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "Quantity");
    }
    ).focus(function () {
        OldQuantityVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitPrice]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitPrice");
    }
    ).focus(function () {
        OldUnitPriceVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtOwnerBudget]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "OwnerBudget");
    }
    ).focus(function () {
        OldOwnerBudgetVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitCost", isItemInserted);
    }
    ).focus(function () {
        OldUnitCostVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtProjectBudget]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "ProjectBudget", isItemInserted);
    }
    ).focus(function () {
        OldProjectBudgetVal = $(this).val();
    }
    );

    $("a[id*=" + gridId + "][id$=btnGenerateFunding]").click(function () {

        var me = $(this);
        var tr = me.parents("tr:first");

        //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
        var detailId = -1;

        if (me.attr("detailid"))
            detailId = me.attr("detailid");


        //var costCode = tr.find("input[id*='ddlCostCodes']").val()

        //var amount = tr.find("input[id$='txtProjectBudget']").val()

        OpenPOPUp('FundingCostCodePopup.aspx?Source=BUDGET_REQUEST&DetailId=' + detailId, 870, 500, true, 'rdgBudgetRequestDetails');
        return false;
        //wnd.add_close(onClose);


    });
}

function ddlTasks_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first")
    var txtStart = tr.find("input[id$='txtStart']");
    var txtFinish = tr.find("input[id$='txtFinish']");
    txtStart.val(item.get_attributes().getAttribute("Start"));
    txtFinish.val(item.get_attributes().getAttribute("Finish"));
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



function AdjustPopupCalculation(gridId) {
    var grid = $("#" + gridId);


    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents("tr:first");
        PopupCalculate(row, "Quantity");
    });

    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents("tr:first");
        PopupCalculate(row, "UnitCost");
    });

    $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function () {
        var row = $(this).parents("tr:first");
        PopupCalculate(row, "TotalAmount");
    });
}

function PopupCalculate(row, Sender) {

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

