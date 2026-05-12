var SaveDetails = 0;

function UpdateRemDurationFromPctChecked() {
    if (document.getElementById('ctl00_CPH1_chkAllowPctCompleteUpdateRemDuration').checked == true) {
        return true;
    } else {
        return false;
    }
}

function UpdateActualFromPcChecked() {
    if (document.getElementById('ctl00_CPH1_chkAllowPctCompleteUpdateActual').checked == true) {
        return true;
    } else {
        return false;
    }
}

function DeleteButtonClicked() {
    var rows = Grids[0].GetSelRows();
    var SelectedTasks = '';
    for (i = 0; i < rows.length; i++) {
        var id = rows[i].id;
        if (rows[i].id > 0) {
            SelectedTasks = SelectedTasks + ';' + id;
        }
    }
    if (SelectedTasks != '') {
        var result = confirm(Msg_ConfirmDeleteTasks);
        if (result) {
            var GridMain = $(".RadMultiPage .GridMain");
            var left = GridMain.offset().left + ((GridMain.width() / 2) - 70);
            var top = GridMain.offset().top + ((GridMain.height() / 2) - 10);
            var MessageDiv = $(".GQMessage")[0];
            MessageDiv.setAttribute("style", "position: absolute; left: " + left + "px; top:" + top + "px;width: 140px; visibility: visible;");
            MessageDiv.innerHTML = DeletingMessage;
            $(".GQMessageShadow")[0].setAttribute("style", "position: absolute; left: " + left + "px; top:" + top + "px;width: 140px; visibility: visible;");
            $(".GQDisabled")[0].style.display = "";

            var hfSelectedTasksIds = $("[id$=hfSelectedTasksIds]")[0];
            hfSelectedTasksIds.value = SelectedTasks;
            var btnDeleteSelectedTasks = $("input[id$=btnDeleteSelectedTasks]")[0];
            btnDeleteSelectedTasks.click();
            return true;
        }
    }
}

Grids.OnDataSend = function (G, Source, Data, Func) {
    if ($('[id=ctl00_hdnRecordId]').length == 1)
        Source.Param['hdnRecordId'] = $('[id=ctl00_hdnRecordId]')[0].value;
    return null;
}

//Grids.OnDataReceive = function (G, Source) {
//    if (Source.Name == "Data") 
//        $("[id=TreeGanttContainer]").width(document.documentElement.clientWidth - $("[id=TreeGanttContainer]").offset().left - 3);   
//}

Grids.OnGanttStart = function (G) {
    //var ColKeys = Object.keys(G.Cols);
    //for (i = 0; i < ColKeys.length; i++) {
    //    if (ColKeys[i] != 'G')
    //        G.HideCol(ColKeys[i]);
    //}

    var GroupArr = G.Group.split(',');
    for (i = 0; i <= GroupArr.length - 1; i++) {
        if ((G.ColNames[0].indexOf(GroupArr[i]) < 0) && (G.ColNames[1].indexOf(GroupArr[i]) < 0)) {
            GroupArr.splice(i, 1);
            i -= +1;
        }
    }
    G.Group = '';
    for (i = 0; i <= GroupArr.length - 1; i++) {
        G.Group += GroupArr[i];
        G.Group += ',';
    }
    if (G.Group != '') {
        G.Group = G.Group.substr(0, G.Group.length - 1);
    }
    if (G.Cols.G.GanttDuration == 'Duration') {
        var Row = G.GetFirst(null, null);
        while (Row != null) {
            if ((Row.id > 0) && (Get(Row, 'TaskSheetId') == TaskSheetId) && (Row.E != Row.E1)) {
                G.SetValue(Row, 'Changed', 1, false);
                G.SetValue(Row, 'EChanged', 1, false);
            }
            Row = G.GetNext(Row);
        }
    }
    if (typeof ScheduleTasks !== 'undefined') {
        G.Cols.G.GanttCorrectDependencies = ScheduleTasks;
    } else {
        G.Cols.G.GanttCorrectDependencies = 0;
    }
}

Grids.OnRenderFinish = function (G) {
    if (SaveDetails == 1) {
        SaveDetails = 0;
        Grids[0].Save();
    }
    if (SortMain) {
        SortMain = false;
        G.SortClick('N2', 0);
    }
}

var CommitChanges = false;

Grids.OnValueChanged = function (G, row, col, val, oldval) {
    /**Flag Date Issue*/
    //if (val && (col == 'M')) {
    //    val = CalculateTaskEndDate(parseInt(val), 2);
    //}
    CommitChanges = false;
    if (col == 'EChanged' || col == 'TF') { return val; }
    if (row.id > 0) {
        if (col == 'Disabled' && G.HasChildren(row)) {
            G.DisableGanttMain(row, 'G', 0, val);
            return val;
        }

        /*Duration Changed*/
        if (col == 'Duration') {
            if (val < 0) { val = 0; }
            if (UpdateRemDurationFromPctChecked() == true) { G.SetValue(row, 'RemDuration', (val - val * Get(row, 'C') / 100), true); }
        }

        /*Cost Changed*/
        if ((col == 'Cost') && (UpdateActualFromPcChecked() == true)) {
            G.SetValue(row, 'ActualCost', val * Get(row, 'C') / 100, true);
        }

        /*Revenue Changed*/
        if ((col == 'Revenue') && (UpdateActualFromPcChecked() == true)) {
            G.SetValue(row, 'ActualRevenue', val * Get(row, 'C') / 100, true);
        }

        /*Rem  Changed*/
        if (col == 'RemDuration') {
            if (val < 0) { val = 0; }
            if (UpdateRemDurationFromPctChecked() == true) {
                if (Get(row, 'C') != 100) {
                    var Durationval = (Math.round(val * 100 / (100 - Get(row, 'C'))));
                    CommitChanges = true;
                    while (Durationval < val) { Durationval += 1; }
                    G.SetValue(row, 'Duration', Durationval, true);
                    CommitChanges = false;
                    if (Durationval != '0') {
                        G.SetString(row, 'C', (1 - val / Durationval) * 100, true);
                    } else {
                        G.SetString(row, 'C', 0, true);
                    }
                    if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Cost') != '')) {
                        G.SetString(row, 'ActualCost', Get(row, 'Cost') * Get(row, 'C') / 100, true);
                    }
                    if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Revenue') != '')) {
                        G.SetString(row, 'ActualRevenue', Get(row, 'Revenue') * Get(row, 'C') / 100, true);
                    }
                } else {
                    val = 0;
                }
            }
        }

        /*Pct Complete Changed*/
        if (col == 'C') {
            if (val < 0) { val = 0; }
            if ((UpdateRemDurationFromPctChecked() == true) && (Get(row, 'Duration') != '')) { G.SetValue(row, 'RemDuration', (Get(row, 'Duration') - Get(row, 'Duration') * val / 100), true); }
            if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Cost') != '')) { G.SetValue(row, 'ActualCost', Get(row, 'Cost') * val / 100, true); }
            if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Revenue') != '')) { G.SetValue(row, 'ActualRevenue', Get(row, 'Revenue') * val / 100, true); }
            if (val == 100) {
                if (Get(row, 'AS') == '')
                    G.SetString(row, 'AS', Get(row, 'S'), true);
                if (Get(row, 'AF') == '')
                    G.SetString(row, 'AF', Get(row, 'E'), true);
            } else if (val > 0 && Get(row, 'AS') == '') {
                if (Get(row, 'S') != '')
                    G.SetString(row, 'AS', Get(row, 'S'), true);
                else if (Get(row, 'E') != '' && Get(row, 'AF') == '')
                    G.SetString(row, 'AF', Get(row, 'E'), true);
            }

            if (Get(row, 'AS') != '' && Get(row, 'AF') != '' && Get(row, 'AS') > Get(row, 'AF')) {
                G.SetString(row, 'ActualDuration', Get(row, 'Duration'), true);
                G.SetValue(row, 'AF', CalculateTaskEndDate(Get(row, 'AS'), Get(row, 'ActualDuration')), true);
            }
            G.SetString(row, 'ActualDuration', CalculateTaskDuration(Get(row, 'AS'), Get(row, 'AF')), true);
        }


        /*Baseline Finish Changed*/
        if (col == 'BF') {
            val = ValidateDate(val);
            if (val == '') { G.SetString(row, 'OriginalDuration', 0, true); }
            else if (Get(row, 'BS') && val < Get(row, 'BS')) {
                G.SetString(row, 'BS', val, true);
            }
            G.SetValue(row, 'OriginalDuration', CalculateTaskDuration(Get(row, 'BS'), val), true);
        }

        /*Baseline Start Changed*/
        if (col == 'BS') {
            if (val == '') { G.SetString(row, 'OriginalDuration', 0, true); }
            else {
                val = ValidateDate(val);
                if (Get(row, 'BF') && val > Get(row, 'BF')) {
                    G.SetString(row, 'BF', val, true);
                    G.SetValue(row, 'OriginalDuration', 1, true);
                }
                else {
                    G.SetString(row, 'BF', CalculateTaskEndDate(val, Get(row, 'OriginalDuration')), true);
                }
            }
        }

        /*Baseline Duration Changed*/
        if (col == 'OriginalDuration') {
            if (val < 0) { val = 0; }
            if (Get(row, 'BS') != '') {
                G.SetString(row, 'BF', CalculateTaskEndDate(Get(row, 'BS'), val), true);
            }
            else {
                val = 0;
            }
        }

        /*Actual Finish Changed*/
        if (col == 'AF') {
            if (val == '') {
                G.SetString(row, 'ActualDuration', 0, true);
            }
            else {
                val = ValidateDate(val);
                if (Get(row, 'AS') && val < Get(row, 'AS')) {
                    G.SetString(row, 'AS', val, true);
                    G.SetString(row, 'S', val, true);
                }
                G.SetString(row, 'ActualDuration', CalculateTaskDuration(Get(row, 'AS'), val), true);
                CommitChanges = true;
                G.SetString(row, 'E', val, true);
                CommitChanges = false;
                G.SetString(row, 'C', '100', true);
                if ((UpdateRemDurationFromPctChecked() == true) && (Get(row, 'Duration') != '')) { G.SetValue(row, 'RemDuration', 0, true); }
                if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Cost') != '')) { G.SetValue(row, 'ActualCost', Get(row, 'Cost'), true); }
                if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Revenue') != '')) { G.SetValue(row, 'ActualRevenue', Get(row, 'Revenue'), true); }
            }
        }

        /*Actual Start Changed*/
        if (col == 'AS') {
            if (val == '') {
                G.SetString(row, 'ActualDuration', 0, true);
            }
            else {
                val = ValidateDate(val);
                if (Get(row, 'AF') && val > Get(row, 'AF')) {
                    val = Get(row, 'AF');
                    G.SetValue(row, 'ActualDuration', 1, true);
                } else {
                    if (Get(row, 'ActualDuration') != '')
                        G.SetValue(row, 'AF', CalculateTaskEndDate(val, Get(row, 'ActualDuration')), true);
                    else if (Get(row, 'AF') != '')
                        G.SetValue(row, 'ActualDuration', CalculateTaskDuration(val, Get(row, 'AF')), true);
                }
                CommitChanges = true;
                G.SetString(row, 'S', val, true);
                CommitChanges = false;
            }
        }

        /*Actual Duration Changed*/
        if (col == 'ActualDuration') {
            if (val < 0) { val = 0; }
            if (Get(row, 'AS') != '') {
                var End = CalculateTaskEndDate(Get(row, 'AS'), val);
                G.SetString(row, 'AF', CalculateTaskEndDate(Get(row, 'AS'), val), true);
                if (End != '') {
                    CommitChanges = true;
                    G.SetString(row, 'E', End, true);
                    CommitChanges = true;
                    G.SetString(row, 'C', '100', true);
                    CommitChanges = false;
                }
            }
            else {
                val = 0;
            }
        }

        /*Actual Cost Changed*/
        if ((col == 'ActualCost') && (UpdateActualFromPcChecked() == true)) {
            if (Get(row, 'C') != 0) {
                G.SetValue(row, 'Cost', (val * 100) / Get(row, 'C'), true);
            }
        }
        /*Actual Revenue Changed*/
        if ((col == 'ActualRevenue') && (UpdateActualFromPcChecked() == true)) {
            if (Get(row, 'C') != 0) {
                G.SetValue(row, 'Revenue', (val * 100) / Get(row, 'C'), true);
            }
        }

        /*Finished Changed*/
        if ((col == 'IsFinished')) {
            if (val == true) {
                G.SetValue(row, 'C', '100', true);
                var currDate = new Date();
                G.SetString(row, 'AF', ValidateDate(Date.UTC(currDate.getFullYear(), currDate.getMonth(), currDate.getDate())), true);
                if (Get(row, 'AS') == '' || (Get(row, 'AF') < Get(row, 'AS'))) {
                    G.SetString(row, 'AS', ValidateDate(Date.UTC(currDate.getFullYear(), currDate.getMonth(), currDate.getDate())), true);
                }
                G.SetValue(row, 'ActualDuration', CalculateTaskDuration(Get(row, 'AS'), Get(row, 'AF')), true);
                if ((UpdateRemDurationFromPctChecked() == true) && (Get(row, 'Duration') != '')) {
                    G.SetValue(row, 'RemDuration', '0', true);
                }
                if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Cost') != '')) { G.SetValue(row, 'ActualCost', Get(row, 'Cost') * Get(row, 'C') / 100, true); }
                if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Revenue') != '')) { G.SetValue(row, 'ActualRevenue', Get(row, 'Revenue') * Get(row, 'C') / 100, true); }
            }
        }

        if (col == 'ESC') {
            G.SetString(row, 'LFC', '', true);
            G.SetString(row, 'EFC', '', true);
        }
        if (col == 'LSC') {
            G.SetString(row, 'LFC', '', true);
            G.SetString(row, 'EFC', '', true);
        }
        if (col == 'EFC') {
            G.SetString(row, 'ESC', '', true);
            G.SetString(row, 'LSC', '', true);
        }
        if (col == 'LFC') {
            G.SetString(row, 'ESC', '', true);
            G.SetString(row, 'LSC', '', true);
        }
    }
    return val;
}

Grids.OnAfterValueChanged = function (G, row, col) {
    if (row.id > 0 && G.Cols.G.GanttCorrectDependencies == 1 && (col == 'AS' || col == 'AF' || col == 'ActualDuration' || (col = 'RemDuration' && UpdateRemDurationFromPctChecked() == true))) {
        G.CorrectDependencies(row)
    }
}


var NotLoop = true;
/****************************************** OnChange **************************************/
Grids.OnChange = function (G, row, col, Event) {
    if (!(row.id > 0)) return;
    if ((Event.PartType != 'Gantt') && CommitChanges) {
        CommitChanges = false;
        /*Early Finish Set*/
        if ((row.id > 0) && (col == 'E')) {
            if ((parseFloat(Get(row, 'E')) > 0) && (parseFloat(Get(row, 'S')) > 0)) {
                if (parseFloat(Get(row, 'E')) < parseFloat(Get(row, 'S'))) {
                    G.SetString(row, 'S', Get(row, 'E'), true);
                }
                var durationVal = CalculateTaskDuration(Get(row, 'S'), Get(row, 'E'));
                if (Get(row, 'Duration') != durationVal) { G.SetString(row, 'Duration', durationVal, true); }
            } else {
                if (Get(row, 'Duration') != '0') { G.SetString(row, 'Duration', '0', true); }
            }
        }
        /*Early Start Set*/
        if ((row.id > 0) && (col == 'S')) {
            if ((parseFloat(Get(row, 'E')) > 0) && (parseFloat(Get(row, 'S')) > 0)) {
                if (parseFloat(Get(row, 'E')) < parseFloat(Get(row, 'S'))) {
                    G.SetString(row, 'E', Get(row, 'S'), true);
                }
                var TaskDurationVal = CalculateTaskEndDate(Get(row, 'S'), Get(row, 'Duration'));
                if (Get(row, 'E') != TaskDurationVal) { G.SetString(row, 'E', TaskDurationVal, true); }
            }
            if ((parseFloat(Get(row, 'E')) > 0) && !(parseFloat(Get(row, 'S')) > 0)) {
                G.SetString(row, 'Duration', '0', true);
                G.SetString(row, 'S', Get(row, 'E'), true);
                G.SetString(row, 'E', '', true);
            }
        }

        /*Pct Complete Set*/
        if ((row.id > 0) && (col == 'C')) {
            if ((UpdateRemDurationFromPctChecked() == true) && (Get(row, 'Duration') != '')) {
                G.SetString(row, 'RemDuration', (Get(row, 'Duration') - Get(row, 'Duration') * Get(row, 'C') / 100), true);
            }
            if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Cost') != '')) {
                G.SetString(row, 'ActualCost', Get(row, 'Cost') * Get(row, 'C') / 100, true);
            }
            if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Revenue') != '')) {
                G.SetString(row, 'ActualRevenue', Get(row, 'Revenue') * Get(row, 'C') / 100, true);
            }
        }

        /*Duration Set*/
        if ((row.id > 0) && (col == 'Duration')) {
            if (Get(row, 'S') != '') {
                G.SetString(row, 'E', CalculateTaskEndDate(Get(row, 'S'), Get(row, 'Duration')), true);
            }
            if (UpdateRemDurationFromPctChecked() == true) {
                G.SetString(row, 'RemDuration', (Get(row, 'Duration') - Get(row, 'Duration') * Get(row, 'C') / 100), true);
            }
        }
        if ((row.id > 0) && ((col == 'Duration') || (col == 'S') || (col == 'E'))) {
            G.Calculate(1, 0);
        }
    }

    if (NotLoop == true) {
        NotLoop = false;
        if (col == 'TaskType') {
            switch (Get(row, 'TaskType')) {
                case 0:
                    if (!(parseFloat(Get(row, 'E')) > 0) || !(parseFloat(Get(row, 'S')) > 0)) {
                        if (!(parseFloat(Get(row, 'E')) > 0) && !(parseFloat(Get(row, 'S')) > 0)) {
                            var currDate = new Date();
                            G.SetString(row, 'S', Date.UTC(currDate.getFullYear(), currDate.getMonth(), currDate.getDate()), true);
                            G.SetString(row, 'E', Date.UTC(currDate.getFullYear(), currDate.getMonth(), currDate.getDate()), true);
                        } else if (parseFloat(Get(row, 'S')) > 0) {
                            G.SetString(row, 'E', Get(row, 'S'), true);
                        } else if (parseFloat(Get(row, 'E')) > 0) {
                            G.SetString(row, 'S', Get(row, 'E'), true);
                        }
                        G.SetString(row, 'Duration', 1, true);
                        G.Calculate(1, 0);
                    }
                    break;
                case 1:
                    if (!(parseFloat(Get(row, 'S')) > 0) || (parseFloat(Get(row, 'E')) > 0)) {
                        if (!(parseFloat(Get(row, 'S')) > 0)) {
                            if (parseFloat(Get(row, 'E')) > 0) {
                                G.SetString(row, 'S', Get(row, 'E'), true);
                            } else {
                                var currDate = new Date();
                                G.SetString(row, 'S', Date.UTC(currDate.getFullYear(), currDate.getMonth(), currDate.getDate()), true);
                            }
                        }
                        G.SetString(row, 'E', '', true);
                        G.SetString(row, 'Duration', 0, true);
                        G.Calculate(1, 0);
                    }
                    break;
                case 2:
                    if ((parseFloat(Get(row, 'S')) > 0) || (!parseFloat(Get(row, 'E')) > 0)) {
                        if (!(parseFloat(Get(row, 'E')) > 0)) {
                            if (parseFloat(Get(row, 'S')) > 0) {
                                G.SetString(row, 'E', Get(row, 'S'), true);
                            } else {
                                var currDate = new Date();
                                G.SetString(row, 'E', Date.UTC(currDate.getFullYear(), currDate.getMonth(), currDate.getDate()), true);
                            }
                        }
                        G.SetString(row, 'S', '', true);
                        G.SetString(row, 'Duration', 0, true);
                        G.Calculate(1, 0);
                    }
                    break;
            }
        }
        if (col == 'Duration' || col == 'S' || col == 'E') {
            if ((parseFloat(Get(row, 'E')) > 0) && (parseFloat(Get(row, 'S')) > 0)) {
                G.SetString(row, 'TaskType', 0, true);
            } else if (parseFloat(Get(row, 'S')) > 0) {
                G.SetString(row, 'TaskType', 1, true);
            } else if (parseFloat(Get(row, 'E')) > 0) {
                G.SetString(row, 'TaskType', 2, true);
            } else {
                G.SetString(row, 'TaskType', 0, true);
            }
        }
        NotLoop = true;
    }

    if (col == 'R') {
        G.SetString(row, 'Res', G.GetString(row, 'R'), true);
    }
}

Grids.OnGanttLineChange = function (G, index) {
    if (index == -2) {
        G.RefreshGanttSlack();
    }
}

Grids.OnGanttChanged = function (G, row, col, item, val, val2) {

    if ((row.id > 0) && (item == 'Main' || item == 'Milestone')) {
        if (UpdateRemDurationFromPctChecked() == true) { G.SetString(row, 'RemDuration', (Get(row, 'Duration') - Get(row, 'Duration') * Get(row, 'C') / 100), true); }
    }

    if ((row.id > 0) && (item == 'Complete')) {
        if ((UpdateRemDurationFromPctChecked() == true) && (Get(row, 'Duration') != '')) { G.SetValue(row, 'RemDuration', (Get(row, 'Duration') - Get(row, 'Duration') * Get(row, 'C') / 100), true); }
        if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Cost') != '')) { G.SetValue(row, 'ActualCost', Get(row, 'Cost') * Get(row, 'C') / 100, true); }
        if ((UpdateActualFromPcChecked() == true) && (Get(row, 'Revenue') != '')) { G.SetValue(row, 'ActualRevenue', Get(row, 'Revenue') * Get(row, 'C') / 100, true); }
        if (Get(row, 'C') == 100) {
            if (Get(row, 'AS') == '')
                G.SetString(row, 'AS', Get(row, 'S'), true);
            if (Get(row, 'AF') == '')
                G.SetString(row, 'AF', Get(row, 'E'), true);
        } else if (Get(row, 'C') > 0 && Get(row, 'AS') == '') {
            if (Get(row, 'S') != '')
                G.SetString(row, 'AS', Get(row, 'S'), true);
            else if (Get(row, 'E') != '' && Get(row, 'AF') == '')
                G.SetString(row, 'AF', Get(row, 'E'), true);
        }

        if (Get(row, 'AS') != '' && Get(row, 'AF') != '' && Get(row, 'AS') > Get(row, 'AF')) {
            G.SetString(row, 'ActualDuration', Get(row, 'Duration'), true);
            G.SetValue(row, 'AF', CalculateTaskEndDate(Get(row, 'AS'), Get(row, 'ActualDuration')), true);
        }
        G.SetString(row, 'ActualDuration', CalculateTaskDuration(Get(row, 'AS'), Get(row, 'AF')), true);
    }

    if ((row.id > 0) && (item == 'Constraints')) {
        if (val2 == 'MinStart') {
            G.SetString(row, 'LFC', '', true);
            G.SetString(row, 'EFC', '', true);
        }
        if (val2 == 'MaxStart') {
            G.SetString(row, 'LFC', '', true);
            G.SetString(row, 'EFC', '', true);
        }
        if (val2 == 'MinEnd') {
            G.SetString(row, 'ESC', '', true);
            G.SetString(row, 'LSC', '', true);
        }
        if (val2 == 'MaxEnd') {
            G.SetString(row, 'ESC', '', true);
            G.SetString(row, 'LSC', '', true);
        }
    }

}

// --- Informational message when printing ---
Grids.OnClickButtonPrint = function () {
    alert("To successfully print the chart you should have chosen 'Printing of background colors and images' in your browser.\nIn IE in Internet options -> Advanced -> Print.\nIn FF in Page setup -> Format and options");
}

Grids.OnAfterSave = function (G, Result, AutoUpdate) {
    if (MainSaveClicked == false) {
        Grids[0].Reload();
    }
    else {
        var btnSaveTaskSheet = $("[id$=btnSaveTaskSheet]");
        btnSaveTaskSheet.click();
    }
    MainSaveClicked = false;
}

Grids.OnSave = function (G, row) {
    var GridMain = $(".RadMultiPage .GridMain");
    var left = GridMain.offset().left + ((GridMain.width() / 2) - 70);
    var top = GridMain.offset().top + ((GridMain.height() / 2) - 10);
    var MessageDiv = $(".GQMessage")[0];
    MessageDiv.setAttribute("style", "position: absolute; left: " + left + "px; top:" + top + "px;width: 140px; visibility: visible;");
    MessageDiv.innerHTML = SavingMessage;
    $(".GQMessageShadow")[0].setAttribute("style", "position: absolute; left: " + left + "px; top:" + top + "px;width: 140px; visibility: visible;");
    $(".GQDisabled")[0].style.display = "";
    var GanttBase = 0;
    var GanttFinish = 0;
    if (Grids[0].Cols.G.GanttBase !== '') {
        GanttBase = G.GetGanttBase();
    }
    if (Grids[0].Cols.G.GanttFinish !== '') {
        GanttFinish = G.GetGanttFinish();
    }
    $.ajax({
        type: "POST",
        url: "tasks.aspx/SaveGanttProperties",
        contentType: "application/json; charset=utf-8",
        data: "{'GanttBase':" + GanttBase + ",'GanttFinish':" + GanttFinish + "}",
        dataType: "json",
        async: true
    });
}

// --- Default Values ---
var count = 0;
Grids.OnRowCopy = function (G, Row, SourceRow) {
    G.SetValue(Row, 'CopiedFromId', Get(SourceRow, 'id'), true);
    G.SetValue(Row, 'DES', '', true);
    G.SetString(Row, 'S', Get(SourceRow, 'S'), false);
    G.SetString(Row, 'E', Get(SourceRow, 'E'), false);
    G.SetString(Row, 'Duration', Get(SourceRow, 'Duration'), false)
    G.SetString(Row, 'Disabled', Get(SourceRow, 'Disabled'), false);
    //G.SetString(Row, 'Def', Get(SourceRow, 'Def'), false);
    count += 1;
}


//var SelectedChildDate = {};

//Grids.OnClickButtonAddChild = function (G) {
//    var FocusedRows = Grids[0].GetFocusedRows();
//    if (FocusedRows.length == 1) 
//        SelectedChildDate[Get(FocusedRows[0], 'id')] = Get(FocusedRows[0], 'S');
//}

Grids.OnRowAdd = function (G, Row) {
    var CStart = '';
    //if (Row.parentNode.Level >= 0 && SelectedChildDate[Get(Row.parentNode, 'id')] != undefined)
    //    CStart = SelectedChildDate[Get(Row.parentNode, 'id')];
    //else 
    //    CStart = G.GetGanttBase();
    var StatusDate = new Date(Grids[0].Cols.G.GanttMark.substring(0, Grids[0].Cols.G.GanttMark.length - 2));
    CStart = Date.UTC(StatusDate.getFullYear(), StatusDate.getMonth(), StatusDate.getDate());
    //CStart = G.GetGanttBase();
    G.SetString(Row, 'S', CStart, false);
    G.SetString(Row, 'E', CStart, false);
    G.SetString(Row, 'Duration', CalculateTaskDuration(CStart, CStart), false)
    G.SetString(Row, 'Disabled', 0, false);
    G.SetString(Row, 'Def', Grids[0].Def.R, false);
    G.SetString(Row, 'DefParent', Grids[0].Def.Sum, false);
    G.SetString(Row, 'DefEmpty', Grids[0].Def.R, false);
}

Grids.OnRowAdded = function (G, Row) {
    //SelectedChildDate = {};
    if (Row.CopiedFromId.toString() != '0' && Row.CopiedFromId.toString() != '') {
        count -= 1;
        if (count == 0) {
            G.RefreshGantt(57);
            G.Save();
        }
    } else {
        G.RefreshGantt(57);
    }
}

Grids.OnRowMove = function (G, row, OldParent, OldNext) {
    G.RefreshGantt(57);
}

// --- Updates length of page for tree, for tree is used 1, for plain table 8 ---
Grids.OnGroup = function (G, Cols) {
    var GroupArr = G.Group.split(',');
    for (i = 0; i <= GroupArr.length - 1; i++) {
        if ((G.ColNames[0].indexOf(GroupArr[i]) < 0) && (G.ColNames[1].indexOf(GroupArr[i]) < 0)) {
            GroupArr.splice(i, 1);
            i -= +1;
        }
    }
    G.Group = '';
    for (i = 0; i <= GroupArr.length - 1; i++) {
        G.Group += GroupArr[i];
        G.Group += ',';
    }
    var RefreshGantt = ((G.Group == '' && Cols != '') || (G.Group != '' && Cols == '')) ? 1 : 0;
    G.Group += Cols;
    var value = G.Grouped && Cols && Cols.length ? 1 : 10;
    if (value == 1) G.GroupSortMain = 1;
    SaveGroupAndPageLength(Cols, value, RefreshGantt);
}

Grids.OnClickPanelGrouped = function (G) {
    var value = !G.Grouped && G.GroupCols && G.GroupCols.length ? 1 : 10;
    PageLengthChanged(value);
}


Grids.OnGetClass = function (G, row, col, cls) {
    if ((col != 'G') && Get(row, 'id').toString().indexOf('GR') == 0 && (col.length > 0) && (col != '_ConstWidth')) {
        var GroupCols = G.Group.split(',');
        return GroupCols[row.Level];
    }
    return null;
};

Grids.OnDblClick = function (G, row, col, x, y) {
    if ((col == 'R') && (row.id > 0) && (row.Added != 1) && (Get(row, 'TaskSheetId') == TaskSheetId)) {
        OpenPOPUp('ResourcesTasksPopup.aspx?Resources=' + G.GetValue(row, col), 800, 600, false)
    }
    return true;
}

Grids.OnClick = function (G, row, col, x, y) {
    if (((col == 'id') || (col == 'Attachments')) && (row.id > 0) && (row.Added != 1) && (Get(row, 'id') > 0) && (Get(row, 'TaskSheetId') == TaskSheetId)) {
        var id = Get(row, 'id');
        //G.Editing=0 From DocumentTasks
        if ((col == 'id') && (!IsDocumentTasks) && (typeof ShowTaskDetailTabs !== 'undefined' && ShowTaskDetailTabs != 'False')) {
            var hfTaskId = $("[id$=hfTaskId]")[0];
            //if (hfTaskId.value != id) {
            hfTaskId.value = id;
            var btnTaskClicked = $("input[id$=btnTaskClicked]")[0];
            btnTaskClicked.click();
            return true;
            //}           
        }
        else if (col == 'Attachments') {
            OpenviewAttachmentPopup("TASKSHEET", id, TaskSheetId, 1, ProjectId, true)
            return true;
        }
    }
}


var IsPopupClosed = false
var ReloadTaskDetails = true;
Grids.OnReload = function () {
    var hfTaskPopupClosed = $("[id$=hfTaskPopupClosed]")[0];
    if ((typeof hfTaskPopupClosed !== 'undefined') && (hfTaskPopupClosed != null)) {
        if (IsPopupClosed == true) {
            hfTaskPopupClosed.value = "1";
        } else {
            hfTaskPopupClosed.value = "0";
        }
    }
    IsPopupClosed = false;
    if (ReloadTaskDetails && !IsDocumentTasks) {
        var btnRefreshDetails = $("input[id$=btnRefreshDetails]")[0];
        btnRefreshDetails.click();
    }
    ReloadTaskDetails = true;
}

Grids.OnGanttSlack = function (G, row, col, bar, value, old, show) {
    if (Get(row, 'TaskSheetId') == TaskSheetId || row.Added == 1) {
        if (row.TF != value / (3600000 * 24)) {
            row.TF = value / (3600000 * 24);
            row.TFChanged = 1;
            row.Changed = 1;
            if (show) G.RefreshCell(row, 'TF');
        }
    }
}

Grids.OnRightClick = function (G, row, col, x, y, event) {
    if ((col == 'id') && (Get(row, 'id') > 0) && (row.id > 0) && (row.Added != 1) && Get(row, 'TaskSheetId') == TaskSheetId && (!IsDocumentTasks)) {
        OpenTaskDetailsPopup('ScheduleTaskPopup.aspx?TaskId=' + Get(row, 'id') + '&UpdateRemDurationFromPctChecked=' + UpdateRemDurationFromPctChecked() + '&UpdateActualFromPcChecked=' + UpdateActualFromPcChecked(), 1100, 545, true)
        return true;
    }

    if (col == 'R' && row.id > 0) {
        OpenPOPUp('ResourcesTasksPopup.aspx?Resources=' + G.GetValue(row, col), 800, 600, false);
        return true;
    }

    if (!IsDocumentTasks && (((col == 'S') || (col == 'E') || (col == 'BS') || (col == 'BF') || (col == 'AS') || (col == 'AF') || (col == 'LS') || (col == 'LF'))
         && (row.Added != 1) && (Get(row, 'id') > 0) && (Get(row, 'TaskSheetId') == TaskSheetId))) {
        var ProjectId = $find("ctl00_CPH1_ddlProjects").get_value();
        var ObjectTypeId = 69;
        var LocationId = 0;
        var ProgramId = 0;
        var IsDetail = 1;
        var FieldId = GetObjectTypeDetailColumnId(col);
        var RecordId = Get(row, 'id');
        var DocumentId = $("[id$=hdnTaskrecordId]")[0].value;
        if (DocumentId == "0" || DocumentId == "" || FieldId == 0) {
            return false
        }
        var SpecFieldId = 0;
        var CustomFormFieldId = 0;
        var CustomFormColumnDataId = 0;
        OpenPOPUp("DefineReminderPopup.aspx?ProjectId=" +
                            ProjectId + "&LocationId="
                            + LocationId
                            + "&ProgramId=" + ProgramId
                            + "&ObjectTypeId=" + ObjectTypeId + "&FieldId=" + FieldId + "&RecordId=" + RecordId + "&DocumentId=" + DocumentId + "&IsDetail=" + IsDetail + "&SpecFieldId=" + SpecFieldId + "&CustomFormFieldId=" + CustomFormFieldId + "&CustomFormColumnDataId=" + CustomFormColumnDataId, 477, 690, true);
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
}

function GetObjectTypeDetailColumnId(ColUniqueName) {
    if (ColUniqueName == 'S')
        return 1665;
    if (ColUniqueName == 'E')
        return 1666;
    if (ColUniqueName == 'BS')
        return 1667;
    if (ColUniqueName == 'BF')
        return 1668;
    if (ColUniqueName == 'AS')
        return 1669;
    if (ColUniqueName == 'AF')
        return 1670;
    if (ColUniqueName == 'LS')
        return 1671;
    if (ColUniqueName == 'LF')
        return 1672;
    return 0;
}

function RefreshGrid() {
    Grids[0].Reload();
}

function OpenPOPUp(URL, Width, Height, Refresh) {
    var Width = $telerik.$(window).width() * 0.9;
    var Height = $telerik.$(window).height() * 0.9;
    var wnd = window.radopen(URL);
    wnd.setSize(Width, Height);
    if (Refresh == true) {
        wnd.add_close(RefreshGrid);
    }
    wnd.Center();
    return false;
}

function popUpNote(isNew) {
    var gridId = 'rdgDocumentNotes';
    var AddClose = true;
    var URL = 'DocumentNotesEditor.aspx';
    var grid = $find(GridNoteId);
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    if ((grid.get_masterTableView().get_selectedItems().length > 0 && !isNew) || isNew) {
        if (isNew) URL = URL + '?IsNew=1'
        var wnd = window.radopen(URL);
        if (isMobileScreen()) {
            wnd.setSize(browserWidth - 10, browserHeight);
            wnd.moveTo(0, 0);
        } else {
            wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
            wnd.Center();
        }
        if (AddClose == true) {
            wnd.add_close(WindowClosed);
            if (gridId) { GridToRebind = gridId; }
        }
    }
    return false;
}

function OpenTaskDetailsPopup(URL, Width, Height, Refresh) {
    var browserWidth = $telerik.$(window).width();
    var browserHeight = $telerik.$(window).height();
    var wnd = window.radopen(URL);
    if (isMobileScreen()) {
        wnd.setSize(browserWidth - 10, browserHeight - 10);
        wnd.moveTo(0, 0);
    }
    else {
        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
        wnd.Center();
    }
    if (Refresh == true) {
        wnd.add_close(TaskPopupClosed);
    }
    return false;
}

function TaskPopupClosed() {
    IsPopupClosed = true;
    RefreshGrid();
}

var popupWindow;
function OpenPOPWindow(url, width, height, Refresh) {
    var left = (screen.width - width) / 2;
    var top = (screen.height - height) / 2;
    popupWindow = window.open(url, "",
                'location=0,status=0,menubar=0,resizable=1,scrollbars=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
    popupWindow.onunload = RefreshGrid;
    return false;
}

function CalculateTaskDuration(StartDate, EndDate) {
    var duration = 0;
    if ((typeof CalendarDaysExcluded === 'undefined') || (CalendarDaysExcluded == null)) { return 0; } //DocumentTasks
    if (EndDate == '') { return 0; }
    if (StartDate == '') { return 0; }
    var TimezoneOffset = new Date(StartDate).getTimezoneOffset() * 60000;
    TimezoneOffset = TimezoneOffset + 18000000; // Add 5 Hours as precaution To avoid losing a day on time zone differences and daylight savings
    duration = ((EndDate - StartDate) / (3600000 * 24)) + 1;
    while (StartDate <= EndDate) {
        if (CalendarDaysExcluded.indexOf(StartDate.toString()) > -1 || (CalendarWeekDaysOff.indexOf(new Date(StartDate + TimezoneOffset).getDay().toString()) > -1 && !(CalendarDaysIncluded.indexOf(StartDate.toString()) > -1))) {
            duration -= +1;
        }
        StartDate = StartDate + (3600000 * 24);
    }
    return duration;
}

function CalculateTaskEndDate(StartDate, Duration) {
    if ((typeof CalendarDaysExcluded === 'undefined') || (CalendarDaysExcluded == null)) { return 0; } //DocumentTasks
    if (Duration == 0) { return ''; }
    var wdc = 0; /* working Days Counter*/
    var DaysOff = 0; /* Days Off*/
    var TimezoneOffset = new Date(StartDate).getTimezoneOffset() * 60000;
    TimezoneOffset = TimezoneOffset + 18000000; // Add 5 Hours as precaution To avoid losing a day on time zone differences and daylight savings
    var RealStartDate = StartDate;
    while (wdc < Duration) {
        while (CalendarDaysExcluded.indexOf(RealStartDate.toString()) > -1 || (CalendarWeekDaysOff.indexOf(new Date(RealStartDate + TimezoneOffset).getDay().toString()) > -1 && !(CalendarDaysIncluded.indexOf(RealStartDate.toString()) > -1))) {
            RealStartDate = RealStartDate + (3600000 * 24);
            DaysOff += 1;
        }
        RealStartDate = RealStartDate + (3600000 * 24);
        wdc += 1;
    }
    var EndDate = StartDate + ((Duration + DaysOff - 1) * (3600000 * 24));
    return EndDate;
}

function ValidateDate(val) {
    var TimezoneOffset = new Date(val).getTimezoneOffset() * 60000;
    TimezoneOffset = TimezoneOffset + 18000000; // Add 5 Hours as precaution To avoid losing a day on time zone differences and daylight savings
    if ((typeof CalendarDaysExcluded === 'undefined') || (CalendarDaysExcluded == null)) { return 0; } //DocumentTasks
    while (CalendarDaysExcluded.indexOf(val.toString()) > -1 || (CalendarWeekDaysOff.indexOf(new Date(val + TimezoneOffset).getDay().toString()) > -1 && !(CalendarDaysIncluded.indexOf(val.toString()) > -1))) {
        val = val + (3600000 * 24);
    }
    return val;
}

var SortMain = false;
function SaveGroupAndPageLength(GroupCols, PageLength, RefreshGantt) {
    if (PageLength <= 0) { PageLength = 1; }
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/SaveGroupAndGanttPageLength",
        contentType: "application/json; charset=utf-8",
        data: "{'GroupCols':'" + GroupCols + "','PageLength':'" + PageLength + "'}",
        dataType: "json",
        async: true
    });
    if (RefreshGantt == 1 && TaskSheetId > 0) {
        if (PageLength == 1) SortMain = true;
        Grids[0].Reload();
    } else {
        Grids[0].PageLength = PageLength;
        Grids[0].CreatePages();
        Grids[0].Render();
        Grids[0].Render();
    }
}

function PageLengthChanged(val) {
    if (val <= 0) { val = 1; }
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/SaveGanttPageLength",
        contentType: "application/json; charset=utf-8",
        data: "{'PageLength':" + val + "}",
        dataType: "json",
        async: true
    });
    Grids[0].PageLength = val;
    Grids[0].CreatePages();
    Grids[0].Render();
    Grids[0].Render();
}

function ShowFilterChanged(val) {
    Grids[0].Filter.Visible = val;
    Grids[0].Render();
    var ShowFilter = false;
    if (val == 1) {
        ShowFilter = true;
    }
    $.ajax({
        type: "POST",
        url: "AjaxService.aspx/SaveGanttShowFilter",
        contentType: "application/json; charset=utf-8",
        data: "{'ShowFilter':" + ShowFilter + "}",
        dataType: "json",
        async: true
    });
}

Grids.OnFocus = function (G, row, col) {
    if ((row != null) && (!IsDocumentTasks)) {
        var AddChildVisible = false;
        var id = Get(row, 'id');
        if (id != null && Get(Get(row, 'Def'), 'Name') != 'Ext' && ((id.toString().indexOf('GR') == 0 && Get(row.firstChild, 'id').toString().indexOf('GR') < 0) || (G.Group == '' && id > 0))) {
            AddChildVisible = G.Adding;
        }
        if (G.Toolbar.AddChildVisible != AddChildVisible) {
            G.Toolbar.AddChildVisible = AddChildVisible;
            G.Toolbar.OutdentVisible = AddChildVisible;
            G.Toolbar.IndentVisible = AddChildVisible;
            G.RefreshRow(G.Toolbar);
        }
    }
}

Grids.OnBlur = function (G, orow, ocol) {
    if ((orow != null) && (!IsDocumentTasks)) {
        var id = Get(orow, 'id');
        if (id != null && (id.toString().indexOf('GR') == 0 || (G.Group == '' && id > 0))) {
            G.Toolbar.AddChildVisible = false;
            G.Toolbar.OutdentVisible = false;
            G.Toolbar.IndentVisible = false;
            G.RefreshRow(G.Toolbar);
        }
    }
}

function IsAddChildVisible() {
    if (IsDocumentTasks) return false;
    var FocusedRows = Grids[0].GetFocusedRows();
    if (FocusedRows.length == 0 || Get(FocusedRows[0], 'UCode') == null || Get(FocusedRows[0], 'Def') == 'Ext') return false;
    if (Get(FocusedRows[0], 'id').toString().indexOf('GR') == 0 || (Grids[0].Group == '' && Get(FocusedRows[0], 'id') > 0)) {
        return (Grids[0].Adding);
    } else {
        return false;
    }
}

var PassedFirstTime = false;
var IsCorrectAll = false;

Grids.OnCorrectDependenciesStart = function (G) {
    if (PassedFirstTime) {
        PassedFirstTime = false;
        return false;
    }
    PassedFirstTime = true;
    var DisabledValues = {};
    var CurrentGanttBase = '';
    if (!IsCorrectAll) {
        CurrentGanttBase = Grids[0].Cols.G.GanttBase;
        var StatusDate = new Date(Grids[0].Cols.G.GanttMark.substring(0, Grids[0].Cols.G.GanttMark.length - 2));
        var msStatusDate = Date.UTC(StatusDate.getFullYear(), StatusDate.getMonth(), StatusDate.getDate());
        if (CurrentGanttBase != '' && CurrentGanttBase >= msStatusDate) msStatusDate = CurrentGanttBase;
        Grids[0].SetGanttBase(msStatusDate, 1, null);
    }
    var Row = G.GetFirst(null, null);
    while (Row != null) {
        if (Row.id > 0 && Row.Calculated != 1) {
            DisabledValues[Row.id] = Get(Row, 'Disabled');
            if (Get(Row, 'AS') != '' || Get(Row, 'AF') != '') {
                if (Get(Row, 'Disabled') == 0)
                    Row.Disabled = 2;
            }
        }
        Row = G.GetNext(Row);
    }
    G.Calculate(1, 0);
    //Grids[0].RefreshGantt(57);

    G.CorrectAllDependencies();

    //Correcting Finished.
    PassedFirstTime = false;
    Row = G.GetFirst(null, null);
    while (Row != null) {
        if (Row.id > 0 && Row.Calculated != 1) {
            Row.Disabled = DisabledValues[Row.id];
        }
        Row = G.GetNext(Row);
    }
    if (!IsCorrectAll) {
        Grids[0].SetGanttBase(CurrentGanttBase, 1, null);
        G.Calculate(1, 0);
        Grids[0].RefreshGantt(57);
        Row = Grids[0].GetFirst(null, null);
        while (Row != null) {
            if (Row.id > 0) {
                Grids[0].RefreshCell(Row, 'TF');
                if (Row.Calculated == 1) {
                    Grids[0].RefreshCell(Row, 'S');
                    Grids[0].RefreshCell(Row, 'E');
                }
            }
            Row = Grids[0].GetNext(Row);
        }
    }
    IsCorrectAll = false;
    Grids[0].HideMessage();
    return true;
}

function PMCorrectDependencies() {
    //Object.keys(Grids[0].GetTasksToSchedule()).length; (Default behavior is to Correct Dependencies Only if this length >0)
    IsCorrectAll = true;
    var CurrGanttBase = Grids[0].Cols.G.GanttBase;
    var StatusDate = new Date(Grids[0].Cols.G.GanttMark.substring(0, Grids[0].Cols.G.GanttMark.length - 2));
    var msStatusDate = Date.UTC(StatusDate.getFullYear(), StatusDate.getMonth(), StatusDate.getDate());
    if (!(CurrGanttBase != '' && CurrGanttBase >= msStatusDate))
        Grids[0].SetGanttBase(msStatusDate, 1, null);

    Grids[0].CorrectAllDependencies();

    IsCorrectAll = false;
    Grids[0].SetGanttBase(CurrGanttBase, 1, null);
    Grids[0].Calculate(1, 0);
    Grids[0].RefreshGantt(57);

    var Row = Grids[0].GetFirst(null, null);
    while (Row != null) {
        if (Row.id > 0) {
            Grids[0].RefreshCell(Row, 'TF');
            if (Row.Calculated == 1) {
                Grids[0].RefreshCell(Row, 'S');
                Grids[0].RefreshCell(Row, 'E');
            }
        }
        Row = Grids[0].GetNext(Row);
    }
}

function OpenResourcePopup() {
    var rows = Grids[0].GetSelRows();
    var SelectedTasks = '';
    for (i = 0; i < rows.length; i++) {
        var id = rows[i].id;
        if (rows[i].id > 0) {
            SelectedTasks = SelectedTasks + ';' + id;
        }
    }
    if (SelectedTasks != '')
        OpenPOPUp('SelectResourcesPopup.aspx?Source=Schedules&TaskIds=' + SelectedTasks, 735, 540, true);
}

function AddResourceDisabled() {
    if (Grids[0].GetSelRows().length == 0) return true;
    var hasAddedRow = false;
    var Row = Grids[0].GetFirst(null, null);
    while (Row != null) {
        if (Row.id > 0 && Row.Added == 1) {
            hasAddedRow = true;
            break;
        }
        Row = Grids[0].GetNext(Row);
    }
    return hasAddedRow;
}

Grids.OnSelect = function (G, Row, Deselect, Cols) {
    if (Row != null) {
        Row.Selected = !Deselect;
        G.Recalculate(G.Toolbar, 'AddResourceDisabled', 1)
        G.RefreshCell(G.Toolbar, 'AddResource');
    }
}