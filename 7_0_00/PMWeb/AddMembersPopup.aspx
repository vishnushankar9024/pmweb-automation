<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddMembersPopup.aspx.vb" Inherits="Website.AddMembersPopup" meta:resourcekey="Page" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .rwReminder {
            z-index: 12000 !important;
        }

         .rwWindowContent > iframe{
                border-radius:10px;
            }
            .rwWindowContent{
               background: transparent !important;
            }

        #switchSystemAddress {
            margin-left: 8px;
            margin-right: 8px;
            vertical-align: text-top;
        }

        .divMessage {
            width: 100%;
            height: 100%;
        }

        .labelWidth div span {
            width: 125px !important;
        }

        #lblSystemAddress {
            vertical-align: middle;
        }

        @media screen and (min-width:585px) and (max-width:635px) {
            #lblSystemAddress {
                width: 110px;
                overflow: hidden;
                text-overflow: ellipsis;
                display: inline-block;
                white-space: nowrap;
            }
        }

        @media screen and (min-width:535px) and (max-width:584px) {
            #lblSystemAddress {
                width: 92px;
                overflow: hidden;
                text-overflow: ellipsis;
                display: inline-block;
                white-space: nowrap;
            }
        }

        @media screen and (min-width:500px) and (max-width:534px) {
            #lblSystemAddress {
                width: 83px;
                overflow: hidden;
                text-overflow: ellipsis;
                display: inline-block;
                white-space: nowrap;
            }
        }

        @media screen and (min-width:350px) and (max-width:499px) {
            #lblSystemAddress {
                width: 65px;
                overflow: hidden;
                text-overflow: ellipsis;
                display: inline-block;
                white-space: nowrap;
            }
        }

        .hide {
            display: none !important;
        }

        .ContactBox {
            background-color: white !important;
        }

        .RadEditor .reToolZone .reEditorModes {
            padding: 0 !important;
        }

        .RadEditor .reToolZone {
            padding: 0 0 1px 0 !important;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadWindowManager ID="PMWindowManager1" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                function CheckClose(sender, args) {

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

                function OpenNotificationSingleCompanyFilterPopupNewStyle(txtFullContact, txtContact, txtEmail, txtIds, Type, Source) {
                    var left = (screen.width - 920) / 2;
                    var top = (screen.height - 300) / 2;
                    var ProjectId = 0;
                    var Entitype = GetquerySt('EntityType');
                    var EntityId = GetquerySt('EntityId');
                    var ObjectType = GetquerySt('ObjectType');
                    if ((Entitype == '0') && (ObjectType != 'BUDGETINITIATIVES')) {
                        ProjectId = EntityId
                    }
                    var win = OpenPOPUpNewStyle('CompaniesFilterPopup.aspx?txtFullContact=' + txtFullContact + '&txtContact=' + txtContact + '&txtEmail=' + txtEmail + '&Type=' + Type + '&txtIds=' + txtIds + '&Source=' + Source + '&ProjectRequired=0&ProjectId=' + ProjectId, '',
                            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=900,height=350,top=' + top + ',left=' + left);
                    return false;
                }

                function OpenSelectUserPopup() {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var Bidder = 0;
                    var wnd = window.parent.radopen('SelectUserPopup.aspx?Bidder=' + Bidder + '&Source=ActivityBoards');

                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(8, 0);
                    }
                    else {
                        wnd.setSize(0.8 * browserWidth, 0.8 * browserHeight);
                        wnd.Center();
                    }
                    return false;
                }

                function switchToolbarButtons() {
                    var checked = document.getElementById("chkEmailInvitation").checked;
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var btnSaveExit = mainToolBar.findItemByValue("SaveAndExit");
                    var btnSend = mainToolBar.findItemByValue("Email");
                    var emailSection = document.getElementsByClassName("emailSection");
                    if (checked == true) {
                        btnSend.set_visible(true);
                        btnSaveExit.set_visible(false);
                        for (var i = 0; i < emailSection.length; i++) {
                            emailSection.item(i).classList.remove("hide");
                        }
                    } else {
                        btnSend.set_visible(false);
                        btnSaveExit.set_visible(true);
                        for (var i = 0; i < emailSection.length; i++) {
                            emailSection.item(i).classList.add("hide");
                        }
                    }
                }

                function pageLoad() {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var btnSaveExit = mainToolBar.findItemByValue("SaveAndExit");
                    btnSaveExit.set_visible(false);
                    switchToolbarButtons();
                }
                function toggleLink() {
                    $("[id$=btnLink]").click();
                }
            </script>
        </telerik:RadCodeBlock>

        <telerik:RadAjaxManager runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnLink">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnLink" LoadingPanelID="ldpEditor" />
                        <telerik:AjaxUpdatedControl ControlID="edtMessage" LoadingPanelID="ldpEditor"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel runat="server" ID="ldpEditor" />
        <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>

        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true"
                                    OnClientButtonClicked="CheckClose">
                                    <Items>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Email" EnableImageSprite="true" CssClass="ToolbarEmail"
                                            Value="Email" ValidationGroup="Email" CausesValidation="true">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            Value="Close">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage TitleToolbarTop" style="margin-bottom: 0;">
            <div class="row">
                <div class="col-12">
                    <%--<asp:Label ID="lblFailed" runat="server" meta:resourcekey="lblFailed" Text="Sending failed." Visible="False" Class="Validator"></asp:Label>--%>
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">

                                <div style="float: left;">
                                    <asp:Label ID="lblUsers" runat="server" meta:resourcekey="lblUsers"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton ID="btnTo" runat="server" CssClass="SearchButton"
                                        OnClientClick="return OpenPOPUpNewStyle('SelectUserPopup.aspx?Bidder=0&Source=ActivityBoards')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="NoWrap NotificationControlWidth">
                                <div style="width: 99%; min-height: 30px;float: left; background-color: #EDEDED; border: 1px solid #666666;"
                                    class=" scroll-pane" id="dvUser">
                                    <span id="spnUser" runat="server" style="white-space: nowrap;display:flex;width:100%;flex-wrap:wrap"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEditRights" runat="server" meta:resourcekey="lblEditRights"></asp:Label>
                            </td>
                            <td style="text-align: left;">
                                <label class="switch">
                                    <input id="chkEditRights" runat="server" type="checkbox" checked="checked" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubscribe" runat="server" meta:resourcekey="lblSubscribe"></asp:Label>
                            </td>
                            <td style="text-align: left;">
                                <label class="switch">
                                    <input id="chkSubscribe" runat="server" type="checkbox" checked="checked" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEmailInvitation" runat="server" meta:resourcekey="lblEmailInvitation"></asp:Label>
                            </td>
                            <td style="text-align: left;">
                                <label class="switch">
                                    <input id="chkEmailInvitation" runat="server" type="checkbox" checked="checked" onchange="switchToolbarButtons()" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>

                        <tr class="emailSection">
                            <td class="labelWidth">
                                <asp:HiddenField runat="server" ID="hdnFromId" ValidateRequestMode="Disabled" />
                                <asp:HiddenField runat="server" ID="hdnFrom" ValidateRequestMode="Disabled" />
                                <asp:HiddenField runat="server" ID="hdnFromEmail" ValidateRequestMode="Disabled" />
                                <div style="float: left;">
                                    <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton runat="server" ID="btnFrom" CssClass="SearchButton" OnClientClick="return OpenNotificationSingleCompanyFilterPopupNewStyle(this.id.replace('btnFrom', 'txtFrom'), this.id.replace('btnFrom', 'hdnFrom'), this.id.replace('btnFrom', 'hdnFromEmail'), this.id.replace('btnFrom', 'hdnFromId'), 'Contacts', 'AddMembers')">
                                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td valign="middle" class="NoWrap NotificationControlWidth">
                                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="tdFrom">
                                            <asp:TextBox BackColor="#EDEDED" ID="txtFrom" runat="server" Width="50%" Enabled="false"></asp:TextBox>
                                            <label id="switchSystemAddress" class="switch">
                                                <input id="chkSystemAddress" runat="server" type="checkbox" />
                                                <span class="slider round"></span>
                                            </label>
                                            <asp:Label ID="lblSystemAddress" CssClass="labelColor" runat="server" meta:resourcekey="lblSystemAddress" />
                                        </td>
                                    </tr>
                                </table>
                                <%--                                <asp:Label ID="lblNoEmail" runat="server" meta:resourcekey="lblNoEmail" Text="There is no email set for the selected contact." Class="Validator hide" />--%>
                            </td>
                        </tr>

                        <tr class="emailSection">
                            <td class="labelWidth">
                                <asp:Label ID="lblLink" runat="server" meta:resourcekey="lblLink"></asp:Label>
                            </td>
                            <td style="text-align: left;">
                                <label class="switch">
                                    <input id="chkLink" runat="server" type="checkbox" checked="checked" onclick="toggleLink();" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr class="emailSection">
                            <td class="labelWidth">
                                <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessage"></asp:Label>
                            </td>
                        </tr>



                    </table>
                </div>
            </div>
            <div class="divMessage emailSection">
                <%--<textarea id="txtAreaMessage" runat="server" rows="20" cols="1"></textarea>--%>
                <telerik:RadEditor ToolsFile="~/ToolsFile.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" Width="100%" Style="box-sizing: border-box;"
                    ID="edtMessage" Skin="Default" runat="server">
                    <Content></Content>
                    <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                    <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                </telerik:RadEditor>
            </div>
        </div>



        <asp:Button runat="server" ID="btnAddUsers" CssClass="Hide" />
        <asp:HiddenField ID="hfdeletedUser" runat="server" Value="0" />
        <asp:Button runat="server" ID="btnRemoveUsers" CssClass="Hide" />
        <asp:Button runat="server" ID="btnLink" CssClass="Hide" />

    </form>

</body>
</html>
