<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EstimateContracts.aspx.vb"
    Inherits="Website.EstimateContracts" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <title>Commitments</title>
</head>
   
<script language="javascript" type="text/javascript">

    function CalculateTotals(ddlGenerates) {
        var tr = ddlGenerates.parentNode.parentNode;
        if (tr.id) {
            var chkIsInclude = $("#" + tr.id).find("input[type='checkbox']")[0];
            if (!chkIsInclude.checked) return;
            var amount = CDbl($($("#" + tr.id).find("input[id$='txtTotal']")[0]).val());
            var totalContracts = CDbl($($("#txtContracts")[0]).val());
            var totalPurchaseOrders = CDbl($($("#txtPurchaseOrders")[0]).val());
            var type = ddlGenerates.options[ddlGenerates.selectedIndex].value;
            if (type == "1") {
                totalContracts += amount;
                totalPurchaseOrders -= amount;
            } else {
                totalPurchaseOrders += amount;
                totalContracts -= amount;
            }
            $($("#txtContracts")[0]).val(CCur(totalContracts));
            $($("#txtPurchaseOrders")[0]).val(CCur(totalPurchaseOrders));
        }

    }

    function SelectAll(chk) {
        var totalContracts = 0;
        var totalPurchaseOrders = 0;
        $("#rdgContractDetails").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
            var tr = this.parentNode.parentNode;
            if (chk.checked && tr.id) {
                var amount = CDbl($($("#" + tr.id).find("input[id$='txtTotal']")[0]).val());
                var ddlGenerates = $("#" + tr.id).find("select[id$='ddlGenerates']")[0];
                var type = ddlGenerates.options[ddlGenerates.selectedIndex].value;
                if (type == "1") {
                    totalContracts += amount;
                } else {
                    totalPurchaseOrders += amount;
                }
            }
        });
        $($("#txtContracts")[0]).val(CCur(totalContracts));
        $($("#txtPurchaseOrders")[0]).val(CCur(totalPurchaseOrders));
        $($("#txtBuyoutTotal")[0]).val(CCur(totalContracts + totalPurchaseOrders));
    }

    function SelectParent(chk) {
        var chkPArent = $("#rdgContractDetails").find("input[type='checkbox']")[0];
        var txtContracts = $($("#txtContracts")[0]);
        var txtPurchaseOrders = $($("#txtPurchaseOrders")[0]);
        var txtBuyoutTotal = $($("#txtBuyoutTotal")[0]);
        var totalContracts = 0;
        var totalPurchaseOrders = 0;

        var i = 0;
        var isChecked = true;
        $("#rdgContractDetails").find("input[type='checkbox']").each(function () {
            if (i != 0) {
                if (chk.checked) {
                    if (!this.checked) isChecked = false;
                }
                var tr = this.parentNode.parentNode;
                if (tr.id) {
                    var amount = CDbl($($("#" + tr.id).find("input[id$='txtTotal']").get(0)).val());
                    var ddlGenerates = $("#" + tr.id).find("select[id$='ddlGenerates']")[0];
                    var type = ddlGenerates.options[ddlGenerates.selectedIndex].value;
                    if (type == "1") {
                        totalContracts = totalContracts + ((this.checked) ? amount : 0);
                    } else {
                        totalPurchaseOrders = totalPurchaseOrders + ((this.checked) ? amount : 0);
                    }
                }
            }
            i++;
        });

        if (!chk.checked) {
            chkPArent.checked = false;
        } else {
            chkPArent.checked = isChecked;
        }

        txtContracts.val(CCur(totalContracts));
        txtPurchaseOrders.val(CCur(totalPurchaseOrders));
        txtBuyoutTotal.val(CCur(totalContracts + totalPurchaseOrders));

        return false;
    }

</script>

<body style="background: White !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpEstimateContracts">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnContracts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="pnlProlog" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgContractDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContractDetails" />
                        <telerik:AjaxUpdatedControl ControlID="txtContracts" />
                        <telerik:AjaxUpdatedControl ControlID="txtPurchaseOrders" />
                        <telerik:AjaxUpdatedControl ControlID="txtBuyoutTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpEstimateContracts" runat="server" Skin="Default" />
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProject" runat="server" Width="99%" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblContracts" runat="server" meta:resourcekey="lblContracts" Text="Contracts"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtContracts" CssClass="Currency" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEstimateDescription" runat="server" meta:resourcekey="lblEstimateDescription" Text="Description"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEstimateDescription" runat="server" Width="99%" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPurchaseOrders" runat="server" meta:resourcekey="lblPurchaseOrders" Text="Purchase Orders"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPurchaseOrders" CssClass="Currency" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDateRevision" runat="server" meta:resourcekey="lblDateRevision" Text="Date / Revision"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtRevisionNumber" CssClass="Right" runat="server" Width="99%" ReadOnly="True"></asp:TextBox>
                                            </td>
                                            <td align="right" style="width: 60px; padding-left: 10px">
                                                <asp:TextBox ID="txtRevisionDate" runat="server" Width="60px" ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBuyoutTotal" runat="server" meta:resourcekey="lblBuyoutTotal" Text="Buy out Total"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBuyoutTotal" CssClass="Currency" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPrologProject" runat="server" meta:resourcekey="lblPrologProject" Text="Prolog Project"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPrologProjects" runat="server" Width="100%" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        Skin="Default" OnClientDropDownOpened="RePosition" meta:resourcekey="ddlPrologProjects">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel ID="pnlProlog" runat="server" Style="float: right;">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td class="labelWidth"></td>
                                                <td  class="controlWidth">
                                                    <asp:Button ID="btnContracts" CssClass="btnGenerator" runat="server" Text="<%$ Resources:PMWeb, Generate %>" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div style="text-align: center;">
                                                        <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                                            Visible="false" Class="Success"></asp:Label>
                                                        <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                                                            Visible="false" Class="Failure"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>

                        </table>
                    </telerik:RadAjaxPanel>
                </div>
            <div class="col-4"></div>
            <div class="col-4"></div>
        </div>
        <div class="row">
            <div class="col-8">
                <table class="colTable">
                    <tr style="width:100%;">
                        <td style="width:100%;">
                            <telerik:RadGrid ID="rdgContractDetails" runat="server" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0" Width="100%"
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
                                                <asp:Label ID="lblInclude" runat="server" Text="Include<br />" meta:resourcekey="lblInclude"></asp:Label>
                                                <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" TextAlign="Left" onclick="SelectAll(this);" />
                                            </HeaderTemplate>
                                            <ItemStyle Wrap="false" Width="56px" HorizontalAlign="Center" />
                                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlCompanies" runat="server" Width="180px">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" Width="180px" HorizontalAlign="Left" />
                                            <HeaderStyle Width="180px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Generate" UniqueName="Generate">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlGenerates" runat="server" Width="100px" onchange="CalculateTotals(this); return false;">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" Width="100px" HorizontalAlign="Left" />
                                            <HeaderStyle Width="100px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                                                    Width="110px"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="true" Width="110px" HorizontalAlign="Left" />
                                            <HeaderStyle Width="110px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Rules" UniqueName="Rules">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlRules" runat="server" Width="160px">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" Width="160px" HorizontalAlign="Left" />
                                            <HeaderStyle Width="160px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="# of <br/>Lines" UniqueName="LineNumber">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLines" runat="server" Style="text-align: right;" Text='<%# ParseDouble(Eval("Lines")) %>'
                                                    Width="30px" ReadOnly="True"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" Width="30px" HorizontalAlign="Right" />
                                            <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTotal" runat="server" Style="text-align: right;" Text='<%# FormatCurrency(ParseDouble(Eval("Total"))) %>'
                                                    Width="55px" ReadOnly="True"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" Width="55px" HorizontalAlign="Right" />
                                            <HeaderStyle Width="55px" HorizontalAlign="Center" />
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
                                        Visible='<%# rdgContractDetails.EditIndexes.Count = 0 And (Not rdgContractDetails.MasterTableView.IsItemInserted) %>'>
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
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMeridianTrademark" runat="server" meta:resourcekey="lblMeridianTrademark" CssClass="SmallItalic"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        </div>
    </form>
</body>
</html>
