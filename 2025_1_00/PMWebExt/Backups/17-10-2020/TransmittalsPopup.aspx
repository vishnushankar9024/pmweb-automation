<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="TransmittalsPopup.aspx.vb" Inherits="Website.TransmittalsPopup" %>

<!DOCTYPE html>
<%@ Register Src="Transmittals.ascx" TagName="Transmittals" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transmittals</title>
    <telerik:RadCodeBlock runat="server">
    <script>
        function GoToTransmittalPage1(sender, eventArgs) {
            GetRadWnd().BrowserWindow.location = eventArgs.getDataKeyValue("Url");
            CloseRadWnd();
            return false;
        }
    </script>
        </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarDone" CommandName="Close"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage" style="padding-top: 50px;">
            <div class="row">
                <div class="col-12">
                    <uc1:Transmittals ID="Transmittals" runat="server" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
