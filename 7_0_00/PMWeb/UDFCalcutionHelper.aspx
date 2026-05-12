<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UDFCalcutionHelper.aspx.vb" Inherits="Website.UDFCalcutionHelper" Title="Calculation Helper" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<style>
    .btncalculatorwidth {
        width: 50px !important;
        height: 39px !important;
    }
</style>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                var txtCalculation;
                function replaceSelection(replacement) {
                    txtCalculation.focus()
                    txtCalculation.replaceSelection(replacement, "end");
                }
                function onNodeClicked(sender, args) {
                    debugger;
                    var selectedNode = args.get_node();
                    var fieldName = selectedNode.get_value();
                    if (fieldName.indexOf("_") != -1) { replaceSelection("[" + fieldName + "]"); }
                }
                function OnNodeExpanded(sender, args) {
                    replaceSelection('');
                }
                function pageLoad() {
                    txtCalculation = $($get('<%= txtCalculation.ClientID %>'));
                    txtCalculation.selectRange(txtCalculation.val().length, 0);
                    var qs = getQueryStrings();
                    var SenderId = qs["SenderId"];
                    SenderId = SenderId.replace("imgCalculation", "txtCalculation");
                    txtCalculation.focus()
                    txtCalculation.val(radWindow.BrowserWindow.document.getElementById(SenderId).value)
                }

                function FillText(spn) {
                    spn = $(spn);
                    if (spn.attr('CalcValue')) {
                        replaceSelection(spn.attr('CalcValue'));
                    } else {
                        replaceSelection(spn[0].value);

                    }
                }

                function CloseCalculationWindow() {
                    var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
                    radWindow.close();
                }
                function CancelCalculation() {
                    var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
                    radWindow.close();
                }


                function SaveClick(action) {
                    var qs = getQueryStrings();
                    var SenderId = qs["SenderId"];
                    SenderId = SenderId.replace("imgCalculation", "txtCalculation");
                    var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
                    radWindow.BrowserWindow.document.getElementById(SenderId).value = txtCalculation.val();

                    var checkBoxId = SenderId.replace("txtCalculation", "chbVisible");
                    if (radWindow.BrowserWindow.document.getElementById(checkBoxId)) { radWindow.BrowserWindow.document.getElementById(checkBoxId).checked = true; }

                    if (action == 'close') self.CloseRadWnd();
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

                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row row-8-4-fit8">
                <div class="col-4">
                    <div class="CurrencyFields" id="tdTreeFields">
                        <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="False"
                            Skin="Default" MultipleSelect="True" Width="100%" Height="100%" OnClientNodeClicked="onNodeClicked" OnClientNodeExpanded="OnNodeExpanded">
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                            <CollapseAnimation Duration="100" Type="OutQuint" />
                        </telerik:RadTreeView>
                    </div>
                </div>
                <div class="col-8">
                    <div class="CalculationFields" id="tdMiddle">
                        <asp:TextBox ID="txtCalculation" runat="server" TextMode="MultiLine" Font-Size="12px" Width="100%" Style="height: calc(100vh - 100px) !important;"></asp:TextBox>
                    </div>
                    <div class="OperationFields" id="tdRight">
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
                            <tr>
                                <td>
                                    <asp:Button ID="btnExp" runat="server" Text="^" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSqrt" runat="server" Text="sqrt" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnNot" runat="server" Text="!" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnEqual" runat="server" Text="==" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnNotEqual" runat="server" Text="!=" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnOr" runat="server" Text="||" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnAnd" runat="server" Text="&&" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnGreater" runat="server" Text=">" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnLess" runat="server" Text="<" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnGreaterEqual" runat="server" Text="&gt;=" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnLessEqual" runat="server" Text="&lt;=" OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>


                <asp:PlaceHolder ID="plcFields" runat="server"></asp:PlaceHolder>
            </div>
        </div>

    </form>
</body>
</html>
