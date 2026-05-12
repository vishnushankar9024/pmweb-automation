<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PortfolioPlanning.aspx.vb" Inherits="Website.PortfolioPlanning" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>
<%@ Register Src="PortfolioPlanningDetails.ascx" TagName="PortfolioPlanningDetails" TagPrefix="uc1" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc7" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpPortfolioPlanning">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPortfolioPlanning" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPortfolioPlanning" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <script src="JS/Portfolio/PlanningWorksheet.js" type="text/javascript"></script>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var validIndexChange = false;

            function DisablePanelAjax() {
            }


            function ProgramSelectedIndexChanging(sender, eventArgs) {
                validIndexChange = true;
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
                        if (validIndexChange == false) {
                            var value = combo.get_value();
                            if (value >= 0) {
                                args.IsValid = true;
                            }
                            else {
                                args.IsValid = false;
                            }
                            if (value.length == 0) {
                                args.IsValid = false;
                            }
                        }
                        else {
                            var value1 = combo.findItemByText(text);
                            if (value1 != null) {
                                args.IsValid = true;
                            }
                            else {
                                args.IsValid = false;
                            }
                        }
                    }
                }
                else {
                    args.IsValid = true;
                }
                validIndexChange = false;
            }

            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.PortfolioPlanning.PlanningWorksheetInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=PORTFOLIOPLANS&Id=" +
                                     '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.Id%>'
                          + "&ProgramId=" + '<%=PM.PortfolioPlanning.PlanningWorksheetInfo.ProgramId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            var forceradmenuToClose = false;
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
              
                var HasMergeTemplate = '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.HasMergeTemplate%>';
                var HasReports = '<%=  PM.PortfolioPlanning.PlanningWorksheetInfo.HasReports %>';
                var RecordDescription = '<%= JSEscape(PM.PortfolioPlanning.PlanningWorksheetInfo.RecordDescription)%>';
                var Description = '<%= JSEscape(PM.PortfolioPlanning.PlanningWorksheetInfo.PortfolioName)%>';
                var Id = '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("PORTFOLIOPLANS") %>';
                switch (Value) {
                    //case 'ImportRecords':
                    //    OpenPOPUp('PortfolioPlanning_Import.aspx?SourceId=Plans_Import', 710, 590);
                    //    break;
                    case 'Copy':
                        OpenPOPUpToRedirect("CopyPortfolioPlanningPopup.aspx", 915, 510, false);
                        // var wnd = window.open("",'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        //                        wnd.setSize(880, 500);
                        //                        wnd.Center();
                        break;
                    case 'GenerateProjectRecords':
                        OpenPOPUp('PortfolioPlanningGeneratePopup.aspx');
                        //var wnd = window.radopen('PortfolioPlanningGeneratePopup.aspx');
                        //wnd.setSize(880, 500);
                        //wnd.Center();
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=PORTFOLIOPLANS&Id=" +
                               '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.PortfolioPlanning.PlanningWorksheetInfo.ProgramId%>' + "&EntityType=2", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PORTFOLIOPLANS&Id=" +
                              '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.Id%>'
                        + "&RecordDescription=" + RecordDescription
                          + "&EntityId=" + '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.ProgramId%>' + "&EntityType=2", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=PORTFOLIOPLANS&Id=" + Id,
                                'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);

                        }
                        break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=PORTFOLIOPLANS&Id=" +
                            '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.Id%>' + "&Description="
                                + Description
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.PortfolioPlanning.PlanningWorksheetInfo.ProgramId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('PORTFOLIOPLANS');
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'New':
                        window.location = "PortfolioPlanning.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                          if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PORTFOLIOPLANS&Id=" +
                              '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.Id%>'
                        + "&RecordDescription=" + RecordDescription
                          + "&EntityId=" + '<%= PM.PortfolioPlanning.PlanningWorksheetInfo.ProgramId%>' + "&EntityType=2", 890, 430, false);
                          }
                          else {
                              window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                           
                          }

                    default:
                        break;
                }
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
    <table style="width: 100%;" class="ToolBar LargeToolBar" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=137">
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
                <telerik:RadComboBox ID="ddlPorfolioPlan" runat="server"
                    Skin="Default" CloseDropDownOnBlur="true" OnClientTextChange="LOD_DropDownTextChange" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" AutoPostBack="False" NoWrap="true"
                    Height="250px" CausesValidation="False" AllowCustomText="true"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>

            <td valign="middle" style="padding-left: 24px; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar"
                    runat="server" Skin="Default" OnClientButtonClicked="click_handler" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save"
                            AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" PostBack="false"
                                    CommandName="Copy" SecurityButtonType="Copy" ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete"
                            AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
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
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked"
                                    OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Reports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked PMWeb Word Templates" Value="ViewTemplates"></telerik:RadMenuItem>
                                                        
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Generate Project Records" Value="GenerateProjectRecords"></telerik:RadMenuItem>
                                               <%-- <telerik:RadMenuItem EnableImageSprite="true" Text="Import" Value="Import">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Records" Value="ImportRecords"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>--%>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('PORTFOLIOPLANS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup('PORTFOLIOPLANS');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <%-- <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMiddleScreen"></telerik:RadToolBarButton>--%>
                        

                        <telerik:RadToolBarButton PostBack="false" Value="genProject" CommandName="GenerateProjectRecords" CssClass="ToolbarGenerate HideOnMobileToolbar" ImageUrl="Images/ToolBar/PMWebW.gif">
                        </telerik:RadToolBarButton>
                           

                        <%--<telerik:RadToolBarSplitButton SecurityButtonType="Add" CommandName="Import" Enabled="true" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarImport" ImageUrl="Images/ToolBar/Import.png" ToolTip="Import"
                            PostBack="false" EnableDefaultButton="false">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Records" CommandName="ImportRecords" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                        <%--<telerik:RadToolBarButton  ImageUrl="Images/Toolbar/Help.png" CausesValidation ="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Portfolio.htm"></telerik:RadToolBarButton>--%>
                         <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                            meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%" align="right">
                <asp:Button Visible="false" ID="btnCreateNextWorksheet" CssClass="LargeButton" runat="server" Width="150px"
                    meta:resourcekey="btnCreateDocNumber" Text="Create Next Worksheet" />
            </td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpPortfolioPlanning" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Skin="Default" Width="100%" EnableViewState="true">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Checklist" Value="Checklists" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpPortfolioPlanning" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true" BorderColor="LightBlue" BorderWidth="0">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPlanYear" meta:Resourcekey="lblPlanYear" runat="server" Text="Plan Year*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadNumericTextBox ID="rntPlanYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true"
                                            IncrementSettings-InterceptMouseWheel="true" Label="" runat="server" CssClass="Right"
                                            MaxValue="2100" MinValue="1899">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="rfvPlanYear" runat="server" ControlToValidate="rntPlanYear" meta:ResourceKey="rfvRequired"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Enter a plan Year." Display="Dynamic"
                                            ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblIDUnique" meta:Resourcekey="lblIDUnique" runat="server" Text="Plan Year must be unique."
                                            Visible="False" Class="Validator">
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" Text="Program" meta:Resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" Skin="Default" NoWrap="true" Width="100%" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" AutoPostBack="true"
                                            EnableVirtualScrolling="True" OnClientSelectedIndexChanging="ProgramSelectedIndexChanging"
                                            Height="200px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" meta:Resourcekey="rfvRequired" runat="server"
                                            ControlToValidate="ddlProgram" CssClass="Validator" InitialValue="" ErrorMessage="<br/>Program required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator meta:Resourcekey="csvProjects" ID="csvProjects" runat="server"
                                            ControlToValidate="ddlProgram" ClientValidationFunction="ValidateProgramCombo"
                                            ValidationGroup="Save" Display="Dynamic" CssClass="Validator" ErrorMessage="<br/>Program required">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPortfolioName" meta:Resourcekey="lblPortfolioName" runat="server"
                                            Text="Portfolio Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" MaxLength="100" ID="txtPortfolioName" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <%--<asp:HyperLink runat="server" CssClass="Link" ID="hplCurrency" Height="16px" meta:Resourcekey="hplCurrency" Text="Currency"></asp:HyperLink>--%>
                                        <div style="float: left;">
                                            <asp:Label ID="lblCurrency" meta:resourcekey="hplCurrency" runat="server" Text="Currency"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="ImgfilterCurrency">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" Skin="Default" Height="300px"
                                            Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" meta:resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px"
                                                        Width="100%">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox ID="txtRevision" CssClass="Right" runat="server" ReadOnly="true" disabled="disabled"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%--<tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDate"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <span runat="server" id="rmd_dtpRevisionDate">
                                                                    <telerik:RadDatePicker ID="dtpRevisionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                        SelectedDate='<%# Date.Today %>' Skin="Default" EnableTyping="False"
                                                                        DatePopupButton-Visible="false">
                                                                        <DateInput ID="DateInput1" Style="margin-top: -1px;" Skin="Default"
                                                                            ReadOnly="true" runat="server">
                                                                        </DateInput>
                                                                    </telerik:RadDatePicker>
                                                                </span>
                                                            </td>
                                                        </tr>--%>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">

                            <div id="divPortfolioRecaps" runat="server">
                                <fieldset id="fldPortfolioRecaps" runat="server">
                                    <legend runat="server" id="fldsetPortfolioRecap" class="legend">
                                        <asp:Label ID="lblPortfolioRecap" runat="server" Text="Plan Recap" meta:Resourcekey="lblPortfolioRecap"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="NoWrap labelWidth">
                                                <asp:Label ID="lblPlanTotal" meta:Resourcekey="lblPlanTotal" runat="server" Text="Plan Total"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPlanTotal" CssClass="Double" ReadOnly="true" runat="server" disabled="disabled"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="NoWrap labelWidth">
                                                <asp:Label ID="lblFundedTotal" meta:Resourcekey="lblFundedTotal" runat="server" Text="Selected To Fund"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtFundedTotal" CssClass="Double" ReadOnly="true" runat="server" disabled="disabled"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblAuthorized" meta:Resourcekey="lblAuthorized" runat="server"
                                                    Text="Authorized"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtAuthorized" CssClass="Double" ReadOnly="true" runat="server" disabled="disabled"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblBalance" meta:Resourcekey="lblBalance" runat="server"
                                                    Text="Balance"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtBalance" CssClass="Double" ReadOnly="true" runat="server" disabled="disabled"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>

                        </div>
                        <div class="col-4 col-4-right">

                            <uc7:AssetRotator id="PMrot" runat="server" />

                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />

                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:PortfolioPlanningDetails ID="PortfolioPlanningDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
         <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc8:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc5:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc6:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
