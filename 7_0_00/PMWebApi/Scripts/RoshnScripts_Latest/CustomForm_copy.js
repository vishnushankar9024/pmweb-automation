import { Roshn } from './RoshnApi.js';
import { User } from './User.js';
import { CustomFormRisk } from './CustomFormRisk.js';

var CustomForm = {
    fromCompany: {
		init: (sender, args) => {
			MutationObserver = window.MutationObserver || window.WebKitMutationObserver;
			var observer = new MutationObserver((mutations, observer) => {
				var pjtMutations = $.grep(mutations, (m) => { return m.type == 'attributes' && m.target.id.indexOf('ddlPHProject_ClientState') > 0;});
				pjtMutations.forEach((m) => {
					setTimeout(CustomForm.fromCompany.bind(sender, args), 1);
				})
			});
			observer.observe(document, {
				subtree: true,
				attributes: true
			});
		},
        bind: function (sender, eventArgs) {
			var companyDropdown = $find($("[id$='ddlPHCompany']")[0].id);
			if(companyDropdown && companyDropdown.get_text().trim() == ''){			
				if( $("[id$='ddlPHCompany']") && $("[id$='ddlPHCompany']").length > 0 ) {
					CustomForm.fromCompany.getCompany().then((company) => {
						if( company && company != null ) {
							companyDropdown.enable();
							companyDropdown.trackChanges();
							companyDropdown.showDropDown();
							companyDropdown.set_value(company.Id);
							companyDropdown.set_text(company.CompanyName);
							companyDropdown.hideDropDown();
							companyDropdown.commitChanges();
							companyDropdown.disable();
						}
					});
				}
				return 0
			}
			return 1;
        },
        getCompany: function () {
            return new Promise((resolve, reject) => {
				User.getCompany().then((json) => {
					resolve(json);
				});
            });
		}
	},
	scope: {
		init: (sender, args) => {
			var scopeContainer = $('#spanCustomScope');
			if (CustomForm.scope.hasScope(scopeContainer) === true) {
				var combo = $find($('div.RadComboBox_Default', scopeContainer)[0].id);
				combo.add_itemsRequesting(function (sender, args) {
					args.set_cancel(true);
				});
				CustomForm.scope.bindScope(sender, args, scopeContainer);
            }
		},
		bindScope: (sender, args, _container) => {
			var project = args.get_item();
			CustomForm.scope.getScope(project.get_value()).then((list) => {
				setTimeout(function() {
					var combo = $find($('div.RadComboBox_Default', _container)[0].id);
					combo.trackChanges();
					combo.clearItems();
					$.each(list, function (i) {
						var comboItem = new Telerik.Web.UI.RadComboBoxItem();
						comboItem.set_text(list[i].Text);
						comboItem.set_value(list[i].Id);
						combo.get_items().add(comboItem)
					});
					combo.commitChanges();
				}, 1);
			});
		},
		getScope: (_projectId) => {
			return new Promise((resolve, reject) => {
				User.getId().then((_userId) => {
					fetch(`${Roshn.getApiUrl('scope/GetScope')}?userid=${_userId}&projectid=${_projectId}`, {
						method: "get"
					}).then(function (data) {
						data.json().then(function (json) {
							resolve(json);
						});
					});
				});
			});
		},
		hasScope: (_container) => {
			return _container.length > 0;
		},
		preventItemRequesting: () => {
			var scopeContainer = $('#spanCustomScope');
			if (CustomForm.scope.hasScope(scopeContainer) === true) {
				var combo = $find($('div.RadComboBox_Default', scopeContainer)[0].id);
				combo.add_itemsRequesting(function (sender, args) {
					args.set_cancel(true);
				});
            }
		}
	},
	Risk: CustomFormRisk
}

export { CustomForm };