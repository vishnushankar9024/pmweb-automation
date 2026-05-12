function CloseFlyout() {
    var flyout = $(".flyoutPopup")[0]
    var flyoutBackdrop = $('#flyoutBackdrop')[0]
    if (flyoutBackdrop.className.indexOf("Hide") < 0) {
        flyoutBackdrop.className = flyoutBackdrop.className + 'Hide';
    }
    flyout.className = flyout.className + ' Hide';
    return false;
}
function CloseFlyoutOnBackdropClick() {
   /* var flyout = $(".flyoutPopup")[0]*/
    var flyoutBackdrop = $('#flyoutBackdrop')[0]
    //if (flyoutBackdrop.className.indexOf('Hide') < 0)
    //flyoutBackdrop.className = flyoutBackdrop.className + 'Hide'
    //if (flyout.className.indexOf('Hide')<0)
    //    flyout.className = flyout.className + ' Hide'; 

    //var ConfigureAssetTreeDiv = $('#ConfigureAssetTreeDiv');
    var AssetTreeToolBarDiv = $('#AssetTreeToolBarDiv');
    var assetExplrerTree = $('#ctl00_ctl00_CPH1_AssetExplorer_rdvAssetExplorer');
    if (AssetTreeToolBarDiv.length > 0 && AssetTreeToolBarDiv[0].className.indexOf('Hide')<0) {
        AssetTreeToolBarDiv.addClass('Hide');
       // ConfigureAssetTreeDiv.removeClass('Hide');
        if (flyoutBackdrop.className.indexOf("Hide") < 0) {
            flyoutBackdrop.className = flyoutBackdrop.className + 'Hide';
        }
        //assetExplrerTree.removeClass('paddingTop');
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const FilterIcon = document.getElementById('filter-icon');
    const UnfilterIcon = document.getElementById('unfilter-icon');
    const EditPenIcon = document.getElementById('edit-pen');

    function fadeIn(element) {
        element.style.opacity = 0;
        element.style.display = 'block';
        setTimeout(() => {
            element.style.transition = 'opacity 0.2s ease-in-out';
            element.style.opacity = 1;
        }, 10);
    }

    function fadeOut(element) {
        element.style.transition = 'opacity 0.2s ease-in-out';
        element.style.opacity = 0;
        setTimeout(() => {
            element.style.display = 'none';
            element.style.opacity = 1;
        }, 200);
    }

    FilterIcon.addEventListener('click', (event) => {
        event.stopPropagation(); // to stop HideFlyoutMenu function from firing
        fadeOut(FilterIcon);
        fadeOut(UnfilterIcon);
        setTimeout(() => {
            fadeIn(EditPenIcon);
        }, 200);
    });

    UnfilterIcon.addEventListener('click', (event) => {
        event.stopPropagation(); // to stop HideFlyoutMenu function from firing
        fadeOut(FilterIcon);
        fadeOut(UnfilterIcon);
        setTimeout(() => {
            fadeIn(EditPenIcon);
        }, 200);
    });

    EditPenIcon.addEventListener('click', (event) => {
        event.stopPropagation(); // to stop HideFlyoutMenu function from firing
        fadeOut(EditPenIcon);
        setTimeout(() => {
            fadeIn(FilterIcon);
            fadeIn(UnfilterIcon);
        }, 200);
    });
});

function OpenHomeFlyout() {
    setTimeout(function () {
    ClosRecentPopup()
    var flyout = $(".flyoutPopup")[0];
    flyout.className = flyout.className.replace(' Hide', '');
    if (flyout.classList.contains('open')) {
        flyout.classList.remove('open');
        flyout.classList.add('close');
    } else {
        flyout.classList.remove('close');
            flyout.style.display = "unset";
            flyout.classList.add('open');    
            flyout.style.zIndex = 7001;
    }
    },200)
    
    return true;
}


function ShowRail() {
   
    setTimeout(function () { truncatetext(OriginalRecordDesc); }, 200);
    HideFlyoutMenu();
    var drawer = $('form')[0]
    if (drawer.className.indexOf("rail") < 0) {
        drawer.className = drawer.className + ' rail';
        if (typeof fixSplitterSize == "function")
            fixSplitterSize(true);
    }
    setCookie('PMWebMenuStatus', 'none', 60);
    FixGridWidth();
    FloatDivs();
 /*   OpenRecentDocumentsPopup('');*/
    if ($("[id$=tbsDocument]")[0] != undefined && $("[id$=tbsDocument]")[0] != null) {
        var tbsdocument = $find($("[id$=tbsDocument]")[0].id);
        if (tbsdocument != null) tbsdocument._resize();
    }
    if ($("[id$=tbsHomeDocument]")[0] != undefined && $("[id$=tbsHomeDocument]")[0] != null) {
        var tbsHomeDocument = $find($("[id$=tbsHomeDocument]")[0].id);
        if (tbsdocument != null) tbsHomeDocument._resize();
    }
    ShowModuleTooltip();
    return false;
}

function ShowModuleTooltip() {
    var moduleElements = document.getElementsByClassName('tooltip-link');
    for (var i = 0; i < moduleElements.length; i++) {
        moduleElements[i].title = moduleElements[i].getElementsByTagName('span')[0].innerHTML
    }
}

function HideModuleTooltip() {
    var moduleElements = document.getElementsByClassName('tooltip-link');
    for (var i = 0; i < moduleElements.length; i++) {
        moduleElements[i].title = ''
    } 
}

function HideRail() {
    setTimeout(function () { truncatetext(OriginalRecordDesc); }, 200);
    HideFlyoutMenu();
    var drawer = $('form')[0];
    drawer.className = drawer.className.replace(' rail', '')
    setCookie('PMWebMenuStatus', 'inline', 60);
    FixGridWidth();
    FloatDivs();
    if (typeof fixSplitterSize == "function")
        fixSplitterSize(false);
 /*   OpenRecentDocumentsPopup('');*/
    if ($("[id$=tbsDocument]")[0] != undefined && $("[id$=tbsDocument]")[0] != null) {
        var tbsdocument = $find($("[id$=tbsDocument]")[0].id);
        if (tbsdocument != null) tbsdocument._resize();
    }
    if ($("[id$=tbsHomeDocument]")[0] != undefined && $("[id$=tbsHomeDocument]")[0] != null) {
        var tbsHomeDocument = $find($("[id$=tbsHomeDocument]")[0].id);
        if (tbsHomeDocument != null) tbsHomeDocument._resize();
    }
    HideModuleTooltip();
    return false;
}
function FixGridWidth() {
    for (var k = 0; k < arrGrids.length; k++) {
        if (arrGrids[k].AppendMenus) {
            if (arrGrids[k].IsSearchDoc)
                AppendSDMenu(arrGrids[k].ClientID);
            else if (arrGrids[k].IsDiv)
                AppendDivMenus(arrGrids[k].ClientID);
            else
                AppendTableMenus(arrGrids[k].ClientID);
        }
    }
}
function OpenIpadMenu() {
    var drawer = $('.drawer');
    var drawerBackdrop = $('#drawerBackdrop')
    drawer[0].className = drawer[0].className + ' activated'
    drawerBackdrop[0].className = "backdrop-activated";
}
function CloseIpadMenu() {
    var drawer = $('.drawer');
    var drawerBackdrop = $('#drawerBackdrop')
    drawer[0].className = drawer[0].className.replace(' activated', '')
    HideFlyoutMenu();
    drawerBackdrop[0].className = "";
}
function GoToHomePage(sender) {
    $('.nav-link').each(function () {
        if (this.id != sender.id)
            this.className = this.className.replace(' active', '')
    });
    if (sender.className.indexOf('active') < 0)
        sender.className = sender.className + ' active';
    window.location = 'Home.aspx';
    return false;
}
function GoToHomePageMobile(sender) {
    window.location = 'Home.aspx';
    return false;
}

function HideFlyoutMobileMenu(sender) {
    var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
    var flyoutMenuClientId = FlyoutMenu.id
    if (FlyoutMenu.classList.contains("Hide") == false)
        FlyoutMenu.classList.add("Hide");
    $('#' + flyoutMenuClientId).find('div').each(function () {
        if ($(this).attr('module-id') > 0 && $(this)[0].classList.contains("Hide") == false)
            $(this)[0].classList.add("Hide")
    })
}

function HideFlyoutMenu(sender) {
    var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
    var flyoutMenuClientId = FlyoutMenu.id
    var backdrop = document.getElementsByClassName('MenuBackDrop')[0];
    if (FlyoutMenu.classList.contains('activated') == true) {
        FlyoutMenu.classList.add('activated')
    }
    if (backdrop.classList.contains('activated') == true) {
        backdrop.classList.add('activated')
    }
    if (backdrop.classList.contains("Hide") == false)
        backdrop.classList.add("Hide")
    if (FlyoutMenu.classList.contains("Transition") == false)
        FlyoutMenu.classList.add("Transition")
    $('#' + flyoutMenuClientId).find('div').each(function () {
        if ($(this).attr('module-id') > 0 && $(this)[0].classList.contains("Hide") == false)
            setTimeout(function () { if ($(this)[0].classList) $(this)[0].classList.add("Hide") }, 500);
    })
}

function isMobile() {
    return window.innerWidth <= 843;
}

function HideFlyoutMenuWithoutTransition() { 
    var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];  
    var backdrop = document.getElementsByClassName('MenuBackDrop')[0];
    var drawer = document.querySelector('.drawer');

    if (FlyoutMenu.classList.contains('activated') == true) {
        FlyoutMenu.classList.add('activated')
    }
    if (backdrop.classList.contains('activated') == true) {
        backdrop.classList.add('activated')
    }
    if (backdrop.classList.contains("Hide") == false)
        backdrop.classList.add("Hide")
    if (FlyoutMenu.classList.contains("Hide") == false) {
        FlyoutMenu.classList.add("Hide")
        setTimeout(function () {
            var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
            FlyoutMenu.classList.add("Transition");
            FlyoutMenu.classList.remove("Hide");
        }, 200)
    }
    if (isMobile() && drawer) {
        if (drawer.classList.contains("show")) {
            drawer.classList.add("Hide");
            setTimeout(function () {
                drawer.classList.remove("Hide");
                drawer.classList.remove("show");
            }, 10);
        }
    }
}

function ClosRecentPopup() {
    if (wndRecentRecords != undefined && wndRecentRecords != null) {
        wndRecentRecords.Close();
        wndRecentRecords = null;
    }
}
function ToggleMobileMenu() {
    ClosRecentPopup()
    var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
    if (FlyoutMenu.classList.contains("Hide") == false) {
        HideFlyoutMobileMenu(FlyoutMenu)
        return false;
    }
    panel = $('.MobileMenuItems');
    if (panel[0].className.indexOf('closeanimation') > 0 || panel[0].className.indexOf('hiddenMobileMenuItems') > 0) {
        panel[0].className = panel[0].className.replace(' hiddenMobileMenuItems', '').replace(' closeanimation', '') + ' openanimation';
        $('.MobileFixedMenu')[0].className = $('.MobileFixedMenu')[0].className + ' open'
        return false;
    }
    panel[0].className = panel[0].className.replace(' hiddenMobileMenuItems', '').replace(' openanimation', '') + ' closeanimation';
    $('.MobileFixedMenu')[0].className = $('.MobileFixedMenu')[0].className.replace(' open', '')
    return false;
}


function OpenFlyoutMenu(sender) {
    if (wndRecentRecords != undefined && wndRecentRecords != null) {
        wndRecentRecords.Close();
        wndRecentRecords = null;      
    }
  
    //--- hide the menu only when the button of the same module is clicked ---
    var ModuleId = sender.getAttribute('data-CommandArgument');
    var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
    if (FlyoutMenu) {
        var isClosed = false;
        $('#' + FlyoutMenu.id).find('div').each(function () {
            if ($(this).attr('module-id') == ModuleId && !$(this)[0].classList.contains('Hide')) {
                var isVisible = !FlyoutMenu.classList.contains("Transition");
                if (isVisible) {
                    HideFlyoutMenu();
                    isClosed = true;
                }
            }
        })
        if (isClosed == true) { return false;}
    }
    //------------------------------------------------------------------------

    if (sender.id.indexOf("btnUniversity")>=0) {
        window.open("TrainingAuthService.aspx", '_blank');
    } else if (sender.id.indexOf("btnAdvanceSearch")>=0) {
        window.open("Search.aspx?ModuleId=7&PageId=223", '_self');
    }
    if (ModuleId) {
        showEditPen();
        if (FilteredModuleIds.split(',').indexOf(ModuleId.toString()) >= 0) {
            showFavouritePages(null, ModuleId);
        } else {
            showAllPagesWithoutImg(null, ModuleId);
        }

        var text = sender.text.trim('\n').toString();
        document.getElementById("myText").innerHTML = text;
        document.getElementById("unfilter-icon").setAttribute("module-id", ModuleId);
        document.getElementById("filter-icon").setAttribute("module-id", ModuleId);
        document.getElementById("edit-pen").setAttribute("module-id", ModuleId);
        var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
        var backdrop = document.getElementsByClassName('MenuBackDrop')[0];
        var divMenuPagesClientId = FlyoutMenu.id;
        var drawer = $('.drawer');
        if (drawer[0].classList.contains('activated') == true && FlyoutMenu.classList.contains('activated') == false) {
            FlyoutMenu.classList.add('activated')
        }
        if (drawer[0].classList.contains('activated') == true && backdrop.classList.contains('activated') == false) {
            backdrop.classList.add('activated')
        }
        var drawerWidth = $('.drawer')[0].clientWidth
        FlyoutMenu.style.left = drawerWidth + 'px';
        backdrop.style.left = drawerWidth + 'px';
        if (backdrop.classList.contains("Hide") == true) {
            backdrop.classList.remove("Hide")
            backdrop.style.display = ""
        }
        if (FlyoutMenu.classList.contains("Hide") == true) {
            FlyoutMenu.classList.remove("Hide")
            FlyoutMenu.style.display = ""
        }
        if (FlyoutMenu.classList.contains("Transition") == true) {
            FlyoutMenu.classList.remove("Transition")
        }
        $('#' + divMenuPagesClientId).find('div').each(function () {
            if ($(this).attr('module-id') == ModuleId) {
                $(this)[0].classList.remove("Hide")
                $(this)[0].classList.remove("Transition")

            }
            else
                if ($(this).attr('module-id') > 0 && $(this)[0].classList.contains("Hide") == false)
                    $(this)[0].classList.add("Hide")
        })

        switch(ModuleId)
        {
           
        }
        

    }


    return false;
}


function OpenMobileFlyoutMenu(sender) {
    if (wndRecentRecords != undefined && wndRecentRecords != null) {
        wndRecentRecords.Close();
        wndRecentRecords = null;
    }
    ToggleMobileMenu();
    var ModuleId = sender.getAttribute('data-CommandArgument');
    if (ModuleId == "-1") {
        window.open("TrainingAuthService.aspx", '_blank');
        return false;
} else if (sender.id.indexOf("btnMobileAdvanceSearch")>=0) {
        window.open("Search.aspx?ModuleId=7&PageId=223", '_self');
        return false;
    }
    if (ModuleId) {
        var FlyoutMenu = document.getElementsByClassName('divMenuPages')[0];
        var divMenuPagesClientId = FlyoutMenu.id;

        if (FlyoutMenu.classList.contains("Hide") == true) {
            FlyoutMenu.classList.remove("Hide")
            FlyoutMenu.style.display = ""
        }
        $('#' + divMenuPagesClientId).find('div').each(function () {
            if ($(this).attr('module-id') == ModuleId)
                $(this)[0].classList.remove("Hide")
            else
                if ($(this).attr('module-id') > 0 && $(this)[0].classList.contains("Hide") == false)
                    $(this)[0].classList.add("Hide")
        })

    }


    return false;
}

function del_cookie(name) {
    document.cookie = name + '=; expires=Thu, 01-Jan-70 00:00:01 GMT;';
}
function getCookie(c_name) {
    var i, x, y, ARRcookies = document.cookie.split(";");
    for (i = 0; i < ARRcookies.length; i++) {
        x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
        x = x.replace(/^\s+|\s+$/g, "");
        if (x == c_name) {
            return unescape(y);
        }
    }
}

function ManageMenuState() {
    if (getCookie('PMWebMenuStatus') == undefined || getCookie('PMWebMenuStatus') == null) {
        var browserWidth = $telerik.$(window).width();
        if (browserWidth < 1460)
            ShowRail();
    }
}

function changeFavouriteState(sender) {
    var ModuleId = sender.closest('.divModulePages').getAttribute("module-id");
    var paramJson = JSON.stringify({ 'PageId': sender.getAttribute("pageId"), 'Favourite': sender.classList.contains("active") });
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/UpdateFavouriteState",
        contentType: "application/json; charset=utf-8",
        data: paramJson,
        dataType: "json",
        async: false,
        success: function (data) {
            
        },
        error: function (data) {
            console.log('The action could not be taken, please refresh the page and try again.');
        }
    });

    event.preventDefault();
    event.stopPropagation();

    sender.classList.add('fade');

    setTimeout(() => {
        if (sender.classList.contains("active")) {
            sender.classList.remove('active');
            sender.setAttribute("src", "CSS/Images/ResponsiveIcons/Icons/Icons/Unfavorite.svg");
            sender.parentElement.parentElement.getElementsByTagName('a')[0].setAttribute('fav', '0');
        } else {
            sender.classList.add('active');
            sender.setAttribute("src", "CSS/Images/ResponsiveIcons/Icons/Icons/Favorite.svg");
            sender.parentElement.parentElement.getElementsByTagName('a')[0].setAttribute('fav', '1');
        }
        sender.classList.remove('fade');
        updateTooltip(sender);
        var containter = document.querySelector('.divModulePages[module-id="' + ModuleId + '"] .row');
        unsortedModulesHTML[ModuleId] = containter.innerHTML.toString();
    }, 200);
}

function updateFilteredModules(sender) {
    if (sender) {
        var ModuleId = sender.getAttribute("module-id");
        var paramJson = JSON.stringify({ 'ModuleId': ModuleId, 'IsAdd': sender.id === 'filter-icon' });
        $.ajax({
            type: "POST",
            url: "AjaxService.aspx/UpdateFilteredModules",
            contentType: "application/json; charset=utf-8",
            data: paramJson,
            dataType: "json",
            async: false,
            success: function (data) {
                FilteredModuleIds = data.d;
            },
            error: function (data) {
                console.log('The action could not be taken, please refresh the page and try again.');
            }
        });
    }
}

function updateTooltip(sender) {
    var tooltip = document.getElementsByClassName('tltpFavUnfav')[0];
    var message = sender.classList.contains('active') ? 'Make unfavorite' : 'Make favorite';
    tooltip.innerHTML = message;
    tooltip.style.display = 'block';
    tooltip.style.top = (sender.y + 20) + "px";
    tooltip.style.left = (sender.x + 20) + "px";
}

function hideTooltip(sender) {
    var tooltip = document.getElementsByClassName('tltpFavUnfav')[0];
    tooltip.style.display = 'none';
}

var unsortedModulesHTML = {};

function showFavouritePages(sender, ModuleId) {
    if (sender) { ModuleId = sender.getAttribute("module-id"); }
    if (SortFavPages) {
        sortPages(ModuleId);
    }
    var pages = Array.from(document.getElementsByClassName('divBox'));
    pages.forEach(function (page) {
        var pageTitle = page.getElementsByTagName('a')[0];
        if (!pageTitle) pageTitle = page.getElementsByTagName('span')[0];
        if (pageTitle) {
            if (!(pageTitle.getAttribute('fav') == '1')) {
                page.closest('table').classList.add('hidden');
            }
        }
        var imgFav = Array.from(page.getElementsByClassName('favourite'));

        imgFav.forEach(function (fav) {
            if (fav) {
                if (!fav.classList.contains('hidden')) {
                    fav.classList.add('hidden');
                }
            }
        })

    })
    updateFilteredModules(sender);
}

function sortPages(ModuleId) {
    var containter = document.querySelector('.divModulePages[module-id="' + ModuleId + '"] .row');
    var tablesArray = Array.from(containter.querySelectorAll('table'));
    if (!unsortedModulesHTML[ModuleId]) {
        unsortedModulesHTML[ModuleId] = containter.innerHTML.toString();
    }

    tablesArray.sort((tableA, tableB) => {
        var textA = '';
        var textB = '';
        if (tableA.querySelector('a')) {
            textA = tableA.querySelector('a').textContent.trim();
        } else {
            if (tableA.querySelector('span')) {
                textA = tableA.querySelector('span').textContent.trim();
            }
        }
        if (tableB.querySelector('a')) {
            textB = tableB.querySelector('a').textContent.trim();
        }
        else {
            if (tableB.querySelector('span')) {
                textB = tableB.querySelector('span').textContent.trim();
            }
        }
        return textA.localeCompare(textB);
    });

    containter.innerHTML = '';
    tablesArray.forEach(row => containter.appendChild(row));
}

function unsortPages(ModuleId) {
    if (unsortedModulesHTML[ModuleId]) {
        var containter = document.querySelector('.divModulePages[module-id="' + ModuleId + '"] .row');
        containter.innerHTML = unsortedModulesHTML[ModuleId];
    }
}

function showAllPages(sender, ModuleId) {
    if (sender) { ModuleId = sender.getAttribute("module-id"); }
    if (SortFavPages) {
        unsortPages(ModuleId);
    }

    var pages = Array.from(document.getElementsByClassName('divBox'));
    pages.forEach(function (page) {
        page.closest('table').classList.remove('hidden');

        var imgFav = Array.from(page.getElementsByClassName('favourite'));
        imgFav.forEach(function (fav) {
            if (fav) {
                fav.classList.remove('hidden');
            }
        })
    })
    //updateFilteredModules(sender);
}

function showEditPen() {
    document.getElementById('edit-pen').style.display = 'block';
    document.getElementById('filter-icon').style.display = 'none';
    document.getElementById('unfilter-icon').style.display = 'none';
}

function showAllPagesWithoutImg(sender, ModuleId) {
    if (sender) { ModuleId = sender.getAttribute("module-id"); }
    if (SortFavPages) {
        unsortPages(ModuleId);
    }

    var pages = Array.from(document.getElementsByClassName('divBox'));
    pages.forEach(function (page) {
        page.closest('table').classList.remove('hidden');

        var imgFav = Array.from(page.getElementsByClassName('favourite'));
        imgFav.forEach(function (fav) {
            if (fav) {
                fav.classList.add('hidden');
            }
        })
    })
    updateFilteredModules(sender);
}

function ShowHideRail() {
    var drawer = $('form')[0];
    if (drawer.className.indexOf("rail") > 0) {
        drawer.className = drawer.className.replace(' rail', '')
    }
    var backdrop = document.getElementsByClassName('MenuBackDrop')[0];
    if (backdrop.classList.contains('activated')) {
        backdrop.classList.remove('activated')
    } else {
        backdrop.classList.add('activated')
    }
    if (backdrop.classList.contains('Hide')) {
        backdrop.classList.remove('Hide')
    } else {
        backdrop.classList.add('Hide')
    }

    setTimeout(function () {
        var drawer = document.querySelector('.drawer');
        if (drawer.classList.contains("show")) {
            drawer.classList.remove("show");
        } else {
            drawer.classList.add("show");
        }
    }, 10);
    return false;
}

function redirectToLastRecord(sender) {
    if (dirty && (dirtyEnabled == 'true')) {
        if (confirm(Msg_PromptToSave) == false) {
            return false;
        } else {
         return   goToLastRecord(sender);
        }
    } else {
      return  goToLastRecord(sender);
    }
}

function goToLastRecord(sender) {
    var ObjectTypeId = sender.getAttribute("otid");
    var URL = "";
    var paramJson = JSON.stringify({ 'ObjectTypeId': ObjectTypeId });
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/GetLastRecordURL",
        contentType: "application/json; charset=utf-8",
        data: paramJson,
        dataType: "json",
        async: false,
        success: function (data) {
            URL = data.d;
        },
        error: function (data) {
            console.log('The action could not be taken, please refresh the page and try again.');
        }
    });

    if (URL !== "") {
        window.location = URL;
        return false; // Prevent default if hooked to an anchor or form event
    }
}

//// Rad Splitter Functions

// This method is called when the sidebar is collapsed and expanded (in the ShowRail() method) 
function fixSplitterSize(isRail) {
    // Timeout to wait for the sidebar transition to happen
    setTimeout(() => {
        let tblSplitter = $("table.RadSplitter");
        if (!tblSplitter || (tblSplitter.length == 0)) return;
        let container = $("table.RadSplitter").parent().parent().parent();
        let containerWidth = container.width();
        let splitter = $find($("table.RadSplitter").parent().parent().attr("id"));
        let firstPane = splitter.getPaneByIndex(0);
        let secondPane = splitter.getPaneByIndex(1);
        secondPane.set_width(containerWidth - firstPane.get_width() - 0);

        splitter.set_width(containerWidth);

    }, 600)

}




