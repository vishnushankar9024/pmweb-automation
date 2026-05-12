<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="EstimateBidders.aspx.vb" Inherits="Website.EstimateBidders" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="EstimateBidderDetails.ascx" TagName="BidderDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>
<%@ Register Src="BidderSubmission.ascx" TagName="BidderSubmission" TagPrefix="uc6" %>
<%@ Register Src="BidderClauses.ascx" TagName="BidderClauses" TagPrefix="uc7" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc8" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc9" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc10" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="ngDocChecklists.ascx" TagName="DocumentCheckList" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc13" %>
<%@ Register Src="ngDocSpecs.ascx" TagName="DocumentSpecifications" TagPrefix="uc14" %>
<%@ Register Src="BidRFIs.ascx" TagName="BIDRFIs" TagPrefix="uc15" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Scoring.js" type="text/javascript"></script>
    <script src="JS/Estimates/Bidders.js" type="text/javascript"></script>
    <script src="JS/Estimates/jquery.countdown.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function OpenPreviewConversion() {
                var RecordCurrencyId = '<%=PM.Estimate.BidderInfo.CurrencyId%>';
                return OpenPOPUp("ConversionRatePopup.aspx?ObjectType=ESTIMATE_BIDDER&Id=" +
                                          '<%= PM.Estimate.BidderInfo.Id%>'
                          + "&ProjectId=" + '<%=PM.Estimate.BidderInfo.ProjectId%>' + "&RecordCurrencyId=" + RecordCurrencyId, 920, 415, false);
            }
            function OpenviewBidRFIAttachmentPopup(DocumentType,SecurityDocumentType, LineId, DocumentId, EntityTypeId, EntityId, IsLastRevision) {

                OpenPOPUpBidRFI('ViewAttachments.aspx?DocumentType=' + DocumentType + '&SecurityDocumentType=' + SecurityDocumentType + '&LineId=' + LineId + '&DocumentId=' +
                 DocumentId + '&EntityTypeId=' + EntityTypeId + '&EntityId=' + EntityId +
                  '&IsLastRevision=' + IsLastRevision, 920, 500);
                return false;
            }
            function OpenPOPUpBidRFI(URL, Width, Height) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(BidRFISelfRedirectAfterClosed);
                return false;
            }
            function BidRFISelfRedirectAfterClosed(oWnd, args) {
                var btnHiddenButton = $("[id$=btnRefreshAttachment]");
                btnHiddenButton.click();
            }
            function OpenPOPUpToSelfRedirect(URL, Width, Height) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(SelfRedirectAfterClosed);
                return false;
            }
            function SelfRedirectAfterClosed(oWnd, args) {
                window.location.href = window.location.href;
            }
            function SubmitWorkflowError(errorMsg, url) {
                alert("'" + errorMsg + "'");
                window.location = url;
            }

            function OnRadWindowShow(sender, args) {
                if (sender.get_contentFrame().src.indexOf('NDAPopUp.aspx') > -1 & !(sender.get_contentFrame().src.indexOf('Preview') > -1)) {
                    $('body').prepend('    <style type="text/css">.TelerikModalOverlay{filter:none !important;background-color:#678fc2 !important;opacity:1!important;}.rwCloseButton,.rwPinButton,.rwReloadButton,.rwMinimizeButton,.rwMaximizeButton{display:none !important;}  </style>')
                    $telerik.$('.rwCloseButton', sender.get_popupElement()).attr('disabled', 'disabled');
                }
                else if (sender.get_contentFrame().src.indexOf('NDAPopUp.aspx') > -1 & sender.get_contentFrame().src.indexOf('Preview') > -1) {
                    $('body').prepend('<style type="text/css">div.TelerikModalOverlay{filter:progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0) !important;background-color:none !important;opacity:0!important;}</style>')
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

            function MoreMenuClicked(sender, args) {

                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "SubmitBID") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("SubmitBID");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Estimate.BidderInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Estimate.BidderInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Estimate.BidderInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Estimate.BidderInfo.Description)%>';
                var Id = '<%= PM.Estimate.BidderInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("ESTIMATE_BIDDER")%>';
                switch (Value) {
                    case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ESTIMATE_BIDDER&Id=" +
                                   Id
                                   + "&RecordDescription=" + RecordDescription
                                   + "&EntityId=" + '<%=PM.Estimate.BidderInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=ESTIMATE_BIDDER&Id=" +
                                        '<%= PM.Estimate.BidderInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Estimate.BidderInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=ESTIMATE_BIDDER&Id=" +
                               '<%= PM.Estimate.BidderInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Estimate.BidderInfo.ProjectId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=ESTIMATE_BIDDER&Id=" + Id
                        + "&EntityId=" + '<%=PM.Estimate.BidderInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'New':
                        window.location = "EstimateBidders.aspx";
                        break;

                    case 'Submit':
                        return OpenWorkflowSubmitPopup('ESTIMATE_BIDDER');
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ESTIMATE_BIDDER&Id=" +
                                   Id
                                   + "&RecordDescription=" + RecordDescription
                                   + "&EntityId=" + '<%=PM.Estimate.BidderInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                        
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'ViewNDA':
                        return OpenNDAPreviewPopup();
                    default:
                        break;
                }
            }


            function OpenLevelingPopup(Id) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('BidLevelingPopup.aspx?Id=' + Id);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10 , browserHeight - 10);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(WindowCloseBestBid);
                return false;
            }

            function WindowCloseBestBid() {
                var btnRefreshGrid = $("[id$=btnRefreshGrid]");
                btnRefreshGrid.click();
            }

            function OpenDeclinePopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('BidderDeclinePopup.aspx');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    var wnWidth = (browserWidth * 0.3 > 500) ? browserWidth * 0.3 : 500;
                    var wnHeight = (browserHeight * 0.3 > 250) ? browserHeight * 0.3 : 250;
                    wnd.setSize(wnWidth, wnHeight);
                    wnd.Center();
                }
                wnd.add_close(WindowClosebtnPopup);
                return false;
            }

            function WindowClosebtnPopup() {
                var hdnrefreshPage = $("[id$=hdnrefreshPage]")[0];
                var btnRefreshPage = $("[id$=btnRefreshPage]");
                var btnOpenSubmit = $("[id$=btnOpenSubmit]");
                if (hdnrefreshPage.value == "1") {
                    hdnrefreshPage.value == "";
                    btnRefreshPage.click();


                }
                if (hdnrefreshPage.value == "2") {
                    hdnrefreshPage.value == "";
                    btnOpenSubmit.click();
                }
            }

            function OpenSubmitBidNotAllowed() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                setTimeout(function () {
                    var wnd = window.radopen('BidderSubmitStopPopup.aspx');
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight);
                        wnd.moveTo(0, 0);
                    }
                    else {
                        var wnWidth = (browserWidth * 0.3 > 500) ? browserWidth * 0.3 : 500;
                        var wnHeight = (browserHeight * 0.3 > 250) ? browserHeight * 0.3 : 250;
                        wnd.setSize(wnWidth, wnHeight);
                        wnd.Center();
                    }
                    wnd.add_close(WindowClosebtnPopup);
                }, 50);
                
                return false;
            }
            function ExecuteWorkflowLoopAlert(msg) {
                alert(msg);
                OpenSubmitBidGo();

            }
            function RefreshPageAfterSubmit() {
                var btnRefreshPage = $("[id$=btnRefreshPageAfterSubmit]");
                btnRefreshPage.click();
            }

            function removeAfterSubmitParameter() {
                var url = window.location.href;
                url = url.replace('&afterSubmit=1', '')
                window.history.replaceState(null, null, url);
            }

            function OpenSubmitBidGo() {
                removeAfterSubmitParameter();
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('BidderSubmitGoPopup.aspx');
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                } else {
                    var wnWidth = (browserWidth * 0.3 > 500) ? browserWidth * 0.3 : 500;
                    var wnHeight = (browserHeight * 0.3 > 250) ? browserHeight * 0.3 : 250;
                    wnd.setSize(wnWidth, wnHeight);
                    wnd.Center();
                }
                wnd.Center();
                return false;
            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=Bidder');
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

            function OpenWorkflowSubmitPopup(ObjectType) {
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
            }
        </script>
        <script type="text/javascript">
            function GenerateCounter() {
                hdnCounterSeconds = $("[id$=hdnCounterSeconds]")[0];
                if(hdnCounterSeconds != null)
                if (hdnCounterSeconds.value != "") {
                    $('#defaultCountdown').countdown({ until: hdnCounterSeconds.value });
                }
            }


            function OpenNDAPreviewPopup() {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('NDAPopUp.aspx?Preview=1');
                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                wnd.Center();
            }

        </script>
        <style>
            @media screen and (max-width:1324px) {
                .ToolbarMobileMenu {
                    display: inline-block !important;
                    padding-left: 5px;
                }
            }
        </style>
    </telerik:RadCodeBlock>


    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpBidders">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBidders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <telerik:AjaxUpdatedControl ControlID="hdnCounterSeconds" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBidders" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <telerik:AjaxUpdatedControl ControlID="hdnCounterSeconds" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <asp:HiddenField runat="server" ID="hdnCounterSeconds" />
   
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar LargeToolBar">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" Value="Save" CommandName="Save" AccessKey="s" ValidationGroup="Save" CausesValidation="true" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton Value="chklock" CommandName="IsLocked" ImageUrl="Images/ToolBar/Active.png">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="View Template" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="View NDA" Value="ViewNDA"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Submit BID" Value="SubmitBID" CssClass="SubmitBID"></telerik:RadMenuItem> 
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ESTIMATE_BIDDER');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup(''ESTIMATE_BIDDER');" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" PostBack="false" CommandName="Print" Text=" "></telerik:RadToolBarButton>--%>
                        <%--                                    <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>--%>
                        <%--   <telerik:RadToolBarButton OuterCssClass="HideOnMobileToolbar" PostBack="False" Text="" Value="Rating">
                                        <ItemTemplate>
                                            <telerik:RadAjaxPanel runat="server" ID="pnlRating">
                                                <table style="padding-right: 20px; width: 100px; height: 100%">
                                                    <tr>
                                                        <td align="center" style="padding-left: 5px">
                                                            <div>
                                                                <span style="padding-bottom: 0px">
                                                                    <asp:Literal ID="Literal3" runat="server" Text="<%$Resources:PMWeb, Msg_Rating%>" /></span>

                                                                <telerik:RadRating Style="padding-top: 0px" ID="rdrating1" runat="server" ItemCount="5" Value="3" SelectionMode="Continuous" Height="10px" Precision="half" Orientation="Horizontal" OnClientRated="OnClientRated" />
                                                            </div>
                                                        </td>
                                                        <td valign="bottom">
                                                            <asp:Label runat="server" ID="lblRating" Style="font-size: 10pt" Text="(3)"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadAjaxPanel>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton ID="btnViewNDA" PostBack="false" runat="server" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar" ImageUrl="Images/ToolBar/PMWebW.gif" CssClass="lnkButtonBar" Value="ViewNDA" CommandName="ViewNDA" Text="View NDA"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnSubmitBID" PostBack="true" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar" Value="SubmitBID"
                            CommandName="SubmitBID" Text="Submit BID" ImageUrl="Images/ToolBar/PMWebW.gif">
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
    <asp:HiddenField ID="hdnrefreshPage" Value="" runat="server" />
    <asp:Button runat="server" ID="btnRefreshPage" CssClass="Hide" />
    <asp:Button runat="server" ID="btnRefreshPageAfterSubmit" CssClass="Hide" />
    <asp:Button runat="server" ID="btnOpenSubmit" CssClass="Hide" />

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpBidders" Width="100%" EnableViewState="True"
        CausesValidation="false" OnTabClick="tbsDocument_TabClick">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="BID RFIs" Value="BIDRFIs"/>
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Value="Spec" Text="Specifications" />
            <telerik:RadTab Text="Checklist" Value="Checklists" />
            <telerik:RadTab Text="Scoring" Value="Scoring" />
            <telerik:RadTab Text="Ratings" Value="Rating" />
            <telerik:RadTab Text="Submission" Value="Submission" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />



        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpBidders" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="false">
                <div class="PMMainPage ">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable" id="tblInfo">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="Label1" meta:Resourcekey="lblProgram" runat="server" Text="Program"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtProgram" ReadOnly="true" Text="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:Resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtProject" ReadOnly="true" Text="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth ">
                                        <asp:Label ID="lblBidderNumber" meta:Resourcekey="lblBidderNumber" runat="server"
                                            Text="Bid #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBidderNumber" runat="server" ReadOnly="true" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliProcurementNumber" meta:Resourcekey="lblProcurementNumber" Text="Procurement #"></asp:HyperLink>

                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProcurementNumber" runat="server" ReadOnly="true" Text=""></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" Text="" />
                                         <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ValidationGroup="Save" ControlToValidate="txtDescription"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidCategory" meta:Resourcekey="lblBidCategory" runat="server" Text="Bid Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtBidCategory" ReadOnly="true" Text="" />
                                    </td>
                                </tr>
                                <tr runat="server" id="trCurrency">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCurrency" meta:Resourcekey="lblCurrency" runat="server" Text="Currency"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCurrency" ReadOnly="true" Text="" />
                                    </td>
                                </tr>
                                <%--                                                          <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" meta:Resourcekey="lblRevisionDate" runat="server" Text="Date"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <span runat="server" id="rmd_txtRevisionDate" style="display: block">
                                            <asp:TextBox ID="txtRevisionDate" CssClass="Right" ReadOnly="true"
                                                runat="server"></asp:TextBox>
                                        </span>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:resourcekey="lblStatusRevision" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <table id="tblStatus" runat="server" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" Visible="true" runat="server" Style="width: 182px !important">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="Right" ReadOnly="true" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidCutoffDate" meta:resourcekey="lblBidCutoff" runat="server" Text="Bid RFI Cutoff Date" ReadOnly="true"></asp:Label>
                                    </td>
                                    <td class="controlWidth">

                                        <span runat="server" id="rmd_rdpBidCutoffDate" style="display: block" >
                                             <telerik:RadDatePicker ID="rdpBidCutoffDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)"
                                                EnableTyping="False" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" Skin="Default"
                                                    ReadOnly="true" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidsDueDate" meta:resourcekey="lblBidsDueDate" runat="server" Text="Bids Due"></asp:Label>
                                    </td>
                                    <td class="controlWidth">

                                        <span runat="server" id="rmd_rdpBidsDue" style="display: block">
                                            <telerik:RadDatePicker ID="rdpBidsDue" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" EnableTyping="true" Enabled="false">
                                                <DateInput ID="DateInput3" runat="server">
                                                </DateInput>
                                                <Calendar ID="Calendar3" runat="server">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                         <asp:RequiredFieldValidator ID="rfvBidsDueDate" Visible="false" runat="server" ControlToValidate="rdpBidsDue" Display="Dynamic" ForeColor=""
                                            CssClass="Validator"  ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime" meta:resourcekey="lblTime" runat="server" Text="Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="rtpTime" runat="server" Skin="Metro" Width="100%" SelectedDate="7:00 AM" Enabled="false">
                                        </telerik:RadTimePicker>
                                         <asp:RequiredFieldValidator ID="rfvBidsDueTime" Visible="false" runat="server" ControlToValidate="rtpTime" Display="Dynamic" ForeColor=""
                                            CssClass="Validator"  ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>


                                </tr>
                                <tr style="line-height:24px;">
                                    <td colspan="2" style="overflow: hidden;text-overflow: ellipsis;white-space:nowrap;">
                                        <asp:Label runat="server" ID="lblServerTime" class="labelColor"></asp:Label>
                                    </td>
                                </tr>
                                <%--  <tr>
                                    <td>&nbsp;</td>
                                    <td style="padding-left: 10px;">
                                        <asp:LinkButton ID="btnViewNDA" runat="server" Style="color: #666666; cursor: pointer; text-decoration: underline;" meta:resourcekey="btnViewNDA" OnClientClick="return OpenNDAPreviewPopup();" Text="View Non-disclosure Agreement11"></asp:LinkButton>
                                    </td>
                                </tr>--%>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server">
                                <legend>
                                    <asp:Label runat="server" ID="lblBidInfo" Text="Bidder" meta:resourcekey="lblBidInfo" />
                                </legend>
                                <table class="colTable">

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblCompany" meta:resourcekey="lblCompany" Text="Company" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCompany" ReadOnly="true" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblBidTotal" meta:resourcekey="lblBidTotal" Text="Bid Total" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtBidTotal" CssClass="Currency" ReadOnly="true" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblZeroLines" meta:resourcekey="lblZeroLines" Text="0.00 Amount Lines" />
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtZeroAmountLines" CssClass="Integer" ReadOnly="true" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRemaningAknowledgments" runat="server" meta:resourcekey="lblRemaningAknowledgments" Text="Acknowledged"></asp:Label>
                                        </td>
                                        <td class="controlwidth">
                                            <table id="tblAcknowledgements" runat="server" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtRemainingAcknowledgements" CssClass="Integer" ReadOnly="true" Width="100%" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td align="left" style="width: 10%; padding-left: 10px; text-align: center;">
                                                        <asp:Label ID="lblOf" runat="server" meta:resourcekey="lblOf" Text="Of"></asp:Label>
                                                    </td>
                                                    <td align="right" style="padding-left: 10px;">
                                                        <asp:TextBox ID="txtTotalAcknowledgments" CssClass="Integer" ReadOnly="true" Width="100%" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <div runat="server" id="fldClock" style="text-transform: uppercase;">
                                <div id="defaultCountdown" style="width: 100%"></div>
                            </div>
                            <asp:Label ID="lblHidenRows" runat="server" Text="Some of the detail lines are hidden for security reasons." Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label>
                            <table class="colTable">
                                <tr>
                                    <td colspan="2">
                                        <table class="TableNoSpacingNoBorder" style="width: 100%; padding-top: 5px;">
                                            <tr>
                                                <td style="width: 175px; padding-right: 50px;">
                                                    <asp:Button runat="server" ID="btnDeclineInvitation" Text="Decline Invitation"
                                                        meta:resourcekey="btnDeclineInvitation" OnClientClick="return OpenDeclinePopup();" />
                                                </td>
                                                <td style="width: 175px;">
                                                    <asp:Button runat="server" ID="btnAcceptInvitation" Text="Accept Invitation"
                                                        meta:resourcekey="btnAcceptInvitation" />
                                                </td>
                                            </tr>
                                        </table>
                                        <%-- <asp:Button ID="btnSubmit" ValidationGroup="SumbitGroup" runat="server" Text="Submit"
                                                                                    meta:resourcekey="btnSubmit" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc8:AssetRotator ID="PMrot" runat="server" />
                            <uc13:Documentspecificationsheader id="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:BidderDetails ID="BidderDetails" runat="server" />
        </telerik:RadPageView>
         <telerik:RadPageView ID="pvBIDRFIs" runat="server" >
            <uc15:BIDRFIs ID="BIDRFIs" runat="server" />
            <asp:Button ID="btnRefreshAttachment" runat="server" CssClass="Hide" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc7:BidderClauses ID="BidderClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpec" runat="server" Visible="False">
            <uc14:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
        </telerik:RadPageView>
         <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc12:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc10:DocumentScoring ID="DocumentScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRating" runat="server">
            <uc9:DocumentRating ID="DocumentRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSubmission" runat="server">
            <uc6:BidderSubmission ID="BidderSubmission1" runat="server" />
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
    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server">
        <ClientEvents OnDateSelected="dateSelected" />
    </telerik:RadDatePicker>
    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Outlook" VisibleStatusbar="False"
        ReloadOnShow="True" Modal="True" OnClientShow="OnRadWindowShow" KeepInScreenBounds="True" Behavior="Default"
        IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
        Top="">
    </telerik:RadWindowManager>

</asp:Content>
