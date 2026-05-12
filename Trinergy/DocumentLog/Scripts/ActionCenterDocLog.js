var isProduction = false;
var global = {
    url: {},
    pmwebUsername: '',
    pmwebUserId: '',
    getAjax: function(url, data, callback) {
        $.ajax({
            url: url,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: data,
            //beforeSend: function () {
            //    $('#pleaseWaitDialog').modal('show');
            //},
            //complete: function () {
            //    $('#pleaseWaitDialog').modal('hide');
            //},
            async: true,
            cache: false,
            success: function(data) {
                callback(data);
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    }
};

function RedirectToPMweb() {
    if (isProduction == true) {
        window.top.location.href = "pmweb/";
    }
}

function calcDataTableHeight(isActionCenter) {
    if (window.top.location != window.location) {

        if (isActionCenter) {
            return $(window).height() - 60;
        } else {
            return $(window).height() - 10;
        }
    } else {
        return ($(window).height() * 0.95);
    }
}

function CheckSession(successCallBack, checkPMWebSession) {
    $.ajax({
        url: global.url.GetSession,
        dataType: "JSON",
        type: "GET",
        contentType: 'application/json;charset=utf-8',
        //beforeSend: function () {
        //    $('#pleaseWaitDialog').modal();
        //},
        async: true,
        cache: false,
        success: function(data) {
            if (data.UserId > 0 && !checkPMWebSession) {
                successCallBack();
            } else {
                CheckPMWebSession(successCallBack);
            }
        },
        error: function(xhr) {
            RedirectToPMweb();
        }
    });
}

function checkpmwebsession(successcallback) {
    $.ajax({
        url: 'https://cmcs.pmweb.com/9_0_00/pmweb/custom/pmwebhelper.aspx/getuser',
        datatype: "json",
        type: "get",
        contenttype: 'application/json;charset=utf-8',
        async: false,
        cache: false,
        success: function(data) {
            var data = json.parse(data.d);
            if (data.id > 0) {
                ceatesession(data.id, successcallback);
            } else {
                redirecttopmweb();
            }
        },
    });
}
// function CheckPMWebSession(successCallBack) {
// $.ajax({
// url: '/WebForms/PMWebHelper.aspx/GetUser', // Updated path to the WebForms folder
// dataType: "json",
// type: "GET",
// contentType: 'application/json;charset=utf-8',
// async: false,
// cache: false,
// success: function (data) {
// var data = JSON.parse(data.d);
// if (data.Id > 0) {
// CeateSession(data.Id, successCallBack);
// } else {
// RedirectToPMweb();
// }
// },
// error: function (xhr) {
// console.error("Error in CheckPMWebSession:", xhr);
// }
// });
// }

function CeateSession(userId, successCallBack) {
    $.ajax({
        type: "GET",
        url: global.url.CeateSession + "?userid=" + userId,
        success: function(data) {
            successCallBack();
        },
        error: function(err) {
            RedirectToPMweb();
        }
    });
}

function ShowTeamInputDetails(docId, userId) {
    CheckSession(function() {
        $.ajax({
            url: global.url.GetTeamInputDetails,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                documentId: docId,
                userId: userId
            },
            beforeSend: function() {
                $('#pleaseWaitDialog').modal();
            },
            complete: function() {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function(data) {
                var modal = $('#teamInputModal');
                $('.modal-body', modal).html(data);
                $('.modal-body', modal).scrollTop(0);
                $('.modal-body', modal).animate({
                    scrollTop: $('.modal-body', modal).offset().top
                });
                modal.modal();
                $('.modal-body', modal).focus();
            },
            error: function(xhr) {
                //alert("failed");
            }
        });
    });
}

//-----------------------------------------------------------------------
function GetAttachments(DocId, Obj) {

    CheckSession(function () {
        $.ajax({
            url: global.url.GetAttachments,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                DocId: DocId
            },
            beforeSend: function () {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function () {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function (data) {
                //var tr = '<tr class="tempRow"><td colspan="16">' + data + '</td></tr>'
                //$(Obj).closest("tr").after(tr);
                var modal = $('#attachmentModal');
                $('.modal-body', modal).empty();
                $('.modal-body', modal).html(data);
                modal.modal();
                AttachmentsCallBack();
            },
            error: function (xhr) {
                RedirectToPMweb();
            }
        });
    });
}

function GetAttachmentsByRecordId(recordId, objectTypeId, documentId) {

    CheckSession(function () {
        $.ajax({
            url: global.url.GetAttachments,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                recordId: recordId,
                objectTypeId: objectTypeId,
                documentId: documentId
            },
            beforeSend: function () {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function () {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function (data) {
                //var tr = '<tr class="tempRow"><td colspan="16">' + data + '</td></tr>'
                //$(Obj).closest("tr").after(tr);
                var modal = $('#attachmentModal');
                $('.modal-body', modal).empty();
                $('.modal-body', modal).html(data);
                modal.modal();
                AttachmentsCallBack();
            },
            error: function (xhr) {
                RedirectToPMweb();
            }
        });
    });
}

function GetAttachmentsActionCenter(projectId, recordId, DocId, Obj) {
    CheckSession(function() {
        $.ajax({
            url: global.url.GetAttachments + 'WithUpload',
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                projectId: projectId,
                recordId: recordId,
                DocId: DocId
            },
            beforeSend: function() {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function() {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function(data) {
                var modal = $('#attachmentModal');
                $('.modal-body', modal).empty();
                $('.modal-body', modal).html(data);
                modal.modal();
                AttachmentsCallBack();
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    });
}

function GetWorkflowStatus(RecordId, Obj) {
    CheckSession(function() {
        $.ajax({
            url: global.url.GetWorkflowStatus,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                RecordId: RecordId,
                "_": Math.random()
            },
            beforeSend: function() {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function() {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function(data) {
                var modal = $('#workflowModal');
                $('.modal-body', modal).html(data);
                modal.modal();
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    });
}

function GetRecord(url, ocs, checkPMWebSession) {
    CheckSession(function() {
        if (ocs) {
            $.ajax({
                url: 'OCS/CeateSession.aspx?username=' + global.pmwebUsername + '&userid=' + global.pmwebUserId,
                dataType: "html",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                beforeSend: function() {
                    $('#pleaseWaitDialog').modal('show');
                },
                complete: function() {
                    $('#pleaseWaitDialog').modal('hide');
                },
                async: true,
                cache: false,
                success: function() {
                    LoadFrame(url, ocs);
                    $('#pmwebRecordFrame').css('width', '800px !important');
                },
                error: function(xhr) {
                    LoadFrame(url, ocs);
                }
            });
        } else {
            $('#pleaseWaitDialog').modal('hide');
            LoadFrame(url, ocs);
        }
    }, checkPMWebSession);
}
var _iframe = null;
 function LoadFrame(url, ocs) {
    var modal = $('#pmwebModal');
    $(".lds-ring").show();

    var h = $(window).height();
	
    $(".modal-dialog", modal).css({ "height": h, "width": '100%', "min-width": '98%'});
    h = h - 50; // Adjust for modal header
    $(".modal-content", modal).css({ "height": h, "max-height": h, 'margin-top': '-10px', 'margin-left': '-10px', 'overflow': 'hidden' }); // Prevent outer scroll
    h = h - 60; // Adjust for footer
    h = h >= 500 ? h : 520;
    $(".modal-body", modal).css({ "height": h, "max-height": h, 'overflow': 'hidden' }); // Prevent outer scroll
    modal.modal();
    $("#pmwebRecordFrame").remove();

    var scrolling = ocs ? 'yes' : 'yes';

    if (_iframe != null) {
        _iframe.remove();
        _iframe = null;
    }

    _iframe = $('<iframe>', {
        src: url,
        id: 'pmwebRecordFrame',
        frameborder: 0,
        scrolling: scrolling,
        style: 'width: 100%; height: 100%;' // Make iframe fill the modal
    }).on('load', function () {
        $(".lds-ring").hide();
        $("#pleaseWaitDialog").hide();

        var iframeContent = $(this).contents();

        // Hide the toolbar div if present
		
        // iframeContent.find('#ctl00_toolbartop').remove();
        // Hide the drawer if present
        iframeContent.find('.MenuContainer').remove();

        // Fix the toolbar at the top
 var $toolbar = iframeContent.find('.ToolBar');
// $toolbar.css({
    // 'position': 'fixed',
    // 'top': '0'+'px',
    // 'width': '100%',
    // 'z-index': '1000',
    // 'background-color': '#fff',
    // 'box-shadow': '0 2px 5px rgba(0, 0, 0, 0.1)',
    // 'margin': '0',
    // 'padding': '0'
// });
var contentPadding1 = $toolbar.outerHeight()
console.log(contentPadding1);
if ($toolbar.outerHeight() == 0)
{
	contentPadding1 = 50
	console.log(contentPadding1);
	}
else
{
	console.log(contentPadding1);
}
// Adjust the RadTabStrip positioning and add temporary styles for visibility
var $radTabStrip = iframeContent.find('.RadTabStrip_Default');
// $radTabStrip.css({
    // 'display': 'block !important', // Force display
    // 'position': 'fixed',
    // 'top': contentPadding1 + 'px', // Add extra spacing from the toolbar
    // 'width': '100%',
    // 'z-index': '999', // Ensure it’s below the toolbar but above content
    // 'background-color': '#fff',
    // 'box-shadow': '0 2px 5px rgba(0, 0, 0, 0.1)',
    
   
// });


// // Adjust the content pane padding to account for both toolbar and RadTabStrip heights
 var contentPadding = $toolbar.outerHeight() + $radTabStrip.outerHeight();
 iframeContent.find('.ContentPane').css({
   
     'width': '100%',
     'margin-left': '0'
 });
 iframeContent.find('#ctl00_toolbartop').css({
   
     'width': '100%',
     'margin-left': '0'
 });


        // Set iframe height dynamically if necessary
        setTimeout(function () {	 
	
        setFrameHeight($(this), url, ocs);
        }.bind(this), 200);
    }).appendTo($(".modal-body", modal));

    if (!ocs) {
        _iframe.hide();
    }
}




// function LoadFrame(url, ocs) {

// var modal = $('#pmwebModal');
// $(".lds-ring").show();
// //$('.modal-title', modal).text(project + ' - ' + formName);
// //$("#modalRecordNo", modal).text(recordNo);
// //$("#modalReferenceNo", modal).text(reference);
// //$("#modalSubject", modal).text(subject);
// var lastScrollHeight = 0;
// var h = $(window).height();
// $(".modal-dialog", modal).css({ "height": h });
// h = h - 50;
// $(".modal-content", modal).css({ "height": h, "max-height": h, 'margin-top': '-10px', 'margin-left': '-10px' });
// h = h - 60;
// h = h >= 500 ? h : 500;
// $(".modal-body", modal).css({ "height": h, "max-height": h });
// modal.modal();
// $("#pmwebRecordFrame").remove();
// var scrolling = 'no';
// if (ocs) {
// scrolling = 'yes';
// }

// if (_iframe != null) {
// _iframe.remove();
// _iframe = null;
// }
// _iframe = $('<iframe>', {
// src: url,
// id: 'pmwebRecordFrame',
// frameborder: 0,
// scrolling: scrolling,
// style: 'width: 800px; height: 720px;', // Set width directly in style
// }).load(function () {
// $(".lds-ring").hide();
// $("#pleaseWaitDialog").hide();
// var obj = $(this);

// var doc = obj.get(0).contentDocument || obj.get(0).contentWindow.document;
// console.log(doc);
// $(doc).ajaxStop(function () {
// console.log('ajaxStop');
// });

// //obj.get(0).contentDocument.body.addEventListener('click', function (event) {
// //    setFrameHeight(obj, url, ocs);
// //    //setTimeout(function () {
// //    //    setFrameHeight(obj, url, ocs);
// //    //}, 5000);
// //}, false);

// setTimeout(function () {
// setFrameHeight(obj, url, ocs);
// }, 200);
// }).appendTo($(".modal-body", modal));
// if (!ocs) {
// _iframe.hide();
// }
// }
							  
								 
						  
							   

								   
				   
	   
			   
									
					
						
							  
							  
	   
			   
						   
								 
					
						
					   
											   

				  
									

									   

						  
						 
					   
	 

																	  
							 
				 
							   
					   
							 
																									  
						 
							  
									  

						  
																				  

										   

											   
																						   
												
													

											

																	
																
																		   
																  
							 
																	
																  
																  
						  
		   

															  
						 

														   
								
										  
				
										 

			   
					   
	 
 


function setFrameHeight(obj, url, ocs) {
    var modal = $('#pmwebModal');
    var modalBodyHeight = $(".modal-body", modal).height();

    // Limit iframe height to stay within modal-body's height
    obj.css({
        width: $(".modal-body", modal).width(),
        height: modalBodyHeight - 20 // Adjust if needed
    });

    // Set dynamic iframe content height with limits
    var frameContentHeight = Math.min(obj.get(0).contentDocument.body.scrollHeight + 100, modalBodyHeight);
    var frameContentWidth = obj.get(0).contentDocument.body.scrollWidth + 100;

																			
																		  
    if (url.toLowerCase().indexOf('pmwebhelper') < 0) {
        frameContentHeight = Math.max(frameContentHeight - 50, 720); // Minimum height constraint
																				  
    }

    obj.css({
        "height": frameContentHeight + 'px',
        "width": frameContentWidth + 'px'
    });
    obj.attr("height", frameContentHeight);
			 
										 
	   
    obj.attr("width", frameContentWidth);

    if (!ocs) {

									   
        var itrCount = 0;

        onElementHeightChange(obj.get(0).contentDocument.body, function() {
            frameContentHeight = Math.min(obj.get(0).contentDocument.body.scrollHeight, modalBodyHeight - 20);

            if (url.toLowerCase().indexOf('pmwebhelper') < 0) {
                frameContentHeight = Math.max(frameContentHeight - 50, 720);
																						  
            }
            obj.css({
                "height": frameContentHeight + 'px'
            });
            obj.attr("height", frameContentHeight);
        });

        onElementWidthChange(obj.get(0).contentDocument.body, function() {
            frameContentWidth = obj.get(0).contentDocument.body.scrollWidth;
								
			 
            obj.css({
                "width": frameContentWidth + 'px'
            });
            obj.attr("width", frameContentWidth);
			 
            itrCount++;
        });
        obj.fadeIn(1000);
    }

    if (_iframe) {
        _iframe.show();
    }
    if (obj) {
        obj.show();
    }
}



function DownloadFolder(FolderId, DocId) {
    CheckSession(function() {
        $.ajax({
            url: global.url.DownloadFolder,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                FolderId: FolderId,
                DocId: DocId
            },
            beforeSend: function() {
                $('#attachmentDownloadDialog').modal('show');
                $('#attachmentModal').hide();
            },
            complete: function() {
                $('#attachmentDownloadDialog').modal('hide');
                $('#attachmentModal').show();
            },
            async: true,
            cache: false,
            success: function(data) {
                var json = JSON.parse(data)
                var newWin = window.open(json.downloadLink, "_blank");
                if (!newWin || newWin.closed || typeof newWin.closed == 'undefined') {
                    alert('Disable popup blocker to download.');
                }
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    });
}
function DownloadFolderByFolder(FolderId,ObjectTypeId,RecordId,DocId) {
    CheckSession(function () {
        $.ajax({
            url: global.url.DownloadFolderByFolder,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                FolderId: FolderId,
                DocId: DocId,
                ObjectTypeId: ObjectTypeId,
                RecordId: RecordId,
            },
            beforeSend: function () {
                $('#attachmentDownloadDialog').modal('show');
                $('#attachmentModal').hide();
            },
            complete: function () {
                $('#attachmentDownloadDialog').modal('hide');
                $('#attachmentModal').show();
            },
            async: true,
            cache: false,
            success: function (data) {
                var json = JSON.parse(data)
                var newWin = window.open(json.downloadLink, "_blank");
                if (!newWin || newWin.closed || typeof newWin.closed == 'undefined') {
                    alert('Disable popup blocker to download.');
                }
            },
            error: function (xhr) {
                RedirectToPMweb();
            }
        });
    });
}
																	   
							  
				
												   
							 
						
														  
				   
								   
							 
										   
								   
			  
									 
															 
											 
			  
								   
															 
											 
			  
						
						 
									  
										   
																	  
																					  
																
				 
			  
								   
								  
			 
		   
	   
 
function AttachmentsCallBack() {
    $("#accordion").accordion({
        header: "h3",
        collapsible: true,
        autoHeight: false,
        navigation: true,
        heightStyle: "content"
    });
}

function GetActionCenterDocuments(dataId) {
    CheckSession(function() {
        $.ajax({
            url: global.url.ActionCenterPendingDocs,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                dataId: dataId
            },
            beforeSend: function() {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function() {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function(data) {
                $('#divListPD').html(data);
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    });
}

//function AddActionCenterButtons(dataId, pendingCount, teamInputRequestedCount, teamInputRecievedCount, overdueCount, overdueMorethanFourteenDaysCount) {
//    var buttons = $(".dt-buttons");
//    var active = '';

//    $('.dt-button').each(function () {
//        $(this).removeClass('dt-button');
//        //$(this).addClass('btn btn-primary-custum');
//    });

//    active = '';
//    if (dataId == 4) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-danger ' + active + '">Overdue more than 14 days <span class="badge badge-light">' + overdueMorethanFourteenDaysCount + '</span></a>').click(function () {
//        GetActionCenterDocuments(4);
//    }).prependTo(buttons);

//    active = '';
//    if (dataId == 3) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-dark ' + active + '">Overdue <span class="badge badge-light">' + overdueCount + '</span></a>').click(function () {
//        GetActionCenterDocuments(3);
//    }).prependTo(buttons);

//    active = '';
//    if (dataId == 2) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-info ' + active + '">Team Input Received <span class="badge badge-light">' + teamInputRecievedCount + '</span></a>').click(function () {
//        GetActionCenterDocuments(2);
//    }).prependTo(buttons);

//    active = '';
//    if (dataId == 1) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-primary ' + active + '">Team Input Requested <span class="badge badge-light">' + teamInputRequestedCount + '</span></a>').click(function () {
//        GetActionCenterDocuments(1);
//    }).prependTo(buttons);

//    active = '';
//    if (dataId == 0) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-success ' + active + '">Total Pending <span class="badge badge-light">' + pendingCount + '</span></a>').click(function () {
//        GetActionCenterDocuments(0);
//    }).prependTo(buttons);
//}

function GetActionedDocuments(dataId, dtStart, dtEnd) {
    CheckSession(function() {
        $.ajax({
            url: global.url.ActionedDocs,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                dataId: dataId,
                dtStart: dtStart,
                dtEnd: dtEnd
            },
            beforeSend: function() {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function() {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function(data) {
                $('#divListActionedDocs').html(data);
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    });
}

//var startDate = '';
//var endDate = '';
//function AddActionedDocumentButtons(dataId, todayActionedDocumentsCount, totalCount, dtStart, dtEnd, dtStartPicker, dtEndPicker) {
//    startDate = dtStart;
//    endDate = dtEnd;
//    var buttons = $(".dt-buttons");
//    var active = '';

//    active = '';
//    if (dataId == 1) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-primary ' + active + '">Actioned Today <span class="badge badge-light">' + todayActionedDocumentsCount + '</span></a>').click(function () {
//        GetActionedDocuments(1, dtEnd, dtEnd);
//    }).prependTo(buttons);

//    InitDateRangePicker(dataId, dtStartPicker, dtEndPicker);

//    active = '';
//    if (dataId == 0) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-success ' + active + '">Total <span class="badge badge-light">' + totalCount + '</span></a>').click(function () {
//        GetActionedDocuments(0, dtStart, dtEnd);
//    }).prependTo(buttons);

//}

//function InitDateRangePicker(dataId, dtStart, dtEnd)
//{
//    var buttons = $(".dt-buttons");

//    var active = '';
//    if (dataId == 2) {
//        active = "active";
//    }
//    $('<a href="#" class="btn btn-badge btn-outline-primary ' + active + '">Get</a>').click(function () {
//        GetActionedDocuments(2, startDate, endDate);
//    }).prependTo(buttons);

//    if ($("#weekPicker").length > 0)
//    {
//        $("#weekPicker").remove();
//    }
//    var datePicker = $('<input type="text" id="weekPicker" class="form-control" style="width:175px; display:inline-block">').val(dtStart + ' - ' + dtEnd);
//    datePicker.datepicker({
//        changeMonth: true,
//        changeYear: true,
//        showButtonPanel: true,
//        beforeShow: function(input)
//        {
//            AddDateSelector(input);
//        },
//        onChangeMonthYear: function (year, month, instance) {
//            AddDateSelector(instance);
//        },
//        onSelect: function (dateText, inst) {
//            var date = $(this).datepicker('getDate');
//            if (dateType == 'day') {
//                startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
//                endDate = startDate;
//            }
//            else {
//                startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
//                endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
//            }
//            var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
//            dateFormat = 'dd-mm-yy'
//            //$('#startDate').text($.datepicker.formatDate(dateFormat, startDate, inst.settings));t
//            //$('#endDate').text($.datepicker.formatDate(dateFormat, endDate, inst.settings));
//            $(this).val($.datepicker.formatDate(dateFormat, startDate, inst.settings) + " - " + $.datepicker.formatDate(dateFormat, endDate, inst.settings));

//            startDate = $.datepicker.formatDate('yy-mm-dd', startDate, inst.settings);

//            endDate = $.datepicker.formatDate('yy-mm-dd', endDate, inst.settings);
//        }
//    });
//    datePicker.prependTo(buttons);

//    var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");

//    var selector = $('<select />', { Id: "ddl-datetype" });
//    $('<opion value="week">Week</option>').appendTo(selector);
//    $('<opion value="day">day</option>').appendTo(selector);
//    selector.appendTo(buttonPane);
//}


function InitDateRangePicker(dataId, dtStart, dtEnd) {
    var active = '';
    if (dataId == 2) {
        active = "active";
    }

    var datePicker = $('#weekPicker');
    datePicker.val(dtStart + ' - ' + dtEnd);
    datePicker.datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        maxDate: 0,
        beforeShow: function(input) {
            AddDateSelector(input);
        },
        onChangeMonthYear: function(year, month, instance) {
            AddDateSelector(instance);
        },
        onSelect: function(dateText, inst) {
            var date = $(this).datepicker('getDate');
            if (dateType == 'day') {
                startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
                endDate = startDate;
            } else {
                startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
                endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
            }
            var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
            dateFormat = 'dd-mm-yy'
            //$('#startDate').text($.datepicker.formatDate(dateFormat, startDate, inst.settings));
            //$('#endDate').text($.datepicker.formatDate(dateFormat, endDate, inst.settings));
            $(this).val($.datepicker.formatDate(dateFormat, startDate, inst.settings) + " - " + $.datepicker.formatDate(dateFormat, endDate, inst.settings));

            startDate = $.datepicker.formatDate('yy-mm-dd', startDate, inst.settings);

            endDate = $.datepicker.formatDate('yy-mm-dd', endDate, inst.settings);
        }
    });
    var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");
    var selector = $('<select />', {
        Id: "ddl-datetype"
    });
    $('<opion value="week">Week</option>').appendTo(selector);
    $('<opion value="day">day</option>').appendTo(selector);
    selector.appendTo(buttonPane);
}
var dateType = 'week';

function AddDateSelector(input) {
    //dateType = 'week';
    setTimeout(function() {
        var buttonPane = $(input)
            .datepicker("widget")
            .find(".ui-datepicker-buttonpane");
        var checked = false;
        if (dateType == 'week') {
            checked = true;
        }
        var $input = $('<input />', {
            type: "radio",
            name: "rd-datetype",
            value: "week",
            checked: checked
        }).click(function() {
            if ($(this).is(':checked')) {
                dateType = $(this).val();
            }
        });

        $("<label />", {
            append: [$input, " Week"], // include our $input and also some text description
            css: {
                "margin-bottom": "0px",
                "font-weight": "normal"
            }
        }).appendTo(buttonPane);

        checked = false;
        if (dateType == 'day') {
            checked = true;
        }
        $input = $('<input />', {
            type: "radio",
            name: "rd-datetype",
            value: "day",
            checked: checked
        }).click(function() {
            if ($(this).is(':checked')) {
                dateType = $(this).val();
            }
        });

        $("<label />", {
            append: [$input, " Day"], // include our $input and also some text description
            css: {
                "margin-bottom": "0px",
                "font-weight": "normal"
            }
        }).appendTo(buttonPane);
    }, 1);
    //$('.ui-datepicker-calendar tr').hover(function () {
    //    if (dateType == 'week') {
    //        $(this).addClass("calendar-hover");
    //    }
    //    else {
    //        $(this).removeClass("calendar-hover");
    //    }
    //});
}

function setHeight(obj, isActionCenter) {
    $(obj).css({
        "height": calcDataTableHeight(isActionCenter) + "px"
    });
}

function ClearDocumentLogDataGrid() {
    var grid = $("#grid_DocumentLog").data("kendoGrid");
    grid.dataSource.data([]);
    grid.dataSource.page(1);
}

function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}

function ChangePedningDaysCellColor(grid, colIndex, field) {
    var gridData = grid.dataSource.view();
    for (var p = 0; p < gridData.length; p++) {
        var forms = gridData[p].items;
        if (forms && forms.length) {
            for (var f = 0; f < forms.length; f++) {
                var documents = forms[f].items;
                for (var d = 0; d < documents.length; d++) {
                    var data = documents[d];
                    //var text = grid.table.find("tr[data-uid='" + data.uid + "'] td:eq(" + colIndex + ")").text();
                    var td = grid.table.find("tr[data-uid='" + data.uid + "'] td:eq(" + colIndex + ")");

                    var pendingDays = data[field];
                    var docStatus = data.DocStatus ? data.DocStatus : 'Submitted';
                    if (pendingDays < 0) {
                        var div = $('<div />').addClass('red-circle').text(-(pendingDays));
                        td.html(div);
                        td.append('<span class="text-red">day(s) overdue</span>');
                    } else if (pendingDays > 0 && pendingDays <= 5) {
                        var div = $('<div />').addClass('green-circle').text(pendingDays);
                        td.html(div);
                        td.append('<span class="text-green">day(s) remaining</span>');
                    } else if (docStatus == 'Approved' || docStatus == 'Withdrawn' || docStatus == 'Rejected' || docStatus == 'Draft') {
                        td.html('');
                    } else {
                        var div = $('<div />').addClass('amber-circle').text(pendingDays);
                        td.html(div);
                        td.append('<span class="text-amber">due today</span>');
                    }
                }
            }
        }
    }
}

function AddActionCenterActionedBadge(data) {
    global.getAjax(global.url.GetActionedDocumentsAjax, {
        '_': Math.random(),
        'dtStart': startDate,
        'dtEnd': endDate
    }, function(_data) {
        _data = JSON.parse(_data);
        $("#totalActionedCount").text(_data.TotalCount);
        $("#todayActionedCount").text(_data.TodayCount);
    });
}

function AddActionCenterBadge(data) {
    global.getAjax(global.url.GetPendingDocumentsAjax, {
        '_': Math.random()
    }, AddActionCenterBadgeCallback);
    AddActionCenterActionedBadge(data);

}

function AddActionCenterBadgeCallback(data) {
    var records = JSON.parse(data);
    var _data = [];
    var badges = ['badge-pending', 'badge-request', 'badge-received', 'badge-overdue', 'badge-overdue14'];

    _data.push(records);

    var TeamInputRequested = $.grep(records, function(w) {
        return (w.TeamInputRequestedTo != "" || w.TeamInputRepliedBy != "");
    });
    _data.push(TeamInputRequested);

    var TeamInputRecieved = $.grep(records, function(w) {
        return w.Occupation == "T";
    });
    _data.push(TeamInputRecieved);

    var overdue = $.grep(records, function(w) {
        return (isNumeric(w.RemainingDays) ? (parseInt(w.RemainingDays) < 0) : false);
    });
    _data.push(overdue);

    var overdue14 = $.grep(records, function(w) {
        return (isNumeric(w.RemainingDays) ? (parseInt(w.RemainingDays) < -14) : false);
    });
    _data.push(overdue14);

    RemoveNoCursor(badges);
    for (var i = 0; i < _data.length; i++) {
        if (_data[i].length == 0) {
            AddNoCursor(badges[i]);
        }
    }
    window.top.document.title = records.length + " pending document" + (records.length > 1 ? "s" : "");
    $(".badge-pending").text(records.length);
    $(".badge-request").text(TeamInputRequested.length);
    $(".badge-received").text(TeamInputRecieved.length);
    $(".badge-overdue").text(overdue.length);
    $(".badge-overdue14").text(overdue14.length);

    BindOnClick();
}

function RemoveNoCursor(badges) {
    $.each(badges, function(idx) {
        var badge = badges[idx];
        var link = $('.' + badge).closest('a');
        link.removeClass('no-cursor');
    });
}

function AddNoCursor(elemClass) {
    var link = $('.' + elemClass).closest('a');
    link.addClass('no-cursor');
}

function BindOnClick() {
    var actionCenterBadges = $("#actionCenterBadges");

    $('.btn-badge', actionCenterBadges).each(function(idx) {
        $(this).click(function(e) {
            e.preventDefault();
            if ($(this).hasClass('no-cursor') == false) {
                pendingDocumentCollapsedRows = [];
                GetPendingDocuments(this, idx);
            }
        });
    });
}

var pendingDocumentCollapsedRows = [];

function onPendingDocumentGroupExpand(e) {
    var grid = e.sender;
    var dataItem = grid.dataItem(e.element);
    var group = e.group;
    var isProject = group.hasSubgroups;

    var project = $.grep(pendingDocumentCollapsedRows, function(w) {
        return w.projectId == dataItem.ProjectId;
    });

    if (project.length > 0) {
        project = project[0];
        project.collapsed = false;
        if (!isProject) {
            var form = $.grep(project.forms, function(w) {
                return w.recordTypeId == dataItem.RecordTypeId;
            });
            if (form.length > 0) {
                form = form[0]
                form.collapsed = false
            }
        }
    }
}

function onPendingDocumentGroupCollapse(e) {
    var grid = e.sender;
    var dataItem = grid.dataItem(e.element);
    var group = e.group;
    var isProject = group.hasSubgroups;

    var project = $.grep(pendingDocumentCollapsedRows, function(w) {
        return w.projectId == dataItem.ProjectId;
    });

    if (project.length == 0) {
        project = {
            projectId: dataItem.ProjectId,
            collapsed: isProject,
            forms: []
        };
        pendingDocumentCollapsedRows.push(project);
    } else {
        project = project[0];
        project.collapsed = isProject;
    }
    if (!isProject) {
        var form = $.grep(project.forms, function(w) {
            return w.recordTypeId == dataItem.RecordTypeId;
        });
        if (form.length == 0) {
            form = {
                recordTypeId: dataItem.RecordTypeId,
                collapsed: true
            };
            project.forms.push(form);
        } else {
            form = form[0];
            form.collapsed = true;
        }
    }
}

function InitDocumentCollapsedRows(e) {
    var grid = e.sender;
    var data = grid.dataSource.view();
    for (var i = 0; i < data.length; i++) {
        var project = data[i].items;
        if (project) {
            var record = project[0].items[0];
            var _project = $.grep(pendingDocumentCollapsedRows, function(w) {
                return w.projectId == record.ProjectId;
            });
            if (_project.length > 0) {
                _project = _project[0];
                if (_project.collapsed == true) {
                    var groupRow = grid.table.find("tr[data-uid='" + record.uid + "']").prev().prev();
                    grid.collapseRow(groupRow);
                }
                for (var j = 0; j < project.length; j++) {
                    var forms = project[j].items;
                    var _form = $.grep(_project.forms, function(w) {
                        return w.recordTypeId == forms[0].RecordTypeId;
                    });

                    if (_form.length > 0) {
                        _form = _form[0];
                        if (_form.collapsed == true) {
                            var groupFormRow = grid.table.find("tr[data-uid='" + forms[0].uid + "']").prev();
                            grid.collapseRow(groupFormRow);
                        }
                    }
                }
            }
        }
    }
}
/**********************************Document Log**************************************/
function ToggleSearch() {
    $("#panelsearch").slideToggle();
}

function CloseSearch() {
    $("#panelsearch").slideUp();
    setTimeout(function() {
        $("#panelsearch").hide();
    }, 200);
}
var IsCancelledDocumentLogRequest = false;
$(document).ready(function() {
    $("#btnCancelRequest").hide();
    $(document).on("contextmenu", function() {
        if (isProduction == true) {
            return false;
        }
    });
    $("#btngetreport").click(function(e) {
        CheckSession(function() {
            gridRetrySession = 0;
            $("#btnCancelRequest").show();
            IsCancelledDocumentLogRequest = false;
            LoadDocumentLog(e);
        });
    });
    $("#btnclear").click(function(e) {
        HideErrors();
        var multiselect = $('#Projects').data('kendoMultiSelect');
        multiselect.value([]);
        multiselect.trigger("change");

        $('#txtfromdate').val('2018-01-01');
        $('#txttodate').val(Today());

        $('#txtsubject').val('');
        $('#txtoref').val('');
        $("#txtrepref").val('');
        $("#txtrecno").val('');
        $("#txtGeneral").val('');


        $("#txtPendingWith").val('');
        $('#listboxws').val('0');

        var _subjectmatter = '';
        $('#txtcategory').val('');
        $('#txtfrom').val('');
        $('#txtto').val('');
        $('#txtFileName').val('');

        $('#txtCreatedBy').val('');

        SelectProjects();
    });
    $("#btnCancelRequest").click(function(e) {
        $("#btnCancelRequest").hide();
        if (documentLogRequest != null) {
            documentLogRequest.abort();
            $("#panelsearch").slideDown();
            IsCancelledDocumentLogRequest = true;
            ClearDocumentLogDataGrid();
        }
    });
    $("#pmwebModal").on('hidden.bs.modal', function() {
        if (_iframe != null)
            _iframe.remove();
        $(".modal-body", $("#pmwebModal")).empty();
        $(".modal-body", $("#pmwebModal")).html('<div class="lds-ring"><div></div><div></div><div></div><div></div></div>');
    });
});

function BindActionRightClick(e) {
    $('a[data-url]').each(function() {
        $(this).on("contextmenu", function() {
            e.preventDefault();
            var url = $(this).attr('data-url');
            window.open(url, '_blank');
        });
    });
}

var documentLogRequest = null;

function LoadDocumentLog(e) {
    HideErrors();
    var _fromDate = $('#txtfromdate').val();
    var _toDate = $('#txttodate').val();

    var _projects = $('#Projects').val();
    var _forms = $('#Forms').val();
    var _discipline = $('#listboxdisc').val();
    var _workflowstatus = $('#WorkflowStatus').val();

    var _subject = $('#txtsubject').val();
    var _originReg = $('#txtoref').val();
    var _outref = ''; //$('#txtrepref').val();
    var _recno = $("#txtGeneral").val(); //$('#txtrecno').val();
    var _subjectmatter = '';
    var _category = $('#txtcategory').val();
    var _from = $('#txtfrom').val();
    var _to = $('#txtto').val();
    var _docType = $('#listboxdoctype').val();
    var _fileName = $('#txtFileName').val();

    var _createdBy = $('#txtCreatedBy').val();

    var _gateway = $('#listboxgateway').val();

    var _pendingWith = $("#txtPendingWith").val();

    var _listboxdepartments = $("#listboxdepartments").val();

    var hasError = false;
    if (!_projects || _projects == null) {
        $('#errorProject').show();
        hasError = true;
    }

    if (!_forms || _forms == null) {
        $('#errorForm').show();
        hasError = true;
    }

    if (!_workflowstatus || _workflowstatus == null) {
        $('#errorWorkflow').show();
        hasError = true;
    }

    if (hasError == true) {
        return;
    }
    $("#panelsearch").slideUp();
    setTimeout(function() {
        $("#panelsearch").hide()
    }, 200);
    $("#btnClose").show();
    // Add errors highlight
    ClearDocumentLogDataGrid();

    documentLogRequest = $.ajax({
        url: global.url.GetDocumentLogReport,
        dataType: "html",

        ContentType: "application/json;charset=utf-8",
        type: "POST",
        data: {
            fromDate: _fromDate,
            toDate: _toDate,
            projects: _projects,
            forms: _forms,
            discipline: _discipline,
            workflowstatus: _workflowstatus,
            subject: _subject,
            originReg: _originReg,
            subjectmatter: _subjectmatter,
            category: _category,
            from: _from,
            to: _to,
            docType: _docType,
            fileName: _fileName,
            createdBy: _createdBy,
            Gateway: _gateway,
            pendingWith: _pendingWith,
            listboxdepartments: _listboxdepartments,
            outref: _outref,
            recno: _recno
        },
        cache: false,
        async: true,
        beforeSend: function() {
            $('#pleaseWaitDialog').modal('show');
        },
        complete: function() {
            $('#pleaseWaitDialog').modal('hide');
            $("#btnCancelRequest").hide();
        },
        success: function(data) {
            //$('#worklist').html(data);
            dataLoadingCompleted = false;
            $("#grid_DocumentLog").data("kendoGrid").dataSource.read();
            $("#panelgrid").show();

        },
        failure: function(response) {
            alert("Get Failed");
        },
    });
}

function ClearDocumentLog(e) {
    $.ajax({
        url: global.url.ClearDocumentLog,
        dataType: "html",
        type: "GET",
        contentType: 'application/json;charset=utf-8',
        data: {
            "_": Math.random()
        },
        complete: function() {
            ClearDocumentLogDataGrid();
        },
        async: true,
        cache: false,
        success: function(data) {},
        error: function(xhr) {
            RedirectToPMweb();
        }
    });
}
/* Functions for telerik */
function filterProjects() {
    var projectVal = $("#Projects").val();
    projects = [].concat.apply([], [projectVal || [0]])
    id_parameter = projects.join(',')
    return {
        projects: id_parameter
    };
}

function projectsOnChange(e) {
    var items = this.ul.find("li");
    checkInputs(items);
    $('#Forms').data('kendoMultiSelect').dataSource.read();
}

function projectDataBound() {
    var items = this.ul.find("li");
    setTimeout(function() {
        checkInputs(items);
    });
}

function projectOnSelect(e) {
    var dataItem = this.dataSource.view()[e.item.index()];
    if (dataItem.Value == 0) {
        var self = this;
        setTimeout(function() {
            var all = $.map(self.dataSource.data(), function(dataItem) {
                return dataItem.Value;
            });
            self.value(all);
            self.trigger("change");
        }, 10);
    }
}

function projectOnDeSelect(e) {
    var dataItem = this.dataSource.view()[e.item.index()];
    if (dataItem.Value == 0) {
        var self = this;
        setTimeout(function() {
            self.value([]);
            self.trigger("change");
        }, 10);
    }
}

function selectAllWorkflowStatus() {
    var multiselect = $('#WorkflowStatus').data('kendoMultiSelect');
    var all = $.map(multiselect.dataSource.data(), function(dataItem) {
        return dataItem.Id;
    });
    multiselect.value(all);
    multiselect.trigger("change");
}

function selectAllForm() {
    var multiselect = $('#Forms').data('kendoMultiSelect');
    var all = $.map(multiselect.dataSource.data(), function(dataItem) {
        if (dataItem.Name != "Memo" && dataItem.Id != "10124" && dataItem.Id != "10097" && dataItem.Id != "10137" && dataItem.Id != "10099") {
            return dataItem.Id;
        }
    });
    multiselect.value(all);
    multiselect.trigger("change");
}

function formOnChange() {
    var items = this.ul.find("li");
    checkInputs(items);
}

function workflowStatusOnChange() {
    var items = this.ul.find("li");
    checkInputs(items);
}

function checkInputs(elements) {
    elements.each(function() {
        var element = $(this);
        var input = element.children("input");
        input.prop("checked", element.hasClass("k-state-selected"));
    });
};
/* End of telerik functions */
function HideErrors() {
    $('.error-form').hide();
}

function gridExpandCollapseAll(obj, _grid) {
    _grid = '#' + _grid;
    var grid = $(_grid).data("kendoGrid");

    if (obj.value == "Expand All") {
        $("td.k-group-cell", $(_grid)).each(function(index) {
            var tr = $(this).closest('tr');
            grid.expandRow(tr);
        });
        obj.value = "Collapse All";
    } else {
        $("td.k-group-cell", $(_grid)).each(function(index) {
            var tr = $(this).closest('tr');
            grid.collapseRow(tr);
        });
        obj.value = "Expand All";
    }

}

function GetTimeSheetDetails(RecordId, Obj) {
    CheckSession(function() {
        $.ajax({
            url: global.url.TimesheetDetails,
            dataType: "html",
            type: "GET",
            contentType: 'application/json;charset=utf-8',
            data: {
                RecordId: RecordId,
                "_": Math.random()
            },
            beforeSend: function() {
                $('#pleaseWaitDialog').modal('show');
            },
            complete: function() {
                $('#pleaseWaitDialog').modal('hide');
            },
            async: true,
            cache: false,
            success: function(data) {
                var modal = $('#timesheetDeatilsModal');
                $('.modal-body', modal).html(data);
                modal.modal();
            },
            error: function(xhr) {
                RedirectToPMweb();
            }
        });
    });
}

function ApproveTimeSheet(e) {
    CheckSession(function() {
        e.preventDefault();
        if (confirm("Please confirm to approve the time sheet")) {
            //var _timesheetId = [];
            var grid = $("#grid_Timesheet").data("kendoGrid");
            var _timesheetId = $.map(grid.select(), function(item) {
                var selectedRowData = grid.dataItem(item);
                if (selectedRowData.Id)
                    return selectedRowData.Id;
            });
            $.ajax({
                url: global.url.ApproveTimeSheet,
                dataType: "JSON",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                data: {
                    RecordId: _timesheetId,
                    "_": Math.random()
                },
                traditional: true,
                beforeSend: function() {
                    $('#pleaseWaitDialog').modal('show');
                },
                complete: function() {
                    $('#pleaseWaitDialog').modal('hide');
                },
                async: true,
                cache: false,
                success: function(data) {
                    if (data == "Failed") {
                        alert("The system unable to approve this time. Please try again.");
                    } else {
                        alert("The time sheet approved successfully.");
                        grid.dataSource.read();
                    }
                },
                error: function(xhr) {
                    //alert("failed");
                }
            });
            grid.dataSource.read();
        }
    });
}

function RefreshGrid(gridId) {
    CheckSession(function() {
        gridId = '#' + gridId;
        var grid = $(gridId).data("kendoGrid");
        if (grid.dataSource) {
            grid.dataSource.filter({
                logic: 'or',
                filters: []
            });
            //grid.dataSource.read();
        }
    });
}

function SetCustomApplicateViewer(userId, applicationName) {
    $.ajax({
        url: global.url.SetCustomApplicateViewer,
        dataType: "html",
        type: "GET",
        contentType: 'application/json;charset=utf-8',
        data: {
            userId: userId,
            applicationName: applicationName,
            "_": Math.random()
        },
        async: true,
        cache: false,
        success: function() {

        }
    });
}

function Today() {
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    return yyyy + '-' + mm + '-' + dd
}

function setCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function onElementHeightChange(elm, callback) {
    var lastHeight = elm.clientHeight,
        newHeight;
    (function run() {
        newHeight = elm.clientHeight;
        if (lastHeight != newHeight)
            callback();
        lastHeight = newHeight;

        if (elm.onElementHeightChangeTimer)
            clearTimeout(elm.onElementHeightChangeTimer);

        //if (lastHeight != newHeight || newHeight == 0) {
        //    elm.onElementHeightChangeTimer = setTimeout(run, 200);
        //}
        elm.onElementHeightChangeTimer = setTimeout(run, 200);
    })();
}

function onElementWidthChange(elm, callback) {
    var lastWidth = elm.clientWidth,
        newWidth;
    (function runWidth() {
        newWidth = elm.clientWidth;
        if (lastWidth != newWidth)
            callback();
        lastWidth = newWidth;

        if (elm.onElementWidthChangeTimer)
            clearTimeout(elm.onElementWidthChangeTimer);

        if (lastWidth != newWidth || newWidth == 0) {
            elm.onElementWidthChangeTimer = setTimeout(runWidth, 200);
        }
        //elm.onElementWidthChangeTimer = setTimeout(runWidth, 200);
    })();
}

var gridRetrySession = 0;

function CheckSessionForGrid(grid) {
    if (grid.dataSource.data().length <= 0 && gridRetrySession < 3) {
        CheckSession(function() {
            gridRetrySession++;
            grid.dataSource.read();
        });
    }
}