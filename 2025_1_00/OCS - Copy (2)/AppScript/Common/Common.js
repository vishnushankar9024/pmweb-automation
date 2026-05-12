// Select All Checkbox
function SelectAll(source, parent) {
    var elemSource = source;
    var elemParent = document.getElementById(parent);
    var elemChild = elemParent.getElementsByTagName('input');
    var isChecked = elemSource.checked;

    for (i = 0; i < elemChild.length; i++) {
        if (elemChild[i].id != elemSource && elemChild[i].type == "checkbox") {
            if (elemChild[i].checked != isChecked) {
                elemChild[i].click();
            }
        }
    }
}

// Validate passed inputbox(source) value for max limit.
// onKeyUp="ValidateMaxChars(this, output, 100);" onChange="ValidateMaxChars(this, output, 100)"
function ValidateMaxChars(sender, output, length) {
    var diff = length - sender.value.length;
    if (diff < 0) {
        sender.value = sender.value.substring(0, length);
        diff = 0;
    }
    var elem = document.getElementById(output);
    output.innerText = diff + " characters left";
}

// Show control
function Show(sender) {
    if (sender != null)
        sender.style.display = "block";
}

// Hide control
function Hide(sender) {
    if (sender != null)
        sender.style.display = "none";
}

// Toggle control
function ShowHide(sender, visible) {
    if (sender != null) {
        if (visible == "true")
            Show(sender);
        else
            Hide(sender);
    }
}

// Hide message
function HideMessage(sender) {
    var elem = document.getElementById(sender);
    Hide(elem);
}