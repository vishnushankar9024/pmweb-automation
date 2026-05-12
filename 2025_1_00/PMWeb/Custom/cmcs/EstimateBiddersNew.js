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
var Typeid = '';



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
    },
	
	 getEOIUrl: (Typeid, Recordid) => {
        return new Promise((resolve, reject) => {
            var Username = '';
            fetch(`${Cmcs.getApiUrl('Procurement/EOIUrl')}?Typeid=${Typeid}&Recordid=${Recordid}&User=${Username}`, {
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
	 getEOIBidderUrl: () => {
        return new Promise((resolve, reject) => {
            fetch(`${Cmcs.getApiUrl('Procurement/EOIBidderUrl')}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                }).catch(reject);
            }).catch(reject);
        });
    }
};

function CreateWarningWindow(type) {	
	var title = '';
	
	var Recordid = '';
	var urlToOpen = '';
	Recordid =  Cmcs.getUrlParameter("id");
// Avoid null access error
    if (submitButton == null && type == 'Url') {
        console.error("submitButton is null — cannot continue");
        return;
    }
	if (submitButton == null && type !== 'Textbox') {
		console.error("submitButton is null — cannot continue");
		return;
	}
	
if (type == 'Url' && submitButton != null){
	//prebid
	if (submitButton.innerHTML == 'PreBid URL'){
		Typeid = '244';
		 title = 'PreBid';  
		// var urlToOpen = 'https://Cmcs.pmweb.com/custom/client?prebidId=20118&Id=0'; // Replace with your desired URL
	}
	//procurement
	else if (submitButton.innerHTML == 'Procurement URL'){
		Typeid = '94';
		// var urlToOpen = 'https://Cmcs.pmweb.com/custom/client?prebidId=20118&Id=20247';
		 title = 'Estimate Procurement';   
	}
	//Bidder
	else if (submitButton.innerHTML == 'Bidder URL'){
		Typeid = '95';
		// var urlToOpen = 'https://Cmcs.pmweb.com/custom/bidder?prebidId=20118&Id=20247&companyId=3';
		 title = 'Estimate Bidder';   
	}
	//prebid EOI url
	else if (submitButton.innerHTML == 'EOI URL'){
		Typeid = '244';
		 title = 'PreBid EOI';  
		// var urlToOpen = 'https://Cmcs.pmweb.com/custom/client?prebidId=20118&Id=0'; // Replace with your desired URL
	}
	} 
	if (type == 'Textbox')	
	{
		if (Cmcs.getUrlParameter("pageid") == 162)
		{
			Typeid = '95';
		}
		else if (Cmcs.getUrlParameter("pageid") == 161)
		{
			Typeid = '94';
		}
		else if (Cmcs.getUrlParameter("pageid") == 286)
		{
			Typeid = '244';
		}
	}
	if (submitButton != null && submitButton.innerHTML == 'EOI URL' && Typeid == '244') {
		Url.getEOIUrl(Typeid, Recordid).then((list) => {
    if (list.length === 0) {
        // Handle empty list
        console.log('No URLs found.');
        urlToOpen = '';  // Set urlToOpen to an empty value or handle as needed
    } else {
        // If list is not empty, iterate through it
        $.each(list, function (i, item) {
            console.log(item);
            console.log(item.App_URL);	
		if (item.App_URL == null)			
		{
			console.log('No URLs found.');
		}    
	if (type == 'Url'){
            urlToOpen = item.App_URL;  // Assuming you want the first URL or set it based on logic
			console.log(item.App_URL);
			if (clickType == 'rightclick')
			{				
			window.open(urlToOpen, '_blank');
			}
			else{
				openJqxWindow(urlToOpen, title);
			}
	}
	});
    }
	}).catch((err) => {
		console.error('Error fetching URL:', err);
	});	
	}
	else{
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
		if (item.App_URL == null)			
		{
			console.log('No URLs found.');
		}    
	if (type == 'Url'){
            urlToOpen = item.App_URL;  // Assuming you want the first URL or set it based on logic
			console.log(item.App_URL);
			if (clickType == 'rightclick')
			{				
			window.open(urlToOpen, '_blank');
			}
			else{
				openJqxWindow(urlToOpen, title);
			}
	}
	});
    }
	}).catch((err) => {
		console.error('Error fetching URL:', err);
	});	
	}

 
//For iframe
function openJqxWindow(urlToOpen, title) {
var leftPanelWidth = $('.drawer-modules').outerWidth();
var topBarHeight = $('.toolbartop').outerHeight();
var smalltoolbar =  $('.tblBreadCrumSegment').outerHeight();
var Middletoolbar =  $('.ExtensionToolbar').outerHeight();

var bottomtoolbar = $('.bottomtoolbar').outerHeight();
var topheight = topBarHeight + smalltoolbar + Middletoolbar;

var availableWidth = $(window).width() - leftPanelWidth;
var availableHeight = $(window).height() - topBarHeight - smalltoolbar - bottomtoolbar;
console.log('topheight:' + topheight);
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
//$('#EBConfirmModal .jqx-widget-content').html(`
//<iframe id="iframeContent" src="${urlToOpen}" style="width:100%; height:100%; border:none;"></iframe>
//<button id="closeBtn" style="position: absolute; top: 0px; left: 13px; padding: 3px; background-color: red; color: white; border: none; cursor: pointer;">Close</button>
//`);
$('#EBConfirmModal .jqx-widget-content').css("position","relative").html(`
 <button id="closeBtn" 
    style="
        position: absolute;
        top: 8px;
        left: 8px;
        z-index: 9999;
        padding: 4px 8px;
        background: #475467;
        color: #fff;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        font-weight: 600;
        font-size: 14px;
        backdrop-filter: blur(6px);
        transition: all 0.2s ease;
    "
    onmouseover="this.style.background='#3b4353'"
    onmouseout="this.style.background='#475467'"
    onmousedown="this.style.transform='scale(0.9)'"
    onmouseup="this.style.transform='scale(1)'"
>
✕
</button>
    <iframe id="iframeContent" src="${urlToOpen}" style="width:100%; height:100%; border:none;"></iframe>
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
iframeDocument.body.style.overflowX = 'auto';

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
	 CreateWarningWindow('Textbox'); 
	}
	var initClose = () => {
		   CreateWarningWindow('Url'); 
	}    
    return {
        initClose,
        handleClose,
		setSubmitButton,
		setclickType
    }
})();
export const EstimateBiddersNew = () => {
    if(Cmcs.getUrlParameter("pageid") == 162 || location.href.toLowerCase().indexOf('estimatebidders.aspx.aspx') || Cmcs.getUrlParameter("pageid") == 161 || location.href.toLowerCase().indexOf('estimateprocurements.aspx.aspx') > -1)
    {
        _eb.handleClose();
	}
	}
	window.ebConfirm = function(sender, event, type) {
		event.preventDefault();
    _eb.setSubmitButton(sender);
	_eb.setclickType(type);
	//For iframe
    _eb.initClose();
};

export const getEOIBidderUrl = () => {
    return new Promise((resolve, reject) => {
        fetch(`${Cmcs.getApiUrl('Procurement/EOIBidderUrl')}`, {
            method: "get"
        }).then(function (data) {
            data.json().then(function (json) {
                resolve(json);
            }).catch(reject);
        }).catch(reject);
    });
};

