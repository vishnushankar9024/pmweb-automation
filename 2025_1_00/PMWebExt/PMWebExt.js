import { Ajax } from './Scripts/Modules/Ajax.js'
import { DynamicButton } from './Scripts/Modules/DynamicButton.js'
import { Textarea } from './Scripts/Modules/Textarea.js'
import { PMWebExt } from './Scripts/Modules/PMWebExt.js'
import { Notification } from './Scripts/Modules/Notification.js'
import { CostCode } from './Scripts/Modules/CostCode.js'
import { PreBid } from './Scripts/Modules/PreBid.js'
(function () {
    var pmwebExt = new PMWebExt();
    var ext = {
        pmweb: pmwebExt,
        ajx: new Ajax()
    };
    var costCode = new CostCode(ext);
    var preBid = new PreBid(ext);
    var textarea = {};

    window.InitModule = function (sender, eventArgs) {
        Init();
    }
    window.FormatCostCode = function (ClipboardData) {
        ClipboardData = costCode.FormatData(ClipboardData);
        return ClipboardData;
    };
    window.GetPQDetails = function (sender, eventArgs) {
        preBid.PreBidMatrixGrid = sender;
        preBid.GetPQDetails(eventArgs.get_gridDataItem().getDataKeyValue("Id"), eventArgs.get_gridDataItem().get_element());
    }
    window.PreBidMatrixRadGridCommand = function (grid) {
        //alert('test');
        //var grid = $find("<%= RadGrid1.ClientID %>");
        //var masterTableView = grid.get_masterTableView();
        //var editItem = masterTableView.get_editItems()[0];
        //var cellValue = editItem.getDataKeyValue("ID");
    }
    function Init() {
        pmwebExt.loadUser().then(() => {
            pmwebExt.IncludeKendo().then(() => {
                new DynamicButton(pmwebExt);
                new Notification(ext);
                setTimeout(function () {
                    new Textarea(ext).Init();
                    pmwebExt.CreateWindow();
                }, 5000);
            });
        });
    }
    Init();
})();