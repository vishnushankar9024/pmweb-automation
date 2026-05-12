<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementJournalEntries.aspx.vb" Inherits="Website.CostManagementJournalEntries" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementJournalEntryDetails.ascx" TagName="JournalEntryDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="ngDocClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Costs/JournalEntry.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        
        <script language="javascript" type="text/javascript">
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.CostManagement.JournalEntryInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=JOURNALENTRY&Id=" +
                                     '<%= PM.CostManagement.JournalEntryInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.JournalEntryInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }


            function ResetCombos(combobox, eventArgs) {
                var item = eventArgs.get_item();

                if (combobox.get_id().indexOf('ddlProjects') > 0) {

                    var ddlCostCode = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCostCodes');
                    ddlCostCode.clearItems();
                    ddlCostCode.set_text('');
                    ddlCostCode.set_value('');

                    var ddlPeriods = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPeriods');
                    ddlPeriods.clearItems();
                    ddlPeriods.set_text('');
                    ddlPeriods.set_value('');

                    var ddlReqCodes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlReqCodes');
                    ddlReqCodes.clearItems();
                    ddlReqCodes.set_text('');
                    ddlReqCodes.set_value('');

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


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.CostManagement.JournalEntryInfo.HasReports%>';
                var HasMergeTemplate = '<%= PM.CostManagement.JournalEntryInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.JournalEntryInfo.Description)%>';
                RecordDescription = RecordDescription + '-' + '<%=JSEscape(PM.CostManagement.JournalEntryInfo.ProjectName)%>';
                var Description = '<%=JSEscape(PM.CostManagement.JournalEntryInfo.Description)%>';
                var Id = '<%= PM.CostManagement.JournalEntryInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("JOURNALENTRY")%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=JOURNALENTRY&Id=" +
                               '<%= PM.CostManagement.JournalEntryInfo.Id%>' + "&Description="
                                                + Description
                                                + "&RecordDescription=" + RecordDescription
                                                + "&EntityId=" + '<%=PM.CostManagement.JournalEntryInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=JOURNALENTRY&Id=" +
                                    '<%=PM.CostManagement.JournalEntryInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.JournalEntryInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=JOURNALENTRY&Id=" + Id
                            + "&EntityId=" + '<%=PM.CostManagement.JournalEntryInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('JOURNALENTRY');
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=JOURNALENTRY&Id=" + Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.CostManagement.JournalEntryInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                          }
                        break;
                        case 'Print':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=JOURNALENTRY&Id=" + Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.CostManagement.JournalEntryInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
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
                          window.location = "CostManagementJournalEntries.aspx";
                          break;

                      default:
                          break;
                  }
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
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="mlpJournalEntries">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpJournalEntries" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpJournalEntries" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100% !important;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar SmallToolbar">
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s" ToolTip="Save (Alt+s)">
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
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Add"
                                    CommandName="CreateRevision" Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete" ToolTip="Delete (Alt+d)">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
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
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print"  CssClass="Print" SecurityButtonType="Read">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('JOURNALENTRY');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('JOURNALENTRY');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
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
            <td></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" CssClass="documentTabs"
        runat="server" MultiPageID="mlpJournalEntries" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
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
    <telerik:RadMultiPage ID="mlpJournalEntries" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPrograms" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true"
                                            Height="300px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true"
                                            OnItemsRequested="ddl_ItemsRequested" SkipValue="0">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvPrograms" runat="server" ControlToValidate="ddlPrograms"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProgram" runat="server" ControlToValidate="ddlPrograms"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Program required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="true" CausesValidation="false"
                                            Height="300px" meta:ResourceKey="ddlProjects"
                                            NoWrap="true" Skin="Default" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" SkipValue="0">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_ProjectRequired%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" runat="server" MaxLength="10" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                        <asp:Label ID="lblHidenRows" runat="server" Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label>
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
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server" Skin="Default" Style="font-size: 11px" MarkFirstMatch="true"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" AllowCustomText="true" Filter="Contains" Height="220px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
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
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                            Skin="Default" Style="font-size: 11px" MarkFirstMatch="true">
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
                                        <asp:RequiredFieldValidator ID="rfvReference" ControlToValidate="txtReference"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="trCurrency" runat="server">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                        <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>                                            
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default" meta:Resourcekey="ddlCurrencies" Height="300px"
                                            Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" width="100%" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" runat="server" MaxLength="9"></asp:TextBox>
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
                                        <asp:Label ID="lblDate" runat="server" Text="<%$ Resources:ProjectManagement, Label_DocumentDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpRevisionDate">
                                            <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Default" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc12:AssetRotator ID="PMrot" runat="server" />
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth NoWrap">
                                        <asp:Label ID="lblNetAmount" runat="server" meta:ResourceKey="lblNetAmount" Text="Net amount"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtNetAmount" runat="server" disabled="False" CssClass="Right" MaxLength="250" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>

                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:JournalEntryDetails ID="JournalEntryDetails" runat="server" />
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
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
