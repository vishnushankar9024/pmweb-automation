<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserProfilePopup.aspx.vb" Inherits="Website.UserProfilePopup" meta:resourcekey="Page" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="UserProfile.ascx" TagName="UserProfile" TagPrefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .ProfileTitle {
            color: #a5a5a5 !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="PMScriptManager" runat="server">
            </asp:ScriptManager>
            <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
                <AjaxSettings>

                </AjaxSettings>
            </telerik:RadAjaxManager>
            <input type="password" style="width:0;height:0;visibility:hidden;position:absolute;left:-1000px;top:0;" />
            <uc1:UserProfile ID="UserProfile" runat="server"></uc1:UserProfile>
        </div>
    </form>
</body>
</html>
