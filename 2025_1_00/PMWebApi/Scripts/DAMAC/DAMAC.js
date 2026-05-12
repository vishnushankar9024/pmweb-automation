import { CustomForm } from './CustomForm.js';
//import { SSISPackage } from './SSISPackage.js';
import { EstimateBiddersNew } from './EstimateBiddersNew.js';


function onDAMACResponseEnd(sender, eventArgs) {
	console.log('Reponsed end initiated by: '+ eventArgs.get_eventTarget());
}

$( document ).ajaxComplete(function( event, xhr, settings ) {
	console.log('test');
});
///********** To load phase based on User company********/
window.onddlPHProjectLoad = function (sender, args) {
    sender.add_selectedIndexChanged((sender, args) => {
        CustomForm.fromCompany.init(sender, args);       
        CustomForm.scope.init(sender, args);
    });
    $(document).ready(function () {       
        CustomForm.scope.preventItemRequesting(sender, args);
        CustomForm.init(sender, args);                                                                                          
    });
}
$(document).ready(function () {
    //CustomForm.scope.fromCompany.init();
  //  CustomForm.scope.GetRecapGroupPermitted();
    //$('#btnCloseRisk').click(CustomForm.ChangeOrder.handleClose);
    //CustomForm.ChangeOrder.initClose();
   // $('#btnOpenAreaSummary').click(EstimateBiddersNew);
  //  $('#btnOpenAreaSummary').click(SSISPackage.SSISSummary.init);
  //  EstimateBiddersNew.CreateWarningWindow();
   // EstimateBiddersNew();
    ebConfirm();
    
});
$(() => {
   // EstimateBiddersNew();
});






