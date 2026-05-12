<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ForgotPasswordPopup.aspx.vb" Inherits="Website.ForgotPasswordPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE  html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FORGOT PASSWORD</title>
    <link href="CSS/ControlsCSS/Combobox.css" rel="stylesheet" />
    <link href="CSS/MainCss.css?id=123" rel="stylesheet" type="text/css" />
    <link href="CSS/ControlsCSS/Button.css" rel="stylesheet" />
    <script type="text/javascript">
        function ClosePopup(){
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            oWindow.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <div>
            <table width="96%" style="margin:10px 10px 10px 10px;">
                <tr>
                    <td style="width:50%">
                        <asp:Label ID="lblUserName" runat="server" Text="User"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                        <telerik:RadComboBox ID="CboUsers" runat="server" Filter="Contains" MarkFirstMatch="true" Width="100%" AllowCustomText="true"></telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />                       
                        If you continue, the current password for the user above will be deleted and a new one will be emailed to the address linked to the account. This process cannot be undone.
                        <br />
                        <br />
                        Do you wish to continue?
                        <br />
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right"  colspan="2">
                        <asp:Button ID="btnOk" runat="server" Text="OK" Width="70px" /> &nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="CANCEL" Width="70px" OnClientClick="return ClosePopup();"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" >
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
