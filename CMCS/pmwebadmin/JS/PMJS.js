
//var Global_DecimalCharacter = '.';
//var Global_DecimalPrecision = '2';
//var Global_DecimalSeparator = ',';
//var Global_CurrencySymbol = '$';
//var Global_PercentCharacter = '%';


var opac2 = 80;
var browserdetect = "";

// Functions for the Message User Control -- >

//********************** RESIZE *************************************//
function OnResize()
{
    CleanPageSize();
    ResizeMasterPage();
}

function OnResizeIE()
{
    var t = setTimeout(OnResize, 5000);
}

function ResizeMasterPage() {
//    ScrollContent();
    // ResizeMenuToPage();
    if ($.browser.msie)
    {
        if (jQuery.browser.version == "7.0" || jQuery.browser.version == "6.0") {
            $('#tblMainTable').css({ 'width': $(window).width() - 15, 'height': $(window).height() - 4 });
            $('#ContentPane').css({ 'padding-left': '0px' });
        } else {
        $('#tblMainTable').css({ 'width': $(window).width() - 5, 'height': $(window).height() - 4 });
        }
    }
    else if ($.browser.safari)
    {
        $('#tblMainTable').css({ 'width': $(window).width() - 8, 'height': $(window).height() - 10 });
    }
    else
    {
        $('#tblMainTable').css({ 'width': $(window).width() - 8, 'height': $(window).height() });
    }
}

function ScrollContent() {
    var content_height = $(window).height() - 68;
    $('#divContentHolder').css({ 'overflow-y': 'auto', 'overflow-x': 'hidden' });
    if ($.browser.msie) {
        if (jQuery.browser.version == "7.0" || jQuery.browser.version == "6.0") {
            $('#divContentHolder').css({ 'height': content_height - 50 });
        } else { $('#divContentHolder').css({ 'height': content_height - 40 }); } 
        
    }
    else if ($.browser.safari) {
    $('#divContentHolder').css({ 'height': content_height - 47 });
    }
    else {
        $('#divContentHolder').css({ 'height': content_height - 20 });
    }
}

function ResizeMenuToPage() {

        var main_height = parseInt($(window).height());
        var menu_height = parseInt($('#ctl00_PmMenu').height());
        var header_height = 68;
        var OpenedMenu_height = main_height - menu_height - header_height;

            if ($.browser.msie) {
                $('.treeMenu').css({ 'height': OpenedMenu_height - 40 });
            }
            else if ($.browser.safari) {
                $('.treeMenu').css({ 'height': OpenedMenu_height - 47 });
            }
            else {
                $('.treeMenu').css({ 'height': OpenedMenu_height - 20 });
            }
}

function CleanPageSize()
{
    $('#tblMainTable').css({ 'width': '', 'height':'' });
    $('.treeMenu').css({ 'height': ''});
}

/***********************************************END RESIZE********************************/

function AlertMessage(top, left, text, time) {

    var color = "#ffd79d";
    $("#divMsg").stop(true, true);
    $("#divMsg").css({'top': top + 'px','left': left + 'px','visibility': 'visible','background-color': color}).show();
    clearTimeout(t);
    var t = setTimeout("$('#divMsg').fadeOut(3000)", time); 
    $("#MsgText").text(text);
}

function MsgLoad1(innerText, WarningLevel, posy, posx, duration) {
    var color = "#ffd79d";
    var top = (posy -20) + 'px';
    var left = (posx + 70) + 'px';
    
    if (WarningLevel == '1') { color = '#FF6666'; }
    else if (WarningLevel == '2') { color = '#FFFF00'; }
    else {color = '#99FF33';}
    $("#divMsg").css({ 'top': top + 'px','left': left + 'px','display':'absolute','visibility': 'visible','background-color': color}).show();
    clearTimeout(t); var t = setTimeout("$('#divMsg').fadeOut(3000)", duration);
    $("#MsgText").text(innerText);
}

function MsgLoad(innerText, WarningLevel, posy, posx, duration) {
    document.getElementById('divMsg').style.visibility = 'visible';
    document.getElementById('divMsg').style.top = posy + 'px';
    document.getElementById('divMsg').style.left = posx + 'px';
    document.getElementById('MsgText').innerHTML = innerText;
    if (WarningLevel == '1') {
        document.getElementById('divMsg').style.backgroundColor = '#FF6666';
    } else {
        if (WarningLevel == '2') {
            document.getElementById('divMsg').style.backgroundColor = '#FFFF00';
        } else {
            document.getElementById('divMsg').style.backgroundColor = '#99FF33';
        }
    }

    setTimeout('fadeOut()', duration);
}

function HideMsg() {
    document.getElementById('divMsg').style.display = 'none';
}

function fadeOut() {
    if (opac2 > 0) {
        opac2 -= 4;
     
            document.getElementById('divMsg').style.opacity = opac2 / 100;
        setTimeout('fadeOut()', 100);
    } else {
        document.getElementById('divMsg').style.display = 'none';
    }
}
//  -- > Functions for the Message User Control


/*****************COMMON TELERIK****************************/


/**********************************END COMMON TELERIK**************************/

function ConfirmDelete() { return confirm(DeleteSelectedItemsMessage); }


function UpdateGlobalVariables(CurrencySymbol, CurrencySymbolPosition, DecimalPrecision, DecimalCharacter, DecimalSeparator, PercentCharacter) {
    Global_CurrencySymbol = CurrencySymbol || Global_CurrencySymbol;
    Global_CurrencySymbolPosition = CurrencySymbolPosition || Global_CurrencySymbolPosition;
    Global_DecimalPrecision = DecimalPrecision || Global_DecimalPrecision; 
    Global_DecimalCharacter = DecimalCharacter || Global_DecimalPrecision;
    Global_DecimalSeparator = DecimalSeparator || Global_DecimalPrecision;
    Global_PercentCharacter = PercentCharacter || Global_PercentCharacter;
}


function FormatNumbers() {
    $(".Integer").numeric({ AllowNegative: true });
    $(".PositiveInteger").numeric();
    $(".Currency").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function(e) { $(this).val(CCur($(this).val(),$(this))); });
    $(".PositiveCurrency").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function(e) { $(this).val(CCur($(this).val(), $(this))); });
    $(".Double").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator });
    $(".PositiveDouble").numeric({ DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator });
    $(".Percent").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function(e) { $(this).val(percentFormatter.FormatPercent($(this).val(), $(this))); });
    $(".PositivePercent").numeric({ DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function(e) { $(this).val(percentFormatter.FormatPercent($(this).val(), $(this))); });
    $("#aspnetForm").attr("autocomplete", "off");
}

function CheckAnyAll(chk1, chk2) {
    if (document.getElementById(chk1).checked == true) {
        document.getElementById(chk1).checked = true;
        document.getElementById(chk2).checked = false;
    } else {
    document.getElementById(chk1).checked = false;
    document.getElementById(chk2).checked = true;
    }
}

function stop(event)
{
    var event = event || window.event;
    if (event == null) { return; }

    if (event.stopPropagation) { event.stopPropagation(); }
      else{event.cancelBubble = true;}
}


function StopPropagation(e){e.cancelBubble = true;if (e.stopPropagation){e.stopPropagation();}}


function DisplayRow() {
        document.getElementById('trDaily').style.display = 'none';
        document.getElementById('trWeekly').style.display = 'none';
        document.getElementById('trMonthly').style.display = 'none';
        document.getElementById('trInterval').style.display = 'none';
       
        var rblFrequency = document.getElementById('ctl00_ctl00_ContentPlaceHolder1_AssetContentPlaceHolder_Preventive_rblFrequency');
        var selectedValue = "";
        for (var i = 0; i < rblFrequency.childNodes[0].childNodes.length; i++) {
            var tr = rblFrequency.childNodes[0].childNodes[i];
            var inputRadio = tr.childNodes[0].childNodes[0];
            if (inputRadio.checked) {
                selectedValue = inputRadio.value;
                break;
            }
        }

        switch (selectedValue) {
            case 'Daily':
                document.getElementById('trDaily').style.display = 'inline';
                break;
            case 'Weekly':
                document.getElementById('trWeekly').style.display = 'inline';
                break;
            case 'Monthly':
                document.getElementById('trMonthly').style.display = 'inline';
                break;
            case 'Interval':
                document.getElementById('trInterval').style.display = 'inline';
                break;
            case 'None':
                document.getElementById('trDaily').style.display = 'inline';
                break;
        }
    }

    function ComboCheckAll(chk, comboId, hdnSelectedValuesId) {
        var combo = $find(comboId);
        var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
        var item = combo.get_items().getItem(0);
        var text = item.get_text();
        var values = item.get_value();
        var i = 0;
        $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function() {
            if (i != 0) {
                if (chk.checked) this.checked = false;
            }
            i++;
        });

//        if (text.length > 0) {
        if (chk.checked) {
            combo.set_text(text.trim());
            if (hdnSelectedValues) hdnSelectedValues.value = values;
        }
        else {
            combo.set_text("");
            if (hdnSelectedValues) hdnSelectedValues.value = "";
        }
    }
    
    
    function ComboCheckParent(chk, comboId, hdnSelectedValuesId) {
        var combo = $find(comboId);
        var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
        var chkParent = $("#" + comboId + "_DropDown").find("input[type='checkbox']")[0];

        var i = 0;
        var isChecked = true;
        var text = "";
        var values = "";
        var items = combo.get_items();
        $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function() {
            if (i != 0) {
                var item = items.getItem(i);
                if (this.checked) {
                    text += item.get_text() + ";";
                    values += item.get_value() + ";";
                }
                if (isChecked) isChecked = this.checked;
            }
            i++;
        });
        
        chkParent.checked = isChecked;
        
        if (isChecked) {
            var item = combo.get_items().getItem(0);
            text = item.get_text();
            values = item.get_value();
            i = 0;
            $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function() {
                if (i != 0) {
                    this.checked = false;
                }
                i++;
            });
        }

        text = removeLastSemiColon(text.trim());
        values = removeLastSemiColon(values.trim());

        if (text.length > 0) {
            combo.set_text(text);
            if (hdnSelectedValues) hdnSelectedValues.value = values;
        }
        else {
            combo.set_text("");
            if (hdnSelectedValues) hdnSelectedValues.value = "";
        }


        return false;
    }
    
    function ComboCheckAllWithoutFirstRow(chk, comboId, hdnSelectedValuesId) {
        var combo = $find(comboId);
        var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
        var item = combo.get_items().getItem(0);
        var text = item.get_text();
        var values = item.get_value();
        var i = 0;
        $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function() {
            // debugger;
            if (i != 0) {
                this.checked = chk.checked;
            }
            i++;
        });

//        if (text.length > 0) {
        if (chk.checked) {
            combo.set_text(text.trim());
            if (hdnSelectedValues) hdnSelectedValues.value = values;
        }
        else {
            combo.set_text("");
            if (hdnSelectedValues) hdnSelectedValues.value = "";
        }
    }
    
    
    function ComboCheckParentWithoutFirstRow(chk, comboId, hdnSelectedValuesId) {
        var combo = $find(comboId);
        var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
        var chkParent = $("#" + comboId + "_DropDown").find("input[type='checkbox']")[0];
        
        var i = 0;
        var isChecked = true;
        var text = "";
        var values = "";
        var items = combo.get_items();
        
        var itemSelected = 0;
        
        $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function() {
            if (i != 0) {
                var item = items.getItem(i);
                if (this.checked) {
                    itemSelected++;
                    text += item.get_text() + ";";
                    values += item.get_value() + ";";
                }
                if (isChecked) isChecked = this.checked;
            }
            i++;
        });
        
        chkParent.checked = isChecked;
        
        if(chkParent.checked)
            text = "*All*";
        else
        {
            if (itemSelected == 1)
                text = removeLastSemiColon(text.trim());
            else if (itemSelected > 1) {
                text = unescape(document.getElementById('ctl00$hdMultiple').value);
            }
            else
                text = "";
        }
            
        values = removeLastSemiColon(values.trim());

        if (text.length > 0) {
            combo.set_text(text);
            if (hdnSelectedValues) hdnSelectedValues.value = values;
        }
        else {
            combo.set_text("");
            if (hdnSelectedValues) hdnSelectedValues.value = "";
        }

        return false;
    }

    
    function removeLastSemiColon(str) {
        return str.replace(/;$/, "");
    }

    function RePosition(sender, args) {
        var divDropDown = $("#" + sender.get_id() + "_DropDown");
        var divNode = divDropDown.find("DIV")[0];
        divDropDown.css({ 'margin-left': 2 });
        divNode.className = divNode.className.replace("rcbScroll", "");

    }


    function conditionalPostback(e, sender) {
        
        if (sender.EventTargetElement) {sender.EventTargetElement.disabled = true;}
        var theRegexp = new RegExp("\.btnUpdateEdited$|\.btnSave$", "ig");
        if (sender.EventTarget.match(theRegexp)) {
            if (!window['UploadId']) return;            
            var upload = $find(window['UploadId']);
            if (upload) {
                //AJAX is disabled only if file is selected for upload
                if (upload.getFileInputs()[0].value != "") {
                    sender.EnableAjax = false;
                }
            }
            else {
                var uploadFile = $("#" + window['UploadId']);
                if (uploadFile.val() != "") {
                    sender.EnableAjax = false;
                }
            }
        }
    }

   function ResponseEnd(sender, args)
       {
            if (args.EventTargetElement){args.EventTargetElement.disabled = false;}
       }
       
    var GridNoteId = ""
    function DocumentNote_Creating(sender, args) {
        if (GridNoteId == "") GridNoteId = sender.ClientID;
    }
    function popUpNote(isNew) {
        var grid = $find(GridNoteId);
        if (grid.get_masterTableView().get_selectedItems().length > 0) {
            if (!isNew) return OpenPOPUp('DocumentNotesEditor.aspx', 1000, 600, true);
        }
        if (isNew) return OpenPOPUp('DocumentNotesEditor.aspx?IsNew=1', 1000, 600, true);
        return false;
    }

    /******* Enable/disable .Net validation without firing them ******/
    function ActivateValidator(val, enable) {
        val.enabled = enable;
        ValidatorUpdateDisplay(val);
    }


    function trim(str, chars) {
        return ltrim(rtrim(str, chars), chars);
    }

    function ltrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
    }

    function rtrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
    }

   