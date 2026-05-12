<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page1" CodeBehind="NDAPopUp.aspx.vb" Inherits="Website.NDAPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server">
        <script language="javascript" type="text/javascript">

            var editorObj;
            function RedirectPage() {

                var oWindow = null
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;

                oWindow.BrowserWindow.location.href = 'home.aspx';
            }

            function ReloadPage() {

                var oWindow = null
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;

                oWindow.BrowserWindow.location.reload();
            }


            function OnClientLoad(editor) {
                editorObj = editor;
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
            }

        </script>
        <style type="text/css">
            .ToolbarDelete.ToolbarDecline .rtbIcon {
                background-position: -312px 0px !important;
            }
        </style>
    </telerik:RadCodeBlock>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="Accept" CommandName="Accept" Text="Accept11" meta:resourcekey="RadToolBarButton_AcceptNDA"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarDelete ToolbarDecline" Value="Decline" CommandName="Decline" Text="Decline11" meta:resourcekey="RadToolBarButton_DeclineNDA"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" meta:resourcekey="RadToolBarButton_Cancel" Text="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage R1Col">
            <div class="row">
                <div class="col-12">
                      <asp:Label runat="server" ID="lblNDAText"></asp:Label>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
