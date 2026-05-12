import { Cmcs } from './CmcsApi.js';
import { User } from './User.js';
var e = false;

var Procurement = {   
	hasFetchedProcStatus: false,  // ✅ Correct property declaration

	GetProcStatus: function () {
	console.log('status ' + this.hasFetchedProcStatus);
    if (this.hasFetchedProcStatus) return;
    this.hasFetchedProcStatus = true;

    console.log('Fetching status...');
	if (Cmcs.getUrlParameter('PageId') == 161) {   
        var Recordid = '';
		var Typeid ='';
		Recordid =  Cmcs.getUrlParameter("id");
		var lblProcStatus = $('#ctl00_CPH1_lblProcStatusID');
		if (Recordid != 0){
			Procurement.getProcPublishStatus(Recordid).then((list) => {

            $.each(list, function (i) {
                console.log('Proc'+list[i].Id + list[i].Status);
				if (list[i].Status == 1){				
					$('#ctl00_CPH1_lblProcStatusID').html('<span style="font-weight: bold;">Bid Status</span> - Published Successfully'); // Update text with bold "Bid Status"
					$('#ctl00_CPH1_lblProcStatusID').closest('tr').show(); // Show the row
					$('#ctl00_CPH1_lblProcStatusID').css("color", "green"); // Change to any color					
				}
				 else if (list[i].Status == 0){				
					$('#ctl00_CPH1_lblProcStatusID').html('<span style="font-weight: bold;">Bid Status</span> - Not Published'); // Update text with bold "Bid Status"
					$('#ctl00_CPH1_lblProcStatusID').closest('tr').show(); // Show the row
					$('#ctl00_CPH1_lblProcStatusID').css("color", "red"); // Change to any color

				 }
            });
        }); 
		Typeid = '94'
		Procurement.getUrl(Typeid,Recordid).then((list) => {
			console.log('work');			
				const lblCustomUrl = document.getElementById('ctl00_CPH1_lblCustomUrl');
				const lblProcStatusID = document.getElementById('ctl00_CPH1_lblProcStatusID');
				const lblUrlMsg = document.getElementById('ctl00_CPH1_lblCustomUrlLockedMsg');
				 if (list.length === 0) {
					// Handle empty list
					console.log('No URLs found.');					
				} else {
				 $.each(list, function (i, item) {
						if (item.TobeEnabled == 0 && Typeid == '94'){										
								
								if (lblCustomUrl) {
									lblCustomUrl.style.pointerEvents = 'none'; // disables click
									lblCustomUrl.style.color = 'gray'; // make it look disabled
									lblCustomUrl.style.textDecoration = 'none';
								}
								console.log('TobeEnabled' + item.TobeEnabled + Typeid);
							}
						else if (item.TobeEnabled == 1 && Typeid == '94'){								
								if (lblUrlMsg) lblUrlMsg.style.display = 'none';
								console.log('TobeEnabled' + item.TobeEnabled + Typeid);
				}
				});
			}
		}); 
		}
		 else{
		 $('#lblProcStatusID').hide();			
		 }
	}
	if (Cmcs.getUrlParameter('PageId') == 162) {
		var Recordid = '';
		var Typeid ='';
		Recordid =  Cmcs.getUrlParameter("id");
		if (Recordid != 0){
		Typeid = '95'
		Procurement.getUrl(Typeid,Recordid).then((list) => {
			console.log('work');			
				const lblCustomUrl = document.getElementById('ctl00_CPH1_lblCustomUrl');
				 if (list.length === 0) {
					// Handle empty list
					console.log('No URLs found.');					
				} else {
				 $.each(list, function (i, item) {
						if (item.TobeEnabled == 0 && Typeid == '95'){
								
								if (lblCustomUrl) {
									lblCustomUrl.style.pointerEvents = 'none'; // disables click
									lblCustomUrl.style.color = 'gray'; // make it look disabled
									lblCustomUrl.style.textDecoration = 'none';
								}
								console.log('TobeEnabled' + item.TobeEnabled + Typeid);
							}
						else if (item.TobeEnabled == 1 && Typeid == '95'){
								//if (lblCustomUrl) lblCustomUrl.style.display = 'none';
								//if (lblProcStatusID) lblProcStatusID.style.display = 'none';
								//if (lblUrlMsg) lblUrlMsg.style.display = 'none';
								console.log('TobeEnabled' + item.TobeEnabled + Typeid);
				}
				});
			}
		}); 
		}
	}
           
    },
	checkBusinessUser: function () {
    var UserId = '';  	
	const BudgetLabel = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl07_lblMeasure');
    const Budgettext = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl07_txtMeasure');	
	User.get().then((_userData) => { 
    UserId = _userData.Id;
	console.log('UserId' + UserId);
	Procurement.getBusinessUser(UserId).then((list) => {	
        $.each(list, function (i, item) {
			if (item.IsBusinessUser == 1){
				 if (BudgetLabel && Budgettext) {					  
					   BudgetLabel[0].style.display = 'none';
					  Budgettext[0].style.display = 'none';
					}
			}
			else{
				 if (BudgetLabel && Budgettext) {
					 BudgetLabel[0].style.display = '';
					 Budgettext[0].style.display = ''; 					 
					}
			}
		})
      });
	 })
	},
	GetBidLockStatus: function (btn) {
	var Recordid = '';	
	Recordid =  Cmcs.getUrlParameter("id");
	
	console.log('Recordid' + Recordid + ' btn' + btn);
	Procurement.GetBidLock(Recordid).then((list) => {	
        $.each(list, function (i, item) {
			if (item.LockFlag == 1){
				btn.hide();
			}
			else{
				btn.show();
			}
		})
      });	 
	},
  
    getProcPublishStatus: (Recordid) => {
        return new Promise((resolve, reject) => {
            // var Recordid = 1;
            fetch(`${Cmcs.getApiUrl('Procurement/ProcurementPublishStatus')}?Recordid=${Recordid}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    // Assuming json is an array of objects (list)
                    resolve(json);
                }).catch((err) => {
                    reject(err);
                });
            }).catch((err) => {
                reject(err);
            });
        });
    },
	
    getUrl: (Typeid, Recordid) => {
        return new Promise((resolve, reject) => {
            var Username = '';
            fetch(`${Cmcs.getApiUrl('Procurement/Url')}?Typeid=${Typeid}&Recordid=${Recordid}&User=${Username}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    // Assuming json is an array of objects (list)
                    resolve(json);
                }).catch((err) => {
                    reject(err);
                });
            }).catch((err) => {
                reject(err);
            });
        });
    },
	getBusinessUser: (UserId) => {
        return new Promise((resolve, reject) => {
            // var Recordid = 1;
            fetch(`${Cmcs.getApiUrl('Procurement/GetBusinessUser')}?UserId=${UserId}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    // Assuming json is an array of objects (list)
                    resolve(json);
                }).catch((err) => {
                    reject(err);
                });
            }).catch((err) => {
                reject(err);
            });
        });
    },
	GetBidLock: (Recordid) => {
        return new Promise((resolve, reject) => {
            // var Recordid = 1;
            fetch(`${Cmcs.getApiUrl('Procurement/GetBidderRevisionLockFlag')}?EstimateBidderId=${Recordid}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    // Assuming json is an array of objects (list)
                    resolve(json);
                }).catch((err) => {
                    reject(err);
                });
            }).catch((err) => {
                reject(err);
            });
        });
    }



}

export { Procurement };