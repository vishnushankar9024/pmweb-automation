<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="GenerateWorkOrderPopup.aspx.vb" Inherits="Website.GenerateWorkOrderPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Generate Work Order</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script src="JS/Asset/Components.js" type="text/javascript"></script>
    <style>
        .PMMainPage > .row{
            min-width: 396px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="170px">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td style="padding-top: 5px; padding-left: 24px">
                                <asp:Label ID="lblCreateWorkOrder" runat="server" meta:resourcekey="lblCreateWorkOrder" Text="If you continue, a Work Order will be created linked to this "></asp:Label>
                                <asp:Label ID="lblAssetType" runat="server"></asp:Label>
                                <asp:Label ID="lblRecord" runat="server" meta:resourcekey="lblRecord" Text=" record."></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 5px; padding-left: 24px">
                                <asp:Label ID="lblLinkComponent" runat="server" meta:resourcekey="lblLinkComponent" Text="Link these Components to the Work Order:"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 24px; padding-top: 5px">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="rdbSelectedComponents" Text="Selected Components" CssClass="RadioCss"
                                                meta:resourcekey="rdbSelectedComponents" runat="server" GroupName="components" Checked="true" />
                                            <br />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="rdbAllComponents" Text="All Components" CssClass="RadioCss"
                                                meta:resourcekey="rdbAllComponents" runat="server" GroupName="components" />
                                            <br />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="rdbNoComponents" Text="No Components" CssClass="RadioCss"
                                                meta:resourcekey="rdbNoComponents" runat="server" GroupName="components" />
                                            <br />
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
