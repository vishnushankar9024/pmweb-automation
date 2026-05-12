
var validIndexChange = false;

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


function ResetCombos(combobox, eventArgs) {
    var item = eventArgs.get_item();
    if ((combobox.get_id() == "ddlResources" ) && (item != null)) {
        var ddlResourcePayTypes = $find("ddlResourcePayTypes");
        ddlResourcePayTypes.clearItems();
        ddlResourcePayTypes.set_text(item.get_attributes().getAttribute("ResourcePayType"));
        ddlResourcePayTypes.set_value(item.get_attributes().getAttribute("PayTypeId"));
   
        var ddlResourceClasses = $find("ddlResourceClasses");
        ddlResourceClasses.clearItems();
        ddlResourceClasses.set_text(item.get_attributes().getAttribute("ResourceClassification"));
        ddlResourceClasses.set_value(item.get_attributes().getAttribute("ClassificationId"));
        

    }
}

function GetValueToReturn(combobox, eventArgs) {
    var SelectedValue;
        var ddlResources = $find("ddlResources");
        SelectedValue = ddlResources.get_value();  
    var context = eventArgs.get_context();
    context["FilterString"] = SelectedValue;

}


function ValidateResourceCombo(source, args) {
    args.IsValid = false;
    var combo = $find(source.controltovalidate);
    if (combo != null) {
        var text = combo.get_text();

        if (text.length < 1) {
            args.IsValid = false;
        }
        else {
            if (validIndexChange == false) {
                var value = combo.get_value();
                if ((value.indexOf("EQU") >= 0) || (value.indexOf('LAB') >= 0)) {
                    args.IsValid = true;
                }
                else {
                    args.IsValid = false;
                }
                if (value.length == 0) {
                    args.IsValid = false;
                }
            }
            else {
                var value1 = combo.findItemByText(text);
                if (value1 != null) {
                    args.IsValid = true;
                }
                else {
                    args.IsValid = false;
                }
            }
        }
    }
    else {
        args.IsValid = true;
    }
    validIndexChange = false;
}

function ResourceSelectedIndexChanging(sender, eventArgs){
    validIndexChange = true;
}