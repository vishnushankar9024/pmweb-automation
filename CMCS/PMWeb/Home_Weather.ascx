<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_Weather.ascx.vb" Inherits="Website.Home_Weather" %>
<asp:Panel ID="pnlWeather" runat="server" Style="padding-top:5px; font-size:10px">

</asp:Panel>
<asp:Panel ID="pnlError" runat="server">
   <table width="100%" cellpadding="2" border="0" style="padding:5px"> 
    <tr>
        <td><asp:Label ID="lblError" runat="server" meta:resourceKey="lblError" Text="Weather feed is not available<br>Please check your internet connection." CssClass="Validator"></asp:Label></td>
    </tr>
   </table>
</asp:Panel>