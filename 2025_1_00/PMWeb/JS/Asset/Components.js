var OldVal;
function AdjustComponentsCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost

    $("input[id*=" + gridId + "][id$=chkServiceByDays]").click(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateLifeRemaining(row);
    });

    $("input[id*=" + gridId + "][id$=txtServiceIntervalUsage]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateServiceDueUsage(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtLastServiceUsage]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateServiceDueUsage(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtServiceIntervalDays]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateServiceDueDate(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtRemovedUsage]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateLifeToDateUsage(row);
        CalculateLifeToDateDays(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtInstalledUsage]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateLifeToDateUsage(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateTotals(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateTotals(row);
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
}
function CalculateTotals(row) {
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var lblTotalCost = row.find("span[id$='lblTotalCost']");
    lblTotalCost.html(CCur(CDbl(txtQuantity.val()) * CDbl(txtUnitCost.val())));

}


function CalculateLifeRemaining(row) {
    var chkServiceByDays = row.find("input[id$='chkServiceByDays']");
    var ServiceDueUsage = CDbl(row.find("span[id$='lblServiceDueUsage']").html());
    var lblLifeRemaining = row.find("span[id$='lblLifeRemaining']");
    var HeaderCurrentUsage = 0;
    var hdnCurrentUsage = row.find("input[id$='hdnCurrentUsage']");
    if (hdnCurrentUsage.length > 0) {
        HeaderCurrentUsage = CDbl(hdnCurrentUsage[0].value);
    }
    if (chkServiceByDays[0].checked == false) {
        lblLifeRemaining.html(FPrec(ServiceDueUsage - HeaderCurrentUsage));

    }
    else {
        hdnComponentTodayDate = $("[id$=hdnComponentTodayDate]")[0];
        txtServiceintervalDays = row.find("input[id$='txtServiceIntervalDays']");
        var ServiceintervalDays = CDbl(txtServiceintervalDays.val());
        var strId = txtServiceintervalDays[0].id;
        var dtpLastServiceDate = $find(strId.substring(strId.lastIndexOf('_'), strId.lenght - 1) + '_dtpLastServiceDate');
        if (dtpLastServiceDate.get_selectedDate() != null) {
            var LastServiceDate = new Date(dtpLastServiceDate.get_selectedDate().format("MM/dd/yyyy"));
            var today=new Date(parseFloat(hdnComponentTodayDate.value));
            today =new Date(today.format("MM/dd/yyyy"));
            var ServiceDueDays = LastServiceDate;
            ServiceDueDays = ServiceDueDays.setDate(ServiceDueDays.getDate() + ServiceintervalDays -1);
            duration = Math.round((ServiceDueDays - today.getTime()) / (3600000 * 24) + 1);
            lblLifeRemaining.html(FPrec(duration));
        }
        else {
            lblLifeRemaining.html(FPrec(0));
        }
    }
    CalculatePercentageRemaining(row);
    }

    function CalculateServiceDueUsage(row) { 
    var ServiceIntervalUsage= CDbl(row.find("input[id$='txtServiceIntervalUsage']").val());
    var  LastServiceUsage = CDbl(row.find("input[id$='txtLastServiceUsage']").val());
    var lblServiceDueUsage = row.find("span[id$='lblServiceDueUsage']");
    lblServiceDueUsage.html(FPrec(ServiceIntervalUsage + LastServiceUsage));
    CalculateLifeRemaining(row);
}

function CalculateServiceDueDate(row) {
    var txtServiceintervalDays = row.find("input[id$='txtServiceIntervalDays']");
    var ServiceintervalDays = CDbl(txtServiceintervalDays.val());
    var strId = txtServiceintervalDays[0].id;
    var dtpLastServiceDate = $find(strId.substring(strId.lastIndexOf('_'), strId.lenght - 1) + '_dtpLastServiceDate');
    var dtpServiceDueDate = $find(strId.substring(strId.lastIndexOf('_'), strId.lenght - 1) + '_dtpServiceDueDate');
    if (dtpLastServiceDate.get_selectedDate() != null) {
        var LastServiceDate = new Date(dtpLastServiceDate.get_selectedDate().format("MM/dd/yyyy"));
        var ServiceDueDays = LastServiceDate;
        ServiceDueDays = ServiceDueDays.setDate(ServiceDueDays.getDate() + ServiceintervalDays);
        dtpServiceDueDate.set_selectedDate(new Date(ServiceDueDays));
    }
    else {
        dtpServiceDueDate.clear();
    }
    CalculateLifeRemaining(row);
}

function LastServiceDate(sender, args) {
    var ctl = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtServiceIntervalDays');
    var row = $(ctl).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $(ctl).parents("tr:first");
    CalculateServiceDueDate(row);

}
function InstalledDateSelected(sender, args) {
    var ctl = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtServiceIntervalDays');
    var row = $(ctl).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $(ctl).parents("tr:first");
    CalculateLifeToDateDays(row);
}
function RemovedDateSelected(sender, args) {
    var ctl = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtServiceIntervalDays');
    var row = $(ctl).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $(ctl).parents("tr:first");
    if(sender.get_selectedDate() == null){
    var txtRemovedUsage = row.find("input[id$='txtRemovedUsage']");
    txtRemovedUsage.val(FPrec(0));
     CalculateLifeToDateUsage(row);}

    CalculateLifeToDateDays(row);
}
function CalculatePercentageRemaining(row) {
    var LifeRemaining = CDbl(row.find("span[id$='lblLifeRemaining']").html());
    var ServiceIntervalUsage = CDbl(row.find("input[id$='txtServiceIntervalUsage']").val());
    var chkServiceByDays = row.find("input[id$='chkServiceByDays']");
    var lblpercentRemaining = row.find("span[id$='lblRemainingPercentage']");
    var ServiceintervalDays = CDbl(row.find("input[id$='txtServiceIntervalDays']").val());
    var res;
    if (chkServiceByDays[0].checked == false) {
        if (ServiceIntervalUsage == 0) {
            if (LifeRemaining < 0) { lblpercentRemaining.html(CPrct(0)); }
            else { lblpercentRemaining.html(CPrct(100)); }
        }
        else {
             res=(LifeRemaining / ServiceIntervalUsage);
             if (res < 0) {
                 lblpercentRemaining.html(CPrct(0));
             }
             else {
                 lblpercentRemaining.html(CPrct(res * 100));
             }
            
        }
    }
    else {

        if (ServiceintervalDays == 0) {
            if (LifeRemaining < 0) { lblpercentRemaining.html(CPrct(0)); }
            else {   lblpercentRemaining.html(CPrct(100));}

        }
        else {
            res = (LifeRemaining / ServiceintervalDays);
            if (res < 0) {
                lblpercentRemaining.html(CPrct(0));
            }
            else {
                lblpercentRemaining.html(CPrct(res * 100));
            }
           
        
        
        }

    }

    if (CDbl(lblpercentRemaining.html()) > 100) {
        lblpercentRemaining.html(CPrct(100));
    }

}

function CalculateLifeToDateUsage(row) {
    var HeaderCurrentUsage = 0;
    var hdnCurrentUsage = $("[id$=hdnCurrentUsage]");
    var txtRemovedUsage = row.find("input[id$='txtRemovedUsage']");
    var lblLifeToDateUsage = row.find("span[id$='lblLifeToDateUsage']");
    var txtInstalledUsage = row.find("input[id$='txtInstalledUsage']");
    var InstalledUsage = CDbl(txtInstalledUsage.val());
    var RemovedUsage=CDbl(txtRemovedUsage.val());
    if (hdnCurrentUsage.length > 0) {
        HeaderCurrentUsage = CDbl(hdnCurrentUsage[0].value);
    }
    if (RemovedUsage == 0) {
        lblLifeToDateUsage.html(FPrec(HeaderCurrentUsage - InstalledUsage));

    }
    else {
        lblLifeToDateUsage.html(FPrec(RemovedUsage - InstalledUsage));
    
    }
}

function CalculateLifeToDateDays(row) {
   var txtRemovedUsage = row.find("input[id$='txtRemovedUsage']");
   var lblLifeToDateDays = row.find("span[id$='lblLifeToDateDays']");
    var RemovedUsage = CDbl(txtRemovedUsage.val());
    var strId = txtRemovedUsage[0].id;
    var dtpRemovedDate = $find(strId.substring(strId.lastIndexOf('_'), strId.lenght - 1) + '_dtpRemovedDate');
    var dtpInstalledDate = $find(strId.substring(strId.lastIndexOf('_'), strId.lenght - 1) + '_dtpInstalledDate');
    var hdnComponentTodayDate = $("[id$=hdnComponentTodayDate]")[0];
    var today = new Date(parseFloat(hdnComponentTodayDate.value));
        today = new Date(today.format("MM/dd/yyyy"));
        if (dtpRemovedDate.get_selectedDate() == null) {
            if (dtpInstalledDate.get_selectedDate() == null) {
                lblLifeToDateDays.html(FPrec(0));
            }
            else {
                var InstalledDate = new Date(dtpInstalledDate.get_selectedDate().format("MM/dd/yyyy"));
                var duration = today.getTime() - InstalledDate.getTime();
                lblLifeToDateDays.html(FPrec(Math.ceil(duration / (1000 * 3600 * 24))));
            }

        }
      else{
        if (dtpInstalledDate.get_selectedDate() != null) {
            var InstalledDate = new Date(dtpInstalledDate.get_selectedDate().format("MM/dd/yyyy"));
            var RemovedDate = new Date(dtpRemovedDate.get_selectedDate().format("MM/dd/yyyy"));
            var duration = RemovedDate.getTime() - InstalledDate.getTime();
            lblLifeToDateDays.html(FPrec(Math.ceil(duration/(1000*3600*24))));
        }
       else{
                lblLifeToDateDays.html(FPrec(0));
            }
           
        }



}

function OpenOffsetPopup(txtId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var ddlLateralOffsetUOMs = $find(txtId.substring(txtId.lastIndexOf('_'), txtId.lenght - 1) + '_ddlLateralOffsetUOMs');
    var ddlVerticalOffsetUOMs = $find(txtId.substring(txtId.lastIndexOf('_'), txtId.lenght - 1) + '_ddlVerticalOffsetUOMs');
    var VerticalUOMId = 0;
    var LateralUOMId = 0;
    if(ddlLateralOffsetUOMs.get_value()!=''){
        LateralUOMId = ddlLateralOffsetUOMs.get_value();
    } 
    if (ddlVerticalOffsetUOMs.get_value() != '') {
        VerticalUOMId = ddlVerticalOffsetUOMs.get_value();
    }
    var wnd = window.radopen('OffsetInformationPopUp.aspx?txtId=' + txtId + '&LateralUOMId=' + LateralUOMId + '&VerticalUOMId=' + VerticalUOMId);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth, browserHeight);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close();
    return false;

}




function DeleteComponentLines() {
 
    var grid = $find($("[id$=rdgEquComponents]")[0].id);
    var HasInventorySelected = false;
    var totalLines = grid.MasterTableView.get_selectedItems().length;
    for (var i = 0; i < totalLines; i++) {
        var row = grid.MasterTableView.get_selectedItems()[i];
        var InventoryStockId = row.getDataKeyValue("InventoryStockId")
        var InventoryQuantityReturned = row.getDataKeyValue("InventoryQuantityReturned")
        if (InventoryStockId > 0 && InventoryQuantityReturned=='False') {
            HasInventorySelected = true;
            break;
        }
    }
    if (HasInventorySelected) {
        return OpenPOPUp('DeleteInventoryComponentPopUp.aspx', 320, 129, false);
    }
    return ConfirmDelete();
}


function ClickSwitchComponentsButton() {
    var btn = $("input[id$=btnSwitchComponents]");
    btn.click();
    return false;
}
function ClickGenerateWorkOrderButton() {
    var btn = $("input[id$=btnGenerateWorkOrder]");
    btn.click();
}



function OpenPopupToRefreshTreeList(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth, browserHeight);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RefreshTreeList);
    return false;
}

function RefreshTreeList(Opener) {
    eval($("a[id$=lbtRefresh]")[0].href);
}

function OpenGenerateWorkOrderPopup(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(ClickGenerateWorkOrderButton);
    return false;
}
