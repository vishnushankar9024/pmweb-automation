
var OldAmountVal = 0;
function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=txtAmount]").change(function() {
        var me = $(this);
        var row = me.parents("tr:first");
        var NewAmountVal = CDbl(me.val());

        var total = CDbl($("input[id$=txtTotalAuthorized]").val());
        var fundedAmount = CDbl(row.find("input[id$='hdnFunded']").val());
        var txtPercent = row.find("input[id$=txtPercent]")

        txtPercent.val(CPrct((NewAmountVal * 1.0 / fundedAmount) * 100));


        total = total + NewAmountVal - OldAmountVal;
        $("input[id$=txtTotalAuthorized]").val(CCur(total));

    }
    ).focus(function() {
        OldAmountVal = CDbl($(this).val());

    }
   );
    $("input[id*=" + gridId + "][id$=txtPercent]").change(function() {
        var me = $(this);
        var row = me.parents("tr:first");

        var txtAmount = row.find("input[id$=txtAmount]")
        var fundedAmount = CDbl(row.find("input[id$='hdnFunded']").val());
        var oldAmount = CDbl(txtAmount.val());
        var percent = CDbl(me.val());
        var total = CDbl($("input[id$=txtTotalAuthorized]").val());

        var newAmount = (percent / 100.00) * fundedAmount;
        txtAmount.val(CCur(newAmount));

        total = total + newAmount - oldAmount;
        $("input[id$=txtTotalAuthorized]").val(CCur(total));


    });
}