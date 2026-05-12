
function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var descriptions = item.get_text().split("-");
    var description = descriptions[1];
    for (var i = 2; i < descriptions.length; i++)
        description = description + "-" + descriptions[i]
    var row = $("#" + itemId).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $("#" + itemId).parents("tr:first")
    row.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));
}

function OpenBudgetCostsPopup(BudgetDetailId, UnitCost, OriginalProjectBudget,UnitPrice, OriginalOwnerBudget,Quantity,CurrencyId) {
    var grid = $find($("[id$=rdgBudgetDetails]")[0].id);
//    if (grid.get_masterTableView().get_selectedItems().length > 0) {
//        var row = grid.get_masterTableView().get_selectedItems()[0];
//        var BudgetDetailId = row.findElement("hdnBudgetDetailId").value;
    OpenPOPUp('CostManagementSpreadedBudgetDetail.aspx?BudgetDetailId=' + BudgetDetailId + '&UnitCost=' + UnitCost + '&OriginalProjectBudget=' + OriginalProjectBudget + '&UnitPrice=' + UnitPrice + '&OriginalOwnerBudget=' + OriginalOwnerBudget + '&Quantity=' + Quantity + '&CurrencyId=' + CurrencyId, 1050, 550, true);
    return false;
//    }
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first")
        tr.find("input[id$='txtOriginalOwnerBudget']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtUnitPrice']").val()))
                );
        tr.find("input[id$='txtOriginalProjectBudget']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtUnitCost']").val()))
                );
    });

    // On change unit price
    $("input[id*=" + gridId + "][id$=txtUnitPrice]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first")
        tr.find("input[id$='txtOriginalOwnerBudget']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
    });

    // On change original owner
    $("input[id*=" + gridId + "][id$=txtOriginalOwnerBudget]").change(function () {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first")

        var txtQuantity = tr.find("input[id$='txtQuantity']");
        var txtUnitPrice = tr.find("input[id$='txtUnitPrice']");

        var QantityVal = CDbl(txtQuantity.val());
        var UnitPrice = CDbl(txtUnitPrice.val());
        var Totalval = CDbl(me.val());

    if (QantityVal !=0) {
        txtUnitPrice.val(CCur(Totalval / QantityVal));
    }

    else {
        me.val(CCur(UnitPrice * QantityVal));
    }


    
    });

    // On change unit cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first")
        tr.find("input[id$='txtOriginalProjectBudget']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
        if (Sync == 'True') {
            var txtUnitPrice = tr.find("input[id$='txtUnitPrice']");
            txtUnitPrice.val(CCur(me.val()));
            txtUnitPrice.trigger('change');
        }
    });

    // On change original cost
    $("input[id*=" + gridId + "][id$=txtOriginalProjectBudget]").change(function () {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first")
        var txtUnitCost = tr.find("input[id$='txtUnitCost']");
        var txtQuantity = tr.find("input[id$='txtQuantity']");
        var UnitCost = CDbl(txtUnitCost.val());
        var QantityVal = CDbl(txtQuantity.val());
        var Totalval = CDbl(me.val());

        if (QantityVal != 0) {
            txtUnitCost.val(CCur(Totalval / QantityVal));
        }

        else {
            me.val(CCur(UnitCost * QantityVal));
        }


        if (Sync == 'True') {
            var txtOriginalOwnerBudget = tr.find("input[id$='txtOriginalOwnerBudget']");
            txtOriginalOwnerBudget.val(CCur(me.val()));
            txtOriginalOwnerBudget.trigger('change');
        }
    });

    $("a[id*=" + gridId + "][id$=btnGenerateFunding]").click(function(e) {

        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first")
        //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
        var detailId = -1;
        var CurrencyId = -1; 
        var costCode = '';
        if (me.attr("detailid"))
            detailId = me.attr("detailid");
       
        //var CurrentLineId = txtFundedId.substring(0, txtFundedId.lastIndexOf('_'))
        //var ddlCurrencies = $find(CurrentLineId + '_ddlCurrencies')
        //if (ddlCurrencies != null) {
        //    CurrencyId=ddlCurrencies.get_selectedItem().get_value();
        //}
         OpenPOPUp('FundingCostCodePopup.aspx?Source=BUDGET&DetailId=' + detailId , 870, 500, true, 'rdgBudgetDetails');
        return false;
        //wnd.add_close(onClose);


    });

}
function AdjustPopupCalculation(gridId) {
    var grid = $("#" + gridId);


    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var row = $(this).parents("tr:first");
        PopupCalculate(row, "Quantity");
    });

    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var row = $(this).parents("tr:first");
        PopupCalculate(row, "UnitCost");
    });

    $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function() {
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

//function onClose(window, result) {
//    if (result && result.get_argument()) {
//       

//        txtFunded.val(result.get_argument());


//    }
//}
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

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}



