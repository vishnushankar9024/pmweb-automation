//Sys.Application.add_load(BindOnload);

//function BindOnload() {
//    
//    $("input[id$=btnSaveBids]")
//}

function AdjustBidderCalculation(gridId) {
    var grid = $("#" + gridId);

    $("input[id*=" + gridId + "][id$=txtBidQuantity]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "TotalAmount");
    });

    $("input[id*=" + gridId + "][id$=txtUnitPrice]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "TotalAmount");
    });


    $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "UnitPrice");
    });
    
   $("input[id*=" + gridId + "][id$=txtMWDBEAmount]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "MWDBEAmount");
    });
    
       $("input[id*=" + gridId + "][id$=txtMWDBE]").change(function() {
        var row = $(this).parents("tr:first");
        Calculate(row, "MWDBE");
    });
    

}

function CalculateSumTotals() {
 //   CalculateSumTotalAmount();
  //  CalculateSumBidAmount();
}


function CalculateSumTotalAmount() {
    var TotalAmount = 0
    $("input[id$='txtTotalAmount']").each(function() {
        TotalAmount += CDbl($(this).val());
    });
    $("[id$='lblTotalTolalAmount']").html(CCur(TotalAmount));
}


function CalculateSumBidAmount() {
    var BidAmount = 0
    $("span[id$='lblLeveledTotal']").each(function() {
        BidAmount += CDbl($(this).html());
    });
    var lbl=$("[id$='lblTotalBidAmount']");
    if (lbl!=null){
    $("[id$='lblTotalBidAmount']").html(CCur(BidAmount));}
}

function Calculate(row, toCalculate) {
    var txtBidQuantity = row.find("input[id$='txtBidQuantity']");
    var txtUnitPrice = row.find("input[id$='txtUnitPrice']");
    var txtTotalAmount = row.find("input[id$='txtTotalAmount']");
    var txtBidAmount = row.find("span[id$='lblLeveledTotal']");;
    var hdnLeveledTotal = row.find("input[id$='hdnLeveledTotal']");
    var txtMWDBEAmount = row.find("input[id$='txtMWDBEAmount']");
    var txtMWDBE = row.find("input[id$='txtMWDBE']");
    
    var MWDBEPercent=CDbl(txtMWDBE.val());
    var MWDBEAmount=CDbl(txtMWDBEAmount.val());
    var QantityVal = CDbl(txtBidQuantity.val());
    var UnitPriceVal = CDbl(txtUnitPrice.val());
    var AmountVal = CDbl(txtTotalAmount.val());
    var LeveledTotal= CDbl(hdnLeveledTotal.val());


    if (toCalculate == "TotalAmount") {
          var totalAmount = UnitPriceVal * QantityVal
        txtTotalAmount.val(CCur(totalAmount));
        if (txtBidAmount !=null){
        txtBidAmount.html(CCur(totalAmount + LeveledTotal));}
        if(totalAmount==0){
         txtMWDBEAmount.val(CCur(0));
        txtMWDBE.val(CPrct(0));
        }
        else
        {
          txtMWDBEAmount.val(CCur((MWDBEPercent*totalAmount)/100));
        }

  }

  else if (toCalculate == "UnitPrice") {
    if (QantityVal == 0) {
            QantityVal = 1;
            txtBidQuantity.val(FPrec(1));
        }
        txtUnitPrice.val(CCur(AmountVal / QantityVal));
   
    if (txtBidAmount !=null){
            txtBidAmount.html(CCur(AmountVal + LeveledTotal));
            txtMWDBEAmount.val(CCur((MWDBEPercent*AmountVal)/100));
           if(AmountVal==0){
                txtMWDBEAmount.val(CCur(0));
                txtMWDBE.val(CPrct(0));
                }
            }
    }
    else if(toCalculate == "MWDBE")
    {
        if (MWDBEPercent>100)
        {
        MWDBEPercent=100;
        }
        txtMWDBEAmount.val(CCur((MWDBEPercent*AmountVal)/100));
    }
        else if(toCalculate == "MWDBEAmount")
    {
       if (MWDBEAmount>AmountVal){
       txtMWDBEAmount.val(CCur(AmountVal));
       
        if(AmountVal==0){
           txtMWDBE.val(CPrct(0));
        }
        else {
         txtMWDBE.val(CPrct(100));
        }
        
        
       }
       
      else if (AmountVal!=0){
         txtMWDBE.val(CPrct((MWDBEAmount/AmountVal)*100));
       
       }
    
    }
    CalculateSumTotals();
}

