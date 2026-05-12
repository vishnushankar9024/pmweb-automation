import { CustomForm } from './CustomForm.js';
import { actionItem } from './ActionItem.js';

window.onRoshnResponseEnd = function(sender, eventArgs) {
	if (args.EventTargetElement) args.EventTargetElement.disabled = false;
	console.log('Reponsed end initiated by: '+ eventArgs.get_eventTarget());
}

$( document ).ajaxComplete(function( event, xhr, settings ) {
	console.log('test');
	console.log(event);
	console.log(xhr);
	console.log('test');
});
/********** From Company DropDown ********/
window.onddlPHProjectLoad = function(sender, args) {
	sender.add_selectedIndexChanged((sender, args) => {
		CustomForm.fromCompany.init(sender, args);
		CustomForm.Risk.stageGate.onProjectChanged(sender, args);
		CustomForm.scope.init(sender, args);
	});
	$(document).ready(function () {
		CustomForm.Risk.init(sender, args);
		CustomForm.scope.preventItemRequesting(sender, args);
		CustomForm.init(sender, args);
	});
}

$(document).ready(function () {
    
    CustomForm.Risk.stageGate.initClose();
});

window.onCollaborateLoad = function () {
	actionItem.init();
}



