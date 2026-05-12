var OldID

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtPayTypeId]").change(function() {
        var row = $(this).parents("tr:first"); Calculate(row, "ID");
    }
    ).focus(function() {
        OldID = $(this).val();
    }
    );
}
function Calculate(row, sender) {
    if (sender == "ID") {
        var txtAbbreviation = row.find("input[id$='txtAbbreviation']");
        var txtPayTypeId = row.find("input[id$='txtPayTypeId']");
        txtAbbreviation.val(txtPayTypeId.val());
    
    } 
}