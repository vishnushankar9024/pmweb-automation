var OldQuantityVal = 0;
var OldUnitCostVal = 0;
var OldTotalCostVal = 0;
var OldMarkupPctl = 0;
var OldMarkup = 0;
function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
    $("input[type='checkbox'][Id*='billing']").click(function () {
        //BindBilling();
    }
   );
    //BindBilling();
}
function BindBilling() {
    if ($("input[id$=chkAllowOverbilling]").is(":checked")) {
        $('[id$=lblAllowbilling]').show();
        $('[id$=lblDoNotAllowOverbilling]').hide();
        $('[id$=divOverBilling]').show();

    }
    else {
        $('[id$=lblAllowbilling]').hide();
        $('[id$=lblDoNotAllowOverbilling]').show();
        $('[id$=divOverBilling]').hide();
        $('input[id$=txtAllowbillingUpTo]').val(CPrct(0));
        $('input[id$=txtLineAllowbillingUpTo]').val(CPrct(0));
        $("input[type='checkbox'][Id$=chkLine]").removeAttr('checked');
        $("input[type='checkbox'][Id$=chkTotal]").removeAttr('checked');
    }
}

function OpenPrimeContractsPopup(BudgetDetailId, UnitCost, OriginalProjectBudget, Quantity, CurrencyId, IsLinkedContractDetail) {
    OpenPOPUp('CostManagementSpreadedContractDetail.aspx?ContractDetailId=' + BudgetDetailId + '&UnitCost=' + UnitCost + '&OriginalProjectBudget=' + OriginalProjectBudget + '&Quantity=' + Quantity + '&CurrencyId=' + CurrencyId + '&IsLinkedContractDetail=' + IsLinkedContractDetail, 940, 550, true);
    return false;
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

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitCost");
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
        Calculate(row, "Quantity");
    }
    ).focus(function() {
        OldQuantityVal = $(this).val();
    }
    );
    //On Adjustment1 change
    $("input[id*=" + gridId + "][id$=txtShipping]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "shipping");
    }
  ).focus(function () {
      OldQuantityVal = $(this).val();
  }
  );
    //on tax changed
    $("input[id*=" + gridId + "][id$=txtTax]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "tax");
    }
).focus(function () {
    OldQuantityVal = $(this).val();
}
);
    //on adjustment2 change
    $("input[id*=" + gridId + "][id$=txtAdjustments]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "Adjustments");
    }
).focus(function () {
    OldQuantityVal = $(this).val();
}
);
    // On change ExtCost
    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalCost");
    }
    ).focus(function() {
        OldTotalCostVal = $(this).val();
    }
    );
//    $("input[id*=" + gridId + "][id$=txtMarkupPct]").change(function() {
//        var row = $(this).parents("tr:first"); Calculate(row, "MarkupPct");
//    }
//    ).focus(function() {
//        OldMarkupPctl= $(this).val();
//    }
//    );
//    $("input[id*=" + gridId + "][id$=txtMarkupPct]").change(function() {
//        var row = $(this).parents("tr:first"); Calculate(row, "MarkupPct");
//    }
//    ).focus(function() {
//        OldMarkupPctl = $(this).val();
//    }
//    );
//    $("input[id*=" + gridId + "][id$=txtMarkup]").change(function() {
//        var row = $(this).parents("tr:first"); Calculate(row, "Markup");
//    }
//    ).focus(function() {
//        OldMarkup = $(this).val();
//    }
//    );
}

function Calculate(row, sender) {
    var txtTotalCost = row.find("input[id$='txtTotalCost']");
    var TotalCostVal = txtTotalCost.val();

    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QantityVal = CDbl(txtQuantity.val());
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();

    var txtTax = row.find("input[id$='txtTax']");
    var txtTaxVal = txtTax.val();
    var txtShipping = row.find("input[id$='txtShipping']");
    var txtShippingVal = txtShipping.val();
    var txtAdjustments = row.find("input[id$='txtAdjustments']");
    var txtAdjustmentsVal = txtAdjustments.val();
    var sumAdj = CDbl(txtAdjustmentsVal) + CDbl(txtShippingVal) + CDbl(txtTaxVal);
  //  var sum = CCur(CDbl(txtTaxVal) + CCur(CDbl(txtShippingVal) + CCur(CDbl(txtAdjustmentsVal);
   // alert(sum);
//    var txtMarkupPct = row.find("input[id$='txtMarkupPct']");
//    var MarkupPctVal = txtMarkupPct.val();
//    var txtMarkup = row.find("input[id$='txtMarkup']");

    var lblTotalPrice = row.find("span[id$='lblTotalPrice']");
    
    
//    var MarkupVal = txtMarkup.val();
//    if (CDbl(MarkupPctVal) > 100) {
//        MarkupPctVal = 100;

//    }
//    if (CDbl(MarkupPctVal) < 0) {
//        MarkupPctVal = 0;

//    }
    if (sender == "TotalCost") {
    if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
    txtUnitCost.val(CCur(CDbl(TotalCostVal) / CDbl(QantityVal)));
//        txtMarkup.val(CCur(CDbl(MarkupPctVal) * CDbl(TotalCostVal) / 100))
    }
    else if (sender == "UnitCost" || sender == "Quantity") {
        
        txtTotalCost.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));
//        txtMarkup.val(CCur(CDbl(MarkupPctVal) * CDbl(txtTotalCost.val()) / 100))
    }
//    else if (sender == "MarkupPct") {
//        txtMarkup.val(CCur(CDbl(MarkupPctVal) * CDbl(TotalCostVal) / 100))

//    }
//    else if (sender == "Markup") {
//    var per = CDbl(txtMarkup.val()) / CDbl(TotalCostVal);
//    per = per * 100;
//    if (per > 100) {
//        per = 100;
//        txtMarkup.val(CCur(CDbl(per) * CDbl(TotalCostVal) / 100));
//    }
//    txtMarkupPct.val(CPrct(CDbl(per)));
//    
//    }
    //    lblTotalPrice.html(CCur(CDbl(txtTotalCost.val()) + CDbl(txtMarkup.val())));
    var totalPrice = sumAdj + CDbl(txtTotalCost.val());
    // lblTotalPrice.html(CCur(txtTotalCost.val()));
    lblTotalPrice.html(CCur(totalPrice));
}