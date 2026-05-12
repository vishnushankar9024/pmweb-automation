<%@ Page Language="vb" meta:resourcekey="Page" Title="Return To" AutoEventWireup="false" CodeBehind="WorkflowActionsReturnToPopup.aspx.vb" Inherits="Website.WorkflowActionsReturnToPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
    
    <telerik:RadCodeBlock ID="CodeBlock" runat="server" >
    <script type ="text/javascript" >
        function OnClientLoad(sender, args) {
            window.parent.intReturnToStepId = '<%= tmpPM.Workflow.DocumentInfo.ReturnToStepId%>';

            if (querySt('DocumentId') > 0) {
                var txtComment = window.parent.document.getElementById(querySt('txtComment'));
                var hdnComment = $("[id$=hdnComment]")[0];
                if (txtComment.value == txtComment.defaultValue) {
                    hdnComment.value = "";
                }
                else {
                    hdnComment.value = txtComment.value;
                }
            }
        }

        function CloseReturnPopup() {
            if (!(querySt('DocumentId') > 0)) {
                window.parent.intReturnToStepId = '<%= tmpPM.Workflow.DocumentInfo.ReturnToStepId%>';
            }
            CloseRadWnd();
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
    </telerik:RadCodeBlock>
    <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td>
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" OnClientLoad="OnClientLoad" CssClass="small-toolbar">
                        <items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Text ="Save" meta:resourcekey="RadToolBarButton_Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Return" Text ="Return" meta:resourcekey="RadToolBarButton_Return"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" Text ="Cancel" meta:resourcekey="RadToolBarButton_Cancel"></telerik:RadToolBarButton>
                        </items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <table style="margin-top:5px" border="0">
            <tr>
                <td style="width:80px">
                    <asp:Label ID="lblReturnTo" runat="server" Text="Return To" meta:resourcekey="lblReturnTo"></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlReturnTo2" AllowCustomText="false" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="200px"></telerik:RadComboBox>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnComment" runat="server" />
    </form>
</body>
</html>
