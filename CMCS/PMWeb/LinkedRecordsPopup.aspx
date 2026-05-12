<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="LinkedRecordsPopup.aspx.vb" Inherits="Website.LinkedRecordsPopup" %>


<%@ Register Src="LinkedRecordDetails.ascx" TagName="LinkedRecordDetails" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Linked Records</title>
    <script>
        function GoToDocument(sender, eventArgs) {
            GetRadWnd().BrowserWindow.location = eventArgs.getDataKeyValue("Url");
            CloseRadWnd();
            return false;
        }
    </script>
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
        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <uc1:linkedrecorddetails id="LinkedRecordDetails" runat="server" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
