<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="BarCodePopup.aspx.vb" Inherits="Website.BarCodePopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server" ID="rdblc1">
        <script type="text/javascript">

            function ClosePopup(fldBarcode, fldFormat) {
                var ctlbarcodeId = $(window.parent.document).find("input[id$='" + fldBarcode + "']");
                ctlbarcodeId.val($("input[id$='txtNumber']").val());
                var ctlFormatId = $(window.parent.document).find("input[id$='" + fldFormat + "']");
                ctlFormatId.val($('#ddlFormats_Input')[0].value);
                CloseRadWnd();
            }

        </script>

    </telerik:RadCodeBlock>
    <style>
        .PMMainPage {
            margin-top: 50px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadajaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="pnlConfig">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rbcBarcode" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>



        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" Value="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMMainPage">
            <div class="row">
                <div class="col-4 col-4-left">
                                <asp:Panel ID="pnlConfig" runat="server">
                                    <table class="colTable">
                                        <tr>
                                            <td style="width: 160px !important;height:24px;line-height:24px">
                                                <asp:Label ID="lblNumber" runat="server" Text="Number1" meta:resourcekey="lblNumber"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtNumber" runat="server" AutoPostBack="true"></asp:TextBox>
                                                <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 160px !important;height:24px;line-height:24px">
                                                <asp:Label ID="lblFormat" runat="server" Text="Format1" meta:resourcekey="lblFormat"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlFormats" AllowCustomText="true" runat="server" Width="100%"
                                                    Skin="Default" Style="font-size: 11px" AutoPostBack="true">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="htnFormat" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <div style="width: 100%; text-align: center; padding-top: 24px">
                                    <telerik:RadBarcode ID="rbcBarcode" CssClass="rbBarcode" runat="server"></telerik:RadBarcode>
                                </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
