<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LogOutPopup.aspx.vb" Inherits="Website.LogOutPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="CSS/Toolbar.css" rel="stylesheet" />
    <style>
        .RadToolBar_Horizontal .rtbItem:first-child {
            margin-left:16px !important;
            margin-right:16px !important;
        }
        .RadToolBar .rtbIcon {
    border: 0;
    padding: 2px;
    background-image: url(Images/24Enabled.png);

}
.RadToolBar .rtbItemHovered .rtbIcon {
    border: 0;
    background-image: url(Images/24Hovered.png) !important;
}
                .RadToolBar .rtbIcon ::selection {
    border: 0;
    padding: 2px;
    background-image: url(Images/24Enabled.png);
}
       tr.ToolBar, table.ToolBar, div.ToolBar {
    z-index: 1999 !important;
    top: 0px !important;
}
.ToolBar {
    position: fixed !important;
    z-index: 999 !important;
    width: 100% !important;
    left: 0;
    top: 0 !important;
    table-layout: fixed;
    width: 100%;
}
        .ToolbarTd {
    width: 24px;
    vertical-align: middle;
}
        .PMMainPage > .row .col-4 {
    position: relative;
    min-height: 1px;
    width: 400px;
}
  
.PMPopupMainPage.documentSinglePage, .PMPopupMainPage > .documentSinglePage {
    margin-bottom: 0 !important;
}
.PMMainPage {
    padding-left: 24px;
    padding-right: 24px;
    box-sizing: border-box;
}

.documentSinglePage {
    margin-top: 50px;
    
}
.PMMainPage > .row {
    table-layout: fixed;
    box-sizing: border-box;
    display: flex !important;
    align-items: flex-start;
    overflow: hidden;
    flex-wrap: wrap;
    padding-top: 24px;
    
}

.PMMainPage > div.row {
    justify-content: space-between !important;
}


    </style>
    
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" Height="50px">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" Height="50px"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Delete" Height="50px"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                                <asp:Label runat="server" ID="lblMsg" Text='When you logged in to PMWeb you chose the"Remember Me"
                                     option which created an authentication cookie on this device
    <br />Do you wish to save the cookie on this device or delete?' style="font-family: sans-serif; margin: 0;font-size: 12px;"></asp:Label>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
