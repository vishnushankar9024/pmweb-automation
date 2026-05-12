function WindowClosed(sender, eventArgs) {
    var btnRefreshId = $("a[id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}

function CheckManual(chkManual, txtAmountId, RecordCurrencyId) {
    var txtAmount = $($('#' + txtAmountId)[0]);
    var chkNewLine = $($('#' + txtAmountId.replace('_txtAmount', '_chkAppendLine'))[0])[0];
    var ddlCurrencies = $find(txtAmountId.replace('_txtAmount', '_ddlCurrencies'));
    
    if (txtAmount && chkManual) {
        if (chkManual.checked) {
            txtAmount.removeAttr("readOnly");
        }
        else {
            txtAmount.attr("readOnly", "readOnly");
        }
    }
    if (ddlCurrencies && chkNewLine)
    {
        if (!(chkNewLine.checked))
        {
             if (chkManual.checked)
             {
                var comboitem = ddlCurrencies.findItemByValue("-1");
                if (comboitem != null) {
                    ddlCurrencies.get_items().remove(comboitem);
                }
                ddlCurrencies.set_enabled(true);
                $("[id='" + txtAmountId.replace('_txtAmount', '_ddlCurrencies') + "'] table:first").removeClass("rcbDisabled");
                ddlCurrencies.findItemByValue(RecordCurrencyId).select();
            }
             else
             {
                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_text("");
                comboItem.set_value("-1");
                var RecordItem = ddlCurrencies.findItemByValue(RecordCurrencyId);
                comboItem.get_attributes()._add("symbol", RecordItem.get_attributes().getAttribute("symbol"))
                comboItem.get_attributes()._add("symbolposition", RecordItem.get_attributes().getAttribute("symbolposition"))
                ddlCurrencies.get_items().add(comboItem);
                $("[id='" + txtAmountId.replace('_txtAmount', '_ddlCurrencies') + "'] table:first").addClass("rcbDisabled");
                comboItem.select();
                ddlCurrencies.set_enabled(false);
            }
        }
    }
}

function AppendLineClicked(chkNewLine, costCodeId, ddlCurrencyId, RecordCurrencyId) {
    var ddlCostCode = $($('#' + costCodeId)[0]);
    var chkManual = $($('#' + costCodeId.replace('_ddlCostCodes', '_chkIsManual'))[0])[0];
    if (ddlCostCode && chkNewLine) {
        if (chkNewLine.checked) {
            ddlCostCode.show();
        }
        else {
            ddlCostCode.hide();
        }
    }
    var ddlProjects = $($('#' + costCodeId.replace('_ddlCostCodes', '_ddlProjects'))[0]); 
    if ($find(costCodeId.replace('_ddlCostCodes', '_ddlProjects')) && chkNewLine) {
        if (chkNewLine.checked) {
            ddlProjects.show();
            ResetComboboxes(costCodeId.replace('_ddlCostCodes', '_ddlProjects'));
        }
        else {
            ResetComboboxes(costCodeId.replace('_ddlCostCodes', '_ddlProjects'));
            ddlProjects.hide();
        }
    }
    var ddlCurrencies = $find(ddlCurrencyId);
    if (ddlCurrencies && chkNewLine)
    {
        if (!(chkManual.checked))
        {
            if (chkNewLine.checked)
            {
                var comboitem = ddlCurrencies.findItemByValue("-1");
                if (comboitem != null) {
                    ddlCurrencies.get_items().remove(comboitem);
                }
                ddlCurrencies.set_enabled(true);
                $("[id='" + ddlCurrencyId + "'] table:first").removeClass("rcbDisabled");
                ddlCurrencies.findItemByValue(RecordCurrencyId).select();
            }
            else {
                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_text("");
                comboItem.set_value("-1");
                var RecordItem = ddlCurrencies.findItemByValue(RecordCurrencyId);
                comboItem.get_attributes()._add("symbol", RecordItem.get_attributes().getAttribute("symbol"))
                comboItem.get_attributes()._add("symbolposition", RecordItem.get_attributes().getAttribute("symbolposition"))
                ddlCurrencies.get_items().add(comboItem);
                $("[id='" + ddlCurrencyId + "'] table:first").addClass("rcbDisabled");
                comboItem.select();
                ddlCurrencies.set_enabled(false);
            }
        }
    }
}

function BindJSDHandlers() {
    $("input[id$=chkAutoCalculate]").changeCheckbox(function(e) {
    chkAutoCalculate_OnChekedChanged(e, this);
    });
}

function chkAutoCalculate_OnChekedChanged(event, checkbox) {
    $("input[id$=btnAutoCalculate]").click();
}


function Adjustment_ResetCombo(combobox, eventArgs) {
    var item = eventArgs.get_item();

    if (combobox.get_id().indexOf('ddlProjects') > 0) {
        //            combobox.trackChanges();
        //            combobox.set_value(item.get_value());
        //            combobox.commitChanges();
        ResetComboboxes(combobox.get_id());
    }
}

function ResetComboboxes(ddlProjectId) {
    var ddlCostCode = $find(ddlProjectId.substring(ddlProjectId.lastIndexOf('_'), ddlProjectId.lenght - 1) + '_ddlCostCodes');
    ddlCostCode.clearItems();
    ddlCostCode.set_text('');
    ddlCostCode.set_value('');

    var ddlADJGCompanies = $find(ddlProjectId.substring(ddlProjectId.lastIndexOf('_'), ddlProjectId.lenght - 1) + '_ddlADJGCompanies');
    ddlADJGCompanies.clearItems();
    ddlADJGCompanies.set_text('');
    ddlADJGCompanies.set_value('');

    var ddlADJCompanies = $find(ddlProjectId.substring(ddlProjectId.lastIndexOf('_'), ddlProjectId.lenght - 1) + '_ddlADJCompanies');
    ddlADJCompanies.clearItems();
    ddlADJCompanies.set_text('');
    ddlADJCompanies.set_value('');
}

function Adjustment_GetValueToReturn(combobox, eventArgs) {
    var SelectedValue;
    if ((combobox.get_id().indexOf('ddlCostCodes') > 0) || (combobox.get_id().indexOf('ddlADJGCompanies')) || (combobox.get_id().indexOf('ddlADJCompanies')))  {
        var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
        var chkAppendLine = $($('#' + combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_chkAppendLine')[0])[0];
        var context = eventArgs.get_context();
        context["AppendLine"] = chkAppendLine.checked;
        if (ddlProjects) {
            SelectedValue = ddlProjects.get_value();
            context["FilterString"] = SelectedValue;
        }
        else {
            context["FilterString"] = "" ;
        }
    }

}