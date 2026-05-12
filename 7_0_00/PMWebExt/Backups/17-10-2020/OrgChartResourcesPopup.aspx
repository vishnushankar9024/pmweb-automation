<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="OrgChartResourcesPopup.aspx.vb" Inherits="Website.OrgChartResourcesPopup" %>

<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<script language="javascript" type="text/javascript">

    function ValidateCombo(source, args) {
        var combo = $find(source.controltovalidate);
        var comboValue = combo.get_value();
        var combotext = combo.get_text();

        if (comboValue == '0') {
            args.IsValid = true;
            return args.IsValid = true;
        }

        if (comboValue != '0' && comboValue != '') {
            args.IsValid = true;
        } else {

            if (combotext == '' && combotext == null) {
                args.IsValid = false;
            }

            else {

                var node = combo.findItemByText(combotext);

                if (node) {
                    //var value = node.get_value();
                    if (node.get_value().length > 0) {
                        args.IsValid = true;
                    } else {
                        args.IsValid = false;
                    }

                }
                else {

                    args.IsValid = false;
                }
            }
        }
        //args.IsValid = true;
    }

</script>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlType">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlType" />
                        <telerik:AjaxUpdatedControl ControlID="ddlResources" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="ddlResources">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlResources" />
                        <telerik:AjaxUpdatedControl ControlID="txtTitle" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Delete" EnableImageSprite="true" Visible="False" CssClass="ToolbarDelete"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage R24SidePadding">
            <div class="row documentSinglePage">
                <div class="col-4" style="width: 400px !important;">
                    <table class="colTable" style="width: 400px !important">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblType" runat="server" Text="Type1" meta:resourcekey="lblType"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" AutoPostBack="true" AllowCustomText="true"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" ID="lblResource" Text="Resource1" meta:resourcekey="lblResource"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlResources" runat="server" Filter="Contains" Width="100%" AutoPostBack="true"
                                    MarkFirstMatch="true" CloseDropDownOnBlur="true" EmptyMessage="Select Resource..." meta:resourcekey="ddlResources"
                                    NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" AllowCustomText="true" EnableItemCaching="False"
                                    EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px" Height="200px">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvResources" runat="server" ControlToValidate="ddlResources"
                                    CssClass="Validator" InitialValue="" ErrorMessage="Required." meta:resourceKey="rfvResources"
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:CustomValidator meta:Resourcekey="csvResources" ID="csvResources" runat="server" ControlToValidate="ddlResources"
                                    ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                    CssClass="Validator" ErrorMessage="Resource required">
                                </asp:CustomValidator>

                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblTitle" runat="server" Text="Title1" meta:resourcekey="lblTitle"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCategory" runat="server" Text="Category1" meta:resourcekey="lblCategory"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCategory" runat="server" AllowCustomText="True" Width="100%"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPercent" runat="server" Text="Percent" meta:resourcekey="lblPercent"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPercentage" CssClass="NoDecimalPercent" MaxNumber="100" MinNumber="0" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
