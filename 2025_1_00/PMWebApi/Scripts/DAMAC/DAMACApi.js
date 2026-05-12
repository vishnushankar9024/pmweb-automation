var DAMAC = {
    baseUrl: 'http://localhost:51216/api/', 
    //baseUrl: 'https://damacpmis.pmweb.com/Dev/PMWebAPI/api/',
    getApiUrl: function (url) {
        return this.baseUrl + url;
    },
	getUrlParameter: function(sParam) {
		var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

		for (i = 0; i < sURLVariables.length; i++) {
			sParameterName = sURLVariables[i].split('=');

			if (sParameterName[0] === sParam || sParameterName[0].toLowerCase() == sParam.toLowerCase()) {
				return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
			}
		}
		return false;
	},
	setDropDownItem: function(dropDown, _value, _text) {
		dropDown.trackChanges();
		dropDown.showDropDown();
		dropDown.set_text(_text);
		dropDown.set_value(_value);
		dropDown.hideDropDown();
		dropDown.commitChanges();
	}
}

export { DAMAC };