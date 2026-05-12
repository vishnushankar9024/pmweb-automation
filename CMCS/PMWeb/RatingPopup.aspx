<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="RatingPopup.aspx.vb" Inherits="Website.RatingPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" style="margin-right:-8px !important;"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4" style="width: 400px !important;">
                    <table class="colTable">
                        <tr>
                            <td>
                                <telerik:RadRating ID="rdrating1" runat="server" ItemCount="5"
                                    Value="3" SelectionMode="Continuous" Height="10px" Skin="Default" Precision="half" Orientation="Horizontal" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top:12px;">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblComment" meta:Resourcekey="lblComment" runat="server" Text="Comments"></asp:Label>
                                    </legend>
                                    <table style="width: 100%">
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtComment" Height="280px" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
