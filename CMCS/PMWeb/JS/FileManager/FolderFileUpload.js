/// <reference path="../jQuery-vsdoc.js" />


function ValidateRadUpload1(source, arguments) {
    arguments.IsValid = GetRadUpload($("[id$=RadUpload1]")[0].id).ValidateExtensions();
    alert("not valid");
}
