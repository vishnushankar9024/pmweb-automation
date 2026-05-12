function pageLoad() {
    var rdgProcurementBidders = $("div[id$='rdgProcurementBidders']");
    var btnAward = rdgProcurementBidders.find("[id$='btnAward']");
    if (btnAward.length > 0) {
        window['AwardId'] = btnAward[0].id;
    }
}


function OpenMultipleCompaniesPopup() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var left = (browserWidth - (browserWidth * 0.9)) / 2;
    var top = (browserHeight - (browserHeight * 0.9)) / 2;
    var ProjectId = 0;
    if ($("div[id*=ddlProject]")[0] != null)
             ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
    var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtContact=NOTExist&txtEmail=NOTExist&Type=Companies&txtIds=NotExist&ddlType=Multiple&Source=Procurment&ProjectId=' + ProjectId + '&ProjectRequired=0', '',
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + browserWidth * 0.9 + ',height=' + browserHeight * 0.9 + ',top=' + top + ',left=' + left);
        return false;
    
}

function OpenCompaniesPopup() {
    OpenPOPUp('CompaniesListPopup.aspx', 800, 500, true, "rdgProcurementBidders");
    return false;
}

function AdjustProcurementCalculation(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalAmount");
    });

    $("input[id*=" + gridId + "][id$=txtEstimatedUnitCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalAmount");
    });

    $("input[id*=" + gridId + "][id$=txtEstimatedTotal]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "UnitPrice");
    });
}

function Calculate(row, toCalculate) {
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitPrice = row.find("input[id$='txtEstimatedUnitCost']");
    var txtTotalAmount = row.find("input[id$='txtEstimatedTotal']");

    var QantityVal = CDbl(txtQuantity.val());
    var UnitPriceVal = CDbl(txtUnitPrice.val());
    var AmountVal = CDbl(txtTotalAmount.val());


    if (toCalculate == "TotalAmount") {
        txtTotalAmount.val(CCur(UnitPriceVal * QantityVal));
    }
    else if (toCalculate == "UnitPrice") {
            if (QantityVal == 0) {
                    QantityVal = 1;
                    txtQuantity.val(FPrec(1));
            }
            txtUnitPrice.val(CCur(AmountVal / QantityVal));
    }
}

function DeleteSelectedLines(ctrl) {
    var gridId = $("[id$=" + ctrl + "]")[0].id;
    var grid = $find(gridId);
    if (grid.get_masterTableView().get_selectedItems().length > 0) {
        return ConfirmDelete();
    }
    return false;
}

//function OnAward_Click(ctrl) {
//    var gridId = $("[id$=rdgProcurementBidders]")[0].id;
//    var grid = $find(gridId);
//    if (!grid) return;

//    var masterView = grid.get_masterTableView()

//    if (grid.get_masterTableView().get_selectedItems().length > 0) {
//        var row = masterView.get_selectedItems()[0];
//        var CanAward = row.findElement("hdnCanAward").value;
//        if (CanAward == "False") {
//            var pos = $("#" + ctrl.id).offset();
//            var width = $("#" + ctrl.id).width();
//           alert( Msg_SelectApprovedBid);
//            return false;
//        }
//    } else {
//    return false;   
//    }
//    
//    return true;
//}

function ProcurementRequestStart(sender, args) {
    if (args.EventTarget) {
        theRegexp = new RegExp("\.btnAward$", "ig");
        if (args.EventTarget.match(theRegexp)) {
            if (!window['AwardId']) return;
            args.EnableAjax = false;
            return;
        }
    }
    if (args.EventTargetElement) args.EventTargetElement.disabled = true;
}