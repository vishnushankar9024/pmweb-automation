function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);

 


    // On change probability value
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtProbabilityValue]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var probabilityValue = CDbl($(this).val());
        var impactValue = CDbl(row.find("input[id$='txtImpactValue']").val());
        var cost = CDbl(row.find("input[id$='txtCost']").val());
        var time = CDbl(row.find("input[id$='txtTime']").val());
        
        row.find("input[id$='txtRiskValue']").val(FPrec(impactValue * probabilityValue));
        row.find("input[id$='txtRiskCost']").val(CCur(cost * probabilityValue));
        row.find("input[id$='txtRiskDelay']").val(FPrec(time * probabilityValue));

    });
    
    // On change impact value
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtImpactValue]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var impactValue = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        row.find("input[id$='txtRiskValue']").val(FPrec(impactValue * probabilityValue));



    });

    // On change Cost
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var Cost = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtRiskCost']").val(CCur(Cost * probabilityValue));

        }

    });
    
    // On change Time
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtTime]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var Time = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtRiskDelay']").val(FPrec(Time * probabilityValue));

        }

    });
    // On change risk Impact
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtRiskValue]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var riskImpact = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtImpactValue']").val(FPrec(riskImpact / probabilityValue));

        }

    });
    
    // On change risk Cost
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtRiskCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var riskCost = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtCost']").val(CCur(riskCost / probabilityValue));

        }
        
    });

    // On change risk Delay
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtRiskDelay]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var riskDelay = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtTime']").val(FPrec(riskDelay / probabilityValue));

        }

    });
                  /*              Contingencies           */
                 
                 
    // On change probability value
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtProbabilityValue]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var probabilityValue = CDbl($(this).val());
        var impactValue = CDbl(row.find("input[id$='txtImpactValue']").val());
        var cost = CDbl(row.find("input[id$='txtCost']").val());
        var time = CDbl(row.find("input[id$='txtTime']").val());

        row.find("input[id$='txtRiskValue']").val(FPrec(impactValue * probabilityValue));
        row.find("input[id$='txtRiskCost']").val(CCur(cost * probabilityValue));
        row.find("input[id$='txtRiskDelay']").val(FPrec(time * probabilityValue));

    });

    // On change impact value
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtImpactValue]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var impactValue = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        row.find("input[id$='txtRiskValue']").val(FPrec(impactValue * probabilityValue));



    });
    // On change Cost
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var Cost = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtRiskCost']").val(CCur(Cost * probabilityValue));

        }

    });

    // On change Time
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtTime]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var Time = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtRiskDelay']").val(FPrec(Time * probabilityValue));

        }

    });
    // On change risk Impact
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtRiskValue]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var riskImpact = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtImpactValue']").val(FPrec(riskImpact / probabilityValue));

        }

    });
    
    // On change risk Cost
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtRiskCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var riskCost = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtCost']").val(CCur(riskCost / probabilityValue));

        }

    });

    // On change risk Delay
    $("input[id*=" + gridId + "][id *= '_Detail'][id$=txtRiskDelay]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        var riskDelay = CDbl($(this).val());
        var probabilityValue = CDbl(row.find("input[id$='txtProbabilityValue']").val());

        if (probabilityValue != 0) {
            row.find("input[id$='txtTime']").val(FPrec(riskDelay / probabilityValue));

        }

    });
    
}

