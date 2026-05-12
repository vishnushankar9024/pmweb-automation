<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="InitiativesBudget.aspx.vb" Inherits="Website.InitiativesBudget" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="InitiativeBudgetDetails.ascx" TagName="InitiativeBudgetDetails"
    TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="DocumentAdjustments.ascx" TagName="DocumentAdjustments" TagPrefix="uc10" %>
<%@ Register Src="DocumentScoring.ascx" TagName="InitiativeScoring" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="InitiativeRating.ascx" TagName="InitiativeRating" TagPrefix="uc9" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc11" %>
<%@ Register Src="DocumentTasks.ascx" TagName="DocumentTasks" TagPrefix="uc12" %>
<%@ Register Src="InitiativeEstimates.ascx" TagName="InitiativeEstimates" TagPrefix="uc13" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>
<%@ Register Src="ProjectCompanies.ascx" TagName="ProjectCompanies" TagPrefix="uc16" %>
<%@ Register Src="ProjectContacts.ascx" TagName="ProjectContacts" TagPrefix="uc17" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc18" %>

<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc19" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Portfolio/InitiativesBudget.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="radCode1" runat="server">
        <style type="text/css">
            .totalsFieldset {
                width: 100% !important;
            }
        </style>
        <script type="text/javascript">
            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }
            function goToProject() {
                var projectId = '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.LinkedProjectId%>'
                window.location.href = "Projects.aspx?Id=" + projectId + "&ModuleId=7&PageId=53";


            }
            function Close() {

                __doPostBack('Enable');
            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                //              $("span[id*='lblRating']").html("(" +rating +")");
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=Initiative');
                wnd.setSize(424, 435);
                wnd.add_close(RefreshRating);
                wnd.Center();
                return false;
            }
            function RefreshRating(Opener) {
                var updatePanel = $find($("[id$=pnlRating]")[0].id);
                var btnRefreshRating = $("a[id*=rdgRating][id$=btnRefreshRating]")[0];;
                if (updatePanel && btnRefreshRating == null) { __doPostBack(updatePanel.get_id()); }
                else if (btnRefreshRating) {
                    eval(btnRefreshRating.href.split(":")[1]);;
                }

            }

            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=BUDGETINITIATIVES&Id=" +
                                     '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
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
                var HasReports = '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("BUDGETINITIATIVES")%>';
                var RecordDescription = '<%=JSEscape(PM.PortfolioPlanning.BudgetInitiativeInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.PortfolioPlanning.BudgetInitiativeInfo.Name)%>';
                var Id = '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>';
                switch (Value) {
                    case 'GenerateProjectRecords':
                        OpenPOPUp('InitiativeGeneratePopup.aspx', 890, 430, true)

                        break;
                    case 'GeneratePMContracts':
                        OpenPOPUp('GenerateCommitmentsFromInitiative.aspx', 890, 500, true)


                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=BUDGETINITIATIVES&Id=" +
                         '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.TemplateId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BUDGETINITIATIVES&Id=" +
                        '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>'
                        + "&RecordDescription=" + RecordDescription
                        + "&EntityId=" + '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.TemplateId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=BUDGETINITIATIVES&Id=" + Id
                        + "&EntityId=" + '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = "InitiativesBudget.aspx?Id=0&ModuleId=1&PageId=" + querySt('PageId');
                        break;

                    case 'NewInitiativeFromTemplate':
                        OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?PageId=' + querySt('PageId'), 1020, 520)
                        break;

                    default:

                        break;
                }
            }

            function DetailMoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                var val = args.get_item().get_value();
                if (val == -8) {
                    var result;
                    result = confirm(WarningMsg_ConfirmDeleteLayout);
                    args.set_cancel(!result);
                    return false;
                }
                DetailClickHandler(val);
            }

            function InitiativeDetailCommandItemClicked(sender, args) {
                DetailClickHandler(args.get_item().get_commandName())
            }

            function DetailClickHandler(Value) {
                switch (Value) {

                    case 'AddItems':
                        OpenPOPUpToRedirect('EstimateItemsSelect.aspx?SourceId=BudgetInitiatives', 910, 580);

                        break;
                    case 'AddAssembly':
                        OpenPOPUp('EstimateAssembliesSelect.aspx?Source=Initiative', 1180, 560, true);

                        break;
                    case 'WorkOrderAddResources':
                        OpenPOPUp('SelectResourcesPopup.aspx?Source=Initiative', 900, 540, true);

                        break;
                    case 'RebindGrid':
                        if ($("[id$=btnRefresh][id*=rdgInitiativeBudgetDetails]").length > 0)
                            $("[id$=btnRefresh][id*=rdgInitiativeBudgetDetails]")[0].click();
                        break;
                    case 'PreviewConversion':
                        OpenPreviewConversion();

                        break;
                    case 'UseUnits':
                        if ($("[id$=btnUseUnits][id*=rdgInitiativeBudgetDetails]").length > 0) {
                            $("[id$=ckbUseUnits][id*=rdgInitiativeBudgetDetails]")[0].checked = !$("[id$=ckbUseUnits][id*=rdgInitiativeBudgetDetails]")[0].checked
                            $("[id$=btnUseUnits][id*=rdgInitiativeBudgetDetails]")[0].click();
                        }


                        break;
                    default:

                        break;
                }
            }


            function OpenLinkEstimatesPopup() {
                var grid = $find($("[id$=rdgEstimateDetails]")[0].id);
                var InitiativeId = '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>';
                return OpenPOPUp('LinkEstimatesPopup.aspx?InitiativeId=' + InitiativeId, 1000, 600, true, 'rdgEstimateDetails');
                return false;
            }

            function PopupConfirmationMessage() {
                var wnd = window.radopen("ConfirmMessagePopUp.aspx");
                wnd.setSize(370, 150);
                wnd.Center();
            }

            function OnClientDropDownOpened() {
                var tree = $find($("[id$=rdvPBS]")[0].id);
                if (tree != null) {
                    var Node = tree.get_selectedNode();
                    if (Node != null) {
                        Node.scrollIntoView(false);
                    }
                }
            }

            function OnClientItemClosing(sender, args) {
                if (forceradmenuToClose) {
                    forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
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
            MobileScreenWidth = 1024;
            function OpenPOPUp(URL, Width, Height, AddClose, gridId) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                if (AddClose == true) {
                    wnd.add_close(WindowClosed);
                    if (gridId) { GridToRebind = gridId; }
                }

                return false;
            }
            function isMobileScreen() {
                var browserWidth = $telerik.$(window).width();
                if (browserWidth <= MobileScreenWidth)
                    return true;
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpInitiativesBudget">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpInitiativesBudget" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpInitiativesBudget" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar SmallToolbar">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=134">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlInitiativesBudget" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" Skin="Default"
                    CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false"
                    NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                    OnItemsRequested="ddl_ItemsRequested">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true"
                    OnClientButtonClicked="click_handler" >
                    <Items>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=134" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                            Value="Save">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="NewInitiativeFromTemplate" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png" SecurityButtonType="Copy"
                                    CommandName="Copy">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" SecurityButtonType="CreateRevision" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="CreateRevision">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <%--  <telerik:RadToolBarSplitButton CssClass="menuMore" EnableDefaultButton="false" PostBack="false" CommandName="More">
                                        <Buttons>
                                            
                                           
                                        
                                            <telerik:RadToolBarButton PostBack="false"   CommandName="Generate" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            </telerik:RadToolBarButton>
                                             <telerik:RadToolBarButton PostBack="false"  CommandName="Help" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif" >
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Generate Project Records" Value="GenerateProjectRecords"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Generate Commitments" Value="GeneratePMContracts"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                   <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('BUDGETINITIATIVES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord"
                                        ImageUrl="Images/ToolBar/CopyRecord.png">
                                    </telerik:RadToolBarButton>--%>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="CreateRevision" CommandName="CreateRevision"
                                        ImageUrl="Images/ToolBar/Revision.png">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton EnableDefaultButton="false" PostBack="false" CommandName="Generate" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate"
                            ImageUrl="Images/ToolBar/Generate.png">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" CommandName="GenerateProjectRecords" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                                <%--<telerik:RadToolBarButton PostBack="false" CommandName="GenerateSchedule"  ImageUrl="Images/ToolBar/PMWebW.gif"></telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" CommandName="GenerateBudget"  ImageUrl="Images/ToolBar/PMWebW.gif"></telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton PostBack="false" CommandName="GeneratePMContracts" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <%--     <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" CausesValidation="false"
                                        Target="_blank" NavigateUrl="Help/PMWebUserManual_Portfolio.htm">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="Hide">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton CssClass="Hide" PostBack="False" Text="" Value="Rating">
                            <ItemTemplate>
                                <telerik:RadAjaxPanel runat="server" ID="pnlRating">
                                    <table style="width: 100px; height: 100%" border="0">
                                        <tr>
                                            <td align="center">
                                                <div>
                                                    <span>
                                                        <asp:Literal ID="Literal3" runat="server" Text="<%$Resources:PMWeb, Msg_Rating%>" /></span>
                                                    <telerik:RadRating ID="rdrating1" runat="server" ItemCount="5"
                                                        OnClientRated="OnClientRated" Value="3" SelectionMode="Continuous" Height="10px"
                                                        Precision="half" Orientation="Horizontal" />
                                                </div>
                                            </td>
                                            <td valign="bottom">
                                                <asp:Label runat="server" ID="lblRating" Text="(3)"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadAjaxPanel>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>


    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpInitiativesBudget" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        Width="100%">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header"></telerik:RadTab>
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Adjustments" Value="Adjustments"></telerik:RadTab>
            <telerik:RadTab Text="Estimate" Value="Estimate"></telerik:RadTab>
            <telerik:RadTab Text="Schedule" Value="Schedule"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Checklist" Value="Checklists" />
            <telerik:RadTab Text="Companies" Value="Companies" />
            <telerik:RadTab Text="Contacts" Value="Contacts" />
            <telerik:RadTab Text="Scoring" Value="Scoring"></telerik:RadTab>
            <telerik:RadTab Text="Ratings" Value="Rating"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpInitiativesBudget" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInitiativeBudget" runat="server" meta:Resourcekey="lblInitiativeBudget"
                                            Text="Initiative ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtInitiativeID" Text="" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" meta:Resourcekey="rfvCodes"
                                            ValidationGroup="Save" ControlToValidate="txtInitiativeID" CssClass="Validator"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblIDUnique" meta:Resourcekey="lblInitiativeProjectIDUnique" runat="server" Text="ID must be unique among Initiatives and Projects."
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" runat="server" meta:Resourcekey="lblName" Text="Name*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="255" ID="txtName" Text=""></asp:TextBox>
                                        <asp:Label ID="lblInitiativeProjectUnique" meta:Resourcekey="lblInitiativeProjectUnique"
                                            runat="server" Text="Name must be unique among Initiatives and Projects."
                                            Visible="False" Class="Validator"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" meta:Resourcekey="rfvNames"
                                            ValidationGroup="Save" ControlToValidate="txtName" CssClass="Validator" Display="Dynamic"
                                            ForeColor=""></asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:HyperLink ID="hliProgram" runat="server" CssClass="Link" meta:Resourcekey="hliProgram"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" Skin="Default" NoWrap="true" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" AutoPostBack="true"
                                            EnableVirtualScrolling="True" Height="300px">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblType" runat="server" meta:Resourcekey="lblType" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true"
                                            Height="300px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:Resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true"
                                            Height="300px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" meta:Resourcekey="lblReference" runat="server" Text="Reference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAbbreviation" runat="server" meta:Resourcekey="lblAbbreviation"
                                            Text="Abbreviation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="50" ID="txtAbbreviation" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliPlan" meta:Resourcekey="hliPlan"
                                            Text="Plan"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ReadOnly="true" ID="txtPlan"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="width: 182px !important">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="Right" Enabled="false" ReadOnly="true"
                                                        Text=""></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:HyperLink ID="hliLocation" runat="server" CssClass="Link" meta:Resourcekey="lblLocation"></asp:HyperLink>

                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocation" runat="server"
                                            Skin="Default" NoWrap="true"
                                            Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliTenantRequest" meta:Resourcekey="hliTenantRequest"
                                            Text="TenantRequest"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ReadOnly="true" ID="txtTenantRequest"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevision" runat="server" meta:Resourcekey="lblRevision" Text="Revision" Visible="false"></asp:Label>
                                    </td>
                                    <td class="NoWrap controlWidth">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td></td>
                                                <td align="right">
                                                    <asp:Label ID="lblDate" runat="server" meta:Resourcekey="lblDate" Text="Date" Visible="false"></asp:Label>
                                                </td>
                                                <td align="right" style="width: 74px">
                                                    <span runat="server" id="rmd_dtpDate" style="display: block">
                                                        <telerik:RadDatePicker ID="dtpDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            SelectedDate='<%# Date.Today %>' EnableTyping="False" Visible="false"
                                                            DatePopupButton-Visible="false">
                                                            <DateInput ID="DateInput1"
                                                                ReadOnly="true" runat="server">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblTemplate" runat="server" meta:Resourcekey="lblTemplate" Visible="false"
                                            Text="Template"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTemplates" runat="server" NoWrap="true"
                                            Visible="false" Height="300px" Skin="Default"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                            OnClientSelectedIndexChanged="onSelectedIndexChanged" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label runat="server" ID="hplCurrency" Height="24px" meta:Resourcekey="hplCurrency" Text="Currency1"></asp:Label>
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
                                        <asp:Label ID="lblPBS" meta:Resourcekey="lblPBS" runat="server" Text="PBS1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPBS" runat="server" CloseDropDownOnBlur="true" AutoPostBack="False"
                                            CausesValidation="False" OnClientDropDownOpened="OnClientDropDownOpened" DropDownCssClass="ddlTreeviewTemplate">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="" />
                                            </Items>
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)">
                                                    <telerik:RadTreeView ID="rdvPBS" runat="server" Height="250px"
                                                        MultipleSelect="false" ShowLineImages="true" OnNodeClick="rdvPBS_NodeClick"
                                                        OnNodeDataBound="rdvPBS_NodeDataBound" OnNodeExpand="rdvPBS_NodeExpand">
                                                    </telerik:RadTreeView>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblBudgetYear" runat="server" Text="Funding Year" meta:Resourcekey="lblFundingYear"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadNumericTextBox ID="rntBudgetYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true"
                                            IncrementSettings-InterceptMouseWheel="true" Label="" runat="server" Style="text-align: right"
                                            MaxValue="2100" MinValue="1899">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblPriority" runat="server" meta:Resourcekey="lblPriority" Text="Priority"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPriority" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true"
                                            Height="300px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable"  id="trResponsive">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStart" runat="server" meta:Resourcekey="lblStart" Text="Start"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpStart" style="display: block">
                                            <telerik:RadDatePicker ID="dtpStart" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>'>
                                                <DateInput ID="rdiFrom"
                                                    runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFinish" runat="server" meta:Resourcekey="lblFinish" Text="Finish"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpFinish" style="display: block">
                                            <telerik:RadDatePicker ID="dtpFinish" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>'>
                                                <DateInput ID="rdiTo" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:CompareValidator meta:resourcekey="cmpFromToDates" ID="cmpFromToDates" runat="server" Style="margin-bottom:5px;"
                                            ControlToValidate="dtpFinish" ControlToCompare="dtpStart" Type="Date" CssClass="Validator"
                                            ErrorMessage="Finish Date should be greater than Start Date" Display="Dynamic"
                                            ForeColor="" Operator="GreaterThanEqual"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblSponsor" runat="server" meta:resourcekey="lblSponsor" Text="To"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter1" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter1','HiddenField1'),this.id.replace('imgfilter1','ddlSponsor'),'Contacts')">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSponsor" runat="server" Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="385px"
                                            Filter="Contains" MarkFirstMatch="true" EnableItemCaching="false" NoWrap="True" AllowCustomText="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Height="300px" CausesValidation="False" OnItemsRequested="ddl_ItemsRequested">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label ID="lblFundingSource" runat="server" meta:Resourcekey="lblFundingSource"
                                            Text="Funding Source"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFundingSource" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true"
                                            Height="300px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="lblProjectManager" runat="server" meta:resourcekey="lblProjectManager" Text="To"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter2" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter2','HiddenField2'),this.id.replace('imgfilter2','ddlProjectManager'),'Contacts')">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjectManager" runat="server" Skin="Default" CloseDropDownOnBlur="true" DropDownWidth="385px"
                                            Filter="Contains" MarkFirstMatch="true" EnableItemCaching="false" NoWrap="True" AllowCustomText="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Height="300px" CausesValidation="False" OnItemsRequested="ddl_ItemsRequested">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth" style="vertical-align: top">
                                        <div class="lblMemo floatLeft">
                                            <asp:Label runat="server" meta:resourcekey="lblScope" ID="Label1" Text="Scope"></asp:Label>
                                        </div>
                                        <div class="floatRight">
                                            <asp:LinkButton runat="server" ID="imgMemo" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgMemo','txtScope'))" CssClass="SearchButton">
                                                                               <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="4000" TextMode="MultiLine" ID="txtScope" Width="100%" Style="box-sizing: border-box;"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <div id="dvTotals" runat="server">
                                <fieldset runat="server" id="fldTotals" class="totalsFieldset">
                                    <legend class="legend">
                                        <asp:Label runat="server" ID="lblTotals" meta:Resourcekey="lblTotals"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblExtCost" meta:Resourcekey="lblExtCost"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox runat="server" ID="txtExtCost" CssClass="Currency" ReadOnly="true"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblAdjustments" meta:Resourcekey="lblAdjustments"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox runat="server" ID="txtAdjustments" CssClass="Currency" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblInitiativeTotal" runat="server" meta:Resourcekey="lblInitiativeTotalCost"
                                                    Text="Initiative Total"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtInitiativeTotal" CssClass="Double" runat="server"
                                                    ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="NoWrap labelWidth">
                                                <asp:Label ID="lblWeightedScore" runat="server" meta:Resourcekey="lblWeightedScore"
                                                    Text="Weighted Score" ReadOnly="true"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtHWeightedScore" MaxLength="15" CssClass="Double" ReadOnly="true"
                                                    runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="NoWrap labelWidth">
                                                <asp:HyperLink ID="hliProject" runat="server" CssClass="Link" meta:Resourcekey="lblProject" Text="Project"></asp:HyperLink>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtProject" runat="server" Enabled="false"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>
                        </div>
                        <div class="col-4 col-4-right">
                            <table style="table-layout: fixed" class="TableNoSpacingNoBorder">
                                <tr>
                                    <td colspan="2"></td>
                                </tr>
                            </table>
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc19:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:InitiativeBudgetDetails ID="InitiativeBudgetDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAdjustments" runat="server">
            <uc10:DocumentAdjustments ID="DocumentAdjustments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvEstimate" runat="server">
            <uc13:InitiativeEstimates ID="InitiativeEstimates1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvTasks" runat="server">
            <uc12:DocumentTasks ID="DocumentTasks1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc6:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvCompanies" runat="server">
            <uc16:ProjectCompanies ID="ProjectCompanies1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvContacts" runat="server">
            <uc17:ProjectContacts ID="ProjectContacts1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc7:InitiativeScoring ID="InitiativeScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRating" runat="server">
            <uc9:InitiativeRating ID="InitiativeRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc11:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc5:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc18:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
