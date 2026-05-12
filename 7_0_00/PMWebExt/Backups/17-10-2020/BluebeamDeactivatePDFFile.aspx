<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="BluebeamDeactivatePDFFile.aspx.vb" Inherits="Website.BluebeamDeactivatePDFFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr id="trTbsDetails" runat="server">
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <div class="PMHeader">
                                    <div class="row">
                                        <div class="col-4">
                                            <table class="colTable" border="0">
                                                <tr>
                                                    <td colspan="2">
                                                        <table>
                                                            <tr>
                                                                <td style="vertical-align: 0px">
                                                                    <asp:Label ID="lblLogo" Width="24px" Height="25px" runat="server" CssClass="DeactivatePDFFile"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblDeactivatePDF" meta:resourcekey="lblDeactivatePDF" runat="server" Text="Deactivate"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="float: right; padding-top: 20px">
                                                        <asp:Button ID="btnOk" Text="OK1" runat="server" meta:resourcekey="btnOk" />
                                                        &nbsp;&nbsp;
                                                        <asp:Button ID="btnCancel" Text="Cancel1" runat="server" meta:resourcekey="btnCancel" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
