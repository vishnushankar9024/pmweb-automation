<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="MessageTemplates.aspx.vb" Inherits="Website.MessageTemplates" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ReminderTemplate.ascx" TagName="ReminderTemplate" TagPrefix="uc1" %>
<%@ Register Src="NotificationTemplate.ascx" TagName="NotificationTemplate" TagPrefix="uc2" %>
<%@ Register Src="SubscriptionTemplate.ascx" TagName="SubscriptionTemplate" TagPrefix="uc3" %>
<%@ Register Src="SystemEventTemplate.ascx" TagName="SystemEventTemplate" TagPrefix="uc4" %>
<%@ Register Src="AlertTemplate.ascx" TagName="AlertTemplate" TagPrefix="uc5" %>
<%@ Register Src="DocumentTeamTemplate.ascx" TagName="CollaborateTemplate" TagPrefix="uc6" %>
<%@ Register Src="ActivityBoardsTemplate.ascx" TagName="ActivityBoardsTemplate" TagPrefix="uc7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/MessageTemplate/Reminder.js" type="text/javascript"></script>
    <script src="JS/MessageTemplate/Subscription.js" type="text/javascript"></script>
    <script src="JS/MessageTemplate/SystemEvent.js" type="text/javascript"></script>
    <script src="JS/MessageTemplate/Alert.js" type="text/javascript"></script>
    <script src="JS/MessageTemplate/Notification.js" type="text/javascript"></script>
    <script src="JS/MessageTemplate/DocumentTeam.js" type="text/javascript"></script>
    <script src="JS/MessageTemplate/ActivityBoard.js" type="text/javascript"></script>
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">
            function pageLoad() {
                CheckReminderParentBox();
            }
            function sldSMSLength_Changed(sender, args) {
                var intFrom = 0;
                intFrom = intFrom + sender.get_selectionStart();
                var intTo = TemplatesSMSLength;
                intTo = intTo - sender.get_selectionStart();
                $('#lblFromLength').html('(' + intFrom + ')');
                $('#lblToLength').html('(' + intTo + ')');
            }
        </script>
        <style type="text/css">
            .useDefault label {
                white-space: nowrap;
            }

            .col-4 .RadEditor iframe, .col-4 .RadEditor .reContentCell, .col-4 .RadEditor .reTextArea {
                height: 430px !important;
            }

                .col-4 .RadEditor iframe.reHtmlMode {
                    height: 0 !important;
                }

            .RadEditor {
                box-sizing: border-box;
            }
            .divContentHolder{
                padding-top: 0px;
            }

            @media screen and (min-width:320px) and (max-width:843px) {

                .MobileMarginTopDocumentTasks {
                    padding-top: 97px;
                }
            }


            .rcbSlide .ToolbarDropdownMessageTemplate {
                display: none;
                position: fixed;
                overflow: hidden;
                top: 105px !important;
            }
            .MsgTemplateToolbarHomePage {
                top: 38px !important;
            }
        </style>
    </telerik:RadCodeBlock>


    <%--    <table>
        <tr class="ToolBar">
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>--%>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1"
        runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" CausesValidation="False" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabWithoutToolbar">
        <Tabs>
            <telerik:RadTab Value="Alerts" Text="Alerts" Selected="True" />
            <telerik:RadTab Value="Reminders" Text="Reminders" />
            <telerik:RadTab Value="Notifications" Text="Notifications" />
            <telerik:RadTab Value="Collaborate" Text="Collaborate" />
            <telerik:RadTab Value="Subscriptions" Text="Subscriptions" />
            <telerik:RadTab Value="SystemEvents" Text="System Events" />
            <telerik:RadTab Value="ActivityBoards" Text="Activity Boards" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="1" Width="100%"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvAlerts" runat="server" Selected="True">
            <uc5:AlertTemplate ID="AlertTemplate1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvReminders" runat="server">
            <uc1:ReminderTemplate ID="ReminderTemplate1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotification" runat="server">
            <uc2:NotificationTemplate ID="NotificationTemplate1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvCollaborate" runat="server">
            <uc6:CollaborateTemplate ID="CollaborateTemplate1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSubscriptions" runat="server">
            <uc3:SubscriptionTemplate ID="SubscriptionTemplate1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSystemEvents" runat="server">
            <uc4:SystemEventTemplate ID="SystemEventTemplate1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvActivityBoards" runat="server">
            <uc7:ActivityBoardsTemplate ID="ActivityBoardsTemplate1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
