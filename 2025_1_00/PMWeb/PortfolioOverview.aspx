<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PortfolioOverview.aspx.vb" Inherits="Website.PortfolioOverview" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PortfolioOverviewDetails.ascx" TagName="PortfolioOverviewDetails" TagPrefix="uc1" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style type="text/css">
    .PortfolioOverviewIframe {
    height: calc(100vh - 91px) !important;
}
    /*.PortfolioView{padding-top:30px;}*/
    @media screen and (min-width:320px) and (max-width:843px) {
    .PortfolioOverviewIframe{margin-top: 0px !important;}
    /*.PortfolioView {
    padding-top: 24px !important;
}*/
    }
</style>

    <uc1:PortfolioOverviewDetails ID="PortfolioOverviewDetails" runat="server" />

</asp:Content>
