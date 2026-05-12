<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="CostMiscellaneousInvoices.aspx.vb" Inherits="Website.CostMiscellaneousInvoices" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostMiscellaneousInvoiceDetails.ascx" TagName="MiscInvoiceDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="CostManagementAPPaymentApplication.ascx" TagName="APPaymentApplication" TagPrefix="uc11" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc13" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Costs/MiscellaneousInvoices.js" type="text/javascript"></script>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>   
            <telerik:AjaxSetting AjaxControlID="mlpMiscellaneousInvoices">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMiscellaneousInvoices" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMiscellaneousInvoices" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.CostManagement.MiscInvoicesInfo.ProjectId %>';
            function ResetCombos(combobox, eventArgs) {
                var item = eventArgs.get_item();

                if (combobox.get_id().indexOf('ddlProjects') > 0) {
                    var ddlWBS = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlWBS');
                    ddlWBS.clearItems();
                    ddlWBS.set_text('');
                    ddlWBS.set_value('');
                    //            combobox.trackChanges();
                    //            combobox.set_value(item.get_value());
                    //            combobox.commitChanges();

                    var ddlPhase = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPhase');
                    ddlPhase.clearItems();
                    ddlPhase.set_text('');
                    ddlPhase.set_value('');

                    var ddlCostCode = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCostCodes');
                    ddlCostCode.clearItems();
                    ddlCostCode.set_text('');
                    ddlCostCode.set_value('');

                    var ddlManufacturers = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlManufacturers');
                    ddlManufacturers.clearItems();
                    ddlManufacturers.set_text('');
                    ddlManufacturers.set_value('');

                    var ddlLocations = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlLocations');
                    ddlLocations.clearItems();
                    ddlLocations.set_text('');
                    ddlLocations.set_value('');

                    for (var i = 1; i <= 10; i++) {
                        var ddlData = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_EditUserDefinedFields' + i + '_ddlData');
                        if (ddlData != null) {
                            var ListId = ddlData._attributes.getAttribute("ListId");
                            if (ListId == 207 || ListId == 214 || ListId == 215 || ListId == 217 || ListId == 206 || ListId == 62) {
                                ddlData.clearItems();
                                ddlData.set_text('');
                                ddlData.set_value('');
                            }

                        }


                    }



                }

            }


            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                if (ddlProjects == null) {
                    SelectedValue = combobox.get_attributes().getAttribute("projectid")
                }
                else {
                    SelectedValue = ddlProjects.get_value();

                }


                var context = eventArgs.get_context();
                context["FilterString"] = SelectedValue;


            }





            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.MiscInvoicesInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=COSTMANAGEMENT_MISCELLANEOUSINVOICES&Id=" +
                                        '<%= PM.CostManagement.MiscInvoicesInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.MiscInvoicesInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.CostManagement.MiscInvoicesInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.MiscInvoicesInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.MiscInvoicesInfo.Description)%>';
                var Id = '<%= PM.CostManagement.MiscInvoicesInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("COSTMANAGEMENT_MISCELLANEOUSINVOICES")%>';
                var HasMergeTemplate = '<%= PM.CostManagement.MiscInvoicesInfo.HasMergeTemplate%>';
                switch (Value) {

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=COSTMANAGEMENT_MISCELLANEOUSINVOICES&Id=" +
                                    '<%= PM.CostManagement.MiscInvoicesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.MiscInvoicesInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENT_MISCELLANEOUSINVOICES&Id=" +
                                '<%= PM.CostManagement.MiscInvoicesInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.MiscInvoicesInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                        case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTMANAGEMENT_MISCELLANEOUSINVOICES&Id=" +
                                '<%= PM.CostManagement.MiscInvoicesInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.MiscInvoicesInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
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
                        OpenPOPUp("Notification.aspx?ObjectType=COSTMANAGEMENT_MISCELLANEOUSINVOICES&Id=" +
                               '<%= PM.CostManagement.MiscInvoicesInfo.Id%>' + "&Description="
                                            + Description
                                            + "&RecordDescription=" + RecordDescription
                                            + "&EntityId=" + '<%=PM.CostManagement.MiscInvoicesInfo.ProjectId%>' + "&EntityType=0", "Notification",
                                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left, 1045, 515, false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=COSTMANAGEMENT_MISCELLANEOUSINVOICES&Id=" + Id
                        + "&EntityId=" + '<%=PM.CostManagement.MiscInvoicesInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left, 1045, 515, false);
                        }
                        break;

                    case 'New':
                        window.location = "CostMiscellaneousInvoices.aspx";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('COSTMANAGEMENT_MISCELLANEOUSINVOICES');
                        break;
                    default:
                        break;
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
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar SmallToolbar">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=74">
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
                <telerik:RadComboBox ID="ddlMiscellaneousInvoices" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" meta:resourcekey="ddlMiscellaneousInvoices"
                    Width="240px" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    AutoPostBack="false" NoWrap="true" CausesValidation="False" Height="250px"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler" AutoPostBack="true">
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=74" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" Value="CopyRecord" ValidationGroup="Save">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
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
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('COSTMANAGEMENT_MISCELLANEOUSINVOICES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('COSTMANAGEMENT_MISCELLANEOUSINVOICES');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <%--                                    <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>--%>
                        <%--                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#MiscellaneousInvoices"></telerik:RadToolBarButton>--%>
                   <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                         </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
        <%--<tr style="height:8px"></tr>--%>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" CssClass="documentTabs"
        runat="server" MultiPageID="mlpMiscellaneousInvoices" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        Width="100%" EnableViewState="True" CausesValidation="false" OnTabClick="tbsDocument_TabClick">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
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
    <telerik:RadMultiPage ID="mlpMiscellaneousInvoices" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server">
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
                                            Skin="Default"
                                            NoWrap="true" Width="100%" Height="400px"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
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
                                <tr id="trProgram" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%"
                                            Height="400px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>

                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvRequired" runat="server" ControlToValidate="ddlProgram"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProgram" runat="server" ControlToValidate="ddlProgram"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Program required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblCompany" runat="server" Text="<%$Resources:CostManagement, Label_Company %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton"
                                                OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField'),this.id.replace('imgfilter','ddlCompanies'),'Companies')">
                                                                         <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>


                                    </td>
                                    <td class="controlWidth">

                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                                            Skin="Default" CloseDropDownOnBlur="true" AutoPostBack="True"
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompanies"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCompany" runat="server" ControlToValidate="ddlCompanies"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceNumber" meta:resourcekey="lblInvoiceNumber" runat="server"
                                            Text="Invoice #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInvoice" runat="server" MaxLength="300"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceNumber" ControlToValidate="txtInvoice"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                      <asp:Label ID="lblMessage" runat="server" CssClass="Validator" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceDate" runat="server" Text="Invoice Date" meta:resourcekey="lblInvoiceDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpInvoiceDate" style="display: block">
                                            <telerik:RadDatePicker ID="rdpInvoiceDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" AutoPostBack="true" SelectedDate='<%# Date.Today %>'
                                                Width="130px" Skin="Default" Culture="English (United States)">
                                                <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvInvoiceDate" ControlToValidate="rdpInvoiceDate"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">

                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="hplCurrency" Height="24px" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                                                <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="300px" Width="100%"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision  %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
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
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" Width="100%" runat="server"></asp:TextBox>
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
                                        <asp:Label ID="lblCostPeriod" runat="server" meta:Resourcekey="lblCostPeriod" Text="Cost Period"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox
                                            ID="ddlPeriods" runat="server" Height="150px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlPeriods" NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="True"
                                            OnItemsRequested="ddl_ItemsRequested" Filter="Contains">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPeriod" runat="server" ControlToValidate="ddlPeriods"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPeriod" runat="server" ControlToValidate="ddlPeriods"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBillingTerms" meta:resourcekey="lblBillingTerms" runat="server" Text="Billing Terms"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBillingTerms" runat="server" Skin="Default" AutoPostBack="true" MarkFirstMatch="true" Filter="Contains" AllowCustomText="True" Width="100%"></telerik:RadComboBox>
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
                                        <asp:Label ID="lblInvoiceDue" runat="server" meta:resourcekey="lblInvoiceDue" Text="Invoice Due"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpInvoiceDueDate" style="display: block">
                                            <telerik:RadDatePicker ID="rdpInvoiceDueDate" runat="server"
                                                Culture="English (United States)" MaxDate="2100-01-01"
                                                MinDate="1901-01-01" SelectedDate="<%# Date.Today %>" Skin="Default"
                                                Width="150px">
                                                <DateInput ID="DateInput4" runat="server"
                                                    LabelCssClass="radLabelCss_Office2007" Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar4" runat="server"
                                                    Skin="Default">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvDueDate" ControlToValidate="rdpInvoiceDueDate"
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
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Width="100%" Skin="Default" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
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
                                        <asp:Label ID="lblDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="99%" Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <table class="TableNoSpacingNoBorder" width="100%" style="color: #666666;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblpost" meta:resourcekey="lblpost" runat="server" Text="Post to Non-commitment Costs1"></asp:Label>
                                                </td>

                                                <td style="text-align: right">
                                                    <asp:CheckBox ID="chkPostToNonCommitment" runat="server" Checked="true" CssClass="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" width="100%">
                                        <table class="TableNoSpacingNoBorder" width="100%" style="color: #666666;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPaidInFull" meta:resourcekey="lblPaidInFull" runat="server" Text="Paid In Full"></asp:Label>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:CheckBox ID="chkPaidInFull" runat="server" CssClass="mobile-switch" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <fieldset runat="server" id="fldContractSnapshot">
                                <legend>
                                    <asp:Label ID="lblRecap" runat="server" meta:resourcekey="lblRecap" Text="INVOICE RECAP"></asp:Label></legend>
                                <table class="colTable" style="color: #666666 !important;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblInvoiceAmount" meta:resourcekey="lblInvoiceAmount" runat="server" Text="Invoice Amount"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInvoiceAmount" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblUnappliedPaymentsAvailable" meta:resourcekey="lblUnappliedPaymentsAvailable" runat="server" Text="Unapplied Payments Available"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtUnappliedPaymentsAvailable" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPaymentsApplied" meta:resourcekey="lblPaymentsApplied" runat="server" Text="Payments Applied"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPaymentsApplied" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOpenBalance" meta:resourcekey="lblOpenBalance" runat="server" Text="Open Balance"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOpenBalance" ReadOnly="true" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblHidenRows" runat="server" Text="1111" Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc13:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:MiscInvoiceDetails ID="MiscInvoiceDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc10:DocumentAdjustments ID="DocumentAdjustments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc6:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPayments" runat="server">
            <uc11:APPaymentApplication ID="APPaymentApplication1" runat="server" />
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
            <uc12:documentteam id="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>










