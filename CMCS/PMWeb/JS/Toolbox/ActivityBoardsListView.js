
$(document).ready(function () {
    $('body').click(function (e) {
        var q = e.target;
        var s = $(q);
        if (s.parents('.ActivityBoardLV').length == 0) return;
        var targetid = e.target.id;
        if ((targetid.indexOf('_txtTaskName') == -1 && $('[id$=txtTaskName]').length > 0)
            || (targetid.indexOf('_txtNewTaskName') == -1 && $('[id$=txtNewTaskName]').length > 0)
            || (targetid.indexOf('_txtNewColumnName') == -1 && $('[id$=txtNewColumnName]').length > 0)) {
            $('[id$=btnCancelAll]')[0].click();
        }
    })
    
    $('.ActivityBoardLV').contextmenu(function (e) {
        if ($('[id$=rdtActivityBoards]').length > 0) {
            if ($find($('[id$=rdtActivityBoards]')[0].id).get_dataItems().length == 0) {
                var menu = $find($('[id$=RadContextMenu1]')[0].id);
                menu.show(e);
            }
        }
    })
})

function ExpandTreeListView() {
    setTimeout(function () {
        if ($('[id$=rdtActivityBoards]').length > 0) {
            var treeList = $find($('[id$=rdtActivityBoards]')[0].id);
            if (!treeList) ExpandTreeListView();
            treeList.get_dataItems().forEach(function (a) {
                if ((a._data._clientDataKeyValues.Id.indexOf("Col_") >= 0) && (a._expandCollapseButton != undefined) && (a._expandCollapseButton.className == "rtlExpand"))
                    a.toggleExpandCollapse();
            });
        } else {
            return;
        }
    }, 100);
}

function LV_FindDropPosition(sender, args) {
    var DestTd = $(args.get_destinationHtmlElement());
    if (!DestTd.hasClass('rtlA') || !DestTd.hasClass('rtlR')) {
        DestTd = DestTd.parents('.rtlA, .rtlR')[0];
    }

    var Pos = 'Top';
    if ((event.pageY - $(DestTd).offset().top) > (DestTd.clientHeight / 2))
        Pos = 'Bottom';
    $("[id$=hdnPos]").val(Pos);
}

function LV_OpenTasksPopup(sender, args) {
    var Taskid = args.get_item().get_dataKeyValue('Id');
    var isColumn = Taskid.indexOf("_");
    if (isColumn < 0) {
        LV_OpenActivityBoardTasksPopup(Taskid);
    }
}

function LV_OpenActivityBoardTasksPopup(Taskid) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();

    var wnd = window.radopen('ActivityBoardTasksPopup.aspx?taskId=' + Taskid);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    wnd.add_close(LV_RefreshListView);
    return false;
}

function LV_OpenActivityBoardListViewFilterPopup(Source) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();

    var wnd = window.radopen('ActivityBoardListViewFilterPopup.aspx?Source=' + Source);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    wnd.setSize(448, 500);
    wnd.center();
    wnd.add_close(LV_RefreshListView);
    return false;
}

function LV_FireRadTreeListCommand(sender, args) {
    var commandName = args.get_item().get_value();
    switch (commandName) {
        case 'Delete':
            if (!ConfirmDelete()) {
                args.set_cancel(true);
                var menu = $find($('[id$=RadContextMenuLV]')[0].id);
                menu.hide();
                return false;
            }
            break;
        case 'AddTask':
            var target = args._targetElement
            while (target.tagName !== 'TR')
                target = target.parentElement;
            var btnId = target.getElementsByClassName("lblTaskName")[0].id.replace("lblTaskName", "InsertButton_EditCommandColumn");
            var btn = $("#" + btnId)[0];
            btn.click();
            break;
    }
}

function LV_OpenListContextMenu(sender, args) {
    if (args.get_item().get_dataKeyValue('Id').indexOf("_") > 0) {
        return LV_OpenContextMenu(sender, args);
    }
}

function LV_OpenContextMenu(sender, args) {
    var menu = $find($('[id$=RadContextMenuLV]')[0].id);
    var evt = args.get_domEvent();

    menu.show(evt);

    evt.cancelBubble = true;
    evt.returnValue = false;

    if (evt.stopPropagation) {
        evt.stopPropagation();
        evt.preventDefault();
    }

    var colId = args.get_item().get_dataKeyValue("Id").replace("Col_", "");
    $("[id$=hdnColId]").val(colId);
    return false;
}

function LV_OpenContextMenuFromButton(sender, event) {
    var menu = $find($('[id$=RadContextMenuLV]')[0].id);
    menu.show(event);

    var treeList = $find($('[id$=rdtActivityBoards]')[0]);
    var CurrNode = $(sender).parents('.rtlA, .rtlR')[0];
    var colId = $find(CurrNode.id).get_dataKeyValue("Id").replace("Col_", "");
    $("[id$=hdnColId]").val(colId);
    return false;
}

function LV_OpenDatePicker(sender, e, atRight) {
    var datePickerId = sender.id.replace("lblDueDate", "RadDatePickerDue");
    var datePicker = $find($("[id$=" + datePickerId + "]")[0].id);
    currentDatePicker = datePicker;
    if (datePicker.isPopupVisible()) {
        datePicker.hidePopup();
    };
    var position = { x: $(sender).offset().left, y: $(sender).offset().top - 20 };
    datePicker.showPopup((!atRight) ? position.x + sender.offsetWidth - 220 : position.x, position.y + sender.offsetHeight + 20);
    e.preventDefault();
    return false;
}

function LV_OpenAssignUserToTaskPopup(taskId) {
    var wnd = window.radopen('AssignUserToTaskPopup.aspx?taskId=' + taskId);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    wnd.setSize(448, 500);
    wnd.center();
    wnd.add_close(LV_RefreshListView);
    return false;
}

function LV_OpenAssignUserToTaskPopupForSelected() {
    var taskIds = "";
    for (var i = 0; i < $find($('[id$=rdtActivityBoards]')[0].id).get_selectedItems().length; i++) {
        var selectedItem = $find($('[id$=rdtActivityBoards]')[0].id).get_selectedItems()[i];
        var item = selectedItem.get_dataKeyValue("Id");
        taskIds = taskIds + item + ","
    }
    var wnd = window.radopen('AssignUserToTaskPopup.aspx?taskIds=' + taskIds + '&Source=ActivityBoardSelectedLV');
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    wnd.setSize(448, 500);
    wnd.center();
    wnd.add_close(LV_RefreshListView);
    return false;
}

function LV_DeleteSelectedColumns() {
    var treeList = $find($('[id$=rdtActivityBoards]')[0].id);
    if (treeList.get_selectedItems().length > 0) {
        return ConfirmDelete();
    }
    return false;
}

function LV_RefreshListView() {
    $('[id$=btnRefreshListView]')[0].click();
}

function LV_FocusTxtTaskName() {
    setTimeout(function () {
        $('[id$=txtTaskName]').focus();
        var $thisVal = $('[id$=txtTaskName]').val();
        $('[id$=txtTaskName]').val('').val($thisVal);
        $('[id$=txtTaskName]').select();
    }, 800);

    $('[id$=txtTaskName]').keydown(function (e) {
        if (e.key === 'Enter') {
            if ($('[id$=txtTaskName]').val() == "") {
                $('[id$=btnCancelAll]')[0].click();
            }
            else { 
                //$('[id$=btnUpdateColumnName]').click();
                eval($('[id$=btnUpdateColumnName]')[0].href.split(":")[1]);
            }
            return false;
        }
    });
}

function LV_FocusTxtNewTaskName() {
    setTimeout(function () {
        $('[id$=txtNewTaskName]').focus();
    }, 800);

    $('[id$=txtNewTaskName]').keypress(function (e) {
        if (e.key === 'Enter') {
            if ($('[id$=txtNewTaskName]').val() == "") {
                $('[id$=btnCancelAll]')[0].click();
            }
            else {
                eval($('[id$=btnAddTask]')[0].href.split(":")[1]);
            }
            return false;
        }
    });
}

function LV_FocusTxtNewColumnName() {
    setTimeout(function () {
        $('[id$=txtNewColumnName]').focus();
    }, 800);

    $('[id$=txtNewColumnName]').keypress(function (e) {
        if (e.key === 'Enter') {
            if ($('[id$=txtNewColumnName]').val() == "") {
                $('[id$=btnCancelAll]')[0].click();
            }
            else {
                $('[id$=btnAddColumn]')[0].click();
            }
            return false;
        }
    });
}

function LV_UpdateRowCount(sender, args) {
    
    if ((args.get_item()._element.className.indexOf('rtlRSel')) >= 0) { // case selected
        if (args.get_item().get_dataKeyValue('Id').indexOf('Col_') >= 0) { // case column selected: deselect all other tasks and columns
            var columnItem = args.get_item();
            var selectedItems = sender.get_selectedItems()
            for (var i = 0; i < selectedItems.length; i++) {
                var selectedItem = selectedItems[i];
                if (selectedItem.get_dataKeyValue('Id') != columnItem.get_dataKeyValue('Id')) {
                    sender.deselectItem(selectedItem);
                }
            }
            $("[id$=DetailsPane]")[0].style.display = "none";
            return;
        } else { // case task selected: deselect all other columns
            var selectedItems = sender.get_selectedItems()
            for (var i = 0; i < selectedItems.length; i++) {
                var selectedItem = selectedItems[i];
                if (selectedItem.get_dataKeyValue('Id').indexOf('Col_') >= 0) {
                    sender.deselectItem(selectedItem);
                }
            }
        }
    }

    var selectedRowsCount = $('.rtlRSel').length;
    if (selectedRowsCount > 0) {
        $("[id$=DetailsPane]")[0].style.display = "inline-block";
        $("[id$=lblTasksSelected]")[0].innerHTML = selectedRowsCount + " " + lblTasksSelectedText;
    } else {
        $("[id$=DetailsPane]")[0].style.display = "none";
    }    
}


