<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="DeleteInventoryComponentPopUp.aspx.vb" Inherits="Website.DeleteInventoryComponentPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
            return ''
        }

        function ClosePopupAndDelete() {

            if (querySt("hddn") != '') {
                CloseRadWnd();
                $(window.parent.document).find("[id$=" + querySt("hddn") + "]").val($("input[id=chQuantity]")[0].checked);
                return false
            }

            if ($("input[id=chQuantity]")[0].checked) {
                CloseRadWnd();
                $(window.parent.document).find("[id$=btnDeleteAndReturnQuantity]").click();
            }
            else {
                CloseRadWnd();
                $(window.parent.document).find("[id$=btnDeleteComponents]").click();

            }
            return false
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" Height="32px" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton ValidationGroup="Ok" EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="OK"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:Label ID="lblDeleteAllRecords" meta:resourceKey="lblDeleteAllRecords" runat="server" Text="Delete all selected records?11 "></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="margin-top: 6px;">
                                <asp:CheckBox ID="chQuantity" meta:resourceKey="chQuantity" Text="Return Quantity to On Hand Stock?" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
