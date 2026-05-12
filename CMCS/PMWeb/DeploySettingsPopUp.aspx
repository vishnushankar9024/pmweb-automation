<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DeploySettingsPopUp.aspx.vb" Inherits="Website.DeploySettingsPopUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function OnClientClick() {
                $(window.parent.document).find("input[id$='btnDeploySettings']").click();
                return true;
            }
            function maintoolbarClick(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'OK':
                        return OnClientClick();
                        break;

                    default:
                        break;
                }
            }

        </script>
        <table  style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="maintoolbarClick">
                                    <Items>
                                        <telerik:RadToolBarButton ValidationGroup="Ok" EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="OK"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage documentSinglePage">
            <table class="colTable" style="padding-top:24px;padding-left:24px;padding-right:24px;">
                        <tr>
                            <td>
                                <asp:Label ID="lblMsgConfirmDeploySettings" meta:resourcekey="lblMsgConfirmDeploySettings" runat="server" Text="Confirm"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkDoNotDisplayMessage" Checked="false" runat="server" meta:resourcekey="chkDoNotDisplayMessage" Text="Do not diplay this message in the future 1" />
                            </td>
                          <%--  <td>
                                <asp:Button ID="btnOk" Text="OK1" runat="server" meta:resourcekey="btnOk" OnClientClick="return OnClientClick();" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnCancel" Text="Cancel1" runat="server" meta:resourcekey="btnCancel" />
                            </td>--%>
                        </tr>
                    </table>
          
        </div>
    </form>
</body>
</html>
