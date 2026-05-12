var OldCurrentQuantityVal = 0;
function DisablePanelAjax() {
    var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
    updatePanel1.set_enableAJAX(false);
}
function rdg1_OnRowClick(sender, args) {

    var grid = $("[id$=rdg1]");
    var grid1 = $find($("[id$=rdg1]")[0].id);
    var disableEvent = "javascript:void(0);";
    var ret = 'true';

    for (var i = 0; i < grid1.MasterTableView.get_selectedItems().length; i++) {
        var row = grid1.MasterTableView.get_selectedItems()[i];
        if ((row.findElement("hdnCanDelete")) && (row.findElement("hdnCanDelete").value == 'False')) {
            ret = 'false';
         
        }
    }
    
//    $(grid).find(".rgSelectedRow").each(function(){
//    
//    
//    if($(this).find("[id$='hdnCanDelete']").val()== 'False'){
//    
//      ret='false';
//    
//    }
//    
//    });


    if ($(grid).find("a[id$=btnDelete]").length > 0) {
        if (ret == 'false') {
            $(grid).find("a[id$=btnDelete]").hide();
        }
        else
        { $(grid).find("a[id$=btnDelete]").show().removeClass("Hide"); }

    }
 


}


function Calculate(row, sender) {
    var txtCurrentQuantity = row.find("input[id$='txtCurrentQuantity']");
    var CurrentQuantityVal = txtCurrentQuantity.val();
    
    var txtStoredMaterial = row.find("input[id$='txtStoredMaterial']");
    var StoredMaterialVal = txtStoredMaterial.val();
    
    var txtPctComplete = row.find("input[id$='txtPctComplete']");
    var PctCompleteVal = txtPctComplete.val();

    var lblScheduledQuantity = row.find("span[id$='lblScheduledQuantity']");
    var ScheduledQuantityVal = lblScheduledQuantity.html();
    
    var txtTotalQuantity = row.find("input[id$='txtTotalQuantity']");
  
    var lblPriorQuantity = row.find("span[id$='lblPriorQuantity']");
    var PriorQuantityVal = lblPriorQuantity.html();

    var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
    var CurrentInvoiceVal = txtCurrentInvoices.val();

    var txtTotalServices = row.find("input[id$='txtTotalServices']");
    var CurrentTotalServices = txtTotalServices.val();

    var lblScheduledValue = row.find("span[id$='lblScheduledValue']");
    var ScheduledValueVal = lblScheduledValue.html();
    var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
    var PriorInvoicesVal = lblPriorInvoices.html();

    var lblUnitCost = row.find("span[id$='lblUnitCost']");
    var UnitCostVal = lblUnitCost.html();
    
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
  
    }
    if (sender == "TotalQuantity") {  
        var lblPriorQuantity = row.find("span[id$='lblPriorQuantity']");
        var PriorQuantityVal = lblPriorQuantity.html();
        var CurrQuant=CDbl(txtTotalQuantity.val()) - CDbl(PriorQuantityVal);

        txtCurrentQuantity.val(FPrec(CurrQuant, 4));

        txtCurrentInvoices.val(CCur(CDbl(CDbl(UnitCostVal) * CDbl(CurrQuant))));


        var perc = 0;
        if (CDbl(ScheduledValueVal) == 0)
            perc = 0;
        else
            perc = (CDbl(PriorInvoicesVal) + CDbl(txtCurrentInvoices.val()) + CDbl(StoredMaterialVal)) / CDbl(ScheduledValueVal) * 100;

        txtPctComplete.val(CPrct(perc));
        
    }
    if (sender == "PctComplete") {
        
        if (PctCompleteVal < 0) {
            txtCurrentQuantity.val(CDbl(0.00));
            txtCurrentInvoices.val(CDbl(0.00));
            txtTotalQuantity.val(CDbl(0.00));
            txtTotalServices.val(CCur(CDbl(PriorInvoicesVal) - CDbl(StoredMaterialVal)));
        }
        else {
          
            var AllTotalVal = CDbl((CDbl(PctCompleteVal) / 100) * CDbl(ScheduledValueVal));
            var TotalVal = CDbl(CDbl(AllTotalVal) - CDbl(StoredMaterialVal));
            var CurrentVal = CDbl(CDbl(TotalVal) - CDbl(PriorInvoicesVal));

            txtCurrentInvoices.val(CCur(CurrentVal));
            txtTotalServices.val(CCur(TotalVal));

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

    if (sender == "TotalServices") {
        PctCompleteVal = ((CDbl(CurrentTotalServices) + CDbl(StoredMaterialVal)) * 100) / CDbl(ScheduledValueVal);
        txtPctComplete.val(CPrct(PctCompleteVal));
        if (PctCompleteVal < 0) {
            txtCurrentQuantity.val(CDbl(0.00));
            txtCurrentInvoices.val(CDbl(0.00));
            txtTotalQuantity.val(CDbl(0.00));
        } else {
            var AllTotalVal = CDbl(CurrentTotalServices) + CDbl(StoredMaterialVal);
            var CurrentInvoiceVal = CDbl(CDbl(CurrentTotalServices) - CDbl(PriorInvoicesVal));
            txtCurrentInvoices.val(CCur(CurrentInvoiceVal));
            if (CDbl(UnitCostVal) == 0) {
                txtCurrentQuantity.val(FPrec(0, 4));
                txtTotalQuantity.val(FPrec(CDbl(PriorQuantityVal), 4));
            } else {
                var CurrQuant = CDbl(CDbl(CurrentInvoiceVal) / CDbl(UnitCostVal));
                txtCurrentQuantity.val(FPrec(CDbl(CurrQuant), 4));
                txtTotalQuantity.val(FPrec(CDbl(CurrQuant) + CDbl(PriorQuantityVal), 4));
            }
        }
    }

    if (sender == "CurrentInvoices") {
          
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
            var CurrQuant = CDbl(CDbl(CurrentInvoiceVal)  / CDbl(UnitCostVal));
            txtCurrentQuantity.val(FPrec(CDbl(CurrQuant), 4));
            txtTotalQuantity.val(FPrec(CDbl(CurrQuant) + CDbl(PriorQuantityVal), 4));
        }
        txtPctComplete.val(CPrct(PctComplete));
        var TotalVal = CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal);  //CDbl((PctComplete / 100) * CDbl(ScheduledValueVal)) - CDbl(StoredMaterialVal);
        txtTotalServices.val(CCur(TotalVal));
    }

    if (sender == "StoredMaterial") {
        var PctComplete;
        if (CDbl(ScheduledValueVal) == 0)
            PctComplete = 0;
        else
            PctComplete = (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal) + CDbl(StoredMaterialVal)) / CDbl(ScheduledValueVal) * 100;
        txtPctComplete.val(CPrct(PctComplete));

    }
    Calculate2(row, "StoredMaterial");
    Calculate2(row, "PctServicesRetain");
    Calculate2(row, "PctMaterialsRetain");
}
function Calculate2(row, sender) {
    var txtStoredMaterial = row.find("input[id$='txtStoredMaterial']");
    var StoredMaterialVal = txtStoredMaterial.val();
    var txtPctComplete = row.find("input[id$='txtPctComplete']");
    var lblTotalThisInvoice = row.find("span[id$='lblTotalThisInvoice']");
    var TotalThisInvoiceVal = lblTotalThisInvoice.html();

    var lblCurrentPayment = row.find("span[id$='lblCurrentPayment']");
    var CurrentPaymentVal = lblCurrentPayment.html();

    var lblTotalStoredMaterial = row.find("span[id$='lblTotalStoredMaterial']");
    var TotalStoredMaterialVal = lblTotalStoredMaterial.html();

    var lblTotalServicesRetainAmount = row.find("span[id$='lblTotalServicesRetainAmount']");
    var TotalServicesRetainAmountVal = lblTotalServicesRetainAmount.html();

    var lblTotalMaterialsRetainAmount = row.find("span[id$='lblTotalMaterialsRetainAmount']");
    var TotalMaterialsRetainAmountVal = lblTotalMaterialsRetainAmount.html();
    
    var txtCurrentInvoices = row.find("input[id$='txtCurrentInvoices']");
    var CurrentInvoiceVal = txtCurrentInvoices.val();

    var lblTotalInvoiced = row.find("span[id$='lblTotalInvoiced']");
    var TotalInvoicedVal = lblTotalInvoiced.html();

    var lblPriorInvoices = row.find("span[id$='lblPriorInvoices']");
    var PriorInvoicesVal = lblPriorInvoices.html();

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

    var lblScheduledValue = row.find("span[id$='lblScheduledValue']");
    var ScheduledValueVal = lblScheduledValue.html();

    var lblCurrentPayment = row.find("span[id$='lblCurrentPayment']");
    var CurrentPaymentVal = lblCurrentPayment.html();

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
    var CurrentPayment = 0;

    if (sender == "StoredMaterial") {
        lblCurrentStoredMaterial.html(CCur(CDbl(StoredMaterialVal) - CDbl(PriorStoredMaterialVal)));
        lblTotalThisInvoice.html(CCur(CDbl(CurrentInvoiceVal) + CDbl(CDbl(StoredMaterialVal) - CDbl(PriorStoredMaterialVal))));
        lblTotalInvoiced.html(CCur(CDbl(PriorInvoicesVal) + CDbl(lblTotalThisInvoice.html()) + CDbl(PriorStoredMaterialVal)));
        lblBalanceToInvoice.html(CCur(CDbl(ScheduledValueVal) - CDbl(lblTotalInvoiced.html())));
        CurrentPayment = (CDbl(lblCurrentStoredMaterial.html()) + CDbl(CurrentInvoiceVal)) - (CDbl(CurrentServicesRetainAmountVal) + CDbl(CurrentMaterialsRetainAmountVal));
        

    }

 
    if (sender == "PctServicesRetain") {
        txtServicesRetainAmount.val(CCur(CDbl(PctServicesRetainVal) * (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal)) / 100));
        lblCurrentServicesRetainAmount.html(CCur(CDbl(txtServicesRetainAmount.val()) - CDbl( PriorServicesRetainAmountVal )));
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));

        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(lblCurrentServicesRetainAmount.html()) + CDbl(CurrentMaterialsRetainAmountVal));
      
        
    }
    if (sender == "ServicesRetainAmount") {
        lblCurrentServicesRetainAmount.html(CCur(CDbl(ServicesRetainAmountVal) - CDbl(PriorServicesRetainAmountVal)));
        
        if (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal) != 0) {
            var ServiceRetainPercent = (CDbl(ServicesRetainAmountVal) / (CDbl(PriorInvoicesVal) + CDbl(CurrentInvoiceVal))) * 100;
            txtPctServicesRetain.val(CPrct(ServiceRetainPercent))
        
        } else
            {txtPctServicesRetain.val(CPrct(0))}
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(lblCurrentServicesRetainAmount.html()) + CDbl(CurrentMaterialsRetainAmountVal));
        
    }
    if (sender == "PctMaterialsRetain") {
        txtMaterialsRetainAmount.val(CCur(CDbl(PctMaterialsRetainVal) * CDbl(StoredMaterialVal) / 100));
        lblCurrentMaterialsRetainAmount.html(CCur(CDbl(txtMaterialsRetainAmount.val()) - CDbl(PriorMaterialsRetainAmountVal)));

        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(CurrentServicesRetainAmountVal ) + CDbl(lblCurrentMaterialsRetainAmount.html()));
        
    }

    if (sender == "MaterialsRetainAmount") {
        lblCurrentMaterialsRetainAmount.html(CCur(CDbl(MaterialsRetainAmountVal) - CDbl(PriorMaterialsRetainAmountVal)));
    
        if (CDbl(StoredMaterialVal) != 0) {
            var MaterialRetainPercent = (CDbl(MaterialsRetainAmountVal) / CDbl(StoredMaterialVal)) * 100;
            txtPctMaterialsRetain.val(CPrct(MaterialRetainPercent))
          
        }  else
            {txtPctMaterialsRetain.val(CPrct(0))}
        lblTotalRetained.html(CCur(CDbl(txtMaterialsRetainAmount.val()) + CDbl(txtServicesRetainAmount.val())));
        CurrentPayment = (CDbl(CurrentStoredMaterialVal) + CDbl(CurrentInvoiceVal)) - (CDbl(CurrentServicesRetainAmountVal) + CDbl(lblCurrentMaterialsRetainAmount.html()));
        
    }


    lblCurrentPayment.html(CCur(CurrentPayment));
}
function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);


    $("a[id*=" + gridId + "][id$=btnGenerateFunding]").click(function(e) {

        var me = $(this);
        var tr = me.parents("tr:first");

        //var txtFundedId = tr.find("input[id$='txtFunded']")[0].id;
        var detailId = -1;

        if (me.attr("detailid"))
            detailId = me.attr("detailid");


        //var costCode = tr.find("span[id$='lblCostCode']").html()

        //var amount = tr.find("input[id$='txtCurrentInvoices']").val()

        OpenPOPUp('FundingCostCodePopup.aspx?Source=PROGRESSINVOICES&DetailId=' + detailId, 870, 500, true, 'rdg1');
        return false;
        //wnd.add_close(onClose);


    });
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtCurrentQuantity]").change(function() {
        var row = $(this).parents("tr:first"); 
        Calculate(row, "CurrentQuantity");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtTotalQuantity]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalQuantity");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtPctComplete]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "PctComplete");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtCurrentInvoices]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "CurrentInvoices");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtStoredMaterial]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "StoredMaterial");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );


    $("input[id*=" + gridId + "][id$=txtTotalServices]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate(row, "TotalServices");
    }
    ).focus(function () {
        OldCurrentQuantityVal = $(this).val();
    }
    );

    $("input[id*=" + gridId + "][id$=txtPctServicesRetain]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate2(row, "PctServicesRetain");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtServicesRetainAmount]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate2(row, "ServicesRetainAmount");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtPctMaterialsRetain]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate2(row, "PctMaterialsRetain");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
    $("input[id*=" + gridId + "][id$=txtMaterialsRetainAmount]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        Calculate2(row, "MaterialsRetainAmount");
        }
    ).focus(function() {
        OldCurrentQuantityVal = $(this).val();
        }
    );
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

    function OpenCOPopup() {
        OpenPOPUp('ProgressInvoiceCOPopup.aspx', 900, 500, true);
    }

    function OpenReport() {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var InvoiceTypeId = 1;
        if ($("[id$=ddlInvoiceType]").length>0)
        InvoiceTypeId = $find($("[id$=ddlInvoiceType]")[0].id).get_value();
        if (InvoiceTypeId == 0) {
            alert(Msg_SelectInvoiceType);
        } else {
            var left = (screen.width - 900) / 2;
            var top = (screen.height - 500) / 2;
            var wnd = window.radopen('PrintPreview.aspx?InvoiceTypeId=' + InvoiceTypeId, "");
        }
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
            wnd.moveTo(8, 0);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        return false;
    }
    
    function chkUserUnits_OnChekedChanged(event, checkbox) {
        $("input[id$=btnUseUnits]").click();
    }

    function BindJSHandlers() {
        $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
            chkUserUnits_OnChekedChanged(e, this);
        });
      
    }