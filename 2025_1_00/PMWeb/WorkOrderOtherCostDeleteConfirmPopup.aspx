<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="WorkOrderOtherCostDeleteConfirmPopup.aspx.vb" Inherits="Website.WorkOrderOtherCostDeleteConfirmPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        a {text-decoration:none}
    </style>
</head>
<body>
    <form id="form1"  runat="server">
                <div style="padding-top:24px;padding-left:24px">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDelete" meta:resourceKey="lblDelete" runat="server" Text="Delete all selected records?"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top:10px">
                                <table width="200px">
                                    <tr>
                                        <td align="left" class="style1">
                                            <asp:Button ID="btnSave" meta:resourceKey="btnSave" Text="Ok" runat="server" ValidationGroup="WorkOrder" />
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btnCancel" meta:resourceKey="btnCancel" Text="Cancel" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>   
                        </tr>
                        <tr>
                         <td>
                                <asp:CheckBox ID="chQuantity" meta:resourceKey="chQuantity" Text="Return Quantity to On Hand Stock?" runat="server" class="mobile-switch"  />
                            </td>
                        </tr>
                    </table>
                </div>
    </form>
</body>
</html>
