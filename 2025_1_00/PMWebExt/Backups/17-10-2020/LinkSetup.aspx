<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="LinkSetup.aspx.vb" Inherits="Website.LinkSetup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="LinkSetupPrimavera.ascx" TagName="LinkSetupPrimavera" TagPrefix="uc1" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Scheduling/LinkSetupPrimavera.js" type="text/javascript"></script>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0"
        runat="server" MultiPageID="mlplinkedSetup" Skin="Default"
        Width="100%" EnableViewState="False">
        <Tabs>
            <telerik:RadTab Text="Primavera" Value="Primavera" Selected="True" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlplinkedSetup" runat="server" SelectedIndex="0"
        Width="100%" RenderSelectedPageOnly="true" BorderColor="LightBlue">
        <telerik:RadPageView ID="pvPrimavera" runat="server">

            <uc1:LinkSetupPrimavera ID="LinkSetupPrimavera1" runat="server" />

        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
