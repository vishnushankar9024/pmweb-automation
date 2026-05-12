<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="DisconnectPDFFiles.aspx.vb" Inherits="Website.DisconnectPDFFiles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function DisconnectFiles() {
                $(window.parent.document).find("input[id$='btnDisconnectPDFFiles']").click();
                return true;
            }
            function maintoolbarClick(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'DisconnectPDF':
                        return DisconnectFiles();
                        break;

                    default:
                        break;
                }
            }
        </script>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="maintoolbarClick">
                                    <Items>
                                        <telerik:RadToolBarButton ValidationGroup="Ok" EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="DisconnectPDF" Text=" PDFs" meta:resourcekey="btnOk"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" meta:resourcekey="RadToolBarButton_Cancel" Text="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-8">
                    <table class="colTable">
                        <tr>
                            <td style="width: 40px; vertical-align: 0px">
                                <asp:Label ID="lblDisconnectLogo" Width="24px" Height="25px" runat="server" CssClass="DisconnectBluebeamPDFFile"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblDisconnectPDFFiles" meta:resourcekey="lblDisconnectPDFFiles" runat="server" Text="Confirm"></asp:Label>
                            </td>
                        </tr>
                       <%-- <tr>
                            <td></td>
                            <td style="float: right; padding-top: 20px">
                                <asp:Button ID="btnOk" Text="OK1" runat="server" meta:resourcekey="btnOk" OnClientClick="return DisconnectFiles();" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnCancel" Text="Cancel1" runat="server" meta:resourcekey="btnCancel" />
                            </td>
                        </tr>--%>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
