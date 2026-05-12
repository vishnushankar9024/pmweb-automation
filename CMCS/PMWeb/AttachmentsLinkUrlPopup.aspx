<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AttachmentsLinkUrlPopup.aspx.vb" Inherits="Website.AttachmentsLinkUrlPopup"
    meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
         <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton Value="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage TitleToolbarTop">
            <div class="row">
                <div class="col-12">
                    <table>
                        <tr>
                            <td style="width: 160px; color: #666666 !important;">
                                <asp:Label ID="lblUrl" runat="server" meta:resourcekey="lblUrl" Text="URL">
                                </asp:Label>
                            </td>
                            <td style="width: 440px">
                                <asp:TextBox runat="server" ID="txtUrl" Text="http://" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvProject" runat="server" ControlToValidate="txtUrl"
                                    CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>" ValidationGroup="Save"
                                    Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
