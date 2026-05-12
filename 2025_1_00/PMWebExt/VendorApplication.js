import { VendorApplication } from './Scripts/Modules/VendorApplication.js'
(function () {
    var app = new VendorApplication();
    app.GetAttachmentOptions();
    app.GetAddressId();
    var BindAttachmentOptions = function () {
        var obj = $('.ddlNotes');
        if (typeof (obj) != 'undefined' && $('option', obj).length <= 1) {
            app.BindAttachmentOption(obj);
            $(obj).change(function () {
                $("[id$='txtDescription']").val($(this).val());
            });
            obj.click();
        }
    };
    var GetAddressId = function () {
        var addId = $("input[id$='txtAddressId']");
        if (typeof (addId) != 'undefined' && addId.val() === '') {
            addId.val(app.GetAddressIdInc())
        }
    };
    window.VendorApplicationCallBack = function (sender, eventArgs) {
        console.log('Response end initiated by: ' + eventArgs.get_eventTarget());
        BindAttachmentOptions();
        GetAddressId();
        app.ValidateAddress();
        app.validateContact();
    };
    app.CheckAttachmentTab();
})();