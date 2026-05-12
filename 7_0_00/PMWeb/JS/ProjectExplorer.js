var StatusddlOpenedvalues = "";
var allowdropdownClose;
function ProjectExplorerStatusddlOpened(sender, args) {
     StatusddlOpenedvalues = GetddlStatusSelectedValues(sender)
   

}

function ProjectExplorerStatusddlClosed(sender, args) {
    var ClosedValues = GetddlStatusSelectedValues(sender)
    if (StatusddlOpenedvalues != ClosedValues) {
        var btnddlStatusChanged = $("[id$=btnddlStatusChanged]");
        btnddlStatusChanged.click();
    }
}


function GetddlStatusSelectedValues(ddlStatus) {
    var comboId = ddlStatus.get_id();
    var currvalues = "";
    var Checkboxes = $("#" + comboId + "_DropDown").find("input[type='checkbox']")
    Checkboxes[0].checked
    for (i = 0; i < Checkboxes.length; i++) {
        if (Checkboxes[i].checked == true)
            currvalues += i + ";";
    }
    return currvalues;
}

function OnProjectExplorerClientNodeClicking(sender, args) {
    if (args.get_node().get_value() == "-2" || args.get_node().get_value().indexOf("Loc") == 0 || args.get_node().get_value().indexOf("PBS") == 0) {
        args.set_cancel(true);
    }
}

function GetValueToReturn(combobox, eventArgs) {
    var SelectedValue;
    var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
    var hdnField = $("[id$=" + hdn + "]")[0];
    var context = eventArgs.get_context();
    context["Ids"] = hdnField.value;
}
function check(sender, ddl, resultId, ResultName) {

    var combo = $find(ddl);
    var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
    var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
    var hdnNames = $("[id$=" + hdn1 + "]")[0];
    var hdnField = $("[id$=" + hdn + "]")[0];
    var vlue = hdnField.value;
    if (sender.checked) {
        hdnField.value = vlue + ',' + resultId;
        if (hdnNames.value == '') {
            hdnNames.value = ResultName;
            combo.set_text(ResultName)
        }
        else
            hdnNames.value = hdnNames.value + ',' + ResultName;
        combo.set_text(hdnNames.value)
    }
    else {
        var results = vlue.split(',');
        var resultNames = hdnNames.value.split(',');
        var i = 0;
        var newVal = '';
        var newNames = '';
        for (i = 0; i < results.length; i++) {
            if (results[i] != resultId)
                newVal = newVal + ',' + results[i];

        }
        var find = 1
        for (i = 0; i < resultNames.length; i++) {
            if (resultNames[i] != ResultName || find == 0) {
                newNames = newNames + ',' + resultNames[i];
            }
            else
                find = 0;
        }
        hdnField.value = newVal;
        if (newNames != '') {
            hdnNames.value = newNames.substring(1);
            combo.set_text(hdnNames.value)
        }
        else {
            hdnNames.value = newNames;
            combo.set_text(hdnNames.value)
        }
    }

}
function OnClientSelectedIndexChanging(combobox, eventArgs) {
    allowdropdownClose = false;
    eventArgs.set_cancel(true);
}
function OnClientDropDownClosing(combobox, eventArgs) {
    if (allowdropdownClose == false) {
        eventArgs.set_cancel(true);
    }
    allowdropdownClose = true;

}

function check(sender, ddl, resultId, ResultName) {

    var combo = $find(ddl);
    var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
    var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
    var hdnNames = $("[id$=" + hdn1 + "]")[0];
    var hdnField = $("[id$=" + hdn + "]")[0];
    var vlue = hdnField.value;
    if (sender.checked) {
        if (vlue.indexOf("-1") > -1 && resultId != "-1") {
            hdnField.value = ""
            hdnNames.value = "";
            vlue = "";
            var items = combo.get_items();
            for (var i = 0; i < items.get_count() ; i++) {
                var item = items.getItem(i);
                if (item.get_value() == "-1") {
                    var checkbox = item.get_element().getElementsByTagName("input")[0];
                    checkbox.checked = false;
                    break;
                }

            }

        }
        hdnField.value = vlue + ',' + resultId;
        if (hdnNames.value == '') {
            hdnNames.value = ResultName;
            combo.set_text(ResultName)
        }
        else
            hdnNames.value = hdnNames.value + ',' + ResultName;
        combo.set_text(hdnNames.value)
        if (resultId == "-1") {
            hdnField.value = resultId;
            hdnNames.value = ResultName;
            combo.set_text(ResultName)
            var items = combo.get_items();
            for (var i = 0; i < items.get_count() ; i++) {

                var item = items.getItem(i);
                if (item.get_value() != "-1") {
                    var checkbox = item.get_element().getElementsByTagName("input")[0];
                    checkbox.checked = false;
                }
            }
        }
    }
    else {
        var results = vlue.split(',');
        var resultNames = hdnNames.value.split(',');
        var i = 0;
        var newVal = '';
        var newNames = '';
        for (i = 0; i < results.length; i++) {
            if (results[i] != resultId)
                newVal = newVal + ',' + results[i];
        }
        var find = 1
        for (i = 0; i < resultNames.length; i++) {
            if (resultNames[i] != ResultName || find == 0) {
                newNames = newNames + ',' + resultNames[i];
            }
            else
                find = 0;
        }
        hdnField.value = newVal;
        if (newNames != '') {
            hdnNames.value = newNames.substring(1);
            combo.set_text(hdnNames.value)
        }
        else {
            hdnNames.value = newNames;
            combo.set_text(hdnNames.value)
        }
    }

}