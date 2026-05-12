var OldQuantityVal = 0;
var OldUnitCostVal = 0;
var OldTotalCostVal = 0;
var currencyCombo;
function ddlPeriods_OnClientSelectedIndexChanged(sender, eventArgs) {

    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var year = item.get_attributes().getAttribute("BudgetYear")
    var RowContainer = $("#" + itemId).parents(".rgEditForm:first");
    if (!RowContainer || RowContainer.length == 0)  
        RowContainer =  $("#" + itemId).parents("tr:first");
    var rntYear = $find(RowContainer.find("input[id*='rntYear']")[0].id);

    if (year.length > 0) {
        rntYear.set_value(year);
    }
    else
        rntYear.clear();
} 

Sys.Application.add_load(BindOnload);
function BindOnload() {
    if ($("[id$=ddlStatus]").length == 0) {
        return false;
    }
    var ddlStatus = $find($("[id$=ddlStatus]")[0].id);
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}
function ddlCurrencyLoad(sender,e) {
    currencyCombo = sender ; 
}

function onSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var currencyId = item.get_attributes().getAttribute("CurrencyId");
    //    alert(currencyCombo.get_value());
    var item = currencyCombo.findItemByValue(currencyId);
    currencyCombo.trackChanges();
    //    currencyCombo.set_value(currencyId);
    if (item)
        item.select();
    currencyCombo.commitChanges(); 
//    alert(currencyCombo.get_value()); 
    
}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
        chkUserUnits_OnChekedChanged(e, this);
    });

}
function Calculate(row, sender, QuantityMultiplier) {

    var txtTotalCost = row.find("input[id$='txtTotalCost']");
    var TotalCostVal = txtTotalCost.val();
    var lblExtentedQuantity = row.find("span[id$='lblExtentedQuantity']")
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QantityVal = txtQuantity.val();
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();
    var txtExtCost = row.find("input[id$='txtExtCost']");
    var ExtCostVal = txtExtCost.val();
    var lblEditAdjustment1 = row.find("span[id$='lblEditAdjustment1']");
    var Adjustment1Val = lblEditAdjustment1.html();
    var lblEditAdjustment2 = row.find("span[id$='lblEditAdjustment2']");
    var Adjustment2Val = lblEditAdjustment2.html();
    var lblEditTax = row.find("span[id$='lblEditTax']");
    var TaxVal = lblEditTax.html();
    if (sender == "TotalCost" ) {
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
            lblExtentedQuantity.text(CPDbl(QantityVal));
        }        
        lblExtentedQuantity.text(FPrec(CPDbl(QantityVal) * QuantityMultiplier));
        txtExtCost.val(CCur(CDbl(TotalCostVal) - CDbl(Adjustment1Val) - CDbl(Adjustment2Val) - CDbl(TaxVal)));
        var ExtCostVal = txtExtCost.val();
        txtUnitCost.val(CCur(CDbl(ExtCostVal) / (CDbl(QantityVal) * QuantityMultiplier)));
    }
    if (sender == "ExtCost") {
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
            lblExtentedQuantity.text(CPDbl(QantityVal));
        }
        lblExtentedQuantity.text(FPrec(CPDbl(QantityVal) * QuantityMultiplier));
        txtUnitCost.val(CCur(CDbl(ExtCostVal) / (CDbl(QantityVal) * QuantityMultiplier)));
        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));
    }

    if (sender == "Quantity") {
        lblExtentedQuantity.text(FPrec(CPDbl(QantityVal) * QuantityMultiplier));
        txtExtCost.val(CCur(CPDbl(QantityVal) * QuantityMultiplier * CDbl(UnitCostVal)));
        ExtCostVal = txtExtCost.val();
        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));
    }
    if (sender == "UnitCost") {
        txtExtCost.val(CCur(CPDbl(QantityVal) * QuantityMultiplier * CDbl(UnitCostVal)));
        ExtCostVal = txtExtCost.val();
        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));
    }
}

function CalculateSumTotalCostVal(oldValue, newValue) {

    var lblSumTotalCost = $("span[id$=lblSumTotalCost]");
    var newTotalTotalCost = CDbl(lblSumTotalCost.html()) + CDbl(newValue) - (CDbl(lblSumTotalCost.html()) == 0 ? 0 : CDbl(oldValue)); ;
    lblSumTotalCost.html(CCur(newTotalTotalCost));
}

function CalculateSumQuantity(oldValue, newValue) {

    var lblTotalQuantity = $("span[id$=lblTotalQuantity]");
    var newQuantitySum = CDbl(lblTotalQuantity.html()) + CDbl(newValue) - (CDbl(lblTotalQuantity.html()) == 0 ? 0 : CDbl(oldValue)); ;
    lblTotalQuantity.html(FPrec(newQuantitySum));
}

function CalculateSumUnitCost(oldValue, newValue) {

    var lblTotalUnitCost = $("span[id$=lblTotalUnitCost]");
    var newUnitCostySum = CDbl(lblTotalUnitCost.html()) + CDbl(newValue) - (CDbl(lblTotalUnitCost.html()) == 0 ? 0 : CDbl(oldValue)); ;
    lblTotalUnitCost.html(CCur(newUnitCostySum));
}

function CalculateSumTotalCost(oldValue, newValue) {

    var lblSumTotalCost = $("span[id$=lblSumTotalCost]");
    var oldSumTotalCostValues = CDbl($(lblSumTotalCost).html());
    var SumVal = CCur(oldSumTotalCostValues - oldValue + newValue);
    lblSumTotalCost.html(SumVal);
}

function AdjustCostCalculation(gridId, QuantityMultiplier) {


    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)  
            row = $(this).parents("tr:first");
        Calculate(row, "UnitCost", QuantityMultiplier);
    }
    ).focus(function() {
        OldUnitCostVal = $(this).val();
    }
    );

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "Quantity", QuantityMultiplier);
    }
    ).focus(function() {
        OldQuantityVal = $(this).val();
    }
    );

    // On change TotalCost
    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalCost", QuantityMultiplier);
    }
    ).focus(function() {
        OldTotalCostVal = $(this).val();
    }
    );

    // On change ExtCost
    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "ExtCost", QuantityMultiplier);
    }
    ).focus(function () {
        OldTotalCostVal = $(this).val();
    }
    );

}




function AdjustScoreCalculation(gridId) {

    var grid = $("#" + gridId);
    // On change Score
    $("input[id*=" + gridId + "][id$=txtScore]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateWeightedScore(row, "Score");
    }
    ).focus(function() {
        OldUnitCostVal = $(this).val();
    }
    );

    // On change Points
    $("input[id*=" + gridId + "][id$=txtPointsAvailable]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateWeightedScore(row, "PointAvailable");
    }
    ).focus(function() {
        OldQuantityVal = $(this).val();
    }
    );

    // On change Weight
    $("input[id*=" + gridId + "][id$=txtWeight]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateWeightedScore(row, "Weight");
    }
    ).focus(function() {
        OldTotalCostVal = $(this).val();
    }
    );


}


function CalculateWeightedScore(row, sender) {


    var txtScore = row.find("input[id$='txtScore']");
    var ScoreVal = txtScore.val();

    var txtPointsAvailable = row.find("input[id$='txtPointsAvailable']");
    var PointsVal = txtPointsAvailable.val();
    
    var txtWeight = row.find("input[id$='txtWeight']");
    var WeightVal = txtWeight.val();
    if( CDbl(WeightVal)>CDbl(100)){
    WeightVal=CDbl(100);
    }
    var txtWeightedScore=row.find("input[id$='txtWeightedScore']");
    
    if(PointsVal ==0)
    {
     txtWeightedScore.val(FPrec(0));
    
    }
    else {
    
     txtWeightedScore.val(FPrec((CDbl(ScoreVal)/CDbl(PointsVal))*CDbl(WeightVal)));
    }


    
}

