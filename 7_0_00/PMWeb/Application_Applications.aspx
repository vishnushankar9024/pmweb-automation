<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Application_Applications.aspx.vb" Inherits="Website.Application_Applications" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<%@ Register Src="~/Application_ApplicationAddresses.ascx" TagName="Application_ApplicationAddresses" TagPrefix="uc1" %>
<%@ Register Src="~/Application_ApplicationAddressContacts.ascx" TagName="Application_ApplicationAddressContacts" TagPrefix="uc2" %>
<%@ Register src="Application_CustomFields.ascx" tagname="Application_CustomFields" tagprefix="uc3" %>
<%@ Register Src="~/ApplicationInsurances.ascx" TagName="ApplicationInsurances" TagPrefix="uc4" %>
<%@ Register Src="~/ApplicationAttachments.ascx" TagName="ApplicationAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/ApplicationNotes.ascx" TagName="ApplicationNotes" TagPrefix="uc6" %>
<%@ Register Src="~/ApplicationTables.ascx" TagName="ApplicationTables" TagPrefix="uc7" %>
<%@ Register Src="~/ApplicationLinks.ascx" TagName="ApplicationLinks" TagPrefix="uc10" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>PMWeb</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body style="background-color:#FFFFFF !important;">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script type="text/javascript">
    
        function OpenApplicationNotesPopup(Id) {
            OpenPOPUp('ApplicationNotesPopup.aspx?Id=' + Id + '&ObjectType=VENDOR_APPLICATIONTYPE', 946, 545, true, 'rdgNotes');
            return false;
        }

        function ConfirmSubmitApplicationPopup() {
            OpenPOPUp('ApplicationConfirmSubmitPopup.aspx', 420, 250, false);
            return false;
        }

//        function GoToTop() {
//            $("html").scrollTop();
//        }

        function ApplicationSubmitted(Id) {
            alert(Msg_ApplicationSubmitted);
            window.location = "Application_AccountDetails.aspx?Id=" + Id;
        }
        function ApplicationSubmittedRequired() {
            alert(Msg_ApplicationSubmittedRequired);
          
        }

        function ApplicationalreadySubmitted(Id) {
            alert(Msg_ApplicationAlreadySubmitted);
            window.location = "Application_Applications.aspx?Id=" + Id;
        }

        function ConfirmSubmitApplication() {
            return confirm(Msg_ConfirmSubmitApplication);
        }

        function RefreshContactsGrid() {
            var btnRefreshGrid = $("[id$=btnRefreshContactsGrid]");
            btnRefreshGrid.click();
        }

        function showLanguages() {
            var language = $('.language');
            language[0].className = language[0].className.replace(' Hide', '')
            return false;
        }


        $(document).ready(function () {
            var $scrollingDiv = $("#scrollingDiv");
            $("#trvSectionMenu")[0].style.height = $(window).height() * 70 / 100 + "px";
            window.onresize = function () {
                $("#trvSectionMenu")[0].style.height = $(window).height() * 70 / 100 + "px";
            }
            //$(window).scroll(function () {

            //    var TopOffset = $(window).scrollTop();
            //    if ($(window).scrollTop() > 120) {
            //        TopOffset = $(window).scrollTop() - 100;
            //    };

            //    $scrollingDiv
			//	.stop()
			//	.animate({ "marginTop": parseInt(TopOffset) + "px" }, "slow");
            //});
            $('body').click(function (e) {
                var q = e.target;
                var targetid = e.target.id
                if (targetid.indexOf('imgSelectedlanguage') >= 0 || targetid.indexOf('rptLanguages') >= 0)
                    return;
                var language = $('.language');
                if (language[0].className.indexOf('Hide') >= 0)
                    return;
                language[0].className = language[0].className + ' Hide';
            });
        });

    </script>
   <style type="text/css">
    .details
    {  white-space:normal;
    	width: 205px;
    	display:block;
    	}
       .fullHeight {
           height: calc(100vh - 135px) !important;
           overflow:auto;
       }
    .padding{padding-left:24px}
       .WidthAuto {width:auto !important;}
       @media screen and (min-width:1248px) and (max-width:1272px) {
        .padding{padding-left:16px}
            }
       @media screen and (max-width:1248px) {
         .displayRow {
                    display: table-cell;
                    width:100% !important;float:left;
                }
            .padding{padding-left:0px !important}
       }
       input.LargeButton:disabled {
           cursor: default;
           background-color: transparent !important;
       }
       .rtTemplate a {
           width: 325px;
           text-overflow: ellipsis;
           display: inline-block;
           overflow: hidden;
       }
       legend{
           height:inherit !important;
       }
    </style>
  </telerik:RadCodeBlock>
    <form id="form1" runat="server" >
        <telerik:RadFormDecorator ID="rfdApp" runat="server" DecoratedControls="All" />
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
       <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpPM" ClientEvents-OnRequestStart="RequestStart" >
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="">
                    <UpdatedControls>
                         <telerik:AjaxUpdatedControl ControlID="" /> 
                    </UpdatedControls>
                </telerik:AjaxSetting> 
           </AjaxSettings>
        </telerik:RadAjaxManager>
        <table style="width:100%;table-layout:fixed" cellpadding="0" cellspacing="0" id="topPage"> 
            <tr>
                <td style="width:400px;border-right:1px solid #666;position:relative" valign="top">
                    <div style="position:fixed;width:400px">

                    <div style="width:100%;text-align:center;padding-top:50px">
                        <asp:Image ID="imgLogo" runat="server" ImageUrl="Images/Login/PMWeb.gif" height="75px" width="260px" onclick="javascript:return CheckDirtOnLogo();" style="cursor:pointer;" />
                    </div>
                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;" id="tblfixedMenu" >
                                <tr>
                                    <td style="padding-top:9px;padding-left:20px;">
                                        <telerik:RadTreeView ID="trvSectionMenu" runat="server" CssClass="fullHeight"
                                                        MultipleSelect="true" AllowNodeEditing="false"  EnableEmbeddedSkins ="false" CausesValidation="false" >
                                                    <NodeTemplate>
                                                        <asp:Label runat="server" ID="lblNode"></asp:Label>
                                                    </NodeTemplate>
                                                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                                <ExpandAnimation Duration="100"></ExpandAnimation>
                                        </telerik:RadTreeView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                </td>
                <td valign="top">
                     <table style="width: 100%;table-layout:fixed;top:0px" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
                         <tr>
                              <td valign="middle" style="vertical-align: middle;width:255px;padding-left:24px">
                                  <telerik:RadToolBar ID="mainToolBar" runat="server"  AutoPostBack="True" CssClass="popup-toolbar" >
                                    <Items>
                                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" meta:Resourcekey="rtbSave"
                                                                    CommandName="Save" AccessKey="s"  ValidationGroup="Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/SaveExit.png" meta:Resourcekey="rtbSaveExit"
                                                                    CommandName="SaveExit" AccessKey="s" ValidationGroup="Save" style="margin-left:10px;" CssClass="ToolbarSaveAndExit" >
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Void.png" meta:Resourcekey="rtbReturnToAccount"
                                                                    CommandName="ReturnToAccount" AccessKey="d" style="margin-left:10px;">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" meta:Resourcekey="rtbDelete"
                                                                    CommandName="Delete" AccessKey="d" Value="Delete" style="margin-left:10px;">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton IsSeparator="true" SecurityButtonType="Read"></telerik:RadToolBarButton>

                                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" CausesValidation="false"
                                                                    CommandName="Print" Value="Print" style="margin-left:10px;">
                                        </telerik:RadToolBarButton> --%>

                                    </Items>
                            </telerik:RadToolBar> 
                              </td>
                             <td>  <asp:Button ID="btnSubmitApp" meta:resourceKey="btnSubmitApp"  runat="server" Text="Submit This Application" CssClass="LargeButton" 
                                                OnClientClick="javascript:return ConfirmSubmitApplication();"  /></td>
                         </tr>
                    </table>
                     <div class="PMMainPage" style="padding-top:50px">
                         <div class="row">
                             <div  id="S_6" style="width:100%">
                                 <table class="colTable" style="width:400px">
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
                                        <td class="languageFlags" style="position:relative;" colspan="2">
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
                                                                        <asp:ImageButton ID="ImageButton1" Style="padding: -15px" Height="13px" Width="30px" OnClientClick="return CheckDirt2();"
                                                                            ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description") %>' runat="server"
                                                                            CausesValidation="false" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath") %>'
                                                                            AlternateText ='<%# DataBinder.Eval(Container.DataItem, "Description") %>'
                                                                            CommandName="LanguageClicked"
                                                                            CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Code") %>'  />
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </td>
                                    </tr>
                                 </table>
                                </div>
                            
                         
                               <fieldset class="WidthAuto">
                                    <legend><asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company" ></asp:Label></legend>
                                   <table cellpadding="0" cellspacing="0">
                                       <tr>
                                           <td class="displayRow">
                                               <table class="colTable" style="width:400px">
                                                   <tr>
                                                       <td class="labelWidth">
                                                           <asp:Label ID="lblCompanyName" runat="server" meta:resourceKey="lblCompanyName" Text="Company Name"></asp:Label>
                                                       </td>
                                                       <td class="controlWidth">
                                                           <asp:TextBox ID="txtCompanyName" runat="server" Text="" Enabled="false"></asp:TextBox>
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                       <td class="labelWidth">
                                                           <asp:Label ID="lblFederalTaxId" runat="server" meta:resourceKey="lblFederalTaxId" Text="Federal Tax ID"></asp:Label>
                                                       </td>
                                                       <td class="controlWidth">
                                                           <asp:TextBox ID="txtFederalTaxId" runat="server" CssClass="Integer" Text="" Enabled="false"></asp:TextBox>
                                                       </td>
                                                   </tr>
                                                   <tr>
                                                        <td class="labelWidth"><asp:Label ID="lblCountry" runat="server" meta:resourceKey="lblCountry" Text="Country"></asp:Label></td>
                                                        <td class="controlWidth"><asp:TextBox ID="txtCountry" runat="server" Text="" Enabled="false" ></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth"><asp:Label ID="lblHomeState" runat="server" meta:resourceKey="lblHomeState" Text="Home State"></asp:Label></td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlHomeState" runat="server" AllowCustomText="false" Filter="Contains" height="200px">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth"><asp:Label ID="lblStateTaxId" runat="server" meta:resourceKey="lblStateTaxId" Text="State Tax ID"></asp:Label></td>
                                                        <td class="controlWidth"><asp:TextBox ID="txtStateTaxId" runat="server" Text=""></asp:TextBox></td>
                                                    </tr>
                                               </table>
                                           </td>
                                           <td class="padding displayRow">
                                               <table class="colTable" style="width:400px" >
                                            <tr>
                                                <td class="labelWidth"><asp:Label ID="lblStatus" meta:resourceKey="lblStatus" runat="server" Text="Status"></asp:Label></td>
                                                <td class="controlWidth"><asp:TextBox ID="txtStatus" Enabled="false" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth" ><asp:Label ID="lblSubmitted" meta:resourceKey="lblSubmitted" runat="server" Text="Submitted"></asp:Label></td>
                                                <td class="controlWidth"><asp:TextBox ID="txtSubmitted" Enabled="false" runat="server" ></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth" ><asp:Label ID="lblApplicationYear" meta:resourceKey="lblApplicationYear" runat="server" Text="Application Year"></asp:Label></td>
                                                <td class="controlWidth"><asp:TextBox ID="txtApplicationYear"  CssClass="Integer" Enabled="false" runat="server" ></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth" ><asp:Label ID="lblAccountId" meta:resourceKey="lblAccountId" runat="server" Text="PMWeb Account ID"></asp:Label></td>
                                                <td class="controlWidth"><asp:TextBox ID="txtAccountID"  CssClass="Integer" Enabled="false" runat="server" ></asp:TextBox></td>
                                            </tr>
                                            <tr id="S_7">
                                                <td class="labelWidth" ><asp:Label ID="lblApplicationID" meta:resourceKey="lblApplicationID" runat="server" Text="Application ID"></asp:Label></td>
                                                <td class="controlWidth"><asp:TextBox ID="txtApplicationID"  CssClass="Integer" Enabled="false" runat="server"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                           </td>
                                       </tr>
                                   </table>
                                   </fieldset>
                         </div>
                         <div class="row">
                             <div class="col-12">
                                  <uc1:Application_ApplicationAddresses ID="Application_ApplicationAddresses1" runat="server" />
                             </div>
                         </div>
                          <div class="row">
                             <div class="col-12">
                                  <uc2:Application_ApplicationAddressContacts ID="Application_ApplicationAddressContacts1" runat="server" />
                             </div>
                         </div>
                         <div class="row">
                             <div class="col-12">
                                  <uc3:Application_CustomFields ID="Application_CustomFields1" runat="server" />
                             </div>
                         </div>
                          <div class="row">
                             <div class="col-12">
                                   <uc4:ApplicationInsurances ID="ApplicationInsurances1" runat="server" />
                             </div>
                         </div>
                          <div class="row">
                             <div class="col-12">
                                  <uc10:ApplicationLinks ID="ApplicationLinks1" runat="server" />
                             </div>
                         </div>
                          <div class="row">
                             <div class="col-12">
                                   <uc6:ApplicationNotes ID="ApplicationNotes1" runat="server" />
                             </div>
                         </div>
                          <div class="row">
                             <div class="col-12">
                                   <uc5:ApplicationAttachments ID="ApplicationAttachments1" runat="server" />
                             </div>
                         </div>
                          <div class="row">
                             <div class="col-12">
                                   <uc7:ApplicationTables ID="ApplicationTables1" runat="server" />
                             </div>
                         </div>
                         <div class="row">
                             <div class="col-4">
                                  <fieldset>
                                            <legend><asp:Label ID="lblSignature" runat="server" meta:resourcekey="lblSignature" Text="Signature"></asp:Label></legend>
                                            <div id="S_12"></div>
                                            <table class="colTable">
                                                <tr>
                                                    <td class="labelWidth"><asp:Label ID="lblAppCompletedDate" runat="server" meta:resourceKey="lblAppCompleted" Text="Date Application Completed" ></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <telerik:RadDatePicker ID="dtpCompleteDate" Width="100%" runat="server" MinDate="1900-01-01" MaxDate="2100-01-01"
                                                             SelectedDate='<%# Date.Today %>' >
                                                            <DateInput ID="DateInput5"
                                                                runat="server">
                                                            </DateInput>
                                                           
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth"><asp:Label ID="lblAppCompletedBy" runat="server" meta:resourceKey="lblCompletedBy" Text="Application Completed By" ></asp:Label></td>
                                                    <td class="controlWidth"><asp:TextBox ID="txtAppCompletedBy" Text="" runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth"><asp:Label ID="lblTitle" runat="server" meta:resourceKey="lblTitle" Text="Title" ></asp:Label></td>
                                                    <td class="controlWidth"><asp:TextBox ID="txtTitle" Text="" runat="server" ></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth"><asp:Label ID="lblPhone" runat="server" meta:resourceKey="lblPhone" Text="Phone" ></asp:Label></td>
                                                    <td class="controlWidth"><asp:TextBox ID="txtPhone" Text="" runat="server" ></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth"><asp:Label ID="lblExt" runat="server" meta:resourceKey="lblExt" Text="Ext." ></asp:Label></td>
                                                    <td class="controlWidth"><asp:TextBox ID="txtExt" Text="" runat="server" ></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth"><asp:Label ID="lblEmail" runat="server" meta:resourceKey="lblEmail" Text="Email" ></asp:Label></td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtEmail" Text="" runat="server" ></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="revEmail" meta:resourceKey="revEmail" CssClass="Validator" 
                                                                        ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                                                        runat="server" ErrorMessage="example@domain.com" ValidationGroup="Save">
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                             </div>
                         </div>
                     </div>
                </td>
            </tr>
             <asp:Button ID="btnSaveApplicationForm" Text="" CssClass="Hide" runat="server" />
        </table>

        
    </form>
</body>
</html>
