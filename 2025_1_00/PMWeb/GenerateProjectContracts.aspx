<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GenerateProjectContracts.aspx.vb"
    Inherits="Website.GenerateProjectContracts" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <title>GENERATE CONTRACTS</title>
</head>
     
<script language="javascript" type="text/javascript">

    function Recalculate(sender, args) {
        var total = 0;

        $(".rgDataDiv .rgRow,.rgDataDiv .rgAltRow").each(function () {
            var isChecked = $(this).find("input[type='checkbox']")[0].checked;
            if (isChecked) {
                //var selectedType = $find($(this).find("[id$='_ddlTypes']")[0].id).get_value();
                var amount = CDbl($(this).find("[id$='_txtTotal']")[0].value);
                //if (selectedType == '1' || selectedType == '2')
                //    totalSubContracts += amount;
                //else
                //    totalContracts += amount;
                total += amount;
            }
        });
        $($("#txtContracts")[0]).val(CCur(total));
        $($("#txtBuyoutTotal")[0]).val(CCur(total));

    }

    function SelectAll(chk) {
        $("#rdgProjectContracts").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked && !this.disabled;
        });

        Recalculate();
    }

    function SelectParent(chk) {
        var chkPArent = $("#rdgProjectContracts").find("input[type='checkbox']")[0];
        var txtContracts = $($("#txtContracts")[0]);
        var txtPurchaseOrders = $($("#txtPurchaseOrders")[0]);
        var txtBuyoutTotal = $($("#txtBuyoutTotal")[0]);
        var totalContracts = 0;
        var totalPurchaseOrders = 0;

        var i = 0;
        var isChecked = true;
        $("#rdgProjectContracts").find("input[type='checkbox']").each(function () {
            if (i != 0) {
                if (chk.checked) {
                    if (!this.checked) isChecked = false;
                }
            }
            i++;
        });

        if (!chk.checked) {
            chkPArent.checked = false;
        } else {
            chkPArent.checked = isChecked;
        }
        Recalculate()

        return false;
    }
  
    window.onload = function () {
       var ReadOnly = document.querySelectorAll('[readonly="readonly"]');
       var ReadOnlyArr = Array.prototype.slice.call(ReadOnly);
       ReadOnlyArr.forEach(function (el) {
       el.style.backgroundColor = "RGB(237,237,237)";
         });
    }

    function Close() {

        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
        radWindow.close();
    }
           
</script>

<style>
    .labelWidth {
        width: 160px !important;
    }

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
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpProjectContracts">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="mainToolBar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
                        <telerik:AjaxUpdatedControl ControlID="pnlGenerate" LoadingPanelID="ldpProjectContracts"/>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="mainToolBar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgProjectContracts" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgProjectContracts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgProjectContracts" />
                        <telerik:AjaxUpdatedControl ControlID="txtContracts" />                       
                        <telerik:AjaxUpdatedControl ControlID="txtBuyoutTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpProjectContracts" runat="server" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton ValidationGroup="Generate" EnableImageSprite="true" CssClass="ToolbarGenerate" CommandName="Generate" value="Generate">
                            </telerik:RadToolBarButton>
                             
                            <telerik:RadToolBarButton  EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" ></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtProject" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEstimateDescription" runat="server" meta:resourcekey="lblEstimateDescription" ></asp:Label>
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
                                            <td style="width: 182px; padding-right: 8px">
                                                <asp:TextBox ID="txtRevisionDate" runat="server" ReadOnly="True"></asp:TextBox>
                                            </td>
                                            <td style="width: 50px" align="right">
                                                <asp:TextBox ID="txtRevisionNumber" CssClass="Right" runat="server"
                                                    ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblContracts" runat="server" meta:resourcekey="lblContracts" ></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtContracts" CssClass="Currency" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBuyoutTotal" runat="server" meta:resourcekey="lblBuyoutTotal" ></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBuyoutTotal" CssClass="Currency" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                                    <asp:Panel ID="pnlGenerate" runat="server"
                                        Style="float: right; margin-top: 20px; text-align: center; width: 170px;" meta:resourcekey="pnlGenerateResource1">
                                        <div style="text-align: center;">
                                            <asp:Label ID="lblContIDUnique" runat="server" Text="<%$ Resources:CostManagement, WarningMsg_IDUnique %>"
                                                Visible="False" Class="Validator"></asp:Label>
                                            <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                                Visible="False" Class="Success"></asp:Label>
                                            <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                                                Visible="False" Class="Failure"></asp:Label>
                                        </div>
                                    </asp:Panel>
                    </telerik:RadAjaxPanel>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgProjectContracts" runat="server" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0" Width="100%"
                        GridLines="None">
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False" onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblInclude" runat="server" Text="Include<br />" meta:resourcekey="lblInclude"></asp:Label>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False" TextAlign="Left" onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Width="100px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Company" UniqueName="Company">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%" DropDownWidth="300px"
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Company..."
                                            NoWrap="True" AllowCustomText="true" meta:Resourcekey="ddlCompanies"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Width="210px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Generate" UniqueName="Generate">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Width="100%" onclientselectedindexchanged="Recalculate">
                                        </telerik:RadComboBox>

                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle Width="200px" HorizontalAlign="Center" />
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
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTotal" runat="server" Style="text-align: right;" Text='<%# FormatCurrency(CDbl(IIf(Eval("Total") Is System.DBNull.Value, 0, Eval("Total")))) %>'
                                            Width="100%" ReadOnly="True"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                                    <HeaderStyle Width="55px" HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ALREADY SENT"  UniqueName="AlreadySent">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsSent" runat="server"></asp:Label>
                                       <asp:HiddenField ID="hdnContractId" runat="server" />
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
                                                Visible='<%# rdgProjectContracts.EditIndexes.Count = 0 And (Not rdgProjectContracts.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings EnableRowHoverStyle="false">
                            <Selecting AllowRowSelect="false" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
         <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Skin="Default">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
