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
    var flyout = $(".flyoutPopup")[0]
    var flyoutBackdrop = $('#flyoutBackdrop')[0]
    if (flyoutBackdrop.className.indexOf('Hide') < 0)
    flyoutBackdrop.className = flyoutBackdrop.className + 'Hide'
    if (flyout.className.indexOf('Hide')<0)
        flyout.className = flyout.className + ' Hide'; 

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
function OpenFlyout() {
    $('#flyoutBackdrop').removeClass("Hide");
    ClosRecentPopup()
    var flyout = $(".flyoutPopup")[0]
    var flyoutBackdrop = $('#flyoutBackdrop')[0]
    flyoutBackdrop.className = flyoutBackdrop.className.replace('Hide', '');
    flyout.className = flyout.className.replace(' Hide', '');
    return true;
}

function ShowRail() {
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
    OpenRecentDocumentsPopup('');
    if ($("[id$=tbsDocument]")[0] != undefined && $("[id$=tbsDocument]")[0] != null) {
        var tbsdocument = $find($("[id$=tbsDocument]")[0].id);
        if (tbsdocument != null) tbsdocument._resize();
    }
    if ($("[id$=tbsHomeDocument]")[0] != undefined && $("[id$=tbsHomeDocument]")[0] != null) {
        var tbsHomeDocument = $find($("[id$=tbsHomeDocument]")[0].id);
        if (tbsdocument != null) tbsHomeDocument._resize();
    }
    return false;
}

function HideRail() {
   
    HideFlyoutMenu();
    var drawer = $('form')[0];
    drawer.className = drawer.className.replace(' rail', '')
    setCookie('PMWebMenuStatus', 'inline', 60);
    FixGridWidth();
    FloatDivs();
    if (typeof fixSplitterSize == "function")
        fixSplitterSize(false);
    OpenRecentDocumentsPopup('');
    if ($("[id$=tbsDocument]")[0] != undefined && $("[id$=tbsDocument]")[0] != null) {
        var tbsdocument = $find($("[id$=tbsDocument]")[0].id);
        if (tbsdocument != null) tbsdocument._resize();
    }
    if ($("[id$=tbsHomeDocument]")[0] != undefined && $("[id$=tbsHomeDocument]")[0] != null) {
        var tbsHomeDocument = $find($("[id$=tbsHomeDocument]")[0].id);
        if (tbsHomeDocument != null) tbsHomeDocument._resize();
    }
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
    if (FlyoutMenu.classList.contains("Hide") == false)
        FlyoutMenu.classList.add("Hide")
    $('#' + flyoutMenuClientId).find('div').each(function () {
        if ($(this).attr('module-id') > 0 && $(this)[0].classList.contains("Hide") == false)
            $(this)[0].classList.add("Hide")
    })
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
    $('.nav-link').each(function () {
        if (this.id != sender.id)
            this.className = this.className.replace(' active', '')
    });
    if (sender.className.indexOf('active') < 0)
        sender.className = sender.className + ' active'

    var ModuleId = sender.getAttribute('data-CommandArgument');
    if (sender.id.indexOf("btnUniversity")>=0) {
        window.open("TrainingAuthService.aspx", '_blank');
    } else if (sender.id.indexOf("btnAdvanceSearch")>=0) {
        window.open("Search.aspx?ModuleId=7&PageId=223", '_self');
    }
    if (ModuleId) {

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
        $('#' + divMenuPagesClientId).find('div').each(function () {
            if ($(this).attr('module-id') == ModuleId) {
                $(this)[0].classList.remove("Hide")


            }
            else
                if ($(this).attr('module-id') > 0 && $(this)[0].classList.contains("Hide") == false)
                    $(this)[0].classList.add("Hide")
        })

        switch(ModuleId)
        {
            case "1":
                if ($('#CustomFormRepeater'))
                    if ($('#CustomFormRepeater')[0].childElementCount > 0) {
                        if ($('#divEstimating').height() < 404) {
                            var PlanFormsHeight = ($('#CustomFormRepeater')[0].childElementCount * 15) + ($('#CustomFormRepeater')[0].childElementCount * 14);
                            if (PlanFormsHeight > 404)
                                $('#CustomFormRepeater')[0].style.height = '404px';
                            else
                                $('#CustomFormRepeater')[0].style.height = PlanFormsHeight + 'px';
                        }
                        else
                        $('#CustomFormRepeater')[0].style.height = $('#divEstimating').height() - 48 + 'px'
                    }
                    else
                        $('#CustomFormRepeater')[0].parentElement.style = 'display:none;'
                break;
            case "2":
                if ($('#divEngineeringFormCustomForms'))
                    if ($('#divEngineeringFormCustomForms')[0].childElementCount > 0) {
                        if ($('#divEngineeringForms').height() < 353) {
                            var EngeneeringFormsHeight = ($('#divEngineeringFormCustomForms')[0].childElementCount * 15) + ($('#divEngineeringFormCustomForms')[0].childElementCount * 14);
                            if (EngeneeringFormsHeight > 353)
                                $('#divEngineeringFormCustomForms')[0].style.height = '353px';
                            else
                                $('#divEngineeringFormCustomForms')[0].style.height = EngeneeringFormsHeight + 'px';
                        }
                        else
                        $('#divEngineeringFormCustomForms')[0].style.height = $('#divEngineeringForms').height() - 48 + 'px'
                    }
                    else
                        $('#divEngineeringFormCustomForms')[0].parentElement.style = 'display:none;'
                break;
            case "3":
                if ($('#divCostManagementCustomForms'))
                    if ($('#divCostManagementCustomForms')[0].childElementCount > 0) {
                        if ($('#divCostManagement').height() < 413) {
                            var CostFormsHeight = ($('#divCostManagementCustomForms')[0].childElementCount * 15) + ($('#divCostManagementCustomForms')[0].childElementCount * 14);
                            if (CostFormsHeight > 413)
                                $('#divCostManagementCustomForms')[0].style.height = '413px';
                            else
                                $('#divCostManagementCustomForms')[0].style.height = CostFormsHeight + 'px';
                        }
                        else
                        $('#divCostManagementCustomForms')[0].style.height = $('#divCostManagement').height() - 48 + 'px'
                    }
                    else
                        $('#divCostManagementCustomForms')[0].parentElement.style = 'display:none;'
                break;
            case "4":
                if ($('#divSchedulingCustomForms'))
                    if ($('#divSchedulingCustomForms')[0].childElementCount > 0) {
                        if ($('#divScheduling').height() < 413) {
                            var ScheduleFormsHeight = ($('#divSchedulingCustomForms')[0].childElementCount * 15) + ($('#divSchedulingCustomForms')[0].childElementCount * 14);
                            if (ScheduleFormsHeight > 413)
                                $('#divSchedulingCustomForms')[0].style.height = '413px';
                            else
                                $('#divSchedulingCustomForms')[0].style.height = ScheduleFormsHeight + 'px';
                        }
                        else
                        $('#divSchedulingCustomForms')[0].style.height = $('#divScheduling').height() - 48 + 'px'
                    }
                    else
                        $('#divSchedulingCustomForms')[0].parentElement.style = 'display:none;'
                break;
            case "5":
                if ($('#divAssetCustomForms'))
                    if ($('#divAssetCustomForms')[0].childElementCount > 0) {
                        if ($('#divAsset').height() < 442) {
                            var AssetFormsHeight = ($('#divCostManagementCustomForms')[0].childElementCount * 15) + ($('#divCostManagementCustomForms')[0].childElementCount * 14);
                            if (AssetFormsHeight > 442)
                                $('#divAssetCustomForms')[0].style.height = '442px';
                            else
                                $('#divAssetCustomForms')[0].style.height = AssetFormsHeight+'px';
                        }
                        else
                        $('#divAssetCustomForms')[0].style.height = $('#divAsset').height() - 48 + 'px'

                    }
                    else
                        $('#divAssetCustomForms')[0].parentElement.style = 'display:none;'
                break;
            case "6":
                if ($('#divWorkflowCustomForms'))
                    if ($('#divWorkflowCustomForms')[0].childElementCount > 0) {
                        if ($('#divWorkflow').height() < 456) {
                            var WorkflowFormsHeight = ($('#divWorkflowCustomForms')[0].childElementCount * 15) + ($('#divWorkflowCustomForms')[0].childElementCount * 14);
                            if (WorkflowFormsHeight > 456)
                                $('#divWorkflowCustomForms')[0].style.height = '456px';
                            else
                                $('#divWorkflowCustomForms')[0].style.height = WorkflowFormsHeight + 'px';

                        }
                        else
                        $('#divWorkflowCustomForms')[0].style.height = $('#divWorkflow').height() - 48 + 'px'
                    }
                    else
                        $('#divWorkflowCustomForms')[0].parentElement.style = 'display:none;'
                break;
            case "7":
                if ($('#divPortfolioCustomForms'))
                    if ($('#divPortfolioCustomForms')[0].childElementCount > 0) {
                        if ($('#divPortfolio').height() < 456) {
                            var PorftfolioFormsHeight = ($('#divPortfolioCustomForms')[0].childElementCount * 15) + ($('#divPortfolioCustomForms')[0].childElementCount * 14);
                            if (PorftfolioFormsHeight > 456)
                                $('#divPortfolioCustomForms')[0].style.height = '456px';
                            else
                                $('#divPortfolioCustomForms')[0].style.height = PorftfolioFormsHeight + 'px';

                        }
                       else
                        $('#divPortfolioCustomForms')[0].style.height = $('#divPortfolio').height() - 48 + 'px'
                    }
                    else
                        $('#divPortfolioCustomForms')[0].parentElement.style = 'display:none;'
                break;
            case "8":
                if ($('#divToolboxCustomForms'))
                    if ($('#divToolboxCustomForms')[0].childElementCount > 0){
                        if ($('#divToolbox').height() < 370) {
                            var toolboxFormsHeight = ($('#divToolboxCustomForms')[0].childElementCount * 15) + ($('#divToolboxCustomForms')[0].childElementCount * 14);
                            if (toolboxFormsHeight > 370)
                                $('#divToolboxCustomForms')[0].style.height = '369px';
                            else
                                $('#divToolboxCustomForms')[0].style.height = toolboxFormsHeight + 'px';
                        }
                        else
                            $('#divToolboxCustomForms')[0].style.height = $('#divToolbox').height() - 48 + 'px';
                    }
                      
                    else
                        $('#divToolboxCustomForms')[0].parentElement.style = 'display:none;'
                break;


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

