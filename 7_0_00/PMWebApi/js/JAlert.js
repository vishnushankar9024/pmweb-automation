

function custom_alert(output_msg, title_msg, controlName, iMessageType, MessageType) {
    if (!title_msg)
        title_msg = 'Alert';


    if (iMessageType == 0) {
        title_msg = 'Warning';        
    }
    else if (iMessageType == 1) {
        title_msg = 'Success';
    }
    else if (iMessageType == 2) {
        title_msg = 'Error';
    }


    title_msg = MessageType;

    if (!output_msg)
        output_msg = 'No Message to Display.';
        output_msg = output_msg.replace(/\n/g, "<br />");

        $j("<div class='alert alert-success'></div>").html(output_msg).dialog({            
            resizable: false,
            modal: true,
            width: 'auto',
            minWidth: 350,
            maxWidth: 600,           
            position: {
                my: "center center",
                at: "center center",
                of: window
            },
            buttons: {
                "Ok":
              function () {
                  if (controlName != "") {
                      setTimeout(function () { $j("#" + controlName).focus(); }, 100);

                  }
                  $j(this).dialog("close");
                  $j(this).remove();
                  //                  $j(this).addClass("btn  btn-warning");
              }

            },


          open: function (event, ui) {
              if (iMessageType == 0) {
                  $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #faf2cc','font-size':'12px','padding-top': '18px;' });
                  $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#8a6d3b', 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '2px', 'border-style': 'solid' });
                  $j('.ui-widget-content').css({ 'color': '#8a6d3b' });
                  $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
                  $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
                  $j('.ui-dialog-titlebar').addClass('importantRule');
                  $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#b89559', 'background-color': '#fcf8e3', 'font-size': '16px', 'border': '1px solid #faf2cc' });
                  $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
                  $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
                  $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
                  $j(":button:contains('Ok')").focus();
                  setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
                  $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#faf2cc dotted thick;' });
                  $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
              }
              else  if (iMessageType == 1) {
                  $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#caf4ca', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #caf4ca', 'font-size': '12px', 'padding-top': '18px;'  });
                  $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#3c763d', 'background-color': '#ffffff', 'border-color': '#caf4ca', 'border-width': '2px', 'border-style': 'solid' });
                    $j('.ui-widget-content').css({ 'color': '#3c763d' });
                    $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
                    $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
                    $j('.ui-dialog-titlebar').addClass('importantRule');
                    $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#509d51', 'background-color': '#DFF0D8', 'font-size': '16px', 'border': '1px solid #caf4ca' });
                    $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
                    $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
                    $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
                    $j(":button:contains('Ok')").focus();
                    setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
                    $j(":button:contains('Ok')").css({ 'background-color': '#509d51', 'border-color': '#caf4ca', 'color': '#ffffff', 'outline': '#caf4ca dotted thick;' });
                    $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-check-circle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
                }
                else if (iMessageType == 2) {
                  $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#ebcccc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #ebcccc', 'font-size': '12px', 'padding-top': '18px;'  });
                    $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#a94442', 'background-color': '#ffffff', 'border-color': '#ebcccc', 'border-width': '2px', 'border-style': 'solid' });
                    $j('.ui-widget-content').css({ 'color': '#a94442' });
                    $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
                    $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
                    $j('.ui-dialog-titlebar').addClass('importantRule');
                    $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#BA6967', 'background-color': '#f2dede', 'font-size': '16px', 'border': '1px solid #ebcccc' });
                    $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
                    $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
                    $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
                    $j(":button:contains('Ok')").focus();
                    setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
                    $j(":button:contains('Ok')").css({ 'background-color': '#BA6967', 'border-color': '#ebcccc', 'color': '#ffffff', 'outline': '#ebcccc dotted thick;' });
                    $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
                }
                var win = $j(window);
                $j(this).parent().css({ position: 'fixed',
                    left: (win.width() - $j(this).parent().outerWidth()) / 2,
                    top: (win.height() - $j(this).parent().outerHeight()) / 2
                });
            }
            //        open: function () {
            //            // $j(this).parents('.ui-dialog-buttonpane button:eq(0)').focus(); 
            //            //$j(this).siblings('.ui-dialog-buttonpane').find('button:eq(1)').focus(); 
            //            
            //          
            //                setTimeout(function () {
            //                    $j(this).siblings('.ui-dialog-buttonpane').find("button:contains('OK')").focus();
            //                    $j(this).siblings('.ui-dialog-buttonpane').find('button:eq(1)').focus(); 
            //                }, 420);
            //            }
            //        


        });

                
}



function jCustomAlert(output_msg, controlName, type, title_msg) {
    if (!title_msg)
        title_msg = 'Info';

//    title_msg = '<%= GetGlobalResourceObject("msgTitleWarning").ToString() %>';
   
    if (!output_msg)
        output_msg = 'No Message to Display.';

    output_msg = output_msg.replace(/\n/g, "<br />");

    $j("<div ></div>").html(output_msg).dialog({
        resizable: false,
        modal: true,
        width: 'auto',
        minWidth: 300,
        maxWidth: 600,
        position: {
            my: "center center",
            at: "center center",
            of: window
        },
        buttons: {
            "Ok": function () {
                if ((controlName != "") && (typeof (controlName) != "undefined")) {
                    if (type == 1) {
                        if (!(document.getElementById(controlName).disabled && document.getElementById(controlName).style.visibility == 'hidden')) {
                            setTimeout(function () { $j("#" + controlName).focus(); }, 100);
                        }
                    }
                    else if (type == 2) {
                        if (!(document.getElementById(controlName).disabled && document.getElementById(controlName).style.visibility == 'hidden')) {
                            setTimeout(function () { $j("#" + controlName).focus(); $j("#" + controlName).select(); }, 100);
                        }
                    }
                    else {
                        setTimeout(function () { $j("#" + controlName).focus(); }, 100);
                    }
                }
                $j(this).dialog("close");
                $j(this).remove();

            }
        },
        open: function (event, ui) {
            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #faf2cc', 'font-size': '12px', 'padding-top': '18px;'  });
            $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#8a6d3b', 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '2px', 'border-style': 'solid' });
            $j('.ui-widget-content').css({ 'color': '#8a6d3b' });
            $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
            $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
            $j('.ui-dialog-titlebar').addClass('importantRule');
            $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#b89559', 'background-color': '#fcf8e3', 'font-size': '16px', 'border': '1px solid #faf2cc' });
            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
            $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
            $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
            $j(":button:contains('Ok')").focus();
            setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
            $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#faf2cc dotted thick;' });
            $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
        }


    });


}

function jCustomConfirm(output_msg, title_msg) {

    var defer = $j.Deferred();
    if (!title_msg)
        title_msg = 'Message';

   // title_msg = 'Confirmation';
    if (!output_msg)
        output_msg = 'No Message to Display.';

    output_msg = output_msg.replace(/\n/g, "<br />");

    $j("<div ></div>").html(output_msg).dialog({       
        resizable: false,
        modal: true,
        width: 'auto',
        minWidth: 300,
        maxWidth: 600,
        position: {
            my: "center center",
            at: "center center",
            of: window
        },
        buttons: {
            "Ok": function () {
               // $j(".ui-widget-overlay ui-front").css('z-index', 100000000);
                defer.resolve("true");
                $j(this).dialog("close");
               $j(this).remove();
//                if ($j(this).parent().hasClass('ui-widget-overlay ui-front')) {
//                    $j(this).parent().removeClass('ui-widget-overlay ui-front');
//                }
                //                $j(this).parent().remove();
                //$j(this).parent().parent()(".ui-widget-overlay ui-front").css('z-index', 100000000);
              //  $j(this).parent().parent().find(".ui-widget-overlay ui-front").css('z-index', 100)

                
                

            },
            "Cancel": function () {
                defer.resolve("false");
                $j(this).dialog("close");
                $j(this).remove();
               

            }
        },
        open: function (event, ui) {
//            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 100000001, 'min-Width': 300 });
//            $j('.ui-dialog').css('z-index', 100000001);
//            $j('.ui-widget-overlay').css({ 'z-index': '100000000', 'opacity': '.7' });
//            $j('.ui-dialog-titlebar').css({ 'width': '95%', 'text-align': 'left', 'margin-left': '8px', 'color': '#333333', 'background-color': '#E9E9E9' });
//            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button  

            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #faf2cc', 'font-size': '12px', 'padding-top': '18px;'  });
            $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#8a6d3b', 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '2px', 'border-style': 'solid' });
            $j('.ui-widget-content').css({ 'color': '#8a6d3b' });
            $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
            $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
            $j('.ui-dialog-titlebar').addClass('importantRule');
            $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#b89559', 'background-color': '#fcf8e3', 'font-size': '16px', 'border': '1px solid #faf2cc' });
            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
            $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
            $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
            $j(":button:contains('Ok')").focus();
            setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
            $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#faf2cc dotted thick;' });
            $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-info-circle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");       
           
            setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
//            $j(":button:contains('Ok')").addClass("btn-success");
            $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#2e6da4 dotted thick;' });
            $j(":button:contains('Cancel')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#2e6da4 dotted thick;' });
            $j('.ui-dialog-buttonpane').find('button:contains("Ok")').prepend('<i class="fa fa-check-circle" aria-hidden="true"></i> ')
            $j('.ui-dialog-buttonpane').find('button:contains("Cancel")').prepend('<i class="fa fa-ban" aria-hidden="true"></i> ')
           
            var win = $j(window);
            $j(this).parent().css({ position: 'fixed',
                left: (win.width() - $j(this).parent().outerWidth()) / 2,
                top: (win.height() - $j(this).parent().outerHeight()) / 2
            });
        }


    });
    if (event.stopPropagation) event.stopPropagation();
    if (event.preventDefault) event.preventDefault();
    window.event.returnValue = false;
    return defer.promise();
}

function jCustomInvAlert(output_msg, controlName, title_msg) {

    title_msg = 'Info';

    if (!output_msg)
        output_msg = 'No Message to Display.';

    output_msg = output_msg.replace(/\n/g, "<br />");

    $j("<div ></div>").html(output_msg).dialog({       
        resizable: false,
        modal: true,
        width: 'auto',
        minWidth: 300,
        maxWidth: 600,
        position: {
            my: "center center",
            at: "center center",
            of: window
        },
        buttons: {
            "Ok": function () {
                if ((controlName != "") && (typeof (controlName) != "undefined")) {                   
                    setTimeout(function () { $j("#" + controlName).focus(); }, 100);                   
                   
                }
                
                $j(this).dialog("close");
                $j(this).remove();

            }
        },
        open: function (event, ui) {
            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #faf2cc', 'font-size': '12px', 'padding-top': '18px;'  });
            $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#8a6d3b', 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '2px', 'border-style': 'solid' });
            $j('.ui-widget-content').css({ 'color': '#8a6d3b' });
            $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
            $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
            $j('.ui-dialog-titlebar').addClass('importantRule');
            $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#b89559', 'background-color': '#fcf8e3', 'font-size': '16px', 'border': '1px solid #faf2cc' });
            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
            $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
            $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
            $j(":button:contains('Ok')").focus();
            setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
            $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#faf2cc dotted thick;' });
            $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
        }
       

    });

    
}


function jCustomLogOut(output_msg, title_msg) {

    var defer = $j.Deferred();
//    if (!title_msg)
//        title_msg = 'Message';
    title_msg = 'Info';
    if (!output_msg)
        output_msg = 'No Message to Display.';

    output_msg = output_msg.replace(/\n/g, "<br />");

    $j("<div  class='alert alert-warning' ></div>").html(output_msg).dialog({        
        resizable: false,
        modal: true,
        width: 'auto',
        minWidth: 350,
        maxWidth: 600,
        position: {
            my: "center center",
            at: "center center",
            of: window
        },
        buttons: {
            "Ok": function () {              
                defer.resolve("true");
                $j(this).dialog("close");
                $j(this).remove();
               

            }
        },
        open: function (event, ui) {
//            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 100000001, 'min-Width': 300 });
//            $j('.ui-dialog').css('z-index', 100000001);
//            $j('.ui-widget-overlay').css({ 'z-index': '100000000', 'opacity': '.7' });  
//            $j('.ui-dialog-titlebar').css({ 'width': '95%', 'text-align': 'left', 'margin-left': '8px', 'color': '#333333', 'background-color': '#E9E9E9' });
            //            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button    
            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #faf2cc', 'font-size': '12px', 'padding-top': '18px;'  });
            $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#8a6d3b', 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '2px', 'border-style': 'solid' });
            $j('.ui-widget-content').css({ 'color': '#8a6d3b' });
            $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
            $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
            $j('.ui-dialog-titlebar').addClass('importantRule');
            $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#b89559', 'background-color': '#fcf8e3', 'font-size': '16px', 'border': '1px solid #faf2cc' });
            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
            $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
            $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });

            $j(":button:contains('Ok')").focus();
            setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
            $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#bcdff1 dotted thick;' });
            var win = $j(window);
            $j(this).parent().css({ position: 'fixed',
                left: (win.width() - $j(this).parent().outerWidth()) / 2,
                top: (win.height() - $j(this).parent().outerHeight()) / 2
            });
            $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-info-circle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
        }


    });

    return defer.promise();
}

function DeleteConfirmation(sMsg,Ctrl,Type) {


  //  var msg = "Do You Want to Delete?";
    jCustomConfirm(sMsg).then(function (sRet) {
        var sRet = Boolean.parse(sRet.toString());
        if (sRet) {
            if (Type == 0) {
                Ctrl = 'ContentPlaceHolder2_' + Ctrl
            }
            __doPostBack(Ctrl, 'DeleteRecord');

        }
    });
}

function PrebookConfirmation(sMsg, Ctrl, Type) {


    //  var msg = "Do You Want to Delete?";
    jCustomConfirm(sMsg).then(function (sRet) {
        var sRet = Boolean.parse(sRet.toString());
        if (sRet) {
            if (Type == 0) {
                Ctrl = 'ContentPlaceHolder2_' + Ctrl
            }
            __doPostBack(Ctrl, 'PrebookConfirmed');

        }
    });
}

function jItmImageAlert(output_msg, controlName, type, title_msg) {
    if (!title_msg)
        title_msg = 'Info';



    if (!output_msg)
        output_msg = 'No Message to Display.';

    output_msg = output_msg.replace(/\n/g, "<br />");

    $j("<div ></div>").html(output_msg).dialog({
        resizable: false,
        modal: true,
        width: 'auto',
        minWidth: 300,
        maxWidth: 600,
        position: {
            my: "center center",
            at: "center center",
            of: window
        },
        buttons: {
            "Ok": function () {
                if ((controlName != "") && (typeof (controlName) != "undefined")) {
                    if (type == 1) {
                        if (!(document.getElementById(controlName).disabled && document.getElementById(controlName).style.visibility == 'hidden')) {
                            setTimeout(function () { $j("#" + controlName).focus(); }, 100);
                        }
                    }
                    else if (type == 2) {
                        if (!(document.getElementById(controlName).disabled && document.getElementById(controlName).style.visibility == 'hidden')) {
                            setTimeout(function () { $j("#" + controlName).focus(); $j("#" + controlName).select(); }, 100);
                        }
                    }
                    else {
                        setTimeout(function () { $j("#" + controlName).focus(); }, 100);
                    }
                }
                $j(this).dialog("close");
                $j(this).remove();

            }
        },
        open: function (event, ui) {
            $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#bcdff1', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #bcdff1', 'font-size': '12px', 'padding-top': '18px;'  });
            $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#31708f', 'background-color': '#ffffff', 'border-color': '#bcdff1', 'border-width': '2px', 'border-style': 'solid' });
            $j('.ui-widget-content').css({ 'color': '#31708f' });
            $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
            $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
            $j('.ui-dialog-titlebar').addClass('importantRule');
            $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#31708f', 'background-color': '#d9edf7', 'font-size': '16px', 'border': '1px solid #bcdff1' });
            $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
            $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
            $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
            $j(":button:contains('Ok')").focus();
            setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
            $j(":button:contains('Ok')").css({ 'background-color': '#31708f', 'border-color': '#bcdff1', 'color': '#ffffff', 'outline': '#bcdff1 dotted thick;' });
            var win = $j(window);
            $j(this).parent().css({ position: 'fixed',
                left: (win.width() - $j(this).parent().outerWidth()) / 2,
                top: (win.height() - $j(this).parent().outerHeight()) / 2
            });
            $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-info-circle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
        }


    });


}


function jCustomAlertConfirm(output_msg, title_msg, controlName, iMessageType, MessageType) {


    var defer = $j.Deferred();
    if (!title_msg)
        title_msg = 'Alert';


    if (iMessageType == 0) {
        title_msg = 'Warning';
    }
    else if (iMessageType == 1) {
        title_msg = 'Success';
    }
    else if (iMessageType == 2) {
        title_msg = 'Error';
    }


    title_msg = MessageType;

    if (!output_msg)
        output_msg = 'No Message to Display.';
    output_msg = output_msg.replace(/\n/g, "<br />");

    $j("<div class='alert alert-success'></div>").html(output_msg).dialog({
        resizable: false,
        modal: true,
        width: 'auto',
        minWidth: 350,
        maxWidth: 600,
        position: {
            my: "center center",
            at: "center center",
            of: window
        },
        buttons: {
            "Ok":
              function () {
                
                  defer.resolve("true");
                  $j(this).dialog("close");
                  $j(this).remove();
                  //                  $j(this).addClass("btn  btn-warning");
              }

        },


        open: function (event, ui) {
            if (iMessageType == 0) {
                $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #faf2cc', 'font-size': '12px', 'padding-top': '18px;'  });
                $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#8a6d3b', 'background-color': '#ffffff', 'border-color': '#faf2cc', 'border-width': '2px', 'border-style': 'solid' });
                $j('.ui-widget-content').css({ 'color': '#8a6d3b' });
                $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
                $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
                $j('.ui-dialog-titlebar').addClass('importantRule');
                $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#b89559', 'background-color': '#fcf8e3', 'font-size': '16px', 'border': '1px solid #faf2cc' });
                $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
                $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
                $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
                $j(":button:contains('Ok')").focus();
                setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
                $j(":button:contains('Ok')").css({ 'background-color': '#b89559', 'border-color': '#faf2cc', 'color': '#ffffff', 'outline': '#faf2cc dotted thick;' });
                $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
            }
            else if (iMessageType == 1) {
                $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#caf4ca', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #caf4ca', 'font-size': '12px', 'padding-top': '18px;'  });
                $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#3c763d', 'background-color': '#ffffff', 'border-color': '#caf4ca', 'border-width': '2px', 'border-style': 'solid' });
                $j('.ui-widget-content').css({ 'color': '#3c763d' });
                $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
                $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
                $j('.ui-dialog-titlebar').addClass('importantRule');
                $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#509d51', 'background-color': '#DFF0D8', 'font-size': '16px', 'border': '1px solid #caf4ca' });
                $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
                $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
                $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
                $j(":button:contains('Ok')").focus();
                setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
                $j(":button:contains('Ok')").css({ 'background-color': '#509d51', 'border-color': '#caf4ca', 'color': '#ffffff', 'outline': '#caf4ca dotted thick;' });
                $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-check-circle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
            }
            else if (iMessageType == 2) {
                $j(this).css({ 'max-height': 300, 'overflow-y': 'auto', 'z-index': 500000001, 'min-Width': 300, 'background-color': '#ffffff', 'border-color': '#ebcccc', 'border-width': '1px', 'border-style': 'solid', 'border': '1px solid #ebcccc', 'font-size': '12px', 'padding-top': '18px;'  });
                $j('.ui-dialog').css({ 'z-index': '500000001', 'color': '#a94442', 'background-color': '#ffffff', 'border-color': '#ebcccc', 'border-width': '2px', 'border-style': 'solid' });
                $j('.ui-widget-content').css({ 'color': '#a94442' });
                $j('.ui-dialog .ui-dialog-content').css({ 'border': 'none' });
                $j('.ui-dialog .ui-dialog-buttonpane').css({ 'border': 'none', 'background-color': '#ffffff' });
                $j('.ui-dialog-titlebar').addClass('importantRule');
                $j('.ui-dialog-titlebar').css({ 'width': '100%', 'text-align': 'left', 'margin-left': '0px', 'color': '#BA6967', 'background-color': '#f2dede', 'font-size': '16px', 'border': '1px solid #ebcccc' });
                $j(".ui-dialog-titlebar-close").hide(); // Hide the [x] button
                $j('.ui-dialog-title').css({ 'margin-left': '-5px' });
                $j('.ui-widget-overlay').css({ 'z-index': '500000000', 'opacity': '.7' });
                $j(":button:contains('Ok')").focus();
                setTimeout(function () { $j(":button:contains('Ok')").focus(); }, 1);
                $j(":button:contains('Ok')").css({ 'background-color': '#BA6967', 'border-color': '#ebcccc', 'color': '#ffffff', 'outline': '#ebcccc dotted thick;' });
                $j(this).parent().find('.ui-dialog-title').append("<i class='fa fa-exclamation-triangle' aria-hidden='true'></i> <span class='title'>" + title_msg + "</span>");
            }
            var win = $j(window);
            $j(this).parent().css({ position: 'fixed',
                left: (win.width() - $j(this).parent().outerWidth()) / 2,
                top: (win.height() - $j(this).parent().outerHeight()) / 2
            });
        }
       


    });
    if (event.stopPropagation) event.stopPropagation();
    if (event.preventDefault) event.preventDefault();
    window.event.returnValue = false;
    return defer.promise();

}