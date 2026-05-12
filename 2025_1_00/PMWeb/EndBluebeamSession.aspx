<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="EndBluebeamSession.aspx.vb" Inherits="Website.EndBluebeamSession" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <telerik:RadCodeBlock ID="rcb1" runat="server">
            <script type="text/javascript">
                var currentLoadingPanel = null;
                var currentUpdatedControl = null;
                function EndBluebeamSession() {
                    currentLoadingPanel = $find('<%= ldpItems.ClientID%>');
                    currentUpdatedControl = '<%= dvEndSession.ClientID%>';
                    currentLoadingPanel.show(currentUpdatedControl);
                    $(window.parent.document).find("input[id$='btnCloseSession']").click();
                    return true;
                }
                function maintoolbarClick(sender, args) {
                    switch (args.get_item().get_commandName()) {
                        case 'EndBluebeamSession':
                            return EndBluebeamSession();
                            break;

                        default:
                            break;
                    }
                }
            </script>
        </telerik:RadCodeBlock>

        <asp:ScriptManager ID="PMScriptManager" runat="server" AsyncPostBackTimeout="1200"></asp:ScriptManager>

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <ClientEvents OnRequestStart="RequestStart" />
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnOk">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="dvEndSession" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="maintoolbarClick">
                                    <Items>
                                        <telerik:RadToolBarButton ValidationGroup="Ok" EnableImageSprite="true" CssClass="ToolbarEndSession" CommandName="EndBluebeamSession"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader" style="margin-top:60px">
            <div class="row">
                <div class="col-4" runat="server" id="dvEndSession">
                    <table class="colTable">
                        <tr>
                            <td style="width: 40px; vertical-align: 0px">
                                <asp:Label ID="lblEndSessionLogo" Width="24px" Height="25px" runat="server" CssClass="EndBluebeamSession"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblEndBluebeamSession" meta:resourcekey="lblEndBluebeamSession" runat="server" Text="Confirm"></asp:Label>
                            </td>
                        </tr>
                   <%--     <tr>
                            <td></td>
                            <td style="float: right; padding-top: 20px; width:100%">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnOk" Text="OK1" runat="server" Width="120px" meta:resourcekey="btnOk" OnClientClick="return EndBluebeamSession();" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" Text="Cancel1" runat="server" meta:resourcekey="btnCancel" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>--%>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
