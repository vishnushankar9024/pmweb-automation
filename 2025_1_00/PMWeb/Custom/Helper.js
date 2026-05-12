var getUrlParameter = function getUrlParameter(sParam) {
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
};

function hasCollaborateButton() {
    return $('#btnStartCollaborate').length > 0
}

function onCollaborateLoad() {
    ShowHideCollaborateButton();
}

function ShowHideCollaborateButton() {
	if (hasCollaborateButton() === true) {
		$('#btnStartCollaborate').hide();
		getUserId().then((userData) => {
			getCollaborateUserId().then((collaborateUserId) => {
				if(userData.Id == collaborateUserId && getUrlParameter('PageId') == 165)
					$('#btnStartCollaborate').show();
			});
			$('#btnStartCollaborate').click(function() {
				$.ajax({
					url: 'https://epms.roshn.sa/PMWebApi/api/Collaborate/Start?UserId=' + userData.Id + '&RecordId=' + getUrlParameter('Id'),
					method: 'POST'
				}).done(function(res) {
					location.reload();
				});
			})
		});
	}
}

var _userData = {};

function getUserId() {
    return new Promise((resolve, reject) => {
        if (_userData.Id) {
            resolve(_userData);
        } else {
            $.ajax({
                url: 'https://epms.roshn.sa/PMWeb/Custom/PmwebHelper.aspx/GetUser',
                method: 'GET',
                async: false,
                cache: false,
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                success: function(data) {
                    _userData = JSON.parse(data.d);
                    resolve(_userData);
                },
                error: function(error) {
                    reject(error)
                }
            });
        }
    });
}

var _collaborateUserId = 0;

function getCollaborateUserId() {
    return new Promise((resolve, reject) => {
        if (_collaborateUserId > 0) {
            resolve(_collaborateUserId);
        } else {
            $.ajax({
                url: 'https://epms.roshn.sa/PMWebApi/api/Collaborate/GetUserId?Id=' + getUrlParameter('Id'),
                method: 'GET',
                success: function(data) {
                    _collaborateUserId = data;
                    resolve(_collaborateUserId);
                },
                error: function(error) {
                    reject(error)
                }
            });
        }
    });
}