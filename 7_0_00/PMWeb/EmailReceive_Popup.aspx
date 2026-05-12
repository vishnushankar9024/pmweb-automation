<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailReceive_Popup.aspx.vb" Inherits="Website.EmailReceive_Popup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>
    </title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <link rel="SHORTCUT ICON" href="Images/Global/favicon.ico" type="image/x-icon" />
    
    <%--<script src="JS/PMJS.js" type="text/javascript"></script>--%>
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
        setTimeout(start, 01);
        setTimeout(showCancel, 1000);
            
        });

        function start() { $("input[id$=btnStartReceiving]").click(); }
        function showCancel() { $("#btnCancel").removeClass("Hide"); }
        function Close() {
            self.close();
            return false;
        }
        function CloseWithRefresh() {
            window.opener.refreshEmails();
            self.close();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="PMScriptManager" runat="server">
    </asp:ScriptManager>
    <telerik:RadProgressManager id="Radprogressmanager1" runat="server"  />
     <telerik:RadProgressArea id="RadProgressArea1"  runat="server" RegisterWithScriptManager="true" 
         >
        </telerik:RadProgressArea>
            <asp:Button ID="btnStartReceiving" runat="server" Text="Submit" CssClass="RadUploadButton Hide" />
            
            <br />
            
     <div style="width:420px;position:relative;text-align:right" >
        <input type="button" runat="server" id="btnCancel" meta:resourcekey="btnCancel" value="Cancel" class="Hide" onclick="Close();"  />
    </div>
    </form>
</body>
</html>
