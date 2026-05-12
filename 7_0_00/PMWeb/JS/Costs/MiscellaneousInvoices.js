function Calculate(row,sender) {

    var txtQuantity = row.find("input[id$='txtQuantity']");
    var QantityVal = CDbl(txtQuantity.val());

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

    var txtTotalCost = row.find("input[id$='txtTotalCost']");
    var TotalCostVal = txtTotalCost.val();

    if ((sender == 'UnitCost') || (sender == 'Quantity')) {

      
        txtExtCost.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));
        ExtCostVal = txtExtCost.val();
        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));
    }

    if ((sender == 'ExtCost')) {
  if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        
        
        txtUnitCost.val(CCur(CDbl(ExtCostVal) / CDbl(QantityVal)));

        txtTotalCost.val(CCur(CDbl(ExtCostVal) + CDbl(Adjustment1Val) + CDbl(Adjustment2Val) + CDbl(TaxVal)));
  
    }

    if ((sender == 'TotalCost')) {
        if (QantityVal == 0) {
            QantityVal = 1;
            txtQuantity.val(FPrec(1));
        }
        txtExtCost.val(CCur(CDbl(TotalCostVal) - CDbl(Adjustment1Val) - CDbl(Adjustment2Val) - CDbl(TaxVal)));
        ExtCostVal = txtExtCost.val();
        txtUnitCost.val(CCur(CDbl(ExtCostVal) / CDbl(QantityVal)));
    }
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);


    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'Quantity');
    });

    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'UnitCost');
    });

    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'TotalCost');
    });

    $("input[id*=" + gridId + "][id$=txtExtCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, 'ExtCost');
    });


}

function OpenFundingCostCodePopup(sender) {
    var tr = $(sender).parents("tr:first");

    //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
    var detailId = -1;

    if ($(sender).attr("detailid"))
        detailId = $(sender).attr("detailid");

    //var costCode = tr.find("input[id*='ddlCostCodes']").val()
    //var amount = tr.find("input[id$='txtTotalCost']").val()
    OpenPOPUp('FundingCostCodePopup.aspx?Source=COSTMANAGEMENT_MISCELLANEOUSINVOICES&DetailId=' + detailId, 870, 500, true, 'rdgMiscellaneousInvoices');
    return false;
}



function rdvReqNodeClicking(sender, args) {
    var ComboId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
    var comboBox = $find(ComboId.substring(ComboId.lastIndexOf('_'), ComboId.lenght - 1));
    var node = args.get_node();
    var strText = "";
    var strValue = "";
    strValue = node.get_value();
    if (strValue.indexOf("SELECT") > 0 || strValue.indexOf("Contract") > 0 || strValue.indexOf("ContractCO") > 0) {
    
        while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
            strText = "/" + node.get_text() + strText;
            node = node.get_parent();
        }
        strText = strText.substr(1, strText.toString().length - 1);
        comboBox.set_text(strText);
        comboBox.trackChanges();
        comboBox.get_items().getItem(0).set_value(strValue);
        comboBox.commitChanges();
        comboBox.hideDropDown();
    }
}