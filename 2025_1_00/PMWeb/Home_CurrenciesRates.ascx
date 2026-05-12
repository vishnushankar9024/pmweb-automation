<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Home_CurrenciesRates.ascx.vb" Inherits="Website.Home_CurrenciesRates" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ltbConvert">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="txtAmountTo" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<asp:Panel ID="pnlCurrencyConverter" runat="server">
<table width="100%" cellpadding="2" border="0" style="padding:5px"> 
    <tr>
        <td width="10%" style="padding:5px"><asp:Label meta:resourceKey="lblConvertFrom"  ID="lblConvertFrom" runat="server" Text="Convert" ></asp:Label></td>
        <td width="45%" style="padding:5px"><asp:TextBox ID="txtAmountFrom" runat="server" CssClass="Double" Text="1.00" Width="99%"></asp:TextBox></td>
        <td width="45%" style="padding:5px"><telerik:RadComboBox runat="server" id="BaseCurrencyList" Height="300px"
               Skin="Default" />
        </td>
    </tr>
    <tr>
        <td style="padding:5px"><asp:Label ID="lblConvertTo" meta:resourceKey="lblConvertTo" runat="server" Text="To"></asp:Label></td>
        <td style="padding:5px"><telerik:RadComboBox runat="server" id="ForeignCurrencyList" Height="300px"
            Skin="Default" /></td>
        <td style="padding:5px"><asp:TextBox ID="txtAmountTo" runat="server" Width="99%" CssClass="Double" ReadOnly="true"></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan="3" align="right">
            <asp:button id="btnConvert" runat="Server" meta:resourceKey="ltbConvert"  text="Convert" />
        </td>
    </tr>
</table>
</asp:Panel>
<asp:Panel ID="pnlError" runat="server">
   <table width="100%" cellpadding="2" border="0" style="padding:5px"> 
    <tr>
        <td><asp:Label ID="lblError" runat="server"  meta:resourceKey="lblError" Text="Currencies feed is not available<br>Please check your internet connection." CssClass="Validator"></asp:Label></td>
    </tr>
   </table>
</asp:Panel>

 
 