import { Ajax } from './Ajax.js'
import { PMWebExt } from './PMWebExt.js'
var self = {}, ajx = {}, pmwebext = {}, list = {};
function VendorApplication() {
    self = this;
    ajx = new Ajax();
    pmwebext = new PMWebExt();
}
Object.assign(VendorApplication.prototype, {
    GetAttachmentOptions: function () {
        ajx.get(pmwebext.getHost() + '/VendorApplication/GetAttachmentOptions').then((data) => { list = JSON.parse(data) });
    },
    BindAttachmentOption: function ($select) {
        $select.empty();
        $('<option />', { value: 0 }).text('--- Select ---').appendTo($select);
        $.each(list, function (i) {
            $('<option />', { value: list[i].Description }).text(list[i].Description).appendTo($select);
        });
    }
});
export { VendorApplication }