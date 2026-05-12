<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorksheetCalculation.aspx.vb" Inherits="Website.WorksheetCalculation" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link href="CSS/MainCss.css" rel="stylesheet" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Worksheet Calculation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        /*.Operator
        {
        	font-size:medium !important;
        	font-weight:bold !important;
        	width: 25px !important;
        	background-image:none !important;
            border: 1px solid #C4DBF9;
        }*/
    </style>
</head>
<script type="text/javascript">
    var calculationSelection = { start: 0, end: 0, length: 0, text: "" };
    var txtCalculation;
    function replaceSelection(replacement) {
        //            calculationSelection = txtCalculation.getSelection();
        txtCalculation.focus()
        txtCalculation.replaceSelection(replacement,"end");
    }

    function pageLoad() {
        txtCalculation = $($get('<%= txtCalculation.ClientID %>'));
        txtCalculation.selectRange(txtCalculation.val().length, 0);
    }
    function onNodeClicked(sender, args) {
        var selectedNode = args.get_node();
        var fieldName = selectedNode.get_attributes().getAttribute("UniqueName");
        replaceSelection("[" + fieldName + "]");
    }

    function FillText(btn) {
        btn = $(btn);
        replaceSelection(btn.val());
    }
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
    function SaveCalculationWindow() {
        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
        GetRadWindow().BrowserWindow.WebForm_GetElementById(querySt("txtCalculationid").replace("btnGenerateCalculation", "txtCalculation")).value = txtCalculation.val();
    }

    function CloseCalculationWindow() {
        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
        GetRadWindow().BrowserWindow.WebForm_GetElementById(querySt("txtCalculationid").replace("btnGenerateCalculation", "txtCalculation")).value = txtCalculation.val();
        radWindow.close();
    }

    function CancelCalculation() {
        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
        radWindow.close();
    }

    function IsNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charcode = (evt.which) ? evt.which : evt.keyCode;
        if ((charcode > 32 && (charcode < 40 || charcode > 57)) || charcode == 44 || charcode == 46) { return false; }
        return true;
    }
    function maintoolbarClick(sender, args) {
        var value = args.get_item().get_commandName();

        switch (value) {

            case 'ToggleSplitter':
                var pane = $find('RadSplitter1');
                pane.set_visible(true)
                break;
        }
    }
    function treeToolbarClick(sender, args) {
        if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
            var pane = $find('RadSplitter1');
            pane.set_visible(false);
            return false;
        }
    }
</script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                        Width="220px" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage" style="margin-bottom:0 !important">
            <div class="row row-8-4-fit8">
                <div class="col-4">
                    <div class="CurrencyFields">
                        <telerik:RadTreeView ID="rdvCurrencyFields" Skin="Default" runat="server" Width="100%"
                            MultipleSelect="false" ShowLineImages="false" CssClass="Left" Height="100%"
                            OnNodeDataBound="rdvCurrencyFields_NodeDataBound"
                            OnClientNodeClicked="onNodeClicked">
                        </telerik:RadTreeView>
                    </div>
                </div>
                <div class="col-8">
                    <div class="CalculationFields">
                        <asp:TextBox ID="txtCalculation" runat="server" TextMode="MultiLine" onkeypress="return IsNumber(event)"
                            Rows="20" Width="100%" CssClass="calculationBox" Wrap="true"></asp:TextBox>

                        <%--         <td align="right">
                    <asp:Button ID="btnClose" runat="server" Text="Close"
                        OnClientClick="CloseCalculationWindow(); return false;"  /> &nbsp; &nbsp; &nbsp;
                     <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                        OnClientClick="CancelCalculation(); return false;"  />
                </td>--%>
                    </div>
                    <div class="OperationFields">
                        <table style="text-align: center;" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Button ID="btnLeftParenth" runat="server" Text="("
                                        OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnRightParenth" runat="server" Text=")"
                                        OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnPlus" runat="server" Text="+"
                                        OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnMinus" runat="server" Text="-"
                                        OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnMultiply" runat="server" Text="*"
                                        OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnDivide" runat="server" Text="/"
                                        OnClientClick="FillText(this); return false;" CssClass="btncalculatorwidth" />
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
