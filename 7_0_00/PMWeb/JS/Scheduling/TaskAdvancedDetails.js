
function UpdateRemDurationFromPctCheckedPopup() {
    var chkAllowPctCompleteUpdateRemDuration = document.getElementById('ctl00_CPH1_chkAllowPctCompleteUpdateRemDuration');
    if (chkAllowPctCompleteUpdateRemDuration != null) {
        if (chkAllowPctCompleteUpdateRemDuration.checked == true) {
            return true;
        } else {
            return false;
        }
    }
    else {
        return UpdateRemDurationFromPctChecked;
    }
}

function UpdateActualFromPcCheckedPopup() {
    var chkAllowPctCompleteUpdateActual = document.getElementById('ctl00_CPH1_chkAllowPctCompleteUpdateActual');
    if (chkAllowPctCompleteUpdateActual != null) {
        if (chkAllowPctCompleteUpdateActual.checked == true) {
            return true;
        } else {
            return false;
        }
    }
    else {
        return UpdateActualFromPcChecked;
    }
}

var CalculateChanges = true;
var C;
var S;
var F;
var DurationDays;
var BS;
var BF;
var BaseLineDurationDays;
var AS;
var AF;
var ActualDurationDays;
var Cost;
var ActualCost;
var Revenue;
var ActualRevenue;
var RemDuration;
var TaskType;
var Grid;

function GridCreated(sender, args) {
    Grid = sender;
}
function AdjustDateCalculation() {
    if (Grid == null || Grid.get_masterTableView() == null)
        return;
    var dataItems = Grid.get_masterTableView().get_dataItems();
    CurrentRow = $(dataItems[0]._element);
    BaseLineRow = $(dataItems[1]._element);
    ActualRow = $(dataItems[2]._element);

    C = $("input[id$=txtPercentComplete]");
    C[0].onchange = PctCompleteChanged;

    RemDuration = $("input[id$=txtRemDuration]");
    RemDuration[0].onchange = RemDurationChanged;

    TaskType = $find($("[id$=ddlTaskTypes]")[0].id);

    S = $find(CurrentRow.find("[id$='dtpStartDate']")[0].id)._dateInput;
    F = $find(CurrentRow.find("[id$='dtpFinishDate']")[0].id)._dateInput;
    DurationDays = CurrentRow.find("input[id$='txtDurationDays']");
    Cost = CurrentRow.find("input[id$='txtCost']");
    Revenue = CurrentRow.find("input[id$='txtRevenue']");

    BS = $find(BaseLineRow.find("[id$='dtpStartDate']")[0].id)._dateInput;
    BF = $find(BaseLineRow.find("[id$='dtpFinishDate']")[0].id)._dateInput;
    BaseLineDurationDays = BaseLineRow.find("input[id$='txtDurationDays']");


    AS = $find(ActualRow.find("[id$='dtpStartDate']")[0].id)._dateInput;
    AF = $find(ActualRow.find("[id$='dtpFinishDate']")[0].id)._dateInput;
    ActualDurationDays = ActualRow.find("input[id$='txtDurationDays']");
    ActualCost = ActualRow.find("input[id$='txtCost']");
    ActualRevenue = ActualRow.find("input[id$='txtRevenue']");



    S.add_valueChanged(StartChanged);
    F.add_valueChanged(FinishChanged);
    DurationDays[0].onchange = DurationChanged;
    Cost[0].onchange = CostChanged;
    Revenue[0].onchange = RevenueChanged;

    BS.add_valueChanged(BaselineStartChanged);
    BF.add_valueChanged(BaselineFinishChanged);
    BaseLineDurationDays[0].onchange = BaseLineDurationChanged;

    AS.add_valueChanged(ActualStartChanged);
    AF.add_valueChanged(ActualFinishChanged);
    ActualDurationDays[0].onchange = ActualDurationChanged;
    ActualCost[0].onchange = ActualCostChanged;
    ActualRevenue[0].onchange = ActualRevenueChanged;
}

function StartChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (S.get_value().length > 0) {
            S.set_selectedDate(ValidateDate1(S.get_selectedDate()));
                F.set_selectedDate(CalculateTaskEndDate1(S.get_selectedDate(), CDbl(DurationDays.val())));
        }
        else {
            DurationDays.val(FPrec(0));
            if (UpdateRemDurationFromPctCheckedPopup() == true) {
                RemDuration.val(FPrec(0));
            }
        }
        setTaskType();
        CalculateChanges = true;
    }
}

function FinishChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (F.get_value().length > 0) {
            F.set_selectedDate(ValidateDate1(F.get_selectedDate()));
        }
        if ((S.get_value().length > 0) && (F.get_value().length > 0) && (F.get_selectedDate() < S.get_selectedDate())) {
            S.set_selectedDate(F.get_selectedDate());
        }
        DurationDays.val(FPrec(CalculateTaskDuration1(S.get_selectedDate(), F.get_selectedDate())));
        if (UpdateRemDurationFromPctCheckedPopup() == true) {
            RemDuration.val(FPrec(CDbl(DurationDays.val())));
        }
        setTaskType();
        CalculateChanges = true;
    }
}

function DurationChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        DurationDays.val(FPrec(Math.round(CDbl(DurationDays.val()))));
        if (CDbl(DurationDays.val()) == 0) {
            F.set_value('');
            if (UpdateRemDurationFromPctCheckedPopup() == true) {
                RemDuration.val(FPrec(0));
            }
            setTaskType();
            CalculateChanges = true;
            return;
        }
        if (CDbl(DurationDays.val()) < 0) {
            DurationDays.val(FPrec(0));
        }
        if (S.get_value().length > 0) {
            F.set_selectedDate(CalculateTaskEndDate1(S.get_selectedDate(), CDbl(DurationDays.val())));
        }
        else {
            DurationDays.val(FPrec(0));
        }
        if (UpdateRemDurationFromPctCheckedPopup() == true) {
            RemDuration.val(FPrec(CDbl(DurationDays.val()) - CDbl(DurationDays.val()) * CDbl(C.val()) / 100));
        }
        setTaskType();
        CalculateChanges = true;
    }
}



function ActualStartChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (AS.get_value().length > 0) {
            AS.set_selectedDate(ValidateDate1(AS.get_selectedDate()));
            if ((AF.get_value().length > 0) && (AS.get_selectedDate() > AF.get_selectedDate())) {
                AF.set_selectedDate(S.get_selectedDate());
            }
            CalculateChanges = true;
            S.set_selectedDate(AS.get_selectedDate());
            CalculateChanges = false;
            AF.set_selectedDate(CalculateTaskEndDate1(AS.get_selectedDate(), CDbl(ActualDurationDays.val())));
        }
        else {
            ActualDurationDays.val(FPrec(0));
        }
        CalculateChanges = true;
    }
}

function ActualFinishChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (AF.get_value().length > 0) {
           AF.set_selectedDate(ValidateDate1(AF.get_selectedDate()));
           if ((AS.get_value().length > 0)  && (AF.get_selectedDate() < AS.get_selectedDate())) {
               AS.set_selectedDate(AF.get_selectedDate());
           }
            CalculateChanges = true;
            F.set_selectedDate(AF.get_selectedDate());
            CalculateChanges = false;
            ActualDurationDays.val(FPrec(CalculateTaskDuration1(AS.get_selectedDate(), AF.get_selectedDate())));
            C.val(CPrct(100));
        }
        else {
            ActualDurationDays.val(FPrec(0));
        }
        CalculateChanges = true;
    }
}

function ActualDurationChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (AS.get_value().length > 0) {
            if (CDbl(ActualDurationDays.val()) == 0) { AF.set_value(''); CalculateChanges = true; return; }
            if (CDbl(ActualDurationDays.val()) < 0) { ActualDurationDays.val(FPrec(0)); }
            if (AS.get_value().length > 0) {
                CalculateChanges = true;
                AF.set_selectedDate(CalculateTaskEndDate1(AS.get_selectedDate(), CDbl(ActualDurationDays.val())));
                CalculateChanges = false;
            }
        }
        else {
            ActualDurationDays.val(FPrec(0));
        }
        CalculateChanges = true;
    }
}

function BaselineStartChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (BS.get_value().length > 0) {
            BS.set_selectedDate(ValidateDate1(BS.get_selectedDate()));
            BF.set_selectedDate(CalculateTaskEndDate1(BS.get_selectedDate(), CDbl(BaseLineDurationDays.val())));
        }
        else {
            BaseLineDurationDays.val(FPrec(0));
        }
        CalculateChanges = true;
    }
}

function BaselineFinishChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if ((BS.get_value().length > 0) && (BF.get_value().length > 0)) {
            BF.set_selectedDate(ValidateDate1(BF.get_selectedDate()));
            if (BF.get_selectedDate() < BS.get_selectedDate()) {
                BS.set_selectedDate(BF.get_selectedDate());
            }
            BaseLineDurationDays.val(FPrec(CalculateTaskDuration1(BS.get_selectedDate(), BF.get_selectedDate())));
        }
        else {
            BaseLineDurationDays.val(FPrec(0));
        }
        CalculateChanges = true;
    }
}

function BaseLineDurationChanged(sender, eventArgs) {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (CDbl(BaseLineDurationDays.val()) < 0) { BaseLineDurationDays.val((FPrec(0))); }
        if (BS.get_value().length > 0) {
            BF.set_selectedDate(CalculateTaskEndDate1(BS.get_selectedDate(), CDbl(BaseLineDurationDays.val())));
        }
        else {
            BaseLineDurationDays.val(FPrec(0));
        }
        CalculateChanges = true;
    }
}


function CostChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (UpdateActualFromPcCheckedPopup() == true) { ActualCost.val(FPrec(CDbl(Cost.val()) * CDbl(C.val()) / 100)); }
        CalculateChanges = true;
    }
}
function ActualCostChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (UpdateActualFromPcCheckedPopup() == true) {
            if (CDbl(C.val())!= 0) {
                Cost.val(FPrec((CDbl(ActualCost.val()) * 100) / CDbl(C.val())));
            } else {
                ActualCost.val(FPrec(0))
            }
        }
        CalculateChanges = true;
    }
}

function RevenueChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (UpdateActualFromPcCheckedPopup() == true) { ActualRevenue.val(FPrec(CDbl(Revenue.val()) * CDbl(C.val()) / 100)); }
        CalculateChanges = true;
    }
}
function ActualRevenueChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (UpdateActualFromPcCheckedPopup() == true) {
            if (CDbl(C.val()) != 0) {
                Revenue.val(FPrec((CDbl(ActualRevenue.val()) * 100) / CDbl(C.val())));
            } else {
                ActualRevenue.val(FPrec(0))
            }
        }
        CalculateChanges = true;
    }
}

function PctCompleteChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        if (CDbl(C.val()) > 100) { C.val(FPrec(100)); }
        if (CDbl(C.val()) < 0) { C.val(FPrec(0)); }
        if (UpdateRemDurationFromPctCheckedPopup() == true) {
            RemDuration.val(FPrec(CDbl(DurationDays.val()) - (CDbl(DurationDays.val()) * CDbl(C.val()) / 100)));
        }
        if (UpdateActualFromPcCheckedPopup() == true) { ActualCost.val(FPrec(CDbl(Cost.val()) * CDbl(C.val()) / 100)); }
        if (UpdateActualFromPcCheckedPopup() == true) { ActualRevenue.val(FPrec(CDbl(Revenue.val()) * CDbl(C.val()) / 100)); }
        if (CDbl(C.val()) > 0 && AS.get_value().length == 0) {
            if (S.get_value().length > 0)
                AS.set_selectedDate(S.get_selectedDate());
            else if (F.get_value().length > 0)
                AF.set_selectedDate(F.get_selectedDate());
        }
        CalculateChanges = true;
    }
}


function RemDurationChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        var Durationval = CDbl(DurationDays.val());
        var val = CDbl(RemDuration.val());
        if (val < 0) { RemDuration.val(FPrec(0)); val = 0; }
        if (UpdateRemDurationFromPctCheckedPopup() == true) {
            if (CDbl(C.val()) != 100) {
                Durationval= Math.round(val * 100 / (100 - CDbl(C.val())));
                while (Durationval < val) { Durationval += 1; }
                DurationDays.val(FPrec(Durationval));
                if (Durationval !=0) {
                    C.val(CPrct((1 - val / Durationval) * 100));
                    if (UpdateActualFromPcCheckedPopup() == true) { ActualCost.val(FPrec(CDbl(Cost.val()) * CDbl(C.val()) / 100)); }
                    if (UpdateActualFromPcCheckedPopup() == true) { ActualRevenue.val(FPrec(CDbl(Revenue.val()) * CDbl(C.val()) / 100)); }
                }
                CalculateChanges = true;
                DurationDays.trigger('change');
            } else {
                RemDuration.val(FPrec(0));
            }
        }
        CalculateChanges = true;
    }
}

function TypeChanged() {
    if (CalculateChanges) {
        CalculateChanges = false;
        switch (TaskType.get_selectedItem().get_value()) {
            case '0':
                if (!(S.get_value().length > 0) || !(F.get_value().length > 0)) {
                    if (!(S.get_value().length > 0) && !(F.get_value().length > 0)) {
                        var currDate = new Date();
                        S.set_selectedDate(ValidateDate1(currDate));
                        F.set_selectedDate(ValidateDate1(currDate));
                    } else if (S.get_value().length > 0) {
                        F.set_selectedDate(S.get_selectedDate());
                    } else if (F.get_value().length > 0) {
                        S.set_selectedDate(F.get_selectedDate());
                    }
                    DurationDays.val(FPrec(1));
                }
                break;
            case '1':
                if (!(S.get_value().length > 0) || (F.get_value().length > 0)) {
                    if (!(S.get_value().length > 0)) {
                        if (F.get_value().length > 0){
                            S.set_selectedDate(F.get_selectedDate());
                        } else {
                            var currDate = new Date();
                            S.set_selectedDate(ValidateDate1(currDate));
                        }
                    }
                    F.set_selectedDate('');
                    DurationDays.val(FPrec(0));
                }
                break;
            case '2':
                if (!(F.get_value().length > 0) || (S.get_value().length > 0)) {
                    if (!(F.get_value().length > 0)) {
                        if (S.get_value().length > 0) {
                            F.set_selectedDate(S.get_selectedDate());
                        } else {
                            var currDate = new Date();
                            F.set_selectedDate(ValidateDate1(currDate));
                        }
                    }
                    S.set_selectedDate('');
                    DurationDays.val(FPrec(0));
                }
                break;
        }
        CalculateChanges = true;
    }
}

function setTaskType() {
       if ((F.get_value().length > 0) && (S.get_value().length > 0)) {
           TaskType.findItemByValue('0').select();
       } else if (S.get_value().length > 0) {
           TaskType.findItemByValue('1').select();
       } else if (F.get_value().length > 0) {
           TaskType.findItemByValue('2').select();
       } else {
           TaskType.findItemByValue('0').select();
        }
}


function CalculateTaskEndDate1(StartDate, Duration) {
    var wdc = 0; /* working Days Counter*/
    var DaysOff = 0; /* Days Off*/
    if (Duration == 0) { return ''; }
    var TimezoneOffset = StartDate.getTimezoneOffset() * 60000;
    var TimezoneOffset = TimezoneOffset + 18000000; // Add 5 Hours as precaution To avoid losing a day on time zone differences and daylight savings
    var RealStartDate = Date.UTC(StartDate.getFullYear(), StartDate.getMonth(), StartDate.getDate());
    while (wdc < Duration) {
        while (CalendarDaysExcluded.indexOf(RealStartDate.toString()) > -1 || (CalendarWeekDaysOff.indexOf(new Date(RealStartDate + TimezoneOffset).getDay().toString()) > -1 && !(CalendarDaysIncluded.indexOf(RealStartDate.toString()) > -1))) {
            RealStartDate = RealStartDate + (3600000 * 24);
            DaysOff += 1;
        }
        RealStartDate = RealStartDate + (3600000 * 24);
        wdc += 1;
    }
    StartDate.addDays(Duration + DaysOff - 1)
    return StartDate;
}

function CalculateTaskDuration1(StartDate, EndDate) {
    var duration = 0;
    if ((EndDate == '') || (EndDate == null)) { return 0; }
    if ((StartDate == '') || (StartDate == null)) { return 0; }
    var TimezoneOffset = StartDate.getTimezoneOffset() * 60000;
    TimezoneOffset = TimezoneOffset + 18000000; // Add 5 Hours as precaution To avoid losing a day on time zone differences and daylight savings
    StartDate = Date.UTC(StartDate.getFullYear(), StartDate.getMonth(), StartDate.getDate());
    EndDate = Date.UTC(EndDate.getFullYear(), EndDate.getMonth(), EndDate.getDate());
    duration = ((EndDate - StartDate) / (3600000 * 24)) + 1;
    while (StartDate <= EndDate) {
        if (CalendarDaysExcluded.indexOf(StartDate.toString()) > -1 || (CalendarWeekDaysOff.indexOf(new Date(StartDate + TimezoneOffset).getDay().toString()) > -1 && !(CalendarDaysIncluded.indexOf(StartDate.toString()) > -1))) {
            duration -= +1;
        }
        StartDate = StartDate + (3600000 * 24);
    }
    return duration;
}


function ValidateDate1(DateVal) {
    var TimezoneOffset = DateVal.getTimezoneOffset() * 60000;
    TimezoneOffset = TimezoneOffset + 18000000; // Add 5 Hours as precaution To avoid losing a day on time zone differences and daylight savings
    var UTCval = Date.UTC(DateVal.getFullYear(), DateVal.getMonth(), DateVal.getDate());
    var Days = 0;
    while (CalendarDaysExcluded.indexOf(UTCval.toString()) > -1 || (CalendarWeekDaysOff.indexOf(new Date(UTCval + TimezoneOffset).getDay().toString()) > -1 && !(CalendarDaysIncluded.indexOf(UTCval.toString()) > -1))) {
        UTCval = UTCval + (3600000 * 24);
        Days += 1;
    }
    DateVal.addDays(Days);
    return DateVal;
}