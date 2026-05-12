import { PMWebExt } from './Scripts/Modules/PMWebExt.js'
import { Ajax } from './Scripts/Modules/Ajax.js'
(function () {
    var ext = {
        pmweb: new PMWebExt(),
        ajx: new Ajax()
    };
    new Notification(ext);
})();