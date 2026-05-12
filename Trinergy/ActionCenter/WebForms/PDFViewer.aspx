<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDFViewer.aspx.cs" Inherits="PMWebHelper.WebForms.PDFViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PDF Viewer</title>
    <script src="../Content/admin-pro/js/vendor/jquery-1.11.3.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Literal ID="ltEmbed" runat="server"></asp:Literal>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            var height = ($(document).height() - 20);
            $("object").css({ "height": height + 'px' });
        });
        $(window).resize(function () {
            var height = ($(document).height() - 20);
            $("object").css({ "height": height + 'px' });
        });
    </script>
</body>
</html>
