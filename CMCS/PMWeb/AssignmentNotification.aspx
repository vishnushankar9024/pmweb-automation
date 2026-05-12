<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AssignmentNotification.aspx.vb" Inherits="Website.AssignmentNotification" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><asp:Label ID="lblTitle" Text="Assignment Notification" meta:resourcekey="lblTitle" runat="server"></asp:Label></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpNotification" runat="server" Skin="Default" />
            
        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet" LoadingPanelID="ldpNotification">
            <table style="width: 400px; margin: 15px 0px 15px 10px;" cellpadding="0" cellspacing="0"
                border="0">
                <tr>
                    <td>
                        <asp:Label ID="lblFrom" meta:resourcekey="lblFrom" runat="server" Text="From"></asp:Label>
                    </td>
                    <td style="padding-left:10px;">
                        <asp:TextBox ID="txtFrom" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTo" meta:resourcekey="lblTo" runat="server" Text="To"></asp:Label>
                    </td>
                    <td style="padding-left:10px;">
                        <asp:TextBox ID="txtTo" runat="server" TextMode="MultiLine" Width="200px" Height="51px" Rows="3"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSubject" meta:resourcekey="lblSubject" runat="server" Text="Subject"></asp:Label>
                    </td>
                    <td style="padding-left:10px;">
                        <asp:TextBox ID="txtSubject" runat="server" ReadOnly="true" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblBody" meta:resourcekey="lblBody" runat="server" Text="Body"></asp:Label>
                    </td>
                    <td style="padding-left:10px;">
                        <asp:TextBox ID="txtBody" runat="server" ReadOnly="true" Height="85px" TextMode="MultiLine" Width="300px" Rows="5"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblComments" meta:resourcekey="lblComments" runat="server" Text="Comments"></asp:Label>
                    </td>
                    <td style="padding-left:10px;">
                        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="300px" Rows="3" Height="51px" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <asp:Button ID="btnClose" runat="server" Text="<%$ Resources:PMWeb, Close %>" />&nbsp;&nbsp;
                        <asp:Button ID="btnSend" meta:resourcekey="btnSend" runat="server" Text="Send Invitations" />&nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                            Visible="False" Class="Success"></asp:Label>
                        <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                            Visible="False" Class="Failure"></asp:Label>
                    </td>
                </tr>
            </table>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
