/********* Chrome Zoom/Scroll Error *****************/
//Type.registerNamespace("Telerik.Web.UI");
$(document).ready(function () {
   if (typeof(Telerik) !=='undefined')  {
        if (Telerik.Web.UI.RadListBox != null) {
            Telerik.Web.UI.RadListBox.prototype.saveClientState = function () {
                return "{" + "\"isEnabled\":" + this._enabled
                        + ",\"logEntries\":" + this._logEntriesJson
                        + ",\"selectedIndices\":" + this._selectedIndicesJson
                        + ",\"checkedIndices\":" + this._checkedIndicesJson
                        + ",\"scrollPosition\":" + Math.round(this._scrollPosition) + "}";
            }
        }
        if (Telerik.Web.UI.RadScheduler != null) {
            Telerik.Web.UI.RadScheduler.prototype.saveClientState = function () {
                return '{"scrollTop":' + Math.round(this._scrollTop) + ',"scrollLeft":' + Math.round(this._scrollLeft) + ',"isDirty":' + this._isDirty + '}';
            }
        }
        if (Telerik.Web.UI.RadTreeView != null) {
            Telerik.Web.UI.RadTreeView.prototype.saveClientState = function () {
                return "{\"expandedNodes\":" + this._expandedNodesJson +
                ",\"collapsedNodes\":" + this._collapsedNodesJson +
                ",\"logEntries\":" + this._logEntriesJson +
                ",\"selectedNodes\":" + this._selectedNodesJson +
                ",\"checkedNodes\":" + this._checkedNodesJson +
                ",\"scrollPosition\":" + Math.round(this._scrollPosition) + "}";
            }
        }
    }
});




/********* Date Picker *****************/
function DisableDatePicker(datepicker) {
    datepicker.clear();
    datepicker.set_enabled(false);
}

function EnableDatePicker(datepicker, enabletyping) {
    datepicker.set_enabled(true);
}


/********************* Rad Window Manager *********************/


function OpenLinkRecordsPopup() {
    var left = (screen.width - 1000) / 2;
    var top = (screen.height - 600) / 2;
    window.open('LinkedRecords.aspx', null,
                     'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1000,height=600,top=' + top + ',left=' + left);


}
function OpenHelpPopup(argUrl) {
    var left = (screen.width - 1000) / 2;
    var top = (screen.height - 600) / 2;
    window.open(argUrl, null, 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1000,height=600,top=' + top + ',left=' + left);
    return false;

}

function CloseLinkRecordsPopup() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnRefreshLinkRecords]")
    if (btnRefreshId) {
        btnRefreshId.click();
    }
}

function CloseDocumentNotesPopup() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnRefreshGrid]")
    if (btnRefreshId) {
        btnRefreshId.click();
    }
}
function CloseParicipantPopup() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnRefreshParticipant]");
    if (btnRefreshId) {
      btnRefreshId.click();
    }
}
function CloseLogOutPopupSave() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnLogoutSave]")
    if (btnRefreshId) {
        btnRefreshId.click();
    }
}

function CloseLogOutPopupDelete() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnLogoutDelete]")
    if (btnRefreshId) {
        btnRefreshId.click();
    }
}

function CloseBrowserPopup() {
    window.close();
}

function WindowClosed(Opener) {
    
    var btnRefreshId;
    if (GridToRebind != "") {
        btnRefreshId = $("a[id*=" + GridToRebind + "][id$=btnRefresh]")[0];
    } else {
        btnRefreshId = $("a[id$=btnRefresh]")[0];
    }
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}
var GridToRebind = ""
function OpenPOPUp(URL, Width, Height, AddClose, gridId) {
    var wnd = window.radopen(URL);
    wnd.setSize(Width, Height);
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }
    wnd.Center();
    return false;
}

function OpenWindowPOPUp(URL, Width, Height) {
    var left = (screen.width - Width) / 2;
    var top = (screen.height - Height) / 2;
    window.open(URL, null,
                     'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + Width + ',height=' + Height + ',top=' + top + ',left=' + left);
    return false;
}

function GetRadWnd() {
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow;

    else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;

    return oWindow;
}

function OpenAdjustmentsSelector(Width, Height) {
    var wnd = window.radopen('AdjustmentSelectPopup.aspx');
    wnd.setSize(Width, Height);
    wnd.add_close(AdjustmentsSelectorClosed);
    wnd.Center();
    return false;
}

function AdjustmentsSelectorClosed(Opener) {
    var btnAdjustmentsRefresh = $("a[id$=btnAdjustmentsRefresh]")[0];
    if (btnAdjustmentsRefresh) { btnAdjustmentsRefresh.click(); }
}

function CloseRadWnd() {
    var oWindow = GetRadWnd(); 
    oWindow.Close();
}

function ClosePopWnd(ctrl) {
    try {
        var oWindow = GetRadWnd();
        oWindow.Close();
    } catch (er) {
    ctrl.close();
    }
}

var GridForCostCodesPopup;
function OpenCostCodesPOPUp(Source, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('CostCodesPOPUp.aspx?SourcePage=' + Source);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(Width, Height);
        wnd.Center();
    }
    wnd.add_close(CostCodesPopupClosed);
    wnd.Center();
    return false;
}

function CostCodesPopupClosed(Opener) {
    if (GridForCostCodesPopup) {
        var btnEditRowsFromCostCodesPopup = $("input[id*=" + GridForCostCodesPopup.get_id() + "][id$=btnEditRowsFromCostCodesPopup]")[0];
        if (btnEditRowsFromCostCodesPopup) { btnEditRowsFromCostCodesPopup.click(); }
    }
}

function OpenContactsPopup(Width, Height) {
    var wnd = window.radopen('ContactsPopup.aspx');
    wnd.setSize(Width, Height);
    wnd.add_close(ContactsPopupClosed);
    wnd.Center();
    return false;
}



function ContactsPopupClosed(Opener) {
    var btnAddContact = $("input[id$=btnAddContact]")[0];
    if (btnAddContact) { btnAddContact.click(); }
}

function OpenPOPUpToRefresh(URL, Width, Height) {
    var wnd = window.radopen(URL);
    wnd.setSize(Width, Height);
    wnd.add_close(RefreshAfterClosed);
    wnd.Center();
    return false;
}


function RefreshAfterClosed(Opener) {
    location.reload();
}

function OpenPOPUpToRedirect(URL, Width, Height) {
    var wnd = window.radopen(URL);
    wnd.setSize(Width, Height);
    wnd.add_close(RedirectAfterClosed);
    wnd.Center();
    return false;
}

function CloseRadWndToRedirect(url) {
    var oWindow = GetRadWnd();
    var arg = new Object();
    arg.url = url;
    oWindow.Close(arg);
}

function RedirectAfterClosed(oWnd, args) {
    var arg = args.get_argument();
    if (arg && arg.url) {
        window.location.href = arg.url;
    }
}


function CloseProcurmentPopup() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnRefreshBidder]");
   
    if (btnRefreshId) {
      btnRefreshId.click();
    }
}

function ClosePreBidPopup() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.opener.document).find("input[id$=btnRefreshBidderMatrix]");

    if (btnRefreshId) {
        btnRefreshId.click();
    }
}


function OpenGridLayoutPopup(URL, gridId) {
    var wnd = window.radopen(URL);
    wnd.setSize(730, 630);
    GridToRebind = gridId;
    wnd.add_close(GridLayoutPopupClosed);
    wnd.Center();
    return false;
}

function GridLayoutPopupClosed(Opener) {
    var btnRefreshId;
    if (GridToRebind != "") {
        btnRefreshId = $("[id$=" + GridToRebind + "] a.GridCmdRebindGrid")[0];
    } else {
        btnRefreshId = $("a.GridCmdRebindGrid")[0];
    }
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}
/*****************************************************************/



function RowDblClick(sender, eventArgs) {

    var btnEditSelected = $("a[id*=" + sender.ClientID + "][id$=btnEditSelected]")[0];
    var btnUpdateEdited = $("a[id*=" + sender.ClientID + "][id$=btnUpdateEdited]")[0];

    if (btnEditSelected) { eval(btnEditSelected.href.split(":")[1].toString().replace(/%20/g, ' ')); }
    else if (btnUpdateEdited) { eval(btnUpdateEdited.href.split(":")[1].toString().replace(/%20/g, ' ')); }
}

function onTabSelecting(sender, args) {
    if (args.get_tab().get_pageViewID()) {
        args.get_tab().set_postBack(false);
    }
    if (args.get_tab().get_value() == 'Attachments') {
        sender.EnableAjax = false;
    }
}

/********Date Picker **********/
var currentTextBox = null;
var currentDatePicker = null;
function showFileAttributeDatePopup(sender, e, atRight) {
 
    currentTextBox = sender;
    
    if (currentTextBox.getAttribute("Readonly") == null || currentTextBox.getAttribute("Readonly")== false ) {

        var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
        currentDatePicker = datePicker;
        datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
        var position = getFileAttributePosition(sender);
        datePicker.showPopup((atRight) ? position.x + sender.offsetWidth - 200 : position.x, position.y + sender.offsetHeight);
        
    }
    }



function getFileAttributePosition(element) {
    var xPosition = 0;
    var yPosition = 0;

    var gbcr = element.getBoundingClientRect(),
        de = document.documentElement,
        b = document.body
    scrollY = window.pageYOffset || de.scrollTop || b.scrollTop,
    scrollX = window.pageXOffset || de.scrollLeft || b.scrollLeft,
    Etop = gbcr.top + scrollY - de.clientTop,
    Eleft = gbcr.left + scrollX - de.clientLeft;
    return { x: Eleft, y: Etop };
}

function RadComboCheckedAll(sender, args) {}

function showDatePopup(sender, e, atRight) {
    currentTextBox = sender;

    if (currentTextBox.getAttribute("Readonly") == null || currentTextBox.getAttribute("Readonly") == false) {

        var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
        currentDatePicker = datePicker;
        datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
        var position = getPosition(sender);
        datePicker.showPopup((atRight) ? position.x + sender.offsetWidth - 220 : position.x, position.y + sender.offsetHeight);
       
    }
   
}


function getPosition(element) {
    var xPosition = 0;
    var yPosition = 0;
    while (element) {
        xPosition += (element.offsetLeft + element.clientLeft);
        yPosition += (element.offsetTop +  element.clientTop);
        element = element.offsetParent;
    }
    return { x: xPosition, y: yPosition };
}


function dateSelected(sender, args) {
    if (currentTextBox != null) {
        currentTextBox.value = args.get_newValue();
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

/******* Grid Functions *********/
var arrGrids = [];


function GridCreatedFunction(sender, args) {
    var fName = sender.get_element().getAttribute("InitialGridCreatedFunction");
    if (fName != null) {
        window[fName](sender, args);
    }
    var ClientID = sender.ClientID;
    var freezeHeader = sender.get_element().getAttribute("FreezeHeader");
    if (freezeHeader != null) {
        if (freezeHeader == "True") {
            for (var k = 0; k < arrGrids.length; k++) {
                if (arrGrids[k].ClientID == ClientID) {
                    arrGrids.splice(k, 1);
                }
            }
            arrGrids.push({ 'ClientID': ClientID, 'setwidth': true });
            scrollHeader();
            sender.add_columnResized(function () { setHeaderWidth(ClientID); setTimeout(function () { setHeaderWidth(ClientID); }, 2); }); //setTimeout for firefox issue 
            sender.add_columnShown(function () { setHeaderWidth(ClientID); setTimeout(function () { setHeaderWidth(ClientID); }, 2); });
            sender.add_columnHidden(function () { setHeaderWidth(ClientID); setTimeout(function () { setHeaderWidth(ClientID); }, 2); });
            sender.add_columnSwapped(function () { setHeaderWidth(ClientID); setTimeout(function () { setHeaderWidth(ClientID); }, 2); });
            $(window).scroll(scrollHeader);
        }
        else {
            $("[id$=" + ClientID + "]  .rgMasterTable.rgClipCells thead:first>tr").removeClass("fixed");
            for (var k = 0; k < arrGrids.length; k++) {
                if (arrGrids[k].ClientID == ClientID) {
                    arrGrids.splice(k, 1);
                    //delete arrGrids[k];
                    return ;
                  }
            }
        }
    }
}


function scrollHeader() {
    for (var k = 0; k < arrGrids.length; k++) {
        var ClientID = arrGrids[k].ClientID;
        var diff = ($(window).scrollTop() - $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells").offset().top);
        var maxHeight = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells").height() - $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead:first").height();
        if ((diff) > 0 && (diff < maxHeight)) {
            $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead:first>tr").css({ top: diff, left: 0 });
            $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead:first>tr").addClass("fixed");
            if (arrGrids[k].setwidth) {
                arrGrids[k].setwidth = false;
                setHeaderWidth(ClientID);
            }
        } else {
            arrGrids[k].setwidth = true;
            $("[id$=" + ClientID + "]  .rgMasterTable.rgClipCells thead:first>tr").removeClass("fixed");
        }
    }
}


function setHeaderWidth(ClientID) {
   var argHeadWidth = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells")[0].getBoundingClientRect().right - $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells")[0].getBoundingClientRect().left;
    var NumberOfGroups = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells thead:first .rgHeader.rgGroupCol").length;
    $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead:first>tr").css({ width: argHeadWidth });
    $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead:first>tr.rgCommandRow  .rgCommandCell").css({ width: argHeadWidth });
    var th = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead>tr>th");
    var editTd = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead .rgEditRow>td");
    var filterTd = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>thead .rgFilterRow>td");
    var tds = $("[id$=" + ClientID + "] .rgMasterTable.rgClipCells>tbody .rgRow:first td");
    for (var i = 0; i < tds.length  ; i++) {
        var tdwidth = $(tds[i]).width();
        if (filterTd.length > i) {
            $(filterTd[i]).width(tdwidth);
        }
        $(th[i]).width(tdwidth);
        if (editTd.length > i) {
            $(editTd[i]).width(tdwidth);
        }
        if (i >= NumberOfGroups) {
            if (filterTd.length > i) {
                filterTd[i].style.minWidth = tdwidth + 'px';
                filterTd[i].style.maxWidth = tdwidth + 'px';
            }
            if (editTd.length > i) {
                editTd[i].style.minWidth = tdwidth + 'px';
                editTd[i].style.maxWidth = tdwidth + 'px';
            }
        }
            th[i].style.minWidth = tdwidth + 'px';
            th[i].style.maxWidth = tdwidth + 'px';
    }
}
/*****************************************************/


/********Time Picker **********/
//var currentTimeTextBox = null;
//var currentTimePicker = null;
//function showTimePopup(sender, e, atRight) {
//    currentTimeTextBox = sender;

//    if (currentTimeTextBox.getAttribute("Readonly") == null || currentTimeTextBox.getAttribute("Readonly") == false) {

//        var TimePicker = $find($("[id$=RadTimePicker1]")[0].id);
//        currentTimePicker = TimePicker;
//        TimePicker.set_selectedDate(currentTimePicker.get_dateInput().parseTime(sender.value));
//        var position = TimePicker.getElementPosition(sender);
//        TimePicker.showPopup((atRight) ? position.x + sender.offsetWidth - 200 : position.x, position.y + sender.offsetHeight);
//    }
//}
//function TimeSelected(sender, args) {
//    if (currentTimeTextBox != null) {
//        currentTimeTextBox.value = args.get_newValue();
//    }
//}


//function parseTime(sender, e) {
//    if (currentTimePicker != null) {
//        var Time = currentTimePicker.get_dateInput().parseTime(sender.value);
//        var TimeInput = currentTimePicker.get_dateInput();

//        if (Time != null) {
//            var formattedTime = TimeInput.get_dateFormatInfo().FormatTime(Time, TimeInput.get_displayDateFormat());
//            sender.value = formattedTime;
//        }
//        else {
//            sender.value = "";
//        }
//    }
//}