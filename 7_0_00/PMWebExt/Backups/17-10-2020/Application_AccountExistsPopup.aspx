<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Application_AccountExistsPopup.aspx.vb" Inherits="Website.Application_AccountExistsPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Account Exists</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
     <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    
      
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
    <script src="JS/PMJS.js" type="text/javascript"></script>
    <script src="JS/TelerikUtilities.js" type="text/javascript"></script>
    
    <script language="javascript" type="text/javascript">
        function ReturnExternalUserPage() {
            CloseRadWnd();
        }

        function VisitAccountDetail() {
            window.parent.location.href = "Application_AccountDetails.aspx";
            self.close();
        }

        //function ShowHideCompanyNameBackground(ExistCompanyName) {
        //    if (ExistCompanyName == "1") {
        //        $('#divCompanyName').css({ 'display': 'block' });
        //    }
        //}

    </script>
</head>
<body style="background-color:#FFFFFF;height:auto !important">
    <form id="form1" runat="server" >
          <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
              <style type="text/css">
        .divMsgContainer
        {position:relative;
        }
             
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
        .VendorInput {
                 width: 100%;
                 height: 24px;
                 line-height: 24px;
                 color: #000000;
                 background: #FFFFFF;
                 border: 1px solid #666;
                 border-radius: 0px;
                 box-sizing: border-box;
             }
          .tblMargin{margin:24px;margin-bottom:10px;}
          .popupbuttons{padding-left:110px;}
@media screen and (min-width:320px) and (max-width:860px) {
    .tblMargin {
        margin-left: 8px !important;
    }
    .popupbuttons{padding-left:95px !important;}
}
    </style>
    </telerik:RadCodeBlock>
    <asp:ScriptManager ID="PMScriptManager" runat="server"> </asp:ScriptManager>
    <table cellpadding="0" cellspacing="0" width="95%" style="table-layout:fixed;" class="tblMargin">
        <tr>
            <td style="width:90%;padding-top:15px;" >
                <asp:Label ID="lblAccountExists" meta:resourceKey="lblAccountExists" runat="server" Text="Account Exists" 
                            style="padding-left:10px;font-family:Tahoma; font-size:15px; font-weight:bold; color:#999999;" >
                </asp:Label>
            </td>
        </tr>
        <tr >
            <td style="padding-top:30px;">
                <table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">
                    <tr>
                        <td style="width:50px" ><asp:Image ID="imgCaution" runat="server" ImageUrl="Images/Global/NoticeIcon.png" style="height:20px;Width:20px;padding-left:10px;"/></td>
                        <td>
                            <asp:Label ID="lblCaution" meta:resourceKey="lblCaution" runat="server" 
                                 Text="An account exists for this ID and Country. Please enter the password for this account or click Cancel  to return  to the log-in page." ></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="padding-left:50px;padding-top:30px;padding-bottom:10px;"><asp:Label ID="lblTypePassword" meta:resourceKey="lblTypePassword" runat="server" Text="Type your password." ></asp:Label></td>
        </tr>
        <tr style="line-height:30px;">
            <td style="padding-left:50px;"><asp:TextBox ID="txtPassword" runat="server" Width="240px" CssClass="VendorInput" TextMode="Password" Text="" ></asp:TextBox></td>
        </tr>
        <tr>
            <td><uc2:Message ID="Message1" runat="server" /></td>
        </tr>
    </table>
        <div class="popupbuttons">

              <asp:Button ID="btnContinue" runat="server" Width="110px" CssClass="btn" meta:resourceKey="btnContinue" Text="Continue" style="width:100px;height:25px;font-family:Tahoma;font-size:11px;" />
                            <asp:Button ID="btnCancel" runat="server" Width="110px"  CssClass="btn" meta:resourceKey="btnCancel" Text="Cancel" style="width:100px;height:25px;font-family:Tahoma;font-size:11px;" />
        </div>
    <asp:HiddenField ID="hfdAccountId" runat="server"  />
    </form>
</body>
</html>
