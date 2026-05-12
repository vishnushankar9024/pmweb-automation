<%@ Page Language="vb" AutoEventWireup="false" meta:resourceKey="Page" CodeBehind="ContactBrowser.aspx.vb"
    Inherits="Website.ContactBrowser" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            background: white none !important;
            color: #000000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
     <script type="text/javascript" >
         function onClientDoubleClick(sender, args) {

             var treeNode = args.get_node();
             var nodeValue = treeNode.get_value();
             if (nodeValue.indexOf("C")>0) {
                 var updatePanel2 = $find('pnlContactPane')
                 updatePanel2.ajaxRequest(nodeValue);
                 CloseContactRadWnd(nodeValue);
             }
         }
           
   function CloseContactRadWnd(Id) {
             var oWindow = GetRadWnd();
             oWindow.Close();
         }
     
     </script>
    <table style="width: 100%">
        <tr>
            <td valign="top">
                <telerik:radtreeview id="trvContacts" runat="server" enabledraganddrop="True"
                    multipleselect="false" OnClientDoubleClick="onClientDoubleClick" >
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                        </telerik:radtreeview>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxPanel ID="pnlContactPane" runat="server" Width="100%">
    </telerik:RadAjaxPanel> 
    
    </form>
</body>
</html>
