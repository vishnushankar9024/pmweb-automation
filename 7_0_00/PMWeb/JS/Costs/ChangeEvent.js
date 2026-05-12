/// <reference path="../jQuery-vsdoc.js" />
/// <reference path="../formatter.js" />





function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function (e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
}



///	<summary>
/// calulate extPriceBudget or unitPriceBudget 
///	</summary>
///	<param name="row" type="String">
///		1: row to edit the other element
///	</param>
///	<param name="row" type="String">
///		1: If Index : '1' then calulate OwnerBudget; Default
///     2: If Index : '2' then caculate UnitPrice
///	</param>
function CalculateExtCost(row, index) {
    // index = index || 1;
    var txtExtCost = row.find("input[id$='txtExtCost']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var hdnRevisedBy = row.find("input[id$='hdnRevisedBy']");
    var prec = Global_DecimalPrecision;
    Global_DecimalPrecision = 5
    var QantityVal = CDbl(txtQuantity.val());
    Global_DecimalPrecision = prec
    if (index == 0) { //    
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        hdnRevisedBy.val('Q');

        if (txtUnitCost[0].isDisabled == true || txtUnitCost[0].disabled == true) {
            txtExtCost.val(CCur(QantityVal * CDbl(txtUnitCost.val())));
        } else {
            txtUnitCost.val(CCur(CDbl(txtExtCost.val()) / QantityVal));
        }
        var prec = Global_DecimalPrecision;
        Global_DecimalPrecision = 5
        txtQuantity.val(FPrec(QantityVal));
        Global_DecimalPrecision = prec

    }

    if (index == 1) { //
        hdnRevisedBy.val('UC');
        txtExtCost.val(
            CCur(CDbl(QantityVal * CDbl(txtUnitCost.val())))
            );
    }

    if (index == 2) { //
        hdnRevisedBy.val('EC');
        //var QantityVal = CDbl(txtQuantity.val());
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        if (txtUnitCost[0].isDisabled == true || txtUnitCost[0].disabled == true) {
            if (CDbl(txtUnitCost.val()) != 0) {

                var prec = Global_DecimalPrecision;
                Global_DecimalPrecision = 5
                var QantityVal = CDbl(txtExtCost.val()) / CDbl(txtUnitCost.val())
                txtQuantity.val(FPrec(CDbl(QantityVal)));
                Global_DecimalPrecision = prec

            }
        } else {
            txtUnitCost.val(CCur(CDbl(txtExtCost.val()) / QantityVal));
        }

    }
}



//
///	<summary>
/// calulate extPriceBudget or unitPriceBudget 
///	</summary>
///	<param name="row" type="String">
///		1: row to edit the other element
///	</param>
///	<param name="row" type="String">
///		1: If Index : '1' then calulate OwnerBudget; Default
///     2: If Index : '2' then caculate UnitPrice
///	</param>
function CalculateOwnerBudget(row, index) {
    index = index || 1;
    var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    var hdnRevisedBy = row.find("input[id$='hdnRevisedBy']");
    if (index == 1) { //
        txtOwnerBudget.val(
            CCur(CDbl(txtQuantity.val()) * CDbl(txtUnitPrice.val()))
            );
    } else {
        var QantityVal = CDbl(txtQuantity.val());
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        txtUnitPrice.val(
            CCur(CDbl(txtOwnerBudget.val()) / QantityVal)
            );
    }
}

function OnQantityChanged(row) {
    var txtOwnerBudget = row.find("input[id$='txtOwnerBudget']");
    var txtProjectBudget = row.find("input[id$='txtProjectBudget']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    var hdnRevisedBy = row.find("input[id$='hdnRevisedBy']");

    txtOwnerBudget.val(
            CCur(CDbl(txtQuantity.val()) * CDbl(txtUnitPrice.val()))
            );
    txtProjectBudget.val(
                CCur(CDbl(txtQuantity.val()) * CDbl(txtUnitCost.val()))
                );
}

//
///	<summary>
/// calulate unitCostCommitment or commitmentAmount 
///	</summary>
///	<param name="row" type="String">
///		1: row to edit the other element
///	</param>
///	<param name="row" type="String">
///		1: If Index : '1' then calulate ProjectBudget; Default
///     2: If Index : '2' then caculate unitCost
///	</param>
function CalculateProjectBudget(row, index) {
    index = index || 1;
    var txtProjectBudget = row.find("input[id$='txtProjectBudget']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");

    if (index == 1) {
        txtProjectBudget.val(
            CCur(CDbl(txtQuantity.val()) * CDbl(txtUnitCost.val()))
            );
        if (Sync == 'True') {
            txtUnitPrice.val(CCur(txtUnitCost.val()));
            CalculateOwnerBudget(row);
        }
    } else {
        var QantityVal = CDbl(txtQuantity.val());
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        txtUnitCost.val(
                CCur(CDbl(txtProjectBudget.val()) / QantityVal)
                );
        if (Sync == 'True') {
            txtUnitPrice.val(txtUnitCost.val());
            CalculateOwnerBudget(row);
        }
    }
}


function AdjustCommitmentCalculation(gridId) {
    //    var grid = $("#" + gridId);
    // On change quantity

    $("a[id*=" + gridId + "][id$=btnGenerateFunding]").click(function (e) {

        var me = $(this);
        var tr = me.parents("tr:first");

        //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
        var detailId = -1;

        if (me.attr("detailid"))
            detailId = me.attr("detailid");


        //var costCode = tr.find("input[id*='ddlCostCodes']").val()

        //var amount = tr.find("input[id$='txtExtCost']").val()
        //var statusid = tr.find("[id*='ddlCostLedgerStatuses']").val();

        OpenPOPUp('FundingCostCodePopup.aspx?Source=CHANGEEVENT&DetailId=' + detailId, 870, 500, true, 'rdgCost');
        return false;
        //wnd.add_close(onClose);


    });


    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateExtCost(row, 0);
    });

    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateExtCost(row, 1);
    });

    // On change Ext. Cost
    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateExtCost(row, 2);
    });
}


function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);




    //    alert($("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtQuantity]").length);
    // On change quantity
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        OnQantityChanged(row);
    });

    // On change unit price
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtUnitPrice]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOwnerBudget(row);
    });


    // On change unit cost
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateProjectBudget(row);
    });

    // On change Owner Budget
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtOwnerBudget]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOwnerBudget(row, 2);
    });

    // On change unit Project budget
    $("input[id*=" + gridId + "]:not([id *= '_Detail'])[id$=txtProjectBudget]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateProjectBudget(row, 2);
    });
}


function ddlLinkSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var txtDescription = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlLinkedBudgetLine')) + '_txtDescription' + "]")[0];
    var txtQuantity = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlLinkedBudgetLine')) + '_txtQuantity' + "]")[0];
    var txtUnitCost = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlLinkedBudgetLine')) + '_txtUnitCost' + "]")[0];
    var txtExtCost = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlLinkedBudgetLine')) + '_txtExtCost' + "]")[0];
    var ddlCostCodes = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlCostCodes');
    var ddlContractLine = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlContractLine');
    var ddlCurrencies = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_ddlCurrencies');

    var ddlContractLineValue;
    if (ddlContractLine == null)
        ddlContractLineValue = null;
    else
        ddlContractLineValue = ddlContractLine._value

    if ((item != null) && ((ddlContractLineValue == null) || (ddlContractLineValue <= 0) || (ddlContractLineValue = ""))) {
        var Quantity = CDbl(item._attributes.getAttribute("Quantity"));
        var UnitCost = CDbl(item._attributes.getAttribute("UnitCost"));
        var Description = item._attributes.getAttribute("ChangeEventDetailDescription");
        var CostCodeWithDescription = item._attributes.getAttribute("CostCodeWithDescription");
        var CostCodeId = item._attributes.getAttribute("CostCodeId");
        var CurrencyId = item._attributes.getAttribute("CurrencyId");
        var Currency = item._attributes.getAttribute("Currency");
        if (ddlCurrencies != null) {
            ddlCurrencies.trackChanges();
            ddlCurrencies.set_value(CurrencyId);
            ddlCurrencies.set_text(Currency);
            ddlCurrencies.commitChanges();
            ddlCurrencies.set_value(CurrencyId);

            var tr = document.getElementById(ddlCurrencies.get_id()).parentElement.parentElement;
            var Symbol = ddlCurrencies._findItemToSelect().get_attributes().getAttribute("symbol");
            var SymbolPosition = ddlCurrencies._findItemToSelect().get_attributes().getAttribute("symbolposition");
            $('input[class=Currency]', tr).each(function () {
                $(this).val(CCCur(CDbl($(this).val()), Symbol, SymbolPosition))
            });
            $('span[class=Currency]', tr).each(function () {
                $(this).html(CCCur(CDbl($(this).html()), Symbol, SymbolPosition))
            });
        }

        ddlCostCodes.trackChanges();
        ddlCostCodes.set_value(CostCodeId);
        ddlCostCodes.set_text(CostCodeWithDescription);
        ddlCostCodes.commitChanges();
        ddlCostCodes.set_value(CostCodeId);
        txtQuantity.value = FPrec(CDbl(Quantity));
        txtDescription.value = Description;
        txtUnitCost.value = CCur(CDbl(UnitCost));
        txtExtCost.value = CCur(CDbl(UnitCost) * CDbl(Quantity));
        // txtEquipmentTotalCost.value =  + (CDbl(txtStandby.value) * STRate) + (CDbl(txtIdle.value) * IDRate));
    }

}