<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CompleteDocuSignPopup.aspx.vb" Inherits="Website.CompleteDocuSignPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Complete Docusign</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <table class="colTable" border="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblCompleteDocuSign" runat="server" meta:resourcekey="lblCompleteDocuSignText" style="font-size:11px;"></asp:Label>
                            </td>
                        </tr>
                        </table>
                    <table class="colTable">
                        <tr>
                            <td style="text-align:right;padding-top:10px" class="btn"> 
                                <asp:Button runat="server" ID="btnOK" Text="OK" meta:resourcekey="btnOK" Width="100px" Style="margin-right:24px; text-transform:uppercase;"  />
                                 <asp:Button runat="server" ID="btnCancel" Text="Cancel" meta:resourcekey="btnCancel" Width="100px" style="text-transform:uppercase;" />
                            </td>
                        </tr>                    
                    </table>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
