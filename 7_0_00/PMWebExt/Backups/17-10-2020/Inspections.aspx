<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Inspections.aspx.vb" Inherits="Website.Inspections" %>

<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc2" %>
<%@ Register Src="InspectionDetails.ascx" TagName="InspectionDetail" TagPrefix="uc3" %>
<%@ Register Src="InspectionImage.ascx" TagName="Image" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc5" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc6" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc7" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc8" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc9" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="radCode1" runat="server">
        <script type="text/javascript">
            var paper;
            var canvas;
            var IE = document.all ? true : false
            var arrDrawings = [];
            $(document).ready(function () {
                paper = new Raphael("Canvas");
                paper.clear();

                $("#Canvas").mousemove(function (e) {
                    var offset = $(this).offset();
                    mouseX = e.pageX;
                    mouseY = e.pageY;
                    mouseX = e.pageX - offset.left;
                    mouseY = e.pageY - offset.top;
                });

            });


            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
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

           <%-- function ddlTypesSelectedIndexChange(s, e) {
                var InspectionId = '<%=PM.Document.InspectionInfo.Id%>';
                if (InspectionId > 0) {

                }
            }--%>

            function OpenGenerateWorkOrderPopup(URL, Width, Height) {
                var wnd = window.radopen(URL);
                wnd.setSize(Width, Height);
                wnd.add_close(ClickGenerateWorkOrderButton);
                wnd.Center();
                return false;
            }

            function ClickGenerateWorkOrderButton() {
                var btn = $("input[id$=btnGenerateWorkOrder]");
                btn.click();
            }


            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=BUDGETINITIATIVES&Id=" +
                                     '<%= PM.PortfolioPlanning.BudgetInitiativeInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.PortfolioPlanning.BudgetInitiativeInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    if (args.get_item().get_value() == "GenerateWorkRequest") {
                        var button = mainToolBar.findItemByValue("GenerateWorkRequest");
                        button.click();
                    }
                    if (args.get_item().get_value() == "GenerateWorkOrder") {
                        var button = mainToolBar.findItemByValue("GenerateWorkOrder");
                        button.click();
                    }

                    if (args.get_item().get_value() == "GenerateInitiative") {
                        var button = mainToolBar.findItemByValue("GenerateInitiative");
                        button.click();
                    }
                    if (args.get_item().get_value() == "UpdateAsset") {
                        var button = document.getElementById("ctl00_CPH1_btnUpdateAsset");
                        button.click();
                    }


                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasReports = 'True';
                var HasMergeTemplate = 'True';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("INSPECTIONS")%>';
                var RecordDescription = '<%=PM.Document.InspectionInfo.Description%>';
                var Description = '<%=PM.Document.InspectionInfo.Description%>';
                var Id = '<%= PM.Document.InspectionInfo.Id%>';
                switch (Value) {
                    //case 'GenerateProjectRecords':

                    //    var wnd = window.radopen('InitiativeGeneratePopup.aspx');
                    //    wnd.setSize(520, 420);
                    //    wnd.Center();
                    //    wnd.add_close(Close);
                    //    break;
                    //case 'GeneratePMContracts':
                    //    var wnd = window.radopen('GenerateCommitmentsFromInitiative.aspx');
                    //    wnd.setSize(880, 500);
                    //    wnd.Center();

                    //break;
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=Inspections&Id=" +
                            '<%= PM.Document.InspectionInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=INSPECTIONS&Id=" +
                               '<%= PM.Document.InspectionInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=INSPECTIONS&Id=" +
                        '<%= PM.Document.InspectionInfo.Id%>'
                        + "&RecordDescription=" + RecordDescription
                        + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=INSPECTIONS&Id=" + Id
                    + "&EntityId=" + '<%=PM.Document.InspectionInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = "Inspections.aspx?Id=0&ModuleId=1&PageId=" + querySt('PageId');
                        break;

                        //case 'GenerateInitiative':
                        //    OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?Source=InspectionInitiative', 1020, 520)
                        //    break;
                    case 'GenerateProject':
                        OpenPOPUpToRedirect('AddInitiativeFromTemplatePopup.aspx?Source=InspectionProject', 1020, 520)
                        break;
                    case 'GenerateWorkOrder':
                        var TenantPropertyId = '<%=PM.Asset.TenantsInfo.PropertyId%>';
                        if (TenantPropertyId == '0') {
                            args.set_cancel(true);
                            alert(Msg_TenantRequestSelectProperty);
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

            function ConfirmUpdateAsset() { return confirm('If you continue condition data from this record will be copied to all linked assets.\n This process cannot be undone.' + '\n' + '\n' + 'Do you wish to continue? '); }


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
            function MenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
            }
            function CloseAssignMenu(sender, args) {
                forceradmenuToClose = true;
                $find($('.DocumentAssign')[0].id).close()

                return false;
            }
            function OnClientItemClosing(sender, args) {
                if (forceradmenuToClose) {
                    forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }

            function CloseMoreAssignMenu(sender, args) {
                forceMoreMenuToClose = true;
                var MoreMenu = $find($('.MoreMenu')[0].id);
                MoreMenu.findItemByValue('Assign').close()
                return false;
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
        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgInspectionDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInspectionDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="ddlTypes" />
                <telerik:AjaxUpdatedControl ControlID="btnUpdateAsset" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSaveAsLayout">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInspectionDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnSaveAsLayout" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnGenerateWorkOrder">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInspectionDetails" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="btnGenerateWorkOrder" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="ddlTypes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgInspectionDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=294">
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
                            <telerik:RadComboBox ID="ddlInspection" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" Skin="Default" EmptyMessage="Select Inspection..."
                                CloseDropDownOnBlur="true" Width="240px" AutoPostBack="false" OnItemsRequested="ddl_ItemsRequested"
                                NoWrap="true" Height="250px" CausesValidation="False" AllowCustomText="true"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True">
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                <Items>
                                    <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=294" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                                        Value="Save">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="New">
                                            </telerik:RadToolBarButton>

                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                                        CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint" SecurityButtonType="Read"
                                        EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
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
                                            <telerik:RadMenu runat="server" RenderMode="Lightweight" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="PMWeb Word" Value="ViewPMWebWord"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" CssClass="Generate">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Generate Work Request" Value="GenerateWorkRequest"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate Work Order" Value="GenerateWorkOrder"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate Initiative" Value="GenerateInitiative"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Generate Project" Value="GenerateProject"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Update Asset" Value="UpdateAsset"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Import" Value="Assign" CssClass="Assign">
                                                                <Items>
                                                                    <telerik:RadMenuItem>
                                                                        <ItemTemplate>
                                                                            <table style="width: 100%">
                                                                                <tr>
                                                                                    <td colspan="2">
                                                                                        <asp:LinkButton runat="server" ID="btnAssign" CssClass="btnToolbarAssign" OnClick="MobileMenubtnAssign_Click">
                                                                                                                                                                    <div class="Icon">
                                                                                                                                                                       &nbsp; 
                                                                                                                                                                    </div>
                                                                                        </asp:LinkButton>
                                                                                        &nbsp;&nbsp;
                                                                                        <asp:LinkButton runat="server" ID="btnCancelAssign" CssClass="btnToolbarCancelAssign" OnClientClick="return CloseMoreAssignMenu()">
                                                                                            <div class="Icon">
                                                                                                                &nbsp; 
                                                                                                            </div>
                                                                                        </asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2">
                                                                                        <asp:Label runat="server" ID="lblAssigned" CssClass="lblAssigned"></asp:Label>
                                                                                        <asp:LinkButton runat="server" ID="lnkRemoveAssignment" CssClass="removeAssign" OnClick="lnkRemoveAssignment_click">
                                                                                                                                                                    <div class="Icon">
                                                                                                                                                                                       &nbsp; 
                                                                                                                                                                                    </div>
                                                                                        </asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblDueDate" Text="Due Date" runat="server" meta:Resourcekey="lblDueDate"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%-- <telerik:RadDateInput Width="150px" ID="rdCalendar" runat="server" InvalidStyleDuration="100" EmptyMessage="Date">
                                                                                                                                                                </telerik:RadDateInput>--%>
                                                                                        <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                                                                            <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                                SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                                                EnableTyping="True">
                                                                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                                    runat="server">
                                                                                                </DateInput>
                                                                                                <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                                                </Calendar>
                                                                                            </telerik:RadDatePicker>
                                                                                        </span>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblUser" Text="User" runat="server" meta:Resourcekey="lblUser"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <telerik:RadComboBox ID="ddlCalendarUsers" runat="server" AllowCustomText="true" ZIndex="9001"
                                                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                                                                            OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="150px">
                                                                                        </telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                             <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('INSPECTIONS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" CssClass="Help"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton EnableDefaultButton="false" PostBack="false" CommandName="Generate" Value="Generate"
                                        ImageUrl="Images/ToolBar/Generate.png" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                CommandName="GenerateWorkRequest" Value="GenerateWorkRequest">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="True" Value="GenerateWorkOrder" CausesValidation="true" ValidationGroup="Gen" CommandName="GenerateWorkOrder" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="True" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                CommandName="GenerateInitiative" Value="GenerateInitiative">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="False" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                CommandName="GenerateProject" Value="GenerateProject">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="Hide">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton PostBack="false" SecurityButtonType="Calendar" OuterCssClass="HideOnMobileToolbar" CommandName="Assign" Value="btnAssign" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" RenderMode="Lightweight" CssClass="DocumentAssign" OnClientItemClosing="OnClientItemClosing" ID="radmen" ClickToOpen="true" OnClientItemClicked="MenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="assign">
                                                        <Items>
                                                            <telerik:RadMenuItem>
                                                                <ItemTemplate>
                                                                    <table style="width: 100%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:LinkButton runat="server" ID="btnAssign" CssClass="btnToolbarAssign" OnClick="btnAssign_Click">
                                                                                            <div class="Icon">
                                                                                               &nbsp; 
                                                                                            </div>
                                                                                </asp:LinkButton>
                                                                                &nbsp;&nbsp;
                                                                                        <asp:LinkButton runat="server" ID="btnCancelAssign" CssClass="btnToolbarCancelAssign" OnClientClick="return CloseAssignMenu()">
                                                                                            <div class="Icon">
                                                                                                               &nbsp; 
                                                                                                            </div>
                                                                                        </asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblDueDate" Text="Due Date" runat="server" meta:Resourcekey="lblDueDate"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <%-- <telerik:RadDateInput Width="150px" ID="rdCalendar" runat="server" InvalidStyleDuration="100" EmptyMessage="Date">
                                                                                        </telerik:RadDateInput>--%>
                                                                                <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                                                                    <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                        SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                                        EnableTyping="True">
                                                                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                            runat="server">
                                                                                        </DateInput>
                                                                                        <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                                        </Calendar>
                                                                                    </telerik:RadDatePicker>
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblUser" Text="User" runat="server" meta:Resourcekey="lblUser"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <telerik:RadComboBox ID="ddlCalendarUsers" runat="server" AllowCustomText="true" ZIndex="9001"
                                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableViewState="false" EnableVirtualScrolling="true"
                                                                                    OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Users" Height="200px" Width="150px">
                                                                                </telerik:RadComboBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton Value="btnDeleteAssign" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarDeleteAssign" SecurityButtonType="Calendar" ImageUrl="Images/Toolbar/user.png" CommandName="DeleteAssign" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <%--<telerik:RadToolBarButton ImageUrl="Images/Toolbox/Check.png" CommandName="UpdateAsset" Value="UpdateAsset" Text="Update Asset"
                                        PostBack="false" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" CausesValidation="false"
                                        Target="_blank" NavigateUrl="Help/PMWebUserManual_Portfolio.htm">
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                            <div style="display: inline-block">
                                <asp:Button runat="server" ID="btnUpdateAsset" CssClass="HideOnMobileToolbar" OnClientClick="return ConfirmUpdateAsset();" Text="Update Asset"></asp:Button>
                            </div>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

      <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpInspection" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Image" Value="Image" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Checklists" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpInspection" runat="server" SelectedIndex="0" CssClass="documentMultiPages" RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" meta:Resourcekey="lblProject" Text="Project*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                            Skin="Default" CausesValidation="false"
                                            Filter="Contains" MarkFirstMatch="true" AutoPostBack="true"
                                            NoWrap="true" Width="100%" Height="300px"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                            EnableVirtualScrolling="True">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProject"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProject"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" meta:Resourcekey="lblLocation" Text="Location"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLocation" ReadOnly="true" Enabled="false" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" Text="<%$ Resources:ProjectManagement, Label_Phase %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInspectionId" runat="server" meta:Resourcekey="lblInspectionId"
                                            Text="Inspection ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtInspectionId" Text="" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" meta:Resourcekey="rfvCode"
                                            ValidationGroup="Save" ControlToValidate="txtInspectionId" CssClass="Validator"
                                            Display="Dynamic" ErrorMessage="Enter The ID." ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblIDUnique" meta:Resourcekey="lblIDUnique" runat="server" Text="ID must be unique."
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" meta:Resourcekey="lblDescription" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" meta:Resourcekey="lblType" Text="Type*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Skin="Default" CloseDropDownOnBlur="true" AutoPostBack="true"
                                            Width="100%" Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Height="300px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvTypes" runat="server" ControlToValidate="ddlTypes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvTypes" runat="server" ControlToValidate="ddlTypes"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="Reuqired">
                                        </asp:CustomValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:Resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            Width="100%" Filter="Contains" MarkFirstMatch="true" NoWrap="true" AllowCustomText="true"
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
                                        <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDate" Text="Date">  </asp:Label>
                                    </td>
                                    <td class="controlWidth">

                                        <telerik:RadDatePicker ID="dtpDate" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default" Width="100%">
                                            <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar4" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime" meta:Resourcekey="lblTime" runat="server" Text="Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="rtpTime" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default" Width="100%">
                                            <DateInput ID="DateInput5" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar5" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <table class="TableNoSpacingNoBorder" style="width: 100%;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblInspectedBy" runat="server" meta:ResourceKey="lblInspectedBy" Text="Inspected By"></asp:Label>
                                                </td>
                                                <td style="float: right">
                                                    <asp:LinkButton runat="server" ID="imgfilter"
                                                        OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlInspectedBy'),'Contacts')"
                                                        CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlInspectedBy" runat="server" Width="100%"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
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
                                        <asp:RequiredFieldValidator ID="rfvSubmittedBy" runat="server" ControlToValidate="ddlInspectedBy"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvSubmittedBy" runat="server" ControlToValidate="ddlInspectedBy"
                                            ClientValidationFunction="ValidateComboWithimgfilter" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />


                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:Resourcekey="lblStatusRevision" runat="server" Text="Status / Revision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="font-size: 11px">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox runat="server" ID="txtRevision" CssClass="Right" ReadOnly="true"
                                                        Text=""></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>


                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc1:AssetRotator ID="PMrot" runat="server" />
                        </div>
                        <div class="col-4 col-4-right">
                            <uc2:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc3:InspectionDetail ID="InspectionDetail1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvImage" runat="server">
            <uc4:Image ID="InspectionImage1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc5:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc6:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc7:DocumentClauses id="DocumentClauses1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc8:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc9:DocumentAttachments id="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc10:WorkflowDocument id="WorkflowDocument" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam id="DocumentTeam1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc12:Notificationlog id="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>



</asp:Content>
