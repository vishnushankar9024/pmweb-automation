jQuery.ajaxPrefilter(function (s) {
    if (s.crossDomain) {
        s.contents.script = false;
    }
});
//var Global_DecimalCharacter = '.';
//var Global_DecimalPrecision = '2';
//var Global_DecimalSeparator = ',';
//var Global_CurrencySymbol = '$';
//var Global_PercentCharacter = '%';


var opac2 = 80;
var browserdetect = "";

function ddlCurrencyChanged(ddl, args) {

    var tr = document.getElementById(ddl.get_id()).parentElement.parentElement;
    if ($('[id=' + ddl.get_id() + ']').parents('.rgEditForm').length > 0) {
        tr = $('[id=' + ddl.get_id() + ']').parents('.rgEditForm')[0];
    }
    var Symbol = ddl.get_selectedItem().get_attributes().getAttribute("symbol");
    var SymbolPosition = ddl.get_selectedItem().get_attributes().getAttribute("symbolposition")
    $('input[class=Currency]', tr).each(function () {
        $(this).val(CCCur(CDbl($(this).val()), Symbol, SymbolPosition))
        //if (this.id.indexOf('txtFunded')>0) {
        //    $(this).val(CCCur(CDbl(0), Symbol, SymbolPosition))
        //}
    });
    $('span[class=Currency]', tr).each(function () {
        $(this).html(CCCur(CDbl($(this).html()), Symbol, SymbolPosition))
    });


}
var skippages = ["properties.aspx", "buildings.aspx", "floors.aspx", "spaces.aspx", "equipments.aspx", "asset_suites.aspx", "leases.aspx", "workorders.aspx", "mergetemplates.aspx", "reservationrequest.aspx", "rfi.aspx", "vendorapprovals.aspx", "tenantrequests.aspx"]
function RenameHeaderTab(x) {
    if ($("[id$=tbsDocument]")[0] != undefined && $("[id$=tbsDocument]")[0] != null) {
        var tbsdocument = $find($("[id$=tbsDocument]")[0].id);
        if (skippages.indexOf(currPageName.toLowerCase()) < 0) { 
            if (tbsdocument)
                var HeaderTab = tbsdocument.findTabByValue("Header");
            if (x.matches) {
                // document.body.style.backgroundColor = "yellow";
                if (HeaderTab) {
                    HeaderTab.set_text(tab_Header);
                }
            }
            else {
                //document.body.style.backgroundColor = "red";
                if (HeaderTab) {
                    HeaderTab.set_text(tab_Main);
                }
            }
        }
    }
}

$(document).ready(function () {
    var x = window.matchMedia("(max-width:844px)");
    RenameHeaderTab(x); x.addListener(RenameHeaderTab);
    $('#next').click(function () { shiftSlide(-1) });
    $('#prev').click(function () {; shiftSlide(1) });
})

var dragEnd;
var dragStart;
var Carouselposition = 0;
var click = 100;
function shiftSlide(direction) {

    var nbrofslide = $('.RotatorDiv').length;
    var carousel = $('#carousel');

    totalnbrofmove = nbrofslide - 4;
    var posx = 0
    if (carousel.hasClass('transition')) {
        var currentTrans = carousel.css('transform').split(/[()]/)[1];
        posx = parseInt(currentTrans.split(',')[4].trim());
    }
    if ((Carouselposition == totalnbrofmove) && direction == -1) return;
    if ((Carouselposition == 0) && direction == 1) return;

    Carouselposition = Carouselposition + (direction * -1);
    dragEnd = dragStart;
    var currpos = 0;
    if (direction == 1)
        currpos = ((Carouselposition + 1) * 100 * -1) + 100;
    else
        currpos = ((Carouselposition - 1) * 100 * -1) - 100;
    $(document).off('mouseup')

    if (!carousel.hasClass('transition')) {
        carousel.off('mousemove').addClass('transition').css('transform', 'translateX(' + currpos + 'px');


    }
    else {

        carousel.off('mousemove').css('transform', 'translateX(' + currpos + 'px');
    }

}
// Functions for the Message User Control -- >


//********************** RESIZE *************************************//
function OnResize() {
    CleanPageSize();
    ResizeMasterPage();
}

function NoPortfolioAccessAlert() {

    alert(Msg_PortfolioSecurityRights);
    return false;
}

function OnResizeIE() {
    var t = setTimeout(OnResize, 5000);
}

function ResizeMasterPage() {
    //    ScrollContent();
    // ResizeMenuToPage();
    if ($.browser.msie) {
        if (jQuery.browser.version == "7.0" || jQuery.browser.version == "6.0") {
            $('#tblMainTable').css({ 'width': $(window).width() - 15, 'height': $(window).height() - 4 });
            $('#ContentPane').css({ 'padding-left': '0px' });
        } else {
            $('#tblMainTable').css({ 'width': $(window).width() - 5, 'height': $(window).height() - 4 });
        }
    }
    else if ($.browser.safari) {
        $('#tblMainTable').css({ 'width': $(window).width() - 8, 'height': $(window).height() - 10 });
    }
    else {
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

function CleanPageSize() {
    $('#tblMainTable').css({ 'width': '', 'height': '' });
    $('.treeMenu').css({ 'height': '' });
}

/***********************************************END RESIZE********************************/

function AlertMessage(top, left, text, time) {

    var color = "#ffd79d";
    $("#divMsg").stop(true, true);
    $("#divMsg").css({ 'top': top + 'px', 'left': left + 'px', 'visibility': 'visible', 'background-color': color }).show();
    clearTimeout(t);
    var t = setTimeout("$('#divMsg').fadeOut(3000)", time);
    $("#MsgText").text(text);
}

function MsgLoad1(innerText, WarningLevel, posy, posx, duration) {
    var color = "#ffd79d";
    var top = (posy - 20) + 'px';
    var left = (posx + 70) + 'px';

    if (WarningLevel == '1') { color = '#FF6666'; }
    else if (WarningLevel == '2') { color = '#FFFF00'; }
    else { color = '#99FF33'; }
    $("#divMsg").css({ 'top': top + 'px', 'left': left + 'px', 'display': 'absolute', 'visibility': 'visible', 'background-color': color }).show();
    clearTimeout(t); var t = setTimeout("$('#divMsg').fadeOut(3000)", duration);
    $("#MsgText").text(innerText);
}

function GetDocumentHeight() {
    var DocBody = document.body;
    var Dochtml = document.documentElement;

    return Math.max(DocBody.scrollHeight, DocBody.offsetHeight, Dochtml.clientHeight, Dochtml.scrollHeight, Dochtml.offsetHeight);

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

    if (navigator.userAgent.toLowerCase().indexOf('firefox') > -1) {
        browserdetect = "mozilla";
    } else {
        browserdetect = "ie";
    }
    setTimeout('fadeOut()', duration);
}

function HideMsg() {
    document.getElementById('divMsg').style.display = 'none';
}

function fadeOut() {
    if (opac2 > 0) {
        opac2 -= 4;
        if (browserdetect == "ie") {
            if (document.getElementById('divMsg').filters) { document.getElementById('divMsg').filters.alpha.opacity = opac2; }

        } else {
            document.getElementById('divMsg').style.opacity = opac2 / 100;
        }
        setTimeout('fadeOut()', 100);
    } else {
        document.getElementById('divMsg').style.display = 'none';
    }
}

function confirmForceAccess() {
    var answer = confirm("This user is already logged into this database. If you continue, the other session will be terminated and data may be lost. Do you wish to continue?")
    if (answer) {
        $("#btnFLogin").click();
    }
    else {
        return false;
    }
}




//  -- > Functions for the Message User Control


/*****************COMMON TELERIK****************************/


/**********************************END COMMON TELERIK**************************/

function ConfirmDelete() { return confirm(Msg_ConfirmDelete); }
function ConfirmUpdateTasks() { return confirm(Msg_ConfirmUpdateTasks); }
function ConfirmUnlinkCommitments() { return confirm(Msg_ConfirmUnlinkCommitments); }
function ConfirmDeletePaymentBatchDetails() { return confirm(unescape(Msg_ConfirmDeletePaymentBatchDetails)); }

function UpdateGlobalVariables(CurrencySymbol, CurrencySymbolPosition, DecimalPrecision, DecimalCharacter, DecimalSeparator, PercentCharacter) {
    Global_CurrencySymbol = CurrencySymbol || Global_CurrencySymbol;
    Global_CurrencySymbolPosition = CurrencySymbolPosition || Global_CurrencySymbolPosition;
    Global_DecimalPrecision = DecimalPrecision || Global_DecimalPrecision;
    Global_DecimalCharacter = DecimalCharacter || Global_DecimalPrecision;
    Global_DecimalSeparator = DecimalSeparator || Global_DecimalPrecision;
    Global_PercentCharacter = PercentCharacter || Global_PercentCharacter;
}


function FormatNumbers() {
    //if ($('select[id*="ddlCurrencyId"]').length > 0) {
    //    $($('select[id*="ddlCurrencyId"]')[0]).attr("onchange", "CurrencyChanged(this)");
    //}
    $("input.Integer").numeric({ AllowNegative: true });
    $("input.PositiveInteger").numeric();
    $("input.Currency").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function (e) { $(this).val(CCur($(this).val(), $(this))); });
    $("input.PositiveCurrency").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function (e) { $(this).val(CCur($(this).val(), $(this))); });
    $("input.Double").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator });
    $("input.PositiveDouble").numeric({ DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator });
    $("input.Percent").numeric({ AllowNegative: true, DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function (e) { $(this).val(percentFormatter.FormatPercent($(this).val(), $(this))); });
    $("input.PositivePercent").numeric({ DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function (e) { $(this).val(percentFormatter.FormatPercent($(this).val(), $(this))); });
    $("input.PmPickerDate").focus(function (e) { $(this).click() }).click(function (e) { ShowPopupDate($(this)[0], e); }).blur(function (e) { parseDate($(this)[0], e); });
    $("input.NoDecimalPercent").numeric({ DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: '0', DecimalSeparator: Global_DecimalSeparator }).on("keypress", function (evt) { var keycode = evt.charCode || evt.keyCode; if (keycode == 46) { return false; } }).blur(function (e) { $(this).val(parseInt($(this).val()) + '%'); });
    $("input.Longtitude").LongtitudeText();
    $("#aspnetForm").attr("autocomplete", "off");
    $("input.PositiveIntegerDouble").numeric({ DecimalCharacter: Global_DecimalCharacter, DecimalPrecision: Global_DecimalPrecision, DecimalSeparator: Global_DecimalSeparator }).blur(function (e) {
        if ($(this).val() % 1 == 0) {
            $(this).val(parseInt($(this).val()))
        }
    });
    disableBackSpace();
    FormatDecimalNumbers();
}

function FormatDecimalNumbers()
{
    var txtNumeric = document.querySelector(".Numeric");
    if (txtNumeric) {
        txtNumeric.addEventListener("keydown", function (e) {
            var characterRegex = new RegExp(Global_DecimalCharacter, "g");
            if (((e.key.match(/([0-9]+[,.]*)+/) == null && e.key.match(characterRegex) == null)) && e.keyCode != 8 && e.keyCode != 37 && e.keyCode != 39 && e.keyCode != 109) {
                e.preventDefault();
            }
            if (e.key == Global_DecimalCharacter || e.key == Global_DecimalCharacter) {
                if (this.selectionStart == 0 && this.selectionEnd == this.value.length || this.value.indexOf(e.key) == -1)
                    return false;
                if (this.value.indexOf(Global_DecimalCharacter) >= this.selectionStart && this.value.indexOf(Global_DecimalCharacter) <= this.selectionEnd && this.selectionStart != this.selectionEnd)
                    return false;
                e.preventDefault();
            }

            if (e.keyCode == 109) {

                if (this.selectionStart != 0)
                    e.preventDefault();
                if (this.value.indexOf('-') >= this.selectionStart && this.value.indexOf('-') <= this.selectionEnd || this.value.length == 0 || (this.selectionStart == 0 && this.selectionEnd == this.value.length) || this.value.indexOf(e.key) == -1) {
                    return false;
                }
                e.preventDefault();
            }

        });

        txtNumeric.addEventListener("change", function () {
            let seperatorRegex = new RegExp(Global_DecimalSeparator, "g")
            if (this.value.indexOf(Global_DecimalSeparator) > -1)
                this.value = this.value.replace(seperatorRegex, '');
            if (this.value.indexOf(Global_DecimalCharacter) > -1)
                this.value = this.value.replace(Global_DecimalCharacter, '.');
            if (this.value.indexOf('.') > -1) {
                var value = this.value;
                value = parseFloat(value);
                value = value.toFixed(parseInt(Global_DecimalPrecision));
                this.value = value;
            }
            this.value = parseFloat(this.value) ? parseFloat(this.value) : 0;
            this.value = this.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, Global_DecimalSeparator);
            this.value = this.value.replace('.', Global_DecimalCharacter);

        });
    }
}

function SetNotUnderlinedLinks() {
    $(".Icon").parent('a').css("text-decoration", "none");
}


function isNumeric(n) { return !isNaN(parseFloat(n)) && isFinite(n); }


function disableBackSpace() {
    $(document).keydown(function (e) {

        var elementType = e.target.nodeName.toLowerCase();

        if ((elementType != 'input' && elementType != 'textarea') || e.target.getAttribute("readonly") == "readonly") {
            if (e.keyCode == 8) {
                return false;
            };
        }
    });
}

function ListInputs() {
    $("table.DisabledInput").each(function () {
        $(this).find("input[type='checkbox'],input[type='radio']").each(function () {
            $(this).attr("disabled", "disabled");
        });
    });

    $("table.EnabledInput").each(function () {
        $(this).find("input[type='checkbox'],input[type='radio']").each(function () {
            $(this).removeAttr("disabled");
        });
    });
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

function stop(event) {
    var event = event || window.event;
    if (event == null) { return; }

    if (event.stopPropagation) { event.stopPropagation(); }
    else { event.cancelBubble = true; }
}


function StopPropagation(e) {
    var event = event || window.event;
    if (event == null) { return; }

    if (event.stopPropagation) { event.stopPropagation(); }
    else { event.cancelBubble = true; }
}


function DisplayRow() {
    document.getElementById('trDaily').style.display = 'none';
    document.getElementById('trWeekly').style.display = 'none';
    document.getElementById('trMonthly').style.display = 'none';
    document.getElementById('trInterval').style.display = 'none';
    document.getElementById('trOnce').style.display = 'none';
    var rblFrequency = document.getElementById('ctl00_ctl00_CPH1_ACPH1_Preventive_rblFrequency');
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
        case 'None':
            document.getElementById('trOnce').style.display = 'inline-block';

            break;
        case 'Daily':
            document.getElementById('trDaily').style.display = 'inline-block';
            break;
        case 'Weekly':
            document.getElementById('trWeekly').style.display = 'inline-block';
            break;
        case 'Monthly':
            document.getElementById('trMonthly').style.display = 'inline-block';
            break;
        case 'Interval':
            document.getElementById('trInterval').style.display = 'inline-block';
            break;
        case 'None':
            document.getElementById('trDaily').style.display = 'inline-block';
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
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
        if (i != 0) {
            if (chk.checked) this.checked = false;
        }
        i++;
    });

    //        if (text.length > 0) {
    if (chk.checked) {
        combo.set_text(text.trim());
        combo.set_value(values);
        if (hdnSelectedValues) hdnSelectedValues.value = values;
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnSelectedValues) hdnSelectedValues.value = "";
    }
}


function ComboCheckParentWithouALL(chk, comboId, hdnSelectedValuesId) {
    var combo = $find(comboId);
    var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);


    var i = 0;
    var isChecked = true;
    var text = "";
    var values = "";
    var items = combo.get_items();
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
        if (i != -1) {
            var item = items.getItem(i);
            if (this.checked) {
                text += item.get_text() + ";";
                values += item.get_value() + ";";
            }
            if (isChecked) isChecked = this.checked;
        }
        i++;
    });



    //        if (isChecked && items.length > 2) {
    //            var item = combo.get_items().getItem(0);
    //            text = item.get_text();
    //            values = item.get_value();
    //            i = 0;
    //            $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
    //                if (i != 0) {
    //                    this.checked = false;
    //                }
    //                i++;
    //            });
    //        }

    text = removeLastSemiColon(text.trim());
    values = removeLastSemiColon(values.trim());

    if (text.length > 0) {
        combo.set_text(text);
        combo.set_value(values);
        if (hdnSelectedValues) {
            hdnSelectedValues.value = values;

        }
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnSelectedValues) hdnSelectedValues.value = "";
    }
    return false;
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
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
        if (i != 0) {
            var item = items.getItem(i);
            if (this.parentElement.parentElement.className.indexOf('Hide') >= 0)
                this.checked = false;

            if (this.checked) {
                text += item.get_text() + ";";
                values += item.get_value() + ";";
            }


            if (isChecked && this.parentElement.parentElement.className.indexOf('Hide') < 0) isChecked = this.checked;
        }
        i++;
    });

    chkParent.checked = isChecked && items._array.length > 2;

    if (isChecked && items._array.length > 2) {
        var item = combo.get_items().getItem(0);
        text = item.get_text();
        values = item.get_value();
        i = 0;
        $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
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
        combo.set_value(values);
        if (hdnSelectedValues) {
            hdnSelectedValues.value = values;

        }
    }
    else {
        combo.set_text("");
        combo.set_value("");
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
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
        if (i != 0) {
            this.checked = chk.checked;
        }
        i++;
    });

    //        if (text.length > 0) {
    if (chk.checked) {
        combo.set_text(text.trim());
        combo.set_value(values);
        if (hdnSelectedValues) hdnSelectedValues.value = values;
    }
    else {
        combo.set_text("");
        combo.set_value("");
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

    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {
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

    if (chkParent.checked)
        text = Msg_All;
    else {
        if (itemSelected == 1)
            text = removeLastSemiColon(text.trim());
        else if (itemSelected > 1) {
            text = Msg_Multiple;
        }
        else
            text = "";
    }

    values = removeLastSemiColon(values.trim());

    if (text.length > 0) {
        combo.set_text(text);
        combo.set_value(values);
        if (hdnSelectedValues) hdnSelectedValues.value = values;
    }
    else {
        combo.set_text("");
        combo.set_value("");
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

var DisableControls = true;

function PMFormSubmit(PMForm, e) {
    if (typeof (ValidatorOnSubmit) == "function" && ValidatorOnSubmit() == false) return false;
    var EventTarget = $('form').find('input[name=__EVENTTARGET]');
    if ((EventTarget.length == 1 && EventTarget.val().indexOf('Excel') > 0) || DisableControls == false) {
        DisableControls = true;
        return true;
    }
    $("[id=DisableAllControlsOnPostback]").removeClass("Hide");
    return true;
}

function RequestStart(sender, args) {
    if (args.EventTarget) {
        if (window.location.pathname.toLowerCase().indexOf("initiativesbudget.aspx") >= 0 && (args.EventTarget.indexOf("$DocumentTasks1") >= 0 || args.EventTarget.indexOf("$tbsDocument") >= 0)) {
            args.EnableAjax = false;
            return;
        }

        if (window.location.pathname.toLowerCase().indexOf("tasks.aspx") >= 0
            && (args.EventTarget.indexOf("$DocumentAttachments$") >= 0
                || (args.EventTarget.indexOf("$DocumentNotes$") >= 0 && (args.EventTarget.indexOf("$btnDelete") >= 0 || args.EventTarget.indexOf("$btnRefresh") >= 0))
                || (args.EventTarget.indexOf("$NotificationLog1") >= 0 && (args.EventTarget.indexOf("$btnDelete") >= 0 || args.EventTarget.indexOf("$btnRefresh") >= 0 || args.EventTarget.indexOf("$btnRebindNotificationGrid") >= 0)))) {
            args.EnableAjax = false;
            return;
        }

        if (window.location.pathname.toLowerCase().indexOf("pmwebviewer.aspx") >= 0
            && (args.EventTarget.indexOf("$DocumentAttachments$") >= 0 || args.EventTarget.indexOf("$DocumentNotes$") >= 0)) {
            args.EnableAjax = false;
            return;
        }

        if ((window.location.pathname.toLowerCase().indexOf("bimmodelmanager.aspx") >= 0 || window.location.pathname.toLowerCase().indexOf("pmwebviewer.aspx") >= 0) && (args.EventTarget.indexOf("$tbsDocument") >= 0)) {
            args.EnableAjax = false;
            return;
        }

        if (args.EventTarget.indexOf("$WorkflowDocument") >= 0) {
            if ((args.EventTarget.indexOf("$btnOk") + args.EventTarget.indexOf("$btnDeleteWorkflow") + args.EventTarget.indexOf("$btnSaveWorkflow")) >= 0) {
                args.EnableAjax = false;
                return;
            }
        }
        var SearchFiles = new RegExp("\.btnSearch", "ig");
        if (window.location.pathname.toLowerCase().indexOf("foldermanager.aspx") >= 0 && args.EventTarget.match(SearchFiles)) {
            args.EnableAjax = false;
            return;
        }


        var ExportExcel = new RegExp("\.btnExportExcel$", "ig");
        if (args.EventTarget.match(ExportExcel)) {
            if (!window['ExportId']) return;
            args.EnableAjax = false;
            return;
        }
        var btnFloorUpload = new RegExp("\.btnUpload$", "ig");
        if (args.EventTarget.match(btnFloorUpload)) {
            args.EnableAjax = false;
            return;
        }

        var ExportRegexp = new RegExp("\.lbtPrjLkup$|\.ExportToPDF$|\.ExportToWord$|\.ExportToExcel$", "ig");

        if (args.EventTarget.match(ExportRegexp)) {
            args.EnableAjax = false;
            return;
        }

        var theRegexp = new RegExp("\.btnAppAttachSave$|\.btnAppAttachUpdateEdited$|\.btnCopyToExcel$|\.btnUpdateEdited$|\.btnSave$", "ig");

        if (args.EventTarget.match(theRegexp)) {
            if (!window['UploadId']) return;
            args.EnableAjax = false;
            return;
        }
        if (args.EventTarget.match(theRegexp)) {
            if (!window['ImageUploadId']) return;
            args.EnableAjax = false;
            return;
        }
        theRegexp = new RegExp("\.btnAdd$|\.rdmInitiative$", "ig");
        if (args.EventTarget.match(theRegexp)) {
            if (!window['SearchId']) return;
            args.EnableAjax = false;
            return;
        }


        theRegexp = new RegExp("\.btnAward$", "ig");
        if (args.EventTarget.match(theRegexp)) {
            if (!window['AwardId']) return;
            args.EnableAjax = false;
            return;
        }

    }
    $("[id=DisableAllControlsOnPostback]").addClass("Hide");
    if (args.EventTargetElement != null) {
        var CanDisable = true;
        var CanDisable = (args.EventTargetElement.id.indexOf("rtvUsers") < 0) &&
                        (args.EventTargetElement.id.indexOf("treeEmails") < 0) &&
                     (args.EventTargetElement.id.indexOf("rtvRecordTypeRules") < 0);

        if (args.EventTargetElement && CanDisable) {
            args.EventTargetElement.disabled = true;
            if (args.EventTargetElement.control != undefined)
                if (args.EventTargetElement.control.set_enabled)
                    args.EventTargetElement.control.set_enabled(false);
        }
    }
}

function RequestEnd(sender, args) {
    if ($("[id$=hplCurrency]").length == 0 && $("[id$=lblCurrency]").length == 0) {
        if ($("[id$=trCurrency]").length > 0)
            $("[id$=trCurrency]")[0].style.display = 'none';
    }
    else {
        if ($("[id$=hplCurrency]").length > 0 && $("[id$=lblCurrency]").length == 0)
            if ($("[id$=hplCurrency]")[0].className == "SearchButton")
                if ($("[id$=trCurrency]").length > 0)
                    $("[id$=trCurrency]")[0].style.display = 'none';
    }
}

function ResponseEnd(sender, args) {
    if (args.EventTargetElement) args.EventTargetElement.disabled = false;


}
function ResponseEnd(sender, args) {
    if (args.EventTargetElement) args.EventTargetElement.disabled = false;
}

var GridNoteId = ""
function DocumentNote_Creating(sender, args) {
    if (GridNoteId == "") GridNoteId = sender.ClientID;
}
function popUpNote(isNew) {

    var grid = $find(GridNoteId);
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var left = (browserWidth - (browserWidth * 0.9)) / 2;
    var top = (browserHeight - (browserHeight * 0.9)) / 2;

    if (grid.get_masterTableView().get_selectedItems().length > 0) {
        if (!isNew) {
            OpenPOPUp('DocumentNotesEditor.aspx', 1180, 560, true, 'rdgDocumentNotes');
        }
    }
    if (isNew) {
        OpenPOPUp('DocumentNotesEditor.aspx?IsNew=1', 1180, 560, true, 'rdgDocumentNotes');
    }

    return false;
}

/******* Enable/disable .Net validation without firing them ******/
function ActivateValidator(val, enable) {
    val.enabled = enable;
    ValidatorUpdateDisplay(val);
}


function SetCostLedgerTogglebutton(btnApprovedId, btnPendingId, toBeDisplayed, IsApproved) {
    var btnApproved = $("#" + btnApprovedId).parents("LI:first");
    var btnPending = $("#" + btnPendingId).parents("LI:first");
    if (toBeDisplayed == "false") {
        btnApproved.css({ 'display': 'none' });
        btnPending.css({ 'display': 'none' });
    } else {
        btnApproved.css({ 'display': ((IsApproved == "true") ? '' : 'none') });
        btnPending.css({ 'display': ((IsApproved == "true") ? 'none' : '') });
    }
}

function GetRadWindow() {
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
    else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

    return oWindow;
}

function OnClientButtonClicking(sender, args) {
    var comandName = args.get_item().get_commandName();
    if (comandName == "Delete") {
        if (!confirm(Msg_ConfirmDeleteDocument)) {
            args.set_cancel(true);
        }
    }
    else if (comandName == "Print") {
        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
        args.set_cancel(true);
    }
    else if (args.get_item().get_value() == "Void") {
        var cancel = confirm("You are about to void this record. This cannot be undone. Are you sure you wish to continue?");
        args.set_cancel(!cancel);
    }
    else if (args.get_item().get_value() == "Copy") {
        args.set_cancel(true);
    }
    else if (args.get_item().get_value() == "Test") {//Assembly
        OpenPOPUp('EstimateAssembliesSelect.aspx?Source=Assembly', 1180, 560, true);
    }
    else if (comandName == "LinkSchedule") {
        OpenLinkedTasksPopUp();
    }
    if (comandName == "PctComplete") {
        if (!confirm(Msg_ConfirmCopyPercentage)) {
            args.set_cancel(true);
        }
    }
    if (comandName == "Forecast") {
        if (!confirm(Msg_ConfirmCalculateForecast)) {
            args.set_cancel(true);
        }
    }
    if (comandName == "Search") {
        if (dirty && (dirtyEnabled == 'true')) {
            if (confirm(Msg_PromptToSave) == false) { args.set_cancel(true); } else { dirty = false; }
        }
    }
    if (comandName.indexOf('Excel') > 0) DisableControls = false;
    //if (sender.get_events()._list && sender.get_events()._list.buttonClicked){
    //    if ((comandName == 'New' || comandName == 'NewInitiative') && args.get_item().constructor.__typeName == 'Telerik.Web.UI.RadToolBarButton') {
    //        PMFormSubmit();
    //    }
    //}
}

function OpenLinkedTasksPopUp() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('LinkSchedulePopup.aspx');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RefreshTasks);
    return false;
}

function OpenHtmlEditorPopUp(ObjectType, RecordId, ColumnName, LiteralID, sender) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var left = (screen.width - 600) / 2;
    var top = (screen.height - 500) / 2;
        var wnd = window.radopen('HtmlNotes.aspx?ObjectType=' + ObjectType + '&RecordId=' + RecordId + '&ColumnName=' + ColumnName + '&LiteralID=' + LiteralID, null);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;

}



/********Date Picker **********/
var currentTextBox = null;
var currentDatePicker = null;
function ShowPopupDate(sender, e) {

    if (currentTextBox.getAttribute("Readonly") == null || currentTextBox.getAttribute("Readonly") == false) {
        var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
        currentDatePicker = datePicker;
        datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
        var position = { x: $(sender).offset().left, y: $(sender).offset().top - 20 };
        if ($(sender).parents('.rgEditForm').length > 0) {
            datePicker.showPopup(position.x, position.y + sender.offsetHeight);
            var calendar = $('[id=' + datePicker.get_calendar().get_element().id + ']');
            if (calendar.length > 0) {
                CalendarHeight = calendar.height();
                var CalendarPopup = calendar.parents('.RadCalendarPopup');
                if (CalendarPopup.length > 0) {
                    CalendarPopup.css('top', (position.y + sender.offsetHeight - CalendarHeight).toString() + 'px');
                }
            }
            datePicker.get_calendar().get_element().style.width = '175px';
        } else {
            datePicker.showPopup(position.x, position.y + sender.offsetHeight);
        }
    }
}

function dateSelected(sender, args) {
    if (currentTextBox != null) {

        currentTextBox.value = args.get_newValue();
        setdirty2(sender, args);

    }
}


function parseDate(sender, e) {
    if (currentDatePicker != null) {
        var date = currentDatePicker.get_dateInput().parseDate(sender.value);
        var dateInput = currentDatePicker.get_dateInput();

        if (date != null) {
            var formattedDate = dateInput.get_dateFormatInfo().FormatDate(date, dateInput.get_displayDateFormat());
            sender.value = formattedDate;
        }
        else {
            sender.value = "";
        }
    }
}
/******* END Date Picker *********/
function CalculateClosedLines(iLineCount, iTotalLines) {
    try {
        $('input[id$=txtLineCount]').val(iLineCount);
        $('input[id$=txtTotalLines]').val(iTotalLines);

        if (CDbl(iLineCount) == 0 && CDbl(iTotalLines) == 0) {
            $('input[id$=txtPercentage]').val(CPrct(0));
            return;
        }


        var valPercent = CDbl(iLineCount) * 100 / CDbl(iTotalLines);

        $('input[id$=txtPercentage]').val(CPrct(valPercent));
    }
    catch (e) {

    }
}

/************Search Document Add************/
function AddNewDocument() {
    var toolbar = $find($("[id$=mainToolBar]")[0].id);

}

function SignOutPopup() {
    parent.parent.window.location = "/Default.aspx?reason=ST";
}

/********** Escape ************/
function Esc(str) {

    if (str.length > 500) str = str.slice(0, 500) + " ... ";

    return str.replace(/&/g, "&amp;").replace(/</g, "&lt;");

}

/********* Date **********************/
function DateDiffInDays(date1, date2) {
    var ONE_DAY = 1000 * 60 * 60 * 24
    var difference_ms = Math.abs(date2 - date1)
    return Math.round(difference_ms / ONE_DAY)
}

var dtCh = "/";
var minYear = 1900;
var maxYear = 2100;

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary(year) {
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}
function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this
}

function isDate(dtStr) {
    var daysInMonth = DaysArray(12)
    var pos1 = dtStr.indexOf(dtCh)
    var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
    var strMonth = dtStr.substring(0, pos1)
    var strDay = dtStr.substring(pos1 + 1, pos2)
    var strYear = dtStr.substring(pos2 + 1)
    strYr = strYear
    if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
    if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
    }
    month = parseInt(strMonth)
    day = parseInt(strDay)
    year = parseInt(strYr)
    if (pos1 == -1 || pos2 == -1) {
        // alert("The date format should be : mm/dd/yyyy")
        return false
    }
    if (strMonth.length < 1 || month < 1 || month > 12) {
        // alert("Please enter a valid month")
        return false
    }
    if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
        // alert("Please enter a valid day")
        return false
    }
    if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
        //lert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
        return false
    }
    if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
        //alert("Please enter a valid date")
        return false
    }
    return true
}

function ReplaceAllString(str, elt, by) {
    if (!str) return "";
    if (str.indexOf(elt) > -1) {
        return ReplaceAllString(str.replace(elt, by), elt, by);
    }
    else return str;
}

Date.prototype.toMMDDYYYYString = function () { return isNaN(this) ? 'NaN' : [this.getMonth() > 8 ? this.getMonth() + 1 : '0' + (this.getMonth() + 1), this.getDate() > 9 ? this.getDate() : '0' + this.getDate(), this.getFullYear()].join('/') }
Date.prototype.addDays = function (days) {
    this.setDate(this.getDate() + days);
}
/*************** arrays *******************/
if (!Array.prototype.indexOf) { Array.prototype.indexOf = function (elt /*, from*/) { var len = this.length; var from = Number(arguments[1]) || 0; from = (from < 0) ? Math.ceil(from) : Math.floor(from); if (from < 0) from += len; for (; from < len; from++) { if (from in this && this[from] === elt) return from; } return -1; }; }



/******************Paste from excel ***********************/

function BindPasteExcelHandlers(rdgCtrl) {
    var clipboard = $('textarea[id$=txtClipboard]')[0];
    var CanPaste = $("a[id$=btnPasteClipBoard]").length > 0;
    if (clipboard && CanPaste) {
        $('textarea[id$=txtClipboard]')[0].onpaste = function () { $('textarea[id$=txtClipboard]')[0].readOnly = false; setTimeout("UpdateClipboardData()", 500); };
        $('textarea[id$=txtClipboard]')[0].onkeydown = function (e) {
            e = e || window.event;
            var key = e.which || e.keyCode;
            var ctrl = e.ctrlKey ? e.ctrlKey : ((key === 17) ? true : false);
            if (key == 86 && ctrl)
                $('textarea[id$=txtClipboard]')[0].readOnly = false;
        }
        $('textarea[id$=txtClipboard]')[0].onbeforepaste = function () { $('textarea[id$=txtClipboard]')[0].readOnly = false; }
        $("[id$=" + rdgCtrl + "]").find(".rgCommandRow").focus(function () { $('textarea[id$=txtClipboard]').focus(); });
        $("[id$=" + rdgCtrl + "]").find(".rgCommandRow").click(function () {
            $('textarea[id$=txtClipboard]').css({ 'top': $(window).scrollTop() });
            $('textarea[id$=txtClipboard]').focus();
        });
        //$("input[id$=btnClipborad]").click(function (event) {
        //    event.stopPropagation();
        //    event.stopImmediatePropagation();
        //});
    }
}

function ReplaceAllNewLine(str) {
    if (!str) return "";
    if (str.indexOf("\n") > -1) {
        return ReplaceAllNewLine(str.replace("\n", "\r"));
    }
    else return str;
}

function UpdateClipboardData() {
    $('textarea[id$=txtClipboard]')[0].readOnly = false;
    var ClipboardData = getClipboardData();
    $('input[id$=hdClipboard]').val(ClipboardData);
    $('textarea[id$=txtClipboard]').val("");
    $('textarea[id$=txtClipboard]')[0].readOnly = true;
    var btnPasteClipBoard = $("a[id$=btnPasteClipBoard]")[0];
    if (btnPasteClipBoard) { eval(btnPasteClipBoard.href.split(":")[1]); }
}

function getClipboardData() {
    var ClipboardData = $('textarea[id$=txtClipboard]').val();
    ClipboardData = ReplaceAllNewLine(ClipboardData);
    ClipboardData = ClipboardData.substring(0, ClipboardData.length - 1);
    return ClipboardData;
}

function GetClipboardData() {
    if (window.clipboardData) {
        var clipboardData = window.clipboardData.getData('Text')
        if (clipboardData != null) {
            clipboardData = clipboardData.substring(0, clipboardData.length - 2);
            $('input[id$=hdClipboard]').val(clipboardData);
        }
    } else {
        alert(Msg_UseCtrl_V);
        $('textarea[id$=txtClipboard]').focus();
        return false;
    }
}

/******************End Paste from excel ******************/


function OpenPOPWindow(url, width, height) {
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    popupWindow = window.open(url, "",
            'location=0,status=0,menubar=0,resizable=1,scrollbars=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
    return false;
}

function LOD_DropDownTextChange(sender, args) {
    if (sender.get_value() == '') {
        args.set_cancel(true);
    }
}

function setCookie(c_name, value, expiredays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = c_name + "=" + escape(value) +
    ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString()) + "; path=/";
}

/****************** HtmlNotes ******************/

function OpenHtmlNotesPopup(PageUrl, ObjectType, RecordId, FieldUniqueName) {
    var wnd = window.radopen(PageUrl + '?ObjectType=' + ObjectType + '&RecordId=' + RecordId + '&FieldUniqueName=' + FieldUniqueName);
    wnd.setSize(575, 400);
    wnd.Center();
    return false;
}

/****** Disable Selection ********/
(function ($) { if ($.browser.mozilla) { $.fn.disableTextSelect = function () { return this.each(function () { $(this).css({ "MozUserSelect": "none" }) }) }; $.fn.enableTextSelect = function () { return this.each(function () { $(this).css({ "MozUserSelect": "" }) }) } } else { if ($.browser.msie) { $.fn.disableTextSelect = function () { return this.each(function () { $(this).bind("selectstart.disableTextSelect", function () { return false }) }) }; $.fn.enableTextSelect = function () { return this.each(function () { $(this).unbind("selectstart.disableTextSelect") }) } } else { $.fn.disableTextSelect = function () { return this.each(function () { $(this).bind("mousedown.disableTextSelect", function () { return false }) }) }; $.fn.enableTextSelect = function () { return this.each(function () { $(this).unbind("mousedown.disableTextSelect") }) } } } })(jQuery)


/********************** Paste From Clipboard *************************************/
var readyToPaste = false;
var senderGridId = '';
var arrKeysStack = [1, 2];
var ctrlKey = 17, vKey = 86, cKey = 67; dashKey = 45; dKey = 68;

var currTouchedElement;
var touchTimerObj;
$(document).ready(function () {

    try {
        if (IsIpad.toLowerCase() == 'true') {
            document.addEventListener('touchstart', function (e) { currTouchedElement = e; touchTimerObj = setTimeout(function () { currTouchedElement.preventDefault; PMWebTouchStart(); }, 2000); }, false);
            document.addEventListener('touchend', function (e) { clearTimeout(touchTimerObj); }, false);
        }
    }
    catch (EX) { }
    if ($('.disableSelection') != null && $('.disableSelection') != undefined && $('.disableSelection').length > 0)
        $('.disableSelection').disableTextSelect();;
    $(document).keydown(function (e) {

        arrKeysStack.shift();
        arrKeysStack.push(e.keyCode);
        if (e.keyCode == vKey) {
            if ((cntrlVDown() == true) && readyToPaste) {
                document.getElementById("txtClipboardValue").value = '';
                document.getElementById("txtClipboardValue").focus();
                setTimeout("PasteValues()", 100);
                readyToPaste = false;
                return true;
            };
        }
    });
});
function cntrlVDown() {
    var isDown = false;
    if ((arrKeysStack[0] == ctrlKey) && (arrKeysStack[1] == vKey)) { isDown = true; }
    return isDown;
}


function PasteValues() {
    var Value = document.getElementById("txtClipboardValue").value;
    var PastedValuesIndex = 0;
    var arrPastedValues = (Value).split(String.fromCharCode(10));
    var currPasteValue = arrPastedValues[0].replace(String.fromCharCode(13), '');
    if (arrPastedValues.length > 1) {
        arrPastedValues = arrPastedValues.splice(0, arrPastedValues.length - 1);
    }

    $(".SelectedToPaste").each(function (cntrlIndxToPaste) {
        var CurrElement = this;
        if (cntrlIndxToPaste > (arrPastedValues.length - 1)) currPasteValue = arrPastedValues[arrPastedValues.length - 1];
        if (PastedValuesIndex <= (arrPastedValues.length - 1)) {
            currPasteValue = arrPastedValues[PastedValuesIndex].replace(String.fromCharCode(13), '');
            PastedValuesIndex += 1;
        }
        if (((' ' + this.className + ' ').indexOf(' Currency ') > -1 || (' ' + this.className + ' ').indexOf(' PositiveCurrency ') > -1
             || (' ' + this.className + ' ').indexOf(' Double ') > -1 || (' ' + this.className + ' ').indexOf(' PositiveDouble ') > -1
             || (' ' + this.className + ' ').indexOf(' Integer ') > -1 || (' ' + this.className + ' ').indexOf(' PositiveInteger ') > -1) && !isNumeric(currPasteValue)) {
            return;
        }
        //text box and radcombo
        if (((this.type == 'text') || (this.type == 'textarea')) && ((' ' + this.className + ' ').indexOf(' SelectedToPaste ') > -1)) {
            if (this.id.match(/_Input$/) == null) {
                Line_CurrencySymbol = null;
                Line_CurrencySymbolPosition = null;
                var CurrentLineId = this.id;
                var replaced = 0;
                for (var i = 1; i <= 10; i++) {
                    if (CurrentLineId.indexOf("_EditUserDefinedFields" + i) > 0) {
                        replaced = 1;
                        CurrentLineId = CurrentLineId.replace("_EditUserDefinedFields" + i, "").substring(CurrentLineId.replace("_EditUserDefinedFields" + i, "").lastIndexOf('_'), CurrentLineId.lenght - 1);
                        break;
                    }
                }
                if (replaced == 0) {
                    CurrentLineId = CurrentLineId.substring(CurrentLineId.lastIndexOf('_'), CurrentLineId.lenght - 1);

                }
                var ddlCurrencies = $find(CurrentLineId + '_ddlCurrencies')
                if (ddlCurrencies) {
                    if (ddlCurrencies.get_selectedItem().get_attributes().getAttribute("symbolposition") != null) {
                        Line_CurrencySymbolPosition = ddlCurrencies.get_selectedItem().get_attributes().getAttribute("symbolposition");
                        Line_CurrencySymbol = ddlCurrencies.get_selectedItem().get_attributes().getAttribute("symbol");
                    }
                }
                var tr = $(this).parents("tr:first");
                if (tr != null) {
                    if (tr.attr("symbolposition") != null && tr.attr("symbol") != null) {
                        Line_CurrencySymbolPosition = tr.attr("symbolposition");
                        Line_CurrencySymbol = tr.attr("symbol");
                    }

                }

                if ($(this).attr("symbolposition") != null && $(this).attr("symbol") != null) {
                    Line_CurrencySymbolPosition = $(this).attr("symbolposition");
                    Line_CurrencySymbol = $(this).attr("symbol");
                }
                this.value = currPasteValue;
                fireOnChange(CurrElement);
            } else {
                var radComboId = this.id.substring(0, this.id.length - 6);
                var combo = $find(radComboId);
                var item = combo.findItemByText(currPasteValue);
                if (item) {
                    item.select();
                    fireOnChange(CurrElement);
                } else {
                    if (combo._enableLoadOnDemand == true) {
                        combo.requestItems(currPasteValue, false);
                        combo.get_element().setAttribute("currPasteValue", currPasteValue);
                        combo.add_itemsRequested(function (sender, eventArgs) {
                            var item = sender.findItemByText(sender.get_element().getAttribute("currPasteValue"));
                            if (item) {
                                item.select();
                                fireOnChange(CurrElement);
                            }
                        });
                    }
                }
            }
        }

        // asp ddl
        if ((this.tagName == 'SELECT') && ((' ' + this.className + ' ').indexOf(' SelectedToPaste ') > -1)) {
            for (j = 0; j < this.options.length; j++) {
                if (this.options[j].text.trim() == currPasteValue.trim()) {
                    this.selectedIndex = j;
                    break;
                }
            }
        }

    });


}

var cntrlID1 = '';
var cntrlID2 = '';

function SelectToPaste2(sender, eventArgs) {
    readyToPaste = true;
    $(".SelectedToPaste").each(function (Indx) { $(this).removeClass('SelectedToPaste'); });
    $(".SelectedToPasteCss").each(function (Indx) { $(this).removeClass('SelectedToPasteCss'); });
    var masterTable = $find(sender.ClientID).get_masterTableView();
    for (var i = 0; i < masterTable.get_dataItems().length; i++) {
        var currCel = masterTable.getCellByColumnUniqueName(masterTable.get_dataItems()[i], eventArgs.get_gridColumn().get_uniqueName());
        if (currCel != null) {
            $(currCel).find('input[type=text]').each(function (Indx) {
                var isDisabled = this.disable == undefined ? !this.isDisabled : this.disable;
                if (this.readOnly == false && isDisabled) {
                    if (!((this.id.match(/_dateInput$/)) || (this.id.match(/_dateInput_text$/)))) {
                        $(this).addClass('SelectedToPaste');
                    }
                }
            });
            var isDisabled = true;
            $(currCel).find('select').each(function (Indx) {
                isDisabled = this.disable == undefined ? !this.isDisabled : this.disable;;
                if (isDisabled == false) {
                    $(this).addClass('SelectedToPaste');
                }
            });
            $(currCel).find('span.rfdSelectText').each(function () {
                if (isDisabled == false) {
                    $(this).addClass('SelectedToPasteCss');
                }
            });
            $(currCel).find('textarea').each(function (Indx) {
                var isDisabled = this.disable == undefined ? !this.isDisabled : this.disable;
                if (this.readOnly == false && isDisabled == false) {
                    $(this).addClass('SelectedToPaste');
                }
            });
        }
    }
}


function SelectToPaste(colIndx, sender) {
    $(".SelectedToPaste").each(function (Indx) { $(this).removeClass('SelectedToPaste'); });

    cntrlID1 = '';
    cntrlID2 = '';
    colIndx = sender.cellIndex + 1;

    var objTds = $('#' + senderGridId + ' tbody tr td:nth-child(' + parseInt(colIndx) + ')');
    for (var i = 0; i < objTds.length; i++) {
        var currTd = objTds[i];
        $(currTd).find('input[type=text][readOnly=false][disabled=false]').each(function (Indx) { $(this).addClass('SelectedToPaste'); });
        $(currTd).find('select[disabled=false]').each(function (Indx) { $(this).addClass('SelectedToPaste'); });

    }
}

function PMWebTouchStart() {
    fireRightClick();
}

function fireOnChange(element) {
    if (document.createEventObject) {// test for IE
        var evt = document.createEventObject();
        return element.fireEvent('onchange', evt)
    }
    else {// test for other browsers
        var evt = document.createEvent("HTMLEvents");
        evt.initEvent('change', true, true); // event type,bubbling,cancelable
        try {
            return !element.dispatchEvent(evt);
        } catch (ex) {
        }
    }

}

function fireRightClick() {
    var intX = typeof currTouchedElement.touches[0].clientX !== 'undefined' ? currTouchedElement.touches[0].clientX : currTouchedElement.touches[0].pageX;
    var intY = typeof currTouchedElement.touches[0].clientY !== 'undefined' ? currTouchedElement.touches[0].clientY : currTouchedElement.touches[0].pageY;
    if (document.createEvent) {
        var ev = document.createEvent('HTMLEvents');
        ev.clientX = intX; ev.clientY = intY;
        ev.initEvent('contextmenu', true, false);
        currTouchedElement.touches[0].target.dispatchEvent(ev);
    } else { // Internet Explorer
        ev.pageX = intX; ev.pageY = intY;
        currTouchedElement.touches[0].target.fireEvent('oncontextmenu');
    }
}
/********************** Load On Demand Threshold *************************************/
function OnClientItemsRequesting(sender, eventArgs) {
    if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
        eventArgs.set_cancel(true);
    } else {
        eventArgs.set_cancel(false);
    }

    if ((sender.get_items().get_count() == 0 && sender.get_value() != '') || typeof $(sender).attr('InitialText') === 'undefined') {
        $(sender).attr('InitialText', eventArgs.get_context()["Text"]);
    }

    if ($(sender).attr('InitialText') == eventArgs.get_context()["Text"]) {
        eventArgs.get_context()["Text"] = "";
    }
}

function ComboCheckParentInSearch(chk, comboId, hdnSelectedValuesId) {
    var combo = $find(comboId);
    var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);


    var i = 0;
    var isChecked = true;
    var text = "";
    var values = "";
    var items = combo.get_items();
    $("#" + comboId + "_DropDown").find("input[type='checkbox']").each(function () {

        var item = items.getItem(i);
        if (this.checked) {
            text += item.get_text() + ";";
            values += item.get_value() + ";";
        }
        i++;

    });

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


function OpenNotificationLogPopup(LogId, recordDescription, type, Id, CustomTypeId, canedit, EntityId, EntityType) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    recordDescription = recordDescription.replace("#", "").replace("'", "");
    var wnd = window.radopen('NotificationLog.aspx?ObjectType=' + type + '&Id=' + Id + '&LogId=' + LogId + '&RecordDescription=' + recordDescription + '&CustomFormTypeId=' + CustomTypeId + '&CanEdit=' + canedit + '&EntityId=' + EntityId + '&EntityType=' + EntityType, 'Notification');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}

function OpenRedliningMeasuresLogPopup(QuantityControlId, UOMControlId, UOMType, FloorId) {
    OpenPOPUp('RedliningMeasuresPopup.aspx?QuantityControlId=' + QuantityControlId + '&UOMControlId=' + UOMControlId + '&UOMType=' + UOMType + '&FloorId=' + FloorId, 820, 500, false);
    return false;
}

function OpenCompanyFilterPopup(ddlControlId, ddlId, Type, ddlProjectId) {
    var left = (screen.width - 920) / 2;
    var top = (screen.height - 300) / 2;
    var ProjectId = 0;
    if (ddlProjectId == null) {
        if ($("div[id$=ddlProjects]").length > 0) {
            ProjectId = $find($("div[id$=ddlProjects]")[0].id).get_value();
        } else if ($("div[id$=ddlProject]").length > 0) {
            ProjectId = $find($("div[id$=ddlProject]")[0].id).get_value();
        } else if (typeof CurrentRecordProjectId != 'undefined') {
            ProjectId = CurrentRecordProjectId;
        }
    }
    else {
        ProjectId = $find(ddlProjectId).get_value();
    }
    if (ProjectId == '')
        ProjectId = 0;
    var currentddl = $find(ddlId)
    if (currentddl == null) {
        ddlId = 'ctl00_' + ddlId;
        currentddl = $find(ddlId);
    }
    if (currentddl != null && currentddl._enabled == false) return false;
    var win = OpenPOPUp('CompaniesFilterPopup.aspx?ControlId=' + ddlControlId + '&ddlId=' + ddlId + '&Type=' + Type + '&ProjectRequired=1&ProjectId=' + ProjectId, '',
            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
    return false;
}
function OpenCompanyFilterPopupWithProjectId(ddlControlId, ddlId, Type, ProjectId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var currentddl = $find(ddlId)
    if (currentddl == null) {
        ddlId = 'ctl00_' + ddlId;
        currentddl = $find(ddlId);
    }
    if (currentddl != null && currentddl._enabled == false) return false;
    var wnd = window.radopen('CompaniesFilterPopup.aspx?ControlId=' + ddlControlId + '&ddlId=' + ddlId + '&Type=' + Type + '&ProjectRequired=1&ProjectId=' + ProjectId);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}
function OpenCompanyFilterPopupProjectNotRequired(ddlControlId, ddlId, Type, ddlProjectId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var ProjectId = 0;
    if (ddlProjectId == null) {
        if ($("div[id*=ddlProject]").length > 0) {
            ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
        } else if (typeof CurrentRecordProjectId != 'undefined') {
            ProjectId = CurrentRecordProjectId;
        }
    }
    else {
        ProjectId = $find(ddlProjectId).get_value();
    }
    if (ProjectId == '')
        ProjectId = 0;
    var currentddl = $find(ddlId)
    if (currentddl == null) {
        ddlId = 'ctl00_' + ddlId;
        currentddl = $find(ddlId);
    }
    if (currentddl != null && currentddl._enabled == false) return false;
    var wnd = window.radopen('CompaniesFilterPopup.aspx?ControlId=' + ddlControlId + '&ddlId=' + ddlId + '&Type=' + Type + '&ProjectRequired=0&ProjectId=' + ProjectId);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}

function OpenCompanyFilterPopupProjectNotRequired1(ddlControlId, ddlId, Type, ddlProjectId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var ProjectId = 0;
    if (ddlProjectId == null) {
        if ($("div[id*=ddlProject]").length > 0) {
            ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
        }
    }
    else {
        ProjectId = $find(ddlProjectId).get_value();
    }
    if (ProjectId == '')
        ProjectId = -1;
    var currentddl = $find(ddlId)
    if (currentddl == null) {
        ddlId = 'ctl00_' + ddlId;
        currentddl = $find(ddlId);
    }
    if (currentddl != null && currentddl._enabled == false) return false;
    var wnd = window.radopen('CompaniesFilterPopup.aspx?ControlId=' + ddlControlId + '&ddlId=' + ddlId + '&Type=' + Type + '&ProjectRequired=0&ProjectId=' + ProjectId, '');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}

function OpenCompanyFilterPopupWithSource(ddlControlId, ddlId, Type, Source, ddlProjectId) {
    var left = (screen.width - 920) / 2;
    var top = (screen.height - 300) / 2;
    //var ProjectId = 0;
    //if (ddlProjectId == null) {
    //    if ($("div[id*=ddlProject]").length > 0) {
    //        ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
    //    }
    //}
    //else {
    //    ProjectId = $find(ddlProjectId).get_value();
    //}
    //if (ProjectId == '')
    //    ProjectId = 0;
    var currentddl = $find(ddlId)
    if (currentddl == null) {
        ddlId = 'ctl00_' + ddlId;
        currentddl = $find(ddlId);
    }
    if (currentddl != null && currentddl._enabled == false) return false;

    OpenPOPUp('CompaniesFilterPopup.aspx?ControlId=' + ddlControlId + '&ddlId=' + ddlId + '&Type=' + Type + '&Source=' + Source + '&ProjectRequired=0&ProjectId=0', 850, 460, true);
    return false;
}
function dllcompClientSelectedIndexChanged(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField1';
    var Control = document.getElementById(HiddenField);
    if (Control != null) {
        Control.value = '';
    }
}

function dllcompClientClosed(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField1';
    var combVal = combobox.get_value();
    if (combVal == '') {
        var Control = document.getElementById(HiddenField);
        if (Control != null) {
            Control.value = '';



        }
    }
}

function dllcompClientSelectedIndexChanged1(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField2';
    var Control = document.getElementById(HiddenField);
    if (Control != null) {
        Control.value = '';
    }
}

function dllcompClientClosed1(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField2';
    var combVal = combobox.get_value();
    if (combVal == '') {
        var Control = document.getElementById(HiddenField);
        if (Control != null) {
            Control.value = '';



        }
    }
}
function dllcompClientSelectedIndexChanged2(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField3';
    var Control = document.getElementById(HiddenField);
    if (Control != null) {
        Control.value = '';
    }
}

function dllcompClientClosed2(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField3';
    var combVal = combobox.get_value();
    if (combVal == '') {
        var Control = document.getElementById(HiddenField);
        if (Control != null) {
            Control.value = '';



        }
    }
}

function dllcompClientSelectedIndexChanged3(combobox, eventArgs) {
    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField4';
    var Control = document.getElementById(HiddenField);
    if (Control != null) {
        Control.value = '';
    }
}

function dllcompClientClosed3(combobox, eventArgs) {
    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_HiddenField4';
    var combVal = combobox.get_value();
    if (combVal == '') {
        var Control = document.getElementById(HiddenField);
        if (Control != null) {
            Control.value = '';
        }
    }
}

function GridSendDateDateSelected(sender, e) {

    var dtpdueDate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_griddtpDueDate');
    hddnNotificationReviewTime = $("[id$=hddnNotificationReviewTime]")[0];
    if (sender.get_selectedDate() != null && dtpdueDate != null && hddnNotificationReviewTime) {
        var reviewTime = hddnNotificationReviewTime.value;
        var myDate = new Date(sender.get_selectedDate().format("MM/dd/yyyy"));
        var i = 0;
        while (i < reviewTime) {
            myDate.setDate(myDate.getDate() + 1);
            i = i + 1;
        }

        dtpdueDate.set_selectedDate(myDate);

    }
}
/***** Dirty Buisness **********/
var dirty = false;
function setdirty() {
    dirty = true;
}
function setdirty2(sender, eventArgs) {
    dirty = true;
    if (typeof $(sender).attr('InitialText') !== 'undefined') {
        sender.clearItems();
    }
}

function CheckDirt2() {
    if (dirty && (dirtyEnabled == 'true')) {
        if (confirm(Msg_PromptToSave) == false) { return false; }
    }
}
function CheckDirtOnLogo() {
    if (dirty && (dirtyEnabled == 'true')) {
        if (confirm(Msg_PromptToSave) == false) { return false; }
    }
    window.location.href = 'home.aspx';
    return false;

}

function CheckDirtOnProfilePic() {
    if (dirty && (dirtyEnabled == 'true')) {

        if (confirm(Msg_PromptToSave) == false) { return false; }
    }
    window.location.href = 'UserProfile.aspx';
}

function CheckDirtLogout() {
    if (dirty && (dirtyEnabled == 'true')) {

        if (confirm(Msg_PromptToSave) == false) { return false; }
    }
    return confirmLogout();
}

function setDirtyRadEditor(editor) {
    editor.get_contentArea().style.backgroundColor = "white";
    editor.get_contentArea().style.backgroundImage = "none";
    editor.attachEventHandler("onkeydown", function (e) {
        dirty = true;
    });
    if ((editor.get_id() == 'ctl00_CPH1_edtMergeTemplate') ||
        (editor.get_id() == 'ctl00_CPH1_treRepeatHeader') ||
        (editor.get_id() == 'ctl00_CPH1_treHeader') ||
        (editor.get_id() == 'ctl00_CPH1_treFooter') ||
        (editor.get_id() == 'ctl00_CPH1_treRepeatFooter') ||
        (editor.get_id() == 'ctl00_CPH1_RadEditor1') ||
        (editor.get_id() == 'ctl00_CPH1_ReminderTemplate1_RadEditor1') ||
        (editor.get_id() == 'ctl00_CPH1_SubscriptionTemplate1_RadEditor1') ||
        (editor.get_id() == 'ctl00_CPH1_SystemEventTemplate1_RadEditor1') ||
        (editor.get_id() == 'ctl00_CPH1_AlertTemplate1_RadEditor1') ||
        (editor.get_id() == 'ctl00_CPH1_NotificationTemplate1_RadEditor1') ||
        (editor.get_id() == 'ctl00_CPH1_CollaborateTemplate1_RadEditor1')
        ) {
        var objTree = $("[id$=tree]");
        if (objTree[0] == undefined) { return; }
        var tree = $find(objTree[0].id);
        makeUnselectable(tree.get_element());
        if (editor.get_id() == 'ctl00_CPH1_RadEditor1' || editor.get_id() == 'ctl00_CPH1_ReminderTemplate1_RadEditor1' || editor.get_id() == 'ctl00_CPH1_SubscriptionTemplate1_RadEditor1' ||
            editor.get_id() == 'ctl00_CPH1_SystemEventTemplate1_RadEditor1' || editor.get_id() == 'ctl00_CPH1_AlertTemplate1_RadEditor1' ||
            editor.get_id() == 'ctl00_CPH1_NotificationTemplate1_RadEditor1' || editor.get_id() == 'ctl00_CPH1_CollaborateTemplate1_RadEditor1') {
            editor.get_contentArea().style.backgroundColor = "white";
            editor.get_contentArea().style.backgroundImage = "none";
            var element = document.all ? editor.get_document().body : editor.get_document();
            $telerik.addExternalHandler(element, "click", function (e) {
                focusId = 'RadEditor1';
                SubscriptionfocusId = 'RadEditor1';
                SystemEventfocusId = 'RadEditor1';
                AlertfocusId = 'RadEditor1';
                NotificationfocusId = 'RadEditor1';
                DocumentTeamfocusId = 'RadEditor1';
            });
        }


        if (editor.get_id() == 'ctl00_CPH1_edtMergeTemplate') {
            editor.attachEventHandler("onclick", function (e) {
                var hdfEditor = $("[id$=hdfEditor]")[0];
                hdfEditor.value = 1;
            });
        }
        if (editor.get_id() == 'ctl00_CPH1_treRepeatHeader') {
            editor.attachEventHandler("onclick", function (e) {
                var hdfEditor = $("[id$=hdfEditor]")[0];
                hdfEditor.value = 2;
            });
        }
        if (editor.get_id() == 'ctl00_CPH1_treHeader') {
            editor.attachEventHandler("onclick", function (e) {
                var hdfEditor = $("[id$=hdfEditor]")[0];
                hdfEditor.value = 3;
            });
        }
        if (editor.get_id() == 'ctl00_CPH1_treFooter') {
            editor.attachEventHandler("onclick", function (e) {
                var hdfEditor = $("[id$=hdfEditor]")[0];
                hdfEditor.value = 4;
            });
        }
        if (editor.get_id() == 'ctl00_CPH1_treRepeatFooter') {
            editor.attachEventHandler("onclick", function (e) {
                var hdfEditor = $("[id$=hdfEditor]")[0];
                hdfEditor.value = 5;
            });
        }

    }



    if (editor.get_id() == 'ctl00_CPH1_QueryBuilderHeaders1_rdeRepeatedHeader') {
        var tree = $find($("[id$=treeFields]")[0].id);
        makeUnselectable(tree.get_element());
        editor.attachEventHandler("onclick", function (e) {
            var hdfEditor = $("[id$=hdfEditor]")[0];
            hdfEditor.value = 1;
        });
    }
    if (editor.get_id() == 'ctl00_CPH1_QueryBuilderHeaders1_rdeHeader') {

        editor.attachEventHandler("onclick", function (e) {
            var hdfEditor = $("[id$=hdfEditor]")[0];
            hdfEditor.value = 2;
        });
    }
    if (editor.get_id() == 'ctl00_CPH1_QueryBuilderFooter1_rdeRepeatedFooter') {
        var tree = $find($("[id$=treeFields]")[0].id);
        makeUnselectable(tree.get_element());
        editor.attachEventHandler("onclick", function (e) {
            var hdfEditor = $("[id$=hdfEditor]")[0];
            hdfEditor.value = 1;
        });
    }
    if (editor.get_id() == 'ctl00_CPH1_QueryBuilderFooter1_rdeFooter') {

        editor.attachEventHandler("onclick", function (e) {
            var hdfEditor = $("[id$=hdfEditor]")[0];
            hdfEditor.value = 2;
        });
    }


}

function CheckDirtyRad(sender, eventArgs) {
    if (dirty && (dirtyEnabled == 'true')) {
        if (confirm(Msg_PromptToSave) == false) { eventArgs.set_cancel(true); }
    }
}
function CheckDirtyWorkflow() {
    if (dirty && (dirtyEnabled == 'true')) {
        if (confirm(Msg_PromptToSave) == false)
            return false;
    }

    return true;
}

/**********************/
function NotificationCompletedChecked(sender, args) {
    hddnNotificationTody = $("[id$=hddnNotificationTodyDate]")[0];
    var chkIsCompleted = $("[id$=" + sender.id + "]")[0];
    var dtpCompetedDate = $find(sender.id.substring(0, sender.id.lastIndexOf('_chkIsCompleted')) + '_griddtpCompletedDate');
    if (chkIsCompleted.checked == true) {
        if (hddnNotificationTody != "") {    //var myDate = new Date(parseFloat(hddnNotificationTody.value));
            dtpCompetedDate.set_selectedDate(new Date());

        }
    }
    else
        dtpCompetedDate.clear();

}

function OpenGlobalLinkRecordPopup(RecordId, ProjectId, Source, gridId) {

    OpenPOPUp('GlobalLinkedRecords.aspx?Id=' + RecordId + '&ProjectId=' + ProjectId + '&Source=' + Source, 850, 460, true, gridId);
    return false;
}

function OpenWindowGlobalLinkRecordPopUp(ProjectId, Source) {
    var left = (screen.width - 720) / 2;
    var top = (screen.height - 570) / 2;
    window.open('GlobalLinkedRecords.aspx?ProjectId=' + ProjectId + '&Source=' + Source, null,
                'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=850,height=460,top=' + top + ',left=' + left);
    return false;

}

function OpenLinkExistinRecordPopup(RecordId, ProjectId, Source, DetailId) {

    OpenPOPUp('GlobalLinkedRecords.aspx?Id=' + RecordId + '&ProjectId=' + ProjectId + '&Source=' + Source + '&DetailId=' + DetailId, 850, 460, true);
    return false;
}

function OpenTaskPopup() {
    OpenPOPUp('CheckListPopup.aspx', 775, 470, true, 'rdgWorkOrderTasks');
    return false;
}

function OpenUploadandViewAutodeskForgeFile(source, strguid, gridId) {
    OpenPOPUp('UploadAndViewAutodeskForgefilePopup.aspx?Source=' + source + '&FileGuid=' + strguid, 300, 200, true, gridId);
    return false;
}

function OpenSnapshotComplete(ObjectType, ObjectId) {
    OpenSmallPOPUp('SnapshotCompletePopup.aspx?ObjectType=' + ObjectType + '&ObjectId=' + ObjectId, 400, 200, false);
    return false;
}

function OpenSnapshotCompleteToRefresh(ObjectType, ObjectId) {
    OpenSmallPOPUp('SnapshotCompletePopup.aspx?ObjectType=' + ObjectType + '&ObjectId=' + ObjectId, 400, 200, false);
    return false;
}

function Open3DViewer(ObjectType, ObjectId, FileGUID) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('PMWeb3DViewer.aspx?ObjectType=' + ObjectType + '&ObjectId=' + ObjectId + '&FileGUID=' + FileGUID, null);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}

function OpenUpload3DViewer(ObjectType, ObjectId, FileGUID) {
    OpenParentPOPUp('PMWeb3DViewer.aspx?ObjectType=' + ObjectType + '&ObjectId=' + ObjectId + '&FileGUID=' + FileGUID, 1025, 800);
    return false;
}


function OpenMultipleCompanyFilterPopup(hdnIds, ddlId, hdnNames, Type, ddlProjectId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var ProjectId = 0;
    if (ddlProjectId == null) {
        if ($("div[id*=ddlProject]").length > 0) {
            ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
        } else if (typeof CurrentRecordProjectId != 'undefined') {
            ProjectId = CurrentRecordProjectId;
        }
    }
    else {
        ProjectId = $find(ddlProjectId).get_value();
    }
    if (ProjectId == '')
        ProjectId = 0;
    var wnd = window.radopen('CompaniesFilterPopup.aspx?hdnIds=' + hdnIds + '&ddlId=' + ddlId + '&Type=' + Type + '&ProjectRequired=1&ProjectId=' + ProjectId + '&hdnNames=' + hdnNames + '&ddlType=Multiple', '');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}


function OpenNotificationSingleCompanyFilterPopup(txtFullContact, txtContact, txtEmail, txtIds, Type, Source) {
    var left = (screen.width - 920) / 2;
    var top = (screen.height - 300) / 2;
    var ProjectId = 0;
    var Entitype = GetquerySt('EntityType');
    var EntityId = GetquerySt('EntityId');
    var ObjectType = GetquerySt('ObjectType');
    if ((Entitype == '0') && (ObjectType != 'BUDGETINITIATIVES')) {
        ProjectId = EntityId
    }
    var win = OpenPOPUp('CompaniesFilterPopup.aspx?txtFullContact=' + txtFullContact + '&txtContact=' + txtContact + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
    return false;
}

function GetquerySt(ji) {
    hu = window.location.search.substring(1);
    gy = hu.split("&");
    for (i = 0; i < gy.length; i++) {
        ft = gy[i].split("=");
        if (ft[0] == ji) {
            return ft[1];
        }
    }
}


function chkCheckListCompletedChecked(sender, args) {
    var hddnToday = $("[id$=hdnCheckListTodayDate]")[0];
    var chkIsCompleted = $("[id$=" + sender.id + "]")[0];
    var dtpDoneDate = $find(sender.id.substring(0, sender.id.lastIndexOf('_chbCompleted')) + '_dtpCompletedTaskDate');
    if (chkIsCompleted.checked == true) {
        if (hddnToday.value != "") {    //var myDate = new Date(parseFloat(hddnToday.value));
            dtpDoneDate.set_selectedDate(new Date());

        }
    }
    else
        dtpDoneDate.clear();

}

function chkCheckListStepCompletedChecked(sender, args) {
    var hddnToday = $("[id$=hdnCheckListTodayDate]")[0];
    var chkIsCompleted = $("[id$=" + sender.id + "]")[0];
    var dtpDoneDate = $find(sender.id.substring(0, sender.id.lastIndexOf('_chbStepCompleted')) + '_dtpCompletedStepDate');
    if (chkIsCompleted.checked == true) {
        if (hddnToday.value != "") {    //var myDate = new Date(parseFloat(hddnToday.value));
            dtpDoneDate.set_selectedDate(new Date());

        }
    }
    else
        dtpDoneDate.clear();

}
/*** ShowHeaderMenuIPad ***/
function ShowHeaderMenuIPad(sender, eventArgs) {
    eventArgs.get_gridColumn().showHeaderMenu(eventArgs._domEvent, 10, 10);
}

function OpenNoteDetailPopup(txtNoteId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('NotesPopup.aspx?txtNotesId=' + txtNoteId);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}

function OpenScoringNoteDetailPopup(txtNoteId, Option) {
    OpenPOPUp('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&Option=' + Option + '&Source=Scoring', 900, 600, true);
    return false;
}

function OpenViewNoteDetailPopup(txtNoteId, sender) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    if (sender != null) {
        var containingGrid = sender.closest('.RadGrid');
        if (containingGrid) {
            if (containingGrid.isContentEditable === false)
                var wnd = window.radopen('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&View=1&EditMode=0');
            else
                var wnd = window.radopen('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&View=1');
        }
    }
    else
        var wnd = window.radopen('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&View=1');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;

    //var left = (screen.width - 620) / 2;             
    //var top = (screen.height - 320) / 2;
    //var win = window.open('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&View=1', '',
    //        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=620,height=400,top=' + top + ',left=' + left);
    //return false;
}


function OpenGoogleAddressesPicker() {
    var left = (screen.width - 900) / 2;
    var top = (screen.height - 600) / 2;

    window.open("GoogleAddressesPicker.aspx?PickerSender=RecordAddress",
        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=900,height=600,top=' + top + ',left=' + left);
    return false;
}

function OpenGoogleLinearPicker(ObjectType, ObjectId, ComponentId, PickerSender) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen("GoogleAddressesPicker.aspx?ShowLinearTab=true&RecordType=" + ObjectType + "&ObjectId=" + ObjectId + "&ComponentId=" + ComponentId + "&PickerSender=" + PickerSender);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}



function OpenSelectClausesPopup() {
    OpenPOPUp('SelectClausesPopup.aspx', 900, 600, true, 'rdgClauses');
    return false;
}

function OpenSelectScoringPopup(ObjectType, RecordId) {
    OpenPOPUp('SelectScoringPopup.aspx', 900, 600, true, 'rdgScoring');
    return false;
}

function OpenApplyAPPaymentsPopup() {
    OpenPOPUp('ApplyAPPaymentsPopup.aspx?Source=AP', 1195, 600, true, 'rdgAPPaymentApplication');
    return false;
}
function OpenAssetApplyPaymentsPopup() {
    OpenPOPUp('AssetApplyPaymentsPopup.aspx', 1195, 600, true, 'rdgAPPaymentApplication');
    return false;
}
function OpenApplyARPaymentsPopup() {
    OpenPOPUp('ApplyAPPaymentsPopup.aspx?Source=AR', 1195, 600, true, 'rdgARPaymentApplication');
    return false;
}

function OpenSelectAPPaymentsPopup() {
    OpenPOPUp('SelectAPPaymentsPopup.aspx', 900, 600, true, 'rdgPayments');
    return false;
}
function OpenSelectAssetAPPaymentsPopup() {
    OpenPOPUp('SelectAssetAPPayment.aspx', 900, 600, true, 'rdgPayments');
    return false;
}
function OpenSelectAssetARPaymentsPopup() {
    OpenPOPUp('SelectAssetARPayment.aspx', 900, 600, true, 'rdgARPayments');
    return false;
}
function OpenSelectARPaymentsPopup() {
    OpenPOPUp('SelectARPaymentsPopup.aspx', 900, 600, true, 'rdgARPayments');
    return false;
}

function OpenPayInvoicesPopup() {
    OpenPOPUp('PayAPInvoicesPopup.aspx', 1220, 600, true, 'rdgPayments');
    return false;
}
function OpenAssetPayAPInvoicesPopup() {
    OpenPOPUp('AssetPayAPInvoices.aspx', 1220, 600, true, 'rdgPayments');
    return false;
}
function OpenAssetPayARInvoicesPopup() {
    OpenPOPUp('AssetPayARInvoices.aspx', 1220, 600, true, 'rdgARPayments');
    return false;
}
function OpenPayARInvoicesPopup() {
    OpenPOPUp('PayARInvoicesPopup.aspx', 1220, 600, true, 'rdgARPayments');
    return false;
}

function SetHigriDate() {
    $(":input").keydown(function (e) {

        if (e.keyCode == 72) {

            if (e.target.id.indexOf("_dateInput") > -1) {
                var dtObj = $find(e.target.id);
                if (dtObj.get_selectedDate() != null) {
                    showToolTip(e.target, (dtObj.get_selectedDate()).getTime().toString());
                    return false;
                }

            } else {
                if ((e.target.attributes["onblur"]) && (e.target.attributes["onblur"].value == "parseDate(this, event);")) {
                    showToolTip(e.target, e.target.value);
                    return false;
                }
            }

        }
    });

}


function dllWBSSelectedIndexChanged(combobox, eventArgs) {

    var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hdnWBS';
    var Control = document.getElementById(HiddenField);
    if (Control != null) {
        Control.value = '';
    }
}

function OpenWBSPopup(ddlWBS, ProjectId, ProgramId) {

    var left = (screen.width - 350) / 2;
    var top = (screen.height - 350) / 2;
    var currentddl = $find(ddlWBS)
    if (currentddl == null) {
        ddlWBS = 'ctl00_' + ddlWBS;
        currentddl = $find(ddlWBS);
    }
    if (currentddl != null && currentddl._enabled == false) return false;
    var win = OpenPOPUp('WBSPopup.aspx?ddlWBS=' + ddlWBS + '&ProjectId=' + ProjectId + '&ProgramId=' + ProgramId, '',
            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=350,height=350,top=' + top + ',left=' + left);
    return false;
}

function OpenVisualCalculator(Id) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('VisualCalculatorPopup.aspx?Id=' + Id, '');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;

}

function OpenBarCodePopup(fldBarcode, fldFormat, ObjectType, Id) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var barcode = $("input[id$='" + fldBarcode + "']").val();
    var format = $("input[id$='" + fldFormat + "']").val();

    var wnd = OpenSmallPOPUp('BarCodePopup.aspx?fldBarcode=' + fldBarcode + '&fldFormat=' + fldFormat + '&barcode=' + barcode + '&format=' + format + '&ObjectType=' + ObjectType + '&RecordId=' + Id, false);

    return false;
}

function OpenviewAttachmentPopup(DocumentType, LineId, DocumentId, EntityTypeId, EntityId, IsLastRevision) {

    OpenPOPUp('ViewAttachments.aspx?DocumentType=' + DocumentType + '&LineId=' + LineId + '&DocumentId=' +
     DocumentId + '&EntityTypeId=' + EntityTypeId + '&EntityId=' + EntityId +
      '&IsLastRevision=' + IsLastRevision, 920, 500, true);
    return false;
}

function OpenConversionRatePopup(ObjectType, ObjectId) {
    var CanEditDocument = 1;
    var Toolbar = $find($("[id$=mainToolBar]")[0].id);
    if (Toolbar) {
        var btnSave = Toolbar.findButtonByCommandName('Save');
        if (!btnSave || btnSave.get_enabled() == false) CanEditDocument = 0;
    }
    OpenCurrencyPOPUpToRedirect('CurrencyPopup.aspx?ObjectType=' + ObjectType + '&ObjectId=' + ObjectId + '&CanEditDocument=' + CanEditDocument);
    return false;
}

function OpenDefaultCurrencyPopup(EntityId, EntityType) {
    OpenCurrencyPOPUpToRedirect('DefaultCurrencyPopup.aspx?EntityId=' + EntityId + '&EntityType=' + EntityType);
    return false;
}


function OpenBarCodeSettingsPopup(fldfield, fldformat, IsAsset) {
    OpenSmallPOPUp('BarCodeSettingsPopup.aspx?fldfield=' + fldfield + '&fldFormat=' + fldformat + '&IsAsset=' + IsAsset, 400, 200, false);
    return false;
}


function OpenOverageDetailPopup(Id, txtActualAmountId, txtOverageId, Save) {
    var txtActualAmount = document.getElementById(txtActualAmountId)
    var txtOverageAmount = document.getElementById(txtOverageId);
    var ActualAmount = CCur(CDbl(txtActualAmount.value));
    var OverageAmount = CCur(CDbl(txtOverageAmount.value));
    var left = (screen.width - 415) / 2;
    var top = (screen.height - 425) / 2;
    var win = window.open('OverageDetailsPopup.aspx?Id=' + Id + '&txtActualAmountId=' + txtActualAmountId + '&txtOverageAmountId=' + txtOverageId + '&ActualAmount=' + ActualAmount + '&OverageAmount=' + OverageAmount + '&Save=' + Save, '',
            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=415,height=425,top=' + top + ',left=' + left);
}
function OpenOverageDetailFromItem(Id, ActualAmount, OverageAmount, Save, OverageId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('OverageDetailsPopup.aspx?Id=' + Id + '&ActualAmount=' + ActualAmount + '&OverageAmount=' + OverageAmount + '&OverageId=' + OverageId + '&Save=' + Save);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    return false;
}
function OpenSelectLeasePopupFromTenantInvoices(Id, ddlId, hdnId) {
    var left = (screen.width - 568) / 2;
    var top = (screen.height - 300) / 2;
    OpenPOPUp('SelectLeasePopup.aspx?Id=' + Id + '&ddlId=' + ddlId + '&hdnId=' + hdnId + '&Source=Tenant', 920, 415, false);
    return false;
}
function OpenSelectLeasePopup(Id, ddlId) {
    OpenPOPUp('SelectLeasePopup.aspx?Id=' + Id + '&ddlId=' + ddlId, 100, 100, false);
    return false;
}
function OpenSelectLeasePopupFromLease(Id, ddlId) {
    var left = (screen.width - 568) / 2;
    var top = (screen.height - 300) / 2;
    OpenPOPUp('SelectLeasePopup.aspx?Id=' + Id + '&ddlId=' + ddlId, 920, 415, false);
    return false;
}
function OpenEscalationDetailPopup(Id, txtCurrentAmountId, txtNewAmountId, LeaseId) {
    var txtCurrentAmount = document.getElementById(txtCurrentAmountId)
    var CurrentAmount = CCur(CDbl(txtCurrentAmount.value));
    OpenSmallPOPUp('EscalationDetailsPopup.aspx?Id=' + Id + '&txtNewAmountId=' + txtNewAmountId + '&CurrentAmount=' + CurrentAmount + '&LeaseId=' + LeaseId + '&RecordId=0', 400, 200, false);
}

function OpenEscalationDetailItemPopup(Id, CurrentAmount, LeaseId, RecordId) {
    OpenSmallPOPUp('EscalationDetailsPopup.aspx?Id=' + Id + '&CurrentAmount=' + CurrentAmount + '&LeaseId=' + LeaseId + '&RecordId=' + RecordId, 400, 200, false);
    return false;
}

function getQueryStrings() {
    var assoc = {};
    var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
    var queryString = location.search.substring(1);
    var keyValues = queryString.split('&');

    for (var i = 0; i < keyValues.length; i++) {
        var key = keyValues[i].split('=');
        if (key.length > 1) {
            assoc[decode(key[0])] = decode(key[1]);
        }
    }
    /*Usage example
    var qs = getQueryStrings();
    var myParam = qs["ParamName"]; 
    
    */
    return assoc;
}

function OpenReminderPropupFromDatePicker(dtp, event) {
    var ProjectId = 0;
    var LocationId = 0;
    var ProgramId = 0;
    var ObjectTypeId = 0;
    var FieldId = 0;
    var RecordId = 0;
    var IsDetail = 0;
    var DocumentId = 0;
    var SpecFieldId = 0;
    var CustomFormFieldId = 0;
    var CustomFormColumnDataId = 0;
    if (dtp.getAttribute("projectid") != null)
        ProjectId = dtp.getAttribute("projectid");
    if (dtp.getAttribute("locationid") != null)
        LocationId = dtp.getAttribute("locationid");
    if (dtp.getAttribute("programid") != null)
        ProgramId = dtp.getAttribute("programid");
    if (dtp.getAttribute("objecttypeid") != null)
        ObjectTypeId = dtp.getAttribute("objecttypeid");
    if (dtp.getAttribute("fieldid") != null)
        FieldId = dtp.getAttribute("fieldid");
    if (dtp.getAttribute("recordid") != null)
        RecordId = dtp.getAttribute("recordId");
    if (dtp.getAttribute("isdetail") != null)
        IsDetail = dtp.getAttribute("isdetail");
    if (dtp.getAttribute("documentid") != null)
        DocumentId = dtp.getAttribute("documentid");
    if (dtp.getAttribute("specfieldid") != null)
        SpecFieldId = dtp.getAttribute("specfieldid");
    if (dtp.getAttribute("customformfieldid") != null)
        CustomFormFieldId = dtp.getAttribute("customformfieldid");
    if (dtp.getAttribute("customformcolumndataid") != null)
        CustomFormColumnDataId = dtp.getAttribute("customformcolumndataid");
    OpenPOPUp("DefineReminderPopup.aspx?ProjectId=" +
                      ProjectId + "&LocationId="
                      + LocationId
                      + "&ProgramId=" + ProgramId
                      + "&ObjectTypeId=" + ObjectTypeId + "&FieldId=" + FieldId + "&RecordId=" + RecordId + "&DocumentId=" + DocumentId + "&IsDetail=" + IsDetail + "&SpecFieldId=" + SpecFieldId + "&CustomFormFieldId=" + CustomFormFieldId + "&CustomFormColumnDataId=" + CustomFormColumnDataId + "&senderId=" + dtp.id, 477, 690, false);

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

function OpenReminderPropupFromTextBox(txt, event) {
    var ProjectId = 0;
    var LocationId = 0;
    var ProgramId = 0;
    var ObjectTypeId = 0;
    var FieldId = 0;
    var RecordId = 0;
    var IsDetail = 0;
    var DocumentId = 0;
    var SpecFieldId = 0;
    var CustomFormFieldId = 0;
    var CustomFormColumnDataId = 0;

    if ($("[id$=RadDatePicker1]").length >= 1) {
        var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
        datePicker.hidePopup();
    }
    if ($(txt).attr("projectid") != null)
        ProjectId = $(txt).attr("projectid");
    if ($(txt).attr("locationid") != null)
        LocationId = $(txt).attr("locationid");
    if ($(txt).attr("programid") != null)
        ProgramId = $(txt).attr("programid");
    if ($(txt).attr("objecttypeid") != null)
        ObjectTypeId = $(txt).attr("objecttypeid");
    if ($(txt).attr("fieldid") != null)
        FieldId = $(txt).attr("fieldid");
    if ($(txt).attr("recordid") != null)
        RecordId = $(txt).attr("recordId");
    if ($(txt).attr("isdetail") != null)
        IsDetail = $(txt).attr("isdetail");
    if ($(txt).attr("documentid") != null)
        DocumentId = $(txt).attr("documentid");
    if ($(txt).attr("specfieldid") != null)
        SpecFieldId = $(txt).attr("specfieldid");
    if ($(txt).attr("customformfieldid") != null)
        CustomFormFieldId = $(txt).attr("customformfieldid");
    if ($(txt).attr("customformcolumndataid") != null)
        CustomFormColumnDataId = $(txt).attr("customformcolumndataid");
    OpenPOPUp("DefineReminderPopup.aspx?ProjectId=" +
                      ProjectId + "&LocationId="
                      + LocationId
                      + "&ProgramId=" + ProgramId
                      + "&ObjectTypeId=" + ObjectTypeId + "&FieldId=" + FieldId + "&RecordId=" + RecordId + "&DocumentId=" + DocumentId + "&IsDetail=" + IsDetail + "&SpecFieldId=" + SpecFieldId + "&CustomFormFieldId=" + CustomFormFieldId + "&CustomFormColumnDataId=" + CustomFormColumnDataId + "&senderId=" + txt.id, 477, 690, false);

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


function OpenSnapShotNotificationPopup(RecordType, RecordId, RecordDescription, EntityId, EntityTypeId, CustomFormTypeId, AttachmentId) {
    OpenParentPOPUp("Notification.aspx?ObjectType=" + RecordType + "&Id=" +
             RecordId + "&Description="
                        + RecordDescription
                        + "&RecordDescription=" + RecordDescription
                        + "&EntityId=" + EntityId + "&EntityType=" + EntityTypeId
                        + "&CustomFormTypeId=" + CustomFormTypeId
                        + "&AttachmentId=" + AttachmentId, 850, 500);
    return false;
}


function OpenNotificationPopup(RecordType, RecordId, RecordDescription, EntityId, EntityTypeId, CustomFormTypeId, AttachmentId) {
    return OpenPOPUp('Notification.aspx?ObjectType=' + RecordType + '&Id=' +
             RecordId + '&Description='
                        + RecordDescription
                        + '&RecordDescription=' + RecordDescription
                        + '&EntityId=' + EntityId + '&EntityType=' + EntityTypeId
                        + '&CustomFormTypeId=' + CustomFormTypeId
                        + '&AttachmentId=' + AttachmentId, 500, 700, true)
    //var browserWidth = $telerik.$(window).width();
    //var browserHeight = $telerik.$(window).height();
    //var wnd = window.radopen('Notification.aspx?ObjectType=' + RecordType + '&Id=' +
    //         RecordId + '&Description='
    //                    + RecordDescription
    //                    + '&RecordDescription=' + RecordDescription
    //                    + '&EntityId=' + EntityId + '&EntityType=' + EntityTypeId
    //                    + '&CustomFormTypeId=' + CustomFormTypeId
    //                    + '&AttachmentId=' + AttachmentId, 'Notification');
    //if (isMobileScreen()) {
    //    wnd.setSize(browserWidth - 10, browserHeight - 10);
    //    wnd.moveTo(8, 0);
    //}
    //else {
    //    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
    //    wnd.Center();
    //}
    //return false;
    //var left = (screen.width - 900) / 2;
    //var top = (screen.height - 500) / 2;
    //window.open("Notification.aspx?ObjectType=" + RecordType + "&Id=" +
    //         RecordId + "&Description="
    //                    + RecordDescription
    //                    + "&RecordDescription=" + RecordDescription
    //                    + "&EntityId=" + EntityId + "&EntityType=" + EntityTypeId
    //                    + "&CustomFormTypeId=" + CustomFormTypeId
    //                    + "&AttachmentId=" + AttachmentId, "Notification",
    //        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
    //return false;
}

function ReloadWorkflowDocPage(msg) {
    alert(msg);
    var btnReloadWorkflowDoc = $("[id$=btnReloadWorkflowDoc]");
    btnReloadWorkflowDoc.click();
}

function AdjustCostImpactTotalCost(gridId) {
    var grid = $("#" + gridId);
    // On change Unit Cost



    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
        var row = $(this).parents("tr:first");
        CalculateCostImpactTotals(row, 'Quantity');
    }
).focus(function () {

}
);
    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
        var row = $(this).parents("tr:first");
        CalculateCostImpactTotals(row, 'UnitCost');
    }
).focus(function () {

}
);
    $("input[id*=" + gridId + "][id$=txtTotalCost]").change(function () {
        var row = $(this).parents("tr:first");
        CalculateCostImpactTotals(row, 'Amount');
    }
).focus(function () {

}
);

}

function CalculateCostImpactTotals(row, sender) {
    var txtAmount = row.find("input[id$='txtTotalCost']");
    var Amount = CDbl(txtAmount.val());
    var txtQuantity = row.find("input[id$='txtQuantity']");
    var Quantity = CDbl(txtQuantity.val());
    var txtUnitCost = row.find("input[id$='txtUnitCost']");
    if (sender == 'Amount') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtUnitCost.val(CCur(Amount / Quantity));
    }

    if (sender == 'UnitCost') {
        if (Quantity == 0) {
            txtQuantity.val(FPrec(1));
            Quantity = 1;
        }
        txtAmount.val(CCur(CDbl(txtUnitCost.val()) * Quantity));

    }
    if (sender == 'Quantity') {

        txtAmount.val(CCur(CDbl(txtUnitCost.val()) * Quantity));

    }


}

/*Redirect From Main Dropdown*/
function MainDropDown_SelectedIndexChanging(sender, eventArgs) {
    var RecordId = eventArgs._item.get_value();
    if (parseInt(RecordId) > 0) {
        eventArgs.set_cancel(true);
        PMFormSubmit();
        if (currPageId == 7 || currPageId == 181) {
            window.location.href = currPageName + '?Id=' + RecordId;
        }
        else {
            window.location.href = currPageName + '?Id=' + RecordId + '&ModuleId=' + currModuleId + '&PageId=' + currPageId;
        }
        return false;
    }
}

/*Redirect From Main DropDown Containing TreeView*/
function MainTree_NodeClicking(sender, eventArgs) {
    var node = eventArgs.get_node();
    var RecordId = ""
    var RecordId = node.get_value();
    var pos1 = RecordId.indexOf(" ");
    if (pos1 > -1) {
        var loadedType = RecordId.substring(pos1 + 1, RecordId.length);
        if (loadedType == "C" || loadedType == "S") {
            eventArgs.set_cancel(true);
            return false;
        }
        else {
            if (loadedType == "I") {
                var Id = RecordId.substring(0, pos1)
                eventArgs.set_cancel(true);
                window.location.href = currPageName + '?Id=' + Id + '&ModuleId=' + currModuleId + '&PageId=' + currPageId;
                return false;
            }

        }

    }

    else {
        window.location.href = currPageName + '?Id=' + CInt(RecordId) + '&ModuleId=' + currModuleId + '&PageId=' + currPageId;
    }



}

Array.prototype.insert = function (index, item) {
    this.splice(index, 0, item);
};


function insertOptionToSelect(select, idx, option) {
    var saved = [];
    var i;
    for (i = 0; i < select.options.length; i++) {
        saved.push(select.options[i]);
    }
    select.options.length = 0;
    for (i = 0; i < idx; i++) {
        select.options[select.options.length] = saved[i];
    }
    select.options[select.options.length] = option;
    while (i < saved.length) {
        select.options[select.options.length] = saved[i++];
    }
}

function UpdateEquipmentLocationAferMove() {
    var btnUpdateEquipmentLocation = $("[id$=btnUpdateEquipmentLocation]");
    if (btnUpdateEquipmentLocation.length == 1) {
        btnUpdateEquipmentLocation.click();

    }

}

/*Length area UOM changing*/
function LinearLengthUOMChanging(sender, eventArgs) {
    if (sender.get_selectedItem() == null || eventArgs.get_item() == null) { return; }
    var FromLengthUOMId = sender.get_selectedItem().get_value();
    var ToLengthUOMId = eventArgs.get_item().get_value();

    var LengthUnitMultipliyer = 1;
    if (FromLengthUOMId == 1) LengthUnitMultipliyer = LengthUnitMultipliyer; //meter
    if (FromLengthUOMId == 2) LengthUnitMultipliyer = (LengthUnitMultipliyer / 3.28084); //lnf
    if (FromLengthUOMId == 3) LengthUnitMultipliyer = (LengthUnitMultipliyer / 0.000621371); //mile

    if (ToLengthUOMId == 1) LengthUnitMultipliyer = LengthUnitMultipliyer; //meter
    if (ToLengthUOMId == 2) LengthUnitMultipliyer = (LengthUnitMultipliyer * 3.28084); //lnf
    if (ToLengthUOMId == 3) LengthUnitMultipliyer = (LengthUnitMultipliyer * 0.000621371); //mile

    var ddlLengthUOM = sender.get_id();
    var txtLengthId = ddlLengthUOM.substring(ddlLengthUOM.lastIndexOf('_'), ddlLengthUOM.lenght - 1) + '_txtLength';
    if (window.$("input[id$=" + txtLengthId + "]")) window.$("input[id$=" + txtLengthId + "]").val(FPrec(CDbl(CDbl(window.$("input[id$=" + txtLengthId + "]").val()) * LengthUnitMultipliyer)));

}

function LinearAreaUOMChanging(sender, eventArgs) {
    if (sender.get_selectedItem() == null || eventArgs.get_item() == null) { return; }
    var FromAreaUOMId = sender.get_selectedItem().get_value();
    var ToAreaUOMId = eventArgs.get_item().get_value();

    var AreaUnitMultipliyer = 1;
    if (FromAreaUOMId == 1) AreaUnitMultipliyer = AreaUnitMultipliyer; //m2
    if (FromAreaUOMId == 2) AreaUnitMultipliyer = AreaUnitMultipliyer / 10.7639; //sqft
    if (FromAreaUOMId == 3) AreaUnitMultipliyer = AreaUnitMultipliyer / 0.0001; //hectare
    if (FromAreaUOMId == 4) AreaUnitMultipliyer = AreaUnitMultipliyer / 0.000247105; //acre

    if (ToAreaUOMId == 1) AreaUnitMultipliyer = AreaUnitMultipliyer; //m2
    if (ToAreaUOMId == 2) AreaUnitMultipliyer = AreaUnitMultipliyer * 10.7639; //sqft
    if (ToAreaUOMId == 3) AreaUnitMultipliyer = AreaUnitMultipliyer * 0.0001; //hectare
    if (ToAreaUOMId == 4) AreaUnitMultipliyer = AreaUnitMultipliyer * 0.000247105; //acre

    var ddlLinearAreaUOM = sender.get_id();
    var txtLinearAreaId = ddlLinearAreaUOM.substring(ddlLinearAreaUOM.lastIndexOf('_'), ddlLinearAreaUOM.lenght - 1) + '_txtLinearArea';
    if (window.$("input[id$=" + txtLinearAreaId + "]")) window.$("input[id$=" + txtLinearAreaId + "]").val(FPrec(CDbl(CDbl(window.$("input[id$=" + txtLinearAreaId + "]").val()) * AreaUnitMultipliyer)));

}
/*Length area UOM changing*/


function GetUDFValueToReturn(combobox, eventArgs) {
    var context = eventArgs.get_context();
    var SelectedValue;
    var ddlId = combobox.get_id().replace('_EditUserDefinedFields', '');
    var ddlProjects = $find(ddlId.substring(0, ddlId.lastIndexOf('_') - 1) + '_ddlProjects');

    if (ddlProjects != null) {
        SelectedValue = ddlProjects.get_value();
        context["FilterString"] = SelectedValue;
    }
    else {
        context["FilterString"] = "-1";

    }


}

////////////////////////////////////////////////////////*MultiSelect dropdown*///////////////////////////

function GetMultiSelectValueToReturn(combobox, eventArgs) {
    var SelectedValue;
    var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnMultiIds';
    var hdnField = $("[id$=" + hdn + "]")[0];
    var context = eventArgs.get_context();
    context["Ids"] = hdnField.value;
}

function ddlMultiSelectCheck(sender, ddl, resultId, ResultName) {
    var combo = $find(ddl);
    var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnMultiIds';
    var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnMultiNames';
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

function OpenScoringAddFilesPopup(RecordType, RecordId, LineId, Options) {
    return OpenPOPUp('ScoringAddFiles.aspx?RecordType=' + RecordType + '&RecordId=' + RecordId + '&LineId=' + LineId + '&Options=' + Options, 500, 400, true)
}

if (typeof document.getElementsByClassName != 'function') {
    document.getElementsByClassName = function () {
        var elms = document.getElementsByTagName('*');
        var ei = new Array();
        for (i = 0; i < elms.length; i++) {
            if (elms[i].getAttribute('class')) {
                ecl = elms[i].getAttribute('class').split(' ');
                for (j = 0; j < ecl.length; j++) {
                    if (ecl[j].toLowerCase() == arguments[0].toLowerCase()) {
                        ei.push(elms[i]);
                    }
                }
            } else if (elms[i].className) {
                ecl = elms[i].className.split(' ');
                for (j = 0; j < ecl.length; j++) {
                    if (ecl[j].toLowerCase() == arguments[0].toLowerCase()) {
                        ei.push(elms[i]);
                    }
                }
            }
        }
        return ei;
    }
}

function DisableLinkbuttonPostback() {
    return false;
}

function rdmLayouts_ItemClicking(sender, eventArgs) {
    var item = eventArgs.get_item().get_value();
    if (item == -8) {
        var result;
        result = confirm(WarningMsg_ConfirmDeleteLayout);
        eventArgs.set_cancel(!result);
        return false;
    }
    eventArgs.set_cancel(false);
    return true;
}

function RefreshRotator() {
    var btnRefreshRotator = $("[id$=btnRefreshRotator]");
    if (btnRefreshRotator) {
        btnRefreshRotator.click();
    }

}
function ResourcesAllowPayTyeComboCheckAll(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnPayTypesIds';
    var hdnPaytTypesIds = $("[id$=" + hdn + "]")[0];
    var chkAll = $("[id$=" + chk + "]")[0];
    //var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
    //var item = combo.get_items().getItem(0);
    var text = '*All*';
    var values = -1;
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
        if (i != 0) {
            if (chkAll.checked) this.checked = false;
        }
        i++;
    });

    //        if (text.length > 0) {
    if (chkAll.checked) {
        combo.set_text(text.trim());
        combo.set_value(values);
        if (hdnPaytTypesIds) hdnPaytTypesIds.value = values;
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnPaytTypesIds) hdnPaytTypesIds.value = "";
    }
}
function ResourcesAllowPayTypeComboCheckParent(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnPayTypesIds';
    var hdnPaytTypesIds = $("[id$=" + hdn + "]")[0];
    //var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
    var chkParent = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[0];
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnDefaultPayTypeId';
    var hddnDefaultPayTypeId = $("[id$=" + hdn + "]")[0];

    var i = 0;
    var isChecked = true;
    var text = "";
    var values = "";
    var items = combo.get_items();
    $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
        if (i != 0) {
            var item = items.getItem(i - 1);
            if (this.parentElement.parentElement.className.indexOf('Hide') >= 0)
                this.checked = false;

            if (this.checked) {
                text += item.get_text() + ";";
                values += item.get_value() + ";";
            }
            else {
                var chk1 = $("#" + comboId + "_DropDown").find("input[id*='chkDefault']")[i - 1]
                chk1.checked = false;
                if (hddnDefaultPayTypeId) hddnDefaultPayTypeId.value = "";
            }

            if (isChecked && this.parentElement.parentElement.className.indexOf('Hide') < 0) isChecked = this.checked;
        }
        i++;
    });

    chkParent.checked = isChecked && items._array.length > 2;

    if (isChecked && items._array.length > 2) {
        var item = combo.get_items().getItem(0);
        text = '*ALL*';
        values = "-1";
        i = 0;
        $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
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
        combo.set_value(values);
        if (hdnPaytTypesIds) {
            hdnPaytTypesIds.value = values;

        }
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnPaytTypesIds) hdnPaytTypesIds.value = "";
    }
    return false;
}

function ResourcesPayTypeComboDefaultClick(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnDefaultPayTypeId';
    var hddnDefaultPayTypeId = $("[id$=" + hdn + "]")[0];
    var chkDefault = $("[id$=" + chk + "]")[0];
    var items = combo.get_items();
    var value = ""
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[id*='chkDefault']").each(function () {
        var item = items.getItem(i);
        if (this != chkDefault) {
            this.checked = false;
        }
        if (this == chkDefault && chkDefault.checked) {
            value = item.get_value()
            var chkAll = $("#" + comboId + "_DropDown").find("input[id*='chkAllowAll']")[0]
            if (!chkAll.checked) {
                var chk1 = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[i + 1]
                chk1.checked = true;
                ResourcesAllowPayTypeComboCheckParent(chk1, comboId)
            }
        }
        i++;
    });
    if (hddnDefaultPayTypeId) hddnDefaultPayTypeId.value = value;
}

function ResourcesAllowClassificationComboCheckAll(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnClassificationsIds';
    var hdnClassificationsIds = $("[id$=" + hdn + "]")[0];
    var chkAll = $("[id$=" + chk + "]")[0];
    //var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
    //var item = combo.get_items().getItem(0);
    var text = '*All*';
    var values = -1;
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
        if (i != 0) {
            if (chkAll.checked) this.checked = false;
        }
        i++;
    });

    //        if (text.length > 0) {
    if (chkAll.checked) {
        combo.set_text(text.trim());
        combo.set_value(values);
        if (hdnClassificationsIds) hdnClassificationsIds.value = values;
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnClassificationsIds) hdnClassificationsIds.value = "";
    }
}

function ResourcesAllowClassificationComboCheckParent(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnClassificationsIds';
    var hdnClassificationsIds = $("[id$=" + hdn + "]")[0];
    //var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
    var chkParent = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[0];
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnDefaultClassificationId';
    var hddnDefaultClassificationId = $("[id$=" + hdn + "]")[0];

    var i = 0;
    var isChecked = true;
    var text = "";
    var values = "";
    var items = combo.get_items();
    $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
        if (i != 0) {
            var item = items.getItem(i - 1);
            if (this.parentElement.parentElement.className.indexOf('Hide') >= 0)
                this.checked = false;

            if (this.checked) {
                text += item.get_text() + ";";
                values += item.get_value() + ";";
            }
            else {
                var chk1 = $("#" + comboId + "_DropDown").find("input[id*='chkDefault']")[i - 1]
                chk1.checked = false;
                if (hddnDefaultClassificationId) hddnDefaultClassificationId.value = "";
            }

            if (isChecked && this.parentElement.parentElement.className.indexOf('Hide') < 0) isChecked = this.checked;
        }
        i++;
    });

    chkParent.checked = isChecked && items._array.length > 2;

    if (isChecked && items._array.length > 2) {
        var item = combo.get_items().getItem(0);
        text = '*ALL*';
        values = "-1";
        i = 0;
        $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
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
        combo.set_value(values);
        if (hdnClassificationsIds) {
            hdnClassificationsIds.value = values;

        }
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnClassificationsIds) hdnClassificationsIds.value = "";
    }
    return false;
}

function ResourcesClassificationComboDefaultClick(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnDefaultClassificationId';
    var hddnDefaultClassificationId = $("[id$=" + hdn + "]")[0];
    var chkDefault = $("[id$=" + chk + "]")[0];
    var items = combo.get_items();
    var value = ""
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[id*='chkDefault']").each(function () {
        var item = items.getItem(i);
        if (this != chkDefault) {
            this.checked = false;
        }
        if (this == chkDefault && chkDefault.checked) {
            value = item.get_value()
            var chkAll = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[0]
            if (!chkAll.checked) {
                var chk1 = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[i + 1]
                chk1.checked = true;
                ResourcesAllowClassificationComboCheckParent(chk1, comboId)
            }

        }
        i++;
    });
    if (hddnDefaultClassificationId) hddnDefaultClassificationId.value = value;
}


function EquipmentResourcesAllowClassificationComboCheckAll(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnEquClassificationsIds';
    var hdnEquClassificationsIds = $("[id$=" + hdn + "]")[0];
    var chkAll = $("[id$=" + chk + "]")[0];
    //var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
    //var item = combo.get_items().getItem(0);
    var text = '*All*';
    var values = -1;
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
        if (i != 0) {
            if (chkAll.checked) this.checked = false;
        }
        i++;
    });

    //        if (text.length > 0) {
    if (chkAll.checked) {
        combo.set_text(text.trim());
        combo.set_value(values);
        if (hdnEquClassificationsIds) hdnEquClassificationsIds.value = values;
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnEquClassificationsIds) hdnEquClassificationsIds.value = "";
    }
}

function EquipmentResourcesAllowClassificationComboCheckParent(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnEquClassificationsIds';
    var hdnEquClassificationsIds = $("[id$=" + hdn + "]")[0];
    //var hdnSelectedValues = document.getElementById(hdnSelectedValuesId);
    var chkParent = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[0];
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnEquDefaultClassificationId';
    var hddnDefaultClassificationId = $("[id$=" + hdn + "]")[0];


    var i = 0;
    var isChecked = true;
    var text = "";
    var values = "";
    var items = combo.get_items();
    $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
        if (i != 0) {
            var item = items.getItem(i - 1);
            if (this.parentElement.parentElement.className.indexOf('Hide') >= 0)
                this.checked = false;

            if (this.checked) {
                text += item.get_text() + ";";
                values += item.get_value() + ";";
            }
            else {
                var chk1 = $("#" + comboId + "_DropDown").find("input[id*='chkDefault']")[i - 1]
                chk1.checked = false;
                if (hddnDefaultClassificationId) hddnDefaultClassificationId.value = "";
            }


            if (isChecked && this.parentElement.parentElement.className.indexOf('Hide') < 0) isChecked = this.checked;
        }
        i++;
    });

    chkParent.checked = isChecked && items._array.length > 2;

    if (isChecked && items._array.length > 2) {
        var item = combo.get_items().getItem(0);
        text = '*ALL*';
        values = "-1";
        i = 0;
        $("#" + comboId + "_DropDown").find("input[id*='chkAllow']").each(function () {
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
        combo.set_value(values);
        if (hdnEquClassificationsIds) {
            hdnEquClassificationsIds.value = values;

        }
    }
    else {
        combo.set_text("");
        combo.set_value("");
        if (hdnEquClassificationsIds) hdnEquClassificationsIds.value = "";
    }
    return false;
}

function EquipmentResourcesClassificationComboDefaultClick(chk, comboId) {
    var combo = $find(comboId);
    var hdn = comboId.substring(comboId.lastIndexOf('_'), comboId.lenght - 1) + '_hddnEquDefaultClassificationsId';
    var hddnEquDefaultClassificationId = $("[id$=" + hdn + "]")[0];
    var chkDefault = $("[id$=" + chk + "]")[0];
    var items = combo.get_items();
    var value = ""
    var i = 0;
    $("#" + comboId + "_DropDown").find("input[id*='chkDefault']").each(function () {
        var item = items.getItem(i);
        if (this != chkDefault) {
            this.checked = false;
        }
        if (this == chkDefault && chkDefault.checked) {
            value = item.get_value()
            var chkAll = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[0]
            if (!chkAll.checked) {
                var chk1 = $("#" + comboId + "_DropDown").find("input[id*='chkAllow']")[i + 1]
                chk1.checked = true;
                EquipmentResourcesAllowClassificationComboCheckParent(chk1, comboId)
            }
        }
        i++;
    });
    if (hddnEquDefaultClassificationId) hddnEquDefaultClassificationId.value = value;
}

function CustomFilter_OnColumnCreated(sender, args) {
    try {
        var column = args.get_column();
        if (column.get_uniqueName().indexOf('$') < 0) {
            var test = $('input[id$=FilterTextBox_' + String(column.get_uniqueName()) + ']');
            if (test) {
                if (column._data.DataTypeName == "System.DateTime" || column._data.DataTypeName == "System.Double"
                    || column._data.DataTypeName == "System.Int64" || column._data.DataTypeName == "System.Int32"
                    || column._data.DataTypeName == "System.Decimal") {
                    var StringTodeleteFromKeyPress = test.attr("onchange");
                    var OnKeyPressString = String(test.attr("onkeypress")).replace(StringTodeleteFromKeyPress, "");
                    test.attr("onkeypress", OnKeyPressString);
                    test.attr("onchange", "");
                }
            }
        }
    }
    catch (err) { }
}

function GridHeaderMenuShowing(sender, args) {
    var SortExp = args.get_gridColumn()._data.SortExpression;
    var Contmenu = args.get_menu();
    var SortAsc = Contmenu.findItemByValue('SortAsc');
    var SortDesc = Contmenu.findItemByValue('SortDesc');
    var SortNone = Contmenu.findItemByValue('SortNone');
    if (SortAsc && SortDesc && SortNone) {
        if (typeof SortExp === 'undefined' || SortExp == '') {
            SortAsc.get_element().style.display = 'none';
            SortDesc.get_element().style.display = 'none';
            SortNone.get_element().style.display = 'none';
        } else {
            SortAsc.get_element().style.display = 'block';
            SortDesc.get_element().style.display = 'block';
            SortNone.get_element().style.display = 'block';
        }
    }
}


function GoToTransmittalPage(sender, eventArgs) {
    window.location = eventArgs.getDataKeyValue("Url");
}


function ShowHidebtnTreeDropItems(sender, args) {
    if (sender.get_checkedNodes().length > 0) {
        $("[id$=btnTreeDropItems]").removeClass("Hide");
    }
    else
        $("[id$=btnTreeDropItems]").addClass("Hide");
}


/*******************Help Link***********************/

var helpLink = '';

function helpClick() {
    var isIE11 = !!window.MSInputMethodContext && !!document.documentMode;
    if (isIE11) {
        createHiddenField();
    }
    window.open(helpLink);
}

function createHiddenField() {
    var input = document.createElement("INPUT")
    input.id = "hdnReferrer";
    input.type = "hidden";
    input.value = window.location.href;
    document.body.appendChild(input);
}

/************************************************/


    var MobileScreenWidth = 1024;
    function isMobileScreen() {
        var browserWidth = $telerik.$(window).width();
        if (browserWidth <= MobileScreenWidth)
            return true;
        return false;
    }

    function OpenCostWorksheetPopup(ProjectId, CostCodeId) {
        var browserWidth = $telerik.$(window).width();
        var browserHeight = $telerik.$(window).height();
        var wnd = window.radopen('CostWorksheetPopup.aspx?Projectid=' + ProjectId + '&CostCodeId=' + CostCodeId);
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
        }
        else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        return false;
    }
    function PopupImageGallery(btnImg) {
        //var url = "ImageGallery.aspx?ImageId=" + $(btnImage).attr("ImageId");
        //return OpenPOPWindow(url, 550, 500);
        $("#flyoutBackdrop ,.RotatorPopup").removeClass("Hide");
        var totalImageCount = $('#RotatorContainer').find("input[type='image']").length;
        var count = 0;
        $('#PmMasterFader img').remove();
        $('#RotatorContainer').find("input[type='image']").each(function () {
            if ($(btnImg).attr('ImageId') == $(this).attr('ImageId'))
                $('<img src="' + $(this).attr('src') + '" style="border-width:0px;height:320px;width:370px;" >').prependTo("#PmMasterFader");
            else
                $('<img src="' + $(this).attr('src') + '" style="border-width:0px;height:320px;width:370px;" >').appendTo("#PmMasterFader");
            count = count + 1;
            if (count == totalImageCount) {
                $('#PmMasterFader img:not(:first)').hide();
                var flyout = $(".RotatorPopup")[0]
                var flyoutBackdrop = $('#flyoutBackdrop')[0]
                flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
                flyout.className = flyout.className.replace(' Hide', '');


            }

        });



        function fadeNext() {
            $('#PmMasterFader img').first().hide().fadeOut().appendTo($('#PmMasterFader'));
            $('#PmMasterFader img').first().fadeIn();
        }

        function fadePrev() {
            $('#PmMasterFader img').first().hide().fadeOut();
            $('#PmMasterFader img').last().prependTo($('#PmMasterFader')).fadeIn();
        }

        $('#popupnext').click(function () {
            fadeNext();
        });

        $('#popupprev').click(function () {
            fadePrev();
        });
        return false;

    }

    let notesPendingClick = 0;
    function OnNotesRowClick(sender, eventArgs) {
        if (notesPendingClick) {
            clearTimeout(notesPendingClick);
            notesPendingClick = 0;
        }
        let e = eventArgs.get_domEvent().rawEvent.detail;
        let index = eventArgs.get_itemIndexHierarchical();
        let grid = sender.get_masterTableView();
        switch (e) {
            case 1:
                notesPendingClick = setTimeout(function () {
                    grid.fireCommand("RowClick", "");
                }, 300);
                break;
            case 2:
                grid.clearSelectedItems()
                grid.selectItem(grid.get_dataItems()[index].get_element());
                grid.fireCommand("DoubelClick", "");
                //return popUpNote(false);
        }
    };