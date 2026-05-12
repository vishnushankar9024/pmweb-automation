var OldScoreQuantityVal = 0;
var OldScoreUnitCostVal = 0;
var OldScoreTotalCostVal = 0;

function AdjustScoreCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Score
    $("input[id*=" + gridId + "][id$=txtScore]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Score");
    }
    ).focus(function () {
        OldScoreUnitCostVal = $(this).val();
    }
    );

    // On change Points
    $("input[id*=" + gridId + "][id$=txtPointsAvailable]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateWeightedScore(row, "PointAvailable");
    }
    ).focus(function () {
        OldScoreQuantityVal = $(this).val();
    }
    );

    // On change Weight
    $("input[id*=" + gridId + "][id$=txtWeight]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Weight");
    }
    ).focus(function () {
        OldScoreTotalCostVal = $(this).val();
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
    if (CDbl(WeightVal) > CDbl(100)) {
        WeightVal = CDbl(100);
    }
    var txtWeightedScore = row.find("input[id$='txtWeightedScore']");

    if (PointsVal == 0) {
        txtWeightedScore.val(FPrec(0));

    }
    else {

        txtWeightedScore.val(FPrec((CDbl(ScoreVal) / CDbl(PointsVal)) * CDbl(WeightVal)));
    }



}



