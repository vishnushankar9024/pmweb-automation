<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="HelpTextPopup.aspx.vb" Inherits="Website.HelpTextPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .rcbImage {
            width: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr valign="top">
                <td class="ToolbarTd" style="width: 150px !important;">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="small-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" Value="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td class="ToolbarTd">
                    <telerik:RadComboBox ID="ddlLanguage" runat="server" Skin="Default" AutoPostBack="true" Style="font-size: 11px" Width="240px"></telerik:RadComboBox>
                </td>
                <td></td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row">
                <div class="col-12 PopupDocumentTabs Margins" style="margin-top:50px;">
                    <asp:TextBox ID="txtHelpText" runat="server" TextMode="MultiLine" Width="100%" Style="height: calc(100vh - 100px) !important;"></asp:TextBox>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
