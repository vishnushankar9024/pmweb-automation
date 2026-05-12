<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PlanViewEdit.aspx.vb" Inherits="Website.PlanViewEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="FloorPlanView.ascx" TagName="FloorPlanView" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">
    function CloseWindow(SpaceId) {
        opener.location.href = 'Spaces.aspx?Id=' + SpaceId + '&ModuleId=5&PageId=42';
        window.close();
    }
    function Refresh() {
        var btnCreater = $("[id$=btnCreate]");
        btnCreater.click();

    }
</script>

<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <asp:Button ID="btnCreate" CssClass="Hide" Width="100px" Text="" runat="server" />
        <asp:Panel ID="dvEdit" runat="server">

            <table style="width: 100%" cellpadding="0" cellspacing="0">
                <tr class="ToolBar">
                    <td style="width: 80px;">
                        <b>&nbsp;
     <asp:Label ID="lblSetupview" Font-Size="11px" Text="Plan View" runat="server"></asp:Label>
                        </b>
                    </td>
                    <td>
                        <telerik:RadToolBar ID="RadToolBar1" runat="server" Skin="Default" AutoPostBack="true">
                            <Items>
                                <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton ImageUrl="Images/ToolBar/PlanViewIcon.png" CommandName="Planview" AccessKey="s" ToolTip="Plan View"></telerik:RadToolBarButton>

                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:ImageButton ID="MarkupImage" runat="server"></asp:ImageButton>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblSpaces" Text="Available Spaces" runat="server"></asp:Label>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="ddlSpaces" runat="server" OnItemsRequested="ddl_ItemsRequested"
                            Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" meta:resourcekey="ddlSpaces"
                            Width="300px" DropDownWidth="400px" AutoPostBack="False" NoWrap="true" CausesValidation="False"
                            Height="200px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="NoWrap">
                        <asp:Label ID="lblAddeSpace" Text="Designated Spaces" runat="server"></asp:Label>
                    </td>
                    <td class="NoWrap">
                        <telerik:RadComboBox ID="ddlAddedSpaces" runat="server" OnItemsRequested="ddl_ItemsRequested"
                            Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" meta:resourcekey="ddlSpaces"
                            Width="300px" DropDownWidth="400px" AutoPostBack="False" NoWrap="true" CausesValidation="False"
                            Height="200px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True">
                        </telerik:RadComboBox>
                        <asp:Button ID="btnRemove" runat="server" Text="Remove"></asp:Button>
                    </td>
                </tr>
                <tr>
                    <td></td>

                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="dvPlanView" runat="server">
            <table style="width: 100%" cellpadding="0" cellspacing="0">
                <tr class="ToolBar">
                    <td style="width: 80px;">
                        <b>&nbsp;
     <asp:Label ID="lblPlanViewSetup" Font-Size="11px" Text="Plan View" runat="server"></asp:Label>
                        </b>
                    </td>
                    <td>
                        <telerik:RadToolBar ID="mainToolBar1" runat="server" Skin="Default" AutoPostBack="true">
                            <Items>
                                <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Setup.png" PostBack="true" CommandName="PlanViewSetup" Value="Setup" AccessKey="n" ToolTip="Plan View Setup" CausesValidation="false"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <uc1:FloorPlanView ID="FloorPlanView1" runat="server" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
