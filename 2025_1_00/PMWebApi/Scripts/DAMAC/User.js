import { DAMAC } from './DAMACApi.js';

var User = {
  
    get: function () {
        return new Promise((resolve, reject) => {           
            //uncomment for live
            fetch('https://damacpmis.pmweb.com/Dev/PMWeb/Custom/PmwebHelper.aspx/GetUser', {
                method: "get",
                async: false,
                cache: 'no-cache',
                dataType: "json",
                headers: {
                    'Content-Type': 'application/json',
                    'data-type': 'json'
                }
            }).then(function (data) {
                data.json().then(function (json) {
                    json = JSON.parse(json.d);
                    resolve(json);
                });
            });
        }); 
    },
    getId: function () {
        return new Promise((resolve, reject) => {
            User.get().then((data) => {
                if (data && data.Id)
                    resolve(data.Id);
                else
                    reject(data);
            });
        }); 
    },
    getCompany: function () {
        return new Promise((resolve, reject) => {
            this.getId().then((_user) => {
                fetch(`${DAMAC.getApiUrl('user/getcompany')}?id=${_user.Id}`, {
                    method: "get"
                }).then(function (data) {
                    data.json().then(function (json) {
                        resolve(json);
                    });
                });
            });
        }); 
    }
}

export { User };