<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BrowsePowerBIPopUp.aspx.vb" Inherits="Website.BrowsePowerBIPopUp" %>

<%--<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BrowsePowerBIPopUp.aspx.vb" Inherits="RND2.PowerBIList" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <style type="text/css">


          .ProfileTitle {
                color: #a5a5a5 !important;
                position: fixed;
                top: 10px !important;
                width: 100%;
                font-size: 15px !important;
                padding: 20px 0px 5px 16px;
                background-color: white;
                z-index: 1000;
            }
          /*
            .closepopup div {
                background-image: url('CSS/Images/ResponsiveIcons/CloseButton.png') !important;
                background-repeat: no-repeat;
                background-position: 0 0 !important;
                display: inline-block;
                position: absolute;
                right: 16px !important;
                bottom: 1px;
            }*/
            .CloseProfilePopup{
                margin-left:0px !important;
            }

            .ToolBar {
                border-bottom: 1px solid RGB(237,237,237);
            }
              .RadToolBar .rtbOuter {
                background-color: white !important;
            }

            .documentSinglePage {
                margin-top: 100px !important;
            }
            
            .ToolBar {
                border-bottom: 2px solid grey;
            }
           
           .RadGrid.RadGrid_Default .rgFilterRow  {
           display: none;
                }
           .tr#rdgBrowsePowerBI_ctl00__0{
                background-color: #EDEDED;
           }
          
        
         
    </style>
</head>
<body>
      <script src="https://alcdn.msauth.net/browser/2.14.2/js/msal-browser.min.js"></script>
        <script type="text/javascript">
  <%--       function GetPBIReports1() {
                var arrReports = [];
                var griData = [];
                    arrReports.push({ "Name": "test", "WebUrl": "www.google.com", "EmbedUrl": "www.kaza.com" });
                    arrReports.push({ "Name": "test2", "WebUrl": "www.goASAogle.com", "EmbedUrl": "www.kaza.com" });
                    arrReports.push({ "Name": "test3", "WebUrl": "www.goASASogle.com", "EmbedUrl": "www.kaza.com" });
               
                if (arrReports.length > 0) {
                    for (var i = 0; i < arrReports.length; i++) {
                        griData.push({ "Select": false, "PMWebName": arrReports[i].Name, "PowerBIReport": arrReports[i].Name, "WebUrl": arrReports[i].WebUrl });
                    }
                }
                 var serializedData = JSON.stringify(griData);
                        var hiddenField = document.getElementById('<%= hdnData.ClientID %>');
                        hiddenField.value = serializedData;
    
                        __doPostBack('<%= btnPost.UniqueID %>', '');
            }--%>

            function GetPBIReports() {

            const clientId = '<%=PM.Parameters.BROWSE_POWERBI_CLIENTID%>'; // Replace with your Power BI application client ID //Pmparameter
            const tenantId = '<%=PM.Parameters.BROWSE_POWERBI_TENANTID%>'; // Replace with your Power BI application client ID //pmparameter
            const redirectUri = '<%=PM.Parameters.PM_WEBSITE_HOSTNAME%>'+'/BrowsePowerBIPopUP.aspx'; // Replace with your Power BI application redirect URI
            const scope = 'https://analysis.windows.net/powerbi/api/Report.Read.All'; // Power BI API scope
            

            const msalConfig = {
                auth: {
                    clientId: clientId,
                    authority: "https://login.microsoftonline.com/" + tenantId,
                },
                cache: {
                    cacheLocation: "sessionStorage",
                    storeAuthStateInCookie: false,
                }
            };

            const msalInstance = new msal.PublicClientApplication(msalConfig);
            var arrReports = [];

            msalInstance.acquireTokenPopup({
                scopes: ["https://analysis.windows.net/powerbi/api/Report.Read.All"] 
            }).then((response) => {
                arrReports = [];
                $.ajax({
                    url: 'https://api.powerbi.com/v1.0/myorg/reports',
                    type: 'GET',
                    headers: {
                        'Authorization': 'Bearer ' + response.accessToken
                    },
                    success: function (response) {
                        var griData = [];
                        if (response.value.length > 0) {
                            for (var i = 0; i < response.value.length; i++) {
                                arrReports.push({ "Name": response.value[i].name, "WebUrl": response.value[i].webUrl, "EmbedUrl": response.value[i].embedUrl });
                            }
                            if (arrReports.length > 0) {
                                for (var i = 0; i < arrReports.length; i++) {
                                    griData.push({ "Select": false, "PMWebName": arrReports[i].Name, "PowerBIReport": arrReports[i].Name, "WebUrl": arrReports[i].EmbedUrl +'&autoAuth=true' });
                                }
                            }
                        }
                        var serializedData = JSON.stringify(griData);
                        var hiddenField = document.getElementById('<%= hdnData.ClientID %>');
                        hiddenField.value = serializedData;
    
                        __doPostBack('<%= btnPost.UniqueID %>', '');
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            }).catch((error) => {
                console.log(error);
            });

            }
           


        </script>
     <form id="form1" runat="server">
        <div class="ProfileTitle">
            <asp:Label runat="server" ID="BrowsePowerBITitle" Text="Browse Power BI" meta:resourcekey="BrowsePowerBITitle"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar"  style="width: 100%; margin-top: 50px; background-color: transparent !important" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton CommandName="SaveExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"></telerik:RadToolBarButton>
                        </Items>                      
                        <Items>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr> 
        </table>
    <div style="padding-top: 140px; padding-left: 50px;padding-right: 50px;">  
        <asp:HiddenField ID="hdnData" runat="server" /> <asp:Button ID="btnPost" runat="server" style="display:none" />
         <telerik:radgrid id="rdgBrowsePowerBI" runat="server"  FilterType="HeaderContext"  EnableHeaderContextFilterMenu="true" filterrow
                AutoGenerateColumns="False" ShowStatusBar="false" HeaderStyle-Font-Size="8" CssClass="WithoutTopBorder" AllowFilteringByColumn="true"
                PageSize="250" AllowPaging="false" ShowFooter="False" ShowGroupPanel="False"  HasPasteFromExcel="false" Width="80%"  setwidth="true"
                AllowMultiRowEdit="False" AllowMultiRowSelection="False" AllowSorting="true" ItemStyle-Height="20px" UseEditFormInMobile="False">
                 <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="PowerBIReport" CommandItemDisplay="none" TableLayout="Fixed"
                    Width="100%" UseAllDataFields="true"
                    EnableHeaderContextMenu="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="10px"   AllowFiltering="false" DataField="Select"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True" UniqueName="SELECT" >
                                <HeaderTemplate >
                                            <table>
                                    <tr>
                                        <td style="padding-left: 27px;padding-top:4px">
                                      <asp:Label runat="server" text="select" meta:resourcekey="GridColumn_SelectPowerBI"></asp:Label>

                                            </td>
                                        <td>
                                          <asp:CheckBox ID="chkAll" onClick="AllDisplayColumnsClicked(this)" runat="server" cssclass="ChkALL"/>

                                        </td>
                                        </tr>
                                                </table>

                                </HeaderTemplate>
                            <ItemTemplate>        
                                 <asp:CheckBox ID="chkDisplay" runat="server"  Checked='<%#Container.DataItem("Checked") %>'/>
                                    </ItemTemplate>
                            <ItemStyle HorizontalAlign="center"></ItemStyle>
                        </telerik:GridTemplateColumn>
                       
                         <telerik:GridTemplateColumn HeaderStyle-Width="60px" meta:Resourcekey="GridColumn_PowerBIReport"  AllowFiltering="false" DataField="PowerBIReport"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True" UniqueName="PowerBIReport"  >
                                  <ItemTemplate>
                                      <div>
                                           <span><%#Container.DataItem("PowerBIReport").ToString%> </span>
                                      </div>
                                       
                                    </ItemTemplate>
                             <ItemStyle BackColor="#ededed" /> 
                            <ItemStyle HorizontalAlign="left"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" meta:Resourcekey="GridColumn_PMWebName"  AllowFiltering="false" DataField="PMWebName"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True" UniqueName="PMWebName">
                                  <ItemTemplate>
                                        <asp:TextBox ID="txtPMWebName" MaxLength="4000" Width="100%" runat="server" Text='<%#Container.DataItem("PMWebName").ToString%>' style="border:hidden"></asp:TextBox>
                                    </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderStyle-Width="60px" meta:Resourcekey="GridColumn_WebUrl" Visible="false"  AllowFiltering="false" DataField="WebUrl"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True" UniqueName="WebUrl">
                                  <ItemTemplate>
                                        <span id="WebUrl" runat="server"><%#Container.DataItem("WebUrl").ToString%></span>
                                    </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>
                          <%--    <telerik:GridTemplateColumn HeaderStyle-Width="60px" meta:Resourcekey="GridColumn_WebUrl" Visible="false"  AllowFiltering="false" DataField="WebUrl"
                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="True" UniqueName="WebUrl">
                                  <ItemTemplate>
                                        <span><%#Container.DataItem("ReportID").ToString%></span>
                                    </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>--%>
                        </Columns> 
                    </MasterTableView> 
                      
            </telerik:radgrid>
    <%--<button id="login"> login</button>
    <button id="clickMe">click me</button>--%>
    </div>
    </form>
    <script>
        function AllDisplayColumnsClicked(iObj) {
            var i = 0;
            var rdgrdgBrowsePowerBI = $("div[id$='rdgBrowsePowerBI']");
            var j = 0;
            var k = 0;
            rdgrdgBrowsePowerBI.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkDisplay") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;

            });    
        }
        function SelectRdgBRowsePowerBIParent(sender) {
            var rdgrdgBrowsePowerBI = $("div[id$='rdgBrowsePowerBI']");
            var chkPArent = rdgrdgBrowsePowerBI.find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;

            rdgrdgBrowsePowerBI.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (sender.checked) {
                        if (!this.disabled && !this.checked && this.id.indexOf("chkDisplay") > 0) isChecked = false;
                    }
                }
                i++;
            });


            if (!sender.checked) {
                chkPArent.checked = false;



            } else {
                chkPArent.checked = isChecked;

            }


            return false;

        };
    </script>
</body>
</html>
