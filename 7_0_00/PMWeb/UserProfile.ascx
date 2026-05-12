<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UserProfile.ascx.vb" Inherits="Website.UserProfile1" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <style type="text/css">
        
        .RadioCss label {
            text-transform: capitalize !important;
        }
        .labelmask{
            position:absolute;
            top:8px;
            left:0;
            padding-left:3px;
            color:#666;
           
        }

        /*.ProjectCenterToolbar {
            top: 50px;
            position: fixed;
            width: 100%;
            border-bottom: 1px solid #999999;
        }
        
        .ProjectCenterToolbar > td, .ProjectCenterToolbar, .rtbOuter
        {
            background-color:white !important;
        }*/

        .documentSinglePage {
            margin-top: 0px !important;
        }

        .PMSettings {
            display: flex !important;
        }

            /*.PMSettings .col-2 {
                width: 175px !important;
            }*/

            /*.PMSettings .col-10 {
                width: calc(100% - 175px) !important;
                margin-top:50px;
            }*/

        .PMHeader .row .col-4-right {
            padding-left: 24px !important;
        }

        .PMHeader .row {
            display: flex !important;
        }

           .PMSettings{
                margin-top:140px;
            }
           .col-12{
                   padding: 10px 25px 25px;
           }

        @media screen and (min-width:1031px) and (max-width:1047px) {
            .PMMainPage .row {
                padding-left: 16px !important;
                padding-right: 16px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 16px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (min-width:1014px) and (max-width:1030px) {
            .PMMainPage .row {
                padding-left: 8px !important;
                padding-right: 8px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 8px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (max-width:1013px) {
            .VerticalTabs {
                display: none !important;
            }

            .tbshorizantaltabs {
                visibility: visible !important;
                margin-top: -20px !important;
                width: 100% !important;
                margin-top: 0px !important;
                padding-top:5px;
            }

            .PMMainPage .row .col-4-right {
                padding-left: 24px !important;
            }

            .PMSettings .col-10 {
                width: 100% !important;
            }

            .PMSettings .col-2 {
                width: 100% !important;
            }

            .PMSettings {
                display: block !important;
            }
        }

        @media screen and (min-width:848px) and (max-width:872px) {
            .PMMainPage .row {
                padding-left: 16px !important;
                padding-right: 16px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 16px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (min-width:830px) and (max-width:847px) {
            .PMMainPage .row {
                padding-right: 8px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 8px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (max-width:830px) {
            .PMMainPage .row {
                padding-right: 24px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 0px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (max-width:448px) {
            .PMMainPage .row {
                padding-left: 16px !important;
                padding-right: 16px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 0px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (max-width:432px) {
            .PMMainPage .row {
                padding-left: 8px !important;
                padding-right: 8px !important;
            }

                .PMMainPage .row .col-4-right {
                    padding-left: 0px !important;
                }

            .PMMainPage .row {
                justify-content: initial !important;
            }
        }

        @media screen and (min-width:320px) and (max-width:843px) {
            .ToolbarTd {
                position: relative;
            }

         
            iframe ::-webkit-scrollbar {
                display: none;
            }

            .tbshorizantaltabs {
                margin-top: 100px !important;
                padding-top:5px;
            }
        }
        .UserProfileTabs {
            position: fixed;
            top: 0px;
            z-index: 990;
            background-color: #fff;
            padding-top: 5px !important;
        }

        input[type=password] {
            font-family: 'Work Sans' !important;
            line-height: 20px;
            color: #000000;
            background: #FFFFFF;
            border: 1px solid #666666;
            border-radius: 0px;
            vertical-align: top;
            font-size: 12px;
        }


        .labelWidth, legend, span, label {
            /*font-size: 12px !important;*/
            font-family: 'Work Sans' !important;
        }

        .rtsLevel.rtsLevel1 {
        width: 100vw !important;
         }
         .rtsLevel.rtsLevel1 li.rtsLI {
         width: 33%;
        }
            .rowFlags{
                display:table-row !important;
            }

    </style>
    <script type="text/javascript">
        if (navigator.userAgent.toLowerCase().indexOf('firefox') > -1)
            window.event = {};
        function GoToRecord(URL) {
            window.top.location.href = URL;
        }
        function OpenWidgetPopupForWebPage(Source, Id, Width, Height) {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen('WidgetPopup.aspx?Source=' + Source + '&Id=' + Id);
            if (browserWidth < 700) {
                wnd.setSize(browserWidth - 10, Height);
            }
            else {
                wnd.setSize(650, Height);
            }
            wnd.Center();
            return false;
        }
        function OpenPDFUploadPopup(FileName, Id, Width, Height) {
            OpenSmallPOPUp('Home_AddPDFPopup.aspx?FileName=' + FileName + '&Id=' + Id, 400, Height, null, null)
            return false;
        }
        function OpenProjectCenterPopup() {
            OpenSmallPOPUp('Home_ProjectCenterPopup.aspx', 500, 400, WindowCloseReport, null)
            return false;
        }

        function OpenAddPMWebReport(Id) {
            OpenPOPUp('Home_AddPMWebReportLink.aspx?Source=Tabs&Id=' + Id, 1040, 435, null, null)
            return false;
        }

        function OpenAddBIReporting(Id) {
            OpenPOPUp('Home_AddSQLReportLink.aspx?Source=Tabs&Id=' + Id, 1040, 435, null, null)
            return false;

        }

        function OnTabSelected(sender, args) {
            if (sender.get_selectedTab().get_value() == 'Events') {
                var Grid = $('[id$=rdgHomeEvents]');
                if (Grid.length > 0)
                    ResetGridSettings(Grid[0].id);
            }
            else if (sender.get_selectedTab().get_value() == 'PageSettings') {
                var Grid = $('[id$=rdgTabs]');
                if (Grid.length > 0)
                    ResetGridSettings(Grid[0].id);
            }
            else if (sender.get_selectedTab().get_value() == 'Delegates') {
                var Grid = $('[id$=rdgDelegates]');
                if (Grid.length > 0)
                    ResetGridSettings(Grid[0].id);
                var iframe = $("[id$=iframeDelegates]")[0].contentDocument
                //var iframe = document.getElementById('ctl00_CPH1_UserProf_iframeDelegates').contentDocument
                iframe.getElementById('rdgDelegates').style.display='none'
                iframe.location.reload(true);
            }

            $find($("[id$=tbsDocument]")[0].id).set_selectedIndex(sender.get_selectedTab().get_index())
        }

        function isMobileScreen() {
            var browserWidth = $telerik.$(window.parent).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }


        function OpenControlsPopup() {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();

            WndConfigureCtrlTabs = window.radopen('Home_ControlsPopup.aspx');
            WndConfigureCtrlTabs.SetUrl('Home_ControlsPopup.aspx?PopupId=' + WndConfigureCtrlTabs.get_id());

            if (isMobileScreen()) {
                WndConfigureCtrlTabs.setSize(browserWidth - 10, browserHeight);
                WndConfigureCtrlTabs.moveTo(8, 0);
            }
            else {
                var popupwidth = browserWidth * 0.3;
                if (popupwidth < 450)
                    popupwidth = 450;
                WndConfigureCtrlTabs.setSize(popupwidth, browserHeight * 0.9);
                WndConfigureCtrlTabs.Center();
            }
            return false;
        }

        function WindowCloseReport() {
            var btnRefreshGrid = $("[id$=btnRefreshGrid]");
            btnRefreshGrid.click();

        }

        function pageLoad() {
            var AllowEditMySettings = '<%= PM.HomeInfo.AllowEditMySettings%>';
            if (AllowEditMySettings == 'False') {
                var tdEvents = document.getElementById('tdEvents');
                var tdLogout = document.getElementById('tdLogout');
                tdEvents.className = 'Hide';
                tdLogout.className = 'Hide';
                document.getElementsByClassName('rtsFirst')[0].style.width = '50%';
                document.getElementsByClassName('rtsLast')[0].style.width = '50%';
            }
            $('#UserProfile_txtOldPassword').focus(function () {
                passwordfocus('UserProfile_lbloldpasswordmask');
            });
            $('#UserProfile_txtOldPassword').blur(function () {
                passwordblur('UserProfile_lbloldpasswordmask', 'UserProfile_txtOldPassword');
            });
            $('#UserProfile_txtPassword').focus(function () {
                passwordfocus('UserProfile_lblPasswordmask');
            });
            $('#UserProfile_txtPassword').blur(function () {
                passwordblur('UserProfile_lblPasswordmask', 'UserProfile_txtPassword');
            });
            $('#UserProfile_txtConfirmPassword').focus(function () {
                passwordfocus('UserProfile_lblConfirmPasswordmask');
            });
            $('#UserProfile_txtConfirmPassword').blur(function () {
                passwordblur('UserProfile_lblConfirmPasswordmask', 'UserProfile_txtConfirmPassword');
            });
        }
        function passwordfocus(lblId) {
            var lbl = $('#' + lblId);
              if (!lbl.hasClass('Hide'))
              lbl.addClass('Hide');
        }
        function passwordblur(lblId,txtId) {
            var txt = $('#' + txtId);
            var lbl = $('#' + lblId);
            if (txt.val().length == 0)
                lbl.removeClass('Hide');
        }
        function onlblPasswordfocus(lblId, txtId) {
            var txt = $('#UserProfile_' + txtId);
            var lbl = $('#UserProfile_' + lblId);
            lbl.removeClass('Hide');
            txt.focus();
        }
        function cleanErrorMessage() {
            if ($("#ErrorMessage")[0] !== undefined) {
                if ($("#ErrorMessage")[0].innerText!="")
                $("#ErrorMessage")[0].outerText = "";
            }
        }


        var uploadsDocFileInProgress = 0;

        function onDocFileSelected(sender, args) {
            uploadsDocFileInProgress++;
        }

        function onDocFileUploaded(sender, args) {

            decrementUploadsDocFileInProgress();
            if (uploadsDocFileInProgress <= 0) {
                var btnRefreshUserImage = $("[id$=btnRefreshUserImage]");
                btnRefreshUserImage.click();
                setTimeout(function () {
                    sender.deleteAllFileInputs();
                }, 10);
            }
        }

        function onDocFileUploadFailed(sender, args) {
            decrementUploadsDocFileInProgress();
        }

        function decrementUploadsDocFileInProgress() {
            uploadsDocFileInProgress--;
        }

        function ClientDocFileValidationFailed(sender, args) {
            decrementUploadsDocFileInProgress();
            alert(WarningMsg_InvalidFile);
        }
        function showLanguages() {
            var language = $('.language');
            language[0].className = language[0].className.replace(' Hide', '')
            return false;
        }
        function RadwindowClosed(sender, args) {
            var tblparams = sender._navigateUrl.split('PopupId=')
            if (tblparams.length == 1) {
                WindowCloseReport();
                return;
            }
            var PopupId = tblparams[tblparams.length - 1];
            var mainWindow = window.document.getElementById('RadWindowWrapper_' + PopupId);
            mainWindow.className = mainWindow.className.replace(' Hide');
        }

        function click_handler_UserProfile(sender, args) {
            var browserWidth = document.documentElement.clientWidth;
            var browserHeight = document.documentElement.clientHeight;
            if (args.get_item().get_commandName() == 'CreateReminder') {
                return OpenPOPUp('DefineReminderPopup.aspx?IsRadMenuItem=1', browserWidth * 0.9, browserHeight * 0.9);
            } else {
                if (args.get_item().get_commandName() == 'Close') {
                    CloseUserProfilePopup();
                } 
            }
        }
        function RadAsyncUploadclcik() {

            var imageuploader = $('.ruFileInput');
            imageuploader.click();
            return false;
        }

        $(document).ready(function () {
            $('body').click(function (e) {
                //debugger;
                var q = e.target;
                var targetid = e.target.id
                if (targetid.indexOf('imgSelectedlanguage') >= 0 || targetid.indexOf('rptLanguages') >= 0)
                    return;
                var language = $('.language');
                if (language[0].className.indexOf('Hide') >= 0)
                    return;
                language[0].className = language[0].className + ' Hide';
            })
        })

        function onTabSelecting(sender, args) {
            if (args.get_tab().get_pageViewID()) {
                args.get_tab().set_postBack(false);
            }
            if (args.get_tab().get_value() == 'Attachments') {
                sender.EnableAjax = false;
            }
            
        }

        function CloseUserProfilePopup() {
            window.CloseRadWnd();
            window.parent.location = window.parent.location;
        }

    </script>
</telerik:RadCodeBlock>

<telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
    ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" OnClientClose="RadwindowClosed"
    IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
    Top="">
</telerik:RadWindowManager>
<telerik:RadAjaxManagerProxy ID="PMAjaxManager" runat="server">
    <AjaxSettings>
  <%--      <telerik:AjaxSetting AjaxControlID="ddlSummarizeEvery">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="lblSummaryDay" />
                <telerik:AjaxUpdatedControl ControlID="ddlSummarizeEvery" />
                <telerik:AjaxUpdatedControl ControlID="ddlSummaryDay" />
            </UpdatedControls>
        </telerik:AjaxSetting>--%>
        <telerik:AjaxSetting AjaxControlID="btnRefreshUserImage">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnRefreshUserImage" />
                <telerik:AjaxUpdatedControl ControlID="imgUserImage" />
                <telerik:AjaxUpdatedControl ControlID="btnClearImage" />
            </UpdatedControls>
        </telerik:AjaxSetting>

              <telerik:AjaxSetting AjaxControlID="btnClearImage">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="imgUserImage" />
                <telerik:AjaxUpdatedControl ControlID="btnClearImage" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="CloseUserProfilePopup()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
<table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar NewStylePopupToolbar">
    <tr valign="top">
        <td valign="top">
            <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" OnClientButtonClicked="click_handler_UserProfile" AutoPostBack="true" Width="100%" Skin="Default" CssClass="toolbar">
                            <Items>
                                <telerik:RadToolBarButton ValidationGroup="Users"  CssClass="ToolbarSave" CommandName="Save" EnableImageSprite="true"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Users"
                                CommandName="SaveAndExit" AccessKey="s" Value="SaveAndExit" Style="margin-right: -8px !important;">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" ValidationGroup="Users" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton ValidationGroup="Users" CommandName="CreateReminder" EnableImageSprite="true" CssClass="ToolbarCreateReminder" PostBack="false"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>


<div class="PMSettings">
    <div class="col-2">
        <%--<telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument"  SelectedIndex="0" runat="server" 
            MultiPageID="mlpUserProfile" Skin="Default" EnableViewState="True" CausesValidation="False" CssClass="VerticalTabs tbsDocSpec" Orientation="HorizontalTop" Align="Center" OnClientTabSelected="OnTabSelected">
            <Tabs>
                <telerik:RadTab Value="Settings" Text="User Settings" Selected="True" />
                <telerik:RadTab Value="PageSettings" Text="Home Page Settings" />
                <telerik:RadTab meta:resourcekey="tab_Delegate" Value="Delegates" Text="Delegate1" PostBack="true" />
            </Tabs>
        </telerik:RadTabStrip>--%>

        <telerik:RadTabStrip ID="tbsDocument" OnClientTabSelecting="onTabSelecting" SelectedIndex="0"
            runat="server" MultiPageID="mlpUserProfile" Skin="Default" ScrollButtonsPosition="Left" CssClass="UserProfileTabs TitleToolbarTop" OnClientTabSelected="OnTabSelected" Orientation="HorizontalTop" Align="Center"
            EnableViewState="True" ScrollChildren="true" CausesValidation="False">
            <Tabs>
                <telerik:RadTab Value="Settings" Text="User Settings" Selected="True" />
                <telerik:RadTab Value="PageSettings" Text="Home Page Settings" />
                <telerik:RadTab meta:resourcekey="tab_Delegate" Value="Delegates" Text="Delegate1" PostBack="true" />
            </Tabs>
        </telerik:RadTabStrip>
    </div>
    <div class="col-10" style="flex:auto">
        <telerik:RadMultiPage ID="mlpUserProfile" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPagesUserProfile">
            <telerik:RadPageView ID="pvSettings" runat="server" Selected="True">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend>PROFILE</legend>
                                            <table class="colTable">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLastLogin" meta:resourceKey="lblLastLogin" runat="server" Text="Last Login"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <span id="Span1" runat="server"><%= FormatDatewithoutTime(PM.UserInfo.LastLoginDate) + " " + FormatTime(PM.UserInfo.LastLoginDate) %></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="First Name*" ID="lblFirstName" meta:resourceKey="lblFirstName" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtFirstName" MaxLength="50" runat="server"></asp:TextBox>
                                                        <div>
                                                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                                                                ValidationGroup="Users" CssClass="Validator" meta:resourcekey="rfvFirstName"
                                                                ErrorMessage="Enter the First Name" Display="Dynamic"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="Last Name" ID="lblLastName" meta:resourceKey="lblLastName" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtLastName" MaxLength="50" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="Email*" ID="lblEmail" runat="server" meta:resourceKey="lblEmail"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                                        <div>
                                                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                                                ValidationGroup="Users" CssClass="Validator" ErrorMessage="Enter the Email" Display="Dynamic"
                                                                meta:resourcekey="rfvEmail"></asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                                                CssClass="Validator" ErrorMessage="Not valid email" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                ValidationGroup="Users" Display="Dynamic" meta:resourcekey="revEmail"></asp:RegularExpressionValidator>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="Cell" ID="lblCell" meta:resourceKey="lblCell" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtCell" MaxLength="50" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">


                                                        <telerik:RadAsyncUpload runat="server" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed" Style="display:none;"
                                                            OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" CssClass="UserProfileUpload"
                                                            MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true" Width="80px">
                                                            <Localization Select="Select" />
                                                        </telerik:RadAsyncUpload>
                                                        <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />

                                                        <div style="float:left">
                                                            <asp:Label runat="server" ID="lblImage" Text="Image"></asp:Label>
                                                        </div>
                                                        <div style="float: right">
                                                            <asp:LinkButton runat="server" ID="btnuserimage" CssClass="SearchButton" OnClientClick="return RadAsyncUploadclcik()">
    					                                                    <span class="Icon"></span>                                                              
                                                            </asp:LinkButton>


                                                        </div>
                                                        <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right">
                                                            <asp:Button ID="btnClearImage" runat="server" CssClass="btnclearimage" Style="background-color: transparent !important;margin-left: 33px !important;" />
                                                        </div>
                                                    </td>

                                                    <td class="controlWidth">
                                                       <asp:Image ID="imgUserImage" runat="server" />

                                                    </td>
                                                </tr>

                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend>LOGIN</legend>
                                            <table class="colTable">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="Old Password" ID="lblOldPassword" runat="server" meta:resourcekey="lblOldPassword"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth" style="position:relative">
                                                        <asp:TextBox ID="txtOldPassword" MaxLength="128" runat="server" Width="100%" TextMode="Password" onkeypress="cleanErrorMessage();"></asp:TextBox>
                                                        <asp:Label runat="server" ID="lbloldpasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lbloldpasswordmask','txtOldPassword')"></asp:Label>
                                                          </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="Password" ID="lblPassword" meta:resourcekey="lblPassword" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth" style="position:relative">
                                                        <asp:TextBox ID="txtPassword" MaxLength="128" runat="server" Width="100%" TextMode="Password" onkeypress="cleanErrorMessage();"></asp:TextBox>
                                                    <asp:Label runat="server" ID="lblPasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lblPasswordmask','txtPassword')"></asp:Label>
                                                         </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label Text="Confirm Password" ID="lblConfirmPassword" meta:resourcekey="lblConfirmPassword" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth" style="position:relative">
                                                        <asp:TextBox ID="txtConfirmPassword" MaxLength="128" Width="100%" runat="server" TextMode="Password"
                                                            onkeypress="cleanErrorMessage();"></asp:TextBox>
                                                         <asp:Label runat="server" ID="lblConfirmPasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lblConfirmPasswordmask','txtConfirmPassword')"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="ErrorMessage" style="height: 5px;">
                                                <asp:Label Text="Invalid Password." CssClass="Validator" meta:resourcekey="lblInvalidPwd" ID="lblInvalidPwd" Visible="false" runat="server"></asp:Label>
                                                <asp:Label Text="Enter New Password." meta:resourcekey="lblEnterNewPassword" CssClass="Validator" ID="lblEnterNewPassword" Visible="false" runat="server"></asp:Label>
                                                <asp:Label Text="New Password Not Confirmed." CssClass="Validator" meta:resourcekey="lblNewPwdNotConfirmed" ID="lblNewPwdNotConfirmed" Visible="false" runat="server"></asp:Label>
                                                <asp:Label ID="lblPasswordError" CssClass="Validator" Visible="false" runat="server"></asp:Label>
                                            </div>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tdLogout">
                                        <fieldset>
                                            <legend>LOGOUT</legend>
                                            <table class="colTable">
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server" style="color: #666666" Text="" meta:Resourcekey="lblLogoutInfo" ID="lblLogoutInformation"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 130px">
                                                        <asp:RadioButtonList ID="rblFrequency" AutoPostBack="false" runat="server" CssClass="labelColor RadioCss RadioPadding" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                                            <asp:ListItem meta:resourcekey="rblFrequency_SaveCookie" Text="" Value="SaveCookie"> </asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="rblFrequency_DeleteCookie" Text="" Value="DeleteCookie"></asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="rblFrequency_PromptMe" Text="Prompt Me" Value="Prompt"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td>
                                        <fieldset>
                                            <legend>OPTIONS</legend>
                                            <table class="colTable">

                                                <tr>
                                                    <td class="labelWidth" style="width: 90% !important">
                                                        <asp:Label ID="lblLanguage" runat="server" OnClientClick="return showLanguages();"></asp:Label>
                                                    </td>
                                                    <td style="text-align: right; width: 50px;">
                                                        <asp:ImageButton ID="imgSelectedlanguage" Height="13px" Width="30px"
                                                            OnClientClick="return showLanguages();" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr style="height: 26px;" class="rowFlags">
                                                    <td class="languageFlags" style="position: relative;" colspan="2">
                                                        <div class="language Hide" style="position: absolute; background-color: white; border: 1px solid gray; right: 0; z-index: 999;">
                                                            <asp:Repeater ID="rptLanguages" runat="server" Visible="true">
                                                                <ItemTemplate>
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td>
                                                                                <div style="float: left">
                                                                                    <asp:Label ID="lblLanguageDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'></asp:Label>
                                                                                </div>
                                                                                <div style="float: right">
                                                                                    <asp:ImageButton ID="ImageButton2" Style="padding: -15px" Height="13px" Width="30px" OnClientClick="return CheckDirt2();"
                                                                                        ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description") %>' runat="server"
                                                                                        CausesValidation="false" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath") %>'
                                                                                        AlternateText='<%# DataBinder.Eval(Container.DataItem, "Description") %>' CommandName="LanguageClicked"
                                                                                        CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Code") %>' />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <%-- <asp:ImageButton ID="ImageButton1" Style="padding: -15px" Height="13px" Width="30px" OnClientClick="return CheckDirt2();"
                                                                            ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description") %>' runat="server"
                                                                            CausesValidation="false" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath") %>'
                                                                            AlternateText='<%# DataBinder.Eval(Container.DataItem, "Description") %>' CommandName="LanguageClicked"
                                                                            CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Code") %>' />--%>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelColor" style="width: 90% !important">
                                                        <asp:Label ID="lblPromptToSave" runat="server" Text="Prompt To Save" meta:resourcekey="chkPromptToSaveNav"></asp:Label>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <label class="switch">
                                                            <input id="chkPromptToSave" runat="server" type="checkbox" />
                                                            <span class="slider round"></span>
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelColor" style="width: 90% !important">
                                                        <asp:Label ID="lblOpenWithMenuCollapsed" runat="server" Text="Open With Menu Collapsed" meta:resourcekey="chkOpenWithMenuCollapse"></asp:Label>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <label class="switch">
                                                            <input id="chkOpenWithMenuCollapsed" runat="server" type="checkbox" />
                                                            <span class="slider round"></span>
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelColor" style="width: 90% !important">
                                                        <asp:Label ID="lblAdvancedGridFiltering" runat="server" Text="Advanced Grid Filters" meta:resourcekey="chkAdvancedGridFilters"></asp:Label>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <label class="switch">
                                                            <input id="chkAdvancedGridFiltering" runat="server" type="checkbox" />
                                                            <span class="slider round"></span>
                                                        </label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                

                            </table>
                        </div>
                         <div class="col-4 col-4-right">
                            <table class="TableNoSpacingNoBorder">
                        <tr>
                                    <td style=" padding-bottom: 5px;" id="tdEvents">
                                        <fieldset>
                                            <legend>Events</legend>
                                            <telerik:RadGrid ID="rdgEvents" runat="server"
                                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True"
                                                AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="False" AllowPaging="False">
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace" Width="100%">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Trigger" UniqueName="Trigger" HeaderStyle-Width="100px">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("Trigger") = String.Empty, "&nbsp;", Container.DataItem("Trigger"))%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Summaries Only" UniqueName="Summaries" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chbSummaries" AutoPostBack="false"
                                                                    Checked='<%# CBool(IIf(Eval("Summaries") Is System.DBNull.Value, 0, Eval("Summaries")))%>'
                                                                    runat="server" class="mobile-switch" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" ID="lblSummarizeEvery" Text="Summarize Every" meta:Resourcekey="lblSummarizeEvery"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlSummarizeEvery" runat="server" AutoPostBack="true" CausesValidation="False"
                                                        CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Day" Value="Day" meta:resourcekey="ItemValue_Day" />
                                                            <telerik:RadComboBoxItem Text="Week" Value="Week" meta:resourcekey="ItemValue_Weeks" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label runat="server" ID="lblSummaryDay" Text="Summary Day" meta:Resourcekey="lblSummaryDay"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlSummaryDay" runat="server" AutoPostBack="False" CausesValidation="False"
                                                        CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Monday" Value="Monday" meta:resourcekey="ItemValue_Monday" />
                                                            <telerik:RadComboBoxItem Text="Tuesday" Value="Tuesday" meta:resourcekey="ItemValue_Tuesday" />
                                                            <telerik:RadComboBoxItem Text="Wednesday" Value="Wednesday" meta:resourcekey="ItemValue_Wednesday" />
                                                            <telerik:RadComboBoxItem Text="Thursday" Value="Thursday" meta:resourcekey="ItemValue_Thursday" />
                                                            <telerik:RadComboBoxItem Text="Friday" Value="Friday" meta:resourcekey="ItemValue_Friday" />
                                                            <telerik:RadComboBoxItem Text="Saturday" Value="Saturday" meta:resourcekey="ItemValue_Saturday" />
                                                            <telerik:RadComboBoxItem Text="Sunday" Value="Sunday" meta:resourcekey="ItemValue_Sunday" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                </table>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvHomePageSettings" runat="server">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadAjaxPanel runat="server" ID="pnlajax" LoadingPanelID="ldpPM">
                                <telerik:RadGrid ID="rdgTabs" AllowMultiRowSelection="true" runat="server" SetWidth="true" AppendMenus="true" PageSize="250" FitPageHeightOffset="34"
                                    HeaderStyle-Font-Size="8" Height="99%" AutoGenerateColumns="False" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true"
                                    AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="false" AllowPaging="True">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        Width="100%" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Show" UniqueName="visible"
                                                ItemStyle-Wrap="false"
                                                SortExpression="visible" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" runat="server" class="mobile-switch" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chbvisible" Checked='<%# CBool(IIf(Eval("visible") Is System.DBNull.Value, 0, Eval("visible")))%>' runat="server" class="mobile-switch" />
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Order" UniqueName="TabNumber" HeaderStyle-Wrap="false" SortExpression="TabNumber"
                                                Groupable="false" Reorderable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <span><%#Container.DataItem("TabNumber").ToString%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%#Eval("TabNumber").ToString%>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Tab Label*" UniqueName="TabName" HeaderStyle-Width="200px"
                                                SortExpression="TabName">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtShowTabName" MaxLength="500" Width="100%" runat="server" Text=' <%#Container.DataItem("TabName")%>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTabName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TabName") %>'>
                                                    </asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvTabName" ControlToValidate="txtTabName"
                                                        ValidationGroup="Users" runat="server" ForeColor="" CssClass="Validator" Display="Dynamic"
                                                        ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                                    </asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="false" Width="200px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Tab Type" UniqueName="TabType" HeaderStyle-Width="200px"
                                                SortExpression="TabType">
                                                <ItemTemplate>
                                                    <telerik:RadComboBox ID="ddlTabType" AutoPostBack="true" OnSelectedIndexChanged="ddlTabType_OnSelectedIndexChanged" Width="100%" runat="server" Style="white-space: nowrap">
                                                        <Items>
                                                                    <telerik:RadComboBoxItem Text="PDF" Value="PDF" />
                                                        <telerik:RadComboBoxItem Text="BI Report" Value="BIReport" Selected="True" />
                                                        <telerik:RadComboBoxItem Text="PMWeb Report" Value="PMWebReport" />
                                                        <telerik:RadComboBoxItem Text="Web Page" Value="WebPage" />
                                                        </Items>
                                                    
                                                    </telerik:RadComboBox>

                                                    <asp:Label runat="server" ID="lblTabType" Text='<%#Container.DataItem("TabType")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%#Eval("TabType").ToString%>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="false" Width="200px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Configure" UniqueName="Configure"
                                                SortExpression="Configure">
                                                <ItemTemplate>
                                                    <div style="width: 24px; float: left; margin-right: 24px;">
                                                        <asp:LinkButton runat="server" ID="imgConfigure" class="SearchButton"
                                                            CssClass="SearchButton">
                                                                            <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <asp:Label runat="server" ID="lblConfigured"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Wrap="false" Width="370px" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <FooterStyle CssClass="GridFooter" />
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" SecurityButtonType="ItemMode_Delete"
                                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgTabs.EditIndexes.Count = 0 And (Not rdgTabs.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnRefreshResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1">
                                                    </asp:Label>
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="false"
                                        Resizing-AllowColumnResize="False">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                        <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                    </ClientSettings>
                                    <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                                </telerik:RadGrid>
                                <asp:Button runat="server" CssClass="Hide" ID="btnRefreshGrid" />

                            </telerik:RadAjaxPanel>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>


            <telerik:RadPageView ID="pvDelegates"  runat="server" Width="100%">
                <iframe runat="server" src="WorkflowDelegateReplaceUserPopup.aspx?FromSettings=true" id="iframeDelegates" frameborder="0" width="100%"
                    style="background-image: none !important; border: 0px; height: 600px"></iframe>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
</div>
</div>

<%--<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <table style="width: 100%;">
                <tr>
                    <td style="vertical-align: top; width: 185px">

     
                    </td>
                    <td class="MobileRow">
                      
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>--%>
