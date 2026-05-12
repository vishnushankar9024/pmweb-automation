
function ddlCostCodes_OnClientSelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;

    var descriptions =item._attributes.getAttribute("Description");
   
    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first")
    tr.find("input[id$='txtDescription']").val(descriptions.replace(/^\s+/, ''));
}


function OpenCOPopup() {
    OpenPOPUp('ProductionCOPopup.aspx', 900, 500, true);
}

function AdjustCostCalculation(gridId) {
    var grid = $("#" + gridId);

    // On change quantity
    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtTotal']").val(
            CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtRate']").val()))
            );
        tr.find("input[id$='txtCumulativeQuantity']").val(
            FPrec(CDbl(tr.find("input[id$='txtCumulativeQuantity']").val()) + CDbl(me.val()) - CDbl(tr.find("input[id$='hdnCurrentQuantity']").val()))
            );
        tr.find("input[id$='hdnCurrentQuantity']").val(FPrec(CDbl(me.val())));
    });

    // On change unit cost
    $("input[id*=" + gridId + "][id$=txtRate]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        tr.find("input[id$='txtTotal']").val(
            CCur(CDbl(me.val()) * CDbl(tr.find("input[id$='txtQuantity']").val()))
            );
    });

    // On change total amount
    $("input[id*=" + gridId + "][id$=txtTotal]").change(function() {
        var me = $(this);
        var tr = me.parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = me.parents("tr:first");
        var unitCost = CDbl(tr.find("input[id$='txtRate']").val());
        if(CDbl(tr.find("input[id$='txtQuantity']").val())!=0){
        var calculatedUnitCost = CDbl(me.val()) / CDbl(tr.find("input[id$='txtQuantity']").val());
        if (unitCost != calculatedUnitCost) {
            tr.find("input[id$='txtRate']").val(
                CCur(CDbl(me.val()) / CDbl(tr.find("input[id$='txtQuantity']").val()))
                );
        }}
        else
        tr.find("input[id$='txtRate']").val(
                CCur(0)
                );
        
    });

}

function DisablePanelAjax() {
    var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
    updatePanel1.set_enableAJAX(false);
}

function OnClientDropDownOpenedHandler(sender, eventArgs) {
    var tree = sender.get_items().getItem(0).findControl("rdvProductions");
    var selectedNode = tree.get_selectedNode();
    if (selectedNode) {
        selectedNode.scrollIntoView();
    }
}

function OnClientDropDownClosedHandler(sender, eventArgs) {

}

function rdvReqNodeClicking(sender, args) {
    var ComboId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
    var comboBox = $find(ComboId.substring(ComboId.lastIndexOf('_'), ComboId.lenght - 1)); 
    var node = args.get_node();
    var strText = "";
    var strValue = "";
    strValue = node.get_value();
    if (strValue.indexOf("SELECT") > 0 || strValue.indexOf("Contract")>0 || strValue.indexOf("ContractCO")>0 ) {



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
