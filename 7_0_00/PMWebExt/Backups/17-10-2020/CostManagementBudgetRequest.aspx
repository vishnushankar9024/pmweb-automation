<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostManagementBudgetRequest.aspx.vb" Inherits="Website.CostManagementBudgetRequest" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="CostManagementBudgetRequestDetails.ascx" TagName="CostManagementBudgetRequestDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="mlpBudgetRequest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBudgetRequest" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBudgetRequest" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            var forceMoreMenuToClose = true;

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

                    var ddlCompanies = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlCompanies');
                    ddlCompanies.clearItems();
                    ddlCompanies.set_text('');
                    ddlCompanies.set_value('');


                    var ddlPeriods = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPeriods');
                    ddlPeriods.clearItems();
                    ddlPeriods.set_text('');
                    ddlPeriods.set_value('');

                    var ddlTasks = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlTasks');
                    ddlTasks.clearItems();
                    ddlTasks.set_text('');
                    ddlTasks.set_value('');

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
                var RecordCurrencyId = '<%=PM.CostManagement.BudgetsRequestInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=BUDGETREQUEST&Id=" +
                                       '<%= PM.CostManagement.BudgetsRequestInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.CostManagement.BudgetsRequestInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }



            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);

                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.CostManagement.BudgetsRequestInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.CostManagement.BudgetsRequestInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.CostManagement.BudgetsRequestInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.CostManagement.BudgetsRequestInfo.Description)%>';
                var Id = '<%= PM.CostManagement.BudgetsRequestInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("BUDGETREQUEST") %>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BUDGETREQUEST&Id=" +
                                '<%= PM.CostManagement.BudgetsRequestInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.BudgetsRequestInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=BUDGETREQUEST&Id=" +
                               '<%= PM.CostManagement.BudgetsRequestInfo.Id%>' + "&Description="
                                            + Description
                                            + "&RecordDescription=" + RecordDescription
                                            + "&EntityId=" + '<%=PM.CostManagement.BudgetsRequestInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                    break;

                case 'ViewTemplates':
                    if (HasMergeTemplate == 'True') {
                        var left = (screen.width - 1045) / 2;
                        var top = (screen.height - 515) / 2;
                        OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=BUDGETREQUEST&Id=" +
                                '<%= PM.CostManagement.BudgetsRequestInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.CostManagement.BudgetsRequestInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);

                    }
                    break;


                case 'ViewPMWebReports':
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 500) / 2;
                    if (HasPMWebReports == 'True' && Id > 0) {
                        OpenPOPUp("PMWebReports.aspx?ObjectType=BUDGETREQUEST&Id=" + '<%= PM.CostManagement.BudgetsRequestInfo.Id%>'
                    + "&EntityId=" + '<%=PM.CostManagement.BudgetsRequestInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                    }
                    break;

                case 'New':
                    window.location = "CostManagementBudgetRequest.aspx";
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
                return;
            }
            args.set_cancel(true);
        }

        </script>
    </telerik:RadCodeBlock>

    <script src="JS/Costs/BudgetRequest.js" type="text/javascript"></script>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=93">
                            <div class="btnToolbarSearchDocument">&nbsp;</div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                            <div class="btnToolbarRecent">&nbsp;</div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlBudgetRequest" runat="server" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                    Skin="Default" CloseDropDownOnBlur="true" ShowMoreResultsBox="True"
                    Width="100%" AutoPostBack="false" NoWrap="true" AllowCustomText="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    CausesValidation="False" Height="400px" OnClientTextChange="LOD_DropDownTextChange" EnableLoadOnDemand="true">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

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
                                    CommandName="Copy" Value="CopyRecord" Width="150px">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/Revision.png"
                                    CommandName="CreateRevision" Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/EmailMessage.gif"
                            CommandName="Notification" PostBack="false" CausesValidation="false" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png"
                            CommandName="Print" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates"></telerik:RadToolBarButton>
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
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('BUDGETREQUEST');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>



    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpBudgetRequest" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Adjustments" Value="Adjustments"></telerik:RadTab>
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

    <telerik:RadMultiPage ID="mlpBudgetRequest" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr id="trvoid" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program*" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" EnableLoadOnDemand="true"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfvRequired" runat="server" ControlToValidate="ddlProgram"
                                            CssClass="Validator" InitialValue=""  ValidationGroup="Save" ForeColor=""
                                            Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProgram" runat="server" ControlToValidate="ddlProgram" CssClass="Validator"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic" ErrorMessage="Program required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:Resourcekey="lblProject" runat="server" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" Height="300px"
                                            NoWrap="true" Skin="Default" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlProjects"
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
                                        <asp:Label ID="lblRecordNumber" runat="server" Text="<%$Resources:PMWeb, Label_RecordNumber %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" runat="server" MaxLength="10" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" ControlToValidate="txtRecordNumber" Display="Dynamic" ValidationGroup="Save"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_FieldsRequired %>">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$Resources:CostManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>">
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
                                        <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType" ValidationGroup="Save"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>"
                                            Display="Dynamic" ForeColor="" Visible="false">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                            Skin="Default" Style="/*font-size: 11px*/" MarkFirstMatch="true">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" Visible="false"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>">
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
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_FieldsRequired%>">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnCurrency" CssClass="SearchButton">
    					                         <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" Height="300px" runat="server" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trHiddenRows" runat="server" visible="false">
                                    <td colspan="2">
                                        <asp:Label ID="lblHidenRows" runat="server" Text="1111" Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPostAs" meta:Resourcekey="lblPostAs" runat="server" Text="Post as"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPostAs" runat="server" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliEstimate" meta:Resourcekey="hliEstimate" Text="Estimate"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEstimate" runat="server" ReadOnly="true" MaxLength="250"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:CostManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" width="100%" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default">
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                                        Display="Dynamic" ForeColor="" Visible="false" ValidationGroup="Save">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td width="50px" style="padding-left: 8px;">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="PositiveInteger" MaxLength="9"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
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
                                        <asp:Label ID="lblDate" runat="server" Text="<%$Resources:CostManagement, Label_RevisionDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Skin="Default" Culture="English (United States)" EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Default" Skin="Default" ReadOnly="true" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc12:AssetRotator ID="PMrot" runat="server" />
                            <fieldset style="width: 300px; text-align: left; display: none;">
                                <legend class="legend">
                                    <asp:Label ID="lblBudgetRecap" runat="server" Text="Budget Recap"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOriginalBudget" runat="server" Text="Original Budget"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOriginalBudget" runat="server" CssClass="Currency" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblApprovedChangeOrders" runat="server" Text="Peding Revisions"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtApprovedChangeOrders" CssClass="Currency" runat="server" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRevisedBudget" runat="server" Text="Revised Budget"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRevisedBudget" CssClass="Currency" runat="server" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPendingRevisions" runat="server" Text="Pending Revisions"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPendingRevisions" CssClass="Currency" runat="server" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAnticipatedBudget" runat="server" Text="Anticipated Budget"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAnticipatedBudget" CssClass="Currency" runat="server" ReadOnly="true"></asp:TextBox>
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
            <uc1:CostManagementBudgetRequestDetails ID="CostManagementBudgetRequestDetails" runat="server" />
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
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc2:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc3:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
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
