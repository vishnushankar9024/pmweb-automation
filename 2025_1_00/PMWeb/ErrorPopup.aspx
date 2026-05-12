<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ErrorPopup.aspx.vb" Inherits="Website.ErrorPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function pageLoad(){
                var win = GetRadWindow()
                if (win._popupElement.classList.contains('rwNoTitleBar')) {
                    var closebutton = $('.closepopup')[0];
                    closebutton.className = closebutton.className.replace('Hide', '');
                }
                
            }
        </script>
        </telerik:RadCodeBlock>
</head>
<body>

    <form id="form1" runat="server">
        <asp:LinkButton runat="server" CssClass="closepopup Hide" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
         &nbsp;
      </div></asp:LinkButton>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-12">
                    <table class="colTable">
                        <tr style="vertical-align: middle; text-align: center">
                            <td>
                                <asp:Label ID="lblMessage" runat="server" Text="The system could not process your request.<br>Check with your system administrator or verify your security settings." Font-Bold="true"
                                    ForeColor="" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
