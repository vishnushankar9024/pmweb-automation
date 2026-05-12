import { DAMAC } from './DAMACApi.js';
import { User } from './User.js';
var e = false;
var CustomFormPhase = {
   
    init: (sender, args) => {
    },
    fromCompany: {
        init: (sender, args) => {
                        
            setTimeout(CustomFormPhase.scope.init(sender, args), 500);
              
           
       
        },
    },

    scope: {
        init: (sender, args) => {
            var scopeContainer = $('#spanCustomScope');
            //if (CustomForm.scope.hasScope(scopeContainer) === true) {
            //    var combo = $find($('div.RadComboBox_Default', scopeContainer)[0].id);
            //    combo.add_itemsRequesting(function (sender, args) {
            //        args.set_cancel(true);
            //    });
            CustomFormPhase.scope.bindScope(sender, args, scopeContainer);
            //}
        },
        bindScope: (sender, args, _container) => {
            var project = 2;
            CustomFormPhase.scope.getScope(project).then((list) => {
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
                //User.getId().then((_userId) => {
                var Username = 'Test';
                var Type = 'MN';
                    fetch(`${DAMAC.getApiUrl('Phase/GetPhaseList')}?Type=${Type}&category=${_projectId}&User=${Username}`, {
                        method: "get"
                    }).then(function (data) {
                        data.json().then(function (json) {
                            resolve(json);
                        });
                    });
                //});
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
    //For Getting recap Group
    
    GetRecapGroupPermitted: (sender, args, _container) => {
        var project = 2;
            CustomFormPhase.GetRecapGroup().then((list) => {
              
                            $.each(list, function (i) {
                                console.log(list[i].Id + list[i].Text);
                            });                     
        });
        CustomFormPhase.GetRecapUser().then((list) => {

            $.each(list, function (i) {
                console.log(list[i].Id + list[i].Text);
            });
        });
    },
    GetRecapGroup: () => {
            return new Promise((resolve, reject) => {
                fetch(`${DAMAC.getApiUrl('Commitment/GroupPermitted')}`, {
                    method: "get"
                }).then(function (data) {
                    data.json().then(function (json) {
                        resolve(json);
                    });
                });
            });
    },
    GetRecapUser: () => {
        return new Promise((resolve, reject) => {
            fetch(`${DAMAC.getApiUrl('Commitment/UserPermitted')}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                });
            });
        });
    }
    
   
}

export { CustomFormPhase };