<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="BluebeamMarkups.aspx.vb" Inherits="Website.BluebeamMarkups" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="BluebeamMarkupDetails.ascx" TagName="BluebeamMarkupDetails" TagPrefix="uc1" %>
<%@ Register Src="BluebeamMarkupFiles.ascx" TagName="BluebeamMarkupFiles" TagPrefix="uc12" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc3" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc4" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc5" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc6" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc7" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc8" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc10" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Toolbox/BluebeamMarkups.js" type="text/javascript"></script>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="mlpBluebeam">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBluebeam" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBluebeam" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <style>
            @media screen and (min-width:880px) and (max-width:1518px) {
                .ToolbarMobileMenu {
                    display: inline-block !important;
                    padding-left: 5px;
                }
            }
            @media screen and (min-width:1324px) and (max-width:1519px) {
                .HideOniPadToolbar {
                    display: none !important;
                }
            }
        </style>
        <script type="text/javascript">


            function OnClientButtonClicking(sender, args) {
                var BlueBeamHaveToken = '<%= PM.BluebeamMarkupsInfo.ValidToken%>';
                switch (args.get_item().get_commandName()) {
                    case 'BluebeamSync':
                        //if (BlueBeamHaveToken == 'True') {
                        //} else {
                        //    args.set_cancel(true);
                        //    OpenBlueBeamLoginPopup();
                        //}
                        //break;
                }
            }
            function FilterActions(sender, args) {
                var btn = $("[id$=btnFilterActions]");
                btn.click();
            }

            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;

            function MoreMenuClicked(sender, args) {
                
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                <%--if (args.get_item().get_value() == "BluebeamSync") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("BluebeamSync");
                    button.click();
                }
                if (args.get_item().get_value() == "OpenSession") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("OpenSession");
                    button.click();
                }--%>

               <%-- if (args.get_item().get_value() == "CloseSession") {
                    console.log('FROM MoreMenuClicked');
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("CloseSession");
                    button.click();
                }--%>
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.BluebeamMarkupsInfo.HasMergeTemplate%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("BLUEBEAMMARKUPS")%>';
                var RecordDescription = '<%=JSEscape(PM.BluebeamMarkupsInfo.Description)%>';
                var Description = '<%=JSEscape(PM.BluebeamMarkupsInfo.Description)%>';
                var Id = '<%= PM.BluebeamMarkupsInfo.Id%>';
                var HasReports = '<%= PM.BluebeamMarkupsInfo.HasReports%>';
                var EntityId = '<%=IIf(PM.BluebeamMarkupsInfo.ObjectTypeId < 0, 0, PM.BluebeamMarkupsInfo.ObjectId)%>';
                var EntityTypeId = '<%=IIf(PM.BluebeamMarkupsInfo.ObjectTypeId < 0, 0, IIf(PM.BluebeamMarkupsInfo.ObjectTypeId = 1, 0, 1))%>';
                var BlueBeamHaveToken = '<%= PM.BluebeamMarkupsInfo.ValidToken%>';
                var SessionID = '<%= PM.BluebeamMarkupsInfo.SessionID%>';
                console.log(Value);


                switch (Value) {
                    case 'New':
                        window.location = "BluebeamMarkups.aspx";
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=BLUEBEAMMARKUPS&Id=" + Id +
                                                                                "&Description=" + Description +
                                                                                "&RecordDescription=" + RecordDescription +
                                                                                "&EntityId=" + EntityId +
                                                                                "&EntityType=" + EntityTypeId, 1045, 515, false);
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=BLUEBEAMMARKUPS&Id=" + Id +
                                                                                        "&Description=" + Description +
                                                                                        "&RecordDescription=" + RecordDescription +
                                                                                        "&EntityId=" + EntityId +
                                                                                        "&EntityType=" + EntityTypeId, 1045, 515, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=BLUEBEAMMARKUPS&Id=" + Id +
                                                                                    "&EntityId=" + EntityId +
                                                                                    "&EntityType=" + EntityTypeId, 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BLUEBEAMMARKUPS&Id=" + Id +
                                                                                            "&RecordDescription=" + RecordDescription +
                                                                                            "&EntityId=" + EntityId +
                                                                                            "&EntityType=" + EntityTypeId,
                                        'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;


                        //case 'DisconnectPDFFiles':
                        //OpenPOPUp('DisconnectPDFFiles.aspx', 440, 220, false);
                        //break;

                    case 'OpenSession':
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var width = browserWidth * 0.9;
                        var height = browserHeight * 0.9;
                        var left = (screen.width - width) / 2;
                        var top = (screen.height - height) / 2;

                        window.open("https://studio.bluebeam.com/join.html?ID=" + SessionID, "_blanc", "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left);
                        break;

                    case 'CloseSession':
                        if (BlueBeamHaveToken == 'True') {
                            OpenPOPUp('EndBluebeamSession.aspx', 600, 270, false);
                        } else {
                            OpenBlueBeamLoginPopup();
                        }
                        break;
                    case 'BluebeamSync':
                        if (BlueBeamHaveToken == 'True') {
                            OpenPOPUp('BluebeamSessionSyncPopup.aspx', 420, 200, false);
                        } else {
                            OpenBlueBeamLoginPopup();
                        }
                        break;

                    default:
                        break;
                }
            }


            function OpenBlueBeamLoginPopup() {
                var left = (screen.width - 790) / 2;
                var top = (screen.height - 505) / 2;
                window.document.location.href = 'BlueBeamLoginPopup.aspx?Action=GetToken';
                return false;
            }

            function RefreshWindow() {
                window.location.reload();
            }

            function OnRefreshButtonClicking(sender, args) {
                var BlueBeamHaveToken = '<%= PM.BluebeamMarkupsInfo.ValidToken%>';
                if (BlueBeamHaveToken == 'True') {
                } else {
                    OpenBlueBeamLoginPopup();
                }
            }


            var OldScoreQuantityVal = 0;
            var OldScoreUnitCostVal = 0;
            var OldScoreTotalCostVal = 0;

            function AdjustScoreCalculation(gridId) {
                var grid = $("#" + gridId);
                // On change Score
                $("input[id*=" + gridId + "][id$=txtScore]").change(function () {
                    var row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Score");
                }
                ).focus(function () {
                    OldScoreUnitCostVal = $(this).val();
                }
                );

                // On change Points
                $("input[id*=" + gridId + "][id$=txtPointsAvailable]").change(function () {
                    var row = $(this).parents("tr:first"); CalculateWeightedScore(row, "PointAvailable");
                }
                ).focus(function () {
                    OldScoreQuantityVal = $(this).val();
                }
                );

                // On change Weight
                $("input[id*=" + gridId + "][id$=txtWeight]").change(function () {
                    var row = $(this).parents("tr:first"); CalculateWeightedScore(row, "Weight");
                }
                ).focus(function () {
                    OldScoreTotalCostVal = $(this).val();
                }
                );
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
        </script>
    </telerik:RadCodeBlock>

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=291">
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
                <telerik:RadComboBox ID="ddlBluebeamMarkups" runat="server" meta:resourcekey="ddlBluebeamMarkups" OnClientTextChange="LOD_DropDownTextChange"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" AutoPostBack="false" Skin="Default" NoWrap="True" AllowCustomText="True"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" Width="240px"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">

                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--     <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" 
                                    ImageUrl="Images/ToolBar/lookup.png" Value="Search">
                                </telerik:RadToolBarButton>--%>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" 
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision"
                                        ImageUrl="Images/ToolBar/Revision.png"  Value="CopyRecord" >
                                </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <%--<telerik:RadToolBarButton PostBack="false" Width ="150px" ImageUrl="Images/ToolBar/PMWebW.gif"  CommandName="ViewTemplates">
                                            </telerik:RadToolBarButton>--%>
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
                                                    </Items>
                                                </telerik:RadMenuItem>

                                                <telerik:RadMenuItem Text="Bluebeam Sync" EnableImageSprite="true" Value="BluebeamSync" CssClass="BluebeamSyncMobile" PostBack="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="End Session" EnableImageSprite="true" Value="CloseSession" CssClass="CloseBluebeamMobile"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Open Session" EnableImageSprite="true" Value="OpenSession" CssClass="OpenSessionMobile"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('BLUEBEAMMARKUPS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help ShowOnMobile" onclick="helpClick();"></telerik:RadMenuItem>



                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar HideOniPadToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" Text="Bluebeam Sync" ImageUrl="Images/ToolBar/EmailMessage.gif" OuterCssClass="HideOnMobileToolbar HideOniPadToolbar"
                            CommandName="BluebeamSync" Value="BluebeamSync" Enabled="<%# PM.BluebeamMarkupsInfo.IsInSession%>" PostBack="false" meta:resourcekey="BluebeamSync">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" Text="" ImageUrl="Images/ToolBar/EmailMessage.gif"
                                        CommandName="DisconnectPDFFiles" Enabled="<%# PM.BluebeamMarkupsInfo.IsInSession%>" PostBack="false">
                                </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" Text="Open Session" ImageUrl="Images/ToolBar/EmailMessage.gif" CssClass="HideOnMobileToolbar" OuterCssClass="HideOniPadToolbar"
                            CommandName="OpenSession" Value="OpenSession" Enabled="<%# PM.BluebeamMarkupsInfo.IsInSession AndAlso PM.BluebeamMarkupsInfo.ValidToken%>" PostBack="false" meta:resourcekey="OpenSession">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" ImageUrl="Images/ToolBar/EmailMessage.gif" CssClass="HideOnMobileToolbar" OuterCssClass="HideOniPadToolbar"
                            CommandName="CloseSession" Value="CloseSession" Enabled="<%# PM.BluebeamMarkupsInfo.IsInSession%>" Text="End Session" PostBack="false">
                        </telerik:RadToolBarButton>

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

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpBluebeam" Skin="Default" Width="100%" EnableViewState="True" CausesValidation="False" CssClass="documentTabs">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
            <telerik:RadTab Text="BluebeamMarkupFiles" Value="BluebeamMarkupFiles"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Checklists" Value="Checklists" />
            <telerik:RadTab Text="Scoring" Value="Scoring" />
            <telerik:RadTab Text="Ratings" Value="Rating" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Team Input" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpBluebeam" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlBluebeamHeader" runat="server" Width="100%" LoadingPanelID="ldpPM">
                <div class="PMMainPage ">
                    <div class="row" runat="server" style="display:none !important">
                        <asp:Label ID="lblBlueBeamError" CssClass="Validator" runat="server" meta:resourcekey="lblBlueBeamError"></asp:Label> 
                    </div>
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProjectLocation" Text="Project / Location" runat="server" meta:resourcekey="lblProjectAndLocation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProjectLocation" runat="server" Width="100%" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSessionID" runat="server" Text="Session ID" meta:resourcekey="lblSessionID"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSessionID" runat="server" Width="100%" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" Text="Description" runat="server" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStart" runat="server" Text=" Start" meta:resourcekey="lblStart"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 116px; padding-right: 8px;">
                                                    <asp:TextBox ID="txtStartDate" runat="server" disabled="disabled" Style="text-align: right;"></asp:TextBox>
                                                </td>
                                                <td style="width: 116px;">
                                                    <asp:TextBox ID="txtStartTime" runat="server" disabled="disabled" Style="text-align: right;"></asp:TextBox>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFinish" runat="server" Text="Finish" meta:resourcekey="lblFinish"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width: 116px; padding-right: 8px">
                                                    <asp:TextBox ID="txtFinishDate" runat="server" disabled="disabled" Style="text-align: right;"></asp:TextBox>
                                                </td>
                                                <td style="width: 116px;">
                                                    <asp:TextBox ID="txtFinishTime" runat="server" disabled="disabled" Style="text-align: right;"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>

                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSessionManager" Text="Session Manager" runat="server" meta:resourcekey="lblSessionManager"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSessionManager" runat="server" Width="100%" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblType" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" meta:Resourcekey="ddlTypes"
                                            Skin="Default" Style="font-size: 11px" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblCategory" Text="Category" meta:Resourcekey="lblCategory"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategories" runat="server" Width="100%" meta:Resourcekey="ddlCategories" Filter="Contains" MarkFirstMatch="true"
                                            Skin="Default" Style="font-size: 11px" AllowCustomText="True">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblStatusRevision" Text="Status / Revision" meta:Resourcekey="lblStatusAndRevision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" meta:Resourcekey="ddlStatus"
                                                        Skin="Default">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox ID="txtRevisionNumber" Width="100%" CssClass="PositiveInteger" runat="server" MaxLength="9" disabled="disabled">
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-4 col-4-middle">

                            <uc11:AssetRotator ID="PMrot" runat="server" />

                            <fieldset id="flsParticipants">
                                <legend>
                                    <asp:Label ID="lblParticipants" runat="server" Text="Participants" meta:resourcekey="lblParticipants"></asp:Label>
                                </legend>
                                <div>
                                    <div>
                                        <asp:Label ID="lblContacts" runat="server" meta:resourcekey="lblContacts" Text="Contacts"></asp:Label>
                                    </div>
                                    <asp:Repeater ID="rptParticipants" runat="server" Visible="true">
                                        <ItemTemplate>

                                            <asp:Label runat="server" ID="lblContact" Text='<%# DataBinder.Eval(Container.DataItem, "ContactDescription")%>' />

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </fieldset>

                            <table width="100%" class="colTable">
                                <tr>
                                    <td class="labelWidth"></td>
                                    <td class="controlWidth">
                                        <asp:Label ID="lblSessionFinished" runat="server" meta:resourcekey="lblSessionFinished" Text="Session Finished" CssClass="SessionFinished"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLastUpdated" runat="server" meta:resourcekey="lblLastUpdated" Text="Last Updated"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <asp:TextBox ID="txtLastUpdated" runat="server" Width="100%" disabled="disabled" Style="text-align: right;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliSessionOrigin" meta:Resourcekey="hliSessionOrigin" Text="Link">
                                        </asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSessionOrigin" runat="server" Width="100%" disabled="disabled"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>


                        </div>
                        <div class="col-4 col-4-right">

                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />

                        </div>

                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit">
            <uc1:BluebeamMarkupDetails ID="BluebeamMarkupDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvFiles" runat="server">
            <uc12:BluebeamMarkupFiles ID="BluebeamMarkupFiles" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc3:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc4:DocumentScoring ID="DocumentScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRating" runat="server">
            <uc5:DocumentRating ID="DocumentRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc6:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc7:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc8:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc10:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


    <asp:Button CssClass="Hide" ID="btnCloseSession" runat="server" />
    <asp:Button CssClass="Hide" ID="btnDisconnectPDFFiles" runat="server" />
    <asp:Button CssClass="Hide" ID="btnSyncMarkups" runat="server" />
</asp:Content>
