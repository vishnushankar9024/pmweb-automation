<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AboutPMWeb.aspx.vb" Inherits="Website.AboutPMWeb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ABOUT PMWEB</title>
    <style type="text/css">
        input[type="button"], input[type="submit"] {
    border: 1px solid #666666;
    text-align: center;
    text-transform: uppercase;
    color: #666666;
    line-height: 1.8;
    border-radius: 2px;
    background-color: #FFFFFF;
    vertical-align: central;
    height: 32px;
    text-decoration: none;
    width: 80px;
    display: table-cell;
    cursor: pointer;
    border-radius: 5px;
}
    </style>
</head>
<body>
            <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
        <link href="CSS/Login.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" type="text/css" />
        <link href="CSS/ControlsCSS/Window.css?rnd=<%= PM.cssRnd  %>" rel="stylesheet" />
    <script src="JS/TelerikUtilities.js"></script>

    <form runat="server">
    <asp:Image ID="imgLogo" runat="server" CssClass="imgIpadLogo" Style="margin-left: 24px;margin-top: 24px;" Width="250px" ImageUrl="Images/Login/PMWeb.gif" onclick="OpenIpadMenu()" onmouseover="this.style.cursor='hand'" />

      <div id="ClientBox"  style="margin-left: 24px;color:#858585;" >
          <div>
                                Client #:
                                <asp:Label runat="server" ID="lblClientNumber" Text="----" />
                            </div>
          <div>
                                Client Name: 
                                <asp:Label runat="server" ID="lblClientName" Text="------------" />
                            </div>
                            <div>
                                PMWeb Version&nbsp
                                <asp:Label runat="server" ID="lblVersionNumber" />
                            </div>
                              <div>
                                Build&nbsp
                                <asp:Label ID="lblBuild" runat="server" />
                            </div>
                            <div>
                                  <asp:Label ID="lblDBVer" runat="server" Text="Database Version" />&nbsp
                                <asp:Label ID="lblDBVersion" runat="server" />
                            </div>
                            
                            
                        

                            <div style="margin-top: 15px;margin-bottom: 15px;""><a style="color:#858585 !important;" href="https://pmweb.com/technical-support/" target="_blank">Technical Support</a></div>
                            <div><a href="http://pmweb.com" target="_blank" style="color:#858585 !important;">PMWeb.com</a></div>
          </div>
    <asp:button runat="server" Text="OK" ID="btnOK" style="position:fixed;bottom:24px;right:24px"/>

        </form>
</body>
</html>
