<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="ActivityBoards.aspx.vb" Inherits="Website.ActivityBoards" Culture="auto" meta:resourcekey="Page" %>

<%@ Register Src="ActivityBoardCardView.ascx" TagName="ActivityBoardCardView" TagPrefix="uc1" %>
<%@ Register Src="ActivityBoardsListView.ascx" TagName="ActivityBoardsListView" TagPrefix="uc2" %>

<asp:Content ID="C2" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Toolbox/ActivityBoards.js" type="text/javascript"></script>
    <script src="JS/Toolbox/ActivityBoardsListView.js" type="text/javascript"></script>
    <link href="CSS/ActivityBoardCardView.css" rel="stylesheet" />
    <link href="CSS/ActivityBoardListView.css" rel="stylesheet" />
    <script src="JS/jquery-ui.js"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            var args = new Object();

            function seturl(url) {
                args.url = url;
            }

            function OpenBoardPOPUpToRedirect(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                wnd.set_visibleTitlebar(false);
                wnd._topResizer.parentElement.className = "";
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(BoardRedirectAfterClosed);
                return false;
            }
            function BoardRedirectAfterClosed() {
                if (args && args.url) {
                    window.location.href = args.url;
                }
            }

            function OpenCopyBoardPOPUp(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                wnd.set_visibleTitlebar(false);
                wnd._topResizer.parentElement.className = "";
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function OpenProfilePopup(URL) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                wnd.set_visibleTitlebar(false);
                wnd._topResizer.parentElement.className = "";
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    var popupwidth = browserWidth * 0.3;
                    if (popupwidth < 450)
                        popupwidth = 450;
                    wnd.setSize(popupwidth, 450);
                    wnd.Center();
                }
                wnd.add_close(WindowClosed);

                return false;
            }


            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "Activation") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Activation");
                        button.click();
                    }
<%--                    if (args.get_item().get_value() == "Activate") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Activation");
                        button.click();
                    }--%>
                    if (args.get_item().get_value() == "BoardSettings") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("BoardSettings");
                        button.click();
                    }
                    if (args.get_item().get_value() == "ListView") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("ListView");
                        button.click();
                    }
                    if (args.get_item().get_value() == "CardView") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("ListView");
                        button.click();
                    }
                    if (args.get_item().get_value() == "FilterTasks") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("FilterTasks");
                        button.click();
                    }
                    if (args.get_item().get_value() == "ProfileDialog") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("ProfileDialog");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            var a = 0;
            function maintoolbarClick(Value) {
                var Id = '<%=PM.ActivityBoardInfo.Id%>';
                var HasReports = '<%= PM.ActivityBoardInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.ActivityBoardInfo.RecordDescription)%>';
                switch (Value) {
                    case 'NewBoard':
                        window.location = "ActivityBoards.aspx?Id=0";
                        break;
                    case 'BoardSettings':
                        OpenBoardPOPUpToRedirect('BoardSettingsDialogPopup.aspx?Id=' + Id);
                        break;
                    case 'CopyBoard':
                        OpenCopyBoardPOPUp('CopyActivityBoardPopup.aspx?Id=' + Id);
                        break;
                    case 'ProfileDialog':
                        OpenProfilePopup('ActivityBoardProfileDialogPopup.aspx');
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'Print':
                        if (HasReports == 'True') {
                            OpenPOPUpNewStyle("ReportsPreviewPopup.aspx?ObjectType=ACTIVITYBOARDS&Id="
                                + '<%= PM.ActivityBoardInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.ActivityBoardInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUpNewStyle("ReportsPreviewPopup.aspx?ObjectType=ACTIVITYBOARDS&Id="
                                + '<%= PM.ActivityBoardInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.ActivityBoardInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    default:
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
        <style type="text/css">
            .rwWindowContent > iframe{
                border-radius:10px;
            }
            .rwWindowContent{
               background: transparent !important;
            }

            .ToolbarProfile .rtbIcon {
                padding: 0;
                width: 24px;
                height: 24px;
                display: inline-block;
                border-radius: 50%;
                background: none !important;
            }

            .ToolbarProfile.rtbItemHovered .rtbIcon,
            .ToolbarProfile.rtbItemFocused .rtbIcon,
            .ToolbarProfile.rtbDisabled .rtbIcon {
                background: none !important;
            }

            .FilterMenuItem > span{
                background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
                background-position: 48px 0px !important;
                display: inline-block !important;
                width: 24px !important;
                height: 24px !important;
                padding: 0 !important;
                border: 0px solid transparent !important;
                background-repeat: repeat !important;
            }
            
            .FilterMenuItem.rmDisabled > span {
                background-image: url(CSS/Images/ResponsiveIcons/24Disabled.png) !important;
            }

            .FilterMenuItem {
                border: 0px !important;
                background-position: 0 1050px !important;
                padding: 0 !important;
                padding-top: 0px !important;
                padding-right: 0px !important;
                padding-bottom: 0px !important;
                padding-left: 0px !important;
            }

            .FilterMenu .rmItem,.FilterMenu .rmItem .rmLink{
                width: inherit !important;
                padding-top:0 !important;
            }
            .RadMenu.FilterMenu .rmVertical .rmText{
                padding:0 20px 0 24px !important;
                margin:0 !important
            }
           .RadMenu.FilterMenu .rmVertical .rmSeparator .rmText{
                padding:0 !important;
                margin:0 !important
            }
            .RadMenu.FilterMenu .rmVertical .rmLeftImage{
                background-image: url(CSS/Images/ResponsiveIcons/16Enabled.png) !important;
                width: 16px;
                height: 16px;
                margin-left:3px !important;
           }
                      
            .FilterMenu .rmRoundedCorners .rmGroup .rmItem
           ,.FilterMenu.RadMenu_Default .rmRootGroup a.rmLink.rmRootLink
           ,.FilterMenu .rmBottomFix  {
                background-image: none !important;
            }

            .FilterMenu .rmSeparator{
                padding-top: 0 !important;
            }
            
            .RadMenu .rmGroup a.rmLink{
                border:1px white solid !important;
             }

              .RadMenu .rmGroup a.rmLink:hover, .RadMenu .rmGroup a.rmFocused, .RadMenu .rmGroup a.rmSelected, .RadMenu .rmGroup a.rmExpanded {
                color: #455A64;
                background: #ECEFF1 !important;
                border:1px #b0b0b0 solid !important;
                }

            .RadMenu .rmGroup a.rmLink:hover .rmText, .RadMenu .rmGroup a.rmFocused .rmText, .RadMenu .rmGroup a.rmSelected .rmText, .RadMenu .rmGroup a.rmExpanded .rmText {
                background: none !important;
            }

            .RadMenu .rmLink {
                height: 20px;
            }
            
            @media screen and (min-width: 320px) and (max-width: 843px) {
              /*  .divContentHolder {
                    margin-top: 60px;
                }*/
            }

        </style>
    </telerik:RadCodeBlock>

    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
        MaxDate="12/31/2100" runat="server" Skin="Default">
        <ClientEvents OnDateSelected="DueDateSelected" />
    </telerik:RadDatePicker>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar LargeToolBar">
        <tr valign="top">
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewBoard" AccessKey="n"  
                                    CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="CopyBoard">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton CommandName="Print" SecurityButtonType="Read" EnableImageSprite="true" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" 
                                    CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <%--<telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>--%>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png"
                            CommandName="Activation" ToolTip="Inactivate1" Value="Activation" CausesValidation="false" OuterCssClass="ToolbarActive HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Post.png"
                            CommandName="BoardSettings" PostBack="false" ToolTip="Board Settings" Value="BoardSettings" CausesValidation="false" OuterCssClass="ToolbarBoardSettings HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Post.png"
                            CommandName="ListView" Value="ListView" ToolTip="List View" CausesValidation="false" OuterCssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                       <telerik:RadToolBarButton PostBack="false" CommandName="FilterTasks" Value="FilterTasks" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ToolTip="Filter Tasks" ID="FilterMenu" CssClass="FilterMenu" ClickToOpen="true"  EnableRoundedCorners="true" OnItemClick="FilterMenu_ItemClick"
                                            CollapseAnimation-Type="None" EnableSelection="true" EnableShadows="true">
                                    <Items>
                                        <telerik:RadMenuItem  CssClass="FilterMenuItem" Value="FilterMenuItem" PostBack="false">
                                            <Items>
                                                <telerik:RadMenuItem Text="All Tasks" Value="AllTasks" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Tasks Done" Value="TasksDone" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Tasks Not Done" Value="TasksNotDone" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="My Tasks Only" Value="MyTasks" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <%--<telerik:RadMenuItem IsSeparator="true"></telerik:RadMenuItem>--%>
                                                <%--<telerik:RadMenuItem Text="Show Subtasks" Value="ShowSubtasks" EnableImageSprite="true"></telerik:RadMenuItem>--%>
                                            </Items>
                                        </telerik:RadMenuItem>                                       
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Post.png" PostBack="false"
                            CommandName="ProfileDialog" Value="ProfileDialog" ToolTip="Profile" CausesValidation="false" OuterCssClass="ToolbarUser HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        <%--<telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>--%>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Inactivate" Value="Activation" CssClass="Activation" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <%--<telerik:RadMenuItem Text="Activate" Value="Activate" CssClass="Activate" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Inactivate" Value="Inactivate" CssClass="Inactivate" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>--%>
                                                <telerik:RadMenuItem Text="Board Settings" Value="BoardSettings" CssClass="BoardSettings" SecurityButtonType="Edit" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="List View" Value="ListView" CssClass="ListView" SecurityButtonType="Read" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Card View" Value="CardView" CssClass="TaskView" SecurityButtonType="Read" EnableImageSprite="true"></telerik:RadMenuItem>
                                              
                                                <telerik:RadMenuItem Text="Profile" Value="ProfileDialog" CssClass="ProfileDialog" SecurityButtonType="Read" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ACTIVITYBOARDS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>

            </td>

            <td style="width: 100%"></td>
        </tr>
    </table>

    <uc1:ActivityBoardCardView ID="ActivityBoardCardView1" runat="server" />

    <uc2:ActivityBoardsListView ID="ActivityBoardsListView" runat="server" visible="false" />
</asp:Content>

