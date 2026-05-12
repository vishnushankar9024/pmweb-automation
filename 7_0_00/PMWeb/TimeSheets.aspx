<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="TimeSheets.aspx.vb" Inherits="Website.TimeSheets" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="TimeSheetDetails.ascx" TagName="TimeSheetDetail" TagPrefix="uc1" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc2" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
          <telerik:AjaxSetting AjaxControlID="mlpTimeSheet">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTimeSheet" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTimeSheet" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
                <style>
     
            .labelChkWidth {
                width: 80% !important;
                height: 24px;
                line-height: 24px;
                background: #FFFFFF;
                color: #666666 !important;
            }
                    </style>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;

            var AutoFill = '<%=PM.Scheduling.TimeSheetInfo.FillDescFromCostCode%>';
            function Main_GetValueToReturn(combobox, eventArgs) {
                if (eventArgs.get_text().length < parseInt(LoadOnDemandRequestThreshold)) {
                    eventArgs.set_cancel(true);
                } else {
                    eventArgs.set_cancel(false);
                } 
                var SelectedValue;
                var ProgramSelectedValue;
                var ddlProjects = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                SelectedValue = ddlProjects.get_value();
                var ddlProgram = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProgram');
                ProgramSelectedValue = ddlProgram.get_value();
                var context = eventArgs.get_context();
                context["FilterString"] = SelectedValue;
                context["ProgramId"] = ProgramSelectedValue;
            }

            function Main_GetValueFromProgram(combobox, eventArgs) {
                var SelectedValue;
                var ddlProgram = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProgram');
                SelectedValue = ddlProgram.get_value();
                var context = eventArgs.get_context();
                context["FilterString"] = SelectedValue;

            }

            function Main_ResetCombos(combobox, eventArgs) {
                var ddlFundingCodes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlFundingCodes');
                ddlFundingCodes.clearItems();
                ddlFundingCodes.set_text("");
                ddlFundingCodes.set_value("0");

                var ddlPeriods = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPeriods');
                ddlPeriods.clearItems();
                ddlPeriods.set_text("");
                ddlPeriods.set_value("0");
            }

            function Program_ResetCombos(combobox, eventArgs) {
                var ddlProject = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlProjects');
                ddlProject.clearItems();
                ddlProject.set_text("");
                ddlProject.set_value("0");


                var ddlFundingCodes = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlFundingCodes');
                ddlFundingCodes.clearItems();
                ddlFundingCodes.set_text("");
                ddlFundingCodes.set_value("0");

                var ddlPeriods = $find(combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_ddlPeriods');
                ddlPeriods.clearItems();
                ddlPeriods.set_text("");
                ddlPeriods.set_value("0");
            }

            function rdvReqNodeClicking(sender, args) {
                var ComboId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
                var comboBox = $find(ComboId.substring(ComboId.lastIndexOf('_'), ComboId.lenght - 1));
                var node = args.get_node();
                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                if (strValue.indexOf("SELECT") > 0 || strValue.indexOf("Contract") > 0 || strValue.indexOf("ContractCO") > 0) {



                    while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                        strText = "/" + node.get_text() + strText;
                        node = node.get_parent();
                    }
                    strText = strText.substr(1, strText.toString().length - 1);
                    comboBox.set_text(strText);
                    comboBox.trackChanges();
                    comboBox.get_items().getItem(0).set_value(strValue);
                    comboBox.commitChanges();
                    comboBox.hideDropDown();
                }

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
                var RecordDescription = '<%=JSEscape(PM.Scheduling.TimeSheetInfo.ProjectName)%>';
                var Description = '<%=JSEscape(PM.Scheduling.TimeSheetInfo.Description)%>';
                var ProjectId = '<%=PM.Scheduling.TimeSheetInfo.ProjectId%>';
                var HasReports = '<%=PM.Scheduling.TimeSheetInfo.HasReports%>';
                if (ProjectId = 0) {
                    RecordDescription = '<%=JSEscape(PM.Scheduling.TimeSheetInfo.ProgramName)%>';
                }
                RecordDescription = RecordDescription + ' - ' + Description;
                var Id = '<%= PM.Scheduling.TimeSheetInfo.Id%>'
            var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("TIMESHEET")%>';
                switch (Value) {
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=TIMESHEET&Id=" +
                         '<%= PM.Scheduling.TimeSheetInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Scheduling.TimeSheetInfo.ProjectId%>' + "&EntityType=0", "Notification",900,500,false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=TIMESHEET&Id=" + Id
                        + "&EntityId=" + '<%=PM.Scheduling.TimeSheetInfo.ProjectId%>' + "&EntityType=0",900,500,false);
                    }
                    break;

                case 'ViewReports':
                    if (HasReports == 'True') {
                        var left = (screen.width - 890) / 2;
                        var top = (screen.height - 430) / 2;
                        OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TIMESHEET&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + ProjectId + "&EntityType=1",890,430,false);
                    }
                    break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TIMESHEET&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + ProjectId + "&EntityType=1", 890, 430, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;
                case 'New':
                    window.location = "TimeSheets.aspx";
                    break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup('TIMESHEET');
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

        function CheckToDate(sender, args) {
            var FromDate = $find("<%= rdpFrom.ClientID %>").get_selectedDate();
                var ToDate = $find("<%= rdpTo.ClientID %>").get_selectedDate();

                var dateDiff = parseInt((ToDate.getTime() - FromDate.getTime()) / (24 * 3600 * 1000));

                if ((dateDiff >= 0) && (dateDiff < 7)) {
                    args.IsValid = true;
                    return;
                }

                args.IsValid = false;
        }
            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
    </telerik:RadCodeBlock>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=73">
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
                <telerik:RadComboBox ID="ddlTimeSheets" runat="server" Skin="Default" CloseDropDownOnBlur="true" EnableLoadOnDemand="true"
                    EmptyMessage="<%$Resources: ddlTimesheet_EmptyMsg %>" Width="100%" AutoPostBack="false" AllowCustomText="true" Height="400px"
                    CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                    NoWrap="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" EnableVirtualScrolling="True" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="TimeSheetSave" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                      
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
               

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                  <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>


                        <telerik:RadToolBarButton CssClass="lnkButtonBar" PostBack="true" Enabled="false" Value="GenerateNext" CommandName="GenerateNext" Text="Create Next" Style="margin-top: -8px;"
                            HoveredCssClass="SubmitHover" DisabledCssClass="BorderDisabled" OuterCssClass="HideOnMobileToolbar" ImageUrl="Images/ToolBar/PMWebW.gif">
                        </telerik:RadToolBarButton>

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
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Generate Next" Value="GenerateNext" Enabled="false" OnClick="btnGenerateNext_Click"></telerik:RadMenuItem> 
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('TIMESHEET');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('TIMESHEET');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit" Style="margin-top: -8px;"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpTimeSheet" Skin="Default" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Value="Details" Text="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpTimeSheet" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet">
                <div class="PMMainPage ">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTimeSheetRecNbr" meta:resourcekey="lblTimeSheetRecNbr" runat="server" Text="Timesheet #11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTimeSheetRecNbr" runat="server" ReadOnly="true" Style="text-align: right"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFrom" meta:resourcekey="lblFromAsterisk" runat="server" Text="From*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpFrom" style="display: block">
                                            <telerik:RadDatePicker ID="rdpFrom" runat="server" MinDate="1900-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Skin="Default">
                                                <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvFrom" runat="server" ValidationGroup="Save" meta:resourcekey="rfvFrom"
                                            ControlToValidate="rdpFrom" ErrorMessage="Select a date" Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTo" meta:resourcekey="lblToAsterisk" runat="server" Text="To*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpTo" style="display: block">
                                            <telerik:RadDatePicker ID="rdpTo" runat="server" MinDate="1900-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Skin="Default">
                                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvTo" meta:resourcekey="rfvTo" runat="server" ValidationGroup="Save"
                                            ControlToValidate="rdpTo" ErrorMessage="Select a date" Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator>
                                        <asp:CompareValidator meta:resourcekey="cmpFromToDates" ID="cmpFromToDates" runat="server" ControlToValidate="rdpTo"
                                            ControlToCompare="rdpFrom" Type="Date" CssClass="Validator" ErrorMessage="To date should be greater than From date"
                                            Display="Dynamic" ValidationGroup="Save" ForeColor="" Operator="GreaterThanEqual" EnableClientScript="false">
                                        </asp:CompareValidator>
                                        <asp:CustomValidator meta:resourcekey="cusvToDate" ID="cusvToDate" runat="server" ControlToValidate="rdpTo" ValidateEmptyText="false"
                                            CssClass="Validator" ErrorMessage="Maximum range: 7 days" Display="Dynamic" ValidationGroup="Save" ClientValidationFunction="CheckToDate"
                                            ForeColor="">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblResource" runat="server" meta:resourcekey="lblResource" Text="Resource"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlResources" meta:resourcekey="ddlResources" runat="server" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Resource..."
                                            NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="200px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" OnClientSelectedIndexChanged="Program_ResetCombos" Filter="Contains" MarkFirstMatch="true"
                                            AllowCustomText="true" runat="server" Skin="Default" NoWrap="true" Height="200px" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProgram" ForeColor=""
                                            CssClass="Validator" InitialValue="" meta:Resourcekey="rfvPrograms"
                                            Display="Dynamic" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator meta:Resourcekey="csvPrograms" ID="csvProjects" runat="server" ControlToValidate="ddlProgram"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic" CssClass="Validator">
                                       
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server" Filter="Contains" meta:resourcekey="ddlProjects"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableVirtualScrolling="true" Style="font-size: 11px"
                                            NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False" Height="200px"
                                            OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanged="Main_ResetCombos" OnClientItemsRequesting="Main_GetValueFromProgram">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:resourcekey="lblStatus" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px;">
                                                    <asp:TextBox ID="txtRevisionNumber" runat="server" CssClass="PositiveInteger" ReadOnly="True" MaxLength="15"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display:none;">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevisionDate" meta:resourcekey="lblRevisionDate" runat="server" Text="Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_txtRevisionDate" style="display: block">
                                            <asp:TextBox ID="txtRevisionDate" runat="server" ReadOnly="True" style="text-align: right;"></asp:TextBox>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTimeSheetNumber" meta:resourcekey="lblTimeSheetNumber" runat="server" Text="Timesheet #11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTimeSheetNumber" runat="server" CssClass="Integer" ReadOnly="True" MaxLength="10"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFundingCode" meta:resourcekey="lblFundingCode" runat="server" Text="Funding Code"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFundingCodes" runat="server" Filter="Contains" meta:resourcekey="ddlFundingCodes"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Funding Codes..." Style="font-size: 11px"
                                            NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False" Height="200px"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Main_GetValueToReturn">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPeriod" meta:resourcekey="lblPeriod" runat="server" Text="Period"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPeriods" runat="server" Filter="Contains" meta:resourcekey="ddlPeriods" EmptyMessage="Periods..."
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" ShowMoreResultsBox="true"
                                            AllowCustomText="true" EnableItemCaching="False" Style="font-size: 11px" Height="200px" EnableLoadOnDemand="True"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Main_GetValueToReturn">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelChkWidth" colspan="2">
                                        <asp:Label ID="lblPostNonCommitment" runat="server" Text="Post to Non-Commitment Costs111" meta:resourcekey="chkPostNonCommitment"></asp:Label>
                                        <div style="float: right;">
                                            <asp:CheckBox ID="chkPostNonCommitment" runat="server" CssClass="Right" class="mobile-switch" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelChkWidth" colspan="2">
                                        <asp:Label ID="lblHidenRows" runat="server" Text="1111" Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc11:AssetRotator ID="PMrot" runat="server" />
                        </div>
                        <div class="col-4 col-4-right">
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:TimeSheetDetail ID="TimeSheetDetail1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc2:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
