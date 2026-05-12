/// <reference path="../jQuery-vsdoc.js"/ >
/// <reference path="../formatter.js"/>
/// <reference path="../PMJS.js"/>

var OldQuantityVal = 0;
var OldUnitCostVal = 0;
var OldTotalCostVal = 0;
var OldVal = 0;
var GridClauseId = ""
function CommitmentClause_Creating(sender, args) {
    if (GridClauseId == "") GridClauseId = sender.ClientID;
}
function popUpClause() {
    var grid = $find(GridClauseId);
    if (grid.get_masterTableView().get_selectedItems().length > 0) {
        var Path = 'CommitmentClauseEdit.aspx?Id=' + grid.get_masterTableView().get_selectedItems(0)[0].getDataKeyValue("Id")
        return OpenPOPUp(Path, 1000, 600, true); 
    }
   
    return false;
}

function OpenCommitmentCostsPopup(BudgetDetailId, UnitCost, OriginalProjectBudget, Quantity, CurrencyId, IsLinkedCommitmentDetail) {
   
    //    if (grid.get_masterTableView().get_selectedItems().length > 0) {
    //        var row = grid.get_masterTableView().get_selectedItems()[0];
    //        var BudgetDetailId = row.findElement("hdnBudgetDetailId").value;
    OpenPOPUp('CostManagementSpreadedCommitmentDetail.aspx?CommitmentDetailId=' + BudgetDetailId + '&UnitCost=' + UnitCost + '&OriginalProjectBudget=' + OriginalProjectBudget + '&Quantity=' + Quantity + '&CurrencyId=' + CurrencyId + '&IsLinkedCommitmentDetail=' + IsLinkedCommitmentDetail, 940, 550, true);
    return false;
    //    }
}

function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var description = item._attributes.getAttribute("Description");

    var row = $("#" + itemId).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $("#" + itemId).parents("tr:first")
    row.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));
}



function chkUserUnits_OnChekedChanged(event, checkbox) {
            $("input[id$=btnUseUnits]").click();
}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
                                              chkUserUnits_OnChekedChanged(e, this);});
   // BindBilling();
}



function ddlTypes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    if (item.get_value() != 1) {
        // purchase order
        $("[id$=trDays]").hide();
        $("[id$=trDueDate]").show();
        $("[id$=trRetentionOnMaterials]").hide();
        $("[id$=trRetentionOnServices]").hide();
        $("[id$=trSchedueledDeliveryDate]").show();
        $("[id$=txtCode]").val($("[id$=hdnPuchaseOrder]").val());
        $("[id$=txtOriginalValueDays]").hide();
        $("[id$=txtApprovedChangesDays]").hide();
        $("[id$=txtRevisedValueDays]").hide();
        $("[id$=txtPendingChangesDays]").hide();
        $("[id$=txtProjectedValueDays]").hide();
        $("[id$=lblDaysHeader]").hide();

    }
    else {        
        // Subcontract
        $("[id$=trDays]").show();
        $("[id$=trDueDate]").hide();
        $("[id$=trRetentionOnMaterials]").show();
        $("[id$=trRetentionOnServices]").show();
        $("[id$=trSchedueledDeliveryDate]").hide();
        $("[id$=txtCode]").val($("[id$=hdnSubcontracts]").val());
        $("[id$=lblDaysHeader]").show();
        $("[id$=txtOriginalValueDays]").show();
        $("[id$=txtApprovedChangesDays]").show();
        $("[id$=txtRevisedValueDays]").show();
        $("[id$=txtPendingChangesDays]").show();
        $("[id$=txtProjectedValueDays]").show();
    }
}
function showShipToPopup() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('ShipToPopup.aspx');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(WindowShipToClosed)
    return false;
}

function WindowShipToClosed(oWnd, args) {

var arg = args.get_argument();
if (arg) {

    $("[id$=txtShipTo]").val(args._argument.FirslLine);


}
}

//
/// 	 < summary >
/// calulate extCost or unitCost
/// 	 < / summary >
/// 	 < param name = "row" type = "String" >
/// 		1 : row to edit the other element
/// 	 < / param >
/// 	 < param name = "sender" type = "String" >
/// 		1 :  sender : sent to calculate the sum of specific column
/// 	 < / param >
function Calculate(row, sender) {
    var txtExtCost = row.find("input[id$='txtExtCost']");
    var TotalCostVal = txtExtCost.val();
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtShipping = row.find("input[id$='txtShipping']");
    var txtTax = row.find("input[id$='txtTax']");
    var txtAdjustments = row.find("input[id$='txtAdjustments']");
    var QantityVal = CDbl(txtQuantity.val());
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var UnitCostVal = txtUnitCost.val();
    var shipping = txtShipping.val();
    var Tax = txtTax.val();
    var Adjustment = txtAdjustments.val();
    var txtTotalCost = row.find("input[id$='txtTotalCost']");
    if (sender == "ExtCost") {
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        txtUnitCost.val(CCur(CDbl(TotalCostVal) / CDbl(QantityVal)));
        txtTotalCost.val(CCur(CDbl(TotalCostVal) + CDbl(shipping) + CDbl(Tax) + CDbl(Adjustment)))
    }
    else if (sender == "TotalCost") {
        txtTotalCost.val(CCur(CDbl(txtExtCost.val()) + CDbl(txtShipping.val()) + CDbl(txtTax.val()) + CDbl(txtAdjustments.val())))
    }
    else {
        txtExtCost.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));
        txtTotalCost.val(CCur(CDbl(txtExtCost.val()) + CDbl(shipping) + CDbl(Tax) + CDbl(Adjustment)))
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

function BindBilling() {


    if ($("input[id$=chkOverbilling]").is(":checked")) {
        $('[id$=lblAllowOverbilling]').show();
        $('[id$=lblDoNotAllowbilling]').hide();
        $('[id$=divOverBilling]').show();
      
    }
    else {
        $('[id$=lblAllowOverbilling]').hide();
        $('[id$=lblDoNotAllowbilling]').show();
        $('[id$=divOverBilling]').hide();
        $('input[id$=txtAllowbillingUpTo]').val(CPrct(0));
        $('input[id$=txtLineAllowbillingUpTo]').val(CPrct(0));
        $("input[type='checkbox'][Id$=chkLine]").removeAttr('checked');
        $("input[type='checkbox'][Id$=chkTotal]").removeAttr('checked');
    }
}

function UncheckLineCheck(){
    $("input[type='checkbox'][Id$=chkLine]").attr('checked', false);

}

function UncheckTotalCheck() {
    $("input[type='checkbox'][Id$=chkTotal]").attr('checked', false);

}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost

    $("a[id*=" + gridId + "][id$=btnGenerateFunding]").click(function(e) {

        var me = $(this);
        var tr = me.parents("tr:first");

        //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
        var detailId = -1;

        if (me.attr("detailid"))
            detailId = me.attr("detailid");


        //var costCode = tr.find("input[id*='ddlCostCodes']").val()

        //var amount = tr.find("input[id$='txtTotalCost']").val()

        OpenPOPUp('FundingCostCodePopup.aspx?Source=CostManagement_Commitments&DetailId=' + detailId, 870, 500, true, 'rdgCommitmentsDetails');
        return false;
        //wnd.add_close(onClose);


    });
    
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

        $("input[id*=" + gridId + "][id$=txtShipping]").change(function() {
            var row = $(this).parents(".rgEditForm:first");
            if (!row || row.length == 0)
                row = $(this).parents("tr:first");
            Calculate(row, "TotalCost");
        }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtAdjustments]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalCost");
    }
    ).focus(function() {
    OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtTax]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalCost");
    }
    ).focus(function() {
    OldVal = $(this).val();
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

    // On change ExtCost
        $("input[id*=" + gridId + "][id$=txtExtCost]").change(function() {
            var row = $(this).parents(".rgEditForm:first");
            if (!row || row.length == 0)
                row = $(this).parents("tr:first");
            Calculate(row, "ExtCost");
        }
    ).focus(function() {
           OldTotalCostVal = $(this).val();
       }
    );

        $("input[type='checkbox'][Id*='billing']").click(function () {
       // BindBilling();
    }
   );

//    $("input[type='checkbox'][Id$=chkTotal]").click(function() {
//        UncheckLineCheck();
//        
//    }
//   );
//    $("input[type='checkbox'][Id$=chkLine]").click(function() {
//        UncheckTotalCheck();

//    }
//   );
   
   
}

function rdgCommitmentsDetails_OnRowClick(sender, args) {
    var grid = $("[id$=rdgCommitmentsDetails]");
    var grid1 = $find($("[id$=rdgCommitmentsDetails]")[0].id);
    var disableEvent = "javascript:void(0);";
    var ret = 'false';

    for (var i = 0; i < grid1.MasterTableView.get_selectedItems().length; i++) {
        var row = grid1.MasterTableView.get_selectedItems()[i];
        if ((row.findElement("IsLinkedCommitmentDetail")) && (row.findElement("IsLinkedCommitmentDetail").value == 'True')) {
            ret = 'true';

        }
    }

    if ($(grid).find("a[id$=btnEditSelected]").length > 0) {
        if (ret == 'true') {
            $(grid).find("a[id$=btnEditSelected]").hide();
        }
        else { $(grid).find("a[id$=btnEditSelected]").show().removeClass("Hide"); }

    }
}

function RowDblClickDetails(sender, eventArgs) {

    var btnEditSelected = $("a[id*=" + sender.ClientID + "][id$=btnEditSelected]")[0];
    var btnUpdateEdited = $("a[id*=" + sender.ClientID + "][id$=btnUpdateEdited]")[0];

    var grid = $("[id$=rdgCommitmentsDetails]");
    var grid1 = $find($("[id$=rdgCommitmentsDetails]")[0].id);
    var disableEvent = "javascript:void(0);";
    var ret = 'false';

    for (var i = 0; i < grid1.MasterTableView.get_selectedItems().length; i++) {
        var row = grid1.MasterTableView.get_selectedItems()[i];
        if ((row.findElement("IsLinkedCommitmentDetail")) && (row.findElement("IsLinkedCommitmentDetail").value == 'True')) {
            ret = 'true';

        }
    }
  
    if (ret == 'false') {
        if (btnEditSelected) { eval(btnEditSelected.href.split(":")[1].toString().replace(/%20/g, ' ')); }
        else if (btnUpdateEdited) { eval(btnUpdateEdited.href.split(":")[1].toString().replace(/%20/g, ' ')); }
    }
     
        
}

