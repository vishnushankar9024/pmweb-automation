<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EstimatePMBudgetsRequests.aspx.vb"
    Inherits="Website.EstimatePMBudgetsRequests" Culture="auto" meta:resourcekey="Page" UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Budget Requests</title>
</head>

<script language="javascript" type="text/javascript">

    function SelectAll(chk) {
        var total = 0;
        $("#rdgBudgetsRequestDetails").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
            var tr = this.parentNode.parentNode;
            if (chk.checked && tr.id) {
                var amount = CDbl($($("#" + tr.id).find("input[id$='txtAmount']")[0]).val());
                total += amount;
            }
        });
        $("#txtBudgetsRequestTotal")[0].value = CCur(total);
    }

    function SelectParent(chk) {
        var chkPArent = $("#rdgBudgetsRequestDetails").find("input[type='checkbox']")[0];
        var txtTotal = $($("#txtBudgetsRequestTotal")[0]);
        var total = CDbl(txtTotal.val());
        var amount = CDbl($($("#" + chk.parentNode.parentNode.id).find("input[id$='txtAmount']")[0]).val());

        var i = 0;
        var isChecked = true;
        $("#rdgBudgetsRequestDetails").find("input[type='checkbox']").each(function () {
            if (i != 0) {
                if (chk.checked) {
                    if (!this.checked) isChecked = false;
                }
            }
            i++;
        });

        if (!chk.checked) {
            chkPArent.checked = false;
            txtTotal.val(CCur(total - amount));
        } else {
            chkPArent.checked = isChecked;
            txtTotal.val(CCur(total + amount));
        }


        return false;
    }
    function maintoolbarClick(sender, args) {
        switch (args.get_item().get_commandName()) {
            case 'Generate':
                var btnBudgets = $('#btnBudgetsRequest')
                btnBudgets.click();
                break;
            default:
                break;
        }
    }
    window.onload = function () {
        var ReadOnly = document.querySelectorAll('[readonly="readonly"]');
        var ReadOnlyArr = Array.prototype.slice.call(ReadOnly);
        ReadOnlyArr.forEach(function (el) {
            el.style.backgroundColor = "RGB(237,237,237)";
        });
    }
</script>
<style>
        .labelWidth {
            width:160px !important;
        }
   
    </style>

<body style="background: White !important;">
    <form id="form1" runat="server">

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server"
            DefaultLoadingPanelID="ldpEstimatePMBudgetsRequest"
            meta:resourcekey="PMAjaxManagerResource">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnBudgetsRequest">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlGenerate" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgBudgetsRequestDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBudgetsRequestDetails" />
                        <telerik:AjaxUpdatedControl ControlID="txtBudgetsRequestTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="chkCombineCostcodes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBudgetsRequestDetails" />
                        <telerik:AjaxUpdatedControl ControlID="txtBudgetsRequestTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpEstimatePMBudgetsRequest" runat="server"
            Skin="Default" meta:resourcekey="ldpEstimatePMBudgetsRequestResource" />
        <%--  <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" 
                    HorizontalAlign="NotSet" meta:resourcekey="pnlDetailPaneResource1">
                    <asp:Panel ID="pnlWarning" runat="server" 
                        style="width:100%; background-color:lightyellow;" Visible="False" 
                        >
                        <asp:Image ID="imgWarning" runat="server" 
                            ImageUrl="~/Images/Global/Warning.png" meta:resourcekey="imgWarningResource1" />
                        <asp:Label ID="lblWarning" Text="This estimate was already sent to BudgetsRequest!" 
                            runat="server" meta:resourcekey="lblWarningResource1"></asp:Label>
                    </asp:Panel>--%>
        <%--    <asp:Panel ID="PnlBudegetInWorkflow" runat="server" 
                        style="width:100%; background-color:lightyellow;" Visible="False" 
                        >
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl="~/Images/Global/Warning.png" meta:resourcekey="imgWarningResource1" />
                        <asp:Label ID="lblBudegetInWorkflow" Text="BudgetsRequest cannot be generated. There is already an approved BudgetsRequest or a BudgetsRequest in workflow for this project." 
                            runat="server" meta:resourcekey="lblWarningResource1"></asp:Label>
                    </asp:Panel>--%>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="Generate" EnableImageSprite="true" CssClass="ToolbarGenerate" CommandName="Generate">
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
                                <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" ReadOnly="True" Width="100%"
                                    meta:resourcekey="txtProjectResource1"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBudgetsRequestTotal" runat="server" meta:resourcekey="lblBudgetsRequestTotal"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtBudgetsRequestTotal" CssClass="Currency" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblEstimateDescription" runat="server" meta:resourcekey="lblEstimateDescription"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtEstimateDescription" runat="server"
                                    ReadOnly="True" meta:resourcekey="txtEstimateDescriptionResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCombineCostcodes" runat="server" meta:resourcekey="lblCombineCostcodes" Text="Combine Cost Codes">  </asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox AutoPostBack="true" runat="server" ID="chkCombineCostcodes" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDateRevision" runat="server" meta:resourcekey="lblDateRevision" Text="Date / Revision"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <table class="TableNoSpacingNoBorder">
                                    <tr>
                                        <td style="width: 182px; padding-right: 8px;">
                                            <asp:TextBox ID="txtRevisionDate" runat="server" ReadOnly="True"
                                                meta:resourcekey="txtRevisionDateResource1"></asp:TextBox>
                                        </td>
                                        <td style="width: 50px" align="right">
                                            <asp:TextBox ID="txtRevisionNumber" CssClass="Right" runat="server"
                                                ReadOnly="True" meta:resourcekey="txtRevisionNumberResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Panel ID="pnlGenerate" runat="server"
                                    Style="float: right; margin-top: 20px; text-align: center; width: 200px;" meta:resourcekey="pnlGenerateResource1">
                                    <asp:Button ID="btnBudgetsRequest" runat="server"
                                        Text="<%$ Resources:PMWeb, Generate %>"
                                        meta:resourcekey="btnBudgetsRequestResource" CssClass="Hide" />
                                    <div style="text-align: center;">
                                        <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                            Visible="False" Class="Success"></asp:Label>
                                        <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                                            Visible="False" Class="Failure"></asp:Label>
                                    </div>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgBudgetsRequestDetails" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0"
                        GridLines="None" meta:resourcekey="rdgBudgetsRequestDetailsResource1">
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%">
                            <Columns>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblInclude" runat="server" meta:resourcekey="lblInclude"></asp:Label>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" TextAlign="Left"
                                            onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Style="font-size: 11px;width:100% !important;"
                                            NoWrap="true">
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                                            Width="100%" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAmount" runat="server" Text='<%# FormatCurrency(CDbl(IIf(Eval("Amount") Is System.DBNull.Value, 0, Eval("Amount"))), CurrencyId:=Eval("CurrencyId"))%>'
                                            CssClass="Currency" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"
                                            MaxLength="200" meta:resourcekey="txtNotesResource1"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="140px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                        Visible='<%# rdgBudgetsRequestDetails.EditIndexes.Count = 0 And (Not rdgBudgetsRequestDetails.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUndo" runat="server" meta:resourcekey="lblUndoResource1"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="false">
                            <Selecting AllowRowSelect="false" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

