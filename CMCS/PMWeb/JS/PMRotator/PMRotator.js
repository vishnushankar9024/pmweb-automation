function MoveMarquee(Speed, Direction) {
    var rotator = document.getElementById(RotatorId);
    if (!rotator) {
        return;
    }
    if (Direction == 'R') {
        rotator.direction = 'right';
        rotator.start();
    } else {
        rotator.direction = 'left';
        rotator.start();
    }
    rotator.scrollAmount = 3;
}

function StopMarquee() {
        var rotator = document.getElementById(RotatorId);
        if (!rotator) {
            return;
        }
        rotator.scrollAmount = 0;
        if (navigator.appName != "Microsoft Internet Explorer") {
            rotator.stop();
        } 
   
}

if (typeof (Sys) != "undefined") {
    if (Sys.Application != null && Sys.Application.notifyScriptLoaded != null) {
        Sys.Application.notifyScriptLoaded();
    }
}









