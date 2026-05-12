
/************* Setup Management *******/

var ddlSystemFields;
var ddlSymbols;
var rdvSystemFields;
function ddlSystemFields_OnLoad(sender, eventArgs) {
    ddlSystemFields = sender;
    var tr = $("#" + ddlSystemFields.get_id()).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + ddlSystemFields.get_id()).parents("tr:first");
    var txtCalculation = $(tr.find("[id$='txtCalculation']")[0]);
    var cvCalculation = tr.find("[id$='cvCalculation']")[0];
    ActivateValidator(cvCalculation, false);
    if (txtCalculation.val() == "") {
    var rfvSymbols = tr.find("[id$='rfvSymbols']")[0];
    ActivateValidator(rfvSymbols, false);
    var csvSymbols = tr.find("[id$='csvSymbols']")[0];
    ActivateValidator(csvSymbols, false); 
    }
    txtCalculation.blur(function() {

        txtCalculation_Validator(this); 
        
        });
}
function rdvSystemFields_OnLoad(sender, eventArgs) {
    rdvSystemFields = sender;
}
function ddlSymbols_Load(sender, args) {
    ddlSymbols = sender;
}

function OpenWorksheetCostCodePopup(txt, event) {
    var CostCodeId = 0;
    var PeriodFromId = 0;
    var PeriodToId = 0;
 
    if ($(txt).attr("costcodeid") != null)
        CostCodeId = $(txt).attr("costcodeid");

    var StatusId = 0;
    if ($(txt).attr("StatusId") != null)
        StatusId = $(txt).attr("StatusId");


    var Columns = "0";
    if ($(txt).attr("Columns") != null)
        Columns = $(txt).attr("Columns");

    
    if ($(txt).attr("PeriodFromId") != null)
        PeriodFromId = ($(txt).attr("PeriodFromId"));

    if ($(txt).attr("PeriodToId") != null)
        PeriodToId = ($(txt).attr("PeriodToId"));

    OpenPOPUp("CostWorksheetEntry.aspx?CostcodeId=" +
                            CostCodeId + "&StatusId=" + StatusId + "&Columns=" + Columns, 697, 310, true);

    try {
        event.preventDefault();
    }
    catch (err) {

    }
    try {
        event.returnValue = false;
    }
    catch (err) {

    }
}
function txtCalculation_Validator(txtCalculation) {
    var me = $(txtCalculation);
    var tr = me.parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = me.parents("tr:first")
    var cvCalculation = tr.find("[id$='cvCalculation']")[0];
    var selectedNode = rdvSystemFields.get_selectedNode();
    var isCalculation = (selectedNode == null || selectedNode.get_value() == "0" || me.val() != "");
    //if (me.val() != "") {
    //    rdvSystemFields.unselectAllNodes();
    //    ddlSystemFields.clearSelection();
    //}
    ActivateValidator(cvCalculation, isCalculation);
    if (selectedNode && selectedNode.get_attributes().getAttribute("IsCurrency") == "true") {
        setSymbolSelectedItemByIndex(0);
    }
    
    (isCalculation) ? ddlSymbols.enable() : ddlSymbols.disable();
    var rfvSymbols = tr.find("[id$='rfvSymbols']")[0];
    ActivateValidator(rfvSymbols, isCalculation);
    var csvSymbols = tr.find("[id$='csvSymbols']")[0];
    ActivateValidator(csvSymbols, isCalculation);
}


function CheckValidation() {
    if (Page_ClientValidate("CostWorksheetColumns"))
        return true;
    return false;
}

function ddlSystemFields_OnClientDropDownOpenedHandler(sender, eventArgs) {
    var selectedNode = rdvSystemFields.get_selectedNode();
    if (selectedNode) {
        selectedNode.scrollIntoView();
    }
}


function rdvSystemFields_nodeClicking(sender, args) {
   
    var node = args.get_node();
    var tree = args.get_node().get_treeView();
    if (node.get_enabled()) {
        var tr = $("#" + ddlSystemFields.get_id()).parents(".rgEditForm:first");
        if (!tr || tr.length == 0)
            tr = $("#" + ddlSystemFields.get_id()).parents("tr:first");
        var txtColumnName = $(tr.find("input[id$='txtColumnName']")[0]);
        var txtCalculation = $(tr.find("[id$='txtCalculation']")[0]);
        var txtTooltip = $(tr.find("input[id$='txtTooltip']")[0]);
        
        var selectedValue = node.get_value();
        var selectedText = node.get_text();

        
        ddlSystemFields.trackChanges();
        ddlSystemFields.set_text(selectedText);
        ddlSystemFields.get_items().getItem(0).set_value(selectedValue);
        ddlSystemFields.get_items().getItem(0).set_text(selectedText);
        ddlSystemFields.commitChanges();
        ddlSystemFields.hideDropDown();

        ddlSymbols.clearSelection();

        
        if (selectedValue == "" || selectedValue == "0") {
            setSymbolSelectedItemByIndex(0);
            ddlSymbols.enable();
            txtColumnName.val("");
            txtTooltip.val("");
        } else {
            if (node.get_attributes().getAttribute("IsCurrency") == "true") {
                setSymbolSelectedItemByIndex(0);
            }
            var rfvSymbols = tr.find("[id$='csvSymbols']")[0];
           
            ddlSymbols.disable();
            txtCalculation.val("")
            txtColumnName.val(selectedText);
            txtTooltip.val(selectedText);
        }
        
    }
    else {
        args.set_cancel(true);
    }
}

function CheckSystemField(sender, args) {
    var tr = $("#" + ddlSystemFields.get_id()).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + ddlSystemFields.get_id()).parents("tr:first");
    var txtCalculation = $(tr.find("[id$='txtCalculation']")[0]);
    var calculationText = txtCalculation.val();
    if (calculationText == "") {
        var selectedNode = rdvSystemFields.get_selectedNode();
        if (selectedNode == null) {
            args.IsValid = false;
            return;
        }
        var selectedValue = selectedNode.get_value();
        if (selectedValue == "" || selectedValue == "0") {
            args.IsValid = false;
            return;
        }
    }
    args.IsValid = true;
    return;
}


function setSymbolSelectedItemByIndex(index) {
    ddlSymbols.enable();
    var item = ddlSymbols.get_items().getItem(index);
    ddlSymbols.trackChanges();
    ddlSymbols.set_value(item.get_value());
    ddlSymbols.set_text(item.get_text());
    item.select();
    ddlSymbols.commitChanges();
}
function openCalculationPopup(txtId) {
    var tr = $("#" + ddlSystemFields.get_id()).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + ddlSystemFields.get_id()).parents("tr:first");
    var txtCalculation = $(tr.find("[id$='txtCalculation']")[0]);
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('WorksheetCalculation.aspx?CalculationText=' + txtCalculation.val().replace(/\+/g, '@')+'&txtCalculationid='+txtId);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}


function onClose(window, result) {
    if (result !== 'undefined') {
        return;
        //var tr = $("#" + ddlSystemFields.get_id()).parents(".rgEditForm:first");
        //if (!tr || tr.length == 0)
        //    tr = $("#" + ddlSystemFields.get_id()).parents("tr:first");
        //var txtCalculation = $(tr.find("[id$='txtCalculation']")[0]);
        //$(txtCalculation).val(result.get_argument());
        //txtCalculation_Validator(txtCalculation);
    }
}


/*************************************/
function rdgCostWS_OnGridCreated(sender, args) {
    $($($("#" + sender._masterClientID).find("TFOOT")[0]).find("TD")[0]).addClass('rgExpandCol');
}


function WorksheetsLoaded(combo, eventArqs) {
    if (combo.get_items().get_count() > 0) {
        combo.set_text("");
    }
}


function PeriodsLoaded(combo, eventArqs) {
    if (combo.get_items().get_count() > 0) {
        combo.set_text(combo.get_items().getItem(0).get_text());
    }
}


function OpenCostWorksheetEntryPopup() {
    OpenPOPUp('CostWorksheetEntry.aspx?CostcodeId=0&StatusId=2&Columns=0', 697, 310, true);
}

function IsNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charcode = (evt.which) ? evt.which : evt.keyCode;
    if ((charcode > 32 && (charcode < 40 || charcode > 57)) || charcode == 44 || charcode == 46) { return false; }
    return true;
}