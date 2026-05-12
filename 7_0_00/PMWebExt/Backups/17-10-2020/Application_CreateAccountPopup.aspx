<%@ Page meta:resourceKey="Page" Language="vb" AutoEventWireup="false" CodeBehind="Application_CreateAccountPopup.aspx.vb" Inherits="Website.Application_CreateAccountPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Account Created</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function VisitAccountDetail() {
            window.parent.location.href = "Application_AccountDetails.aspx";
            self.close();
        }

        function BeginNewApplication() {
            window.parent.location.href = "Application_Applications.aspx?Id=0";
            self.close();
        }

        //function ShowHideCompanyNameBackground(ExistCompanyName) {
        //    if (ExistCompanyName == "1") {
        //        $('#divCompanyName').css({ 'display': 'block' });
        //    }   
        //}
    </script>

    <style type="text/css" >
        
    .btn{border: 1px solid #666666;
    text-align: center;
    text-transform: uppercase;
    color: #666666;
    line-height: 1.8;
    border-radius: 2px;
    background-color: #FFFFFF;
    vertical-align: central;
    height: 32px;
    text-decoration: none;
    width: 100%;
    display: table-cell;
    cursor: pointer;
    border-radius: 5px;padding: 1px 1px 1px 1px !important;
    margin-right: 0px;}
    .tblMargin{margin:24px;}
@media screen and (min-width:320px) and (max-width:860px) {
    .tblMargin {
        margin-left: 8px !important;
    }
}
    </style>
</head>
<body style="background-color:#FFFFFF;height:auto !important">   
     <form id="form1" runat="server">
           <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
    </telerik:RadCodeBlock>
    <asp:ScriptManager ID="PMScriptManager" runat="server"> </asp:ScriptManager>
    <table cellpadding="0" cellspacing="0" width="95%" style="table-layout:fixed;" class="tblMargin">
         <tr>
            <td>
                <asp:Label ID="lblAccountCreated" meta:resourceKey="lblAccountCreated" runat="server" Text="Account Created" 
                            style="font-family:Tahoma; font-size:15px; font-weight:bold; color:#999999;" >
                </asp:Label>
            </td>
        </tr>
            <tr style="height:50px;">
                <td>
                 <table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">
                     <tr>
                          <td style="width:50px;"><asp:Image ID="imgCaution" runat="server" ImageUrl="Images/Global/NoticeIcon.png" height="20px" Width="22px"/></td>
            <td><asp:Label ID="lblCaution" meta:resourceKey="lblCaution" runat="server" Text="Your PMWeb account has been created. You will need to provide the username and the password you entered each time you log into PMWeb." ></asp:Label></td>
                     </tr>
                </table>
                </td>
              
           
        </tr>
          <tr>
<td>
                 <table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">
                     <tr>
                          <td style="width:50px;">&nbsp;</td>
          <td><asp:Label ID="lblNote" meta:resourceKey="lblNote" runat="server" Text="Click a button below to begin applying for vendor status or to visit your account details page. Note: you can always start your application from the Account Details page." ></asp:Label></td>
                     </tr>
                </table>
                </td>
            
        </tr>
        <tr style="height:30px;"><td><br /></td></tr>
        <tr style="padding-top:10px;" >
            <td align="right"><asp:Button ID="btnVisitMyAccount" CssClass="btn" runat="server" Width="195px" meta:resourceKey="btnVisitMyAccount" Text="Visit My Account Details"  />
                <asp:Button ID="btnBeginMyApp" CssClass="btn" runat="server"  Width="195px" meta:resourceKey="btnBeginMyApp" Text="Begin My Application" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
