function MoveMarquee(Speed, Direction) {
    if (Direction == 'R') {
        document.getElementById(RotatorId).direction = 'right';
    } else {
    document.getElementById(RotatorId).direction = 'left';
    }
    document.getElementById(RotatorId).scrollAmount = Speed;
}

function StopMarquee() {
    document.getElementById(RotatorId).scrollAmount = 0;
}

if (typeof (Sys) != "undefined") {
    if (Sys.Application != null && Sys.Application.notifyScriptLoaded != null) {
        Sys.Application.notifyScriptLoaded();
    }
}