<%@ Page Language="vb" meta:resourcekey="EventSubscriptionPage" AutoEventWireup="false" CodeBehind="SubscriptionDetailPopup.aspx.vb" Inherits="Website.SubscriptionDetailPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Subscription</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">

        td.controlWidth {
            padding-right: 24px !important;
        }

        td.labelWidth {
            padding-left: 24px !important;
        }
        .documentSinglePage{
           
            margin-bottom:0px !important;
        }
    </style>
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
                    OpenPOPUp("SnoozePopup.aspx?TotalNumber=1&Source=SubscriptionDetailPopup&Id=" + Id, 300, 175, false);
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
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="mainToolbarClick">
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
                   <div class="PMMainPage ">
                    <div class="row JustifyContent">
                        <div class="row documentSinglePage">
                            <div class="col-4">
                                <table class="colTable">
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
                                            <asp:Label ID="lblPath" runat="server" Text="Path" meta:resourcekey="lblPath">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPath" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFolder" runat="server" Text="Field11" meta:resourcekey="lblFolder"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFolder" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDate">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDate" runat="server" Width="99%" Enabled="false">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>
                                            <fieldset>
                                                <legend>
                                                    <asp:Label runat="server" ID="lblFolderActivity" Text="Folder Activity" meta:resourcekey="lblFolderActivity"></asp:Label></legend>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkdocumentRevisionAdded" Text="" runat="server" Enabled="false" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDocumentRevisionAdded" runat="server" Text="" meta:resourcekey="lblDocumentRevisionAdded">
                                                            </asp:Label>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkdocumentCheckedInCheckedOut" Text="" runat="server" Enabled="false" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDocumentCheckedInCheckedOut" runat="server" Text="" meta:resourcekey="lblDocumentCheckedInCheckedOut">
                                                            </asp:Label>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkdocumentMovedDeleted" Text="" runat="server" Enabled="false" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDocumentMovedDeleted" runat="server" Text="" meta:resourcekey="lblDocumentMovedDeleted">
                                                            </asp:Label>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkdocumentDownloaded" Text="" runat="server" Enabled="false" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDocumentDownloaded" runat="server" Text="" meta:resourcekey="lblDocumentDownloaded">
                                                            </asp:Label>
                                                        </td>
                                                        <td>&nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>

                                        </td>
                                    </tr>
                                    <tr id="trLink" runat="server">
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLink" runat="server" Text="Link11" meta:resourcekey="lblLink">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:HyperLink ID="hliGoToRecord" runat="server" Text="Go To Record1" Style="cursor: pointer;" onclick="OpenRecord(this)"></asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblMessage" runat="server" Text="Message11" meta:resourcekey="lblMessage">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtNotes" Width="98%" runat="server" MaxLength="500" Enabled="false" TextMode="MultiLine" Height="90px">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSubscription" runat="server" Text="Subscription" meta:resourcekey="lblSubscription">
                                            </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%"  cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td style="width:47%">
                                                        <asp:TextBox ID="txtSubscription" runat="server" Width="97%" Enabled="false">
                                                        </asp:TextBox>
                                                    </td>
                                                    <td style="text-align: center">
                                                        <asp:Label ID="lblEvent" runat="server" Text="Event11" meta:resourcekey="lblEvent">
                                                        </asp:Label>
                                                    </td>
                                                    <td style="width:47%">
                                                        <asp:TextBox ID="txtEvent" runat="server" Width="97%" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
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
