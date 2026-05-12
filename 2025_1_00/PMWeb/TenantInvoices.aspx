<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="TenantInvoices.aspx.vb" Inherits="Website.TenantInvoices" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Src="TenantInvoiceDetails.ascx" TagName="TenantInvoiceDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc2" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc7" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc8" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc9" %>


<%@ Register Src="AssetPaymentApplications.ascx" TagName="AssetPaymentApplications" TagPrefix="uc3" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Asset/TenantInvoice.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">

            function StopSelectLeaseAjax() {
                return false;
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Asset.TenantInvoicesInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Asset.TenantInvoicesInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("TenantInvoices")%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.TenantInvoicesInfo.InvoiceNumber & " - " & PM.Asset.TenantInvoicesInfo.Description)%>';
                var Description = '<%=JSEscape(PM.Asset.TenantInvoicesInfo.Description)%>';
                var Id = '<%= PM.Asset.TenantInvoicesInfo.Id%>';

                switch (Value) {

                    case 'ViewPMWebReports':

                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=TenantInvoices&Id=" + Id
                         + "&EntityId=" + '<%=PM.Asset.TenantInvoicesInfo.PropertyId%>' + "&EntityType=1",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TenantInvoices&Id=" +
                                 Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Asset.TenantInvoicesInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TenantInvoices&Id=" +
                                 Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Asset.TenantInvoicesInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=TenantInvoices&Id=" +
                  '<%= PM.Asset.TenantInvoicesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.TenantInvoicesInfo.PropertyId%>' + "&EntityType=1", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=TenantInvoices&Id=" +
                             '<%= PM.Asset.TenantInvoicesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.TenantInvoicesInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;

                    case 'New':
                        window.location = "TenantInvoices.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('TenantInvoices');
                        break;
                    default:
                        break;
                }
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
            <telerik:AjaxSetting AjaxControlID="mlpTenantInvoice">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTenantInvoice" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTenantInvoice" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnLease">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnLease" />
                    <telerik:AjaxUpdatedControl ControlID="txtInvoicenumber" />
                    <telerik:AjaxUpdatedControl ControlID="txtTenant" />
                    <telerik:AjaxUpdatedControl ControlID="txtPostType" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <asp:HiddenField ID="hdnLeaseId" runat="server" />

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save"
                            AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete"
                            AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CommandName="Notification"
                            ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print"  CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                         <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb View Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('TenantInvoices');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('TenantInvoices');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#tenantinvoices"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpTenantInvoice" Skin="Default" Width="100%" CssClass="documentTabs"
        EnableViewState="True" ScrollChildren="true" ScrollButtonsPosition="Left">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Adjustments" Value="Adjustments"></telerik:RadTab>
            <telerik:RadTab Text="Payments" Value="Payments"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpTenantInvoice" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" Width="100%" NoWrap="true" Height="300px"
                                            CausesValidation="False" AutoPostBack="true" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties" CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Location"
                                             Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"  ClientValidationFunction="ValidateCombo"
                                            ValidationGroup="Save" Display="Dynamic" CssClass="Validator" meta:resourcekey="csv_Location">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lbllease" meta:resourcekey="lbllease" runat="server" Text="Lease*"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgLease" CssClass="SearchButton">
                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:Button ID="btnLease" runat="server" CssClass="Hide" />
                                        <telerik:RadComboBox ID="ddlLease" runat="server" Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" Width="100%" NoWrap="true" Height="300px" meta:resourcekey="ddlLease"
                                            CausesValidation="False" AutoPostBack="true" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLease" runat="server" ControlToValidate="ddlLease" CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Lease"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLease" runat="server" ControlToValidate="ddlLease"  ClientValidationFunction="ValidateCombo"
                                            ValidationGroup="Save" Display="Dynamic" CssClass="Validator" meta:resourcekey="csv_Lease">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTenant" runat="server" meta:resourcekey="lblTenant" Text="Tenant"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTenant" Width="100%" Enabled="false" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoicenumber" runat="server" meta:resourcekey="lbl_Invoicenumber" Text="Invoice #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInvoicenumber" Width="100%" MaxLength="10" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvInvoicenumber" ControlToValidate="txtInvoicenumber" runat="server" Display="Dynamic" ValidationGroup="Save" CssClass="Validator" meta:resourcekey="rfv_Invoicenumber"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblInvoiceNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false" Text="Invoice # must be unique by Location and Lease." meta:resourcekey="lblInvoiceNumberAlreadyExist"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" Width="100%" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPostType" meta:resourcekey="lblPostType" runat="server" Text="Post As"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPostType" Width="100%" Enabled="false" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" Skin="Default"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" />
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox ID="txtRevision" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" runat="server" ValidationGroup="Save" ControlToValidate="txtRevision"
                                                        CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                        ForeColor=""></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliBatchID" meta:Resourcekey="hliBatchID" Text="Batch ID"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBatchID" runat="server" Enabled="false" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceDate" meta:resourcekey="lblInvoiceDate" runat="server" Text="Invoice Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpInvoiceDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpInvoiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" Skin="Default" EnableTyping="True" AutoPostBack="true">
                                                <DateInput ID="DateInput4" Skin="Default"
                                                    runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillingTerm" meta:resourcekey="lblBillingTerm" runat="server" Text="Billing Terms"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBillingTerms" runat="server" AutoPostBack="true" Skin="Default" MarkFirstMatch="true" Filter="Contains" AllowCustomText="True"
                                            Width="100%">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDueDate" meta:resourcekey="lblDueDate" runat="server" Text="Due Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDueDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDueDate" AutoPostBack="false" runat="server" Width="100%" MinDate="1901-01-01" MaxDate="2100-01-01" Skin="Default" EnableTyping="True">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput3" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCostPeriod" meta:resourcekey="lblCostPeriod" runat="server" Text="Cost Period"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%"
                                            EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                            Skin="Default" CloseDropDownOnBlur="true" meta:resourcekey="ddlPeriods"
                                            NoWrap="True" AllowCustomText="False" Height="250px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" Text="Type" runat="server" meta:resourcekey="lblType" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2" AutoPostBack="false" AllowCustomText="True">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" Text="Category" runat="server" meta:resourcekey="lblCategory" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategories" runat="server" Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False" TabIndex="2" AutoPostBack="false" AllowCustomText="True">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaidInFull" Text="Paid in Full" runat="server" meta:resourcekey="lblPaidInFull" />
                                    </td>
                                    <td class="controlWidth chkBox" style="position: relative; left: -3px">
                                        <asp:CheckBox runat="server" ID="chkPaidInFull" ClientIDMode="Static" class="mobile-switch" />
                                        <label for="chkPaidInFull">
                                            <i class="icon"></i>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc9:AssetRotator ID="PMrot" runat="server" />
                            <fieldset runat="server" id="fldInvoiceRecap">
                                <legend>
                                    <asp:Label ID="lblInvoiceRecap" runat="server" Text="Invoice Recap" meta:resourcekey="lblInvoiceRecap"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTotalCost" Text="Total Cost" runat="server" meta:resourcekey="lblTotalCost" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtTotalCost" ReadOnly="True" Enabled="false" style="text-align:right;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTotalPrice" Text="Total Price" runat="server" meta:resourcekey="lblTotalPrice" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtTotalPrice" ReadOnly="True" Enabled="false" style="text-align:right;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPaymentsApplied" Text="Payments Applied" runat="server" meta:resourcekey="lblPaymentsApplied" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtPaymentsApplied" ReadOnly="True" Enabled="false" style="text-align:right;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOpenBalance" Text="Open Balance" runat="server" meta:resourcekey="lblOpenBalance" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtOpenBalance" ReadOnly="True" Enabled="false" style="text-align:right;"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:TenantInvoiceDetails ID="TenantInvoiceDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc2:DocumentAdjustments ID="DocumentAdjustments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvPayments" runat="server">
            <uc3:AssetPaymentApplications ID="AssetPaymentApplications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc6:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc8:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc7:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
