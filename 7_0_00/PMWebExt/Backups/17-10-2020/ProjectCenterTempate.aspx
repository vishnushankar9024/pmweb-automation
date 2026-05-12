<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ProjectCenterTempate.aspx.vb" Inherits="Website.ProjectCenterTempate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">

            <script type="text/javascript">
                function ColseAndReferesh() {
                    CloseRadWnd();
                    $(window.parent.document).find("[id$=btnRefereshAfterCopy]").click();

                }
                function ValidateCombo(source, args) {
                    args.IsValid = false;
                    var combo = $find(source.controltovalidate);
                    if (combo != null) {
                        var text = combo.get_text();
                        if (text.length < 1) {
                            args.IsValid = false;
                        }
                        else {
                            var value = combo.get_value();
                            if (value >= 0 && value != '') {
                                args.IsValid = true;
                            }
                            else {
                                args.IsValid = false;
                            }
                        }
                    }
                    else
                        args.IsValid = true;
                }

                function Validateddl(source, args) {

                    args.IsValid = false;
                    var combo = $find(source.controltovalidate);
                    if (combo != null) {
                        var text = combo.get_text();
                        if (text.length < 1) {
                            args.IsValid = false;
                        }
                        else {
                            var value = combo.get_value();
                            if (value != '0' && value != '') {
                                args.IsValid = true;
                            }
                            else {
                                args.IsValid = false;
                            }
                        }
                    }
                    else
                        args.IsValid = true;
                }
                function ValidateCostPeriodddl(source, args) {

                    args.IsValid = false;
                    var combo = $find(source.controltovalidate);
                    if (combo != null) {
                        var text = combo.get_text();
                        if (text.length < 1) {
                            args.IsValid = false;
                        }
                        else {
                            var value = combo.get_value();
                            if (value != '-1' && value != '') {
                                args.IsValid = true;
                            }
                            else {
                                args.IsValid = false;
                            }
                        }
                    }
                    else
                        args.IsValid = true;
                }

            </script>
        </telerik:RadCodeBlock>
        <style>
            @media screen and (max-width: 467px) and (min-width: 418px) {
                div.PMMainPage {
                    padding-right: 24px;
                    padding-left: 24px;
                }
            }
        </style>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="tblproj">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tblproj" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="Add" EnableImageSprite="true" CssClass="ToolbarCheck"
                                            Value="Add" CausesValidation="true" ValidationGroup="Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel"
                                            CommandName="Cancel" Value="Cancel" CausesValidation="False" AccessKey="s">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>



        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable" border="0" runat="server" id="tblproj">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label runat="server" meta:resourcekey="lblProject" ID="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlProjects" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" AutoPostBack="true"
                                    Width="100%" NoWrap="true" CausesValidation="False"
                                    EnableLoadOnDemand="true" ShowMoreResultsBox="True" CheckForDirt="True"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfvProjects" runat="server" ControlToValidate="ddlProjects"
                                    CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>"
                                    Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProjects"
                                    ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                    CssClass="Validator" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredProject%>">
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>


    </form>
</body>
</html>
