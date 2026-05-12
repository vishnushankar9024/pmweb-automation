/// <reference path="../jQuery-vsdoc.js" />
/// <reference path="../formatter.js" />

function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var description = item._attributes.getAttribute("Description");

    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first")
    tr.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));
}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function (e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
}


function OpenCEPopup() {
    OpenPOPUp('CommimentCOCEPopup.aspx', 800, 500, true);
}


var showConfirm = 1;
function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}





function Calculate(row, toCalculate) {
    var hdnRevisedBy = row.find("input[id$='hdnRevisedBy']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var prec = Global_DecimalPrecision;
    Global_DecimalPrecision = 5
    var QuantityVal = CDbl(txtQuantity.val());
    Global_DecimalPrecision = prec
    var txtUnitCostApproved = row.find("input[id$='txtUnitCostApproved']");
    var UnitCostApprovedVal = CDbl(txtUnitCostApproved.val());
    var txtAmountApproved = row.find("input[id$='txtAmountApproved']");
    var AmountApprovedVal = CDbl(txtAmountApproved.val());

    var txtUnitCostRequested = row.find("input[id$='txtUnitCostRequested']");
    var UnitCostRequestedVal = CDbl(txtUnitCostRequested.val());
    var txtAmountRequested = row.find("input[id$='txtAmountRequested']");
    var AmountRequestedVal = CDbl(txtAmountRequested.val());
    if (toCalculate == "AmountRequested") {
        hdnRevisedBy.val('VR');
        if (QuantityVal == 0) {
            QuantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        if (txtUnitCostRequested[0].isDisabled == true || txtUnitCostRequested[0].disabled == true) {
            if (UnitCostRequestedVal != 0) {

                var prec = Global_DecimalPrecision;
                Global_DecimalPrecision = 5
                var QuantityVal = CDbl(AmountRequestedVal / UnitCostRequestedVal)
                txtQuantity.val(FPrec(CDbl(QuantityVal)));
                Global_DecimalPrecision = prec
                txtAmountApproved.val(CCur(UnitCostApprovedVal * (AmountRequestedVal / UnitCostRequestedVal)));
            }
        } else {
            txtUnitCostRequested.val(CCur(AmountRequestedVal / QuantityVal))
            txtUnitCostApproved.val(CCur(AmountRequestedVal / QuantityVal))
            txtAmountApproved.val(CCur(AmountRequestedVal));

        }
    }
    else if (toCalculate == "UnitCostRequested") {
        hdnRevisedBy.val('UR');
        txtAmountRequested.val(CCur(UnitCostRequestedVal * QuantityVal))
        txtUnitCostApproved.val(CCur(UnitCostRequestedVal))
        txtAmountApproved.val(CCur(UnitCostRequestedVal * QuantityVal));
    } else if (toCalculate == "AmountApproved") {
        hdnRevisedBy.val('VA');
        if (QuantityVal == 0) {
            QuantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        if ((txtUnitCostApproved[0].isDisabled == true || txtUnitCostApproved[0].disabled == true)) {
            if ((UnitCostApprovedVal != 0) && (txtQuantity[0].isDisabled == false || txtQuantity[0].disabled == false)) {

                var prec = Global_DecimalPrecision;
                Global_DecimalPrecision = 5
                var QuantityVal = CDbl(AmountApprovedVal / UnitCostApprovedVal)
                txtQuantity.val(FPrec(CDbl(QuantityVal)));
                Global_DecimalPrecision = prec
            }

            //txtAmountRequested.val(CCur(UnitCostRequestedVal * (AmountApprovedVal / UnitCostApprovedVal)));

        } else {
            txtUnitCostApproved.val(CCur(AmountApprovedVal / QuantityVal))
        }
    }
    else if (toCalculate == "UnitCostApproved") {
        hdnRevisedBy.val('UA');
        txtAmountApproved.val(CCur(UnitCostApprovedVal * QuantityVal));
    }
    else if (toCalculate == "Amounts") {
        hdnRevisedBy.val('Q');
        txtAmountRequested.val(CCur(UnitCostRequestedVal * QuantityVal));
        txtAmountApproved.val(CCur(UnitCostApprovedVal * QuantityVal));
        Global_DecimalPrecision = 5
        txtQuantity.val(FPrec(QuantityVal));
        Global_DecimalPrecision = prec
    }
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    $("a[id*=" + gridId + "][id$=btnGenerateFunding]").click(function (e) {

        var me = $(this);
        var tr = me.parents("tr:first");

        //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
        var detailId = -1;

        if (me.attr("detailid"))
            detailId = me.attr("detailid");


        //var costCode = tr.find("input[id*='ddlCostCodes']").val()

        //var amount = tr.find("input[id$='txtAmountApproved']").val()

        OpenPOPUp('FundingCostCodePopup.aspx?Source=COMMITMENT_CO&DetailId=' + detailId, 870, 500, true, 'rdgCommitmentCODetails');
        return false;
        //wnd.add_close(onClose);


    });
    // On change UnitCost
    $("input[id*=" + gridId + "][id$=txtUnitCostApproved]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitCostApproved");
    });

    $("input[id*=" + gridId + "][id$=txtAmountApproved]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "AmountApproved");
    });

    $("input[id*=" + gridId + "][id$=txtUnitCostRequested]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitCostRequested");
    });

    $("input[id*=" + gridId + "][id$=txtAmountRequested]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "AmountRequested");
    });

    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "Amounts");
    });

}