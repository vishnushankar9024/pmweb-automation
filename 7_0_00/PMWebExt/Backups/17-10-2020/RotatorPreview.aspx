<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RotatorPreview.aspx.vb" Inherits="Website.RotatorPreview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Preview</title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        .body{background:none important!;}
    </style>
</head>

<body>
<script type="text/javascript">

function MoveMarquee(Speed) {
    document.getElementById('ctl00_CPH1_PropertyDetails_RotatorMarquee').scrollAmount = Speed;
}

function StopMarquee() {
    document.getElementById('ctl00_CPH1_PropertyDetails_RotatorMarquee').scrollAmount = 0;
}

function PostBack() {
    __doPostBack('GetImage_Previous', '');
}

</script>
    <form id="form1" runat="server">
    <div class="NormalWhiteBack">
     <table border="0" cellspacing="0" cellpadding="0" class="NormalWhiteBack">
        <tr>
            <td style="width:20px">
                <asp:linkButton ID="lbtLeftButton" runat="server">
                    <div class="RotatorButtonLeft"></div>
                </asp:linkButton>
            </td>
            <td class="AllLightBlueBorder"> <asp:Image ID="imagePreview" runat="server" ImageUrl="Images/Global/WhiteDot.gif" Height="320" Width="370"
                     AlternateText="preview" BorderWidth="0" ></asp:Image></td>
            <td style="width:20px">
                <asp:linkButton ID="lbtRightButton" runat="server">
                    <div class="RotatorButtonRight"></div>
                </asp:linkButton>
                
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
