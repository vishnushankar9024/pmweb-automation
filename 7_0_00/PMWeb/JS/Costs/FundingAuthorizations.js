function ddlFundingCode_OnClientSelectedIndexChanged() {
    var ddlFundingCode = $("[id$=ddlFundingCode]")[0]; 
    var txtRevisedFunding = $("[id$=txtRevisedFunding]")[1];
    var txtPriorAuthorized = $("[id$=txtPriorAuthorized]")[0];
    var txtThisAuthorization = $("[id$=txtThisAuthorization]")[0];

    var Item = ddlFundingCode.item(ddlFundingCode.selectedIndex)
    if (Item != null) {
        var Revised = Item.getAttribute("RevisedFunding");
        var Prior = Item.getAttribute("PriorAuthorized");
        var a = CDbl(Revised) - CDbl(Prior);
        txtRevisedFunding.innerText=CCur(Revised);
        txtPriorAuthorized.innerText = CCur(Prior);
        txtThisAuthorization.innerText=CCur(a);
    
    }
}


function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtThisAuthorization']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtUnitCost']").val()))
                );
    });

    // On change unit cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtThisAuthorization']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
    });

    // On change original cost
    $("input[id*=" + gridId + "][id$=txtThisAuthorization]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtUnitCost']").val(
                CCur(CDbl(me.val()) / CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
    });
}