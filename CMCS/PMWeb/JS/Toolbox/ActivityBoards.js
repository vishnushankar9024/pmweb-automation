$(document).ready(function () {
    if ($('[id$=MainBoard]').length == 0) return;
    if ((typeof (CanEditActivityBoard) !== 'undefined') && CanEditActivityBoard) {
        $('body').click(function (e) {
            var q = e.target;
            var JQTarget = $(q);
            var targetid = q.id;
            if (targetid != 'DivNewCol' && $(e.target).parents("[id=DivNewCol]").length == 0 && !($('.DivNewColText').hasClass('Hide'))) {
                AddColumn(false);
            }
            if (JQTarget.parents('.TempRow').length == 0 && !(JQTarget.hasClass('.TempRow')) && $('.inputAddTask').length > 0) {
                $('.inputAddTask').parents('.ABRow').remove();
                if (!IsFiltered)
                    $(".ABRowsContainer").sortable('option', 'disabled', false);
            }
            if (targetid != 'DivEditCol' && $(e.target).parents("[id=DivEditCol]").length == 0 && !($('.DivNewColText').hasClass('DivEditCol'))) {
                EditColumn(null,false);
            }
        });
    }
});

function safe_tags(str) {
    return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}
function DrawActivityBoard() {
    //return;
    //ObjCols = [];
    //ObjCols[0] = { Id: 1, ColumnName: 'Grp1', Rows: [], };
    //ObjCols[1] = { Id: 2, ColumnName: 'Grp2', Rows: [], };
    //ObjCols[0].Rows[0] = { Id: 1, ColId: 1, LineNbr: 1, AttachImg: '', Title: 'A', AssignedToId: 0, AssignedToImg: '', DueDate: '', NbrLikes: 1, NbrComments: 0, NbrSubTasks: 0, Priority: 0, Flags: [] };
    //ObjCols[0].Rows[1] = { Id: 2, ColId: 1, LineNbr: 2, AttachImg: 'CDI Solution Changes 6.1.png', Title: 'B', AssignedToId: 0, AssignedToImg: 'CDI Solution Changes 6.1.png', DueDate: '', NbrLikes: 0, NbrComments: 5, NbrSubTasks: 0, Priority: 1, Flags: [] };
    //ObjCols[0].Rows[2] = { Id: 3, ColId: 1, LineNbr: 3, AttachImg: 'CDI Solution Changes 6.1.png', Title: 'C', AssignedToId: 0, AssignedToImg: 'CDI Solution Changes 6.1.png', DueDate: '', NbrLikes: 0, NbrComments: 0, NbrSubTasks: 6, Priority: 0, Flags: [] };
    //ObjCols[1].Rows[0] = { Id: 4, ColId: 2, LineNbr: 1, AttachImg: '', Title: 'A1', AssignedToId: 0, AssignedToImg: '', DueDate: '', NbrLikes: 0, NbrComments: 2, NbrSubTasks: 3, Priority: 0, Flags: [] };
    //ObjCols[1].Rows[1] = { Id: 5, ColId: 2, LineNbr: 2, AttachImg: '', Title: 'B1', AssignedToId: 0, AssignedToImg: 'CDI Solution Changes 6.1.png', DueDate: '', NbrLikes: 1, NbrComments: 7, NbrSubTasks: 11, Priority: 2, Flags: [] };

   if (ABBackgroundColor != '')
       $('body').css("background-color", ABBackgroundColor);
   if (ABColumnColor != '')
       $('head').append('<style type="text/css"> .ColTitle, .PlusImg, .imgAddTask{Color:' + ABColumnColor + ' !important;} </style>');
    var MainboardEle = $('[id$=MainBoard]');
    MainboardEle.html('');
    if (CanEditActivityBoard){
        var NewColDiv = $('<div id="DivNewCol" class="AddNewCol">' +
                 '    <div id="DivColTitle" class="ColTitle" onclick="return AddColumn(true);">' +
                 '          <div class="hoveredItem" style="margin-left:-8px;margin-top:-3px !important;height:28px !important"></div> ' +
                 '          <div class="PlusImg material-icons">add</div><div class="NewColText">' + safe_tags(TranslatedAddColumn) + '</div>' +
                 '     </div>' +
                 '    <div id="DivNewColText" class="DivNewColText Hide"><input id="inputAddCol" type="text" PlaceHolder="' + TranslatedAddColumn + '"></input></div>' +
                 '</div>');
    }
    MainboardEle.append(NewColDiv);
    for (var k = 0; k < ObjCols.length; k++) {
        var ABCol = ObjCols[k];
        var divCol = AppendNewColumn(ABCol.Id, ABCol.ColumnName);
        var PrevRow = null
        for (var i = 0; i < ABCol.Rows.length; i++) {
            AppendNewRow
            var ABRow = ABCol.Rows[i];
            PrevRow = AppendNewRow(ABRow, divCol, null,null);         
        }
    }
    if (CanEditActivityBoard)
        SetSortableFunctionality();
    $('.DivNewColText input').keydown(function (e) {
        if (e.key === 'Enter') {
            if (this.value == '') {
                AddColumn(false);
                return;
            }
            AppendNewColumn(0, this.value);
            SetSortableFunctionality();
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/AddActivityBoardColumn",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ ColumnName: this.value.replace("\\", "\\\\").replace("'", "\\'") }),
                dataType: "json",
                async: true,
                success: function (ColId) {
                    if (ColId.d == 'F') {
                        alert('The action could not be taken, please refresh the page and try again.');
                        return;
                    }
                    $('[id=ABCol_0]').attr('id', 'ABCol_' + ColId.d);
                },
                error: function (data) {
                    alert('The action could not be taken, please refresh the page and try again.')
                }
            });
            $('.DivNewColText input').val('');
            $('.DivNewColText')[0].scrollIntoView();
            $(window).scrollTop(0);
            return false;
        } else if (e.key === 'Escape') {
            AddColumn(false);
        }
    });

    var CookTaskId = getCookie('CurrTaskId');
    if (CookTaskId) {       
        var SelectedTask = $('[id=ABRow_' + CookTaskId + ']');
        if (SelectedTask.length == 1){
            SelectedTask[0].setAttribute('tabindex', -1);
            SelectedTask.css('outline', 'none');
            SelectedTask.focus();

            $('.ABRow').hover(function () {
                $('.ABRow:focus').blur();
            });
        }
        del_cookie('CurrTaskId');
    }


    //$('.DivEditCol input').keydown(function (e) {
    //    if (e.key === 'Enter') {
    //        var Colvalue = this.value.replace("\\", "\\\\").replace("'", "\\'");
    //        $(this).parents('.ABCol').find('.spnColName')[0].innerText = Colvalue;
    //        $.ajax({
    //            type: "POST",
    //            url: "AjaxService.aspx/EditActivityBoardColumnname",
    //            contentType: "application/json; charset=utf-8",
    //            data: "{'ColId':" + $(this).parents('.ABCol')[0].id.replace('ABCol_', '') + ",'ColumnName':'" + Colvalue + "'}",
    //            dataType: "json",
    //            async: true,
    //            success: function (data) {
    //            },
    //            error: function (data) {
    //                var x = 0;
    //            }
    //        });
    //        EditColumn(this,false);
    //        return false;
    //    } else if (e.key === 'Escape') {
    //        EditColumn(this,false);
    //    }
    //});
}

function EditColKeyDown(sender,e) {
    if (e.key === 'Enter') {
        var Colvalue = sender.value.replace("\\", "\\\\").replace("'", "\\'");
        if (Colvalue == '') return false;
        $(sender).parents('.ABCol').find('.spnColName')[0].innerText = Colvalue;
        $.ajax({
            type: "POST",
            url: "AjaxService.aspx/EditActivityBoardColumnname",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ ColId: $(sender).parents('.ABCol')[0].id.replace('ABCol_', ''), ColumnName: Colvalue }),
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d == 'F') alert('The action could not be taken, please refresh the page and try again.');
            },
            error: function (data) {
                alert('The action could not be taken, please refresh the page and try again.');
            }
        });
        EditColumn(sender, false);
        return false;
    } else if (e.key === 'Escape') {
        EditColumn(sender, false);
    }
}

function AppendNewRow(ABRow, divCol, PreviousRow, NextRow) {
    var DoneClass = "";
    if (ABRow.Done) {
        DoneClass = " IsDone";
    }
    var divRow = $('<div id="ABRow_' + ABRow.Id + '" class="ABRow" colid="' + ABRow.ColId + '" nbrsubtasks="' + ABRow.NbrSubTasks + '"  onclick="return OpenTaskPopup(this.id);"' + (CanEditActivityBoard ? ' oncontextmenu="OpenTaskContextMenu(this,event);"' : '') + '>' +
                      '<div class="ABRowHolder' + DoneClass + '">' +
                      '</div>' +
                  '</div>');
    if (ABRow.AttachImg != '') {
        var divAtach = $('<div id="AttachDiv" class="AttachDiv">' +
                         '<img src="' + ABRow.AttachImg + '" alt="" width="268px" height="160px"></img></div>');
        divRow.find('.ABRowHolder').append(divAtach);
    }

    var divTitle = $(' <div id="TitleDiv" class="TitleDiv">' +
                        ' <div style="float:left;">' +
                            ' <div class="chkDone"></div>' +
                            ' <span class="TitleSpan">'  + safe_tags(ABRow.Title)  + '</span>' + 
                            '<div style="clear:both"></div>' +
                        ' </div>' +
                         (CanEditActivityBoard ? '<div class="hoveredTaskMenu" style="margin-right:0 !important;" onclick="OpenTaskContextMenu(this,event);"></div>': '') +
                         '<div style="clear:both"></div>' +
                     ' </div>');
    divRow.find('.ABRowHolder').append(divTitle);

    var divTaskInfo = $('<table class="tblTaskInfo" cellpadding="0" cellspacing="0">' +
                       ' <tbody><tr>' +
                          ' <td  class="assignedToImg"' +  (CanEditActivityBoard ? ' onclick="OpenAssignUserPopupFromCardView(this);event.stopPropagation();"' : '') + '></td>' +
                          ' <td class="DueDate"></td>' +
                          ' <td class="UserIcons" align="right">' +
                          '      <table  cellpadding="0" cellspacing="0" style="table-layout: fixed; border-spacing: 0">' +
                          '         <tbody> ' +
                                     '<tr></tr>' +
                          '         </tbody>' +
                          '      </table>' +
                          '</td>' +
                       ' </tr></tbody></table>');
    if (ABRow.AssignedToImg != '') {
        var divASsigned = $('<div class="ToolTipDiv"><img src="' + ABRow.AssignedToImg + '" class="imgAssignedTo"  alt="" width="24px" height="24px"></img><span class="Tooltip">' + safe_tags(ABRow.AssignedToFullName) + '<span></div>');
        divTaskInfo.find('.assignedToImg').append(divASsigned);
    } else if (ABRow.AssignedToId > 0) {
        var divASsigned = $('<div class="AssignedToInitials">' + ABRow.AssignedToInitials + '<span class="Tooltip">' + safe_tags(ABRow.AssignedToFullName) + '</span>' + '</div>');
        divTaskInfo.find('.assignedToImg').append(divASsigned);
    } else {
        var divASsigned = $('<div class="EmptyImg' + (CanEditActivityBoard ? '' : ' ImgDisabled') + '"></div>');
        divTaskInfo.find('.assignedToImg').append(divASsigned);
    }
    var DueDateClass = 'class="DivDueDate"'
    if (ABRow.DueDate == '') {
        DueDateClass = 'class="DivDueDate' + (CanEditActivityBoard ? ' DivDueDateImg' + '"' : '');
    } else if (ABRow.IsDueDatePast) {
        DueDateClass = 'class="DivDueDate DueDateRed"'
    }
    var divDueDate = $('<div id="DivDueDate" ' + DueDateClass + (CanEditActivityBoard ? ' onclick="showDueDatePopup(this,event,true);event.stopPropagation();"' : '') + ' DateValue="' + ABRow .DueDate + '">' + ABRow.DueDateText + '</div>');
    divTaskInfo.find('.DueDate').append(divDueDate);

    var trUserIcons = divTaskInfo.find('.UserIcons > table > tbody > tr');

    if (ABRow.NbrLikes > 0) {
        var divLikes = $('<td style="padding-left:6px">' +
                         '    <span class="NumberOf">' + ABRow.NbrLikes + '</span>' +
                         '</td>' +
                         '<td style="padding-left:2px">' +  
                              '<div class="ImgLikes"></div>' +
                          '</td>')
        trUserIcons.append(divLikes);
    }
    if (ABRow.NbrComments > 0) {
        var divComments = $('<td style="padding-left:6px">' +
                         '    <span class="NumberOf">' + ABRow.NbrComments + '</span>' +
                         '</td>' +
                         '<td style="padding-left:2px">' +
                              '<div class="ImgComments"></div>' +
                          '</td>')
        trUserIcons.append(divComments);
    }
    if (ABRow.NbrSubTasks > 0) {
        var divSubTasks = $('<td style="padding-left:6px">' +
                         '    <span class="NumberOf">' + ABRow.NbrSubTasks + '</span>' +
                         '</td>' +
                         '<td style="padding-left:2px">' +
                              '<div class="ImgSubTasks"></div>' +
                          '</td>')
        trUserIcons.append(divSubTasks);
    }

    divRow.find('.ABRowHolder').append(divTaskInfo);

    for (var s = 0; s < ABRow.Flags.length; s++) {
        var divFlag = $(' <div class="FlagDiv" style="Background-color:' + ABRow.Flags[s].FlagColor + ';"><span>' + safe_tags(ABRow.Flags[s].FlagName) + '</span></div>')
        divRow.find('.ABRowHolder').append(divFlag);
    }

    if (PreviousRow != null)
        PreviousRow.after(divRow);     
    else if (NextRow != null)
        NextRow.before(divRow);
    else
        divCol.find(".ABRowsContainer").append(divRow);
    return divRow;
}

function AppendNewColumn(Id, Name) {
    var divCol = $(' <div id="ABCol_' + Id + '" class="ABCol">' +
                  (CanEditActivityBoard ? '<div id="DivEditCol" class="DivEditCol Hide"><input id="inputEditCol" onkeydown="EditColKeyDown(this,event);" type="text" value="' + Name + '"></div>' : '') +
                  '<div class="ColTitle">' +
                    '<div class="hoveredItem ColHoveredItem" ' + (CanEditActivityBoard ? ' oncontextmenu="OpenColumnContextMenu(this,event);"' : '') + '>' +
                    (CanEditActivityBoard ? '<div class="hoveredMenu" onclick="OpenColumnContextMenu(this,event);"></div>' : '')
                    + '</div>'
                    + '<span class="spnColName">' + safe_tags(Name) + '</span>' +
                  '</div>' +
                    (CanEditActivityBoard ?
                  '<div class="DivAddTask" onclick="return AddTask(this,true,event);">' +
                    '<div class="hoveredItem"></div>' +
                    '   <div class="imgAddTask material-icons">add</div>' +
                  '</div>' : '') + 
                  '<div class="ABRowsContainer"></div>' +
              '</div>');
    if (CanEditActivityBoard)
        $('[id=DivNewCol]').before(divCol);
    else {
        $('[id$=MainBoard]').append(divCol);
    }
    return divCol;
}

function SetSortableFunctionality() {
    if (!IsFiltered) {
        $(".portlet-toggle").remove();
        $(".ABRowsContainer").sortable({
            connectWith: ".ABRowsContainer",
            handle: ".ABRowHolder",
            placeholder: "portlet-placehoder ui-corner-all",
            receive: ItemDropped,
            update: itemSorted,
            cancel: ".TempRow",
            cursor: 'move',
            helper: 'clone'
        });
        $(".ABRow")
        .addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
            .find(".ABRowHolder")
                    .addClass("ui-widget-header ui-corner-all").prepend("<span class='ui-icon ui-icon-minusthick portlet-toggle'></span>");
        $(".portlet-toggle").on("click", function () {
            var icon = $(this);
            icon.toggleClass("ui-icon-minuthick ui-icon-plusthick");
            icon.closest(".ABRow").find(".ABRowHolder").toggle();
        });
    }

    $(".Colportlet-toggle").remove();
    $("[id$=MainBoard]").sortable({
        connectWith: "[id$=MainBoard]",
        handle: ".ColTitle",
        cancel: ".AddNewCol",
        placeholder: "Colportlet-placehoder ui-corner-all",
        axis: 'x',
        cursor: 'move',
        forcePlaceholderSize: true,
        opacity: 0.8,
        items: '.ABCol',
        update: ColSorted,
    });
    $(".ABCol")
    .addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
        .find(".ColTitle")
                .addClass("ui-widget-header ui-corner-all").append("<span class='ui-icon ui-icon-minusthick Colportlet-toggle'></span>");
    $(".Colportlet-toggle").on("click", function () {
        var icon = $(this);
        icon.toggleClass("ui-icon-minuthick ui-icon-plusthick");
        icon.closest(".ABCol").find(".ColTitle").toggle();
    });
}

function ItemDropped(event, ui) {
    var ToColumnId = $(event.target).parents('.ABCol')[0].id.replace('ABCol_', '');
    var Tasks = Array.prototype.slice.call($(ui.item[0]).parents('.ABRowsContainer')[0].children);
    var Position = Tasks.indexOf(ui.item[0]) + 1;
    ui.item.attr('colid', ToColumnId);
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/CardViewDropped",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ TaskId: ui.item[0].id.replace('ABRow_', ''), FromColumnId: ui.item.attr('colid'), ToColumnId: ToColumnId, Position: Position }),
        dataType: "json",
        async: true,
        success: function (data) {
            if (data.d == 'F') alert('The action could not be taken, please refresh the page and try again.');
        },
        error: function (data) {
            alert('The action could not be taken, please refresh the page and try again.');
        }
    });
}

function itemSorted(event, ui) {
    if ($(event.target).find('[id=' + ui.item[0].id + ']').length == 0) return;
    if (ui.item.parents('.ABCol')[0].id.replace('ABCol_', '') != ui.item.attr('colid')) return;
    var Tasks = Array.prototype.slice.call($(ui.item[0]).parents('.ABRowsContainer')[0].children);
    var ToPosition = Tasks.indexOf(ui.item[0]) + 1;
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/ItemSorted",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ TaskId: ui.item[0].id.replace('ABRow_', ''), ToPosition: ToPosition }),
        dataType: "json",
        async: true,
        success: function (data) {
            if (data.d == 'F') alert('The action could not be taken, please refresh the page and try again.');
        },
        error: function (data) {
            alert('The action could not be taken, please refresh the page and try again.');
        }
    });
}


function ColSorted(event, ui) {
    var Cols = Array.prototype.slice.call($('[id$=MainBoard]')[0].children);
    var ToPosition = Cols.indexOf(ui.item[0]) + 1;
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/ColSorted",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ ColId: ui.item[0].id.replace('ABCol_', ''), ToPosition: ToPosition }),
        dataType: "json",
        async: true,
        success: function (data) {
            if (data.d == 'F') alert('The action could not be taken, please refresh the page and try again.');
        },
        error: function (data) {
            alert('The action could not be taken, please refresh the page and try again.');
        }
    });
}

function AddColumn(ShowText) {
    if (ShowText) {
        $("[id$=MainBoard]").sortable('option', 'disabled', true);
        $('.AddNewCol .ColTitle').addClass('Hide');
        $('.DivNewColText').removeClass('Hide');
        $('.DivNewColText input').focus().val('');        
    } else {
        $("[id$=MainBoard]").sortable('option', 'disabled', false);
        $('.AddNewCol .ColTitle').removeClass('Hide');
        $('.DivNewColText').addClass('Hide');
    }
    return false;
}

function EditColumn(sender, ShowText) {
    if (sender == null) {
        $('.DivEditCol').addClass('Hide');
        $('.ABCol .ColTitle').removeClass('Hide');
        return;
    }
    if (ShowText) {
        $(sender).parents('.ABCol').find('.DivEditCol').removeClass('Hide');
        var EditColumnInput = $(sender).parents('.ABCol').find('.DivEditCol input')[0];
        EditColumnInput.value = $(sender).parents('.ABCol').find('.spnColName')[0].innerText;
        EditColumnInput.focus();
        EditColumnInput.select();
        $(sender).parents('.ABCol').find('.ColTitle').addClass('Hide');
    } else {
        $(sender).parents('.ABCol').find('.DivEditCol').addClass('Hide');
        $(sender).parents('.ABCol').find('.ColTitle').removeClass('Hide');
    }
    return false;
}


function AddTask(Elem, ShowText, event) {
     if (!($('.DivNewColText').hasClass('Hide')))
         AddColumn(false);
     EditColumn(null, false);
    var CurrCol = $(Elem).parents('.ABCol');
    var ColId = CurrCol[0].id.replace('ABCol_', '');
    if (ColId == "0") return;
    $('.inputAddTask').parents('.ABRow').remove();
    var divRow = $('<div id="ABRow_0" class="ABRow TempRow" colid=' + ColId + '>' +
                  '<div class="ABRowHolder">' +
                   '<input id="inputAddTask" class="inputAddTask" type="text" PlaceHolder="' + TranslatedAddTask + '"></input>' +
                  '</div>' +
              '</div>');
    if (!IsFiltered)
       $(".ABRowsContainer").sortable('option','disabled', true);
    CurrCol.find('.ABRowsContainer').prepend(divRow);
    divRow.find('.inputAddTask').focus().keydown(function (e) {
        if (e.key === 'Enter') {
            var Currvalue = this.value;
            var CurrRow = $(this).parents('.ABRow');
            if (Currvalue == '') {
                CurrRow.remove();
                return;
            }
            //CurrRow.removeClass('TempRow');
            var ColDiv = $(this).parents('.ABCol');
            var ColId = ColDiv[0].id.replace('ABCol_', '');
            var Tasks = Array.prototype.slice.call(CurrRow.parents('.ABRowsContainer')[0].children);
            var Position = Tasks.indexOf(CurrRow[0]) + 1;
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/AddActivityBoardtask",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ TaskName: Currvalue.replace("\\", "\\\\").replace("'", "\\'"), ColId: ColId, Position: Position }),
                dataType: "json",
                async: true,
                success: function (RowId) {
                    if (RowId.d == 'F') {
                        alert('The action could not be taken, please refresh the page and try again.');
                        return;
                    }
                    $('[id=ABRow_0]').attr('id', 'ABRow_' + RowId.d);
                },
                error: function (data) {
                    alert('The action could not be taken, please refresh the page and try again.');
                }
            });
            var Row = { Id: 0, ColId: ColId, AttachImg: '', Title: Currvalue, AssignedToId: 0, Done: false, AssignedToInitials: '', AssignedToImg: '', DueDateText: '', DueDate: '', IsDueDatePast: false, NbrLikes: 0, NbrComments: 0, NbrSubTasks: 0, Flags: [] }
            AppendNewRow(Row, ColDiv, null, CurrRow);
            $(this).val('');
            SetSortableFunctionality();
            $('.inputAddTask').focus();
            return false;
        } else if (e.key === 'Escape') {
            $('.inputAddTask').parents('.ABRow').remove();
            if (!IsFiltered)
                $(".ABRowsContainer").sortable('option', 'disabled', false);
        }
    });
    if (event){
        if (event.stopPropagation)
            event.stopPropagation();
        else
            event.cancelBubble=true;
    }
    return false;
}
var CurrTaskId;
function OpenTaskPopup(Taskid) {
    CurrTaskId = Taskid.replace('ABRow_', '');
    OpenBoardPOPUpToRefresh('ActivityBoardTasksPopup.aspx?taskId=' + CurrTaskId, 1020, 520);
}

function OpenBoardPOPUpToRefresh(URL, Width, Height) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
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
    wnd.add_close(RedirectAfterClosed);
    return false;
}


function RedirectAfterClosed(oWnd, args) {
    if (CurrTaskId) {
        var date = new Date();
        date.setTime(date.getTime() + (30 * 1000));
        document.cookie = 'CurrTaskId' + "=" + escape(CurrTaskId) + ";expires=" + date.toGMTString() + "; path=/";
    }
     window.location.href = window.location.href;
}

function del_cookie(name) {
    document.cookie = name + '=; expires=Thu, 01-Jan-70 00:00:01 GMT; path=/';
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

var DateNotSelected = false
function showDueDatePopup(sender, e, atRight) {
    currentTextBox = sender;

    var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
    currentDatePicker = datePicker;
    if (datePicker.isPopupVisible()) {
        datePicker.hidePopup();
    };
    DateNotSelected = true;
    datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.getAttribute('DateValue')));
    DateNotSelected = false;
    var position = { x: $(sender).offset().left, y: $(sender).offset().top - 20 };
    datePicker.showPopup((!atRight) ? position.x + sender.offsetWidth - 220 : position.x, position.y + sender.offsetHeight + 20);

}

function DueDateSelected(sender, args) {
    if (!DateNotSelected) {
        if (currentTextBox != null) {
            var TaskId = $(currentTextBox).parents('.ABRow')[0].id.replace('ABRow_', '');
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateTaskDueDate",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ TaskId: TaskId, DueDate: args.get_newDate().toMMDDYYYYString() }),
                dataType: "json",
                async: false,
                success: function (SelectedDate) {
                    currentTextBox.setAttribute('DateValue', args.get_newValue());
                    currentTextBox.innerText = SelectedDate.d.DueDateText;
                    $(currentTextBox).removeClass('DivDueDateImg');
                    if (SelectedDate.d.IsDueDatePast) {
                        $(currentTextBox).addClass('DueDateRed');
                    } else {
                        $(currentTextBox).removeClass('DueDateRed');
                    }
                },
                error: function (data) {
                        alert('The action could not be taken, please refresh the page and try again.');
                }
            });
         }
    }
}

function OpenAssignUserPopupFromCardView(ele) {
    var TaskId = $(ele).parents('.ABRow')[0].id.replace('ABRow_', '');
    var wnd = window.radopen('AssignUserToTaskPopup.aspx?TaskId=' + TaskId + '&Source=ActivityBoardCardView');
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    wnd.setSize(448, 500);
    wnd.center();
    return false;
}

function OpenActivityBoardCopyTaskPopup(TaskId) {
    var wnd = window.radopen('ActivityBoardCopyTaskPopup.aspx?TaskId=' + TaskId);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    wnd.setSize(448, 500);
    wnd.center();
    wnd.add_close(RedirectAfterClosed);
    return false;
}


function OpenActivityBoardMoveTaskPopup(TaskId) {
    var wnd = window.radopen('ActivityBoardMoveTaskPopup.aspx?TaskId=' + TaskId);
    wnd.set_visibleTitlebar(false);
    wnd._topResizer.parentElement.className = "";
    wnd.setSize(448, 500);
    wnd.center();
    wnd.add_close(RedirectAfterClosed);
    return false;
}

function OpenColumnContextMenu(sender,event) {
    var menu = $find($('[id$=RadContextMenu1]')[0].id);
    menu.show(event);
    return false;
}

function OpenTaskContextMenu(sender, event) {
    var menu = $find($('[id$=RadContextMenu2]')[0].id);
    menu.show(event);
    return false;
}

function FireColumnCommand(sender,args){
    var commandName = args.get_item().get_value();;
    if (commandName == 'Edit') {
        EditColumn(null, false);
        AddColumn(false);
        $('.inputAddTask').parents('.ABRow').remove();
        if (!IsFiltered)
            $(".ABRowsContainer").sortable('option', 'disabled', false);
        EditColumn(args.get_targetElement(), true);
    }
    else if (commandName == 'Delete') {
        if (ConfirmDelete()) {
            var ColId = $(args.get_targetElement()).parents('.ABCol')[0].id.replace('ABCol_','');
            $(args.get_targetElement()).parents('.ABCol').remove();
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/DeleteActivityBoardColumn",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ ColId: ColId.toString() }),
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d == 'F')  alert('The action could not be taken, please refresh the page and try again.');                    
                },
                error: function (data) {
                    alert('The action could not be taken, please refresh the page and try again.');
                }
            });
            return true;
        }
    }
}

function OnTaskContextMenuShowing(sender, args) {
    var TaskItem = $(args.get_targetElement());
    if (!TaskItem.hasClass('ABRow')) {
        TaskItem = TaskItem.parents('.ABRow');
    }
    if(TaskItem.find('.IsDone').length==1){
        sender.findItemByValue('MarkDone').set_text(MenuItem_MarkUndone);
    } else {
        sender.findItemByValue('MarkDone').set_text(MenuItem_MarkDone);
    }
    if (TaskItem[0].getAttribute('nbrsubtasks') != "0") {
        sender.findItemByValue('DeleteTask').set_text(MenuItem_DeleteTaskAndSubTasks);
    } else {
        sender.findItemByValue('DeleteTask').set_text(MenuItem_DeleteTask);
    }
}

function FireTaskCommand(sender, args) {
    var commandName = args.get_item().get_value();
    var TaskItem = $(args.get_targetElement());
    if (!TaskItem.hasClass('ABRow')) {
        TaskItem = TaskItem.parents('.ABRow');
    }
    var TaskId = TaskItem[0].id.replace('ABRow_', '');
    switch (commandName) {
        case 'MarkDone':
            var IsDone;
            if (TaskItem.find('.IsDone').length == 0) {
                TaskItem.find('.ABRowHolder').addClass('IsDone');
                IsDone = true;
            } else {
                TaskItem.find('.ABRowHolder').removeClass('IsDone');
                IsDone = false;
            }

            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/ActivityBoardTaskMakeDone",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ TaskId: TaskId.toString(), IsDone: IsDone }),
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d == 'F') alert('The action could not be taken, please refresh the page and try again.');
                },
                error: function (data) {
                    alert('The action could not be taken, please refresh the page and try again.');
                }
            });            
            break;
        case 'DeleteTask':
            if (ConfirmDelete()) {
                TaskItem.remove();
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/DeleteActivityBoardTask",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ TaskId: TaskId.toString() }),
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == 'F') alert('The action could not be taken, please refresh the page and try again.');
                    },
                    error: function (data) {
                        alert('The action could not be taken, please refresh the page and try again.');
                    }
                });
            }
            break;
        case 'CopyTask':
            OpenActivityBoardCopyTaskPopup(TaskId);
            break;
        case 'MoveTask':
            OpenActivityBoardMoveTaskPopup(TaskId);
            break;
        default:
    }

}


function unbindDropEvent() {
    var dropZone = document.querySelector('.Js-DropZone');
    if (!dropZone) return;
    dropZone.removeEventListener('drop', DropEvent);
}

function appendDropEvent() {
    unbindDropEvent();
    var dropZone = document.querySelector('.Js-DropZone');
    if (!dropZone) return;
    dropZone.addEventListener('dragover', function (event) {
        event.stopPropagation();
        event.preventDefault();
        // Style the drag-and-drop as "copy file" operation
        event.dataTransfer.dropEffect = 'copy';
    })
    dropZone.addEventListener('drop', DropEvent);
}

async function DropEvent(event){
    let queue = [];
    let folders = [];
    let files = [];
    let filesList = [];
    let lst = new DataTransfer();
    var myFileList;
    var empty = 0;

    if (event.target && (($(event.target).parents("[id$=rdtActivityBoards]").length == 1) || ($(event.target).parents(".ABRow").length == 1))){
        var taskId = 0;
        var element = event.target;
        
        if (($(event.target).parents("[id$=rdtActivityBoards]").length == 1)){
            while (element.tagName !== 'TR'){
                element = element.parentElement;
            }
            taskId = $find(element.id).get_dataKeyValue("Id");
        
            if (taskId.indexOf("Col_") >= 0) {
                event.stopPropagation();
                event.preventDefault();
                return;
            }        
        } 

        if (($(event.target).parents(".ABRow").length == 1)){
            taskId = $(event.target).parents(".ABRow")[0].id.replace("ABRow_","");
        }
        
        $("[id$=hdnTaskId]").val(taskId);  

        const addFile = entry => {
            return new Promise(function(resolve,reject){
                entry.file(function(el){resolve(filesList.push(el))})
            })
        }

        const scanFiles =  (item) => {
            return new Promise(async function(resolve,reject) {
                if(item.isDirectory){
                    folders.push(item);
                    await checkIfEmpty(item);
                    if(empty == 1)
                        resolve(1);
                    else{
                        await readDirectoryEntry(item);
                        let directoryReader = item.createReader();
                        directoryReader.readEntries(function(entries){
                            entries.forEach(function(entry,index){
                                if(index == entries.length - 1)
                                    resolve(1);
                            })
                        
                        })
                    }
                }
            });
        }
         

        function readDirectoryEntry(item)
        {
            return new Promise((resolve,reject) => {
                let directoryReader = item.createReader();
                directoryReader.readEntries(async function(entries){
                        
                    await entries.forEach(async function(entry,index){
                        if(entry.isDirectory)
                        {     await scanFiles(entry);
                            if(index == entries.length - 1)
                                resolve(1);}
                        else
                        {
                            files.push(entry);
                            await addFile(entry);
                            if(index == entries.length - 1)
                                resolve(1);
                        }
                    })
                       
                
                    })
            })
        }
        
        const checkIfEmpty = entry =>{
            return new Promise((resolve,reject) =>{
                let directoryReader = entry.createReader();
                directoryReader.readEntries(function(entries){
                    if(entries.length == 0)
                        resolve(empty = 1);
                    else
                        resolve(empty = 0);
                })
            })
                
        }
        event.stopPropagation();
        event.preventDefault();    

        for (const it of event.dataTransfer.items) {
            if (it.kind != 'string') {
                var entry = it.webkitGetAsEntry();
                if (entry.isDirectory) {
                    queue.push(scanFiles(entry).then());
                }
                else {
                    files.push(entry);
                    queue.push(addFile(entry).then());
                }
            }
        }
        await Promise.all(queue);
                    
        for(var i=0;i<filesList.length;i++)
        {
            lst.items.add(filesList[i]);

        }
        var rauFiles = document.querySelector(".inputFile");
        rauFiles.files = lst.files;
        if(files.length>  0 || folders.length > 0)
        {
            var btn = document.querySelector(".btnUpload");
            btn.click();
        }
    } else {
        event.stopPropagation();
        event.preventDefault();
    }
}