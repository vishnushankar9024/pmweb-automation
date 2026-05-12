<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProcurementContracts.aspx.vb"
    Inherits="Website.ProcurementContracts" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <title>Generate Commitments</title>
</head>


<script language="javascript" type="text/javascript">


    function SelectAll(chk) {
        var i = 0;
        $("#rdgContractDetails").find("input[type='checkbox']").each(function () {
            if (i != 0)
                this.checked = chk.checked;
            i++;
        });
    }

    function SelectParent(chk) {
        var chkParent = $("#rdgContractDetails").find("input[type='checkbox']")[1];

        var i = 0;
        var isChecked = true;
        $("#rdgContractDetails").find("input[type='checkbox']").each(function () {
            if (i != 1 && i != 0) {
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
    function CheckClose(sender, args) {

        switch (args.get_item().get_commandName()) {
            case "Cancel":
                CloseRadWnd();
                break;

            default:

                break;
        }
    }
</script>

<body style="background: White !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpProcurementContracts">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgContractDetails">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContractDetails" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadStyleSheetManager runat="server" EnableStyleSheetCombine="true"></telerik:RadStyleSheetManager>
        <telerik:RadAjaxLoadingPanel ID="ldpProcurementContracts" runat="server" Skin="Default" />



        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="CheckClose" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarGenerate" PostBack="true"
                                CommandName="GenerateCommitment" AccessKey="s" Value="GenerateCommitment">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Cancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet" LoadingPanelID="">
            <div class="PMMainPage PMPopupMainPage documentSinglePage">
                <div class="row">
                    <div class="col-4 col-4-left">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblProcurementTitle" Text="Procurement" meta:resourcekey="lblProcurementTitle"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgram" runat="server" meta:resourcekey="lblProgram"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProgram" runat="server" Enabled="false" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtProject" runat="server" Enabled="false" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProcurement" Text="Procurement" runat="server" meta:resourcekey="lblProcurement"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDescription" runat="server" Enabled="false" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBidCategory" Text="Bid Category" runat="server" meta:resourcekey="lblBidCategory"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBidCategory" runat="server" Enabled="false" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAwardedBidder" Text="Awarded Bidder" runat="server" meta:resourcekey="lblAwardedBidder"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAwardedBidder" runat="server" Enabled="false" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr runat="server" visible="false">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCompany" runat="server" Enabled="false" Width="250px" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevision" runat="server" meta:resourcekey="lblRevision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="width: 47%">
                                                    <asp:TextBox ID="txtRevisionNumber" Enabled="false" CssClass="Right" runat="server" Width="95%"
                                                        ReadOnly="True"></asp:TextBox>
                                                </td>
                                                <td align="center">
                                                    <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDate"></asp:Label>
                                                </td>
                                                <td style="width: 47%; padding-left: 10px;">
                                                    <asp:TextBox ID="txtRevisionDate" Enabled="false" runat="server" ReadOnly="True"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblCommitment" Text="Commitment" meta:resourcekey="lblCommitment"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" runat="server" meta:resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox runat="server" ID="ddlCommitmentType">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <%--    <tr>
                                                            <td>
                                                                <asp:Label ID="lblCommitmentId" runat="server" Text="Commitment ID" Visible = "False" meta:Resourcekey="lblCommitmentId"></asp:Label>
                                                            </td>
                                                            <td style="padding-left: 3px;">
                                                                <asp:TextBox ID="txtCode" runat="server" Visible = "False" Enabled="false" MaxLength="15" Width="120px"></asp:TextBox>&nbsp;&nbsp;
                                                                <asp:CheckBox runat="server" ID="chkautoCreateId" Visible = "False"  meta:Resourcekey="chkautoCreateId" Checked="true" AutoPostBack="true" Text="Auto Create ID" />
                                                             <div> <asp:Label ID="lblCommitmentIdRequired" runat="server" Visible = "False" Text="Required."
                                                                     Class="Validator" meta:resourcekey="lblCommitmentIdRequired"></asp:Label></div>   
                                                            </td>
                                                        </tr>--%>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDecription" runat="server" Text="Description" meta:resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCommitmentDescription" MaxLength="500"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox runat="server" ID="ddlCommitmentCategory">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCopy" meta:resourcekey="lblCopy" runat="server" Text="Copy"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="row">
                                            <div class="col-4">
                                                <asp:CheckBox runat="server" Checked="true" meta:resourcekey="chkCopyClauses" Text="Clauses" ID="chkCopyClauses" />
                                            </div>
                                            <div class="col-4">
                                                <asp:CheckBox runat="server" Checked="true" meta:resourcekey="chkCopyNotes" Text="Notes" ID="chkCopyNotes" />
                                            </div>
                                            <div class="col-4">
                                                <asp:CheckBox runat="server" Checked="true" meta:resourcekey="chkCopyAttachments" Text="Attachments" ID="chkCopyAttachments" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
            </div>
        </telerik:RadAjaxPanel>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <asp:RadioButtonList ID="rdbQuantityAndCosts" Enabled="true" AutoPostBack="true" runat="server" CssClass="RadioCss RadioPadding">
                        <asp:ListItem Text="Use Online Bid Quantities and Costs" meta:resourcekey="rdbOnlineBid" Value="OnlineBid" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Use Procurement Quantities and Costs" meta:resourcekey="rdbProcurement" Value="Procurement"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:Panel ID="pnlGenerate" runat="server" Style="float: right; margin-top: 20px; text-align: center;" meta:resourcekey="pnlGenerateResource1">
                        <div style="text-align: center;">
                            <asp:Label ID="lblCommIDUnique" runat="server" Text="<%$ Resources:CostManagement, WarningMsg_IDUnique %>"
                                Visible="False" Class="Validator"></asp:Label>
                            <asp:Label ID="lblSucceed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Succeed %>"
                                Visible="False" Class="Success"></asp:Label>
                            <asp:Label ID="lblFailed" runat="server" Text="<%$ Resources:PMWeb, WarningMsg_Failed %>"
                                Visible="False" Class="Failure"></asp:Label>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgContractDetails" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" AppendMenus="true"
                        EnableHeaderContextFilterMenu="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" ShowStatusBar="True" CellPadding="0" ShowGroupPanel="True" AllowFilteringByColumn="true"
                        AllowSorting="true" AllowMultiRowSelection="True" GridLines="None" ItemStyle-Height="20px">
                        <PagerStyle Mode="NextPrevAndNumeric" Position="TopAndBottom" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Include" UniqueName="Include" Groupable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblInclude" runat="server" Text="Include" meta:resourcekey="lblInclude"></asp:Label>
                                                </td>
                                                <td style="cursor: default">
                                                    <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" onclick="SelectAll(this);" />
                                                </td>
                                            </tr>
                                        </table>

                                    </HeaderTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                    AutoPostBackOnFilter="true" DataField="ProjectName" SortExpression="ProjectName"
                                    GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("ProjectName") Is System.DBNull.Value, "&nbsp;", Eval("ProjectName"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="170px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Item" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" SortExpression="ItemCode"
                                    AutoPostBackOnFilter="true" DataField="ItemCode" GroupByExpression="ItemCode [GridColumn_ItemCode] Group By ItemCode ASC" UniqueName="ItemCode">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" SortExpression="Description"
                                    AutoPostBackOnFilter="true" DataField="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC" UniqueName="Description">
                                    <ItemTemplate>
                                        <div><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></div>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" AllowFiltering="false" SortExpression="UOM"
                                    AutoPostBackOnFilter="true" DataField="UOM" GroupByExpression="UOM [GridColumn_UOM] Group By UOM ASC" UniqueName="UOM">
                                    <ItemTemplate>
                                        &nbsp;<%#Eval("UOM").ToString%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="false" SortExpression="Quantity"
                                    AutoPostBackOnFilter="true" DataField="Quantity" HeaderText="Quantity" GroupByExpression="Quantity [GridColumn_Quantity] Group By Quantity ASC" UniqueName="Quantity">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblQuantity"></asp:Label>

                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn AllowFiltering="false" SortExpression="UnitCost"
                                    AutoPostBackOnFilter="true" DataField="UnitCost" HeaderText="Unit Cost" Groupable="false" UniqueName="UnitCost">
                                    <ItemTemplate>
                                        <%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label runat="server" ID="lblTotal" Text="<%$Resources:PMWeb, Total %>"></asp:Label>
                                    </FooterTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total Cost" AllowFiltering="false" SortExpression="TotalCost"
                                    AutoPostBackOnFilter="true" GroupByExpression="TotalCost [GridColumn_TotalCost] Group By TotalCost ASC" UniqueName="TotalCost">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblTotalCost"></asp:Label>

                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" CurrentFilterFunction="Contains" DataField="Notes" FilterListOptions="VaryByDataType" SortExpression="Notes"
                                    AutoPostBackOnFilter="true" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" UniqueName="Notes">
                                    <ItemTemplate>
                                        &nbsp;<%#Eval("Notes").ToString%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                                    Visible='<%# rdgContractDetails.EditIndexes.Count = 0 And (Not rdgContractDetails.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>

                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label3" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>


                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        &nbsp;&nbsp;<asp:Label ID="Label4" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:CheckBox runat="server" ID="ckbUseUnits" OnCheckedChanged="useUnitChanged_CheckedChanged" AutoPostBack="true" Checked="true" Text="Use Units" meta:resourcekey="ckbUseUnits" SecurityButtonType="ItemMode_Edit" />
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="False" AllowColumnsReorder="True" ColumnsReorderMethod="Reorder"
                            AllowDragToGroup="True" AllowRowsDragDrop="false">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="True"
                                AllowColumnResize="True" />
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
