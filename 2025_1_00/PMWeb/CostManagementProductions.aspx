<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementProductions.aspx.vb" Inherits="Website.CostManagementProductions" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementProductionDetails.ascx" TagName="ProductionDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc10" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    
    <script src="JS/Costs/Production.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.ProductionInfo.ProjectId %>';
            var forceMoreMenuToClose = true;
            function contextM(div, event) {
                var DetailId = 0;
                var str = div.id;
                DetailId = str.substring(7);

                if (DetailId != '0') {
                    OpenPOPUp("UnitRecap.aspx?Source=COSTMANAGEMENTPRODUCTION&DetailId=" +
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
                var RecordCurrencyId = '<%=PM.CostManagement.ProductionInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=COSTMANAGEMENTPRODUCTION&Id=" +
                                     '<%= PM.CostManagement.ProductionInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.ProductionInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.CostManagement.ProductionInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.ProductionInfo.ProductionName)%>';
                var Description = '<%=JSEscape(PM.CostManagement.ProductionInfo.ProductionName)%>';
                var Id = '<%= PM.CostManagement.ProductionInfo.Id%>'
                var HasMergeTemplate = '<%= PM.CostManagement.ProductionInfo.HasMergeTemplate%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("COSTMANAGEMENTPRODUCTION")%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=COSTMANAGEMENTPRODUCTION&Id=" +
                               '<%= PM.CostManagement.ProductionInfo.Id%>' + "&Description="
                                            + Description
                                            + "&RecordDescription=" + RecordDescription
                                            + "&EntityId=" + '<%=PM.CostManagement.ProductionInfo.ProjectId%>' + "&EntityType=0", "Notification",
                                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=COSTMANAGEMENTPRODUCTION&Id=" + Id
                            + "&EntityId=" + '<%=PM.CostManagement.ProductionInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENTPRODUCTION&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.CostManagement.ProductionInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;

                        case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENTPRODUCTION&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.CostManagement.ProductionInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'New':
                        window.location = "CostManagementProductions.aspx";
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('COSTMANAGEMENTPRODUCTION');
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=COSTMANAGEMENTPRODUCTION&Id=" +
                                    '<%= PM.CostManagement.ProductionInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.ProductionInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    default:
                        break;
                }
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
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
       <style>
           .CreateNext{
               border: 1px solid #666666;
    text-align: center;
    color: #666666;
    line-height: 1.8;
    border-radius: 2px;
    background-color: #FFFFFF;
    vertical-align: central;
    height: 32px;
    text-decoration: none;
    width: 100%;
    cursor: pointer;
    border-radius: 5px;
}
           
       </style>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
          <telerik:AjaxSetting AjaxControlID="mlpProductions">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpProductions" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpProductions" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
            </UpdatedControls>
        </telerik:AjaxSetting>
       
           <%-- <telerik:AjaxSetting AjaxControlID="ProductionDetails">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProductions" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle; width: 100%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" ValidationGroup="Save" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                       
                        <telerik:RadToolBarButton ID="btnCreateNext" PostBack="true" runat="server" CssClass="lnkCreateNext" OuterCssClass="HideOnMobileToolbar" Value="CreateNext"
                            meta:resourcekey="btnCreateNext" CommandName="CreateNext" Text="Create Next" ImageUrl="Images/ToolBar/PMWebW.gif" OnClientClick="DisablebtnCreateNext(this)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add"
                                    CommandName="CreateRevision" Visible="false">
                                </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#Productions"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('COSTMANAGEMENTPRODUCTION');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                 <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('COSTMANAGEMENTPRODUCTION');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>                                                                                           
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                          <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" CssClass="documentTabs"
        runat="server" MultiPageID="mlpProductions" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="true" CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpProductions" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement,Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="true" CausesValidation="false"
                                            Height="300px"
                                            NoWrap="true" Skin="Default" Width="100%"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:Panel ID="pnlUniqueID" runat="server" Visible="false">
                                            <asp:Label ID="lblUniqueID" runat="server" CssClass="Validator"
                                                meta:resourcekey="ErrorMsg_UniqueID"></asp:Label>
                                        </asp:Panel>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" runat="server" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"
                                            Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProductionNumber" runat="server" Text="Production #" meta:Resourcekey="lblProductionNumber"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProductionNumber" runat="server" CssClass="Right" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="Label11" runat="server" Text="Contract" meta:Resourcekey="lblContracts"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPrimeContracts" runat="server" Width="100%" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" AutoPostBack="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPrimeContractId" runat="server" ControlToValidate="ddlPrimeContracts"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPrimeContractId" runat="server" ControlToValidate="ddlPrimeContracts"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
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
                                        <asp:Label ID="lblCommitment" runat="server" meta:ResourceKey="Label_Commitment"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCommitments" runat="server" Width="100%"
                                            Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                            EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" AutoPostBack="true" EnableLoadOnDemand="True"
                                            ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCommitmentId" runat="server" ControlToValidate="ddlCommitments"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCommitmentId" runat="server" ControlToValidate="ddlCommitments"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompany" runat="server" Text="<%$Resources:CostManagement, Label_Company %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                                            Filter="Contains" MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                            EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px"
                                            Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCompanyId" runat="server" ControlToValidate="ddlCompanies"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCompanyId" runat="server" ControlToValidate="ddlCompanies"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" cellpadding="0" cellspacing="0" width="100%" border="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" Skin="Default"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td width="50%" style="padding-left: 8px; text-align: right;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevisionNumber"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevisionDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="80px" Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Default" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc10:AssetRotator ID="PMrot" runat="server" />
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFromDate" runat="server" meta:resourceKey="lblFromDate" Text="From"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpFromDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpFromDate" runat="server"
                                                Culture="English (United States)" MaxDate="2100-01-01" MinDate="1901-01-01"
                                                SelectedDate="<%# Date.Today %>" Skin="Default" Width="99%">
                                                <DateInput ID="DateInput1" runat="server"
                                                    LabelCssClass="radLabelCss_Default" Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar1" runat="server"
                                                    Skin="Default">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvFromDate" Enabled="false" Visible="false" runat="server"
                                            ControlToValidate="dtpFromDate" CssClass="Validator" Display="Dynamic"
                                            ErrorMessage="&lt;br&gt;Enter a date!"
                                            meta:Resoucekey="WarningMsg_DateIsRequired"
                                            meta:ResourceKey="WarningMsg_DateIsRequired" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblToDate" runat="server" meta:Resourcekey="lblToDate"
                                            Text="To"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpToDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpToDate" runat="server"
                                                Culture="English (United States)" MaxDate="2100-01-01" MinDate="1901-01-01"
                                                SelectedDate="<%# Date.Today %>" Skin="Default">
                                                <DateInput ID="DateInput2" runat="server"
                                                    LabelCssClass="radLabelCss_Default" Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar2" runat="server"
                                                    Skin="Default">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator Enabled="false" Visible="false" ID="rfvToDate" runat="server"
                                            ControlToValidate="dtpToDate" CssClass="Validator" Display="Dynamic"
                                            ErrorMessage="&lt;br&gt;Enter a date!"
                                            meta:ResourceKey="WarningMsg_DateIsRequired" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="cmvDateRange" runat="server"
                                            ControlToCompare="dtpFromDate" ControlToValidate="dtpToDate"
                                            CssClass="Validator" Display="Dynamic"
                                            ErrorMessage="The To date must be greater than From"
                                            meta:Resourceskey="WarningMsg_To_From" Operator="GreaterThanEqual"
                                            ValidationGroup="Save"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>

                                    <td class="labelWidth">
                                        <asp:Label ID="lblPeriod" runat="server" Text="<%$Resources:CostManagement, Label_Period %>"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPeriods" runat="server" AutoPostBack="false" Type="OutQuint"
                                            Skin="Default" Width="100%" Height="300px" NoWrap="true" CausesValidation="false"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPeriod" runat="server" Visible="false" ControlToValidate="ddlPeriods"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default"
                                            Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType" ValidateEmptyText="true"
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
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default"
                                            Style="font-size: 11px">
                                        </telerik:RadComboBox>
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
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblIsPostToCostLedger" runat="server" meta:ResourceKey="chkIsPostToCostLedger"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkIsPostToCostLedger" runat="server" Text="" Style="float: right" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:ProductionDetails ID="ProductionDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc6:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <asp:Panel ID="pnlProductionUnique" runat="server" Visible="false">
        <asp:Label ID="lblProductionUnique" runat="server" CssClass="Validator"
            Text="<%$ Resources:CostManagement, ProductionUnique %>"></asp:Label>
    </asp:Panel>
</asp:Content>
    
