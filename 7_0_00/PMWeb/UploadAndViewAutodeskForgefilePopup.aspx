<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="UploadAndViewAutodeskForgefilePopup.aspx.vb" Inherits="Website.UploadAndViewAutodeskForgefilePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server" AsyncPostBackTimeout="1200">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnOk">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlConfirmation" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="pnlView" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnCancel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlConfirmation" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

        <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text=""></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar  NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
                                <div class="PMHeader Margins">
                                    <div class="row documentSinglePage">
                                        <div class="col-4">
                                            <table class="colTable" border="0">
                                                <asp:Panel ID="pnlConfirmation" runat="server">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td style="padding-bottom: 5px">
                                                                <b>
                                                                    <asp:Label ID="lblConfirmTitle" runat="server" Text="Message11" meta:resourcekey="lblConfirmTitle"></asp:Label></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-bottom: 15px">
                                                                <asp:Label ID="lblConfirmMessage" runat="server" Text="Message11" meta:resourcekey="lblConfirmMessage"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <%--       <tr>
                    <td style="text-align:right">
                        <asp:Button ID="btnOk" runat="server" Text="Ok11" meta:resourcekey="btnOk" />&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel11" meta:resourcekey="btnCancel" />
                    </td>
                </tr>--%>
                                                    </table>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlView" runat="server" Visible="false">

                                                    <tr>
                                                        <td style="padding-bottom: 15px">
                                                            <asp:Label ID="lblViewMessage" runat="server" Text="Message11" meta:resourcekey="lblViewMessage"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: center">
                                                            <asp:Button ID="btnView" runat="server" Text="View11" meta:resourcekey="btnView" />
                                                        </td>
                                                    </tr>



                                                </asp:Panel>

                                            </table>
                                        </div>
                                    </div>
                                </div>
    </form>
</body>
</html>
