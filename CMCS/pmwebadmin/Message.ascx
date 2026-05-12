<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Message.ascx.vb" Inherits="Website.Message" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
</telerik:RadAjaxManagerProxy>

<style>
    .Msg {
    z-index: 110;
    filter: alpha(opacity=80);
    opacity: 0.8;
    -moz-opacity: 1;
    border-right: black 1px solid;
    border-top: black 1px solid;
    border-left: black 1px solid;
    position: absolute;
    border-bottom: black 1px solid;
    visibility: hidden;
    width: 250px;
    font-family: 'Work Sans';
    font-size: 11px;
    color: Black;
    padding: 2px;
}
</style>
<div style="position:relative;">
    <div id="divMsg" class="Msg" style=" width:250px;height:30px;">
       <table style="width:230px">
            <tr><td id="MsgText" style="padding-right: 129px"></td></tr>
            <tr><td align="right"><a onclick="HideMsg();"><b>OK</b></a>&nbsp;</td></tr>
        </table>
    </div>
</div>

