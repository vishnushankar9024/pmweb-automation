<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="OrgChartGroupsPopup.aspx.vb" Inherits="Website.OrgChartGroupsPopup" %>

<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<style>
   
</style>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save" Value="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Delete" EnableImageSprite="true" Visible="False" CssClass="ToolbarDelete"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4" style="width: 400px !important;">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important; height: 29px !important;">
                                <asp:Label ID="lblTitle" runat="server" Text="Title1" meta:resourcekey="lblTitle"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important; height: 29px !important;">
                                <asp:TextBox ID="txtTitle" runat="server" Height="24px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Required" ValidationGroup="Save"
                                    Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblSubtitle" Text="Subtitle1" meta:resourcekey="lblSubtitle"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtSubtitle" Height="24px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblGroupCategory" runat="server" Text="GroupCategory1" meta:resourcekey="lblGroupCategory"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox runat="server" ID="ddlCategory" meta:resourcekey="ddlCategory" AllowCustomText="True" Width="100%"></telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
