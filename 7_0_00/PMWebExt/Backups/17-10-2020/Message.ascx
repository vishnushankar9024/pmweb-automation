<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Message.ascx.vb" Inherits="Website.Message" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
</telerik:RadAjaxManagerProxy>

<div class="divMsgContainer">
    <div id="divMsg" class="Msg" style=" width:250px">
        <table style="width:230px">
            <tr><td id="MsgText"></td></tr>
            <tr><td align="right"><div style="float:right"><a onclick="HideMsg();"><b>OK</b></a>&nbsp;</div></td></tr>
        </table>
    </div>
</div>

