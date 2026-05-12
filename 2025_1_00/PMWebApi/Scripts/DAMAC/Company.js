import { DAMAC } from './DAMACApi.js';

var Company = {
    getName: function (id) {
        return new Promise((resolve, reject) => {
            fetch(DAMAC.getApiUrl('company/getname?id=') + id, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                });
            });
        });
    }
}

export { Company }