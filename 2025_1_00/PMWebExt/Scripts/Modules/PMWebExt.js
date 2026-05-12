import { Ajax } from './Ajax.js';
var self = {}, vars = [], user = {}, _ajax = {};
function PMWebExt() {
    self = this;
    var hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0].toLowerCase());
        vars[hash[0].toLowerCase()] = hash[1];
    }
    _ajax = new Ajax();
    vars.push("Id");
    vars["Id"] = 0;
}
Object.assign(PMWebExt.prototype, {
    constructor: PMWebExt,
    getUrlVar: function (param) {
        return vars[param.toLowerCase()];
    },
    loadUser: function () {
        return new Promise((resolve, reject) => {
            //user = { Id: 1, Email: "" };
            //resolve(1);
            _ajax.get(self.getHost(true) + '/custom/pmwebext.aspx/GetUser').then((data) => { user = JSON.parse(JSON.parse(data).d); resolve(1); }).catch((error) => reject(error));
        });
    },
    getHost: function (isPMWeb) {
        if (isPMWeb) {
            return location.origin + '/7_0_00/pmweb';
        }
        return location.origin + '/7_0_00/pmwebext';
        //return location.origin;
    },
    getUser: function () { return user; },
    getPage: function () {
        return window.location.pathname.split("/").pop();
    },
    InitWindow: function (title, content) {
        var kendoWindow = $("#PMWebExtWindow").data("kendoWindow");
        kendoWindow.content(content);
        kendoWindow.center().open();
    },
    IncludeKendo: function () {
        return new Promise((resolve, reject) => {
            $('head').append('<link id="moduleKendoCss" href="https://kendo.cdn.telerik.com/2019.3.1023/styles/kendo.default-v2.min.css" rel="stylesheet" />');
            $('#moduleKendoCss').remove();
            $('#moduleKendoScript').remove();
            //$('head').append('<link id="moduleKendoCss" href="' + self.getHost() + '/Content/web/kendo.default-v2.min.css" rel="stylesheet" />');
            var src = 'https:' === location.protocol ? 'https' : 'http',
                script = document.createElement('script');
            script.onload = resolve(1);
            script.id = 'moduleKendoScript';
            script.src = src + '://kendo.cdn.telerik.com/2019.3.1023/js/kendo.all.min.js';
            //script.src = self.getHost() + '/Scripts/Kendo/2019.3.1023/kendo.all.min.js';
            document.getElementsByTagName('body')[0].appendChild(script);
        });
    },
    CreateWindow: function () {
        $('<div />', {
            Id: 'PMWebExtWindow'
        }).appendTo($('body'));
        var windowOptions = {
            //actions: ["Custom", "Minimize", "Maximize", "Close"],
            draggable: true,
            resizable: true,
            width: "500px",
            visible: false,
            modal: true,
            //close: onClose
        };

        windowOptions.animation = { open: { effects: 'expand:vertical' }, close: { effects: 'expand:vertical', reverse: true } };

        setTimeout(function () {
            $("#PMWebExtWindow").kendoWindow(windowOptions);
        }, 2500);
    }
});
export { PMWebExt };