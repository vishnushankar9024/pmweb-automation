//import { DAMAC } from './DAMACApi.js';

var User = {
  
    get: function () {
        return new Promise((resolve, reject) => {           
            //uncomment for live
            fetch('https://cmcs.pmweb.com/7_0_00/PMWeb/Custom/PmwebHelper.aspx/GetUser', {
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
    }
}


User.get()
  .then(function (userData) {
    console.log(userData);
  })
  .catch(function (error) {
    console.error('Error:', error);
  });


window.document.onload = function(e){ 
	User.get().then((_userData) => {
                  console.log(_userData.Username);
                });
   }
