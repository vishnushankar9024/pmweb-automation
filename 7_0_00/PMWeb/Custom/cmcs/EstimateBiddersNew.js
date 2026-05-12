import { Cmcs } from './CmcsApi.js';

var msgUpdate;

var MsgTitleUpdated = "Updated";
var MsgTitleSaved = "Saved";
var MsgTitleDeleted = "Deleted";
var MsgTitleRestored = "Restored";

var MsgTypeSuccess = "green";
var MsgTypeWarning = "orange";
var MsgTypeError = "red";


var submitButton = null; 
var clickType  = null;

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
    }
};

function CreateWarningWindow() {	
	var title = '';
	var Typeid = '';
	var Recordid = '';
	var urlToOpen = '';
	Recordid =  Cmcs.getUrlParameter("id");

	//prebid
	if (submitButton.innerHTML == 'PreBid URL'){
		Typeid = '244';
		 title = 'PreBid';  
		// var urlToOpen = 'https://cmcs.pmweb.com/custom/client?prebidId=20118&Id=0'; // Replace with your desired URL
	}
	//procurement
	else if (submitButton.innerHTML == 'Procurement URL'){
		Typeid = '94';
		// var urlToOpen = 'https://cmcs.pmweb.com/custom/client?prebidId=20118&Id=20247';
		 title = 'Estimate Procurement';   
	}
	//Bidder
	else if (submitButton.innerHTML == 'Bidder URL'){
		Typeid = '95';
		// var urlToOpen = 'https://cmcs.pmweb.com/custom/bidder?prebidId=20118&Id=20247&companyId=3';
		 title = 'Estimate Bidder';   
	}
	Url.getUrl(Typeid, Recordid).then((list) => {
    if (list.length === 0) {
        // Handle empty list
        console.log('No URLs found.');
        urlToOpen = '';  // Set urlToOpen to an empty value or handle as needed
    } else {
        // If list is not empty, iterate through it
        $.each(list, function (i, item) {
            console.log(item);
            console.log(item.App_URL);			
    // Find the TextBox element (modify the selector as needed for your setup)
    const textBox = document.getElementById('ctl00_CPH1_txtCustomUrl');

    // Set the hardcoded value to the TextBox
    if (textBox) {
        textBox.value = item.App_URL;
        console.log("TextBox value set to custom URL:", textBox.value);
    } else {
        console.error("TextBox not found!");
    }
	
            urlToOpen = item.App_URL;  // Assuming you want the first URL or set it based on logic
			console.log(item.App_URL);
			if (clickType == 'rightclick')
			{				
			window.open(urlToOpen, '_blank');
			}
			else{
				openJqxWindow(urlToOpen, title);
			}
	});
    }
	}).catch((err) => {
		console.error('Error fetching URL:', err);
	});	

    // Function to create and open the jqxWindow in full screen
 // function openJqxWindow(urlToOpen, title) {
 // var jqxWindow = $('#EBConfirmModal').jqxWindow({
 // autoOpen: false,
 // width: $(window).width(),
 // height: $(window).height(),
 // position: { x: 0, y: 0 },
 // title: title,
 // isModal: true,
 // resizable: false,
 // draggable: false,
 // showCloseButton: true
 // });

 // $('#EBConfirmModal > div:last-child').html(`
 // <iframe src="${urlToOpen}" style="width:100%; height:100%; border:none;"></iframe>
 // `);

 // jqxWindow.jqxWindow('open');

 // $(window).resize(function () {
 // jqxWindow.jqxWindow({
 // width: $(window).width(),
 // height: $(window).height()
 // });
 // });
 // }
// function to open jqx window in particular alignment with in pmweb page.
function openJqxWindow(urlToOpen, title) {
    var leftPanelWidth = $('.drawer-header').outerWidth();
    var topBarHeight = $('.toolbartop').outerHeight();
    var smalltoolbar = $('.SmallToolbar').outerHeight();
    var bottomtoolbar = $('.bottomtoolbar').outerHeight();
    var topheight = topBarHeight + smalltoolbar;

    var availableWidth = $(window).width() - leftPanelWidth;
    var availableHeight = $(window).height() - topBarHeight - smalltoolbar - bottomtoolbar;

    // Initialize jqxWindow
    var jqxWindow = $('#EBConfirmModal').jqxWindow({
        autoOpen: false,
        width: availableWidth,
        height: availableHeight,
        position: { x: leftPanelWidth, y: topheight },
        isModal: true,
        resizable: false,
        draggable: false,
        showCloseButton: false,
		title: ''
    });

    // Inject CSS dynamically
    const styleSheet = document.createElement('style');
    styleSheet.type = 'text/css';
    styleSheet.innerHTML = `
        #EBConfirmModal {
            width: ${availableWidth}px !important;
            height: ${availableHeight}px !important;
            top: ${topheight}px !important;
            left: ${leftPanelWidth}px !important;
            max-width: ${availableWidth}px !important;
            max-height: ${availableHeight}px !important;
            overflow: hidden !important; /* Modal container should not scroll */
        }
        #EBConfirmModal iframe {
            width: 100% !important;
            height: 100% !important;
            border: none;
        }
    `;
    document.head.appendChild(styleSheet);

    // Set iframe content
    $('#EBConfirmModal .jqx-widget-content').html(`
        <iframe id="iframeContent" src="${urlToOpen}" style="width:100%; height:100%; border:none;"></iframe>
		<button id="closeBtn" style="position: absolute; top: 0px; right: 13px; padding: 3px; background-color: red; color: white; border: none; cursor: pointer;">Close</button>
    `);
	  $('#closeBtn').on('click', function () {
        jqxWindow.jqxWindow('close');
    });
    // Force scrolling inside iframe after it loads
    $('#iframeContent').on('load', function () {
        const iframe = document.getElementById('iframeContent');
        const iframeDocument = iframe.contentWindow.document;

        // Allow vertical scroll in the iframe content
        iframeDocument.body.style.overflowY = 'auto';
        iframeDocument.body.style.overflowX = 'hidden';
		
    });
	// Target the header of the jqxWindow
$('#EBConfirmModal .jqx-window-header > div[style*="float: left"]').remove();

    // Open jqxWindow
    jqxWindow.jqxWindow('open');

    // Adjust on window resize
    $(window).resize(function () {
        availableWidth = $(window).width() - leftPanelWidth;
        availableHeight = $(window).height() - topBarHeight - smalltoolbar - bottomtoolbar;

        jqxWindow.jqxWindow('setWidth', availableWidth);
        jqxWindow.jqxWindow('setHeight', availableHeight);
		$('#iframeContent').css('height', availableHeight - 20 + 'px');

        styleSheet.innerHTML = `
            #EBConfirmModal {
                width: ${availableWidth}px !important;
                height: ${availableHeight}px !important;
                top: ${topheight}px !important;
                left: ${leftPanelWidth}px !important;
                max-width: ${availableWidth}px !important;
                max-height: ${availableHeight}px !important;
                overflow: hidden !important;
            }
            #EBConfirmModal iframe {
                width: 100% !important;
                height: 100% !important;
                border: none;
            }
        `;
    });
}


}

var _eb = (() => {	
    var setSubmitButton = (button) => {
        submitButton = button;
		console.log(submitButton);
		console.log(button.innerHTML); 
    }  
	  var setclickType = (type) => {
        clickType = type;
		console.log(clickType);
		
    } 
    var handleClose = () => {
	
	}
	var initClose = () => {
		   CreateWarningWindow(); 
	}    
    return {
        initClose,
        handleClose,
		setSubmitButton,
		setclickType
    }
})();
export const EstimateBiddersNew = () => {
    if(Cmcs.getUrlParameter("pageid") == 162 || location.href.toLowerCase().indexOf('estimatebidders.aspx.aspx') > -1)
    {
        _eb.handleClose();
	}
	}
	window.ebConfirm = function(sender, event, type) {
		event.preventDefault();
    _eb.setSubmitButton(sender);
	_eb.setclickType(type);
	
    _eb.initClose();
}

