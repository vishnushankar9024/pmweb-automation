$(document).ready(function () {
    $(window).resize(function () {
        RTime = new Date();
        if (RTimeout == false) {
            RTimeout = true;
            setTimeout(WindowResizeEnd, RDelta);
        }
    });

    if ($(".MobileFixedMenu").length == 1)
        $("[id$=divContentHolder]").css({ "margin-bottom":  $(".MobileFixedMenu")[0].clientHeight + "px" });
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

function WindowClosed(Opener) {
    var btnRefreshId = $("a[id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}

function OpenPOPUp(URL, Width, Height, AddClose) {
    var wnd = window.radopen(URL);
    wnd.setSize(Width, Height);
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
    }
    wnd.Center();
    return false;
}

function GetRadWnd() {
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow;

    else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;

    return oWindow;
}

function CloseRadWnd() {
    var oWindow = GetRadWnd();
    oWindow.Close();
    //        window.location.href = "Default.aspx?reason=ST";
}

/*****************************************************************/
function CloseLogOutPopupSave() {
    var btnRefreshId;
    btnRefreshId = $(window.parent.document).find("input[id$=btnLogoutSave]")
    if (btnRefreshId) {
        btnRefreshId.click();
    }
    window.close();
}

function CloseLogOutPopupDelete() {
    var btnRefreshId;
    window.close();
    btnRefreshId = $(window.parent.document).find("input[id$=btnLogoutDelete]")
    if (btnRefreshId) {
        btnRefreshId.click();
    }
}


function RowDblClick(sender, eventArgs) {

    var btnEditSelected = $("a[id*=" + sender.ClientID + "][id$=btnEditSelected]")[0];
    var btnUpdateEdited = $("a[id*=" + sender.ClientID + "][id$=btnUpdateEdited]")[0];

    if (btnEditSelected) { eval(btnEditSelected.href.split(":")[1]); }
    else if (btnUpdateEdited) { eval(btnUpdateEdited.href.split(":")[1]); }
}

function onTabSelecting(sender, args) {
    if (args.get_tab().get_pageViewID()) {
        args.get_tab().set_postBack(false);
    }
}

var arrGrids = [];
function GridCreatedFunction(sender, args) {
    var fName = sender.get_element().getAttribute("InitialGridCreatedFunction");
    if (fName != null) {
        window[fName](sender, args);
    }
    var ClientID = sender.ClientID;
    if (!($("[id=" + ClientID + "]")) || $("[id=" + ClientID + "]").length == 0) return;    
    if (sender.ClientSettings.Scrolling.AllowScroll == false) return;
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].ClientID == ClientID) {
            arrGrids.splice(k, 1);
        }
    }
    var IsVirtual = sender.ClientSettings.Scrolling.EnableVirtualScrollPaging;
    var SumColumnWidth = -1000;
    var FitParentContainer = (sender.get_element().hasAttribute("FitParentContainer") && sender.get_element().getAttribute("FitParentContainer").toLowerCase().trim() == 'true');
    var AttrSetWidth = true;
    var GroupHeaders = $("[id=" + ClientID + "] .rgGroupHeader");
    for (var s = 0; s < GroupHeaders.length; s++) {
        if ($(GroupHeaders[s]).find('>td>div>div>div').length == 0) continue;
        var CurrentEle = $(GroupHeaders[s]).find('>td>div>div>div')[0];
        if ($(CurrentEle).offset().left + CurrentEle.offsetWidth > $(GroupHeaders[s]).offset().left + GroupHeaders[s].offsetWidth) {
            CurrentEle.style.width = ($(GroupHeaders[s]).offset().left + GroupHeaders[s].offsetWidth - $(CurrentEle).offset().left - 10).toString() + 'px';
            CurrentEle.style.textOverflow = 'ellipsis';
            CurrentEle.style.overflow = 'hidden';
        }
    }
    var MasterTable = sender.get_masterTableView();

    arrGrids.push({ 'ClientID': ClientID, 'SetWidth': AttrSetWidth,  'FitParentContainer': FitParentContainer, 'SumColumnWidth': SumColumnWidth, 'IsVirtual': IsVirtual });

    if (AttrSetWidth) {
        ResizeGrid(ClientID, SumColumnWidth, IsVirtual);
        sender.add_columnResized(function () { ResetGridSettings(ClientID); });
        sender.add_columnShown(function () { ResetGridSettings(ClientID); });
        sender.add_columnHiding(GridColumnHiding);
        sender.add_columnHidden(function () { ResetGridSettings(ClientID, true); });
    }
}

function GridColumnHiding(sender, args) {
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].ClientID == sender.ClientID) {
            var SumColumnWidth = arrGrids[k].SumColumnWidth;
            //var Columns = sender.get_masterTableView().get_columns();
            //for (var O = 0; O < Columns.length; O++)
            //    SumColumnWidth = SumColumnWidth + Columns[O].get_element().offsetWidth;
            SumColumnWidth = SumColumnWidth - args.get_gridColumn().get_element().offsetWidth;
            arrGrids[k].SumColumnWidth = SumColumnWidth;
            return;
        }
    }
}

var RTime;
var RTimeout = false;
var RDelta = 100;
var WindowWidth = $(window).width();

function WindowResizeEnd() {
    if (new Date() - RTime < RDelta) {
        setTimeout(WindowResizeEnd, RDelta);
    } else {
        RTimeout = false;
        if (WindowWidth == $(window).width()) return;
        WindowWidth = $(window).width();
        ResizeAllGrids();
        if ($(".MobileFixedMenu").length == 1)
            $("[id$=divContentHolder]").css({ "margin-bottom": $(".MobileFixedMenu")[0].clientHeight + "px" });
    }

}

function ResizeAllGrids() {
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].SetWidth) ResizeGrid(arrGrids[k].ClientID, arrGrids[k].SumColumnWidth, arrGrids[k].IsVirtual);       
    }
}

function ResetGridSettings(ClientID, SkipWidthCalculate) {
    if ($find(ClientID) == null) return;
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].ClientID == ClientID) {
            if (!SkipWidthCalculate)
                arrGrids[k].SumColumnWidth = $find(arrGrids[k].ClientID).get_masterTableView().get_element().offsetWidth;
            if (arrGrids[k].SetWidth)
                ResizeGrid(arrGrids[k].ClientID, arrGrids[k].SumColumnWidth, arrGrids[k].IsVirtual);
            return;
        }
    }
}

function ResizeGrid(ClientID, SumColumnWidth, IsVirtual) {
    if ($("[id=" + ClientID + "]").length == 0) return;
    // set grid width
    var left = $("[id=" + ClientID + "]").offset().left;
    var HasHorScroll = true;
    var screenwidth = document.documentElement.clientWidth;
    var FitParentContainer = ($("[id=" + ClientID + "]")[0].hasAttribute("FitParentContainer") && $("[id=" + ClientID + "]")[0].getAttribute("FitParentContainer").toLowerCase().trim() == 'true');
    if (FitParentContainer) {
        var divEle = $("[id=" + ClientID + "]").parents('div[class*="col-"]');
        var divWidth = divEle[0].clientWidth;
        if (divEle.find(" > .colTable").length > 0)
            //divWidth = divWidth - 24;
        if (divWidth > screenwidth - left || (divWidth > SumColumnWidth && SumColumnWidth > 1)) {
            $("[id=" + ClientID + "]").width(Math.min(screenwidth - left - 5, (SumColumnWidth > 1) ? SumColumnWidth : screenwidth - left - 5));
            if (SumColumnWidth < screenwidth - left - 5 && SumColumnWidth > 1)
                HasHorScroll = false;
        } else
            $("[id=" + ClientID + "]").width(divWidth - 5);
    } else {
        if (screenwidth - left < SumColumnWidth || SumColumnWidth <= 2)
            $("[id=" + ClientID + "]").width(screenwidth - left - 10);
        else {
            $("[id=" + ClientID + "]").width(SumColumnWidth);
            HasHorScroll = false;
        }

    }
    // set grid height
    var GridFixedElementsHeight = 0;
    $("[id=" + ClientID + "]").children().each(function (index) {
        if ($(this).hasClass('rgDataDiv') == false)
            GridFixedElementsHeight += this.offsetHeight;
    });
    var FixedElementsHeight = 50;
    if ($(".MobileFixedMenu").length == 1)
        FixedElementsHeight = FixedElementsHeight + $(".MobileFixedMenu")[0].clientHeight;
   var rgDataDivHeight = document.documentElement.clientHeight - GridFixedElementsHeight - FixedElementsHeight;
   var dataHeight = $("[id=" + ClientID + "] .rgDataDiv > table > tbody ")[0].offsetHeight;
   if (rgDataDivHeight < dataHeight)
       $("[id=" + ClientID + "] .rgDataDiv").height((rgDataDivHeight < 60) ? 50 : rgDataDivHeight - 20);
   else {
       if (IsVirtual)
           $("[id=" + ClientID + "] .rgDataDiv").css('height', dataHeight);
       else
           $("[id=" + ClientID + "] .rgDataDiv").css('height', 'auto');
   }
    if (!HasHorScroll && $("[id=" + ClientID + "] .rgDataDiv")[0].style.height != 'auto')
        $("[id=" + ClientID + "]").width(SumColumnWidth + 20);

    //reset grid width if scroll appears
    if (document.documentElement.clientWidth != screenwidth) {
        setTimeout(function () {
            for (var n = 0; n < arrGrids.length; n++) {
                if (!arrGrids[n].FitParentContainer && arrGrids[n].SetWidth && $("[id=" + arrGrids[n].ClientID + "]").length == 1) {
                    var WidthToSet = document.documentElement.clientWidth - $("[id=" + arrGrids[n].ClientID + "]").offset().left;
                    if (WidthToSet < arrGrids[n].SumColumnWidth || arrGrids[n].SumColumnWidth <= 1)
                        $("[id=" + arrGrids[n].ClientID + "]").width(WidthToSet - 10);
                    else if ($("[id=" + arrGrids[n].ClientID + "] .rgDataDiv")[0].style.height != 'auto')
                        $("[id=" + arrGrids[n].ClientID + "]").width(arrGrids[n].SumColumnWidth + 20);
                    else
                        $("[id=" + arrGrids[n].ClientID + "]").width(arrGrids[n].SumColumnWidth);
                }
            }
        }, 50);
    }
}


function OnGridScroll(sender, args) {
    //$('.rgEditForm').css({ 'margin-left': $('.rgDataDiv').scrollLeft() });
}
function ResizeAllGrids() {
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].SetWidth) ResizeGrid(arrGrids[k].ClientID, arrGrids[k].SumColumnWidth, arrGrids[k].IsVirtual);
        if (arrGrids[k].AppendMenus) {
            if (arrGrids[k].IsSearchDoc)
                AppendSDMenu(arrGrids[k].ClientID);
            else if (arrGrids[k].IsDiv)
                AppendDivMenus(arrGrids[k].ClientID);
            else
                AppendTableMenus(arrGrids[k].ClientID, arrGrids[k].IsWorkOrderSearch);
        }
    }
}

function ResetGridSettings(ClientID, SkipWidthCalculate) {
    if ($find(ClientID) == null) return;
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].ClientID == ClientID) {
            if (!SkipWidthCalculate)
                arrGrids[k].SumColumnWidth = $find(arrGrids[k].ClientID).get_masterTableView().get_element().offsetWidth;
            if (arrGrids[k].SetWidth)
                ResizeGrid(arrGrids[k].ClientID, arrGrids[k].SumColumnWidth, arrGrids[k].IsVirtual);
            if (arrGrids[k].AppendMenus) {
                if (arrGrids[k].IsSearchDoc)
                    AppendSDMenu(arrGrids[k].ClientID);
                else if (arrGrids[k].IsDiv)
                    AppendDivMenus(arrGrids[k].ClientID);
                else
                    AppendTableMenus(arrGrids[k].ClientID, arrGrids[k].IsWorkOrderSearch);
            }
            return;
        }
    }
}
function AppendDivMenus(ClientID) {
    if ($("[id=" + ClientID + "] .rgCommandCell > div").length == 0) return
    //reset grid state
    var Qelement = $("[id=" + ClientID + "] .rgCommandCell > div");
    var div = $("<div></div>");
    var element = Qelement[0];
    if (Qelement.find("[id$=div_more_menu]").length > 0) {
        var menutds = Qelement.find("[id$=div_more_menu] > table > tbody > tr > td");
        for (var j = 0; j < menutds.length; j++) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(menutds[j].children[0]));
        }
    }
    if (Qelement.find("[id$=div_add_more_menu]").length > 0) {
        var menutds = Qelement.find("[id$=div_add_more_menu] > table > tbody > tr > td");
        for (var j = 0; j < menutds.length; j++) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(menutds[j].children[0]));
        }
    }

    Qelement.find("[id$=div_more_menu]").remove();
    Qelement.find("[id$=img_more_menu]").remove();
    Qelement.find("[id$=div_add_more_menu]").remove();
    Qelement.find("[id$=spn_add_more_menu]").remove();


    if (div[0].childElementCount > 0) {
        while (element.childElementCount > 0) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(element.children[0]));
        }

        var Cdivs = div.find("> div");
        var OrderedIndexes = {};
        for (var i = 0; i < Cdivs.length; i++) {
            if (!Cdivs[i].children[0].getAttribute("orderindex") && Cdivs[i].children[0].children[0].getAttribute("orderindex"))
                Cdivs[i].children[0].setAttribute("orderindex", Cdivs[i].children[0].children[0].getAttribute("orderindex"));
            OrderedIndexes[Cdivs[i].children[0].getAttribute("orderindex")] = i;
        }

        Object.keys(OrderedIndexes).sort(function (a, b) {
            return parseInt(a) < parseInt(b) ? -1 : 1;
        }).forEach(function (key) {
            Qelement.append($(Cdivs[OrderedIndexes[key]].children[0]));
        });
    }

    //append menu
    var MenuInvisibleItems = [];
    var AddMenuAdded = false;
    for (var i = 0; i < element.childElementCount; i++) {
        var SType = element.children[i].attributes['SecurityButtonType'] ? element.children[i].attributes['SecurityButtonType'].value : '';
        if (SType && (SType == 'ItemMode_Delete' || SType == 'ItemMode_Add' || SType == 'AddEditMode_Edit' || SType == 'AddEditMode_Add' || SType == 'AddEditMode')) {
            if ($(element.children[i]).offset().left + element.children[i].offsetWidth + 40 > Qelement.offset().left + element.offsetWidth) {
                if (AddMenuAdded) continue;
                i = 0;
                AppendDivAddMenu(ClientID);
                MenuInvisibleItems = [];
                AddMenuAdded = true;
                continue;
            }
        } else if ($(element.children[i]).offset().left + element.children[i].offsetWidth + 40 > Qelement.offset().left + element.offsetWidth)
            if (element.children[i].id != 'div_add_more_menu' && element.children[i].id != 'spn_add_more_menu')
                MenuInvisibleItems.push(element.children[i]);
    }
    if (MenuInvisibleItems.length > 0) {
        var div = $('<div class="div_more_menu Hide" id="div_more_menu" style="position:absolute;background-color:white;border:1px solid gray;z-index: 99;"></div>')
        $(element).append(div);
        var html = $('<a id="img_more_menu" class="img_more_menu" href="#" onclick="return false;"><span id="spn_more_menu"></span></a>');
        $(element).append(html);
        var table = $("<table></table>");
        div.append(table);
        for (var i = 0; i < MenuInvisibleItems.length; i++) {
            var tr = $('<tr></tr>');
            table.append(tr);
            var td = $('<td></td>');
            tr.append(td);
            td.append($(MenuInvisibleItems[i]));
        }
        MenuInvisibleItems = [];
        var AddToMenu = false;
        var htmlmenu = element.children[element.childElementCount - 1];
        while (($(htmlmenu).offset().left + htmlmenu.offsetWidth > Qelement.offset().left + element.offsetWidth) && (element.childElementCount > 2)) {
            var index = element.childElementCount - 3
            var ele = element.children[element.childElementCount - 3];
            while (index > 0) {
                if (element.children[index].id == 'div_add_more_menu' || element.children[index].id == 'spn_add_more_menu' || element.children[index].id == 'img_more_menu' || element.children[index].id == 'div_more_menu') {
                    ele = element.children[index - 1];
                    index = index - 1;
                } else
                    index = 0;
            }
            if (ele.id == 'div_add_more_menu' || ele.id == 'spn_add_more_menu' || ele.id == 'img_more_menu' || ele.id == 'div_more_menu') return;
            var tr = $('<tr></tr>');
            table.append(tr);
            var td = $('<td></td>');
            tr.append(td);
            td.append($(ele));
        }
    }
}

function AppendDivAddMenu(ClientID) {
    var Addelement = $("[id=" + ClientID + "] .rgCommandCell > div")[0];
    var AddMenuItems = [];
    var firstAddItem;
    for (var z = 0; z < Addelement.childElementCount; z++) {
        var SType = Addelement.children[z].attributes['SecurityButtonType'] ? Addelement.children[z].attributes['SecurityButtonType'].value : '';
        if (SType && SType == 'ItemMode_Add') {
            if (!firstAddItem) firstAddItem = Addelement.children[z];
            AddMenuItems.push(Addelement.children[z]);
        }
    }

    if (AddMenuItems.length > 1) {
        var Adddiv = $('<div class="div_add_more_menu Hide" id="div_add_more_menu" style="position:absolute;background-color:white;border:1px solid gray;z-index: 99;"></div>')
        $(Addelement).append(Adddiv);
        var Addhtml = $('<a id="spn_add_more_menu" class="spn_add_more_menu" style="vertical-align: middle;display: inline-block;">' +
                             '<span>' +
                                 '<span title="Add" class="spn_add_more_menu_icon"></span>' +
                                 '<span class="spn_add_more_menu_text">Add</span>' +
                             '</span>' +
                             '<span class="spn_add_more_menu_arrow"></span>' +
                         '</a>');
        if (firstAddItem)
            Addhtml.insertAfter($(firstAddItem));
        else
            $(Addelement).prepend(Addhtml);

        var Addtable = $("<table></table>");
        Adddiv.append(Addtable);
        for (var z = 0; z < AddMenuItems.length; z++) {
            var Addtr = $('<tr></tr>');
            Addtable.append(Addtr);
            var Addtd = $('<td></td>');
            Addtr.append(Addtd);
            Addtd.append($(AddMenuItems[z]));
        }
    }
}


function AppendTableMenus(ClientID, IsWorkOrderSearch) {
    var Qelement
    if (IsWorkOrderSearch)
        Qelement = $("[id=" + ClientID + "] .rgCommandCell > div [id$=tblDropDownLists] > table > tbody > tr");
    else
        Qelement = $("[id=" + ClientID + "] .rgCommandCell > table > tbody > tr");
    if (Qelement.length == 0) return;
    //reset grid state
    var div = $("<div></div>");
    var element = Qelement[0];
    if ($("[id=" + ClientID + "] [id$=div_more_menu]").length > 0) {
        var menutds = $("[id=" + ClientID + "] [id$=div_more_menu] > table > tbody > tr");
        for (var j = 0; j < menutds.length; j++) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(menutds[j].children[0]));
        }
    }

    $("[id=" + ClientID + "] [id$=div_more_menu]").remove();
    Qelement.find("[id$=td_more_menu]").remove();

    if (div[0].childElementCount > 0) {
        while (element.childElementCount > 0) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(element.children[0]));
        }

        var Cdivs = div.find("> div");
        var OrderedIndexes = {};
        for (var i = 0; i < Cdivs.length; i++) {
            if (!Cdivs[i].children[0].getAttribute("orderindex") && Cdivs[i].children[0].children[0].getAttribute("orderindex"))
                Cdivs[i].children[0].setAttribute("orderindex", Cdivs[i].children[0].children[0].getAttribute("orderindex"));
            OrderedIndexes[Cdivs[i].children[0].getAttribute("orderindex")] = i;
        }

        Object.keys(OrderedIndexes).sort(function (a, b) {
            return parseInt(a) < parseInt(b) ? -1 : 1;
        }).forEach(function (key) {
            Qelement.append($(Cdivs[OrderedIndexes[key]].children[0]));
        });
    }

    //append menu
    var MenuInvisibleItems = [];
    var CommandRow = $("[id=" + ClientID + "] .rgCommandRow");
    for (var i = 0; i < element.childElementCount; i++) {
        if (element.children[i].childElementCount == 0) continue;
        if ($(element.children[i]).offset().left + element.children[i].offsetWidth + 40 > CommandRow.offset().left + CommandRow[0].offsetWidth)
            if (element.children[i].id != 'td_more_menu' && element.children[i].id != 'div_more_menu')
                MenuInvisibleItems.push(element.children[i]);
    }
    if (MenuInvisibleItems.length > 0) {
        var td = $('<td class="td_more_menu" id="td_more_menu"></td>');
        var div = $('<div class="div_more_menu Hide" id="div_more_menu" style="position:absolute;background-color:white;border:1px solid gray;z-index: 99;"></div>');
        var html = $('<a id="img_more_menu" class="img_more_menu" href="#" onclick="return false;"><span id="spn_more_menu"></span></a>');
        $("[id=" + ClientID + "] .rgCommandCell").append(div);
        td.append(html);
        Qelement.append(td);
        var table = $("<table></table>");
        div.append(table);
        for (var i = 0; i < MenuInvisibleItems.length; i++) {
            var tr = $('<tr></tr>');
            table.append(tr);
            tr.append($(MenuInvisibleItems[i]));
        }
    }
}


function AppendSDMenu(ClientID) {
    if ($("[id=" + ClientID + "] .rgCommandCell > div [id$=tblDropDownLists]").length == 0) return
    //reset grid state
    var Qelement = $("[id=" + ClientID + "] .rgCommandCell > div [id$=tblDropDownLists] > table > tbody > tr");
    var div = $("<div></div>");
    if ($("[id=" + ClientID + "] [id$=div_more_menu]").length > 0) {
        var menutds = $("[id=" + ClientID + "] [id$=div_more_menu] > table > tbody > tr");
        for (var j = 0; j < menutds.length; j++) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(menutds[j].children[0]));
        }
    }

    $("[id=" + ClientID + "] [id$=div_more_menu]").remove();
    $("[id=" + ClientID + "] [id$=td_more_menu]").remove();
    $("[id=" + ClientID + "] [id$=empty_td]").remove();

    if (div[0].childElementCount > 0) {
        if (div.find(".SearchDoctdComboFilters").length > 0)
            $("[id=" + ClientID + "] .rgCommandCell > div [id$=tblDropDownLists]").after(div.find(".SearchDoctdComboFilters"));
        if (div.find(".SearchDoctdLayout").length > 0)
            $("[id=" + ClientID + "] .rgCommandCell > div .SearchDoctdRefresh").after(div.find(".SearchDoctdLayout"));
        var Cdivs = div.find("> div");
        var OrderedIndexes = {};
        for (var i = 0; i < Cdivs.length; i++) {
            if (Cdivs[i].childElementCount == 0) continue;
            if (!Cdivs[i].children[0].getAttribute("orderindex") && Cdivs[i].children[0].children[0].getAttribute("orderindex"))
                Cdivs[i].children[0].setAttribute("orderindex", Cdivs[i].children[0].children[0].getAttribute("orderindex"));
            OrderedIndexes[Cdivs[i].children[0].getAttribute("orderindex")] = i;
        }

        Object.keys(OrderedIndexes).sort(function (a, b) {
            return parseInt(a) < parseInt(b) ? -1 : 1;
        }).forEach(function (key) {
            Qelement.append($(Cdivs[OrderedIndexes[key]].children[0]));
        });
    }

    //append menu
    var MenuInvisibleItems = [];
    var CommandeCell = $("[id=" + ClientID + "] .rgCommandCell");
    var left = $("[id=" + ClientID + "]").offset().left;
    var screenwidth = document.documentElement.clientWidth;
    var element = $("[id=" + ClientID + "] .rgCommandCell > div > table > tbody > tr")[0];
    for (var i = 0; i < element.childElementCount; i++) {
        if (element.children[i].childElementCount == 0) continue;
        if ($(element.children[i]).offset().left + element.children[i].offsetWidth - 10 > screenwidth - 5) {
            for (var j = 0; j < Qelement[0].childElementCount; j++) {
                MenuInvisibleItems.push(Qelement[0].children[j]);
            }
            if ($(".SearchDoctdComboFilters").length > 0)
                MenuInvisibleItems.push($(".SearchDoctdComboFilters")[0]);
            Qelement.append($('<td id="empty_td"></td>'))
            break;
        }
    }
    if (MenuInvisibleItems.length > 0) {
        var td = $('<td class="td_more_menu" id="td_more_menu"></td>');
        var div = $('<div class="div_more_menu Hide SD_div_more_menu" id="div_more_menu" style="position:absolute;background-color:white;border:1px solid gray;z-index: 99;"></div>');
        var html = $('<a id="img_more_menu" class="img_more_menu" href="#" onclick="return false;"><span id="spn_more_menu"></span></a>');
        $("[id=" + ClientID + "] .rgCommandCell").append(div);
        td.append(html);
        $("[id=" + ClientID + "] .rgCommandCell > div > table > tbody > tr").append(td);
        var table = $("<table></table>");
        div.append(table);
        for (var i = 0; i < MenuInvisibleItems.length; i++) {
            var tr = $('<tr></tr>');
            table.append(tr);
            tr.append($(MenuInvisibleItems[i]));
        }
        if ($(".SearchDoctdLayout").length > 0) {
            for (var i = 0; i < element.childElementCount; i++) {
                if (element.children[i].childElementCount == 0) continue;
                if ($(element.children[i]).offset().left + element.children[i].offsetWidth + 40 > screenwidth - 5) {
                    var tr = $('<tr></tr>');
                    table.append(tr);
                    tr.append($("[id=" + ClientID + "] .rgCommandCell > div .SearchDoctdLayout"));
                    break;
                }
            }
        }
    }
}

var MobileScreenWidth = 1024;
function isMobileScreen() {
    var browserWidth = $telerik.$(window).width();
    if (browserWidth <= MobileScreenWidth)
        return true;
    return false;
}

function OpenPOPUpToRedirect(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var popupwidth = browserWidth - 50;
    var popupHeight = browserHeight - 50;
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(popupwidth, popupHeight);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(Width, Height);
        wnd.Center();
    }
    //wnd.add_close(RedirectAfterClosed);
    return false;
}