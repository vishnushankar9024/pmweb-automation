<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ApplicationTables.ascx.vb" Inherits="Website.ApplicationTables" %>
<%@ Register src="ApplicationCustomTables.ascx" tagname="ApplicationCustomTables" tagprefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="RadProx1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rpt">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rpt" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

 <asp:Repeater runat="server" ID="rpt">
<ItemTemplate>
<div id='<%# "C_" & Eval("Id") %>' >
    <uc1:ApplicationCustomTables ID="ApplicationCustomTables1" runat="server" />
</div>
<br />
</ItemTemplate>
</asp:Repeater>
 
          

