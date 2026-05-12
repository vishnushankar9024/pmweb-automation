<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalApplicationPopup.aspx.vb" Inherits="Website.VendorApprovalApplicationPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Application_ApplicationAddresses.ascx" TagName="Application_ApplicationAddresses" TagPrefix="uc1" %>
<%@ Register Src="~/Application_ApplicationAddressContacts.ascx" TagName="Application_ApplicationAddressContacts" TagPrefix="uc2" %>
<%@ Register Src="Application_CustomFields.ascx" TagName="Application_CustomFields" TagPrefix="uc3" %>
<%@ Register Src="~/ApplicationInsurances.ascx" TagName="ApplicationInsurances" TagPrefix="uc4" %>
<%@ Register Src="~/ApplicationAttachments.ascx" TagName="ApplicationAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/ApplicationNotes.ascx" TagName="ApplicationNotes" TagPrefix="uc6" %>
<%@ Register Src="~/ApplicationTables.ascx" TagName="ApplicationTables" TagPrefix="uc7" %>
<%@ Register Src="~/ApplicationLinks.ascx" TagName="ApplicationLinks" TagPrefix="uc10" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PMWeb</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>
    <%--<script src="JS/TelerikUtilities.js" type="text/javascript"></script>--%>

    <script type="text/javascript">

        function OpenApplicationNotesPopup(Id, ObjectType) {
            
            OpenPOPUp('ApplicationNotesPopup.aspx?Id=' + Id + '&ObjectType=' + ObjectType, 946, 545, true, 'rdgNotes');
            return false;
        }

        function GoToTop() {
            $("html").scrollTop();
        }

    </script>
    <style type="text/css">
        .details {
            white-space: normal;
            width: 205px;
            display: block;
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
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd" valign="middle" style="vertical-align: middle; width: 70%">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" CssClass="ToolbarSave"
                                CommandName="Save" AccessKey="s" Enabled="false" ValidationGroup="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveExit" AccessKey="s" Enabled="false" ValidationGroup="Save" Style="margin-left: 10px;">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" EnableImageSprite="true" CssClass="ToolbarDelete"
                                CommandName="Delete" AccessKey="d" Value="Delete" Enabled="false" Style="margin-left: 10px;">
                            </telerik:RadToolBarButton>

                        </Items>
                    </telerik:RadToolBar>

                    <%--    <td style="width:13%;">
                            <asp:Button ID="btnSubmitApp" meta:resourceKey="btnSubmitApp" runat="server" Text="Submit This Application" CssClass="LargeButton" Enabled="false" />
                        </td>--%>
                </td>
            </tr>
        </table>

        <table cellpadding="0" cellspacing="0" id="tblMainTable" style="width: 100%; height: 100%;" class="documentSinglePage">
            <tr valign="top">
                <td id="topPage" style="height: 50px">
                    <asp:Image ID="imgLogo" runat="server" ImageUrl="Images/Login/PMWeb.gif" Width="260px" />
                </td>
            </tr>
        </table>

        <div class="PMMainPage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:Label ID="lblvendorqualifications" meta:resourceKey="lblvendorqualifications" runat="server" Text="Vendor Qualifications"
                                    Style=" font-weight: bold; color: Maroon"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadTreeView ID="trvSectionMenu" runat="server" Skin="Default" Width="100%"
                                    MultipleSelect="true" AllowNodeEditing="false" CausesValidation="false">
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
                <div class="col-8">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company"></asp:Label></legend>
                        <table class="colTable">
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
                                    <asp:TextBox ID="txtFederalTaxId" runat="server" Text="" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCountry" runat="server" meta:resourceKey="lblCountry" Text="Country"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtCountry" runat="server" Text="" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblHomeState" runat="server" meta:resourceKey="lblHomeState" Text="Home State"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlHomeState" runat="server" AllowCustomText="false" Filter="Contains" Skin="Default"
                                        Width="100%" Height="200px">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStateTaxId" runat="server" meta:resourceKey="lblStateTaxId" Text="State Tax ID"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtStateTaxId" runat="server" Text=""></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatus" meta:resourceKey="lblStatus" runat="server" Text="Status"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtStatus" Enabled="false" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblSubmitted" meta:resourceKey="lblSubmitted" runat="server" Text="Submitted"></asp:Label>

                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtSubmitted" Enabled="false" runat="server" Style="text-align: right;"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblApplicationYear" meta:resourceKey="lblApplicationYear" runat="server" Text="Application Year">

                                    </asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtApplicationYear" Enabled="false" runat="server" Style="text-align: right;"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:LinkButton ID="lbtAccountID" meta:resourceKey="lbtAccountID" runat="server" Text="PMWeb AccountID" class="Link">

                                    </asp:LinkButton></td>
                                <td class="controlWidth">

                                    <asp:TextBox ID="txtAccountID" Enabled="false" runat="server" Style="text-align: right;">

                                    </asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">

                                    <asp:LinkButton ID="lbtApplicationID" meta:resourceKey="lbtApplicationID" runat="server" Text="Application ID" class="Link">

                                    </asp:LinkButton></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtApplicationID" Enabled="false" runat="server" Style="text-align: right;"></asp:TextBox></td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-12">
                        <table class="colTable">
                            <tr>
                                <td width="100%">
                                    <uc1:Application_ApplicationAddresses ID="Application_ApplicationAddresses1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc2:Application_ApplicationAddressContacts ID="Application_ApplicationAddressContacts1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc3:Application_CustomFields ID="Application_CustomFields1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc4:ApplicationInsurances ID="ApplicationInsurances1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc10:ApplicationLinks ID="ApplicationLinks1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc6:ApplicationNotes ID="ApplicationNotes1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc5:ApplicationAttachments ID="ApplicationAttachments1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <uc7:ApplicationTables ID="ApplicationTables1" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblSignature" runat="server" meta:resourcekey="lblSignature" Text="Signature"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAppCompletedDate" runat="server" meta:resourceKey="lblAppCompletedDate" Text="Date Application Completed"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadDatePicker ID="dtpCompleteDate" runat="server" MinDate="1900-01-01" MaxDate="2100-01-01"
                                        SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)" EnableTyping="True">
                                        <DateInput ID="DateInput5" Skin="Default" LabelCssClass="radLabelCss_Office2007"
                                            runat="server">
                                        </DateInput>
                                        <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAppCompletedBy" runat="server" meta:resourceKey="lblAppCompletedBy" Text="Application Completed By"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtAppCompletedBy" Text="" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblTitle" runat="server" meta:resourceKey="lblTitle" Text="Title"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtTitle" Text="" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPhone" runat="server" meta:resourceKey="lblPhone" Text="Phone"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPhone" Text="" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblExt" runat="server" meta:resourceKey="lblExt" Text="Ext."></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtExt" Text="" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEmail" runat="server" meta:resourceKey="lblEmail" Text="Email"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEmail" Text="" runat="server"></asp:TextBox>
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

    </form>
</body>
</html>
