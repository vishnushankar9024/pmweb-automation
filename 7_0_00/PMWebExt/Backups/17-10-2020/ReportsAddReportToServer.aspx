<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportsAddReportToServer.aspx.vb" Inherits="Website.ReportsAddReportToServer" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function ClientNodeClicked(sender, eventArgs) {
                var node = eventArgs.get_node();
                var nodeType = node.get_attributes().getAttribute("ItemType");
                if (nodeType == 'Folder') {
                    document.getElementById('txtReportPath').value = node.get_value();
                } else {
                    if (nodeType == 'DataSource') { document.getElementById('txtReportDatasource').value = node.get_value(); }
                }

            }

            function click_handler(sender, args) {
                if (args.get_item().get_commandName() != null) {
                    if (args.get_item().get_commandName() == 'Cancel') {
                        return close();
                    }
                }
            }

        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <%--<asp:Label ID="lblAddServerReport" runat="server" meta:resourcekey="lblAddServerReport" Text="Add Server Report"></asp:Label>--%>
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" PostBack="false" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblServerObjects" runat="server" meta:resourcekey="lblServerObjects" Text="Server Objects"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td>
                                    <telerik:RadTreeView ID="treeFolders" runat="server" EnableDragAndDrop="false" Height="450px" OnClientNodeClicked="ClientNodeClicked"
                                        Skin="Default" MultipleSelect="false" Width="100%" CausesValidation="false">
                                        <ExpandAnimation Duration="100"></ExpandAnimation>
                                        <CollapseAnimation Duration="100" Type="OutQuint" />
                                    </telerik:RadTreeView>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblReportProperties" runat="server" meta:resourcekey="lblReportProperties" Text="Properties"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReportPath" runat="server" meta:resourcekey="lblReportPath" Text="Path"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtReportPath" runat="server" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvReportPath" runat="server" ControlToValidate="txtReportPath"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvReportPath" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReportDatasource" runat="server" meta:resourcekey="lblReportDatasource" Text="Datasource"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtReportDatasource" runat="server" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvReportDatasource" runat="server" ControlToValidate="txtReportDatasource"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvReportDatasource" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReportDefinition" runat="server" meta:resourcekey="lblReportDefinition" Text="Definition"></asp:Label>
                                </td>
                                <td class="controWidth">
                                    <asp:FileUpload ID="fupReportDefinition" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%" align="center" colspan="2">
                                    <table style="width:100%">
                                        <tr>
                                            <td style="width:50%;">
                                                <asp:Button ID="btnSave" runat="server" CssClass="NormalButton" Text="Save" />
                                            </td>
                                            <td style="width:50%;">
                                                <asp:Button ID="btnClose" runat="server" CssClass="NormalButton" OnClientClick="javascript:self.close();" Text="Close" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
