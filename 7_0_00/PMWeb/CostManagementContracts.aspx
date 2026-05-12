<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementContracts.aspx.vb" Inherits="Website.CostManagementContracts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementContractDetails.ascx" TagName="CostManagementContractDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc7" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="CostManagementAPPaymentApplication.ascx" TagName="APPaymentApplication" TagPrefix="uc14" %>
<%@ Register Src="ContractRequistions.ascx" TagName="Requisitions" TagPrefix="uc15" %>
<%@ Register Src="ContractChanges.ascx" TagName="ContractChanges" TagPrefix="uc16" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc17" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc18" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc8" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Costs/PrimeContracts.js" type="text/javascript"></script>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpContactInvoices">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpContactInvoices" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpContactInvoices" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <style>
            .RadioCss input {
                position: absolute;
                margin-top: 0px;
                height: 18px;
                width: 18px;
                background-color: #ffffff !important;
                border-radius: 50%;
                border-color: #666666 !important;
            }
        </style>
        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.PrimeContractInfo.ProjectId %>';
            function contextM(div, event) {
                var DetailId = 0;
                var str = div.id;
                DetailId = str.substring(7);

                if (DetailId != '0') {
                    OpenPOPUp("UnitRecap.aspx?Source=COSTMANAGEMENT_CONTRACT&DetailId=" +
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
                var RecordCurrencyId = '<%=PM.CostManagement.PrimeContractInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=COSTMANAGEMENT_CONTRACT&Id=" +
                                  '<%= PM.CostManagement.PrimeContractInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.PrimeContractInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
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
                var HasReports = '<%= PM.CostManagement.PrimeContractInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.PrimeContractInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.PrimeContractInfo.Description)%>';
                var Id = '<%= PM.CostManagement.PrimeContractInfo.Id%>';
                var HasMergeTemplate = '<%= PM.CostManagement.PrimeContractInfo.HasMergeTemplate%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("COSTMANAGEMENT_CONTRACT")%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENT_CONTRACT&Id=" +
                                '<%= PM.CostManagement.PrimeContractInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PrimeContractInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=COSTMANAGEMENT_CONTRACT&Id=" +
                               '<%= PM.CostManagement.PrimeContractInfo.Id%>' + "&Description="
                                            + Description
                                            + "&RecordDescription=" + RecordDescription
                                            + "&EntityId=" + '<%=PM.CostManagement.PrimeContractInfo.ProjectId%>' + "&EntityType=0", "Notification",
                                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                        break;
                    case 'PaymentSchedule':
                        if (Id == 0) break;
                        var Sleft = (screen.width - 850) / 2;
                        var Stop = (screen.height - 500) / 2;
                        OpenPOPUp("ARPaymentSchedule.aspx", "",
                                   'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=850,height=500,top=' + Stop + ',left=' + Sleft, 1045, 515, false);
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=COSTMANAGEMENT_CONTRACT&Id=" + Id
                            + "&EntityId=" + '<%=PM.CostManagement.PrimeContractInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=\COSTMANAGEMENT_CONTRACT&Id=" +
                                    '<%= PM.CostManagement.PrimeContractInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PrimeContractInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('COSTMANAGEMENT_CONTRACT');
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENT_CONTRACT&Id=" +
                                '<%= PM.CostManagement.PrimeContractInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.PrimeContractInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                    case 'New':
                        window.location = "CostManagementContracts.aspx";
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
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar SmallToolbar">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=112">
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
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlPrimeContracts" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" AutoPostBack="false" NoWrap="true"
                    Height="250px" CausesValidation="False" AllowCustomText="true"
                    EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar"
                    runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=112" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" PostBack="false" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png" ValidationGroup="Save">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>


                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" OuterCssClass="HideOnMobileToolbar"
                            CssClass="ToolbarPrint" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
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
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
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
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Payment Schedule" Value="PaymentSchedule"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('COSTMANAGEMENT_CONTRACT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('COSTMANAGEMENT_CONTRACT');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" CssClass="Help" Text="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            CssClass="ToolbarGenerate HideOnMobileToolbar" EnableDefaultButton="false">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Payment Schedule" Width="150px" Value="PaymentSchedule" CommandName="PaymentSchedule" ImageUrl="Images/ToolBar/PMWebW.gif" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#Contracts"></telerik:RadToolBarButton>
                         <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <asp:Button ID="btnLoadPaymentTab" runat="server" CssClass="Hide" />

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpContactInvoices" CssClass="documentTabs"
        Skin="Default" Width="100%" EnableViewState="True" ScrollChildren="true" ScrollButtonsPosition="Left">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" Selected="True" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Change Orders" Value="ChangeOrders"></telerik:RadTab>
            <telerik:RadTab Text="Requisitions" Value="Requisitions"></telerik:RadTab>
            <telerik:RadTab Text="Payments" Value="Payments"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpContactInvoices" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True"
                                            Skin="Default" NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
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
                                        <asp:Label ID="lblID" runat="server" Text="ID*" meta:Resourcekey="lblID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="20" ID="txtID" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" meta:Resourcekey="rfvCodes" ValidationGroup="Save" ControlToValidate="txtID"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="Required" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblIDUnique" meta:Resourcekey="lblIDUniqueSetting" runat="server" Text="ID must be unique by project." Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
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
                                        <div style="width: 100%; white-space: nowrap">
                                            <telerik:RadComboBox
                                                ID="ddlCompanies" runat="server" Height="200px" Skin="Default" OnClientDropDownClosed="dllcompClientClosed"
                                                CloseDropDownOnBlur="true" NoWrap="False" OnItemsRequested="ddl_ItemsRequested"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" AutoPostBack="True">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvCompany" runat="server" ControlToValidate="ddlCompanies"
                                                ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lbDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="500" ID="txtDescription" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
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
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"
                                            Style="font-size: 11px" MarkFirstMatch="true">
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
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:CostManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px;">
                                                    <asp:TextBox ID="txtRevision" CssClass="PositiveInteger" MaxLength="9" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="text-align: right;">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEffectiveDate" meta:Resourcekey="lblEffectiveDate" runat="server" Text="Effective Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpEffectiveDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpEffectiveDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvEffectiveDate" ControlToValidate="dtpEffectiveDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="trDays" style="margin-top: 5px;" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDays" runat="server" meta:Resourcekey="lblDays" Text="Days"></asp:Label>
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
                                        <asp:Label ID="lblPaidInFull" meta:resourcekey="lblPaidInFull" runat="server" Text="Paid In Full"></asp:Label>
                                    </td>
                                    <td class="controlWidth chkBox">
                                        <asp:CheckBox ID="chkPaidInFull" runat="server" ClientIDMode="Static" />
                                        <label for="chkPaidInFull">
                                            <i class="icon"></i>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                            <fieldset runat="server" id="trOverbilling">
                                <legend>
                                    <asp:Label ID="lblBilling" runat="server" meta:Resourcekey="lblBilling" Text="Billing"></asp:Label>
                                </legend>
                                <table class="colTable" style="color: #666666;">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBillingTerms" meta:Resourcekey="lblBillingTerms" runat="server" Text="Billing Terms"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBillingTerms" runat="server" Skin="Default" Style="font-size: 11px" MarkFirstMatch="true" Filter="Contains" Width="100%" AllowCustomText="True"></telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvBillingTerms" runat="server" ControlToValidate="ddlBillingTerms"
                                                CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvBillingTerms" runat="server" ControlToValidate="ddlBillingTerms" ValidateEmptyText="true"
                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr id="trRetentionOnServices" runat="server">
                                         <td colspan="2">
                                            <div style="float:left">
                                            <asp:Label ID="lblRetentionOnServices" meta:Resourcekey="lblRetentionOnServices" runat="server" Text="Retention on Services"></asp:Label>
                                            </div>
                                         <div style="float:right">
                                            <asp:TextBox ID="txtRetentionOnServices" runat="server" CssClass="Percent"
                                                MaxNumber="100" MinNumber="0" Width="60px"></asp:TextBox>
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
                                            <asp:Label ID="lblRetentionOnMaterials" meta:Resourcekey="lblRetentionOnMaterials"
                                                runat="server" Text="Retention on Stored Materials"></asp:Label>
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
                                            <div style="float:left"> 
                                            <asp:Label ID="lblRevised" meta:resourcekey="lblRevised" runat="server" Text="Use Revised Units by Default"></asp:Label>
                                     </div>
                                         <div style="float:right"> 
                                            <asp:CheckBox ID="chkRevised" runat="server" Checked="false" ClientIDMode="Static" />
                                           <%-- <label for="chkRevised">
                                                <i class="icon"></i>
                                            </label>--%>
                                             </div>
                                        </td>
                                    </tr>
                                    <tr>
                                         <td colspan="2">
                                            <div style="float:left"> 
                                            <asp:Label ID="lblDefaultMarkup" runat="server" meta:Resourcekey="lblDefaultMarkup" Text="Default Markup" Visible="false"></asp:Label>
                                       </div>
                                        <div style="float:right"> 
                                            <asp:TextBox ID="txtDefaultMarkup" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0" Visible="false"></asp:TextBox>
                                        </div>
                                            </td>
                                    </tr>
                                     <tr>
                                        <td colspan="2" style="padding-bottom:0px">
                                             <asp:RadioButtonList ID="rblOverBilling" AutoPostBack="true" runat="server" CssClass="labelColor RadioCss RadioPadding" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                                <asp:ListItem meta:resourcekey="lblDoNotAllowOverbilling" Text="" Value="DoNotAllow"> </asp:ListItem>
                                                <asp:ListItem meta:resourcekey="lblAllowbilling" Text="" Value="Allow"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                     <tr id="trUpToTotal" runat="server">
                                        <td colspan="2">
                                             <div class="labelWidth" style="float:left; text-align:center; width:160px">
                                                  <asp:CheckBox runat="server" ID="chkTotal" CssClass="mobile-switch" meta:ResourceKey="lblUpToTotal1" />
                                                  <asp:Label ID="lblUpToTotal1" runat="server" Visible="false"   Text="Up to" ></asp:Label>
                                              </div>
                                             <div class="ControlWidth" style="float:right; width:240px">
                                                  <asp:TextBox ID="txtAllowbillingUpTo" MaxLength="15" CssClass="Percent" MinNumber="0" runat="server" Width="60px"></asp:TextBox>
                                                   <asp:Label ID="lblUpToTotal2" runat="server" Text="% of revised value" meta:ResourceKey="lblUpToTotalValue"></asp:Label>
                                             </div>
                                            </td>
                                         </tr>
                                    <tr id="trUpToLine" runat="server">
                                         <td colspan="2">
                                               <div class="labelWidth" style="float:left; text-align:center; width:160px">
                                                      <asp:CheckBox runat="server" ID="chkLine" CssClass="mobile-switch"  meta:ResourceKey="lblUpToLine1" />
                                                     <asp:Label ID="lblUpToLine1" runat="server" Text="Up to" Visible="false"></asp:Label>
                                                   </div>
                                               <div class="ControlWidth" style="float:right; width:240px">
                                                     <asp:TextBox ID="txtLineAllowbillingUpTo" MaxLength="15" CssClass="Percent" MinNumber="0" runat="server" Width="60px"></asp:TextBox>
                                                    <asp:Label ID="lblUpToLine2" runat="server" Text="% of line item" meta:ResourceKey="lblUpToLineItem"></asp:Label>
                                               </div>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server" id="fldsetContractRecap">
                                <legend>
                                    <asp:Label ID="lblRecap" runat="server" meta:Resourcekey="lblRecap" Text="Contract Recap"></asp:Label>
                                </legend>
                                <table class="colTable ">
                                    <tr>
                                        <td class="labelWidth"></td>
                                        <td class="controlWidth">
                                            <table class="colTable" style="text-align: center; text-transform: uppercase;">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px" class="NoWrap">
                                                        <asp:Label ID="lblCosts" meta:resourcekey="lblCosts" runat="server" Text="Costs" Style="text-transform: uppercase; color: #999999;"></asp:Label>
                                                    </td>
                                                    <td style="width: 50px;" class="NoWrap">
                                                        <asp:Label ID="lblDaysHeader" meta:Resourcekey="lblDays" runat="server" Text="Days" Style="text-transform: uppercase; color: #999999;"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOrigValue" meta:Resourcekey="lblOriginalvalue" runat="server" Text="Original Value"></asp:Label></td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px;">
                                                        <asp:TextBox ID="txtOrigValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">
                                                        <asp:TextBox ID="txtOriginalValueDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblApprovedChanges" meta:Resourcekey="lblApprovedChanges" runat="server" Text="Approved Changes"></asp:Label></td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px;">
                                                        <asp:TextBox ID="txtApprovedChanges" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">
                                                        <asp:TextBox ID="txtApprovedChangesDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRevisedValue" meta:Resourcekey="lblRevisedValue" runat="server" Text="Revised Value"></asp:Label></td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px;">
                                                        <asp:TextBox ID="txtRevisedValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">
                                                        <asp:TextBox ID="txtRevisedValueDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblInvoiced" meta:Resourcekey="lblBilled" runat="server" Text="Invoiced"></asp:Label></td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px">
                                                        <asp:TextBox ID="txtInvoiced" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRetained" meta:Resourcekey="lblRetained" runat="server" Text="Retained"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px;">
                                                        <asp:TextBox ID="txtRetained" runat="server" CssClass="Currency"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBalance" meta:Resourcekey="lblBalanceDue" runat="server" Text="Balance"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px">
                                                        <asp:TextBox ID="txtBalance" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPaid" meta:resourcekey="lblPaymentsApplied" runat="server" Text="Paid"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px">
                                                        <asp:TextBox ID="txtPaid" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOpenBalance" meta:resourcekey="lblOpenBalance" runat="server" Text="Open Balance"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px">
                                                        <asp:TextBox ID="txtOpenBalance" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblUnbilled" meta:resourcekey="lblUnbilled" runat="server" Text="Unbilled"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px">
                                                        <asp:TextBox ID="txtUnbilled" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPendingChanges" meta:Resourcekey="lblPendingChanges" runat="server" Text="Pending Changes"></asp:Label></td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px">
                                                        <asp:TextBox ID="txtPendingChanges" runat="server" CssClass="Currency"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">
                                                        <asp:TextBox ID="txtPendingChangesDays" runat="server" CssClass="Days"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProjectedValue" meta:Resourcekey="lblProjectedValue" runat="server" Text="Projected Value"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 182px; padding-right: 8px;">
                                                        <asp:TextBox ID="txtProjectedValue" CssClass="Currency" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50px">
                                                        <asp:TextBox ID="txtProjectedValueDays" CssClass="Days" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>
                            </fieldset>


                        </div>
                        <div class="col-4 col-4-right">
                            <uc8:AssetRotator ID="PMrot" runat="server" />
                            <uc18:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>

            </telerik:RadAjaxPanel>

        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit">
            <uc1:CostManagementContractDetails ID="CostManagementContractDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc7:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChangeOrders" runat="server">
            <uc16:ContractChanges ID="ContractChanges1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRequisitions" runat="server">
            <uc15:Requisitions ID="Requisitions1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvPayments" runat="server">
            <uc14:APPaymentApplication ID="ARPaymentApplication1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc5:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc17:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc6:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
