<%@ Page Language="vb" meta:resourcekey="EventReminderPage" AutoEventWireup="false" CodeBehind="ReminderDetailsPopup.aspx.vb" Inherits="Website.ReminderDetailsPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reminder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <style type="text/css">
        td.controlWidth {
            padding-right: 24px !important;
        }

        td.labelWidth {
            padding-left: 24px !important;
        }

        table.colTable {
    margin-top: 24px;
}
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function refreshEvents() {
                var btn = window.opener.$("[id$=btnRefreshEvents]")[0];
                if (btn != null) {
                    btn.click();
                }
                window.close();
            }
            function OpenRecord(sender) {
                if ($(sender).attr("LinkSrc") != "") {
                    window.close();
                    window.opener.RedirectParentToPage($(sender).attr("LinkSrc"));
                }
                return false;
            }
            function mainToolbarClick(sender, args) {
                var comandName = args.get_item().get_commandName();
                if (comandName == "Snooze") {
                    return OpenSnoozePopup();
                }
            }
            function OpenSnoozePopup() {
                var hdnEventId = $("[id$=hdnEventId]")[0];
                var Id = hdnEventId.value;
                if (Id > 0) {
                    OpenPOPUp("SnoozePopup.aspx?TotalNumber=1&Source=ReminderDetailPopup&Id=" + Id, 300, 175, false);
                }
                return false;
            }

        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="mainToolbarClick" CssClass="small-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="Dismiss">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Snooze" PostBack="false" EnableImageSprite="true" CssClass="ToolbarClock"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-4">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSubject" runat="server" Text="lblSubject11" meta:resourcekey="lblSubject">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtSubject" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProject" runat="server" Text="Project11" meta:resourcekey="lblProject">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtProject" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trLocation">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLocation" runat="server" Text="Location11" meta:resourcekey="lblLocation">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtLocation" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRecordType" runat="server" Text="Record Type11" meta:resourcekey="lblRecordType">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtRecordType" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblField" runat="server" Text="Field11" meta:resourcekey="lblField"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtField" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRecord" runat="server" Text="Record11" meta:resourcekey="lblRecord">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtRecord" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="trLine" runat="server" visible="false">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLine" runat="server" Text="Line11" meta:resourcekey="lblLine">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtLine" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblReferenceDate" runat="server" Text="Reference Date11" meta:resourcekey="lblReferenceDate">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtReferenceDate" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDaysToDate" runat="server" Text="Days to Date11" meta:resourcekey="lblDaysToDate">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDateToDays" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="trLink" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLink" runat="server" Text="Link11" meta:resourcekey="lblLink">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:HyperLink ID="hliGoToRecord" runat="server" meta:resourcekey="hliGoToRecord" Text="Go To Record1" Style="cursor: pointer;" onclick="OpenRecord(this)"></asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblMessage" runat="server" Text="Message11" meta:resourcekey="lblMessage">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtNotes" Width="99%" runat="server" MaxLength="500" Enabled="false" TextMode="MultiLine" Height="90px">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblReminder" runat="server" Text="Reminder11" meta:resourcekey="lblReminder">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td style="width: 40%">
                                                        <asp:TextBox ID="txtReminder" runat="server" Width="99%" Enabled="false">
                                                        </asp:TextBox>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <asp:Label ID="lblEvent" runat="server" Text="Event11" meta:resourcekey="lblEvent">
                                                        </asp:Label>
                                                    </td>
                                                    <td style="width: 40%">
                                                        <asp:TextBox ID="txtEvent" runat="server" Width="99%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <asp:Button ID="btnSnooze" runat="server" CssClass="Hide"
            Text="" />
        <asp:HiddenField runat="server" ID="hdnEventId" Value="0" />
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behaviors="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
