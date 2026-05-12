var Cmcs = {
    baseUrl: 'https://cmcs.pmweb.com/7_0_00/PMWebApi/api/',
	
	// baseUrlDev: 'http://localhost:60417/api/',
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
	},
	MutationObserver: window.MutationObserver || window.WebKitMutationObserver,
	mainTab: () => {
		try{
			return $find($(".RadTabStripTop_Default")[0].id);
		}catch(e) {
			return null;
		}
	},
	getText: (node) => {
		var nodes = $(node).contents().filter(function() {
			return this.nodetype === node.text_node; 
		});
		return nodes;
	},
	ajx: {
		post: (url, data) => {
			return $.ajax({
				type: "POST",
				url: url,
				data: data,
				dataType: 'json'
			});
		}
	},
	onProjectChanged: (calback) => {
		var observer = new Cmcs.MutationObserver((mutations, observer) => {
			var pjtMutations = $.grep(mutations, (m) => { return m.type == 'attributes' && (
				m.target.id.indexOf('ddlPHProject_ClientState') > 0 ||
				m.target.id.indexOf('ddlProject_ClientState') > 0 ||
				m.target.id.indexOf('ddlProjects_ClientState') > 0
			);});
			pjtMutations.forEach((m) => {
				setTimeout(calback, 500);
			});
		});
		observer.observe(document, {
			subtree: true,
			attributes: true
		});
	},
	trackChanges: (elem, callback) => {
		var observer = new Cmcs.MutationObserver((mutations) => {
			mutations.forEach((m) => {
				setTimeout(callback, 500);
			});
		});
		observer.observe(elem, {
			subtree: true,
			attributes: true
		});
	},
	getCustomTableName: (sender) => {
		var fieldSet = $(sender.get_element()).closest('fieldset');
        var legend  = $('legend', fieldSet);
        var span = $('span', legend);
        return span.text().toLowerCase();

	},
	updateQueryStringParameter: (uri, key, value) => {
		var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
		var separator = uri.indexOf('?') !== -1 ? "&" : "?";
		if (uri.match(re)) {
			return uri.replace(re, '$1' + key + "=" + value + '$2');
		}
		else {
			return uri + separator + key + "=" + value;
		}
	}
}

export { Cmcs };