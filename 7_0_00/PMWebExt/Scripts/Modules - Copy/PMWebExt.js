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
            _ajax.get('https://cmcs.pmweb.com/7_0_00/pmweb/custom/pmwebext.aspx/GetUser').then((data) => { user = JSON.parse(JSON.parse(data).d); resolve(1); }).catch((error) => reject(error));
        });
    },
    getHost: function () {
        //return location.origin + "/pmwebext/";
        return location.origin + '/7_0_00/pmwebext';
        //return location.origin;
    },
    getUser: function () { return user; },
    getPage: function () {
        return window.location.pathname.split("/").pop();
    }
});
export { PMWebExt };