<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfirmInspectionPointPopup.aspx.vb" Inherits="Website.ConfirmInspectionPointPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>

    </style>

       <script type="text/javascript">
        function cancelClicked() {
            $(window.parent.document).find("[id$=hdnDrawPoint]").val('');
            CloseRadWnd();
            return true;
        }
    </script>
</head>
    
<body>
    <form id="form1" runat="server">
   <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
    <asp:Label runat="server" ID="lblMessage" Style="font-size: 14px; color: #666;opacity:0.7" ></asp:Label>
       </div>
 <div id="divResults" style="text-align: center">
                 <table>
                     <tr>
                         <td>
    <asp:Button runat="server"  CssClass="ButtonOK" ID="btnOk"  Style="position: fixed; width: 100px; bottom: 24px; right: 165px"  meta:Resourcekey="btnOk" Text="Ok"/>
    <asp:Button runat="server" ID="btnCancel" CssClass="ButtonCancel" meta:Resourcekey="btnCanvel" style="position:fixed;width:100px;bottom:24px;right:24px" Text="Cancel" OnClientClick="cancelClicked()" />
      </td>
                     </tr>
                 </table>
                    </div>
                </div>
       </div>
    </form>
</body>
</html>
