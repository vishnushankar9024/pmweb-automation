function EnableDisableCredential(sender, args) {
    var txtWebServiceUser = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chbUseNetworkCredential')) + '_txtWebServiceUser' + "]")[0];
    var txtWebServicePass = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chbUseNetworkCredential')) + '_txtWebServicePassword' + "]")[0];
    var txtDomain = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chbUseNetworkCredential')) + '_txtDomain' + "]")[0];
    var txtWebServicePassword = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chbUseNetworkCredential')) + '_txtWebServicePassword' + "]")[0];
    var chkUseCredential = $("[id$=" + sender.id + "]")[0];

    txtDomain.disabled = !(chkUseCredential.checked);
    txtWebServiceUser.disabled = !(chkUseCredential.checked);
    txtWebServicePass.disabled = !(chkUseCredential.checked);
    txtWebServicePassword.disabled = !(sender.checked)



}