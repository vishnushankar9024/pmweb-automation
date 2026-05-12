<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ApplicationLinks.ascx.vb" Inherits="Website.ApplicationLinks" %>
<%@ Register Src="~/ApplicationCustomLinks.ascx" TagName="ApplicationCustomLinks" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RadProx1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rptCustomLinks">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rptCustomLinks" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<asp:Repeater runat="server" ID="rptCustomLinks">
<ItemTemplate>
    <div id="<%# "L_" & Eval("Id").ToString() %>" >
        <uc1:ApplicationCustomLinks ID="ApplicationCustomLinks1" runat="server" />
    </div>
</ItemTemplate>
</asp:Repeater>