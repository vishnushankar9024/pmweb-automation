<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="MeetingMinutes.aspx.vb" Inherits="Website.MeetingMinutes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="MeetingMinuteDetails.ascx" TagName="MeetingMinuteDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="Participants.ascx" TagName="Participants" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc9" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <link href="CSS/ControlsCSS/Toolbar.css" rel="stylesheet" />
    <style type="text/css">
        /* The following CSS needs to be copied to the page to produce textbox-like RadEditor */

        .jspPane {
            width: auto !important;
        }

        .RadGrid_PM .rgActiveRow td, .RadGrid_PM .rgHoveredRow td, .RadGrid_PM .rgEditRow td {
            border-bottom-color: #D0D7E5;
            white-space: normal;
        }

        .reLeftVerticalSide,
        .reRightVerticalSide,
        .reToolZone,
        .reToolCell {
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
            min-width: 100% !important;
            min-height: 100% !important;
        }

        .reWrapper_corner,
        .reWrapper_center {
            display: none !important; /* for FF */
            width: 100% !important;
            height: 100% !important;
        }

        td.reWrapper_corner,
        td.reWrapper_center {
            display: none !important; /* for all versions of IE */
        }

        .reModule {
            display: none !important;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.Document.MeetingMinutesInfo.ProjectId %>';
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;


            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
                updatePanel1.set_enableAJAX(false);
            }
            function maintoolbarClick(value) {
                var HasMergeTemplate = '<%= PM.Document.MeetingMinutesInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Document.MeetingMinutesInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Document.MeetingMinutesInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Document.MeetingMinutesInfo.Description)%>';
                var Id = '<%= PM.Document.MeetingMinutesInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("MEETINGMINUTES")%>';
                switch (value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=MEETINGMINUTES&Id=" +
                                '<%= PM.Document.MeetingMinutesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.MeetingMinutesInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=MEETINGMINUTES&Id=" +
                               '<%= PM.Document.MeetingMinutesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.MeetingMinutesInfo.ProjectId%>' + "&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=MEETINGMINUTES&Id=" +
                               '<%= PM.Document.MeetingMinutesInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Document.MeetingMinutesInfo.ProjectId%>' + "&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=MEETINGMINUTES&Id=" + Id
                        + "&EntityId=" + '<%=PM.Document.MeetingMinutesInfo.ProjectId%>' + "&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'New':
                        window.location = " MeetingMinutes.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function OnClientLoad(editor) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";

            }
            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function check(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }
            }
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "GenerateTransmittal") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Generate");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
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

            function CreateDocNumberClick(sender, args) {
                var button = $("[id$=btnCreateDocNumber]");
                button.click();
            }
            function OpenTransmittalsPopup() {
                var Description = '<%=JSEscape(PM.Document.MeetingMinutesInfo.Description)%>';
                var Id = '<%= PM.Document.MeetingMinutesInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('TransmittalsPopup.aspx?ObjectType=MEETINGMINUTES&RecordId=' + Id + '&Description=' + Description);
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
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpMeetingMinutes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMeetingMinutes" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMeetingMinutes" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=82">
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
                <telerik:RadComboBox ID="ddlMeetingMinutes" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" Width="240px" AutoPostBack="False" NoWrap="True" AllowCustomText="True"
                    CausesValidation="False" Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:resourcekey="ddlMeetingMinutes"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                                <%-- <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/Global/AddLine.png"
                                                CommandName="NewInitiativeFromTemplate">
                                            </telerik:RadToolBarButton>--%>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy" SecurityButtonType="Copy">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="CreateRevision" SecurityButtonType="Add" Visible="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <%--   <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search">
                                    </telerik:RadToolBarButton>--%>
                        <%-- <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>
                        <%--  <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png">
                                    </telerik:RadToolBarButton>
                        --%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar" EnableDefaultButton="false" PostBack="false">
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
                                                <telerik:RadMenuItem Value="CreateNext" EnableImageSprite="true" Text="Create Next" onclick="CreateDocNumberClick();" meta:resourcekey="btnCreateDocNumber"></telerik:RadMenuItem>

                                                <telerik:RadMenuItem Text="Recent" radgValue="Recent" onclick="OpenRecentDocumentsPopup('MEETINGMINUTES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <%--   <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png" Visible="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                            EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate rtbWrap rtbExpandDown rtbIconOnly">
                            <Buttons>
                                <telerik:RadToolBarButton Text="Transmittal" Value="Generate" CommandName="GenerateTransmittal" ImageUrl="Images/ToolBar/PMWebW.gif">
                                </telerik:RadToolBarButton>
                                <%--     <telerik:RadToolBarButton PostBack="True" Text="" Value="Empty" CommandName="Empty">
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
                        <telerik:RadToolBarButton Value="btnDeleteAssign" SecurityButtonType="Calendar" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarDeleteAssign" ImageUrl="Images/Toolbar/user.png" CommandName="DeleteAssign" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ID="btnCreateDocNumber" PostBack="true" runat="server" CssClass="lnkCreateNext" OuterCssClass="HideOnMobileToolbar" Value="CreateNext"
                            meta:resourcekey="btnCreateNext" CommandName="CreateNext" Text="Create Next" ImageUrl="Images/ToolBar/PMWebW.gif" OnClientClick="CreateDocNumberClick();" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <%-- <td class="ToolbarTd HideOnMobileToolbar" style="">
                <asp:Button ID="btnCreateDocNumber" ValidationGroup="Save" runat="server"
                    meta:resourcekey="btnCreateDocNumber" Text="Create Next" CssClass="CreateDocNumber" />
            </td>--%>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" CssClass="documentTabs"
        runat="server" MultiPageID="mlpMeetingMinutes" Skin="Default" Width="100%" ScrollChildren="true" ScrollButtonsPosition="Left"
        EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Value="Header" Text="Header" Selected="True" />
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
    <telerik:RadMultiPage ID="mlpMeetingMinutes" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="true">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr valign="top">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$ Resources:ProjectManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                            Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
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
                                        <telerik:RadComboBox ID="ddlPhase" runat="server" AllowCustomText="True" AutoPostBack="false"
                                            CausesValidation="False" Filter="Contains" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            MarkFirstMatch="True" NoWrap="True" Skin="Default">
                                            <CollapseAnimation Duration="150" Type="OutQuint" />
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
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblWBS" Text="<%$ Resources:ProjectManagement, Label_WBS %>"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgWBS" CssClass="SearchButton">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlWBS" runat="server" AutoPostBack="false"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                            NoWrap="True" AllowCustomText="true"
                                            OnClientDropDownClosed="dllcompClientClosed1"
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
                                        <asp:Label ID="lblType" runat="server" Text="Type" meta:resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server" Filter="Contains" MarkFirstMatch="True"
                                            Skin="Default" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                            CssClass="Validator" InitialValue="-- Select --" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvType" runat="server" ControlToValidate="ddlType" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblChangeEventNumber" runat="server" meta:resourcekey="lblChangeEventNumber"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecordNumber" MaxLength="13" runat="server" ValidationGroup="Save"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRecordNumber" runat="server" ControlToValidate="txtRecordNumber" Display="Dynamic"
                                            CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"
                                            ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblRecordNumberAlreadyExist" runat="server" CssClass="Validator" Text="<%$Resources:PMWeb, WarningMsg_RecordNumberAlreadyExists %>"
                                            Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr runat="server" id="trMeeting">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDocNumber" runat="server" Text="Meeting #" meta:resourcekey="lblDocNumber"></asp:Label>
                                    </td>
                                    <td class="controlWidth">

                                        <asp:TextBox ID="txtDocNumber" runat="server" ReadOnly="true"></asp:TextBox>
                                    </td>



                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:ProjectManagement, Label_Description %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" MaxLength="1000"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" ControlToValidate="txtDescription"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLocation" MaxLength="100" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvLocation" ControlToValidate="txtLocation"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
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
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" EmptyMessage="" Filter="Contains" runat="server" Skin="Default"
                                            Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor="" Visible="false"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCategory" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMeetingDate" meta:resourcekey="lblMeetingDate" runat="server" Text="Meeting Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpMeetingDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpMeetingDate" runat="server" Culture="English (United States)"
                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                Skin="Default">
                                                <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                    Skin="Default">
                                                </DateInput>
                                                <Calendar ID="Calendar2" runat="server" Skin="Default">
                                                </Calendar>
                                            </telerik:RadDatePicker>
                                        </span>
                                        <asp:RequiredFieldValidator ID="rfvMeetingDate" ControlToValidate="dtpMeetingDate"
                                            runat="server" CssClass="Validator" Display="Dynamic"
                                            ValidationGroup="Save" Visible="false" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <table class="colTable" id="trMeetingStartEnd" runat="server">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStarted" meta:resourcekey="lblStarted" runat="server" Text="Started"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpStarted" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default">
                                            <DateInput ID="DateInput1" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar1" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvMeetingStartTime" ControlToValidate="dtpStarted"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEnded" runat="server" meta:resourcekey="lblEnded" Text="Ended"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpEnded" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default">
                                            <DateInput ID="DateInput3" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar3" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="rfvMeetingEndTime" ControlToValidate="dtpEnded"
                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" runat="server" Text="<%$ Resources:ProjectManagement, Label_StatusRevision %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table id="tblStatus" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important"></telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="rfvStatus" ControlToValidate="ddlStatus"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="CsvStatus" runat="server" ControlToValidate="ddlStatus"
                                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                                        CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                    </asp:CustomValidator>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; min-width: 20px; text-align: right">
                                                    <asp:TextBox ID="txtRevision" CssClass="PositiveInteger" runat="server" MaxLength="9" Width="100%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvRevision" ControlToValidate="txtRevision"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
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
                                <tr>
                                    <td colspan="2">
                                        <fieldset>
                                            <legend>
                                                <asp:Label ID="lblNextMeeting" runat="server" meta:resourcekey="lblNextMeeting" Text="NEXT MEETING" CssClass="legend"></asp:Label>
                                            </legend>
                                        </fieldset>
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblNextMeetingLocation" runat="server" meta:resourcekey="lblNextMeetingLocation"
                                                        Text="Location"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtNextMeetingLocation" MaxLength="100" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvNextMeetingLocation" ControlToValidate="txtNextMeetingLocation"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblNextMeetingMeetDate" runat="server" meta:resourcekey="lblNextMeetingMeetDate"
                                                        Text="Meet Date"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <span runat="server" id="rmd_dtpNextMeetingMeetDate" style="display: block">
                                                        <telerik:RadDatePicker ID="dtpNextMeetingMeetDate" runat="server" Culture="English (United States)"
                                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                            Skin="Default">
                                                            <DateInput ID="DateInput4" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                                Skin="Default">
                                                            </DateInput>
                                                            <Calendar ID="Calendar4" runat="server" Skin="Default">
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </span>
                                                    <asp:RequiredFieldValidator ID="rfvNextMeetingDate" ControlToValidate="dtpNextMeetingMeetDate"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblNextMeetingStart" runat="server" meta:resourcekey="lblNextMeetingStart"
                                                        Text="Next Time"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadTimePicker ID="dtpNextMeetingMeetStart" runat="server" Culture="English (United States)"
                                                        EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                                        Skin="Default">
                                                        <DateInput ID="DateInput5" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                            Skin="Default">
                                                        </DateInput>
                                                        <Calendar ID="Calendar5" runat="server" Skin="Default">
                                                        </Calendar>
                                                    </telerik:RadTimePicker>
                                                    <asp:RequiredFieldValidator ID="rfvNextMeetingStartTime" ControlToValidate="dtpNextMeetingMeetStart"
                                                        runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                        ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server" id="fsParticipants">
                                <legend>
                                    <asp:Label ID="lblParticipants" runat="server" meta:resourcekey="lblParticipants" Text="Participants" CssClass="legend"></asp:Label>
                                </legend>
                                <uc6:Participants ID="Participants" runat="server" />
                            </fieldset>


                        </div>
                        <div class="col-4 col-4-right">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:MeetingMinuteDetails ID="MeetingMinuteDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc9:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc10:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc4:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>



    <%--   <tr>
        <td width="12%">
            <asp:Label ID="lblDocumentDate" runat="server" Text="<%$ Resources:ProjectManagement, Label_DocumentDate %>"></asp:Label>
        </td>
        <td width="44%" class="Nowrap">

            <span runat="server" id="rmd_dtpDocumentDate" style="display: block">
                <telerik:RadDatePicker ID="dtpDocumentDate" runat="server" Culture="English (United States)"
                    EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                    Skin="Default" Width="120px">
                    <DateInput ID="DateInput7" runat="server" LabelCssClass="radLabelCss_Office2007"
                        Skin="Default">
                    </DateInput>
                    <Calendar ID="Calendar7" runat="server" Skin="Default">
                    </Calendar>
                </telerik:RadDatePicker>
            </span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="dtpDocumentDate"
                runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
            </asp:RequiredFieldValidator>
        </td>
    </tr>--%>

    <%--<script type="text/javascript">
        function DropDownOpened(sender, args) {
            var item = args.get_item();
            var element = item.get_element();

            if (element.className.indexOf('rtbSplBtn') >= 0) {
                // split button

                var dropDownList = item.get_dropDownElement();

                document.onmousemove =
                    function(e) {
                        if (!e) e = window.event;
                        if (!e.target) e.target = e.srcElement;

                        if (!$telerik.isDescendantOrSelf(dropDownList, e.target)
                            && !$telerik.isDescendantOrSelf(element, e.target)) {
                            item.hideDropDown();
                        }
                    };
            }
        }

        function DropDownClosed(sender, args) {
            var item = args.get_item();

            if (item.get_element().className.indexOf('rtbSplBtn') >= 0) {
                document.onmousemove = function(e) { };
            }
        }

        function MouseOverFunction(sender, args) {
            var item = args.get_item();
            if (item.get_element().className.indexOf('rtbSplBtn') >= 0) {
                item.showDropDown();
            }
        }
    </script>--%>
</asp:Content>


