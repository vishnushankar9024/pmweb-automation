<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ContractsCommitments.aspx.vb" Inherits="Website.ContractsCommitments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="CommitmentsClauses.ascx" TagName="CommitmentsClauses" TagPrefix="uc1" %>
<%@ Register Src="CommitmentsDetails.ascx" TagName="CommitmentsDetails" TagPrefix="uc2" %>
<%@ Register Src="CostManagementCommitmentClauses.ascx" TagName="CostManagementCommitmentClauses" TagPrefix="uc6" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="CommitmentProgressInvoices.ascx" TagName="ProgressInvoices" TagPrefix="uc8" %>
<%@ Register Src="CommitmentChanges.ascx" TagName="CommitmentChanges" TagPrefix="uc9" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc11" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc12" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc13" %>
<%@ Register Src="CostManagementAPPaymentApplication.ascx" TagName="APPaymentApplication" TagPrefix="uc14" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc15" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc16" %>
<%@ Register Src="CostImpacts.ascx" TagName="CostImpacts" TagPrefix="uc15" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc17" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.CommitmentsInfo.ProjectId %>';

            var forceMoreMenuToClose = true;
            function contextM(div, event) {
                var DetailId = 0;
                var str = div.id;
                DetailId = str.substring(str.indexOf('_') + 1);

                if (DetailId != '0') {
                    OpenPOPUp("UnitRecap.aspx?Source=CostManagement_Commitments&DetailId=" +
            DetailId, 740, 500, false);

                }

                try {
                    event.preventDefault();
                }
                catch (err) {

                }
                try {
                    event.returnValue = false;
                }
                catch (err)
                { }


                return false;

            }
            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.CommitmentsInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=CostManagement_Commitments&Id=" +
                                 '<%= PM.CostManagement.CommitmentsInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.CommitmentsInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
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
                var HasMergeTemplate = '<%= PM.CostManagement.CommitmentsInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.CommitmentsInfo.HasReports%>';
                var RecordDescription = '<%=mid(JSEscape(PM.CostManagement.CommitmentsInfo.RecordDescription),1,20)%>';
                var Description = '<%=mid(JSEscape(PM.CostManagement.CommitmentsInfo.Description),1,20)%>';
                var Id = '<%= PM.CostManagement.CommitmentsInfo.Id%>';
                var HasPMWebReports = '<%=PM.CostManagement.CommitmentsInfo.QueryBuilderHasReports%>';
                var left = (screen.width - 1045) / 2;
                var top = (screen.height - 515) / 2;
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=CostManagement_Commitments&Id=" +
                                    '<%= PM.CostManagement.CommitmentsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.CommitmentsInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;

                        OpenPOPUp("Notification.aspx?ObjectType=CostManagement_Commitments&Id=" +
                               '<%= PM.CostManagement.CommitmentsInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.CommitmentsInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=CostManagement_Commitments&Id=" +
                         '<%= PM.CostManagement.CommitmentsInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.CostManagement.CommitmentsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'Print':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=CostManagement_Commitments&Id=" +
                         '<%= PM.CostManagement.CommitmentsInfo.Id%>'
                + "&RecordDescription=" + RecordDescription
                + "&EntityId=" + '<%=PM.CostManagement.CommitmentsInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'PaymentSchedule':
                        if (Id == 0) break;
                        var Sleft = (screen.width - 850) / 2;
                        var Stop = (screen.height - 500) / 2;
                        OpenPOPUp("APPaymentSchedule.aspx", "",
                          'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=850,height=500,top=' + Stop + ',left=' + Sleft, 1045, 515, false);
                        break;
                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=CostManagement_Commitments&Id=" + Id
                        + "&EntityId=" + '<%=PM.CostManagement.CommitmentsInfo.ProjectId%>' + "&EntityType=0",
                'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;

                    case 'New':
                        window.location = "ContractsCommitments.aspx";
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('CostManagement_Commitments');
                        break;
                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function contextmenu(toolbar, args) {

                args.get_domEvent().preventDefault();

                return false;
            }
            function OpenContactPOPUp(URL, Width, Height, AddClose) {
                var wnd = window.radopen(URL);
                wnd.setSize(Width, Height);
                if (AddClose == true) {
                    wnd.add_close(WindowContactClosed);
                }
                wnd.Center();
                return false;
            }
            function OpenOverbillingStatePopup() {
                OpenPOPUp('OverbillingStatePopup.aspx?Source=Commitment', 1045, 515, false);
                //wnd.setSize(800, 500);
                //wnd.Center();
                return false;
            }


            function MenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                if (args.get_item().get_value() == 'Assign') {
                    var lblAssigned = $('.lblAssigned');
                    if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                        forceMoreMenuToClose = false;
                }

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
    </telerik:RadCodeBlock>
    <style>
        .RadioCss input {
            height: 18px;
            width: 18px;
            background-color: #ffffff !important;
            border-radius: 50%;
            border-color: #666666 !important;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
              <telerik:AjaxSetting AjaxControlID="mlpCommitments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCommitments" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCommitments" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
         
         
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <script src="JS/Costs/Commitments.js" type="text/javascript"></script>
    <table class="ToolBar SmallToolbar" style="width: 100% !important;" cellpadding="0" cellspacing="0">
        <tr>
<%--            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlCommitments" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                    Width="100%" AutoPostBack="false" NoWrap="true" CausesValidation="False"
                    Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>--%>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" OnClientContextMenu="contextmenu" Skin="Default" AutoPostBack="True">
                    <Items>
                       <%-- <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add" Visible="false"
                                    CommandName="CreateRevision">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                            Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification"
                            ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass=" HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarSplitButton EnableDefaultButton="false" PostBack="false" CommandName="Generate" CssClass="ToolbarGenerate HideOnMobileToolbar"
                            ImageUrl="Images/ToolBar/Generate.png">
                            <Buttons>
                                <telerik:RadToolBarButton CommandName="CreateChangeOrder" ImageUrl="Images/CostControl/ChangeOrder.png"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton CommandName="CreateProgressInvoice" ImageUrl="Images/CostControl/Invoice.png"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Text="Payment Schedule" Width="150px" Value="PaymentSchedule" CommandName="PaymentSchedule"
                                    ImageUrl="Images/ToolBar/PMWebW.gif" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" CssClass="Print" Text="Print" Value="Print" SecurityButtonType="Read">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>                                                       
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Word Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" CssClass="Generate" Text="Generate" Value="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Create Change Order" Value="CreateChangeOrder"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Create Progress Invoice" Value="CreateProgressInvoice"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Payment Schedule" Value="PaymentSchedule"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('CostManagement_Commitments');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('CostManagement_Commitments');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" CssClass="Help" Text="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>--%>


                        <%--<telerik:RadToolBarButton  ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>"
                                        CausesValidation ="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#commitments"></telerik:RadToolBarButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <%--<tr>
            <td>
                    <table style="width: 1100px !important;" cellspacing="0" class="Padding7" border="0">
                        <tr valign="top">
                            <td valign="top"><span class="Padding7"></span></td>
                            <td colspan="2">
                                <asp:Panel ID="pnlProlog" runat="server" Style="float: right;display:none;" >
                                    <table width="100%" cellpadding="1" cellspacing="0" style="background: #fff no-repeat; width: 136px; height: 60px" border="1">
                                        <tr>
                                            <td style="height: 32px"></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 12px"></td>
                                            <td><asp:Button ID="btnContracts" CssClass="btnGenerator" runat="server" Text="Generate" /></td>
                                            <td style="width: 12px"></td>
                                        </tr>
                                        <tr>
                                            <td style="height: 10px"></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                    <div style="text-align: center;">
                                        <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>" Visible="false" Class="Success"></asp:Label>
                                        <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>" Visible="false" Class="Failure"></asp:Label>
                                    </div>
                                </asp:Panel>
                            </td>
                        </tr>
                        
                    </table>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>--%>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" CssClass="documentTabs"
        runat="server" MultiPageID="mlpCommitments" Skin="Default" OnTabClick="tbsDocument_TabClick"
        Width="100%" EnableViewState="True" CausesValidation="False" ScrollChildren="true" ScrollButtonsPosition="Left">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
            <telerik:RadTab Text="Adjustments" Value="Adjustments"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Cost Impact" Value="CostImpact"></telerik:RadTab>
            <telerik:RadTab Text="Change Orders" Value="ChangeOrders"></telerik:RadTab>
            <telerik:RadTab Text="Progress Invoices" Value="ProgressInvoices"></telerik:RadTab>
            <telerik:RadTab Text="Payments" Value="Payments"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpCommitments" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages" RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">

            <asp:PlaceHolder ID="plhScript" runat="server"></asp:PlaceHolder>
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr id="trMaster" runat="server">
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliMaster" meta:Resourcekey="hliMaster" Text="Master"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtMaster" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr valign="top">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$ Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="true"
                                            Skin="Default" NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID %>" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCommIDUnique" runat="server" Text="<%$ Resources:CostManagement, WarningMsg_IDUnique %>" Visible="False" Class="Validator"></asp:Label>
                                        <asp:HiddenField ID="hdnPuchaseOrder" runat="server" />
                                        <asp:HiddenField ID="hdnSubcontracts" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblCompany" runat="server" Text="<%$ Resources:CostManagement, Label_Company %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                                                OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
    					                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default"
                                            CloseDropDownOnBlur="true" AutoPostBack="true" NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCompany" runat="server" ControlToValidate="ddlCompanies"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="500"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="ImgfilterCurrency">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="300px" Skin="Default" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblTypeCommitments"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Skin="Default" Style="font-size: 11px"
                                            AllowCustomText="true" MarkFirstMatch="true" Filter="Contains">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCommitmentType" runat="server" ControlToValidate="ddlTypes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ValidationGroup="Save" Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCommitmentType" runat="server" ControlToValidate="ddlTypes"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                            Skin="Default" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference" runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" meta:resourcekey="lblStatusRevision" runat="server" Text="Status / Revision 11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevisionNumber"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEffectiveDate" runat="server" Text="Effective Date"
                                            meta:ResourceKey="lblEffectiveDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_txtEffectiveDate" style="display: block">
                                            <telerik:RadDatePicker ID="txtEffectiveDate" runat="server"
                                                Culture="English (United States)" Skin="Default">
                                                <Calendar Skin="Default" runat="server" UseColumnHeadersAsSelectors="False"
                                                    UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvEffectiveDate" ControlToValidate="txtEffectiveDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="trDays" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDays" meta:resourcekey="lblDays" runat="server" Text="Days"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDays" runat="server" CssClass="Days" MaxLength="15"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDays" ControlToValidate="txtDays" runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliProcurement" meta:Resourcekey="lblProcurement" Text="Procurement #"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProcurement" runat="server" MaxLength="30" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaidInFull" meta:resourcekey="lblPaidInFull" runat="server" Text="Paid In Full"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkPaidInFull" runat="server" ClientIDMode="Static" />
                                    </td>
                                </tr>

                            </table>
                            <fieldset style="width: 100%" runat="server" id="trOverBilling">
                                <legend class="legend">
                                    <asp:Label ID="lblBillings" runat="server" Text="Billing" meta:Resourcekey="lblBilling"></asp:Label>
                                </legend>
                                <table class="colTable" style="color: #666666;">
                                    <%--<tr>
                                        <td colspan="2">
                                            <asp:Panel runat="server" ID="fldOverBilling">
                                                <table class="TableNoSpacingNoBorder" width="100%">
                                                    <tr>
                                                        <td style="width: 70%">
                                                            <asp:Label ID="lblDoNotAllowbilling" runat="server" Text="Do Not Allow Overbilling 11" meta:Resourcekey="lblDoNotAllowbilling"></asp:Label>
                                                            <asp:Label ID="lblAllowOverbilling" runat="server" Text="Allow billing 11" meta:Resourcekey="lblAllowOverbilling"></asp:Label>
                                                        </td>
                                                        <td style="width: 30%; text-align: right">
                                                            <asp:CheckBox ID="chkOverbilling" runat="server" CssClass="mobile-switch" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBillingTerms" runat="server" meta:ResourceKey="lblBillingTerms" Text="Billing Terms"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBillingTerms" runat="server" Skin="Default" Style="font-size: 11px; width: 100%"
                                                MarkFirstMatch="true" Filter="Contains" AllowCustomText="True">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvBillingTerm" runat="server" ControlToValidate="ddlBillingTerms"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor="" Visible="false">
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvBillingTerm" runat="server" ControlToValidate="ddlBillingTerms"
                                                ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr id="trRetentionOnServices" runat="server">
                                        <td colspan="2">
                                            <div style="float:left">
                                                <asp:Label ID="lblRetentionOnServices" runat="server" Text="Retention on Services" meta:resourceKey="lblRetentionOnServices"></asp:Label>
                                            </div>
                                            <div style="float:right">
                                            <asp:TextBox ID="txtRetentionOnServices" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0" Width="60px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvRetentionOnServices" ControlToValidate="txtRetentionOnServices"
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:RequiredFieldValidator>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trRetentionOnMaterials" runat="server">
                                        <td colspan="2">
                                            <div style="float:left">
                                                <asp:Label ID="lblRetentionOnMaterials" meta:resourceKey="lblRetentionOnMaterials" runat="server" Text="Retention on Stored Materials"></asp:Label>
                                            </div>
                                            <div style="float:right">
                                            <asp:TextBox ID="txtRetentionOnMaterials" CssClass="Percent" MaxNumber="100" MinNumber="0" runat="server" Width="60px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvRetentionOnStoredMaterials" ControlToValidate="txtRetentionOnMaterials"
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:RequiredFieldValidator>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div style="float:left"> <asp:Label ID="lblRevised" meta:resourcekey="lblRevisedUnits" runat="server" Text="Use Revised Units by Default"></asp:Label></div>
                                            <div style="float:right"> <asp:CheckBox ID="chkRevised" runat="server" Checked="false" CssClass="mobile-switch" /></div>
                                        </td>
                                    </tr>
                                    <tr id="fldOverBilling" runat="server">
                                       <td colspan="2">
                                           <table class="colTable">
                                                <tr>
                                        <td>
                                             <asp:RadioButtonList ID="rblOverBilling" AutoPostBack="true" runat="server" CssClass="labelColor RadioCss RadioPadding" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                                <asp:ListItem meta:resourcekey="lblDoNotAllowbilling" Text="" Value="DoNotAllow"> </asp:ListItem>
                                                <asp:ListItem meta:resourcekey="lblAllowOverbilling" Text="" Value="Allow"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                      <tr id="trUpToTotal" runat="server">
                                        <td>
                                            <div class="labelWidth" style="float:left; text-align:center; width:160px">
                                                 <asp:CheckBox runat="server" ID="chkTotal" CssClass="mobile-switch" meta:ResourceKey="lblUpToLine1"/>
                                                 <asp:Label ID="lblUpToLine1" runat="server" Text="Up to" visible="false"></asp:Label>
                                            </div>
                                            <div class="ControlWidth" style="float:right; width:240px">
                                                 <asp:TextBox ID="txtAllowbillingUpTo" MaxLength="15" CssClass="Percent" MinNumber="0" Width="60px" runat="server"></asp:TextBox>
                                                 <asp:Label ID="lblUpToTotal" runat="server" Text="revised value" meta:ResourceKey="lblUpToTotal21"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                     <tr id="trUpToLine" runat="server">
                                        <td>
                                             <div class="labelWidth" style="float:left; text-align:center; width:160px">
                                                 <asp:CheckBox runat="server" ID="chkLine" CssClass="mobile-switch" meta:ResourceKey="lblUpToLine1"/>
                                             </div>
                                            <div class="ControlWidth" style="float:right; width:240px">
                                                 <asp:TextBox ID="txtLineAllowbillingUpTo" MaxLength="15" CssClass="Percent" MinNumber="0" Width="60px" runat="server"></asp:TextBox>
                                                <asp:Label ID="lblUpToLine" runat="server" Text="line item" meta:ResourceKey="lblUpToLine21"></asp:Label>
                                            </div>
                                           
                                        </td>
                                    </tr>
                                           </table>
                                       </td>
                                    </tr>
                                </table>
                            </fieldset>

                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblRecap" class="legend" runat="server" Text="RECAP" meta:Resourcekey="lblRecap"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <table class="colTable" style="text-align: center; color: #666666; text-transform: uppercase;">
                                                <tr>
                                                    <td style="width: 60%;" class="NoWrap">
                                                        <asp:Label ID="lblCosts" meta:resourcekey="lblCosts" runat="server" Text="Costs" Style="text-transform: uppercase; color: #999999;"></asp:Label>
                                                    </td>
                                                    <td style="width: 40%;" class="NoWrap">
                                                        <asp:Label ID="lblDaysHeader" meta:resourceKey="lblDays" runat="server" Text="Days" Style="text-transform: uppercase; color: #999999;"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOriginalValue" meta:resourcekey="lblOriginalValue" runat="server" Text="Original Value"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtOriginalValue" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtOriginalValueDays" CssClass="Days" runat="server" Width="98%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblApprovedChanges" meta:resourcekey="lblApprovedChanges" runat="server" Text="Approved Changes"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtApprovedChanges" CssClass="Currency" Width="100%" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtApprovedChangesDays" CssClass="Days" runat="server" Width="98%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRevisedValue" meta:resourcekey="lblRevisedValue" runat="server" Text="Revised Value"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtRevisedValue" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtRevisedValueDays" CssClass="Days" runat="server" Width="98%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblInvoiced" meta:resourcekey="lblBilled" runat="server" Text="Invoiced"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtInvoiced" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;" runat="server" id="overbilled">
                                                        <asp:LinkButton runat="server" ID="imgOverbilled" OnClientClick="return OpenOverbillingStatePopup();"
                                                            CausesValidation="False" CssClass="Warning" TabIndex="-1" Visible="false"> 
                                                                        <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRetained" meta:resourcekey="lblRetained" runat="server" Text="Retained"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtRetained" runat="server" CssClass="Currency" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBalance" meta:resourcekey="lblBalanceDue" runat="server" Text="Balance"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtBalance" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPaid" meta:resourcekey="lblPaid" runat="server" Text="Paid"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtPaid" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOpenBalance" meta:resourcekey="lblOpenBalance" runat="server" Text="Open Balance"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtOpenBalance" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblUnbilled" meta:resourcekey="lblUnbilled" runat="server" Text="Unbilled"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtUnbilled" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPendingChanges" meta:resourcekey="lblPendingChanges" runat="server" Text="Pending Changes"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtPendingChanges" runat="server" CssClass="Currency" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtPendingChangesDays" runat="server" CssClass="Days" Width="98%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProjectedValue" meta:resourcekey="lblProjectedValue" runat="server" Text="Projected Value"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 60%;">
                                                        <asp:TextBox ID="txtProjectedValue" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 40%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtProjectedValueDays" CssClass="Days" runat="server" Width="98%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset runat="server" id="tdDelivery">
                                <legend class="legend">
                                    <asp:Label ID="lblDelivery" runat="server" Text="Delivery" meta:Resourcekey="lblDelivery"></asp:Label>
                                </legend>
                                <table class="colTable ">
                                    <tr id="trDueDate" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDueDate" runat="server" Text="Due Date" meta:Resourcekey="lblDueDate"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_txtDueDate" style="display: block">
                                                <telerik:RadDatePicker ID="txtDueDate" runat="server" Culture="English (United States)" Skin="Default">
                                                    <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>
                                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                </telerik:RadDatePicker>
                                            </span>
                                            <asp:RequiredFieldValidator ID="rfvDueDate" ControlToValidate="txtDueDate"
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr id="trSchedueledDeliveryDate" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSchedueledDeliveryDate" meta:resourceKey="lblSchedueledDeliveryDate" runat="server" Text="Scheduled Delivery Date" Width="150px"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_txtSchedueledDeliveryDate" style="display: block">
                                                <telerik:RadDatePicker ID="txtSchedueledDeliveryDate" runat="server" Culture="English (United States)"
                                                    Skin="Default">
                                                    <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>
                                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                </telerik:RadDatePicker>
                                            </span>
                                            <asp:RequiredFieldValidator ID="rfvScheduledDeliveryDate" ControlToValidate="txtSchedueledDeliveryDate"
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" meta:resourcekey="lblVia" ID="lblVia" Text="Ship Via"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlVia" MarkFirstMatch="true" Filter="Contains" AllowCustomText="True" runat="server" Skin="Default"
                                                CloseDropDownOnBlur="true" NoWrap="true" ShowToggleImage="true">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvShipVia" runat="server" ControlToValidate="ddlVia"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor="" Visible="false">
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvShipVia" runat="server" ControlToValidate="ddlVia"
                                                ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <div style="float: left">
                                                <asp:Label ID="lblShipTo" runat="server" meta:resourcekey="lblShipTo" Text="Ship To"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="imgFilterShipTo" CssClass="SearchButton"
                                                    OnClientClick="return showShipToPopup();">
    					                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtShipTo" TextMode="MultiLine" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvShipTo" ControlToValidate="txtShipTo"
                                                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc17:AssetRotator ID="PMrot" runat="server" />
                            <uc16:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>

        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit">
            <uc2:CommitmentsDetails ID="CommitmentsDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc10:DocumentAdjustments ID="DocumentAdjustments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc12:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc13:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvCostImpact" runat="server">
            <uc15:CostImpacts ID="CostImpacts1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChangeOrders" runat="server">
            <uc9:CommitmentChanges ID="CommitmentChanges1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvProgressInvoices" runat="server">
            <uc8:ProgressInvoices ID="ProgressInvoices1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPayments" runat="server">
            <uc14:APPaymentApplication ID="APPaymentApplication1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc3:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc15:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc11:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <asp:Button ID="btnLoadPaymentTab" runat="server" CssClass="Hide" />
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
        InitialBehavior="None" Left="" Style="display: none;"
        Top="">
        <Windows>
            <telerik:RadWindow ID="wndItems" runat="server" Skin="Default"
                Height="600px" Width="900px"
                Title="Items" VisibleStatusbar="False" ReloadOnShow="True" Modal="True" OnClientClose="WindowClosed"
                Behavior="Default" InitialBehavior="None" Left=""
                Style="display: none;" Top="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
