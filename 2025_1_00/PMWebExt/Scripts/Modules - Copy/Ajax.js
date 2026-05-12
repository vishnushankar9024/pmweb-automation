var self = {};
function Ajax() { self = this; }
Object.assign(Ajax.prototype, {
    post: function (url, data) {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: url,
                dataType: "html",
                type: "POST",
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
                data: JSON.stringify(data),
            }).then((data) => { resolve(data); }).then((err) => { reject(err); });
        });
    },
    get: function (url) {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: url,
                dataType: "html",
                type: "GET",
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
            }).then((data) => { resolve(data); }).then((err) => { reject(err); });
        });
    }
});
export { Ajax };