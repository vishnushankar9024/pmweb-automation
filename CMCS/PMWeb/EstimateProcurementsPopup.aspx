<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" Title="Estimate Items" CodeBehind="EstimateProcurementsPopup.aspx.vb" Inherits="Website.EstimateProcurementsPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>

<script language="javascript" type="text/javascript">

    function pageLoad() {
        CheckParentBox();
    }

    function CheckParentBox() {
        var rdgRights = $("div[id$='rdgEstimateItems']");
        var ParentIsNotChecked = true;
        var i = 0;
        rdgRights.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (!this.checked) {
                    if (this.id.indexOf("chkIsIncluded") > 0)
                        ParentIsNotChecked = false;
                }
            }
            i++;
        });

        if (!ParentIsNotChecked) {
            rdgRights.find("input[type='checkbox']")[0].checked = false;

        } else {
            if (i > 0) {
                rdgRights.find("input[type='checkbox']")[0].checked = true;
            }

        }
    }

    function SelectParent(chk) {
        var rdgRights = $("div[id$='rdgEstimateItems']");
        if (rdgRights.find("input[type='checkbox']")[0] == null) return;
        var chkPArent = rdgRights.find("input[type='checkbox']")[0];

        var i = 0;
        var isChecked = true;
        rdgRights.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (chk.checked) {
                    if (!this.checked) isChecked = false;
                }
            }
            i++;
        });
        var hdnCount = $("[id$=hdnCount]");
        var Value = parseFloat(hdnCount.val());

        if (!chk.checked) {
            chkPArent.checked = false;
            if (Value > 0)
                Value = Value - 1;


        } else {
            chkPArent.checked = isChecked;
            Value = Value + 1;
        }
        hdnCount.val(Value);
        return false;
    }

    function SelectAll(chk) {
        var i = 0;
        var rdg = $("div[id$='rdgEstimateItems']");
        var j = 0;
        var k = 0;
        rdg.find("input[type='checkbox']").each(function () {
            if (i > 0) {
                if (!this.disabled && this.id.indexOf("chkIsIncluded") > 0) {
                    if (!this.checked)
                        j = j + 1;
                    if (this.checked)
                        k = k + 1;
                    this.checked = chk.checked;
                }

            }
            i++;
        });

        var hdnCount = $("[id$=hdnCount]");
        var Value = parseFloat(hdnCount.val());
        if (chk.checked) {
            Value = Value + j;
            var btnCheckAll = $("[id$=btnCheckAll]");
            btnCheckAll.click();
        }
        else {
            if ((Value - k) >= 0)
                Value = Value - k;
            var btnUncheckAll = $("[id$=btnUncheckAll]");
            btnUncheckAll.click();
        }
        hdnCount.val(Value);
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
                <telerik:AjaxSetting AjaxControlID="rdgEstimateItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgEstimateItems" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnUncheckAll">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgEstimateItems" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr class="ToolBar">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
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
                            <td class="labelWidth" style="width:160px !important">
                                <asp:Label ID="lblProcurement" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProcurement" ReadOnly="true" runat="server" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" style="width:160px !important">
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" ReadOnly="true" runat="server" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBidCategory" runat="server" meta:resourcekey="lblBidCategory" Text="Bid Category"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtBidCategory" ReadOnly="true" runat="server" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgEstimateItems" AllowMultiRowSelection="false" runat="server" Width="100%"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="250" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                    Groupable="false" Reorderable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblSelect" runat="server" Text=""></asp:Label>
                                        <asp:CheckBox ID="chkAll" runat="server" TextAlign="Left"
                                            onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Estimate/Initiative" UniqueName="EstimateInitiative" DataField="Type"
                                    GroupByExpression="Type [GridColumn_Type] Group By Type ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType">
                                    <ItemTemplate>
                                        <span><%#Eval("Type").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Record" UniqueName="EstimateInitiativeDescription" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="EstimateInitiativeDescription"
                                    GroupByExpression="EstimateInitiativeDescription [GridColumn_EstimateInitiativeDescription] Group By EstimateInitiativeDescription ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("EstimateInitiativeDescription").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="LineNumber"
                                    GroupByExpression="LineNumber [GridColumn_LineNumber] Group By LineNumber ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("LineNumber").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Item" UniqueName="ItemCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ItemCode"
                                    GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("ItemCode") = String.Empty, "&nbsp;", Eval("ItemCode"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Description") Is System.DBNull.Value, "&nbsp;", Eval("Description"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="170px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ProjectName"
                                    GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("ProjectName") Is System.DBNull.Value, "&nbsp;", Eval("ProjectName"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="170px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Bid Category" UniqueName="BidCategory" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="BidCategory"
                                    GroupByExpression="BidCategory [GridColumn_BidCategory] Group By BidCategory ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("BidCategory") = String.Empty, "&nbsp;", Eval("BidCategory"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Cost Code" UniqueName="CostCode" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CostCode"
                                    GroupByExpression="CostCode [GridColumn_CostCode] Group By CostCode ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("CostCode") = String.Empty, "&nbsp;", Eval("CostCode"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="ExtendedQuantity"
                                    Groupable="false" Reorderable="false" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Quantity">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Eval("ExtendedQuantity"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM"
                                    GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="UOM">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("UOM") = String.Empty, "&nbsp;", Eval("UOM"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost"
                                    Groupable="false" Reorderable="false" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="UnitCost">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost"
                                    Groupable="false" Reorderable="false" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="TotalCost">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("TotalCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>



                                <telerik:GridTemplateColumn HeaderText="Phase" UniqueName="PhaseName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="PhaseName"
                                    GroupByExpression="PhaseName [GridColumn_PhaseName] Group By PhaseName ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("PhaseName") = String.Empty, "&nbsp;", Eval("PhaseName"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>



                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                        Visible='<%# rdgEstimateItems.EditIndexes.Count = 0 And (Not rdgEstimateItems.MasterTableView.IsItemInserted) %>'>
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
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" />
        <asp:Button ID="btnUncheckAll" runat="server" CssClass="Hide" />
        <asp:Button ID="btnCheckAll" runat="server" CssClass="Hide" />
    </form>
</body>
</html>
