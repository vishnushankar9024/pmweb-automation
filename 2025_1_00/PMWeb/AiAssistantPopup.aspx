<%@ Page Language="vb" meta:resourcekey="Page" Title="Ai Assistant" AutoEventWireup="false" CodeBehind="AiAssistantPopup.aspx.vb" Inherits="Website.AiAssistantPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

       <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <link href="CSS/MainCss.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
    </telerik:RadCodeBlock> 
    <title></title>
    <style type="text/css">

        body{
          font-family: 'Roboto', sans-serif !important;
        }

        .header {
          display: flex; 
          justify-content: center; 
          align-items: center; 
          padding-left: 20px;
        }

        .title {
          color: white;
          font-size: 16px;
          padding-left: 12px;
        }

        .CloseButton {
          fill: white;
          display: inline-block !important;
          width: 24px !important;
          height: 24px !important;
          margin-right: 20px !important;
          cursor:pointer;
        }

        .trSearchBar {
          display: flex;
          justify-content: center;
        }

        .tdSearchBar {
          display: flex;
          justify-content: center;
          width: 100%;
        }

      
        .AiSearchInput {
          border-radius: 25px !important;
          height: 50px !important;
          font-size: 18px;
          padding-left: 22px !important;
        }

        .AiSearchInput:focus {
          outline: none;
        }

        .AiSearchIcon {
          width: 24px;
          height: 24px;
          fill: white;
          position: absolute;
          top: 50%;
          right: 8px;
          transform: translateY(-50%);
          cursor: pointer;
          background-color: /*2*/#3498DB/*2*/;
          border-radius: 50%;
          padding: 7px;
        }

        .tblButtons {
          box-sizing:border-box; 
          position: absolute;
          width: 100%;
          margin-top: 5%; 
          table-layout: fixed
        }

        .trSearchBarButtons {
          display: flex;
          justify-content: center;
          margin-top: 15px;
        }

        .tdSearchBarButton {
          display: flex;
          justify-content: center;
          width: 25%;
        }

        .SearchBarButton {
          width: 80px;
          height: 36px;
          border-radius:20px;
          background-color:#ffffff;
          box-sizing: border-box;
          box-shadow:0px 3px 9px 0px rgba(0,0,0,0.35);
          color: #555555;
          text-decoration: none;
          display: flex;
          justify-content: center;
          align-items: center;
        }

        .trOptionButton {
          display: flex;
          justify-content: space-between;
          width: 100%;
          margin-bottom: 10px;
          cursor: pointer;
        }

        .trOptionButton-mobile {
          display: flex;
          justify-content: space-between;
          width: 100%;
          margin-bottom: 10px;
          cursor: pointer;
        }  

        .trOptionButton:hover {
          border-radius:20px;
          background-color:#ffffff;
          box-sizing: border-box;
          box-shadow:0px 3px 9px 0px rgba(0,0,0,0.35);
        }

        .tdOptionButton {
          display: flex;
          justify-content: center;
          width: 75%;
        }

        .OptionButton {
          display: flex; 
          justify-content: center; 
          align-items: center;
          text-decoration: none;
          width: 100%;
          height: 40px;
        }

        

        .OptionLabel {
          color: /*1*/#00568F/*1*/;
          font-size: 16px;
          width: 70%;
        }
      

        .tdShortcut {
          visibility: visible;
          width: 40%;
        }

        .divShortcut {
          display: flex;
          justify-content: center; 
          align-items: center;
        }

        .txtShortcut {
          color: #aaaaaa;
        }

        .tdShortcut-mobile {
            visibility: hidden;
            width: 0;
        }

        .OptionButton-mobile {
          display: flex; 
          justify-content: center; 
          align-items: center;
          text-decoration: none;
          width: 100%;
          height: 45px;
        }

        .tdOptionButton-mobile {
            width: 100%;
            background-color: #ffffff;
            box-sizing: border-box;
            box-shadow: none;
            border-radius: 35px;
            border-style: solid;
            border-width: 1px;
            border-color: rgba(215, 215, 215, 1);
        }

            .tdOptionButton-mobile:hover {
                border-radius: 20px;
                background-color: #ffffff;
                box-sizing: border-box;
                box-shadow: 0px 1px 4px 0px rgba(0, 0, 0, 0.35);
            }

        }
      

    </style>

    <script src="JS/jquery.min.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate.js" type="text/javascript"></script>
    <script type="text/javascript">

        var MobileScreenWidth = 1024;

        function isMobileScreenSize() {
            var browserWidth = $telerik.$(window.parent).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }

        function isParentMobileScreen() {
            var browserWidth = $telerik.$(window.parent).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }

        window.onload = function () {
            if (isMobileScreenSize() && $telerik.$(window.parent).width() < 704) {
                const tdShortcutElts = document.querySelectorAll('.tdShortcut');
                const tdOptionButton = document.querySelectorAll('.tdOptionButton');
                const divShortcut = document.querySelectorAll('.divShortcut');
                const trOption = document.querySelectorAll('.trOptionButton');
                divShortcut.forEach(element => {
                    element.remove();
                });
                tdShortcutElts.forEach(element => {
                    element.classList.remove('tdShortcut');
                });
                trOption.forEach(element => {
                    element.classList.remove('trOption');
                    element.classList.add('trOptionButton-mobile');
                });
                tdOptionButton.forEach(element => {
                    element.classList.remove('tdOptionButton');
                    element.classList.remove('OptionButton');
                    element.classList.add('tdOptionButton-mobile');
                    element.classList.add('OptionButton-mobile');
                });
            }
        }    
        function CloseAiAssistant() {
            self.close();
            window.parent.document.body.focus();
        }

        function GoToUserProfilePage() {
            window.parent.location.href = 'profile.aspx';
        }

        function OpenReminderPopup() {
            CloseAiAssistant();
            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen("DefineReminderPopup.aspx?IsRadMenuItem=1");
            if (isMobileScreenSize()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            return false;
        }

        function OpenUserProfilePopup(URL) {
            CloseAiAssistant();
            var browserWidth = $telerik.$(window.parent).width();
            var browserHeight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen(URL, browserWidth, browserHeight);
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            if (isMobileScreenSize()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            wnd.get_popupElement().className = wnd.get_popupElement().className + " UserProfilePopup"
            return false;
        }

        function RedirectToHomePage() {
            CloseAiAssistant();
            window.parent.location.href = 'home.aspx';
        }

        function ExitPMWeb() {
            CloseAiAssistant();
            let btnLogOut = window.parent.$('[id$=btnExit]')[0];
            btnLogOut.click();        
        }

        function OpenPopUp(popupName) {
            CloseAiAssistant();
            if (wndRecentRecords != undefined && wndRecentRecords != null) {
                wndRecentRecords.Close();
                wndRecentRecords = null;
            }
            if (popupName == "PMWebUniversity") {
                window.open("TrainingAuthService.aspx", '_blank');
            } else if (popupName == "AdvancedSearch") {
                window.parent.open("Search.aspx?ModuleId=7&PageId=223", '_self');
            }
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <div style="position: absolute; height: 100%; width: 100%">

            <div class="headerContainer">
                <div class="header">
                    <svg width="24px" height="24px" viewBox="0 0 32 32" fill="white">
                        <path d="M 16.811490428466954 31.726495726495727  L 14.91499983536268 31.72654555875376  C 14.999260799781757 31.10200060253064  
                                    15.042735042735043 30.462911513105492  15.042735042735043 29.811965811965813  C 15.042735042735043 22.153846153846153  
                                    9.025641025641026 16.136752136752136  1.3675213675213675 16.136752136752136  C 0.9988826408264756 16.136752136752136  
                                    0.634046447079418 16.150694757560853  0.27350089950376943 16.178092311782493  L 0.2735005254599723 14.454386718053474  
                                    C 0.6340461947841886 14.481783865276078  0.9988825133640735 14.495726495726496  1.3675213675213675 14.495726495726496  
                                    C 9.025641025641026 14.495726495726496  15.042735042735043 8.478632478632479  15.042735042735043 0.8205128205128205  
                                    C 15.042735042735043 0.5448135783850826  15.034936496593048 0.2712412124778777  15.019542460728267 0  
                                    L 16.706952112896204 0  C 16.69155922178389 0.2712414972856616  16.683760683760685 0.5448137218960706  
                                    16.683760683760685 0.8205128205128205  C 16.683760683760685 8.478632478632479  22.700854700854702 14.495726495726496  
                                    30.358974358974358 14.495726495726496  C 30.915200426645786 14.495726495726496  31.462769368132285 14.463983699715195  
                                    32 14.402136448361132  L 31.99999981247942 16.230303231682097  C 31.462766237041773 16.168494751253107  30.91519883634912 
                                    16.136752136752136  30.358974358974358 16.136752136752136  C 22.700854700854702 16.136752136752136  16.683760683760685 
                                    22.153846153846153  16.683760683760685 29.811965811965813  C 16.683760683760685 30.46289425730101  16.72723262184246 
                                    31.101966719523  16.811490428466954 31.726495726495727  Z "/>
                     </svg>
                    <asp:Label ID="lblTitle" runat="server" meta:Resourcekey="lblTitle" Text="PMWeb Assistant" CssClass="title"></asp:Label>
                </div>
                <div style="display: flex; justify-content: center; align-items: center;">
                    <svg viewBox="0 -960 960 960" class="CloseButton" OnClick="return CloseAiAssistant()">
                        <path d="m256-200-56-56 224-224-224-224 56-56 224 224 224-224 56 56-224 224 224 224-56 56-224-224-224 224Z"/>
                    </svg>
                </div>
            </div>

            <div style="position:relative; width: 80%; margin-left: 10%; margin-top: 7%; display: flex; justify-content: center">
             <%--    <table style="box-sizing:border-box; position: absolute; width: 100%;">
                    <tr class="trSearchBar">
                        <td class="tdSearchBar">
                          <div style="position: relative; width: 100%">
                            <asp:TextBox ID="txtAiSearch" runat="server" CssClass="AiSearchInput"></asp:TextBox>
                             <svg viewBox="0 -960 960 960" class="AiSearchIcon">
                                 <path d="M120-160v-640l760 320-760 320Zm80-120 474-200-474-200v140l240 60-240 60v140Zm0 0v-400 400Z"/>
                             </svg>
                           </div>
                        </td>
                    </tr>
                     <tr class="trSearchBarButtons">
                         <td class="tdSearchBarButton">
                            <asp:LinkButton CssClass="SearchBarButton" runat="server" ID="btnFind">
                              <asp:Label ID="lblFind" runat="server" Text="Find" meta:resourcekey="lblFind"></asp:Label>
                            </asp:LinkButton>
                        </td>
                         <td class="tdSearchBarButton">
                            <asp:LinkButton CssClass="SearchBarButton" runat="server" ID="btnGoTo">
                              <asp:Label ID="lblGoTo" runat="server" Text="Go To" meta:resourcekey="lblGoTo"></asp:Label>
                            </asp:LinkButton>
                         </td>
                         <td class="tdSearchBarButton">
                            <asp:LinkButton CssClass="SearchBarButton" runat="server" ID="btnAdd">
                              <asp:Label ID="lblAdd" runat="server" Text="Add" meta:resourcekey="lblAdd"></asp:Label>
                            </asp:LinkButton>
                         </td>
                         <td class="tdSearchBarButton">
                            <asp:LinkButton CssClass="SearchBarButton" runat="server" ID="btnPrint">
                              <asp:Label ID="lblPrint" runat="server" Text="Print" meta:resourcekey="lblPrint"></asp:Label>
                            </asp:LinkButton>
                         </td>
                     </tr>
                 </table>--%>
                <table class="tblButtons">
                     <tr class="trOptionButton" onclick="OpenRecentDocuments()">
                         <td class="tdOptionButton">
                             <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnRecentRecords">
                                 <svg viewBox="0 -960 960 960" class="OptionIcon">
                                     <path d="m612-292 56-56-148-148v-184h-80v216l172 172ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 
                                         31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 
                                         83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-400Zm0 320q133 0 226.5-93.5T800-480q0-133-93.5-226.5T480-800q-133
                                         0-226.5 93.5T160-480q0 133 93.5 226.5T480-160Z"/>
                                 </svg>
                              <asp:Label ID="lblRecentRecords" CssClass="OptionLabel" runat="server" Text="Recent Records" meta:resourcekey="lblRecentRecords"></asp:Label>
                            </asp:LinkButton> 
                         </td>
                         <td class="tdShortcut">
                             <div class="divShortcut">
                                 <p class="txtShortcut">Ctrl + Alt + R</p>
                             </div>
                         </td>
                     </tr>
                     <tr class="trOptionButton" onclick="OpenReminderPopup()">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnReminder">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M260-640h40v-40q0-17-11.5-28.5T260-720q-17 0-28.5 11.5T220-680q0 17 11.5 28.5T260-640Zm180 0q17 0 
                                        28.5-11.5T480-680q0-17-11.5-28.5T440-720q-17 0-28.5 11.5T400-680v40h40Zm62 300ZM419-80q-28 0-52.5-12T325-126L107-403l19-20q20-21 
                                        48-25t52 11l74 45v-168h-40q-50 0-85-35t-35-85q0-50 35-85t85-35q11 0 20.5 2t19.5 5v-47q0-17 11.5-28.5T340-880q17 0 29 11.5t12 
                                        28.5v56q14-8 28.5-12t30.5-4q50 0 85 35t35 85q0 50-35 85t-85 35h-59v312l-97-60 104 133q6 7 14 11t17 4h221q33 0 
                                        56.5-23.5T720-240v-160q0-17-11.5-28.5T680-440H461v-80h219q50 0 85 35t35 85v160q0 66-47 113T640-80H419Z"/>
                                </svg>
                              <asp:Label ID="lblReminder" CssClass="OptionLabel" runat="server" Text="Reminder" meta:resourcekey="lblReminder"></asp:Label>
                            </asp:LinkButton>
                         </td>
                          <td class="tdShortcut">
                             <div class="divShortcut">
                                 <p class="txtShortcut">Ctrl + Alt + E</p>
                             </div>
                         </td>
                      </tr>
                      <tr class="trOptionButton" onclick="helpClick()">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnOnlineHelp">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M478-240q21 0 35.5-14.5T528-290q0-21-14.5-35.5T478-340q-21 0-35.5 14.5T428-290q0 21 
                                        14.5 35.5T478-240Zm-36-154h74q0-33 7.5-52t42.5-52q26-26 41-49.5t15-56.5q0-56-41-86t-97-30q-57 
                                        0-92.5 30T342-618l66 26q5-18 22.5-39t53.5-21q32 0 48 17.5t16 38.5q0 20-12 37.5T506-526q-44 39-54 
                                        59t-10 73Zm38 314q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 
                                        0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 
                                        0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/>
                                </svg>
                              <asp:Label ID="lblOnlineHelp" CssClass="OptionLabel" runat="server" Text="Online Help" meta:resourcekey="lblOnlineHelp"></asp:Label>
                            </asp:LinkButton>
                         </td>
                        <td class="tdShortcut">
                            <div class="divShortcut">
                                <p class="txtShortcut">Ctrl + Alt + O</p>
                            </div>
                        </td>
                     </tr>
                     <tr class="trOptionButton" onclick="OpenPopUp('PMWebUniversity')">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnPMWebUniversity">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M480-120 200-272v-240L40-600l440-240 440 240v320h-80v-276l-80 44v240L480-120Zm0-332 274-148-274-148-274 
                                        148 274 148Zm0 241 200-108v-151L480-360 280-470v151l200 108Zm0-241Zm0 90Zm0 0Z"/>
                                </svg>
                              <asp:Label ID="lblPMWebUniversity" CssClass="OptionLabel" runat="server" Text="PMWeb University" meta:resourcekey="lblPMWebUniversity"></asp:Label>
                            </asp:LinkButton>
                         </td>
                        <td class="tdShortcut">
                            <div class="divShortcut">
                                <p class="txtShortcut">Ctrl + Alt + U</p>
                            </div>
                        </td>
                     </tr>
                     <tr class="trOptionButton" onclick="OpenPopUp('AdvancedSearch')">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnSearchPage">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M784-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 
                                        44-14 83t-38 69l252 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T380-760q-75 0-127.5 52.5T200-580q0 
                                        75 52.5 127.5T380-400Z"/>
                                </svg>
                              <asp:Label ID="lblSearchPage" CssClass="OptionLabel" runat="server" Text="Search Page" meta:resourcekey="lblSearchPage"></asp:Label>
                            </asp:LinkButton>
                         </td>
                        <td class="tdShortcut">
                            <div class="divShortcut">
                                <p class="txtShortcut">Ctrl + Alt + S</p>
                            </div>
                        </td>
                     </tr>
                     <tr class="trOptionButton" onclick="GoToUserProfilePage()">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnProfile">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-160v-112q0-34 
                                        17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 
                                        43.5T800-272v112H160Zm80-80h480v-32q0-11-5.5-20T700-306q-54-27-109-40.5T480-360q-56 0-111 13.5T260-306q-9 5-14.5 14t-5.5 20v32Zm240-320q33 
                                        0 56.5-23.5T560-640q0-33-23.5-56.5T480-720q-33 0-56.5 23.5T400-640q0 33 23.5 56.5T480-560Zm0-80Zm0 400Z"/>
                                </svg>
                              <asp:Label ID="lblProfile" CssClass="OptionLabel" runat="server" Text="Profile" meta:resourcekey="lblProfile"></asp:Label>
                            </asp:LinkButton>
                         </td>
                        <td class="tdShortcut">
                            <div class="divShortcut">
                                <p class="txtShortcut">Ctrl + Alt + P</p>
                            </div>
                        </td>
                     </tr>
                     <tr class="trOptionButton" onclick="return RedirectToHomePage()">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="btnHomePage">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M240-200h120v-240h240v240h120v-360L480-740 240-560v360Zm-80 80v-480l320-240 320 240v480H520v-240h-80v240H160Zm320-350Z"/>
                                </svg>
                              <asp:Label ID="lblHomePage" CssClass="OptionLabel" runat="server" Text="Home Page" meta:resourcekey="lblHomePage"></asp:Label>
                            </asp:LinkButton>
                         </td>
                        <td class="tdShortcut">
                            <div class="divShortcut">
                                <p class="txtShortcut">Ctrl + Alt + H</p>
                            </div>
                        </td>
                     </tr>
                       <tr class="trOptionButton" onclick="return ExitPMWeb()">
                         <td class="tdOptionButton">
                            <asp:LinkButton CssClass="OptionButton" runat="server" ID="ExitPMWeb">
                                <svg viewBox="0 -960 960 960" class="OptionIcon">
                                    <path d="M186.67-120q-27 0-46.84-19.83Q120-159.67 120-186.67v-586.66q0-27 19.83-46.84Q159.67-840 186.67-840h292.66v66.67H186.67v586.66h292.66V-120H186.67Zm470.66-176.67-47-48 102-102H360v-66.66h351l-102-102 47-48 184 184-182.67 182.66Z"/>
                                </svg>
                              <asp:Label ID="lblExit" CssClass="OptionLabel" runat="server" Text="Exit PMWeb" meta:resourcekey="lblExitPMWeb"></asp:Label>
                            </asp:LinkButton>
                         </td>
                        <td class="tdShortcut">
                            <div class="divShortcut">
                                <p class="txtShortcut">Ctrl + Alt + X</p>
                            </div>
                        </td>
                     </tr>
                </table>
               </div>
            </div>

            <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;">
            </telerik:RadWindowManager>
    </form>
</body>
</html>
