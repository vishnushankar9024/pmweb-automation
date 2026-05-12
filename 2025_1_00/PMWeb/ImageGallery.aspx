<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ImageGallery.aspx.vb" Inherits="Website.ImageGallery" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register src="PMRotator.ascx" tagname="PMRotator" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>
    Image Gallery
    </title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
           <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
    <div>
    <table>
    <tr>
    <td style="width:100px">&nbsp;</td>
    <td>
    &nbsp;
    </td>
    <td>&nbsp;</td>
    </tr>
    <tr>
    <td>&nbsp;</td>
     <td align="right">
         <uc1:PMRotator ID="PMRotator1" runat="server" />
     </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
     <td>&nbsp;</td>
      <td>&nbsp;</td>
    
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
