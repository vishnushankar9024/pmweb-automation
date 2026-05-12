<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EstimateBudgets.aspx.vb"
    Inherits="Website.EstimateBudgets" Culture="auto" meta:resourcekey="Page" UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
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

</script>

<body style="background: White !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpEstimateBudgets">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnBudgets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlProlog" />
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
        <telerik:RadAjaxLoadingPanel ID="ldpEstimateBudgets" runat="server" Skin="Default" />

        <div class="PMMainPage" style="padding:0">
            <div class="row documentSinglePage">
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet">
                    <div class="col-4 col-4-left" style="padding-left:24px;">
                        <table class="colTable">
                            <tr>
                                <td style="width: 100%;">
                                    <div id="divBudget" style="float: left; width: 100%">
                                        <table class="colTable">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblProject" runat="server" Text="Project" meta:resourcekey="lblProject"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtProject" runat="server" ReadOnly="True"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblBudgetTotal" runat="server" meta:resourcekey="lblBudgetTotal" Text="Budget Total"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtBudgetTotal" CssClass="Currency" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblEstimateDescription" runat="server" meta:resourcekey="lblEstimateDescription" Text="Description"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtEstimateDescription" runat="server" ReadOnly="True"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblDateRevision" runat="server" meta:resourcekey="lblDateRevision" Text="Date / Revision"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <table class="TableNoSpacingNoBorder">
                                                        <tr>
                                                            <td style="width: 182px;padding-right:8px;">
                                                                <asp:TextBox ID="txtRevisionNumber" CssClass="Right" runat="server" Width="100%"
                                                                    ReadOnly="True"></asp:TextBox>
                                                            </td>
                                                            <td style="width:50px;">
                                                                <asp:TextBox ID="txtRevisionDate" runat="server" ReadOnly="True"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblPrologProject" runat="server" meta:resourcekey="lblPrologProject" Text="Prolog Project"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlPrologProjects" runat="server" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                        Skin="Default" OnClientDropDownOpened="RePosition" meta:resourcekey="ddlPrologProjects">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlProlog" runat="server" Style="float: right;">

                                        <asp:Button ID="btnBudgets" CssClass="btnGenerator" runat="server" Text="<%$ Resources:PMWeb, Generate %>" />

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
                    <div class="col-4">
                    </div>
                    <div class="col-4">
                    </div>
                </telerik:RadAjaxPanel>
            </div>
            <div class="row">
                <div class="col-8">
                    <table class="colTable">
                        <tr>
                            <td>
                                <div style="overflow: auto;">
                                    <telerik:RadGrid ID="rdgBudgetDetails" runat="server" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                        AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0"
                                        GridLines="None">
                                        <HeaderContextMenu EnableViewState="false">
                                        </HeaderContextMenu>
                                        <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id" CommandItemDisplay="Top">
                                            <Columns>
                                                <telerik:GridTemplateColumn>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" onclick="SelectParent(this);" />
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblInclude" runat="server" meta:resourcekey="lblInclude"></asp:Label>
                                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" TextAlign="Left" onclick="SelectAll(this);" />
                                                    </HeaderTemplate>
                                                    <ItemStyle Wrap="false" Width="70px" HorizontalAlign="Center" />
                                                    <HeaderStyle Width="70px" HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode">
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="190px" Style="font-size: 11px"
                                                            NoWrap="true">
                                                        </telerik:RadComboBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" Width="190px" HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                                                            Width="170px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="true" Width="170px" HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAmount" runat="server" Width="100px" Text='<%# FormatCurrency(CDbl(IIf(Eval("Amount") Is System.DBNull.Value, 0, Eval("Amount")))) %>'
                                                            CssClass="Currency"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" Width="100px" HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="130px"
                                                            MaxLength="200"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="true" Width="130px" HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                                    CancelImageUrl="Cancel.gif">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <CommandItemTemplate>
                                                <div style="padding: 2px">
                                                    &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                                    Visible='<%# rdgBudgetDetails.EditIndexes.Count = 0 And (Not rdgBudgetDetails.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <ClientSettings EnableRowHoverStyle="false">
                                            <Selecting AllowRowSelect="false" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%;" align="left" valign="top">
                                <asp:Label ID="lblMeridianTrademark" runat="server" meta:resourcekey="lblMeridianTrademark" CssClass="SmallItalic"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4"></div>
            </div>
        </div>
    </form>
</body>
</html>
