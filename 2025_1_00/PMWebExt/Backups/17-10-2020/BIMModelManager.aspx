<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="BIMModelManager.aspx.vb" Inherits="Website.BIMModelManager" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc1" %>
<%@ Register Src="DocumentScoring.ascx" TagName="DocumentScoring" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc7" %>
<%@ Register Src="DocumentRating.ascx" TagName="DocumentRating" TagPrefix="uc8" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>
<%@ Register Src="PMWebModelViewer2.ascx" TagName="PMWebModelViewer2" TagPrefix="uc10" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
           <telerik:AjaxSetting AjaxControlID="mlpBIMModelManager">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBIMModelManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBIMModelManager" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <asp:PlaceHolder ID="phModelManager" runat="server"></asp:PlaceHolder>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Scoring.js" type="text/javascript"></script>
    <style type="text/css">

        .header-table td {
            padding: 2px;
        }

        /* The following CSS needs to be copied to the page to produce textbox-like RadEditor */
        .RadGrid_PM .rgActiveRow td, .RadGrid_PM .rgHoveredRow td, .RadGrid_PM .rgEditRow td {
            border-bottom-color: #D0D7E5;
            white-space: normal;
        }

        .reLeftVerticalSide, .reRightVerticalSide, .reToolZone, .reToolCell {
            background: white !important;
        }



        .reContentCell {
            border-width: 0 !important;
        }

        .formInput {
            border: solid 1px black;
        }

        .RadEditor {
            filter: chroma(color=c2dcf0);
            width: 100% !important;
            height: 100% !important;
            min-width: 100% !imprtant;
            min-height: 100% !important;
        }

        .reWrapper_corner, .reWrapper_center {
            display: none !important; /* for FF */
            width: 100% !important;
            height: 100% !important;
        }

        td.reWrapper_corner, td.reWrapper_center {
            display: none\9 !important; /* for all versions of IE */
        }

        .reModule {
            display: none !important;
        }

        .RadWindow .rwTitleRow em {
            font: 16px "Segoe UI" !important;
            color: #FFFFFF !important;
            padding: 0 0 0 24px !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
            float: left !important;
            text-transform: uppercase !important;
        }

    </style>
        <script type="text/javascript">



            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
                updatePanel1.set_enableAJAX(false);
            }

            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Active") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                if (args.get_item().get_value() == "InActive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.BIM.BIMModelManagerInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.BIM.BIMModelManagerInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.BIM.BIMModelManagerInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.BIM.BIMModelManagerInfo.Description)%>';
                var Id = '<%= PM.BIM.BIMModelManagerInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("BIMModelManager")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=BIMModelManager&Id=" +
                            '<%= PM.BIM.BIMModelManagerInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.BIM.BIMModelManagerInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=BIMModelManager&Id=" +
                 '<%= PM.BIM.BIMModelManagerInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.BIM.BIMModelManagerInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=BIMModelManager&Id=" +
                            '<%= PM.BIM.BIMModelManagerInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=BIMModelManager&Id=" + Id
                    + "&EntityId=0&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = "BIMModelManager.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=BMM');
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
    <telerik:RadStyleSheetManager ID="SSH1" EnableStyleSheetCombine="true" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Editor.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Editor.Office2007.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Window.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Window.Office2007.css" />
        </StyleSheets>
    </telerik:RadStyleSheetManager>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=197">
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
                <telerik:RadComboBox ID="ddlBIMModelManagers" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" Width="100%" AutoPostBack="False" NoWrap="True" AllowCustomText="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--   <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                    Value="Search">
                                </telerik:RadToolBarButton>--%>
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
                                <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord"
                                    ImageUrl="Images/ToolBar/CopyRecord.png">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png"
                                    Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
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
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('BIMModelManager');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png"
                            CausesValidation="false" Value="Activate" CommandName="Activation" ToolTip="Activate" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton OuterCssClass="HideOnMobileToolbar"  style="display:none !important;" PostBack="False" Text="" Value="Rating" CssClass="Hide">
                            <ItemTemplate>
                                <telerik:RadAjaxPanel runat="server" ID="pnlRating">
                                    <table style="padding-right: 20px; width: 100px; height: 100%">
                                        <tr>
                                            <td align="center" style="padding-left: 5px">
                                                <div>
                                                    <span style="padding-bottom: 0px">
                                                    <telerik:RadRating Style="padding-top: 0px" ID="rdrating1" runat="server" ItemCount="5"
                                                        Value="3" SelectionMode="Continuous" Height="10px" Skin="Default" Precision="half"
                                                        Orientation="Horizontal" OnClientRated="OnClientRated" />
                                                </div>
                                            </td>
                                            <td valign="bottom">
                                                <asp:Label runat="server" ID="lblRating" Style="font-size: 10pt" Text="(3)"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadAjaxPanel>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <asp:Panel ID="pnlModelManagerHeader" runat="server">
        <%--    <tr>
                        <td valign="middle" style="padding: 5px 0px 0px 5px">
                            <img id="tblModelManagerHeaderimg" alt="" src="Images/Workflow/wMinus.png" onclick="return ToggleModelManagerHeaderSection(this);" />
                            <span style="color: #09296C; font-size: 11px; font-weight: bold">
                                <asp:Label ID="lblModelManagerHeader" runat="server" meta:resourcekey="lblModelManagerHeader"></asp:Label></span>
                            <img alt="" src="Images/Workflow/wSperator.png" />
                        </td>
                    </tr>--%>


        <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0"
            runat="server" MultiPageID="mlpBIMModelManager" Skin="Default" Width="100%" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
            EnableViewState="True" CausesValidation="False">
            <Tabs>
                <telerik:RadTab Text="Header" Value="Header" />
                <telerik:RadTab Text="3D Viewer" Value="3DViewer" CssClass="HideTabWhenDetailShownInHeader" />
                <telerik:RadTab Text="Specifications" Value="Spec" />
                <telerik:RadTab Text="Tasks" Value="Checklists" />
                <telerik:RadTab Text="Scoring" Value="Scoring" />
                <telerik:RadTab Text="Ratings" Value="Rating" TabIndex="2" />
                <telerik:RadTab Value="Notes" Text="Notes" />
                <telerik:RadTab Value="Attachments" Text="Attachments" />
                <telerik:RadTab Value="Workflow" Text="Workflow" />
                <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
                <telerik:RadTab Text="Notification" Value="NotificationLog" />
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="mlpBIMModelManager" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
            RenderSelectedPageOnly="True">
            <telerik:RadPageView ID="pvHeader" runat="server">
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                    <div class="PMMainPage ">
                        <div class="row JustifyContent R3Cols">
                            <div class="col-4 col-4-left ">
                                <table id="tblModelManagerHeader" class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLocation" runat="server"
                                                Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlLocation"
                                                CssClass="Validator" InitialValue="" meta:resourcekey="rfvLocations" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlLocation"
                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" meta:resourcekey="csvLocations">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                                Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="rfvProject" runat="server" ControlToValidate="ddlProject"
                                                CssClass="Validator" InitialValue="" meta:resourcekey="rfvProjects" ValidationGroup="Save"
                                                Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="csvProject" runat="server" ControlToValidate="ddlProject"
                                                ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                                CssClass="Validator" meta:resourcekey="csvProjects">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBuilding" runat="server" meta:resourcekey="lblBuilding"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBuilding" runat="server" Skin="Default"
                                                AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                                                Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>" ShowMoreResultsBox="True"
                                                EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblID" runat="server" meta:resourcekey="lblID"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtID" runat="server" CausesValidation="False"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="TxtID" CssClass="Validator"
                                                InitialValue="" meta:resourcekey="rfvIds" ValidationGroup="Save" Display="Dynamic"
                                                ForeColor=""></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDescription" runat="server" meta:resourcekey="LblDescription"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblBIMApplication" runat="server" meta:resourcekey="LblBIMApplication"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBIMApplication" runat="server" AutoPostBack="False" AllowCustomText="true"
                                                Filter="Contains" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                MarkFirstMatch="True" NoWrap="True" Skin="Default">
                                                <CollapseAnimation Duration="150" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblBIMModel" runat="server" meta:resourcekey="LblBIMModel"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtBIMModel" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblOwner" runat="server" meta:resourcekey="LblOwner"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlOwner" runat="server"
                                                Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" Height="270px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblType" runat="server" Text="Type" meta:resourcekey="lblType"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" MarkFirstMatch="True"
                                                Skin="Default" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                                CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server"
                                                Skin="Default" Style="font-size: 11px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLOD" meta:resourcekey="lblLOD" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLOD" AllowCustomText="true" Filter="Contains" runat="server"
                                                Skin="Default" Style="font-size: 11px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="LblStatusRev" runat="server" meta:resourcekey="LblStatusRev"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlStatus" runat="server" AllowCustomText="True" AutoPostBack="False"
                                                            Filter="Contains" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                            MarkFirstMatch="True" NoWrap="True" Skin="Default" Width="100%">
                                                            <CollapseAnimation Duration="150" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width:50px; padding-left: 8px">
                                                        <asp:TextBox ID="TxtRevision" CssClass="PositiveInteger" runat="server"
                                                            MaxLength="9"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-middle">
                                <table class="colTable">
                                    <tr>
                                        <td>
                                            <uc7:AssetRotator ID="PMrot" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                <table class="colTable">
                                    <tr>
                                        <td>
                                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </telerik:RadAjaxPanel>
            </telerik:RadPageView>
            <telerik:RadPageView ID="PV3DViewer" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
                <uc10:PMWebModelViewer2 ID="PMWebModelViewer21" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="PvSpec" runat="server">
                <uc1:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvChecklist" runat="server">
                <uc11:DocumentCheckList ID="DocumentCheckList1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvScorings" runat="server">
                <uc2:DocumentScoring ID="Scoring1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvRating" runat="server">
                <uc8:DocumentRating ID="DocumentRating1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
                <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                <uc4:DocumentAttachments ID="DocumentAttachments" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWorkflow" runat="server">
                <uc5:WorkflowDocument ID="WorkflowDocument" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
                <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotificationLog" runat="server">
                <uc6:NotificationLog ID="NotificationLog1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>


    </asp:Panel>
</asp:Content>
