<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowDocuSignPopup.aspx.vb" Inherits="Website.WorkflowDocuSignPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function closeWnd() {
                window.close();
                //$(window.opener.document).find("input[id$=btnReloadWorkflowDoc]").click();
                return false;
            }
            function ReloadParentPage() {
                if (window.opener.location.toString().indexOf("Home") > 0) {
                    $(window.opener.document).find("[id$=lbtRefresh2]")[0].click();
                } else {
                    $(window.opener.document).find("[id$=btnReloadWorkflowDoc]")[0].click();
                }
                return false;
            }

        </script>
        <div class="PMHeader">
            <div class="row">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td>
                                <div style="text-align: center">
                                    <asp:Label runat="server" ID="lblMessage" Text="DocuSign Document is Sent.1" meta:resourcekey="lblMessage" Style="text-transform: uppercase; color: #666666;margin-left:3px;"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:LinkButton runat="server" ID="btnClose" CssClass="lnkButtonAnchor">
                                        <div style="width: 168px; margin: auto" class="lnkButton" runat="server">
                                            <asp:Label runat="server" ID="lblClose" Text="Close1" meta:resourcekey="lblClose"></asp:Label>
                                        </div>
                                    </asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
