<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DefineSubscription.aspx.vb" Inherits="Website.DefineSubscription" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Define Subscription</title>
    <script type="text/javascript">


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
            var ProjectId = 0;
            if ($("div[id*=ddlProject]").length > 0) {
                ProjectId = $find($("div[id*=ddlProject]")[0].id).get_value();
                if (ProjectId == '')
                    ProjectId = 0;
            }
            var win = OpenPOPUpNewStyle('CompaniesFilterPopup.aspx?txtContact=' + txtContact + '&Bidder=' + Bidder + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&ddlType=Multiple&Source=' + Source + '&ProjectId=' + ProjectId, '',
               'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
            return false;
        }


        function AddContacts() {
            var btnAddContacts = $("[id$=btnAddContacts]");
            btnAddContacts.click();

        }
        function AddUsers() {
            var btnAddUsers = $("[id$=btnAddUsers]");
            btnAddUsers.click();
        }
        function RemoveUserBox(argId) {
            var hfdeletedUser = $("[id$=hfdeletedUser]")[0];
            hfdeletedUser.value = argId;
            var btnRemoveUsers = $("[id$=btnRemoveUsers]");
            btnRemoveUsers.click();

        }
        function OpenSelectUserPopup() {
            var left = (screen.width - 568) / 2;
            var top = (screen.height - 300) / 2;
            var Bidder = 0;
            var win = OpenPOPUpNewStyle('SelectUserPopup.aspx?&Bidder=' + Bidder + '&Source=Subscription', '',
               'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1200,height=360,top=' + top + ',left=' + left);
            return false;
        }

        function clickOnToolbar(sender, args) {
            var comandName = args.get_item().get_commandName();
            if (comandName == "Save") {
                var btnCheckhasChilds = $("[id$=btnCheckhasChilds]");
                btnCheckhasChilds.click();
            }
        }
        function SaveSubscription() {
            var btnSave = $("[id$=btnSave]");
            btnSave.click();

        }
        function OpenOverridePopup() {
            //OpenPOPUp("ConfirmSubscriptionOverride.aspx", 400, 220, false);
            var browserWidth = $telerik.$(window).width();
            var browserHeight = $telerik.$(window).height();
            var wnd = window.radopen("ConfirmSubscriptionOverride.aspx");
            var divWindow = wnd._popupElement;
            wnd.set_visibleTitlebar(false);
            wnd._topResizer.parentElement.className = "";
            divWindow.classList.add("rwFolderManager");
            //wnd.setSize(464, 512);
            wnd.center();
            if (isMobileScreen()) {
                wnd.setSize(browserWidth - 10, browserHeight);
                wnd.moveTo(0, 0);
            }
            else {
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }
            //if (AddClose == true) {
            //    wnd.add_close(WindowClosed);
            //    if (gridId) { GridToRebind = gridId; }
            //}

            return false;
            return false;
        }
        function ActivateSubscribeButton() {
            debugger;
                
                    window.parent.ActivateButtonSubscribe();
                
            
            CloseRadWnd();
            return false;
           
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
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
        <style type="text/css">
            html body .RadInput_Office2007 .riDisabled, html body .RadInput_Disabled_Office2007 {
                border-color: #CCDBED;
                color: #333;
                cursor: default;
            }

            .RadComboBox_Outlook .rcbDisabled .rcbInputCell .rcbInput, .RadComboBoxDropDown_Outlook .rcbDisabled {
                color: #333;
            }

             .Toolbar{
                 width: 100%;
                 margin-top: 40px;
                 background-color: white !important;
                 border-bottom: 1px solid RGB(237,237,237);
             }
             .rwWindowContent > iframe{
                border-radius:10px;
            }
            .rwWindowContent{
               background: transparent !important;
            }

        </style>
        <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="clickOnToolbar" runat="server" Skin="Default" AutoPostBack="true"
                                    Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"
                                            PostBack="false">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Delete" EnableImageSprite="true" CssClass="ToolbarDelete">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" ClientEvents-OnResponseEnd="ResponseEnd" ClientEvents-OnRequestStart="RequestStart">
            <div class="PMMainPage documentSinglePage PMPopupMainPage TitleToolbarTop">
                <div class="row">
                    <div class="col-4 col-4-left">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblLinkedTo" runat="server" Text="Linked To" meta:resourcekey="lblLinkedTo">
                                </asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program" meta:resourcekey="lblProgram">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" DropDownWidth="255px" NoWrap="true"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True"
                                            EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px"
                                            meta:Resourcekey="ddlProjects" NoWrap="true" Skin="Default"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trLocation">
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocations" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" EmptyMessage="Select a Location..." Height="300px"
                                            meta:Resourcekey="ddlLocations" NoWrap="true" Skin="Default"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblPath" runat="server" Text="Path" meta:resourcekey="lblPath">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPath" runat="server" Enabled="false">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblFolder" runat="server" Text="Folder" meta:resourcekey="lblFolder"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFolder" runat="server" Enabled="false">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-middle">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblSubscription" runat="server" Text="Subscription" meta:resourcekey="lblSubscription"></asp:Label>
                            </legend>
                            <table class="colTable">

                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkdocumentRevisionAdded" Text="" runat="server" meta:resourcekey="lblDocumentRevisionAdded" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkdocumentCheckedInCheckedOut" Text="" runat="server" meta:resourcekey="lblDocumentCheckedInCheckedOut" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkdocumentMovedDeleted" Text="" runat="server" meta:resourcekey="lblDocumentMovedDeleted" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkdocumentDownloaded" Text="" runat="server" meta:resourcekey="lblDocumentDownloaded" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkOverrideSettings" Text="" runat="server" meta:resourcekey="lblOverrideSettings" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkApplyToSubFolders" Text="" runat="server" meta:resourcekey="lblApplyToSubFolders" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <table class="colTable" style="padding-top: 5px">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important">
                                    <div style="float: left; width: 128px !important">
                                        <asp:Label ID="lblRemindusers" runat="server" Text="Remind user(s)" meta:resourcekey="lblReminduser">
                                        </asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton"
                                            OnClientClick="return OpenSelectUserPopup()">
                                            <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <div style="width: 100%; min-height: 70px;overflow-x:auto; float: left;"
                                        class="AllLightBlueBorder" id="dvUser">
                                        <span id="spnToUser" runat="server" style="white-space: nowrap;display:flex;width:100%;flex-wrap:wrap;"></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important">
                                    <div style="float: left; width: 128px !important">
                                        <asp:Label ID="lblRemindContacts" runat="server" Text="Remind Contact(s)" meta:resourcekey="lblRemindContacts">
                                        </asp:Label>
                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton runat="server" ID="imgbtnfilterContacts" CssClass="SearchButton"
                                            OnClientClick="return OpenReminderMultipleCompanyFilterPopup(this.id.replace('imgbtnfilterContacts','spnToContacts'),this.id.replace('imgbtnfilterContacts','spnToContacts'),this.id.replace('imgbtnfilterContacts','NotExistIds'),'Contacts','Subscription')">
                                           <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <div style="width: 100%; min-height: 70px;overflow-x:auto; float: left"
                                        class="AllLightBlueBorder" id="dvContact">
                                        <span id="spnToContacts" runat="server" style="white-space: nowrap;display:flex;width:100%;flex-wrap:wrap;"></span>
                                    </div>
                                </td>
                            </tr>

                        </table>
                    </div>
                    <div class="col-4 col-4-right">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblEvents" runat="server" Text="Event(s)" meta:resourcekey="lblEvents">
                                </asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:CheckBox ID="chkEmail" Text=" Email" meta:resourcekey="chkEmail" runat="server" />
                                    </td>
                                    <td rowspan="3" class="controlWidth">                                    
                                        <asp:TextBox ID="txtNotes" Width="100%" runat="server" MaxLength="500" TextMode="MultiLine" Height="82px">
                                        </asp:TextBox>
                                        </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:CheckBox ID="chkSMS" Text=" Text(SMS)" meta:resourcekey="chkSMS" Visible="false" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:CheckBox ID="chkOnScreenMessage" Text=" OnScreen Message" meta:resourcekey="chkOnScreenMessage" runat="server" />
                                    </td>
                                </tr>
                                </table >
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblSubject" runat="server" Text="Subject" meta:resourcekey="lblSubject">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSubject" Width="100%" runat="server">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblSystemId" runat="server" Text="System ID" meta:resourcekey="lblSystemId">
                                        </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSystemId" runat="server" Enabled="false" Width="100%">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <asp:Button runat="server" ID="btnRemoveContact" CssClass="Hide" />
                    <asp:HiddenField ID="hfdeletedContact" runat="server" Value="0" />
                    <asp:Button runat="server" ID="btnAddContacts" CssClass="Hide" />
                    <asp:HiddenField ID="hfdeletedUser" runat="server" Value="0" />
                    <asp:Button runat="server" ID="btnAddUsers" CssClass="Hide" />
                    <asp:Button runat="server" ID="btnRemoveUsers" CssClass="Hide" />
                    <asp:Button ID="btnCheckhasChilds" runat="server" CssClass="Hide"
                        Text="" />
                </div>
            </div>
        </telerik:RadAjaxPanel>
        <asp:Button ID="btnSave" runat="server" CssClass="Hide"
            Text="" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" Behaviors="Close,Move"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
