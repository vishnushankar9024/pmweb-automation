function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var description = item._attributes.getAttribute("Description");

    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first")
    tr.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));
}

function DisablePanelAjax() {
    var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
    updatePanel1.set_enableAJAX(false);
}


function CalculateRow(row, me, sender){
    var txtCurrentQuantity = row.find("input[id$='txtCurrentQuantity']");
    var CurrentQuantityVal = txtCurrentQuantity.val();

    var txtStoredMaterial = row.find("input[id$='txtStoredMaterial']");
    var StoredMaterialVal = txtStoredMaterial.val();

    var txtPctComplete = row.find("input[id$='txtPctComplete']");
    var PctCompleteVal = txtPctComplete.val();

    var txtScheduledQuantity = row.find("input[id$='txtScheduledQuantity']");
    var ScheduledQuantityVal = txtScheduledQuantity.val();

    var txtTotalQuantity = row.find("input[id$='txtTotalQuantity']");

    var lblPriorQuantity = row.find("span[id$='lblPriorQuantity']");
    var PriorQuantityVal = lblPriorQuantity.html();

    var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
    var CurrentInvoiceVal = txtCurrentInvoices.val();



    var ScheduledValueVal;
    var txtScheduledValue;
    txtScheduledValue = row.find("input[id$='txtScheduledValue']");
    if (txtScheduledValue.val()) {
        ScheduledValueVal = txtScheduledValue.val();

    }
    else {
        txtScheduledValue = row.find("span[id$='lblScheduledValue']");
        ScheduledValueVal = txtScheduledValue.html();
    }
    
    var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
    var PriorInvoicesVal = lblPriorInvoices.html();

    var UnitCostVal;
    var txtUnitCost;
     txtUnitCost = row.find("input[id$='txtUnitPrice']");
     if (txtUnitCost.val()) {
        UnitCostVal = txtUnitCost.val();

    }
    else {
        txtUnitCost = row.find("span[id$='lblUnitPrice']");
        UnitCostVal = txtUnitCost.html();
    }
    
    if (sender == "ScheduledQuantity"){
        var txtScheduledValue = row.find("input[id$='txtScheduledValue']");
         txtScheduledValue.val(
                CDbl(CDbl(me.val()) * CDbl(row.find("input[id$='txtUnitPrice']").val()))
                );
//        var txtTotalQuantity = row.find("input[id$='txtTotalQuantity']");
//        var txtPctComplete = row.find("input[id$='txtPctComplete']");
//        var perc = (CDbl(txtTotalQuantity.val()) / CDbl(me.val())) * 100;
//        txtPctComplete.val(CPrct(perc));
         //        CalculateRow(row, txtPctComplete, "PctComplete");
         CalculateRow(row, txtScheduledValue, "ScheduledValue");  
        
    }
    
    if (sender == "UnitPrice"){
        var txtScheduledValue = row.find("input[id$='txtScheduledValue']");
        txtScheduledValue.val(
                CDbl(CDbl(me.val()) * CDbl(row.find("input[id$='txtScheduledQuantity']").val()))
                );
        CalculateRow(row, txtScheduledValue, "ScheduledValue");  
    
    }
    
    if (sender == "ScheduledValue"){
        var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
        var PriorInvoicesVal = lblPriorInvoices.html();
        var txtPctComplete = row.find("input[id$='txtPctComplete']");
        var PctCompleteVal = txtPctComplete.val();
        var ScheduledValueVal = (me.val()) ? me.val() : me.html();
        var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
        txtCurrentInvoices.val(CDbl(CDbl(CDbl(PctCompleteVal) * CDbl(ScheduledValueVal) / 100) - CDbl(PriorInvoicesVal) - CDbl(StoredMaterialVal)));
       
    }
    if (sender == "CurrentQuantity") {
        var total = CDbl(CDbl(PriorQuantityVal) + CDbl(CurrentQuantityVal));
        txtCurrentInvoices.val(CCur(CDbl(CDbl(UnitCostVal) * CDbl(CurrentQuantityVal))));

        txtTotalQuantity.val(total);
        var perc = 0;
        if (CDbl(ScheduledValueVal) == 0)
            perc = 0;
        else
            perc = (CDbl(PriorInvoicesVal) + CDbl(txtCurrentInvoices.val()) + CDbl(StoredMaterialVal)) / CDbl(ScheduledValueVal) * 100;

        txtPctComplete.val(CPrct(perc));
        
  
        
//        var total = CDbl(CDbl(PriorQuantityVal) + CDbl(me.val()));
//        txtTotalQuantity.val(total);
//        CalculateRow(row, txtTotalQuantity, "TotalQuantity");
    } 
    
    if (sender == "TotalQuantity"){
        var lblPriorQuantity = row.find("span[id$='lblPriorQuantity']");
        var PriorQuantityVal = lblPriorQuantity.html();
        var CurrQuant = CDbl(txtTotalQuantity.val()) - CDbl(PriorQuantityVal);

        txtCurrentQuantity.val(FPrec(CurrQuant, 4));

        txtCurrentInvoices.val(CCur(CDbl(CDbl(UnitCostVal) * CDbl(CurrQuant))));


        var perc = 0;
        if (CDbl(ScheduledValueVal) == 0)
            perc = 0;
        else
            perc = (CDbl(PriorInvoicesVal) + CDbl(txtCurrentInvoices.val()) + CDbl(StoredMaterialVal)) / CDbl(ScheduledValueVal) * 100;

        txtPctComplete.val(CPrct(perc));
    }  
    
    if (sender == "PctComplete"){
        if (PctCompleteVal < 0) {
            txtCurrentQuantity.val(CDbl(0.00));
            txtCurrentInvoices.val(CDbl(0.00));
            txtTotalQuantity.val(CDbl(0.00));
        }
        else {

            var AllTotalVal = CDbl((CDbl(PctCompleteVal) / 100) * CDbl(ScheduledValueVal));
            var TotalVal = CDbl(CDbl(AllTotalVal) - CDbl(StoredMaterialVal));
            var CurrentVal = CDbl(CDbl(TotalVal) - CDbl(PriorInvoicesVal));

            txtCurrentInvoices.val(CCur(CurrentVal));

            if (CDbl(UnitCostVal) == 0) {
                txtCurrentQuantity.val(FPrec(0, 4));
                txtTotalQuantity.val(FPrec(CDbl(PriorQuantityVal), 4));

            }
            else {

                var CurrQuant = CDbl(CDbl(CurrentVal) / CDbl(UnitCostVal));
                txtCurrentQuantity.val(FPrec(CDbl(CurrQuant), 4));
                txtTotalQuantity.val(FPrec(CDbl(CurrQuant) + CDbl(PriorQuantityVal), 4));
            }

        }

    }   
    
    if (sender == "CurrentInvoices"){
        var PctComplete;
        if (CDbl(ScheduledValueVal) == 0)
            PctComplete = 0;
        else
            PctComplete = (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal) + CDbl(StoredMaterialVal)) / CDbl(ScheduledValueVal) * 100;

        if (CDbl(UnitCostVal) == 0) {
            txtCurrentQuantity.val(FPrec(0, 4));
            txtTotalQuantity.val(FPrec(CDbl(PriorQuantityVal), 4));

        }
        else {

            var CurrQuant = CDbl(CDbl(CurrentInvoiceVal) / CDbl(UnitCostVal));
            txtCurrentQuantity.val(FPrec(CDbl(CurrQuant), 4));
            txtTotalQuantity.val(FPrec(CDbl(CurrQuant) + CDbl(PriorQuantityVal), 4));
        }


        txtPctComplete.val(CPrct(PctComplete));
    }
    if (sender == "StoredMaterial") {

    }
    Calculate2(row, "StoredMaterial");
    Calculate2(row, "PctServicesRetain");
    Calculate2(row, "PctMaterialsRetain");
    
    
//    if (sender == "StoredMaterial"){
//        var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
//        var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
//        var lblTotalThisInvoice = row.find("span[id$='lblTotalThisInvoice']");
//        lblTotalThisInvoice.html(CCur(CDbl(me.val()) + CDbl(txtCurrentInvoices.val())));
//        
//        var txtMaterialsRetainAmount = row.find("input[id$='txtMaterialsRetainAmount']");
//        var txtPctMaterialsRetain = row.find("input[id$='txtPctMaterialsRetain']");
//        txtMaterialsRetainAmount.val(CDbl(me.val()) * CDbl(txtPctMaterialsRetain.val()) / 100);

//        CalculateRow(row, lblTotalThisInvoice, "TotalThisInvoice");
//    }   
//    
//    if (sender == "TotalThisInvoice"){
//        var lblTotalInvoiced = row.find("span[id$='lblTotalInvoiced']");
//        var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
//        var PriorInvoicesVal = lblPriorInvoices.html();
//        lblTotalInvoiced.html(CCur(CDbl(PriorInvoicesVal) + CDbl(me.html())));
//        CalculateRow(row, lblTotalInvoiced, "TotalInvoiced");
//    }  
//    
//    if (sender == "TotalInvoiced"){
//        var lblBalanceToInvoice = row.find("span[id$='lblBalanceToInvoice']");
//        var ScheduledValue = row.find("[id$='ScheduledValue']");
//        var ScheduledValueVal = (ScheduledValue.val()) ? ScheduledValue.val() : ScheduledValue.html();
//        lblBalanceToInvoice.html(CCur(CDbl(ScheduledValueVal) - CDbl(me.html())));
//        
//        var txtServicesRetainAmount = row.find("input[id$='txtServicesRetainAmount']");
//        var txtPctServicesRetain = row.find("input[id$='txtPctServicesRetain']"); 
//        txtServicesRetainAmount.val(CCur(CDbl(me.html()) * CDbl(txtPctServicesRetain.val()) / 100));
//        var txtTotalRetained = row.find("input[id$='txtTotalRetained']");
//        CalculateRow(row, txtTotalRetained, "TotalRetained"); 
//    }
//    
//    if (sender == "TotalRetained"){
//        var txtMaterialsRetainAmount = row.find("input[id$='txtMaterialsRetainAmount']");
//        var txtServicesRetainAmount = row.find("input[id$='txtServicesRetainAmount']");
//        me.val(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())))
//      
//    }
}

function Calculate2(row, sender) {
    var txtStoredMaterial = row.find("input[id$='txtStoredMaterial']");
    var StoredMaterialVal = txtStoredMaterial.val();

    var lblTotalThisInvoice = row.find("span[id$='lblTotalThisInvoice']");
    var TotalThisInvoiceVal = lblTotalThisInvoice.html();

    var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
    var CurrentInvoiceVal = txtCurrentInvoices.val();

    var lblTotalInvoiced = row.find("span[id$='lblTotalInvoiced']");
    var TotalInvoicedVal = lblTotalInvoiced.html();

    var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
    var PriorInvoicesVal = lblPriorInvoices.html();

    var ScheduledValueVal;
    var txtScheduledValue;
    txtScheduledValue = row.find("input[id$='txtScheduledValue']");
    if (txtScheduledValue.val()) {
        ScheduledValueVal = txtScheduledValue.val();

    }
    else {
        txtScheduledValue = row.find("span[id$='lblScheduledValue']");
        ScheduledValueVal = txtScheduledValue.html();
    }

    var lblBalanceToInvoice = row.find("span[id$='lblBalanceToInvoice']");
    var BalanceToInvoiceVal = lblBalanceToInvoice.html();

    var txtPctServicesRetain = row.find("input[id$='txtPctServicesRetain']");
    var PctServicesRetainVal = txtPctServicesRetain.val();

    var txtServicesRetainAmount = row.find("input[id$='txtServicesRetainAmount']");
    var ServicesRetainAmountVal = txtServicesRetainAmount.val();

    var txtPctMaterialsRetain = row.find("input[id$='txtPctMaterialsRetain']");
    var PctMaterialsRetainVal = txtPctMaterialsRetain.val();

    var txtMaterialsRetainAmount = row.find("input[id$='txtMaterialsRetainAmount']");
    var MaterialsRetainAmountVal = txtMaterialsRetainAmount.val();

    var lblTotalRetained = row.find("span[id$='lblTotalRetained']");

    var lblCurrentPayment = row.find("span[id$='lblCurrentPayment']");
    var CurrentPaymentVal = lblCurrentPayment.html();

//    var lblTotalStoredMaterial = row.find("span[id$='lblTotalStoredMaterial']");
//    var TotalStoredMaterialVal = lblTotalStoredMaterial.html();

//    var lblTotalServicesRetainAmount = row.find("span[id$='lblTotalServicesRetainAmount']");
//    var TotalServicesRetainAmountVal = lblTotalServicesRetainAmount.html();

//    var lblTotalMaterialsRetainAmount = row.find("span[id$='lblTotalMaterialsRetainAmount']");
//    var TotalMaterialsRetainAmountVal = lblTotalMaterialsRetainAmount.html();

    var lblPriorStoredMaterial = row.find("span[id$='lblPriorStoredMaterial']");
    var PriorStoredMaterialVal = lblPriorStoredMaterial.html();

    var lblPriorServicesRetainAmount = row.find("span[id$='lblPriorServicesRetainAmount']");
    var PriorServicesRetainAmountVal = lblPriorServicesRetainAmount.html();

    var lblPriorMaterialsRetainAmount = row.find("span[id$='lblPriorMaterialsRetainAmount']");
    var PriorMaterialsRetainAmountVal = lblPriorMaterialsRetainAmount.html();


    var lblCurrentStoredMaterial = row.find("span[id$='lblCurrentStoredMaterial']");
    var CurrentStoredMaterialVal = lblCurrentStoredMaterial.html();

    var lblCurrentServicesRetainAmount = row.find("span[id$='lblCurrentServicesRetainAmount']");
    var CurrentServicesRetainAmountVal = lblCurrentServicesRetainAmount.html();

    var lblCurrentMaterialsRetainAmount = row.find("span[id$='lblCurrentMaterialsRetainAmount']");
    var CurrentMaterialsRetainAmountVal = lblCurrentMaterialsRetainAmount.html();
    var CurrentPayment = 0;


    if (sender == "StoredMaterial") {
        lblTotalThisInvoice.html(CCur(CDbl(CurrentInvoiceVal) + CDbl(StoredMaterialVal) - CDbl(PriorStoredMaterialVal)));
        lblCurrentStoredMaterial.html(CCur(CDbl(StoredMaterialVal) - CDbl(PriorStoredMaterialVal)));
        lblTotalInvoiced.html(CCur(CDbl(PriorInvoicesVal) + CDbl(lblTotalThisInvoice.html()) + CDbl(PriorStoredMaterialVal)));
        lblBalanceToInvoice.html(CDbl(CDbl(ScheduledValueVal) - CDbl(lblTotalInvoiced.html())));


        CurrentPayment = (CDbl(lblCurrentStoredMaterial.html()) + CDbl(CurrentInvoiceVal)) - (CDbl(CurrentServicesRetainAmountVal) + CDbl(CurrentMaterialsRetainAmountVal));


    }
    if (sender == "PctServicesRetain") {
        txtServicesRetainAmount.val(CDbl(CDbl(PctServicesRetainVal) * (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal)) / 100));
        lblCurrentServicesRetainAmount.html(CDbl(CDbl(txtServicesRetainAmount.val()) - CDbl(PriorServicesRetainAmountVal)));
        
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(lblCurrentServicesRetainAmount.html()) + CDbl(CurrentMaterialsRetainAmountVal));
    
    
    }
    if (sender == "ServicesRetainAmount") {
        lblCurrentServicesRetainAmount.html(CDbl(CDbl(ServicesRetainAmountVal) - CDbl(PriorServicesRetainAmountVal)));
    
        if (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal) != 0) {
            var ServiceRetainPercent = (CDbl(ServicesRetainAmountVal) / (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal))) * 100;
            txtPctServicesRetain.val(CPrct(ServiceRetainPercent))
        }
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(lblCurrentServicesRetainAmount.html()) + CDbl(CurrentMaterialsRetainAmountVal));
    
    
    }
    if (sender == "PctMaterialsRetain") {
        txtMaterialsRetainAmount.val(CDbl(CDbl(PctMaterialsRetainVal) * CDbl(StoredMaterialVal) / 100));
        lblCurrentMaterialsRetainAmount.html(CCur(CDbl(txtMaterialsRetainAmount.val()) - CDbl(PriorMaterialsRetainAmountVal)));
       
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(CurrentServicesRetainAmountVal) + CDbl(lblCurrentMaterialsRetainAmount.html()));
    
    
    }

    if (sender == "MaterialsRetainAmount") {
        lblCurrentMaterialsRetainAmount.html(CDbl(CDbl(MaterialsRetainAmountVal) - CDbl(PriorMaterialsRetainAmountVal)));
    
        if (CDbl(StoredMaterialVal) != 0) {
            var MaterialRetainPercent = (CDbl(MaterialsRetainAmountVal) / CDbl(StoredMaterialVal)) * 100;
            txtPctMaterialsRetain.val(CPrct(MaterialRetainPercent))
        }
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(CurrentServicesRetainAmountVal) + CDbl(lblCurrentMaterialsRetainAmount.html()));
    
    }

    lblCurrentPayment.html(CCur(CurrentPayment));

}

function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=txtUnitPrice]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        CalculateRow(tr, me, "UnitPrice")
        }
    );

    $("input[id*=" + gridId + "][id$=txtScheduledQuantity]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        CalculateRow(tr, me, "ScheduledQuantity")

        }
    );

    $("input[id*=" + gridId + "][id$=txtScheduledValue]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        var txtUnitPrice = tr.find("input[id$='txtUnitPrice']");
        txtUnitPrice.val(
                CDbl(CDbl(me.val()) / CDbl(tr.find("input[id$='txtScheduledQuantity']").val()))
                );
        CalculateRow(tr, me, "ScheduledValue")

        }
    );
    
    $("input[id*=" + gridId + "][id$=txtCurrentQuantity]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        CalculateRow(tr, me, "CurrentQuantity")
        
        }
    );
    $("input[id*=" + gridId + "][id$=txtTotalQuantity]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var txtCurrentQuantity = tr.find("input[id$='txtCurrentQuantity']");
//        var lblPriorQuantity = tr.find("span[id$='lblPriorQuantity']");
//        var PriorQuantityVal = lblPriorQuantity.html();
//        txtCurrentQuantity.val(CDbl(me.val()) - CDbl(PriorQuantityVal));
        CalculateRow(tr, me, "TotalQuantity")
        }
    );
    
    $("input[id*=" + gridId + "][id$=txtPctComplete]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var ScheduledQuantity = tr.find("[id$='ScheduledQuantity']");
//        var ScheduledQuantityVal = (ScheduledQuantity.val()) ? ScheduledQuantity.val() : ScheduledQuantity.html();
//        var lblPriorQuantity = tr.find("span[id$='lblPriorQuantity']");
//        var PriorQuantityVal = lblPriorQuantity.html();
//        var txtCurrentQuantity = tr.find("input[id$='txtCurrentQuantity']");
//        var txtTotalQuantity = tr.find("input[id$='txtTotalQuantity']");
//        txtTotalQuantity.val(CDbl(CDbl(me.val()) * CDbl(ScheduledQuantityVal) / 100));
//        txtCurrentQuantity.val(CDbl(txtTotalQuantity.val()) - CDbl(PriorQuantityVal));
        CalculateRow(tr, me, "PctComplete")

        }
    );
    
    $("input[id*=" + gridId + "][id$=txtCurrentInvoices]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var ScheduledValue = tr.find("[id$='ScheduledValue']");
//        var ScheduledValueVal = (ScheduledValue.val()) ? ScheduledValue.val() : ScheduledValue.html();
//        
//    
//        var ScheduledQuantity = tr.find("[id$='ScheduledQuantity']");
//        var ScheduledQuantityVal = (ScheduledQuantity.val()) ? ScheduledQuantity.val() : ScheduledQuantity.html();

//        var txtCurrentQuantity = tr.find("input[id$='txtCurrentQuantity']");
//        var txtTotalQuantity = tr.find("input[id$='txtTotalQuantity']");
//        var txtPctComplete = tr.find("input[id$='txtPctComplete']");
//        
//        var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
//        var PriorInvoicesVal = lblPriorInvoices.html();
//        
//        var lblPriorQuantity = tr.find("span[id$='lblPriorQuantity']");
//        var PriorQuantityVal = lblPriorQuantity.html();
//        var PctComplete = (CDbl(ScheduledValueVal) == 0) ? 0 : CDbl(me.val() + PriorInvoicesVal) / CDbl(ScheduledValueVal) * 100;
//             
//        var TotalQuant = CDbl((CDbl(PctComplete) / 100) * CDbl(ScheduledQuantityVal));
//        txtCurrentQuantity.val(FPrec(CDbl(TotalQuant) - CDbl(PriorQuantityVal),4));
//        txtTotalQuantity.val(FPrec(TotalQuant, 4));
//        txtPctComplete.val(CPrct(PctComplete));
        CalculateRow(tr, me, "CurrentInvoices")
        }
    );
    
    $("input[id*=" + gridId + "][id$=txtStoredMaterial]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        CalculateRow(tr, me, "StoredMaterial");
    }
    );

    $("input[id*=" + gridId + "][id$=txtPctServicesRetain]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var txtServicesRetainAmount = tr.find("input[id$='txtServicesRetainAmount']");
//        var lblTotalInvoiced = tr.find("span[id$='lblTotalInvoiced']");
//        txtServicesRetainAmount.val(CCur(CDbl(me.val()) * CDbl(lblTotalInvoiced.html()) / 100));
//        var txtTotalRetained = tr.find("input[id$='txtTotalRetained']");
        Calculate2(tr, "PctServicesRetain");
    }
    );
    
    $("input[id*=" + gridId + "][id$=txtServicesRetainAmount]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var txtPctServicesRetain = tr.find("input[id$='txtPctServicesRetain']");
//        var lblTotalInvoiced = tr.find("span[id$='lblTotalInvoiced']");
//        var ServiceRetainPercent = (CDbl(me.val()) / CDbl(lblTotalInvoiced.html())) * 100;
//        txtPctServicesRetain.val(CPrct(ServiceRetainPercent));
//        var txtTotalRetained = tr.find("input[id$='txtTotalRetained']");
        Calculate2(tr, "ServicesRetainAmount");
        }
    );
    
    $("input[id*=" + gridId + "][id$=txtPctMaterialsRetain]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var txtMaterialsRetainAmount = tr.find("input[id$='txtMaterialsRetainAmount']");
//        var txtStoredMaterial = tr.find("input[id$='txtStoredMaterial']");
//        txtMaterialsRetainAmount.val(CCur(CDbl(me.val()) * CDbl(txtStoredMaterial.val()) / 100));
//        var txtTotalRetained = tr.find("input[id$='txtTotalRetained']");
        Calculate2(tr, "PctMaterialsRetain");
        }
    );
    
    $("input[id*=" + gridId + "][id$=txtMaterialsRetainAmount]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
//        var txtPctMaterialsRetain = tr.find("input[id$='txtPctMaterialsRetain']");
//        var txtStoredMaterial = tr.find("input[id$='txtStoredMaterial']");
//        var MaterialsRetainPercent = (CDbl(me.val()) / CDbl(txtStoredMaterial.val())) * 100;
//        txtPctMaterialsRetain.val(CPrct(MaterialsRetainPercent));
//        var txtTotalRetained = tr.find("input[id$='txtTotalRetained']");
        Calculate2(tr, "MaterialsRetainAmount");
        }
    );
}





function RequisitionOnClientButtonClicking(sender, args) {
    var comandName = args.get_item().get_commandName();
    if (comandName == "Delete") {
        if (!confirm(Msg_ConfirmDeleteDocument)) {
            args.set_cancel(true);
        }
    }
 
    else if (args.get_item().get_value() == "Void") {
    var cancel = confirm(Msg_ConfirmVoid);
        args.set_cancel(!cancel);
    }
    else if (args.get_item().get_value() == "Copy") {
        args.set_cancel(true);
    }
    else if (args.get_item().get_value() == "Save") {
    var ddlProjects = $find($("[id$=ddlProjects]")[0].id)
    var ddlContacts = $find($("[id$=ddlContracts]")[0].id)
    if (ddlProjects.get_value() > 0 && ddlContacts.get_value() > 0 && $("[id$=hdfCopyDetails]").val() == 0 && $("[id$=txtRecordNumber]").val()) {
    var cancel = confirm(Msg_ConfirmAddContractDetails);
    $("[id$=hdfCopyDetails]").val(cancel);}
    //args.get_item()._attributes.getAttribute()
}

if (comandName == "PctComplete") {
    if (!confirm(Msg_ConfirmCopyPercentage)) {
        args.set_cancel(true);
    }
}
}

function rdvReqNodeClicking(sender, args) {
    var ComboId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
    var comboBox = $find(ComboId.substring(ComboId.lastIndexOf('_'), ComboId.lenght - 1));
    var node = args.get_node();
    var strText = "";
    var strValue = "";
    strValue = node.get_value();
    if (strValue == "0" || strValue.indexOf("Contract") > 0 || strValue.indexOf("ContractCO") > 0) {
        if (node != null) { 
        strText=node.get_text();
        }
        comboBox.set_text(strText);
        comboBox.trackChanges();
        comboBox.get_items().getItem(0).set_value(strValue);
        comboBox.commitChanges();
        comboBox.hideDropDown();
    } 

}

function OpenCOPopup() {
    OpenPOPUp('RequisitionCOPopup.aspx', 900, 500, true);
}

function OpenActualCostsPopup() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
//    var grid = $find($("[id$=rdgRequisitionDetails]")[0].id);
//    if (grid.get_masterTableView().get_selectedItems().length > 0) {
//        var row = grid.get_masterTableView().get_selectedItems()[0];
//        var RequisitionDetailId = row.findElement("hdnRequisitionDetailId").value;
//        OpenActual(RequisitionDetailId, 900, 500);
    //    }
    var wnd = window.radopen('RequisitionActualCostsPopup.aspx');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(ActualCostsPopupClosed);
    wnd.Center();
    return false;
}


//function OpenActual(RequisitionDetailId, Width, Height) {
//    var wnd = window.radopen('RequisitionActualCostsPopup.aspx');
//    wnd.setSize(Width, Height);
//    wnd.add_close(ActualCostsPopupClosed);
//    wnd.Center();
//    return false;
//}

function ActualCostsPopupClosed(Opener) {
    var btnActualCostsPopup;
    btnActualCostsPopup = $("input[id$=btnActualCostsPopup]")[0];
    if (btnActualCostsPopup) { btnActualCostsPopup.click(); }
}


function ConfirmDeleteActualCosts() {
    return confirm(Msg_ConfirmDeleteActualCosts);
}

function ShowHideActualCostBtn(sender, args) {
    var btnDeleteActualCosts = $("[id*=" + sender.get_id() + "][id$=btnDeleteActualCosts]");
    if ((sender.get_detailTables().length == 0 || sender.get_detailTables()[0].get_selectedItems().length == 0) && sender.get_masterTableView().get_selectedItems().length>0)    
        btnDeleteActualCosts.hide();
    else
        btnDeleteActualCosts.show();
}

function ValidateTotalQty(sender, args) {
    var txtTotalQuantity = $("#" + sender.controltovalidate);
    var row = txtTotalQuantity.parents("tr:first");
    var PriorQuantity = row.find("[id$='PriorQuantity']");
    var ScheduledQuantity = row.find("[id$='ScheduledQuantity']");
    
    var TotalQuantityVal = CDbl(txtTotalQuantity.val()); 
    var PriorQuantityVal = (PriorQuantity.val()) ? CDbl(PriorQuantity.val()) : CDbl(PriorQuantity.html());
    var ScheduledQuantityVal = (ScheduledQuantity.val()) ? CDbl(ScheduledQuantity.val()) : CDbl(ScheduledQuantity.html());
    
    if (TotalQuantityVal >= PriorQuantityVal && TotalQuantityVal <= ScheduledQuantityVal) {
        args.IsValid = true;
    } else {
        args.IsValid = false;
    }
}