<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="SubmitWorkRequestPopup.aspx.vb" Inherits="Website.SubmitWorkRequestPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgSpecifications">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgSpecifications" LoadingPanelID="ldpSubmitWorkRequest" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="tbsSpecs">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbsSpecs" />
                        <telerik:AjaxUpdatedControl ControlID="rdgSpecifications" LoadingPanelID="ldpSubmitWorkRequest" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlProperties">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbsSpecs" />
                        <telerik:AjaxUpdatedControl ControlID="rdgSpecifications" LoadingPanelID="ldpSubmitWorkRequest" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpSubmitWorkRequest" runat="server" Skin="Default" />


        <style type="text/css">
            .WorkRequestUploaderDropZone {
                padding-top: 10px;
                padding-bottom: 10px;
                text-align: center;
                padding-left: 6px;
                color: #fff;
                background-color: #71b641;
                width: 359px;
            }

            .RadUpload .ruFakeInput {
                float: left !important;
                margin-top: 1px !important;
                margin-left: 0px !important;
                margin-right: 2px !important;
                width: 359px !important;
            }

            .RadTabStrip .rtsLink {
                text-transform: capitalize !important;
            }

            .ruSelectWrap {
                text-align: center;
            }
        </style>

        <script type="text/javascript">
            var uploadsInProgress = 0;

            function onFileSelected(sender, args) {
                uploadsInProgress++;
            }

            function ExecuteWorkflowLoopAlert(msg) {
                alert(msg);
                CloseSubmit();

            }

            function onUploadFailed(sender, args) {
                decrementUploadsInProgress();
            }

            function decrementUploadsInProgress() {
                uploadsInProgress--;
            }

            function added(sender, args) {
                if (document.getElementById('lblUploadOption')) {
                    if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                        $("#lblUploadOption").html(lblUploadOptionChFFText);
                    } else {
                        $("#lblUploadOption").html(lblUploadOptionIEText);
                    }
                }
            }

            function ClientValidationFailed(sender, args) {
                decrementUploadsInProgress();
                alert(WarningMsg_InvalidFile);
            }

            function ValidateCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value >= 0 && value != '') {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    }
                }
                else
                    args.IsValid = true;
            }

            function OpenSelectUserPopup() {
                var left = (screen.width - 568) / 2;
                var top = (screen.height - 300) / 2;
                var Bidder = 0;
                var win = window.open('SelectUserPopup.aspx?Source=WorkRequest&IsSingleSelect=1', '',
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1200,height=360,top=' + top + ',left=' + left);
                return false;
            }
            function OnClientButtonClicked(sender, args) {
                var comandName = args.get_item().get_commandName();
                if (comandName == "Save") {
                    var btnCheckRecordNumber = $("[id$=btnCheckRecordNumber]");
                    btnCheckRecordNumber.click();
                }
            }
            function SubmitWorkRequest() {
                var btnubmitWorkRequest = $("[id$=btnubmitWorkRequest]");
                btnubmitWorkRequest.click();
            }
            function CloseSubmit() {
                var btnRefereshReportViewer = window.opener.$("[id$=btnRefereshReportViewer]");
                if (btnRefereshReportViewer.length > 0) {
                    var btn = btnRefereshReportViewer[0];
                    btn.click();

                }
                window.close();
            }


            function OnRowDblClick(sender, eventArgs) {

                var btnEditSelectedId = 'rdgSpecifications_ctl00_ctl02_ctl00_btnEditSelected';
                var btnUpdateEditedId = 'rdgSpecifications_ctl00_ctl02_ctl00_btnUpdateEdited';

                if (document.getElementById(btnEditSelectedId)) {
                    document.getElementById(btnEditSelectedId).focus();
                    document.getElementById(btnEditSelectedId).click();
                } else {
                    document.getElementById(btnUpdateEditedId).focus();
                    document.getElementById(btnUpdateEditedId).click();
                }
            }

        </script>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="OnClientButtonClicked" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" AccessKey="s" PostBack="false" CausesValidation="false" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table id="MainTable" runat="server" style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="colTable" style="padding-bottom: 10px; width: 90%">
                                <asp:Literal ID="ltlImportantrtMsg" meta:resourceKey="ltlImportantrtMsg" runat="server" Text="<b>Important Message</b>: If this is an emergency, please contact management or the authorities by telephone. Do not use this form to report an emergency."></asp:Literal>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <fieldset runat="server" id="FldContactInfo">
                                                <legend>
                                                    <asp:Label runat="server" ID="lblContactInfo" meta:resourceKey="lblContactInfo" Text="Contact Info"></asp:Label>
                                                </legend>
                                                <table width="100%" cellpadding="0">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <div style="float: left">
                                                                <asp:Label ID="lblContactName" meta:resourcekey="lblContactName" runat="server" Text="Contact Name*">
                                                                </asp:Label>
                                                            </div>
                                                            <div style="float: right">
                                                                <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton" OnClientClick="return OpenSelectUserPopup()">
                                                                <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtContactName" MaxLength="250" runat="server" Width="99%" Text="">
                                                            </asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName"
                                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"
                                                                Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblContactPhoneDay" runat="server" meta:resourcekey="lblContactPhoneDay"
                                                                Text="Phone (Day)"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <table style="width: 100%" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td style="width: 47%">
                                                                        <asp:TextBox MaxLength="50" Style="margin: 0px;" ID="txtContactPhoneDay" runat="server" Width="97%">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblExt" runat="server" meta:resourcekey="lblExt" Text="Ext."></asp:Label>
                                                                    </td>
                                                                    <td style="width: 47%">
                                                                        <asp:TextBox ID="txtContactPhoneDayExt" Style="margin: 0px;" MaxLength="50" Width="97%"
                                                                            runat="server" TabIndex="3">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label runat="server" ID="lblCell" meta:resourcekey="lblCell" Text="Cell"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtCell" MaxLength="50" Style="margin: 0px;" runat="server" Width="99%" Text="">
                                                            </asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblContactPhoneNight" runat="server" meta:resourcekey="lblContactPhoneNight"
                                                                Text="Phone (Night)"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <table cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td style="width: 47%">
                                                                        <asp:TextBox MaxLength="50" ID="txtContactPhoneNight" runat="server" Width="97%">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblExtNight" runat="server" meta:resourcekey="lblExt" Text="Ext."></asp:Label>
                                                                    </td>
                                                                    <td style="width: 47%">
                                                                        <asp:TextBox ID="txtContactPhoneNightExt" Style="margin: 0px;" MaxLength="50" Width="97%"
                                                                            runat="server" TabIndex="3">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblContactEmail" meta:resourcekey="lblContactEmail" runat="server"
                                                                Text="Email"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtContactEmail" Style="margin: 0px;" MaxLength="255" runat="server" Width="99%" Text="">
                                                            </asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtContactEmail" CssClass="Validator" ErrorMessage="Not valid email"
                                                                ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Save" Display="Dynamic" meta:resourcekey="revEmail">
                                                            </asp:RegularExpressionValidator>

                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server">
                                                <table cellpadding="0" style="width: 100%;">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblLocation" meta:resourceKey="lblLocation" runat="server" Text="Location"></asp:Label></td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlProperties" runat="server"
                                                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                                                Width="100%" NoWrap="true" Height="300px"
                                                                CausesValidation="False" AutoPostBack="true"
                                                                EmptyMessage="<%$Resources:Asset, ddlLocation_EmptyMsg %>"
                                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                            <asp:Label ID="lblPropertyError" meta:resourceKey="lblPropertyError" CssClass="Validator" runat="server" Text="Location" Visible="false"></asp:Label>
                                                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                                                CssClass="Validator" InitialValue="" ErrorMessage="Required." meta:resourceKey="rfvLocation"
                                                                Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

                                                            <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                                                ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic" meta:resourceKey="csvLocation"
                                                                CssClass="Validator" ErrorMessage="Required.">
                                                            </asp:CustomValidator></td>

                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblChangeEventNumber" runat="server"
                                                                Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtRecordNumber" runat="server" MaxLength="10" Width="99%" ValidationGroup="Save"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" ValidationGroup="Save" Display="Dynamic"
                                                                runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                                                Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlCategoy" runat="server" Filter="Contains" AllowCustomText="true"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                                Width="100%" NoWrap="true"
                                                                CausesValidation="False" TabIndex="2">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type">
                                                            </asp:Label>
                                                        </td>
                                                        <td class="labelWidth">
                                                            <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" AllowCustomText="true"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                                Width="100%" NoWrap="true"
                                                                CausesValidation="False" TabIndex="2">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDescription" meta:resourceKey="lblDescription" runat="server" Text="Description"></asp:Label></td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtDescription" MaxLength="255" runat="server" Width="99%" Text=""></asp:TextBox></td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            <div style="float: left">
                                                                <asp:Label runat="server" meta:resourceKey="lblWBS" ID="lblWBS" Text="WBS"></asp:Label>
                                                            </div>
                                                            <div style="float: right">
                                                                <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                                <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </div>

                                                        </td>
                                                        <td class="NoWrap">
                                                            <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AutoPostBack="false"
                                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                                                NoWrap="True"
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                OnItemsRequested="ddl_ItemsRequested"
                                                                Style="font-size: 11px" Height="250px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div style="display: none">
                                                    <asp:Button ID="btnCheckRecordNumber" runat="server" Style="display: none;"
                                                        Text="" ValidationGroup="Save" />
                                                </div>

                                            </telerik:RadAjaxPanel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <fieldset>
                                                <legend>
                                                    <asp:Label runat="server" meta:resourcekey="lblScope" ID="lblScope" Text="Scope"></asp:Label>
                                                </legend>
                                                <asp:TextBox ID="txtScope" runat="server" MaxLength="4000" TextMode="MultiLine" Height="117px" Width="99%"></asp:TextBox>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlQuickFileUpload" runat="server">
                                                <fieldset style="padding: 0">
                                                    <legend>
                                                        <asp:Label ID="lblQuickFileUpload" runat="server" meta:resourcekey="lblQuickFileUpload" Text="Quick File Upload"></asp:Label></legend>
                                                    <table border="0" style="width: 100%">
                                                        <tr>
                                                            <td>
                                                                <table width="100%" border="0">
                                                                    <tr>
                                                                        <td>
                                                                            <fieldset style="border: 5px dashed #d5d5d5 !important;">
                                                                                <div id="UploadDropZone">
                                                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                                                        <tr>
                                                                                            <td style="width: 80px;">
                                                                                                <telerik:RadAsyncUpload runat="server" RenderMode="Native" ID="rauAttachment" CssClass="SelectButtonStyle" Width="80px" Skin="Default" OnClientFileUploadFailed="onUploadFailed"
                                                                                                    OnClientFileSelected="onFileSelected" OnClientAdded="added" PostbackTriggers="btnubmitWorkRequest" HideFileInput="true"
                                                                                                    MultipleFileSelection="Automatic" OnClientValidationFailed="ClientValidationFailed" DropZones=".WorkRequestUploaderDropZone">
                                                                                                    <Localization Select="<%$ Resources:PMWeb, btn_Select %>" />
                                                                                                </telerik:RadAsyncUpload>
                                                                                            </td>
                                                                                            <td class="WorkRequestUploaderDropZone" id="tdUploadOption" style="text-align: left; padding-left: 10px; color: #999999; background-color: #FFFFFF;" runat="server">
                                                                                                <span id="lblUploadOption"></span>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </fieldset>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
                                                MaxDate="12/31/2100" runat="server" Skin="Default">
                                                <Calendar Width="200px"></Calendar>
                                                <ClientEvents OnDateSelected="dateSelected" />
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset class="fldSpecs">
                                                <legend>
                                                    <asp:Label runat="server" ID="lblCustomFields" meta:ResourceKey="lblCustomFields" Text="Custom Fields"></asp:Label>
                                                </legend>
                                                <telerik:RadTabStrip ID="tbsSpecs"
                                                    runat="server" MultiPageID="mlpEstimates" Skin="Default"
                                                    EnableViewState="True" CausesValidation="False">
                                                </telerik:RadTabStrip>
                                                <telerik:RadGrid ID="rdgSpecifications" ShowGroupPanel="false" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                    AutoGenerateColumns="False" AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="true" UseEditFormInMobile="true">
                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                        DataKeyNames="SpecificationId,Id" CommandItemDisplay="Top" EditMode="InPlace">
                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderStyle-Width="140px"
                                                                SortExpression="Specification" UniqueName="Specification">
                                                                <ItemTemplate>
                                                                    <%#IIf(Container.DataItem("Specification") = String.Empty, "&nbsp;", Container.DataItem("Specification"))%>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderStyle-Width="80px"
                                                                SortExpression="UOM" UniqueName="UOM">
                                                                <ItemTemplate>
                                                                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn UniqueName="Measure" HeaderStyle-Width="200px" SortExpression="Measure">
                                                                <ItemTemplate>
                                                                    <asp:PlaceHolder ID="plcLabel" runat="server"></asp:PlaceHolder>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <div style="width: 100%; text-align: right;">
                                                                        <asp:TextBox ID="txtMeasure" Visible="false" MaxLength="4000" Width="100%" runat="server"></asp:TextBox>
                                                                        <asp:CheckBox ID="chkMeasure" Visible="false" runat="server" />
                                                                        <asp:TextBox ID="txtDate" MaxLength="100" Style="text-align: right" Visible="false" Width="100%" onclick="showDatePopup(this, event, true);" onfocus="showDatePopup(this, event, true);"
                                                                            onblur="parseDate(this, event);" runat="server"></asp:TextBox>
                                                                        <telerik:RadComboBox MarkFirstMatch="True" Filter="Contains" AllowCustomText="True"
                                                                            sNoWrap="true" DropDownWidth="250px" EmptyMessage="Select..." ID="ddlMeasure" runat="server" Width="100%" Height="400px" Visible="false" Skin="Default"
                                                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="Gridddl_ItemsRequested">
                                                                        </telerik:RadComboBox>
                                                                        <asp:TextBox runat="server" Visible="false" Width="80%" TextMode="MultiLine" Height="14px" ID="txtMemo"></asp:TextBox>
                                                                        <asp:LinkButton runat="server" ID="imgMemo" Visible="false" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtMemo'))" CssClass="SearchButton">
                                                                            <span class="Icon"></span>
                                                                        </asp:LinkButton>
                                                                        <asp:RequiredFieldValidator ID="rfvMeasure" runat="server" ControlToValidate=""
                                                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </EditItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn UniqueName="Notes" HeaderStyle-Width="120px" SortExpression="Notes" GroupByExpression="Notes [Notes] Group By Notes ASC">
                                                                <ItemTemplate>
                                                                    <div><%# IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></div>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox runat="server" MaxLength="4000" Width="80%" TextMode="MultiLine" Height="14px" ID="txtNotes" Text='<%#Container.DataItem("Notes") %>'></asp:TextBox>
                                                                    <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                                                        CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                                                    </asp:LinkButton>

                                                                </EditItemTemplate>
                                                                <ItemStyle Wrap="false" />
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <CommandItemTemplate>
                                                            <table cellpadding="2" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                                                                        CommandName="EditRows" Visible='<%# rdgSpecifications.EditIndexes.Count = 0 %>'>
                                                                                        <span class="Icon"></span>
                                                                                        <asp:Label ID="lbledit" runat="server"></asp:Label>&nbsp;&nbsp;
                                                                                    </asp:LinkButton>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                                                                        CommandName="UpdateEdited" Visible='<%# rdgSpecifications.EditIndexes.Count > 0 %>'>
                                                                                        <span class="Icon"></span>
                                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                                                                    </asp:LinkButton>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                                                                        CommandName="CancelAll" Visible='<%# rdgSpecifications.EditIndexes.Count > 0 %>'>
                                                                                        <span class="Icon"></span>
                                                                                        <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;
                                                                                    </asp:LinkButton>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td>&nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </CommandItemTemplate>
                                                    </MasterTableView>
                                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                    <ClientSettings Resizing-AllowColumnResize="true" AllowDragToGroup="false">
                                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                                                        <ClientEvents OnRowDblClick="OnRowDblClick" />
                                                    </ClientSettings>
                                                </telerik:RadGrid>

                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <div style="display: none;">
            <asp:Button ID="btnubmitWorkRequest" runat="server" Style="display: none;"
                Text="" ValidationGroup="Save" />
        </div>


    </form>
</body>
</html>
