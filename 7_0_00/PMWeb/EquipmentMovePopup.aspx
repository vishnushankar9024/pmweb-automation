<%@ Page Language="vb" Title="Equipment Move" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="EquipmentMovePopup.aspx.vb" Inherits="Website.EquipmentMovePopup" %>

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
        @media screen and (max-width: 467px) and (min-width: 418px){
div.PMMainPage {
    padding-right: 8px;
    padding-left: 24px !important;
}
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

                var strText = "";
                var strValue = "";
                strValue = node.get_value();

                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text().replace(/^\s+|\s+$/g, '') + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);

                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }
        </script>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="EquipmentMove" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row ">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEquipmentId" meta:resourcekey="lblEquipmentId" runat="server" Text="Equipment ID"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtEquipmentId" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblName" meta:resourcekey="lblName" runat="server" Text="Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtName" ReadOnly="true" Width="100%" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrentLocation" meta:resourcekey="lblCurrentLocation" runat="server" Text="Current Location"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrentLocation" ReadOnly="true" Width="100%" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMouveOutDate" meta:resourcekey="lblMouveOutDate" runat="server" Text="Move-out date*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDatePicker ID="dtpMoveOutDate" MinDate="01/01/1901"
                                    MaxDate="12/31/2100" runat="server" Skin="Default" Width="100%">
                                    <ClientEvents />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="rfvdtpoutdate" meta:resourcekey="rfvRequired"
                                    runat="server" ControlToValidate="dtpMoveOutDate" CssClass="Validator"
                                    ErrorMessage="Required" Display="Dynamic" ValidationGroup="EquipmentMove">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMoveInDate" meta:resourcekey="lblMoveInDate" runat="server" Text="Move-in date*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadDatePicker ID="dtpMoveInDate" MinDate="01/01/1901"
                                    MaxDate="12/31/2100" runat="server" Skin="Default" Width="100%">
                                    <ClientEvents />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="rfvIndate" meta:resourcekey="rfvRequired"
                                    runat="server" ControlToValidate="dtpMoveInDate" CssClass="Validator"
                                    ErrorMessage="Required" Display="Dynamic" ValidationGroup="EquipmentMove">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNewLocation" meta:resourcekey="lblNewLocation" runat="server" Text="New Location*"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlLocation" AllowCustomText="true" runat="server"
                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Location..."
                                    Width="100%" NoWrap="true" ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" />
                                    </Items>
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)">
                                            <telerik:RadTreeView ID="rdvAssets" Skin="Default" runat="server"
                                                Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvAssetNodeClicking"
                                                OnNodeDataBound="rdvAssets_NodeDataBound" OnNodeExpand="rdvAssets_NodeExpand">
                                                <NodeTemplate>
                                                    <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                                                </NodeTemplate>
                                            </telerik:RadTreeView>
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvLocation" meta:resourcekey="rfvRequired"
                                    runat="server" ControlToValidate="ddlLocation" CssClass="Validator"
                                    ErrorMessage="Required" Display="Dynamic" ValidationGroup="EquipmentMove">
                                </asp:RequiredFieldValidator>
                            </td>

                        </tr>
                        <%--  <tr>
                            <td class="labelWidth"></td>
                            <td style="height: 10px;" colspan="5" align="right" class="controlWidth">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnSave" runat="server" meta:resourcekey="btnSave" Text="Save" ValidationGroup="EquipmentMove" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCancel" meta:resourcekey="btnCancel" runat="server" Text="Cancel"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>--%>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
