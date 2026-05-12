
function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var description =item._attributes.getAttribute("Description");
 
    var row = $("#" + itemId).parents(".rgEditForm:first");
    if (!row || row.length == 0)
        row = $("#" + itemId).parents("tr:first")
    row.find("input[id$='txtDescription']").val(description.replace(/^\s+/, ''));
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtTotalAmount']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtUnitCost']").val()))
                );
    });

    // On change unit cost
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtTotalAmount']").val(
                CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
    });

    // On change total amount
    $("input[id*=" + gridId + "][id$=txtTotalAmount]").change(function () {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        var unitCost = CDbl(tr.find("input[id$='txtUnitCost']").val());
        var calculatedUnitCost = CDbl(me.val()) / CDbl(tr.find("input[id$='txtQuantity']").val());
        var txtQuantity = tr.find("input[id$='txtQuantity']");
        var QuantityVal = CDbl(txtQuantity.val());

        if (unitCost != calculatedUnitCost) {
            if (QuantityVal == 0) {
                QuantityVal = 1
                txtQuantity.val(FPrec(1));
                        }
            tr.find("input[id$='txtUnitCost']").val(
                CCur(CDbl(me.val()) / QuantityVal));
        }
    });

}

function BindJSHandlers() {
    $("input[id$=ckbUseUnits]").changeCheckbox(function(e) {
        chkUserUnits_OnChekedChanged(e, this);
    });
}

function chkUserUnits_OnChekedChanged(event, checkbox) {
    $("input[id$=btnUseUnits]").click();
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