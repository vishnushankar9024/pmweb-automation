<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="GenerateCommitmentsFromInitiative.aspx.vb" Inherits="Website.GenerateCommitmentsFromInitiative" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <title>Commitments</title>
</head>

<script language="javascript" type="text/javascript">

    function CalculateTotals(ddlTypes) {
        var tr = ddlTypes.parentNode.parentNode;
        if (tr.id) {
            var chkIsInclude = $("#" + tr.id).find("input[type='checkbox']")[0];
            if (!chkIsInclude.checked) return;
            var amount = CDbl($($("#" + tr.id).find("input[id$='txtTotal']")[0]).val());
            var totalContracts = CDbl($($("#txtContracts")[0]).val());
            var totalPurchaseOrders = CDbl($($("#txtPurchaseOrders")[0]).val());
            var type = ddlTypes.options[ddlTypes.selectedIndex].value;
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
                var ddlTypes = $("#" + tr.id).find("select[id$='ddlTypes']")[0];
                var type = ddlTypes.options[ddlTypes.selectedIndex].value;
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
                    var amount = CDbl($($("#" + tr.id).find("input[id$='txtTotal']")[0]).val());
                    var ddlTypes = $("#" + tr.id).find("select[id$='ddlTypes']")[0];
                    var type = ddlTypes.options[ddlTypes.selectedIndex].value;
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
<style>
    .rgCommandRow .SmallWarning {
        padding-right: 24px;
    }

    .RadAjax {
        width: 100% !important;
        height: 100% !important;
        position: fixed !important;
        zoom: 1 !important;
        color: black !important;
        left: 0 !important;
        top: 0 !important;
    }
</style>

<body style="background: White !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:radajaxmanager id="PMAjaxManager" runat="server" defaultloadingpanelid="ldpEstimateContracts">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="mainToolBar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                        <telerik:AjaxUpdatedControl ControlID="pnlGenerate" LoadingPanelID="ldpEstimateContracts"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                   <telerik:AjaxSetting AjaxControlID="mainToolBar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContractDetails" />
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
        </telerik:radajaxmanager>
        <telerik:radajaxloadingpanel id="ldpEstimateContracts" runat="server" skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:radtoolbar id="mainToolBar" style="width: 100%" runat="server" skin="Default" autopostback="true">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="Generate" EnableImageSprite="true" CssClass="ToolbarGenerate" CommandName="Generate" value="Generate">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:radtoolbar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <telerik:radajaxpanel id="pnlDetailPane" runat="server" width="100%" horizontalalign="NotSet">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProject" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblInitiative" runat="server" meta:resourcekey="lblInitiative"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtInitiative" runat="server" ReadOnly="True"></asp:TextBox>
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
                                                <asp:TextBox ID="txtRevisionDate" Width="170px" runat="server" ReadOnly="True" style="text-align:right;"></asp:TextBox>
                                            </td>
                                            <td style="width: 60px; padding-left: 10px" align="right">
                                                <asp:TextBox ID="txtRevisionNumber" CssClass="Right" runat="server" Width="60px" ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblContracts" runat="server" meta:resourcekey="lblContracts"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtContracts" CssClass="Currency" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPurchaseOrders" runat="server" meta:resourcekey="lblPurchaseOrders"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPurchaseOrders" CssClass="Currency" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBuyoutTotal" runat="server" meta:resourcekey="lblBuyoutTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBuyoutTotal" CssClass="Currency" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                           
                                    <asp:Panel ID="pnlGenerate" runat="server"
                                        Style="float: right; margin-top: 20px; text-align: center; width: 200px;" meta:resourcekey="pnlGenerateResource1">
                                        <div style="text-align: center;">
                                            <asp:Label ID="lblCommIDUnique" runat="server" Text="<%$ Resources:CostManagement, WarningMsg_IDUnique %>"
                                                Visible="False" Class="Validator"></asp:Label>
                                            <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                                Visible="False" Class="Success"></asp:Label>
                                            <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                                                Visible="False" Class="Failure"></asp:Label>
                                        </div>
                                    </asp:Panel>
                               
                    </telerik:radajaxpanel>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:radgrid id="rdgContractDetails" runat="server" setwidth="true" fitparentcontainer="true" clientsettings-scrolling-allowscroll="true"
                        autogeneratecolumns="False" showstatusbar="True" cellpadding="0" width="100%" fitpageheightoffset="24"
                        gridlines="None">
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblInclude" runat="server" Text="Include<br />" meta:resourcekey="lblInclude"></asp:Label>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" TextAlign="Left" onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Width="200px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"  Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select Company..."
                                            NoWrap="True" AllowCustomText="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Width="200px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Generate" UniqueName="Generate">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" onchange="CalculateTotals(this); return false;">
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>'
                                            Width="100%"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="true" HorizontalAlign="Left" />
                                    <HeaderStyle Width="150px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="# of <br/>Lines" UniqueName="NumberOfLines">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtLines" runat="server" Style="text-align: right;" Text='<%# CDbl(IIf(Eval("Lines") Is System.DBNull.Value, 0, Eval("Lines"))).ToString("") %>'
                                            Width="100%" ReadOnly="True"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                    <HeaderStyle Width="100px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTotal" runat="server" Style="text-align: right;" Text='<%# FormatCurrency(CDbl(IIf(Eval("Total") Is System.DBNull.Value, 0, Eval("Total")))) %>'
                                            Width="100%" ReadOnly="True"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                    <HeaderStyle Width="100px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="">
                                    <ItemTemplate>
                                        <div id="imgIsSent" class="EmptyButton" runat="server"><span class="Icon"></span></div>
                                        <asp:HiddenField ID="hdnCommitmentId" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                    CancelImageUrl="Cancel.gif">
                                </EditColumn>
                            </EditFormSettings>
                            <CommandItemTemplate>
                                <table width="100%" style="padding: 0px; border: 0px transparent none; height: 30px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>&nbsp;&nbsp;
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                                Visible='<%# rdgContractDetails.EditIndexes.Count = 0 And (Not rdgContractDetails.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                        </td>
                                        <td align="right">
                                            <div class="SmallWarning">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblWarningExp" runat="server" Font-Bold="true" Text=": Already sent"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="false">
                            <Selecting AllowRowSelect="false" />
                        </ClientSettings>
                    </telerik:radgrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>

