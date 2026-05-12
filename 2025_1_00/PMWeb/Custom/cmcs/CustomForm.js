import { Cmcs } from './CmcsApi.js';
import { User } from './User.js';

var e = false;
var show = true;
var CustomForm = {   
   
    init: (sender, args) => {
    },
    fromCompany: {
        init: () => {                         
                    setTimeout(CustomForm.scope.init(), 500);            
          
         
        },
    }, 
	scope: {
      
        hasScope: (_container) => {
            return _container.length > 0;
        },
        
    },

	//To hide the recap section 
	 Recap: () => {
    var userid = '';
    var userGrp = '';
    var spnRecap = $('#spanRecap');
    var tabStrip = Cmcs.mainTab();
    const tab = Cmcs.mainTab().get_selectedTab().get_text();

    const handleDisplay = (PackageBudgetLabel = null, PackageBudgettext = null, EOIUrl = null, PrebidUrl = null) => {
	 if (Cmcs.getUrlParameter('PageId') == 286) {
      if (show) {
        if (PackageBudgetLabel && PackageBudgettext && EOIUrl && PrebidUrl) {
          PackageBudgetLabel[0].style.display = '';
          PackageBudgettext[0].style.display = '';
		  EOIUrl[0].style.display = '';
          PrebidUrl[0].style.display = '';
        }        
      } else if (show == false) {    
		console.log('show flag:', show);		
        if (PackageBudgetLabel && PackageBudgettext && EOIUrl && PrebidUrl) {
          PackageBudgetLabel[0].style.display = 'none';
          PackageBudgettext[0].style.display = 'none';
		  EOIUrl[0].style.display = 'none';
          PrebidUrl[0].style.display = 'none';
        }        
      }
	 }else{
	  if (show) {
        if (PackageBudgetLabel && PackageBudgettext) {
          PackageBudgetLabel[0].style.display = '';
          PackageBudgettext[0].style.display = '';
        }        
      } else if (show == false) {    
		
		console.log('show flag:', show);		
        if (PackageBudgetLabel && PackageBudgettext) {
          PackageBudgetLabel[0].style.display = 'none';
          PackageBudgettext[0].style.display = 'none';
        }        
      }
	 }
    };
 const processRecap = (PackageBudgetLabel = null, PackageBudgettext = null, EOIUrl = null, PrebidUrl = null) => {
  if (!CustomForm.scope.hasScope(spnRecap)) return;

  const combo = $find($('div.RadComboBox_Default', spnRecap)[0].id);
 // if (combo.get_value() == 5) {
    //show = true;
    //CustomForm.Recapshow(show);
   // handleDisplay(PackageBudgetLabel, PackageBudgettext,EOIUrl,PrebidUrl);
   // return;
  //}

  // Proceed to group/user validation
  User.get().then((_userData) => {
    userGrp = _userData.Group;
    userid = _userData.Id;

    CustomForm.GetRecapGroup().then((groupList) => {
      const groupMatch = groupList.some(item => item.Text === userGrp);
      if (groupMatch) {
        show = true;
        CustomForm.Recapshow(show);
        handleDisplay(PackageBudgetLabel, PackageBudgettext,EOIUrl,PrebidUrl);
        return;
      }

      CustomForm.GetRecapUser().then((userList) => {
        const userMatch = userList.some(item => item.Id == userid);
        show = userMatch;
        CustomForm.Recapshow(show);
        handleDisplay(PackageBudgetLabel, PackageBudgettext,EOIUrl,PrebidUrl);
      });
    });
  });
};
  

    // if (Cmcs.getUrlParameter('PageId') == 106) {
      // const RFAamountLabel = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl08_lblMeasure');
      // const RFAamounttext = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl08_txtMeasure');
      // processRecap(RFAamountLabel, RFAamounttext);
	  // var e = Cmcs.mainTab().findTabByText('Additional Info');
	  // const currentTab = Cmcs.mainTab().get_selectedTab().get_text().toLowerCase();
	  // console.log('tabname' + e);	
	    // if (currentTab == 'additional info') {
                    // var tabContentElement = e.get_pageView().get_element();                    
                    // if (show == false) {
                        // tabContentElement.innerHTML = '';
                    // }                  

                // }
    // }

    if (Cmcs.getUrlParameter('PageId') == 161) {
	  var e = Cmcs.mainTab().findTabByText('Additional Info');
	  const currentTab = Cmcs.mainTab().get_selectedTab().get_text().toLowerCase();
	  console.log('tabname' + e);	 
               
      // const RFAamountLabel = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl05_lblMeasure');
      // const RFAamounttext = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl05_txtMeasure');
      const PackageBudgetLabel = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl04_lblMeasure');
      const PackageBudgettext = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl04_ddlMeasure');
      processRecap(PackageBudgetLabel, PackageBudgettext, '', '');
	  if (currentTab == 'additional information') {
                    var tabContentElement = e.get_pageView().get_element();                    
                    if (show == false) {
                        tabContentElement.innerHTML = '';
                    }                 

                }
    }
	  if (Cmcs.getUrlParameter('PageId') == 286) {
	  var e = Cmcs.mainTab().findTabByText('Additional Info');
	  const currentTab = Cmcs.mainTab().get_selectedTab().get_text().toLowerCase();
	  console.log('tabname' + e);	 
               
      // const RFAamountLabel = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl05_lblMeasure');
      // const RFAamounttext = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl05_txtMeasure');
      const PackageBudgetLabel = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl04_lblMeasure');
      const PackageBudgettext = $('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl04_ddlMeasure');
	  console.log($('#ctl00_CPH1_DocumentSpecificationsHeader1_rptHeaderSpecification_ctl04_ddlMeasure').length);

	  
	  const EOIUrl = $('#ctl00_CPH1_lblCustomEOIUrl');
	  const PrebidUrl = $('#ctl00_CPH1_lblCustomUrl');
	  
      processRecap(PackageBudgetLabel, PackageBudgettext, EOIUrl, PrebidUrl);
	  if (currentTab == 'additional info') {
                    var tabContentElement = e.get_pageView().get_element();                    
                    if (show == false) {
                        tabContentElement.innerHTML = '';
                    }                  

                }
    }
  },

	Recapshow: (show) => {	
	    if (show == true)
		{
			console.log('recap show');
			// $('#dvRecap').show();
			
		}
	},
	GetRecapGroup: () => {
            return new Promise((resolve, reject) => {
                fetch(`${Cmcs.getApiUrl('Commitment/GroupPermitted')}`, {
                    method: "get"
                }).then(function (data) {
                    data.json().then(function (json) {
                        resolve(json);
                    });
                });
            });
    },
    GetRecapUser: () => {
        return new Promise((resolve, reject) => {
            fetch(`${Cmcs.getApiUrl('Commitment/UserPermitted')}`, {
                method: "get"
            }).then(function (data) {
                data.json().then(function (json) {
                    resolve(json);
                });
            });
        });
    },
	
}

export { CustomForm };