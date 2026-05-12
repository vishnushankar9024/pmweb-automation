<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="ScoringDateTimeOptionsPopup.aspx.vb" Inherits="Website.ScoringDatetimeOptionPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function SaveDateTimeOptions(Options) {
                $(window.parent.document)[0].getElementById(querySt('hdnOptions')).value = Options;
                $(window.parent.document)[0].getElementById(querySt('txtOptions')).value = ReplaceAllString(Options, '$$', '/');
                return false;
            }

            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }
        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>



        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDisplay" runat="server" Text="Display"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblcontrols" runat="server" Text="Controls"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:CheckBox ID="chbDate" runat="server" />
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblDate" runat="server" Text="Date"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:CheckBox ID="chbTime" runat="server" />
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblTime" runat="server" Text="Time"></asp:Label>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
