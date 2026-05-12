import { Roshn } from './RoshnApi.js';
import { User } from './User.js';

var CustomFormRisk = {
    init: function (sender, args) {
        var spanRBSCategory = $('#spanRBSCategory');
        if (spanRBSCategory && spanRBSCategory.length == 1) {
            var ddlRBSCategory = $find($('div.RadComboBox_Default', spanRBSCategory)[0].id);
            ddlRBSCategory.add_selectedIndexChanged(CustomFormRisk.selectedIndexChanged);
        }
        var spanRBSSubCategory = $('#spanRBSSubCategory');
        if (spanRBSSubCategory && spanRBSSubCategory.length) {
            $find($('div.RadComboBox_Default', spanRBSSubCategory)[0].id).add_itemsRequesting(function (sender, args) {
                args.set_cancel(true);
            });
        }
		CustomFormRisk.stageGate.init(sender, args);
    },
    selectedIndexChanged: function (sender, args) {
        var spanRBSSubCategory = $('#spanRBSSubCategory');
        if (spanRBSSubCategory && spanRBSSubCategory.length) {
            var item = args.get_item();
            CustomFormRisk.getRiskSubCategoryList(item.get_text()).then(function (subCategories) {
                CustomFormRisk.bindSubCategory(subCategories, $find($('div.RadComboBox_Default', spanRBSSubCategory)[0].id));
            });
        }
    },
    getRiskSubCategoryList: function (category) {
        return new Promise((resolve, reject) => {
            fetch(`${Roshn.getApiUrl('Risk/GetSubCategoryList')}?category=${category}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                });
            });
        });
    },
    bindSubCategory: function (list, combo) {
        combo.trackChanges();
        combo.clearItems();
        $.each(list, function (i) {
            var comboItem = new Telerik.Web.UI.RadComboBoxItem();
            comboItem.set_text(list[i].Text);
            comboItem.set_value(list[i].Id);
            combo.get_items().add(comboItem)
        });
        combo.commitChanges();
        combo.showDropDown();
    },
    stageGate: {
        init: function (sender, args) {
			if ($('#spanStageGate').length == 1 && Roshn.getUrlParameter('TypeId') == 141) {
				$find($("[id$='ddlPHCategory']")[0].id).add_selectedIndexChanged(CustomFormRisk.stageGate.onCategoryChanged);
			}
        },
		onProjectChanged: function (sender, args) {
            CustomFormRisk.stageGate.loadStageGate(args.get_item().get_value(), $find($("[id$='ddlPHCategory']")[0].id).get_text());
		},
		onCategoryChanged: function (sender, args) {
			CustomFormRisk.stageGate.loadStageGate($find($("[id$='ddlPHProject']")[0].id).get_value(), args.get_item().get_text());
		},
        loadStageGate: function (projectId, phaseId) {
			if(projectId > 0 && phaseId != "") {
				User.get().then((_userData) => {
					if (_userData && _userData != null) {
						CustomFormRisk.stageGate.getCurrentStageGate(projectId, phaseId, _userData.Username).then(function (StageGate) {
							if (StageGate.length > 0) {
								$('#spanStageGate').html(StageGate[0].Text);
							}
						 });
					}
				});
			}
        },
        getCurrentStageGate: function (projectId, phase, username) {
            return new Promise((resolve, reject) => {
                fetch(`${Roshn.getApiUrl('Risk/GetCurrentSG')}?projectId=${projectId}&phase=${phase}&user=${username}`, {
                    method: "get"
                }).then(function (data) {
                    data.json().then(function (json) {
                        resolve(json);
                    });
                });
            });
        },
        initClose: function () {
            if (Roshn.getUrlParameter('TypeId') == 141 && Roshn.getUrlParameter('Id') && Roshn.getUrlParameter('Id') > 0) {
				var spanRiskStatus = $('#spanRiskStatus');
                var ddlRiskStatus = $find($('div.RadComboBox_Default', spanRiskStatus)[0].id);
                if (ddlRiskStatus.get_text() == 'Closed') {
                    $('#btnCloseRisk').hide();
                    $('.ToolbarSave').hide();
                    $('.ToolbarDelete').hide();
                }
                else {
                    $('#btnCloseRisk').show();
                    $('.ToolbarSave').show();
                    $('.ToolbarDelete').show();
                }
				$('#btnCloseRisk').click(CustomFormRisk.stageGate.handleClose);
            }
        },
        handleClose: function (e) {
            var spanClosureDesc = $('#spanClosureDesc');
            var spanClosureReason = $('#spanClosureReason');
            if (spanClosureReason.length > 0 && spanClosureDesc.length > 0) {
                var closureReason = $find($('div.RadComboBox_Default', spanClosureReason)[0].id);
                var ddlRiskStatus = $find($('div.RadComboBox_Default', spanRiskStatus)[0].id);
                var closureDesc = $('textarea', $("#spanClosureDesc"));
                if (closureReason.get_value() == "" || closureDesc.val() == "") {
                    alert('Please fill the closure reason and Description details');
                }
                else {
					Roshn.setDropDownItem(ddlRiskStatus, 489, 'Closed');
                    $('.ToolbarSave')[0].click();
                }
            }
        }
    }
}

export { CustomFormRisk };