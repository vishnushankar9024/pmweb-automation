import { DAMAC } from './DAMACApi.js';
import { User } from './User.js';
function createSSISPackage(PackageName, RecId) {

    $.ajax({        
        url: DAMAC.getApiUrl('api/RunSSIS'),
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            PackageName: PackageName,
            FolderName: 'MyFolder',
            ProjectName: 'MyProject',
            Use32BitRuntime: false,   // false for 64-bit, true for 32-bit
            ParameterName: RecId,  // Optional
            ParameterValue: 'MyValue'      // Optional
        }),
        success: function (response) {
            alert('SSIS Package Executed Successfully');
            console.log(response);
        },
        error: function (xhr, status, error) {
            alert('An error occurred: ' + error);
        }
    });
}

var SSISPackage = {

    init: (sender, args) => {
    },
    SSISSummary: {
        init: (sender, args) => {
            //if (DAMAC.getUrlParameter('TypeId') == 105 && DAMAC.getUrlParameter('Id') > 0) {
                setTimeout(SSISPackage.buttonClick.init(sender, args), 500);
            //}
        },
    },

    buttonClick: {
        init: (sender, args) => {
            var btnContainer = $('#btnOpenAreaSummary');
            if (SSISPackage.buttonClick.hasScope(btnContainer) === true) {
                var PackageName = '';
                PackageName = btnContainer.name();
                var RecId = 2;
                createSSISPackage(PackageName, RecId);
            });
        },  
        getScope: (RecId, PackageName) => {
            return new Promise((resolve, reject) => {
                //User.getId().then((_userId) => {
                var Username = 'Test';
                var Type = 'MN';
             
                //});
            });
        },
        hasScope: (_container) => {
            return _container.length > 0;
        },      

    }, 

}

export { SSISPackage };
