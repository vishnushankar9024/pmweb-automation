function pageLoad() {
    var body = document.getElementsByTagName("body")[0];
    body.addEventListener("click", RemoveDoubleQuotesFromInputs)
    RemoveDoubleQuotesFromInputs();
}

function RemoveDoubleQuotesFromInputs() {
    var obj = document.getElementsByClassName("rfdTextInput");
    for (var i = 0; i < obj.length; i++)
        if (obj[i].value.indexOf('"') >= 0)
            obj[i].value = obj[i].value.replace(/"/g, '');
}