<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowEmailActions.aspx.vb" Inherits="Website.WorkflowEmailActions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body{
             font-size:12px !important;
             font-family: Tahoma !important;
	        color: #272727 !important;
        }
        a{
             font-size:12px !important;
             font-family: Tahoma !important;
             color:#4FA3D5 !important;
        }
        .Validator
        {
	        color: #C60000 !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table width="100%" >
        <tr>
            <td>
             <asp:Image ID="imgLogo" runat="server" ImageUrl="Images/Login/PMWeb.gif" height="86px" width="260px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlSuccess" runat="server" style="margin-left:20px">
                     <table width="100%">
                        <tr>
                            <td><asp:Label ID="lblConfirmaion" runat="server" meta:ResourceKey="lblConfirmaion" Font-Bold="true" style="font-size:15px; font-family:Arial" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td><br />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblAction" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblRecord" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblEntity" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                        <td><br />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblOpenRecord" runat="server" meta:ResourceKey="lblOpenRecord"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:HyperLink ID="hplLink" runat="server"></asp:HyperLink>
                            </td>
                        </tr>
                      </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlError" runat="server" width="100%">
                     <table width="100%">
                        <tr>
                            <td><asp:Label ID="lblErrorMessage" runat="server" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                      </table>
                </asp:Panel>
              </td>
        </tr>
    </table>

    </form>
</body>
</html>
