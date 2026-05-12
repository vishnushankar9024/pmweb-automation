import { Cmcs } from './CmcsApi.js';

import { CustomForm } from './CustomForm.js';

import { EstimateBiddersNew } from './EstimateBiddersNew.js';

import { EstimateBiddersSubmit } from './EstimateBiddersSubmit.js';

import { Procurement } from './Procurement.js';



let previousTab = '';  // Store the previously selected tab

$(document).ajaxComplete(function( event, xhr, settings ) {
	console.log('test');
});
window.onCmcsResponseEnd = function(sender, eventArgs) {
	if (args.EventTargetElement) args.EventTargetElement.disabled = false;
	console.log('Reponsed end initiated by: '+ eventArgs.get_eventTarget());
}


window.onddlPHProjectLoad = function (sender, args)   {
    alert(sender._uniqueId);  
}
 
$(document).ready(function () {
	// Procurement related changes
	window.initAll = function (btn) {	
		 // If a button is passed, submit button id from online bids page
		if (btn) {
			if (Cmcs.getUrlParameter('PageId') == 162)
			{
			try {
				Procurement.GetBidLockStatus(btn);
			} catch (e) {
				console.warn("Could not update button:", e);
			}
			}
		}
		Procurement.hasFetchedProcStatus = false;
		Procurement.GetProcStatus();
		EstimateBiddersNew();
		// To hide Recap fields based on recap security on RFA and commitments
		 if (Cmcs.getUrlParameter('PageId') == 106 || Cmcs.getUrlParameter('PageId') == 161 || Cmcs.getUrlParameter('PageId') == 286){
			  console.log('Entering recap..');
				  CustomForm.Recap();				
		 }
		// if (Cmcs.getUrlParameter('PageId') == 286){
		 // Procurement.checkBusinessUser();		
		 // }		
	}; 
	
	// Procurement related changes
	 if (Cmcs.getUrlParameter('PageId') == 106 || Cmcs.getUrlParameter('PageId') == 161 || Cmcs.getUrlParameter('PageId') == 286){
	    CustomForm.Recap(); 
	
	 }   
	
	Cmcs.onProjectChanged(() => {	
	// Procurement related changes
	    if (Cmcs.getUrlParameter('PageId') == 286 || Cmcs.getUrlParameter('PageId') == 161 || Cmcs.getUrlParameter('PageId') == 162){
		initAll();
		}	
	});
	
	Cmcs.onCommitmentAdditionalTabChanged(() => {	
	// To hide Recap fields and additional info tab based on recap security on RFA and commitments
	if (Cmcs.getUrlParameter('PageId') == 106 || Cmcs.getUrlParameter('PageId') == 161 || Cmcs.getUrlParameter('PageId') == 286){
	  CustomForm.Recap();	
	}
	});	 
	
});
Cmcs.onCommitmentmainTabChanged(() => {
	    // Procurement related changes
	    if (Cmcs.getUrlParameter('PageId') == 286 || Cmcs.getUrlParameter('PageId') == 161 || Cmcs.getUrlParameter('PageId') == 162){
		setTimeout(() => {
			const currentTab = Cmcs.mainTab().get_selectedTab().get_text().toLowerCase();

			if (currentTab === 'main' && previousTab !== 'main') {
				Procurement.hasFetchedProcStatus = false;
				Procurement.GetProcStatus();
				
			}

			previousTab = currentTab;
		}, 100); // Delay 100ms to allow tab switch to fully apply
		}
		
	});
	
  function ApplicationSubmitted(Id) {
		// if ($("#txtStatus").val() != 'Draft')
		if ($("#txtSubmitted").val() != '')
		{
		console.log($("#txtStatus").val());
		console.log($("#txtSubmitted").val());
            alert(Msg_ApplicationSubmitted);
            window.location = "Application_AccountDetails.aspx?Id=" + Id;
		}
		else{
			alert('Please attach files to submit the application');
		}
	}	

	$(() => {
		// Procurement related changes
	    if (Cmcs.getUrlParameter('PageId') == 286 || Cmcs.getUrlParameter('PageId') == 161 || Cmcs.getUrlParameter('PageId') == 162){
			
		EstimateBiddersNew();			
		EstimateBiddersSubmit();
		Procurement.hasFetchedProcStatus = false;
		Procurement.GetProcStatus();	
		 // If a button is passed, submit button id from online bids page
		
		if (Cmcs.getUrlParameter('PageId') == 162)
			{
			try {
				 // Find the Telerik-generated hidden field
				var clientStateInput = $("input[id$='_mainToolBar_ClientState']")[0];
				if (!clientStateInput) {
					console.warn("mainToolBar ClientState input not found.");
					return;
				}
				   // Extract the actual RadToolBar client ID (remove '_ClientState')
				var toolbarClientId = clientStateInput.id.replace('_ClientState', '');

				var mainToolBar = $find(toolbarClientId);
				if (!mainToolBar) {
					console.warn("RadToolBar instance not found for:", toolbarClientId);
					return;
				}
				 // Find the button inside the toolbar
				var button = mainToolBar.findItemByValue("SubmitBIDConfirm");				
				Procurement.GetBidLockStatus(button);
			} catch (e) {
				console.warn("Could not update button:", e);
			}
		}
		 // if (Cmcs.getUrlParameter('PageId') == 286){
		 // Procurement.checkBusinessUser();		
		 // }
				
		}
		//Procurement page changes ends here
	});
	

