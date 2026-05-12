import { Roshn } from './RoshnApi.js';
import { User } from './User.js';
var actionItem = {
    elements: {
        btnContainer: null,
        tblTeamInputRefresh: null,
        tblLogRefresh: null,
		tab: null,
		tabs: {
			collaborate: null
		},
        set: () => {
            actionItem.elements.btnContainer = $('#btnTodoListButtons');
            actionItem.elements.tblTeamInputRefresh = $('a[id$="btnRefresh"]', $('td[id$="tblTeamInput"]'))[0];
            actionItem.elements.tblLogRefresh = $('a[id$="btnRefresh"]', $('td[id$="tblLog"]'))[0];
			actionItem.elements.tab = $find($(".RadTabStripTop_Default")[0].id);
			actionItem.elements.tabs.collaborate = actionItem.elements.tab.findTabByText('Collaborate');
        }
    },
    variable: {
        collaborateUserId: 0
    },
    init: function (sender, args) {
        actionItem.elements.set();
        actionItem.renderButtons();
		
		if(Roshn.getUrlParameter('t') == 'c'){
			$(document).ready(() => {
				setTimeout(() => {
					actionItem.elements.tabs.collaborate.click();
				}, 100);
			});
			window.history.replaceState({}, window.location.href, window.location.href.replace('&t=c', ''));
		}
    },
    renderButtons: function () {
        if (actionItem.elements.btnContainer.length > 0 && Roshn.getUrlParameter('PageId') == 165) {
            actionItem.elements.btnContainer.empty();
            User.getId().then((_userId) => {
                actionItem.getCreatedById().then((_createdById) => {
                    if (_userId == _createdById) {
                        $('<input />', {
                            type: 'button',
                            value: 'Start Collaborate',
                            css: { 'width': '150px' },
                            click: function () {
                                $(this).prop('disabled', true);
                                actionItem.startCollaborate(_userId, 0);
                            }
                        }).appendTo(actionItem.elements.btnContainer);

                        $('<input />', {
                            type: 'button',
                            value: 'Invite Accountable',
                            css: { 'width': '150px', 'margin-left': '20px' },
                            click: function () {
                                $(this).prop('disabled', true);
                                actionItem.startCollaborate(_userId, 1);
                            }
                        }).appendTo(actionItem.elements.btnContainer);
                    }
                });
            });
        }
    },
    startCollaborate: function (_userId, raciRole) {
        $.ajax({
            url: `${Roshn.getApiUrl('Collaborate/Start')}?UserId=${_userId}&RecordId=${Roshn.getUrlParameter('Id')}&raciRole=${raciRole}`,
            method: 'POST'
        }).done(function (res) {
            var msg = raciRole == 0 ? 'Collaborate initiated successfully' : 'Accountable invited successfully';
            alert(msg);
			if(Roshn.getUrlParameter('t') == 'c')
				location.href = location.href;
			else
				location.href = location.href + '&t=c';
        });
    },
    getCreatedById: function () {
        return new Promise((resolve, reject) => {
            if (actionItem.variable.collaborateUserId > 0)
                resolve(actionItem.variable.collaborateUserId);

            fetch(`${Roshn.getApiUrl('Collaborate/GetUserId')}?Id=${Roshn.getUrlParameter('Id')}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    actionItem.variable.collaborateUserId = json;
                    resolve(actionItem.variable.collaborateUserId);
                });
            });
        });
    }
}

export { actionItem }