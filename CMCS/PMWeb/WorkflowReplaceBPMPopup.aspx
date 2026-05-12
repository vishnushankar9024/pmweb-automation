<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="WorkflowReplaceBPMPopup.aspx.vb" Inherits="Website.WorkflowReplaceBPMPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script language="javascript" type="text/javascript">
        function ClosePopup() {
            var btn = window.opener.$("[id$=btnRefreshPage]")[0];
            btn.click();
            window.close();
        }

        //        function ClosePopupAndReloadPage() {
        //            var btn = window.opener.$("[id$=btnReloadPage]")[0];
        //            btn.click();
        //            window.close();
        //        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left ">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    <table class="colTable" style="margin-top:20px;">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblTemplateToDelete" runat="server" Text="Template To Delete"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <asp:TextBox ID="txtTemplateToDelete" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblTemplateToSubstitute" runat="server" Text="Template To Substitute" meta:resourcekey="lblTemplateToSubstitute"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlBPMTemplate" AllowCustomText="false" Filter="Contains" runat="server" Width="100%" Skin="Default"></telerik:RadComboBox>
                                <asp:CompareValidator ID="rfvBPMTemplates" ControlToValidate="ddlBPMTemplate" runat="server" ValueToCompare="0" CssClass="Validator"
                                    ForeColor="" Operator="GreaterThan" meta:resourcekey="rfvBPMTemplates" ValidationGroup="Save" Display="Dynamic">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
