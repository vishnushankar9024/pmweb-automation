/********* Chrome Zoom/Scroll Error *****************/
var MobileScreenWidth = 1024;
$(document).ready(function () {

    if (typeof $telerik != "undefined") {
        $telerik.getViewPortSize = function () {
            var width = 0;
            var height = 0;

            var canvas = document.body; 

            if ((!$telerik.quirksMode && !$telerik.isSafari) ||
                (Telerik.Web.Browser.chrome && Telerik.Web.Browser.version >= 61)) {
                canvas = document.documentElement;
            }

            if (window.innerWidth) {
                width = Math.max(document.documentElement.clientWidth, document.body.clientWidth);
                height = Math.max(document.documentElement.clientHeight, document.body.clientHeight);

                if (width > window.innerWidth)
                    width = document.documentElement.clientWidth;
                if (height > window.innerHeight)
                    height = document.documentElement.clientHeight;
            }
            else {
                width = canvas.clientWidth;
                height = canvas.clientHeight;
            }

            width += canvas.scrollLeft;
            height += canvas.scrollTop;

            if ($telerik.isMobileSafari) {
                width += window.pageXOffset;
                height += window.pageYOffset;
            }

            return { width: width - 6, height: height - 6 };
        }
    }
    if (typeof (Telerik) !== 'undefined') {
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
        if (Telerik.Web.UI.RadPane != null) {
            Telerik.Web.UI.RadPane.prototype.saveClientState = function () {
                if (this.get_isUpdating())
                    return null;
                var f = this.getScrollPos();
                var g = { _originalWidth: this._originalWidth, _originalHeight: this._originalHeight, _collapsedDirection: this._collapsedDirection, _scrollLeft: Math.round(f.left), _scrollTop: Math.round(f.top), _expandedSize: this._expandedSize };
                var d = ["width", "height", "collapsed", "contentUrl", "minWidth", "maxWidth", "minHeight", "maxHeight", "locked"];
                for (var b = 0, c = d.length; b < c; b++) {
                    var e = d[b];
                    g[e] = this["get_" + e]();
                }
                return Sys.Serialization.JavaScriptSerializer.serialize(g);
            }
        }
    }

    $($('body')[0]).click(function (e) {
        var q = e.target;
        var s = $(q);
        var targetid = e.target.id;
        if ((($(q).parents('[id$=div_more_menu]').length > 0 || targetid.indexOf('div_more_menu') >= 0) && (s.parents('[id$=spn_exchange_more_menu]').length == 0 && targetid.indexOf('spn_exchange_more_menu') < 0))
            || $(q).parents('[id$=div_add_more_menu]').length > 0 || targetid.indexOf('div_add_more_menu') >= 0
            || $(q).parents('[id$=div_exchange_more_menu]').length > 0 || targetid.indexOf('div_exchange_more_menu') >= 0)
            return;
        if (targetid.indexOf('spn_more_menu') >= 0 || targetid.indexOf('img_more_menu') >= 0) {
            var div = $(q).parents('.rgCommandCell').find("[id$=div_more_menu]");
            if (div.hasClass("Hide")) {
                var html;
                var ParentElementLeft = 0;
                if ($(q).parents('.rgCommandCell').find("[id$=td_more_menu]").length > 0)
                    html = $(q).parents('.rgCommandCell').find("[id$=td_more_menu]");
                else
                    html = $(q).parents('.rgCommandCell').find("[id$=img_more_menu]");
                div.removeClass("Hide");
                var LeftPosit = html.position().left - div[0].offsetWidth + 39;
                if (LeftPosit < 0)
                    LeftPosit = 0;
                div.css({
                    left: LeftPosit + 'px' // 10 for padding and 24 for image size.
                });
            } else
                $("[id$=div_more_menu]").addClass("Hide");
            $("[id$=div_exchange_more_menu]").addClass("Hide");
        } else {
            if (s.parents('[id$=spn_exchange_more_menu]').length > 0 || targetid.indexOf('spn_exchange_more_menu') >= 0) {
                var div = $(q).parents('.rgCommandCell').find("[id$=div_exchange_more_menu]");
                var left = 0;
                var top = 0;
                var right = 0;
                if (div.parents(".div_more_menu").length == 0)
                    $("[id$=div_more_menu]").addClass("Hide");
                if (div.hasClass("Hide")) {
                    var html = $(q).parents('.rgCommandCell').find("[id$=spn_exchange_more_menu]");
                    div.removeClass("Hide");
                    if (div.parents(".div_more_menu").length > 0) {
                        top = -4
                        var MoreMenu = div.parents(".div_more_menu");
                        var rgCommandCellDiv = div.parents(".rgCommandCell").find(" > div");
                        if (MoreMenu.offset().left + MoreMenu[0].offsetWidth + div[0].offsetWidth < rgCommandCellDiv.offset().left + rgCommandCellDiv[0].offsetWidth)
                            left = div.parents(".div_more_menu")[0].offsetWidth - 8;
                        else {
                            if (div[0].offsetWidth + 8 > MoreMenu.offset().left + rgCommandCellDiv.offset().left) {
                                right = div.parents(".div_more_menu")[0].offsetWidth - div[0].offsetWidth - 5.5;
                                if (right < 0) right = 0;
                                top = html[0].offsetHeight;
                            } else
                                left = -div[0].offsetWidth - 8;
                        }
                    } else
                        top = html[0].offsetHeight;
                    if (right > 0) {
                        div.css({
                            right: right + 'px',
                            top: top + 'px',
                        });
                    } else {
                        div.css({
                            left: left + 'px',
                            top: top + 'px'
                        });
                    }
                } else
                    $("[id$=div_exchange_more_menu]").addClass("Hide");
            } else {
                $("[id$=div_exchange_more_menu]").addClass("Hide");
                $("[id$=div_more_menu]").addClass("Hide");
            }
        }

        if (s.parents('[id$=spn_add_more_menu]').length > 0 || targetid.indexOf('spn_add_more_menu') >= 0) {
            var div = $(q).parents('.rgCommandCell').find("[id$=div_add_more_menu]");
            if (div.hasClass("Hide")) {
                var html = $(q).parents('.rgCommandCell').find("[id$=spn_add_more_menu]");
                div.removeClass("Hide");
                div.css({
                    left: html.position().left - 5 + 'px' //3 for table border spacing 
                });
            } else
                $("[id$=div_add_more_menu]").addClass("Hide");
        } else
            $("[id$=div_add_more_menu]").addClass("Hide");
    });

    $(window).resize(function () {
        RTime = new Date();
        if (RTimeout == false) {
            RTimeout = true;

            setTimeout(TelerikWindowResizeEnd, RDelta);
        }
    });

});

var LayoutColsOnWindowResize = true;
var MainPages = [];
var ColHeights = [];
var ColsInitialState = [];
function PMPageLoad() {
    var TableElem = document.querySelectorAll('.colTable');
    var arrTables = Array.prototype.slice.call(TableElem);
    for (var t = 0; t < arrTables.length; t++) {
        var TableDisplayprop = getComputedStyle(arrTables[t])['display'];
        if (TableDisplayprop && TableDisplayprop == 'none') continue;
        var JQArrTables = $(arrTables[t]);
        var skip = false;
        if (typeof getComputedStyle === 'function'){
            var CurrTableParents = JQArrTables.parents();
            for (s = 0; s < CurrTableParents.length; s++) {
                var displayprop = getComputedStyle(CurrTableParents[s])['display'];
                if (displayprop && displayprop == 'none') {
                    skip = true;
                    break;
                }
            }
        }
        if (skip) continue;
        var trs = JQArrTables.find('> tbody > tr');
        var arrTr = Array.prototype.slice.call(trs);
        for (var i = 0; i < arrTr.length; i++) {
            var CurrTr = arrTr[i];
            var ToHide = true;
            for (j = 0; j < CurrTr.childElementCount ; j++) {
                var CurrTd = CurrTr.children[j];
                var tdHeight = 0;
                for (k = 0; k < CurrTd.childElementCount ; k++) {
                    tdHeight = tdHeight + CurrTd.children[k].offsetHeight;
                }
                if (CurrTd.innerHTML.trim() !== "" && tdHeight >= 5) {
                    ToHide = false;
                    break;
                }
            }
            if (ToHide)
                CurrTr.style.display = 'none';
        }
    }

    $("[id=DisableAllControlsOnPostback]").addClass("Hide");
    FloatDivs(true, true);
    setTimeout(ResizeAllGrids, 50);
    if (typeof (ResizeObserver) !== typeof undefined) {
        if ($('.R3Cols .col-4').length > 0 || $('.PMMainPage').length > 0) {
            var observer = new ResizeObserver(function (e) {
                if ($(e[0].target).parent('.row').length >0) {
                    var rowId = $(e[0].target).parent('.row')[0].getAttribute("pmid");
                    if (typeof (ColHeights[rowId]) !== typeof undefined &&
                           ((e[0].target.className.indexOf("col-4-left") >= 0 && ColHeights[rowId].LeftHeight != e[0].target.offsetHeight) ||
                            (e[0].target.className.indexOf("col-4-mid") >= 0 && ColHeights[rowId].MiddleHeight != e[0].target.offsetHeight) ||
                            (e[0].target.className.indexOf("col-4-right") >= 0 && ColHeights[rowId].RightHeight != e[0].target.offsetHeight))
                        )
                        AdjustCols(rowId);
                }
            });
            var observer1 = new ResizeObserver(function (e) {
                if (e[0].target.getAttribute("pmid") != null && typeof (MainPages[e[0].target.getAttribute("pmid")]) !== typeof undefined){
                    if (MainPages[e[0].target.getAttribute("pmid")].width != e[0].target.offsetWidth) {
                        FloatDivs(false);
                    }
                }
            });
            for (i = 0 ; i < $('.R3Cols .col-4').length; i++) {
                observer.observe($('.R3Cols .col-4')[i]);
            }
            for (i = 0 ; i < $('.PMMainPage').length; i++) {
                observer1.observe($('.PMMainPage')[i]);
            }
        }
        LayoutColsOnWindowResize = false;
    } else if (typeof (MutationObserver) !== typeof undefined) {
        if ($('.R3Cols .col-4-middle .Validator,.R3Cols .col-4-left .Validator').length > 0) {
            var Validators = $('.R3Cols .col-4-middle .Validator,.R3Cols .col-4-left .Validator');
            var observer = new MutationObserver(function (mutations) {
                AdjustCols($(mutations[0].target).parents('.row')[0].getAttribute("pmid"));
            });
            var config = { attributes: true };
            for (i = 0; i < Validators.length ; i++)
                observer.observe(Validators[i], config);
        }
    }

    /********Rotator******/
    $('.Rotatornext').click(function () { shiftSlide(-1) });
    $('.Rotatorprev').click(function () {; shiftSlide(1) });
    /***********************/
}

function DisableCostCodeLinks() {
    $("[id$=hplCostCode]").each(function () {
        this.removeAttribute("onclick");
    }).removeClass("Link").css("cursor", "default");
}

function AppendDivClasses(PmMainPageId, rowId) {
    var PmMainPage = $("[pmid=" + PmMainPageId + "]");
    var row = $("[pmid=" + rowId + "]");
    var rowWidth = row[0].getBoundingClientRect().width;
    if (row.hasClass("row-NotesPopup")) {
        var div560 = row.find("> div.col-560");
        var div4 = row.find("> div.col-4");
        div560.removeClass("RrightGutterCalc560 ").removeClass("R0Gutter").removeClass("Width400");
        if (rowWidth < 984 && rowWidth >= 900) {
            div560.addClass("R0Gutter");
            div560.addClass("RrightGutterCalc560");
        } else if (rowWidth < 900) {
            div560.addClass("R0Gutter");
        }
    } else if (row.hasClass("row-8-4-fit4")) {
        var LastDiv = row.find("> div:last-child");
        var div4 = row.find("> div.col-4");
        var div8 = row.find("> div.col-8");
        LastDiv.removeClass("R24Gutter").removeClass("R0Gutter").removeClass("R24Top");
        div4.removeClass("col-4-fit").removeClass("RColFitPageSize");
        div8.removeClass("RColFitPageSize");
        if (rowWidth > 1248) {
            LastDiv.addClass("R24Gutter");
            div4.addClass("col-4-fit");
        } else {
            LastDiv.addClass("R0Gutter");
            div4.addClass("RColFitPageSize");
            div8.addClass("RColFitPageSize")
            if (LastDiv.hasClass('AddTopPadWhenUnfit'))
                LastDiv.addClass("R24Top");
        }
    } else if (row.hasClass("row-8-4-fit8")) {
        var LastDiv = row.find("> div:last-child");
        var div8 = row.find("> div.col-8");
        LastDiv.removeClass("R24Gutter").removeClass("R0Gutter").removeClass("R24Top");
        div8.removeClass("col-8-fit").removeClass("RColFitPageSize");
        if (rowWidth > 824) {
            LastDiv.addClass("R24Gutter");
            div8.addClass("col-8-fit");
        } else {
            LastDiv.addClass("R0Gutter");
            div8.addClass("RColFitPageSize");
            if (LastDiv.hasClass('AddTopPadWhenUnfit'))
                LastDiv.addClass("R24Top");
        }
    } else if (row.hasClass("row-8-4")) {
        var LastDiv = row.find("> div:last-child");
        var div8 = row.find("> div.col-8");
        LastDiv.removeClass("R0Gutter").removeClass("R24Top").removeClass("R24rightGutter").removeClass("R8Gutter");
        div8.removeClass("RColFitPageSize").removeClass("R808width");
        if (rowWidth < 1216 && LastDiv.find(".RadGrid").length > 0 && LastDiv.find("fieldset").length == 0)
            LastDiv.addClass("R24Top");
        if (rowWidth < 1248 && rowWidth >= 1216) {
            LastDiv.addClass("R8Gutter");
            div8.addClass("R808width");
        } else if (rowWidth < 1216 && rowWidth >= 850) {
            LastDiv.addClass("R0Gutter");
        } else if (rowWidth < 850) {
            LastDiv.addClass("R0Gutter");
            div8.addClass("RColFitPageSize");
        }
        if ($('body').height() > $(window).height()) {
            if (!LastDiv.hasClass("VerticalScrollbarGutter"))
            LastDiv.addClass("VerticalScrollbarGutter")

        } else {
            LastDiv.removeClass("VerticalScrollbarGutter")
        }
        setTimeout(function () {
            if ($('body').height() > $(window).height()) {
                if(!LastDiv.hasClass("VerticalScrollbarGutter"))
                 LastDiv.addClass("VerticalScrollbarGutter")

        } else {
            LastDiv.removeClass("VerticalScrollbarGutter")
        }},150)
        
     
    } else if (row.hasClass("row-6-5")) {
        var LastDiv = row.find("> div:last-child");
        LastDiv.removeClass("R0Gutter").removeClass("R24rightGutter");
        if (rowWidth < 1124 && rowWidth >= 1099)
            LastDiv.addClass("R0Gutter").addClass("R24rightGutter");
        else if (rowWidth < 1099)
            LastDiv.addClass("R0Gutter");
    } else {
        if (!row.hasClass("R3Cols")) {
            row.removeClass("Cols2").removeClass("R0MinWidth");
            var RightElem = row.find("> div.col-4-right");
            RightElem.removeClass("R24Gutter").removeClass("RrightGutterCalc").removeClass("R8Gutter").removeClass("R0Gutter").removeClass("R24rightGutter").removeClass("R24Top");
            if (row.find("> div.col-4").length == 0) return;
            if (rowWidth < 1216 && rowWidth >= 850) {
                row.addClass("Cols2");
                RightElem.addClass("R24Gutter");
                if (window.location.pathname.indexOf("Notification.aspx") < 0 && window.location.pathname.indexOf("Notificationlog.aspx") < 0)
                    RightElem.addClass("RrightGutterCalc");
            } else if (rowWidth < 850 && rowWidth >= 808) {
                row.addClass("Cols2");
                RightElem.addClass("R8Gutter");
            } else if (rowWidth < 808 && rowWidth >= 500) {
                if (RightElem.hasClass("col-4-TopPadding"))
                    RightElem.addClass("R24Top");
                RightElem.addClass("R0Gutter").addClass("R24rightGutter");
            } else if (rowWidth < 500) {
                if (RightElem.hasClass("col-4-TopPadding"))
                    RightElem.addClass("R24Top");
                RightElem.addClass("R0Gutter");
            }
            if (PmMainPage.hasClass("PMPopupMainPage") && PmMainPage.parents(".popupDiv").length > 0 && rowWidth < 424)
                row.addClass("R0MinWidth");
        } else {
            var Cols3Size = 1200;
            var Cols2Size = 800;
            var Cols1Size = 500;
            var RightElem = row.find("> div.col-4-right");
            var MiddleElem = row.find("> div.col-4-middle");
            var Gutter = "R8Gutter";
            row.removeClass("Cols2").removeClass("R0MinWidth");
            RightElem.removeClass("R24Gutter").removeClass("R8Gutter").removeClass("Order3").removeClass("Order2").removeClass("R0Gutter").removeClass("RrightGutterCalc").removeClass("R24rightGutter").removeClass("rleftCalc");
            MiddleElem.removeClass("R24Gutter").removeClass("R8Gutter").removeClass("Order3").removeClass("Order2").removeClass("R0Gutter").removeClass("RrightGutterCalc").removeClass("R24rightGutter").removeClass("rleftCalc");
            if (row.hasClass("row-4-5-4")) {
                Cols3Size = 1300;
                Cols2Size = 900;
                Cols1Size = 600;
            }
            if (rowWidth >= Cols3Size + 48) {
                if (PmMainPage.hasClass("PMPopupMainPage"))
                    Gutter = "R24Gutter";
                MiddleElem.addClass(Gutter);
                RightElem.addClass(Gutter);
            } else if (rowWidth < Cols3Size + 48 && rowWidth >= Cols3Size + 16) {
                MiddleElem.addClass("R8Gutter");
                RightElem.addClass("R8Gutter");
            } else if (rowWidth < Cols3Size + 16 && rowWidth >= Cols2Size + 50) {
                row.addClass("Cols2");
                MiddleElem.addClass("R24Gutter").addClass("Order3");
                RightElem.addClass("R24Gutter").addClass("Order2");
                if (!row.hasClass("row-2Cols-Justified")) {
                    MiddleElem.addClass("RrightGutterCalc");
                    RightElem.addClass("RrightGutterCalc");
                }
            } else if (rowWidth < Cols2Size + 50 && rowWidth >= Cols2Size + 8) {
                row.addClass("Cols2");
                MiddleElem.addClass("R8Gutter").addClass("Order3");
                RightElem.addClass("R8Gutter").addClass("Order2").addClass("rleftCalc");
            } else if (rowWidth < Cols2Size + 8 && rowWidth >= Cols1Size) {
                MiddleElem.addClass("R0Gutter").addClass("R24rightGutter");
                RightElem.addClass("R0Gutter").addClass("R24rightGutter");
            } else if (rowWidth < Cols1Size) {
                MiddleElem.addClass("R0Gutter");
                RightElem.addClass("R0Gutter");
            }
            if (PmMainPage.hasClass("PMPopupMainPage") && PmMainPage.parents(".popupDiv").length > 0 && rowWidth < 424)
                row.addClass("R0MinWidth");
        }
    }
}

function FloatDivs(onLoad, resetAll) {
    var PmMainPages = $(".PMMainPage");
    MainPages = [];
    for (j = 0; j < PmMainPages.length; j++) {
        var PmMainPage = $(PmMainPages[j]);
        PmMainPages[j].setAttribute("pmid", "PmMainPage_" + j);
        MainPages["PmMainPage_" + j] = {width:PmMainPages[j].offsetWidth , height:PmMainPages[j].offsetHeight};
        var rows = PmMainPage.find("> .row");
        for (i = 0; i < rows.length; i++) {
       
            rows[i].setAttribute("pmid", "PMRow_" + j.toString() + "_" + i.toString());          
            var row = $(rows[i]);
            var MaxHeight = 0;
            var LeftHeight = 0;
            var MiddleHeight = 0;
            var RightHeight = 0;
            var MaxIndex = 0;
            var LeftElem = row.find("> div.col-4-left");
            var MiddleElem = row.find("> div.col-4-middle");
            var RightElem = row.find("> div.col-4-right");
            if (resetAll) {
                PmMainPage.removeClass("JustifyContent");
                if (row.find("> div.col-4").length == 3) {
                    if (ColsInitialState["PMRow_" + j.toString() + "_" + i.toString()] == null) {
                        ColsInitialState["PMRow_" + j.toString() + "_" + i.toString()] = { 'left': LeftElem[0].className, 'middle': MiddleElem[0].className, 'right': RightElem[0].className}
                    } else {
                        row.find("> div.col-4")[0].className = ColsInitialState["PMRow_" + j.toString() + "_" + i.toString()].left;
                        row.find("> div.col-4")[1].className = ColsInitialState["PMRow_" + j.toString() + "_" + i.toString()].middle;
                        row.find("> div.col-4")[2].className = ColsInitialState["PMRow_" + j.toString() + "_" + i.toString()].right;
                    }
                    RightElem.css("left", 0);
                    RightElem.css("top", 0);
                    LeftElem = row.find("> div.col-4-left");
                    MiddleElem = row.find("> div.col-4-middle");
                    RightElem = row.find("> div.col-4-right");
                    row.removeClass("Cols2").removeClass("R0MinWidth");
                    if (!PmMainPage.hasClass("PMPopupMainPage"))
                        row.addClass("JustifyContent");
                    row.addClass("R3Cols");
                }
            }
            row.css("height", "");
            if (!row.hasClass("R3Cols")) {
                RightElem.css("top", 0);
                RightElem.css("left", 0);
                AppendDivClasses(PmMainPages[j].getAttribute("pmid"), rows[i].getAttribute("pmid"))
                continue;
            }
            LeftHeight = LeftElem[0].offsetHeight;
            MaxHeight = LeftHeight;
            MiddleHeight = MiddleElem[0].offsetHeight;
            if (MiddleHeight > MaxHeight) {
                MaxHeight = MiddleHeight;
                MaxIndex = 1;
            }
            RightHeight = RightElem[0].offsetHeight;
            if (RightHeight > MaxHeight) {
                MaxHeight = RightHeight;
                MaxIndex = 2;
            }
            if (resetAll && row.hasClass("R3Cols") && !(PmMainPage.hasClass("PMPopupMainPage"))) {
                if (LeftHeight < 20) {
                    LeftElem.addClass("Hide");
                    row.removeClass("R3Cols");
                    row.removeClass("JustifyContent");
                    $(".ShowInHeaderWhenFit").removeClass("Responsive");
                    if (MiddleHeight < 20) {
                        MiddleElem.addClass("Hide");
                        LeftElem.removeClass("col-4-left").addClass("col-4-right");
                        RightElem.removeClass("col-4-right").addClass("col-4-left");
                    }
                    else {
                        LeftElem.removeClass("col-4-left").addClass("col-4-middle");
                        MiddleElem.removeClass("col-4-middle").addClass("col-4-left");
                    }
                } else if (MiddleHeight < 20) {
                    MiddleElem.addClass("Hide")
                    row.removeClass("JustifyContent");
                    row.removeClass("R3Cols");
                    $(".ShowInHeaderWhenFit").removeClass("Responsive");
                    if (RightHeight < 20)
                        RightElem.addClass("Hide");
                } else if (RightHeight < 20) {
                    RightElem.addClass("Hide");
                    row.removeClass("JustifyContent");
                    row.removeClass("R3Cols");
                    $(".ShowInHeaderWhenFit").removeClass("Responsive");
                    MiddleElem.removeClass("col-4-middle").addClass("col-4-right");
                    RightElem.removeClass("col-4-right").addClass("col-4-middle");
                }
            }
            AppendDivClasses(PmMainPages[j].getAttribute("pmid"), rows[i].getAttribute("pmid"));
            AdjustCols(rows[i].getAttribute("pmid"));         
        }
    }

}

function AdjustCols(rowId) {
    var row = $("[pmid=" + rowId + "]");
    if (row.hasClass("R3Cols")) {
        var MaxHeight = 0;
        var LeftHeight = 0;
        var MiddleHeight = 0;
        var RightHeight = 0;
        var MaxIndex = 0;
        var LeftElem = row.find("> div.col-4-left");
        var MiddleElem = row.find("> div.col-4-middle");
        var RightElem = row.find("> div.col-4-right");
        LeftHeight = LeftElem[0].offsetHeight;
        MaxHeight = LeftHeight;
        MaxIndex = 0;
        MiddleHeight = MiddleElem[0].offsetHeight;
        if (MiddleHeight > MaxHeight) {
            MaxHeight = MiddleHeight;
            MaxIndex = 1;
        }
        RightHeight = RightElem[0].offsetHeight;
        if (RightHeight > MaxHeight) {
            MaxHeight = RightHeight;
            MaxIndex = 2;
        }
        ColHeights[rowId] = { LeftHeight: LeftHeight, MiddleHeight: MiddleHeight, RightHeight: RightHeight };
        var trResponsive = $("[id=trResponsive]");
        if (trResponsive.length == 1 && $("[id$=dvTotals]")[0].offsetHeight > 25) {
            if (RightElem.position().top > LeftElem.position().top + 25)
                LeftElem.append(trResponsive);
            else
                MiddleElem.prepend(trResponsive);

            LeftHeight = LeftElem[0].offsetHeight;
            MaxHeight = LeftHeight;
            MaxIndex = 0;
            MiddleHeight = MiddleElem[0].offsetHeight;
            if (MiddleHeight > MaxHeight) {
                MaxHeight = MiddleHeight;
                MaxIndex = 1;
            }
            RightHeight = RightElem[0].offsetHeight;
            if (RightHeight > MaxHeight) {
                MaxHeight = RightHeight;
                MaxIndex = 2;
            }
        }
        if (RightElem.position().top > LeftElem.position().top + 25) {
            if ((MiddleElem.position().top > LeftElem.position().top + 25)) {
                RightElem.css("top", 0);
                RightElem.css("left", 0);
                return;
            }
            RightElem.css("left", 400);
            if (MiddleHeight > LeftHeight) return;
            var Top = LeftHeight - MiddleHeight;
            RightElem.css("top", -Top);
            if (LeftHeight > MiddleHeight + RightHeight)
                row.css("height", LeftHeight + 24);
            else
                row.css("height", MiddleHeight + RightHeight + 24);
            return;
        } else
            RightElem.css("left", 0);
        RightElem.css("top", 0);
    }
}

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
    OpenPOPUp('LinkedRecords.aspx', null, null, true);


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
    var wnd = GetRadWnd();
    wnd.close();
    btnRefreshId = $(window.parent.document).find("input[id$=btnRefreshParticipant]");
    if (btnRefreshId) {
        btnRefreshId.click();
    }
}

function CloseBluebeamParticipantPopup() {
    var btnRefreshId;
    btnRefreshId = $(window.opener.document).find("input[id$=btnRefresh]");
    if (btnRefreshId) {
        btnRefreshId.click();
    }
    setTimeout(function () { self.close(); }, 500);
   
}

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

function isMobileScreen() {
    var browserWidth = $telerik.$(window).width();
    if (browserWidth <= MobileScreenWidth)
        return true;
    return false;
}

function OpenPOPUpToRedirect(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10 , browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RedirectAfterClosed);
    return false;
}

function OpenCurrencyPOPUpToRedirect(URL) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();

    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(450, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RedirectAfterClosed);
    return false;
}

function OpenSubmitPOPUpToRedirect(URL) {
    var browserWidth = $telerik.$(window).width()
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    wnd.get_popupElement().className = wnd.get_popupElement().className + " SubmitPopup"
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(448, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RedirectAfterClosed);
    return false;
}

function OpenPOPUp(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        if (URL.indexOf("Notification.aspx") > -1 || URL.indexOf("NotificationLog.aspx") > -1)
            wnd.setSize(browserWidth, browserHeight);
        else
            wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }

    return false;
}

function OpenPOPUp2(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        if (URL.indexOf("Notification.aspx") > -1 || URL.indexOf("NotificationLog.aspx") > -1)
            wnd.setSize(browserWidth, browserHeight);
        else
            wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(Width, Height);
        wnd.Center();
    }
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }

    return false;
}


function OpenPOPUpNewStyle(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    if (isMobileScreen()) {
        if (URL.indexOf("Notification.aspx") > -1 || URL.indexOf("NotificationLog.aspx") > -1)
            wnd.setSize(browserWidth, browserHeight);
        else
            wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }

    return false;
}

function OpenCheckInPOPUp(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        if (URL.indexOf("Notification.aspx") > -1 || URL.indexOf("NotificationLog.aspx") > -1)
            wnd.setSize(browserWidth, browserHeight);
        else
            wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
        wnd.Center();
    }
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }

    return false;
}

function OpenSmallPOPUp(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(0, 0);
    }
    else {
        var popupwidth = browserWidth * 0.3;
        if (popupwidth < 450)
            popupwidth = 450;
        wnd.setSize(popupwidth, browserHeight * 0.9);
        wnd.Center();
    }
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }

    return false;
}

var wndRecentRecords = null;
var wndAiAssistant = null;

function WindowRecentClosed() {
    wndRecentRecords = null;
    var pathname = window.location.pathname;
    $('.nav-link').each(function () {
        this.className = this.className.replace(' active', '');
    });

    if (pathname.toLowerCase().indexOf("search.aspx") >= 0) {
        $("#ctl00_btnAdvanceSearch")[0].className = $("#ctl00_btnAdvanceSearch")[0].className + ' active';
    }
    else if (pathname.toLowerCase().indexOf("home.aspx") >= 0) {
        $("#ctl00_btnHome")[0].className = $("#ctl00_btnHome")[0].className + ' active';
    }
    else
        $('.nav-link').each(function () {
            this.className = this.className.replace(' active', '')
            if (this.getAttribute('data-CommandArgument') == Global_CurrentModuleId)
                this.className = this.className + ' active';
        });
}

function AiAssistantClosed() {
    wndAiAssistant = null;
}

function OpenMobilePopup(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    wnd.setSize(browserWidth, browserHeight);
    if (AddClose == true) {
        wnd.add_close(WindowClosed);
        if (gridId) { GridToRebind = gridId; }
    }
    wnd.moveTo(0, 0);
    return false;
}

function OpenParentPOPUp(URL, Width, Height) {
    var wnd = window.parent.radopen(URL);
    wnd.setSize(Width, Height);
    wnd.Center();
    return false;
}

function OpenReportViewerPOPUp(URL) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var PopupWidth = (browserWidth * 0.9) - 10; // 10 = borders of the popup
    var PopupHeight = (browserHeight * 0.9) - 60;// 60 = title + status bar of the popup
    var left = ((browserWidth - PopupWidth) / 2) + 10;
    var top = ((browserHeight - PopupHeight) / 2) + 60;
    window.open(URL, "",
                     'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + PopupWidth + ',height=' + PopupHeight + ',top=' + top + ',left=' + left);
    return false;
}

function OpenWindowPOPUp(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var PopupWidth = (browserWidth * 0.9) - 10; // 10 = borders of the popup
    var PopupHeight = (browserHeight * 0.9) - 60;// 60 = title + status bar of the popup
    var left = ((browserWidth - PopupWidth) / 2) + 10;
    var top =((browserHeight - PopupHeight) / 2) + 60;
    window.open(URL, null,
                     'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=' + PopupWidth + ',height=' + PopupHeight + ',top=' + top + ',left=' + left);
    return false;
}

function GetRadWnd() {
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow;

    else if (window.frameElement && window.frameElement.radWindow) oWindow = window.frameElement.radWindow;

    return oWindow;
}

function OpenAdjustmentsSelector(Width, Height) {
    var wnd = window.radopen('AdjustmentSelectPopup.aspx');
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }

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
        wnd.setSize(browserWidth, browserHeight);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(CostCodesPopupClosed);
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
    CloseRadWnd();
    btnRefreshId = $(window.parent.document).find("input[id$=btnRefreshBidder]");

    if (btnRefreshId) {
        btnRefreshId.click();
    }
}

function ClosePreBidPopup() {
    var btnRefreshId;
    CloseRadWnd();
    btnRefreshId = $(window.parent.document).find("input[id$=btnRefreshBidderMatrix]");

    if (btnRefreshId) {
        btnRefreshId.click();
    }
}




function OpenGridLayoutPopup(URL, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    setTimeout(function () {
        var wnd = window.radopen(URL);
        var divWindow = wnd._popupElement;
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        GridToRebind = gridId;
        if (URL.indexOf("FILEMANGER_VIEW") > -1) {
            wnd.set_visibleTitlebar(false);
            wnd.add_close(FolderManager_GridLayoutPopupClosed);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
        }
        else if (URL.indexOf("FILEMANGERROOT_VIEW") > -1) {
            wnd.set_visibleTitlebar(false);
            wnd.add_close(function () {
                if ($("[id$=btnRefreshRootGrid]")[0])
                    $("[id$=btnRefreshRootGrid]")[0].click();});
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
        }
        else if (URL.indexOf("DOCUMENTATTACHMENTS_VIEW") > -1) {
            wnd.set_visibleTitlebar(false);
            wnd.add_close(DocumentAttachment_GridLayoutPopupClosed);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
        }
        else
            wnd.add_close(GridLayoutPopupClosed);
            wnd.Center();
    }, 200);
    return false;
}

function FolderManager_GridLayoutPopupClosed() {
    if ($("[id$=btnRefreshCurrentWorkingFolder]")[0])
        $("[id$=btnRefreshCurrentWorkingFolder]")[0].click();
}

function DocumentAttachment_GridLayoutPopupClosed() {
    if ($("[id$=btnRefresh]")[0])
        $("[id$=btnRefresh]")[0].click();
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

    if (currentTextBox.getAttribute("Readonly") == null || currentTextBox.getAttribute("Readonly") == false) {

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

function RadComboCheckedAll(sender, args) { }

function showDatePopup(sender, e, atRight) {
    currentTextBox = sender;

    if (currentTextBox.getAttribute("Readonly") == null || currentTextBox.getAttribute("Readonly") == false) {
        var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
        currentDatePicker = datePicker;
        datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
        var position = { x: $(sender).offset().left, y: $(sender).offset().top  };
        if ($(sender).parents('.rgEditForm').length > 0) {
            datePicker.showPopup((atRight) ? position.x + sender.offsetWidth - 175 : position.x, position.y + sender.offsetHeight);
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
            datePicker.showPopup((atRight) ? position.x + sender.offsetWidth -260 : position.x, position.y + sender.offsetHeight);
        }
    }

}

function getPosition(element) {
    var xPosition = 0;
    var yPosition = 0;
    var IsGrid = 0
    var id = element.id;

    if (element.id.indexOf('rdg'))
        IsGrid = 1
    while (element) {

        xPosition += (element.offsetLeft + element.clientLeft);
        yPosition += (element.offsetTop + element.clientTop);// - document.getElementById('ctl00_CPH1_Submittals_rdgSubmittals_GridData').scrollTop);
        element = element.offsetParent;
    }



    var PreIndex = 0
    PreIndex = id.toLowerCase().indexOf('rdg');
    var searchString = '_';
    var SearchIndex = PreIndex + id.substring(PreIndex).indexOf(searchString);
    id = id.substring(0, SearchIndex);

    if (IsGrid && document.getElementById(id + "_GridData")) {

        xPosition -= document.getElementById(id + "_GridData").scrollLeft;

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
function UdfDateTimeCloseOnTabClick(e) {
    if (e.keyCode == 9) {
        setTimeout(function () { currentDatePicker.hidePopup(); }, 300);
    }

}

/******* Grid Functions *********/
var arrGrids = [];
var GridParents = [];
function GridCreatedFunction(sender, args) {
    var fName = sender.get_element().getAttribute("InitialGridCreatedFunction");
    if (fName != null) {
        window[fName](sender, args);
    }
    var ClientID = sender.ClientID;
    if (!($("[id=" + ClientID + "]")) || $("[id=" + ClientID + "]").length == 0) return;
    if (sender.get_element().hasAttribute("HasPasteFromExcel") && sender.get_element().getAttribute("HasPasteFromExcel").toLowerCase().trim() == 'true')
        BindPasteExcelHandlers(ClientID);
    if (sender.get_element().hasAttribute("HasCostCodePoup") && sender.get_element().getAttribute("HasCostCodePoup").toLowerCase().trim() == 'true')
        GridForCostCodesPopup = sender;
    $("[id=" + ClientID + "] .rgEditForm .RadComboBox").each(function () {
        if (!$find(this.id)) return;
        var dropDownElement = $("[id=" + $find(this.id)._dropDownElement.id + "]");
        var rcbheader = dropDownElement.find('.rcbHeader');
        if (rcbheader.length > 0) {
            if (dropDownElement.find('.rcbScroll').length > 0) {
                rcbheader.css({ width: '161px' });
                rcbheader.css({ overflow: 'hidden' });
            }
            dropDownElement.find('.rcbScroll').on('scroll', function () {
                $(this).parents('.RadComboBoxDropDown').find('.rcbHeader').scrollLeft($(this).scrollLeft());
            });
        }
    });
    if (sender.ClientSettings.Scrolling.AllowScroll == false) return;
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].ClientID == ClientID) {
            arrGrids.splice(k, 1);
        }
    }
    var IsVirtual = sender.ClientSettings.Scrolling.EnableVirtualScrollPaging;
    var AttrIsSearchDoc = (sender.get_element().hasAttribute("IsSearchDoc") && sender.get_element().getAttribute("IsSearchDoc").toLowerCase().trim() == 'true');
    var AttrIsWorkOrderSearch = (sender.get_element().hasAttribute("IsWorkOrderSearch") && sender.get_element().getAttribute("IsWorkOrderSearch").toLowerCase().trim() == 'true');
    var AttrSetWidth = (sender.get_element().hasAttribute("SetWidth") && sender.get_element().getAttribute("SetWidth").toLowerCase().trim() == 'true');
    var AttrAppendMenus = (sender.get_element().hasAttribute("AppendMenus") && sender.get_element().getAttribute("AppendMenus").toLowerCase().trim() == 'true');
    var IsDiv = false;

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


    if (AttrAppendMenus) {
        if ($("[id=" + ClientID + "] .rgCommandRow").length > 0) {
            if ($("[id$=rfdMaster]").length > 0) {
                var rfdMaster = $find($("[id$=rfdMaster]")[0].id);
                rfdMaster.decorate($("[id=" + ClientID + "] .rgCommandRow")[0]);
            }
        }
        var CommandCell = $("[id=" + ClientID + "] .rgCommandCell");
        if (CommandCell.length > 1) CommandCell = $(CommandCell[0]);
        if (CommandCell.length == 1 && CommandCell.parents("rgDetailTable").length == 0 && CommandCell[0].childElementCount == 1) {
            if (AttrIsSearchDoc || AttrIsWorkOrderSearch) {
                var CommandSDElement = CommandCell.find("> div [id$=tblDropDownLists] > table > tbody > tr");
                if (CommandSDElement.length > 0) {
                    for (var i = 0; i < CommandSDElement[0].childElementCount; i++) {
                        CommandSDElement[0].children[i].setAttribute("orderindex", i);
                    }
                } else
                    AttrAppendMenus = false;
            } else {
                var CommandDivElement = CommandCell.find("> div");
                var CommandtrElement = CommandCell.find("> table > tbody > tr");
                if (CommandDivElement.length == 1 && (CommandDivElement[0].id == null || CommandDivElement[0].id == '') && CommandDivElement[0].childElementCount > 1) {
                    IsDiv = true
                    for (var i = 0; i < CommandDivElement[0].childElementCount; i++) {
                        CommandDivElement[0].children[i].setAttribute("orderindex", i);
                    }
                } else if (CommandtrElement.length == 1 && CommandtrElement[0].childElementCount > 1) {
                    for (var i = 0; i < CommandtrElement[0].childElementCount; i++) {
                        CommandtrElement[0].children[i].setAttribute("orderindex", i);
                    }
                } else
                    AttrAppendMenus = false;
            }
        } else
            AttrAppendMenus = false;
    }
    var JQGrid = $("[id=" + ClientID + "]");
    var NeedsRebind = false;
    if ((AttrAppendMenus || AttrSetWidth) && JQGrid[0].offsetWidth <= 20) {
        var JParents = JQGrid.parents();
        GridParents[ClientID] = [];
        for (i = 0; i < JParents.length ; i++) {
            var style = JParents[i].getAttribute("style");
            GridParents[ClientID][i] = style;
            if (style && style != "") {
                if (style[style.length - 1] == ";")
                    style = style.substring(0, style.length - 1);
                JParents[i].setAttribute("style", style + ";display:block !important;");
            } else
                JParents[i].setAttribute("style", "display:block !important;");
        }
        var Gridstyle = JQGrid[0].getAttribute("style");
        GridParents[ClientID][JParents.length] = Gridstyle;
        if (Gridstyle && Gridstyle != "") {
            if (Gridstyle[Gridstyle.length - 1] == ";")
                Gridstyle = Gridstyle.substring(0, Gridstyle.length - 1);
            JQGrid[0].setAttribute("style", Gridstyle + ";display:block !important;");
        } else
            JQGrid[0].setAttribute("style", "display:block !important;");
        NeedsRebind = true;
    }
    arrGrids.push({ 'ClientID': ClientID, 'SetWidth': AttrSetWidth, 'AppendMenus': AttrAppendMenus, 'IsSearchDoc': AttrIsSearchDoc, 'IsWorkOrderSearch': AttrIsWorkOrderSearch, 'IsDiv': IsDiv, 'IsVirtual': IsVirtual });
    if (AttrAppendMenus) {
        if (AttrIsSearchDoc)
            AppendSDMenu(ClientID);
        else if (IsDiv)
            AppendDivMenus(ClientID);
        else
            AppendTableMenus(ClientID, AttrIsWorkOrderSearch);
    }
    if (AttrSetWidth) SetGridHeight(ClientID, IsVirtual);
    if (NeedsRebind) {
        var JParents = JQGrid.parents();
        for (i = 0; i < JParents.length; i++) {
            if (GridParents[ClientID][i])
                JParents[i].setAttribute("style", GridParents[ClientID][i]);
            else
                JParents[i].removeAttribute("style");
        }
        if (GridParents[ClientID][JParents.length])
            JQGrid[0].setAttribute("style", GridParents[ClientID][JParents.length]);
        else
            JQGrid[0].removeAttribute("style");
    }
}

var RTime;
var RTimeout = false;
var RDelta = 150;
var WindowWidth = $(window).width();

function TelerikWindowResizeEnd() {
    if (LayoutColsOnWindowResize)
        FloatDivs();
    if (new Date() - RTime < RDelta) {
        setTimeout(TelerikWindowResizeEnd, RDelta);
    } else {
        RTimeout = false;
        //if (WindowWidth == $(window).width()) return

        WindowWidth = $(window).width();
        if (LayoutColsOnWindowResize)
            setTimeout(FloatDivs, 500);
        ResizeAllGrids();
        //  ResizemainToolbar();
        //if ($("[id=TreeGanttContainer]").length > 0)
        //    $("[id=TreeGanttContainer]").width(document.documentElement.clientWidth - $("[id=TreeGanttContainer]").offset().left - 3);
 
    }

}

function ResizeAllGrids() {
    for (var k = 0; k < arrGrids.length; k++) {
        if ($find(arrGrids[k].ClientID) == null) continue;
        if ((arrGrids[k].AppendMenus || arrGrids[k].SetWidth) && $("[id=" + arrGrids[k].ClientID + "]")[0].offsetWidth <= 20)
            continue;
        if (arrGrids[k].AppendMenus) {
            if (arrGrids[k].IsSearchDoc)
                AppendSDMenu(arrGrids[k].ClientID);
            else if (arrGrids[k].IsDiv)
                AppendDivMenus(arrGrids[k].ClientID);
            else
                AppendTableMenus(arrGrids[k].ClientID, arrGrids[k].IsWorkOrderSearch);
        }
        if (arrGrids[k].SetWidth) {
            SetGridHeight(arrGrids[k].ClientID, arrGrids[k].IsVirtual);
            if ($("[id=" + arrGrids[k].ClientID + "]").parents('.row.R3Cols .col-4').length > 0)
                AdjustCols($("[id=" + arrGrids[k].ClientID + "]").parents('.row.R3Cols')[0].getAttribute("pmid"));
        }
    }
}

function ResetGridSettings(ClientID, SkipWidthCalculate) {
    if ($find(ClientID) == null) return;
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].ClientID == ClientID) {
            if (arrGrids[k].AppendMenus) {
                if (arrGrids[k].IsSearchDoc)
                    AppendSDMenu(arrGrids[k].ClientID);
                else if (arrGrids[k].IsDiv)
                    AppendDivMenus(arrGrids[k].ClientID);
                else
                    AppendTableMenus(arrGrids[k].ClientID, arrGrids[k].IsWorkOrderSearch);
            }
            if (arrGrids[k].SetWidth) {
                SetGridHeight(arrGrids[k].ClientID, arrGrids[k].IsVirtual);
            }
            return;
        }
    }
}

function SetGridHeight(ClientID, IsVirtual) {
    // set grid height
    if ($("[id=" + ClientID + "]").length == 0) return;
    var JQGrid = $("[id=" + ClientID + "]");
    if (ClientID != 'ctl00_CPH1_ucRoles_rdgRoles') {
        var GridFixedElementsHeight = 8;// for borders, 
        if ($(".bottomtoolbar").length == 1 && $(".bottomtoolbar").css("display") != "none")
            GridFixedElementsHeight += 2;// 2 for bottomToolbar;
        JQGrid.children().each(function (index) {
            if ($(this).hasClass('rgDataDiv') == false)
                GridFixedElementsHeight += this.offsetHeight;
        });
        var FixedElementsHeight = 0;
        if ($("[id$=MasterToolbarTop]:visible").length > 0)
            FixedElementsHeight = FixedElementsHeight + $("[id$=MasterToolbarTop]:visible").height() + 1;
        if ($("[id=MasterToolbarTopExtension]:visible").length > 0)
            FixedElementsHeight = FixedElementsHeight + $("[id=MasterToolbarTopExtension]:visible").height();
        if ($("[id$=tblRowBreadCrumb]:visible").length > 0)
            FixedElementsHeight = FixedElementsHeight + $("[id$=tblRowBreadCrumb]:visible").height();
        if ($(".bottomtoolbar:visible").length > 0)
            FixedElementsHeight = FixedElementsHeight + $(".bottomtoolbar:visible").height();
        if ($(".MobileFixedMenu:visible").length > 0)
            FixedElementsHeight = FixedElementsHeight + $(".MobileFixedMenu:visible").height() + 1;
        $(".ToolBar:visible").each(function (index) {
            if ($(this).css('Position') == 'fixed' || $(this).css('Position') == 'sticky')
                FixedElementsHeight += (this.offsetHeight > 5) ? this.offsetHeight : 0;
        });
        $(".documentTabs:visible").each(function (index) {
            if ($(this).css('Position') == 'fixed' || ($(this).parent('.RadAjaxPanel').length >=1  && $(this).parent('.RadAjaxPanel').css('Position') == 'sticky'))
                FixedElementsHeight += (this.offsetHeight > 5) ? this.offsetHeight : 0;
        });
        $(".WorkflowTabsOnMobile:visible").each(function (index) {
            if ($(this).css('Position') == 'fixed' || $(this).css('Position') == 'sticky')
                FixedElementsHeight += (this.offsetHeight > 5) ? this.offsetHeight : 0;
        });
        var FitPageHeight = false;
        if (JQGrid[0].hasAttribute("FitPageHeightOffset")) {
            var GridBotOffset = JQGrid[0].getAttribute("FitPageHeightOffset").toLowerCase().trim();
            var CurBordersHeight = 0;
            if ($(".bottomtoolbar:visible").length > 0)
                CurBordersHeight = CurBordersHeight + $(".bottomtoolbar:visible").height();
            if ($(".MobileFixedMenu:visible").length > 0)
                CurBordersHeight = CurBordersHeight + $(".MobileFixedMenu:visible").height();
            if (JQGrid.offset().top + parseFloat(GridBotOffset) + 150 + CurBordersHeight < document.documentElement.clientHeight)
                FixedElementsHeight = JQGrid.offset().top + parseFloat(GridBotOffset) + CurBordersHeight;
            FitPageHeight = true;
        }

        if (JQGrid.find(".rgHeaderDiv .rgEditForm").length > 0) {
            var InsertedItem = JQGrid.find(".rgHeaderDiv .rgEditForm")
            JQGrid.find(".rgDataDiv").css('height', 0);
            var dataHeight = InsertedItem.height();
            GridFixedElementsHeight = GridFixedElementsHeight - dataHeight;
            var rgDataDivHeight = document.documentElement.clientHeight - GridFixedElementsHeight - FixedElementsHeight;
            if (rgDataDivHeight < dataHeight) {
                JQGrid.find(".rgEditForm").css('height', (rgDataDivHeight < 60) ? 50 : rgDataDivHeight);
                JQGrid.find(".rgEditForm").css('overflow-y', 'scroll');
                JQGrid.find(".rgHeaderDiv").css('margin-right', '17px');
            } else {
                JQGrid.find(".rgHeaderDiv").css('margin-right', '0');
                InsertedItem.css('overflow-y', 'hidden');
                InsertedItem.css('height', 'auto');
            }
            JQGrid.find(".rgHeaderDiv").css('overflow-x', 'scroll');
        } else {
            var rgDataDivHeight = document.documentElement.clientHeight - GridFixedElementsHeight - FixedElementsHeight;
            var dataHeight = JQGrid.find(".rgDataDiv > table > tbody ")[0].offsetHeight;
            var MaxHeight =  JQGrid.find(".rgDataDiv").css("max-height");
            if (!isNaN(parseFloat(MaxHeight)) && rgDataDivHeight > parseFloat(MaxHeight)) {
                rgDataDivHeight = parseFloat(MaxHeight);
            }
            if (rgDataDivHeight < dataHeight || (window.location.pathname.indexOf("RecentDocuments.aspx") >= 0 && ClientID.indexOf("rdgrecords") >= 0)) {
                JQGrid.find(".rgDataDiv").height((rgDataDivHeight < 60) ? 50 : rgDataDivHeight);
                JQGrid.find(".rgDataDiv").css('overflow-y', 'scroll');
                JQGrid.find(".rgHeaderDiv").css('margin-right', '17px');
            } else {
                if (IsVirtual) {
                    var rgDataDiv = JQGrid.find(".rgDataDiv")[0];
                    if (rgDataDiv.clientWidth < rgDataDiv.scrollWidth) dataHeight = dataHeight + 20;
                    JQGrid.find(".rgDataDiv").css('height', dataHeight);
                    JQGrid.find(".rgDataDiv").css('overflow-y', 'scroll');
                    JQGrid.find(".rgHeaderDiv").css('margin-right', '17px');
                }
                else {
                    JQGrid.find(".rgDataDiv").css('height', 'auto');
                    JQGrid.find(".rgDataDiv").css('overflow-y', 'hidden');
                    JQGrid.find(".rgHeaderDiv").css('margin-right', '0');
                }

            }
        }
    }
}

function AppendDivMenus(ClientID) {
    var CommandCell = $("[id=" + ClientID + "] .rgCommandCell");
    if (CommandCell.length > 1) CommandCell = $(CommandCell[0]);
    if (CommandCell.find("> div").length == 0) return
    //reset grid state
    var Qelement = CommandCell.find("> div");
    var div = $("<div></div>");
    var element = Qelement[0];
    if (Qelement.find("[id$=div_exchange_more_menu]").length > 0) {
        var menutds = Qelement.find("[id$=div_exchange_more_menu] > table > tbody > tr > td");
        for (var j = 0; j < menutds.length; j++) {
            var Cdiv = $("<div></div>");
            div.append(Cdiv);
            Cdiv.append($(menutds[j].children[0]));
        }
    }
    if (Qelement.find(".div_ExchangeContainer_more_menu").parents("[id$=div_more_menu]").length > 0)
        Qelement.find(".div_ExchangeContainer_more_menu").closest("tr").remove();
    else
        Qelement.find(".div_ExchangeContainer_more_menu").remove();

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
    var MenuWidth = 0;
    for (var i = element.childElementCount - 1; i >= 0; i--) {
        var SType = element.children[i].attributes['SecurityButtonType'] ? element.children[i].attributes['SecurityButtonType'].value : '';
        var id = element.children[i].attributes['id'] ? element.children[i].attributes['id'].value : '';
        if (MenuInvisibleItems.length > 0) MenuWidth = 29;
        if ((SType && (SType == 'ItemMode_Delete' || SType == 'ItemMode_Add' || SType == 'AddEditMode_Edit' || SType == 'AddEditMode_Add' || SType == 'AddEditMode'))
            || (id && id.indexOf('btnExportExcel') >= 0)) {
            if ($(element.children[i]).offset().left + element.children[i].offsetWidth + MenuWidth + 10 > Qelement.offset().left + element.offsetWidth) {
                if (AddMenuAdded) continue;
                i = 0;
                AppendDivAddMenu(ClientID)
                i = element.childElementCount - 1;
                MenuInvisibleItems = [];
                AddMenuAdded = true;
                continue;
            }
        } else if ($(element.children[i]).offset().left + element.children[i].offsetWidth + MenuWidth + 10 > Qelement.offset().left + element.offsetWidth)
            if (element.children[i].id != 'div_add_more_menu' && element.children[i].id != 'spn_add_more_menu')
                MenuInvisibleItems.push(element.children[i]);
    }
    if (MenuInvisibleItems.length > 0) {
        var div = $('<div class="div_more_menu Hide" id="div_more_menu"></div>')
        $(element).append(div);
        var html = $('<a id="img_more_menu" class="img_more_menu" href="#" onclick="return false;"><span id="spn_more_menu"></span></a>');
        $(element).append(html);
        var table = $("<table><tbody></tbody></table>");
        div.append(table);
        for (var i = MenuInvisibleItems.length - 1; i >= 0 ; i--) {
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
            table.prepend(tr);
            var td = $('<td></td>');
            tr.append(td);
            td.append($(ele));
        }
    }
}

function AppendDivAddMenu(ClientID) {
    var AddCommandCell = $("[id=" + ClientID + "] .rgCommandCell");
    if (AddCommandCell.length > 1) AddCommandCell = $(AddCommandCell[0]);
    var Addelement = AddCommandCell.find("> div")[0];
    var AddMenuItems = [];
    var ExchangeMenuItems = [];
    var firstAddItem;
    var RefreshItem;
    for (var z = 0; z < Addelement.childElementCount; z++) {
        var SType = Addelement.children[z].attributes['SecurityButtonType'] ? Addelement.children[z].attributes['SecurityButtonType'].value : '';
        var id = Addelement.children[z].attributes['id'] ? Addelement.children[z].attributes['id'].value : '';
        if (SType && SType == 'ItemMode_Add' && id.indexOf('btnPasteClipBoard') < 0) {
            if (!firstAddItem) firstAddItem = Addelement.children[z];
            AddMenuItems.push(Addelement.children[z]);
        }
        if (id.indexOf('btnPasteClipBoard') >= 0 || id.indexOf('btnExportExcel') >= 0)
            ExchangeMenuItems.push(Addelement.children[z]);
        if (id.indexOf('btnRefresh') >= 0)
            RefreshItem = Addelement.children[z];
    }

    if (AddMenuItems.length > 0) {
        var Addtext = (typeof (Menu_Add) !== 'undefined') ? Menu_Add : 'Add';
        var Adddiv = $('<div class="div_add_more_menu Hide" id="div_add_more_menu" style="position:absolute;background-color:white;border:1px solid gray;z-index: 99;"></div>')
        $(Addelement).append(Adddiv);
        var Addhtml = $('<a id="spn_add_more_menu" class="spn_add_more_menu" style="vertical-align: middle;display: inline-block;">' +
                             '<span>' +
                                 '<span title="' + Addtext + '" class="spn_add_more_menu_icon"></span>' +
                                 '<span class="spn_add_more_menu_text">' + Addtext + '</span>' +
                             '</span>' +
                             '<span class="spn_add_more_menu_arrow"></span>' +
                         '</a>');
        if (firstAddItem)
            Addhtml.insertAfter($(firstAddItem));
        else
            $(Addelement).prepend(Addhtml);

        var Addtable = $("<table><tbody></tbody></table>");
        Adddiv.append(Addtable);
        for (var z = 0; z < AddMenuItems.length; z++) {
            var Addtr = $('<tr></tr>');
            Addtable.append(Addtr);
            var Addtd = $('<td></td>');
            Addtr.append(Addtd);
            Addtd.append($(AddMenuItems[z]));
        }
    }

    if (ExchangeMenuItems.length > 0) {
        var ExchangeText = (typeof (Menu_Exchange) !== 'undefined') ? Menu_Exchange : 'Exchange Data';
        var ExchangeContainer = $('<div id="div_ExchangeContainer_more_menu" class="div_ExchangeContainer_more_menu" style="display:inline-block;position: relative;z-index: 801;"></div>');
        var ExchangeMenudiv = $('<div class="div_exchange_more_menu Hide" id="div_exchange_more_menu" style="position:absolute;background-color:white;border:1px solid gray;"></div>')
        var ExchangeMenuhtml = $('<a id="spn_exchange_more_menu" class="spn_exchange_more_menu" style="vertical-align: middle;display: inline-block;">' +
                             '<span>' +
                                 '<span title="' + ExchangeText + '" class="spn_exchange_more_menu_icon"></span>' +
                                 '<span class="spn_exchange_more_menu_text">' + ExchangeText + '</span>' +
                             '</span>' +
                             '<span class="spn_add_more_menu_arrow"></span>' +
                         '</a>');
        $(ExchangeContainer).append(ExchangeMenudiv);
        $(ExchangeContainer).append(ExchangeMenuhtml);
        if (RefreshItem)
            ExchangeContainer.insertAfter($(RefreshItem));
        else
            $(Addelement).append(ExchangeContainer);

        var ExchangeMenu = $("<table><tbody></tbody></table>");
        ExchangeMenudiv.append(ExchangeMenu);
        for (var z = 0; z < ExchangeMenuItems.length; z++) {
            var ExchangeMenutr = $('<tr></tr>');
            ExchangeMenu.append(ExchangeMenutr);
            var ExchangeMenutd = $('<td></td>');
            ExchangeMenutr.append(ExchangeMenutd);
            ExchangeMenutd.append($(ExchangeMenuItems[z]));
        }
    }
}


function AppendTableMenus(ClientID, IsWorkOrderSearch) {
    var CommandCell = $("[id=" + ClientID + "] .rgCommandCell");
    if (CommandCell.length > 1) CommandCell = $(CommandCell[0]);
    var Qelement
    if (IsWorkOrderSearch)
        Qelement = CommandCell.find("> div [id$=tblDropDownLists] > table > tbody > tr");
    else
        Qelement = CommandCell.find("> table > tbody > tr");
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
    if (CommandRow.length > 1) CommandRow = $(CommandRow[0]);
    for (var i = 0; i < element.childElementCount; i++) {
        if (element.children[i].childElementCount == 0) continue;
        if ($(element.children[i]).offset().left + element.children[i].offsetWidth + 39 > CommandRow.offset().left + CommandRow[0].offsetWidth)
            if (element.children[i].id != 'td_more_menu' && element.children[i].id != 'div_more_menu')
                MenuInvisibleItems.push(element.children[i]);
    }
    if (MenuInvisibleItems.length > 0) {
        var td = $('<td class="td_more_menu" id="td_more_menu"></td>');
        var div = $('<div class="div_more_menu Hide" id="div_more_menu"></div>');
        var html = $('<a id="img_more_menu" class="img_more_menu" href="#" onclick="return false;"><span id="spn_more_menu"></span></a>');
        CommandCell.append(div);
        td.append(html);
        Qelement.append(td);
        var table = $("<table><tbody></tbody></table>");
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
        if ($(element.children[i]).offset().left + element.children[i].offsetWidth + 5 > screenwidth - 5) {
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
        var div = $('<div class="div_more_menu Hide SD_div_more_menu" id="div_more_menu"></div>');
        var html = $('<a id="img_more_menu" class="img_more_menu" href="#" onclick="return false;"><span id="spn_more_menu"></span></a>');
        $("[id=" + ClientID + "] .rgCommandCell").append(div);
        td.append(html);
        $("[id=" + ClientID + "] .rgCommandCell > div > table > tbody > tr").append(td);
        var table = $("<table><tbody></tbody></table>");
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
function OpenSmallestPopup(URL, Width, Height, AddClose, gridId) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    if (GetRadWindowManager()) {
        var wnd = window.radopen(URL);
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight - 10);
        }
        else {
            wnd.setSize(browserWidth * 0.5, browserHeight * 0.5);
            wnd.Center();
        }
    }
    else {
        setTimeout(function () {
            var wnd = window.radopen(URL);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
            }
            else {
                wnd.setSize(browserWidth * 0.5, browserHeight * 0.5);
                wnd.Center();
            }
        },500)
    }
    return false;
}

//    --------------------------------Section: Grid Freeze Header --------------------------------------------------------
function OnGridScroll(sender, args) {
}


function ToolbarGlobalClientButtonClicking(sender, args) {
    if (args.get_item().get_commandName() == "New") {
        if (dirty && (dirtyEnabled == 'true')) {
            if (confirm(Msg_PromptToSave) == false) {
                args.set_cancel(true);
                return false;
            }
        }
    }
    var fName = sender.get_element().getAttribute("InitialFunciton");
    if (fName != null) {
        window[fName](sender, args);
    }
}