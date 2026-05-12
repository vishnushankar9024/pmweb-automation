var StatusddlOpenedvalues = "";
var allowdropdownClose;

function ddlViewsClosed(sender) {
    sender._element.parentElement.parentElement.classList.remove("AngularControlClicked");

}
var ViewswDropDownOpened = false;
function ddlViewsOpened(sender) {
    ViewswDropDownOpened = true;
    sender._element.parentElement.parentElement.classList.add("AngularControlClicked");
   
    var SelectedItem = sender.get_selectedItem();
    if (SelectedItem) {
        $(SelectedItem.get_element()).addClass("SelectedItemClass")
    }
}


function ddlProjectStatusRemoveBorder() {
    var ddlProjectStatus = document.getElementById($("[id$=ddlProjectStatus]")[0].id);
    ddlProjectStatus.parentElement.parentElement.classList.remove("AngularControlClicked");

}
var StatusDropDownIsOpening = false;
function ProjectExplorerStatusddlOpened(sender, args) {
    StatusDropDownIsOpening = true;
    StatusddlOpenedvalues = GetddlStatusSelectedValues(sender);
    var comboId = sender.get_id()
    if (sender._value == -1) {
        document.querySelector(".rcbList").classList.add("SelectedItemClass");
    }
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
        if (this.checked) {
            this.parentElement.parentElement.classList.add("SelectedItemClass");
        }
       
       /* this.parentElement.parentElement.parentElement.classList.remove("SelectedItemClass");*/
    });
    sender._element.parentElement.parentElement.classList.add("AngularControlClicked");
    document.querySelector(".rcbItem").children[0].classList.add("Firstcombo-item");
    //if (sender.get_dropDownVisible()) {
    //    sender.hideDropDown();
    //}
   

}

function ProjectExplorerStatusddlClosed(sender, eventArgs) {
    var ClosedValues = GetddlStatusSelectedValues(sender);
    if (StatusddlOpenedvalues != ClosedValues && !event.srcElement.classList.contains("Clearddlbutton")) {
        var btnddlStatusChanged = $("[id$=btnddlStatusChanged]");
        btnddlStatusChanged.click();
    }
    sender._element.parentElement.parentElement.classList.remove("AngularControlClicked")
}

function ClearSelection(sender) {
    var ddlProjectStatus = $("[id$=ddlProjectStatus]")[0];
    var comboID = sender.previousElementSibling.id

    $("#" + comboID + "_DropDown").find("input[type='checkbox']").each(function () {
            this.checked = false;
            this.parentElement.parentElement.classList.remove("SelectedItemClass")
        this.parentElement.parentElement.parentElement.classList.remove("SelectedItemClass");
    });

    ddlProjectStatus.classList.remove("ItemsSelected");
    $find($("[id$=ddlProjectStatus]")[0].id).set_text("");
    $find($("[id$=ddlProjectStatus]")[0].id).set_value("");
    $("[id$=ClearSelection]")[0].style.display = "none";
    document.querySelector(".Clearddlbutton").style.display = "none";
        var btnddlStatusChanged = $("[id$=btnddlStatusChanged]");
        btnddlStatusChanged.click();
    
    return false;


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
var typingTimer;
var doneTypingInterval = 1500;
function txtSearchLoaded(sender) {
    var $filterInput =$( $("[id$='txtSearch']")[0])
    $filterInput.on("input", function () {
        clearTimeout(typingTimer);
        typingTimer = setTimeout(doneTyping, doneTypingInterval);
        ShowCancelButton()
    });

    $filterInput.on("keydown", function (e) {
        clearTimeout(typingTimer);
        if (e.key === "Enter" || e.keyCode === 13) {
            e.preventDefault(); // Optional: prevent form submission
            var hdnbtn = document.querySelector(".HiddenPostBack");
            hdnbtn.click();
        }
     
    });
}
function ShowCancelButton() {
    var ClearSearchModule = document.getElementById($("[id$=ClearSearch]")[0].id);
    var FilterInput = document.getElementById($("[id$=txtSearch]")[0].id);
    if (FilterInput.value != '') {
        ClearSearchModule.style.display = "block";
    }
    else {
        ClearSearchModule.style.display = "none";
       
       
    }
  
}
function doneTyping() {
    var FilterInput = document.getElementById($("[id$=txtSearch]")[0].id);
    var hdnbtn = document.querySelector(".HiddenPostBack");
    hdnbtn.click();
   
}
function ClearTimeout(sender, eventArgs) {
    clearTimeout(typingTimer);
    
}
function Cleartext() {
    if (typingTimer) clearTimeout(typingTimer);
    var ClearSearchModule = document.getElementById($("[id$=ClearSearch]")[0].id);
    var FilterInput = document.getElementById($("[id$=txtSearch]")[0].id);
    FilterInput.value = '';
    ClearSearchModule.style.display = "none";
    var hdnbtn = document.querySelector(".HiddenPostBack");
    hdnbtn.click();
    return false;
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
function ClosedllProjectStatus() {
    var ddlProjectStatus = $find($("[id$=ddlProjectStatus]")[0].id)
 
    if (!StatusDropDownIsOpening) {
        ddlProjectStatus.hideDropDown()
    }
   
    StatusDropDownIsOpening = false;
  
 

}
function ClosedllViews() {
    var ddlViews = $find($("[id$=ddlViews]")[0].id)
 
    if (!ViewswDropDownOpened) {
        ddlViews.hideDropDown()
    }
   
    ViewswDropDownOpened = false;
  

}
