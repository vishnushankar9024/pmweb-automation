<%@ Page Language="vb" Title="Issue" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="IssuesPopup.aspx.vb" Inherits="Website.IssuesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" ValidationGroup="Issues"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>>
        <div class="PMMainPage R1Col">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDate" meta:resourcekey="lblDate" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDatePicker ID="dtpDate" MinDate="01/01/1901" Width="100%"
                                    MaxDate="12/31/2100" runat="server" Skin="Default">
                                    <ClientEvents />
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCode" meta:resourcekey="lblCode" runat="server" Text="Code*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCode" Width="99%" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" meta:resourcekey="rfvCode"
                                    runat="server" ControlToValidate="txtCode" CssClass="Validator"
                                    ErrorMessage="Required." Display="Dynamic" ValidationGroup="Issues">
                                </asp:RequiredFieldValidator>
                                <asp:Label ID="lblCodeUnique" meta:resourcekey="lblCodeUnique" Visible="false" runat="server" CssClass="Validator" Text="Code already used."></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblName" meta:resourcekey="lblName" runat="server" Text="Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtName" Width="99%" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" Width="99%" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
