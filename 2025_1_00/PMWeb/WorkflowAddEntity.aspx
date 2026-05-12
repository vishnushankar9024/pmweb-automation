<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowAddEntity.aspx.vb" Inherits="Website.WorkflowAddEntity" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="JS/Workflow/NewEntity.js" type="text/javascript"></script>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
     <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                switch (Value) {
                    case 'Cancel':
                        CancelEdit();
                        break;
                    default:
                        break;
                }
            }
            </script>
        </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarConfigure" CommandName="Configure" Text="Configure" Value="Configure" ValidationGroup="Configure" meta:resourcekey="RadToolBarButton_Configure"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel" Text="Cancel" meta:resourcekey="RadToolBarButton_Cancel"></telerik:RadToolBarButton>
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
                            <td class="labelWidth">
                                <asp:Label ID="lblSelect" runat="server" Text="Select an entity to configure"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlNotConfiguredEntities" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                    Skin="Default" CloseDropDownOnBlur="true" AutoPostBack="False"
                                    CausesValidation="False" Width="100%">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
<%--        <div class="Padding7 BackroungLightGray">
            Select an entity to configure
        </div>--%>
<%--        <div class="Top Padding7">
            &nbsp;&nbsp;<asp:Button ID="btnAdd" runat="server" CssClass="" Text="Configure" />&nbsp;&nbsp;
        <asp:Button ID="btnCancel" runat="server" OnClientClick="Javascript:CancelEdit()" Text="Cancel" />

        </div>--%>
    </form>
</body>
</html>
