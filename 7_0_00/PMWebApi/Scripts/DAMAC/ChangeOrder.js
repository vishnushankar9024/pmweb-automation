import { DAMAC } from './DAMACApi.js';
import { User } from './User.js';
var msgUpdate;

var MsgTitleUpdated = "Updated";
var MsgTitleSaved = "Saved";
var MsgTitleDeleted = "Deleted";
var MsgTitleRestored = "Restored";

var MsgTypeSuccess = "green";
var MsgTypeWarning = "orange";
var MsgTypeError = "red";

//$('#dialog_ocr_ei').load("http://localhost:51216/Home/ChangeOrderPopup");

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
function CreateWarningWindow() {
    if ($('#dialog_ocr_ei').length > 0) {
        var kwindow = $('#dialog_ocr_ei').kendoWindow({
            width: "80%",
            height: "820px",
            title: '',//"WARNING RELATED TO USE OF CONFIDENTIAL INFORMATION",
            visible: true,
            modal: true,
            content: {
                url: "http://localhost:51216/Home/ChangeOrderPopup",
                iframe: true
            },
            close: function (e) {
                $('#dialog_ocr_ei').fadeIn();
            }
        }).data("kendoWindow");
        kwindow.center().open();
    }
}
//$(document).ready(function () {
//    $('#jqxwindow').jqxWindow({
//        autoOpen: false,
//        width: 200,
//        height: 100
//    });  
//})
//function CreateWarningWindow() {
//    //if ($('#dialog').length > 0) {
//    var kwindow = $('#dialog').jqxWindow({
//        width: "80%",
//        height: "820px",
//        title: '',//"WARNING RELATED TO USE OF CONFIDENTIAL INFORMATION",      
//        isModal: true,
//        content: {
//            url: "http://localhost:51216/PMWebApi/Views/ChangeOrderPopup.html",
//            iframe: true
//        }
//        //$('#dialog').jqxWindow('close');

//    })
//    //kwindow.center().open();

//}
//function CreateWarningWindow() {
//    var strReturn;
//    var url = "/Views/ChangeOrderPopup.html";
//    var a = $('#dialog')
//    var iframe = document.getElementById("dialog");
//    iframe.src = url;
//    var _recId = 15;
//    CustomFormChangeOrder.Commitment(_recId);
//}
//function CreateWarningWindow() {
//    //if ($('#dialog').length > 0) {
//        var kwindow = $('#dialog').kendoWindow({
//            width: "80%",
//            height: "820px",
//            title: '',//"WARNING RELATED TO USE OF CONFIDENTIAL INFORMATION",
//            visible: false,
//            modal: true,
//            content: {
//                url: "http://localhost:51216/PMWebApi/Views/ChangeOrderPopup.html",
//                iframe: true
//            },
//            close: function (e) {
//                $('#dialog').fadeIn();
//            }
//        }).data("kendoWindow");
//        //kwindow.center().open();

//}
//function CreateWarningWindow() { 
//    $("#dialog").kendoWindow({
//        content: "http://localhost:51216/PMWebApi/Views/ChangeOrderPopup.html",
//        iframe: true
//    }); 
//}
var CustomFormChangeOrder = {
    initClose: function () {
        //if (DAMAC.getUrlParameter('TypeId') == 105 && DAMAC.getUrlParameter('Id') && DAMAC.getUrlParameter('Id') > 0) {
        //$('#btnSearchCustomer').click(CustomFormChangeOrder.SaveCOR);
    },
    handleClose: function (e) {
    //    //if (DAMAC.getUrlParameter('TypeId') == 105 && DAMAC.getUrlParameter('Id') && DAMAC.getUrlParameter('Id') > 0) {

    //    //var divModal = $("#popupWindow_CustomerQueue").modal('show');
    //    //$('#btnCloseRisk').click(CustomFormChangeOrder.SaveCOR);
    //    //$('#dvTestResultWindow').load('Views/Common/ChangeOrder.html');
    //    $('#btnSearchCustomer').click(CustomFormChangeOrder.SaveCOR);
    //        //CreateWarningWindow();       
    //    //$('#dialog').append(divModal);
        $("#popupWindow_CustomerQueue").modal('show');
        var _recId = 15;
        var CustomFormTypeId = 105;
        CustomFormChangeOrder.Commitment(_recId, CustomFormTypeId);
    //        //CustomFormChangeOrder.Clearall();

    //    //}
    },

    //handleClose: function (e) {
    //    CreateWarningWindow();
    //    var _recId = 15;
    //    var CustomFormTypeId = 105;
    //    CustomFormChangeOrder.Commitment(_recId, CustomFormTypeId);
        
    //},
    Clearall: function () {
        $('#cboUsers').jqxComboBox('clearSelection');
        $('#cboUsers').removeClass('error');
        $('#cboUsers').next('').css('top', '0');
    },
    Commitment: function (_recId, CustomFormTypeId) {
        CustomFormChangeOrder.getCommitment(_recId, CustomFormTypeId).then((list) => {
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'Id' },
                    { name: 'Text' }
                ],
                id: 'id',
                localdata: list
            };
            if (!$("#popupWindow_CustomerQueue")) {
                console.log('popupWindow_CustomerQueue');
            }
            var dataAdapter = new $.jqx.dataAdapter(source);

            if (!$("#cboUsers")) {
                console.log('Cbousers');
            }
            $("#cboUsers").jqxComboBox({ source: dataAdapter, multiSelect: true, displayMember: "Text", valueMember: "Id", width: '100%', showArrow: true });
            //$.each(dataAdapter.records, function (index) {
            //    $("#cboUsers").jqxComboBox('selectItem', dataAdapter.records[index].Id);
            //});

        });
    },
    getCommitment: function (_recId, CustomFormTypeId) {
        return new Promise((resolve, reject) => {
            fetch(`${DAMAC.getApiUrl('Commitment/GetCommitmentList')}?recId=${_recId}&CustomFormTypeId=${CustomFormTypeId}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                });
            });

        });
    },
    SaveCOR: function (_recId, CustomFormTypeId) {
        var Types = "";
        var items;
        var bvalidate = true;

        if ($("#cboUsers").jqxComboBox('getSelectedItem') == null) {
            $('#cboUsers').addClass('error');
            bvalidate = false;

        } else {
            $('#cboUsers').removeClass('error');
        }
        if (bvalidate == false) {
            msgUpdate = 'Please fill the mandatory fields.';
            showNotification('Mandatory Fields', msgUpdate, MsgTypeWarning);
            return false;
        }

        items = $("#cboUsers").jqxComboBox('getSelectedItems');
        for (var i = 0; i <= items.length - 1; i++) {
            if (Types != "") {
                Types = Types + ",";
            }
            Types = Types + items[i].value;
        }
        var _recId = 15;
        return new Promise((resolve, reject) => {
            fetch(`${DAMAC.getApiUrl('Commitment/SaveCOR')}?Types=${Types}&recId=${_recId}&CustomFormTypeId=${CustomFormTypeId}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                });
                if (data.statusText == "OK") {
                    msgUpdate = 'AutoCreation is done.';
                    showNotification(MsgTitleSaved, msgUpdate, MsgTypeSuccess);
                }
            });

        });

    }
}

export { CustomFormChangeOrder };