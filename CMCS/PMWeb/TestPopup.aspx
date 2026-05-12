<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TestPopup.aspx.vb" Inherits="Website.TestPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register src="ApplicationTables.ascx" tagname="ApplicationTables" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
      <link href="JS/Estimates/jquery.countdown.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">

 <script src="JS/Estimates/jquery.countdown.js" type="text/javascript"></script>
 

    <script type="text/javascript">
        $(function () {

            var austDay = new Date();
            austDay = new Date(austDay.getFullYear() + 1, 1 - 1, 26);
            $('#defaultCountdown').countdown({ until: austDay });

        });
    
    </script>

 
    <div id="defaultCountdown"></div>
    </form>
</body>
</html>

