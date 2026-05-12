<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EstimatePMBudgets.aspx.vb"
    Inherits="Website.EstimatePMBudgets" Culture="auto" meta:resourcekey="Page" UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Budgets</title>
</head>

<script language="javascript" type="text/javascript">

    function SelectAll(chk) {
        var total = 0;
        $("#rdgBudgetDetails").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
            var tr = this.parentNode.parentNode;
            if (chk.checked && tr.id) {
                var amount = CDbl($($("#" + tr.id).find("input[id$='txtAmount']")[0]).val());
                total += amount;
            }
        });
        $("#txtBudgetTotal")[0].value = CCur(total);
    }

    function SelectParent(chk) {
        var chkPArent = $("#rdgBudgetDetails").find("input[type='checkbox']")[0];
        var txtTotal = $($("#txtBudgetTotal")[0]);
        var total = CDbl(txtTotal.val());
        var amount = CDbl($($("#" + chk.parentNode.parentNode.id).find("input[id$='txtAmount']")[0]).val());

        var i = 0;
        var isChecked = true;
        $("#rdgBudgetDetails").find("input[type='checkbox']").each(function () {
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
                var btnBudgets = $('#btnBudgets')
                btnBudgets.click();
                break;
            default:
                break;
        }
    }
    window.onload = function () {
        var Tds = document.querySelectorAll('td[colspan="2"]');
        var TdArr = Array.prototype.slice.call(Tds);
        TdArr.forEach(function (el) {
            if (el.innerHTML.trim().toString() === "")
                el.parentNode.style.display = "none";
        });
        var ReadOnly = document.querySelectorAll('[readonly="readonly"]');
        var ReadOnlyArr = Array.prototype.slice.call(ReadOnly);
        ReadOnlyArr.forEach(function (el) {
            el.style.backgroundColor = "RGB(237,237,237)";
        });
    }
</script>
<style>
    .labelWidth {
        width: 160px !important;
    }

    #pnlWarning {
        padding-bottom: 19px;
    }
</style>

<body style="background: White !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server"
            DefaultLoadingPanelID="ldpEstimatePMBudgets"
            meta:resourcekey="PMAjaxManagerResource1">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnBudgets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlGenerate" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgBudgetDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBudgetDetails" />
                        <telerik:AjaxUpdatedControl ControlID="txtBudgetTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpEstimatePMBudgets" runat="server"
            Skin="Default" meta:resourcekey="ldpEstimatePMBudgetsResource1" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
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
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%"
                        HorizontalAlign="NotSet" meta:resourcekey="pnlDetailPaneResource1">
                        <table class="colTable">
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlWarning" runat="server"
                                        Style="width: 100%;" Visible="False">
                                        <div class="Warning">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblWarning" Text="This estimate was already sent to budget!"
                                                runat="server" meta:resourcekey="lblWarningResource1"></asp:Label>
                                        </div>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="PnlBudegetInWorkflow" runat="server"
                                        Style="width: 100%;" Visible="False">
                                        <div class="Warning" style="padding-bottom:24px;">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblBudegetInWorkflow" Text="Budget cannot be generated. There is already an approved budget or a budget in workflow for this project."
                                                runat="server" meta:resourcekey="lblWarningResource1"></asp:Label>
                                        </div>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProject" runat="server" ReadOnly="True"
                                        meta:resourcekey="txtProjectResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBudgetTotal" runat="server" meta:resourcekey="lblBudgetTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBudgetTotal" CssClass="Currency" runat="server"></asp:TextBox>
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
                                    <asp:Label ID="lblDateRevision" runat="server" meta:resourcekey="lblDateRevision" Text="Date / Revision"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td style="width: 182px; padding-right: 8px;">
                                                <asp:TextBox ID="txtRevisionDate" runat="server" ReadOnly="True"
                                                    meta:resourcekey="txtRevisionDateResource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 50px;" align="right">
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
                                        <asp:Button ID="btnBudgets" runat="server"
                                            Text="<%$ Resources:PMWeb, Generate %>"
                                            meta:resourcekey="btnBudgetsResource1" CssClass="Hide" />
                                        <div style="text-align: center;">
                                            <asp:Label ID="lblBudgetUnique" runat="server" CssClass="Validator" Visible="false"
                                                Text="<%$ Resources:CostManagement, ErrorMsg_UniqueBudget %>"></asp:Label>
                                            <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                                Visible="False" Class="Success"></asp:Label>
                                            <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                                                Visible="False" Class="Failure"></asp:Label>
                                        </div>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadAjaxPanel>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgBudgetDetails" runat="server" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        GridLines="None" meta:resourcekey="rdgBudgetDetailsResource1">
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
                                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%" Style="font-size: 11px"
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
                                        <asp:TextBox ID="txtAmount" runat="server" Width="100%" Text='<%# FormatCurrency(CDbl(IIf(Eval("Amount") Is System.DBNull.Value, 0, Eval("Amount")))) %>'
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
                                        Visible='<%# rdgBudgetDetails.EditIndexes.Count = 0 And (Not rdgBudgetDetails.MasterTableView.IsItemInserted) %>'
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
