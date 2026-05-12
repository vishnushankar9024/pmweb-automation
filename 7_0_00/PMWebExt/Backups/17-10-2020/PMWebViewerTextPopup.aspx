<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="PageTitle" CodeBehind="PMWebViewerTextPopup.aspx.vb" Inherits="Website.PMWebViewerTextPopup" %>

<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">
            var isBold = false;
            var isItalic = false;
            var fontSize = "11px";

            function changeSize(sender, args) {
                var txt = document.getElementById('<%=txtText2.ClientID%>');
                txt.style.fontSize = sender.get_value();
                fontSize = sender.get_value();
            }

            function toolbarclicked(sender, args) {
                switch (args.get_item().get_commandName()) {
                    case 'Cancel':
                        setTimeout("var oWnd = GetRadWindow();oWnd.close();", 500);
                        break;
                    case 'Save':
                        var label = document.getElementById('txtText2').value;
                        window.parent.AddTextFromPopup(isBold, isItalic, fontSize, label);
                        setTimeout("var oWnd = GetRadWindow();oWnd.close();", 500);
                        break;
                    case 'Bold':
                        isBold = !isBold;
                        var txt = document.getElementById('<%= txtText2.ClientID%>')
                        if (isBold) {
                            txt.style.fontWeight = "bold";
                            args.get_item()._linkElement.className = args.get_item()._linkElement.className + ' rtbItemFocused';

                        }
                        else {
                            txt.style.fontWeight = "";
                            args.get_item()._linkElement.className = args.get_item()._linkElement.className.toString().replace(' rtbItemFocused', '');

                        }

                        args.get_item().blur();

                        break;
                    case 'Italic':
                        var txt = document.getElementById('<%= txtText2.ClientId%>')
                        isItalic = !isItalic;
                        if (isItalic) {
                            txt.style.fontStyle = "italic";
                            args.get_item()._linkElement.className = args.get_item()._linkElement.className + ' rtbItemFocused';
                        }
                        else {
                            txt.style.fontStyle = "";
                            args.get_item()._linkElement.className = args.get_item()._linkElement.className.toString().replace(' rtbItemFocused', '');
                        }
                        args.get_item().blur();
                        break;
                }
            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
        </script>

    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="toolbarclicked" AutoPostBack="true" Width="100%" CssClass="small-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" PostBack="false" CssClass="ToolbarSaveAndExit" Value="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" PostBack="false" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton>
                                            <ItemTemplate>
                                                <telerik:RadComboBox runat="server" Width="150px " OnClientSelectedIndexChanged="changeSize" ID="ddlSize" AutoPostBack="false" style="margin-left:24px;margin-right:21px">
                                                </telerik:RadComboBox>
                                            </ItemTemplate>
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton CommandName="Bold" EnableImageSprite="true" PostBack="false" CssClass="ToolbarBold"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Italic" EnableImageSprite="true" PostBack="false" CssClass="ToolbarItalic"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    <div class="PMMainPage PMPopupMainPage documentSinglePage" style="margin-bottom:0">
        <div class="row" style="min-width:100px !important">
        <div class="col-12" style="padding-right: 24px;padding-left: 24px;">
             <textarea id="txtText2" runat="server"> </textarea>
             <asp:Label ID="lblMsg" runat="server" meta:Resourcekey="lblMsg" style="margin-top: 24px;display: block;color: #666666;"> </asp:Label>
        </div>
       </div>
  </div>













        <div>
            <table>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td>


                        <%--<telerik:RadTextBox ID="txtText" ClientEvents-OnMouseOver="mouse" ClientEvents-OnMouseOut ="mouse" TextMode="MultiLine"  runat="server"></telerik:RadTextBox>--%>
                    </td>
                </tr>

            </table>

        </div>
    </form>
</body>
</html>
