//function GetValueToReturn(combobox, eventArgs) {
//    var SelectedValue;
//    var ddlCompanies = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCompanies');
//    SelectedValue = ddlCompanies.get_value();
//    var context = eventArgs.get_context();
//    context[combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCompanies'] = SelectedValue;
//}

//function ResetCombos(combobox, eventArgs) {
//    var ddlContacts = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlContacts');
//    ddlContacts.clearItems();
//    ddlContacts.set_text("");
//    ddlContacts.set_value("0"); 
//}

//function DisableCombos(combobox, eventArgs) {
//    var ddlResources = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResources');
//    var ddlContacts = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlContacts');
//    var ddlCompanies = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCompanies');
//    if (ddlResources.get_value() != "") {
//        ddlContacts.trackChanges();
//        ddlContacts.clearItems();
//        ddlContacts.set_text("");
//        ddlContacts.set_value("0");
//        ddlContacts.set_enabled(false);
//        ddlContacts.commitChanges();
//        ddlCompanies.trackChanges();
//        ddlCompanies.clearItems();
//        ddlCompanies.set_text("");
//        ddlCompanies.set_value("0");
//        ddlCompanies.set_enabled(false);
//        ddlCompanies.commitChanges();
//    }
//    else {
//        ddlContacts.trackChanges();
//        ddlContacts.clearItems();
//        ddlContacts.set_text("");
//        var txtContacts = ddlContacts.get_inputDomElement();
//        txtContacts.disabled = false;
//        ddlContacts.set_value("0");
//        ddlContacts.set_enabled(true);
//        ddlContacts.commitChanges();
//        ddlCompanies.trackChanges();
//        ddlCompanies.clearItems();
//        ddlCompanies.set_text("");
//        var txtCompanies = ddlCompanies.get_inputDomElement();
//        txtCompanies.disabled = false;
//        ddlCompanies.set_value("0");
//        ddlCompanies.set_enabled(true);
//        ddlCompanies.commitChanges();
//    }
//}

function ResetCombos(combobox, eventArgs) {
    var item = eventArgs.get_item();
    if (combobox.get_id().indexOf('ddlResources') > 0) {
        var ddlResourcePayTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResourcePayTypes');
        ddlResourcePayTypes.clearItems();
        ddlResourcePayTypes.set_text(item.get_attributes().getAttribute("ResourcePayType"));
        ddlResourcePayTypes.set_value(item.get_attributes().getAttribute("PayTypeId"));
        var ddlResourceClasses = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResourceClasses');
        ddlResourceClasses.clearItems();
        ddlResourceClasses.set_text(item.get_attributes().getAttribute("ResourceClassification"));
        ddlResourceClasses.set_value(item.get_attributes().getAttribute("ClassificationId"));

    } 
}


function GetValueToReturn(combobox, eventArgs) {
    if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
        eventArgs.set_cancel(true);
    } else {
        eventArgs.set_cancel(false);
    }
    var SelectedValue;
        var ddlResources = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResources');
        SelectedValue = ddlResources.get_value();
    var context = eventArgs.get_context();
    context[combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlResources'] = SelectedValue;
}

function DateSelected(sender, e) {
    var finishdate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpFinishTime');
    var StartDate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_tpStartTime');   
        if (finishdate.get_selectedDate() != null) {
            var finishtime = new Date("1/1/2000 " + finishdate.get_selectedDate().format("HH:mm"));
            var starttime = new Date("1/1/2000 " + StartDate.get_selectedDate().format("HH:mm"));
            if (finishtime.getTime() >= starttime.getTime()) {
                var result = CDbl((finishtime.getTime() - starttime.getTime()) / 3600000);
                if (result >= 24) {//for the language;
                    result = CDbl(result) - 24;
                }
                var txtTotalHours = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('_')) + '_txtHours' + "]")[0];
                txtTotalHours.value=FPrec(result);
            }
            else if (starttime.getTime() >= finishtime.getTime()) {
                var result = CDbl((finishtime.getTime() - starttime.getTime()) / 3600000);
                if (result <= 24) {//for the language;
                    result = CDbl(Math.abs(result)) - 24;
                }
                var txtTotalHours = $("[id$=" + sender.get_id().substring(0, sender.get_id().lastIndexOf('_')) + '_txtHours' + "]")[0];
                txtTotalHours.value = Math.abs(FPrec(result));

            }
            
        }

      if (starttime.getTime() === finishtime.getTime()) {
          txtTotalHours.value = 24;
         }
}

function onSelectedIndexChanging(sender, eventArgs) {
    var HiddenField = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_HiddenField1';
    var combVal = sender.get_value();
    if (combVal == '' || combVal == '0') {
        var Control = document.getElementById(HiddenField);
        if (Control != null) {
            Control.value = '';
        }
    }
    if (sender.get_value() == '0') {
        OpenPOPUp('Contacts.aspx?Type=3', 775, 455, false);
    }
}

function OpenResourcePopup() {
    OpenPOPUp('ResourcePopup.aspx', 900, 460, true, 'rdgDailyReportTimesheet');
}
function OpenCompanyPopup() {
    OpenPOPUp('Contacts.aspx?Type=4', 775, 455, true, 'rdgOnSite');
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
function DisablePanelAjax() {
    //var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
    //updatePanel1.set_enableAJAX(false);
}