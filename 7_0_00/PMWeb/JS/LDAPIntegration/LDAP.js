function GetValueToReturn(combobox, eventArgs) {
    if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
        eventArgs.set_cancel(true);
    } else {
        eventArgs.set_cancel(false);
    }
    var ddlLicenseTypes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLicenseTypes');
    SelectedValue = ddlLicenseTypes.get_value();
    var context = eventArgs.get_context();
    context["FilterString"] = SelectedValue;
}

function ResetCombos(combobox, eventArgs) {
    var ddlGroups = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlGroups');
    ddlGroups.clearItems();
    ddlGroups.set_text("");
    ddlGroups.set_value("0");
    
    var ddlIsNamedLic = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlIsNamedLic');
    ddlIsNamedLic.clearItems();
    ddlIsNamedLic.set_text("");
    ddlIsNamedLic.set_value("0");
}

function ddlContact_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents("tr:first");
    var ddlCompanies = $find(tr.find("[id$='ddlCompanies']")[0].id);
    var txtFirstName = tr.find("input[id$='txtFirstName']");
    var txtLastName = tr.find("input[id$='txtLastName']");
    var chkCreateContact = tr.find("input[id$='chkCreateContact']");

    txtFirstName.val(item.get_attributes().getAttribute("FirstName"));
    txtLastName.val(item.get_attributes().getAttribute("LastName"));

    var contactId = parseInt(item.get_value());
    if (contactId > 0) {
        ddlCompanies.clearSelection();
        ddlCompanies.set_enabled(false);
        txtFirstName.attr("readOnly", "true");
        txtLastName.attr("readOnly", "true");
        //        txtEmail.attr("readOnly", "true");
        chkCreateContact.attr("checked", false);
        chkCreateContact.attr("disabled", true);
    } else {
        //        if (contactId == 0) {
        //            return OpenContactsPopup(520, 300);
        //        }
        ddlCompanies.set_enabled(true);
        txtFirstName.removeAttr("readOnly");
        txtLastName.removeAttr("readOnly");
        chkCreateContact.removeAttr("disabled");
        //        txtEmail.removeAttr("readOnly");
    }

}

function ddlCompanies_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents("tr:first");
    var CompanyId = parseInt(item.get_value());
    var chkCreateContact = tr.find("input[id$='chkCreateContact']");
    var ddlContacts = $find(tr.find("[id$='ddlContacts']")[0].id);
    if (ddlContacts.get_selectedItem()) {
        var ContactId = parseInt(ddlContacts.get_selectedItem().get_value());
        if (ContactId > 0) {
            chkCreateContact.attr("disabled", true);
        } else {
            chkCreateContact.removeAttr("disabled");
        }
    } else {
        chkCreateContact.removeAttr("disabled");
    }


}