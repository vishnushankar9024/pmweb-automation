<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Message.ascx.vb" Inherits="Website.Message" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
</telerik:RadAjaxManagerProxy>
<style>
   .MsgText {
    text-align: center;
    text-wrap: nowrap;
    position: relative;
    left: 7px;
    font-size: 14px;
    top: 6px;
    font-family: 'Roboto', sans-serif;
   }

    .MsgText_UsernamePwnd {
    text-align: center;
    text-wrap: nowrap;
    position: relative;
    left: -32px;
    font-size: 14px;
    top: 6px;
    font-family: 'Roboto', sans-serif;
   }
</style>
<div class="divMsgContainer">
    <div id="divMsg" class="Msg" style="display: none;">
        <table style="width:230px">
            <tr><td id="MsgText" class="MsgText"></td></tr>
        </table>
    </div>
</div>

