<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="TodoList.aspx.vb" Inherits="Website.TodoList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="TodoListDetails.ascx" TagName="TodoListDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc6" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
   
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
          <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpTodoList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTodoList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTodoList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlPhase">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtTodoListNumber" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlPhase" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.Document.TodoListInfo.ProjectId %>';
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "GenerateTransmittal") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Generate");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Document.TodoListInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Document.TodoListInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Document.TodoListInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Document.TodoListInfo.Description)%>';
                var Id = '<%= PM.Document.TodoListInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("TODOLIST")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=TODOLIST&Id=" +
                                '<%= PM.Document.TodoListInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.TodoListInfo.ProjectId%>' + "&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=TODOLIST&Id=" +
                               '<%= PM.Document.TodoListInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Document.TodoListInfo.ProjectId%>' + "&EntityType=0", "Notification",
                        'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=TODOLIST&Id=" +
                                '<%= PM.Document.TodoListInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.TodoListInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=TODOLIST&Id=" + Id
                            + "&EntityId=" + '<%=PM.Document.TodoListInfo.ProjectId%>' + "&EntityType=0",
                        'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'New':
                        window.location = "TodoList.aspx";
                        break;

                    default:
                        break;
                }
            }
            function GoToDocument(sender, eventArgs) {
                window.location = eventArgs.getDataKeyValue("Url");
            }
            function MenuClicked(sender, args) {
                //debugger;
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

            function OpenLinkedRecordsPopup() {
                var Description = '<%=JSEscape(PM.Document.TodoListInfo.Description)%>';
                var Id = '<%= PM.Document.TodoListInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkedRecordsPopup.aspx?ObjectType=TODOLIST&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkedRecordsPopup);
                return false;
            }

            function CloseLinkedRecordsPopup() {
                var btnRefreshLinkedRecords = $("[id$=btnRefreshLinkedRecords]");
                if (btnRefreshLinkedRecords) {
                    btnRefreshLinkedRecords.click();
                }
            }
            function OpenTransmittalsPopup() {
                var Description = '<%=JSEscape(PM.Document.TodoListInfo.Description)%>';
                var Id = '<%= PM.Document.TodoListInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('TransmittalsPopup.aspx?ObjectType=TODOLIST&RecordId=' + Id + '&Description=' + Description);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseTransmittalsPopup);
                return false;
            }

            function CloseTransmittalsPopup() {
                var btnRefreshTransmittals = $("[id$=btnRefreshTransmittals]");
                if (btnRefreshTransmittals) {
                    btnRefreshTransmittals.click();
                }
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="TodoListDetails1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpTodoList" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=106">
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
                <telerik:RadComboBox ID="ddlTodoList" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                    Width="240px" AutoPostBack="false" NoWrap="true" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    CausesValidation="False" Height="250px"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" ValidationGroup="Save" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <%--<telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="NewInitiative">
                                            </telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" SecurityButtonType="Copy">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="CreateRevision" SecurityButtonType="Add" Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>


                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" PostBack="false" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint rtbWrap rtbExpandDown rtbIconOnly"
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
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false"></telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

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
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Transmittal" Value="GenerateTransmittal"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
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
                                                                            
                                                                                <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                    SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                                    EnableTyping="True">
                                                                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                        runat="server">
                                                                                    </DateInput>
                                                                                    <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                                    </Calendar>
                                                                                </telerik:RadDatePicker>
                                                                            
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
                                                     <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('TODOLIST');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate rtbWrap rtbExpandDown rtbIconOnly">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Transmittal" Value="Generate"
                                    CommandName="GenerateTransmittal" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                                <%-- <telerik:RadToolBarButton PostBack="True" Text="" Value="Empty" CommandName="Empty">
                                            </telerik:RadToolBarButton>--%>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton PostBack="false" SecurityButtonType="Calendar" OuterCssClass="HideOnMobileToolbar" CommandName="Assign" Value="btnAssign" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" CssClass="DocumentAssign" OnClientItemClosing="OnClientItemClosing" ID="radmen" ClickToOpen="true" OnClientItemClicked="MenuClicked">
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
                                                                    
                                                                        <telerik:RadDatePicker ID="rdCalendar" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                            SelectedDate='<%# Date.Today %>' Width="105px" Skin="Default" Culture="English (United States)"
                                                                            EnableTyping="True">
                                                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                runat="server">
                                                                            </DateInput>
                                                                            <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                                            </Calendar>
                                                                        </telerik:RadDatePicker>
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
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpTodoList" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Value="Details" Text="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpTodoList" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$ Resources:ProjectManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                            Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlProject"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProject"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhase" runat="server" Text="<%$ Resources:ProjectManagement, Label_Phase %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" AutoPostBack="true" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPhase" runat="server" ControlToValidate="ddlPhase"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPhase" runat="server" ControlToValidate="ddlPhase"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NoWrap labelWidth">
                                        <asp:Label runat="server" ID="lblTodoListNumber" meta:Resourcekey="lblTodoListNumber" Text="Action Item #*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="13" ID="txtTodoListNumber"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvNumber" meta:Resourcekey="rfvNumber" ValidationGroup="Save" ControlToValidate="txtTodoListNumber"
                                            Display="Dynamic" runat="server" ErrorMessage="Enter the Action Item #" CssClass="Validator"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblTodoListNumberUnique" runat="server" CssClass="Validator" meta:Resourcekey="lblTodoListNumberUnique" Text="Action Item Number should be unique by project & phase."
                                            Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:ProjectManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="500" ID="txtDescription" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default" Style="width: 182px !important">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                                        Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                                        CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right">
                                                    <asp:TextBox ID="txtRevision" CssClass="PositiveInteger" Width="100%" runat="server"
                                                        MaxLength="9"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevisionNumber" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDocumentDate" runat="server" Text="<%$ Resources:ProjectManagement, Label_DocumentDate %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDocumentDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                SelectedDate='<%# Date.Today %>' Skin="Default" Culture="English (United States)"
                                                EnableTyping="true" DatePopupButton-Visible="false">
                                                <DateInput ID="DateInput2" ReadOnly="true"  disabled="disabled" runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultUser" meta:Resourcekey="lblDefaultUser" Text="User" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlUsers" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" CloseDropDownOnBlur="true" Height="300"
                                            EnableItemCaching="false" EmptyMessage="Select"
                                            NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvDefaultUser" runat="server" ControlToValidate="ddlUsers"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvDefaultUser" runat="server" ControlToValidate="ddlUsers"
                                            ClientValidationFunction="Validateddl" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblWBS" Text="<%$ Resources:ProjectManagement, Label_WBS %>"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AutoPostBack="false"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvWBS" runat="server" ControlToValidate="ddlWBS"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvWBS" runat="server" ControlToValidate="ddlWBS"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCSICode" meta:Resourcekey="lblCSICode" Text="CSI Code" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCSICode" MaxLength="100" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCSICode" ControlToValidate="txtCSICode"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategory" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
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
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPriority" runat="server" Text="<%$ Resources:ProjectManagement, Label_Priority %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPriority" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" NoWrap="True" AllowCustomText="True" Width="100%"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvPriority" runat="server" ControlToValidate="ddlPriority"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvPriority" runat="server" ControlToValidate="ddlPriority" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblLinkedRecords" meta:resourcekey="LblLinkedRecords" runat="server" Text="Linked Records"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedRecords" OnClientClick="return OpenLinkedRecordsPopup();">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshLinkedRecords" runat="server" class="Hide"></asp:Button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtLinkedRecords" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblTransmittals" meta:resourcekey="LblTransmittals" runat="server" Text="Transmittals"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtTransmittals" OnClientClick="return OpenTransmittalsPopup();">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:Button ID="btnRefreshTransmittals" runat="server" class="Hide"></asp:Button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtTransmittals" runat="Server" Width="100%" MaxLength="255" Style="text-align: right;" disabled="disabled" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                     
                        </div>
                        <div class="col-4 col-4-right">
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:TodoListDetails ID="TodoListDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc8:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc9:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc6:NotificationLog ID="NotificationLog1" runat="server" />

        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

<%--              <td style="width: 27px">
                                                                        <asp:Label ID="lblDocumentDate" runat="server" Text="<%$ Resources:ProjectManagement, Label_DocumentDate %>"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                                                                            <telerik:RadDatePicker ID="dtpDocumentDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                                SelectedDate='<%# Date.Today %>' Width="100px" Skin="Default" Culture="English (United States)"
                                                                                EnableTyping="true" DatePopupButton-Visible="false">
                                                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                                                    ReadOnly="true" runat="server">
                                                                                </DateInput>
                                                                            </telerik:RadDatePicker>
                                                                        </span>
                                                                    </td>--%>