//google.load("language", "1");

function initialize() {


}
//google.setOnLoadCallback(initialize);


function GoogleTranslateSelected(gridId) {
    var grid = $find($("[id$=" + gridId + "]")[0].id);
    var rows = grid.get_masterTableView().get_selectedItems();

    if (rows.length == 0) {alert("Select items to translate.");return false;}
    
    var ddlLanguages = $find($("[id$=ddlLanguages]")[0].id);
    var DestLang = ddlLanguages.get_selectedItem().get_value();
   //if( DestLang.indexOf("ar") != -1){
   // DestLang = "ar-LB";
   //}
    //if code is not found use culture code only
    if (!google.language.isTranslatable(DestLang)) {
        DestLang = DestLang.split("-")[0];
    }

    if (google.language.isTranslatable(DestLang)) {
        $("#divAlert").html("Please wait while google is translating...").show(300);
        for (var i = 0; i < rows.length; i++) {
            GoogleTranslatedValue(rows[i], DestLang, rows.length - 1 == i);
            }
        }else{
        alert("Invalid destination language code.");
        return false;
    }
    return false;
}

function GoogleTranslatedValue(row, DestLang, isLastItem) {
var value = row.findElement("lblDefaultValue").innerHTML;
google.language.translate(value, "en", DestLang,
                                    function(result) {
                                        if (result.translation) {
                                            updateValue(DestLang, value, result.translation,row)
                                            hideAlert(isLastItem);
                                        }
                                    });
   
}

function hideAlert(isLastItem) {
    if (isLastItem) {
        $("#divAlert").html("<img src='Images/Global/Approved.png'/> Text has been translated, Save to apply.");
        setTimeout('$("#divAlert").hide(400)', 5000);
    }
}



function updateValue(DestLang, value, result, row) {

    var txtValue = row.findElement("txtValue");
    var lblComment = row.findElement("lblComment");
    
    if (DestLang.split("-")[0] == "en") {
        txtValue.value = result;
    } else if (trim(value.toUpperCase()) == trim(result.toUpperCase())) {//if same
        txtValue.value = result + "";//add (en) for test
        lblComment.innerText = "Google has returned same word(s).";
    }
    else {

        txtValue.value = correctSentence(value, result);
    }
}


function correctSentence(value, result) {

    var regV = new RegExp(/{[0-9]+}/g);
    var regR = new RegExp(/\([0-9]+\)/g);
    var mtcV = regV.exec(value);
    var mtcR = regR.exec(result);

    if (mtcV != null && mtcR != null) {
        result = result.replace(mtcR[0], mtcV[0]);
        value = value.replace(mtcV[0], "$replaced$");
        return correctSentence(value, result);
    } else {
        return result;
    }
}

function ConfirmOnResourceFiles() {
    var resourceType = $("input[id$=hdnResourceType]").val();
    if (resourceType != 'Report') {
    return confirm('This command will Sign Out all connected Users, Are you sure you want to proceed?');
    }
}


function GetDefaultValuesSelected(gridId) {
    var grid = $find($("[id$=" + gridId + "]")[0].id);
    var rows = grid.get_masterTableView().get_selectedItems();
    if (rows.length == 0) { alert("Select items to translate."); return false; }

    $("#divAlert").html("Please wait while reseting the info...").show(300);


    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
            var DefaultValue = row.findElement("lblDefaultValue").innerHTML;
            var txtValue = row.findElement("txtValue");
            txtValue.value = DefaultValue;
        }
        $("#divAlert").html("<img src='Images/Global/Approved.png'/> Text has been restored, Save to apply.");
        setTimeout('$("#divAlert").hide(400)', 5000);
    return false;
}
function TriggerUpload() {
    $("#fluImage").click()
    return false;
}

$(document).ready(function () {
    $("#fluImage").change(function () {
        var uploadFile = $(this);
        $("#txtFileName").val(uploadFile.val().replace(/^.*\\/, ""));
    });

})