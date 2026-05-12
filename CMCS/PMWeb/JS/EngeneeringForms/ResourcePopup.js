var gridId = "rpnResourceGrid";
function isMouseOverGrid(target) {
    parentNode = target;
    while (parentNode != null) {
        if (parentNode.id == gridId) {
            return parentNode;
        }
        parentNode = parentNode.parentNode;
    }
    return null;
}

function onNodeDragging(sender, args) {
    var target = args.get_htmlElement();

    if (!target) return;

    if (target.tagName == "INPUT") {
        target.style.cursor = "hand";
    }

    var grid = isMouseOverGrid(target)
    if (grid) {
        grid.style.cursor = "hand";
    }
}

function droppedOnGrid(args) {
    var target = args.get_htmlElement();

    while (target) {
        if (target.id == gridId) {
            args.set_htmlElement(target);
            return;
        }

        target = target.parentNode;
    }
    args.set_cancel(true);
}



function onNodeDropping(sender, args) {
    if (droppedOnGrid(args)) return;
}