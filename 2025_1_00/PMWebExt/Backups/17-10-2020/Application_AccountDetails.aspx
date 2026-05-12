<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Application_AccountDetails.aspx.vb"
    Inherits="Website.Application_AccountDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Application_PMWebLogo.ascx" TagName="PMWebLogo" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb</title>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head> 
<body style="background-color: #FFFFFF;">
     <telerik:RadCodeBlock runat="server">
  <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
   <%--  <script src="JS/PMJS.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>--%>
        <script type="text/javascript" language="javascript">
             function pageLoad() {

            $('#txtCurrentPass').focus(function () {
                passwordfocus('lbloldpasswordmask');
            });
            $('#txtCurrentPass').blur(function () {
                passwordblur('lbloldpasswordmask', 'txtCurrentPass');
            });
            $('#txtNewPass').focus(function () {
                passwordfocus('lblPasswordmask');
            });
            $('#txtNewPass').blur(function () {
                passwordblur('lblPasswordmask', 'txtNewPass');
            });
            $('#txtReEnterNewPass').focus(function () {
                passwordfocus('lblConfirmPasswordmask');
            });
            $('#txtReEnterNewPass').blur(function () {
                passwordblur('lblConfirmPasswordmask', 'txtReEnterNewPass');
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
            var txt = $('#' + txtId);
            var lbl = $('#' + lblId);
            lbl.removeClass('Hide');
            txt.focus();
        }
            function OpenApplication(sender, eventArgs) {
                window.location = "Application_Applications.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }
            function OpenNewApplication() {
                window.location = "Application_Applications.aspx?Id=0";
                return false;
            }
            function OpenExistingApplication(Id) {
                window.location = "Application_Applications.aspx?Id=" + Id;
                return false;
            }

            function ApplicationCreationNotAllowed() {
                radalert(Msg_ApplicationCreationNotAllowed, 450, 200, Msg_TitleAppCreationNotAllowed);
                return false;
            }

            function BeginRequalification() {
                OpenPOPUp("ApplicationBeginRequalificationPopup.aspx", 750, 430, false)
            }

            function ShowHideCompanyNameBackground(ExistCompanyName) {
                if (ExistCompanyName == "1") {
                    $('#divCompanyTitle').css({ 'display': 'block' });
                }
            }
            function showLanguages() {
                var language = $('.language');
                language[0].className = language[0].className.replace(' Hide', '')
                return false;
            }
            $(document).ready(function () {
                setTimeout(FloatDivs, 100);
                var today = new Date();
                var year = today.getFullYear();
                $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc. All rights reserved.');
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
        </script>
        <style type="text/css">
            .PMMainPage > .row > .col-8{width:calc(100vw - 775px) !important;padding-left:24px !important;box-sizing: initial !important;}
                  .PMMainPage > .row > .col-8.VerticalScrollbarGutter{width:calc(100vw - 790px) !important;padding-left:24px !important;box-sizing: initial !important;}
            .btn{text-decoration:none}
             @media screen and (max-width: 880px){
                .tdImgLogin {display: table-cell;}
                #SideBar {width:300px;}
               }
             @media screen and (max-width: 835px){
                .tdImgLogin {
                    display: table-cell;
                    width:100% !important;float:left;
                }
                #SideBar {width:100% !important;}
                .tdSidebar{width:100% !important;float:left;}
               }
 @media screen and (max-width: 1149px){
     .PMMainPage > .row > .col-8{width:100% !important;padding-left:0px !important;box-sizing: initial !important;}
                  .PMMainPage > .row > .col-8.VerticalScrollbarGutter{width:100% !important;padding-left:0px !important;box-sizing: initial !important;}
               }
         .labelmask{
            position:absolute;
            top:8px;
            left:0;
            padding-left:3px;
            color:#666;
           
        }
        </style>
    </telerik:RadCodeBlock>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
    <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpPM">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgApplications">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgApplications" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
        <table style="width:100%;height: 100%; max-width: 100vw;table-layout:fixed" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width:300px;height:100vh" valign="top" class="tdSidebar">
                    <div id="SideBar" class="Sidebar" style="position:relative">
                        <div id="img_pmweb" style="text-align: center">
                            <asp:Image ID="imgLogo" Style="margin-top: 40px" runat="server" ImageUrl="CSS/Images/PMWeb-Logo-WHite.png" Height="68px" Width="220px" />
                        </div>
                        <div style="position:absolute;bottom:100px">
                            <div id="out_links">
                                <asp:LinkButton runat="server"  ID="btnHelp" OnClientClick="return OpenPOPUp('AboutPMWeb.aspx')" style="color:white !important;margin-top:50px;display:block;">
                                <table><tr><td><div class="HeaderMenuHelp">&nbsp;</div></td><td>
                                    <asp:Label runat="server" ID="lblAboutPMWeb" Text="About PMWeb" meta:resourceKey="lblAboutPMWeb"></asp:Label>
                                    </td></tr></table></asp:LinkButton>
                            </div>
                            <div id="licenseAgreement" style="padding-top:10px">
                                Use of PMWeb is subject to the terms of the license
                                agreement. &nbsp;
                                <br />
                                <a href="https://help.pmweb.com/pmwebeula.html" target="_blank" style="color: white !important">www.pmweb.com/EULA</a>
                            </div>
                            <div id="copyright">
                                <label id="copyrightLabel"></label>
                            </div>
                        </div>
                    </div>
                </td>
                <td class="tdImgLogin" valign="top" >
                    <div class="PMMainPage">
                         <div class="row row-8-4 JustifyContent">
                             <div class="col-4">
                                 <table style="width:400px">
                                     <tr>
                                                    <td style="width: 90% !important;color:#666">
                                                        <asp:Label ID="lblLanguage" runat="server"></asp:Label>
                                                    </td>
                                                     <td style="text-align: right; width: 50px;">
                                                        <asp:ImageButton ID="imgSelectedlanguage"  Width="40px"
                                                            OnClientClick="return showLanguages();" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
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
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </td>
                                                </tr>
                                     <tr>
                                         <td colspan="2">
                                               <asp:Label ID="lblWelcome" meta:resourceKey="lblWelcome" runat="server" Text="Welcome to the Global Developers' Vendor Application. Please enter your Information below and click The Create Account button or log in to your account above."></asp:Label>
                                         </td>
                                     </tr>
                                     </table>
                                    <table class="colTable" style="padding-top:5px">
                                     <tr>
                                         <td class="labelWidth">
                                              <asp:Label ID="lblAccountID" meta:resourceKey="lblAccountID" runat="server" Text="PMWeb Account ID"></asp:Label>
                                         </td>
                                         <td class="controlWidth">
                                               <asp:TextBox ID="txtAccountID" CssClass="Integer" runat="server" Text="" Enabled="false"></asp:TextBox>
                                         </td>
                                     </tr>
                                     <tr>
                                          <td class="labelWidth">
                                               <asp:Label ID="lblUsername" meta:resourceKey="lblUsername" runat="server" Text="Username"></asp:Label>
                                         </td>
                                         <td class="controlWidth">
                                               <asp:TextBox ID="txtUsername" runat="server" Text=""></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                                                CssClass="Validator" ErrorMessage="<br/>Enter Username" Display="Dynamic" ForeColor=""
                                                ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfv_Username">
                                            </asp:RequiredFieldValidator>
                                            <asp:Label ID="lblUsernameExist" meta:resourcekey="lblUsernameExist" runat="server"
                                                Text="Username already exists" Visible="false" Style="color: #C60000;"></asp:Label>
                                         </td>
                                     </tr>
                                     <tr>
                                         <td class="labelWidth">
                                             <asp:Label ID="lblCurrentPass" meta:resourceKey="lblCurrentPass" runat="server" Text="Current Password*"></asp:Label>
                                         </td>
                                         <td class="controlWidth" style="position:relative">
                                             <asp:TextBox ID="txtCurrentPass" runat="server" Text="" Width="100%" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                                           <asp:Label runat="server" ID="lbloldpasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lbloldpasswordmask','txtCurrentPass')"></asp:Label>
                                              <asp:Label ID="lblRequiredPass" meta:resourcekey="lbl_RequiredPass" runat="server"
                                                Text="Enter Current Password" Visible="false" Style="color: #C60000;"></asp:Label>
                                            <asp:Label ID="lblWongPass" meta:resourcekey="lblWrongPass" runat="server" Text="Wrong Password"
                                                Visible="false" Style="color: #C60000;"></asp:Label>
                                         </td>
                                     </tr>
                                     <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblNewPass" meta:resourceKey="lblNewPass" runat="server" Text="New Password"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="position:relative">
                                            <asp:TextBox ID="txtNewPass" runat="server" Text="" TextMode="Password" AutoCompleteType="Disabled" ></asp:TextBox>
                                            <asp:Label runat="server" ID="lblPasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lblPasswordmask','txtNewPass')"></asp:Label>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblReEnterNewPass" meta:resourceKey="lblReEnterNewPass" runat="server"
                                                Text="Re-enter New Password"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="position:relative">
                                            <asp:TextBox ID="txtReEnterNewPass" runat="server" Text="" TextMode="Password" AutoCompleteType="Disabled" ></asp:TextBox>
                                              <asp:Label runat="server" ID="lblConfirmPasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lblConfirmPasswordmask','txtReEnterNewPass')"></asp:Label>
                                              <asp:Label ID="lblConfirmPass" meta:resourcekey="lblConfirmPass" runat="server" Text="Password Not Confirmed" Visible="false" ></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCompanyName" meta:resourceKey="lblCompanyName" runat="server" Text="Company Name*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCompanyName" runat="server" Text=""></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName"
                                                CssClass="Validator" ErrorMessage="<br/>Enter Company Name" Display="Dynamic"
                                                ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfv_CompanyName">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFederalTaxId" meta:resourceKey="lblFederalTaxId" runat="server"
                                                Text="Federal Tax ID*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFederalTaxId" runat="server" Text="" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvFederalTaxId" runat="server" ControlToValidate="txtFederalTaxId"
                                                CssClass="Validator" ErrorMessage="<br/>Enter Federal Tax ID" Display="Dynamic"
                                                ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfv_FederalTaxId">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCountry" meta:resourceKey="lblCountry" runat="server" Text="Country*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCountries" Height="350px" AllowCustomText="false"
                                                Filter="Contains" MarkFirstMatch="true" runat="server" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:Label ID="lblCountryRequired"  meta:resourcekey="lblCountryRequired" runat="server" CssClass="Validator" Text="Select country"
                                                Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblContactName" meta:resourceKey="lblContactName" runat="server" Text="Contact Name*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtContactName" runat="server" Text=""></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName"
                                                CssClass="Validator" ErrorMessage="<br/>Enter Contact Name" Display="Dynamic"
                                                ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfv_ContactName">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblContactEmail" meta:resourceKey="lblContactEmail" runat="server"
                                                Text="Contact Email*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtContactEmail" runat="server" Text="" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvContactEmail" runat="server" ControlToValidate="txtContactEmail"
                                                CssClass="Validator" ErrorMessage="<br/>Enter Contact Email" Display="Dynamic"
                                                ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfv_ContactEmail">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revContactEmail" meta:resourceKey="revContactEmail"
                                                CssClass="Validator" Display="Dynamic" ControlToValidate="txtContactEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                runat="server" ErrorMessage="example@domain.com" ValidationGroup="Apply">
                                            </asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblContactPhone" meta:resourceKey="lblContactPhone" runat="server"
                                                Text="Contact Phone*"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtContactPhone" runat="server" Text="" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvContactPhone" runat="server" ControlToValidate="txtContactPhone"
                                                CssClass="Validator" ErrorMessage="<br/>Enter Contact Phone" Display="Dynamic"
                                                ForeColor="" ValidationGroup="Apply" Operator="NotEqual" meta:resourcekey="rfv_ContactPhone">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                     <tr>
                                         <td colspan="2" align="right">
                                              <asp:Button ID="btnSaveAccount" meta:resourceKey="btnSaveAccount" ValidationGroup="Apply" Width="120px" CssClass="btn" runat="server" Text="Save Account" />
                                               <asp:Button ID="btnCancel"  meta:resourcekey="btnCancel"  runat="server" Text="Cancel" CssClass="btn" Width="80px"/>
                                         </td>
                                     </tr>
                                 </table>
                             </div>
                         <div class="col-8 VerticalScrollbarGutter">
                             <fieldset>
                                <legend>
                                    <asp:Label ID="lblApplications" runat="server" meta:resourcekey="lblApplications"
                                        Text="Applications" Style="margin-left: 10px;"></asp:Label></legend>
                                <telerik:RadGrid ID="rdgApplications" runat="server"  ClientSettings-Scrolling-AllowScroll="true"
                                     AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" SetWidth="true"
                                    PageSize="10" AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="true"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" CommandItemDisplay="Top" EditMode="InPlace" EnableHeaderContextMenu="true"
                                        ClientDataKeyNames="Id">
                                        <Columns>
                                            <telerik:GridTemplateColumn UniqueName="ApplicationID" ItemStyle-Wrap="false" HeaderText="Application ID">
                                                <ItemTemplate>
                                                      <asp:LinkButton ID="btnApplicationID" Text='<%#IIf(Eval("ApplicationID") = String.Empty, "&nbsp;", Eval("ApplicationID")) %>' runat="server" Style="border-width: 0px; cursor: pointer; float: right;"></asp:LinkButton>
                                                    <%--<asp:Label ID="lblApplicationID" runat="server" Text='<%#IIf(Eval("ApplicationID") = String.Empty, "&nbsp;", Eval("ApplicationID")) %>'></asp:Label>--%>
                                                </ItemTemplate>
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Application Year" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                                UniqueName="ApplicationYear">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblYear" runat="server" Text='<%# Eval("Year") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Submitted" ItemStyle-Wrap="false" UniqueName="Submitted">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSubmitted" runat="server" Text='<%# if(Eval("Submitted") Is DBNull.value, "", FormatDate(Eval("Submitted"))) %>'></asp:Label>&nbsp;
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="75px" ItemStyle-Wrap="false" HeaderText="Status"
                                                UniqueName="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("WorkflowStatus") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="75px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="220px" ItemStyle-Wrap="false" HeaderText="Approval Starts" ItemStyle-HorizontalAlign="Right"
                                                UniqueName="ApprovalStarts">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApprovalStarts" runat="server" Text='<%# if(Eval("ApprovalStarts") Is DBNull.value, "", FormatDate(Eval("ApprovalStarts"))) %>'></asp:Label>&nbsp;
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="220px" ItemStyle-Wrap="false" HeaderText="Approval Expires" ItemStyle-HorizontalAlign="Right"
                                                UniqueName="ApprovalExpires">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApprovalExpires" runat="server" Text='<%# if(Eval("ApprovalExpires") Is DBNull.value, "", FormatDate(Eval("ApprovalExpires"))) %>'></asp:Label>&nbsp;
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                <asp:LinkButton ID="btnEdit" SecurityButtonType="ItemMode_Edit" runat="server" CausesValidation="false" CssClass="GridCmdEditRow" 
                                                    CommandName="EditRow">
                                                   <span class="Icon"></span>
                                                    <asp:Label ID="lblEdit" runat="server" Text="Open"></asp:Label>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnAddApplication" SecurityButtonType="ItemMode_Add" runat="server" CssClass="GridCmdInitNewRow" 
                                                    CausesValidation="false" CommandName="InitNewRow">
                                                   <span class="Icon"></span>
                                                    <asp:Label ID="lblAdd" runat="server" Text="New Application"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" SecurityButtonType="ItemMode_Delete" CausesValidation="false" CssClass="GridCmdDeleteRows" 
                                                    OnClientClick="javascript:return ConfirmDelete();" runat="server" CommandName="DeleteRows">
                                                  <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteRows" runat="server" Text="Delete Selected Application"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <ClientSettings Resizing-AllowColumnResize="true" ClientEvents-OnRowDblClick="OpenApplication">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </fieldset>
                         </div>
                     </div>
</div>
                </td>
            </tr>
        </table>
           






    <%--<table cellpadding="0" cellspacing="0" border="0" style="vertical-align: top; width: 100%; height: 100%; margin-bottom: 20px;" id="tblMainTable">
        <tr valign="top">
            <td style="width: 280px; height: 820px">
                <uc1:PMWebLogo ID="PMWebLogo" runat="server" />
            </td>
            <td valign="top" style="padding-left: 20px; float: left">
                <table cellpadding="0" cellspacing="0" border="0" style="height: 280px; width: 900px;
                    font-family: Tahoma; font-size: 11px; color: #333333;">
                    <tr>
                        <td style="height: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="divCompanyTitle" style="background: URL(Images/login/TitleBlueGredientBG.png) #99ccff no-repeat right;
                                display: none;">
                                <asp:Label ID="lblCompanyTitle" runat="server" Style="font-size: 25px; font-weight: bold;
                                    line-height: 40px; margin-left: 20px;"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="height: 50px">
                            <asp:Label ID="lblWelcome1" meta:resourceKey="lblWelcome" runat="server" Text="Welcome to the Global Developers' Vendor Application. Please enter your Information below and click The Create Account button or log in to your account above."></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 50px;">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" id="tdAccountDetails">
                            <fieldset style="width: 500px;">
                                <legend>
                                    <asp:Label ID="lblAccountDetails" runat="server" meta:resourcekey="lblAccountDetails"
                                        Text="Account Details" Style="margin-left: 10px;"></asp:Label></legend>
                                <table cellpadding="3" cellspacing="0" border="0" style="width: 100%; height: 430px;">
                                    <tr>
                                        <td style="width: 30%;">
                                           
                                        </td>
                                        <td style="width: 70%;">
                                          
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                           
                                        </td>
                                        <td>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            
                                        </td>
                                        <td>
                                            
                                        </td>
                                    </tr>
                                    
                                    
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                          
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdApplications" style="padding-top: 30px;">
                            
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 25px;">
                        </td>
                    </tr>
                    <tr valign="bottom">
                        <td>
                            <asp:Repeater ID="rptLanguages" runat="server" Visible="true">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton1" Style="padding: -15px; margin-left: 10px;" Height="15px"
                                        Width="30px" OnClientClick="return CheckDirt2();" ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description") %>'
                                        runat="server" CausesValidation="false" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath") %>'
                                        AlternateText='<%# DataBinder.Eval(Container.DataItem, "Description") %>' CommandName="LanguageClicked"
                                        CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Code") %>' />
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>--%>
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>
    </form>
</body>
</html>
