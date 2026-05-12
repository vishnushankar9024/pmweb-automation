import { DAMAC } from './DAMACApi.js';
import { User } from './User.js';
var e = false;
var CustomFormPhase = {

    init: (sender, args) => {
    },
    fromCompany: {
        init: (sender, args) => {
            var observer = new DAMAC.MutationObserver((mutations, observer) => {
                var pjtMutations = $.grep(mutations, (m) => { return m.type == 'attributes' && m.target.id.indexOf('ddlPHProject_ClientState') > 0; });
                pjtMutations.forEach((m) => {
                    setTimeout(CustomForm.scope.init(sender, args), 500);
                })
            });
            observer.observe(document, {
                subtree: true,
                attributes: true
            });
        },
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
                setTimeout(function () {
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
                }, 100);
            });
        },
        getScope: (_projectId) => {
            return new Promise((resolve, reject) => {
                User.getId().then((_userId) => {
                    fetch(`${DAMAC.getApiUrl('Phase/GetPhaseList')}?category=${_projectId}&User=${_userData.Username}`, {
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
    }

}

export { CustomFormPhase };