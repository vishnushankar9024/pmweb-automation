<%@ Page Language="vb" Title="Add Actual Costs" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="RequisitionActualCostsPopup.aspx.vb" Inherits="Website.RequisitionActualCostsPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

</head>

<script language="javascript" type="text/javascript">

    function SelectAll(chk) {
        var total = 0;
        $("#rdgActualCosts").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
        });
    }

    function SelectParent(chk) {
        var chkParent = $("#rdgActualCosts").find("input[type='checkbox']")[0];

        var i = 0;
        var isChecked = true;
        $("#rdgActualCosts").find("input[type='checkbox']").each(function () {
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
                <telerik:AjaxSetting AjaxControlID="rdgActualCosts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgActualCosts" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
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
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" Text="" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>

                            <td class="labelWidth">
                                <asp:Label ID="lblInvoiceNumber" runat="server" meta:resourcekey="lblInvoiceNumber" Text="Invoice #"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtInvoiceNumber" runat="server" ReadOnly="true" Width="100%" style="text-align:right"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblContract" runat="server" meta:resourcekey="lblContract" Text="Contract"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtContract" runat="server" Text="" Width="100%" ReadOnly="true"></asp:TextBox>
                                <span style="display: none">
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
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgActualCosts" AllowMultiRowSelection="false" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" ShowFooter="true" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="250" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="CostLedgerDetailId,RequisitionDetailId" ClientDataKeyNames="CostLedgerDetailId,RequisitionDetailId" CommandItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" Width="100%">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblSelect" runat="server" Text="Select" meta:resourcekey="lblSelect"></asp:Label><br />
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False" TextAlign="Left"
                                            onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Req. Code" UniqueName="ReqCode"
                                    GroupByExpression="ReqCode [GridColumn_ReqCode] Group By ReqCode ASC" SortExpression="ReqCode"
                                    DataField="ReqCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("ReqCode") = String.Empty, "&nbsp;", Container.DataItem("ReqCode"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date"
                                    GroupByExpression="CreateDate [GridColumn_Date] Group By CreateDate ASC" SortExpression="CreateDate"
                                    DataField="CreateDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("CreateDate"))%></span>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Document Type" UniqueName="DocumentType"
                                    GroupByExpression="DocumentType [GridColumn_DocumentType] Group By DocumentType ASC" SortExpression="DocumentType"
                                    DataField="DocumentType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("DocumentType") = String.Empty, "&nbsp;", Container.DataItem("DocumentType"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Document" UniqueName="Document"
                                    GroupByExpression="Document [GridColumn_Document] Group By Document ASC" SortExpression="Document"
                                    DataField="Document" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#Eval("Document").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="130px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Company Resource" UniqueName="CompanyResource"
                                    GroupByExpression="CompanyResource [GridColumn_CompanyResource] Group By CompanyResource ASC" SortExpression="CompanyResource"
                                    DataField="CompanyResource" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#Eval("CompanyResource").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="130px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description ASC" SortExpression="Description"
                                    DataField="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#Eval("Description").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="130px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM"
                                    Groupable="false" Reorderable="false" SortExpression="UOM" DataField="UOM"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("UOM") = String.Empty, "&nbsp;", Eval("UOM"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="60px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity"
                                    Groupable="false" Reorderable="false" SortExpression="Quantity" DataField="Quantity"
                                    CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#ParseDouble(Eval("Quantity"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UnitCost" UniqueName="UnitCost"
                                    Groupable="false" Reorderable="false" SortExpression="UnitCost" DataField="UnitCost"
                                    CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="TotalAmount" UniqueName="TotalAmount"
                                    Groupable="false" Reorderable="false" DataField="TotalAmount" Aggregate="Sum" FooterAggregateFormatString="{0:N}" SortExpression="TotalAmount"
                                    CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("TotalAmount"), CurrencyId:=Eval("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn Aggregate="SUM" DataField="TotalAmount" Visible="False" />
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                            Visible='<%# rdgActualCosts.EditIndexes.Count = 0 And (Not rdgActualCosts.MasterTableView.IsItemInserted) %>'>
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
    </form>
</body>
</html>
