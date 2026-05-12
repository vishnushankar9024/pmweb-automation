<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderCalculatedField.aspx.vb" Inherits="Website.QueryBuilderCalculatedField" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .CurrencyFieldsQB {
            width: 100%;
            height: calc(100vh - 129px) !important;
            overflow: auto;
            border: 1px solid #666666;
            box-sizing: border-box;
            margin-bottom: 24px;
        }

        @media screen and (max-width: 853px) {
            .CurrencyFieldsQB {
                height: 271px !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                var calculationSelection = { start: 0, end: 0, length: 0, text: "" };
                var txtCalculation;
                function replaceSelection(replacement) {
                    txtCalculation.focus()
                    txtCalculation.replaceSelection(replacement,"end");
                }

                function pageLoad() {
                    txtCalculation = $($get('<%= txtCalculation.ClientID %>'));
                    txtCalculation.selectRange(txtCalculation.val().length, 0);
                }
                function onNodeClicked(sender, args) {
                    var selectedNode = args.get_node();
                    var fieldName = selectedNode.get_attributes().getAttribute("SqlSelectStatement");
                    replaceSelection(fieldName);
                }

                function FillText(btn) {
                    btn = $(btn);
                    replaceSelection(btn.val());
                }

                function CloseCalculationWindow() {
                    var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
                    radWindow.close();
                }
                function CancelCalculation() {
                    var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
                    radWindow.close();
                }
                function mainToolBarClick(sender, args) {
                    var command = args.get_item().get_commandName();
                    if (command === "Close")
                        CancelCalculation();
                    return false;
                }
            </script>
        </telerik:RadCodeBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" OnClientButtonClicked="mainToolBarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row row-8-4-fit8">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAlias" runat="server" Text="Alias" meta:resourcekey="lblAlias"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtAliasName" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <div class="CurrencyFieldsQB">
                        <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="False" Style="overflow: auto !important; margin: 0 !important"
                            Skin="Default" MultipleSelect="True" Width="100%" OnClientNodeClicked="onNodeClicked">
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                            <CollapseAnimation Duration="100" Type="OutQuint" />
                        </telerik:RadTreeView>
                    </div>
                </div>
                <div class="col-8">
                    <div class="CalculationFields">
                        <asp:TextBox ID="txtCalculation" runat="server" TextMode="MultiLine" CssClass="calculationBox" Width="100%"></asp:TextBox>
                    </div>
                    <div class="OperationFields">
                        <table style="text-align: center;" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Button ID="btnLeftBracket" runat="server" Text="(" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnRightBracket" runat="server" Text=")" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnPlus" runat="server" Text="+" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnMinus" runat="server" Text="-" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnMultiply" runat="server" Text="*" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnDivide" runat="server" Text="/" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
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
