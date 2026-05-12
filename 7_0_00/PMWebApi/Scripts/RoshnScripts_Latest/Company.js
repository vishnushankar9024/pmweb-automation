import { Roshn } from './RoshnApi.js';

var Company = {
    getName: function (id) {
        return new Promise((resolve, reject) => {
            fetch(`${Roshn.getApiUrl('company/getname')}?id=${id}`, {
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