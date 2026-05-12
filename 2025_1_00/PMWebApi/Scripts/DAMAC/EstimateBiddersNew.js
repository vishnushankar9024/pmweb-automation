import { DAMAC } from './DAMACApi.js';

var msgUpdate;

var MsgTitleUpdated = "Updated";
var MsgTitleSaved = "Saved";
var MsgTitleDeleted = "Deleted";
var MsgTitleRestored = "Restored";

var MsgTypeSuccess = "green";
var MsgTypeWarning = "orange";
var MsgTypeError = "red";


var submitButton = null; 

function showNotification(title, content, type, control, bscroll, FormAndRow, oldValue) {
    var form = ""
    if (FormAndRow != undefined) {
        form = FormAndRow;
    }

    if (bscroll == undefined) {
        bscroll = true;
    }
    $.confirm({
        title: title,
        content: content,
        type: type,
        backgroundDismiss: true,
        //autoClose: 'close|5000',
        animation: 'zoom',
        closeAnimation: 'scale',
        typeAnimated: false,
        animateFromElement: false,
        scrollToPreviousElement: bscroll,
        buttons: {
            close: function () {
            }

        },
        onDestroy: function () {

            if (control != "") {
                $("#" + control).focus();
            }
            if (FormAndRow != undefined && oldValue != undefined) {

                var SiNo = form.match(/\d+/);
                var FormName = form.replace(/\d+/g, '');


            }
        }
    });

}

const Url = {
    getUrl: (Typeid, Recordid) => {
        return new Promise((resolve, reject) => {
            var Username = '';
            fetch(`${DAMAC.getApiUrl('Procurement/Url')}?Typeid=${Typeid}&Recordid=${Recordid}&User=${Username}`, {
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
};
function CreateWarningWindow() {
	
    var title = '';
    Url.getUrl('244', '0').then((list) => {
        // Assuming the list is an array of ProcURL objects
        $.each(list, function (i, item) {
            console.log(item);  // Logs each ProcURL object in the list
            // For example, if you want to access the URL in the object, you can use:
            console.log(item.App_URL);  // Assuming the property is "App_URL"
        });
    }).catch((err) => {
        console.error('Error fetching URL:', err);
    });
	//prebid
	//if (submitButton.innerHTML == 'PreBid URL'){
	//	title = 'PreBid';  
	//	var urlToOpen = 'https://cmcs.pmweb.com/custom/client?prebidId=20118&Id=0'; // Replace with your desired URL
	//}
	////procurement
	//else if (submitButton.innerHTML == 'Procurement URL'){
	//	var urlToOpen = 'https://cmcs.pmweb.com/custom/client?prebidId=20118&Id=20247';
	//	title = 'Estimate Procurement';   
	//}
	////Bidder
	//else if (submitButton.innerHTML == 'Bidder URL'){
	//	var urlToOpen = 'https://cmcs.pmweb.com/custom/bidder?prebidId=20118&Id=20247&companyId=3';
	//	title = 'Estimate Bidder';   
	//}
	
console.log(title);
    // Define the jqxWindow to occupy the full screen
    var jqxWindow = $('#EBConfirmModal').jqxWindow({
        autoOpen: false,
        width: $(window).width(),  // Full width
        height: $(window).height(), // Full height
        position: { x: 0, y: 0 }, // Align to top-left corner
        title: title,
        isModal: true,
        resizable: false, // Disable resizing
        draggable: false, // Disable dragging
        showCloseButton: true // Add close button for user convenience
    });

    // Set the content dynamically to include an iframe for the URL
    $('#EBConfirmModal > div:last-child').html(`
        <iframe src="${urlToOpen}" style="width:100%; height:100%; border:none;"></iframe>
    `);

    // Open the window
    jqxWindow.jqxWindow('open');

    // Handle window resize to adjust the jqxWindow size dynamically
    $(window).resize(function () {
        jqxWindow.jqxWindow({
            width: $(window).width(),
            height: $(window).height()
        });
    });
}

var _eb = (() => {
	
 //   var setSubmitButton = (button) => {
 //       submitButton = button;
	//	console.log(submitButton);
	//	  console.log(button.innerHTML); 
 //   }
  
   var handleClose = () => {
	
	}
	var initClose = () => {
		   CreateWarningWindow(); 
	}    
    return {
        initClose,
        handleClose,
		//setSubmitButton
    }
})();
export const EstimateBiddersNew = () => {
    if(DAMAC.getUrlParameter("pageid") == 162 || location.href.toLowerCase().indexOf('estimatebidders.aspx.aspx') > -1)
    {
        _eb.handleClose();
	}
	}
	window.ebConfirm = function(sender) {
   // _eb.setSubmitButton(sender);
	
    _eb.initClose();
}

