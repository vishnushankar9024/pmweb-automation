<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BluebeamSessionSyncPopup.aspx.vb" Inherits="Website.BluebeamSessionSyncPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">

        <telerik:RadCodeBlock ID="rcb1" runat="server">
            <script type="text/javascript">

                function SynMarkupsSession() {
                    $(window.parent.document).find("input[id$='btnSyncMarkups']").click();
                    return true;
                }
            </script>
        </telerik:RadCodeBlock>

        <div runat="server" id="dvSynMarkups" style="padding: 5px">
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td valign="top">
                        <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="ToolbarTd">

                                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                                        Width="220px" CssClass="popup-toolbar">
                                        <Items>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"
                                                >
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
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
                                                        <td style="width: 40px; vertical-align: 0px">
                                                            <asp:Label ID="lblBluebeamLogo" Width="24px" Height="25px" runat="server" CssClass="BluebeamButton"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSynMarkups" meta:resourcekey="lblSynMarkups" runat="server" Text="Confirm11"></asp:Label>
                                                        </td>
                                                    </tr>
                                        <%--            <tr>
                                                        <td></td>
                                                        <td style="float: right; padding-top: 20px">
                                                            <asp:Button ID="btnOk" Text="OK1" runat="server" meta:resourcekey="btnOk" OnClientClick="return SynMarkupsSession();" />
                                                            &nbsp;&nbsp;
                    <asp:Button ID="btnCancel" Text="Cancel1" runat="server" meta:resourcekey="btnCancel" />
                                                        </td>
                                                    </tr>--%>
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

        </div>

    </form>
</body>
</html>
