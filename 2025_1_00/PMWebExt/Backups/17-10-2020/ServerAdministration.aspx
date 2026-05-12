<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="ServerAdministration.aspx.vb" Inherits="Website.ServerAdministration" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserManagement.ascx" TagName="UserManagement" TagPrefix="uc1" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
    <table>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        <tr id="trServerAdministration">
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsServerAdministration"
                    SelectedIndex="0" runat="server" MultiPageID="mlpServerAdministration" Skin="Default"
                    OnTabClick="tbsServerAdministration_TabClick" Width="100%" EnableViewState="False">
                    <Tabs>
                        <telerik:RadTab Text="User Management" Value="UserManagement" Selected="True" />
                   
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadMultiPage ID="mlpServerAdministration" runat="server" SelectedIndex="0"
                    Width="100%" RenderSelectedPageOnly="true">
                    <telerik:RadPageView ID="pvUserManagement" runat="server">
                        <uc1:UserManagement ID="UserManagement" runat="server" />
                    </telerik:RadPageView>
                
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxLoadingPanel ID="ldpServerAdministration" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default"/>
</asp:Content>
