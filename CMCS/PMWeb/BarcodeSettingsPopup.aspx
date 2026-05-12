<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="BarcodeSettingsPopup.aspx.vb" Inherits="Website.BarcodeSettingsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server" ID="rdblc1">
        <script type="text/javascript">

            function ClosePopup(fldField, fldFormat) {
                var ctlfieldId = $(window.parent.document).find("input[id$='" + fldField + "']");
                ctlbarcodeId.val($('#ddlFields_Input')[0].value);
                var ctlFormatId = $(window.parent.document).find("input[id$='" + fldFormat + "']");
                ctlFormatId.val($('#ddlFormats_Input')[0].value);
                CloseRadWnd();
            }

        </script>

    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <div>
            <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Height="50px" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheck" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <div class="PMMainPage documentSinglePage JustifyContent" style="margin-bottom: 0px !important;">
                <div class="row">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td style="height:24px !important;width:160px;line-height:24px;">
                                    <asp:Label ID="lblField" runat="server" Text="Barcode Field" ></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlFields" runat="server" Width="100%" meta:Resourcekey="ddlFields"
                                        Skin="Default" AutoPostBack="true">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height:24px !important;width:160px;line-height:24px;">
                                    <asp:Label ID="lblFormat" runat="server" Text="Barcode Format"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlFormats" runat="server" Width="100%" meta:Resourcekey="ddlFormats"
                                        Skin="Default" AutoPostBack="true">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
