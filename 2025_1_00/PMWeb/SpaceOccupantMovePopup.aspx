<%@ Page Language="vb" AutoEventWireup="false" Title="Occupant Move" meta:resourcekey="Page" CodeBehind="SpaceOccupantMovePopup.aspx.vb" Inherits="Website.SpaceOccupantMovePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        Body {
            background-color: White !important;
            background-image: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <script type="text/javascript">
            function rdvAssetNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlLocation]")[0].id);
                var node = args.get_node();

                if (node.get_value().indexOf("S") < 0) {
                    node.set_selected(false);

                    return;
                }

                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);

                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }


        </script>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                        Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" ValidationGroup="EquipmentMove"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
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
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrentLocation" runat="server" Text="Space" meta:resourcekey="lblCurrentLocation"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrentLocation" ReadOnly="true" Width="100%" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMouveOutDate" runat="server" Text="Move-out date*" meta:resourcekey="lblMouveOutDate"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDatePicker ID="dtpMoveOutDate" MinDate="01/01/1901" Width="100%"
                                    MaxDate="12/31/2100" runat="server" Skin="Default">
                                    <ClientEvents />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="rfvdtpoutdate"
                                    runat="server" ControlToValidate="dtpMoveOutDate" CssClass="Validator" meta:resourcekey="rfvdtpoutdate"
                                    ErrorMessage="Enter the Move-out date" Display="Dynamic" ValidationGroup="EquipmentMove">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMoveInDate" runat="server" Text="Move-in date*" meta:resourcekey="lblMoveInDate"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDatePicker ID="dtpMoveInDate" MinDate="01/01/1901" Width="100%"
                                    MaxDate="12/31/2100" runat="server" Skin="Default">
                                    <ClientEvents />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="rfvIndate"
                                    runat="server" ControlToValidate="dtpMoveInDate" CssClass="Validator" meta:resourcekey="rfvIndate"
                                    ErrorMessage="Enter the Move-in date" Display="Dynamic" ValidationGroup="EquipmentMove">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNewSpace" runat="server" Text="New Space*" meta:resourcekey="lblNewSpace"></asp:Label></td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlLocation" AllowCustomText="false" runat="server"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Location..."
                                    Width="100%" NoWrap="true" ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" />
                                    </Items>
                                    <ItemTemplate>
                                        <telerik:RadTreeView ID="rdvAssets" Skin="Default" runat="server"
                                            Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvAssetNodeClicking"
                                            OnNodeDataBound="rdvAssets_NodeDataBound" OnNodeExpand="rdvAssets_NodeExpand">
                                        </telerik:RadTreeView>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
