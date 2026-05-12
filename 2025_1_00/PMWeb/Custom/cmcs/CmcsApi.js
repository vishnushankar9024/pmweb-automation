var Cmcs = {
    baseUrl: 'https://cmcs.pmweb.com/9_0_00/PMWebApi/api/',	
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
		// dropDown.set_value(_value);
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
		console.log(nodes);
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
	
	onProjectChanged: (callback) => {
		var observer = new Cmcs.MutationObserver((mutations, observer) => {
			var pjtMutations = $.grep(mutations, (m) => { return m.type == 'attributes' && m.target.id.indexOf('ddlPHProject_ClientState') > 0 ||  m.target.id.indexOf('ddlProject_ClientState') > 0 ||  m.target.id.indexOf('ddlProjects_ClientState') > 0;});
			pjtMutations.forEach((m) => {                    
				setTimeout(callback, 100);
			});
		});
		observer.observe(document, {
			subtree: true,
			attributes: true
		});
	},
	onTabChanged: (callback) => {
		var observer = new Cmcs.MutationObserver((mutations, observer) => {
			var pjtMutations = $.grep(mutations, (m) => { return Cmcs.mainTab().get_selectedTab().get_text().toLowerCase().indexOf('additional info') === 0 ;});
			pjtMutations.forEach((m) => {                    
				setTimeout(callback, 1000);
			});
		});
		observer.observe(document, {
			subtree: true,
			attributes: true
		});
	},
	// onCommitmentmainTabChanged: (callback) => {
		// var observer = new Cmcs.MutationObserver((mutations, observer) => {
			// var pjtMutations = $.grep(mutations, (m) => { return Cmcs.mainTab().get_selectedTab().get_text().toLowerCase().indexOf('main') === 0 ;});
			// pjtMutations.forEach((m) => {                    
				// setTimeout(callback, 100);
			// });
		// });
		// observer.observe(document, {
			// subtree: true,
			// attributes: true
		// });
	// },
	onCommitmentmainTabChanged: (callback) => {
    var observer = new Cmcs.MutationObserver((mutations, observer) => {
        var pjtMutations = $.grep(mutations, (m) => {
            const tab = Cmcs.mainTab();
            if (!tab || !tab.get_selectedTab()) return false;
            return tab.get_selectedTab().get_text().toLowerCase().startsWith('main');
        });
        pjtMutations.forEach((m) => {
            setTimeout(callback, 100);
        });
    });
		observer.observe(document, {
			subtree: true,
			attributes: true
		});
	},
		// onCommitmentAdditionalTabChanged: (callback) => {
		// var observer = new Cmcs.MutationObserver((mutations, observer) => {
			// var pjtMutations = $.grep(mutations, (m) => { return Cmcs.mainTab().get_selectedTab().get_text().toLowerCase().indexOf('additional info') === 0 ;});
			// pjtMutations.forEach((m) => {                    
				// setTimeout(callback, 100);
			// });
		// });
		// observer.observe(document, {
			// subtree: true,
			// attributes: true
		// });
	// },
		onCommitmentAdditionalTabChanged: (callback) => {
    var observer = new Cmcs.MutationObserver((mutations, observer) => {
        var pjtMutations = $.grep(mutations, (m) => {
            const tab = Cmcs.mainTab();
            if (!tab || !tab.get_selectedTab()) return false;
            return tab.get_selectedTab().get_text().toLowerCase().startsWith('additional info');
        });
        pjtMutations.forEach((m) => {
            setTimeout(callback, 100);
        });
    });
		observer.observe(document, {
			subtree: true,
			attributes: true
		});
	},
	urlContains: function(textToFind) {
        if (!textToFind) return 0;
        
        try {
            var currentUrl = window.location.href.toLowerCase();
            var searchText = textToFind.toLowerCase();
            
            return currentUrl.indexOf(searchText) !== -1 ? 1 : 0;
        } catch (e) {
            console.error("Error checking URL:", e);
            return 0;
        }
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
	}
}

export { Cmcs };