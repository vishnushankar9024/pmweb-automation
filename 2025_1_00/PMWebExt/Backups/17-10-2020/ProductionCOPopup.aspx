<%@ Page Language="vb" Title="Add Change Orders" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ProductionCOPopup.aspx.vb" Inherits="Website.ProductionCOPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>

<script language="javascript" type="text/javascript">

    function SelectAll(chk) {
        $("#rdgCommitmentCOs").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
        });
    }

    function SelectParent(chk) {
        var chkParent = $("#rdgCommitmentCOs").find("input[type='checkbox']")[0];

        var i = 0;
        var isChecked = true;
        $("#rdgCommitmentCOs").find("input[type='checkbox']").each(function () {
            if (i != 0) {
                if (chk.checked) {
                    if (!this.checked) isChecked = false;
                }
            }
            i++;
        });

        if (!chk.checked) {
            chkParent.checked = false;
        } else {
            chkParent.checked = isChecked;
        }


        return false;
    }

</script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgCommitmentCOs">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCommitmentCOs" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
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
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" Text="" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>  
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCommitment" runat="server" meta:resourcekey="lblCommitment" Text="Contract"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCommitment" runat="server" Text="" Width="100%" ReadOnly="true"></asp:TextBox>
                                <span style="display: none;">
                                    <asp:Label ID="lblPeriod" runat="server" meta:resourcekey="lblPeriod" Text="Cost Period"></asp:Label>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" runat="server" Text="" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblInvoiceNumber" runat="server" meta:resourcekey="lblInvoiceNumber" Text="Production #"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtInvoiceNumber" runat="server" ReadOnly="true" Width="100%" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" runat="server" ReadOnly="true" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDate" Visible="false" runat="server" meta:resourcekey="lblDate" Text="Invoice Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDate" Visible="false" runat="server" ReadOnly="true" Width="100%" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                        <legend>
                            <asp:Label runat="server" ID="lblOptions" Text="Options" meta:resourcekey="lblOptions" />
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td style="color:#666666 !important;">
                                    <asp:CheckBox runat="server" ID="chkRevised" Checked="true" Text="Use Revised Units" meta:resourcekey="chkRevised" />
                                </td>
                            </tr>
                            <tr>
                                <td style="color:#666666 !important;">
                                    <asp:CheckBox runat="server" ID="chkAppend" Text="Append Change Orders as single lines" meta:resourcekey="chkAppend" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgCommitmentCOs" AllowMultiRowSelection="false" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="25">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblSelect" runat="server" Text=""></asp:Label>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False" TextAlign="Left"
                                            onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="CO #" UniqueName="CONumber"
                                    GroupByExpression="CONumber [GridColumn_CONumber] Group By CONumber ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("CONumber").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="CE #" UniqueName="CENumber"
                                    GroupByExpression="CENumber [GridColumn_CENumber] Group By CENumber ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("CENumber").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="180px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("UOM") = String.Empty, "&nbsp;", Eval("UOM"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="60px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%# IIf(CDbl(ParseDouble(Eval("Quantity"), 1)) = CInt(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1), 5).TrimEnd("0"))%>
                                        </span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency"
                                    GroupByExpression="Currency [GridColumn_Currency] Group By Currency ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Currency") = String.Empty, "&nbsp;", Eval("Currency"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="180px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UnitCost" UniqueName="UnitCost"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("Amount"), CurrencyId:=Eval("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Period" UniqueName="Period"
                                    GroupByExpression="Period [GridColumn_Period] Group By Period ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Period") = String.Empty, "&nbsp;", Eval("Period"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Commitment Line" UniqueName="ContractLine"
                                    GroupByExpression="ContractLine [GridColumn_ContractLine] Group By ContractLine ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Eval("ContractLine") = String.Empty, "&nbsp;", Eval("ContractLine"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                            Visible='<%# rdgCommitmentCOs.EditIndexes.Count = 0 And (Not rdgCommitmentCOs.MasterTableView.IsItemInserted) %>'>
                            <span class="Icon"></span>
                            <asp:Label ID="lblUndo" runat="server"></asp:Label>
                        </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <ClientSettings EnableRowHoverStyle="False" AllowDragToGroup="True" AllowRowsDragDrop="False">
                            <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
        <%-- <asp:LinkButton ID="lbtSave" runat="server" Text="<%$ Resources:PMWeb, Save %>"></asp:LinkButton>&nbsp;&nbsp;|&nbsp;&nbsp;
                            <asp:LinkButton ID="lbtClose" runat="server" Text="<%$ Resources:PMWeb, Cancel %>"></asp:LinkButton>&nbsp;&nbsp;--%>
    </form>
</body>
</html>

