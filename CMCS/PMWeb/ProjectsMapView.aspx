<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ProjectsMapView.aspx.vb" Inherits="Website.ProjectsMapView" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
<style type="text/css">
        .body{background:none important!;}
    </style>
    <table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0">
     <tr class="ToolBar">
            <td class="Padding7">
                <b>
                    <asp:Label ID="lblMapView" meta:Resourcekey="lblMapView" runat="server" Text="Map View"></asp:Label></b>
            </td>
        </tr>
        <tr>
        <td>
            <iframe src="ProjectsMapViewFrame.aspx" width="100%" height="520px" style="background-image:none important!; border:0px;"></iframe>
        </td>
        </tr>
     </table>
   
</asp:Content>
