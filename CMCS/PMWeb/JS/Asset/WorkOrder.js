var OldVal;
function CalculateOtherCost(row, sender) {
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var txtExtCost = row.find("input[id$='txtExtCost']");
    txtExtCost.val(CCur(CDbl(txtQuantity.val()) * CDbl(txtUnitCost.val())));
}
function AdjustCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOtherCost(row, "UnitCost");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateOtherCost(row, "Quantity");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );

}

/////////////Resource Labors/////////////////////////////////

var ddlabor = null;
var ddlPayType = null;
var ddlClassification = null;
 




function ddlLoad(sender) { ddlabor = sender; }
function ddlPayTypeLoad(sender) { ddlPayType = sender; }
function ddlClassificationLoad(sender) { ddlClassification = sender; }

function SetTotalCost() {
    var Item = ddlClassification.get_selectedItem()
    var value = ddlPayType.get_value();
    if (Item != null && value != null) {
        if (Item._attributes.getAttribute(value) != null) {
            var Rate = CDbl(Item._attributes.getAttribute(value));
            var txtTotalCost = $("[id$=txtTotalCost]")[0];
            var txtTotalHours = $("[id$=txtTotalHours]")[0];
            txtTotalCost.value = CCur(CDbl(txtTotalHours.value) * Rate);
        }
    }
}


function ddlPayType_OnClientSelectedIndexChanged(sender, eventArgs) { SetTotalCost(); }
function ddlClassification_OnClientSelectedIndexChanged(sender, eventArgs) { SetTotalCost(); }



function AdjustLaborCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateLabors(row, "TotalCost");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtTotalHours]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateLabors(row, "totalHours");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );

}
function CalculateLabors(row, sender) {
    if (sender = "totalHours") {
        SetTotalCost();
    }
}


///////////Resource Equipments////////////////////////////////////////
var Operating = null;
var Standby = null;
var Idle = null;
var EqTotalHours = null;
var ddlEquipment = null;
var EqTotalCost = null;
var ddlEquipment=null;
function EqBlur(sender, args) {
    EqTotalHours.set_value(Operating.get_value() + Standby.get_value() + Idle.get_value());
    SetEqTotalCost();
}


function SetEqTotalCost() {
    var Item = ddlEquipment.get_selectedItem()
    if (Item != null) {
        var OPRate = CDbl(Item._attributes.getAttribute("OPERATING"));
        var STRate = CDbl(Item._attributes.getAttribute("STANDBY"));
        var IDRate = CDbl(Item._attributes.getAttribute("IDLE"));
        var txtEquipmentTotalCost = $("[id$=txtEquipmentTotalCost]")[0];
        var txtOperating = $("[id$=txtOperating]")[0];
        var txtStandby = $("[id$=txtStandby]")[0];
        var txtIdle = $("[id$=txtIdle]")[0];
        txtEquipmentTotalCost.value = CCur((CDbl(txtOperating.value) * OPRate) + (CDbl(txtStandby.value) * STRate) + (CDbl(txtIdle.value) * IDRate));
    }

}
function ddlEquipments_OnClientSelectedIndexChanged(sender, eventArgs) {

    SetEqTotalCost();
}
function ddlEqLoad(sender){
ddlEquipment=sender;

}
function EqStartDateSelected(sender, e) {
    var Checkbox = $("[id$=chkRegularHours]")[0];
    if (Checkbox.checked == true) {
        var finishdate = $find($("[id$=tpEqFinishTime]")[0].id);
        if (finishdate.get_selectedDate() != null) {

            var finishtime = new Date("1/1/2000 " + finishdate.get_selectedDate().format("HH:mm")); 
            var starttime = new Date("1/1/2000 " + e._newDate.format("HH:mm")); 

            if (finishtime.getTime() >= starttime.getTime()) {

                var result = Math.round(CDbl((finishtime.getTime() - starttime.getTime()) / 3600000));
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                var txtTotalHours = $("[id$=txtEquipmentTotalHours]")[0];
                var txtOperating = $("[id$=txtOperating]")[0];
                var txtStandby = $("[id$=txtStandby]")[0];
                var txtIdle = $("[id$=txtIdle]")[0];
                txtOperating.value = FPrec(result);
                txtTotalHours.value = FPrec(CDbl(result) + CDbl(txtIdle.value) + CDbl(txtStandby.value));
                SetEqTotalCost();
            }

        }
    }
}
function EqFinishDateSelected(sender, e) {
    var Checkbox = $("[id$=chkRegularHours]")[0];
    if (Checkbox.checked == true) {
        var Startdate = $find($("[id$=tpEqStartTime]")[0].id);
        if (Startdate.get_selectedDate() != null) {

            var starttime = new Date("1/1/2000 " + Startdate.get_selectedDate().format("HH:mm"));
            var finishtime = new Date("1/1/2000 " + e._newDate.format("HH:mm")); 

            if (finishtime.getTime() >= starttime.getTime()) {

                var result = Math.round(CDbl((finishtime.getTime() - starttime.getTime()) / 3600000));
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                var txtTotalHours = $("[id$=txtEquipmentTotalHours]")[0];
                var txtOperating = $("[id$=txtOperating]")[0];
                var txtStandby = $("[id$=txtStandby]")[0];
                var txtIdle = $("[id$=txtIdle]")[0];
                txtOperating.value = FPrec(result);
                txtTotalHours.value = FPrec(CDbl(result) + CDbl(txtIdle.value) + CDbl(txtStandby.value));
                SetEqTotalCost();
            }

        }
    }
}


function AdjustEquipmentCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtStandby]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateEquipment(row, "Standby");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtOperating]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateEquipment(row, "Operating");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtIdle]").change(function() {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateEquipment(row, "Idle");
    }
    ).focus(function() {
        OldVal = $(this).val();
    }
    );
}
function CalculateEquipment(row, sender) {
    var txtOperating = $("[id$=txtOperating]")[0];
    var txtStandby = $("[id$=txtStandby]")[0];
    var txtIdle = $("[id$=txtIdle]")[0];
    var txtTotalHours = $("[id$=txtEquipmentTotalHours]")[0];
    txtTotalHours.value = FPrec(CDbl(txtOperating.value) + CDbl(txtIdle.value) + CDbl(txtStandby.value));
    SetEqTotalCost();

}
///////////////////////////////////////////////////////////////////////////////////////////////
function AdjustLaborCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        SetTotalCost(row, "TotalCost");
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=txtTotalHours]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        SetTotalCost(row, "totalHours");
    }
    ).focus(function () {
        OldVal = $(this).val();
    });
     $("input[id*=" + gridId + "][id$=txtRate]").change(function () {
         var row = $(this).parents(".rgEditForm:first");
         if (!row || row.length == 0)
             row = $(this).parents("tr:first");
        SetTotalCost(row, "Rate");
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );

}

function SetTotalCost(row,sender) {
    var txtTotalCost = row.find("input[id$='txtTotalCost']");
    var txtRate = row.find("input[id$='txtRate']");
    var txtTotalHours = row.find("input[id$='txtTotalHours']");
   if(sender=="Rate" || sender=="totalHours")
   {
   txtTotalCost.val(CCur(CDbl(txtRate.val())*CDbl(txtTotalHours.val())));
   }
   else if(sender=="TotalCost")
   {
      if(CDbl(txtTotalHours.val())!=0)
      {
        txtRate.val(FPrec(CDbl(txtTotalCost.val())/CDbl(txtTotalHours.val())));
      }
    else if(CDbl(txtTotalHours.val())==0)
    {
    txtRate.val(FPrec(CDbl(txtTotalCost.val())));
    txtTotalHours.val(FPrec(1));
    }
   }

}

function ActualStartDateSelected(sender, e) {
    var txtTotalHours = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtTotalHours');
    var txtTotalCost = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtTotalCost');
    var txtRate = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtRate');
    var Startdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpActualStartTime');

    var finishdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpActualFinishTime');
    if (CDbl(txtTotalHours.value) == 0) {
        if (finishdate.get_selectedDate() != null) {

            var finishtime = new Date("1/1/2000 " + finishdate.get_selectedDate().format("HH:mm"));
            var starttime = new Date("1/1/2000 " + e._newDate.format("HH:mm"));

            if (finishtime.getTime() >= starttime.getTime()) {

                var result = CDbl((finishtime.getTime() - starttime.getTime()) / 3600000);
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                txtTotalHours.value = FPrec(result);
                txtTotalCost.value = CCur(CDbl(txtRate.value) * CDbl(result));

            }

        } 
    }
}

function ActualFinishDateSelected(sender, e) {
    var txtTotalHours = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtTotalHours');
    var txtTotalCost = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtTotalCost');
    var txtRate = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtRate');
    var Startdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpActualStartTime');
    if (Startdate.get_selectedDate() != null) {

        var starttime = new Date("1/1/2000 " + Startdate.get_selectedDate().format("HH:mm"));
        var finishtime = new Date("1/1/2000 " + e._newDate.format("HH:mm"));
        if (CDbl(txtTotalHours.value) == 0) {
            if (finishtime.getTime() >= starttime.getTime()) {

                var result = CDbl((finishtime.getTime() - starttime.getTime()) / 3600000);
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                txtTotalHours.value = FPrec(result);
                txtTotalCost.value = CCur(CDbl(txtRate.value) * CDbl(result));

            }
        }

    }
}

function DispatchedStartDateSelected(sender, e) {
    var txtTotalHours = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtDispatchedHours');
    var Startdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpDispatchedStartTime');

    var finishdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpDispatchedFinishTime');
    if (CDbl(txtTotalHours.value) == 0) {
        if (finishdate.get_selectedDate() != null) {

            var finishtime = new Date("1/1/2000 " + finishdate.get_selectedDate().format("HH:mm"));
            var starttime = new Date("1/1/2000 " + e._newDate.format("HH:mm"));

            if (finishtime.getTime() >= starttime.getTime()) {

                var result = CDbl((finishtime.getTime() - starttime.getTime()) / 3600000);
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                txtTotalHours.value = FPrec(result);

            }

        }
    }
}

function DispatchedFinishDateSelected(sender, e) {
    var txtTotalHours = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_txtDispatchedHours');
    var Startdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpDispatchedStartTime');
    if (Startdate.get_selectedDate() != null) {

        var starttime = new Date("1/1/2000 " + Startdate.get_selectedDate().format("HH:mm"));
        var finishtime = new Date("1/1/2000 " + e._newDate.format("HH:mm"));
        if (CDbl(txtTotalHours.value) == 0) {
            if (finishtime.getTime() >= starttime.getTime()) {

                var result = CDbl((finishtime.getTime() - starttime.getTime()) / 3600000);
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                txtTotalHours.value = FPrec(result);

            }
        }

    }
}




function ResetCombos(combobox, eventArgs) {
    var item = eventArgs.get_item();
 
    var txtTotalHours = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtTotalHours');
    var txtTotalCost = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtTotalCost');
    var txtRate = document.getElementById(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtRate');
    var SelectedValue = item.get_value();
    var Rate = 0; 
    if (combobox.get_id().indexOf('ddlLabors') > 0) {
        var ddlResourcePayTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPayType');
        ddlResourcePayTypes.clearItems();
        ddlResourcePayTypes.set_text(item.get_attributes().getAttribute("ResourcePayType"));
        ddlResourcePayTypes.set_value(item.get_attributes().getAttribute("PayTypeId"));
        combobox.trackChanges();
        combobox.set_value(item.get_value());
        combobox.commitChanges();
        var ddlResourceClasses = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlClassification');
        ddlResourceClasses.clearItems();
        ddlResourceClasses.set_text(item.get_attributes().getAttribute("ResourceClassification"));
        ddlResourceClasses.set_value(item.get_attributes().getAttribute("ClassificationId"));      
        Rate=item.get_attributes().getAttribute("Rate");
        txtRate.value = FPrec(CDbl(Rate));
        txtTotalCost.value = CCur(CDbl(Rate) * CDbl(txtTotalHours.value));
        var lblLinkedResource = $("#" + combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_lblLinkedResource');
        lblLinkedResource.html(item.get_attributes().getAttribute("LinkedResource"));
    }
    if (combobox.get_id().indexOf('ddlPayType') > 0) {
        var ddlLabor = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLabors');
        if (ddlLabor.get_value() == "") { return false; }
        if (ddlLabor.get_value().indexOf("LAB") == 0) {
            var ddlClasses = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlClassification');
            ClassValue = ddlClasses.get_value();
            if (ClassValue == "" || ClassValue == "0")
                return false;
            Rate = item.get_attributes().getAttribute(ClassValue);
            txtRate.value = FPrec(CDbl(Rate));
            txtTotalCost.value = CCur(CDbl(Rate) * CDbl(txtTotalHours.value));
        }
        else if (ddlLabor.get_value().indexOf("EQU") == 0) {
            Rate = item.get_attributes().getAttribute("Rate");
            txtRate.value = FPrec(CDbl(Rate));
            txtTotalCost.value = CCur(CDbl(Rate) * CDbl(txtTotalHours.value));
        }


    }

    if (combobox.get_id().indexOf('ddlClassification') > 0) {
        var ddlLabor = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLabors');
        var ddlResourcePayTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPayType');
       if (ddlLabor.get_value() == "") { return false; }
       if (ddlLabor.get_value().indexOf("LAB") == 0) {
           var PayTypesItemId = ddlResourcePayTypes.get_value(); ;
           if (PayTypesItemId == "" || PayTypesItemId=="0")
               return false;
           Rate = item.get_attributes().getAttribute(PayTypesItemId);
           txtRate.value = FPrec(CDbl(Rate));
           txtTotalCost.value = CCur(CDbl(Rate) * CDbl(txtTotalHours.value));

       }
    
    }

}

function GetValueToReturn(combobox, eventArgs) {
    var SelectedValue;
    if ((combobox.get_id().indexOf('ddlPayType') > 0) || (combobox.get_id().indexOf('ddlClassification') > 0)) {
        var ddlResources = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLabors');
        SelectedValue = ddlResources.get_value();

     var context = eventArgs.get_context();
     context[combobox.get_id()] = SelectedValue;
    }

}

function DeleteInstalledLines() {
    var grid = $find($("[id$=rdgInstalled]")[0].id);
    var HasInventorySelected = false;
    var totalLines = grid.MasterTableView.get_selectedItems().length;
    for (var i = 0; i < totalLines; i++) {
        var row = grid.MasterTableView.get_selectedItems()[i];
        var InventoryStockId = row.getDataKeyValue("InventoryStockId")
        if (InventoryStockId > 0) {
            HasInventorySelected = true;
            break;
        }
    }
    if (HasInventorySelected) {
        return OpenPOPUp('DeleteInventoryComponentPopUp.aspx', 320, 129, false);
    }
    return ConfirmDelete();
}

function AdjustServicedCalculation(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost
    $("input[id*=" + gridId + "][id$=txtCurrentReading]").change(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        CalculateReading(row, "totalHours");
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
    $("input[id*=" + gridId + "][id$=chkRemoved]").click(function () {
        var row = $(this).parents(".rgEditForm:first");
        if (!row || row.length == 0)
            row = $(this).parents("tr:first");
        OnCheckedChanged(row, "totalHours");
    }
    ).focus(function () {
        OldVal = $(this).val();
    }
    );
}

function CalculateReading(row, sender) {
    var txtPreviousReading = row.find("span[id$='lblPreviousReading']");
    var txtCurrentReading = row.find("input[id$='txtCurrentReading']");
    var lblUsage = row.find("span[id$='lblUsage']");
    lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.val()) - CDbl(txtPreviousReading.html()))));
//    var CurrentReading = txtCurrentReading.val();
//    var OldRow = row;
//    var lineNumber = CDbl(row.find("span[id$='lblLineNumber']").html());
//    row = row.next();
//    var Finish = 0;
//    while (row.length > 0) {
//        var NewLineNumber = CDbl(row.find("span[id$='lblLineNumber']").html());
//        if (lineNumber + 1 == NewLineNumber) {
//            var txtPreviousReading = row.find("span[id$='lblPreviousReading']");
//            txtPreviousReading.html(FPrec(CDbl(CurrentReading)))
//            var txtCurrentReading = row.find("input[id$='txtCurrentReading']");
//            var lblUsage = row.find("span[id$='lblUsage']");
//            if (txtCurrentReading.length > 0) {
//                lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.val()) - CDbl(txtPreviousReading.html()))));
//                CurrentReading = txtCurrentReading.val();
//            }
//            else {
//                txtCurrentReading = row.find("span[id$='lblCurrentReading']");
//                lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.html()) - CDbl(txtPreviousReading.html()))));
//                CurrentReading = txtCurrentReading.html();
//            }
//            Finish = 1;
//            break;
//        }
//        row = row.next();
//    }

//    if (Finish == 0) {
//        row = OldRow.prev();

//        while (row.length > 0) {
//            var lblLineNumber = row.find("span[id$='lblLineNumber']");
//            if (lblLineNumber.length == 0) { break; }
//            var NewLineNumber = CDbl(lblLineNumber.html());
//            if (lineNumber + 1 == NewLineNumber) {
//                var txtPreviousReading = row.find("span[id$='lblPreviousReading']");
//                txtPreviousReading.html(FPrec(CDbl(CurrentReading)))
//                var txtCurrentReading = row.find("input[id$='txtCurrentReading']");
//                var lblUsage = row.find("span[id$='lblUsage']");
//                if (txtCurrentReading.length > 0) {
//                    lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.val()) - CDbl(txtPreviousReading.html()))));
//                    CurrentReading = txtCurrentReading.val();
//                }
//                else {
//                    txtCurrentReading = row.find("span[id$='lblCurrentReading']");
//                    lblUsage.html(FPrec(CDbl(CDbl(txtCurrentReading.html()) - CDbl(txtPreviousReading.html()))));
//                    CurrentReading = txtCurrentReading.html();
//                }
//                Finish = 1;
//                break;
//            }
//            row = row.prev();
//        }


    //}

}

function OnCheckedChanged(row, sender) {
    var chkRemoved = row.find("input[id$='chkRemoved']")[0];
    var hdnReturnQuantity = row.find("input[id$='hdnReturnQuantity']")[0];
    if (chkRemoved.checked == true) {
        var InventoryStockId = $find("ctl00_CPH1_WorkOrderServiced1_rdgServiced_ctl00_ctl05_Detail10").extractKeysFromItem(row[0]).InventoryStockId;
        var InventoryQuantityReturned = $find("ctl00_CPH1_WorkOrderServiced1_rdgServiced_ctl00_ctl05_Detail10").extractKeysFromItem(row[0]).InventoryQuantityReturned;
       
        if (InventoryQuantityReturned =='True') {
            return false;
        }
        if (InventoryStockId > 0) {
            return OpenPOPUp('DeleteInventoryComponentPopUp.aspx?hddn=' + hdnReturnQuantity.id, 320, 135, false);
        }

    }
    else {
        hdnReturnQuantity.value='false';
    
    
    }
    return false;
}