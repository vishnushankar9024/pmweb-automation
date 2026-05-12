import { Ajax } from './Ajax.js'
import { PMWebExt } from './PMWebExt.js'
var self = {}, ajx = {}, pmwebext = {}, list = {}, addressId = 0;
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
	},
	GetAddressId: function () {
		ajx.get(pmwebext.getHost() + '/VendorApplication/GetAddressId?Id=' + pmwebext.getUrlVar('Id')).then((data) => { addressId = JSON.parse(data) });
	},
	GetAddressIdInc: function () {
		addressId = addressId + 1;
		return addressId;
	},
	ValidateAddress: function () {
		var btnUpdate = $("a[id$='btnAddressUpdateEdited']");
		if (typeof (btnUpdate) !== 'undefined') {
			btnUpdate.click(self.ValidateCallback);
		}
		var btnSave = $("a[id$='btnAddressSave']");
		if (typeof (btnSave) !== 'undefined') {
			btnSave.click(self.ValidateCallback);
		}

	},
	ValidateCallback: function (e) {
		if ($("input[id$='txtAddress1']").val() === "") {
			e.preventDefault();
			alert('Please enter the address1!');
			$("input[id$='txtAddress1']").focus();
			return;
		}
		if ($("input[id$='ddlCountry_Input']").val() === "") {
			e.preventDefault();
			alert('Please select the country!');
			$("input[id$='ddlCountry_Input']").focus();
			return;
		}
		if ($("input[id$='txtPhone']").val() === "") {
			e.preventDefault();
			alert('Please enter the phones!');
			$("input[id$='txtPhone']").focus();
			return;
		}
		if ($("input[id$='txtEmail']").val() === "") {
			e.preventDefault();
			alert('Please enter the email!');
			$("input[id$='txtEmail']").focus()
			return;
		}
		if ($("input[id$='txtWebsite']").val() === "") {
			e.preventDefault();
			alert('Please enter the website!');
			$("input[id$='txtWebsite']").focus()
			return;
		}
	},
	validateContact: function () {
		var btnSave = $("a[id$='btnContactSave']");
		if (typeof (btnSave) !== 'undefined') {
			btnSave.click(self.validateContactCallback);
		}
		var btnUpdate = $("a[id$='btnContactUpdateEdited']");
		if (typeof (btnUpdate) !== 'undefined') {
			btnUpdate.click(self.validateContactCallback);
		}
	},
	validateContactCallback: function (e) {
		if ($("input[id$='txtFirstName']").val() === "") {
			e.preventDefault();
			alert('Please enter the First Name!');
			$("input[id$='txtFirstName']").focus();
			return;
		}
		if ($("input[id$='txtLastName']").val() === "") {
			e.preventDefault();
			alert('Please enter the Last Name!');
			$("input[id$='txtLastName']").focus();
			return;
		}
		if ($("input[id$='_txtTitle']").val() === "") {
			e.preventDefault();
			alert('Please enter the title!');
			$("input[id$='_txtTitle']").focus();
			return;
		}
		if ($("input[id$='_txtEmail']").val() === "") {
			e.preventDefault();
			alert('Please enter the email!');
			$("input[id$='_txtEmail']").focus();
			return;
		}
		if ($("input[id$='_txtCell']").val() === "") {
			e.preventDefault();
			alert('Please enter the mobile!');
			$("input[id$='_txtCell']").focus();
			return;
		}
	},
	CheckAttachmentTab: function () {
		if (typeof (pmwebext.getUrlVar('RadUrid')) != 'undefined' && pmwebext.getUrlVar('RadUrid') != '') {
			var aTag = $("a[name='attachment']");
			$('html,body').animate({ scrollTop: aTag.offset().top }, 'slow');
        }
    }
});
export { VendorApplication }