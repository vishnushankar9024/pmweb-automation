<%@ Page Language="vb" meta:resourcekey="Page" Title="Define Role" AutoEventWireup="false" CodeBehind="WorkflowDefineRolePopup.aspx.vb" Inherits="Website.WorkflowDefineRolePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">

           
        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="MainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save" Text="Save" meta:resourcekey="RadToolBarButton_Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save" Text="Save & Exit" meta:resourcekey="RadToolBarButton_SaveAndExit"></telerik:RadToolBarButton>
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
                                <asp:Label ID="lblRole" runat="server" Text="Role" meta:resourcekey="lblRole"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtRole" runat="server" Width="99%"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfvRole" CssClass="Validator"
                                    ValidationGroup="Save" ControlToValidate="txtRole" Display="Dynamic"
                                    meta:resourcekey="rfvRole">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUser" runat="server" Text="User" meta:resourcekey="lblUser"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlUsers" runat="server" Width="99%" Height="150px"
                                    Skin="Default" meta:resourcekey="ddlUsers" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                </telerik:RadComboBox>
                                <asp:CompareValidator ID="cmvUsers" Display="Dynamic" ControlToValidate="ddlUsers" runat="server" ValueToCompare="0"
                                    CssClass="Validator" ForeColor="" Operator="GreaterThan" meta:resourcekey="cmvUsers" ValidationGroup="Save">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
