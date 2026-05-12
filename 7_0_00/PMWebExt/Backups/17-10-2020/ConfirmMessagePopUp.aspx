<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfirmMessagePopUp.aspx.vb" Inherits="Website.ConfirmMessagePopUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Generate Complete</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save"
                                           >
                                        </telerik:RadToolBarButton>

                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr id="trTbsDetails" runat="server">
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <div class="PMHeader">
                                    <div class="row documentSinglePage">
                                        <div class="col-4">
                                            <table class="colTable" border="0">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label runat="server" ID="lblConfirmationMessage" Text='<%#CStr(HttpContext.GetGlobalResourceObject("PMWeb", "GenerateMsg_GenerateCompleted"))%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
