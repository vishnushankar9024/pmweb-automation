<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OffsetInformationPopUp.aspx.vb" Inherits="Website.OffsetInformationPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">

        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }


        function SetValues() {
            var txtLateralOffsetId = querySt("txtId");
            var ddlLateralOffsetUOMId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_ddlLateralOffsetUOMs';
            var txtVerticalOffsetId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_txtVerticalOffset';
            var ddlVerticalOffsetUOMId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_ddlVerticalOffsetUOMs';
            var txtRadialOffsetId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_txtRadialOffset';

            var txtLateralOffset = window.parent.document.getElementById(txtLateralOffsetId);
            var ddlLateralOffsetUOM = window.parent.document.getElementById(ddlLateralOffsetUOMId);
            var txtVerticalOffset = window.parent.document.getElementById(txtVerticalOffsetId);
            var ddlVerticalOffsetUOM = window.parent.document.getElementById(ddlVerticalOffsetUOMId);
            var txtRadialOffset = window.parent.document.getElementById(txtRadialOffsetId);

            if (txtLateralOffset != null) {

                document.getElementById('txtLateral').value = FPrec(CDbl(txtLateralOffset.value));
                document.getElementById('txtVertical').value = FPrec(CDbl(txtVerticalOffset.value));
                document.getElementById('txtRadial').value = FPrec(CDbl(txtRadialOffset.value));

            }


        }
        function FillValuesInGrid(lateralUOMId, VerticalUOMId,lateralUOM, VerticalUOM) {
            var txtLateralOffsetId = querySt("txtId");
            var ddlLateralOffsetUOMId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_ddlLateralOffsetUOMs';
            var txtVerticalOffsetId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_txtVerticalOffset';
            var ddlVerticalOffsetUOMId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_ddlVerticalOffsetUOMs';
            var txtRadialOffsetId = txtLateralOffsetId.substring(txtLateralOffsetId.lastIndexOf('_'), txtLateralOffsetId.lenght - 1) + '_txtRadialOffset';

            var txtLateralOffset = window.parent.document.getElementById(txtLateralOffsetId);
            var ddlLateralOffsetUOM = window.parent.document.getElementById(ddlLateralOffsetUOMId);
            var txtVerticalOffset = window.parent.document.getElementById(txtVerticalOffsetId);
            var ddlVerticalOffsetUOM = window.parent.document.getElementById(ddlVerticalOffsetUOMId);
            var txtRadialOffset = window.parent.document.getElementById(txtRadialOffsetId);
            if (txtLateralOffset != null) {
                txtLateralOffset.value = FPrec(CDbl(document.getElementById('txtLateral').value));
                txtVerticalOffset.value = FPrec(CDbl(document.getElementById('txtVertical').value));
                txtRadialOffset.value = FPrec(CDbl(document.getElementById('txtRadial').value));
                ddlVerticalOffsetUOM.control.set_text(VerticalUOM);
                ddlLateralOffsetUOM.control.set_text(lateralUOM);
                ddlVerticalOffsetUOM.control.set_value(VerticalUOMId);
                ddlLateralOffsetUOM.control.set_value( lateralUOMId);
               
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">



        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" Height="32px" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                    <Items>
                                         <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>


                    <div class="PMMainPage documentSinglePage">
                        <div class="row">
                            <div class="col-6">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblVertical" meta:resourcekey="lblVertical" runat="server" Text="Vertical11"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox runat="server" ID="txtVertical" CssClass="Double"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblVerticalUOM" meta:resourcekey="lblUOM" runat="server" Text="UOM11"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlVerticalUOM" Width="100%" Filter="Contains" Height="300px" AllowCustomText="true"
                                                            runat="server" Skin="Default">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td  style="width: 30%;height:200px;text-align:center;">
                                            <img alt="Vertical offset" src="Images/Asset/OffsetLinear2.jpg" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-6">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLateral" meta:resourcekey="lblLateral" runat="server" Text="Lateral11"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox runat="server" ID="txtLateral" CssClass="Double"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblLateralUOM" meta:resourcekey="lblUOM" runat="server" Text="UOM11"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlLateralUOM" Width="100%" Filter="Contains" Height="300px" AllowCustomText="true"
                                                            runat="server" Skin="Default">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td  style="width: 30%;height:200px;text-align:center;">
                                            <img alt="Lateral offset" src="Images/Asset/OffsetLinear1.jpg" />
                                        </td>
                                    </tr>
                                </table>
                            </div>                       
                        </div>
                        <div class="row">
                              <div class="col-6">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblRadial" meta:resourcekey="lblRadial" runat="server" Text="Radial11"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <asp:TextBox runat="server" Width="99%" ID="txtRadial" CssClass="Double"></asp:TextBox><br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 40%;height:200px;text-align:center;">
                                            <img alt="Radial" src="Images/Asset/Offset_Radial.jpg" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
    </form>
</body>
</html>
