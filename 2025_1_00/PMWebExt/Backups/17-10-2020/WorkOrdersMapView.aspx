<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="WorkOrdersMapView.aspx.vb" Inherits="Website.WorkOrdersMapView" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script type="text/javascript">
        function resizeIframe(obj) {
            obj.style.height = 0;
            obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
        }
    </script>
    <style type="text/css">
        iframe {
            height: calc(100vh - 37px) !important;
        }
    </style>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr>
            <td class="ToolbarTd" style="width: 200px;">
                <asp:Label ID="lblMapView" meta:Resourcekey="lblMapView" runat="server" Text="Map View"></asp:Label>
            </td>
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
    <iframe src="WorkOrdersMapViewFrame.aspx" width="100%" onload="resizeIframe(this)" frameborder="0" style="background-image: none !important; border: 0;"></iframe>


</asp:Content>
