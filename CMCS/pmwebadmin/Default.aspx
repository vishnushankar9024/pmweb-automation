<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Website._Default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PMWEB Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <%--  <link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jquery.min.js" type="text/javascript"></script>

    <script src="JS/PMJS.js" type="text/javascript"></script>
   <%-- <link href="CSS/ComboBox.PM.css" rel="stylesheet" />--%>
    <link href="CSS/Login.css" rel="stylesheet" type="text/css" />



    <script type="text/javascript">

        $(document).ready(function (n) {
          
            var today = new Date();
            var year = today.getFullYear();
            $('#copyrightLabel').html('© 2007-' + year + ' PMWEB, Inc.');

            $(document).keypress(function (e) {
                kc = e.keyCode ? e.keyCode : e.which;
                sk = e.shiftKey ? e.shiftKey : ((kc == 16) ? true : false);
                if (((kc >= 65 && kc <= 90) && !sk) || ((kc >= 97 && kc <= 122) && sk)) {
                    document.getElementById('CapsLockDiv').style.visibility = 'visible';
                } else {
                    document.getElementById('CapsLockDiv').style.visibility = 'hidden';
                }
            });
        });

      
        function isMobileScreen() {
            var MobileScreenWidth = 768;
            var browserWidth = $telerik.$(window).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }

        function OpenPOPUp(URL) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen(URL);
            let el = wnd.get_popupElement();
            //wnd.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close);
            wnd.set_modal(true);
            wnd.setSize(480, 365);
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            wnd.set_visibleStatusbar(false);
            wnd.set_visibleTitlebar(false);
            wnd.set_destroyOnClose(false);
            wnd.center();

            $(el).find("tr.rwTitleRow, td.rwCorner, tr.rwFooterRow").remove();
            $(el).find(".rwWindowContent").css("border-radius", "20px");
            $(el).find(".rwWindowContent").css("box-shadow", "0px 0px 1rem rgba(0, 0, 0, 0.3)");
            //$(el).find(".rwWindowContent").css("overflow", "hidden");
            $(el).find('iframe').css("border-radius", "20px");
            $(el).find("table.rwTable").css("width","100%")

            return false;
        }

        function clearFields(s) {
            if (s.checked == false) {

                $.ajax({
                    type: "POST",
                    url: "default.aspx/ClearCookie",
                    contentType: "application/json; charset=utf-8",
                    data: "{'isChecked':'" + document.getElementById('chkSavePassword').checked + "'}",
                    dataType: "json",
                    async: false,
                    success: function (response) {

                    }
                });


            }

        }

        function btnLogin_Clicked() {
           
            var strUsername = '';
            var strPassWord = '';
            var intDbId = 0;
            if ($find('cboDatabases')) {
                strDatabase = $find('cboDatabases').get_text();
            }
          
             if ($find('txtUser')) { strUsername = $find('txtUser').get_value(); }
            
            if ($find('txtPassword')) {
                strPassWord = $find('txtPassword').get_value();
            }  
        
        }
        function onComboxOpen(sender, eventArgs) {
            //if (sender.get_dropDownVisible()) {
            //    eventArgs.set_cancel(true);
            //}
        }
        function closeDDL(sender, eventArgs) {
            //if (sender.get_dropDownVisible()) {
            //    sender.hideDropDown();
            //}
        }
        document.addEventListener('DOMContentLoaded', function (event) {
             
                       let arrowButtons = document.querySelectorAll(".form-ddl-input .rcbArrowCell");
                       arrowButtons.forEach(arrow => {
                           arrow.addEventListener("click", e => {
                               let comboElement = arrow.closest(".RadComboBox");
                               if (!comboElement) {
                                   return;
                               }
                               let combo = $find(comboElement.id);
                               if (combo) {
                                   e.preventDefault();
                                   e.stopPropagation();
                                   combo.toggleDropDown();
                               }
                           })
                       });
                       let labels = document.querySelectorAll(".form-ddl-input label");
                       labels.forEach(label => {
                           label.addEventListener("click", e => {
                               let comboElement = label.closest(".RadComboBox");
                               if (!comboElement) {
                                   return;
                               }
                               let combo = $find(comboElement.id);
                               if (combo) {
                                   e.preventDefault();
                                   e.stopPropagation();
                                   combo.toggleDropDown();
                               }
                           })
                       })

                   });
        function showErrCredentials() {
            const divErrElement = document.getElementById('errCredentials');
            divErrElement.style.visibility = "visible";
        }
    </script>
</head>

<body>
    <form id="form1" runat="server" style="background-color:lightgray">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
         <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
     ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
     IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
     Top="">
 </telerik:RadWindowManager>
        <div class="main-container">
    <div class="sidebar">

        <div class="header-section">
            <asp:Image ID="imgLogo" runat="server" class="logo" ImageUrl="CSS/Images/LoginLogo.png" AlternateText="PMWEB Logo" />
            <h1 class="title">PMWEB Admin Utility</h1>
             <p class="subtitle">Log in to your account to get started</p>
            
            <div id="errCredentials" style="visibility: hidden; margin-block: 1px; transform: translateY(5px);">
                <p class="errorMsg" style="font-size: 1rem">There was a problem</p>
                <p class="errorMsg" style="font-size: 0.75rem">Please try again</p>
            </div>
        </div>
              <div class="form-section">
               <div>
      
                       <telerik:RadComboBox ID="cboDatabases" runat="server" AutoPostBack="true" CausesValidation="false"
            CloseDropDownOnBlur="true" Height="232px" TabIndex="1" CssClass="form-ddl-input"
            DropDownCssClass="form-ddl" ExpandAnimation-Type="None"
            ExpandAnimation-Duration="0000" CollapseAnimation-Type="None" CollapseAnimation-Duration="0000"
            Label="Database" LabelCssClass="input-label" EmptyMessage="Database" >
            <ItemTemplate>
                <asp:Label runat="server" Text='<%# Eval("DatabaseName") %>'></asp:Label>
                <i class="selected-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" viewBox="20 -237.5 356.2 257.5" stroke="#3654e9" stroke-width="40">
                        <path d="m 40 -98.7 l 98.7 98.7 l 217.5 -217.5" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </i>
              
            </ItemTemplate>
        </telerik:RadComboBox>
    </div>


    <div>
     
        <label for="txtUser" class="input-label">User</label>
        <telerik:RadTextBox ID="txtUser" runat="server" CausesValidation="True" CssClass="form-text-input"  Width="85%" Visible="true"
            Style="height: 40px;" TabIndex="2">
        </telerik:RadTextBox>
    </div>

    <div>
        <label for="txtPassword" class="input-label">Password</label>
        <div>
            <telerik:RadTextBox ID="txtPassword" runat="server" CausesValidation="True"
                TextMode="Password" AutoCompleteType="None" autocomplete="Off" TabIndex="3" CssClass="form-text-input password">
            </telerik:RadTextBox>
            <asp:Label runat="server" ID="Label1" Style="display: none;"></asp:Label>
        </div>
        <div id="CapsLockDiv" class="Validator" style="display: none">Caps Lock is on</div>

    </div>
    <uc1:Message ID="Message1" runat="server" />

    <div class="options">
        <%--<div class="checkbox-input">
            <input id="chkSavePassword" runat="server" type="checkbox" onclick="clearFields(this)" />
            <label for="chkSavePassword" class="checkbox-label">Remember Me</label>
        </div>--%>
        <div>
            <label class="checkbox-container">
                <input id="chkSavePassword" runat="server" type="checkbox" onclick="clearFields(this)" />
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="m 5 13 l 4 4 l 10 -10" fill="none" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                <span class="checkbox-label">Remember Me</span>
            </label>
        </div>
        
    </div>

    <div class="loginBtnFont">
        <asp:Button ID="btnLogin" Text="Log in" runat="server" OnClientClick="return btnLogin_Clicked()" class="login-button" />
        <asp:Button ID="btnFLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="FLogin" class="login-button" />
        <asp:Button ID="btnLoginAfterPassChange" CausesValidation="false" CssClass="Hide" runat="server" Text="PLogin" class="login-button" />
        <asp:Button ID="btnRemindLogin" CausesValidation="false" CssClass="Hide" runat="server" Text="PRemindLogin" class="login-button" />
    </div>
                      <div class="footer">
                          <p id="copyrightLabel"></p>
                          <div class="footer-links">
                          <a href="javascript:void(0)"; onclick="return OpenPOPUp('AboutPMWEB.aspx')" >
                                 <asp:Literal runat="server" > About PMWEB</asp:Literal>
                                  </a>
                   <a href="https://www.pmweb.com/eula" target="_blank">License Agreement</a>
                  <%-- <a href="https://help.pmweb.com/pmwebeula.html" target="_blank">Privacy Policy</a>--%>
     </div>
                           </div> 

    
                  </div>
                   

    </div>


 <div style="flex: 1">
    <img src="CSS/Images/LoginBackgroundImg.png" style=" width: 100%;" class="imgLogin" id="imgLogin" runat="server" alt="Login Background Image" />
</div>
                
        </div>

    </form>
</body>
</html>
