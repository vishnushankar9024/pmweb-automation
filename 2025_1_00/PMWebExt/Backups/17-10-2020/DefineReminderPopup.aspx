<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DefineReminderPopup.aspx.vb" Inherits="Website.DefineReminderPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Define Reminder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style>
        .ContactBox span {
            white-space: normal !important;
        }

        .LockButton .Icon, .smalllock, .UnlockButton .Icon {
            margin-right: 14px;
            margin-top: 4px;
        }

        .rwReminder {
            z-index: 12000 !important;
        }
    </style>
    <script type="text/javascript">
        function CreateReminder() {
            var btnHiddenButton = $("[id$=btnCreateReminder]");
            var txtCreateReminder = $("[id$=txtCreateReminder]")[0];
            txtCreateReminder.value = CPInt(txtCreateReminder.value);
            btnHiddenButton.click();
        }
        document.onload = function () {
            DisableValidator();
        }

        function DisableValidator() {
            var validator = document.querySelector("#ctl00_CPH1_rfvProjects");
            ValidatorEnable(validator, false);
        }


        function RemoveContactBox(argId) {
            var hfdeletedContact = $("[id$=hfdeletedContact]")[0];
            hfdeletedContact.value = argId;
            var btnRemoveContact = $("[id$=btnRemoveContact]");
            btnRemoveContact.click();
        }
        function OpenReminderMultipleCompanyFilterPopup(txtContact, txtEmail, txtIds, Type, Source) {
            var left = (screen.width - 920) / 2;
            var top = (screen.height - 300) / 2;
            var Bidder = 0;
            if (querySt("ObjectTypeId") == '94') {
                Bidder = 1;
            }
            var ProjectId = 0;
            if ($("div[id*=ddlProject]").length > 0) {
                ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
                if (ProjectId == '')
                    ProjectId = 0;
            }
            if (querySt("ObjectTypeId") == '134') {
                ProjectId = 0;
            }
            var MobileScreenWidth = 1024;
            function isMobileScreen() {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= MobileScreenWidth)
                    return true;
                return false;
            }
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.parent.radopen('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source + '&ProjectId=' + ProjectId, '');
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwReminder");
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(browserWidth + 25, browserHeight + 38);
                wnd.Center();
            }
            return false;
        }
        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }
        function AddContacts() {
            var btnAddContacts = $("[id$=btnAddContacts]");
            btnAddContacts.click();

        }
        function AddUsers() {
            var btnAddContacts = $("[id$=btnAddUsers]");
            btnAddContacts.click();
        }
        function RemoveUserBox(argId) {
            var hfdeletedUser = $("[id$=hfdeletedUser]")[0];
            hfdeletedUser.value = argId;
            var btnRemoveUsers = $("[id$=btnRemoveUsers]");
            btnRemoveUsers.click();

        }
        function OpenSelectUserPopup() {
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var Bidder = 0;
            if (querySt("ObjectTypeId") == '94') {
                Bidder = 1;
            }

            var wnd = window.parent.radopen('SelectUserPopup.aspx?&Bidder=' + Bidder + '&Source=Reminder', '');
            var divWindow = wnd._popupElement;
            divWindow.classList.add("rwReminder");
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight - 10);
                wnd.moveTo(8, 0);
            }
            else {
                wnd.setSize(browserWidth + 25, browserHeight + 50);
                wnd.Center();
            }
            return false;
        }
        function OpenReminderExecutedPopup() {
            OpenPOPUp("ReminderExecutedPopup.aspx", 400, 150, false);
            return false;
        }
        function OpenReminderExecutedPopupWithouSave() {
            OpenPOPUp("ReminderExecutedPopup.aspx?DefineReminder=1", 400, 150, false);
            return false;
        }
        function clickOnToolbar(sender, args) {
            var comandName = args.get_item().get_commandName();
            if (comandName == "SaveAndExit") {
                var btnCheckReminderDate = $("[id$=btnCheckReminderDate]");
                var hdnSaveAndExit = $("[id$=hdnSaveAndExit]");
                hdnSaveAndExit.val(1);
                btnCheckReminderDate.click();
                
            }
            else if (comandName == "Save") {
                var btnCheckReminderDate = $("[id$=btnCheckReminderDate]");
                var hdnSaveAndExit = $("[id$=hdnSaveAndExit]");
                hdnSaveAndExit.val(0);
                btnCheckReminderDate.click();
            }
            else if (comandName == "Cancel")
                window.close();
        }
        function SaveReminder() {
            var btnSave = $("[id$=btnSave]");
            btnSave.click();

        }
        function CloseWindow() {
           
            window.close();
         
        }

        function ActivateDatePicker() {
            var params = new URLSearchParams(window.location.search)
            var senderId = '';
            if (params.has('senderId')) {
                senderId = params.get('senderId');
                var datePicker = window.parent.document.querySelector("#" + senderId);
                datePicker.classList.add("ActivatedDate");

            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnAddContacts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="dvContact" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnAddUsers">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="dvUser" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>
        <script type="text/javascript">
            var UserPos;
            var ContPos;

            function ResponseEnd(sender, eventArgs) {

                document.getElementById("dvUser").scrollTop = UserPos;
                document.getElementById("dvContact").scrollTop = ContPos;

            }
            function RequestStart(sender, eventArgs) {
                UserPos = document.getElementById("dvUser").scrollTop;
                ContPos = document.getElementById("dvContact").scrollTop;

            }
        </script>
        <telerik:RadFileExplorer ID="RadFileExplorer1" runat="server" CssClass="Hide"></telerik:RadFileExplorer>
        <%--     <style type="text/css">
html body .RadInput_Office2007 .riDisabled, html body .RadInput_Disabled_Office2007 {
border-color: #CCDBED;
color: #333;
cursor: default;
}
.RadComboBox_Outlook .rcbDisabled .rcbInputCell .rcbInput, .RadComboBoxDropDown_Outlook .rcbDisabled {
color: #333;
}
    </style>--%>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="clickOnToolbar" runat="server" Skin="Default" AutoPostBack="true"
                        Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" PostBack="false">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" PostBack="false">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Delete" EnableImageSprite="true" CssClass="ToolbarDelete">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" ClientEvents-OnResponseEnd="ResponseEnd" ClientEvents-OnRequestStart="RequestStart">
            <div class="PMMainPage documentSinglePage PMPopupMainPage" style="margin-bottom: 24px !important">
                <div class="row">
                    <div class="col-4 col-4-left">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblLinkedTo" runat="server" Text="Linked To" meta:resourcekey="lblLinkedTo">
                                </asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program" meta:resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true"
                                            Width="100%" Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                            EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px"
                                            meta:Resourcekey="ddlProjects" NoWrap="true" Skin="Default" Width="100%"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLocation">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocations" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" EmptyMessage="Select a Location..." Height="300px"
                                            meta:Resourcekey="ddlLocations" NoWrap="true" Skin="Default" Width="100%"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordType" runat="server" Text="Record Type" meta:resourcekey="lblRecordType">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRecordTypes" runat="server" AllowCustomText="true" CausesValidation="False"
                                            CloseDropDownOnBlur="true" Height="300px" Filter="Contains" Skin="Default"
                                            meta:Resourcekey="ddlLocations" Width="100%">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trField">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblField" runat="server" Text="Field" meta:resourcekey="lblField"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtField" runat="server" Enabled="false">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trRecord">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecord" runat="server" Text="Record" meta:resourcekey="lblRecord">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecord" runat="server" Enabled="false">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLine" visible="false">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLine" runat="server" Text="Line" meta:resourcekey="lblLine">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLine" runat="server" Enabled="false">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-middle">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblReminder" runat="server" Text="Reminder" meta:resourcekey="lblReminder">
                                </asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr id="trReferenceDate" runat="server">
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblReferenceDate" runat="server" Text="Reference Date" meta:resourcekey="lblReferenceDate">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReferenceDate" runat="server" Width="100%" Enabled="false" Style="text-align: right;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trCreateReminder" runat="server">
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblCreateReminder" runat="server" Text="Create reminder" meta:resourcekey="lblCreateReminder">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtCreateReminder" MaxLength="4" runat="server" onChange="CreateReminder();" CssClass="PositiveInteger" Width="95%">
                                                    </asp:TextBox>
                                                </td>
                                                <td style="padding-left: 10px;">
                                                    <telerik:RadComboBox ID="ddlTimeSystem" runat="server" AutoPostBack="true" CausesValidation="False"
                                                        CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Days" Value="Days" meta:resourcekey="ItemValue_Days" />
                                                            <telerik:RadComboBoxItem Text="Months" Value="Months" meta:resourcekey="ItemValue_Months" />
                                                            <telerik:RadComboBoxItem Text="Weeks" Value="Weeks" meta:resourcekey="ItemValue_Weeks" />
                                                            <telerik:RadComboBoxItem Text="Years" Value="Years" meta:resourcekey="ItemValue_Years" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="padding-left: 10px;">
                                                    <telerik:RadComboBox ID="ddlAfterBefore" runat="server" AutoPostBack="true" CausesValidation="False"
                                                        CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="After" Value="After" meta:resourcekey="ItemValue_After" />
                                                            <telerik:RadComboBoxItem Text="Before" Value="Before" meta:resourcekey="ItemValue_Before" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <div style="float: left; width: 128px;">
                                            <asp:Label ID="lblReminderDate" runat="server" Text="Reminder Date" meta:resourcekey="lblReminderDate">
                                            </asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnLocked" CssClass="LockButton" Style="cursor: pointer;">
                                                                             <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpReminderDate" Visible="true" AutoPostBack="true" runat="server"
                                            MinDate="1900-01-01" MaxDate="2200-01-01" Width="100%" Skin="Default" EnableTyping="True">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                Skin="Default">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput2" Skin="Default" runat="server">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:Label runat="server" ID="lblWarningMsg" CssClass="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime" runat="server" Text="Time" meta:resourcekey="lblTime"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpTime" runat="server" AutoPostBack="true" EnableTyping="True" MaxDate="2100-01-01"
                                            MinDate="1901-01-01" SelectedDate="<%# Date.Today %>" Skin="Default" Width="100%">
                                            <DateInput ID="DateInput6" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar1" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left; width: 128px;">
                                            <asp:Label ID="lblRemindusers" runat="server" Text="Remind user(s)" meta:resourcekey="lblReminduser"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgbtnfilterUsers"
                                                OnClientClick="return OpenSelectUserPopup()"
                                                CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div style="width: 100%; height: 70px; max-height: 70px; overflow: auto; padding-right: 2px; box-sizing: border-box;"
                                            class="AllLightBlueBorder scroll-pane" id="dvUser">
                                            <span id="spnToUser" runat="server" style="white-space: nowrap;"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left; width: 128px;">
                                            <asp:Label ID="lblRemindContacts" runat="server" Text="Remind Contact(s)" meta:resourcekey="lblRemindContacts"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgbtnfilterContacts"
                                                OnClientClick="return OpenReminderMultipleCompanyFilterPopup(this.id.replace('imgbtnfilterContacts','spnToContacts'),this.id.replace('imgbtnfilterContacts','spnToContacts'),this.id.replace('imgbtnfilterContacts','NotExistIds'),'Contacts','Reminder')"
                                                CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div style="width: 100%; height: 70px; max-height: 70px; overflow: auto; padding-right: 2px; box-sizing: border-box;"
                                            class="AllLightBlueBorder scroll-pane" id="dvContact">
                                            <span id="spnToContacts" runat="server" style="white-space: nowrap;"></span>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">

                        <fieldset>
                            <legend>
                                <asp:Label ID="lblMessage" runat="server" Text="Event(s)" meta:resourcekey="lblEvents">
                                </asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:CheckBox ID="chkEmail" Text=" Email" runat="server" meta:resourcekey="chkEmail" />
                                    </td>
                                    <td rowspan="3" class="controlWidth">
                                        <asp:TextBox ID="txtNotes" runat="server" MaxLength="500" TextMode="MultiLine" class="AllLightBlueBorder scroll-pane" Height="82px">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:CheckBox ID="chkSMS" Text=" Text(SMS)" runat="server" Visible="false" meta:resourcekey="chkTextSMS" />
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:CheckBox ID="chkOnScreenMessage" Text=" OnScreen Message" runat="server" meta:resourcekey="chkOnScreenMessages" />
                                    </td>
                                </tr>
                            </table>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblSubject" runat="server" Text="Subject" meta:resourcekey="lblSubject">
                                        </asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtSubject" runat="server">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblSystemId" runat="server" Text="System ID" meta:resourcekey="lblSystemId">
                                        </asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtSystemId" CssClass="PositiveInteger" runat="server" Enabled="false">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                        <asp:Button runat="server" ID="btnCreateReminder" CssClass="Hide" />
                        <asp:Button runat="server" ID="btnRemoveContact" CssClass="Hide" />
                        <asp:HiddenField ID="hfdeletedContact" runat="server" Value="0" />
                        <asp:Button runat="server" ID="btnAddContacts" CssClass="Hide" />
                        <asp:HiddenField ID="hfdeletedUser" runat="server" Value="0" />
                        <asp:Button runat="server" ID="btnAddUsers" CssClass="Hide" />
                        <asp:Button runat="server" ID="btnRemoveUsers" CssClass="Hide" />
                        <asp:Button ID="btnCheckReminderDate" runat="server" CssClass="Hide"
                            Text="" />

                    </div>
                </div>
            </div>
        </telerik:RadAjaxPanel>

        <asp:Button ID="btnSave" runat="server" CssClass="Hide"
            Text="" />
        <asp:HiddenField ID="hdnLbl" runat="server" Value="0" />
        <asp:HiddenField ID="hdnSaveAndExit" runat="server" Value="0" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" Behaviors="Close,Move"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
