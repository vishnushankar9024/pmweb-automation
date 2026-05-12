
function openGroupDetailsPopup(GroupId) {
    OpenPOPUp('BudgetGroupDetailsPopup.aspx?GroupId=' + GroupId, null, null, true, 'rdgGroups')
    return false;
}

function RebindBudgetGroupsGrid(Opener) {
    var btnRefreshId = $("a[id*=rdgGroups][id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}

function RebindBudgetCodeGrid() {
    var btnRefreshId = $("a[id*=rdgCostCodes][id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
}

function OpenBudgetGroupPopUp() {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('ProjectsLookup.aspx?From=BudgetGroups');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RebindBudgetGroupsGrid);
    return false;
}


function OpenBudgetCodePopUp() {    
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen('ProjectsLookup.aspx?From=BudgetCodes');
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(8, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(RebindBudgetCodeGrid);
    return false;
}

function RebindBudgetCodeAndGroupsGrid(Opener) {
    var btnRefreshId = $("a[id*=rdgBudgetCodes][id$=btnRefresh]")[0];
    if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
    window.setTimeout(function() {
        btnRefreshId = $("a[id*=rdgGroups][id$=btnRefresh]")[0];
        if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
    }, 100);
}



function ConfirmDeleteDetailsRows() {
    var confirmed = ConfirmDelete();
    if (confirmed) {
        return SelectedRowIsUsed();
    }
    return false;
}


function SelectedRowIsUsed() {
    var rdgBudgetGroupDetails = $find($("[id$=rdgBudgetGroupDetails]")[0].id);
    var MasterTable = rdgBudgetGroupDetails.MasterTableView;
    var selectedRows = MasterTable.get_selectedItems();
    if (selectedRows.length = 1) {
        var row = selectedRows[0];
        var cell = MasterTable.getCellByColumnUniqueName(row, "IsUsed")
        var IsUsed = (cell.innerHTML.toLowerCase() == 'true');
        if (IsUsed) {
            alert(Msg_CannotDeleteUsedInBudgetCodes);
            return false;
        }
    }
    return true;
}