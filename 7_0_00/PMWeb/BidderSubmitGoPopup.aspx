<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="BidderSubmitGoPopup.aspx.vb" Inherits="Website.BidderSubmitGoPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
     <style type="text/css">
        a{text-decoration:none !important}
    </style>
</head>

<body>
    <form id="form1" runat="server">
     <div class="PMMainPage R1Col">
         <div class="row">
             <div class="col-12">
                 <table class="colTable" border="0">
                     <tr>
                         <td>
                             <asp:Label ID="lblSubmitGo" runat="server" meta:resourcekey="lblSubmitGo"></asp:Label>
                         </td>
                     </tr>
                     <tr>
                         <td align="right">
                             <asp:Button runat="server" ID="btnOk" Text="Ok" meta:resourcekey="btnOk" Width="100px" />
                         </td>
                     </tr>
                 </table>
             </div>
         </div>
    </div>
    </form>
</body>
</html>
