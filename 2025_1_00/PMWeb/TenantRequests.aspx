<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="TenantRequests.aspx.vb" Inherits="Website.TenantRequests" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc1" %>
<%@ Register Src="TenantRequestDetails.ascx" TagName="TenantRequestDetails" TagPrefix="uc2" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc3" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc10" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:radajaxmanagerproxy id="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
             <telerik:AjaxSetting AjaxControlID="mlpTenantRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTenantRequests" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTenantRequests" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
          

            <telerik:AjaxSetting AjaxControlID="btnReLoadLinkedRecords">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTenantRequests" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:radajaxmanagerproxy>

    <telerik:radcodeblock id="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            //function Test() {
            //    OpenPOPUpToRedirect('SubmitWorkRequestPopup.aspx', 1020, 520)
            //}

            function SubmitWorkflowError(errorMsg, url) {
                alert("'" + errorMsg + "'");
                window.location = url;
            }

            function GenereatedWorkOrder(WorkOrderRecNumb) {
                var Msg = Msg_ConfirmWorkOrder.replace("[WorkOrderNumber]", WorkOrderRecNumb);
                alert(Msg);
            }

            function OpenGoogleTenantRequestAddressesPicker() {
                var Id = '<%= PM.Asset.TenantsInfo.TenantsRequestId%>';
                if (Id > 0) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=ASSET_TENANTREQUEST&ObjectId=" + Id + "&PickerSender=RecordAddress");
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                        wnd.moveTo(8, 0);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                }
                return false;
            }

            function OpenSelectUserPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var Bidder = 0;
                var wnd = window.radopen('SelectUserPopup.aspx?Source=WorkRequest&IsSingleSelect=1');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "GenerateWorkOrder") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("GenerateWorkOrder");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value(), args)
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName(), args)
            }

            function OpenLinkAssetsPopup() {
                var Description = '<%=JSEscape(PM.Asset.TenantsInfo.Description)%>';
                var Id = '<%= PM.Asset.TenantsInfo.TenantsRequestId%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkAssetsPopup.aspx?ObjectType=ASSET_TENANTREQUEST&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkAssetsPopup);
                return false;
            }

            function CloseLinkAssetsPopup() {
                var btnRefreshHeader = $("[id$=btnRefreshHeader]");
                if (btnRefreshHeader) {
                    btnRefreshHeader.click();
                }
            }
    
            function maintoolbarClick(Value, args) {
                var RecordDescription = '<%=JSEscape(PM.Asset.TenantsInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Asset.TenantsInfo.Description)%>';
                var Id = '<%= PM.Asset.TenantsInfo.TenantsRequestId%>';
                var HasReports = '<%= PM.Asset.TenantsInfo.HasReports%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=ASSET_TENANTREQUEST&Id=" +
                            Id + "&Description="
                                        + Description
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=" + '<%=PM.Asset.TenantsInfo.PropertyId%>' + "&EntityType=1", "Notification",
                            'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var browserWidth = $telerik.$(window).width();
                            var browserHeight = $telerik.$(window).height();
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            var wnd = window.radopen("ReportsPreviewPopup.aspx?ObjectType=ASSET_TENANTREQUEST&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.TenantsInfo.PropertyId%>' + "&EntityType=1");
                            if (isMobileScreen()) {
                                wnd.setSize(browserWidth - 10, browserHeight - 10);
                                wnd.moveTo(8, 0);
                            }
                            else {
                                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                                wnd.Center();
                            }
                            return false;

                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var browserWidth = $telerik.$(window).width();
                            var browserHeight = $telerik.$(window).height();
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            var wnd = window.radopen("ReportsPreviewPopup.aspx?ObjectType=ASSET_TENANTREQUEST&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.TenantsInfo.PropertyId%>' + "&EntityType=1");

                            if (isMobileScreen()) {
                                wnd.setSize(browserWidth - 10, browserHeight - 10);
                                wnd.moveTo(8, 0);
                            }
                            else {
                                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                                wnd.Center();
                            }
                            return false;

                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                
                break;
                    case 'New':
                        window.location = "TenantRequests.aspx";
                        break;
                    case 'GenerateInitiative':
                        OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?Source=TenantRequestInitiative', 1020, 520)
                        break;
                    case 'GenerateProject':
                        OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?Source=TenantRequestProject', 1020, 520)
                        break;
                    case 'GenerateWorkOrder':
                        var TenantPropertyId = '<%=PM.Asset.TenantsInfo.PropertyId%>';
                        if (TenantPropertyId == '0') {
                            args.set_cancel(true);
                            alert(Msg_TenantRequestSelectProperty);
                        }
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('ASSET_TENANTREQUEST');
                        break;
                    default:

                        break;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }


            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:radcodeblock>
    <style type="text/css">
        #dvClear {
            display: none !important;
        }
    </style>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:radtoolbar id="mainToolBar" runat="server" skin="Default" autopostback="True">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Copy" ImageUrl="Images/ToolBar/CopyRecord.png"
                                    CommandName="Copy" Value="CopyRecord" Width="150px" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>


                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/EmailMessage.gif"
                            PostBack="false" CausesValidation="false" CommandName="Notification" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                  <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                       <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Initiative" Value="GenerateInitiative"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Project" Value="GenerateProject"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Work Order" Value="GenerateWorkOrder"></telerik:RadMenuItem>

                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('ASSET_TENANTREQUEST');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ASSET_TENANTREQUEST');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            EnableDefaultButton="false" CssClass="ToolbarGenerate HideOnMobileToolbar" Value="Generate">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="False" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="GenerateInitiative" Value="GenerateInitiative">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="False" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="GenerateProject" Value="GenerateProject">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="True" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="GenerateWorkOrder" Value="GenerateWorkOrder" CausesValidation="true" ValidationGroup="Gen">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:radtoolbar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <telerik:radtabstrip onclienttabselecting="onTabSelecting" id="tbsDocument" selectedindex="0" scrollchildren="true" scrollbuttonsposition="Left"
        runat="server" multipageid="mlpTenantRequests" skin="Default" width="100%" enableviewstate="True" cssclass="documentTabs"
        causesvalidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:radtabstrip>

    <telerik:radmultipage id="mlpTenantRequests" runat="server" selectedindex="0" width="100%" cssclass="documentMultiPages"
        renderselectedpageonly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td style="text-align: justify; height: 53px;">
                                        <asp:Literal ID="Literal1" meta:resourceKey="Literal1" runat="server" Text="IMPORTANT MESSAGE: If this is an emergency, please contact management or the authorities by telephone. Do not use this form to report an emergency."></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <fieldset id ="fldContactInfo" runat="server">
                                            <legend>
                                                <asp:Label runat="server" ID="lblContactInfo" meta:resourcekey="lblContactInfo" Text="Contact Info"></asp:Label>
                                            </legend>
                                            <table class="colTable" width="100%">
                                                <tr>
                                                    <td class="labelWidth NoWrap">
                                                        <div style="float: left;">
                                                            <asp:Label ID="lblContactName" meta:resourcekey="lblContactNameRequired" runat="server" Text="Contact Name*"></asp:Label>
                                                        </div>
                                                        <div style="float: right;">
                                                            <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton">
                                                                                    <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtContactName" Style="margin: 0px;" MaxLength="250" runat="server" Width="100%" Text=""></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName" Display="Dynamic" ForeColor=""
                                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" ValidationGroup="Save">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth NoWrap">
                                                        <asp:Label ID="lblContactPhoneDay" runat="server" meta:resourcekey="lblContactPhoneDayExt" Text="Phone (Day)"></asp:Label>
                                                    </td>
                                                    <td class="NoWrap controlWidth">
                                                        <table id="tblPhoneDay" runat="server" width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="50%">
                                                                    <asp:TextBox MaxLength="50" Style="margin: 0px;" ID="txtContactPhoneDay" runat="server"></asp:TextBox>
                                                                </td>

                                                                <td style="width: 50%; padding-left: 8px;">
                                                                    <asp:TextBox ID="txtContactPhoneDayExt" Style="margin: 0px;" MaxLength="50" runat="server" TabIndex="3"></asp:TextBox>
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
                                                        <asp:TextBox ID="txtCell" Style="margin: 0px;" MaxLength="50" runat="server" Text=""></asp:TextBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth NoWrap">
                                                        <asp:Label ID="lblContactPhoneNight" runat="server" meta:resourcekey="lblContactPhoneNightExt" Text="Phone (Night)"></asp:Label>
                                                    </td>
                                                    <td class="NoWrap controlWidth">
                                                        <table id="tblPhoneNight" runat="server" width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="50%">
                                                                    <asp:TextBox MaxLength="50" Style="margin: 0px;" ID="txtContactPhoneNight" runat="server"></asp:TextBox>
                                                                </td>

                                                                <td style="width: 50%; padding-left: 8px;">
                                                                    <asp:TextBox ID="txtContactPhoneNightExt" Style="margin: 0px;" MaxLength="50" runat="server" TabIndex="3"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblContactEmail" meta:resourcekey="lblContactEmail" runat="server" Text="Email"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtContactEmail" Style="margin: 0px;" MaxLength="255" runat="server" Text=""></asp:TextBox>
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
                                        <fieldset style="min-height: 135px;">
                                            <legend>
                                                <asp:Label runat="server" ID="lblRequest" meta:resourcekey="lblRequest" Text="REQUEST111"></asp:Label>
                                            </legend>
                                            <table class="colTable" style="width: 100%;">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLocation" meta:resourceKey="lblLocation" runat="server" Text="Location"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                                            NoWrap="true" Height="300px" CausesValidation="False" AutoPostBack="true"
                                                            EmptyMessage="<%$Resources:Asset, ddlLocation_EmptyMsg %>" ShowMoreResultsBox="True" AllowCustomText="true"
                                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" EnableLoadOnDemand="true">
                                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                        </telerik:RadComboBox>
                                                        <asp:Label ID="lblPropertyError" runat="server" Text="<%$Resources: rfvProperties.ErrorMessage %>"
                                                            Visible="false" CssClass="Validator">
                                                        </asp:Label>
                                                        <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                            CssClass="Validator" ErrorMessage="<%$Resources: rfvProperties.ErrorMessage %>">
                                                        </asp:CustomValidator>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblChangeEventNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtRecordNumber" runat="server" MaxLength="10" ValidationGroup="Save"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" ValidationGroup="Save" Display="Dynamic"
                                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                                            Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>">
                                                        </asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlCategoy" runat="server" Filter="Contains" AllowCustomText="true"
                                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="true"
                                                            CausesValidation="False" TabIndex="2">
                                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" AllowCustomText="true"
                                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                            NoWrap="true" CausesValidation="False" TabIndex="2">
                                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblDescription" meta:resourceKey="lblDescription" runat="server" Text="Description"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtDescription" MaxLength="255" runat="server" Text=""></asp:TextBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <div style="float: left;">
                                                            <asp:Label runat="server" meta:resourceKey="lblWBS" ID="lblWBS" Text="WBS"></asp:Label>
                                                        </div>
                                                        <div style="float: right;">
                                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                                                    <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlWBS" runat="server" AutoPostBack="false" Style="font-size: 11px"
                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                                            NoWrap="True" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>' Height="250px"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label runat="server" meta:resourcekey="lblScope" ID="lblScope" Text="Scope"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox ID="txtScope" runat="server" MaxLength="4000" TextMode="MultiLine" Style="width: 100%; box-sizing: border-box;"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <div style="float: left;">
                                                            <asp:Label ID="LblLinkedAssets" meta:resourcekey="LblLinkedAsset" runat="server" Text="Linked Assets"></asp:Label>
                                                        </div>
                                                        <div style="float: right;">
                                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedAsset" OnClientClick="return OpenLinkAssetsPopup();">
                                                                                                            <span class="Icon"></span>
                                                            </asp:LinkButton>
                                                            <asp:button id="btnRefreshHeader" runat="server" class="Hide"></asp:button>
                                                        </div>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <div class="NoWrap">
                                                            <asp:TextBox ID="txtLinkedAsset" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" Enabled="false" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>


                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblSubmitted" meta:Resourcekey="lblSubmitted" Text="Submitted"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtSubmitted" Text=""></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth" >
                                        <%--<asp:HyperLink  CssClass="Link"   font-size="12px" ></asp:HyperLink>--%>
                                    <div style="float: left;">
                                        <asp:Label ID="hliWorkOrder"  meta:Resourcekey="hpLinkedRecords" Text="Linked Work Order" runat="server"></asp:Label>
                                    </div>
                                    <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedRecords" >
                                                 <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshLinkedRecords" runat="server" class="Hide"></asp:Button>
                                    </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtWorkOrder"  Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportedBy" meta:resourceKey="lblReportedBy" runat="server" Text="Reported By"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlContacts" runat="server" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownWidth="400px"
                                            Skin="Default" Style="font-size: 11px" NoWrap="True" Height="200px" AllowCustomText="True" ShowMoreResultsBox="True"
                                            EnableItemCaching="false" CloseDropDownOnBlur="true" AutoPostBack="False" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            EnableLoadOnDemand="True" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" OnClientDropDownClosed="dllcompClientClosed">
                                            <HeaderTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td>
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td>
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" meta:resourceKey="lblStatusRevision" runat="server" Text="Status/Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Filter="Contains" MarkFirstMatch="true" TabIndex="2"
                                                        Skin="Default" CloseDropDownOnBlur="true" NoWrap="true" CausesValidation="False" Style="width: 182px !important">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; text-align: right; padding-left: 8px;">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCountry" runat="server" meta:resourcekey="lblCountry"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountries" runat="server" Width="100%" meta:resourcekey="ddlCountry"
                                            Height="200px" Skin="Default" MarkFirstMatch="true"
                                            AllowCustomText="true" Filter="Contains">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblGeolocation" runat="server" meta:resourcekey="lblGeolocation" Text="GeoLocation"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <telerik:RadCodeBlock runat="server">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGeolocation" OnClientClick="return OpenGoogleTenantRequestAddressesPicker();">
                                                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </telerik:RadCodeBlock>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server"></asp:TextBox>
                                        <asp:HiddenField ID="htnGeolocation" runat="server" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <telerik:RadCodeBlock runat="server">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtPMbarcode">
                                                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </telerik:RadCodeBlock>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtBarcode" runat="Server" MaxLength="255"></asp:TextBox>
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-4 col-4-right">
                            <asp:Button ID="btnReLoadLinkedRecords" CssClass="Hide" runat="server" />
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                            <uc10:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>

                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc1:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc12:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc5:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc3:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc6:NotificationLog ID="NotificationLog" runat="server" />
        </telerik:RadPageView>
    </telerik:radmultipage>

    <asp:Button runat="server" ID="btnReloadWorkflowDoc" CssClass="Hide" />
</asp:Content>
