<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="BidderSubmitStopPopup.aspx.vb" Inherits="Website.BidderSubmitStopPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Submit Bid</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function CloseStopPopup() {
            $(window.parent.document).find("[id$=hdnrefreshPage]").val(2);
            CloseRadWnd();
            return true;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <table class="colTable" border="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblSubmit" runat="server" meta:resourcekey="lblSubmit"></asp:Label>
                            </td>

                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button runat="server" ID="btnViewSubmit" Text="View Submission Tab" CssClass="LargeButton" meta:resourcekey="btnViewSubmit"  style="position:fixed;width:200px;bottom:24px;right:24px" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
