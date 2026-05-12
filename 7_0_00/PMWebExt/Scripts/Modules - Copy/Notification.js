var self = {}, ext = {};
function Notification(_ext) {
    self = this;
    ext = _ext;
    if (ext.pmweb.getUrlVar('IsNotification') && ext.pmweb.getUrlVar('IsNotification') == '1')
        self.Init();
}
Object.assign(Notification.prototype, {
    Init: function () {
        ext.ajx.post(ext.pmweb.getHost() + '/Notification/GetContact', { Id: ext.pmweb.getUrlVar('id') }).then((data) => self.BindContact(data));
    },
    BindContact: function (data) {
        data = JSON.parse(data);
        var LockAfterSend = $("[id$=hdnLockAfterSend]")[0].value;
        var IsSent = $("[id$=hdnIsSent]")[0].value;
        var val = $("[id$=hdnToCompany]")[0].value;
        if ((LockAfterSend == "True" || IsSent == "True") && val == '') {
            for (var d in data) {
                AddToCompanyEmail(d.Id, d.DisplayName, d.Email, 'spnToCompany');
            }
        }

    }
});
export { Notification };