<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfirmPage.aspx.vb" Inherits="Website.ConfirmPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
<script src="JS/Utilities/queryString.js" type="text/javascript"></script>
    <title>PMWeb</title>
    
    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            var answer = self.confirm("You are currently logged into a PMWeb database that does not match this hyperlink. If you click continue you will automatically be logged you out of that database.\n You will then be prompted to log in to the database that matches the hyperlink.\n Do you wish to continue?");
            if (answer) {
                var vgoto = $.query.get('goto');
                $("input[id$=hdnUrl]").val(vgoto);
                __doPostBack('GoToPage', '')
            } else {
            window.close();
            document.location = "about:blank"
            }
        });
       
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <input type="hidden" id="hdnUrl" runat="server" />
    
        <asp:LinkButton ID="GoToPage" Text="" runat="server"></asp:LinkButton>
    
    </div>
    </form>
</body>
</html>
