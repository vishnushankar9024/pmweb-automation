<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangePasswordPopup.aspx.vb" Inherits="Website.ChangePasswordPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">

        function CloseChangePasswordPopup() {
            var btn = window.opener.$("[id$=btnLoginAfterPassChange]")[0];
            window.close();
            if (btn != null) {
                btn.click();
               
            }
        }
        function ClosePopupAndLogin() {
            var btn = window.opener.$("[id$=btnRemindLogin]")[0];
            window.close();
            if (btn != null) {
                btn.click();

            }
        }
    </script>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
       body {background-color: White !important; background-image: none !important;}
       </style>
     <table>
     <tr>
     <td valign="top" style=" padding-right:20px">
          <asp:LinkButton ID="btnCheck" runat="server" CausesValidation="False"  CssClass="CheckButton" >
                    <span class="Icon"></span>    
                </asp:LinkButton> 
     </td>
     <td valign="top">
     Your Password has expired and you are required to create a <br />
     new one. After you create and save your new password you <br />
     will be able to use it to log into PMWeb.<br /><br />
     Please fill out all of the fields below and then click OK.
     </td>
     </tr>
     </table><br />
   <table>
<tr>
<td>
<asp:Label Text="Old Password*" ID="lblOldPassword" runat="server" meta:resourcekey="lblOldPassword"></asp:Label>
</td>
<td style="width: 219px">
   <asp:TextBox ID="txtOldPassword" MaxLength="128" runat="server" 
        TextMode="Password"  Width="227px"></asp:TextBox> 
          <div>
        <asp:Label Text="Invalid Password." CssClass="Validator" meta:resourcekey="lblInvalidPassword" ID="lblInvalidPassword" Visible="false" runat="server" ></asp:Label>
</div>
</td>
</tr>
<tr>
<td>
<asp:Label Text="New Password*" ID="lblPassword" meta:resourcekey="lblPassword" runat="server" ></asp:Label>
</td>
<td style="width: 219px">
   <asp:TextBox ID="txtPassword" MaxLength="128" runat="server" TextMode="Password" 
        Width="227px"></asp:TextBox>
          <div>
        <asp:Label Text="Enter New Password." CssClass="Validator" ID="lblEnterNewPassword" Visible="false" runat="server" ></asp:Label>
</div>
</td>
</tr>
<tr>
<td>
<asp:Label Text="Confirm New Password*" ID="lblConfirmPassword" meta:resourcekey="lblConfirmPassword" runat="server" ></asp:Label>
</td>
<td style="width: 219px">
   <asp:TextBox ID="txtConfirmPassword" MaxLength="128" runat="server" TextMode="Password" Width="227px"></asp:TextBox>
         <div>
     <asp:CompareValidator runat="server" Display="Dynamic" ValidationGroup="Save" CssClass="Validator" ID="cmp1" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" ErrorMessage="New Password Not Confirmed."></asp:CompareValidator>

</div>
</td>
</tr>

<tr runat="server" id="trPasswordRules">
<td colspan="2">
<br /><br />
<div style="border:1px solid black; background-color:RGB(255,255,217);">
   Password Rules:<br /><br />
<table>
<tr>

<td>
<asp:Label runat="server" ID="lblminNumberOfCharacters"></asp:Label>
</td>
</tr>
<tr>
<td>
<asp:Label runat="server" ID="lblNumeral"></asp:Label>
</td>
</tr>
<tr>
<td>
<asp:Label runat="server" ID="lblUppercase"></asp:Label>
</td>
</tr>
<tr>
<td>
<asp:Label runat="server" ID="lblnonAplphanum"></asp:Label>
</td>
</tr>
</table></div>
</td>
</tr>
<tr>
<td colspan="2" align="right">
<br />
<asp:Button runat="server" CssClass="smallbutton" ID="btnSave" ValidationGroup="Save" Text="OK" />
</td>
</tr>
</table>  

<asp:Label   CssClass="Validator" ID="lblComplexityError" Visible="false" runat="server" ></asp:Label>

    </form>
</body>
</html>
