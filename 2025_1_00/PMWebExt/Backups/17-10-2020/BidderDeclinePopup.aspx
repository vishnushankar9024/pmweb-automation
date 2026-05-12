<%@ Page meta:resourcekey="BidderDeclinePage" Language="vb" AutoEventWireup="false" CodeBehind="BidderDeclinePopup.aspx.vb" Inherits="Website.BidderDeclinePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Confirm Decline Invitation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function CloseDeclinePopup() {
            $(window.parent.document).find("[id$=hdnrefreshPage]").val(1);
            CloseRadWnd();
            return true;
        }
    </script>
    <style type="text/css">
        .btn a{text-decoration:none !important}
    </style>
</head>
<body>
    <form id="form1" runat="server">
<%--        <table class="ToolBar" style="width: 100%; display: none" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">

                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>--%>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <table class="colTable" border="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblDecline" runat="server" meta:resourcekey="lblDeclinesText" style="font-size:11px;"></asp:Label>
                            </td>
                        </tr>
                        </table>
                    <table class="colTable"> 
                        <tr>
                            <td style="width:50px">
                                <label class="switch">
                                    <input id="chkSelect" runat="server" type="checkbox" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                            <td>
                                <asp:Label ID="lblSelect" runat="server" meta:resourcekey="chkSelect" style="font-size:11px;"></asp:Label>
                                <%-- <asp:CheckBox ID="chkSelect1" Checked="true" AutoPostBack="False" meta:resourcekey="chkSelect" runat="server" Text="Also, please remove my company from the list of future bidders." class="mobile-switch" />--%>
                            </td>
                        </tr>
                        </table>
                    <table class="colTable">
                        <tr>
                            <td style="text-align:right;padding-top:10px" class="btn"> 
                                <asp:Button runat="server" ID="btnOK" Text="OK" meta:resourcekey="btnOK" Width="100px" Style="margin-right:24px"  />
                                 <asp:Button runat="server" ID="btnCancel" Text="Cancel" meta:resourcekey="btnCancel" Width="100px" />
                            </td>
                        </tr>
                        <%--<tr>
<td align="right">
<asp:Button runat="server"  ID="btnok" Text="Ok"
   meta:resourcekey="btnok" />
<asp:Button runat="server"  ID="btCancel" Text="Cancel"
   meta:resourcekey="btCancel" />
</td>

</tr>--%>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
