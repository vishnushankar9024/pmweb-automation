<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementFundingRequest.aspx.vb" Inherits="Website.CostManagementFundingRequest" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementFundingRequestDetails.ascx" TagName="CostManagementFundingRequestDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="ucNotes" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="UcAttachements" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="ucWorflow" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc3" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
               <telerik:AjaxSetting AjaxControlID="mlpFundingRequest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpFundingRequest" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
               </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpFundingRequest" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
           
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function ddlTasks_SelectedIndexChanged(sender, eventArgs) {
                var item = eventArgs.get_item();
                var itemId = item.get_parent()._clientStateFieldID;
                var tr = $("#" + itemId).parents(".rgEditForm:first");
                if (!tr || tr.length == 0)
                    tr = $("#" + itemId).parents("tr:first")
                var txtStart = tr.find("input[id$='txtStartDate']");
                var txtFinish = tr.find("input[id$='txtFinishDate']");
                txtStart.val(item.get_attributes().getAttribute("EarlyStartDate"));
                txtFinish.val(item.get_attributes().getAttribute("EarlyFinishDate"));
            }

            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.FundingRequestInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=FUNDINGREQUEST&Id=" +
                                     '<%= PM.CostManagement.FundingRequestInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.FundingRequestInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
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
                var HasReports = '<%= PM.CostManagement.FundingRequestInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.FundingRequestInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.FundingRequestInfo.Description)%>';
                var Id = '<%= PM.CostManagement.FundingRequestInfo.Id%>';
                var HasMergeTemplate = '<%= PM.CostManagement.FundingRequestInfo.HasMergeTemplate%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("FUNDINGREQUEST")%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=FUNDINGREQUEST&Id=" +
                                    '<%= PM.CostManagement.FundingRequestInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.FundingRequestInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                        case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=FUNDINGREQUEST&Id=" +
                                    '<%= PM.CostManagement.FundingRequestInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.FundingRequestInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=FUNDINGREQUEST&Id=" +
                               '<%= PM.CostManagement.FundingRequestInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.FundingRequestInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 890, 430, false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=FUNDINGREQUEST&Id=" + Id
                        + "&EntityId=" + '<%=PM.CostManagement.FundingRequestInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 890, 430, false);
                        }
                        break;

                    case 'New':
                        window.location = "CostManagementFundingRequest.aspx";
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('FUNDINGREQUEST');
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=FUNDINGREQUEST&Id=" +
                                    '<%= PM.CostManagement.FundingRequestInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.FundingRequestInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;


                    default:
                        break;
                }
            }


            function ValidateProgramCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();

                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.findItemByText(text);
                        if (value != null) {
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

            function ddlCurrencyLoad(sender, e) {
                currencyCombo = sender;
            }

            function onSelectedIndexChanged(sender, eventArgs) {
                var item = eventArgs.get_item();
                var currencyId = item.get_attributes().getAttribute("CurrencyId");
                //    alert(currencyCombo.get_value());
                var item = currencyCombo.findItemByValue(currencyId);
                currencyCombo.trackChanges();
                //    currencyCombo.set_value(currencyId);
                if (item)
                    item.select();
                currencyCombo.commitChanges();
                //    alert(currencyCombo.get_value()); 

            }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar SmallToolbar">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=87">
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
                <telerik:RadComboBox ID="ddlFundingRequest" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="100%" OnItemsRequested="ddl_ItemsRequested"
                    AutoPostBack="false" NoWrap="true" CausesValidation="False" Height="400px"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=87" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CausesValidation="true"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false" PostBack="false"
                                    meta:resourcekey="RadToolBarButtonResource1">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Copy" Width="150px" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png" ValidationGroup="Save">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" CommandName="CreateRevision" Visible="false" ImageUrl="Images/ToolBar/Revision.png">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="False">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
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

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
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
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('FUNDINGREQUEST');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('FUNDINGREQUEST');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem> 
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
                        <%--<telerik:RadToolBarButton CssClass="HideOnMobileToolbar" ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#FundingRequest"></telerik:RadToolBarButton>--%>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" OnTabClick="tbsDocument_TabClick" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpFundingRequest" Skin="Default"
        Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
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
    <telerik:RadMultiPage ID="mlpFundingRequest" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBudgetYear" meta:ResourceKey="lblBudgetYear" runat="server" Text="Year"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadNumericTextBox ID="rntBudgetYear" ShowSpinButtons="true"
                                            IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true"
                                            Label="" runat="server" EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>"
                                            MaxValue="2100" MinValue="1899">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="rfvYear" ControlToValidate="rntBudgetYear"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSource" meta:ResourceKey="lblSource" runat="server" Text="Source"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSource" runat="server" Skin="Default" NoWrap="true" Height="300px"
                                            Style="font-size: 11px" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvSourceId" runat="server" ControlToValidate="ddlSource"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvSourceId" runat="server" ControlToValidate="ddlSource" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCode" meta:ResourceKey="lblCode" runat="server" Text="Code"></asp:Label>

                                    </td>
                                    <td class="controlWidth">

                                        <asp:TextBox ID="txtCode" MaxLength="50" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" ControlToValidate="txtCode"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordNumber" runat="server"
                                            Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" MaxLength="10" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" ValidationGroup="Save" Display="Dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>

                                        <asp:Label ID="lblRecordNumberAlreadyExist" meta:ResourceKey="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" ForeColor="" Visible="false"
                                            Text="The Record # is already in use.<br/> Record # must be unique by the combination of Year, Program, Source and Code.<br/> Please enter a unique Record # and save again"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="500"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
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
                                        <div style="float: left">
                                            <asp:Label runat="server" CssClass="Link" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                                    <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" Style="font-size: 11px" Height="300px"
                                            OnClientLoad="ddlCurrencyLoad">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_Status %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td align="right" style="width: 50px">
                                                    <asp:TextBox ID="txtRevisionNumber" runat="server" CssClass="PositiveInteger" MaxLength="9"></asp:TextBox>
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
                                        <asp:Label ID="lblDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_txtRevisionDate" style="display: block">
                                            <telerik:RadDatePicker ID="txtRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Default" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"
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
                                        <asp:Label ID="lblPostAs" meta:Resourcekey="lblPostAs" runat="server" Text="Post as"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPostAs" runat="server" Skin="Default" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc12:AssetRotator ID="PMrot" runat="server" />
                            <fieldset runat="server" id="fldsetFundingBy">
                                <legend>
                                    <asp:Label ID="lblFundingBy" runat="server" Text="Funding by" CssClass="legend" meta:Resourcekey="lblFundingBy"></asp:Label>
                                </legend>
                                <table style="color: #666666;width:100%;table-layout:fixed" cellpadding="0" cellspacing="0">
                                    <tr style="width: 100%;">
                                        <td align="left" style="width: 160px; padding: 0;">
                                            <asp:RadioButtonList ID="rdbEntityList" Enabled="true" AutoPostBack="true" runat="server" RepeatDirection="Vertical" CssClass="RadioCss">
                                                <asp:ListItem Text="PORTFOLIO" meta:resourcekey="rdbPortfolio" Value="Portfolio" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="PROGRAM" meta:resourcekey="rdbProgram" Value="Program"></asp:ListItem>
                                                <asp:ListItem Text="PROJECT" meta:resourcekey="rdbProject" Value="Project"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td style="min-width: 240px; padding: 0;">
                                            <table class="colTable">
                                                <tr style="width: 100%;">
                                                    <td style="height: 24px;" class="controlWidth"><asp:Label ID="lbl" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr id="trProgram" runat="server" style="width: 100%;">
                                                    <td class="controlWidth" style="height: 24px;">
                                                        <telerik:RadComboBox ID="ddlProgram" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                                            Skin="Default" AutoPostBack="True" NoWrap="true" Height="250px">
                                                        </telerik:RadComboBox>
                                                        <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lblProgram" CssClass="Hide"></asp:Label>
                                                        <asp:CustomValidator meta:Resourcekey="csvProjects" ID="CustomValidator1" runat="server" ControlToValidate="ddlProgram"
                                                            ClientValidationFunction="ValidateProgramCombo" ValidationGroup="Save" Display="Dynamic"
                                                            CssClass="Validator" ErrorMessage="Program required">
                                                        </asp:CustomValidator>
                                                    </td>
                                                </tr>
                                                <tr id="trProject" runat="server" style="width: 100%;">
                                                    <td class="controlWidth" style="height: 24px;">
                                                        <asp:Label ID="lblProject" runat="server" meta:ResourceKey="lblProject" Text="Project" CssClass="Hide"> </asp:Label>
                                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server"
                                                            Skin="Default" NoWrap="true" Height="250px"
                                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" AutoPostBack="True"
                                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                        </telerik:RadComboBox>
                                                        <asp:Panel ID="Panel1" runat="server" Visible="false">
                                                            <asp:Label ID="Label3" runat="server" CssClass="Validator"
                                                                meta:ResourceKey="lblFundingUnique"></asp:Label>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:CostManagementFundingRequestDetails ID="CostManagementFundingRequestDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc3:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <ucNotes:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <UcAttachements:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <ucWorflow:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc2:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
