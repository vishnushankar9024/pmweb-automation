import { Cmcs } from './CmcsApi.js';
import { User } from './User.js';
var msgUpdate;

var MsgTitleUpdated = "Updated";
var MsgTitleSaved = "Saved";
var MsgTitleDeleted = "Deleted";
var MsgTitleRestored = "Restored";

var MsgTypeSuccess = "green";
var MsgTypeWarning = "orange";
var MsgTypeError = "red";


var submitButton = null;


const BiddersSubmit = {   
      
        getBidderPublishStatus: (Recordid) => {
            return new Promise((resolve, reject) => {                
                fetch(`${Cmcs.getApiUrl('Procurement/BiddersPublishStatus')}?Recordid=${Recordid}`, {
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
function CreateWarningWindow() {
	var Recordid = '';
	Recordid =  Cmcs.getUrlParameter("id");
    var kwindow = $('#EBConfirmPopupModal').jqxWindow({
        autoOpen: false,
        width: 350,
        height: 200,
        title: 'Confirm Submission',//"WARNING RELATED TO USE OF CONFIDENTIAL INFORMATION",
        // visible: true,
        isModal: true,
		// content: $("#EBConfirmPopupModal").html()
    }).data("jqxWindow");
	 // Initialize Bidder Not Submitted Popup
    $("#BidderNotSubmittedPopup").jqxWindow({
        width: 400,
        height: 150,
        autoOpen: false,
        isModal: true,       
    });

    $("#EBConfirmPopupModal").jqxWindow('open');
   
    $('#btSubmitCancel').click(() => {
        $("#EBConfirmPopupModal").jqxWindow('close');

    });
	  $('#btnCloseBidderPopup').click(() => {
        $("#BidderNotSubmittedPopup").jqxWindow('close');

    });
	
    
    $('#btnSubmitConfirm').click((event) => {
        event.preventDefault(); // Prevent the default form submission behavior
        
		BiddersSubmit.getBidderPublishStatus(Recordid).then((list) => {
		if (list.length === 0) {
			// Handle empty list
			$("#BidderNotSubmittedPopup").jqxWindow('open');
			console.log('bidder is not submitted in tool');       
		} else {
			// If list is not empty, iterate through it
			$.each(list, function (i, item) {				
				console.log(item.Status);	
							
			if (item.Status == 1) {
			if (submitButton) {
				__doPostBack(submitButton.name, '');
			}
			if (submitButton.disabled) {
				console.log("Submit button is disabled. Enabling it...");
				submitButton.disabled = false;
			}
			console.log("Clicking submit button...");
			submitButton.click();
			}					
				
				else{	
					$("#BidderNotSubmittedPopup").jqxWindow('open');
				}	
			});
		}	
		});		

			// Delay the modal close and refresh to ensure submit completes
			setTimeout(() => {
				$("#EBConfirmPopupModal").jqxWindow('close'); // Close the modal window
				// CloseGoPopup(); // Call the close function (which includes refresh)
			}, 100); // Adjust delay as needed to allow submit to process
		});


}

var _eb = (() => {

    var setSubmitButton = (button) => {
        submitButton = button;
    }

    var handleClose = () => {

    }
    var initClose = () => {
        CreateWarningWindow();
    }
    return {
        initClose,
        handleClose,
        setSubmitButton
    }
})();
export const EstimateBiddersSubmit = () => {
    if (Cmcs.getUrlParameter("pageid") == 162 || location.href.toLowerCase().indexOf('estimatebidders.aspx.aspx') > -1) {
        _eb.handleClose();
        //EstimateBiddersSubmit();
    }
}
window.ebSubmitConfirm = function (sender) {
    _eb.setSubmitButton(sender);

    _eb.initClose();
}

