<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Requisitions.aspx.vb" Inherits="Website.Requisitions" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementRequisitionDetails.ascx" TagName="RequisitionDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc3" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="CostManagementAPPaymentApplication.ascx" TagName="ARPaymentApplication" TagPrefix="uc11" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc13" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
            <telerik:AjaxSetting AjaxControlID="mlpRequisitions">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRequisitions" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpRequisitions" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.RequisitionInfo.ProjectId %>';
            function OpenProductionPopup() {
                OpenPOPUp("ProductionPopup.aspx?Source=REQUISITION", 700, 500, true);
            }

            function contextM(div, event) {
                var DetailId = 0;
                var str = div.id;
                DetailId = str.substring(7);

                if (DetailId != '0') {
                    OpenPOPUp("UnitRecap.aspx?Source=REQUISITION&DetailId=" +
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
                var RecordCurrencyId = '<%=PM.CostManagement.RequisitionInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=REQUISITION&Id=" +
                                 '<%= PM.CostManagement.RequisitionInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Void") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Void");
                    button.click();
                }
                if (args.get_item().get_value() == "CreateNext") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("CreateNext");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%=  PM.CostManagement.RequisitionInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.RequisitionInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.RequisitionInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.RequisitionInfo.Description)%>';
                var Id = '<%= PM.CostManagement.RequisitionInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("REQUISITION") %>';
               
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=REQUISITION&Id=" +
                                '<%= PM.CostManagement.RequisitionInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=REQUISITION&Id=" +
                                '<%= PM.CostManagement.RequisitionInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=REQUISITION&Id=" +
                                '<%= PM.CostManagement.RequisitionInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=REQUISITION&Id=" +
                               '<%= PM.CostManagement.RequisitionInfo.Id%>' + "&Description="
                                            + Description
                                            + "&RecordDescription=" + RecordDescription
                                            + "&EntityId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&EntityType=0", "Notification",
                                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                          break;

                      case 'ViewPMWebReports':
                          var left = (screen.width - 900) / 2;
                          var top = (screen.height - 500) / 2;
                          if (HasPMWebReports == 'True' && Id > 0) {
                              OpenPOPUp("PMWebReports.aspx?ObjectType=REQUISITION&Id=" + Id
                              + "&EntityId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                          break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=REQUISITION&Id=" +
                                '<%= PM.CostManagement.RequisitionInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.RequisitionInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('REQUISITION');
                        break;

                    case 'New':
                        window.location = "Requisitions.aspx";
                        break;

                    default:
                        break;
                }
            }

            function DisablebtnCreateNext(me) {
                if (Page_ClientValidate('Save')) {
                    me.setAttribute('disabled', 'disabled');
                    DisablePanelAjax();
                }
            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }

        </script>
    </telerik:RadCodeBlock>
    <script src="JS/Costs/Requisitions.js" type="text/javascript"></script>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar SmallToolbar">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=115">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlRequisitions" runat="server" Filter="Contains" MarkFirstMatch="true"
                    CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false" NoWrap="true" DropDownCssClass="ddlTreeviewTemplate ToolbarDropdown"
                    Height="250px" CausesValidation="False" CheckForDirt="True">
                    <Items>
                        <telerik:RadComboBoxItem Text="" />
                    </Items>
                    <ItemTemplate>
                        <div id="div1">
                            <telerik:RadTreeView ID="rdvRequisitionList" runat="server"
                                Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="MainTree_NodeClicking"
                                OnNodeDataBound="rdvRequisitionList_NodeDataBound" OnNodeExpand="rdvRequisitionList_NodeExpand">
                            </telerik:RadTreeView>
                        </div>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar"
                    runat="server" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=115" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" PostBack="false" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton ID="btnCreateNext" meta:resourcekey="btnCreateNext" PostBack="true" Value="CreateNext" CommandName="CreateNext" OuterCssClass="HideOnMobileToolbar"
                            runat="server" Text="Create Next" OnClientClick="DisablebtnCreateNext(this)" ValidationGroup="Save" CssClass="lnkCreateNext" ImageUrl="Images/ToolBar/PMWebW.gif">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete"
                            AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Void.png" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarVoid"
                            CommandName="Void" AccessKey="v" ToolTip="Void (Alt+v)" Value="Void" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>



                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                         <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb View Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem SecurityButtonType="Edit" EnableImageSprite="true" Text="Void" Value="Void" CssClass="Void"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Create Next" Value="CreateNext" CssClass="CreateNext"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('REQUISITION');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('REQUISITION');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" CssClass="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#Requisitions"></telerik:RadToolBarButton>
                    
                          <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpRequisitions" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Width="100%" EnableViewState="True">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Adjustments" Value="Adjustments"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Payments" Value="Payments"></telerik:RadTab>
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpRequisitions" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr id="trVoid" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVoid" meta:resourcekey="lblVoid" runat="server" Text="Void"></asp:Label>
                                    </td>
                                    <td class="controlWidth chkBoxDisabled">
                                        <label id="imgVoid" runat="server">
                                            <i class="icon"></i>
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True"
                                            NoWrap="true" Width="100%" Height="300px"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID%>">
                                        </asp:CustomValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblContract" runat="server" Text="Contract*" meta:resourcekey="lblContract"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlContracts" runat="server" Width="100%"
                                            CloseDropDownOnBlur="true" NoWrap="False" EmptyMessage="Select a Contract..."
                                            AllowCustomText="true" AutoPostBack="true" Style="font-size: 11px" Height="250px"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>

                                        <asp:RequiredFieldValidator ID="rfvContracts" runat="server" ControlToValidate="ddlContracts"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <%--<asp:RequiredFieldValidator ID="rfvContracts2" runat="server" ControlToValidate="ddlContracts"
                                                CssClass="Validator" InitialValue="<%$ Resources:PMWeb, DASHSELECT%>" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_SelectContract%>"
                                                Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                                        <asp:CustomValidator ID="csvContracts" runat="server" ControlToValidate="ddlContracts"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID%>">
                                        </asp:CustomValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompany" runat="server" Text="<%$Resources:CostManagement, Label_Company %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCompany" MaxLength="100" Text="" ReadOnly="true"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoicenumber" runat="server" meta:resourcekey="lblInvoicenumber" Text="Invoice #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtInvoiceNumber" CssClass="Right" MaxLength="9" ReadOnly="true" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblChangeEventNumber" runat="server"
                                            Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" runat="server" MaxLength="20" ValidationGroup="Save"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" ValidationGroup="Save" Display="Dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <br />
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                            Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                        <asp:Label ID="lblMessage" runat="server" CssClass="Validator" ForeColor="Red"></asp:Label>

                                    </td>

                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="hplCurrency" Height="18px" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
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
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_StatusRevision%>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger" MaxLength="9" Width="100%" Text=""></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="100%" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput1" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCostPeriod" meta:resourcekey="lblCostPeriod" runat="server" Text="Cost Period"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostPeriod" runat="server" Width="100%"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCostPeriod" runat="server" ControlToValidate="ddlCostPeriod"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCostPeriod" runat="server" ControlToValidate="ddlCostPeriod"
                                            ClientValidationFunction="ValidateCostPeriodddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaidInFull" meta:resourcekey="lblPaidInFull" runat="server" Text="Paid In Full"></asp:Label>
                                    </td>
                                    <td class="controlWidth chkBox" style="text-align: right">
                                        <asp:CheckBox ID="chkPaidInFull" runat="server" ClientIDMode="Static" />
                                        <label for="chkPaidInFull">
                                            <i class="icon"></i>
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceDate" meta:resourcekey="lblInvoiceDate" runat="server" Text="Invoice Date" Width="100%"></asp:Label>
                                    </td>
                                    <td class="controllWidth">
                                        <span runat="server" id="rmd_dtpInvoiceDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpInvoiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" EnableTyping="True" AutoPostBack="true">
                                                <DateInput ID="DateInput4"
                                                    runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceDate" ControlToValidate="dtpInvoiceDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillingTerms" meta:Resourcekey="lblBillingTerms" runat="server" Text="Billing Terms" Width="100%"></asp:Label>
                                    </td>
                                    <td class="controllWidth">
                                        <telerik:RadComboBox ID="ddlBillingTerms" runat="server" AutoPostBack="true" MarkFirstMatch="true" Filter="Contains" AllowCustomText="True" Width="100%"></telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvBillingTerms" runat="server" ControlToValidate="ddlBillingTerms"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvBillingTerms" runat="server" ControlToValidate="ddlBillingTerms" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceDue" meta:resourcekey="lblInvoiceDue" Width="100%" runat="server" Text="Invoice Due"></asp:Label>
                                    </td>
                                    <td class="controllWidth">
                                        <span runat="server" id="rmd_dtpInvoiceDue" style="display: block">
                                            <telerik:RadDatePicker ID="dtpInvoiceDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" EnableTyping="True">
                                                <DateInput ID="DateInput5" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceDue" ControlToValidate="dtpInvoiceDue"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server" id="pldsetContrSnapshot">
                                <legend>
                                    <asp:Label ID="lblContractSnapshot" meta:resourcekey="lblContractSnapshot" runat="server" Text="Contract Snapshot"></asp:Label>
                                </legend>
                                <table runat="server" id="tblRecap" class="colTable" style="color: #666666 !important;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOriginalContract" meta:resourcekey="lblOriginalContract" runat="server" Text="Original Contract" Width="100%"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOriginalValue" ReadOnly="true" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblApprovedChanges" meta:resourcekey="lblApprovedChanges" Width="100%" runat="server" Text="Approved Change Orders"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtApprovedChanges" ReadOnly="true" CssClass="Currency" Width="100%" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRevisedContract" meta:resourcekey="lblRevisedContract" Width="100%" runat="server" Text="Revised Contract"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRevisedContract" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblInvoiced" Width="100%" meta:resourcekey="lblInvoiced" runat="server" Text="Total Invoiced"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInvoiced" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRetained" runat="server" meta:resourcekey="lblRetained" Text="Total Retained" Width="100%"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRetained" ReadOnly="true" runat="server" CssClass="Currency" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblEarnedLessRetainage" meta:resourcekey="lblEarnedLessRetainage" runat="server" Text="Earned Less Retainage"
                                                Width="100%"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEarnedLessRetainage" ReadOnly="true" runat="server" CssClass="Currency" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLessPriorInvoices" meta:resourcekey="lblLessPriorInvoices" Width="100%" runat="server" Text="Less Prior Invoices"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLessPriorInvoices" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTotalThisInvoice" meta:resourcekey="lblCurrentPaymentDue" Width="100%" runat="server" Text="Total This Invoice"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalThisInvoice" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblUnappliedPaymentsAvailable" Width="100%" meta:resourcekey="lblUnappliedPaymentsAvailable" runat="server" Text="Unapplied Payments Available"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUnappliedPaymentsAvailable" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPaymentsApplied" meta:resourcekey="lblPaymentsApplied" Width="100%" runat="server" Text="Payments Applied"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPaymentsApplied" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOpenBalance" meta:resourcekey="lblOpenBalance" Width="100%" runat="server" Text="Open Balance"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOpenBalance" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblBalanceToInvoice" meta:resourcekey="lblBalanceToInvoice" Width="100%" runat="server" Text="Balance To Invoice"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBalanceToInvoice" ReadOnly="true" Width="100%" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>

                        </div>
                        <div class="col-4 col-4-right">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc13:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:RequisitionDetails ID="RequisitionDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc10:DocumentAdjustments ID="DocumentAdjustments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc3:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPayments" runat="server">
            <uc11:ARPaymentApplication ID="ARPaymentApplication1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc5:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc12:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc2:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <script type="text/javascript">
        var div1 = document.getElementById("div1");
        div1.onclick = StopPropagation;
    </script>
    <asp:HiddenField ID="hdfCopyDetails" runat="server" />
</asp:Content>
