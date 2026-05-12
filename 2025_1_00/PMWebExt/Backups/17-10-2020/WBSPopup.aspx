<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WBSPopup.aspx.vb" Inherits="Website.WBSPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>WBS</title>
    <script type="text/javascript">
        function onClientDoubleClick(sender, args) {

            var treeNode = args.get_node();
            var WBS = treeNode.get_text();
            var WBSId = treeNode.get_value();
            var ddlWBS = window.parent.$find(querySt('ddlWBS'));
            if (WBSId == 0) {

                return false;
            }
            if (ddlWBS != null) {
                ddlWBS.trackChanges();
                ddlWBS.set_text(WBS);
                ddlWBS.set_value(WBSId);
                ddlWBS.commitChanges();
                window.parent.setdirty();
            }

            window.close();

        }



        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }

    </script>

</head>

<body>

    <form id="form1" runat="server">
       
            <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
         <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <table style="width: 100%">

                        <tr>
                            <td valign="top">
                                <telerik:RadTreeView ID="rdvLocation" runat="server" EnableDragAndDrop="True" OnClientNodeClicked="onClientDoubleClick"
                                    Skin="Default" MultipleSelect="false"  >
                                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                </telerik:RadTreeView>
                            </td>
                        </tr>
                    </table>
                </div>
        </div>
             </div>
    </form>
</body>
</html>
