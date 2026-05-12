<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InventoryLinkedAssets.aspx.vb" Inherits="Website.InventoryLinkedAssets" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Link</title>
    <style type="text/css">
        body {
            background: white none !important;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <script type="text/javascript">
            function onClientDoubleClick(sender, args) {

                var treeNode = args.get_node();
                var nodeText = treeNode.get_value();

                var updatePanel2 = $find('pnlAssetPane')
                updatePanel2.ajaxRequest(nodeText);
                CloseContactRadWnd(nodeText);

            }

            function CloseContactRadWnd(Id) {
                var oWindow = GetRadWnd();
                oWindow.Close();
            }

        </script>

        <table style="width: 100%" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top">
                    <telerik:RadTreeView ID="trvAssets" runat="server" EnableDragAndDrop="True"
                        Skin="Default" MultipleSelect="false" OnClientDoubleClick="onClientDoubleClick">
                        <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                        <ExpandAnimation Duration="100"></ExpandAnimation>
                        <NodeTemplate>
                            <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                        </NodeTemplate>
                    </telerik:RadTreeView>
                </td>
            </tr>
        </table>
        <telerik:RadAjaxPanel ID="pnlAssetPane" runat="server" Width="100%">
        </telerik:RadAjaxPanel>




    </form>
</body>
</html>
