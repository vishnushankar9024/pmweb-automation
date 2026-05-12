<%@ Page Language="VB" meta:resourcekey="Page" Title="Return To" AutoEventWireup="false" CodeBehind="WorkflowReturnToPopup.aspx.vb" Inherits="Website.WorkflowReturnToPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                function OnClientLoad(sender, args) {
                    window.parent.intReturnToStepId = '<%= PM.Workflow.DocumentInfo.ReturnToStepId %>';

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
                        window.parent.intReturnToStepId = '<%= PM.Workflow.DocumentInfo.ReturnToStepId%>';
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
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientLoad="OnClientLoad">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Return"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width:160px !important;">
                                <asp:Label ID="lblReturnTo" runat="server" Text="Return To" meta:resourcekey="lblReturnTo"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:240px !important;">
                                <telerik:RadComboBox ID="ddlReturnTo2" AllowCustomText="false" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnComment" runat="server" />
    </form>
</body>
</html>
